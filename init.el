(when (string= emacs-version "30.0.93")
   (setq package-user-dir "/Users/gaomei/.emacs.d/elpa30.0.93"))
(when (string= emacs-version "29.4")
  (setq package-user-dir "/Users/gaomei/.emacs.d/elpa29.4"))
(load-file (expand-file-name "packageConfig/packageConfig.el" user-emacs-directory))

(global-hl-line-mode nil)

(setq default-frame-alist '((menu-bar-lines . 0)
			    (tool-bar-lines . 0)
			    (vertical-scroll-bars . nil)
			    (horizontal-scroll-bars . nil)
			    (width . 215)
			    (height . 60)
			    (top . 0)
			    (left . 0)))


(global-display-line-numbers-mode t)

(global-set-key (kbd "C-x C-n") 'treemacs)
(global-set-key (kbd "C-.") 'idomenu)

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(kill-ring-max 80)
 '(org-agenda-files '("~/bingo/org/agenda/ms.org"))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
