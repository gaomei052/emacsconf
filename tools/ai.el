(defvar-local ai-first-display-buffer "*ai display buffer 322348729*")
(defvar-local ai-second-display-buffer "*ai display buffer 987293847*")

(defvar ai-model "deepseek-r1:1.5b")

(cl-defun ai--display-create(&key
			     minibuffer
			     width
			     height
			     position
			     title
			     menu-bar-lines
			     tool-bar-lines
			     tab-bar-lines
			     border-width
			     border-color
			     dis-type
			     internal-border-width
			     internal-border-color
			     cursor-type
			     line-spacing
			     left-fringe
			     right-fringe
			     background
			     decorated
			     header-line-format
			     mode-line-format
			     &allow-other-keys)
  (let* ((position (or position (cons 0 0)))
	 (internal-border-width (or internal-border-width border-width 1))
	 (width (if (and (fixnump width) (numberp width))
		    width
		  (frame-width)))
	 (height (if (numberp height)
		     height
		   (frame-height)))
	 (left-fringe (unless left-fringe
			0))
	 (right-fringe (unless right-fringe
			 0))
	 (parent-frame (selected-frame)))
    (setq-local dis-frame (make-frame `((minibuffer . ,minibuffer)
				(width . ,width)
				(height . ,height)
				(menu-bar-lines . ,menu-bar-lines)
				(tool-bar-lines . ,tool-bar-lines)
				(tab-bar-lines . ,tab-bar-lines)
				(border-width . ,border-width)
				(internal-border-width . ,internal-border-width)
				(cursor-type . ,cursor-type)
				(ai-dis-frame . t)
				(ai-dis-type . ,dis-type)
				(line-spacing . ,line-spacing)
				(left-fringe . ,left-fringe)
				(right-fringe . ,right-fringe)
				(undecorated . ,(not decorated)))))
    (setq-local dis-window (frame-root-window dis-frame))
    (set-frame-parameter dis-frame 'parent-frame parent-frame)
    (when border-color
      (set-face-background 'child-frame-border border-color dis-frame))
    (when background
      (set-face-background 'default background dis-frame))
    (unless header-line-format
      (set-window-parameter dis-window 'header-line-format 'none))
    (unless mode-line-format
      (set-window-parameter dis-window 'mode-line-format 'none))
    (set-frame-position dis-frame (car position) (cdr position))
    dis-frame))

(defun ai-posframe-quit()
  (interactive)
  (let* ((frames (frame-list)))
    (dolist (frame frames)
      (when (frame-parameter frame 'ai-dis-frame)
	(delete-frame frame))))
  (when (buffer-live-p (get-buffer ai-first-display-buffer))
    (kill-buffer ai-first-display-buffer))
  (when (buffer-live-p (get-buffer ai-second-display-buffer))
    (kill-buffer ai-second-display-buffer)))

(defun ai-display-hide()
  (interactive)
  (setq parent-frame nil)
  (dolist (frame (frame-list))
    (when (frame-parameter frame 'ai-dis-frame)
      (make-frame-invisible frame)
      (setq parent-frame (frame-parent frame))))
  (select-frame parent-frame))

(defvar-keymap ai-posframe-keymap
  :doc "AI posframe keymap"
 ;; "q" 'ai-posframe-quit
  "h" 'ai-display-hide)

(define-derived-mode ai-mode fundamental-mode "Ai"
;;  (setq buffer-read-only t)
  (when (boundp 'auto-save-default)
    (set (make-local-variable 'auto-save-default) nil))
  (setq-local backup-inhibited t)
  (read-only-mode 1)
  (display-line-numbers-mode 0)
  (let ((map ai-posframe-keymap))
    (use-local-map (make-composed-keymap map (current-local-map)))))

(cl-defun ai--display()
  (let* ((frame-width (frame-pixel-width))
	 (frame-height (frame-pixel-height))
	 (width 80)
	 (height 55)
	 (position-1 (cons (- (/ frame-width 2) (* width 7) 2) 10))
	 (position-2 (cons (* width 7) 0))
	 (frame-1 (ai--display-create :width width
				      :height height
				      :position position-1
				      :background "#5A5A5A"
				      :dis-type "think"
				      :border-width 1
				      :border-color "#b2b814"))
	 (frame-2 (ai--display-create :width width
				      :height height
				      :position position-2
				      :background "#5A5A5A"
				      :dis-type "main"
				      :border-width 1
				      :border-color "#b2b814"))
	 (bf-1 (get-buffer-create ai-first-display-buffer))
	 (bf-2 (get-buffer-create ai-second-display-buffer)))
    (with-current-buffer bf-1
      (ai-mode))
    (with-current-buffer bf-2
      (ai-mode))
    (select-frame frame-1)
    (switch-to-buffer bf-1)
    (select-frame frame-2)
    (switch-to-buffer bf-2)
    (cons frame-1 frame-2)))

(defun ai-display-show()
  (setq think-buf (get-buffer ai-first-display-buffer))
  (setq main-buf (get-buffer ai-second-display-buffer))
  (setq think-frame nil)
  (setq main-frame nil)
  (dolist (frame (frame-list))
      (when (frame-parameter frame 'ai-dis-frame)
	(when (string= (frame-parameter frame 'ai-dis-type) "think")
	  (setq think-frame frame))
	(when (string= (frame-parameter frame 'ai-dis-type) "main")
	  (setq main-frame frame))))
  (unless (buffer-live-p think-buf)
      (setq think-buf (get-buffer-create ai-first-display-buffer))
      (with-current-buffer think-buf
	(ai-mode)))
  (unless (buffer-live-p main-buf)
      (setq main-buf (get-buffer-create ai-second-display-buffer))
      (with-current-buffer main-buf
	(ai-mode)))
  (when (and (or think-frame main-frame) (not (and think-frame main-frame)))
      (when think-frame
	(delete-frame think-frame)
	(setq think-frame nil))
      (when main-frame
	(delete-frame main-frame)
	(setq think-frame nil)))
  (unless (and think-frame main-frame)
      (setq frames (ai--display))
      (setq think-frame (car frames))
      (setq main-frame (cdr frames)))
  (unless (member think-buf (buffer-list think-frame))
      (select-frame think-frame)
      (switch-to-buffer think-buf))
  (unless (member main-buf (buffer-list main-frame))
      (select-frame main-frame)
      (switch-to-buffer main-frame))
  (make-frame-visible think-frame)
  (make-frame-visible main-frame))

(defun ai-display-message(think main)
  (ai-display-show)
  (let* ((think-buf (get-buffer ai-first-display-buffer))
	 (main-buf (get-buffer ai-second-display-buffer)))
    (with-current-buffer think-buf
      (read-only-mode 0)
      (erase-buffer)
      (insert think)
      (read-only-mode 1))
    (with-current-buffer main-buf
      (read-only-mode 0)
      (erase-buffer)
      (insert main)
      (read-only-mode 1))))

(cl-defun request-deepseek-api-callback(&key data &allow-other-keys)
  (let* ((serialize-data (json-read-from-string data))
	 (choices-data (elt (assoc-default 'choices serialize-data) 0))
	 (text-data (assoc-default 'text choices-data))
	 (message-list (split-string text-data "</think>"))
	 (think-message (replace-regexp-in-string
			 "<think>"
			 ""
			 (car message-list)))
	 (main-message (replace-regexp-in-string
			"^[\n ]*"
			""
			(car (cdr message-list)))))
    (ai-display-message think-message main-message)))

(cl-defun request-deepseek-api(prompt)
  (interactive "s输入关键信息: ")
  (let* ((post-data (list
		     (cons "model" ai-model)
		     (cons "prompt" prompt))))
   (request "http://localhost:8110/v1/completions"
	 :type "POST"
	 :data (json-encode post-data)
	 :headers '(("Content-Type" . "application/json"))
	 :success 'request-deepseek-api-callback))
  (message "over"))

(global-set-key (kbd "M-n") 'request-deepseek-api)
