(use-package projectile
  :ensure t
  :config
  (setq projectile-grep-command "/hopt/home/brew/bin/ag")
  (projectile-mode +1)
  :bind
  (("C-c p" . projectile-command-map)))
