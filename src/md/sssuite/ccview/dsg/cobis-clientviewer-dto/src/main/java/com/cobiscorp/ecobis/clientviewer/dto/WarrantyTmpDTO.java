package com.cobiscorp.ecobis.clientviewer.dto;

import java.io.Serializable;
import java.util.Date;

/**
 * DTO which is used in the method getAllWarranties
 * 
 * @author bbuendia
 * 
 */
public class WarrantyTmpDTO implements Serializable {
	/**
	 * 
	 */

	private static final long serialVersionUID = 1L;
	private Integer spidWar;
	private Integer client;
	private String code;
	private String module;
	private String warrantyType;
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
	private String custody;
	private String stateCode;
	private String clientName;
	private Date cancelationDate;
	private Date activationDate;
	private Double realizationValue;

	public WarrantyTmpDTO() {
	}

	public WarrantyTmpDTO(Integer client, String warrantyType,
			String warrantyDescription, String code, String currency,
			Double initialValue, Double actualValue, Double actualMLValue,
			Double percet, Double mRC, String stateDescription,
			String fixedTerm, String accountType, String guarantor,
			String guarantorId, String custody, String stateCode,
			String clientName, Date cancelationDate, Date activationDate,
			Double realizationValue) {

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

		if (stateCode != null)
			this.stateCode = stateCode;
		else
			this.stateCode = " ";

		this.fixedTerm = fixedTerm;
		this.accountType = accountType;
		this.guarantor = guarantor;
		this.guarantorId = guarantorId;
		this.custody = custody;
		this.state = stateDescription;
		this.clientName = clientName;
		this.cancelationDate = cancelationDate;
		this.activationDate = activationDate;
		this.realizationValue = realizationValue;
	}

	public Date getCancelationDate() {
		return cancelationDate;
	}

	public void setCancelationDate(Date cancelationDate) {
		this.cancelationDate = cancelationDate;
	}

	public Date getActivationDate() {
		return activationDate;
	}

	public void setActivationDate(Date activationDate) {
		this.activationDate = activationDate;
	}

	public Integer getSpid() {
		return spidWar;
	}

	public void setSpid(Integer spid) {
		this.spidWar = spid;
	}

	public Integer getClient() {
		return client;
	}

	public void setClient(Integer client) {
		this.client = client;
	}

	public String getWarrantyType() {
		return warrantyType;
	}

	public void setWarrantyType(String warrantyType) {
		this.warrantyType = warrantyType;
	}

	public String getWarrantyDescription() {
		return warrantyDescription;
	}

	public void setWarrantyDescription(String warrantyDescription) {
		this.warrantyDescription = warrantyDescription;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
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

	public String getCustody() {
		return custody;
	}

	public void setCustody(String custody) {
		this.custody = custody;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getStateCode() {
		return stateCode;
	}

	public void setStateCode(String stateCode) {
		this.stateCode = stateCode;
	}

	public Double getRealizationValue() {
		return realizationValue;
	}

	public void setRealizationValue(Double realizationValue) {
		this.realizationValue = realizationValue;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((client == null) ? 0 : client.hashCode());
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		result = prime * result + ((spidWar == null) ? 0 : spidWar.hashCode());
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
		WarrantyTmpDTO other = (WarrantyTmpDTO) obj;
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
		if (spidWar == null) {
			if (other.spidWar != null)
				return false;
		} else if (!spidWar.equals(other.spidWar))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "WarrantyTmp [spid=" + spidWar + ", client=" + client
				+ ", code=" + code + ", module=" + module + ", warrantyType="
				+ warrantyType + ", warrantyDescription=" + warrantyDescription
				+ ", currency=" + currency + ", initialValue=" + initialValue
				+ ", actualValue=" + actualValue + ", actualMLValue="
				+ actualMLValue + ", percet=" + percet + ", MRC=" + MRC
				+ ", state=" + state + ", fixedTerm=" + fixedTerm
				+ ", accountType=" + accountType + ", guarantor=" + guarantor
				+ ", guarantorId=" + guarantorId + ", custody=" + custody
				+ ", clientName=" + clientName + "]";
	}
}
