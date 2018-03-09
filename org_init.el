
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(setenv "LANG" "en_US.UTF-8")

(setq inhibit-startup-message t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "<f5>") 'revert-buffer)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq scroll-conservatively 100)
(when window-system (global-hl-line-mode t))
(add-hook 'eshell-mode-hook (lambda ()
                                    (setq-local global-hl-line-mode
                                                nil)))
(add-hook 'term-mode-hook (lambda ()
                                    (setq-local global-hl-line-mode
                                                nil)))
(when window-system (global-prettify-symbols-mode))

(add-to-list 'default-frame-alist '(font . "Source Code Pro for Powerline:pixelsize=15:foundry=ADBO:weight=semi-bold:slant=normal:width=normal:spacing=100:scalable=true"))
(set-face-attribute 'default t :font "Source Code Pro for Powerline:pixelsize=15:foundry=ADBO:weight=semi-bold:slant=normal:width=normal:spacing=100:scalable=true" )

(use-package try
        :ensure t)

(use-package which-key
      :ensure t 
      :config
      (which-key-mode))

(setenv "BROWSER" "chromium-browser")

        (use-package org-bullets
        :ensure t
        :config
        (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

            (custom-set-variables
             '(org-directory "~/Dropbox/orgfiles")
             '(org-default-notes-file (concat org-directory "/notes.org"))
             '(org-export-html-postamble nil)
             '(org-hide-leading-stars t)
             '(org-startup-folded (quote overview))
             '(org-startup-indented t)
             )

            (setq org-file-apps
                (append '(
                          ("\\.pdf\\'" . "evince %s")
                          ) org-file-apps ))

            (global-set-key "\C-ca" 'org-agenda)

            (setq org-agenda-custom-commands
            '(("c" "Simple agenda view"
            ((agenda "")
            (alltodo "")))))

            (use-package org-ac
                  :ensure t
                  :init (progn
                          (require 'org-ac)
                          (org-ac/config-default)
                          ))

            (global-set-key (kbd "C-c c") 'org-capture)

            (setq org-agenda-files (list "~/Dropbox/orgfiles/gcal.org"
                                       "~/Dropbox/orgfiles/i.org"
                                       "~/Dropbox/orgfiles/schedule.org"))
            (setq org-capture-templates
                                  '(("a" "Appointment" entry (file  "~/Dropbox/orgfiles/gcal.org" )
                                           "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
                                          ("l" "Link" entry (file+headline "~/Dropbox/orgfiles/links.org" "Links")
                                           "* %? %^L %^g \n%T" :prepend t)
                                          ("b" "Blog idea" entry (file+headline "~/Dropbox/orgfiles/i.org" "Blog Topics:")
                                           "* %?\n%T" :prepend t)
                                          ("t" "To Do Item" entry (file+headline "~/Dropbox/orgfiles/i.org" "To Do")
                                           "* TODO %?\n%u" :prepend t)
                                          ("m" "Mail To Do" entry (file+headline "~/Dropbox/orgfiles/i.org" "To Do")
                                           "* TODO %a\n %?" :prepend t)
                                          ("g" "GMail To Do" entry (file+headline "~/Dropbox/orgfiles/i.org" "To Do")
                                           "* TODO %^L\n %?" :prepend t)
                                          ("n" "Note" entry (file+headline "~/Dropbox/orgfiles/i.org" "Note space")
                                           "* %?\n%u" :prepend t)
                                          ))
            ;; (setq org-capture-templates
        ;;                  '(("a" "Appointment" entry (file  "~/Dropbox/orgfiles/gcal.org" )
        ;;                           "* TODO %?\n:PROPERTIES:\nDEADLINE: %^T \n\n:END:\n %i\n")
        ;;                          ("l" "Link" entry (file+headline "~/Dropbox/orgfiles/links.org" "Links")
        ;;                           "* %? %^L %^g \n%T" :prepend t)
        ;;                          ("b" "Blog idea" entry (file+headline "~/Dropbox/orgfiles/i.org" "Blog Topics:")
        ;;                           "* %?\n%T" :prepend t)
        ;;                          ("t" "To Do Item" entry (file+headline "~/Dropbox/orgfiles/i.org" "To Do")
        ;;                           "* TODO %?\n%u" :prepend t)
        ;;                          ("n" "Note" entry (file+headline "~/Dropbox/orgfiles/i.org" "Note space")
        ;;                           "* %?\n%u" :prepend t)

        ;;                          ("j" "Journal" entry (file+datetree "~/Dropbox/journal.org")
        ;;                           "* %?\nEntered on %U\n  %i\n  %a")
            ;;                                ("s" "Screencast" entry (file "~/Dropbox/orgfiles/screencastnotes.org")
            ;;                                "* %?\n%i\n")))


        (defadvice org-capture-finalize 
            (after delete-capture-frame activate)  
        "Advise capture-finalize to close the frame"  
        (if (equal "capture" (frame-parameter nil 'name))  
        (delete-frame)))

        (defadvice org-capture-destroy 
            (after delete-capture-frame activate)  
        "Advise capture-destroy to close the frame"  
        (if (equal "capture" (frame-parameter nil 'name))  
        (delete-frame)))  

        (use-package noflet
        :ensure t )
        (defun make-capture-frame ()
        "Create a new frame and run org-capture."
        (interactive)
        (make-frame '((name . "capture")))
        (select-frame-by-name "capture")
        (delete-other-windows)
        (noflet ((switch-to-buffer-other-window (buf) (switch-to-buffer buf)))
            (org-capture)))

(require 'ox-beamer)

(setq org-src-window-setup 'current-window)

(add-to-list 'org-structure-template-alist
             '("el" "#+BEGIN_SRC emacs-lisp\n  ?\n#+END_SRC")
             )

(use-package counsel
:ensure t
  :bind
  (("M-y" . counsel-yank-pop)
   :map ivy-minibuffer-map
   ("M-y" . ivy-next-line)))




  (use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "%d/%d ")
  (setq ivy-display-style 'fancy))


  (use-package swiper
  :ensure t
  :bind (("C-s" . swiper)
         ("C-r" . swiper)
         ("C-c C-r" . ivy-resume)
         ("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    ))

(use-package avy
:ensure t
:bind ("M-s" . avy-goto-word-1)) ;; changed from char as per jcs

(use-package auto-complete
:ensure t
:init
(progn
  (ac-config-default)
  (global-auto-complete-mode t)
  ))
 (add-hook 'c-mode-common-hook '(lambda ()

        ;; ac-omni-completion-sources is made buffer local so
        ;; you need to add it to a mode hook to activate on 
        ;; whatever buffer you want to use it with.  This
        ;; example uses C mode (as you probably surmised).

        ;; auto-complete.el expects ac-omni-completion-sources to be
        ;; a list of cons cells where each cell's car is a regex
        ;; that describes the syntactical bits you want AutoComplete
        ;; to be aware of. The cdr of each cell is the source that will
        ;; supply the completion data.  The following tells autocomplete
        ;; to begin completion when you type in a . or a ->

        (add-to-list 'ac-omni-completion-sources
                     (cons "\\." '(ac-source-semantic)))
        (add-to-list 'ac-omni-completion-sources
                     (cons "->" '(ac-source-semantic)))

        ;; ac-sources was also made buffer local in new versions of
        ;; autocomplete.  In my case, I want AutoComplete to use 
        ;; semantic and yasnippet (order matters, if reversed snippets
        ;; will appear before semantic tag completions).

        (setq ac-sources '(ac-source-semantic ac-source-yasnippet))
))

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq TeX-auto-save t)                  ;自动保存
(setq TeX-parse-self t)                 ;解析
(setq-default TeX-master nil)
(dolist (hook (list
               'LaTeX-mode-hook
               'latex-mode-hook
               ))
  (add-hook hook 'turn-on-reftex))
(add-hook 'LaTeX-mode-hook
      (lambda()
        (local-set-key [C-tab] 'TeX-complete-symbol)))
(use-package auto-complete-auctex
        :ensure t)
(require 'auto-complete-auctex)

(require 'flymake)

(defun flymake-get-tex-args (file-name)
(list "pdflatex"
(list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))

(add-hook 'LaTeX-mode-hook 'flymake-mode)

(setq ispell-program-name "aspell") ; could be ispell as well, depending on your preferences
(setq ispell-dictionary "english") ; this can obviously be set to any language your spell-checking program supports

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)
;(require 'latex-pretty-symbols)
(require 'flymake)

(defun flymake-get-tex-args (file-name)
(list "pdflatex"
(list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))
(add-to-list
    `flymake-err-line-patterns
    '("Runaway argument?" nil nil nil)) ; fixes unbalanced braces in LaTeX files

(add-hook 'LaTeX-mode-hook 'flymake-mode)

(setq ispell-program-name "aspell") ; could be ispell as well, depending on your preferences
(setq ispell-dictionary "english") ; this can obviously be set to any language your spell-checking program supports

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)

(defun turn-on-outline-minor-mode ()
(outline-minor-mode 1))

(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(add-hook 'latex-mode-hook 'turn-on-outline-minor-mode)
(setq outline-minor-mode-prefix "\C-c \C-o") ; Or something else

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

(use-package yasnippet
  :ensure t
  :init
    (yas-global-mode 1))

(use-package latex-preview-pane
        :ensure t)
(latex-preview-pane-enable)
(add-hook 'auctex 'latex-preview-pane-mode)
(add-hook 'latex-mode 'latex-preview-pane-mode)
(add-hook 'AUCTeX 'latex-preview-pane-mode)
(add-hook 'LaTeX-mode-hook ' latex-preview-pane-mode)

(use-package monokai-theme
      :ensure t)

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (setq powerline-default-separator (quote arrow))
  (spaceline-spacemacs-theme))

(use-package diminish
  :ensure t
  :init
  (diminish 'hungry-delete-mode)
  (diminish 'beacon-mode)
  (diminish 'rainbow-mode)
  (diminish 'which-key-mode)
  (diminish 'company-mode)
  (diminish 'undo-tree-mode)
  (diminish 'flycheck-mode)
  (diminish 'yas-minor-mode)
  (diminish 'auto-complete-mode)
  (diminish 'subword-mode)
  )

(line-number-mode 1)
(column-number-mode 1)

(require 'package)
(package-initialize)

;; yasnippet code 'optional', before auto-complete
(require 'yasnippet)
(yas-global-mode 1)

;; auto-complete setup, sequence is important
(require 'auto-complete)
(add-to-list 'ac-modes 'latex-mode) ; beware of using 'LaTeX-mode instead
(use-package ac-math
  :ensure t)
(require 'ac-math) ; package should be installed first 
(defun my-ac-latex-mode () ; add ac-sources for latex
   (setq ac-sources
         (append '(ac-source-math-unicode
           ac-source-math-latex
           ac-source-latex-commands)
                 ac-sources)))
(add-hook 'LaTeX-mode-hook 'my-ac-latex-mode)
(setq ac-math-unicode-in-math-p t)
(ac-flyspell-workaround) ; fixes a known bug of delay due to flyspell (if it is there)
(add-to-list 'ac-modes 'org-mode) ; auto-complete for org-mode (optional)
(require 'auto-complete-config) ; should be after add-to-list 'ac-modes and hooks
(ac-config-default)
(setq ac-auto-start nil)            ; if t starts ac at startup automatically
(setq ac-auto-show-menu t)
(global-auto-complete-mode t) 

(require 'ac-math) ; This is not needed when you install from MELPA

(add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of `latex-mode`

(defun ac-latex-mode-setup ()         ; add ac-sources to default ac-sources
  (setq ac-sources
     (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
               ac-sources)))

(add-hook 'TeX-mode-hook 'ac-latex-mode-setup)
(setq ac-math-unicode-in-math-p t)

(show-paren-mode 1)
(electric-pair-mode 1)
(setq electric-pair-pairs '(
                            (?\" . ?\")
                            (?\{ . ?\})
                            (?\[ . ?\])
                            (?\$ . ?\$)
                            ))

(use-package magit
  :ensure t)
(global-set-key (kbd "C-x g") 'magit-status)

(use-package bash-completion
       :ensure t)
(add-hook 'shell-dynamic-complete-functions
  'bash-completion-dynamic-complete)

(use-package magit-gitflow
        :ensure t)

(require 'magit-gitflow)
(add-hook 'magit-mode-hook 'turn-on-magit-gitflow)

(use-package company
        :ensure t
        :config
        (add-hook 'after-init-hook 'global-company-mode)
)

(use-package evil
        :ensure t)
(evil-mode 0)

(defun insert-oe ()
  "Insert \"o at cursor point."
  (interactive)
  (insert "\\\"o"))
(global-set-key (kbd "ö") 'insert-oe) ; ö

(defun insert-OE ()
  "Insert \"O at cursor point."
  (interactive)
  (insert "\\\"O"))
(global-set-key (kbd "Ö") 'insert-OE) ; Ö

(defun insert-ae ()
  "Insert \"a at cursor point."
  (interactive)
  (insert "\\\"a"))
(global-set-key (kbd "ä") 'insert-ae) ; ä 

(defun insert-AE ()
  "Insert \"A at cursor point."
  (interactive)
  (insert "\\\"A"))
(global-set-key (kbd "Ä") 'insert-AE) ; Ä

(defun insert-ue ()
  "Insert \"u at cursor point."
  (interactive)
  (insert "\\\"u"))
(global-set-key (kbd "ü") 'insert-ue) ; ü

(defun insert-UE ()
  "Insert \"U at cursor point."
  (interactive)
  (insert "\\\"U"))
(global-set-key (kbd "Ü") 'insert-OE) ; Ü

(defun insert-ss ()
  "Insert \ss at cursor point."
  (interactive)
  (insert "\\ss\ "))
(global-set-key (kbd "ß") 'insert-ss) ; ß

(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

(global-set-key (kbd "C-ö") 'ansi-term)

(use-package pdf-tools
:ensure t)
(pdf-tools-install)
(setq pdf-view-midnight-colors '("#ffeeee" . "#272822"))
(add-hook 'pdf-view-mode-hook
          (lambda ()
            add-hook 'pdf-view-midnight-minor-mode))

(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)

(use-package ido-vertical-mode
  :ensure t
  :init
  (ido-vertical-mode 1))
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

(use-package smex
  :ensure t
  :init (smex-initialize)
  :bind
  ("M-x" . smex))

(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)

(defun config-visit ()
  (interactive)
  (find-file "~/.emacs.d/org_init.org"))
(global-set-key (kbd "C-c e") 'config-visit)

(defun config-reload ()
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/org_init.org"))
  )

(global-set-key (kbd "C-c r") 'config-reload)

(global-set-key (kbd "C-x b") 'ibuffer)

(use-package rainbow-mode
        :ensure t
      :init (rainbow-mode 1))

(use-package switch-window
  :ensure t
  :config
  (setq switch-window-input-style 'minibuffer)
  (setq switch-window-increase 4)
  (setq switch-window-threshold 2)
  (setq switch-window-shortcut-style 'qwerty)
  (setq switch-window-qwerty-shortcuts
        '("j" "k" "l" "a" "s" "d" "f"))
  :bind
  ([remap other-window] . switch-window))

(use-package atomic-chrome
:ensure t)

(defun ztlevi-atomic-chrome-server-running-p ()
      (cond ((executable-find "lsof")
             (zerop (call-process "lsof" nil nil nil "-i" ":64292")))
            ((executable-find "netstat") ; Windows
             (zerop (call-process-shell-command "netstat -aon | grep 64292")))))

    (if (ztlevi-atomic-chrome-server-running-p)
        (message "Can't start atomic-chrome server, because port 64292 is already used")
      (ignore-errors (atomic-chrome-start-server)))

(defun atomic-latex-start ()
  (interactive)
  (latex-mode)
  (latex-preview-pane-mode)
  (atomic-chrome-edit-mode)
)

(setq atomic-chrome-buffer-open-style 'frame)

(global-set-key (kbd "C-ü") (lambda () (interactive) (atomic-latex-start)))

(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

(use-package beacon
        :ensure t)
(beacon-mode 1)

(global-subword-mode 1)

(defun kill-whole-word ()
  (interactive)
  (backward-word)
  (kill-word 1))
(global-set-key (kbd "C-c k w") 'kill-whole-word)

(use-package hungry-delete
        :ensure t
        :config (global-hungry-delete-mode 0)
)

(use-package sudo-edit
  :ensure t
  :bind ("C-c s" . sudo-edit)
  )

(use-package symon
  :ensure t
  )
(symon-mode 1)

(defun kill-curr-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'kill-curr-buffer)

(defun copy-whole-line ()
  (interactive)
  (save-excursion
    (kill-new
     (buffer-substring(
                       (point-at-bol)
                       (point-at-eol))))))
(global-set-key (kbd "C-c w l") 'copy-whole-line)

(use-package rainbow-delimiters
  :ensure t
  :init
  (rainbow-delimiters-mode 1)
  )
(rainbow-delimiters-mode -1)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 10)))
  (setq dashboard-banner-logo-title "")
  )

(setq display-time-24hr-format t)
(display-time-mode 1)
