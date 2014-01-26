#!/usr/bin/env sbcl --script

(setf *random-state* (make-random-state t))

(defun file->list (filename)
  "Read in a file as a list"
  (with-open-file (stream filename :if-does-not-exist nil)
    (loop
      for line = (read-line stream nil 'eof)
      until (eq line 'eof)
      collect line)))

(defun multiple-nth (indices alist)
  "Grab each element at index from a list."
  (loop
    for index in indices
    collect (nth index alist)))

(defun join-string-list (string-list)
  "Concatenates a list of strings and puts spaces between the elements."
  (format nil "~{~A~^ ~}" string-list))

(defun generate-passphrase (filename size)
  (let* ((words (file->list filename))
         (word-size (length words)))
    (string-downcase (join-string-list
                       (multiple-nth
                         (loop repeat size collect (random word-size)) words)))))

(format t "~a" (generate-passphrase "wordlist.txt" 4))
