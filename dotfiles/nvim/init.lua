-- ==========================================================================
-- 1. CORE OPTIONS & KITTY 16-COLOR PALETTE
-- ==========================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

-- Better UX defaults
vim.opt.ignorecase = true -- Case-insensitive search...
vim.opt.smartcase = true  -- ...unless uppercase is typed
vim.opt.splitright = true -- Vertical splits open to the right
vim.opt.splitbelow = true -- Horizontal splits open below
vim.opt.undofile = true   -- Persistent undo across sessions
vim.opt.updatetime = 250  -- Faster CursorHold and diagnostic updates
vim.opt.showmode = false  -- Hide "-- INSERT --" (put it in statusline instead)
vim.o.winborder = "rounded" -- Rounded borders on all floating windows (LSP, diagnostics, pickers)

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Clean "riced" characters
vim.opt.fillchars = {
    eob = " ",
    vert = "│",
    horiz = "─",
    diff = "╱",
}

-- ==========================================================================
-- 2. COLORSCHEME & 16-COLOR KITTY POLISH
-- ==========================================================================
vim.cmd.colorscheme("vim") -- Base 16-color scheme, refined below for Kitty ANSI palette (0-15)

local transparent_groups = {
    "Normal", "NormalNC", "NormalFloat", "SignColumn",
    "EndOfBuffer", "LineNr", "StatusLine", "StatusLineNC",
    "VertSplit", "WinSeparator", "FoldColumn", "MiniFilesNormal", "MiniFilesBorder", "MiniFilesTitle",
    "MiniPickNormal", "MiniPickBorder", "MiniPickPrompt",
    "MiniClueBorder", "MiniClueDescGroup", "MiniClueDescSingle",
    "BlinkCmpMenu", "BlinkCmpMenuBorder", "BlinkCmpDoc", "BlinkCmpDocBorder",
}

for _, group in ipairs(transparent_groups) do
    vim.api.nvim_set_hl(0, group, { ctermbg = "none", bg = "none" })
end

