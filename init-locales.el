;;; init-locales.el --- Configure default locale -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(defun sanityinc/utf8-locale-p (v)
  "Return whether locale string V relates to a UTF-8 locale."
  (and v (string-match "UTF-8" v)))

(defun sanityinc/locale-is-utf8-p ()
  "Return t iff the \"locale\" command or environment variables prefer UTF-8."
  (or (sanityinc/utf8-locale-p (and (executable-find "locale") (shell-command-to-string "locale")))
      (sanityinc/utf8-locale-p (getenv "LC_ALL"))
      (sanityinc/utf8-locale-p (getenv "LC_CTYPE"))
      (sanityinc/utf8-locale-p (getenv "LANG"))))

(when (or window-system (sanityinc/locale-is-utf8-p))
  (set-language-environment 'utf-8)
  (setq locale-coding-system 'utf-8)
  (set-selection-coding-system (if (eq system-type 'windows-nt) 'utf-16-le 'utf-8))
  (prefer-coding-system 'utf-8))


(global-linum-mode t)

(defun delete-current-line ()
  "Delete the whole line,not kill"
  (interactive)
  (forward-line 0)
  (delete-char (- (line-end-position) (point)))
  (delete-blank-lines ))

(global-set-key (kbd "M-<RET>") 'sanityinc/newline-at-end-of-line)

(recentf-mode t)
(cua-mode t)
(cua-selection-mode t)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
(global-set-key (kbd "C-u") 'delete-current-line)

(provide 'init-locales)
;;; init-locales.el ends here
