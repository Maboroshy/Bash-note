Bash-note changelog
=========

### 30.09.2016
- Non-ascill URL adress are now decoded to a proper unicode instead of `%D0%AF`-like.
- Web2note module now doesn't include Firefox reader toolbar html code to note.

### 23.08.2016 
- New option to scan all files before starting file system watcher;  
- New option for bash-note to generate absolute or relative links while processing notes;  
- Added entry type for Fast notes merger and Clipnote - bookmark with web page title handling;  
- Fast note merger now use headers as entry titles;  
- Clipnote has an option to add headers to an entry like Fast note merger does;    
- Fixed some broken things in Relink module;  
- Other minor enhancements.

### 01.08.2016 
- Added Relink module that can convert links and cleanup media dirctory of unused files;  
- Fast note merger module now process images put to inbox directory and has a sefety check for file extensions;  
- There's an option for auto-rotation of such images based on EXIF orientation to correctly display them in QOwnNotes and other apps that don't use EXIF orientation themselve;  
- Added limited support for symlinks - directories set on config can now be symlinks;  
- Fixed bugs when there is "media" in note root path;  
- Other minor enhancements.

### 16.07.2016 
Initial release. 
