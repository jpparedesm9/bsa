package com.cobis.gestionasesores.data.models.requests;

/**
 * Created by jescudero on 21/08/2017.
 */

public class DeviceRegistrationData {
    private String alias;
    private String description;

    public DeviceRegistrationData(String alias, String description) {
        this.alias = alias;
        this.description = description;
    }

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
