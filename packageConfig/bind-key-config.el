;;; dap-conf.el --- Description -*- lexical-binding: t; -*-


(defvar-keymap dap-breakpoint-work-map
  :doc "Dap breakpoint work"
  "d" 'dap-debug
  "x" 'dap-disconnect
  "b" 'dap-breakpoint-toggle
  "A" 'dap-breakpoint-delete-all
  "D" 'dap-breakpoint-delete
  "l" 'dap-ui-breakpoints)


(global-set-key (kbd "C-,") dap-breakpoint-work-map)



(provide 'bind-key-config)
