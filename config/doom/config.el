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
(setq doom-font (font-spec :family "CodeNewRoman Nerd Font" :size 16))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
;;(setq doom-theme 'doom-one-light)
(load-theme 'modus-vivendi t)

  ;; (setq modus-themes-vivendi-color-overrides
  ;;       '((bg-main . "#191a1b")
  ;;         )))

;; (setq modus-themes-operandi-color-overrides nil)

(setq all-the-icons-scale-factor 1.1)

(after! doom-modeline
  (doom-modeline-def-modeline 'main
    '(bar matches buffer-info remote-host buffer-position parrot selection-info)
    '(misc-info minor-modes checker input-method buffer-encoding major-mode process vcs "      "))) ; <-- added padding here

(setq fancy-splash-image "~/.config/doom/emacs.png")

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:

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

 (defun toggle-transparency ()
   (interactive)
   (let ((alpha (frame-parameter nil 'alpha)))
     (set-frame-parameter
      nil 'alpha
      (if (eql (cond ((numberp alpha) alpha)
                     ((numberp (cdr alpha)) (cdr alpha))
                     ;; Also handle undocumented (<active> <inactive>) form.
                     ((numberp (cadr alpha)) (cadr alpha)))
               100)
          '(90 . 90) '(100 . 100)))))
 (global-set-key (kbd "C-c t") 'toggle-transparency)
