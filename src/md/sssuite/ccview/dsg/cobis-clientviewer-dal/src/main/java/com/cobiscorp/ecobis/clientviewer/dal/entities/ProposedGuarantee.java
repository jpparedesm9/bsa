package com.cobiscorp.ecobis.clientviewer.dal.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@IdClass(ProposedGuaranteeId.class)
@Table(name = "cr_gar_propuesta", schema = "cob_credito")
/**
 * Class used to access the database using JPA
 * related table: cr_gar_propuesta bdd: cob_credito
 * @author bbuendia
 *
 */
public class ProposedGuarantee {
	
	@Id
	@Column(name = "gp_tramite")
	private Integer processed;
	
	@Id
	@Column(name = "gp_garantia")
	private String guarantee;
	
	@Column(name = "gp_abierta")
	private String opened;
	
	@Column(name = "gp_deudor")
	private Integer debtor;
	
	@Column(name = "gp_est_garantia")
	private String stateGuarantee;
	
	@ManyToOne
	@JoinColumns({ @JoinColumn(name = "gp_garantia", referencedColumnName = "cu_codigo_externo") })
	private Custody custody;
	
	/** Default constructor */
	public ProposedGuarantee() {
		
	}

	public Integer getProcessed() {
		return processed;
	}

	public void setProcessed(Integer processed) {
		this.processed = processed;
	}

	public String getGuarantee() {
		return guarantee;
	}

	public void setGuarantee(String guarantee) {
		this.guarantee = guarantee;
	}

	public String getOpened() {
		return opened;
	}

	public void setOpened(String opened) {
		this.opened = opened;
	}

	public Integer getDebtor() {
		return debtor;
	}

	public void setDebtor(Integer debtor) {
		this.debtor = debtor;
	}

	public String getStateGuarantee() {
		return stateGuarantee;
	}

	public void setStateGuarantee(String stateGuarantee) {
		this.stateGuarantee = stateGuarantee;
	}

	public Custody getCustody() {
		return custody;
	}

	public void setCustody(Custody custody) {
		this.custody = custody;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((guarantee == null) ? 0 : guarantee.hashCode());
		result = prime * result
				+ ((processed == null) ? 0 : processed.hashCode());
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
		ProposedGuarantee other = (ProposedGuarantee) obj;
		if (guarantee == null) {
			if (other.guarantee != null)
				return false;
		} else if (!guarantee.equals(other.guarantee))
			return false;
		if (processed == null) {
			if (other.processed != null)
				return false;
		} else if (!processed.equals(other.processed))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ProposedGuarantee [processed=" + processed + ", guarantee="
				+ guarantee + ", opened=" + opened + ", debtor=" + debtor
				+ ", stateGuarantee=" + stateGuarantee + ", custody=" + custody
				+ "]";
	}

}
