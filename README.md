# Bash-note

Bash-note is as set of small scripts called modules. 
There are two types of modules: 
1) modules evoked by file system watcher on specific file types;
2) modules evoked by running bash-note with specific argument.

Bash-note stores its settings inside the script file in config section.

Usage:
bash-note                   Run file system watcher for directory set in config section
bash-note -w DIRECTORY      Run file system watcher for DIRECTORY

bash-note -d                List and check module dependencies (binaries used in module)

bash-note -i FILE           Import bash-note settings from FILE

bash-note -c                Run Clipnote module with inbox file set in config section
bash-note -c FILE           Run Clipnote module with FILE as inbox file
