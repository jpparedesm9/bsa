package com.cobiscorp.ecobis.clientviewer.dal.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "pf_operacion", schema = "cob_pfijo")
/**
 * Class used to access the database using JPA
 * related table: pf_operacion bdd: cob_pfijo
 * @author bbuendia
 *
 */
public class FixedTermOperation {
	
	@Id
	@Column(name = "op_num_banco")
	private String bankNumber;
	
	@Column(name = "op_estado")
	private String status;
	
	@Column(name = "op_monto_pgdo")
	private Double amountPaid;
	
	/** Default constructor */
	public FixedTermOperation() {
		
	}

	public String getBankNumber() {
		return bankNumber;
	}

	public void setBankNumber(String bankNumber) {
		this.bankNumber = bankNumber;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Double getAmountPaid() {
		return amountPaid;
	}

	public void setAmountPaid(Double amountPaid) {
		this.amountPaid = amountPaid;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((bankNumber == null) ? 0 : bankNumber.hashCode());
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
		FixedTermOperation other = (FixedTermOperation) obj;
		if (bankNumber == null) {
			if (other.bankNumber != null)
				return false;
		} else if (!bankNumber.equals(other.bankNumber))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "FixedTermOperation [bankNumber=" + bankNumber + ", status="
				+ status + ", amountPaid=" + amountPaid + "]";
	}

}
