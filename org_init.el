
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

(use-package ace-window
:ensure t
:init
(progn
(setq aw-scope 'frame)
(global-set-key (kbd "C-x O") 'other-frame)
  (global-set-key [remap other-window] 'ace-window)
  (custom-set-faces
   '(aw-leading-char-face
     ((t (:inherit ace-jump-face-foreground :height 3.0))))) 
  ))

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
                            (?\$ . ?\$)
                            ) )

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

(use-package atomic-chrome
:ensure t
:config 
(atomic-chrome-start-server))

(defun atomic-latex-start ()
(interactive)
(latex-mode)
(latex-preview-pane-mode)
(atomic-chrome-edit-mode)
)

(setq atomic-chrome-buffer-open-style 'frame)

(global-set-key (kbd "C-ü") (lambda () (interactive) (atomic-latex-start)))
