;;; Emacs configuration file
;; Noah L. Rydén
;; rydennoah@gmail.com

;;; Melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;;; Turn off bars
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

;;; Line numbers
(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)

;;; Theme
(use-package spacemacs-theme
  :defer t
  :init (load-theme 'spacemacs-light :no-confirm))

;;; Dired
;; Change the 'c' binding since it's easier than pressing 'C-x C-f' and fulfills the same purpose.
(eval-after-load 'dired
  '(progn
     (define-key dired-mode-map (kbd "c") 'find-file)))

;;; Outline-minor-mode
;; Clean code folding via Outline minor mode.
(add-hook 'prog-mode-hook 'outline-minor-mode)
(add-hook 'text-mode-hook 'outline-minor-mode)

;; Load outline-minor-mode and bind TAB
(eval-after-load 'outline
  '(progn
     ;; Bind TAB to toggle folding
     (define-key outline-minor-mode-map (kbd "TAB") 'outline-toggle-children)
     ;; Optional: Bind S-TAB to unfold
    (define-key outline-minor-mode-map (kbd "<backtab>") 'outline-show-all)))

;; Automatically hide body text when outline-minor-mode is enabled
(add-hook 'outline-minor-mode-hook 'outline-hide-body)

;;; Vertico
(use-package vertico
  :ensure t
  :config
  (setq vertico-cycle t)
  (setq vertico-resize nil)
  (vertico-mode 1))


;;; Marginalia
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))
  
;;; Consult
(use-package consult
  :ensure t
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :bind
  ( :map global-map
    ("M-g M-g" . consult-goto-line)
    ("M-K" . consult-keep-lines) ; M-S-k is similar to M-S-5 (M-%)
    ("M-F" . consult-focus-lines) ; same principle
    ("M-s M-b" . consult-buffer)
    ("M-s M-f" . consult-find)
    ("M-s M-g" . consult-grep)
    ("M-s M-h" . consult-history)
    ("M-s M-i" . consult-imenu)
    ("M-s M-l" . consult-line)
    ("M-s M-m" . consult-mark)
    ("M-s M-y" . consult-yank-pop)
    ("M-s M-s" . consult-outline)
    :map consult-narrow-map
    ("?" . consult-narrow-help)))
  

;;; Custom set variable
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(consult marginalia vertico spacemacs-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#fbf8ef" :foreground "#655370" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 160 :width normal :foundry "ADBO" :family "FreeSerif")))))
