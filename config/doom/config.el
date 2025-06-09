(beacon-mode 1)

(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

(evil-define-key 'normal ibuffer-mode-map
  (kbd "f c") 'ibuffer-filter-by-content
  (kbd "f d") 'ibuffer-filter-by-directory
  (kbd "f f") 'ibuffer-filter-by-filename
  (kbd "f m") 'ibuffer-filter-by-mode
  (kbd "f n") 'ibuffer-filter-by-name
  (kbd "f x") 'ibuffer-filter-disable
  (kbd "g h") 'ibuffer-do-kill-lines
  (kbd "g H") 'ibuffer-update)

(require 'dap-netcore)
(require 'dap-dlv-go)
(map! :leader
      (:prefix ("d" . "dap-mode")
       :desc "Toggle breakpoint" "t" #'dap-breakpoint-toggle
       :desc "Continue execution" "c" #'dap-continue
       :desc "Step in" "n" #'dap-step-in
       :desc "Step out" "N" #'dap-step-out
       :desc "See all breakpoints" "b" #'dap-ui-breakpoints-toggle
       :desc "Change variable value" "s" #'dap-ui-set-variable-value
       :desc "Evaluate expression at point" "e" #'dap-eval-thing-at-point
       :desc "Evaluate expression" "E" #'dap-eval
       :desc "Run debugger" "r" #'dap-debug
       :desc "Restart debugger" "R" #'dap-debug-restart
       :desc "Stop debugger" "d" #'dap-disconnect))
(use-package dap-mode
    :init
    (dap-auto-configure-mode)

    :custom
    (dap-netcore-download-url "https://github.com/Samsung/netcoredbg/releases/download/3.1.0-1031/netcoredbg-linux-amd64.tar.gz"))

;; With dired-open plugin, you can launch external programs for certain
;; extensions For example, I set all .png files to open in 'vimiv' and all .mp4
;; files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "vimiv")
                              ("jpg" . "vimiv")
                              ("png" . "vimiv")
                              ("mkv" . "mpv")
                              ("mp3" . "mpv")
                              ("mp4" . "mpv")))

(evil-define-key 'normal peep-dired-mode-map
  (kbd "j") 'peep-dired-next-file
  (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

(setq delete-by-moving-to-trash t
      trash-directory "~/.local/share/Trash/files/")

(setq doom-theme 'doom-gruvbox)
(map! :leader
      :desc "Load new theme" "h t" #'load-theme)

(use-package emojify
  :hook (after-init . global-emojify-mode))

(setq doom-font (font-spec :family "Mononoki Nerd Font" :size 14)
      doom-variable-pitch-font (font-spec :family "Mononoki Nerd Font" :size 14)
      doom-big-font (font-spec :family "Mononoki Nerd Font" :size 20))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(defun drk/insert-todays-date (prefix)
  (interactive "P")
  (let ((format (cond
                 ((not prefix) "%A, %B %d, %Y")
                 ((equal prefix '(4)) "%m-%d-%Y")
                 ((equal prefix '(16)) "%Y-%m-%d"))))
    (insert (format-time-string format))))

(require 'calendar)
(defun drk/insert-any-date (date)
  "Insert DATE using the current locale."
  (interactive (list (calendar-read-date)))
  (insert (calendar-date-string date)))

(map! :leader
      (:prefix ("i d" . "Insert date")
        :desc "Insert any date" "a" #'drk/insert-any-date
        :desc "Insert todays date" "t" #'drk/insert-todays-date))

(setq display-line-numbers-type t)
(map! :leader
      :desc "Comment or uncomment lines" "TAB TAB" #'comment-line
      (:prefix ("t" . "toggle")
       :desc "Toggle line numbers" "l" #'doom/toggle-line-numbers
       :desc "Toggle line highlight in frame" "h" #'hl-line-mode
       :desc "Toggle line highlight globally" "H" #'global-hl-line-mode
       :desc "Toggle truncate lines" "t" #'toggle-truncate-lines))

(after! lsp-mode)
    (setq lsp-csharp-csharpls-use-dotnet-tool 't)
(add-hook 'csharp-mode-hook #'lsp-deferred)

(add-hook 'go-mode-hook #'lsp-deferred)

(add-hook 'rust-mode-hook #'lsp-deferred)

(custom-set-faces
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold :family "Mononoki Nerd Font"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.5))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.4))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.3))))
 '(markdown-header-face-4 ((t (:inherit markdown-header-face :height 1.2))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :height 1.1))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :height 1.0)))))

(set-face-attribute 'mode-line nil :font "Mononoki Nerd Font-12")
(setq doom-modeline-height 30     ;; sets modeline height
      doom-modeline-bar-width 5   ;; sets right bar width
      doom-modeline-persp-name t  ;; adds perspective name to modeline
      doom-modeline-persp-icon t) ;; adds folder icon next to persp name

(xterm-mouse-mode 1)

(map! :leader
      :desc "Toggle neotree" "e" #'neotree-toggle)
(setq neo-theme 'nerd)
(setq neo-smart-open t)
(setq projectile-switch-project-action 'neotree-projectile-action)

(map! :leader
      (:prefix ("=" . "open file")
       :desc "Edit doom config.org" "c" #'(lambda () (interactive) (find-file "~/.config/doom/config.org"))
       :desc "Edit doom init.el" "i" #'(lambda () (interactive) (find-file "~/.config/doom/init.el"))
       :desc "Edit doom packages.el" "p" #'(lambda () (interactive) (find-file "~/.config/doom/packages.el"))))

(map! :leader
      :desc "Org babel tangle" "m B" #'org-babel-tangle)
(after! org
  (setq org-ellipsis " ▼ "
        org-superstar-headline-bullets-list '("◉" "●" "○" "◆" "●" "○" "◆")
        org-superstar-item-bullet-alist '((?+ . ?➤) (?- . ?✦)) ; changes +/- symbols in item lists
        org-log-done 'time
        org-hide-emphasis-markers t
        ;; Settings for fancy priorities (requires +pretty flag or similar)
        org-fancy-priorities-list '("󰈼" "󰈻" "󰈽")
        org-priority-faces
          '((?A :foreground "#fb4934" :weight bold)
            (?B :foreground "#fabd2f" :weight bold)
            (?C :foreground "#83a598" :weight bold))))

(setq org-publish-use-timestamps-flag nil)
(setq org-export-with-broken-links t)

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda () (rainbow-mode 1)))
(global-rainbow-mode 1 )

(setq shell-file-name "/bin/fish"
      vterm-max-scrollback 10000)
(map! :leader
      :desc "Vterm popup toggle" "v t" #'+vterm/toggle)

(defun prefer-horizontal-split ()
  (set-variable 'split-height-threshold nil t)
  (set-variable 'split-width-threshold 40 t)) ; make this as low as needed
(add-hook 'markdown-mode-hook 'prefer-horizontal-split)
(map! :leader
      :desc "Clone indirect buffer other window" "b c" #'clone-indirect-buffer-other-window)

(set-frame-parameter nil 'alpha-background 95) ; For current frame
(add-to-list 'default-frame-alist '(alpha-background . 95)) ; For all new frames henceforth
(when (daemonp)
  (exec-path-from-shell-initialize))

(map! :leader
      (:prefix ("w" . "window")
       :desc "Winner redo" "<right>" #'winner-redo
       :desc "Winner undo" "<left>" #'winner-undo))
