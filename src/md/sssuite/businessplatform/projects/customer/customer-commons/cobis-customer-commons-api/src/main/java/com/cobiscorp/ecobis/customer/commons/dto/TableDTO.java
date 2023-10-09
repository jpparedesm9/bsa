package com.cobiscorp.ecobis.customer.commons.dto;

/**
 * DTO used to save all information of Customers.
 * 
 * @author gvillamagua
 * 
 */
public class TableDTO {
	private Integer columnExist;

	public Integer getColumnExist() {
		return columnExist;
	}

	public void setColumnExist(Integer columnExist) {
		this.columnExist = columnExist;
	}

	public TableDTO(Integer columnExist) {
		super();
		this.columnExist = columnExist;
	}

}
