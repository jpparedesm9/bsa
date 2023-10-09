package com.cobiscorp.ecobis.frm.business.dto;

public class Item {
	private String code;
	private String value;
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	@Override
	public String toString() {
		return "Item [code=" + code + ", value=" + value + "]";
	}
	
	
}
