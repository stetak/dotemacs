;; Package repos
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Initialize package management
(package-initialize)

;; Download ELPA archive desc
(when (not package-archive-contents)
  (package-refresh-contents))

;; My packages
(defvar my-packages
  '(
    ;; git integration
    magit

    ;; colorful parenthesis matching
    rainbow-delimiters

    ;; go-mode
    go-mode
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

;; Package customizations

;; go-mode
(add-hook 'go-mode-hook
	  (lambda()
;;	    (add-hook 'before-save-hook 'gofmt-before-save)
	    (setq tab-width 4)
	    (setq indent-tabs-mode 1)))
