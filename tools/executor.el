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


(defun executor-ui()
  "Create executor ui."
  (setq current-window-height (window-height))
  (setq height-old (cond ((> current-window-height 30)
  			    (- current-window-height 10))))
  (setq exe-win (split-window-below height-old))
  (setq exe-buf (get-buffer-create "*Executor output*"))
  (with-current-buffer exe-buf
    (executor-mode))
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

(defun awk-executor-work(config script)
  "Awk executor,Output a string list,this list is make-process's command argument."
  (setq result nil)
  (let ((args-mid (plist-get config :args-mid))
	(output-file (plist-get config :output-file))
	(src-file (plist-get config :src-file))
	(exec-path (plist-get config :exec-path)))
    (push exec-path result)
    (when (and (stringp args-mid) (string= args-mid ""))
      (setq args-mid (read-from-minibuffer "Input awk's argument: ")))
    (push args-mid result)
    (push "-f" result)
    (push script result)
    (when (and (stringp src-file) (string= src-file ""))
      (setq src-file (read-file-name "Entry source file name: ")))
    (push src-file result)
    (when (and (stringp output-file) (string= output-file ""))
      (setq output-file (read-from-minibuffer "Entry output file name: ")))
    (push output-file result))
  (reverse (ex-remove-if (lambda(x) (and (stringp x) (string= x ""))) result)))  

(executor-type-template
 (list
  :mode 'awk-mode
  :args-mid ""
  :output-file ""
  :src-file ""
  :executor-work 'awk-executor-work
  :exec-path "/opt/homebrew/bin/awk"
  :name "awk"))


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
    (setq wb (executor-ui))
    (setq command-list (funcall (plist-get executor-config :executor-work) executor-config script))
    (when command-list
      (make-process
       :name "execut programmer"
       :connection-type 'pipe
       :coding 'no-conversion
       :command command-list
       :buffer (window-buffer (car wb))
       :stderr (window-buffer (car wb))
       :stdout (window-buffer (car wb))))))
  
(define-key global-map (kbd "C-x xx") 'executor-ex)
