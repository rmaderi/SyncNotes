package facebook;
import java.text.ParseException;
import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONObject;

/**
 * 
 * @author Jyoti Garg
 *
 */
public class GetFBNotes implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String access_token; //= "2227470867|2.sIMbI_UD0F9x1RDFK6ls7w__.3600.1282748400-1207308088|FwnR5DxgphHDhf8fPJhnd_rSPYo.";
	private static HashMap<Integer, HashMap<String, String>>  friendNotes;
	//private static HashMap<Integer, HashMap<String, String>> allnotes;

	public GetFBNotes() {}

	public void setAccessToken(String access_token) {
		this.access_token = access_token;
	}


	public HashMap<Integer, HashMap<String, String>> getMyNotes() throws NotesNotFoundException, UserNotFoundException {
		HashMap<Integer, HashMap<String, String>> allnotes = new HashMap<Integer, HashMap<String, String>>();
		GetMyID me = new GetMyID(access_token);
		String myId = me.getMe();

		if (myId != null) {
			String myNotes = "https://graph.facebook.com/" + myId + "/notes?access_token="  + access_token;
			GetURL url = new GetURL(myNotes);
			String text = url.getJSON();
			allnotes = getNote(0, text, "my");
		}
		else {
			throw new NotesNotFoundException();
		}
		return allnotes;
	}

	public HashMap<Integer, HashMap<String, String>> getFriendsNotes() throws UserNotFoundException {
		friendNotes = new HashMap<Integer, HashMap<String, String>>();
		ExtractFBFriends friends = new ExtractFBFriends(access_token);
		String[] id = friends.getFriends();

		if (id == null) {
			throw new UserNotFoundException();
		}
		else {
			for (int i = 0; i < id.length -1 ; i++) {
				String myNotes = "https://graph.facebook.com/" + id[i] + "/notes?access_token="  + access_token;
				GetURL url = new GetURL(myNotes);
				String text = url.getJSON();
				friendNotes = getNote(0, text, "friend");
			}
		}	
		return friendNotes;
	}

	public HashMap<Integer, HashMap<String, String>> getNote(int j, String text, String name) {
		HashMap<Integer, HashMap<String, String>> allnotes;
		if (name.equals("my")) {
			allnotes = new HashMap<Integer, HashMap<String, String>>();
		}
		else {
			allnotes = friendNotes; 
		}
			
		
		try {
			//System.out.println(text);
			JSONObject json = new JSONObject(text);
			JSONArray jarr = json.getJSONArray("data");
			if (jarr !=null) {
				int i = 0;
				while (i < jarr.length() ) {
					HashMap<String, String> note = new HashMap<String, String>();
					JSONObject json1  = jarr.getJSONObject(i);
					note.put("Subject", (String)json1.get("subject"));
					note.put("Message", (String)json1.get("message"));
					note.put("Created", (String)json1.get("created_time"));
					allnotes.put(i, note);
					i++;
				}
			}
		}
		catch (ParseException e){
			e.printStackTrace();
		}
		return allnotes;
	}
	
/*/TEST CODE
	public static void printNotes(HashMap<Integer, HashMap<String, String>> notes) {
		HashMap<String, String> test = notes.get(1);
		System.out.println(test.get("Subject"));
		System.out.println(test.get("Message"));
		System.out.println(test.get("Created"));
	}

	public static void main(String[] args) throws NotesNotFoundException {
		String access = "2227470867|2.saZtpITXk8_vKH_NvKU_hg__.3600.1282791600-1207308088|PQ0pS5DxFyYKrlcQ-RNjNGM17y0.";
		HashMap<Integer, HashMap<String, String>> no = new HashMap<Integer, HashMap<String, String>>();
		GetFBNotes notes = new GetFBNotes();
		notes.setAccessToken(access);


		try {
			no = notes.getMyNotes();
			printNotes(no);
		} catch (UserNotFoundException e) {
			e.printStackTrace();
		}			

	}
/**/
}
