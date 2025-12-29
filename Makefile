STOW_DIRS=fish ghostty nvim onedrive starship tmux yazi zed

all:
	@echo "Nothing to do"

# backup gnome gsettings into .ini files
gnome-backup:
	./gnome/gnome_conf backup

# restore gnome gsettings from .ini files
gnome-restore:
	./gnome/gnome_conf restore

# re-stow directories
stow-all:
	@for dir in $(STOW_DIRS); do \
		echo "Running stow on $$dir"; \
		stow -R -v $$dir; \
	done	

