os := $(shell uname -s | tr [:upper:] [:lower:])
dotfiles_dir := ./dotfiles
common_dotfiles_dir := $(dotfiles_dir)/common
os_dotfiles_dir := $(dotfiles_dir)/$(os)

stow := stow --target=$(HOME) -v *
unstow := stow --delete --target=$(HOME) -v *

.PHONY: install
install:
	cd $(common_dotfiles_dir) && $(call stow)
	cd $(os_dotfiles_dir) && $(call stow)

.PHONY: uninstall
uninstall:
	cd $(common_dotfiles_dir) && $(call unstow)
	cd $(os_dotfiles_dir) && $(call unstow)
