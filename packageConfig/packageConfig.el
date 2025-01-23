(require 'package)
(add-to-list 'package-archives '("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") t)
(package-initialize)
(setq package-selected-packages '(lsp-mode
				  yasnippet
				  lsp-treemacs
				  helm-lsp
				  projectile
				  ag
				  hydra
				  flycheck
				  company
				  avy
				  which-key
				  helm-xref
				  dap-mode
				  exec-path-from-shell
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
(exec-path-from-shell-initialize)
(load-file (expand-file-name "packageConfig/projectile_config.el" user-emacs-directory))
(load-file (expand-file-name "packageConfig/dashboard_config.el" user-emacs-directory))
(load-file (expand-file-name "packageConfig/org_conf.el" user-emacs-directory))
(load-file (expand-file-name "packageConfig/lsp_conf.el" user-emacs-directory))
(load-file (expand-file-name "packageConfig/helm_conf.el" user-emacs-directory))
(load-file (expand-file-name "packageConfig/other_conf.el" user-emacs-directory))
(load-file (expand-file-name "packageConfig/dap_conf.el" user-emacs-directory))
