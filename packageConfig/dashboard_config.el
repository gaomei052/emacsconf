(use-package dashboard
  :ensure t
  :requires projectile
  :hook (dashboard-setup . my-bashboard-setup))
  
(dashboard-setup-startup-hook)
(setq dashboard-startup-banner '("~/.emacs.d/images/dog_svg.png" . ""))
(setq dashboard-items '((recents . 10)
			  (bookmarks . 5)
			  (projects . 5)
			  (agenda . 5)
			  (registers . 5)))
(setq dashboard-item-shortcuts '((recents   . "r")
                                 (bookmarks . "m")
                                 (projects  . "p")
                                 (agenda    . "a")
                                 (registers . "e")))
(setq dashboard-item-names '(("Recent Files:"               . "Recently opened files:")
                             ("Agenda for today:"           . "Today's agenda:")
                             ("Agenda for the coming week:" . "Agenda:")))
(add-to-list 'dashboard-items '(agenda) t)
(setq dashboard-week-agenda t)
(defun my-bashboard-setup()
  (dashboard-set-center
   '((group "Projects"
	    (files projectile-recent-projects)))))

(define-key dashboard-mode-map (kbd "n") 'dashboard-next-line)
