package facebook;

import java.io.*;
import java.util.HashMap;

import javax.servlet.*;
import javax.servlet.http.*;

public class InitFB extends HttpServlet{
	GetFBNotes notes;
	public void doGet(HttpServletRequest req, HttpServletResponse res)
		throws ServletException, IOException {
			//notes = new GetFBNotes("2227470867|2.sIMbI_UD0F9x1RDFK6ls7w__.3600.1282748400-1207308088|FwnR5DxgphHDhf8fPJhnd_rSPYo.");		
			//try {
				//HashMap<Integer, HashMap<String, String>> myNote = notes.getMyNotes();
				//HashMap<Integer, HashMap<String, String>> friendsNote = notes.getFriendsNotes();
			//} catch (NotesNotFoundException e) {
			//	e.printStackTrace();
			//} catch (UserNotFoundException e) {
			//	e.printStackTrace();
			//}
			
			HttpSession sess = req.getSession(true);
			sess.setAttribute("notes", notes);
 	}
}
