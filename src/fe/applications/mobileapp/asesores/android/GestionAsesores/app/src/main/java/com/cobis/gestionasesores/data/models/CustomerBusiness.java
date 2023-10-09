package com.cobis.gestionasesores.data.models;

import com.bayteq.libcore.util.StringUtils;

/**
 * Created by mnaunay on 08/06/2017.
 */

public class CustomerBusiness extends SectionData<CustomerBusiness> {

    private int serverId;
    private AddressData addressData;
    private String name;
    private String turnaround;
    private String creditDestination;
    private String phoneNumber;
    private int phoneId;
    private String activity;
    private String timeActivity;
    private String timeRooting;
    private Long openingDate;
    private String creditPay;
    private double monthlyIncome;
    private String locationType;

    public CustomerBusiness() {
        super();
    }

    @Override
    public CustomerBusiness merge(CustomerBusiness data) {
        throw new RuntimeException("Operation not implemented!!");
    }

    private CustomerBusiness(Builder builder) {
        addressData = builder.addressData;
        name = builder.name;
        turnaround = builder.turnaround;
        creditDestination = builder.creditDestination;
        phoneNumber = builder.phoneNumber;
        phoneId = builder.phoneId;
        activity = builder.activity;
        timeActivity = builder.timeActivity;
        timeRooting = builder.timeRooting;
        openingDate = builder.openingDate;
        creditPay = builder.creditPay;
        monthlyIncome = builder.monthlyIncome;
        locationType = builder.locationType;
        serverId = builder.serverId;
    }

    public AddressData getAddressData() {
        return addressData;
    }

    public String getName() {
        return name;
    }

    public String getTurnaround() {
        return turnaround;
    }

    public String getCreditDestination() {
        return creditDestination;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public int getPhoneId() {
        return phoneId;
    }

    public String getActivity() {
        return activity;
    }

    public String getTimeActivity() {
        return timeActivity;
    }

    public String getTimeRooting() {
        return timeRooting;
    }

    public Long getOpeningDate() {
        return openingDate;
    }

    public String getCreditPay() {
        return creditPay;
    }

    public double getMonthlyIncome() {
        return monthlyIncome;
    }

    public String getLocationType() {
        return locationType;
    }

    public int getServerId() {
        return serverId;
    }

    public void setServerId(int serverId) {
        this.serverId = serverId;
    }

    public Builder buildUpon() {
        return new Builder(this);
    }

    @Override
    public boolean isComplete() {
        boolean isComplete = true;

        if (name == null || name.isEmpty()) {
            isComplete = false;
        }

        if (creditDestination == null || creditDestination.isEmpty()) {
            isComplete = false;
        }

        if (StringUtils.isEmpty(phoneNumber)) {
            isComplete = false;
        }

        if (activity == null || activity.isEmpty()) {
            isComplete = false;
        }

        if (timeActivity == null || timeActivity.isEmpty()) {
            isComplete = false;
        }

        if (timeRooting == null || timeRooting.isEmpty()) {
            isComplete = false;
        }

        if (openingDate == null) {
            isComplete = false;
        }

        if (creditPay == null || creditPay.isEmpty()) {
            isComplete = false;
        }

        if (monthlyIncome == 0.0) {
            isComplete = false;
        }

        if (locationType == null || locationType.isEmpty()) {
            isComplete = false;
        } else if (addressData == null || !addressData.isComplete()) {
            isComplete = false;
        }
        return isComplete;
    }

    public static class Builder {

        private int serverId;
        private AddressData addressData;
        private String name;
        private String turnaround;
        private String creditDestination;
        private String phoneNumber;
        private int phoneId;
        private String activity;
        private String timeActivity;
        private String timeRooting;
        private Long openingDate;
        private String creditPay;
        private double monthlyIncome;
        private String locationType;

        public Builder() {
        }

        private Builder(CustomerBusiness customerBusiness) {
            serverId = customerBusiness.serverId;
            addressData = customerBusiness.addressData;
            name = customerBusiness.name;
            turnaround = customerBusiness.turnaround;
            creditDestination = customerBusiness.creditDestination;
            phoneNumber = customerBusiness.phoneNumber;
            phoneId = customerBusiness.phoneId;
            activity = customerBusiness.activity;
            timeActivity = customerBusiness.timeActivity;
            timeRooting = customerBusiness.timeRooting;
            openingDate = customerBusiness.openingDate;
            creditPay = customerBusiness.creditPay;
            monthlyIncome = customerBusiness.monthlyIncome;
            locationType = customerBusiness.locationType;
        }

        public Builder addServerId(int serverId) {
            this.serverId = serverId;
            return this;
        }

        public Builder addAddressData(AddressData addressData) {
            this.addressData = addressData;
            return this;
        }

        public Builder addName(String name) {
            this.name = name;
            return this;
        }

        public Builder addTurnaround(String turnaround) {
            this.turnaround = turnaround;
            return this;
        }

        public Builder addCreditDestination(String creditDestination) {
            this.creditDestination = creditDestination;
            return this;
        }

        public Builder addPhoneNumber(String phoneNumber) {
            this.phoneNumber = phoneNumber;
            return this;
        }

        public Builder addPhoneId(int phoneId){
            this.phoneId = phoneId;
            return this;
        }

        public Builder addActivity(String activity) {
            this.activity = activity;
            return this;
        }

        public Builder addTimeActivity(String timeActivity) {
            this.timeActivity = timeActivity;
            return this;
        }

        public Builder addTimeRooting(String timeRooting) {
            this.timeRooting = timeRooting;
            return this;
        }

        public Builder addOpeningDate(Long openingDate) {
            this.openingDate = openingDate;
            return this;
        }

        public Builder addCreditPay(String creditPay) {
            this.creditPay = creditPay;
            return this;
        }

        public Builder addMonthlyIncome(double monthlyIncome) {
            this.monthlyIncome = monthlyIncome;
            return this;
        }

        public Builder addLocationType(String locationType) {
            this.locationType = locationType;
            return this;
        }

        public CustomerBusiness build() {
            return new CustomerBusiness(this);
        }
    }


}
