package com.cobiscorp.ecobis.clientviewer.dal.entities;

import javax.persistence.Embeddable;

/**
 * Class that contains primary keys: "gp_tramite" and "gp_garantia"
 * from the table: cr_gar_propuesta
 * @author bbuendia
 *
 */
@Embeddable
public class ProposedGuaranteeId {
	
	private Integer processed;
	
	private String guarantee;
	
	/** Default constructor */
	public ProposedGuaranteeId(){
		
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
		ProposedGuaranteeId other = (ProposedGuaranteeId) obj;
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
		return "ProposedGuaranteeId [processed=" + processed + ", guarantee="
				+ guarantee + "]";
	}

}
