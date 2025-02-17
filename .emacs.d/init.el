;;; Emacs configuration file
;; Noah L. Rydén
;; rydennoah@gmail.com

;;; Turn off bars
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

;;; Theme
(use-package spacemacs-theme
  :ensure t
  :config (load-theme 'spacemacs-light :no-confirm))

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

;;; Custom set variable
