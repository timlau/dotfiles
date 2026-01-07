STOW_DIRS=fish ghostty nvim onedrive starship tmux yazi zed
EXTENSIONS= $(shell ls -1 /home/tim/.local/share/gnome-shell/extensions)
COMMIT_MSG ?= update settings

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


git-pull:
	@git pull origin main --quiet

git-commit:
ifneq ($(shell git diff-index --quiet HEAD; echo $$?), 0)
	@echo " ->> Changes detected, committing..."
	@git add . --no-verbose
	@git commit -m "$(COMMIT_MSG)" --quiet
endif


sync: git-pull git-commit gnome-restore
	@echo " ->> Settings are synced and updated"
