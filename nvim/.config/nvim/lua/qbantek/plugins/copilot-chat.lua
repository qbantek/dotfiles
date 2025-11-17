-- Define user
local user = vim.env.USER or "User"

-- Function to create mappings
local function create_mapping(normal, insert, detail)
  return {
    normal = normal,
    insert = insert,
    details = detail,
  }
end

-- Define prompts
local prompts = {
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
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}

-- Main plugin configuration
return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "main",
  dependencies = {
    { "zbirenbaum/copilot.lua" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },
  },
  opts = {
    debug = false,

    model = "gpt-5-mini",

    question_header = "  " .. user .. " ",
    answer_header = "  Copilot ",
    error_header = "  Error ",

    prompts = prompts,
    auto_follow_cursor = true,
    show_help = false,
    chat_autocomplete = true,
    mappings = {
      complete = create_mapping("<Tab>", "<Tab>", "Use @<Tab> or /<Tab> for options."),
      close = create_mapping("q", "<C-c>"),
      reset = create_mapping("<C-x>", "<C-x>"),
      submit_prompt = create_mapping("<CR>", "<C-CR>"),
      accept_diff = create_mapping("<C-y>", "<C-y>"),
      yank_diff = create_mapping("gmy", nil),
      show_diff = create_mapping("gmd", nil),
      show_context = create_mapping("gmc", nil),
    },
  },
  config = function(_, opts)
    -- Setup Copilot-Chat with the provided options
    local ok, copilot_chat = pcall(require, "CopilotChat")
    if not ok then
      vim.notify("Failed to load CopilotChat", vim.log.levels.ERROR)
      return
    end

    local ok_select, select = pcall(require, "CopilotChat.select")
    if not ok_select then
      vim.notify("Failed to load CopilotChat.select", vim.log.levels.ERROR)
      return
    end

    opts.selection = select.unnamed
    opts.prompts.Commit = {
      prompt = "Write a commit message for the change."
        .. " Make sure the title has maximum 50 characters and message is"
        .. " wrapped at 72 characters. Wrap the whole message in code"
        .. " block with language gitcommit.",
      selection = select.gitdiff,
    }
    opts.prompts.CommitStaged = {
      prompt = prompts.CommitMessage,
      selection = function(source)
        return select.gitdiff(source, true)
      end,
    }
    copilot_chat.setup(opts)

    -- Define user commands
    local function define_user_commands()
      vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
        copilot_chat.ask(args.args, { selection = require("CopilotChat.select").visual })
      end, { nargs = "*", range = true })

      vim.api.nvim_create_user_command("CopilotChatInline", function(args)
        copilot_chat.ask(args.args, {
          selection = require("CopilotChat.select").visual,
          window = {
            layout = "float",
            relative = "cursor",
            width = 1,
            height = 0.4,
            row = 1,
          },
        })
      end, { nargs = "*", range = true })

      vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
        copilot_chat.ask(args.args, { selection = require("CopilotChat.select").buffer })
      end, { nargs = "*", range = true })
    end

    -- Define autocommands
    local function define_autocommands()
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-*",
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true

          local ft = vim.bo.filetype
          if ft == "copilot-chat" then
            vim.bo.filetype = "markdown"
          end
        end,
      })
    end

    -- Define key mappings
    local function define_key_mappings()
      local wk = require("which-key")
      wk.add({
        { "gm", group = "+Copilot Chat" },
        { "gmd", desc = "Show diff" },
        { "gmp", desc = "System prompt" },
        { "gms", desc = "Show selection" },
        { "gmy", desc = "Yank diff" },
        { "<leader>a", group = "Copilot Chat" },
        { "<leader>aM", desc = "Generate commit message for staged changes" },
        { "<leader>aR", desc = "Refactor code" },
        { "<leader>ad", desc = "Debug info" },
        { "<leader>ae", desc = "Explains code" },
        { "<leader>af", desc = "Fix Diagnostic" },
        { "<leader>ah", desc = "Help actions" },
        { "<leader>ai", desc = "Ask input" },
        { "<leader>al", desc = "Clear buffer and chat history" },
        { "<leader>am", desc = "Generate commit message" },
        { "<leader>an", desc = "Better namings" },
        { "<leader>ap", desc = "Prompt actions" },
        { "<leader>aq", desc = "Quick chat" },
        { "<leader>ar", desc = "Review code" },
        { "<leader>at", desc = "Generate tests" },
        { "<leader>av", desc = "Open in vertical split" },
        { "<leader>ax", desc = "Inline chat" },
      })
    end

    -- Call the functions to define commands, autocommands, and key mappings
    define_user_commands()
    define_autocommands()
    define_key_mappings()
  end,
  event = "VeryLazy",
  keys = {
    {
      "<leader>ah",
      function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.telescope").pick(actions.help_actions())
      end,
      desc = "Diagnostic actions",
      mode = { "n", "v" },
    },
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
    { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Explain code" },
    { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Generate tests" },
    { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Review code" },
    { "<leader>aR", "<cmd>CopilotChatRefactor<cr>", desc = "Refactor code" },
    { "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "Better Naming" },
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
    { "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>", desc = "Debug Info" },
    { "<leader>af", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "Fix Diagnostic" },
    { "<leader>al", "<cmd>CopilotChatReset<cr>", desc = "Clear buffer and chat history" },
    { "<leader>av", "<cmd>CopilotChatToggle<cr>", desc = "Toggle" },
  },
}
