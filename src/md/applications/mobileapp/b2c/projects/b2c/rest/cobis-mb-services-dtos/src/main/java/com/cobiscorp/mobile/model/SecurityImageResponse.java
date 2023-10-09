package com.cobiscorp.mobile.model;

import java.util.List;

public class SecurityImageResponse extends BaseResponse{

	private List<SecurityImageItem> securityImageItems;

	public List<SecurityImageItem> getSecurityImageItems() {
		return securityImageItems;
	}

	public void setSecurityImageItems(List<SecurityImageItem> securityImageItems) {
		this.securityImageItems = securityImageItems;
	}

	public SecurityImageResponse() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	
}
