;; How to Install Package? (if not sure, better check out EmacsWiki)
;;      M-x package-refresh-contents
;;      M-x package-install RET evil

(setq inhibit-startup-screen t)
(setq make-backup-files nil)
(require 'linum)
(global-linum-mode 1)
(menu-bar-mode 0)
(tool-bar-mode 0)
(setq shell-file-name "/bin/zsh")
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)

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

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(global-set-key (kbd "C-M-g") 'keyboard-quit)
(global-set-key (kbd "C-x C-g") 'keyboard-quit)
(global-set-key (kbd "C-x C-M-g") 'keyboard-quit)

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
