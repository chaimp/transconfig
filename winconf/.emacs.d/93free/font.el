;; 设置字体
(set-default-font "Envy Code R-10")
(set-fontset-font (frame-parameter nil 'font)
  'han '("Microsoft YaHei" . "unicode-bmp"))
(set-fontset-font (frame-parameter nil 'font)
  'japanese-jisx0208 '("Microsoft YaHei" . "unicode-bmp"))
(set-fontset-font (frame-parameter nil 'font)
  'symbol '("Microsoft Yahei" . "unicode-bmp"))
(set-fontset-font (frame-parameter nil 'font)
  'cjk-misc '("Microsoft Yahei" . "unicode-bmp"))
(set-fontset-font (frame-parameter nil 'font)
  'bopomofo '("Microsoft Yahei" . "unicode-bmp"))
(global-font-lock-mode t)
;; --------------------------------
;; 字体设置结束
