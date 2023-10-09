package com.cobis.cloud.sofom.operationsexecution.santander.dto;

public class ProcedureEntityResponseDTO {
	private Integer entityId;
	private Integer procedureNumber;

	public Integer getEntityId() {
		return entityId;
	}

	public void setEntityId(Integer entityId) {
		this.entityId = entityId;
	}

	public Integer getProcedureNumber() {
		return procedureNumber;
	}

	public void setProcedureNumber(Integer procedureNumber) {
		this.procedureNumber = procedureNumber;
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "[Entity id:" + entityId + ", Procedure Number:"
				+ procedureNumber + "]";
	}

}
