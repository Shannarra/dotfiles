# dotfiles
Collection of my dotfiles

Just drag-and-drop in `~`

### Terminal
I am using a TerMinal MultipleXer (TMUX) in my day-to-day development life.

#### Installation
To install it, you can just do:

```console
sudo apt install tmux
```
On Debian-based systems. For other distros you can refer to [tmux installing wiki](https://github.com/tmux/tmux/wiki/Installing).

#### Configuration
Configuring is as simple as just copy-pasting the `.tmux.conf` and `.tmux.color.conf` files into the `~` folder and running the following command:

```console
tmux source-file ~/.tmux.conf
```

#### Custom bindings
MOD key has been set to `C-x`, same as EMACS.

Reloading the configuration can be done using `$MOD-r`.

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
`workdir` => changes directory to one specified by the user. To set it up just change the [`PROJECT_DIR=`](https://github.com/Shannarra/dotfiles/blob/master/.bashrc#L134) variable on line 134.
`clear_port` => clears a given port, killing all processes occupying it. Especially useful for web development.
