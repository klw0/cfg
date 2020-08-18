os := $(shell uname -s | tr [:upper:] [:lower:])
dotfile_dir := ./dotfile
common_dotfile_dir := $(dotfile_dir)/common
os_dotfile_dir := $(dotfile_dir)/$(os)

stow := stow --target=$(HOME) -v *
unstow := stow --delete --target=$(HOME) -v *

.PHONY: install
install:
	cd $(common_dotfile_dir) && $(call stow)
	cd $(os_dotfile_dir) && $(call stow)

.PHONY: uninstall
uninstall:
	cd $(common_dotfile_dir) && $(call unstow)
	cd $(os_dotfile_dir) && $(call unstow)
