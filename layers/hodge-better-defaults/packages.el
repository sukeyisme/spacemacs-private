(setq hodge-better-defaults-packages
      '(
        evil
        dired
        fcitx
        ))
(setq hodge-better-defaults-excluded-packages '())

(defun hodge-better-defaults/post-init-fcitx()
  ;;输入模式为hybrid的时候，加入下行才能开启fcitx
  (setq fcitx-active-evil-states '(insert emacs hybrid))
  (fcitx-aggressive-setup)
  )

(defun hodge-better-defaults/post-init-evil()
  (progn
    (define-key evil-visual-state-map "p" 'evil-paste-after-from-0)
    ))

(defun hodge-better-defaults/post-init-dired()
  (progn
    (fset 'yes-or-no-p 'y-or-n-p)
    (setq dired-recursive-deletes 'always)
    (setq dired-recursive-copies 'always)
    ;;使用单位(k,m,g)显示文件大小
    (setq dired-listing-switches "-alh"))
  )
