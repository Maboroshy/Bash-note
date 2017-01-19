# Bash-note

Bash-note is as shell script for GNU/Linux to help you dealing with plain-text markdown notes.

Bash-note can:
- Paste selected text blocks to markdown note, images included;
- Convert web pages to markdown notes;
- Merge "fast notes" into single "inbox" note in a smart manner;
- Process/convert markdown links.

Paired with [QOwnNotes](https://github.com/pbek/QOwnNotes) and the special script for that app, Bash-note knows the note currently opened in QOwnNotes and can paste selected text there without openning QOwnNotes itself. Make sure you've put path to Bash-note file to the QOwnNotes script file. There is more information about QOwnNotes script at the end of this readme.

Before running the script you should open it and check config section for set options. The most important is `note_root_dir` which is the directory where you store markdown notes.  
This directory can be a symlink, anything inside it however should be real files or hardlinks.

## Using Bash-note

You can see all possbile Bash-note command line arguments by running `bash-note -h`. 
This also shows if all requered binaries/packages are present in the system. 

Bash-note requeres: xclip, gettext, pandoc, wget, inotify-tools, jhead.

### Import settings from previous version
Deficiencies: none  
Usage: `bash-note -i FILE` 

Imports Bash-note settings from FILE. This is useful for updating Bash-note:  
1) Rename old version of bash-note to `bash-note.old` (or any other name);  
2) Put a new version file to the directory;  
3) Run `bash-note -i bash-note.old` and all existing settings will be imported to the new script.

### Paste selected text to markdown note
Dependencies: xclip, iconv, pandoc, wget  
Usage: 
```
bash-note -c t       Add selected text or part of web page to the top of the inbox file set
bash-note -c b       Add selected text or part of web page to the bottom of the inbox file
bash-note -c td      Add current date, time and selected text to the top of the inbox file
bash-note -c bd      Add current date, time and selected text to the bottom of the inbox file
bash-note -c t FILE  Add selected text or part of web page to the top of a FILE, 
                     Same for other -c commands
``` 

1) Select any part of web page or document, including images;  
2) Run `bash-note -c td` by binded key shortcut or in terminal;  
3) The text block is in your note. 

Bash-note can paste text block selected in any application (browser, text editor, etc.) to the note file set in config section or by command line arguments. When used with browser Clipnote will also paste all images in selection.

The provided QOwnNotes script will continously change note in config secion to currently opened note.

The best way to use it is binding `bash-note -c td` to a key shortcut using you DE instruments or third-party app, and then using it as you use clipboard. I use it assigned to `Win+C`. You can also assign other keys, like `Win+V`, to a `bash-note -c td FILE` to put selected text to that predefined FILE.

If selected text is web URL, Bash-note considers it as "bookmark" and pastes URL target title and icon as a link to that URL.

### Convert web pages to markdown notes
Dependencies: iconv, pandoc  
Usage: by "file scanner" with `bash-note -s` for single run or `bash-note -w` for continious directory watch.  
Processed files: web pages and their "_files" directories saved to any directory inside note root.

1) Open web page in browser;  
2) (Optional) Use "Reader view";  
3) Save web page to any directory inside note root;  
4) Run Bash-note file scanner by `bash-note -s` or `bash-note -w`;  
5) Web page is a markdown note now.

Bash-note will convert any web page it finds in note root directory to a markdown note.  
The note will have the same name as web page and will be stored in the same sub-directory.  

Modern web pages are very cluttered. The easiest way to get a clean note is saving a web page from the "Reader view" of your browser. Then you can save web page to a desired sub-folder. It will be converted by Bash-note's file scanner.

There are two Firefox extensions that make the usage of this module more efficient:  
[Save File to](https://addons.mozilla.org/en/firefox/addon/save-file-to/) by Atte Kemppilä - adds new context menu items to quickly save web page to desired directory.  
[Stylish](https://addons.mozilla.org/en/firefox/addon/stylish/?src=search) with [Reader Mode Button Always Visible](https://userstyles.org/styles/123290/reader-mode-button-always-visible) userstyle - forces "Reader view" for every page or  
[Open in Reader View](https://addons.mozilla.org/en/firefox/addon/reader-view/) by rNeomy - adds context menu items to use "Reader view" even on pages Firefox doesn't allow to. 

With this extensions the experience of using Bash-note with browser is close to the one of web clippers. Reader mode removes all the clutter and "save to" context menu allows to save web page to any directory by 2 clicks.

### Merge "fast notes" into single "inbox" note
Dependencies: jhead  
Usage: by "file scanner" with `bash-note -s` for single run or `bash-note -w` for continious directory watch.  
Processed files: images and files with set extension (default is `.txt`) put to set "inbox" directory.

1) Run Bash-note file scanner by `bash-note -s` or `bash-note -w`;  
2) Put file with set extension (default is `txt`) or an image to the set inbox directory;  
3) File's content added to the set inbox note file.

Bash-note is supposed to help manage small notes made on the run, which I call "fast notes".  
This notes should have different extension (default is `.txt`) than the main notes (default is `.md`).  
Bash-note will process only "fast notes" put to specific "inbox" directory which can be set in the Bash-note file.

If "fast note" is web URL, Bash-note considers it as "bookmark" and get URL target title and icon as a link to that URL.

Any image put to "inbox" note, like the photo of some document or phone number, will be considered as "fast note" too. 

Bash-note will put the content of all the "fast note" to a single note set in the Bash-note file and then delete them.

"Fast notes" can be tagged by putting words beggining with symbols set in config section of Bash-note to the text. Default is `,,`. Tags can't have spaces. There can be multiple tags.  
The "fast note" with a tag will be merged to the file with the same name.  
So if you want to note some idea about using bash-note, you can put `,,bash-note` after your idea. All such notes will be merged to a single `bash-note.md`.

### Process markdown links
Dependencies: none  
Usage: `bash-note -l`

Bash-note can parse and process links and linked files with various methods. Bash-note will scan all notes in note root directory set in Bash-note file unless the specific directory provided by command line arguments.

There is an interactive mode, where you can choose how you want to use it, with all necessary information and action confirmations. You can run it with `bash-note -l`. 

Before each run Bash-note scans note root directory parsing notes for links and getting info about every link. The scan can take a while. You can run the parser in test mode for verbose output and benchmarking with `bash-note -l t`. It won't write anything to files in this mode.

All commands available in interactive mode can be run with command line arguments after `bash-note -l`. The command run that way will ask no confirmation.

So, if you want to cleanup your media directory from unused images you can:  
1) Run `bash-note -l`;  
2) Type `c` and press Enter;  
3) Confirm action by typing `y` and pressing Enter.

Or you can make all the following by running `bash-note -l c`.

Some actions like conversion of links have a verbose test run mode that can be run on the confirmation stage by typing `t` instead of confirming `y`. This test also won't write anything.

Run `bash-note -h` to see all command line arguments.

## Bash-note helper QOwnNotes script

TODO
