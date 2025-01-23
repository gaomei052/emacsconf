(use-package zenburn-theme
  :ensure t)

(use-package which-key
  :ensure t)

(use-package yasnippet
  :ensure t)

(load-theme 'zenburn t)
(which-key-mode)

(setq yas-snippet-dirs '("/Users/gaomei/.emacs.d/temp/emacs-run/snippets"))

(yas-global-mode 1)

(setq desktop-pat '("/Users/gaomei/.emacs.d/temp/emacs-run"))

(setq auto-save-list-file-name
      "/Users/gaomei/.emacs.d/temp/emacs-run/auto-save-list/.saves-50324-bingo.local~")

(setq auto-save-list-file-prefix
      "/Users/gaomei/.emacs.d/temp/emacs-run/auto-save-list/.saves-")
