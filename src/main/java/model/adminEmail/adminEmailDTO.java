package model.adminEmail;

public class adminEmailDTO {
	private String emailAddress;
	private String emailPassword;
	
	
	public String getEmailAddress() {
		return emailAddress;
	}
	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}
	public String getEmailPassword() {
		return emailPassword;
	}
	public void setEmailPassword(String emailPassword) {
		this.emailPassword = emailPassword;
	}
	@Override
	public String toString() {
		return "adminEmailDTO [emailAddress=" + emailAddress + ", emailPassword=" + emailPassword + "]";
	}
	
	
}
