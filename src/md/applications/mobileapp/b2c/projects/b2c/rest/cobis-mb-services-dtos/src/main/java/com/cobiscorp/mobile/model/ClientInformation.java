package com.cobiscorp.mobile.model;

import java.util.List;

public class ClientInformation {
	Integer customerId;
	String ultimoAcceso;
	String mailAddress;
	String businessPartner;
	List<ClientLoansInfo> listClientLoansInfo;

	/**
	 * @return the customerId
	 */
	public Integer getCustomerId() {
		return customerId;
	}

	/**
	 * @param customerId
	 *            the customerId to set
	 */
	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	/**
	 * @return the ultimoAcceso
	 */
	public String getUltimoAcceso() {
		return ultimoAcceso;
	}

	/**
	 * @param ultimoAcceso
	 *            the ultimoAcceso to set
	 */
	public void setUltimoAcceso(String ultimoAcceso) {
		this.ultimoAcceso = ultimoAcceso;
	}

	/**
	 * @return the mailAddress
	 */
	public String getMailAddress() {
		return mailAddress;
	}
	/**
	 * @param mailAddress the mailAddress to set
	 */
	public void setMailAddress(String mailAddress) {
		this.mailAddress = mailAddress;
	}
	/**
	 * @return the listClientLoansInfo
	 */
	public List<ClientLoansInfo> getListClientLoansInfo() {
		return listClientLoansInfo;
	}

	/**
	 * @param listClientLoansInfo
	 *            the listClientLoansInfo to set
	 */
	public void setListClientLoansInfo(List<ClientLoansInfo> listClientLoansInfo) {
		this.listClientLoansInfo = listClientLoansInfo;
	}

	/**
	 * @return the businessPartner
	 */
	public String getBusinessPartner() {
		return businessPartner;
	}

	/**
	 * @param businessPartner the businessPartner to set
	 */
	public void setBusinessPartner(String businessPartner) {
		this.businessPartner = businessPartner;
	}
	
	

}
