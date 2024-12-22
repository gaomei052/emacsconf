;;; Minimal setup to load latest `org-mode`.

;; Activate Debuging.

(setq debug-on-error t
      debug-on-signal nil
      debug-on-quit nil)

;; Add latest Org mode to load path.
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/org-9.7.16"))
