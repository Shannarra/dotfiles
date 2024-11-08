;;; php-mode-debug.el --- Debug functions for PHP Mode  -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Friends of Emacs-PHP development

;; Author: USAMI Kenta <tadsan@zonu.me>
;; URL: https://github.com/emacs-php/php-mode
;; Keywords: maint
;; Version: 1.24.1
;; License: GPL-3.0-or-later

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Provides functions to debugging php-mode work.

;;; Code:
(require 'cc-mode)
(require 'cus-edit)
(require 'php-mode)
(require 'package)
(require 'pkg-info nil t)

(declare-function pkg-info-version-info "pkg-info" (library &optional package show))

(defun php-mode-debug--buffer (&optional command &rest args)
  "Return buffer for php-mode-debug, and execute `COMMAND' with `ARGS'."
  (with-current-buffer (get-buffer-create "*PHP Mode DEBUG*")
    (cl-case command
      (init (erase-buffer)
            (goto-address-mode))
      (top (goto-char (point-min)))
      (insert (goto-char (point-max))
              (apply #'insert args)))
    (current-buffer)))

(defun php-mode-debug--message (format-string &rest args)
  "Write message `FORMAT-STRING' and `ARGS' to debug buffer, like `message'."
  (declare (indent 1))
  (php-mode-debug--buffer 'insert (apply #'format format-string args) "\n"))

(defun php-mode-debug ()
  "Display informations useful for debugging PHP Mode."
  (interactive)
  (unless (eq major-mode 'php-mode)
    (user-error "Invoke this command only in php-mode buffer"))
  (php-mode-debug--buffer 'init)
  (php-mode-debug--message "Feel free to report on GitHub what you noticed!")
  (php-mode-debug--message "https://github.com/emacs-php/php-mode/issues/new")
  (php-mode-debug--message "")
  (php-mode-debug--message "Pasting the following information on the issue will help us to investigate the cause.")
  (php-mode-debug--message "```")
  (php-mode-debug--message "--- PHP-MODE DEBUG BEGIN ---")
  (php-mode-debug--message "versions: %s; %s; Cc Mode %s)" (emacs-version) (php-mode-version) c-version)
  (php-mode-debug--message "package-version: %s"
    (if (fboundp 'pkg-info)
        (pkg-info-version-info 'php-mode)
      (let ((pkg (and (boundp 'package-alist)
                      (cadr (assq 'php-mode package-alist)))))
        (when (and pkg (member (package-desc-status pkg) '("unsigned" "dependency")))
          (package-version-join (package-desc-version pkg))))))

  (php-mode-debug--message "major-mode: %s" major-mode)
  (php-mode-debug--message "minor-modes: %s"
    (cl-loop for s in minor-mode-list
             unless (string-match-p "global" (symbol-name s))
             if (and (boundp s) (symbol-value s))
             collect s))
  (php-mode-debug--message "variables: %s"
    (cl-loop for v in '(indent-tabs-mode tab-width)
             collect (list v (symbol-value v))))
  (php-mode-debug--message "custom variables: %s"
    (cl-loop for (v type) in (custom-group-members 'php nil)
             if (eq type 'custom-variable)
             collect (list v (symbol-value v))))
  (php-mode-debug--message "c-indentation-style: %s" c-indentation-style)
  (php-mode-debug--message "c-style-variables: %s"
    (cl-loop for v in c-style-variables
             unless (memq v '(c-doc-comment-style c-offsets-alist))
             collect (list v (symbol-value v))))
  (php-mode-debug--message "c-doc-comment-style: %s" c-doc-comment-style)
  (php-mode-debug--message "c-offsets-alist: %s" c-offsets-alist)
  (php-mode-debug--message "buffer: %s" (list :length (save-excursion (goto-char (point-max)) (point))))
  (php-mode-debug--message "--- PHP-MODE DEBUG END ---")
  (php-mode-debug--message "```\n")
  (php-mode-debug--message "Thank you!")
  (pop-to-buffer (php-mode-debug--buffer 'top)))

(provide 'php-mode-debug)
;;; php-mode-debug.el ends here
