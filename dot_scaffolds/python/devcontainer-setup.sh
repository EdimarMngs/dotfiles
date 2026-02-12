#!/bin/bash
export DEV_CONTAINER=1
chezmoi init --apply git@github.com:EdimarMngs/dotfiles.git

echo "export DEV_CONTAINER=1" >>~/.zshrc

uv lock
uv sync --all-groups