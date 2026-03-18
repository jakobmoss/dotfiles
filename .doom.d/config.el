;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))

;; --> Font suggestion by neic
(setq doom-font (font-spec :family "BlexMono Nerd Font Mono" :size 13)
      doom-variable-pitch-font (font-spec :family "BlexMono Nerd Font" :size 13))
;; The Apple Color Emoji font give slightly to high glyphs causing uneven
;; lineheights. This is especially noticeable in the terminal when programs
;; redraws lines with emoji. We scale it down.
(add-to-list 'face-font-rescale-alist '("Apple Color Emoji" . 0.8))


;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)

;; Automatic switching of light/dark mode
;; --> From https://github.com/doomemacs/doomemacs/issues/6424
;; --> and https://github.com/LionyxML/auto-dark-emacs
;; (use-package! auto-dark
;;   :hook (doom-init-ui . auto-dark-mode)
;;   :config
;;   (setq auto-dark-dark-theme 'doom-one)
;;   (setq auto-dark-light-theme 'doom-one-light))
(use-package! auto-dark
  :defer t
  :init
  ;; Configure themes
  (setq! auto-dark-themes '((doom-one) (doom-one-light)))
  ;; Disable doom's theme loading mechanism (just to make sure)
  (setq! doom-theme nil)
  ;; Faster switching on MacOS
  (setq auto-dark-allow-osascript t)
  ;; Declare that all themes are safe to load.
  ;; Be aware that setting this variable may have security implications if you
  ;; get tricked into loading untrusted themes (via auto-dark-mode or manually).
  ;; See the documentation of custom-safe-themes for details.
  (setq! custom-safe-themes t)
  ;; Enable auto-dark-mode at the right point in time.
  ;; This is inspired by doom-ui.el. Using server-after-make-frame-hook avoids
  ;; issues with an early start of the emacs daemon using systemd, which causes
  ;; problems with the DBus connection that auto-dark mode relies upon.
  (defun my-auto-dark-init-h ()
    (auto-dark-mode)
    (remove-hook 'server-after-make-frame-hook #'my-auto-dark-init-h)
    (remove-hook 'after-init-hook #'my-auto-dark-init-h))
  (let ((hook (if (daemonp)
                  'server-after-make-frame-hook
                'after-init-hook)))
    ;; Depth -95 puts this before doom-init-theme-h, which sounds like a good
    ;; idea, if only for performance reasons.
    (add-hook hook #'my-auto-dark-init-h -95)))


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; ---------------
;; Global settings
;; ---------------

;; Overwrite modifier keys on MacOS
;; --> Consider just swapping to still enable CMD+V for pasting
(setq mac-command-modifier 'meta
      mac-option-modifier 'none)

;; Use lsp on large repos.
(with-eval-after-load 'lsp-mode
  (setq lsp-file-watch-threshold 3500)
  )

;; Smooth scrolling on MacOS
(use-package ultra-scroll
  :if (eq window-system 'mac)
  :init
  (setq scroll-conservatively 101 ; important!
        scroll-margin 0)
  :config
  (ultra-scroll-mode 1))


;; -----
;; Tramp
;; -----

; Disable everything other than git for version control to speedup TRAMP.
;
; https://www.gnu.org/software/emacs/manual/html_node/tramp/Frequently-Asked-Questions.html
; # How to speed up TRAMP?
(setq vc-handled-backends '(Git))

; Reuse the same ssh connection everywhere by inheriting ControlMaster from
; ~/.ssh/config for TRAMP.
;
; https://www.gnu.org/software/emacs/manual/html_node/tramp/Frequently-Asked-Questions.html
; # TRAMP does not use default ssh ControlPath
(setq tramp-use-ssh-controlmaster-options nil)

; Disable file locks. Safe if no other Emacs sessions are modifying the same
; remote file.
;
; https://www.gnu.org/software/emacs/manual/html_node/tramp/Frequently-Asked-Questions.html
; # How to speed up TRAMP?
; https://coredumped.dev/2025/06/18/making-tramp-go-brrrr./#getting-started
(setq remote-file-name-inhibit-locks t)

; Even when chosing external methods (scp, rsync), files smaller than
; tramp-copy-size-limit, use inline methods. The default is 10kB, but
; experiments posted on coredumped.dev show that the cutoff is around 2MB.
;
; https://www.gnu.org/software/tramp/#External-methods-1
; https://coredumped.dev/2025/06/18/making-tramp-go-brrrr./#getting-started
(setq tramp-copy-size-limit (* 1024 1024)) ; 1MB

; Set the default method to rsync. The default method is used when accessing
; files with /-:hostname: . coredumped.dev says rsync is 3-4 times faster than
; the default scp after the initial transfer.
;
; https://coredumped.dev/2025/06/18/making-tramp-go-brrrr./#getting-started
(customize-set-variable 'tramp-default-method "rsync")
