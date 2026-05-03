;;; Bootstrap straight.el

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setopt straight-use-package-by-default t)

;;; Options

(setopt menu-bar-mode nil
	tool-bar-mode nil
	scroll-bar-mode nil
	display-line-numbers t
	electric-pair-mode t)

(keymap-global-set "M-n" 'scroll-up-line)
  (keymap-global-set "M-p" 'scroll-down-line)

  (defun my/kill-whole-line-backwards (&optional arg)
    "Kill current line and preceding newline.
With prefix ARG, kill that many lines starting from the current line backwards.
If ARG is negative, kill forwards. Also kill the trailing newline.
If ARG is zero, kill current line."
    (interactive "p")
    (kill-whole-line (- arg)))
  (keymap-global-set "C-S-k" 'my/kill-whole-line-backwards)

(setopt backup-directory-alist '(("." . "~/.emacs.d/backup")))

;;; Theme and font

(setopt modus-themes-mixed-fonts t)
(load-theme 'modus-operandi)

(set-face-attribute 'default nil
  		    :family "Aporetic Serif Mono"
  		    :height 140)

(set-face-attribute 'fixed-pitch nil
  		    :family "Aporetic Sans Mono")

(set-face-attribute 'variable-pitch nil
  		    :family "Aporetic Serif")

(defun my/enable-variable-pitch-mode ()
  (unless (derived-mode-p 'mhtml-mode 'nxml-mode 'yaml-mode)
    (variable-pitch-mode t)))

(add-hook 'text-mode-hook #'my/enable-variable-pitch-mode)

;;; Org mode

(setopt org-startup-indented t)
(setopt org-hide-emphasis-markers t)

;;; Magit

(use-package magit)

;;; Exec path from shell

(use-package exec-path-from-shell
  :init
  (when (memq window-system '(pgtk))
    (exec-path-from-shell-initialize)))

(use-package expand-region
  :bind
  ("C-+" . er/expand-region))

(use-package multiple-cursors
  :bind
  (("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)))

(use-package vertico
  :init
  (vertico-mode))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package consult
  :bind
  (("C-c b" . consult-buffer)
   ("C-c g" . consult-grep)))

(recentf-mode t)

(use-package embark
  :bind
  (("C-$" . embark-act)))
(use-package embark-consult)

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(defun my/enable-eglot ()
  (when (derived-mode-p 'c++-ts-mode 'c-ts-mode 'tsx-ts-mode 'typescript-ts-mode 'js-ts-mode)
    (eglot-ensure)))

(defun my/prevent-eglot-completion ()
  (remove-hook 'completion-at-point-functions #'eglot-completion-at-point t))

(add-hook 'prog-mode-hook 'my/enable-eglot)
(add-hook 'eglot-managed-mode-hook 'my/prevent-eglot-completion)

(use-package markdown-mode)

(use-package corfu
  :init
  (global-corfu-mode))

(use-package cape
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev))

(use-package prettier-js
  :hook ((js-ts-mode typescript-ts-mode tsx-ts-mode html-ts-mode css-ts-mode) .
	 prettier-js-mode))

(defun my/format-on-save ()
  (add-hook 'before-save-hook 'prettier-js-prettify nil 'make-it-local))
  
(add-hook 'js-ts-mode 'my/format-on-save)  
(add-hook 'typescript-ts-mode 'my/format-on-save)  
(add-hook 'tsx-ts-mode 'my/format-on-save)  
(add-hook 'html-ts-mode 'my/format-on-save)  
(add-hook 'css-ts-mode 'my/format-on-save)

(setopt js-indent-level 2) ; same as prettier
(setopt css-indent-offset 2)
