;;load forture
(require 'ox)
(require 'ox-latex)
(require 'ox-html)
(require 'ox-ascii)
(require 'ox-texinfo)
(require 'ob-shell)
(require 'ob-python)

;;定义org table calc执行时的Debug模式开启与关闭
(setq org-table-formula-debug nil)

;;(define-key org-mode-map (kbd "C-c /") 'org-agenda)


(setq org-todo-keywords
      '((type "Fred" "Sara" "Lucy" "|" "DONE")))


;;(setq org-todo-keywords
;;      '((sequence "TODO(t)" "|" "DONE(d)")
;;	(sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
;;
;;	(sequence "|" "CANCELED(c)")))




(setq org-todo-keyword-faces
      '(("TODO" . org-warning) ("STARTED" . "yellow")
        ("CANCELED" . (:foreground "blue" :weight bold :background "yellow"))))

;;(setq org-log-done 'note)

