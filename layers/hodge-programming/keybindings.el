;; (spacemacs/set-leader-keys-for-major-mode 'c++-mode
;;      "og." 'rtags-find-symbol-at-point
;;      "og," 'rtags-find-references-at-point
;;     "ogv" 'rtags-find-virtuals-at-point
;;     "ogV" 'rtags-print-enum-value-at-point
;;     "og/" 'rtags-find-all-references-at-point
;;     "ogY" 'rtags-cycle-overlays-on-screen
;;     "og>" 'rtags-find-symbol
;;     "og<" 'rtags-find-references
;;     "og[" 'rtags-location-stack-back
;;     "og]" 'rtags-location-stack-forward
;;     "ogD" 'rtags-diagnostics
;;     "ogG" 'rtags-guess-function-at-point
;;     "ogp" 'rtags-set-current-project
;;     "ogP" 'rtags-print-dependencies
;;     "oge" 'rtags-reparse-file
;;     "ogE" 'rtags-preprocess-file
;;     "ogR" 'rtags-rename-symbol
;;     "ogM" 'rtags-symbol-info
;;     "ogS" 'rtags-display-summary
;;     "ogO" 'rtags-goto-offset
;;     "og;" 'rtags-find-file
;;     "ogF" 'rtags-fixit
;;     "ogL" 'rtags-copy-and-print-current-location
;;     "ogX" 'rtags-fix-fixit-at-point
;;     "ogB" 'rtags-show-rtags-buffer
;;     "ogI" 'rtags-imenu
;;     "ogT" 'rtags-taglist
;;     "ogh" 'rtags-print-class-hierarchy
;;     "ogA" 'rtags-print-source-arguments
;;     "obc"'cmake-ide-compile
;;     "obb"'cmake-ide-run-cmake
;;     "odd" 'realgud:gdb
;;     "odn" 'realgud:cmd-next
;;     "odb" 'realgud:cmd-break
;;     "odB" 'realgud:cmd-clear
;;     "odc" 'realgud:cmd-continue
;;     "odq" 'realgud:cmd-quit
;;     "odp" 'realgud:cmd-eval-dwim
;;     "ods" 'realgud:cmd-step
;;     "odo" 'realgud:cmd-finish
;;     "odr" 'realgud:cmd-restart
;;     "odG" 'realgud-window-src-undisturb-cmd
;;     "odg" 'realgud-window-cmd-undisturb-src
;;     "od<" 'realgud:cmd-newer-frame
;;     "od>" 'realgud:cmd-older-frame
;;     "odu" 'realgud:cmd-until
;;     "odk"  'realgud-short-key-mode)

(spacemacs/set-leader-keys-for-major-mode 'c++-mode
  "oha" 'hs-hide-all
  "osa" 'hs-show-all
  "ohb" 'hs-hide-block
  "osb" 'hs-show-block)

(spacemacs/set-leader-keys-for-major-mode 'lisp-mode
  "oha" 'hs-hide-all
  "osa" 'hs-show-all
  "ohb" 'hs-hide-block
  "osb" 'hs-show-block)


(spacemacs/set-leader-keys-for-major-mode 'c-mode
  "otb" 'sukey/company-toggle-company-irony)
(spacemacs/set-leader-keys-for-major-mode 'c++-mode
  "otb" 'sukey/company-toggle-company-irony)
