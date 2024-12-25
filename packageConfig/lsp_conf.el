(use-package lsp-mode
  :ensure t
  :config
  (setq lsp-gopls-server-path "~/go/bin/gopls")
  (setq lsp-clients-lua-lsp-server-install-dir "/Users/gaomei/.luarocks/bin/lua-lsp")
  (setenv "PERL5LIB" "/Users/gaomei/perl5/lib/perl5")
  (setq lsp-pls-executable "/Users/gaomei/perl5/bin/pls")
  (setq lsp-awk-executable '("/opt/homebrew/bin/awk-language-server"))
  (setq lsp-go-analyses '((shadow . t)
			  (simplifycompositelit . :json-false)))
  :hook
  (c-mode . #'lsp)
  (c++-mode . #'lsp)
  (go-mode . #'lsp)
  (lua-mode . #'lsp)
  (perl-mode . #'lsp)
  (typescript-mode . #'lsp)
  (awk-mode . #'lsp)
  )

(use-package lsp-pyright
  :ensure t
  :custom (lsp-pyright-langserver-command "pyright")
  :hook (python-mode . (lambda ()
			 (require 'lsp-pyright)
			 (lsp))))

