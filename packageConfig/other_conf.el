(use-package zenburn-theme
  :ensure t)

(use-package which-key
  :ensure t)

(use-package yasnippet
  :ensure t)

(use-package nov
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

(use-package chinese-word-at-point
  :ensure t)

(use-package osx-dictionary
  :ensure t
  :if (eq system-type 'darwin)
  :bind (("C-c d" . osx-dictionary-search-pointer)
         ("C-c D" . osx-dictionary-search-input)
         ("C-c i" . osx-dictionary-search-pointer-at-point))
  :config
  (setq osx-dictionary-use-chinese-text-segmentation t))


(add-hook 'nov-mode-hook
          (lambda ()
            (face-remap-add-relative 'default :height 150))) ; 字号 150%（按需调整）

(load-theme 'zenburn t)
(which-key-mode)

(setq yas-snippet-dirs '("/Users/gaomei/.emacs.d/temp/emacs-run/snippets"))

(yas-global-mode 1)

(setq desktop-pat '("/Users/gaomei/.emacs.d/temp/emacs-run"))

(setq auto-save-list-file-name
      "/Users/gaomei/.emacs.d/temp/emacs-run/auto-save-list/.saves-50324-bingo.local~")

(setq auto-save-list-file-prefix
      "/Users/gaomei/.emacs.d/temp/emacs-run/auto-save-list/.saves-")
