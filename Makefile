STOW_DIRS=fish ghostty nvim onedrive starship tmux yazi zed shotcut
EXTENSIONS= $(shell ls -1 /home/tim/.local/share/gnome-shell/extensions)
COMMIT_MSG ?= . Updated configuration files

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
		stow --target=${HOME} -R  $$dir; \
	done	

# un-stow directories
unstow-all:
	@for dir in $(STOW_DIRS); do \
		echo " ->> Running stow (delete) on $$dir"; \
		stow --target=${HOME} -D $$dir; \
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
	@git push --quiet origin main
endif


sync-restore: git-pull git-commit gnome-restore
	@echo " ->> Settings are synced and updated"

sync-backup: git-pull gnome-backup git-commit
	@echo " ->> Settings are synced and updated"

