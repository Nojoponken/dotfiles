;;; Emacs configuration file
;; Noah L. Rydén
;; rydennoah@gmail.com


;;; Leaf
(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    ;; initialize leaf-keywords.el
    (leaf-keywords-init)))

;; Defaults
(setq leaf-defaults '(:ensure t :require t))


;;; Basic configuration
;;;; Buffer Move
(leaf buffer-move
  :doc "Move buffers around (why do i need a package for this???)."
  :url "https://www.emacswiki.org/emacs/buffer-move.el")

;;;; Dired and C-x C-f
;; Change the 'c' binding since it's easier than pressing 'C-x C-f' and fulfills the same purpose.
(eval-after-load 'dired
  '(progn
     (define-key dired-mode-map (kbd "c") 'find-file)))
(setq vc-follow-symlinks t)

;;;; Outshine
(leaf outshine
  :doc "Replacement for `outline-minor-mode'."
  :url "https://github.com/alphapapa/outshine/"
  :config (add-hook 'emacs-lisp-mode-hook 'outshine-mode)
  :after outorg)  ; Load after `outorg`

;;;;; Outorg
;; Dependency for outshine (in emacs 31)
(leaf outorg
  :doc "Edit code comments in `org-mode'."
  :url "https://github.com/alphapapa/outorg")

;;;; Magit
(leaf magit
  :doc "I'll always use magit though!"
  :url "https://magit.vc"
  :bind ("C-c g" . magit))

;;; Visual configuration
;;;; Unicode
(set-fontset-font t 'symbol (font-spec :name "FreeSerif") nil)
(set-fontset-font t 'symbol (font-spec :name "Symbola") nil 'append)
(set-fontset-font t 'symbol (font-spec :name "FiraCode Nerd Font") nil 'append)
(set-fontset-font t 'manichaean (font-spec :name "Noto Sans Manichaean") nil 'append)
(set-fontset-font t 'vai (font-spec :name "Noto Sans Vai") nil 'append)

;;;; Line numbers
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(global-hl-line-mode t)

;;;; Fixed pitch mode
(leaf fixed-pitch
  :doc "Provides a complement to `varied-pitch-mode' for when the `default' face is varied instead of fixed."
  :url "https://github.com/conao3/leaf.el"
  :vc (:url "https://github.com/cstby/fixed-pitch-mode.git")
  :config (add-hook 'prog-mode-hook 'fixed-pitch-mode))


;;;; Theme
(leaf spacemacs-theme
  :doc "Nice theme from the spacemacs emacs-distribution."
  :url "https://github.com/nashamri/spacemacs-theme"
  :config (load-theme 'spacemacs-light :no-confirm))


;;; Minibuffer
;;;; Vertico
(leaf vertico
  :doc "Make the minibuffer vertical and update results continuesly."
  :url "https://github.com/minad/vertico"
  :config
  (setq vertico-cycle t)
  (setq vertico-resize nil)
  :config (vertico-mode t))


;;;; Marginalia
(leaf marginalia
  :doc "Inline documentation in the minibuffer."
  :url "https://github.com/minad/marginalia"
  :config (marginalia-mode t))

;;;; Consult
(leaf consult
  :doc "Search and navigation functions with previews."
  :url "https://github.com/minad/consult"
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :bind
  ( :global-map
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
    ("M-s M-s" . consult-outline))
  (:consult-narrow-map
    ("?" . consult-narrow-help)))

;;;; Orderless
(leaf orderless
  :doc "Orderless completions in the minibuffer."
  :url "https://github.com/oantolin/orderless"
  :config
  (setq completion-styles '(orderless basic)))

;;; Markdown
;; I mostly put this here since it is apparently a prerequisite for lsp-bridge
(leaf markdown-mode)

;;; Org
(add-hook 'org-mode-hook 'org-indent-mode)
(setq-default prettify-symbols-alist '(("#+TITLE:" . "🙠")
				       ("#+AUTHOR:" . "✍")
				       ("#+OPTIONS:" . "🔧")
				       ("#+EMAIL:" . "📩")
				       ("#+LANGUAGE:" . "")))
(add-hook 'org-mode-hook 'prettify-symbols-mode)

;;;; Bullets
(leaf org-bullets
  :doc "Give `org-mode' headers stylish bulletpoints."
  :url "https://github.com/sabof/org-bullets"
  :config  (add-hook 'org-mode-hook #'org-bullets-mode)
	   (setq org-bullets-bullet-list '("❡" "❧" "🙠" "🙛" "𐫱" "𐫱" "𐫱" "𐫱")))

;;;; Superstar
;; (leaf org-superstar
;;   :doc "Rewrite descendant of `org-bullets'."
;;   :url "https://github.com/integral-dw/org-superstar-mode"
;;   :config (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1))))

;;;; Roam
(leaf org-roam
  :doc "Second brain for `org-mode'."
  :url "https://www.orgroam.com"
  :config
  (setq org-roam-directory (file-truename "~/Org/Roam"))
  (org-roam-db-autosync-mode 1))

;;; LSP
;;;; Yasnippet
(leaf yasnippet
  :doc "Template system."
  :url "https://github.com/joaotavora/yasnippet"
  :hook   ((after-init-hook . yas-reload-all)
           (prog-mode-hook  . yas-minor-mode))
  :custom (yas-snippet-dirs . `(,(expand-file-name "snippets" user-emacs-directory))))

;;;; LSP Bridge
(leaf lsp-bridge
  :doc "Fast multithreaded LSP client."
  :vc (:url "https://github.com/manateelazycat/lsp-bridge")
  :init (global-lsp-bridge-mode)
  :custom
  (acm-enable-tabnine                 . t)
  (acm-enable-copilot                 . nil)
  (acm-enable-quick-access            . t)
  (lsp-bridge-enable-hover-diagnostic . t)
  (acm-backend-yas-candidates-number  . 5))

;;;; Python
(leaf python
  :doc "Python development environment"
  :url "https://wiki.python.org/moin/EmacsPythonMode"
  :mode ("\\.py\\'" . python-mode))

;;;; Elixir
;; To install the elixir-ts-grammar since I had trouble using only treesit
(leaf treesit-auto
  :doc "Automatic ts grammar installations."
  :url "https://github.com/renzmann/treesit-auto"
  :config
  (global-treesit-auto-mode))

;; Treesitter elixir mode
(leaf elixir-ts-mode
  :doc "Elixir development environment."
  :url "https://github.com/wkirschbaum/elixir-ts-mode"
  :mode (("\\.exs\\'" . elixir-ts-mode)
	 ("\\.ex\\'" . elixir-ts-mode)))

;;;; Flutter
;; Assuming usage with dart-mode
(leaf dart-mode
  :doc "Portable UI language."
  :url "https://dart.dev"
  ;; Optional
  :hook (dart-mode . flutter-test-mode))

(leaf flutter
  :doc "GUI app framework."
  :url "https://flutter.dev"
  :after dart-mode)

;;; Custom set variable
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-echo-area-message t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(package-selected-packages nil)
 '(package-vc-selected-packages
   '((fixed-pitch :url "https://github.com/cstby/fixed-pitch-mode.git")))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#fbf8ef" :foreground "#655370" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 160 :width normal :foundry "ADBO" :family "FreeSerif"))))
 '(fixed-pitch ((t (:family "FiraCode Nerd Font")))))
