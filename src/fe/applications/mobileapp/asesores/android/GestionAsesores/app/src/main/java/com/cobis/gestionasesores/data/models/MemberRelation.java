package com.cobis.gestionasesores.data.models;

import java.io.Serializable;

/**
 * Created by mnaunay on 19/08/2017.
 */

public class MemberRelation implements Serializable{
    private int customerId;
    private String relationTypeCode;
    private String name;
    private String relationName;


    public MemberRelation(Builder builder) {
        customerId = builder.customerId;
        relationTypeCode = builder.relationTypeCode;
        name = builder.name;
        relationName = builder.relationName;
    }

    public int getCustomerId() {
        return customerId;
    }

    public String getRelationTypeCode() {
        return relationTypeCode;
    }

    public String getName() {
        return name;
    }

    public String getRelationName() {
        return relationName;
    }

    public static class Builder{
        private int customerId;
        private String relationTypeCode;
        private String name;
        private String relationName;

        public Builder setCustomerId(int customerId) {
            this.customerId = customerId;
            return this;
        }

        public Builder setRelationTypeCode(String relationTypeCode) {
            this.relationTypeCode = relationTypeCode;
            return this;
        }

        public Builder setName(String name) {
            this.name = name;
            return this;
        }

        public Builder setRelationName(String relationName) {
            this.relationName = relationName;
            return this;
        }

        public MemberRelation build(){
            return new MemberRelation(this);
        }
    }
}
