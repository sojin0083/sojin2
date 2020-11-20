package egovframework.openlink.home.service;

public class UserVO {
	private int no;
	private String user_id;
	private String user_name;
	private String user_pw;
	private int auth;
	private String taskAuth;
	private int delCheck;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public int getAuth() {
		return auth;
	}
	public void setAuth(int auth) {
		this.auth = auth;
	}
	public String getTaskAuth() {
		return taskAuth;
	}
	public void setTaskAuth(String taskAuth) {
		this.taskAuth = taskAuth;
	}
	public int getDelCheck() {
		return delCheck;
	}
	public void setDelCheck(int delCheck) {
		this.delCheck = delCheck;
	}	
}