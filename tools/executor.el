;;Set global varible
(setq exector-buffer-name "*Executor output29347293847*")

;;Project executor
(defun awk-execute-quit()
  (interactive)
  (kill-buffer)
  (delete-window))

(defvar-keymap awk-execute-mode-map
  :doc "Add awk-execute-ui hot key."
  "q" 'awk-execute-quit)

(define-derived-mode executor-mode text-mode "Executor"
  "Executor mode."
  (read-only-mode 1)
  (use-local-map awk-execute-mode-map))


(defun executor-ui(bn)
  "Create executor ui."
  (setq current-window-height (window-height))
  (setq height-old (cond ((> current-window-height 30)
  			    (- current-window-height 10))))
  (setq exe-win (split-window-below height-old))
  (setq exe-buf (get-buffer-create bn))
  (with-current-buffer exe-buf
    (executor-mode))
;;  (display-buffer exe-buf exe-win)
  (select-window exe-win)
  (switch-to-buffer exe-buf)
  (list exe-win exe-buf))


;;Create a executor template.
(defvar executor-type-template-lists '())

(defun executor-type-template(template)
  "Add template to executor-type-template-lists."
  (push template executor-type-template-lists))


(defun ex-remove-if(fun list)
  "Input a function & a list.Output execut function list's elements list."
  (let ((result nil))
	 (dolist (ele list)
	   (unless (funcall fun ele)
	     (push ele result)))
	 (reverse result)))

(defun ex-create-dir(path)
  (if (file-exists-p path)
      (file-exists-p path)
    (let ((parent-dir (file-name-directory path)))
      (when parent-dir
	(ex-create-dir parent-dir))
      (unless (file-directory-p path)
	(make-directory dir t)))))

(defun ex-create-file(path)
  (if (file-exists-p path)
      (file-exists-p path)
    ((ex-create-dir (file-name-directory path))
     (touch path))))

(defun awk-executor-work(config script)
  "Awk executor,Output a string list,this list is make-process's command argument."
  (setq result nil)
  (let ((args-mid (plist-get config :args-mid))
	(src-file (plist-get config :src-file))
	(exec-path (plist-get config :exec-path)))
    (push exec-path result)
    (when (and (stringp args-mid) (string= args-mid ""))
      (setq args-mid (read-from-minibuffer "Input awk's argument: ")))
    (push args-mid result)
    (push "-f" result)
    (push script result)
    (when (and (stringp src-file) (string= src-file ""))
      (setq src-file (read-file-name "Entry source file name: "))
      (when (string= src-file "/")
	(setq src-file "")))
    (push src-file result))
  (reverse (ex-remove-if (lambda(x) (and (stringp x) (or (string= x "") (string= x "/")))) result)))  

(executor-type-template
 (list
  :mode 'awk-mode
  :args-mid ""
  :src-file ""
  :executor-work 'awk-executor-work
  :exec-path "/opt/homebrew/bin/awk"
  :name "awk"))

(defun get-makefile-project-dir(dir)
  (when (or (string= dir "") (string= dir "/"))
    (error (message "Not find makefile.")))
  (unless (or (string= dir "") (string= dir "/"))
    (setq project-dir (replace-regexp-in-string
		       "/$"
		       ""
		       dir))
    (setq mkfile (replace-regexp-in-string
		  "\n"
		  ""
		  (shell-command-to-string
		   (format "find %s -maxdepth 1 -name '[m|M]akefile'"
			   project-dir))))
    (when (string= mkfile "")
      (get-makefile-project-dir (file-name-directory project-dir)))
    (format mkfile)))
    
    
  
(defun C-executor-work(config script)
  "C exector,"
  (let ((make-file (get-makefile-project-dir (file-name-directory script))))
    (setq cmd (replace-regexp-in-string
	       "\n"
	       ""
	       (shell-command-to-string
		(format
		 "awk -F':' '/^[a-zA-Z]*[a-zA-Z0-9_]*:{1,1}/{print $1;exit}' %s"
		 make-file))))
    (setq exe cmd)
    (shell-command-to-string (format "cd %s;make" (file-name-directory make-file)))
    (setq bin-path (replace-regexp-in-string
		    "\n"
		    ""
		    (concat (file-name-directory make-file) "/" exe))))
  (list bin-path))

(executor-type-template
 (list
  :mode 'c-mode
  :args ""
  :makefile-pth ""
  :executor-work 'C-executor-work
  :name "c"))



(defun ex-entry-process-sentinel(process event)
  (cond ((eq (process-status process) 'exit)
	 (switch-to-buffer exector-buffer-name)
	 (beginning-of-buffer))))



(defun executor-ex()
  "Excutor entry."
  (interactive)
  (setq mode major-mode)
  (setq script (buffer-file-name (current-buffer)))
  (setq command-list nil)
  (setq executor-config nil)
  (dolist (template executor-type-template-lists)
    (when (equal (plist-get template :mode) mode)
      (setq executor-config template)))
  (when executor-config
    (setq command-list (funcall (plist-get executor-config :executor-work) executor-config script))
    (setq bn (get-buffer exector-buffer-name))
    (when (buffer-live-p bn)
      (setq win (get-buffer-window bn))
      (kill-buffer bn)
      (delete-window win))
    (unless (buffer-live-p bn)
      (executor-ui exector-buffer-name))
    (setq bn (get-buffer exector-buffer-name))
    (when command-list
      (make-process
       :name "execut programmer"
       :connection-type 'pipe
       :coding 'no-conversion
       :command command-list
       :sentinel 'ex-entry-process-sentinel
       :buffer bn
;;       :stderr bn
;;       :stdout bn
       ))))
  
(define-key global-map (kbd "C-x xx") 'executor-ex)
