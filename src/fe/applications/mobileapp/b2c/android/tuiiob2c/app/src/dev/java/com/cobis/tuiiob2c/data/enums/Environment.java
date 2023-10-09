package com.cobis.tuiiob2c.data.enums;

import com.cobis.tuiiob2c.BuildConfig;

public enum Environment {
    TEST(BuildConfig.ENVIRONMENT_TEST),
    TEST_COBIS(BuildConfig.ENVIRONMENT_TEST_COBIS),
    SAFE(BuildConfig.ENVIRONMENT_SAFE),
    DEV(BuildConfig.ENVIRONMENT_DEV),
    DEV_COBIS(BuildConfig.ENVIRONMENT_DEV_COBIS),
    SUSTAINING(BuildConfig.ENVIRONMENT_SUSTAINING),
    SUSTAINING2(BuildConfig.ENVIRONMENT_SUSTAINING_2),
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