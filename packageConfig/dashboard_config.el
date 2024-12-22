(setq dashboard-package '(dashboard))
(when (cl-find-if-not #'package-installed-p dashboard-package)
  (package-refresh-contents)
  (mapc #'package-install dashboard-package))
(require 'dashboard)
(dashboard-setup-startup-hook)

;;(setq dashboard-startup-banner '("~/.emacs.d/elpa/dashboard-20241120.2030/banners/dog_svg.png" . "~/.emacs.d/elpa/dashboard-20241120.2030/banners/2.txt"))

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

;;绑定上(p)下(n)快捷键
(define-key dashboard-mode-map (kbd "n") 'dashboard-next-line)
(define-key dashboard-mode-map (kbd "p") 'dashboard-previous-line)
