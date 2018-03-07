;;; try-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "try" "try.el" (23200 25454 15551 539000))
;;; Generated autoloads from try.el

(autoload 'try-and-refresh "try" "\
Refreshes package-list before calling `try'.

\(fn)" t nil)

(autoload 'try "try" "\
Try out a package from your `package-archives' or pass a URL
to a raw .el file. Packages are stored in `try-tmp-dir' and raw
.el files are not stored at all.

\(fn &optional URL-OR-PACKAGE)" t nil)

;;;***

;;;### (autoloads nil nil ("try-pkg.el") (23163 47776 899613 587000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; try-autoloads.el ends here
