#!/usr/bin/env sbcl --script

(setf *random-state* (make-random-state t))

(defun file->list (filename)
    "This shit will be awesome"
    (with-open-file (stream filename :if-does-not-exist nil)
        (loop
           for line = (read-line stream nil 'eof)
           until (eq line 'eof)
           collect line)))

(defun multiple-nth (indices alist)
  (loop
    for index in indices
    collect (nth index alist)))

(defun join-string-list (string-list)
  "Concatenates a list of strings and puts spaces between the elements."
  (format nil "~{~A~^ ~}" string-list))

(defun generate-passphrase (filename)
    (let* ((words (file->list "wordlist.txt"))
           (word-size (length words)))
        (join-string-list (multiple-nth (list (random word-size)
                                              (random word-size)
                                              (random word-size)
                                              (random word-size)) words))))

(print (generate-passphrase "wordlist.txt"))
