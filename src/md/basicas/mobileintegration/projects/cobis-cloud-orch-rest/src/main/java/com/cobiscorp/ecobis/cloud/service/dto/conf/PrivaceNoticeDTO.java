package com.cobiscorp.ecobis.cloud.service.dto.conf;

public class PrivaceNoticeDTO {
	private String title;
	private String content;
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "PrivaceNoticeDTO [title=" + title + ", content=" + content + "]";
	}
	
	

}
