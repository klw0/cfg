local vim = vim

local M = {}

function M.init()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
    }
  )
end

function M.show_buffer_diagnostics()
  local diagnostics = vim.lsp.diagnostic.get(vim.fn.bufnr())
  if not diagnostics then return end

  local items = {}
  for _, diagnostic in ipairs(diagnostics) do
    local range = diagnostic.range.start
    table.insert(items, {
      filename = vim.fn.bufname(),
      lnum = range.line + 1,
      col = range.character + 1,
      text = diagnostic.message,
      type = ({ "E", "W", "I", "H" })[diagnostic.severity],
    })
  end

  vim.lsp.util.set_loclist(items)

  -- Ensure the location list window is closed when there are no diagnostics.
  if #items == 0 then
    vim.api.nvim_command("lclose")
  end
end

return M
