package com.cobiscorp.mobile.model;

import java.util.List;

/**
 * 
 * The Class ClientLoansInfo
 * 
 * @author jsanchez
 *
 */
public class ClientLoansInfo {

	private int operation;
	private String allowPayment;
	private String allowDispersal;
	private String productName;
	private String showAnotherValue;
	private String bank;
	private Integer instProc;
	
	private List<ClientLoans> listClientLoans;
	private List<ClientLoansDetails> listClientLoansDetails;

	/**
	 * Builder empty
	 */
	public ClientLoansInfo() {
		super();
	}
	
	
	/**
	 * 
	 * @return
	 */
	public int getOperation() {
		return operation;
	}


	/**
	 * 
	 * @param operation
	 */
	public void setOperation(int operation) {
		this.operation = operation;
	}
	
	/**
	 * @return the allowPayment
	 */
	public String getAllowPayment() {
		return allowPayment;
	}


	/**
	 * @param allowPayment the allowPayment to set
	 */
	public void setAllowPayment(String allowPayment) {
		this.allowPayment = allowPayment;
	}


	/**
	 * @return the allowDispersal
	 */
	public String getAllowDispersal() {
		return allowDispersal;
	}


	/**
	 * @param allowDispersal the allowDispersal to set
	 */
	public void setAllowDispersal(String allowDispersal) {
		this.allowDispersal = allowDispersal;
	}

	
	/**
	 * @return the productName
	 */
	public String getProductName() {
		return productName;
	}


	/**
	 * @param productName the productName to set
	 */
	public void setProductName(String productName) {
		this.productName = productName;
	}


	/**
	 * @return the showAnotherValue
	 */
	public String getShowAnotherValue() {
		return showAnotherValue;
	}


	/**
	 * @param showAnotherValue the showAnotherValue to set
	 */
	public void setShowAnotherValue(String showAnotherValue) {
		this.showAnotherValue = showAnotherValue;
	}


	/**
	 * @return the bank
	 */
	public String getBank() {
		return bank;
	}


	/**
	 * @param bank the bank to set
	 */
	public void setBank(String bank) {
		this.bank = bank;
	}


	/**
	 * @return the instProc
	 */
	public Integer getInstProc() {
		return instProc;
	}


	/**
	 * @param instProc the instProc to set
	 */
	public void setInstProc(Integer instProc) {
		this.instProc = instProc;
	}

	/**
	 * Builder with fields
	 * 
	 * @param listClientLoans        the list client loans
	 * @param listClientLoansDetails the client loans details
	 */
	public ClientLoansInfo(List<ClientLoans> listClientLoans, List<ClientLoansDetails> listClientLoansDetails) {
		super();
		this.listClientLoans = listClientLoans;
		this.listClientLoansDetails = listClientLoansDetails;
	}

	/**
	 * Get list client loans
	 * 
	 * @return the listClientLoans
	 */
	public List<ClientLoans> getListClientLoans() {
		return listClientLoans;
	}

	/**
	 * Set list client loans
	 * 
	 * @param listClientLoans the listClientLoans to set
	 */
	public void setListClientLoans(List<ClientLoans> listClientLoans) {
		this.listClientLoans = listClientLoans;
	}

	/**
	 * Get list client loans details
	 * 
	 * @return the listClientLoansDetails
	 */
	public List<ClientLoansDetails> getListClientLoansDetails() {
		return listClientLoansDetails;
	}

	/**
	 * Set list client loans details
	 * 
	 * @param listClientLoansDetails the listClientLoansDetails to set
	 */
	public void setListClientLoansDetails(List<ClientLoansDetails> listClientLoansDetails) {
		this.listClientLoansDetails = listClientLoansDetails;
	}

}
