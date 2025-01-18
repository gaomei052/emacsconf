(load-file (expand-file-name "packageConfig/packageConfig.el" user-emacs-directory))

(setq exec-path (append exec-path '("~/.opam/default/bin")))
(setq exec-path (append exec-path '("/Library/TeX/texbin/")))
(setq exec-path (append exec-path '("/Library/TeX/Distributions/Programs/texbin")))

(global-hl-line-mode nil)
(put 'set-goal-column 'disabled nil)

(setq kill-ring-max 80)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(tooltip-mode 0)
(size-indication-mode t)
(setq default-frame-alist '((width . 216)
                            (height . 60)
                            (top . 0) 
                            (left . 0)
                            (alpha-background . 60)))


(global-font-lock-mode 0)
(add-hook 'c-mode-hook 'font-lock-mode)
(fringe-mode '(0 . 0))

(setq ispell-program-name "/opt/homebrew/bin/ispell")
(setq write-region-inhibit-fsync t)
(setq inhibit-startup-message t)

(global-display-line-numbers-mode t)

(global-set-key (kbd "C-x C-n") 'treemacs)
(global-set-key (kbd "C-.") 'idomenu)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)


(global-font-lock-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files '("~/bingo/org/agenda/ms.org"))
 '(package-selected-packages
   '(c-mode lsp-mode yasnippet lsp-treemacs helm-lsp projectile ag hydra flycheck company avy which-key helm-xref dap-mode exec-path-from-shell json-mode zenburn-theme typescript-mode python-mode go-mode lua-mode lsp-pyright magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
