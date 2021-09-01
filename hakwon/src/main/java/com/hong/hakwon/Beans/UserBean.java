package com.hong.hakwon.Beans;



public class UserBean {

	private int id;
	private String userId;
	private String password;
	private String name;
	private String phoneNumber;
	private String sido;
	private String sigungu;
	private String email;


	public int getId() {
		return id;
	}
	public String getUserId() {
		return userId;
	}

	public String getPassword() {
		return password;
	}

	public String getName() {
		return name;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public String getSido() {
		return sido;
	}

	public String getSigungu() {
		return sigungu;
	}

	public String getEmail() {
		return email;
	}

	public UserBean() {
	}

	public UserBean(String userId, String password, String name, String phoneNumber, String sido, String sigungu, String email) {
		this.userId = userId;
		this.password = password;
		this.name = name;
		this.phoneNumber = phoneNumber;
		this.sido = sido;
		this.sigungu = sigungu;
		this.email = email;
	}

	public UserBean(int id, String userId, String password, String name, String phoneNumber, String sido, String sigungu, String email) {
		this.id = id;
		this.userId = userId;
		this.password = password;
		this.name = name;
		this.phoneNumber = phoneNumber;
		this.sido = sido;
		this.sigungu = sigungu;
		this.email = email;
	}
}
