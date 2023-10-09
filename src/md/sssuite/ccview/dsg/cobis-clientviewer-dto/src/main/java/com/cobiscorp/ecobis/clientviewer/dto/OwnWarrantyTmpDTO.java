package com.cobiscorp.ecobis.clientviewer.dto;

import java.io.Serializable;
import java.util.Date;

/**
 * DTO which is used to get all promissory notes
 * 
 * @author bbuendia
 * 
 */
public class OwnWarrantyTmpDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer spidOwn;
	private Integer client;
	private String code;
	private String warrantyType;
	private String module;
	private String warrantyDescription;
	private String currency;
	private Double initialValue;
	private Double actualValue;
	private Double actualMLValue;
	private Double percet;
	private Double MRC;
	private String state;
	private String fixedTerm;
	private String accountType;
	private String guarantor;
	private String guarantorId;
	private String stateCode;
	private String clientName;
	private Date activationDate;
	private Date cancelationDate;
	 
	

	public Date getActivationDate() {
		return activationDate;
	}

	public void setActivationDate(Date activationDate) {
		this.activationDate = activationDate;
	}

	public Date getCancelationDate() {
		return cancelationDate;
	}

	public void setCancelationDate(Date cancelationDate) {
		this.cancelationDate = cancelationDate;
	}

	public Integer getSpidOwn() {
		return spidOwn;
	}

	public void setSpidOwn(Integer spidOwn) {
		this.spidOwn = spidOwn;
	}

	public Integer getClient() {
		return client;
	}

	public void setClient(Integer client) {
		this.client = client;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getWarrantyType() {
		return warrantyType;
	}

	public void setWarrantyType(String warrantyType) {
		this.warrantyType = warrantyType;
	}

	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}

	public String getWarrantyDescription() {
		return warrantyDescription;
	}

	public void setWarrantyDescription(String warrantyDescription) {
		this.warrantyDescription = warrantyDescription;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public Double getInitialValue() {
		return initialValue;
	}

	public void setInitialValue(Double initialValue) {
		this.initialValue = initialValue;
	}

	public Double getActualValue() {
		return actualValue;
	}

	public void setActualValue(Double actualValue) {
		this.actualValue = actualValue;
	}

	public Double getActualMLValue() {
		return actualMLValue;
	}

	public void setActualMLValue(Double actualMLValue) {
		this.actualMLValue = actualMLValue;
	}

	public Double getPercet() {
		return percet;
	}

	public void setPercet(Double percet) {
		this.percet = percet;
	}

	public Double getMRC() {
		return MRC;
	}

	public void setMRC(Double mRC) {
		MRC = mRC;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getFixedTerm() {
		return fixedTerm;
	}

	public void setFixedTerm(String fixedTerm) {
		this.fixedTerm = fixedTerm;
	}

	public String getAccountType() {
		return accountType;
	}

	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}

	public String getGuarantor() {
		return guarantor;
	}

	public void setGuarantor(String guarantor) {
		this.guarantor = guarantor;
	}

	public String getGuarantorId() {
		return guarantorId;
	}

	public void setGuarantorId(String guarantorId) {
		this.guarantorId = guarantorId;
	}

	public String getStateCode() {
		return stateCode;
	}

	public void setStateCode(String stateCode) {
		this.stateCode = stateCode;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public OwnWarrantyTmpDTO() {
	}

	public OwnWarrantyTmpDTO(Integer client, String warrantyType,
			String warrantyDescription, String code, String currency,
			Double initialValue, Double actualValue, Double actualMLValue,
			Double percet, Double mRC, String stateDescription,
			String fixedTerm, String accountType, String guarantor,
			String guarantorId, String stateCode, String clientName, Date activationDate, Date cancelationDate) {
		this.client = client;
		this.warrantyType = warrantyType;
		this.module = "GAR";
		this.warrantyDescription = warrantyDescription;
		this.code = code;
		this.currency = currency;
		this.initialValue = initialValue;
		this.actualValue = actualValue;
		this.actualMLValue = actualMLValue;
		this.percet = percet;
		this.MRC = mRC;

		if (state != null)
			this.state = stateDescription;
		else
			this.state = " ";

		this.fixedTerm = fixedTerm;
		this.accountType = accountType;
		this.guarantor = guarantor;
		this.guarantorId = guarantorId;
		this.stateCode = stateCode;
		this.clientName = clientName;
		this.activationDate =  activationDate;
		this.cancelationDate = cancelationDate;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((client == null) ? 0 : client.hashCode());
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		result = prime * result + ((spidOwn == null) ? 0 : spidOwn.hashCode());
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
		OwnWarrantyTmpDTO other = (OwnWarrantyTmpDTO) obj;
		if (client == null) {
			if (other.client != null)
				return false;
		} else if (!client.equals(other.client))
			return false;
		if (code == null) {
			if (other.code != null)
				return false;
		} else if (!code.equals(other.code))
			return false;
		if (spidOwn == null) {
			if (other.spidOwn != null)
				return false;
		} else if (!spidOwn.equals(other.spidOwn))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "OwnWarrantyTmpDTO [spidOwn=" + spidOwn + ", client=" + client
				+ ", code=" + code + ", warrantyType=" + warrantyType
				+ ", module=" + module + ", warrantyDescription="
				+ warrantyDescription + ", currency=" + currency
				+ ", initialValue=" + initialValue + ", actualValue="
				+ actualValue + ", actualMLValue=" + actualMLValue
				+ ", percet=" + percet + ", MRC=" + MRC + ", state=" + state
				+ ", fixedTerm=" + fixedTerm + ", accountType=" + accountType
				+ ", guarantor=" + guarantor + ", guarantorId=" + guarantorId
				+ ", stateCode=" + stateCode + ", clientName=" + clientName
				+ "]";
	}

}
