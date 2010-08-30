package facebook;

public class UserNotFoundException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public String getMessage() {
		// TODO Auto-generated method stub
		return "Something went wrong. User can't be found. Possibly check if the user is authenticated";
	}
}
