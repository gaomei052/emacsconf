(use-package projectile
  :ensure t
  :config
  (setq projectile-cache-file "~/.emacs.d/temp/emacs-run/projectile.cache")
  (setq projectile-known-projects-file "~/.emacs.d/temp/emacs-run/projectile-bookmarks.eld")
  (setq projectile-grep-command "/hopt/home/brew/bin/ag")
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map))
