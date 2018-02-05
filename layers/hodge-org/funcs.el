;;------------------------------------------------------------------
;; 粘贴图片到org
;; http://bianle.blog/2016/10/26/emacs-paste-image-from-clipboard/
;;------------------------------------------------------------------
(defun paste-image(image-dir)
  (setq relFilename (format-time-string "%Y%m%d%H%M%S.png" (current-time)) )
  (setq filename (concat image-dir relFilename ))
  (message (concat "/usr/local/bin/pngpaste " filename))
  (call-process-shell-command (concat "/usr/local/bin/pngpaste " filename))
  relFilename
  )

;;本地
(defun paste-local-image()
  ;; "paste image from clipboard to local"
  (interactive)
  (setq fullpath (concat "~/Pictures/emacs/deft/" (paste-image "~/Pictures/emacs/deft/")))
  (insert (concat "[[" fullpath "]]"))
  )

;; 上传七牛云
(defun paste-local-image-upload()
  ;; "paste image from clipboard to local"
  (interactive)
  (setq name (paste-image "~/Pictures/emacs/blog/"))
  (call-process-shell-command (concat "/usr/local/bin/qshell qupload 2 ~/.qiniu.conf"  ))
  (insert (concat "![](http://7xqio8.com1.z0.glb.clouddn.com/" name ")"))
  )

;;文件拖拽
;; (defun drag-image-upload (event)
;;   (interactive "e")
;;   (goto-char (nth 1 (event-start event)))
;;   (x-focus-frame nil)
;;   (let* ((payload (car (last event)))
;;          (type (car payload))
;;          (fname (cadr payload))
;;          (img-regexp "\\(gif\\|png\\|jp[e]?g\\)\\>")
;; 	 (localBaseDir "~/.qiniu/bianle/")
;; 	 (relFilename (concat (format-time-string "%Y/%m/%d/" (current-time)) (nth 0 (last (split-string fname "/"))))))
;;     (cond
;;      ;; insert image link
;;      ((and  (eq 'drag-n-drop (car event))
;;             (eq 'file type)
;;             (string-match img-regexp fname))
;;       (call-process-shell-command (concat "mkdir -p " (concat localBaseDir "$(date +%Y/%m/%d)")) )
;;       (call-process-shell-command (format "cp %s %s" fname (concat localBaseDir "$(date +%Y/%m/%d)" "/") ))
;;       (call-process-shell-command "~/sh/sync.sh")
;;       (insert (format "![](http://7xqio8.com1.z0.glb.clouddn.com/%s)" relFilename))
;;       (beginning-of-line)
;;       (forward-char 2)
;;       ;;(org-display-inline-images t t))
;;       ;; regular drag and drop on file
;;      ((eq 'file type)
;;       (insert (format "[[%s]]\n" fname)))
;;      (t
;;       (error "I am not equipped for dnd on %s" payload))))))
;; (require 'markdown-mode)
;; (define-key markdown-mode-map (kbd "<drag-n-drop>") 'md-dnd-func)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.

;; 插入代码块
;; http://wenshanren.org/?p=327
;; change it to helm
(defun hodge/org-insert-src-block (src-code-type)
  "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
  (interactive
   (let ((src-code-types
          '("emacs-lisp" "python" "C" "sh" "java" "js" "clojure" "C++" "css"
            "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
            "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
            "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
            "scheme" "sqlite")))
     (list (ido-completing-read "Source code type: " src-code-types))))
  (progn
    (newline-and-indent)
    (insert (format "#+BEGIN_SRC %s\n" src-code-type))
    (newline-and-indent)
    (insert "#+END_SRC\n")
    (previous-line 2)
    (org-edit-src-code)))

;; (defun hodge//org-archive-tasks (prefix)
;;   (org-map-entries
;;    (lambda ()
;;      (org-archive-subtree)
;;      (setq org-map-continue-from (outline-previous-heading)))
;;    (format "/%s" prefix) 'file))

;; (defun hodge/org-archive-all-tasks ()
;;   (interactive)
;;   (hodge//org-archive-tasks "DONE")
;;   (hodge//org-archive-tasks "CANCELLED")
;;   (hodge//org-archive-tasks "FIXED")
  ;; )

;;通知函数
(defun hodge//notify (title message)
  (let ((terminal-notifier-command (executable-find "terminal-notifier")))
    (start-process "terminal-notifier"
                   "*terminal-notifier*"
                   terminal-notifier-command
                   "-title" title
                   "-message" message
                   "-activate" "org.gnu.Emacs"
                   "-sender" "org.gnu.Emacs")))

