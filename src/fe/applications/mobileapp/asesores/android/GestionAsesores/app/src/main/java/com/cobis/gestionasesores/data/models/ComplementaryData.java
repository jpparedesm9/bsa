package com.cobis.gestionasesores.data.models;

public class ComplementaryData extends SectionData<ComplementaryData> {

    private String ifeNumber;
    private String passportNumber;
    private String eSignSN;
    private String msgPhoneNumber;
    private String msgDelegateName;
    private Boolean hasAntecedentsBureau;
    private String conventionalPhoneNumber;

    public ComplementaryData() {
        super();
    }

    public ComplementaryData(Builder builder) {
        this.ifeNumber = builder.ifeNumber;
        this.passportNumber = builder.passportNumber;
        this.eSignSN = builder.eSignSN;
        this.msgPhoneNumber = builder.msgPhoneNumber;
        this.msgDelegateName = builder.msgDelegateName;
        this.hasAntecedentsBureau = builder.hasAntecedentsBureau;
        this.conventionalPhoneNumber = builder.conventionalPhoneNumber;
    }

    public String getIfeNumber() {
        return ifeNumber;
    }

    public String getPassportNumber() {
        return passportNumber;
    }

    public String geteSignSN() {
        return eSignSN;
    }

    public String getMsgPhoneNumber() {
        return msgPhoneNumber;
    }

    public String getMsgDelegateName() {
        return msgDelegateName;
    }

    public Boolean hasAntecedentsBureau() {
        return hasAntecedentsBureau;
    }

    public String getConventionalPhoneNumber() {
        return conventionalPhoneNumber;
    }

    @Override
    public boolean isComplete() {
        return hasAntecedentsBureau != null;
    }

    public static class Builder {
        private String ifeNumber;
        private String passportNumber;
        private String eSignSN;
        private String msgPhoneNumber;
        private String msgDelegateName;
        private Boolean hasAntecedentsBureau;
        private String conventionalPhoneNumber;

        public Builder addIfeNumber(String ifeNumber) {
            this.ifeNumber = ifeNumber;
            return this;
        }

        public Builder addPassportNumber(String passportNumber) {
            this.passportNumber = passportNumber;
            return this;
        }

        public Builder addeSignSN(String eSignSN) {
            this.eSignSN = eSignSN;
            return this;
        }

        public Builder addMsgPhoneNumber(String msgPhoneNumber) {
            this.msgPhoneNumber = msgPhoneNumber;
            return this;
        }

        public Builder addMsgDelegateName(String msgDelegateName) {
            this.msgDelegateName = msgDelegateName;
            return this;
        }

        public Builder addHasAntecedentsBureau(Boolean hasAntecedentsBureau) {
            this.hasAntecedentsBureau = hasAntecedentsBureau;
            return this;
        }

        public Builder addConventionalPhoneNumber(String conventionalPhoneNumber) {
            this.conventionalPhoneNumber = conventionalPhoneNumber;
            return this;
        }

        public ComplementaryData build() {
            return new ComplementaryData(this);
        }
    }
}
