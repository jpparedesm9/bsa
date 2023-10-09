package com.cobiscorp.ecobis.clientviewer.dal.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "cl_moneda", schema = "cobis")
/**
 * Class used to access the database using JPA
 * related table: cl_moneda bdd: cobis
 * @author bbuendia
 *
 */
public class Currency {

	/** The id of the currency */
	@Id
	@Column(name = "mo_moneda")
	private Integer id;
	/** Currency Description */
	@Column(name = "mo_descripcion")
	private String description;
	/** Currency status */
	@Column(name = "mo_estado")
	private String status;
	/** If the currency supports decimals */
	@Column(name = "mo_decimales")
	private String hasDecimals;
	/** The currency symbol */
	@Column(name = "mo_simbolo")
	private String symbol;
	/** The currency mnemonic */
	@Column(name = "mo_nemonico")
	private String mnemonic;

	@OneToMany(mappedBy = "currency")
	private List<SummaryOther> summaryOthers;
	
	@OneToMany(mappedBy = "currency")
	private List<SummaryInvestments> summaryInvestments;
	
	@OneToMany(mappedBy = "currency")
	private List<SummaryCredits> summaryCredits;
	
	@OneToMany(mappedBy = "currency")
	private List<SummaryDebts> summaryDebts;

	public Currency() {
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getHasDecimals() {
		return hasDecimals;
	}

	public void setHasDecimals(String hasDecimals) {
		this.hasDecimals = hasDecimals;
	}

	public String getSymbol() {
		return symbol;
	}

	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}

	public String getMnemonic() {
		return mnemonic;
	}

	public void setMnemonic(String mnemonic) {
		this.mnemonic = mnemonic;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
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
		Currency other = (Currency) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Currency [id=" + id + ", description=" + description
				+ ", status=" + status + ", hasDecimals=" + hasDecimals
				+ ", symbol=" + symbol + ", mnemonic=" + mnemonic + "]";
	}

}
