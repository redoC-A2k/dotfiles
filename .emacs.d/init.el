;--------------------------------------------
;;--- |‾‾‾ |\  /|   /\   /‾‾‾  |‾‾‾ ---------
;;--- |--  | \/ |  /--\  ⅼ      \--| --------
;;--- |___ |    | /    \ \___   __/ ---------
;--------------------------------------------


(setq inhibit-startup-message t)

(scroll-bar-mode -1) ; Disable the visible scrollbar
(tool-bar-mode -1) ;Disable the toolbar
(tooltip-mode -1) ; Disable the tooltips
(set-fringe-mode 8) ; Give some breathing room
(menu-bar-mode 1) ; Disable the menu bar
;(global-hl-line-mode t) ;highlights the line on which we are
(auto-fill-mode 1)
;display relative line numbers
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setq display-line-numbers-type 'relative)
;change default tab size
(setq default-tab-width 4)
;; Setup visible bell 
; (setq visible-bell t)
;font settings
(set-face-attribute 'default nil :font "Liberation Mono" :height 100)
;setting path for vala language server
(setq lsp-clients-vala-ls-executable "/usr/bin/vala-language-server")
;automatic parenthesis closing
(electric-pair-mode t)
;enabling tabbar mode by default
(tab-bar-mode 1)
; setting up a backup directory
;; Write backups to ~/.emacs.d/backup/
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying      t  ; Don't de-link hard links
      version-control        t  ; Use version numbers on backups
      delete-old-versions    t  ; Automatically delete excess backups:
      kept-new-versions      20 ; how many of the newest versions to keep
      kept-old-versions      5) ; and how many of the old

;------------------------------;
;----------functions-----------;
;------------------------------;

(defun smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key [(control shift return)] 'smart-open-line-above)

;;;;;;;;;;MELPA SETUP;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;;;;; packages ;;;;
(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package pdf-tools
   :config
   (pdf-tools-install)
   (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
   :custom
   (pdf-annot-activate-created-annotations t "automatically annotate highlights"))

(use-package org-superstar
  :ensure t
  :config (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1))))

(use-package ace-window
  :ensure t
  :init (global-set-key (kbd "M-o") 'ace-window)
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (ace-window-display-mode)
  (custom-set-faces '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0))))))

(use-package ivy
  :ensure t)

(use-package counsel
  :ensure t)

(use-package undo-tree
  :ensure t
  :init
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undodir/")))
  :config
  (global-undo-tree-mode)
  )

(use-package swiper
  :ensure t
  :config
  (progn
    (ivy-mode)
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t)
    ;; enable this if you want `swiper' to use it
    ;; (setq search-default-mode #'char-fold-to-regexp)
    (global-set-key "\C-s" 'swiper)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "<f6>") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
    (global-set-key (kbd "<f1> l") 'counsel-find-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
    ))

(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  ;; Set the title
  (setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")
  (setq dashboard-startup-banner "/home/afshan/.emacs.d/emacs-logo.png")
  
  ;; Content is not centered by default. To center, set
  (setq dashboard-center-content t)
  ;; To disable shortcut "jump" indicators for each section, set
  ;(setq dashboard-show-shortcuts nil)
  ; show contents on home page
  (setq dashboard-items '((recents . 10)
                          (bookmarks . 5)
                          (projects . 5)
                          (agenda . 5)
                          ))
	)

;--------------LSP related------------;

(use-package company
  :ensure t
  :config
  (global-company-mode t)
  (setq company-idle-delay 0)
  :bind("M-SPC" . company-complete))

(use-package company-quickhelp
  :ensure t
  :config
  (company-quickhelp-mode))

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1)
  (setq yas-prompt-functions '(yas-dropdown-prompt))
)

(use-package yasnippet-snippets
  :ensure t)

;----gettign yasnippets to be shown in company popup 
(defun mars/company-backend-with-yas (backends)
      "Add :with company-yasnippet to company BACKENDS.
Taken from https://github.com/syl20bnr/spacemacs/pull/179."
      (if (and (listp backends) (memq 'company-yasnippet backends))
	  backends
	(append (if (consp backends)
		    backends
		  (list backends))
		'(:with company-yasnippet))))

    ;; add yasnippet to all backends
    (setq company-backends
          (mapcar #'mars/company-backend-with-yas company-backends))

 
;---- keybinding change for yasnippet
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)

;; Bind `SPC' to `yas-expand' when snippet expansion available (it
;; will still call `self-insert-command' otherwise).
(define-key yas-minor-mode-map (kbd "SPC") yas-maybe-expand)
;; Bind `C-c y' to `yas-expand' ONLY.
(define-key yas-minor-mode-map (kbd "C-c y") #'yas-expand)

(use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook
  (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
  (prog-mode . lsp)
   ;; if you want which-key integration
  (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
 ; :config
;  (lsp-enable-snippet 1)
)

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)
              ("C-c p" . projectile-command-map)))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config (setq flycheck-check-syntax-automatically '(save) ))

(use-package flycheck-pos-tip
  :ensure t)

(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
)

;; if you are helm user
;(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
;(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
;(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;-------------- LSP-Servers ---------------;
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
			 (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred
(use-package lsp-java
  :ensure t
  :init
  (setq lsp-java-server-install-dir "/home/afshan/eclipse-jdt/")
  :hook
  ('java-mode-hook #'lsp)
  ('java-mode-hook
     '(lambda ()
      (define-key java-mode-map "\C-m" 'newline-and-indent)))
)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(undo-tree yasnippet-snippets yasnippet pdf-tools lsp-java flycheck-pos-tip lsp-pyright dashboard flycheck-pos-top flycheck projectile company-mode ivy org-superstar which-key use-package try org-bullets))
 '(warning-suppress-log-types '((lsp-mode) (lsp-mode)))
 '(warning-suppress-types '((lsp-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))

;------------------------#MY-STUFF#------------------------;
;(setq indo-enable-flex-matching t) ;sets little more flexible pattern matching for buffer
;(setq ido-everywhere t) ; as we want to enable flexible match everywhere
;(ido-mode 1  ) 
;(defalias 'list-

;------------------------#ORG-MODE#----------------------------;
