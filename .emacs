(load "/usr/share/emacs/site-lisp/site-gentoo")
(add-to-list 'load-path "~/.emacs.d/93free")
(add-to-list 'load-path "~/.emacs.d/lisps")
(add-to-list 'load-path "~/.emacs.d/lisps/nxhtml/util")
(add-to-list 'load-path "~/.emacs.d/lisps/themes")
;; 载入elisp文件


(global-set-key [(f1)] (lambda () (interactive) (manual-entry (current-word))))
(global-set-key [f2] 'speedbar)         ; 快速浏览
(global-set-key [f3] 'linum-mode)       ; 显示行号
(global-set-key [f4] 'view-mode)        ; 只读方式查看文件
(global-set-key [f5] 'revert-buffer)    ; 重载文件/刷新
(global-set-key [f6] 'eshell)           ; 一个 elisp 写的 shell
(global-set-key [f7] 'calendar)         ; Emacs 的日历系统
;;(global-set-key [f8] 'plan)             ; 计划任务
(global-set-key [f9] 'other-window)     ; 跳转到 Emacs 的另一个窗口
;;(global-set-key [f10] ')              ; 文件菜单
(global-set-key [f11] 'compile)         ; 在 Emacs 中编译
(global-set-key [f13] 'gdb)             ; 在 Emacs 中调试
;; 这些功能键有时候还是很有用的。除了直接设置之外，还可以配合 Shift, Ctrl 设置，比如：
;;
;; (global-set-key [(shift f1)] 'goto-line)
;;
;; 实际上 Shift-F1 也可以用 F13 表示。

(global-set-key (kbd "C-SPC") 'nil)
(global-set-key "\C-x\C-b" 'electric-buffer-list)
(global-set-key "\C-c\C-z" 'pop-global-mark)   
;; 很多文件的时候，在几个文件中跳转到曾经用过的 mark 地方。


(global-set-key "\C-\\" 'toggle-truncate-lines)
;; 基本不用 Emacs 的输入法，绑定给折行命令吧

(global-set-key "\C-z" 'set-mark-command)      
;; 设置标记。

(define-prefix-command 'ctl-x-m-map)
(global-set-key "\C-xm" 'ctl-x-m-map)          
;; 定义了一个新的前缀，并且绑定到 C-x m

(define-key ctl-x-m-map "w" 'ibuffer)         
;; 管理 Emacs 所打开的 buffer。

(setq inhibit-startup-message t)               
;; 不显示 Emacs 的开始画面。

(setq frame-title-format '("" buffer-file-name "@" user-login-name ":" system-name))
;; 设置缓冲标题

(setq default-major-mode 'text-mode)           
;; 任意的打开一个新文件时，缺省使用 text-mode。

(setq require-final-newline t)                 
;; 存盘的时候，要求最后一个字符是换行符。

(setq resize-mini-windows nil)                 
;; mini buffer 的大小保持不变。

;;(mouse-avoidance-mode 'animate)                
;; 鼠标指针避开光标

;; 用鼠标快速 copy ,cut , paste
(require 'mouse-copy)
(global-set-key [S-down-mouse-1] 'mouse-drag-secondary-pasting)
(global-set-key [M-S-down-mouse-1] 'mouse-drag-secondary-moving)

(setq track-eol t)                             
;; 当光标在行尾上下移动的时候，始终保持在行尾。

(setq Man-notify-method 'pushy)                
;; 当浏览 man page 时，直接跳转到 man buffer。

(setq uniquify-buffer-name-style 'forward)     
;; 当有两个文件名相同的缓冲时，使用前缀的目录名做 buffer 名字，不用原来的

(setq line-number-display-limit 1000000)       
;; 当行数超过一定数值，不再显示行号。

(setq kill-ring-max 200)                       
;; kill-ring 最多的记录个数。

(setq ring-bell-function 'ignore)              
;; 彻底的消除 ring-bell 的效果。

(setq apropos-do-all nil)                      
;; M-x apropos 时多查询些结果，但需要更多的 CPU。

(setq dired-recursive-copies t)               
(setq dired-recursive-deletes t)               
;; 复制(删除)目录的时，第归的复制(删除)其中的子目录。

(setq display-time-24hr-format t)
(setq display-time-day-and-date t)  
(setq display-time-use-mail-icon t) 
(setq display-time-interval 10)                
;; 在 mode-line 上显示时间。


(require 'smtpmail)
(setq send-mail-function 'smtpmail-send-it)
(setq message-send-mail-function 'smtpmail-send-it)
(setq user-full-name "transtone")
(setq smtpmail-local-domain "gmail.com")
(setq user-mail-address (concat "zm3345@" smtpmail-local-domain))
;; 缺省的名字和邮件地址，很多地方用得到，比如 VC(version control) 中产生ChangeLog 文件。

(setq appt-issue-message t)                    
;; 打开约会提醒功能。

(setq x-select-enable-clipboard t)
;; 支持emacs和外部程序的粘贴

(setq time-stamp-active t)
(setq time-stamp-warn-inactive t)
(setq time-stamp-format "%:y-%02m-%02d %3a %02H:%02M:%02S 93free")
;; 设置时间戳，标识出最后一次保存文件的时间。

(setq version-control t)                       
(setq kept-old-versions 1)                     
(setq kept-new-versions 2)                     
(setq delete-old-versions t)
(setq backup-directory-alist '(("." . "~/.emacs.d/tmp")))
(setq backup-by-copying t)                     
;; Emacs 中，改变文件时，默认都会产生备份文件(以 ~ 结尾的文件)。可以完全去掉
;; (并不可取)，也可以制定备份的方式。这里采用的是，把所有的文件备份都放在一
;; 个固定的地方("~/var/tmp")。对于每个备份文件，保留最原始的一个版本和最新的
;; 两个版本。并且备份的时候，备份文件是复本，而不是原件。

(global-font-lock-mode 1)
(setq font-lock-maximum-decoration t)
(setq font-lock-global-modes '(not shell-mode text-mode))
(setq font-lock-verbose t)
(setq font-lock-maximum-size '((t . 1048576) (vm-mode . 5250000)))
;; 语法高亮。除 shell-mode 和 text-mode 之外的模式中使用语法高亮。

(setq git-lock-defer-on-scrolling t)
(setq font-lock-support-mode 'git-lock-mode)
;; 为什么使用语法显示的大文件在移动时如此之慢

(require 'color-theme)
(setq theme-load-from-file t)
;;(color-theme-initialize)
;;(color-theme-sitaramv-nt)
(load-file "~/.emacs.d/lisps/themes/color-theme-tango-light.el")
(load-file "~/.emacs.d/lisps/themes/color-theme-awesome.el")
(load-file "~/.emacs.d/lisps/themes/color-theme-tango-2.el")
(color-theme-tango-light)

;; shell 和 eshell 相关设置
(setq shell-file-name "/bin/bash")

;; 让 shell mode 可以正常显示颜色
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(require 'ansi-color)

;; eshell 的颜色;; 这样可以显示颜色，但是当在文件很多的目录里面显示的时候会很慢
;(add-hook 'eshell-preoutput-filter-functions
;         'ansi-color-apply)
;; 这样直接把颜色滤掉
(add-hook 'eshell-preoutput-filter-functions
	  'ansi-color-filter-apply)

;; eshell ssh
(defun eshell/ssh (&rest args)
  "Secure shell"
  (let ((cmd (eshell-flatten-and-stringify
              (cons "ssh" args)))
        (display-type (framep (selected-frame))))
    (cond
     ((and
       (eq display-type 't)
       (getenv "STY"))
      (send-string-to-terminal (format "\033]83;screen %s\007" cmd)))
     ((eq display-type 'x)
      (eshell-do-eval
       (eshell-parse-command
	(format "Terminal -e %s &" cmd)))
      nil)
     (t
      (apply 'eshell-exec-visual (cons "ssh" args))))))


(setq-default kill-whole-line t)                
;; 在行首 C-k 时，同时删除该行。

(fset 'yes-or-no-p 'y-or-n-p)                   
;; 按 y 或空格键表示 yes，n 表示 no。

(auto-compression-mode 1)               ; 打开压缩文件时自动解压缩。
(column-number-mode 1)                  ; 显示列号。
(blink-cursor-mode -1)                  ; 光标不要闪烁。
(display-time-mode 1)                   ; 显示时间。
(show-paren-mode 1)                     ; 高亮显示匹配的括号。
(setq show-paren-style 'parentheses) 	; 括号不来回弹跳。
;;(menu-bar-mode -1)                      ; 不要 menu-bar。
(icomplete-mode 1)                      ; 给出用 M-x foo-bar-COMMAND 输入命令的提示。
;;(set-scroll-bar-mode 'right)		; scroll-bar 靠右显示。
(scroll-bar-mode -1)                    ; 不要 scroll-bar
(display-battery-mode 1)
(tool-bar-mode -1)			; 不要 tool-bar。

(autoload 'table-insert "table" "WYGIWYS table editor")
;; 可以识别文本文件里本来就存在的表格，而且可以把表格输出为 HTML 和 TeX。

(autoload 'folding-mode          "folding" "Folding mode" t)
(autoload 'turn-off-folding-mode "folding" "Folding mode" t)
(autoload 'turn-on-folding-mode  "folding" "Folding mode" t)
;;【folding.el】编辑文本的一部分，将其他部分折叠起来。



;; 设置 sentence-end 可以识别中文标点。不用在 fill 时在句号后插入两个空格。
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)


(load-library "hideshow")
(add-hook 'java-mode-hook 'hs-minor-mode)
(add-hook 'perl-mode-hook 'hs-minor-mode)
(add-hook 'php-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
;; 代码折叠

(require 'thumbs)
(autoload 'thumbs "thumbs" "Preview images in a directory." t)
(auto-image-file-mode t)
;; 开启图片浏览

(setq tab-width 4 indent-tabs-mode nil)
;; 将tab替换成空格

(setq x-stretch-cursor nil)
;; 如果设置为 t，光标在 TAB 字符上会显示为一个大方块 :)。

;;(require 'un-define)  ;;最新版的mule-ucs不自动加载unicode支持,须照此行方法手动载入.
(require 'unicad)
;;(set-language-environment 'utf-8)
(set-keyboard-coding-system 'chinese-gbk)

(modify-coding-system-alist 'file "\\.nfo\\'" 'cp437)
;; 用cp437编码来打开.nfo文件

;;(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
(setq auto-mode-alist (cons '("\\.asp$" . html-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.phtml$" . html-mode) auto-mode-alist))
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;;; cperl-mode is preferred to perl-mode                                        
;;; "Brevity is the soul of wit" <foo at acm.org> 
(mapc
  (lambda (pair)
    (if (eq (cdr pair) 'perl-mode)
        (setcdr pair 'cperl-mode)))
  (append auto-mode-alist interpreter-mode-alist))

(require 'mumamo-fun)
(setq auto-mode-alist
   (append '(("\\.py\\'" . python-mode)
      ("\\.css\\'" . css-mode)
      ("\\.php\\'" . mumamo-alias-html-mumamo-mode)
      ("\\.html\\'" . mumamo-alias-html-mumamo-mode))
      auto-mode-alist))
;; 将文件模式和文件后缀关联起来。

;; 括号匹配			  
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))
;; 当 % 在括号上按下时，那么匹配括号，否则输入一个 %。			  

(global-set-key "\C-ch" 'highline-mode)
(global-set-key "\C-cg" 'global-highline-mode)
(global-set-key "\C-cc" 'highline-customize)
(global-set-key "\C-cv" 'highline-view-mode)
(global-set-key "\C-c2" 'highline-split-window-vertically)
(global-set-key "\C-c3" 'highline-split-window-horizontally)

;;(require 'tex-site)
(require 'compile)

(global-set-key ( kbd "C-.") 'redo)
;; 设置Redo的键绑定

(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(require 'browse-kill-ring)
(global-set-key [(control c)(k)] 'browse-kill-ring)
(browse-kill-ring-default-keybindings)
;; 方便的在 kill-ring 里寻找需要的东西。

(require 'ido)
(ido-mode t)

(define-key global-map "\e\e" 'vi-mode) ;quick switch into vi-mode
;;(setq find-file-hook (list
;;                     (function (lambda ()
;;                               (if (not (or (eq major-mode 'Info-mode)
;;                                   (eq major-mode 'vi-mode)))
;;                                   (vi-mode))))))

(require 'erc)
;;(require 'erc-list)
;;(require 'erc-nicklist)
(setq erc-encoding-coding-alist (quote (("default" . utf-8))))


;; gnuserv begain
;; -----------------------------------------------
;;(require 'devices)
;;(require 'gnuserv-compat)
;;(require 'gnuserv)
;;(gnuserv-start)
;;(setq gnuserv-frame (selected-frame)) ;在当前frame打开
;;(setenv "GNUSERV_SHOW_EMACS" "1") ;打开后让emacs跳到前面来
;; -----------------------------------------------
;; gnuserv end here

;;(server-start)
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)
(global-set-key (kbd "C-x C-k") 'server-edit)

;; tabbar设置
;; ------------------------------------------------
(require 'tabbar)
(global-set-key (kbd "<S-up>") 'tabbar-backward-group)
(global-set-key (kbd "<S-down>") 'tabbar-forward-group)
(global-set-key (kbd "<S-left>") 'tabbar-backward)
(global-set-key (kbd "<S-right>") 'tabbar-forward)     ; 用 Shift+方向键 切换tab

;; 改变 "tabbar-buffer-groups-function"
;;(setq tabbar-buffer-groups-function 'tabbar-buffer-ignore-groups)
;;(defun tabbar-buffer-ignore-groups (buffer)
;;  "Return the list of group names BUFFER belongs to.
;;   Return only one group for each buffer."
;;  (with-current-buffer (get-buffer buffer)
;;    (cond
;;     ((or (get-buffer-process (current-buffer))
;;          (memq major-mode
;;                '(comint-mode compilation-mode)))
;;      '("Process"))
;;     ((member (buffer-name)
;;              '("*scratch*" "*Messages*"))
;;      '("Common"))
;;     ((eq major-mode 'dired-mode)
;;      '("Dired"))
;;     ((memq major-mode
;;            '(help-mode apropos-mode Info-mode Man-mode))
;;      '("Help"))
;;     ((memq major-mode
;;            '(rmail-mode
;;              rmail-edit-mode vm-summary-mode vm-mode mail-mode
;;              mh-letter-mode mh-show-mode mh-folder-mode
;;              gnus-summary-mode message-mode gnus-group-mode
;;             gnus-article-mode score-mode gnus-browse-killed-mode))
;;      '("Mail"))
;;     (t
;;      (list 
;;       "default"  ;; no-grouping
;;       (if (and (stringp mode-name) (string-match "[^ ]" mode-name))
;;           mode-name
;;         (symbol-name major-mode))))))) 
(tabbar-mode)
;; 把每个 buffer 同时加入它所在的 major mode 的组和一个叫做 "default" 的组，
;; 这样在 default 组里就可以方便的浏览到所有的 buffer 了。
;; 而切换到其它组就可以分组浏览。
;; ------------------------------------------------
;; tabbar end here


;; calendar & planner begain
;; -------------------------------------------
(require 'todo-mode)
(require 'weekly-view)
(require 'cal-china-x)
(setq diary-file "~/.emacs.d/plans/.diary")  ;; 默认的日记文件
(add-hook 'diary-display-hook 'fancy-diary-display-week-graph)
(load-library "cal-desk-calendar")
(add-hook 'diary-display-hook 'sort-diary-entries)
(add-hook 'diary-display-hook 'fancy-schedule-display-desk-calendar t)

;; planner
;;(setq muse-project-alist
;;   '(("WikiPlanner"
;;     ("~/.emacs.d/plans"   ;; Or wherever you want your planner files to be
;;     :default "index"
;;     :major-mode planner-mode
;;     :visit-link planner-visit-link))))
;;(require 'planner)
;;(global-set-key (kbd "<f8> p") 'planner-create-task-from-buffer)
;;(setq planner-publishing-directory "~/.emacs.d/plans")
;;;;Start planner together with Calendar
;;(planner-calendar-insinuate)
;;(setq planner-calendar-show-planner-files t)
;; -------------------------------------------
;; calendar & planner end here

(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)


;; 自动补全 "hippie-expand"
(global-set-key "\M-/" 'hippie-expand)
(setq hippie-expand-try-functions-list 
   '(try-expand-dabbrev
     try-expand-dabbrev-visible
     try-expand-dabbrev-all-buffers
     try-expand-dabbrev-from-kill
     try-complete-file-name-partially
     try-complete-file-name
     try-expand-all-abbrevs
     try-expand-list
     try-expand-line
     try-complete-lisp-symbol-partially
     try-complete-lisp-symbol))
;; hippie-expand 的补全方式。它是一个优先列表， hippie-expand 会优先使用表最前面的函数来补全。

;; 这个函数是一个 vi 的 "f" 命令的替代品。
(defun wy-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
		     char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))

(define-key global-map (kbd "C-c a") 'wy-go-to-char)
;; 有了这段代码之后，当你按 C-c a x (x 是任意一个字符) 时，光标就会到下一个 x 处。
;; 再次按 x，光标就到下一个 x。比如 C-c a w w w w ..., C-c a b b b b b b ...

;; 这两个函数可以分别把一个区域和匹配某个regexp的行都藏起来，就跟不存在一样……
;; hide region
(require 'hide-region)
(global-set-key (kbd "C-c r") 'hide-region-hide)
(global-set-key (kbd "C-c R") 'hide-region-unhide)
;; hide lines
(require 'hide-lines)
(global-set-key (kbd "C-c l") 'hide-lines)
(global-set-key (kbd "C-c L") 'show-all-invisible)
;; hide-lines 在操作某些行的时候用起来特别方便。加一个前缀参数可以把不匹配的行都藏起来，只看到匹配的！


;; ecb代码浏览器
(require 'ecb)
(setq ecb-layout-name "left1")
(setq ecb-compile-window-height 10)
(add-hook 'ecb-activate-hook
          (lambda ()
            (ecb-toggle-compile-window -1)))
(setq ecb-vc-enable-support t)
(setq ecb-tip-of-the-day nil)

;; 中国象棋
(require 'chinese-chess-pvc)

(require 'ange-ftp)
(require 'tramp)

;; yasnippet
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/lisps/yasnippet/snippets")
(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt
                             yas/ido-prompt
                             yas/completing-prompt))



;;session和desktop插件,需要放在最后
;;(require 'session)
;;(add-hook 'after-init-hook 'session-initialize)
;;(require 'desktop)
;;(desktop-load-default) 
;;(desktop-read)

