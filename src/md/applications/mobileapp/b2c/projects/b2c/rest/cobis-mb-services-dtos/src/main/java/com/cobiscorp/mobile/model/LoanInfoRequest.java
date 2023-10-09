package com.cobiscorp.mobile.model;

public class LoanInfoRequest {
	
	private Integer customerId;
	private String option;
	private Integer operation;
	private String productType;
	
	
	
	public LoanInfoRequest() {
		super();
	}
	
	public LoanInfoRequest(Integer customerId) {
		super();
		this.customerId = customerId;
	}


	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	/**
	 * @return the option
	 */
	public String getOption() {
		return option;
	}

	/**
	 * @param option the option to set
	 */
	public void setOption(String option) {
		this.option = option;
	}

	/**
	 * @return the operation
	 */
	public Integer getOperation() {
		return operation;
	}

	/**
	 * @param operation the operation to set
	 */
	public void setOperation(Integer operation) {
		this.operation = operation;
	}

	/**
	 * @return the productType
	 */
	public String getProductType() {
		return productType;
	}

	/**
	 * @param productType the productType to set
	 */
	public void setProductType(String productType) {
		this.productType = productType;
	}
	
	

}
