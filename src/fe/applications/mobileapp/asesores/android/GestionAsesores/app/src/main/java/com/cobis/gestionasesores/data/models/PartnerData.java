package com.cobis.gestionasesores.data.models;

import com.bayteq.libcore.util.StringUtils;

/**
 * Created by bqtdesa02 on 6/8/2017.
 */

public class PartnerData extends SectionData<PartnerData> {
    private int serverId;
    private GeneralPersonData generalPersonData;
    private String activity;

    public PartnerData() {
        super();
    }

    @Override
    public PartnerData merge(PartnerData data) {
        if (data.serverId > 0) {
            this.serverId = data.serverId;
        }

        if (this.generalPersonData == null) {
            this.generalPersonData = data.generalPersonData;
        } else {
            if (data.generalPersonData != null) {
                this.generalPersonData = this.generalPersonData.merge(data.generalPersonData);
            }
        }

        if (StringUtils.isNotEmpty(data.activity)) {
            this.activity = data.activity;
        }
        return this;
    }

    private PartnerData(Builder builder) {
        generalPersonData = builder.generalPersonData;
        activity = builder.activity;
        serverId = builder.serverId;
    }

    public void setServerId(int serverId) {
        this.serverId = serverId;
    }

    public GeneralPersonData getGeneralPersonData() {
        return generalPersonData;
    }

    public String getActivity() {
        return activity;
    }

    public int getServerId() {
        return serverId;
    }

    @Override
    public boolean isComplete() {
        boolean isComplete = true;

        if (generalPersonData != null) {
            String firstName = generalPersonData.getFirstName();
            if (firstName == null || firstName.isEmpty()) {
                isComplete = false;
            }

            String lastName = generalPersonData.getLastName();
            if (lastName == null || lastName.isEmpty()) {
                isComplete = false;
            }

            String sex = generalPersonData.getSex();
            if (sex == null || sex.isEmpty()) {
                isComplete = false;
            }

            Long birthDate = generalPersonData.getBirthDate();
            if (birthDate == null) {
                isComplete = false;
            }

            String birthEntity = generalPersonData.getBirthEntityCode();
            if (birthEntity == null || birthEntity.isEmpty()) {
                isComplete = false;
            }

            String birthCountry = generalPersonData.getBirthCountry();
            if (birthCountry == null || birthCountry.isEmpty()) {
                isComplete = false;
            }

            String nationality = generalPersonData.getNationality();
            if (nationality == null || nationality.isEmpty()) {
                isComplete = false;
            }

            String educationLevel = generalPersonData.getEducationLevel();
            if (educationLevel == null || educationLevel.isEmpty()) {
                isComplete = false;
            }

            String occupation = generalPersonData.getOccupation();
            if (occupation == null || occupation.isEmpty()) {
                isComplete = false;
            }
        } else {
            isComplete = false;
        }

        return isComplete;
    }

    public static class Builder {
        private int serverId;
        private GeneralPersonData generalPersonData;
        private String activity;

        public Builder addGeneralPersonData(GeneralPersonData generalPersonData) {
            this.generalPersonData = generalPersonData;
            return this;
        }

        public Builder addActivity(String activity) {
            this.activity = activity;
            return this;
        }

        public Builder addServerId(int serverId) {
            this.serverId = serverId;
            return this;
        }

        public PartnerData build() {
            return new PartnerData(this);
        }
    }
}
