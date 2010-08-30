package syncnote;

import java.util.*;
/**
 * 
 * @author rashmi
 *
 */

@SuppressWarnings("unchecked")
public class NoteDirectory {

	private String dirName;
	private List files;
	
	public NoteDirectory() {}
	
	public NoteDirectory(String name) 
	{
		dirName = name;
		files = new ArrayList();
	}

	public String getDirName() {
		return dirName;
	}

	public void setDirName(String dirName) {
		this.dirName = dirName;
	}

	public List getFiles() {
		return files;
	}

	public void setFiles(Note note) {
		this.files.add(note);
	}
	
}
