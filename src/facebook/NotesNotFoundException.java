package facebook;

public class NotesNotFoundException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3274060308190669039L;
	@Override
	public String getMessage() {
		return "Something went wrong. Notes are not found";
	}

}
