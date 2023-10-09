package com.cobis.cloud.sofom.operationsexecution.santander.dto;

public class ProcedureEntityRequestDTO {
	private Integer entityId;
	private Integer procedureNumber;
	private String hasAccountAndBuc;

	public ProcedureEntityRequestDTO() {
	}

	public ProcedureEntityRequestDTO(Integer entityId, Integer procedureNumber) {
		this.entityId = entityId;
		this.procedureNumber = procedureNumber;
	}

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

	public String getHasAccountAndBuc() {
		return hasAccountAndBuc;
	}

	public void setHasAccountAndBuc(String hasAccountAndBuc) {
		this.hasAccountAndBuc = hasAccountAndBuc;
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "[Entity id:" + entityId + ", Procedure Number:" + procedureNumber + "]";
	}

}
