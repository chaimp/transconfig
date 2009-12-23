;; EMMS
;; ---------------------------------------------------

(require 'emms-setup)
(emms-devel)

;; players
(setq emms-player-mpg321-command-name "mpg123"
      emms-player-mplayer-command-name "mplayer"
      emms-player-list '(emms-player-mpg321
			 emms-player-ogg123
			 emms-player-mplayer
                         emms-player-mplayer-playlist))

;; coding
;;(setq emms-info-mp3info-coding-system 'gbk
;;      emms-lyrics-coding-system 'gbk
;;      emms-cache-file-coding-system 'utf-8)

;; files
(setq emms-source-file-default-directory "/mnt/d/media")
;;      emms-lyrics-dir "~/music/lyrics")

;; mode line format
(setq emms-mode-line-format "[ %s ]"
      emms-lyrics-display-format "%s"
      emms-playing-time-display-format "%s")

(setq global-mode-string
      '("" appt-mode-string
        display-time-string " "
        battery-mode-line-string " "
        erc-modified-channels-object
        emms-mode-line-string " "
        emms-playing-time-string " "
        emms-lyrics-mode-line-string " "))

;; faces
(set-face-foreground 'emms-playlist-selected-face "magenta")
(set-face-foreground 'emms-playlist-track-face  "green")
(setq emms-source-file-directory-tree-function
      'emms-source-file-directory-tree-find)
(add-hook 'emms-player-started-hook 'emms-show)
(setq emms-playlist-sort-prefix "S")
(define-key emms-playlist-mode-map (kbd "S s") 'emms-playlist-sort-by-score)
(global-set-key (kbd "<f3>") 'emms-playlist-mode-go-popup)
(defun emms-playlist-mode-jump ()
  "Jump to the directory of track at point in `emms-playlist-buffer'."
  (interactive)
  (dired
   (file-name-directory
    (emms-track-get (emms-playlist-track-at) 'name))))

(global-set-key (kbd "C-c e t") 'emms-play-directory-tree)
(global-set-key (kbd "C-c e x") 'emms-start)
(global-set-key (kbd "C-c e v") 'emms-stop)
(global-set-key (kbd "C-c e n") 'emms-next)
(global-set-key (kbd "C-c e p") 'emms-previous)
(global-set-key (kbd "C-c e o") 'emms-show)
(global-set-key (kbd "C-c e h") 'emms-shuffle)
;; (global-set-key (kbd "C-c e e") 'emms-play-file)
(global-set-key (kbd "C-c e SPC") 'emms-pause)
(global-set-key (kbd "C-c e f") 'emms-no-next)
(global-set-key (kbd "C-c e a") 'emms-add-directory-tree)

(global-set-key (kbd "C-c e r")   'emms-toggle-repeat-track)
(global-set-key (kbd "C-c e R")   'emms-toggle-repeat-playlist)
(global-set-key (kbd "C-c e m")   'emms-lyrics-toggle-display-on-minibuffer)
(global-set-key (kbd "C-c e M")   'emms-lyrics-toggle-display-on-modeline)

(global-set-key (kbd "C-c e <left>")  (lambda () (interactive) (emms-seek -10)))
(global-set-key (kbd "C-c e <right>") (lambda () (interactive) (emms-seek +10)))
(global-set-key (kbd "C-c e <down>")  (lambda () (interactive) (emms-seek -60)))
(global-set-key (kbd "C-c e <up>")    (lambda () (interactive) (emms-seek +60)))

(global-set-key (kbd "C-c e s u") 'emms-score-up-playing)
(global-set-key (kbd "C-c e s d") 'emms-score-down-playing)
(global-set-key (kbd "C-c e s o") 'emms-score-show-playing)

;; ----------------------------------------------------------
;; EMMS end here

