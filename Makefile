STOW_DIRS=fish ghostty nvim onedrive starship tmux yazi zed
EXTENSIONS= $(shell ls -1 /home/tim/.local/share/gnome-shell/extensions)

all:
	@echo "Nothing to do"


show-extensions:
	@for ext in $(EXTENSIONS); do \
		echo "$$ext"; \
	done	

# backup gnome gsettings into .ini files
gnome-backup:
	@./gnome/gnome_conf.fish backup

# restore gnome gsettings from .ini files
gnome-restore:
	@./gnome/gnome_conf.fish restore

# re-stow directories
stow-all:
	@for dir in $(STOW_DIRS); do \
		echo " ->> Running stow on $$dir"; \
		stow -R -v $$dir; \
	done	

extension-install:
	@./gnome/gnome_extentions.fish
