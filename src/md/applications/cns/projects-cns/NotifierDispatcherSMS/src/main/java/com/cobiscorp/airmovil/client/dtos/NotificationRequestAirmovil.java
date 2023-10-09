
package com.cobiscorp.airmovil.client.dtos;

import java.util.Map;

public class NotificationRequestAirmovil {

	private Contact contact;
	private String country;
	private Map<String, Object> customAttributes;
	private String idNotification;

	public Contact getContact() {
		return contact;
	}

	public void setContact(Contact contact) {
		this.contact = contact;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public Map<String, Object> getCustomAttributes() {
		return customAttributes;
	}

	public void setCustomAttributes(Map<String, Object> customAttributes) {
		this.customAttributes = customAttributes;
	}

	public String getIdNotification() {
		return idNotification;
	}

	public void setIdNotification(String idNotification) {
		this.idNotification = idNotification;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("NotificationRequestAirmovil [contact=");
		builder.append(contact);
		builder.append(", country=");
		builder.append(country);
		builder.append(", customAttributes=");
		builder.append(customAttributes);
		builder.append(", idNotification=");
		builder.append(idNotification);
		builder.append("]");
		return builder.toString();
	}

}
