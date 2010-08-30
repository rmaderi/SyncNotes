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

/* Gets notes from all folders */
public class GetAllNotes extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private Document dom = null;

	public void init() throws ServletException
	{
		super.init();
	}

	public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
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
	@SuppressWarnings("unchecked")
	private void GetFolderStructure() {
		
		NoteDirectory dir = null;
		List dirList = new ArrayList ();
		StringBuffer content = null;
		
		try {
			File root = new File("/tmp/sync/Notes");
			File [] listOfDir = root.listFiles();
			
			for ( int i =0 ; i < listOfDir.length; i++) {
				if (listOfDir[i].isDirectory() && !listOfDir[i].isHidden()) {
					String dirName = listOfDir[i].getName();
					
					dir = new NoteDirectory(dirName);
					File noteDir = new File("/tmp/sync/Notes/" +dirName);
					
					if (dir != null) {
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
						dirList.add(dir);
				
					}
			 } 
			}
			
	 }
	 catch (FileNotFoundException e) {
		System.err.println("Error :" + e.getMessage());
	 }
	  
	if (dirList.size() > 0)
		createXMLfile(dirList);
	}

	/* Creates a XML file of notes */
	private void createXMLfile(List <NoteDirectory> dirList) {
		Iterator <NoteDirectory> it = dirList.iterator();
	
		try {
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			dom = db.newDocument();

			Element rootEle = dom.createElement("Notes");
			dom.appendChild(rootEle);
		
			while ( it.hasNext()) {
				NoteDirectory n = it.next();
				Element repEle = createElement(n);
				rootEle.appendChild(repEle);
			}
		
		}
		
		catch(ParserConfigurationException e) {
			System.err.println("Caught ParserConfigurationException : " + e.getMessage());
		}
		
	}

	/* Create a new node element */
	private Element createElement(NoteDirectory dir) {
		Element repEle = dom.createElement("Directory");
		repEle.setAttribute("name", dir.getDirName());

		for (int i = 0; i < dir.getFiles().size(); i++) {
			Element firstEle = dom.createElement("Note");
			Element nextEle = dom.createElement("FileName");
			
			Text nextText = dom.createTextNode(((Note) dir.getFiles().get(i)).getNoteName());
			nextEle.appendChild(nextText);
			firstEle.appendChild(nextEle);
			repEle.appendChild(firstEle);
			
			nextEle = dom.createElement("Content");
			nextText = dom.createTextNode(((Note) dir.getFiles().get(i)).getNoteContent());
			nextEle.appendChild(nextText);
			firstEle.appendChild(nextEle);
			repEle.appendChild(firstEle);
		}
		
		return repEle;
	}
	
}