-- Subtle highlights using Kitty's ANSI colors (0-15) so UI elements pop cleanly
vim.api.nvim_set_hl(0, "CursorLine", { ctermbg = 0 })                -- Kitty color0 (black/dark gray)
vim.api.nvim_set_hl(0, "CursorLineNr", { ctermfg = 4, bold = true }) -- Kitty color4 (blue)
vim.api.nvim_set_hl(0, "LineNr", { ctermfg = 8 })                    -- Kitty color8 (bright black/muted gray)
vim.api.nvim_set_hl(0, "Visual", { ctermbg = 8 })                    -- Muted selection highlight
vim.api.nvim_set_hl(0, "Pmenu", { ctermbg = 0, ctermfg = 7 })        -- Completion menu
vim.api.nvim_set_hl(0, "PmenuSel", { ctermbg = 4, ctermfg = 0, bold = true })
vim.api.nvim_set_hl(0, "FloatBorder", { ctermfg = 8, ctermbg = "none" })
vim.api.nvim_set_hl(0, "WinSeparator", { ctermfg = 8, ctermbg = "none" })
vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { ctermfg = 8 })
vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { ctermbg = 0, ctermfg = 15, bold = true })
vim.api.nvim_set_hl(0, "MiniPickPrompt", { ctermfg = 4, ctermbg = "none", bold = true })
vim.api.nvim_set_hl(0, "MiniStarterHeader",     { ctermfg = 14, bold = true })
vim.api.nvim_set_hl(0, "MiniStarterFooter",     { ctermfg = 14 })
vim.api.nvim_set_hl(0, "MiniStarterSection",    { ctermfg = 13, bold = true })
vim.api.nvim_set_hl(0, "MiniStarterItemPrefix", { ctermfg = 12, bold = true })
vim.api.nvim_set_hl(0, "MiniStarterItemBullet", { ctermfg = 14 })
vim.api.nvim_set_hl(0, "MiniStarterQuery",      { ctermfg = 10, bold = true })
vim.api.nvim_set_hl(0, "MiniStarterCurrent",    { ctermbg = "none", ctermfg = 14, bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpKind", { ctermfg = 6 })

-- Statusline 16-color ANSI pills (transparent center, colored badges)
vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal",  { ctermbg = 4, ctermfg = 0, bold = true })
vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert",  { ctermbg = 2, ctermfg = 0, bold = true })
vim.api.nvim_set_hl(0, "MiniStatuslineModeVisual",  { ctermbg = 5, ctermfg = 0, bold = true })
vim.api.nvim_set_hl(0, "MiniStatuslineModeReplace", { ctermbg = 1, ctermfg = 0, bold = true })
vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand", { ctermbg = 3, ctermfg = 0, bold = true })
vim.api.nvim_set_hl(0, "MiniStatuslineModeOther",   { ctermbg = 6, ctermfg = 0, bold = true })
vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo",     { ctermbg = 0, ctermfg = 7 })
vim.api.nvim_set_hl(0, "MiniStatuslineFilename",    { ctermbg = "none", ctermfg = 15, bold = true })
vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo",    { ctermbg = 0, ctermfg = 6 })
vim.api.nvim_set_hl(0, "MiniStatuslineInactive",    { ctermbg = "none", ctermfg = 8 })

-- Distinct 16-color ANSI syntax mapping (overrides "vim" defaults that grouped too many tokens together)
local syntax_groups = {
    -- Comments & Todos
    Comment                = { ctermfg = 8, italic = true },
    ["@comment"]           = { ctermfg = 8, italic = true },
    SpecialComment         = { ctermfg = 8, italic = true },
    Todo                   = { ctermfg = 11, bold = true },
    ["@comment.todo"]      = { ctermfg = 11, bold = true },
    ["@comment.note"]      = { ctermfg = 14, bold = true },
    ["@comment.warning"]   = { ctermfg = 3, bold = true },
    ["@comment.error"]     = { ctermfg = 9, bold = true },

    -- Variables, Parameters, Properties
    Identifier             = { ctermfg = 7 },
    ["@variable"]          = { ctermfg = 7 },
    ["@lsp.type.variable"] = { ctermfg = 7 },
    ["@variable.parameter"]  = { ctermfg = 9, italic = true },
    ["@lsp.type.parameter"]  = { ctermfg = 9, italic = true },
    ["@variable.builtin"]    = { ctermfg = 1, italic = true },
    ["@variable.member"]     = { ctermfg = 6 },
    ["@property"]            = { ctermfg = 6 },
    ["@lsp.type.property"]   = { ctermfg = 6 },

    -- Functions & Methods
    Function                 = { ctermfg = 12, bold = true },
    ["@function"]            = { ctermfg = 12, bold = true },
    ["@function.call"]       = { ctermfg = 12, bold = true },
    ["@function.method"]     = { ctermfg = 12, bold = true },
    ["@function.method.call"] = { ctermfg = 12, bold = true },
    ["@lsp.type.function"]   = { ctermfg = 12, bold = true },
    ["@lsp.type.method"]     = { ctermfg = 12, bold = true },
    ["@function.builtin"]    = { ctermfg = 14, bold = true },
    ["@constructor"]         = { ctermfg = 14, bold = true },

    -- Keywords & Operators
    Statement                = { ctermfg = 13, bold = true },
    Keyword                  = { ctermfg = 13, bold = true },
    Conditional              = { ctermfg = 13, bold = true },
    Repeat                   = { ctermfg = 13, bold = true },
    Exception                = { ctermfg = 13, bold = true },
    Label                    = { ctermfg = 13, bold = true },
    ["@keyword"]             = { ctermfg = 13, bold = true },
    ["@keyword.conditional"] = { ctermfg = 13, bold = true },
    ["@keyword.repeat"]      = { ctermfg = 13, bold = true },
    ["@keyword.exception"]   = { ctermfg = 13, bold = true },
    ["@label"]               = { ctermfg = 13, bold = true },
    ["@keyword.function"]    = { ctermfg = 13, italic = true },
    ["@keyword.return"]      = { ctermfg = 13, italic = true },
    Operator                 = { ctermfg = 14 },
    ["@operator"]            = { ctermfg = 14 },
    ["@keyword.operator"]    = { ctermfg = 14 },

    -- Types, Modules, Preprocessor
    Type                     = { ctermfg = 11, bold = true },
    Structure                = { ctermfg = 11, bold = true },
    Typedef                  = { ctermfg = 11, bold = true },
    ["@type"]                = { ctermfg = 11, bold = true },
    ["@lsp.type.type"]       = { ctermfg = 11, bold = true },
    ["@lsp.type.class"]      = { ctermfg = 11, bold = true },
    ["@lsp.type.struct"]     = { ctermfg = 11, bold = true },
    ["@lsp.type.interface"]  = { ctermfg = 11, bold = true },
    ["@lsp.type.enum"]       = { ctermfg = 11, bold = true },
    StorageClass             = { ctermfg = 3, italic = true },
    ["@type.builtin"]        = { ctermfg = 3, italic = true },
    ["@lsp.type.typeParameter"] = { ctermfg = 3, italic = true },
    ["@module"]              = { ctermfg = 4, italic = true },
    ["@module.builtin"]      = { ctermfg = 4, italic = true },
    ["@lsp.type.namespace"]  = { ctermfg = 4, italic = true },
    PreProc                  = { ctermfg = 5 },
    Include                  = { ctermfg = 5 },
    Define                   = { ctermfg = 5 },
    Macro                    = { ctermfg = 5 },
    PreCondit                = { ctermfg = 5 },
    ["@keyword.import"]      = { ctermfg = 5 },
    ["@attribute"]           = { ctermfg = 5 },
    ["@constant.macro"]      = { ctermfg = 5 },
    ["@lsp.type.macro"]      = { ctermfg = 5 },
    ["@lsp.type.decorator"]  = { ctermfg = 5 },

    -- Literals & Constants
    String                   = { ctermfg = 10 },
    Character                = { ctermfg = 10 },
    ["@string"]              = { ctermfg = 10 },
    ["@character"]           = { ctermfg = 10 },
    SpecialChar              = { ctermfg = 14 },
    ["@string.escape"]       = { ctermfg = 14 },
    ["@string.special"]      = { ctermfg = 14 },
    ["@string.regexp"]       = { ctermfg = 14 },
    Number                   = { ctermfg = 3 },
    Float                    = { ctermfg = 3 },
    ["@number"]              = { ctermfg = 3 },
    ["@number.float"]        = { ctermfg = 3 },
    Boolean                  = { ctermfg = 9, bold = true },
    ["@boolean"]             = { ctermfg = 9, bold = true },
    Constant                 = { ctermfg = 9 },
    ["@constant"]            = { ctermfg = 9 },
    ["@constant.builtin"]    = { ctermfg = 9, bold = true },
    ["@lsp.type.enumMember"] = { ctermfg = 9 },

    -- Punctuation, Special, Tags, Markup
    Delimiter                = { ctermfg = 8 },
    ["@punctuation.delimiter"] = { ctermfg = 8 },
    ["@punctuation.bracket"]   = { ctermfg = 8 },
    ["@punctuation.special"]   = { ctermfg = 14 },
    Special                  = { ctermfg = 14 },
    Tag                      = { ctermfg = 14 },
    ["@tag"]                 = { ctermfg = 14 },
    ["@tag.attribute"]       = { ctermfg = 3, italic = true },
    ["@tag.delimiter"]       = { ctermfg = 8 },
    Title                    = { ctermfg = 12, bold = true },
    ["@markup.heading"]      = { ctermfg = 12, bold = true },
    ["@markup.strong"]       = { bold = true },
    ["@markup.italic"]       = { italic = true },
    ["@markup.raw"]          = { ctermfg = 10 },
    ["@markup.raw.block"]    = { ctermfg = 10 },
    ["@markup.link"]         = { ctermfg = 6, underline = true },
    ["@markup.link.url"]     = { ctermfg = 6, underline = true },
}

for group, opts in pairs(syntax_groups) do
    vim.api.nvim_set_hl(0, group, opts)
end

-- ==========================================================================
-- 3. PLUGINS (Built-in vim.pack in Neovim 0.12+)
-- ==========================================================================
vim.pack.add({
    "https://github.com/nvim-mini/mini.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/akinsho/toggleterm.nvim",
    "https://github.com/stevearc/conform.nvim",
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
})

-- Icons & UI Polish
require("mini.icons").setup()
local statusline = require("mini.statusline")
statusline.setup({
    use_icons = true,
    content = {
        active = function()
            local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
            local git           = statusline.section_git({ trunc_width = 40 })
            local diff          = statusline.section_diff({ trunc_width = 75 })
            local diagnostics   = statusline.section_diagnostics({ trunc_width = 75 })
            local filename      = statusline.section_filename({ trunc_width = 140 })
            local fileinfo      = statusline.section_fileinfo({ trunc_width = 120 })
            local location      = "%l:%c │ %p%%"

            local clients = vim.lsp.get_clients({ bufnr = 0 })
            local lsp = ""
            if #clients > 0 then
                local names = vim.tbl_map(function(c) return c.name end, clients)
                lsp = " " .. table.concat(names, ", ")
            end

            return statusline.combine_groups({
                { hl = mode_hl,                  strings = { mode:upper() } },
                { hl = "MiniStatuslineDevinfo",  strings = { git, diff, diagnostics } },
                "%<",
                { hl = "MiniStatuslineFilename", strings = { filename } },
                "%=",
                { hl = "MiniStatuslineDevinfo",  strings = { lsp } },
                { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
                { hl = mode_hl,                  strings = { location } },
            })
        end,
    },
})
require("mini.indentscope").setup({ symbol = "│" })
require("mini.notify").setup()
require("mini.diff").setup()
local hour = tonumber(os.date("%H"))
local greeting = (hour < 12 and "Good morning") or (hour < 18 and "Good afternoon") or "Good evening"
local welcome = string.format("%s, %s!", greeting, vim.env.USER or "user")
local pad = string.rep(" ", math.max(0, math.floor((48 - #welcome) / 2)))
local rule = string.rep("─", 48)
local starter = require("mini.starter")
starter.setup({
    header = table.concat({
        "                     │\\  ││",
        "                     ││\\ ││",
        "                     ││ \\││",
        "                     ││  \\│",
        "",
        pad .. welcome,
        rule,
    }, "\n"),
    footer = rule,
    content_hooks = {
        starter.gen_hook.adding_bullet("▸ "),
        starter.gen_hook.aligning("center", "center"),
    },
})

-- Editing Ergonomics (the "LazyVim feel")
require("mini.pairs").setup()    -- Auto-close (), [], {}, ""
require("mini.surround").setup() -- sa (add), sd (delete), sr (replace) surroundings
require("mini.ai").setup()       -- Better text objects: va), cin", daf (function)

-- File Explorer & Fuzzy Finder
require("mini.files").setup()
require("mini.pick").setup()

-- Keybinding Discovery Popup (replaces which-key.nvim)
local miniclue = require("mini.clue")
miniclue.setup({
    triggers = {
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },
        { mode = "n", keys = "g" },
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },
    },
    clues = {
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        { mode = "n", keys = "<Leader>f", desc = "+Find" },
        { mode = "n", keys = "<Leader>c", desc = "+Code" },
        { mode = "n", keys = "<Leader>r", desc = "+Run" },
    },
})

-- Treesitter (AST syntax highlighting & indentation for nvim-treesitter main branch)
require("nvim-treesitter").install({ "lua", "nix", "python", "go", "typescript", "markdown", "bash" })

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})

-- Autocomplete (replaces nvim-cmp)
require("blink.cmp").setup({
    keymap = { preset = "enter" },
    completion = {
        menu = { border = "none" },
        documentation = {
            auto_show = true,
            window = { border = "none" },
        },
    },
})

-- Built-in LSP (Neovim 0.11+ native vim.lsp.enable)
vim.lsp.enable({ "lua_ls", "nil_ls", "pyright", "gopls", "ruff" })

vim.diagnostic.config({
    virtual_text = { prefix = "●" },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
            [vim.diagnostic.severity.HINT]  = "󰌵 ",
        },
    },
})

-- Code Formatting (conform.nvim)
require("conform").setup({
    formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_format" },
        lua = { "stylua" },
        nix = { "nixfmt" },
        go = { "gofmt" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})

-- Floating / Interactive Terminal
require("toggleterm").setup({
    open_mapping = [[<C-\>]],
    direction = "float",
    float_opts = { border = "rounded" },
})

-- ==========================================================================
-- 4. KEYMAPS
-- ==========================================================================
vim.keymap.set("n", "<leader>ff", "<cmd>Pick files<CR>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Pick grep_live<CR>", { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Pick buffers<CR>", { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>e", function() require("mini.files").open() end, { desc = "File Explorer" })
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })
vim.keymap.set("n", "<leader>rp", function()
    vim.cmd("write")
    local file = vim.fn.shellescape(vim.fn.expand("%:p"))
    require("toggleterm").exec("python3 " .. file, 1, nil, nil, "float", nil, false)
end, { desc = "Run Python File" })

-- LSP shortcuts
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Docs" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename Symbol" })
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format Buffer" })
