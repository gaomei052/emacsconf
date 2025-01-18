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

(defun org-current-week ()
  "返回当前是第几周"
  (let ((today (decode-time (current-time))))
    (let ((year (nth 5 today))
          (month (nth 4 today))
          (day (nth 3 today)))
      ;; 这里可以加入更复杂的计算，考虑闰年等因素
      (let ((days-in-year (calendar-total-days year month day)))
        (1+ (floor days-in-year 7))))))

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
	("c"
	 "Msbank"
	 entry
	 (file+headline "~/bingo/org/capture/msbank_meeting.org" "Msbank")
	 "* %T\n 主题: %?\n 事件报告单位: \n 事件概述: \n 事件处理: \n 事件影响: \n 解决方式: \n")
	))

(setq org-agenda-include-diary t)
  
;;load forture
(require 'ox)
(require 'ox-latex)
(require 'ox-html)
(require 'ox-odt)
(require 'ox-ascii)
(require 'ox-texinfo)
;;(require 'org-crypt)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . nil)
   (python . t)
   (shell . t)))

;;(setq org-todo-keywords
;;      '((type "Fred" "Sara" "Lucy" "|" "DONE")))
;;
;;(setq org-todo-keyword-faces
;;      '(("TODO" . org-warning) ("STARTED" . "yellow")
;;        ("CANCELED" . (:foreground "blue" :weight bold :background "yellow"))))
;;

(setq org-todo-keywords
      '((sequence "LOOKAT" "START" "DONE")
	(sequence "TODO" "DONE")))

(setq org-todo-keyword-faces
      '(("TODO" . org-warning) ("LOOKAT" . org-warning)
	("START" . "yellow") ("DONE" . "green")))


;;Config org agenda
(setq agenda-frame-v "agenda-frame-323424")
(setq agenda-frame-flag 0)

(defun create-agenda-frame()
  (interactive)
  (when (> agenda-frame-flag 0)
    (setq agenda-frame (find-agenda-frame-by-title))
    (select-frame agenda-frame)
    (raise-frame agenda-frame))
  (when (= agenda-frame-flag 0)
    (let ((new-frame (make-frame)))
      (set-frame-parameter new-frame 'title agenda-frame-v)
      (set-frame-size new-frame 100 60)
      (set-frame-position new-frame 400 0)
      (select-frame new-frame)
      (follow-mode)
      (scroll-bar-mode 0)
      (org-agenda-list)
      (delete-other-windows)
      (setq agenda-frame-flag 1))))

(defun quit-agenda-frame()
  (interactive)
  (when (> agenda-frame-flag 0)
    (org-save-all-org-buffers)
    (setq agenda-frame (find-agenda-frame-by-title))
    (delete-frame agenda-frame)
    (setq agenda-frame-flag 0)))

(defun return-agenda-frame()
  (interactive)
  (when (> agenda-frame-flag 0)
    (setq agenda-frame (find-agenda-frame-by-title))
    (select-frame agenda-frame)
    (org-save-all-org-buffers)
    (org-agenda-list)
    (delete-other-windows)))

(defun find-agenda-frame-by-title()
  (interactive)
  (let ((foud-frame nil))
    (mapc (lambda(frame)
	    (when (string= agenda-frame-v (frame-parameter frame 'title))
	      (setq found-frame frame)))
	  (frame-list))
    found-frame))


(define-key global-map (kbd "C-;") 'create-agenda-frame)
(define-key global-map (kbd "C-c C-;") 'quit-agenda-frame)
(define-key global-map (kbd "C-c C-'") 'return-agenda-frame)

;;config crypt
(setq epa-pinentry-mode 'loopback)

;;config meeting template


;;agenda posframe
(defun bff-posframe-handler(info)
  (let* ((frame (plist-get info :frame))
	 (poswidth (plist-get info :posframe-width))
	 (fwidth (plist-get info :parent-frame-width))
	 (width (- fwidth poswidth)))
    (cons width 1)))
	 
(defun bff(data tout)
	(let ((bf (get-buffer-create "*posframe message 0023324*"))
	      )
	  (with-current-buffer bf
	    (erase-buffer)
	    (goto-char (point-max))
	    (insert (format "%s\n" data)))
	  (posframe-show bf
			 :poshandler 'bff-posframe-handler
			 :min-width 1
	  		 :min-height 1
			 :right-fringe 10
			 :left-fringe 5
			 :border-color "#b2b814"
			 :internal-border-width 1
	  		 :foreground-color "red"
			 :background-color "#505050"
	  		 :timeout tout)))

(defun org-get-agenda-todo-list()
  (let ((files org-agenda-files)
	(result ""))
    (dolist (file files)
	(with-current-buffer (find-file-noselect file)
	  (save-excursion
	    (goto-char (point-min))
  	    (while (re-search-forward "^\\* " nil t)
  	      (let* ((todo (org-element-at-point))
  		     (stime (org-element-property :scheduled todo))
  		     (title (org-element-property :title todo))
  		     (type (org-element-property :todo-keyword todo)))
  		(when stime
  		  (let* ((sttime (org-time-string-to-time (format "%s" stime)))
  			 (sftime (format-time-string "%H:%M" sttime)))
  		    (when (time-less-p sttime
  				       (current-time))
  		      (setq result
  			    (concat result
  				    (format
  				     "%s:\t%s\tSCHEDULED: %s\n"
				     type title sftime)))))))))))
    (replace-regexp-in-string "\n$" "" result)))

(defun agenda-alter-time-out()
  (posframe-delete-all)
  (let ((messages (org-get-agenda-todo-list)))
    (unless (string= messages "")
      (bff messages 30))))

(run-with-timer 60 60 'agenda-alter-time-out)
