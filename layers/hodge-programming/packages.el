(setq hodge-programming-packages
      '(
        magit
        ;; company
        ;; ( guess-style :location (recipe :fetcher github :repo "nschum/guess-style"))
        lice;;开源授权协议
        (doxymacs :location site)
        ))

(setq hodge-programming-excluded-packages '())

(defun hodge-programming/post-init-magit ()
  (progn
    (setq magit-process-popup-time 10)))

(defun hodge-programming/init-lice()
  (use-package lice
  :defer t))



(defun hodge-programming/init-doxymacs()
  (use-package doxymacs
    :init
    (add-hook 'c-mode-common-hook 'doxymacs-mode)
    (add-hook 'c++-mode-common-hook 'doxymacs-mode)
    (custom-set-variables '(doxymacs-doxygen-style "C++"))
    :config
    (progn
      (defconst doxymacs-C++-file-comment-template
        '("/*!" > n
          "* " (doxymacs-doxygen-command-char) "file   "
          (if (buffer-file-name)
              (file-name-nondirectory (buffer-file-name))
            "") > n
          "* " (doxymacs-doxygen-command-char) "author " (user-full-name)
          (doxymacs-user-mail-address)
          > n
          "* " (doxymacs-doxygen-command-char) "date   " (current-time-string) > n
          "* " (doxymacs-doxygen-command-char) "update   " (current-time-string) > n
          "* " > n
          "* " (doxymacs-doxygen-command-char) "brief  " (p "Brief description of this file: ") > n
          "* " > n
          "* " p > n
          "* Copyright (c) 2016 " (user-full-name) > n
          "*/" > n)
        )
      (defun my-doxymacs-font-lock-hook ()
        (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
            (doxymacs-font-lock)))
      (add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)
      (add-hook 'before-save-hook 'spacemacs/c-c++-doxymacs-update-last-modified)
      (dolist (mode c-c++-modes)
      (spacemacs/declare-prefix-for-mode mode "mc" "compile/comments"))
      (spacemacs|hide-lighter doxymacs-mode)
      (dolist (mode c-c++-modes)
        (spacemacs/set-leader-keys-for-major-mode mode
          "cf" 'doxymacs-insert-function-comment
          "cm" 'doxymacs-insert-member-comment
          "cF" 'doxymacs-insert-file-comment)))))

;; (defun hodge-programming/init-guess-style()
;;   (autoload 'guess-style-set-variable "guess-style" nil t)
;;   (autoload 'guess-style-guess-variable "guess-style")
;;   (autoload 'guess-style-guess-all "guess-style" nil t)
;;   )

;; (defun sukey-programming/init-flycheck-irony()
;;   (use-package flycheck-irony
;;     :defer t
;;     :init
;;     (with-eval-after-load 'flycheck
;;     (add-hook 'flycheck-mode-hook 'flycheck-irony-setup))))


;; (defun sukey-programming/init-dumb-jump ()
;;   (use-package dumb-jump
;;     :defer t
;;     :init
;;     (progn
;;       (add-hook 'c-mode-common-hook 'dumb-jump-mode)
;;       (spacemacs/set-leader-keys-for-major-mode 'c++-mode
;;         "gb" 'dumb-jump-back
;;         "gg" 'dumb-jump-go
;;         "gq" 'dumb-jump-quick-look))))

;; (defun sukey-programming/post-init-yasnippet()
;;   :init
;;   (progn
;;   (setq my-snippet-dir (expand-file-name "~/.spacemacs.d/snippets"))
;;   (setq yas-snippet-dirs  my-snippet-dir))
;;   )

;; (defun sukey-programming/init-protobuf-mode()
;;   (use-package protobuf-mode
;;     :defer t))

;; (defun sukey-programming/init-realgud()
;;   (use-package realgud
;;     :defer t))


;; (defun sukey-programming/init-auto-complete-clang()
;;   (use-package auto-complete-clang
;;     :defer t))

;; (defun sukey-programming/init-cmake-ide ()
;;   (use-package cmake-ide
;;     :defer t
;;     :init
;;     (with-eval-after-load 'rtags
;;     (cmake-ide-setup))))


;; (defun sukey-programming/init-rtags ()
;;   (use-package rtags
;;     :defer t
;;     :init
;;     (add-hook 'c-mode-common-hook 'rtags-start-process-unless-running)
;;     ;; (push 'company-rtags company-backends-c-mode-common)
;;     ;; (setq company-rtags-begin-after-member-access nil)
;;     (evilified-state-evilify rtags-mode rtags-mode-map
;;       "r" 'rtags-select-and-remove-rtags-buffer) ;;原来和spc冲突了  和evil也冲突了在normal下
;;     ))

;; (when (configuration-layer/layer-usedp 'auto-completion)
;;   (defun sukey-programming/init-company-irony()
;;     (use-package company-irony
;;       :defer t
;;       :init
;;       (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
;;       (with-eval-after-load 'company
;;         (sukey|toggle-company-backends company-irony)
;;         )))
  
;;   (defun sukey-programming/init-company-irony-c-headers()
;;     (use-package company-irony-c-headers
;;       :defer t
;;       :init
;;       (push 'company-irony-c-headers company-backends-c-mode-common)))

;;   (defun sukey-programming/post-init-company()
;;   (setq company-minimum-prefix-length 1
;;         company-idle-delay 0))

;;   (defun sukey-programming/init-irony ()
;;   (use-package irony
;;     :if (configuration-layer/package-usedp 'company)
;;     :defer t
;;     :init
;;     (add-hook 'c++-mode-hook 'irony-mode)
;;     (add-hook 'c-mode-hook 'irony-mode)
;;     (add-hook 'objc-mode-hook 'irony-mode)
;;     (defun my-irony-mode-hook()
;;       (define-key irony-mode-map [remap completion-at-point]
;;         'irony-completion-at-point-async)
;;       (define-key irony-mode-map [remap complete-symbol]
;;         'irony-completion-at-point-async))
;;     (add-hook 'irony-mode-hook 'my-irony-mode-hook)
;;     (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
;;     :config
;;     (spacemacs|diminish irony-mode " ⓘ" " i"))))


;; (defun sukey-programming/init-google-c-style ()
;;   (use-package google-c-style
;;     :defer t
;;     :init
;;     (add-hook 'c-mode-common-hook 'google-set-c-style)
;;     (add-hook 'c-mode-common-hook 'google-make-newline-indent)))

;; (defun sukey-programming/post-init-magit ()
;;   (progn
;;     (setq magit-process-popup-time 10)))

;; (defun sukey-programming/init-flymake-google-cpplint()
;;   (use-package flymake-google-cpplint
;;     :defer t
;;     :init
;;     (custom-set-variables
;;      '(flymake-google-cpplint-command "/usr/local/bin/cpplint"))
;;      (add-hook 'c++-mode-hook 'flymake-google-cpplint-load)))

;; (defun sukey-programming/init-flymake-cursor()
;;   (use-package flymake-cursor
;;     :defer t))

;; (defun sukey-programming/init-gud()
;;   (use-package gud
;;     :defer t))


