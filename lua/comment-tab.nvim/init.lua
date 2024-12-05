local M = {} -- module

local comment_string = {
    python = "# ",
    lua = "-- ",
    javascript = "// ",
    typescript = "// ",
    c = "// ",
    cpp = "// ",
    java = "// ",
    html = "<!-- ",
    css = "/* ",
}
local function get_comment_string()
    local ft = vim.bo.filetype
    return comment_string[ft] or "# " -- auto #
end
function M.comment_chunk()
    local bufnr = vim.api.nvim_get_current_buf()
    print(vim.api.nvim_get_current_buf())
    print(vim.fn.mode()) -- get mode 'n' 'v' 'i'
    local comment = get_comment_string()
    local start_line = vim.api.nvim_buf_get_mark(bufnr, "<")[1] - 1
    local end_line = vim.api.nvim_buf_get_mark(bufnr, ">")[1] - 1
    for line = start_line, end_line do
        local code = vim.api.nvim_buf_get_lines(bufnr, line, line + 1, false)[1]
        if code then
            local code_commented = comment .. code
            vim.api.nvim_buf_set_lines(bufnr, line, line + 1, false, { code_commented })
        end
    end
end
-- Function to tab (indent) selected lines
function M.tab_chunk()
    local indent_string = "    " -- Default to 4 spaces
    local buf = vim.api.nvim_get_current_buf()

    -- Get start and end positions of the visual selection
    local start_pos = vim.api.nvim_buf_get_mark(buf, "<")
    local end_pos = vim.api.nvim_buf_get_mark(buf, ">")

    local start_line = start_pos[1] - 1
    local end_line = end_pos[1] - 1

    -- Loop through each line in the selection
    for line = start_line, end_line do
        local content = vim.api.nvim_buf_get_lines(buf, line, line + 1, false)[1]
        if content then
            -- Add indentation to each line
            local indented_line = indent_string .. content
            vim.api.nvim_buf_set_lines(buf, line, line + 1, false, { indented_line })
        end
    end
end
function M.setup(opts)
    opts = opts or {}
    vim.keymap.set("v", "gc", ":lua require('comment-tab.nvim').comment_chunk()<CR>", { noremap = true, silent = true })
    vim.keymap.set("v", "gt", ":lua require('comment-tab.nvim').tab_chunk()<CR>", {noremap = true, silent = true})
end
