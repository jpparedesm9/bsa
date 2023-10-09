package com.cobis.gestionasesores.data.models.requests;

import com.cobis.gestionasesores.data.enums.CreditAppType;
import com.cobis.gestionasesores.data.enums.PersonType;

/**
 * Created by bqtdesa02 on 2/2/2018.
 */


public class GetPersonsRequest {
    private int type;
    private int[] status;
    private String keyword;
    private String creditType;
    private Boolean isValidated;
    private Boolean inGroup = null;
    private Boolean hasPartner;

    public GetPersonsRequest(Builder builder) {
        type = builder.type;
        status = builder.status;
        keyword = builder.keyword;
        creditType = builder.creditType;
        isValidated = builder.isValidated;
        inGroup = builder.inGroup;
        hasPartner = builder.hasPartner;
    }

    public int getType() {
        return type;
    }

    public int[] getStatus() {
        return status;
    }

    public String getKeyword() {
        return keyword;
    }

    public String getCreditType() {
        return creditType;
    }

    public Boolean getValidated() {
        return isValidated;
    }

    public Boolean getInGroup() {
        return inGroup;
    }

    public Boolean getHasPartner() {
        return hasPartner;
    }

    public static class Builder {
        private int type;
        private int[] status;
        private String keyword;
        private String creditType;
        private Boolean isValidated;
        private Boolean inGroup;
        private Boolean hasPartner;

        public Builder() {
            this.type = PersonType.UNKNOWN;
            this.creditType = CreditAppType.UNKNOWN;
        }

        public Builder setType(int type) {
            this.type = type;
            return this;
        }

        public Builder setStatus(int... status) {
            this.status = status;
            return this;
        }

        public Builder setKeyword(String keyword) {
            this.keyword = keyword;
            return this;
        }

        public Builder setInGroup(Boolean inGroup) {
            this.inGroup = inGroup;
            return this;
        }

        public Builder setCreditType(String creditType) {
            this.creditType = creditType;
            return this;
        }

        public Builder setValidated(Boolean validated) {
            isValidated = validated;
            return this;
        }

        public Builder setHasPartner(Boolean hasPartner) {
            this.hasPartner = hasPartner;
            return this;
        }

        public GetPersonsRequest build() {
            return new GetPersonsRequest(this);
        }
    }
}
