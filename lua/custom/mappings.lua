local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger",
    },
        ["<leader>ws"] = { [[:%s/\s\+$//e<cr>]], "Remove trailing whitespace" },
        ["<leader>u"]  = { "<cmd>UndotreeToggle<CR>", "UndoTreeToggle"}
  }
}

return M

