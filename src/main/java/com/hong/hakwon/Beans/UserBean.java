package com.hong.hakwon.Beans;



public class UserBean {

	private int id;
	private String userId;
	private String password;
	private String name;
	private String phoneNumber;
	private String city;
	private String county;
	private String district;
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

	public String getCity() {
		return city;
	}

	public String getCounty() {
		return county;
	}

	public String getDistrict() {
		return district;
	}

	public String getEmail() {
		return email;
	}

	public UserBean() {
	}

	public UserBean(int id, String userId, String password, String name, String phoneNumber, String city, String county, String district, String email) {
		this.id = id;
		this.userId = userId;
		this.password = password;
		this.name = name;
		this.phoneNumber = phoneNumber;
		this.city = city;
		this.county = county;
		this.district = district;
		this.email = email;
	}
}
