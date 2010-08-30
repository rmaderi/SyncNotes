package syncnote;
/**
 * 
 * @author rashmi
 *
 */
public class Note {
	
	private static final long serialVersionUID = 1L;
	private String noteName;
	private String noteContent;
	
	public Note() {}
	
	public Note(String noteName, String noteContent)
	{
		this.noteName = noteName;
		this.noteContent = noteContent;
	}
	
	public String getNoteName() {
		return noteName;
	}
	public void setNoteName(String noteName) {
		this.noteName = noteName;
	}
	public String getNoteContent() {
		return noteContent;
	}
	public void setNoteContent(String noteContent) {
		this.noteContent = noteContent;
	}
	
}
