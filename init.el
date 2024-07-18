;; Turn on to debug
;(setq debug-on-error t)

;;
;; .emacs.d path settings
;;

;; Emacs Lisp files downloaded go here

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)

(add-to-list 'load-path "~/.emacs.d/vendor")

;; Customizations go here
(add-to-list 'load-path "~/.emacs.d/customizations")

;;
;; Package management
;;

;; Setup packages before we start modifying them
(load "packages.el")

;;
;; Package configuration
;;

;; Turn on rainbow parens
;;(global-rainbow-delimiters-mode t)

;;
;; Other customizations
;;

;; Fix Mac command key to be meta
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'super
	mac-right-option-modifier nil
	mac-command-modifier 'meta
	mac-right-command-modifier 'meta))

;; Turn on go-autocomplete
(defun auto-complete-for-go ()
(auto-complete-mode 1))
 (add-hook 'go-mode-hook 'auto-complete-for-go)

;; Turn off accidental quit
(global-unset-key "\C-x\C-c")

;; Dont show toolbar
(tool-bar-mode 0)

;; Keep autosaves and backups in my .emacs dir
(setq auto-save-file-name-transforms
      `((".*" ,(concat user-emacs-directory "auto-save/") t)))
(setq backup-directory-alist
      `(("." . ,(expand-file-name (concat user-emacs-directory "backups")))))

;; Fix menu crash in OS-X
(define-key global-map [menu-bar file revert-buffer] nil)

;;
;; Helper functions
;;

;; Reset key
(defun my-reset-key (key func)
  (global-unset-key key)
  (global-set-key key func)
)

;; Get PATH from system
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

;;
;; Other non-managed packages in vendor
;;

;;(load "avro-mode")

;; Load and set key-bindings for ascope
;;(load "ascope")

;;(my-reset-key (kbd "C-c a o") 'ascope-init)
;;(my-reset-key (kbd "C-c a g") 'ascope-find-global-definition)
;;(my-reset-key (kbd "C-c a a") 'ascope-find-this-symbol)
;;(my-reset-key (kbd "C-c a s") 'ascope-find-this-text-string)
;;(my-reset-key (kbd "C-c a c") 'ascope-find-functions-calling-this-function)
;;(my-reset-key (kbd "C-c a f") 'ascope-find-called-functions)
;;(my-reset-key (kbd "C-c a i") 'ascope-find-files-including-file)
;;(my-reset-key (kbd "C-c a b") 'ascope-pop-mark)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(manoj-dark))
 '(custom-safe-themes
   '("713f898dd8c881c139b62cf05b7ac476d05735825d49006255c0a31f9a4f46ab" default))
 '(package-selected-packages
   '(tangotango-theme highlight-indentation go-autocomplete go-guru ansible-vault yasnippet rainbow-delimiters magit igrep go-mode exec-path-from-shell auto-complete ansible))
 '(password-cache nil)
 '(safe-local-variable-values '((pyvenv-workon . ciao))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; aws.el mode
(use-package aws-mode
  :bind ;; some functions which make sense to bind to something
  ("C-c a a" . aws)
  ("C-c a l" . aws-set-profile)
  ("C-c a n" . aws-organizations-get-account-name)
  ("C-c a i" . aws-organizations-get-account-id)
  :load-path "~/.emacs.d/vendor/aws.el"
  :custom
  (aws-vault nil) ;; when t use aws-vault cmd to get into aws session
  (aws-output "json") ;; optional: yaml, json, text (default: yaml)
  (aws-organizations-account "root")) ;; profile of organizations account. organizations commands are automatically executed against this account, when specified
