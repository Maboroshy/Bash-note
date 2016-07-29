Bash-note changelog
=========

**0.2.0**  
- Added Relink module that can parse all links, convert them and cleanup media directory from unused files;  
- Fast note merger module now process images put to inbox directory and has a safety check for file extensions;  
- There's an option for auto-rotation of such images based on EXIF orientation to correctly display them in QOwnNotes and other apps that don't use EXIF orientation themselves, requires jhead as dependency;  
- Added limited support for symlinks - directories set on config can now be symlinks;  
- Fixed bugs when there is "media" in note root path;  
- Other minor enhancements.

**0.1.1**  
Initial release. 
