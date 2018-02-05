(spacemacs/set-leader-keys "oh" 'help-for-help)
(define-key evil-visual-state-map (kbd "C-r") 'hodge/evil-quick-replace) ;;有bug 没区分大小写
(global-set-key (kbd "s-d") 'hodge/my-mc-mark-next-like-this) ;;有bug 以后再看看

;;有道
(when (configuration-layer/layer-usedp 'chinese)
  (spacemacs/set-leader-keys
    "oy" 'youdao-dictionary-search-at-point+
    "or" 'youdao-dictionary-play-voice-at-point
    "oR" 'youdao-dictionary-search-and-replace))

;;等ivy完全替换helm的时候再删掉
(spacemacs/set-leader-keys
  "rm"   'helm-all-mark-rings)

;;ivy匹配项与创建项名字有重复的时候直接创建
(define-key ivy-minibuffer-map (kbd "C-<return>") 'ivy-immediate-done)
