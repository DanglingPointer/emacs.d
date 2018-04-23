;; Use ibuffer instead of default one
(global-set-key (kbd "C-x C-b") 'ibuffer)


;; Show line numbers
(global-linum-mode t)


;; Add sources
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)


;; Auto install packages
(dolist (package '(package clang-format ggtags))
 (unless (package-installed-p package)
   (package-install package)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; Load theme: zenburn/flatland/busybee
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'zenburn t)


;; Set Consolas font
(set-frame-font "Consolas-12.5")


;; Highlight matching parentheses
(show-paren-mode 1)


;; No indentation within namespaces in c++-mode
(defun my-cpp-setup ()
  (c-set-offset 'innamespace [0]))
(add-hook 'c++-mode-hook 'my-cpp-setup)


;; Open headers in c++-mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))


;; Python indent is 3
(setq python-indent-offset 3)


;; Activate windmove keybindings
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))


;; Window switching keybindings (like i3)
(global-set-key (kbd "C-s-j")  'windmove-left)
(global-set-key (kbd "C-s-ø") 'windmove-right)
(global-set-key (kbd "C-s-;") 'windmove-right)
(global-set-key (kbd "C-s-l")    'windmove-up)
(global-set-key (kbd "C-s-k")  'windmove-down)


;; Window resizing keybindings (like i3)
(global-set-key (kbd "C-M-s-j") 'shrink-window-horizontally)
(global-set-key (kbd "C-M-s-ø") 'enlarge-window-horizontally)
(global-set-key (kbd "C-M-s-;") 'enlarge-window-horizontally)
(global-set-key (kbd "C-M-s-k") 'shrink-window)
(global-set-key (kbd "C-M-s-l") 'enlarge-window)


;; Put auto-saved and backup files to /tmp/
(setq backup-directory-alist
      `(("." . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `(("^(.+\/)" ,temporary-file-directory nil)))


;; Toggle between beginning-of-indentation and beginning-of-line when pressing C-a
(defun move-smart-beginning-of-line ()
  "Move point to `beginning-of-line'. If repeat command it cycle
position between `back-to-indentation' and `beginning-of-line'."
  (interactive "^")
  (if (eq last-command 'move-smart-beginning-of-line)
      (if (= (line-beginning-position) (point))
	  (back-to-indentation)
	(beginning-of-line)) ; inner else
    (back-to-indentation))) ; outer else

(global-set-key (kbd "C-a") 'move-smart-beginning-of-line)


;; clang-format
(load "/home/mikhailv/.emacs.d/elpa/clang-format-20180406.814/clang-format.el")
(require 'clang-format)
(setq clang-format-style-option "file")
(setq clang-format-executable "clang-format-5.0")
(global-set-key [C-M-tab] 'clang-format-buffer)


;; ggtags-mode (automatically on for c, c++ and java)
(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))
(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)
