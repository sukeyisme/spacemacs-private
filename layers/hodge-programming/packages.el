(setq hodge-programming-packages
      '(
        magit
        company
        ))

(setq hodge-programming-excluded-packages '())

(defun hodge-programming/post-init-magit ()
  (progn
    (setq magit-process-popup-time 10)))

(defun hodge-programming/post-init-company()
  (setq company-minimum-prefix-length 1
        company-idle-delay 0))
