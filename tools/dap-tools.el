(defun mkfile-gen-bin(pdir)
  (interactive "DProject root dir: ")
  ;;(setq project-dir (file-name-directory (expand-file-name file)))
  (setq project-dir (replace-regexp-in-string
		     "/$"
		     ""
		     pdir))
  (setq mkfile (replace-regexp-in-string
  	       "\n"
  	       ""
  	       (shell-command-to-string
  		(format
  		 "find %s -maxdepth 1 -name '[m|M]akefile'"
  		 project-dir))))
  (when (not (null mkfile))
    (setq cmd (shell-command-to-string
  	      (format
  	       "awk -F':' '/^[a-zA-Z]*[a-zA-Z0-9_]*:{1,1}/{print $1;exit}' %s"
  	       mkfile)))
    (setq exe cmd)
    (shell-command-to-string (format "cd %s;make CXXFLAGS=\"-g\"" (file-name-directory mkfile)))
    (setq bin-path (replace-regexp-in-string
     "\n"
     ""
     (concat project-dir "/" exe))))
  (message bin-path))


(defun get-args(args)
  (interactive "sExecute bin args: ")
  (format args))


(defun clear-make-build-file(arg)
  (setq launch-args (plist-get arg :launch-aargs))
  (setq cwd (plist-get launch-args :cwd))
  (when (or (eq major-mode "c-mode") (eq major-mode "c++-mode"))
    (shell-command (format "cd %s;make clean" cwd))))
