(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(load-theme 'spacemacs-light :no-confirm)

(require 'god-mode)
(god-mode)

(define-key god-local-mode-map (kbd "i") #'god-local-mode)
(global-set-key (kbd "<escape>") #'(lambda () (interactive) (god-local-mode 1)))
(define-key god-local-mode-map (kbd ".") #'repeat)
(setq god-exempt-major-modes nil)
(setq god-exempt-predicates nil)

;;(custom-set-faces
;; '(god-mode-lighter ((t (:inherit error)))))

(defun my-god-mode-update-mode-line ()
  (cond
   (god-local-mode
    (set-face-attribute 'mode-line nil
                        :foreground "#604000"
                        :background "#fff29a")
    (set-face-attribute 'mode-line-inactive nil
                        :foreground "#3f3000"
                        :background "#fff3da"))
   (t
    (set-face-attribute 'mode-line nil
			:foreground "#0a0a0a"
			:background "#d7d7d7")
    (set-face-attribute 'mode-line-inactive nil
			:foreground "#404148"
			:background "#efefef"))))

(add-hook 'post-command-hook #'my-god-mode-update-mode-line)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
  '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
  '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

(defun my-render-org-table-at-point ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (if (overlays-at (point))
        ;; this is a rough solution, because there can
        ;; be other overlays at point
        (delete-overlay (car (overlays-at (point))))

      (let* ((element-type (org-element-type (org-element-at-point))))
        (if (and (not (eq element-type 'table))
                 (not (eq element-type 'table-row)))
            (error "not at an org table")

          (while (not (eq 'table (org-element-type (org-element-at-point))))
            (forward-line -1))

          (my-render-org-table (org-element-at-point)))))))

(defun my-render-org-table (table)
  (interactive)
  (let* ((begin (org-element-property :begin table))
         (end (let ((pos (org-element-property :end table)))
                (goto-char pos)
                (beginning-of-line)
                ;; skip possible space after table
                (while (not (looking-at " *[|#]"))
                  (setq pos (point))
                  (forward-line -1))
                pos))
         (tabletxt (buffer-substring-no-properties begin end))
         (img (with-temp-buffer
                (insert tabletxt)
                (mark-whole-buffer)
                (org-latex-convert-region-to-latex)
                (org-preview-latex-fragment)
                (goto-char (point-min))
                (overlay-get  (car (overlays-at (point))) 'display)))
         (overlay (make-overlay begin end)))
    (overlay-put overlay 'display img)
    (forward-line -1)))

(defun my-render-org-tables-in-buffer ()
  (save-excursion
    (org-element-map (org-element-parse-buffer) 'table 'my-render-org-table)))

(global-set-key (kbd "C-c t") 'my-render-org-table-at-point)

;; Below is styling for org-mode
(setq org-hide-emphasis-markers t)

(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(setq org-roam-directory (file-truename "~/Org/Roam"))

(let* ((variable-tuple
        (cond ((x-list-fonts "ETBembo")         '(:font "ETBembo"))
              ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
              ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
              ((x-list-fonts "Verdana")         '(:font "Verdana"))
              ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
              (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
       (base-font-color     (face-foreground 'default nil 'default))
       (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

  (custom-theme-set-faces
   'user
   `(org-level-8 ((t (,@headline ,@variable-tuple))))
   `(org-level-7 ((t (,@headline ,@variable-tuple))))
   `(org-level-6 ((t (,@headline ,@variable-tuple))))
   `(org-level-5 ((t (,@headline ,@variable-tuple))))
   `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
   `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
   `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5))))
   `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.75))))
   `(org-document-title ((t (,@headline ,@variable-tuple :height 2.0 :underline nil))))))

(custom-theme-set-faces
 'user
 '(default ((t (:family "FreeSerif" :height 180))))
 '(variable-pitch ((t (:family "FreeSerif" :height 180))))
 '(fixed-pitch ((t ( :family "Fira Code Retina" :height 160)))))

(add-hook 'org-mode-hook 'variable-pitch-mode)
(add-hook 'org-mode-hook 'visual-line-mode)

(custom-theme-set-faces
 'user
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-code ((t (:inherit (shadow fixed-pitch)))))
 '(org-document-info ((t (:foreground "dark orange"))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
 '(org-link ((t (:foreground "royal blue" :underline t))))
 '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-property-value ((t (:inherit fixed-pitch))) t)
 '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
 '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
 '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(spacemacs-light))
 '(custom-safe-themes
   '("bbb13492a15c3258f29c21d251da1e62f1abb8bbd492386a673dcfab474186af" default))
 '(package-selected-packages '(org-roam god-mode devil spacemacs-theme org-bullets)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "FreeSerif" :height 180))))
 '(fixed-pitch ((t (:family "Fira Code Retina" :height 160))))
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-code ((t (:inherit (shadow fixed-pitch)))))
 '(org-document-info ((t (:foreground "dark orange"))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-document-title ((t (:inherit default :weight bold :foreground "#655370" :font "ETBembo" :height 2.0 :underline nil))))
 '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
 '(org-level-1 ((t (:inherit default :weight bold :foreground "#655370" :font "ETBembo" :height 1.75))))
 '(org-level-2 ((t (:inherit default :weight bold :foreground "#655370" :font "ETBembo" :height 1.5))))
 '(org-level-3 ((t (:inherit default :weight bold :foreground "#655370" :font "ETBembo" :height 1.25))))
 '(org-level-4 ((t (:inherit default :weight bold :foreground "#655370" :font "ETBembo" :height 1.1))))
 '(org-level-5 ((t (:inherit default :weight bold :foreground "#655370" :font "ETBembo"))))
 '(org-level-6 ((t (:inherit default :weight bold :foreground "#655370" :font "ETBembo"))))
 '(org-level-7 ((t (:inherit default :weight bold :foreground "#655370" :font "ETBembo"))))
 '(org-level-8 ((t (:inherit default :weight bold :foreground "#655370" :font "ETBembo"))))
 '(org-link ((t (:foreground "royal blue" :underline t))))
 '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-property-value ((t (:inherit fixed-pitch))))
 '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
 '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
 '(org-verbatim ((t (:inherit (shadow fixed-pitch)))))
 '(variable-pitch ((t (:family "FreeSerif" :height 180)))))
