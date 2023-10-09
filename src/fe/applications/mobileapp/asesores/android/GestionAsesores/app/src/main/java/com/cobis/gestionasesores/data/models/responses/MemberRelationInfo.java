package com.cobis.gestionasesores.data.models.responses;

/**
 * Created by bqtdesa02 on 10/2/2017.
 */

public class MemberRelationInfo {

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
}
