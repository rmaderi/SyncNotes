package syncnote;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @author dmurthy
 *
 */
public class PutNotes {
	/**
	 * 
	 * @param file
	 * @param filename
	 */

	public void putNotes(File file,String filename) throws IOException{
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
		Date date = new Date();
		File dest = new File("/tmp/sync/Notes/"+ filename+"_"+dateFormat.format(date));
		dest.createNewFile();
		if(file.renameTo(dest)){
			System.out.println("Done");
		}
		
	}
	
}
