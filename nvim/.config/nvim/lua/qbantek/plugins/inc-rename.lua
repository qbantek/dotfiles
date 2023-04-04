local setup, inc_rename = pcall(require, "inc_rename")
if not setup then
  return
end

-- configure/enable incRename
inc_rename.setup()
