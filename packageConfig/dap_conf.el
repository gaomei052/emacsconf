(load-file (expand-file-name "tools/dap-tools.el" user-emacs-directory))

(defvar-keymap dap-breakpoint-work-map
  :doc "Dap breakpoint work"
  "C-d" 'dap-debug
  "x" 'dap-disconnect
  "b" 'dap-breakpoint-toggle
  "D" 'dap-breakpoint-delete-all
  "l" 'dap-ui-breakpoints)

(use-package dap-mode
  :ensure t
  :init
  (dap-mode 1)
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  (dap-ui-controls-mode 1)
  :hook (dap-stopped . (lambda (arg) (call-interactively #'dap-hydra)))
  :bind-keymap ("C-," . dap-breakpoint-work-map))  



;;C & C++ config
(require 'dap-lldb)
(require 'dap-cpptools)
(setq dap-lldb-debug-program '("/Users/gaomei/bingo/git/llvm-project/build/bin/lldb-vscode"))
(setq dap-lldb-debugged-program-function 'mkfile-gen-bin)
(dap-register-debug-template "lldb-vscode-make-debug"
			     (list :type "lldb-vscode"
				   :cwd nil
				   :request "launch"
				   :name "lldb-vscode-make-debug"
				   ))

;;golnag configure
(require 'dap-dlv-go)
(dap-register-debug-template
 "Go debugger"
 (list :type "go"
       :request "launch"
       :name "Go debugger"
       :mode "auto"
       :program nil
       :buildFlags nil
       :args nil
       :env nil
       :substitutePath (vector (ht ("from" "/home/user/projects/tribonacci") ("to" "github.com/s-kostyaev/tribonacci")))
       ))

;;python configure
(require 'dap-python)
(setq dap-python-executable "/Users/gaomei/.virtualenvs/common399/bin/python")
(dap-register-debug-template "Common"
  (list :type "python"
        :args "-i"
        :cwd nil
        :env '(("DEBUG" . "1"))
	:target-module (expand-file-name "~/bingo/python/algorithms/sorts/sort.py")
        :request "launch"
	:debugger  'debugpy
        :name "Common399"))
