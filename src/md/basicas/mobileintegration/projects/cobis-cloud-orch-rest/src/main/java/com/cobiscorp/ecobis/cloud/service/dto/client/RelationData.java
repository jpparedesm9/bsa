package com.cobiscorp.ecobis.cloud.service.dto.client;



public class RelationData {

	private int relatedPersonId;
	private int typeOfRelationship;
	private String relationDescription;
	
	public int getRelatedPersonId() {
		return relatedPersonId;
	}

	public void setRelatedPersonId(int relatedPersonId) {
		this.relatedPersonId = relatedPersonId;
	}

	public int getTypeOfRelationship() {
		return typeOfRelationship;
	}

	public void setTypeOfRelationship(int typeOfRelationship) {
		this.typeOfRelationship = typeOfRelationship;
	}

	public String getRelationDescription() {
		return relationDescription;
	}

	public void setRelationDescription(String relationDescription) {
		this.relationDescription = relationDescription;
	}
	
	public Relation toRelation() {
		Relation relation = new Relation();
		relation.setRelatedCustomerId(relatedPersonId);
		relation.setRelation(typeOfRelationship);
		return relation;
	}
	
}
