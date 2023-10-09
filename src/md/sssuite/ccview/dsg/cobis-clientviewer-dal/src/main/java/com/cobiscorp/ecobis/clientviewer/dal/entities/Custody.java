package com.cobiscorp.ecobis.clientviewer.dal.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "cu_custodia", schema = "cob_custodia")
/**
 * Class used to access the database using JPA
 * related table: cu_custodia bdd: cob_custodia
 * @author bbuendia
 *
 */
public class Custody {

	@Id
	@Column(name = "cu_codigo_externo")
	private String externalCode;
	
	@Column(name = "cu_tipo")
	private String type;
	
	@Column(name = "cu_estado")
	private String status;
	
	@Column(name = "cu_cuenta_hold")
	private String holdAccount;
	
	@ManyToOne
	@JoinColumns({ @JoinColumn(name = "cu_cuenta_hold", referencedColumnName = "op_num_banco") })
	private FixedTermOperation fixedTermOperation;
	
	/** Default constructor */
	public Custody(){
		
	}
	
	public String getExternalCode() {
		return externalCode;
	}

	public void setExternalCode(String externalCode) {
		this.externalCode = externalCode;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public FixedTermOperation getFixedTermOperation() {
		return fixedTermOperation;
	}

	public void setFixedTermOperation(FixedTermOperation fixedTermOperation) {
		this.fixedTermOperation = fixedTermOperation;
	}

	public String getHoldAccount() {
		return holdAccount;
	}

	public void setHoldAccount(String holdAccount) {
		this.holdAccount = holdAccount;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((externalCode == null) ? 0 : externalCode.hashCode());
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
		Custody other = (Custody) obj;
		if (externalCode == null) {
			if (other.externalCode != null)
				return false;
		} else if (!externalCode.equals(other.externalCode))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Custody [externalCode=" + externalCode + ", type=" + type
				+ ", status=" + status + ", holdAccount=" + holdAccount
				+ ", fixedTermOperation=" + fixedTermOperation + "]";
	}
	
}
