package com.cobiscorp.cloud.notificationservice.model;

public class CustomerAccStatus {
	private Integer cliendId;
	private String clientName;
	private String filename;
	private String mail;
	private String mailSubject;
	public Integer getCliendId() {
		return cliendId;
	}
	public void setCliendId(Integer cliendId) {
		this.cliendId = cliendId;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getMailSubject() {
		return mailSubject;
	}
	public void setMailSubject(String mailSubject) {
		this.mailSubject = mailSubject;
	}
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	
	
}
