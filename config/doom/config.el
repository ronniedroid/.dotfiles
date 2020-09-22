;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "Ronnie Nissan"
      user-mail-address "ronni.n.yousif@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "CodeNewRoman Nerd Font" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-one-light)

(setq fancy-splash-image "~/.config/doom/emacs.png")

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type 'relative)

;; make orgmode keywords colors when exported though latex

(defun org-latex-format-headline-colored-keywords-function
    (todo todo-type priority text tags info)
        (concat
           (cond ((string= todo "TODO")(and todo (format "{\\color{red}\\bfseries\\sffamily %s} " todo)))
   ((string= todo "DONE")(and todo (format "{\\color{blue}\\bfseries\\sffamily %s} " todo)))
   ((string= todo "WAIT")(and todo (format "{\\color{green}\\bfseries\\sffamily %s} " todo))))
            (and priority (format "\\framebox{\\#%c} " priority))
            text
            (and tags
            (format "\\hfill{}\\textsc{%s}"
    (mapconcat (lambda (tag) (org-latex-plain-text tag info))
           tags ":")))))

(setq org-latex-format-headline-function 'org-latex-format-headline-colored-keywords-function)

;; emmet mode

(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;;enable Emmet's css abbreviation.

;; Setting up prettier

(add-hook 'js-mode-hook 'prettier-js-mode)

(setq prettier-js-args '(
  "--trailing-comma" "none"
  "--bracket-spacing" "true"
  "--single-quote" "true"
  "--no-semi" "true"
  "--jsx-single-quote" "true"
  "--jsx-bracket-same-line" "true"
  "--print-width" "100"))

;;svelte mode

(add-to-list 'auto-mode-alist '("\\.svelte\\'" . svelte-mode))
