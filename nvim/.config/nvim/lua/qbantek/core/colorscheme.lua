local status, _ = pcall(vim.cmd, "colorscheme Neosolarized")
if not status then
  print("Colorscheme not found!")
  return
end
