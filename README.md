# NeoVim Configuration for Linux Kernel Development

This is a lua based, bootstrap-able NeoVim Configuration for C development (for example, Linux Kernel or Qemu).

## 1. Prerequisite

1. Install [NeoVim](https://neovim.io/). Refer to [NeoVim Installation Wiki](https://github.com/neovim/neovim/blob/master/INSTALL.md)
2. Install [ripgrep](https://github.com/BurntSushi/ripgrep). Usually distributions already have it.
3. [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) are pretty icon fonts. It is better to install to have a good experience.
4. Have access to github.com. Proxy may need to be configured if sitting in internal network.

## 2. Install

1. Do following to cleanup previous nvim related configurations
```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```
2. Clone this repo to ~/.config/nvim
3. Launch 'nvim'. This will download all the necessary plugins automatically.
4. Quit nvim, and relaunch nvim. That's it.

## 3. LSP and Language Servers

This configuration leverages [LSP](https://microsoft.github.io/language-server-protocol/) and Language servers to do auto-completion, go-to-definition, references, etc.

Refer to [server_configurations.md](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md) on various language servers.

This configuration uses plugin [mason](https://github.com/williamboman/mason.nvim) to manage language servers. Use ':Mason' command to bring up mason interface.

Two language servers 'clangd' and 'lua_ls' are automatically installed. Use ':Mason' to bring up mason and install other language servers.

Sometimes language servers may fail to install. Usually that is because of environment issues, such as proxy is not configured properly.

### 3.1. Clangd and compile_commands.json

If it is C repo, the file compile_commands.json is needed for language server 'clangd' to work.

#### 3.1.1. Linux Kernel

Run 'scripts/clang-tools/gen_compile_commands.py' after kernel compiling. This will generate compile_commands.json in the top directory.

After that, editing c file in the kernel repo will make clangd start to act as a language server.

#### 3.1.2. Qemu

Qemu automatically generate a compile_commands.json in its build/ directory, so no extra actions is needed for Qemu.

## 4. Key Bindings

| Mode | Key              | Binding                                                         |
| ---- | ---------------- | ----------------------------------------------------------------|
| n    | \<SPACE\>        | Leader key                                                      |
| n    | tt               | Toggle Nvim-Tree on left side                                   |
| n    | ts               | Toggle Symbols Outline on right side                            |
| n    | fc               | Telescope switch colorscheme                                    |
| n    | ff               | Telescope find file                                             |
| n    | fb               | Telescope find and switch buffer                                |
| n    | fw               | Telescope find and switch workspace                             |
| n    | fh               | Telescope find all commits that touch selected lines            |
| n    | fg               | Telescope lsp dynamic workspace symbols                         |
| n    | \<C-\]\>         | LSP go to definition                                            | 
| n    | \<C-\\\>r        | Telescope lsp find symbol references                            |
| n    | \<C-\\\>s        | Telescope grep word under cursor                                |
| n    | \<C-\\\>t        | Telescope live grep                                             |
| n    | \<C-\\\>w        | Check out commit to a tmp workspace from a fugitive file buffer |
| n    | \<C-g\>          | Refine search for live grep & lsp-dynamic-workspace symbols     |
| n    | \<C-e\>          | Toggle diagnostic messages from LSP server for a line           |
| n    | K                | LSP hover on current word                                       |
| n    | \<ESC\>          | Cancel search highlight                                         |
| n    | \<TAB\>          | Goto next harpoon buffer, if no, go to next buffer              |
| n    | \<C-Left\>       | Window vertical resize +1                                       |
| n    | \<C-Right\>      | Window vertical resize -1                                       |
| n    | \<C-Up\>         | Window resize -1                                                |
| n    | \<C-Down\>       | Window resize +1                                                |
| n    | \<SPACE\>w       | Switch window                                                   |
| n    | \<C-n\>          | Start a terminal                                                |
| t    | \<ESC\>          | Back to normal mode in terminal                                 |
