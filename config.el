;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Scott Caprisecca"
      user-mail-address "john@doe.com")

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
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Sync/Notes/org-notes/")
(setq org-archive-location "~/Sync/Notes/org-notes/done-list.org::")
(setq org-default-notes-file "~/Sync/Notes/org-notes/inbox.org")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
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
;;
;; Org Mode Customizations
;;
;; Hide bold, italic, code symbols
(setq org-hide-emphasis-markers t)

;; Enable auto-save and create backup files
(setq auto-save-default t
      make-backup-files t)
;;
;; Adds a timestamp to tasks when marked 'DONE'
(setq org-log-done 'time)

;; Remove quit confirm question
(setq confirm-kill-emacs nil)

;; Org Capture Templates
(after! org
  (setq org-capture-templates
        `(("i" "Inbox"
           entry (file "~/Sync/Notes/org-notes/inbox.org")
           "* %?\n%U\n\n  %i"
           :kill-buffer t)
          ("t" "Todo"
           entry (file "~/Sync/Notes/org-notes/inbox.org")
           "* TODO %?\n%U\n\n  %i"
           :kill-buffer t)
          ("l" "Captain Log Entry"
           entry (file+datetree "~/Sync/Notes/org-notes/captainLog.org")
           "* %?"
           :kill-buffer t)
          ("e" "Add Errand"
           entry (file "~/Sync/Notes/org-notes/errands.org")
           "* %?"
           :kill-buffer t)
          ("m" "Meeting"
           entry (file+headline "~/Sync/Notes/org-notes/inbox.org" "Future")
           ,(concat "* TODO %? :meeting:\n" "<%<%Y-%m-%d %a %H:00>>"))
          ("o" "Open Question Thesis"
           entry (file+headline "~/OneDrive/org-roam/openquestions.org" "Questions")
           "* OPEN %? \n %U\n")))
  (set-face-attribute 'org-headline-done nil :strike-through t)
  )


;; == Custom State Keywords ==
(setq org-use-fast-todo-selection t)
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "PROJ(p)" "|" "DONE(d)")
	(sequence "WAITING(w@/!)" "INACTIVE(i)" "SOMEDAY(s)" "|" "CANCELLED(c@/!)")))

;; Custom colors for the keywords
(setq org-todo-keyword-faces
      '(("TODO" :foreground "red" :weight bold)
	("NEXT" :foreground "blue" :weight bold)
	("PROJ" :foreground "magenta" :weight bold)
	("DONE" :foreground "forest green" :weight bold)
	("WAITING" :foreground "orange" :weight bold)
	("INACTIVE" :foreground "magenta" :weight bold)
	("SOMEDAY" :foreground "cyan" :weight bold)
	("CANCELLED" :foreground "forest green" :weight bold)))

;; Set Tags
(after! org
  org-tag-alist
  '(("home" . ?h)
    ("office" . ?o)
    ("backyard" . ?b)
    ("idea" . ?i)
    ("errand" . ?e)
    ("homedepot" . ?d)
    ("walmart" . ?w)
    ("amazon" . ?a)))

;; Org Agenda Deadline Warning
;;(setq org-deadline-warning-days 1)
;; Org Agendas
(setq org-agenda-start-with-log-mode t)

(setq org-agenda-custom-commands
      '(("p" "Planning"
         ((tags-todo "+@planning"
                     ((org-agenda-overriding-header "Planning Tasks")))
          (tags-todo "-{.*}"
                     ((org-agenda-overriding-header "Untagged Tasks")))
          (todo ".*" ((org-agenda-files '("~/Notes/Inbox.org"))
                      (org-agenda-overriding-header "Unprocessed Inbox Items")))))

        ("d" "Daily Agenda"
         ((agenda "" ((org-agenda-span 'day)
                      (org-deadline-warning-days 7)))
          (tags-todo "+PRIORITY=\"A\""
                     ((org-agenda-overriding-header "High Priority Tasks")))))

        ("w" "Weekly Review"
         ((agenda ""
                  ((org-agenda-overriding-header "Completed Tasks")
                   (org-agenda-skip-function '(org-agenda-skip-entry-if 'nottodo 'done))
                   (org-agenda-span 'week)))

          (agenda ""
                  ((org-agenda-overriding-header "Unfinished Scheduled Tasks")
                   (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-span 'week)))))))
