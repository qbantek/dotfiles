local prompts = {
  -- Code related prompts
  Explain = "Please explain how the following code works.",
  Review = "Please review the following code and provide suggestions for improvement.",
  Tests = "Please explain how the selected code works, then generate unit tests for it.",
  Refactor = "Please refactor the following code to improve its clarity and readability.",
  FixCode = "Please fix the following code to make it work as intended.",
  FixError = "Please explain the error in the following text and provide a solution.",
  BetterNamings = "Please provide better names for the following variables and functions.",
  Documentation = "Please provide documentation for the following code.",
  SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
  SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}

local user = vim.env.USER or "User"

local function create_mapping(normal, insert, detail)
  return {
    normal = normal,
    insert = insert,
    details = detail,
  }
end

return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  dependencies = {
    { "zbirenbaum/copilot.lua" },
    { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    { "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
  },
  opts = {
    debug = false,
    question_header = "  " .. user .. " ",
    answer_header = "  Copilot ",
    error_header = "  Error ",
    prompts = prompts,
    auto_follow_cursor = false, -- Don't follow the cursor after getting response
    show_help = false, -- Show help in virtual text, set to true if that's 1st time using Copilot Chat
    mappings = {
      -- Use tab for completion
      complete = create_mapping("<Tab>", "<Tab>", "Use @<Tab> or /<Tab> for options."),
      -- Close the chat
      close = create_mapping("q", "<C-c>"),
      -- Reset the chat buffer
      reset = create_mapping("<C-x>", "<C-x>"),
      -- Submit the prompt to Copilot
      submit_prompt = create_mapping("<CR>", "<C-CR>"),
      -- Accept the diff
      accept_diff = create_mapping("<C-y>", "<C-y>"),
      -- Yank the diff in the response to register
      yank_diff = create_mapping("gmy", nil),
      -- Show the diff
      show_diff = create_mapping("gmd", nil),
      -- Show the prompt
      show_system_prompt = create_mapping("gmp", nil),
      -- Show the user selection
      show_user_selection = create_mapping("gms", nil),
    },
  },
  config = function(_, opts)
    local chat = require("CopilotChat")
    local select = require("CopilotChat.select")

    -- Use unnamed register for the selection
    opts.selection = select.unnamed

    local commit_prompt = "Write a commit message for the change."
      .. " Make sure the title has maximum 50 characters and message is"
      .. " wrapped at 72 characters. Wrap the whole message in code"
      .. " block with language gitcommit."

    -- Override the git prompt message
    opts.prompts.Commit = {
      prompt = commit_prompt,
      selection = select.gitdiff,
    }
    opts.prompts.CommitStaged = {
      prompt = commit_prompt,
      selection = function(source)
        return select.gitdiff(source, true)
      end,
    }

    chat.setup(opts)

    -- Setup the CMP integration
    require("CopilotChat.integrations.cmp").setup()

    vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
      chat.ask(args.args, { selection = select.visual })
    end, { nargs = "*", range = true })

    -- Inline chat with Copilot
    vim.api.nvim_create_user_command("CopilotChatInline", function(args)
      chat.ask(args.args, {
        selection = select.visual,
        window = {
          layout = "float",
          relative = "cursor",
          width = 1,
          height = 0.4,
          row = 1,
        },
      })
    end, { nargs = "*", range = true })

    -- Restore CopilotChatBuffer
    vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
      chat.ask(args.args, { selection = select.buffer })
    end, { nargs = "*", range = true })

    -- Custom buffer for CopilotChat
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "copilot-*",
      callback = function()
        vim.opt_local.relativenumber = true
        vim.opt_local.number = true

        -- Get current filetype and set it to markdown if the current filetype is copilot-chat
        local ft = vim.bo.filetype
        if ft == "copilot-chat" then
          vim.bo.filetype = "markdown"
        end
      end,
    })

    -- Add which-key mappings
    local wk = require("which-key")
    wk.register({
      g = {
        m = {
          name = "+Copilot Chat",
          d = "Show diff",
          p = "System prompt",
          s = "Show selection",
          y = "Yank diff",
        },
      },
    })
    wk.register({
      ["<leader>"] = {
        a = {
          name = "+Copilot Chat",
          h = "Help actions",
          p = "Prompt actions",
          e = "Explains code",
          t = "Generate tests",
          r = "Review code",
          R = "Refactor code",
          n = "Better namings",
          v = "Open in vertical split",
          x = "Inline chat",
          i = "Ask input",
          m = "Generate commit message",
          M = "Generate commit message for staged changes",
          q = "Quick chat",
          d = "Debug info",
          f = "Fix Diagnostic",
          l = "Clear buffer and chat history",
        },
      },
    })
  end,
  event = "VeryLazy",
  keys = {
    -- Show help actions with telescope
    {
      "<leader>ah",
      function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.telescope").pick(actions.help_actions())
      end,
      desc = "Diagnostic actions",
      mode = { "n", "v" },
    },

    -- Show prompts actions with telescope
    {
      "<leader>ap",
      function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
      end,
      desc = "Prompt actions",
      mode = { "n", "v" },
    },
    {
      "<leader>ap",
      ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
      mode = "x",
      desc = "Prompt actions (on selection)",
    },

    -- Code related commands
    { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Explain code" },
    { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Generate tests" },
    { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Review code" },
    { "<leader>aR", "<cmd>CopilotChatRefactor<cr>", desc = "Refactor code" },
    { "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "Better Naming" },

    -- Chat with Copilot in visual mode
    {
      "<leader>av",
      ":CopilotChatVisual",
      mode = "x",
      desc = "Open in vertical split",
    },
    {
      "<leader>ax",
      ":CopilotChatInline<cr>",
      mode = "x",
      desc = "Inline chat",
    },
    -- Custom input for CopilotChat
    {
      "<leader>ai",
      function()
        local input = vim.fn.input("Ask Copilot: ")
        if input ~= "" then
          vim.cmd("CopilotChat " .. input)
        end
      end,
      desc = "Ask input",
    },
    -- Generate commit message based on the git diff
    {
      "<leader>am",
      "<cmd>CopilotChatCommit<cr>",
      desc = "Generate commit message for all changes",
    },
    {
      "<leader>aM",
      "<cmd>CopilotChatCommitStaged<cr>",
      desc = "Generate commit message for staged changes",
    },
    -- Quick chat with Copilot
    {
      "<leader>aq",
      function()
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          vim.cmd("CopilotChatBuffer " .. input)
        end
      end,
      desc = "Quick chat with your buffer",
    },
    -- Debug
    { "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>", desc = "Debug Info" },
    -- Fix the issue with diagnostic
    { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "Fix Diagnostic" },
    -- Clear buffer and chat history
    { "<leader>al", "<cmd>CopilotChatReset<cr>", desc = "Clear buffer and chat history" },
    -- Toggle Copilot Chat Vsplit
    { "<leader>av", "<cmd>CopilotChatToggle<cr>", desc = "Toggle" },
  },
}
