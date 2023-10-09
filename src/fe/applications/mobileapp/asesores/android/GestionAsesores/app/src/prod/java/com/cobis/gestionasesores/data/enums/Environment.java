package com.cobis.gestionasesores.data.enums;

import com.cobis.gestionasesores.BuildConfig;

/**
 * Created by Jose on 11/1/2017.
 */

public enum Environment {
    PROD(BuildConfig.ENVIRONMENT_PROD),
    DRP(BuildConfig.ENVIRONMENT_DRP);

    private final String mEndPoint;

    Environment(String endPoint) {
        this.mEndPoint = endPoint;
    }

    public String getEndPoint() {
        return mEndPoint;
    }
}