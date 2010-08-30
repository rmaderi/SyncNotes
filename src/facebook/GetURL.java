package facebook;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;

/**
 * This class will return the text form of the response
 * which can be later converted to JSON object
 * @author Jyoti Garg
 *
 */
public class GetURL {

	private String url;

	public GetURL(String url) {
		this.url = url;
	}

	public String getJSON() {
		String inputLine, text = "";
		
		try {
			URL facebook = new URL(url);
			URLConnection fb = facebook.openConnection();

			BufferedReader in = new BufferedReader(
					new InputStreamReader(
							fb.getInputStream()));

			while ((inputLine = in.readLine()) != null) {
				text = text + inputLine ;	
			}
			in.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return text;

	}
}
