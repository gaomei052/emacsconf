;; 完整的 PDF 工具配置
(use-package pdf-tools
  :ensure t
  :magic ("%PDF" . pdf-view-mode)
  :init
  (setq pdf-info-epdfinfo-program "/Users/gaomei/.emacs.d/elpa30.0.93/pdf-tools-20240429.407/epdfinfo")
  :config
  (pdf-tools-install t) ; 自动安装依赖
  
  ;; 显示设置
  (setq pdf-view-use-scaling t)
  (setq pdf-view-use-imagemagick nil)
  (setq pdf-view-display-size 'fit-width)
  (setq pdf-view-continuous nil)
  
  ;; 主题适配
  (setq pdf-view-midnight-colors '("#ededed" . "#414141"))
  
  ;; 快捷键配置
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
  (define-key pdf-view-mode-map (kbd "C-r") 'isearch-backward)
  (define-key pdf-view-mode-map (kbd "M-s") 'pdf-view-previous-page)
  (define-key pdf-view-mode-map (kbd "M-n") 'pdf-view-next-page)
  (define-key pdf-view-mode-map (kbd "g") 'pdf-view-first-page)
  (define-key pdf-view-mode-map (kbd "G") 'pdf-view-last-page)
  
  ;; 夜间模式
  
  (define-key pdf-view-mode-map (kbd "C-c C-m") 'pdf-view-midnight-minor-mode)
  
  ;; 自动启用
  (add-hook 'pdf-view-mode-hook 
            (lambda ()
              (display-line-numbers-mode -1)
              (hl-line-mode -1)
              (auto-revert-mode 1)))
  ;; 默认夜间模式
  (add-hook 'pdf-view-mode-hook #'pdf-view-midnight-minor-mode)
  )

;; 标注系统
(use-package pdf-annot
  :after pdf-tools
  :config
  (setq pdf-annot-default-annotation-properties
        '((highlight :color "yellow" :opacity 0.3)
          (underline :color "green" :opacity 0.3)
          (squiggly :color "red" :opacity 0.3)
          (strike-out :color "gray" :opacity 0.3)))
  
  (define-key pdf-view-mode-map (kbd "C-c h") 'pdf-annot-add-highlight-markup-annotation)
  (define-key pdf-view-mode-map (kbd "C-c u") 'pdf-annot-add-underline-markup-annotation)
  (define-key pdf-view-mode-map (kbd "C-c s") 'pdf-annot-add-squiggly-markup-annotation)
  (define-key pdf-view-mode-map (kbd "C-c d") 'pdf-annot-delete-annotation))

;; 与 LaTeX 同步
(use-package pdf-sync
  :after (pdf-tools)
  :config
  (setq pdf-sync-backward-search-method 'synctex)
  (add-hook 'TeX-after-compilation-finished-functions
            #'TeX-revert-document-buffer))

;; 缩略图支持
(use-package pdf-history
  :after pdf-tools
  :config
  (setq pdf-history-enabled t))

;; 自动恢复上次阅读位置
(setq pdf-view-restore-filename 
      (expand-file-name "pdf-view-restore" user-emacs-directory))

(use-package company-auctex
  :ensure t)

;; LaTeX 编辑环境完整配置
(use-package auctex
  :ensure t
  :defer t
  :init
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq TeX-PDF-mode t)
  (setq TeX-source-correlate-mode t)
  (setq TeX-source-correlate-start-server t)
  (setq TeX-command-list
	`(("latexmk" "latexmk -pdf -pdflatex='xelatex' -silent -use-make %t"
	   TeX-run-TeX nil (latex-mode doctex-mode) :help "Use latexmk complie Latex file")
	  ,@TeX-command-list))
  (setq TeX-view-program-selection '((output-pdf "PDF Tools")))
  (setq TeX-view-program-list 
        '(("PDF Tools" "TeX-pdf-tools-sync-view")))
  (setq TeX-electric-sub-and-superscript t)
  (setq TeX-electric-math (cons "$" "$"))
  (setq TeX-insert-braces t)
  (setq TeX-DVI-via-PDFTeX t)
  (setq TeX-engine 'pdflatex)
  (setq TeX-output-directory "./")
  (setq TeX-aux-directory "./")
  
  :config
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (add-hook 'LaTeX-mode-hook 'company-mode)
  (add-hook 'LaTeX-mode-hook 'flyspell-mode)
  (add-hook 'LaTeX-mode-hook 'visual-line-mode)

  ;; 智能补全
  (use-package company-auctex
    :ensure t
    :config (company-auctex-init))
  
  ;; 语法检查
  (use-package flycheck
    :ensure t
    :config
    (flycheck-define-checker tex-chktex
      "A LaTeX checker using chktex"
      :command ("chktex" "-v0" "-I" source)
      :error-patterns
      ((warning line-start (file-name) ":" line ":" column ":" (message) line-end))
      :modes (latex-mode plain-tex-mode)))

  ;; 数学符号输入
  (use-package latex-pretty-symbols
    :ensure t
    :hook (LaTeX-mode . latex-pretty-symbols-mode))

  
  ;; 代码片段
  (use-package yasnippet
    :ensure t
    :config
    (yas-global-mode 1)
    (use-package yasnippet-snippets :ensure t))

  :bind (:map LaTeX-mode-map
	        ("C-c C-v" . TeX-view)
		("C-c C-c" . TeX-command-master)
		("C-c C-e" . LaTeX-environment)
		("C-c C-s" . LaTeX-section)
		("M-RET" . LaTeX-insert-item)))


;; 保存后自动编译
(add-hook 'LaTeX-mode-hook
	  (lambda()
	    (add-hook 'after-save-hook
		      (lambda()
			(TeX-command "latexmk" 'TeX-master-file)))))

  


