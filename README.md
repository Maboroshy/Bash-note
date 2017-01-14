# Bash-note

Bash-note is as shell script for GNU/Linux to help you dealing with plain-text markdown notes.

Bash-note can:
- Paste selected text blocks to markdown note, images included;
- Convert saved web pages to markdown notes;
- Merge "fast notes" into single inbox note in a smart manner;
- Process/convert markdown links.

Paired with [QOwnNotes](https://github.com/pbek/QOwnNotes) and the special script for that app, Bash-note knows the note currently opened in QOwnNotes and can paste selected text there without openning QOwnNotes itself. Make sure you've put path to Bash-note file to the QOwnNotes script file.

Before running the script you should open it and check config section for set options. The most important is `note_root_dir` which is the directory where you store markdown notes.  
This directory can be a symlink, anything inside it however should be real files or hardlinks.

## Using Bash-note

You can see all Bash-note command line arguments by running `bash-note -h`. 
This also shows if all requred binaries/packages are present in the system. 

Bash-note requres: xclip, gettext, pandoc, wget, inotify-tools, jhead.

### Import settings
Deficiencies: none  
Usage: `bash-note -i FILE` 

Import Bash-note settings from FILE. Thi is useful for updating Bash-note:  
1) Rename old version of bash-note to `bash-note.old` (or any other name);  
2) Put a new version file to the directory;  
3) Run `bash-note -i bash-note.old` and all existing settings will be imported to the new script.

### Clipnote
Dependencies: xclip, iconv, pandoc, wget  
Usage: 
```
bash-note -c            Run Clipnote module with inbox file set in config section
bash-note -c FILE       Run Clipnote module with FILE as inbox file
``` 

1) Select any part of web page or document, including images;  
2) Run `bash-note -c` by keystroke or in terminal;  
3) The text block is in your note. 

Clipnote pastes text block selected in any application (browser, text editor, etc.) to the note file set in config section or by command line arguments. When used with browser Clipnote will also paste all images in selection.

The provided QOwnNotes script will continously change note in config secion to currently opened note.

The best way to use it is binding `bash-note -c` to a keystroke using you DE instruments, and then using it as you use clipboard. I use it assigned to `Win+C`. You can also assign other keys, like `Win+V` to a `bash-note -c FILE` to put selected text to that predefined FILE.

TODO Rewrite later text

### Relink
Dependencies: none  
Usage: `bash-note -l`

Relink is the module that can parse and process links and linked files with various methods. 

It has an interactive mode where you can choose how you want to use it with all necessary information and action confirmations. You can run it with `bash-note -l`. 

Before each run Relinks scans note root directory parsing notes for links and getting info about every link. The scan can take a while. You can run the parser in test mode for verbose output and benchmarking with `bash-note -l test` or `bash-note -l t`. It won't write anything to files in this mode.

All command available in interactive mode can be run with command line arguments after `bash-note -l`. The command run that way will still ask for action confirmation. To surpass the confirmation add extra `force` or `f` argument.

So if you want to cleanup your media directory from unused images you can:  
1) Run `bash-note -l`;  
2) Type `c` or `cleanup` and press Enter;  
3) Confirm action by typing `y` and pressing Enter.

Or you can make all the following by running `bash-note -l cleanup force` or `bash-note -l c f`.

Some actions like conversion of links have a verbose test run mode that can be run on the confirmation stage by typing `t` instead of confirming `y`. Such tests can also be run by adding `test` or `t` as command line argument instead of `force` or `f`. This tests also won't write anything.

Run `bash-note -h` to see all command line arguments.

## 2. Modules ran by file system watcher

### File system watcher
Dependencies: inotify-tools  
Usage: 
```
bash-note                     Run file system watcher for directory set in config section 
bash-note -w DIRECTORY        Run file system watcher for DIRECTORY
```

File system watcher uses inotify events to watch for all file changes in directory set as note root in config section of the script or by command line arguments. It works only while the script is continuously running.

File system watcher passes the name and type of changed files to other modules. Each module dependent on File system watcher process only the files of specific types. More info on this modules below.

### Web2note
Dependencies: iconv, pandoc  
Processed files: web pages and their "_files" directories saved to any directory inside note root

Web2note converts web page saved by browser to markdown note file with same name. 

Modern web pages are very cluttered. The easiest way to get a clear note is saving a web page from the "Reader view" of your browser.

There are two Firefox extensions that make the usage of this module more efficient:  
[Save File to](https://addons.mozilla.org/ru/firefox/addon/save-file-to/) by Atte Kemppilä - adds new context menu items to quickly save web page to desired directory.  
[Open in Reader View](https://addons.mozilla.org/ru/firefox/addon/reader-view/) by rNeomy - adds new context menu items to use "Reader view" even on pages Firefox doesn't allow to. 

With this two extensions the experience of using Web2note is close to the one of web clippers. Reader mode removes all the clutter and "save to" context menu allows to save web page to any directory in 2 clicks.

1) Open web page in browser;  
2) (Optional) Use "Reader view";  
3) Save web page to any directory inside note root;  
4) It's a markdown note now.

### Fast notes merger
Dependencies: jhead  
Processed files: images files with extensions set in config section inside the script, (default is `txt`) put to inbox directory set in config section

Fast notes merger made mainly to put many short notes and "note-like" images made on the phone to one place. 

It adds the content of images and files with selected extension to one note set in config section. Each entry begins with date and time the file was created. The files are deleted after being merged.

To compensate the lack of support for EXIF orientation handling in QOwnNotes the module can optionally rotate processed images according to EXIF data to display them correctly. That is what jhead dependence is for.

1) Put file with set extension (default is `txt`) or an image to the set inbox directory;  
2) See their content added to the set inbox note file.
