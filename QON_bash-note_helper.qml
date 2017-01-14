import QtQml 2.0
import com.qownnotes.noteapi 1.0

QtObject {
    
    // Put absolute path to bash-note script file here
    property var bashNote:"/storage/emulated/0/notes/bash-note";
    
    property var lastOpenedNote:null;
    
    function noteOpenedHook(note) {
        
        if (note.fullNoteFilePath != lastOpenedNote){ 
            var replaceCommand = "0,/^clipnote_inbox_file_name=/ s|^clipnote_inbox_file_name=.*|clipnote_inbox_file_name='" + note.fullNoteFilePath + "'|";
            var arguments = ["-i",replaceCommand,bashNote];
            script.startDetachedProcess("sed", arguments);
            script.log("Bash-note: current note set to " + note.fullNoteFilePath);
        }
        
        lastOpenedNote = note.fullNoteFilePath;
    }

    function init() {
        script.registerCustomAction("runBashNote", "Scan this folder with Bash-note", "Scan this folder with Bash-note", "system-run-symbolic.svg");
        script.registerCustomAction("setFolder", "Set folder as note root");
        script.registerCustomAction("setFastnotesInbox", "Set note as Fast notes inbox");
        script.registerCustomAction("editBashNote", "Edit Bash-note file", "Edit", "format-text-code.svg");
    }

    function customActionInvoked(identifier) {
       
        switch (identifier) {
            
            case "runBashNote":
                var folder = script.currentNoteFolderPath();
                var arguments = [bashNote,"-s",folder]
                script.startDetachedProcess("bash", arguments);
                script.log("Bash-note: Scanning " + folder);
                break;
                
            case "setFolder":
                var folder = script.currentNoteFolderPath();
                var replaceCommand = "0,/^note_root_dir=/{s|^note_root_dir=.*|note_root_dir='" + folder + "'|}";
                var arguments = ["-i",replaceCommand,bashNote];
                script.startDetachedProcess("sed", arguments);
                script.log("Bash-note: Note root folder set to " + folder);
                break;
                
            case "setFastnotesInbox":
                var note = script.currentNote();            
                var replaceCommand = "0,/^fast_notes_inbox_file_name=/{s|^fast_notes_inbox_file_name=.*|fast_notes_inbox_file_name='" + note.fullNoteFilePath + "'|}";
                var arguments = ["-i",replaceCommand,bashNote];
                script.startDetachedProcess("sed", arguments);
                script.log("Bash-note: Fast notes inbox set to " + note.fullNoteFilePath);
                break;
                
            case "editBashNote":
                script.startDetachedProcess("kwrite", bashNote);
                break;
        }
    }
}

 
