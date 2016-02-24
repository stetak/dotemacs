;; Turn on to debug
;(setq debug-on-error t)

;;
;; .emacs.d path settings
;;

;; Emacs Lisp files downloaded go here
(add-to-list 'load-path "~/.emacs.d/vendor")

;; Customizations go here
(add-to-list 'load-path "~/.emacs.d/customizations")

;;
;; Package management
;;

;; Setup packages before we start modifying them
(load "packages.el")

;;
;; Other customizations
;;

;; Turn off accidental quit
(global-unset-key "\C-x\C-c")

;; Dont show toolbar
(tool-bar-mode 0)

;;
;; Helper functions
;;
(defun my-reset-key (key func)
  (global-unset-key key)
  (global-set-key key func)
)

;;
;; Other customizations
;;

;; Load and set key-bindings for ascope
(load "ascope")

(my-reset-key (kbd "C-c a o") 'ascope-init)
(my-reset-key (kbd "C-c a g") 'ascope-find-global-definition)
(my-reset-key (kbd "C-c a a") 'ascope-find-this-symbol)
(my-reset-key (kbd "C-c a s") 'ascope-find-this-text-string)
(my-reset-key (kbd "C-c a c") 'ascope-find-functions-calling-this-function)
(my-reset-key (kbd "C-c a f") 'ascope-find-called-functions)
(my-reset-key (kbd "C-c a i") 'ascope-find-files-including-file)
(my-reset-key (kbd "C-c a b") 'ascope-pop-mark)
