local M = {}

function M.do_code_action_sync(code_action)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {code_action}}

  local client_results, err = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
  if err then
    vim.notify(string.format("lsp: %s on %s", err, code_action), vim.log.levels.ERROR)
    return
  end

  for client_id, results in pairs(client_results) do
    for _, action in pairs(results.result or {}) do
      if action.edit then
        local client = vim.lsp.get_client_by_id(client_id)
        vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
      end

      if action.command then
        vim.lsp.buf.execute_command(action.command)
      end
    end
  end
end

return M
