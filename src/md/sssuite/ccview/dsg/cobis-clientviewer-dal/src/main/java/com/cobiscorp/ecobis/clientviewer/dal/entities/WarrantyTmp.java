package com.cobiscorp.ecobis.clientviewer.dal.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@IdClass(WarrantyTmpId.class)
@Table(name = "cr_gar_tmp", schema = "cob_credito")
@NamedQueries({ @NamedQuery(name = "WarrantyTmp.getAllWarranties", query = "select distinct new com.cobiscorp.ecobis.clientviewer.dto.WarrantyTmpDTO(w.client, w.warrantyType, w.warrantyDescription, w.code, w.currency, w.initialValue, w.actualValue, w.actualMLValue, w.percet, w.MRC, sc.description, w.fixedTerm, w.accountType, w.guarantor, w.guarantorId, w.custody, sc.state, w.clientName, w.cancelationDate, w.activationDate, w.realizationValue)"
		+ " from WarrantyTmp w left join w.stateWarrantyCustody sc"
		+ " where w.code > ' ' and w.spidWar = :spid  ORDER BY w.activationDate DESC") })
@NamedNativeQueries({ @NamedNativeQuery(name = "WarrantyTmp.delete", query = "Delete from cob_credito..cr_gar_tmp where spid = ?1") })
/**
 * Class used to access the database using JPA
 * related table: cr_gar_tmp bdd: cob_credito
 * @author bbuendia
 *
 */
public class WarrantyTmp {
	@Id
	@Column(name = "spid")
	private Integer spidWar;
	@Id
	@Column(name = "CLIENTE")
	private Integer client;
	@Id
	@Column(name = "CODIGO")
	private String code;
	@Transient
	private String module;
	@Column(name = "TIPO_GAR")
	private String warrantyType;
	@Column(name = "DESC_GAR")
	private String warrantyDescription;
	@Column(name = "MONEDA")
	private String currency;
	@Column(name = "VALOR_INI")
	private Double initialValue;
	@Column(name = "VALOR_ACT")
	private Double actualValue;
	@Column(name = "VALOR_ACT_ML")
	private Double actualMLValue;
	@Column(name = "PORCENTAJE")
	private Double percet;
	@Column(name = "MRC")
	private Double MRC;
	@Column(name = "ESTADO")
	private String state;
	@Column(name = "PLAZO_FIJO")
	private String fixedTerm;
	@Column(name = "TIPO_CTA")
	private String accountType;
	@Column(name = "FIADOR")
	private String guarantor;
	@Column(name = "ID_FIADOR")
	private String guarantorId;
	@Column(name = "CUSTODIA")
	private String custody;
	@Transient
	private String stateCode;
	@Column(name = "nombre_cliente")
	private String clientName;
	
	@Column(name = "fechaCancelacion")
	private Date cancelationDate;
	@Column(name = "fechaActivacion")
	private Date activationDate;

	@Column(name = "VALOR_REALIZACION")
	private Double realizationValue;

	@ManyToOne
	@JoinColumn(name = "ESTADO", referencedColumnName = "eg_estado")
	private StateWarrantyCustody stateWarrantyCustody;

	public WarrantyTmp() {
	}

	public WarrantyTmp(Integer client, String warrantyType,
			String warrantyDescription, String code, String currency,
			Double initialValue, Double actualValue, Double actualMLValue,
			Double percet, Double mRC, String stateDescription,
			String fixedTerm, String accountType, String guarantor,
			String guarantorId, String custody, String stateCode,
			String clientName) {
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
		this.custody = custody;
		this.stateCode = stateCode;
		this.clientName = clientName;
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

	public StateWarrantyCustody getStateWarrantyCustody() {
		return stateWarrantyCustody;
	}

	public void setStateWarrantyCustody(
			StateWarrantyCustody stateWarrantyCustody) {
		this.stateWarrantyCustody = stateWarrantyCustody;
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
		WarrantyTmp other = (WarrantyTmp) obj;
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
		return "WarrantyTmp [spidWar=" + spidWar + ", client=" + client + ", code=" + code + ", module=" + module + ", warrantyType=" + warrantyType + ", warrantyDescription="
				+ warrantyDescription + ", currency=" + currency + ", initialValue=" + initialValue + ", actualValue=" + actualValue + ", actualMLValue=" + actualMLValue
				+ ", percet=" + percet + ", MRC=" + MRC + ", state=" + state + ", fixedTerm=" + fixedTerm + ", accountType=" + accountType + ", guarantor=" + guarantor
				+ ", guarantorId=" + guarantorId + ", custody=" + custody + ", stateCode=" + stateCode + ", clientName=" + clientName + ", cancelationDate=" + cancelationDate
				+ ", activationDate=" + activationDate + ", realizationValue=" + realizationValue + ", stateWarrantyCustody=" + stateWarrantyCustody + "]";
	}

}
