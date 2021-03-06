# Neovim Config

This repository contains my NeoVim-configurations.

Please note, that [@Binx](https://github.com/Binx-Codes) helped me quite a bit with this config, when I was starting out with NeoVim - mainly helping me transition to a lua config from vimscript.

I primarily use Neovim for Golang, Python, and Ruby Projects, so a lot of my configurations are centered towards those languages and frameworks.

## Setup

### Prerequisites

Make sure you have Node, npm and Python3 installed. Then install `pynvim` with `pip install pynvim` or `pip3 install pynvim` and `neovim` with `npm install -g neovim`.

### Install

1. Clone this config to your machine to `~/.config/nvim` (Linux) or `C:\Username\AppData\Local\nvim` (Windows). If you are on Windows, change the packer install path in [init.lua](init.lua).
2. Then open NeoVim (ignore any errors you encounter when it opens) and run `:PackerSync` to install the plugins. Note that this may take a while - some plugins like `vim-go` also install the go binaries. You may remove this from the plugins list in [plugin-list.lua](lua/plugin-list.lua).
3. Finally, restart NeoVim, and you should be good to go!

## Usage

There are a few keys which are already mapped, such as `Ctrl-F`, `Ctrl-S`, and a couple of leader key (Space) maps. You can view the complete mapping in [keybinds.lua](lua/keybinds.lua).

You can install LSP servers with `:LspInstall`. I would recommend installing `lua` and `vim`.

Install TreeSitter parsers with `:TSInstall`. You can tweak the permanently installed parsers in [treesitter-parsers.lua](lua/treesitter-parsers.lua).

You can add plugins in [plugin-list.lua](lua/plugin-list.lua). If you know of any plugins that you think might be useful, feel free to create and issue, or PR!

## Sidenote

My current config has about 30 plugins, which is quite a lot. Yet it takes only ~200 ms to load (You can test this with `nvim some-file.extension --startup-time logs.txt` and then open `logs.txt` to see the break down of the startup time).
This is because most of the plugins are loaded _on demand_. So when you actually open up NeoVim, only a handful of plugins (10-12) are sourced.

Feel free to add more plugins, and configurations, and open a PR to implement them!
