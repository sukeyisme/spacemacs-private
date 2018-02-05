(spacemacs/set-leader-keys
  "oO" 'occur
  "oo" 'occur-dwim
  "os" 'helm-swoop
  "ofF" 'figlet
  "off" 'figlet-comment
  "ofR" 'figlet-figletify-region
  "ofr" 'figlet-figletify-region-comment
  "oaw" 'wttrin)

(global-set-key (kbd "C-c o s") 'company-ispell)

;;让occur buffer 支持上下左右键
(add-hook 'occur-mode-hook
          (lambda ()
            (evil-add-hjkl-bindings occur-mode-map 'emacs
              (kbd "/")       'evil-search-forward
              (kbd "n")       'evil-search-next
              (kbd "N")       'evil-search-previous
              (kbd "C-d")     'evil-scroll-down
              (kbd "C-u")     'evil-scroll-up
              )))
