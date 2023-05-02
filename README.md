# dotfiles
Collection of my dotfiles

Just drag-and-drop in `~`

### IDE
I am using [Emacs](https://www.gnu.org/software/emacs/), ergo the `.emacs` files.
If you want to change the font or the font size you can edit the first lines in the .emacs file to something like:
```el
;;; Appearance
(defun rc/get-default-font ()
  (cond
   ((eq system-type 'windows-nt) "TimesNewRoman-13")
   ((eq system-type 'gnu/linux) "ComicSans-20")))
```

And restart Emacs. 

### GHCI
Custom prelute text has been added when running `ghci`.

### BASH
Several custom/utility commands have been added:  
`sfind`   => a wrapper around `grep` excluding most possible utility, log and vendor folders (`node_modules` included)  
`emkdir`  => shorthand for "enter make directory". Creates a directory and enters it in a single command.   
`unzip`   => unzips a tarball.  
`workdir` => changes directory to one specified by the user.  
`clear_port` => clears a given port, killing all processes occupying it. Especially useful for web development.   
