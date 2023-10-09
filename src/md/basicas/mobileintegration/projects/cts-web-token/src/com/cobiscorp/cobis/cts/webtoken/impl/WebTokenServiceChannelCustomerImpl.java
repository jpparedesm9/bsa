package com.cobiscorp.cobis.cts.webtoken.impl;

import java.util.Map;

/**
 * Created by fervincent on 18/08/17.
 */
public class WebTokenServiceChannelCustomerImpl extends  WebTokenServiceBaseImpl {

    public static final String DEVICE_ID = "deviceId";

    public WebTokenServiceChannelCustomerImpl() {
        super(MOBILE_BANKING_CHANNEL);
    }
    @Override
    protected String getAudience() {
        return "mobilebanking";
    }
    @Override
    protected Map<String, Object> getClaims(Map<String, Object> login) {
        Map<String, Object> claims = super.getClaims(login);
        claims.put(DEVICE_ID, login.get(DEVICE_ID));
        return claims;
    }

}
