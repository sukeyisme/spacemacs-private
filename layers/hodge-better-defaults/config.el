;;Don't ask me when close emacs with process is running
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (flet ((process-list ())) ad-do-it))

;;Don't ask me when kill process buffer
(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))

;;每行120字符
(setq-default fill-column 110)

;;编码识别顺序修改
(prefer-coding-system 'chinese-iso-8bit)
(prefer-coding-system 'utf-8)

;;选中设置
;; (add-hook 'javascript-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
;; (add-hook 'c-mode-common-hook #'(lambda () (modify-syntax-entry ?_ "w")))
;; (add-hook 'c-mode-common-hook #'(lambda () (modify-syntax-entry ?- "w")))
;; (add-hook 'cmake-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

;;让artist-mode在spacemacs下不需要按住shift就能使用
(defun artist-mode-toggle-emacs-state ()
  (if artist-mode
      (evil-emacs-state)
    (evil-exit-emacs-state)))
;; (unless (eq dotspacemacs-editing-style 'emacs)
;;   (add-hook 'artist-mode-hook #'artist-mode-toggle-emacs-state))
