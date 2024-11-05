(require 'package)

(add-to-list 'package-archives
             '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize)

(set-frame-font 
 (cond
  ((eq system-type 'windows-nt) "Iosevka 18")
  ((eq system-type 'gnu/linux) "Iosevka 20"))
 nil t)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)

(setq display-line-numbers-type 'relative) 
(global-display-line-numbers-mode)
 
(load-theme 'spacemacs-dark t)
(setq ring-bell-function 'ignore)

(ido-mode 1)
(setq inhibtit-startup-screen t)
(setq make-backup-files nil)

;; Auto trigger lsp and lsp-ui for different files:

;; 1. Ruby
(add-to-list 'auto-mode-alist
             '("\\(?:Brewfile\\|Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))
(add-hook 'ruby-mode-hook 'lsp)
(add-hook 'ruby-mode-hook 'lsp-ui-mode)

;; 2. Haskell
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)

;; 3. Docker
(add-to-list 'auto-mode-alist
             '("\\(?:Dockerfile\\)\\'" . dockerfile-mode))

(load "~/.emacs.local/org-config.el")

(use-package fzf
	:defer t
	:config
	(setq
	 fzf/args "-x --print-query --margin=1,0 --no-hscroll"
	 fzf/executable "fzf"
	 fzf/git-grep-args "-i --line-number %s"        
	 fzf/grep-command "rg --no-heading -nH"        
	 fzf/position-bottom t        
	 fzf/window-height 15)  
	:bind  (
					("<f5>" . (lambda (&optional x) (interactive "P") 
                        (if x (fzf-git) (fzf))))))

(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(global-set-key (kbd "C-z")         'undo)
(global-set-key (kbd "M-g M-f")     'goto-line)
(global-set-key (kbd "C-c C-d")     (print "# rubocop:disable "))
(global-set-key (kbd "C-c C-e")     (print "# rubocop:enable "))
(global-set-key (kbd "C-c C-b")     (print "binding.pry"))

(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

(setq-default tab-width 2)
(setq rust-format-on-save t)

(setq initial-scratch-message "
\" Happy coding!
 -- Editing shortcuts:
 C-S-c C-S-c 'mc/edit-lines
 C->         'mc/mark-next-like-this
 C-<         'mc/mark-previous-like-this
 C-c C-<     'mc/mark-all-like-this
 C-          'mc/skip-to-next-like-this
 C-:         'mc/skip-to-previous-like-this
 -- Magit
 C-c m s     'magit-status
 C-c m l     'magit-log

-- Search
M-x find-name-dired

-- Tree
C-c C-t      'neotree-toggle

-- Go to line
M-g M-f      <line-number>

-- Find a file
<f5>         <file-name-interactive>

-- Ruby stuff
C-c C-d      # rubocop:disable
C-c C-e      # rubocop:enable
C-c C-b      binding.pry

 -- Lisp
 C-c) C-j eval-print-last-sexp

 You can write some Emacs Lisp right here:
\"
")

;; Tree sidebar view
(require 'neotree)
;; https://github.com/jaypei/emacs-neotree/blob/dev/README.md#keybindings
(global-set-key (kbd "C-c C-t") 'neotree-toggle)

(setq yas-snippet-dirs '("~/.emacs.snippets"))
(yas-global-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(imp-default-user-filters '((markdown-mode) (html-mode) (web-mode)))
 '(inhibit-startup-screen t)
 '(org-agenda-files '("/home/shannarra/Desktop/impass.org"))
 '(package-selected-packages
	 '(markdown-preview-mode impatient-mode yaml-mode fzf dockerfile-mode docker-compose-mode rust-mode yaml ## yasnippet move-text lsp-haskell haskell-mode magit lsp-ui lsp-mode enh-ruby-mode eglot company-inf-ruby company flymake-ruby neotree multiple-cursors spacemacs-theme)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-document-title ((t (:inherit default :weight bold :foreground "#b2b2b2" :family "Sans Serif" :height 1.6 :underline nil))))
 '(org-level-1 ((t (:inherit default :weight bold :foreground "#b2b2b2" :family "Sans Serif" :height 1.5))))
 '(org-level-2 ((t (:inherit default :weight bold :foreground "#b2b2b2" :family "Sans Serif" :height 1.3))))
 '(org-level-3 ((t (:inherit default :weight bold :foreground "#b2b2b2" :family "Sans Serif" :height 1.2))))
 '(org-level-4 ((t (:inherit default :weight bold :foreground "#b2b2b2" :family "Sans Serif" :height 1.1))))
 '(org-level-5 ((t (:inherit default :weight bold :foreground "#b2b2b2" :family "Sans Serif"))))
 '(org-level-6 ((t (:inherit default :weight bold :foreground "#b2b2b2" :family "Sans Serif"))))
 '(org-level-7 ((t (:inherit default :weight bold :foreground "#b2b2b2" :family "Sans Serif"))))
 '(org-level-8 ((t (:inherit default :weight bold :foreground "#b2b2b2" :family "Sans Serif")))))

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
