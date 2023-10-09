package com.cobis.gestionasesores.data.models;

/**
 * Created by bqtdesa02 on 6/9/2017.
 */

public class CustomerPayment extends SectionData<CustomerPayment> {
    private double mMonthlyIncome;
    private double mMonthlyBusinessExpenses;
    private double mMonthlyFamilyExpenses;
    private double mPaymentCapacity;

    public CustomerPayment() {
        super();
    }

    @Override
    public CustomerPayment merge(CustomerPayment data) {
        if (data.mMonthlyIncome > 0) {
            this.mMonthlyIncome = data.mMonthlyIncome;
        }
        if (data.mMonthlyBusinessExpenses > 0) {
            this.mMonthlyBusinessExpenses = data.mMonthlyBusinessExpenses;
        }
        if (data.mMonthlyFamilyExpenses > 0) {
            this.mMonthlyFamilyExpenses = data.mMonthlyFamilyExpenses;
        }
        if (data.mPaymentCapacity > 0) {
            this.mPaymentCapacity = data.mPaymentCapacity;
        }
        return this;
    }

    private CustomerPayment(Builder builder) {
        mMonthlyIncome = builder.mMonthlyIncome;
        mMonthlyBusinessExpenses = builder.mMonthlyBusinessExpenses;
        mMonthlyFamilyExpenses = builder.mMonthlyFamilyExpenses;
        mPaymentCapacity = builder.mPaymentCapacity;
    }

    public double getMonthlyIncome() {
        return mMonthlyIncome;
    }

    public double getMonthlyBusinessExpenses() {
        return mMonthlyBusinessExpenses;
    }

    public double getMonthlyFamilyExpenses() {
        return mMonthlyFamilyExpenses;
    }

    public double getPaymentCapacity() {
        return mPaymentCapacity;
    }

    @Override
    public boolean isComplete() {
        boolean isComplete = true;

        if (mMonthlyIncome == 0.0) {
            isComplete = false;
        }

        if (mMonthlyBusinessExpenses == 0.0) {
            isComplete = false;
        }

        if (mMonthlyFamilyExpenses <= 0.0) {
            isComplete = false;
        }

        return isComplete;
    }

    public static class Builder {
        private double mMonthlyIncome;
        private double mMonthlyBusinessExpenses;
        private double mMonthlyFamilyExpenses;
        private double mPaymentCapacity;

        public Builder addMonthlyIncome(double monthlyIncome) {
            mMonthlyIncome = monthlyIncome;
            return this;
        }

        public Builder addMonthlyBusinessExpenses(double monthlyBusinessExpenses) {
            mMonthlyBusinessExpenses = monthlyBusinessExpenses;
            return this;
        }

        public Builder addMonthlyFamilyExpenses(double monthlyFamilyExpenses) {
            mMonthlyFamilyExpenses = monthlyFamilyExpenses;
            return this;
        }

        public Builder addPaymentCapacity(double paymentCapacity) {
            mPaymentCapacity = paymentCapacity;
            return this;
        }

        public CustomerPayment build() {
            return new CustomerPayment(this);
        }
    }
}
