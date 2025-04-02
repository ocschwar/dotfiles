(abyss-theme)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(require 'org-re-reveal)
(setq python-shell-interpreter "python3")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(inhibit-startup-screen t)
 '(org-journal-dir "~/Diaries/personal")
 '(package-selected-packages
   '(## abyss-theme company-lean dash haskell-mode helm-lean jedi
	jenkinsfile-mode lean-mode lsp-jedi lsp-mode lsp-ui magit
	magit-section mermaid-mode ob-mermaid ob-rust org org-journal
	ox-epub ox-pandoc ox-reveal ox-typst rust-mode use-package
	yasnippet-lean)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(with-eval-after-load 'package (add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/")))

;;(require 'package)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(package-initialize)
(require 'org-journal)
(require 'ox-reveal)
;;(setq load-path (cons "/Users/omri/Lean/lean4-mode" load-path))

;;(setq lean4-mode-required-packages '(dash f flycheck lsp-mode magit-section s))

;;(require 'package)
;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;(let ((need-to-refresh t))
;  (dolist (p lean4-mode-required-packages)
;    (when (not (package-installed-p p))
;      (when need-to-refresh
;        (package-refresh-contents)
;        (setq need-to-refresh nil))
;      (package-install p))))

;(require 'lean4-mode)
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)                      ; optional
(setq jedi:complete-on-dot t)                 ; optional
(setq jedi:environment-virtualenv "/opt/homebrew/bin/virtualenv")
(setq jedi:server-command (list "python3" jedi:server-script))
(setq org-plantuml-jar-path "/opt/homebrew/Cellar/plantuml/1.2025.2/libexec/plantuml.jar")

;(defun fluence-input ()
; "Add INPUT to a Fluence Pytest file"
; (interactive)
; (insert "allure.step(\": \")
;    mc.holding_write(ip_address=env, port=mr.MduModbus.mdu_port, 
;    name=mr.MduModbus.XXX,
;    value_str=XXX, comment=\"\")
;")
; (message "INput added. Fill stuff in now"))

;(defun fluence-output ()
; "Add INPUT to a Fluence Pytest file"
; (interactive)
; (insert "    xxx = mc.holding_read_internal(ip_address=env, port=mr.MduModbus.;mdu_port,
;         name=mr.MduModbus.xxx)
;")
; (message "Added OUTput. fill in the gaps now"))

(use-package lsp-mode
  :hook
  ((python-mode . lsp)))
(use-package lsp-ui
  :commands lsp-ui-mode)
(require 'package)


(add-to-list 'package-selected-packages 'dash)
(add-to-list 'package-selected-packages 'lsp-mode)
(add-to-list 'package-selected-packages 'magit-section)
					; 
					; 

;;(package-refresh-contents)
;;(package-install-selected-packages 'no-confirm)
(global-set-key (kbd "<f12>") 'org-journal-new-entry)
(add-hook 'rust-mode-hook 'lsp-deferred)

;; -------------------------------------
;; Org mode
;; -------------------------------------
(use-package org-mode
;;  :init
  ;; This allows PlantUML, Graphviz and ditaa diagrams
  :init
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t)
   (mermaid . t)
   (dot . t)
   (plantuml . t))
 )
:hook
(org-babel-after-execute . org-redisplay-inline-images)
)
(setq ob-mermaid-cli-path "/opt/homebrew/bin/mmdc")
		
  ;

 ;; ditaa installed through dpkg on Debian
(setq org-ditaa-jar-path "/opt/homebrew/Cellar/ditaa/0.11.0_1/libexec/ditaa-0.11.0-standalone.jar")
 ;; Do not ask before evaluating a code block
 ;(org-confirm-babel-evaluate nil)
 ;; Fix for including SVGs
 (setq plantuml-default-exec-mode 'executable)
 (setq plantuml-jar-args '("-tpng"))
 (setq plantuml-output-type "png")
 (setq plantuml-java-args (list "-Djava.awt.headless=true" "-jar"))
 (add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))

(setq org-confirm-babel-evaluate nil)
 
