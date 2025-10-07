;;; -*- mode: emacs-lisp; lexical-binding: t; -*-


(require 'package)
(add-to-list 'package-archives '("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") t)
(package-initialize)
(setq package-selected-packages '(lsp-mode
				  yasnippet
				  lsp-treemacs
				  helm-lsp
				  projectile
				  ag
				  hydra
				  flycheck
				  company
				  avy
				  which-key
				  helm-xref
				  dap-mode
				  exec-path-from-shell
				  json-mode
				  zenburn-theme
				  typescript-mode
				  python-mode
				  go-mode
				  lua-mode
				  lsp-pyright
				  request
				  magit
				  ))
(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))
(exec-path-from-shell-initialize)
(require 'diary-lib)
;;(load-file (expand-file-name "tools/ai.el" user-emacs-directory))

(use-package ai
  :load-path "~/.emacs.d/tools"
;;  :defer t
  :config
  (message "Ai load Successfully."))

(use-package projectile-config
  :load-path "~/.emacs.d/packageConfig"
;;  :defer t
  :config
  (message "Projectile config loaded Successfully"))

(use-package dashboard-config
  :load-path "~/.emacs.d/packageConfig"
;;  :defer t
  :config
  (message "Dashboard config loaded Successfully"))

(use-package org-conf
  :load-path "~/.emacs.d/packageConfig"
;;  :defer t
  :config
  (message "Org config loaded Successfully"))

(use-package lsp-conf
  :load-path "~/.emacs.d/packageConfig"
;;  :defer t
  :config
  (message "LSP config loaded Successfully"))

(use-package helm-conf
  :load-path "~/.emacs.d/packageConfig"
  ;;:defer t
  :config
  (message "Helm loaded Successfully"))

(use-package other-conf
  :load-path "~/.emacs.d/packageConfig"
;;  :defer t
  :config
  (message "Other config loaded Successfully"))

(use-package dap-conf
  :load-path "~/.emacs.d/packageConfig"
  ;;  :mode ("\\.c\\'" "\\.cpp\\'" "\\.py\\'" "\\.go\\'" "\\.h\\'")
;;  :defer t
  :config
  (message "Dap config loaded Successfully"))

(use-package latex-conf
  :load-path "~/.emacs.d/packageConfig"
;;  :defer t
  :config
  (message "LaTex config loaded Successfully"))

(use-package bind-key-config
  :load-path "~/.emacs.d/packageConfig"
;;  :defer t
  :config
  (message "Bind key config load Successfully"))

(provide 'packageConfig)
