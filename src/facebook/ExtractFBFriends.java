package facebook;
import java.text.ParseException;

import org.json.JSONArray;
import org.json.JSONObject;

/**
 * 
 * @author Jyoti Garg
 * Project SyncNotes
 */
public class ExtractFBFriends {
	private String accessToken; //= "access_token=2227470867|2.jhlifSlf_q_KUtmXAKL_8g__.3600.1282420800-1207308088|z_8rhfV0mCWkNyf4wEa2SV47Brw.";
	private String userArray[] = null;

	public ExtractFBFriends(String accessToken) {
		this.accessToken = accessToken;
	}

	/**
	 * This method will return a list of users friends 
	 * @return
	 */
	public String[] getFriends() {
		int i = 0;

		String friends = "https://graph.facebook.com/me/friends" + "?access_token=" + accessToken;
		GetURL url = new GetURL(friends);
		String text = url.getJSON();
		
		try {
			JSONObject json = new JSONObject(text);
			JSONArray jarr = json.getJSONArray("data");

			userArray = new String[jarr.length()];

			while (i < jarr.length() - 1 ) {
				JSONObject json1  = jarr.getJSONObject(i);
				userArray[i] =  (String) json1.get("id");
				i++;
			}

			return userArray;
		}
		catch (ParseException e){
			e.printStackTrace();
		}
		return userArray;
	}



}
