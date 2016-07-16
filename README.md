# Bash-note

Bash-note will run only on GNU/Linux.

Before running the script you should open it and check config section for set options. The most important is `note_root_dir` which is the directory where you store markdown notes.

Bash-note is as set of small scripts called modules.

There are two types of modules:  
1) Modules ran by running bash-note with specific argument;  
2) Modules ran by file system watcher for specific file types.

## 1. Modules ran by command line argument 

### Dependancy check
Dependancies: none  
Usage: `bash-note -d`

Shows the names of packages requred by each module and checks if needed binaries are already present. 
Good to check at first run.

### Import settings
Dependancies: none  
Usage: `bash-note -i FILE` 

Import Bash-note settings from FILE. This module is useful for updating Bash-note:  
1) Rename old version of bash-note to `bash-note.old` (or any other name);  
2) Put a new version file to the directory;  
3) Run `bash-note -i bash-note.old`  and all existing settings will be imported to the new script.

I'll try making it less manual in the future releases.

### Clipnote
Dependancies: xclip, iconv, pandoc, wget  
Usage: 
```
bash-note -c              Run Clipnote module with inbox file set in config section
bash-note -c FILE         Run Clipnote module with FILE as inbox file
``` 

Clipnote copies text block selected in any application (browser, text editor, etc.) to the note file set in config section or by command line arguments. 

The best way to use it is binding `bash-note -c` to a keystroke using you DE intruments and then using it as you use clipboard. I use it assigned to `Win+C`.

When used with browser Clipnote will also copies all images in selection.

1) Select any part of web page or document, including images;  
2) Run `bash-note -c` by keystroke or in terminal;  
3) The text block is in your note.  

By setting `FILE` with command line argument you can have different keystrokes for different note files.


## 2. File system watcher

Dependancies: inotify-tools  
Usage: 
```
bash-note                 Run file system watcher for directory set in config section 
bash-note -w DIRECTORY    Run file system watcher for DIRECTORY
```

File system watcher uses inotify events to watch for all file changes in directory set as note root in config section of the script or by command line arguments. It works only while the script is continuously running.

File system watcher passes the name and type of changed files to other modules. Each module dependant on File system watcher process only the files of specific types. More info on this modules below.

### Web2note
Dependencies: iconv, pandoc  
Processed files: web pages and their "_files" directories saved to any directory inside note root

Web2note converts web page saved by browser to markdown note file with same name. 

Modern web pages are very cluttered. The easiest way to get a clear note is saving a web page from the "Reader view" of your browser.

There are two Firefox extensions that make the usage of this module more efficient:  
[Open in Reader View](https://addons.mozilla.org/ru/firefox/addon/reader-view/) by rNeomy - adds new context menu items to use "Reader view" even on pages Firefox doesn't allow to.  
[Save File to](https://addons.mozilla.org/ru/firefox/addon/save-file-to/) by Atte Kemppilä - adds new context menu items to quickly save web page to desired directory. 

With this two extensions the experience of using Web2note is close to the one of web clippers. Reader mode removes all the clutter and "save to" context menu allows to save web page to any directory in 2 clicks.

1) Open web page in browser;  
2) (Optional) Use "Reader view";  
3) Save web page to any directory inside note root;  
4) It's a markdown note now.

### Fast notes merger
Dependencies: none  
Processed files: files with extensions set in config section inside the script, default is `txt`

Fast notes merger made mainly to put many short notes made on the phone to one place. 

It adds the content of all files with selected extension to one note set in config section. Each entry begins with date and time the fast note was created. The fast notes files are deleted after being merged.
