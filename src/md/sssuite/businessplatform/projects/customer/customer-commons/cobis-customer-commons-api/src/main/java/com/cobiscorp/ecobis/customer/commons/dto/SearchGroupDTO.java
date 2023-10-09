package com.cobiscorp.ecobis.customer.commons.dto;

import java.io.Serializable;

import com.cobiscorp.ecobis.commons.utils.dto.Paging;

/**
 * DTO used in the method queryGroup.
 * @author bbuendia
 *
 */
public class SearchGroupDTO extends Paging implements Serializable {

	private static final long serialVersionUID = 1L;

	private int customerCode;
	private int dateFormat;
	private int groupCode;
	private int searchMode;
	private String groupName;
	private char operationValue;
	private int typeValue;
	private String searchValue;
	private int type;
	private Character isClient;	
	private String groupType;	

	public int getCustomerCode() {
		return this.customerCode;
	}

	public void setCustomerCode(int customerCode) {
		this.customerCode = customerCode;
	}

	public int getDateFormat() {
		return this.dateFormat;
	}

	public void setDateFormat(int dateFormat) {
		this.dateFormat = dateFormat;
	}

	public int getGroupCode() {
		return this.groupCode;
	}

	public void setGroupCode(int groupCode) {
		this.groupCode = groupCode;
	}

	public int getSearchMode() {
		return this.searchMode;
	}

	public void setSearchMode(int searchMode) {
		this.searchMode = searchMode;
	}

	public String getGroupName() {
		return this.groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public char getOperationValue() {
		return this.operationValue;
	}

	public void setOperationValue(char operationValue) {
		this.operationValue = operationValue;
	}

	public int getTypeValue() {
		return this.typeValue;
	}

	public void setTypeValue(int typeValue) {
		this.typeValue = typeValue;
	}

	public String getSearchValue() {
		return this.searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public Character getIsClient() {
		return isClient;
	}

	public void setIsClient(Character isClient) {
		this.isClient = isClient;
	}

	public String getGroupType() {
		return groupType;
	}

	public void setGroupType(String groupType) {
		this.groupType = groupType;
	}
	
	
}
