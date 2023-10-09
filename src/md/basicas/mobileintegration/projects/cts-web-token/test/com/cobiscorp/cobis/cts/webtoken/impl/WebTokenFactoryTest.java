package com.cobiscorp.cobis.cts.webtoken.impl;

import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.cts.webtoken.api.IWebTokenService;
import org.junit.Assert;
import org.junit.Test;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by fabad on 18/08/17.
 */
public class WebTokenFactoryTest {

    @Test(expected = COBISInfrastructureRuntimeException.class)
    public void itShouldValidateChannel() {
        Map<String, Object> login = new HashMap<String, Object>();
        IWebTokenService webTokenService = WebTokenFactory.getService(login);
    }


    public void itShouldGetByChannel() {

        IWebTokenService webTokenService = WebTokenFactory.getService(IWebTokenService.MOBILE_OFFICIAL_CHANNEL);
        Assert.assertNotNull(webTokenService);
    }


    @Test(expected = COBISInfrastructureRuntimeException.class)
    public  void itShoulGiveErrorInNoHaveImplementationForChanel() {
        Map<String, Object> login = new HashMap<String, Object>();
        login.put(IWebTokenService.CHANNEL, 50);
        IWebTokenService webTokenService = WebTokenFactory.getService(login);
    }

    @Test
    public void itShouldGiveImplementationForChannel20(){
        Map<String, Object> login = new HashMap<String, Object>();
        login.put(IWebTokenService.CHANNEL, IWebTokenService.MOBILE_OFFICIAL_CHANNEL);
        IWebTokenService webTokenService = WebTokenFactory.getService(login);
        Assert.assertNotNull(webTokenService);

    }


}
