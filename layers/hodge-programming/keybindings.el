;;     "obc"'cmake-ide-compile
;;     "obb"'cmake-ide-run-cmake

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

(spacemacs/set-leader-keys-for-major-mode 'c++-mode
  "cl" 'lice)
