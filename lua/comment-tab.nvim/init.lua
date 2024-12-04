local M = {} -- module

local ft = vim.bo.filetype
-- .py filetype is python.
-- .js is javascript
-- .ts is typescript
--
local function comment_chunk()
    local bufnr = vim.api.nvim_get_current_buf()
    print(vim.api.nvim_get_current_buf())
    print(vim.fn.mode()) -- get mode 'n' 'v' 'i'
    local start_pos = vim.api.nvim_buf_get_mark(bufnr, "<")
    local end_pos = vim.api.nvim_buf_get_mark(bufnr, ">")
    local start_line = start_pos[1] - 1
    local end_line = end_pos[1] - 1
    local comment = "-- "
    for line = start_line, end_line do
        local code = vim.api.nvim_buf_get_lines(bufnr, line, line+1, false)[1]
        if code then
            local code_commented = comment .. code
            vim.api.nvim_buf_set_lines(bufnr, line, line+1, false, {code_commented})
        end
    end
end

function M.setup(opts)
    opts = opts or {}
--    vim.keymap.set("v", "<leader>c", comment_chunk, {noremap=true, silent=true})
end











