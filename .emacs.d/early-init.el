;;; early-init.el --- load before init.el

(custom-set-variables
 ;; Disable startup screen
 '(inhibit-startup-screen t)
 '(inhibit-startup-message t)
 '(inhibit-startup-echo-area-message t)

 ;; Disable UI elements
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

(provide 'early-init)
;; early-init.el ends here
