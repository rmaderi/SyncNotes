package syncnote;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Text;
import com.sun.org.apache.xml.internal.serialize.*;

/**
 * 
 * @author rashmi
 *
 */

/* Gets notes from particular directory */
public class GetDirNotes extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private Document dom;
	private String dirName;

	public void init() throws ServletException
	{
		super.init();
	}

	public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		dirName = request.getParameter("dir");
		System.out.println("--------" + dirName);
		this.GetFolderStructure();
		
  	/* Convert dom to string */
		StringWriter out = new StringWriter(); 
    Serializer serializer = new XMLSerializer(out, new OutputFormat(dom)); 
    ((BaseMarkupSerializer) serializer).serialize(dom); 
    String result = out.toString(); 
    
    System.out.println("--------" + result);
    
    /* Send response */
    response.setContentType("text/xml");
    response.setHeader("Cache-Control", "no-cache");
    response.getWriter().write(result);
	}

	/** Get the SyncNote folder structure */
	
	private void GetFolderStructure() {
		NoteDirectory dir = null;
		StringBuffer content = null;
		
		try {
					dir = new NoteDirectory(dirName);
					File noteDir = new File("/tmp/sync/Notes/" + dirName);
					File [] noteList = noteDir.listFiles();

					if (noteList.length > 0) {
						for ( int j =0 ; j < noteList.length; j++) {
							File f = noteList[j];
							if (f.isFile() && !f.isHidden()) {
								if (f.exists() && f.length() > 0) {
									content = new StringBuffer();
									Scanner scanner = new Scanner(f);
									String NL = System.getProperty("line.separator");
									
									while (scanner.hasNextLine()) {
										content.append(scanner.nextLine() + NL);
									}
									
								}
								dir.setFiles(new Note(noteList[j].getName(), content.toString()));
							}
							
						}
					} else {
							System.out.println("Empty Folder");
					  }
			
	 }
		
		catch (FileNotFoundException e) {
			System.err.println("Error :" + e.getMessage());
		 }
	
	this.createXMLfile(dir);
	}

	/* Creates a XML file of notes */
	@SuppressWarnings("unchecked")
	private void createXMLfile(NoteDirectory dir) {
	
		try {
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			dom = db.newDocument();

			Element rootEle = dom.createElement("Notes");
			dom.appendChild(rootEle);
		
			Element dirEle = dom.createElement("Directory");
			dirEle.setAttribute("name", dirName);
			
			List <Note> list = dir.getFiles();
			Iterator <Note> it = list.iterator();
			
			while ( it.hasNext()) {
				Note newNote = it.next();
				Element noteEle = createElement(newNote);
				dirEle.appendChild(noteEle);
			}
			rootEle.appendChild(dirEle);
		}
		
		catch(ParserConfigurationException e) {
			System.err.println("Caught ParserConfigurationException : " + e.getMessage());
		}
		
	}

	/* Create a new xml node element */
	private Element createElement(Note newNote) {
		
			Element firstEle = dom.createElement("Note");
			Element nextEle = dom.createElement("FileName");
			Text nextText = dom.createTextNode(newNote.getNoteName());
			nextEle.appendChild(nextText);
			firstEle.appendChild(nextEle);
			
			nextEle = dom.createElement("Content");
			nextText = dom.createTextNode(newNote.getNoteContent());
			nextEle.appendChild(nextText);
			firstEle.appendChild(nextEle);
		
		return firstEle;
	}
	
}
