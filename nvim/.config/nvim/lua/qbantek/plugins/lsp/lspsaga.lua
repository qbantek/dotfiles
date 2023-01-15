local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
  return
end

saga.setup({
  move_in_saga = {
    prev = "<C-k>",
    next = "<C-j>"
  },
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "",
  dianostic_header_icon = "   ",
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  finder_action_keys = {
    open = "<CR>", -- default
  },
  -- use enter to open file with definition preview
  definition_action_keys = {
    edit = "<CR>",
  },
  definition_preview_icon = "  ",
})
