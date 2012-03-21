;;(load "/usr/share/emacs/site-lisp/site-gentoo")
(add-to-list 'load-path "~/.emacs.d/93free")
(add-to-list 'load-path "~/.emacs.d/lisps")
(add-to-list 'load-path "~/.emacs.d/lisps/tree")
;;(add-to-list 'load-path "~/.emacs.d/lisps/mumamo")
;; 载入elisp文件

;;(global-set-key [(f1)] (lambda () (interactive) (manual-entry (current-word))))
(global-set-key [f1] 'dirtree)             ; 快速浏览
(global-set-key [f2] 'view-mode)            ; 只读模式
(global-set-key [f3] 'linum-mode)           ; 显示行号
(global-set-key [f4] 'global-highline-mode) ; 高亮光标行 
(global-set-key [f5] 'font-lock-mode)       ; 语法高亮
(global-set-key [f6] 'eshell)               ; 一个 elisp 写的 shell
(global-set-key [f7] 'calendar)             ; Emacs 的日历系统
(global-set-key [f8] 'flymake-mode)         
(global-set-key [f9] 'other-window)         ; 跳转到 Emacs 的另一个窗口
;;(global-set-key [f10] ')                  ; 文件菜单
(global-set-key [f11] 'compile)             ; 在 Emacs 中编译
(global-set-key [f12] 'gdb)                 ; 在 Emacs 中调试
;; 这些功能键有时候还是很有用的。除了直接设置之外，还可以配合 Shift, Ctrl 设置，比如：
;;
;; (global-set-key [(shift f1)] 'goto-line)
;;
;; 实际上 Shift-F1 也可以用 F13 表示。

(require 'grep-edit)
(require 'diff-mode)
(defvar diff-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "M-.") 'diff-hunk-next)
    (define-key map (kbd "M-,") 'diff-hunk-prev)
  map)
"Keymap for `diff-mode'.")

(require 'twittering-mode)
(setq twittering-username "transtone")
(setq twittering-update-status-function
      'twittering-update-status-from-pop-up-buffer)
(twittering-icon-mode)                       ; Show icons (requires wget)
(setq twittering-timer-interval 300) 

(autoload 'dirtree "dirtree" "Add directory to tree view" t)

(eval-after-load "man" '(require 'man-completion))

(global-set-key (kbd "C-SPC") 'nil)
(global-set-key "\C-x\C-b" 'electric-buffer-list)
(global-set-key "\C-c\C-z" 'pop-global-mark)   
;; 很多文件的时候，在几个文件中跳转到曾经用过的 mark 地方。


(global-set-key "\C-\\" 'toggle-truncate-lines)
;; 基本不用 Emacs 的输入法，绑定给折行命令吧

(global-set-key "\C-z" 'set-mark-command)      
(global-set-key (kbd "M-SPC") 'set-mark-command)
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
(add-hook 'text-mode-hook '(lambda () (setq require-final-newline 'query)))
;; 任意的打开一个新文件时，缺省使用 text-mode。

;;(setq require-final-newline t)
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

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)     
;; 当有两个文件名相同的缓冲时，使用前缀的目录名做 buffer 名字，不用原来的

(setq default-fill-column 78)

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
;;(setq display-time-use-mail-icon t) 
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

(defun zhou-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
If no region is selected and current line is not blank and we are not at the end of the line,
then comment current line.
Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'zhou-comment-dwim-line)
;;do what I mean,注释功能

;;###复制一行绑定
(global-set-key (kbd "M-w") 'zhou-save-line-dwim)
;;###autoload
(defun zhou-save-one-line (&optional arg)
  "save one line. If ARG, save one line from first non-white."
  (interactive "P")
  (save-excursion
    (if arg
        (progn
          (back-to-indentation)
          (kill-ring-save (point) (line-end-position)))
      (kill-ring-save (line-beginning-position) (line-end-position)))))
;;;###autoload
(defun zhou-kill-ring-save (&optional n)
  "If region is active, copy region. Otherwise, copy line."
  (interactive "p")
  (if (and mark-active transient-mark-mode)
      (kill-ring-save (region-beginning) (region-end))
    (if (> n 0)
        (kill-ring-save (line-beginning-position) (line-end-position n))
      (kill-ring-save (line-beginning-position n) (line-end-position)))))
;;;###autoload
(defun zhou-save-line-dwim (&optional arg)
  "If region is active, copy region.
If ARG is nil, copy line from first non-white.
If ARG is numeric, copy ARG lines.
If ARG is non-numeric, copy line from beginning of the current line."
  (interactive "P")
  (if (and mark-active transient-mark-mode)
      ;; mark-active, save region
      (kill-ring-save (region-beginning) (region-end))
    (if arg
        (if (numberp arg)
            ;; numeric arg, save ARG lines
            (zhou-kill-ring-save arg)
          ;; other ARG, save current line
          (zhou-save-one-line))
      ;; no ARG, save current line from first non-white
      (zhou-save-one-line t))))
;;==============================================


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
;;(load-file "~/.emacs.d/lisps/themes/color-theme-tango-light.el")
(load-file "~/.emacs.d/lisps/themes/color-theme-ir-black.el")
(load-file "~/.emacs.d/lisps/themes/color-theme-tango-2.el")
(load-file "~/.emacs.d/lisps/themes/color-theme-subdued.el")
(load-file "~/.emacs.d/lisps/themes/color-theme-irblack-2.el")
(load-file "~/.emacs.d/lisps/themes/tango-theme.el")
(load-file "~/.emacs.d/lisps/themes/zen-and-art2.el")
;;(if window-system
;;    (if (> (caddr (decode-time (current-time))) 18)
;;        (color-theme-tango-light)             ;白天光线好用黑色系的主题
;;      (color-theme-tango-2))          ;晚上光线差用深蓝系的主题
;;(color-theme-tty-dark)
;;)
;;(color-theme-irblack-2)
(color-theme-tango-light)
;;(color-theme-zen-and-art2)

;; TTY-emacs: Use mode line face for vertical border
;; (set-display-table-slot standard-display-table
;;       'vertical-border
;;       (make-glyph-code ?| 'mode-line))


(defun djcb-opacity-modify (&optional dec)
  "modify the transparency of the emacs frame; if DEC is t,
    decrease the transparency, otherwise increase it in 10%-steps"
  (let* ((alpha-or-nil (frame-parameter nil 'alpha)) ; nil before setting
          (oldalpha (if alpha-or-nil alpha-or-nil 100))
          (newalpha (if dec (- oldalpha 10) (+ oldalpha 10))))
    (when (and (>= newalpha frame-alpha-lower-limit) (<= newalpha 100))
      (modify-frame-parameters nil (list (cons 'alpha newalpha))))))

 ;; C-8 will increase opacity (== decrease transparency)
 ;; C-9 will decrease opacity (== increase transparency
 ;; C-0 will returns the state to normal
(global-set-key (kbd "C-8") '(lambda()(interactive)(djcb-opacity-modify)))
(global-set-key (kbd "C-9") '(lambda()(interactive)(djcb-opacity-modify t)))
(global-set-key (kbd "C-0") '(lambda()(interactive)
                               (modify-frame-parameters nil `((alpha . 100)))))


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

;;(require 'hfyview)

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
(menu-bar-mode -1)                      ; 不要 menu-bar。
(icomplete-mode 1)                      ; 给出用 M-x foo-bar-COMMAND 输入命令的提示。
(set-scroll-bar-mode 'right)		; scroll-bar 靠右显示。
(scroll-bar-mode -1)                    ; 不要 scroll-bar
(display-battery-mode 1)
(tool-bar-mode -1)			; 不要 tool-bar。
(global-linum-mode 1)                   ; 开启行号。
(setq linum-format "%d ")

(autoload 'table-insert "table" "WYGIWYS table editor")
;; 可以识别文本文件里本来就存在的表格，而且可以把表格输出为 HTML 和 TeX。

;; 设置 sentence-end 可以识别中文标点。不用在 fill 时在句号后插入两个空格。
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)

;; 注释style
;;(setq comment-style 'box)

;; outline-mode
(setq outline-minor-mode-prefix [(control d)])
(set-display-table-slot
 standard-display-table
 'selective-display
 (let ((face-offset (* (face-id 'shadow) (lsh 1 22))))
   (vconcat (mapcar (lambda (c) (+ face-offset c)) " [...] "))))

;; 有了这段代码之后，当你按 C-c a x (x 是任意一个字符) 时，光标就会到下一个 x 处。
;; 再次按 x，光标就到下一个 x。比如 C-c a w w w w ..., C-c a b b b b b b ...
(defun zhou-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `zhou-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "Go to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
		     char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))
(define-key global-map (kbd "C-c a") 'zhou-go-to-char)

;; 这两个函数可以分别把一个区域和匹配某个regexp的行都藏起来，就跟不存在一样……
;; hide region
(require 'hide-region)
(global-set-key (kbd "C-c r") 'hide-region-hide)
(global-set-key (kbd "C-c R") 'hide-region-unhide)
;; hide lines
(require 'hide-lines)
;;(global-set-key (kbd "C-c l") 'hide-lines)
(global-set-key (kbd "C-c L") 'show-all-invisible)
;; hide-lines 在操作某些行的时候用起来特别方便。加一个前缀参数可以把不匹配的行都藏起来，只看到匹配的！

(require 'thumbs)
(autoload 'thumbs "thumbs" "Preview images in a directory." t)
(auto-image-file-mode t)
;; 开启图片浏览

(setq tab-width 4 indent-tabs-mode nil)
;; 将tab替换成空格

(setq x-stretch-cursor nil)
;; 如果设置为 t，光标在 TAB 字符上会显示为一个大方块 :)。

;;(require 'un-define)  ;;最新版的mule-ucs不自动加载unicode支持,须照此行方法手动载入.
;;(require 'unicad)
;;(set-language-environment 'utf-8)
;;(set-keyboard-coding-system 'chinese-gbk)

(modify-coding-system-alist 'file "\\.nfo\\'" 'cp437)
;; 用cp437编码来打开.nfo文件

;; css-mode 缩进
(setq cssm-indent-function #'cssm-c-style-indenter)

;; yasnippet
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/lisps/yasnippet/snippets")
(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt
                             yas/ido-prompt
                             yas/completing-prompt))

;; dirty fix for having AC everywhere
(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
                       (if (not (minibufferp (current-buffer)))
                         (auto-complete-mode 1))
                       ))
(real-global-auto-complete-mode t)
;;(define-key ac-complete-mode-map "\t" 'ac-expand)
;;(define-key ac-complete-mode-map "\r" 'ac-complete)
(define-key ac-complete-mode-map "\M-n" 'ac-next)
(define-key ac-complete-mode-map "\M-p" 'ac-previous)

(set-default 'ac-sources
             '(ac-source-semantic
               ac-source-yasnippet
               ac-source-abbrev
               ac-source-words-in-buffer
               ac-source-words-in-all-buffer
               ac-source-imenu
               ac-source-files-in-current-dir
               ac-source-filename))

;;; cperl-mode is preferred to perl-mode                                        
;;; "Brevity is the soul of wit" <foo at acm.org> 
(mapc
  (lambda (pair)
    (if (eq (cdr pair) 'perl-mode)
        (setcdr pair 'cperl-mode)))
  (append auto-mode-alist interpreter-mode-alist))

(setq auto-mode-alist
      (append '(("\\.php\\'"   . php-mode)
		("\\.module$"  . php-mode)
		("\\.inc$"     . php-mode)
		("\\.install$" . php-mode)
		("\\.engine$"  . php-mode)
		("\\.js\\'"    . js-mode)
		("\\.asp$"     . html-mode)
		("\\.phtml$"   . html-mode)
		("\\.djhtml$"  . django-html-mode)
		("\\.htm$"     . django-html-mode)
		("\\.html\\'"  . html-mode))
	      auto-mode-alist))
;; 将文件模式和文件后缀关联起来。
(require 'auto-complete)
(require 'auto-complete-config)
;;(require 'ac-anything)
(add-hook 'php-mode-hook
	  (lambda()
	    (setq case-fold-search t)
	    (setq indent-tabs-mode nil)
	    (setq fill-column 78)
            (c-set-style "bsd")
            (setq c-indent-level 4)
            (setq c-continued-statement-offset 4)
            (setq c-brace-offset -4)
            (setq c-argdecl-indent 0)
            (setq c-label-offset -4)
            (setq c-basic-offset 2)
            (setq tab-width 4)
	    (c-set-offset 'arglist-cont 0)
	    (c-set-offset 'arglist-intro '+)
	    (c-set-offset 'case-label 2)
	    (c-set-offset 'arglist-close 0)
            (c-set-offset 'arglist-cont-nonempty 'c-lineup-math)
	    (require 'php-completion)
	    (php-completion-mode t)
	    (define-key php-mode-map (kbd "C-c p") 'phpcmp-complete)
	    (make-variable-buffer-local 'ac-sources)
	    (add-to-list 'ac-sources 'ac-source-php-completion)
	    (auto-complete-mode t)))

;; php-mode
(require 'php-mode)

;; python-mode 

;; django-mode
(require 'django-html-mode)
(require 'django-mode)

;; Autofill inside of comments
(defun python-auto-fill-comments-only ()
  (auto-fill-mode 1)
  (set (make-local-variable 'fill-nobreak-predicate)
       (lambda ()
         (not (python-in-string/comment)))))
(add-hook 'python-mode-hook
          (lambda ()
            (python-auto-fill-comments-only)))
;;Autofill comments
;;TODO: make this work for docstrings too.
;; but docstrings just use font-lock-string-face unfortunately
(add-hook 'python-mode-hook
          (lambda ()
            (auto-fill-mode 1)
            (set (make-local-variable 'fill-nobreak-predicate)
                 (lambda ()
                   (not (eq (get-text-property (point) 'face)
                            'font-lock-comment-face))))))
;; pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Auto-completion
;;;  Integrates:
;;;   1) Rope
;;;   2) Yasnippet
;;;   all with AutoComplete.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun prefix-list-elements (list prefix)
  (let (value)
    (nreverse
     (dolist (element list value)
      (setq value (cons (format "%s%s" prefix element) value))))))
(defvar ac-source-rope
  '((candidates
     . (lambda ()
         (prefix-list-elements (rope-completions) ac-target))))
  "Source for Rope")
(defun ac-python-find ()
  "Python `ac-find-function'."
  (require 'thingatpt)
  (let ((symbol (car-safe (bounds-of-thing-at-point 'symbol))))
    (if (null symbol)
        (if (string= "." (buffer-substring (- (point) 1) (point)))
            (point)
          nil)
      symbol)))
(defun ac-python-candidate ()
  "Python `ac-candidates-function'"
  (let (candidates)
    (dolist (source ac-sources)
      (if (symbolp source)
          (setq source (symbol-value source)))
      (let* ((ac-limit (or (cdr-safe (assq 'limit source)) ac-limit))
             (requires (cdr-safe (assq 'requires source)))
             cand)
        (if (or (null requires)
                (>= (length ac-target) requires))
            (setq cand
                  (delq nil
                        (mapcar (lambda (candidate)
                                  (propertize candidate 'source source))
                                (funcall (cdr (assq 'candidates source)))))))
        (if (and (> ac-limit 1)
                 (> (length cand) ac-limit))
            (setcdr (nthcdr (1- ac-limit) cand) nil))
        (setq candidates (append candidates cand))))
    (delete-dups candidates)))
(add-hook 'python-mode-hook
          (lambda ()
	    (set (make-local-variable 'ac-sources)
		 (append ac-sources 'ac-source-rope))
	    (set (make-local-variable 'ac-find-function) 'ac-python-find)
	    (set (make-local-variable 'ac-candidate-function) 'ac-python-candidate)
;;	    (set (make-local-variable 'ac-auto-start) nil)
            (rope-open-project "~/.emacs.d/93free/python/")
            (local-set-key "\C-css" 'cscope-find-this-symbol)
            (local-set-key "\C-csd" 'cscope-find-global-definition)
            (local-set-key "\C-csg" 'cscope-find-global-definition)
            (local-set-key "\C-csG" 'cscope-find-global-definition-no-prompting)
            (local-set-key "\C-csc" 'cscope-find-functions-calling-this-function)
            (local-set-key "\C-csC" 'cscope-find-called-functions)
            (local-set-key "\C-cst" 'cscope-find-this-text-string)
            (local-set-key "\C-cse" 'cscope-find-egrep-pattern)
            (local-set-key "\C-csf" 'cscope-find-this-file)
            (local-set-key "\C-csi" 'cscope-find-files-including-file)
            (local-set-key "\C-csb" 'cscope-display-buffer)
            (local-set-key "\C-csB" 'cscope-display-buffer-toggle)
            (local-set-key "\C-csn" 'cscope-next-symbol)
            (local-set-key "\C-csN" 'cscope-next-file)
            (local-set-key "\C-csp" 'cscope-prev-symbol)
            (local-set-key "\C-csP" 'cscope-prev-file)
            (local-set-key "\C-csu" 'cscope-pop-mark)
            (local-set-key "\C-csa" 'cscope-set-initial-directory)
            (local-set-key "\C-csA" 'cscope-unset-initial-directory)
            (local-set-key "\C-csL" 'cscope-create-list-of-files-to-index)
            (local-set-key "\C-csI" 'cscope-index-files)
            (local-set-key "\C-csE" 'cscope-edit-list-of-files-to-index)
            (local-set-key "\C-csW" 'cscope-tell-user-about-directory)
            (local-set-key "\C-csS" 'cscope-tell-user-about-directory)
            (local-set-key "\C-csT" 'cscope-tell-user-about-directory)
            (local-set-key "\C-csD" 'cscope-dired-directory)
            ))

;;(require 'zencoding-mode)
;;(add-hook 'html-mode-hook 'zencoding-mode) ;; Auto-start on any markup modes

;; 显示匹配的括号
(show-paren-mode t)
;; 括号匹配			  
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))
;; 当 % 在括号上按下时，那么匹配括号，否则输入一个 %。			  

;;(global-set-key "\C-ch" 'highline-mode)
;;(global-set-key "\C-cg" 'global-highline-mode)
;;(global-set-key "\C-cc" 'highline-customize)
;;(global-set-key "\C-cv" 'highline-view-mode)
;;(global-set-key "\C-c2" 'highline-split-window-vertically)
;;(global-set-key "\C-c3" 'highline-split-window-horizontally)


;; 交换两个窗口的内容
;; transpose(interchange) two windows
(defun his-transpose-windows (arg)
  "Transpose the buffers shown in two windows."
  (interactive "p")
  (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
    (while (/= arg 0)
      (let ((this-win (window-buffer))
            (next-win (window-buffer (funcall selector))))
        (set-window-buffer (selected-window) next-win)
        (set-window-buffer (funcall selector) this-win)
        (select-window (funcall selector)))
      (setq arg (if (plusp arg) (1- arg) (1+ arg))))))
;; 交换两个窗口内的 buffer
(global-set-key (kbd "C-c l") 'his-transpose-windows)

(require 'redo+)
(setq undo-no-redo t)
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

;; 为 view-mode 加入 vim 的按键。
(setq view-mode-hook
      (lambda ()
        (define-key view-mode-map "h" 'backward-char)
        (define-key view-mode-map "l" 'forward-char)
        (define-key view-mode-map "j" 'next-line)
        (define-key view-mode-map "k" 'previous-line)))

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
;;(require 'tabbar-ruler)
(require 'tabbar)
;;(require 'tabbar-extension) 
(tabbar-mode 1)
(setq tabbar-separator (quote ("T")))

(global-set-key (kbd "<S-up>") 'tabbar-backward-group)
(global-set-key (kbd "<S-down>") 'tabbar-forward-group)
(global-set-key (kbd "M-n") 'tabbar-backward)
(global-set-key (kbd "M-p") 'tabbar-forward)
(global-set-key (kbd "<S-left>") 'tabbar-backward)
(global-set-key (kbd "<S-right>") 'tabbar-forward)     ; 用 Shift+方向键 切换tab

(setq tabbar-buffer-list-function
    (lambda ()
        (remove-if
          (lambda(buffer)
             (find (aref (buffer-name buffer) 0) " *"))
          (buffer-list))))

(defun tabbar-buffer-groups ()
  "Return the list of group names the current buffer belongs to.
Return a list of one element based on major mode."
  (list
   (cond
    ((or (get-buffer-process (current-buffer))
         ;; Check if the major mode derives from `comint-mode' or
         ;; `compilation-mode'.
         (tabbar-buffer-mode-derived-p
          major-mode '(comint-mode compilation-mode)))
     "Process"
     )
    ((member (buffer-name)
             '("*scratch*" "*Messages*"))
     "Common"
     )
    ((eq major-mode 'dired-mode)
     "Dired"
     )
    ((memq major-mode 
	   '(html-mode php-mode nxml-mode sgml-mode python-mode django-mode django-html-mode css-mode javascript-mode js-mode js2-mode))
     "Webcodes"
     )
    ((memq major-mode
           '(help-mode apropos-mode Info-mode Man-mode))
     "Help"
     )
    ((memq major-mode
           '(rmail-mode
             rmail-edit-mode vm-summary-mode vm-mode mail-mode
             mh-letter-mode mh-show-mode mh-folder-mode
             gnus-summary-mode message-mode gnus-group-mode
             gnus-article-mode score-mode gnus-browse-killed-mode))
     "Mail"
     )
    (t
     ;; Return `mode-name' if not blank, `major-mode' otherwise.
     (if (and (stringp mode-name)
              ;; Take care of preserving the match-data because this
              ;; function is called when updating the header line.
              (save-match-data (string-match "[^ ]" mode-name)))
         mode-name
       (symbol-name major-mode))
     ))))

;;;; 设置tabbar外观
;; 设置默认主题: 字体, 背景和前景颜色，大小
(set-face-attribute 'tabbar-default nil
                    :underline nil
                    :strike-through nil
                    :stipple nil
                    :box nil
                    :family "Screen"
                    :foreground "#657B83"
                    :background "#fdf6e3"
                    :height 0.6
                    )
;; 设置左边按钮外观：外框框边大小和颜色
(set-face-attribute 'tabbar-button nil
                    :inherit 'tabbar-default
		    :height 0.6
                    :box nil)
;; 设置当前tab外观：颜色，字体，外框大小和颜色
(set-face-attribute 'tabbar-selected nil
                    :inherit 'tabbar-default
                    :foreground "#cb4b16"
                    :background "#073642"
                    :box '(:line-width 2 :color "#073642" :style nil)
                    ;; :overline "#80A4CD"
                    ;; :underline "black"
                    ;; :weight 'bold
                    )
;; 设置非当前tab外观：外框大小和颜色
(set-face-attribute 'tabbar-unselected nil
                    :inherit 'tabbar-default
		    :background "#eee8d5"
                    :box '(:line-width 2 :color "#eee8d5")
                    )
;; 设置tab间空白的外观
(set-face-attribute 'tabbar-separator nil
                    :inherit 'tabbar-default
		    :foreground "#859900"
		    :family "OpenLogos"
		    :height 0.8
		    ;; :background "#"
                    ;; :box '(:line-width 2 :color "#eee8d5")
                    )
;; tabbar end here

(require 'highlight-tail)
(setq highlight-tail-colors
		'(("#c1e156" . 0)
		  ("#b8ff07" . 25)
		  ("#00c377" . 60)))
;;(highlight-tail-mode)


;; 最近打开的文件
;;(setq recentf-max-saved-items nil)
;;(recentf-mode 1)
;;(defvar recentf-open-last-file "" "`recentf-open-files-complete'最近打开的文件")
;;(defun recentf-open-files-complete ()
;;  (interactive)
;;  (let* ((all-files recentf-list)
;;         (default (file-name-nondirectory (directory-file-name recentf-open-last-file)))
;;         (collection (mapcar (function (lambda (x) (cons (file-name-nondirectory (directory-file-name x)) x))) all-files))
;;         (prompt (if (string= default "") "文件名或目录名: " (format "文件名或目录名(缺省为%s): " default)))
;;         (file ""))
;;    (while (string= file "")
;;         (setq file (completing-read prompt collection nil t nil nil default)))
;;    (find-file (setq recentf-open-last-file (cdr (assoc-ignore-representation file collection))))))
;;(global-set-key [(control x)(control r)] 'recentf-open-files-complete-sb)
;;(define-key recentf-dialog-mode-map (kbd "n") 'widget-forward)
;;(define-key recentf-dialog-mode-map (kbd "j") 'widget-forward)
;;(define-key recentf-dialog-mode-map (kbd "p") 'widget-backward)
;;(define-key recentf-dialog-mode-map (kbd "k") 'widget-backward)

;; 记录打开的目录到recentf里面去
;;(defun recentf-add-dir ()
;;  "Add directory name to recentf file list."
;;  (recentf-add-file dired-directory))

;;(add-hook 'dired-mode-hook 'recentf-add-dir)


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
;;(define-key global-map "\C-cl" 'org-store-link)
;;(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(autoload 'remember "remember" nil t)
(autoload 'remember-region "remember" nil t)
(setq org-reverse-note-order t)
(when (file-exists-p "~/gtd/")
  (define-key global-map [(f14)] 'remember)
  (setq remember-annotation-functions '(org-remember-annotation))
  (setq remember-handler-functions '(org-remember-handler))
  (add-hook 'remember-mode-hook 'org-remember-apply-template)

  (setq org-directory "~/gtd/")
  (setq org-remember-templates
        `((?t "* TODO %?\n  %i"
              ,(expand-file-name "todo.org" org-directory) "Tasks")
          (?m "* %U\n\n  %?%i\n  %a"
              ,(expand-file-name "notes.org" org-directory) "Notes")))

  (let ((todo (expand-file-name "todo.org" org-directory)))
    (when (file-exists-p todo)
      (add-to-list 'org-agenda-files todo))))

(require 'xcscope)
;; 中国象棋
(require 'chinese-chess-pvc)
;;(require 'ange-ftp)
(require 'tramp)
(setq auto-save-default nil)
(require 'epa) ;;使用EasyPG

(defun wl-sudo-find-file (file dir)
  (find-file (concat "/sudo:localhost:" (expand-file-name file dir))))
(require 'find-func)
(find-function-setup-keys)

;; flymake
(require 'flymake)
(autoload 'flymake-find-file-hook "flymake" "" t)
;; (add-hook 'find-file-hook 'flymake-find-file-hook)
(setq flymake-allowed-file-name-masks '())
(setq flymake-gui-warnings-enabled nil)
(setq flymake-log-level 0)
(setq flymake-no-changes-timeout 5.0)
(setq flymake-master-file-dirs
      '("." "./src" "../src" "../../src"
        "./source" "../source" "../../source"
        "./Source" "../Source" "../../Source"
        "./test" "../test" "../../test"
        "./Test" "../Test" "../../Test"
        "./UnitTest" "../UnitTest" "../../UnitTest"))

(defvar flymake-mode-map (make-sparse-keymap))
(define-key flymake-mode-map (kbd "C-c <f4>") 'flymake-goto-next-error)
(define-key flymake-mode-map (kbd "C-c <S-f4>") 'flymake-goto-prev-error)
(define-key flymake-mode-map (kbd "C-c <C-f4>")
  'flymake-display-err-menu-for-current-line)
(or (assoc 'flymake-mode minor-mode-map-alist)
    (setq minor-mode-map-alist
          (cons (cons 'flymake-mode flymake-mode-map)
                minor-mode-map-alist)))
(defadvice flymake-goto-prev-error (after display activate)
  (message (get-char-property (point) 'help-echo)))
(defadvice flymake-goto-next-error (after display activate)
  (message (get-char-property (point) 'help-echo)))

(when (executable-find "texify")
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.tex\\'" flymake-simple-tex-init))
  (add-to-list 'flymake-allowed-file-name-masks
               '("[0-9]+\\.tex\\'"
                 flymake-master-tex-init flymake-master-cleanup)))

(when (executable-find "xml")
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.xml\\'" flymake-xml-init))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.html?\\'" flymake-xml-init)))

(when (executable-find "perl")
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.p[ml]\\'" flymake-perl-init)))

(when (executable-find "php")
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.php[345]?\\'" flymake-php-init)))

(when (executable-find "make")
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.idl\\'" flymake-simple-make-init))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.java\\'"
                 flymake-simple-make-java-init flymake-simple-java-cleanup))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.cs\\'" flymake-simple-make-init)))

(defun flymake-elisp-init ()
  (if (string-match "^ " (buffer-name))
      nil
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list
       (expand-file-name invocation-name invocation-directory)
       (list
        "-Q" "--batch" "--eval"
        (prin1-to-string
         (quote
          (dolist (file command-line-args-left)
            (with-temp-buffer
              (insert-file-contents file)
              (emacs-lisp-mode)
              (condition-case data
                  (scan-sexps (point-min) (point-max))
                (scan-error
                 (goto-char(nth 2 data))
                 (princ (format "%s:%s: error: Unmatched bracket or quote\n"
                                file (line-number-at-pos)))))))))
        local-file)))))
;; (add-to-list 'flymake-allowed-file-name-masks '("\\.el$" flymake-elisp-init))
;; (add-hook 'write-file-functions (lambda nil
;; (when (eq major-mode 'emacs-lisp-mode)
;; (check-parens))))

(defcustom flymake-shell-of-choice "sh"
  "Path of shell.")
(defcustom flymake-shell-arguments
  (list "-n")
  "Shell arguments to invoke syntax checking.")
(defun flymake-shell-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list flymake-shell-of-choice
          (append flymake-shell-arguments (list local-file)))))
(when (executable-find flymake-shell-of-choice)
  (add-to-list 'flymake-allowed-file-name-masks '("\\.sh$" flymake-shell-init)))

(defvar flymake-makefile-filenames '("Makefile" "makefile" "GNUmakefile")
  "File names for make.")
(defvar flymake-c-file-arguments
  '(("gcc" ("-I.." "-I../include" "-I../inc" "-I../common" "-I../public"
            "-I../.." "-I../../include" "-I../../inc"
            "-I../../common" "-I../../public"
            "-Wall" "-Wextra" "-pedantic" "-fsyntax-only"))
    ("clang" ("-I.." "-I../include" "-I../inc" "-I../common" "-I../public"
              "-I../.." "-I../../include" "-I../../inc"
              "-I../../common" "-I../../public"
              "-Wall" "-Wextra" "-pedantic" "-fsyntax-only"))
    ("cl" ("/I.." "/I../include" "/I../inc" "/I../common" "/I../public"
           "/I../.." "/I../../include" "/I../../inc"
           "/I../../common" "/I../../public"
           "/EHsc" "/W4" (concat "/Fo" (getenv "TEMP") "\\null.obj") "/c"))))
(defvar flymake-cxx-file-arguments
  '(("g++" ("-I.." "-I../include" "-I../inc" "-I../common" "-I../public"
            "-I../.." "-I../../include" "-I../../inc"
            "-I../../common" "-I../../public"
            "-Wall" "-Wextra" "-pedantic" "-fsyntax-only"))
    ("clang++" ("-I.." "-I../include" "-I../inc" "-I../common" "-I../public"
                "-I../.." "-I../../include" "-I../../inc"
                "-I../../common" "-I../../public"
                "-Wall" "-Wextra" "-pedantic" "-fsyntax-only"))
    ("cl" ("/I.." "/I../include" "/I../inc" "/I../common" "/I../public"
           "/I../.." "/I../../include" "/I../../inc"
           "/I../../common" "/I../../public"
           "/EHsc" "/W4" (concat "/Fo" (getenv "TEMP") "\\null.obj") "/c"))))
(defun flymake-get-compile (arguments)
  (let ((compile nil))
    (while (and (not compile) arguments)
      (let ((arg (car arguments)))
        (if (executable-find (car arg))
            (setq compile arg)
          (setq arguments (cdr arguments)))))
    compile))
(defun flymake-get-c-compile ()
  (flymake-get-compile flymake-c-file-arguments))
(defun flymake-get-cxx-compile ()
  (flymake-get-compile flymake-cxx-file-arguments))
(defun flymake-get-cc-cmdline (source base-dir)
  (let ((args nil)
        (compile (if (string= (file-name-extension source) "c")
                     (flymake-get-c-compile)
                   (flymake-get-cxx-compile))))
    (if compile
        (setq args (list (car compile)
                         (append (car (cdr compile)) (list source))))
      (flymake-report-fatal-status
       "NOMK" (format "No compile found for %s" source)))
    args))
(defun flymake-init-find-makfile-dir (source-file-name)
  "Find Makefile, store its dir in buffer data and return its dir, if found."
  (let* ((source-dir (file-name-directory source-file-name))
         (buildfile-dir nil))
    (catch 'found
      (dolist (makefile flymake-makefile-filenames)
        (let ((found-dir (flymake-find-buildfile makefile source-dir)))
          (when found-dir
            (setq buildfile-dir found-dir)
            (setq flymake-base-dir buildfile-dir)
            (throw 'found t)))))
    buildfile-dir))
(defun flymake-simple-make-cc-init-impl (create-temp-f
                                         use-relative-base-dir
                                         use-relative-source)
  "Create syntax check command line for a directly checked source file.
Use CREATE-TEMP-F for creating temp copy."
  (let* ((args nil)
         (source-file-name buffer-file-name)
         (source-dir (file-name-directory source-file-name))
         (buildfile-dir
          (and (executable-find "make")
               (flymake-init-find-makfile-dir source-file-name)))
         (temp-source-file-name
          (ignore-errors
            (flymake-init-create-temp-buffer-copy create-temp-f))))
    (if temp-source-file-name
        (setq args
              (flymake-get-syntax-check-program-args
               temp-source-file-name
               (if buildfile-dir buildfile-dir source-dir)
               use-relative-base-dir
               use-relative-source
               (if buildfile-dir
                   'flymake-get-make-cmdline
                 'flymake-get-cc-cmdline)))
      (flymake-report-fatal-status
       "TMPERR" (format "Can't create temp file for %s" source-file-name)))
    args))
(defun flymake-simple-make-cc-init ()
  (flymake-simple-make-cc-init-impl 'flymake-create-temp-inplace t t))
(defun flymake-master-make-cc-init (get-incl-dirs-f
                                    master-file-masks
                                    include-regexp)
  "Create make command line for a source file
 checked via master file compilation."
  (let* ((args nil)
         (temp-master-file-name
          (ignore-errors
            (flymake-init-create-temp-source-and-master-buffer-copy
             get-incl-dirs-f
             'flymake-create-temp-inplace
             master-file-masks
             include-regexp))))
    (if temp-master-file-name
        (let* ((source-file-name buffer-file-name)
               (source-dir (file-name-directory source-file-name))
               (buildfile-dir
                (and (executable-find "make")
                     (flymake-init-find-makfile-dir temp-master-file-name))))
          (setq args (flymake-get-syntax-check-program-args
                      temp-master-file-name
                      (if buildfile-dir buildfile-dir source-dir)
                      nil
                      nil
                      (if buildfile-dir
                          'flymake-get-make-cmdline
                        'flymake-get-cc-cmdline))))
      (flymake-report-fatal-status
       "TMPERR" (format "Can't create temp file for %s" source-file-name)))
    args))
(defun flymake-master-make-cc-header-init ()
  (flymake-master-make-cc-init
   'flymake-get-include-dirs
   '("\\.cpp\\'" "\\.c\\'")
   "[ \t]*#[ \t]*include[ \t]*\"\\([[:word:]0-9/\\_.]*%s\\)\""))
(when (or (executable-find "make")
          (flymake-get-c-compile)
          (flymake-get-cxx-compile))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.\\(?:h\\(?:pp\\)?\\)\\'"
                 flymake-master-make-cc-header-init flymake-master-cleanup))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.\\(?:c\\(?:pp\\|xx\\|\\+\\+\\)?\\|CC\\)\\'"
                 flymake-simple-make-cc-init)))


;; (when (executable-find "pyflakes")
;;   (defun flymake-pyflakes-init ()
;;     (let* ((args nil)
;;            (temp-file (ignore-errors (flymake-init-create-temp-buffer-copy
;;                                       'flymake-create-temp-inplace))))
;;       (if temp-file
;;           (let ((local-file (file-relative-name
;;                              temp-file
;;                              (file-name-directory buffer-file-name))))
;;             (setq args (list "pyflakes" (list local-file))))
;;         (flymake-report-fatal-status
;;          "TMPERR" (format "Can't create temp file")))
;;       args))
;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" flymake-pyflakes-init)))

(defun flymake-pylint-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name
		      temp-file
		      (file-name-directory buffer-file-name))))
    (list "epylint" (list local-file))))

(add-to-list 'flymake-allowed-file-name-masks '("\\.py\\'" flymake-pylint-init))

(defun flymake-php-init ()
  "Use php to check the syntax of the current file."
  (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
	 (local (file-relative-name temp (file-name-directory buffer-file-name))))
    (list "php" (list "-f" local "-l"))))

(add-to-list 'flymake-err-line-patterns
  '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))

(add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))

;; Drupal-type extensions
(add-to-list 'flymake-allowed-file-name-masks '("\\.module$" flymake-php-init))
(add-to-list 'flymake-allowed-file-name-masks '("\\.install$" flymake-php-init))
(add-to-list 'flymake-allowed-file-name-masks '("\\.inc$" flymake-php-init))
(add-to-list 'flymake-allowed-file-name-masks '("\\.engine$" flymake-php-init))

(add-hook 'php-mode-hook (lambda () (flymake-mode 1)))
(define-key php-mode-map '[M-S-up] 'flymake-goto-prev-error)
(define-key php-mode-map '[M-S-down] 'flymake-goto-next-error)

(defun flymake-css-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name
		      temp-file
		      (file-name-directory buffer-file-name))))
    (list "cssparse" (list local-file))))
(add-to-list 'flymake-allowed-file-name-masks '("\\.css$" flymake-css-init))
(add-to-list 'flymake-err-line-patterns
	     '("\\(.*\\) \\[\\([0-9]+\\):\\([0-9]+\\): \\(.*\\)\\]"
	       nil 2 3 1))
(add-hook 'css-mode-hook (lambda () (flymake-mode t)))

(defun flymake-html-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name
		      temp-file
		      (file-name-directory buffer-file-name))))
    (list "tidy" (list "-utf8" "--fix-uri" "no" local-file))))

(add-to-list 'flymake-allowed-file-name-masks '("\\.html$\\|\\.ctp" flymake-html-init))

(add-to-list 'flymake-err-line-patterns
	     '("line \\([0-9]+\\) column \\([0-9]+\\) - \\(Warning\\|Error\\): \\(.*\\)"
	       nil 1 2 4))


(defconst flymake-allowed-js-file-name-masks '(("\\.json$" flymake-js-init)
					       ("\\.js$" flymake-js-init)))
(defcustom flymake-js-detect-trailing-comma t nil :type 'boolean)
(defvar flymake-js-err-line-patterns '(("^\\(.+\\)\:\\([0-9]+\\)\: \\(SyntaxError\:.+\\)\:$" 1 2 nil 3)))
(when flymake-js-detect-trailing-comma
  (setq flymake-js-err-line-patterns (append flymake-js-err-line-patterns
					     '(("^\\(.+\\)\:\\([0-9]+\\)\: \\(strict warning: trailing comma.+\\)\:$" 1 2 nil 3)))))

(defun flymake-js-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name
		      temp-file
		      (file-name-directory buffer-file-name))))
    (list "js-config" (list "-s" local-file))))
(defun flymake-js-load ()
  (interactive)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-js-file-name-masks))
  (setq flymake-err-line-patterns flymake-js-err-line-patterns)
  (flymake-mode t))

(add-hook 'javascript-mode-hook '(lambda () (flymake-js-load)))

;; cedet配置
;;(require 'cedet)
;;(require 'semantic-ia)
;; Enable EDE (Project Management) features
;;(global-ede-mode 1)
;;(semantic-load-enable-excessive-code-helpers)
;;(semantic-load-enable-semantic-debugging-helpers)
;; Enable SRecode (Template management) minor-mode.
;;(global-srecode-minor-mode 1)

;; ecb代码浏览器
;;(require 'ecb-autoloads)
;;(defun ecb ()
;;  "启动ecb"
;;  (interactive)
;;  (ecb-activate)
;  (ecb-layout-switch "left9"))

;;(require 'cedet)
;;(require 'ecb)
;;(setq ecb-options-version "2.40")
;;(setq ecb-layout-name "left2")
;;(setq ecb-compile-window-height 10)
;;(add-hook 'ecb-activate-hook
;;          (lambda ()
;;            (ecb-toggle-compile-window -1)))
;;(setq ecb-vc-enable-support t)
;;(setq ecb-tip-of-the-day nil)

(defun reload-dotemacs-file ()
    "reload your .emacs file without restarting Emacs"
    (interactive)
    (load-file "~/.emacs"))

;;session和desktop插件,需要放在最后
;;(require 'session)
;;(add-hook 'after-init-hook 'session-initialize)
;;(desktop-save-mode 1)
;;(setq desktop-save-directory "~/.emacs.d/desktop/")
;;(setq desktop-buffers-not-to-save
;;     (concat "\\(" "^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\|^tags\\|^TAGS"
;;      "\\|\\.emacs.*\\|\\.diary\\|\\.newsrc-dribble\\|\\.bbdb" 
;;      "\\)$"))
;;(add-to-list 'desktop-modes-not-to-save 'dired-mode)
;;(add-to-list 'desktop-modes-not-to-save 'Info-mode)
;;(add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
;;(add-to-list 'desktop-modes-not-to-save 'fundamental-mode)
