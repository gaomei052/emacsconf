(load-file (expand-file-name "tools/dap-tools.el" user-emacs-directory))
;;Global config
(setq package-selected-packages '(lsp-mode
				  yasnippet
				  lsp-treemacs
				  helm-lsp
				  projectile
				  hydra
				  flycheck
				  company
				  avy
				  which-key
				  helm-xref
				  dap-mode
				  json-mode
				  zenburn-theme
				  typescript-mode
				  python-mode
				  go-mode
				  lua-mode
				  lsp-pyright
				  magit
				  ))
(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))
(load-theme 'zenburn t)
(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)
(which-key-mode)


(dap-mode 1)
(dap-ui-mode 1)
(dap-tooltip-mode 1)
(tooltip-mode 1)
(dap-ui-controls-mode 1)

(add-hook 'dap-stopped-hook
	  (lambda (arg) (call-interactively #'dap-hydra)))
				 
(defvar-keymap dap-breakpoint-work-map
  :doc "Dap breakpoint work"
  "C-d" 'dap-debug
  "x" 'dap-disconnect
  "b" 'dap-breakpoint-toggle
  "D" 'dap-breakpoint-delete-all
  "l" 'dap-ui-breakpoints)

(keymap-set dap-mode-map "C-," dap-breakpoint-work-map)

;;The C&C++ config
(add-hook 'prog-mode-hook (lambda()
			    (progn
			      (add-hook 'c-mode-hook #'lsp)
			      (add-hook 'c++-mode-hook #'lsp))))
(require 'dap-lldb)
(require 'dap-cpptools)
(setq dap-lldb-debug-program '("/Users/gaomei/bingo/git/llvm-project/build/bin/lldb-vscode"))
(setq dap-lldb-debugged-program-function 'mkfile-gen-bin)
(dap-register-debug-template "lldb-vscode-make-debug"
			     (list :type "lldb-vscode"
				   :cwd nil
				   :request "launch"
				   :name "lldb-vscode-make-debug"
;;				   :args (get-args)
				   ))


;;The golang config
(setq lsp-gopls-server-path "~/go/bin/gopls")
(setq lsp-go-analyses '((shadow . t)
                        (simplifycompositelit . :json-false)))
(add-hook 'go-mode-hook #'lsp)

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


;;The python config
(use-package lsp-pyright
  :ensure t
  :custom (lsp-pyright-langserver-command "pyright")
  :hook (python-mode . (lambda ()
			 (require 'lsp-pyright)
			 (lsp))))

(setq dap-python-executable "/Users/gaomei/.virtualenvs/common399/bin/python")

(require 'dap-python)
(dap-register-debug-template "Common"
  (list :type "python"
        :args "-i"
        :cwd nil
        :env '(("DEBUG" . "1"))
	:target-module (expand-file-name "~/bingo/python/algorithms/sorts/sort.py")
        :request "launch"
	:debugger  'debugpy
        :name "Common399"))

;;The lua config
(setq lsp-clients-lua-lsp-server-install-dir "/Users/gaomei/.luarocks/bin/lua-lsp")
(add-hook 'lua-mode-hook #'lsp)

;;The perl config
(setenv "PERL5LIB" "/Users/gaomei/perl5/lib/perl5")
(setq lsp-pls-executable "/Users/gaomei/perl5/bin/pls")
(add-hook 'perl-mode-hook #'lsp)

;;The ts&js config
(add-hook 'typescript-mode-hook #'lsp)
(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      create-lockfiles nil) ;; lock files will kill `npm start'
(with-eval-after-load 'lsp-mode
  (require 'dap-chrome)
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (yas-global-mode))

;;Awk config
(setq lsp-awk-executable '("/opt/homebrew/bin/awk"))


