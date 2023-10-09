package com.cobis.gestionasesores.data.models;

/**
 * Created by bqtdesa02 on 6/5/2017.
 */

public class CustomerData extends SectionData<CustomerData> {
    private GeneralPersonData mGeneralPersonData;
    private String mCustomerNumber;
    private String mCivilStatus;
    private String mEconomicDependents;
    private String mCurp;
    private String mTechnicalDegree;
    private Boolean mHasOtherIncomeSources;
    private String mOtherIncomeSources;
    private double mOtherIncomeSourcesAmount;
    private int mNumCyclesOtherInstitutions;
    private Boolean mIsPoliticallyExposed;
    private String mFunctionPerformed;
    private Boolean mHasRelationshipPoliticallyExposed;
    private String mRelationship;
    private String mCustomerAccountNumber;

    public CustomerData() {
        super();
    }

    @Override
    public CustomerData merge(CustomerData data) {
        throw new RuntimeException("Operation not implemented!!");
    }

    public void mergeGeneralData(GeneralPersonData personData) {
        if (this.mGeneralPersonData == null || personData == null) return;
        this.mGeneralPersonData = this.mGeneralPersonData.merge(personData);
    }

    private CustomerData(Builder builder) {
        mGeneralPersonData = builder.mGeneralPersonData;
        mCustomerNumber = builder.mCustomerNumber;
        mCivilStatus = builder.mCivilStatus;
        mEconomicDependents = builder.mEconomicDependents;
        mCurp = builder.mCurp;
        mTechnicalDegree = builder.mTechnicalDegree;
        mHasOtherIncomeSources = builder.mHasOtherIncomeSources;
        mOtherIncomeSources = builder.mOtherIncomeSources;
        mOtherIncomeSourcesAmount = builder.mOtherIncomeSourcesAmount;
        mNumCyclesOtherInstitutions = builder.mNumCyclesOtherInstitutions;
        mIsPoliticallyExposed = builder.mIsPoliticallyExposed;
        mFunctionPerformed = builder.mFunctionPerformed;
        mHasRelationshipPoliticallyExposed = builder.mHasRelationshipPoliticallyExposed;
        mRelationship = builder.mRelationship;
        mCustomerAccountNumber = builder.mCustomerAccountNumber;
    }

    public GeneralPersonData getGeneralPersonData() {
        return mGeneralPersonData;
    }

    public String getCustomerNumber() {
        return mCustomerNumber;
    }

    public String getCivilStatus() {
        return mCivilStatus;
    }

    public String getEconomicDependents() {
        return mEconomicDependents;
    }

    public String getCurp() {
        return mCurp;
    }

    public String getTechnicalDegree() {
        return mTechnicalDegree;
    }

    public Boolean hasOtherIncomeSources() {
        return mHasOtherIncomeSources;
    }

    public String getOtherIncomeSources() {
        return mOtherIncomeSources;
    }

    public double getOtherIncomeSourcesAmount() {
        return mOtherIncomeSourcesAmount;
    }

    public int getNumCyclesOtherInstitutions() {
        return mNumCyclesOtherInstitutions;
    }

    public Boolean isPoliticallyExposed() {
        return mIsPoliticallyExposed;
    }

    public String getFunctionPerformed() {
        return mFunctionPerformed;
    }

    public Boolean hasRelationshipPoliticallyExposed() {
        return mHasRelationshipPoliticallyExposed;
    }

    public String getCustomerAccountNumber() {
        return mCustomerAccountNumber;
    }

    public void setCurp(String curp) {
        mCurp = curp;
    }

    public String getRelationship() {
        return mRelationship;
    }

    //these setters are made to refill de data from the server.
    public void setCustomerNumber(String mCustomerNumber) {
        this.mCustomerNumber = mCustomerNumber;
    }

    public void setCustomerAccountNumber(String mCustomerAccountNumber) {
        this.mCustomerAccountNumber = mCustomerAccountNumber;
    }

    public void setCivilStatus(String civilStatus) {
        mCivilStatus = civilStatus;
    }

