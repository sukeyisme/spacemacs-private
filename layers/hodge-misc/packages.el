(setq hodge-misc-packages
      '(
        figlet
        make-it-so
        mu4e
        helm-github-stars
        wttrin
        ;; (url :location built-in)
        ))
;;解决url有中文报错
;; (defun hodge-misc/post-init-url()
;;   :init
;;   (progn
;;   (advice-add 'url-http-create-request :override
;;               'url-http-create-request-debug)
;;   (defun url-http-create-request-debug (&optional ref-url)
;;     "Create an HTTP request for `url-http-target-url', referred to by REF-URL."
;;     (let* ((extra-headers)
;;            (request nil)
;;            (no-cache (cdr-safe (assoc "Pragma" url-http-extra-headers)))
;;            (using-proxy url-http-proxy)
;;            (proxy-auth (if (or (cdr-safe (assoc "Proxy-Authorization"
;;                                                 url-http-extra-headers))
;;                                (not using-proxy))
;;                            nil
;;                          (let ((url-basic-auth-storage
;;                                 'url-http-proxy-basic-auth-storage))
;;                            (url-get-authentication url-http-proxy nil 'any nil))))
;;            (real-fname (url-filename url-http-target-url))
;;            (host (url-http--encode-string (url-host url-http-target-url)))
;;            (auth (if (cdr-safe (assoc "Authorization" url-http-extra-headers))
;;                      nil
;;                    (url-get-authentication (or
;;                                             (and (boundp 'proxy-info)
;;                                                  proxy-info)
;;                                             url-http-target-url) nil 'any nil))))
;;       (if (equal "" real-fname)
;;           (setq real-fname "/"))
;;       (setq no-cache (and no-cache (string-match "no-cache" no-cache)))
;;       (if auth
;;           (setq auth (concat "Authorization: " auth "\r\n")))
;;       (if proxy-auth
;;           (setq proxy-auth (concat "Proxy-Authorization: " proxy-auth "\r\n")))

;;       ;; Protection against stupid values in the referrer
;;       (if (and ref-url (stringp ref-url) (or (string= ref-url "file:nil")
;;                                              (string= ref-url "")))
;;           (setq ref-url nil))

;;       ;; We do not want to expose the referrer if the user is paranoid.
;;       (if (or (memq url-privacy-level '(low high paranoid))
;;               (and (listp url-privacy-level)
;;                    (memq 'lastloc url-privacy-level)))
;;           (setq ref-url nil))

;;       ;; url-http-extra-headers contains an assoc-list of
;;       ;; header/value pairs that we need to put into the request.
;;       (setq extra-headers (mapconcat
;;                            (lambda (x)
;;                              (concat (car x) ": " (cdr x)))
;;                            url-http-extra-headers "\r\n"))
;;       (if (not (equal extra-headers ""))
;;           (setq extra-headers (concat extra-headers "\r\n")))

;;       ;; This was done with a call to `format'.  Concatenating parts has
;;       ;; the advantage of keeping the parts of each header together and
;;       ;; allows us to elide null lines directly, at the cost of making
;;       ;; the layout less clear.
;;       (setq request
;;             (concat
;;              ;; The request
;;              (or url-http-method "GET") " "
;;              (url-http--encode-string
;;               (if using-proxy (url-recreate-url url-http-target-url) real-fname))
;;              " HTTP/" url-http-version "\r\n"
;;              ;; Version of MIME we speak
;;              "MIME-Version: 1.0\r\n"
;;              ;; (maybe) Try to keep the connection open
;;              "Connection: " (if (or using-proxy
;;                                     (not url-http-attempt-keepalives))
;;                                 "close" "keep-alive") "\r\n"
;;                                 ;; HTTP extensions we support
;;                                 (if url-extensions-header
;;                                     (format
;;                                      "Extension: %s\r\n" url-extensions-header))
;;                                 ;; Who we want to talk to
;;                                 (if (/= (url-port url-http-target-url)
;;                                         (url-scheme-get-property
;;                                          (url-type url-http-target-url) 'default-port))
;;                                     (format
;;                                      "Host: %s:%d\r\n" host (url-port url-http-target-url))
;;                                   (format "Host: %s\r\n" host))
;;                                 ;; Who its from
;;                                 (if url-personal-mail-address
;;                                     (concat
;;                                      "From: " url-personal-mail-address "\r\n"))
;;                                 ;; Encodings we understand
;;                                 (if (or url-mime-encoding-string
;;                                         ;; MS-Windows loads zlib dynamically, so recheck
;;                                         ;; in case they made it available since
;;                                         ;; initialization in url-vars.el.
;;                                         (and (eq 'system-type 'windows-nt)
;;                                              (fboundp 'zlib-available-p)
;;                                              (zlib-available-p)
;;                                              (setq url-mime-encoding-string "gzip")))
;;                                     (concat
;;                                      "Accept-encoding: " url-mime-encoding-string "\r\n"))
;;                                 (if url-mime-charset-string
;;                                     (concat
;;                                      "Accept-charset: "
;;                                      (url-http--encode-string url-mime-charset-string)
;;                                      "\r\n"))
;;                                 ;; Languages we understand
;;                                 (if url-mime-language-string
;;                                     (concat
;;                                      "Accept-language: " url-mime-language-string "\r\n"))
;;                                 ;; Types we understand
;;                                 "Accept: " (or url-mime-accept-string "*/*") "\r\n"
;;                                 ;; User agent
;;                                 (url-http-user-agent-string)
;;                                 ;; Proxy Authorization
;;                                 proxy-auth
;;                                 ;; Authorization
;;                                 auth
;;                                 ;; Cookies
;;                                 (when (url-use-cookies url-http-target-url)
;;                                   (url-http--encode-string
;;                                    (url-cookie-generate-header-lines
;;                                     host real-fname
;;                                     (equal "https" (url-type url-http-target-url)))))
;;                                 ;; If-modified-since
;;                                 (if (and (not no-cache)
;;                                          (member url-http-method '("GET" nil)))
;;                                     (let ((tm (url-is-cached url-http-target-url)))
;;                                       (if tm
;;                                           (concat "If-modified-since: "
;;                                                   (url-get-normalized-date tm) "\r\n"))))
;;                                 ;; Whence we came
;;                                 (if ref-url (concat
;;                                              "Referer: " ref-url "\r\n"))
;;                                 extra-headers
;;                                 ;; Length of data
;;                                 (if url-http-data
;;                                     (concat
;;                                      "Content-length: " (number-to-string
;;                                                          (length url-http-data))
;;                                      "\r\n"))
;;                                 ;; End request
;;                                 "\r\n"
;;                                 ;; Any data
;;                                 url-http-data))
;;       ;; Bug#23750
;;       (setq request (url-http--encode-string request))
;;       (unless (= (string-bytes request)
;;                  (length request))
;;         (error "Multibyte text in HTTP request: %s" request))
;;       (url-http-debug "Request is: \n%s" request)
;;       request))))

(defun hodge-misc/init-wttrin ()
  (use-package wttrin
    :defer t
    :init
    (progn
      (setq wttrin-default-cities '("Beijing" "Shanghai"))
      )))

(defun hodge-misc/init-helm-github-stars()
   (use-package helm-github-stars
     :defer t
     :init
     (progn
       (spacemacs/set-leader-keys "oag" 'helm-github-stars)
       (setq helm-github-stars-username "sukeyisme"))))

(defun hodge-misc/init-make-it-so()
  (use-package make-it-so
    :defer t
    :init
    (progn
      (mis-config-default)
      )))

(defun hodge-misc/init-figlet()
  (use-package figlet
    :defer t
    :init
    (progn
      )))

;;邮件设置
(defun hodge-misc/pre-init-mu4e()
  (spacemacs|use-package-add-hook mu4e
    :post-config (require 'smtpmail-async)
  (progn
  ;; 邮件通知
  (with-eval-after-load 'mu4e-alert
      (mu4e-alert-set-default-style 'notifier))
  (setq
   ;;基本设置
  mu4e-maildir "~/.mail"
  ;; mu4e-refile-folder "/ArMchive"
  mu4e-get-mail-command "mbsync -a"
  mu4e-update-interval 300
  mu4e-compose-signature-auto-include t
  mu4e-view-show-images t
  mu4e-view-prefer-html t
  mu4e-view-show-addresses t
  mail-specify-envelope-from t
  mail-envelope-from 'header
  mail-user-agent      'mu4e-user-agent
  read-mail-command    'mu4e
  gnus-dired-mail-mode 'mu4e-user-agent
  mu4e-headers-skip-duplicates t
  mu4e-use-fancy-chars t
  mu4e-attachment-dir "~/Downloads"
  mu4e-change-filenames-when-moving t
  ;;发邮件设置
  send-mail-function 'async-smtpmail-send-it
  message-send-mail-function 'async-smtpmail-send-it
  mu4e-sent-messages-behavior 'delete
  ;;多账号设置
  mu4e-compose-context-policy 'ask
  mu4e-context-policy 'pick-first

  mu4e-user-mail-address-list
  (delq nil
        (mapcar (lambda (context)
                  (when (mu4e-context-vars context)
                    (cdr (assq 'user-mail-address (mu4e-context-vars context)))))
                mu4e-contexts))))

  ))

;; (defun sukey-tools/init-make-it-so()
;;   (use-package make-it-so
;;     :defer t
;;     :init
;;     (progn
;;       (mis-config-default) 
;;       )))
;; (defun sukey-tools/init-figlet()
;;   (use-package figlet
;;     :defer t
;;     :init
;;     (progn
;;       )))

;; (defun sukey-tools/init-emms()
;;   (use-package emms
;;     :defer t
;;     :init
;;     (progn
;;       (emms-standard)
;;       (setq emms-player-list '(emms-player-mplayer) emms-player-mplayer-command-name "mplayer" emms-player-mplayer-parameters '("-slave"))
;;       (setq emms-repeat-playlist nil emms-source-file-default-directory "/Users/sukey/Music/网易云音乐/" emms-lyrics-dir "/Users/sukey/Music/网易云音乐/" emms-lyrics-coding-system nil emms-playlist-buffer-name "*EMMS*")
;;       (global-set-key (kbd "C-c e g") 'emms-play-directory)
;;       (global-set-key (kbd "C-c e d") 'emms-play-dired)
;;       (global-set-key (kbd "C-c e v") 'emms-playlist-mode-go)
;;       (global-set-key (kbd "C-c e x") 'emms-start)
;;       (global-set-key (kbd "C-c e SPC") 'emms-pause)
;;       (global-set-key (kbd "C-c e s") 'emms-stop)
;;       (global-set-key (kbd "C-c e n") 'emms-next)
;;       (global-set-key (kbd "C-c e p") 'emms-previous)
;;       )))

;; (defun sukey-tools/init-password-store()
;;   (use-package password-store
;;   :defer t
;;   :init
;;   (progn
;;     (setq password-store-password-length 15)

;;     (defun sukey/password-store-get-second-line(entry)
;;       (car (cdr (s-lines (password-store--run-show entry)))))

;;     (defun password-store-url (entry)
;;       (interactive (list (password-store--completing-read)))
;;       (let ((url (sukey/password-store-get-second-line entry)))
;;         (if (or (string-prefix-p "http://" url)
;;                 (string-prefix-p "https://" url))
;;             (browse-url url)
;;           (error "%s" "String does not look like a URL"))))

;;     (defun password-store-timeout ()
;;       (if (getenv "PASSWORD_STORE_CLIP_TIME")
;;           (string-to-number (getenv "PASSWORD_STORE_CLIP_TIME"))
;;         15))

;;     (defun password-store-clear ()
;;       (interactive)
;;       (when password-store-timeout-timer
;;         (cancel-timer password-store-timeout-timer)
;;         (setq password-store-timeout-timer nil))
;;       (when password-store-kill-ring-pointer
;;         (setcar password-store-kill-ring-pointer "")
;;         (setq password-store-kill-ring-pointer nil)
;;         (x-set-selection 'CLIPBOARD nil)
;;         (message "Password cleared.")))
;;     )))

;; (defun sukey-tools/init-wangyi-music-mode()
;;   (use-package wangyi-music-mode
;;   :defer t
;;   ))
