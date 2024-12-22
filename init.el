;;; (load "~/.emacs.d/packageConfig/packageConfig.el")

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") t)
(package-initialize)

(setq other-packages-list '(
			   exec-path-from-shell
			   ))
(when (cl-find-if-not #'package-installed-p other-packages-list)
  (package-refresh-contents)
  (mapc #'package-install other-packages-list))

(exec-path-from-shell-initialize)

(load-file (expand-file-name "packageConfig/packageConfig.el" user-emacs-directory))

(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(setq org-babel-python-command "/opt/homebrew/bin/python3")

;;(load "~/.emacs.d/elpa/proof-general-20240912.1558/generic/proof-site")

;;(when (memq window-system '(mac ns x))
;;  (exec-path-from-shell-initialize))
(setq exec-path (append exec-path '("~/.opam/default/bin")))
(setq exec-path (append exec-path '("/Library/TeX/texbin/")))
(setq exec-path (append exec-path '("/Library/TeX/Distributions/Programs/texbin")))





(global-hl-line-mode nil)
(put 'set-goal-column 'disabled nil)

(setq kill-ring-max 120)

(tool-bar-mode 0)
(menu-bar-mode 0)
;;(Scroll-bar-mode 0)
(tooltip-mode 0)
(size-indication-mode t)
(setq default-frame-alist '((width . 213) 
                            (height . 60) 
                            (top . 0) 
                            (left . 0)
                            (alpha-background . 90)))

(global-font-lock-mode 0)
(add-hook 'c-mode-hook 'font-lock-mode)
;;(setq treesit-extra-load-path "/Users/gaomei/bingo/git/tree-sitter-grammars")
(fringe-mode '(0 . 0))

(setq ispell-program-name "/opt/homebrew/bin/ispell")
(setq write-region-inhibit-fsync t)
(setq inhibit-startup-message t)

(global-display-line-numbers-mode t)

;;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; '(package-selected-packages '(idomenu imenu-anywhere treemacs proof-general)))
;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; )

(global-set-key (kbd "C-x C-n") 'treemacs)
(global-set-key (kbd "C-.") 'idomenu)

;;(setq org-src-fontify-natively t)
;;(custom-set-variables
;; ;; custom-set-variables was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; '(dashboard-item-shortcuts
;;   '((recents . "r")
;;     (bookmarks . "m")
;;     (projects . "p")
;;     (agenda . "a")
;;     (registers . "e")))
;; '(package-selected-packages
;;   '(typescript-mode lsp-mode projectile term-project dashboard fuzzy htmlize org org-preview-html grip-mode treemacs proof-general imenu-anywhere idomenu exec-path-from-shell))
;; '(zenburn-override-colors-alist
;;   '(("zenburn-bg+05" . "#282828")
;;     ("zenburn-bg+1" . "#2F2F2F")
;;     ("zenburn-bg+2" . "#868282")
;;     ("zenburn-bg+3" . "#676565"))))
;;(custom-set-faces
;; ;; custom-set-faces was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; )



;;(desktop-save-mode 1)

(global-font-lock-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(helm-make lsp-mode yasnippet lsp-treemacs helm-lsp projectile hydra flycheck helm-xref dap-mode json-mode zenburn-theme typescript-mode go-mode lsp-pyright)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