    @Override
    public boolean isComplete() {
        boolean isComplete = true;

        if (mGeneralPersonData != null) {

            String firstName = mGeneralPersonData.getFirstName();
            if (firstName == null || firstName.isEmpty()) {
                isComplete = false;
            }

            String lastName = mGeneralPersonData.getLastName();
            if (lastName == null || lastName.isEmpty()) {
                isComplete = false;
            }

            String sex = mGeneralPersonData.getSex();
            if (sex == null || sex.isEmpty()) {
                isComplete = false;
            }

            if (mGeneralPersonData.getBirthDate() == null) {
                isComplete = false;
            }

            String birthEntity = mGeneralPersonData.getBirthEntityCode();
            if (birthEntity == null || birthEntity.isEmpty()) {
                isComplete = false;
            }

            String birthCountry = mGeneralPersonData.getBirthCountry();
            if (birthCountry == null || birthCountry.isEmpty()) {
                isComplete = false;
            }

            String nationality = mGeneralPersonData.getNationality();
            if (nationality == null || nationality.isEmpty()) {
                isComplete = false;
            }

            String educationLevel = mGeneralPersonData.getEducationLevel();
            if (educationLevel == null || educationLevel.isEmpty()) {
                isComplete = false;
            }

            String occupation = mGeneralPersonData.getOccupation();
            if (occupation == null || occupation.isEmpty()) {
                isComplete = false;
            }
        }else{
            isComplete = false;
        }

        if (mCivilStatus == null || mCivilStatus.isEmpty()) {
            isComplete = false;
        }

        if (mHasOtherIncomeSources == null) {
            isComplete = false;
        } else if (mHasOtherIncomeSources) {
            if (mOtherIncomeSources == null || mOtherIncomeSources.isEmpty()) {
                isComplete = false;
            }
            if (mOtherIncomeSourcesAmount == 0.0) {
                isComplete = false;
            }
        }

        if (mNumCyclesOtherInstitutions < 0) {
            isComplete = false;
        }

        if (mHasRelationshipPoliticallyExposed == null) {
            isComplete = false;
        } else if (mHasRelationshipPoliticallyExposed) {
            if (mRelationship == null || mRelationship.isEmpty()) {
                isComplete = false;
            }
        }

        return isComplete;
    }

    public static class Builder {
        private GeneralPersonData mGeneralPersonData;
        private String mCustomerNumber;
        private String mCivilStatus;
        private String mEconomicDependents;
        private String mCurp;
        private String mTechnicalDegree;
        private Boolean mHasOtherIncomeSources;
        private String mOtherIncomeSources;
        private double mOtherIncomeSourcesAmount;
        private int mNumCyclesOtherInstitutions;
        private Boolean mIsPoliticallyExposed;
        private String mFunctionPerformed;
        private Boolean mHasRelationshipPoliticallyExposed;
        private String mRelationship;
        private String mCustomerAccountNumber;

        public Builder addGeneralPersonData(GeneralPersonData generalPersonData) {
            mGeneralPersonData = generalPersonData;
            return this;
        }

        public Builder addCustomerNumber(String customerNumber) {
            mCustomerNumber = customerNumber;
            return this;
        }

        public Builder addCivilStatus(String civilStatus) {
            mCivilStatus = civilStatus;
            return this;
        }

        public Builder addEconomicDependents(String economicDependents) {
            mEconomicDependents = economicDependents;
            return this;
        }

        public Builder addCurp(String curp) {
            mCurp = curp;
            return this;
        }

        public Builder addTechnicalDegree(String technicalDegree) {
            mTechnicalDegree = technicalDegree;
            return this;
        }

        public Builder addHasOtherIncomeSources(Boolean hasOtherIncomeSources) {
            mHasOtherIncomeSources = hasOtherIncomeSources;
            return this;
        }

        public Builder addOtherIncomeSources(String otherIncomeSources) {
            mOtherIncomeSources = otherIncomeSources;
            return this;
        }

        public Builder addOtherIncomeSourcesAmount(double otherIncomeSourcesAmount) {
            mOtherIncomeSourcesAmount = otherIncomeSourcesAmount;
            return this;
        }

        public Builder addNumCyclesOtherInstitutions(int numCyclesOtherInstitutions) {
            mNumCyclesOtherInstitutions = numCyclesOtherInstitutions;
            return this;
        }

        public Builder addIsPoliticallyExposed(Boolean isPoliticallyExposed) {
            mIsPoliticallyExposed = isPoliticallyExposed;
            return this;
        }

        public Builder addFunctionPerformed(String functionPerformed) {
            mFunctionPerformed = functionPerformed;
            return this;
        }

        public Builder addHasRelationshipPoliticallyExposed(Boolean hasRelationshipPoliticallyExposed) {
            mHasRelationshipPoliticallyExposed = hasRelationshipPoliticallyExposed;
            return this;
        }

        public Builder addRelationship(String relationship) {
            mRelationship = relationship;
            return this;
        }

        public Builder addCustomerAccountNumber(String CustomerAccountNumber) {
            mCustomerAccountNumber = CustomerAccountNumber;
            return this;
        }

        public CustomerData build() {
            return new CustomerData(this);
        }
    }
}
