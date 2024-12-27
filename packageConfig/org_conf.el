(use-package org
  :ensure t
  :config
  (setq org-babel-python-command "/Users/gaomei/.virtualenvs/common399/bin/python")
  (setq org-directory "~/bingo/org")
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (setq org-table-formula-debug nil)
  (setq org-src-fontify-natively t)
  :bind ("C-c c" . org-capture))

;;Org capture functions
(defun capture-url-path()
  (let ((url-input (read-from-minibuffer "Url path: ")))
    (format "[[%s][跳转]]" url-input)))

;;Org capture template
(setq org-capture-templates
      '(("m"
	 "Memo"
	 entry
	 (file+headline "~/bingo/org/capture/memo.org" "Memo")
	 "* MEMO %?\n DATETIME: %T\n %i\n %A")
	("u"
	 "Url"
	 entry
	 (file+headline "~/bingo/org/capture/url.org" "Web Clips")
	 "* Desc %?\n DATATIME: %T\n %i\n %(capture-url-path)")
	("t"
	 "Todo"
	 entry
	 (file+headline "~/bingo/org/capture/todo.org" "Tasks")
	 "* TODO %?\n %i\n %a")
	))

(current-buffer)
  
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

