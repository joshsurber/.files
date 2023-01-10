-- A list of modules included. Uncommented ones will be loaded.
local modules = {

    'ai', -- Extend and create `a`/`i` textobjects          -- miniai
    -- 'align' , -- Align text interactively                   -- minialign
    'animate', -- Animate common Neovim actions             -- minianimate
    -- 'base16' , -- Base16 colorscheme creation               -- minibase16
    'bufremove', -- Remove buffers                          -- minibufremove
    'comment', -- Comment                                   -- minicomment
    -- 'completion' , -- Completion and signature help         -- minicompletion
    'cursorword', -- Autohighlight word under cursor        -- minicursorword
    -- 'doc' , -- Generate Neovim help files                   -- minidoc
    -- 'fuzzy' , -- Fuzzy matching                             -- minifuzzy
    'indentscope', -- Visualize and operate on indent scope -- miniindentscope
    'jump', -- Jump forward/backward to a single character  -- minijump
    'jump2d', -- Jump within visible lines                  -- minijump2d
    -- 'map' , -- Window with buffer text overview             -- minimap
    -- 'misc' , -- Miscellaneous functions                     -- minimisc
    'pairs', -- Autopairs                                   -- minipairs
    'sessions', -- Session management                       -- minisessions
    'starter', -- Start screen                              -- ministarter
    'statusline', -- Statusline                             -- ministatusline
    'surround', -- Surround actions                         -- minisurround
    'tabline', -- Tabline                                   -- minitabline
    -- 'test' , -- Test Neovim plugins                         -- minitest
    'trailspace', -- Trailspace (highlight and remove)      -- minitrailspace

}

local config = {

    bufremove = {
        after = function()
            vim.keymap.set("n", "<leader>q", "<cmd>lua MiniBufremove.wipeout()<cr>",
                { desc = 'Wipeout buffer (close tab)' })
        end
    },

    sessions = {
        after = function()
            vim.api.nvim_create_user_command('Screate', function()
                vim.ui.input({
                    prompt = 'Session name? ',
                }, function(input) MiniSessions.write(input) end)
            end, {})

            vim.api.nvim_create_user_command('Sdelete', function()
                MiniSessions.select('delete')
            end, {})

            vim.api.nvim_create_user_command('Sload', function()
                MiniSessions.write()
                MiniSessions.select()
            end, {})
        end
    },

    trailspace = {
        after = function()
            -- Delete trailing space on write
            vim.api.nvim_create_autocmd('BufWritePre', { callback = MiniTrailspace.trim})
            vim.api.nvim_create_autocmd('BufWritePre', { callback = MiniTrailspace.trim_last_lines})
        end
    }

}

for _, module in pairs(modules) do
    local opts = config[module] or {}
    require('mini.' .. module).setup(opts)
    if config[module] and config[module].after then pcall(config[module].after) end
end

-- vim.api.nvim_create_user_command('Bdelete', )