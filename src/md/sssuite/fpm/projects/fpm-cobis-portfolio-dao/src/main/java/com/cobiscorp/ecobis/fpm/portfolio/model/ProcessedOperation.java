package com.cobiscorp.ecobis.fpm.portfolio.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="cr_tramite",schema="cob_credito")
@NamedQueries({@NamedQuery(name="ProcessedOperation.FindProcessedOperation",query="Select po from ProcessedOperation po where po.operation = :operation")})
public class ProcessedOperation {
	
	@Id
	@Column(name = "tr_tramite")
	private Integer processedId;
	
	@Column(name = "tr_toperacion")
	private String operation;

	public Integer getProcessedId() {
		return processedId;
	}

	public void setProcessedId(Integer processedId) {
		this.processedId = processedId;
	}

	public String getOperation() {
		return operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}

	public ProcessedOperation(Integer processedId, String operation) {
		super();
		this.processedId = processedId;
		this.operation = operation;
	}

	public ProcessedOperation() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((operation == null) ? 0 : operation.hashCode());
		result = prime * result
				+ ((processedId == null) ? 0 : processedId.hashCode());
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
		ProcessedOperation other = (ProcessedOperation) obj;
		if (operation == null) {
			if (other.operation != null)
				return false;
		} else if (!operation.equals(other.operation))
			return false;
		if (processedId == null) {
			if (other.processedId != null)
				return false;
		} else if (!processedId.equals(other.processedId))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ProcessedOperation [processedId=" + processedId
				+ ", operation=" + operation + "]";
	}
}
