package facebook;
import java.text.ParseException;

import org.json.JSONObject;

/**
 * This class will return logged in Users ID.
 * @author Jyoti Garg
 *
 */
public class GetMyID {
	private String accessToken;

	public GetMyID(String accessToken) {
		this.accessToken = accessToken;
	}

	public String getMe() throws UserNotFoundException{	
		String me = "https://graph.facebook.com/me" + "?access_token=" + accessToken;
		GetURL url = new GetURL(me);

		String text = url.getJSON();
		if (text == null) {
			throw new UserNotFoundException();
		}
		else {
			try {
				JSONObject json = new JSONObject(text);
				return (String) json.get("id");
			}
			catch (ParseException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

}
