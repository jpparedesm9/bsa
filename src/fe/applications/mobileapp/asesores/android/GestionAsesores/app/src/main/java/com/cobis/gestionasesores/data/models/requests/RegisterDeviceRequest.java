package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by jescudero on 8/19/2017.
 */

public class RegisterDeviceRequest {
    private DeviceRegistrationData deviceRegistrationData;
    private boolean online;

    public RegisterDeviceRequest() {
    }
    public RegisterDeviceRequest(Builder builder){
        this.deviceRegistrationData = builder.deviceRegistrationData;
        this.online = builder.online;
    }

    public DeviceRegistrationData getDeviceRegistrationData() {
        return deviceRegistrationData;
    }

    public boolean isOnline() {
        return online;
    }



    public static class Builder {
        private DeviceRegistrationData deviceRegistrationData;
        private boolean online;

        public Builder setDeviceRegistrationData(DeviceRegistrationData deviceRegistrationData) {
            this.deviceRegistrationData = deviceRegistrationData;
            return this;
        }

        public Builder setOnline(boolean online) {
            this.online = online;
            return this;
        }

        public RegisterDeviceRequest build () {
            return new RegisterDeviceRequest(this);
        }
    }
}
