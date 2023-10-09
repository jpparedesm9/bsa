package com.cobiscorp.ecobis.busin.model;

public class CustomerDto {
	private Integer id;
	private String name;
	private String renapoStatus;

	public CustomerDto() {

	}

	public CustomerDto(Integer id, String name, String renapoStatus) {
		super();
		this.id = id;
		this.name = name;
		this.renapoStatus = renapoStatus;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRenapoStatus() {
		return renapoStatus;
	}

	public void setRenapoStatus(String renapoStatus) {
		this.renapoStatus = renapoStatus;
	}

}
