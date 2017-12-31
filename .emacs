;; Usage: rm ~/.emacs; ln ~/git/readings/.emacs ~/.emacs

;; How to Install Package? (if not sure, better check out EmacsWiki)
;;      M-x package-refresh-contents
;;      M-x package-install RET evil

(setq user-full-name "TANG ZhiXiong")
(setq user-mail-address "tang.zhi.xiong@qq.com")

(setq inhibit-startup-screen t)
(setq make-backup-files nil)
(require 'linum)
(global-linum-mode 1)
(menu-bar-mode 0)
(tool-bar-mode 0)
(setq shell-file-name "/bin/zsh")
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)
(setq column-number-mode t)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; insert filename easily (Vim: c-[x f])
(defun insert-file-name (filename &optional args)
  "Insert name of file FILENAME into buffer after point.

  Prefixed with \\[universal-argument], expand the file name to
  its fully canocalized path.  See `expand-file-name'.

  Prefixed with \\[negative-argument], use relative path to file
  name from current directory, `default-directory'.  See
  `file-relative-name'.

  The default with no prefix is to insert the file name exactly as
  it appears in the minibuffer prompt."
  ;; Based on insert-file in Emacs -- ashawley 20080926
  (interactive `(,(ido-read-file-name "File Name: ")
                 ,current-prefix-arg))
  (cond ((eq '- args)
         (insert (expand-file-name filename)))
        ((not (null args))
         (insert filename))
        (t
         (insert (file-relative-name filename)))))
(global-set-key (kbd "M-]") 'insert-file-name)

;; This HAS to come before (require 'org)
(setq org-emphasis-regexp-components
      '("     ('\"{“”"
        "-   .,!?;''“”\")}/\\“”"
        "    \r\n,"
        "."
        1))

(global-set-key (kbd "C-M-g") 'keyboard-quit)
(global-set-key (kbd "C-x C-g") 'keyboard-quit)
(global-set-key (kbd "C-x C-M-g") 'keyboard-quit)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (smex evil)))
 '(safe-local-variable-values (quote ((org-hide-emphasis-markers)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; evil for editing
(require 'evil)
(evil-mode 1)

;; ido
(ido-mode t)
(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t)

;; smex for commanding
(global-set-key (kbd "M-x") 'smex)
(defadvice smex (around space-inserts-hyphen activate compile)
        (let ((ido-cannot-complete-command
               `(lambda ()
                  (interactive)
                  (if (string= " " (this-command-keys))
                      (insert ?-)
                    (funcall ,ido-cannot-complete-command)))))
          ad-do-it))

;; org-mode
(setq org-log-done t
      org-todo-keywords '((sequence "TODO" "INPROGRESS" "P1" "P2" "P3" "DONE"))
      org-todo-keyword-faces '(("P1" . (:foreground "lightcoral" :weight bold))
                               ("P2" . (:foreground "gray" :weight bold))
                               ("P3" . (:foreground "lightgray" :weight bold))
                               ("INPROGRESS" . (:foreground "violet" :weight bold))))
(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-show-log t
      org-agenda-todo-ignore-scheduled t
      org-agenda-todo-ignore-deadlines t)
(setq org-agenda-files (list "~/Documents/GoogleDriveSync/personal.org"
                             "~/Documents/GoogleDriveSync/review.org"))
(setq org-src-fontify-natively t
      org-confirm-babel-evaluate nil)
;; change font size: c-x c-+, c-x c-- (then press '+', '-', '0')

(setq org-ditaa-jar-path "~/git/readings/vendor/ditaa0_9.jar")
(setq org-plantuml-jar-path "~/git/readings/vendor/plantuml.1.2017.16.jar")
(require 'ob)
(org-babel-do-load-languages
    'org-babel-load-languages
    '((C . t)
      (ruby . t)
      (ditaa . t)
      (dot . t)
      (emacs-lisp . t)
      (java . t)
      (js . t)
      (perl . t)
      (plantuml . t)
      (python . t)
      (matlab . t)
      (R . t)
      (sh . t)))
(setq org-confirm-babel-evaluate nil)
(add-to-list 'org-src-lang-modes (quote ("plantuml" . fundamental)))

;; <p TAB to expand
(add-to-list 'org-structure-template-alist
             (list "p" (concat ":PROPERTIES:\n"
                               "?\n"
                               ":END:")))

;; capture
(global-set-key (kbd "C-c c ") 'org-capture)
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/git/org/gtd.org" "Tasks")
         "* TODO %?\n %i\n %a")
        ("j" "Journal" entry (file+datetree "~/git/org/journal.org")
         "* %?\nEntered on %U\n %i\n %a")))
