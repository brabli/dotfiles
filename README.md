# brabli's Dotfiles

All the cool kids have a dotfiles repository, so as a cool kid myself I found it fitting to create my own.

These files contain my config for the following programs:

- Neovim
- Vim
- Tmux
- Lazygit

# Installation

First, make sure `$XDG_CONFIG_HOME` is set to `$HOME/.config`.

I'm using [gnu stow](https://www.gnu.org/software/stow/) as a mechanism for installing my dotfiles. Install `stow` and clone this repository into your home directory.

From inside this directory run `stow .` to create symlinks in your home directory to the files in this dotfiles repo.


# Additional Tools

Some other programs are required in order to make full use of these dotfiles.

These tools include but are not necessarily limited to:

- [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

