# To-Do
- [vim] Drop NERDTree for (not) netrw
- [vim] Fix style
    - Use single quotes
    - Update editorconfig for vimscript to use two spaces for indents
    - Use noremap map commands where possible
    - vint configuration?
- [vim] Try out `vim-rhubarb`
- [vim] Use `write-good` via `coc-diagnostic` for prose linting
- [vim] Explore Neovim's built-in LSP client when released (v0.5)
- [linux] Brightness control script for internal and external monitor
- [vim] Convert coc.nvim mappings to built-in mappings with conditional coc.nvim
  use if language server is provided for filetype
    ```autocmd FileType * call LanguageClientMaps()

    function! LanguageClientMaps()
        if has_key(g:LanguageClient_serverCommands, &filetype)
        nnoremap <buffer> <silent> gd \
            :call LanguageClient#textDocument_definition()<CR>
        endif
    endfunction```
