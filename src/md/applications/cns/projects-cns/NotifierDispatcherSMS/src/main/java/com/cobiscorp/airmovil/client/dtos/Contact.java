
package com.cobiscorp.airmovil.client.dtos;

public class Contact {

	private String phone;

	public Contact(String phone) {
		this.phone = phone;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Contact [phone=");
		builder.append(phone);
		builder.append("]");
		return builder.toString();
	}

}
