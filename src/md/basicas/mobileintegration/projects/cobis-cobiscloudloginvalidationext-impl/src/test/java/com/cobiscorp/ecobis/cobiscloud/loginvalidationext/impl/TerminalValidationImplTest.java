package com.cobiscorp.ecobis.cobiscloud.loginvalidationext.impl;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceExecutorClient;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;
import com.cobiscorp.ecobis.services.extended.api.IExtendedServices;
import com.cobiscorp.ecobis.services.extended.api.dto.ExtendedServiceException;
import com.cobiscorp.ecobis.services.extended.api.dto.ExtendedServiceMessage;
import com.cobiscorp.ecobis.services.extended.api.dto.ExtendedServiceResponse;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import static org.mockito.Mockito.*;
import org.powermock.reflect.Whitebox;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TerminalValidationImplTest {
    IExtendedServices instance;
    ServiceResponseTO serviceResponseTO = new ServiceResponseTO();

    ICTSServiceExecutorClient serviceExecutorClient;
    String token = "OWvxvJdUIwzEqRmMhwff3BQ36Q12H1euNMr7e79DWyudd3Yx3YRCFBJM34R2KeTp1v2GNFUYyGTagoiWopp3CnL9leZrpM941isyeTFJQ/o36v6NkvtM0ALXyafEfj9N91+NiaGzBdCylsTMNN33GClUr4ZOAGpkl1GIvhOttATpDleOKmmaaH2c0dew3Biht//kElgRBBT6v/+cuFsVBZWBqGSTjv1KV7liElxjwE4ekRPJr68/OP8bbgo2ofrMN1qu5HPeG/ng3aM4V6wMVYtBVBPkjMLLbiZZwW2+VgnnOLHhOQLd3tE8M1R3IOKlLndXg+RxsSdqPkWFXKQQ/g\u003d\u003d";
    Map<String, Object> fromLogin = new HashMap<String, Object>();
    @Before
    public void setUp() {
        System.setProperty("COBIS_HOME","COBIS_HOME");
        Activator.loadConfig();
        fromLogin = new HashMap<String, Object>();
        fromLogin.put("token",token);

        serviceExecutorClient = mock(ICTSServiceExecutorClient.class);

        instance = new TerminalValidationImpl();
        ((TerminalValidationImpl)instance).setServiceExecutorClient(serviceExecutorClient);

    }

    @Test
    public void testRetrieveObjectFromToken() throws Exception {

        Map<String, Object> tokenObject = Whitebox.invokeMethod(instance, "getObjectFromToken", token);
        System.out.println("tokenObject:" + tokenObject);
        List<String> macs = (List<String>) tokenObject.get("macs");
        Assert.assertNotNull(macs);
        Assert.assertTrue(macs.contains("70-5A-0F-97-AA-36"));
    }

    @Test
    public void validateError() throws ExtendedServiceException {
        serviceResponseTO.setSuccess(true);
        serviceResponseTO.addValue("SERVICE_RESPONSE", Boolean.FALSE);
        //when(ctsServiceIntegration.getResponseFromCTS(any(ServiceRequestTO.class))).thenReturn(serviceResponseTO);
        when(serviceExecutorClient.execute(anyString(),any(ServiceRequest.class))).thenReturn(serviceResponseTO);
        instance = new TerminalValidationImpl();
        //((TerminalValidationImpl)instance).setServiceIntegration(ctsServiceIntegration);
        ((TerminalValidationImpl)instance).setServiceExecutorClient(serviceExecutorClient);

        ExtendedServiceResponse extendedServiceResponse = instance.validateTerminal(fromLogin);
        Assert.assertFalse(extendedServiceResponse.isSuccess());
        ExtendedServiceMessage extendedServiceMessage = extendedServiceResponse.getMessages().get(0);
        Assert.assertEquals("-1", extendedServiceMessage.getCode());
        Assert.assertEquals("COMMONS.SECURITY.MSG_TERMINAL_VALIDATION_FAILED", extendedServiceMessage.getMessage());


    }

    @Test
    public void validateSuccess() throws ExtendedServiceException {
        serviceResponseTO.setSuccess(true);
        serviceResponseTO.addValue("SERVICE_RESPONSE", Boolean.TRUE);
        //when(ctsServiceIntegration.getResponseFromCTS(any(ServiceRequestTO.class))).thenReturn(serviceResponseTO);
        when(serviceExecutorClient.execute(anyString(),any(ServiceRequest.class))).thenReturn(serviceResponseTO);
        instance = new TerminalValidationImpl();
        //((TerminalValidationImpl)instance).setServiceIntegration(ctsServiceIntegration);
        ((TerminalValidationImpl)instance).setServiceExecutorClient(serviceExecutorClient);
        ExtendedServiceResponse extendedServiceResponse = instance.validateTerminal(fromLogin);
        Assert.assertTrue(extendedServiceResponse.isSuccess());
    }

    @Test
    public void itShouldValidateADifferentChannel() throws ExtendedServiceException {
        instance = new TerminalValidationImpl();
        fromLogin.put(TerminalValidationImpl.CHANNEL_PARAMETER,
                TerminalValidationImpl.MOBILE_OFFICIAL_CHANNEL);
        ExtendedServiceResponse extendedServiceResponse = instance.validateTerminal(fromLogin);

        Assert.assertTrue(extendedServiceResponse.isSuccess());
    }


    @Test(expected = ExtendedServiceException.class)
    public void itShouldThrowException() throws ExtendedServiceException {
        fromLogin.put("token", "A" + token);
        instance = new TerminalValidationImpl();
        ExtendedServiceResponse extendedServiceResponse = instance.validateTerminal(fromLogin);

    }
}
