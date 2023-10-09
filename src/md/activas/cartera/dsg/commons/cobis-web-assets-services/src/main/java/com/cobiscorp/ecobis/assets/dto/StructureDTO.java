package com.cobiscorp.ecobis.assets.dto;

public class StructureDTO {
	private String value;
	private String type;
	private String format;
	private String regularExp;
	private char groupSeparator;
	private char decimalSeparator;

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getFormat() {
		return format;
	}

	public void setFormat(String format) {
		this.format = format;
	}

	public String getRegularExp() {
		return regularExp;
	}

	public void setRegularExp(String regularExp) {
		this.regularExp = regularExp;
	}

	public char getGroupSeparator() {
		return groupSeparator;
	}

	public void setGroupSeparator(char groupSeparator) {
		this.groupSeparator = groupSeparator;
	}

	public char getDecimalSeparator() {
		return decimalSeparator;
	}

	public void setDecimalSeparator(char decimalSeparator) {
		this.decimalSeparator = decimalSeparator;
	}

	
}
