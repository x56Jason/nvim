# NeoVim Configuration for Linux Kernel Development

This is a lua based, bootstrap-able NeoVim Configuration for C development (for example, Linux Kernel or Qemu).

## Prerequisite

1. Install NeoVim. Refer to [NeoVim Installation Wiki](https://github.com/neovim/neovim/wiki/Installing-Neovim)
2. Have access to github.com. Proxy may need to be configured if sitting in internal network.

## Install

1. Do following to cleanup previous nvim related configurations
```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```
2. Clone this repo to ~/.config/nvim
3. Launch 'nvim'. This will download all the necessary plugins automatically.
4. Quit nvim, and relaunch nvim. That's it.

## Post-Install

1. Install language servers (clangd, bashls, etc.). Refer to [server_configurations.md](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md) on how to install language servers.
2. Install Nerd fonts

## Generate compile_commands.json

If it is C repo, the file compile_commands.json is needed for language server clangd to work.

### Linux Kernel

Run scripts/clang-tools/gen_compile_commands.py after kernel compiling. This will generate compile_commands.json in the top directory.
Using nvim to edit a file in the repo will make clangd start to act as a language server.

### Qemu

Qemu automatically generate a compile_commands.json in its build/ directory, so no extra actions is needed for Qemu.

## Key Bindings

| Mode | Key              | Binding                                                     |
| ---- | ---------------- | ------------------------------------------------------------|
| n    | \<SPACE\>        | Leader key                                                  |
| n    | tt               | Toggle Nvim-Tree on left side                               |
| n    | ts               | Toggle Symbols Outline on right side                        |
| n    | fc               | Telescope switch colorscheme                                |
| n    | ff               | Telescope find file                                         |
| n    | fb               | Telescope find and switch buffer                            |
| n    | fw               | Telescope find and switch workspace                         |
| n    | fh               | Telescope find all commits that touch selected lines        |
| n    | fg               | Telescope lsp dynamic workspace symbols                     |
| n    | \<C-\]\>         | LSP go to definition                                        | 
| n    | \<C-\\\>r        | Telescope lsp find symbol references                        |
| n    | \<C-\\\>s        | Telescope grep word under cursor                            |
| n    | \<C-\\\>t        | Telescope live grep                                         |
| n    | \<C-g\>          | Refine search for live grep & lsp-dynamic-workspace symbols |
| n    | \<C-e\>          | Toggle diagnostic messages from LSP server for a line       |
| n    | K                | LSP hover on current word                                   |
| n    | \<ESC\>          | Cancel search highlight                                     |
| n    | \<TAB\>          | Goto next buffer                                            |
| n    | \<C-Left\>       | Window vertical resize +1                                   |
| n    | \<C-Right\>      | Window vertical resize -1                                   |
| n    | \<C-Up\>         | Window resize -1                                            |
| n    | \<C-Down\>       | Window resize +1                                            |
| n    | \<SPACE\>w       | Switch window                                               |
| n    | \<C-n\>          | Start a terminal                                            |
| t    | \<ESC\>          | Back to normal mode in terminal                             |
