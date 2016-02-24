;; Turn on to debug
;(setq debug-on-error t)

;; Include my own user load path
(setq load-path  (cons (expand-file-name "~/.emacs.d/lisp/") load-path))

;; I have hit this key too many times
(global-unset-key "\C-x\C-c")

;; I don't want the toolbar
(tool-bar-mode 0)

;; Helper function to unset and set a key
(defun my-reset-key (key func)
  (global-unset-key key)
  (global-set-key key func)
)

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
