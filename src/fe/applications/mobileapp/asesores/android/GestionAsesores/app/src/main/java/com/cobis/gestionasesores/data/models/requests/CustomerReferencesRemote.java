package com.cobis.gestionasesores.data.models.requests;

import java.util.List;

public class CustomerReferencesRemote {

    private List<ReferenceInfo> reference;

    public List<ReferenceInfo> getReference() {
        return reference;
    }

    public void setReference(List<ReferenceInfo> reference) {
        this.reference = reference;
    }

    public static class ReferenceInfo {

        private int referenceId;
        private String firstName;
        private String surname;
        private String phone;
        private String emailAddress;
        private int timeOfRelationship;

        public int getReferenceId() {
            return referenceId;
        }

        public void setReferenceId(int referenceId) {
            this.referenceId = referenceId;
        }

        public String getPhone() {
            return phone;
        }

        public void setPhone(String phone) {
            this.phone = phone;
        }

        public String getEmailAddress() {
            return emailAddress;
        }

        public void setEmailAddress(String emailAddress) {
            this.emailAddress = emailAddress;
        }

        public int getTimeOfRelationship() {
            return timeOfRelationship;
        }

        public void setTimeOfRelationship(int timeOfRelationship) {
            this.timeOfRelationship = timeOfRelationship;
        }

        public String getFirstName() {
            return firstName;
        }

        public void setFirstName(String firstName) {
            this.firstName = firstName;
        }

        public String getSurname() {
            return surname;
        }

        public void setSurname(String surname) {
            this.surname = surname;
        }
    }
}
