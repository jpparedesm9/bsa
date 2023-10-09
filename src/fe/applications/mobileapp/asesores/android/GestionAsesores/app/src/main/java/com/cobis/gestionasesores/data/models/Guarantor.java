package com.cobis.gestionasesores.data.models;

import java.io.Serializable;

/**
 * Created by mnaunay on 06/07/2017.
 */

public class Guarantor implements Serializable {
    private String name;
    private String document;
    private String riskLevel;
    private int serverId;

    public Guarantor(Builder builder) {
        name = builder.name;
        document = builder.document;
        riskLevel = builder.riskLevel;
        serverId = builder.serverId;
    }

    public String getName() {
        return name;
    }

    public String getDocument() {
        return document;
    }

    public String getRiskLevel() {
        return riskLevel;
    }

    public int getServerId() {
        return serverId;
    }

    public static class Builder{
        private String name;
        private String document;
        private String riskLevel;
        private int serverId;

        public Builder setServerId(int serverId) {
            this.serverId = serverId;
            return this;
        }


        public Builder setName(String name) {
            this.name = name;
            return this;
        }

        public Builder setDocument(String document) {
            this.document = document;
            return this;
        }

        public Builder setRiskLevel(String riskLevel) {
            this.riskLevel = riskLevel;
            return this;
        }

        public Guarantor build(){
            return new Guarantor(this);
        }
    }
}
