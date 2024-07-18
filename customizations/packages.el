;; Package repos
(require 'package)
;;(add-to-list 'package-archives
;;             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("melpaorg" . "https://melpa.org/packages/") t)

;; Pin lsp to stable
(add-to-list 'package-pinned-packages
	     '(lsp-mode . "melpa-stable") t)
(add-to-list 'package-pinned-packages
	     '(lsp-ui . "melpa-stable") t)
(add-to-list 'package-pinned-packages
	     '(lsp-treemacs . "melpa-stable") t)

;; Initialize package management
(package-initialize)

;; Download ELPA archive desc
;;
;; Do this manually every once in a while to make sure package list is up-to-date
(when (not package-archive-contents)
  (package-refresh-contents))

;; My packages
(defvar my-packages
  '(
    ;; git integration
    magit

    ;; colorful parenthesis matching
    ;;rainbow-delimiters

    ;; igrep
    ;; igrep - not sure where this came from, but not in current package lists

    ;; ansible mode and dependencies
    yasnippet
    auto-complete
    ansible

    ;; yaml mode
    yaml-mode

    ;; Language Server Protocol support
    lsp-mode
    ;; lsp-ui - these guys aren't happy compiling
    ;; lsp-treemacs
    flycheck
    company
    
    ;; terraform mode
    company-terraform
    terraform-doc

    ;; Python virtualenv support
    pyvenv
    auto-virtualenv
    ))

;; On OS X, an Emacs instance started from the graphical user
;; interface will have a different environment than a shell in a
;; terminal window, because OS X does not run a shell during the
;; login. Obviously this will lead to unexpected results when
;; calling external utilities like make from Emacs.
;; This library works around this problem by copying important
;; environment variables from the user's shell.
;; https://github.com/purcell/exec-path-from-shell
(if (eq system-type 'darwin)
    (add-to-list 'my-packages 'exec-path-from-shell))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; General helper modes

;; company - COMPlete ANYthing autocomplete
;;(add-hook `after-init-hook `global-company-mode)

;; yaml-mode
(add-hook 'yaml-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)
            (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; hotkey for igrep
(global-unset-key "\C-c\C-f")
(global-set-key "\C-c\C-f" 'igrep-find)

;; Make sure path is set correctly (see above OS X comment)
(if (eq system-type 'darwin)
    (exec-path-from-shell-initialize))

;; addhook for ansible mode
(add-hook 'yaml-mode-hook '(lambda () (ansible 1)))

;; add hooks for terraform-mode ot use lsp
;;(lsp-register-client
;; (make-lsp-client :new-connection (lsp-stdio-connection '("/usr/local/bin/terraform-lsp" "serve"))
;;                  :major-modes '(terraform-mode)
;;                  :server-id 'terraform-lsp))


;; Terraform Mode
(add-hook 'terraform-mode-hook `company-mode)
(add-hook 'terraform-mode-hook `company-terraform-init)



;; Setup python virtual env package
(use-package auto-virtualenv
  :init
  (use-package pyvenv
    :demand t)
  :config
  (add-hook 'python-mode-hook 'auto-virtualenv-set-virtualenv))
  

;; Python LSP
(use-package lsp-mode
  :hook
  ((python-mode . lsp))
  ((js-mode . lsp)))

