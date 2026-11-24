# Neovim Cheatsheet

**Leader Key:** `Space` _(pause after pressing `Space`, `g`, `[`, or `]` for `mini.clue` popup)_

## Files & Search (`mini.pick` & `mini.files`)

| Key         | Action                       | Controls                                                                              |
| :---------- | :--------------------------- | :------------------------------------------------------------------------------------ |
| `<Space>ff` | Find files                   | `Ctrl+n`/`p` move, `Enter` open, `Esc` close                                          |
| `<Space>fg` | Live grep (text search)      | `Ctrl+n`/`p` move, `Enter` open, `Esc` close                                          |
| `<Space>fb` | Switch open buffers          | `Ctrl+n`/`p` move, `Enter` open, `Esc` close                                          |
| `<Space>e`  | File explorer (`mini.files`) | `h`/`l` (or Left/Right) folder nav & open file, `:w` apply renames/deletes, `q` close |

## Code & LSP (`nvim-lspconfig`)

| Key         | Action                     |
| :---------- | :------------------------- |
| `gd`        | Go to definition           |
| `K`         | Hover docs                 |
| `<Space>ca` | Code action / quick fix    |
| `<Space>cr` | Rename symbol              |
| `<Space>cd` | Show line diagnostics      |
| `[d` / `]d` | Previous / next diagnostic |

## Autocomplete (`blink.cmp` — Insert Mode)

| Key                 | Action                     |
| :------------------ | :------------------------- |
| `Ctrl+n` / `Ctrl+p` | Next / previous suggestion |
| `Enter`             | Accept suggestion          |
| `Ctrl+e`            | Close menu                 |
| `Ctrl+Space`        | Trigger menu / toggle docs |
| `Ctrl+b` / `Ctrl+f` | Scroll docs up / down      |

## Editing & Navigation (`mini.surround`, `mini.ai`)

| Key                   | Mode            | Action                                                            |
| :-------------------- | :-------------- | :---------------------------------------------------------------- |
| `sa{motion}{char}`    | Normal / Visual | Add surround (`saiw"` wraps word in quotes)                       |
| `sd{char}`            | Normal          | Delete surround (`sd"` removes quotes)                            |
| `sr{old}{new}`        | Normal          | Replace surround (`sr"'` changes `"` to `'`)                      |
| `vif` / `daf`         | Normal          | Select / delete function (`f` = func, `a` = arg, `q` = any quote) |
| `Ctrl+h/j/k/l`        | Normal          | Move between splits                                               |
| `Shift+h` / `Shift+l` | Normal          | Previous / next buffer                                            |
| `Shift+j` / `Shift+k` | Visual          | Move selected lines down / up                                     |
