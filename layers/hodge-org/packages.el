(setq hodge-org-packages
      '(
        ;; org-mac-link
        org
        ;; flymd
        easy-hugo
        osx-browse
        deft))

(setq hodge-org-excluded-packages '())

(defun hodge-org/pre-init-deft()
  (progn
    (setq deft-directory "~/Dropbox/Apps/emacs/notes")
    (setq deft-recursive t)
    (setq deft-use-filter-string-for-filename t)
    (setq deft-extensions '("org" "md" "txt" "text" "markdown"))))

(defun hodge-org/init-osx-browse()
  (use-package osx-browse
    :defer t))

;;hugo 博客
(defun hodge-org/init-easy-hugo()
  (progn
  (setq easy-hugo-basedir "~/Documents/blog/hugo")
  (setq easy-hugo-url "https://sukeyisme.github.io")
  (setq easy-hugo-sshdomain "blogdomain")
  (setq easy-hugo-root "/home/blog/")
  (setq easy-hugo-previewtime "300")
  (setq easy-hugo-default-ext ".org")
  (evilified-state-evilify-map easy-hugo-mode-map
    :eval-after-load easy-hugo
    :mode easy-hugo-mode
    :bindings
    "n" 'easy-hugo-newpost
    "v" 'easy-hugo-view
    "N" 'easy-hugo-no-help
    "<" 'easy-hugo-previous-blog
    ">" 'easy-hugo-next-blog
    "V" 'easy-hugo-view-other-window
    "G" 'easy-hugo-github-deploy
    "H" 'easy-hugo-github-deploy-timer
    )
  (add-hook 'view-mode-hook #'evil-motion-state)
 ))

;; (defun hodge-org/init-flymd()
;;   (use-package flymd
;;     :defer t
;;     :init
;;     (progn
;;       (defun my-flymd-browser-function (url)
;;         (let ((process-environment (browse-url-process-environment)))
;;           (apply 'start-process
;;                  (concat "google-chrome " url) nil
;;                  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
;;                  (list "--allow-file-access-from-files" url))))
;;       (setq flymd-browser-open-function 'my-flymd-browser-function)
;;       )))

;;mac下各种app上打开的文件的链接
;; (defun hodge-org/init-org-mac-link()
;;   (use-package org-mac-link
;;     :init
;;     :defer t
;; ))

(defun hodge-org/post-init-org()
  (with-eval-after-load 'org
    (progn
      ;;TODO可能是错误的
      ;; (autoload 'org-archive-subtree "~/.spacemacs.d/layers/hodge-org/local/org-archive-subtree-hierarchical.el")

      ;;设置 e : EDITED, shown value does not take effect untpriority级别的快捷键
      ;; (spacemacs/set-leader-keys-for-major-mode 'org-mode "," 'org-priority)

      ;;设置habit 每日 每周等等
      (add-to-list 'org-modules 'org-habit)
      (require 'org-habit)

      ;;设置todo状态字段
      (setq org-todo-keywords
            (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
                    (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")
                    (sequencep "NOTE(n)"))))

      ;;设置字段颜色值等 颜色名称可以list-colors-display查看
      (setq org-todo-keyword-faces
            (quote (("TODO" :foreground "red" :weight bold)
                    ("STARTED" :foreground "blue" :weight bold)
                    ("NOTE" :foreground "White" :weight bold)
                    ("DONE" :foreground "Green" :weight bold)
                    ("WAITING" :foreground "orange" :weight bold)
                    ("HOLD" :foreground "magenta" :weight bold)
                    ("CANCELLED" :foreground "Brown" :weight bold))))
      (setq org-tag-alist '( ("daily" . ?d) ("hobbyist" . ?h) ("cefc" . ?c) ("spacemacs" . ?s) ("other" . ?o)))

      ;; (setq org-plantuml-jar-path
      ;;       (expand-file-name "~/.spacemacs.d/layers/hodge-org/plantuml.jar"))
      ;; (setq org-ditaa-jar-path "~/.spacemacs.d/layers/hodge-org/ditaa.jar")

      ;;执行代码片段
      (org-babel-do-load-languages
       'org-babel-load-languages
       '((perl . t)
         (ruby . t)
         (sh . t)
         (js . t)
         (python . t)
         (emacs-lisp . t)
         (plantuml . t)
         (C . t)
         (dot . t)
         (ditaa . t)))

;; org后缀文件自动org mode
      (add-to-list 'auto-mode-alist '("\\.org_archive\\'" . org-mode))

;; org 相关文件存放
      (setq org-agenda-dir "~/Dropbox/Apps/emacs/gtd")
      (setq org-agenda-file-project (expand-file-name "project.org" org-agenda-dir))
      (setq org-agenda-file-task (expand-file-name "task.org" org-agenda-dir))
      (setq org-agenda-file-note (expand-file-name "note.org" org-agenda-dir))
      (setq org-agenda-file-gtd-archive (expand-file-name "gtd.org_archive" org-agenda-dir))
      (setq org-agenda-files `(,org-agenda-file-project ,org-agenda-file-task , org-agenda-file-note))
      (setq org-default-notes-file org-agenda-file-task)
      (setq org-directory org-agenda-dir)
      (setq org-refile-targets '(("task.org" :maxlevel . 1)))

      ;;模板
      (setq org-capture-templates
            '(("a" "Appointment" entry (file  org-gcal-file)
               "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
              ("t" "Task" entry (file+headline org-agenda-file-task "Tasks")
               "* TODO [#B] %?\n  %i\n"
               :empty-lines 1)
              ("n" "Quick Note" entry (file+headline org-agenda-file-note "Quick notes")
               "* NOTE [#C] %?\n  %i\n %U"
               :empty-lines 1)
              ("p" "Project" entry (file+headline org-agenda-file-project "Project")
               "* TODO [#A] %? %^g\n  %i\n %U"
               :empty-lines 1)))
      (setq org-agenda-custom-commands
            '(
              ("w" . "任务安排")
              ("wa" "重要且紧急的任务" tags-todo "+PRIORITY=\"A\"")
              ("wb" "重要且不紧急的任务" tags-todo "-Weekly-Monthly-Daily+PRIORITY=\"B\"")
              ("wc" "不重要且紧急的任务" tags-todo "+PRIORITY=\"C\"")
              ("n" "Quick Note" todo "NOTE")
              ("p" . "项目安排")
              ("c" "Simple agenda view"
               ((agenda "")
                (todo "TODO")))
              ;; ("c" "Columns View" agenda ""
              ;;  ((org-agenda-overriding-columns-format "%SCHEDULED %EFFORT %CLOCKSUM %PRIORITY %50ITEM")
              ;;   (org-agenda-view-columns-initially t)))
              ("W" "Weekly Review"
               ((stuck "")            ;; review stuck projects as designated by org-stuck-projects
                (tags-todo "PROJECT") ;; review all projects (assuming you use todo keywords to designate projects)
                ))))

      ;;番茄时间的通知
      (add-hook 'org-pomodoro-finished-hook
                (lambda ()
                  (hodge//notify "Pomodoro completed!" "Time for a break.")))
      (add-hook 'org-pomodoro-break-finished-hook
                (lambda ()
                  (hodge//notify "Pomodoro Short Break Finished" "Ready for Another?")))
      (add-hook 'org-pomodoro-long-break-finished-hook
                (lambda ()
                  (hodge//notify "Pomodoro Long Break Finished" "Ready for Another?")))
      (add-hook 'org-pomodoro-killed-hook
                (lambda ()
                  (hodge//notify "Pomodoro Killed" "One does not simply kill a pomodoro!")))

      ;;父任务随子任务状态变化
      (defun org-summary-todo (n-done n-not-done)
        "Switch entry to DONE when all subentries are done, to TODO otherwise."
        (let (org-log-done org-log-states)   ; turn off logging
          (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

      (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

      ;;重复任务自动重置
      (setq org-default-properties (cons "RESET_SUBTASKS" org-default-properties))
      (defun org-reset-subtask-state-subtree ()
        "Reset all subtasks in an entry subtree."
        (interactive "*")
        (if (org-before-first-heading-p)
            (error "Not inside a tree")
          (save-excursion
            (save-restriction
              (org-narrow-to-subtree)
              (org-show-subtree)
              (goto-char (point-min))
              (beginning-of-line 2)
              (narrow-to-region (point) (point-max))
              (org-map-entries
               '(when (member (org-get-todo-state) org-done-keywords)
                  (org-todo (car org-todo-keywords))))
              ))))
      (defun org-reset-subtask-state-maybe ()
        "Reset all subtasks in an entry if the `RESET_SUBTASKS' property is set"
        (interactive "*")
        (if (org-entry-get (point) "RESET_SUBTASKS")
            (org-reset-subtask-state-subtree)))
      (defun org-subtask-reset ()
        (when (member org-state org-done-keywords)
          (org-reset-subtask-state-maybe)
          (org-update-statistics-cookies t)))
      (add-hook 'org-after-todo-state-change-hook 'org-subtask-reset)
      )))
