;; (with-eval-after-load 'org
;;   (spacemacs/set-leader-keys-for-major-mode 'org-mode
;;     "otc" 'org-toggle-checkbox
;;     "oit" 'org-insert-todo-heading
;;     "og" 'org-mac-grab-link
;;     "ois" 'hodge/org-insert-src-block
;;     "oiS" 'hodge/capture-screenshot
;;     "ou" 'hodge/octopress-upimg)
;;   (with-eval-after-load 'org-agenda
;;     (org-defkey org-agenda-mode-map "m" 'org-agenda-month-view)
;;     ;; pomodoro快捷键
;;     (define-key org-agenda-mode-map (kbd "P") 'org-pomodoro)))
(spacemacs/set-leader-keys "oab" 'easy-hugo)
