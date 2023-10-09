package com.cobiscorp.ecobis.customer.commons.dto;

import com.cobiscorp.ecobis.commons.utils.dto.Paging;

public class SearchCustomerDTO extends Paging{

	private int clientNumber;
	private String clientNumberB;
	private int group;
	private String subType;
	private int type;
	private int mode;
	private String comercialName;
	private String clientName;
	private String clientSecondName;
	private String clientLastName;
	private String clientSecondLastName;
	private String cedRuc;
	private Character isClient;
	private int columnExist;

	public SearchCustomerDTO() {
	}

	public SearchCustomerDTO(int clientNumber, int group) {
		this.clientNumber = clientNumber;
		this.group = group;
	}

	public SearchCustomerDTO(int clientNumber, String subType, int type, int mode, String comercialName,
			String clientName, String clientLastName, String cedRuc, Character isClient) {
		this.clientNumber = clientNumber;
		this.subType = subType;
		this.type = type;
		this.mode = mode;
		this.comercialName = comercialName;
		this.clientName = clientName;
		this.clientLastName = clientLastName;
		this.cedRuc = cedRuc;
		this.isClient = isClient;
	}
	
	public SearchCustomerDTO(int clientNumber, String subType, int type, int mode, String comercialName,
			String clientName, String clientLastName, String cedRuc, Character isClient, String clientNumberB) {
		this.clientNumber = clientNumber;
		this.subType = subType;
		this.type = type;
		this.mode = mode;
		this.comercialName = comercialName;
		this.clientName = clientName;
		this.clientLastName = clientLastName;
		this.cedRuc = cedRuc;
		this.isClient = isClient;
		this.clientNumberB = clientNumberB;
	}

	public int getClientNumber() {
		return clientNumber;
	}

	public void setClientNumber(int clientNumber) {
		this.clientNumber = clientNumber;
	}

	public String getClientNumberB() {
		return clientNumberB;
	}

	public void setClientNumberB(String clientNumberB) {
		this.clientNumberB = clientNumberB;
	}

	public int getGroup() {
		return group;
	}

	public void setGroup(int group) {
		this.group = group;
	}

	public String getSubType() {
		return subType;
	}

	public void setSubType(String subType) {
		this.subType = subType;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getMode() {
		return mode;
	}

	public void setMode(int mode) {
		this.mode = mode;
	}

	public String getComercialName() {
		return comercialName;
	}

	public void setComercialName(String comercialName) {
		this.comercialName = comercialName;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getClientLastName() {
		return clientLastName;
	}

	public void setClientLastName(String clientLastName) {
		this.clientLastName = clientLastName;
	}

	public String getCedRuc() {
		return cedRuc;
	}

	public void setCedRuc(String cedRuc) {
		this.cedRuc = cedRuc;
	}

	public Character getIsClient() {
		return isClient;
	}

	public void setIsClient(Character isClient) {
		this.isClient = isClient;
	}
	
	public String getClientSecondLastName() {
		return clientSecondLastName;
	}

	public void setClientSecondLastName(String clientSecondLastName) {
		this.clientSecondLastName = clientSecondLastName;
	}	

	public String getClientSecondName() {
		return clientSecondName;
	}

	public void setClientSecondName(String clientSecondName) {
		this.clientSecondName = clientSecondName;
	}

	public int getColumnExist() {
		return columnExist;
	}

	public void setColumnExist(int columnExist) {
		this.columnExist = columnExist;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + clientNumber;
		result = prime * result + group;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		SearchCustomerDTO other = (SearchCustomerDTO) obj;
		if (clientNumber != other.clientNumber)
			return false;
		if (group != other.group)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "SearchCustomerDTO [clientNumber=" + clientNumber + ", group=" + group + ", sub_type=" + subType
				+ ", type=" + type + ", mode=" + mode + ", comercialName=" + comercialName + ", clientName="
				+ clientName + ", clientLastName=" + clientLastName + ", clientSecondLastName=" + clientSecondLastName
				+ ", cedRuc=" + cedRuc + ", isClient=" + isClient + ", clientNumberB=" + clientNumberB + "]";
	}

}
