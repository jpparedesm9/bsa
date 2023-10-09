package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by mnaunay on 14/07/2017.
 */

public class ValidatePersonRequest {
    private boolean online;
    private DataStruct inValidationProspectRequest;

    public ValidatePersonRequest(boolean online, DataStruct inValidationProspectRequest) {
        this.online = online;
        this.inValidationProspectRequest = inValidationProspectRequest;
    }

    public boolean isOnline() {
        return online;
    }

    public void setOnline(boolean online) {
        this.online = online;
    }

    public DataStruct getInValidationProspectRequest() {
        return inValidationProspectRequest;
    }

    public void setInValidationProspectRequest(DataStruct inValidationProspectRequest) {
        this.inValidationProspectRequest = inValidationProspectRequest;
    }

    public static class DataStruct {
        private int customerId;

        public DataStruct(int customerId) {
            this.customerId = customerId;
        }

        public int getCustomerId() {
            return customerId;
        }

        public void setCustomerId(int customerId) {
            this.customerId = customerId;
        }
    }
}
