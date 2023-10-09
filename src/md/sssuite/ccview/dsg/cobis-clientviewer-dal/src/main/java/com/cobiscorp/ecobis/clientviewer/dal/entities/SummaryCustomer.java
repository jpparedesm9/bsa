package com.cobiscorp.ecobis.clientviewer.dal.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@IdClass(SummaryId.class)
@Table(name = "cr_situacion_cliente", schema = "cob_credito")
/**
 * Class used to access the database using JPA
 * related table: cr_situacion_cliente bdd: cob_credito
 * @author bbuendia
 *
 */
public class SummaryCustomer {

	@Id
	@Column(name = "sc_cliente")
	private Integer customer;

	@Id
	@Column(name = "sc_usuario")
	private String user;	

	@Id
	@Column(name = "sc_secuencia")
	private Integer sequence;

	@Column(name = "sc_tramite")
	private Integer processId;

	@Column(name = "sc_tipo_con")
	private String queryType;

	@Column(name = "sc_cliente_con")
	private Integer queryCustomer;

	@Column(name = "sc_rol")
	private String rol;

	@Column(name = "sc_nombre_cliente")
	private String customerName;

	@OneToMany(mappedBy = "summaryCustomer")
	private List<SummaryOther> summaryOther;

	@OneToMany(mappedBy = "summaryCustomerAffiliate")
	private List<Affiliate> affiliates;

	@OneToMany(mappedBy = "summaryCustomer")
	private List<SummaryInvestments> summaryInvestments; 
	
	@OneToMany(mappedBy = "summaryCustomer")
	private List<SummaryDebts> summaryDebts;
	
	@OneToMany(mappedBy = "summaryCustomer")
	private List<SummaryCredits> summaryCredits;

	
	public SummaryCustomer() {

	}

	public SummaryCustomer(Integer customer, String user, Integer sequence,
			Integer processId, String queryType, Integer queryCustomer,
			String rol, String customerName) {
		this.customer = customer;
		this.user = user;
		this.sequence = sequence;
		this.processId = processId;
		this.queryType = queryType;
		this.queryCustomer = queryCustomer;
		this.rol = rol;
		this.customerName = customerName;
	}

	public Integer getCustomer() {
		return customer;
	}

	public void setCustomer(Integer customer) {
		this.customer = customer;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public Integer getSequence() {
		return sequence;
	}

	public void setSequence(Integer sequence) {
		this.sequence = sequence;
	}

	public Integer getProcessId() {
		return processId;
	}

	public void setProcessId(Integer processId) {
		this.processId = processId;
	}

	public String getQueryType() {
		return queryType;
	}

	public void setQueryType(String queryType) {
		this.queryType = queryType;
	}

	public Integer getQueryCustomer() {
		return queryCustomer;
	}

	public void setQueryCustomer(Integer queryCustomer) {
		this.queryCustomer = queryCustomer;
	}

	public String getRol() {
		return rol;
	}

	public void setRol(String rol) {
		this.rol = rol;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public List<SummaryOther> getSummaryOther() {
		return summaryOther;
	}

	public void setSummaryOther(List<SummaryOther> summaryOther) {
		this.summaryOther = summaryOther;
	}

	public List<Affiliate> getAffiliates() {
		return affiliates;
	}

	public void setAffiliates(List<Affiliate> affiliates) {
		this.affiliates = affiliates;
	}
	
	public List<SummaryInvestments> getSummaryInvestments() {
		return summaryInvestments;
	}

	public void setSummaryInvestments(List<SummaryInvestments> summaryInvestments) {
		this.summaryInvestments = summaryInvestments;
	}
	
	public List<SummaryDebts> getSummaryDebts() {
		return summaryDebts;
	}

	public void setSummaryDebts(List<SummaryDebts> summaryDebts) {
		this.summaryDebts = summaryDebts;
	}

	public List<SummaryCredits> getSummaryCredits() {
		return summaryCredits;
	}

	public void setSummaryCredits(List<SummaryCredits> summaryCredits) {
		this.summaryCredits = summaryCredits;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + customer;
		result = prime * result + sequence;
		result = prime * result + ((user == null) ? 0 : user.hashCode());
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
		SummaryCustomer other = (SummaryCustomer) obj;
		if (customer != other.customer)
			return false;
		if (sequence != other.sequence)
			return false;
		if (user == null) {
			if (other.user != null)
				return false;
		} else if (!user.equals(other.user))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "SummaryCustomer [customer=" + customer + ", user=" + user
				+ ", sequence=" + sequence + ", processId=" + processId
				+ ", queryType=" + queryType + ", queryCustomer="
				+ queryCustomer + ", rol=" + rol + ", customerName="
				+ customerName + ", summaryOther=" + summaryOther + "]";
	}

}
