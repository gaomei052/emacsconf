(use-package org
  :ensure t
  :config
  (setq org-babel-python-command "/Users/gaomei/.virtualenvs/common399/bin/python")
  (setq org-table-formula-debug nil)
  (setq org-src-fontify-natively t)
  :bind ("C-c c" . org-capture))
  
;;load forture
(require 'ox)
(require 'ox-latex)
(require 'ox-html)
(require 'ox-ascii)
(require 'ox-texinfo)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . nil)
   (python . t)
   (shell . t)))

(setq org-todo-keywords
      '((type "Fred" "Sara" "Lucy" "|" "DONE")))

(setq org-todo-keyword-faces
      '(("TODO" . org-warning) ("STARTED" . "yellow")
        ("CANCELED" . (:foreground "blue" :weight bold :background "yellow"))))

