package com.cobiscorp.cobis.cts.webtoken.impl;

import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.cts.webtoken.api.IWebTokenService;

import java.util.Map;

/**
 * Created by fervincent on 18/08/17.
 */
public class WebTokenFactory {

    public static IWebTokenService getService(Map<String, Object> login) {

        Integer channel = (Integer)login.get(IWebTokenService.CHANNEL);

        if(channel == null) {
            throw new COBISInfrastructureRuntimeException("channel is required in order to generate token");
        }
        return getService(channel);
    }

    public static IWebTokenService getService(int channel) {
        if (channel == IWebTokenService.MOBILE_OFFICIAL_CHANNEL) {
            return new WebTokenServiceChannelOfficerImpl();
        } else if (channel == IWebTokenService.MOBILE_BANKING_CHANNEL) {
            return new WebTokenServiceChannelCustomerImpl();
        }
        else {
            throw new COBISInfrastructureRuntimeException("Not implemented for channel:" + channel);

        }

    }
}
