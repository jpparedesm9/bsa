package com.cobiscorp.ecobis.cobiscloud.loginvalidationext.impl;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import com.cobiscorp.cobis.commons.converters.ByteConverter;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;
import com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.MacsToValidate;
import com.cobiscorp.ecobis.services.extended.api.IExtendedServices;
import com.cobiscorp.ecobis.services.extended.api.dto.ExtendedServiceException;
import com.cobiscorp.ecobis.services.extended.api.dto.ExtendedServiceResponse;
import org.apache.commons.codec.binary.Base64;
import org.codehaus.jackson.map.ObjectMapper;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceExecutorClient;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TerminalValidationImpl implements IExtendedServices {

    public static Integer MOBILE_OFFICIAL_CHANNEL = 20;
    public static final String CHANNEL_PARAMETER = "channel";

    private static ILogger logger = LogFactory.getLogger(TerminalValidationImpl.class);


    private ICTSServiceExecutorClient serviceExecutorClient;

    @Override
    public ExtendedServiceResponse validateTerminal(Map<String, Object> map) throws ExtendedServiceException {
        try {
            return validateTerminalInternall(map);
        }catch (Exception e) {
            logger.logError("error", e);
            throw new ExtendedServiceException("Problemas validando el terminal");
        }
    }

    private ExtendedServiceResponse validateTerminalInternall(Map<String, Object> map) {
        Integer channel = (Integer) map.get(CHANNEL_PARAMETER);
        if(MOBILE_OFFICIAL_CHANNEL.equals(channel)) {
            return createEmptySuccessResponse();
        }
        String token = (String) map.get("token");
        logger.logDebug("token:" + token);

        Map<String, Object> objectFromToken = getObjectFromToken(token);
        List<String> macsFromToken = (List<String>) objectFromToken.get("macs");
        ExtendedServiceResponse extendedServiceResponse = new ExtendedServiceResponse();
        if(areValidMacs(macsFromToken)) {
            extendedServiceResponse.setSuccess(true);
            logger.logDebug("Terminal autorizada");
        } else {
            extendedServiceResponse.setSuccess(false);
            extendedServiceResponse.addMessage("-1", "COMMONS.SECURITY.MSG_TERMINAL_VALIDATION_FAILED");
            logger.logDebug("Terminal no autorizada");
        }
        return extendedServiceResponse;
    }

    private Map<String, Object> getObjectFromToken(String token) {
        Base64 base64 = new Base64();
        byte[] bytesToken =base64.decode(token);
        KeepSecurity keepSecurity = new KeepSecurity(
                ByteConverter.tranformToHex(Activator.getPrivateKey()).toCharArray());
        String decrypted = keepSecurity.decrypt(ByteConverter.tranformToHex(bytesToken));
        logger.logDebug("decrypted:" + decrypted);
        return readObjectFromJson(decrypted);

    }

    private Boolean areValidMacs(List<String> macsFromToken) {
        MacsToValidate macsToValidate = new MacsToValidate();
        if(macsFromToken.size() >= 1) {
            macsToValidate.setMac(macsFromToken.get(0));
        }
        if(macsFromToken.size() >= 2) {
            macsToValidate.setMac1(macsFromToken.get(1));
        }

        if(macsFromToken.size() >= 3) {
            macsToValidate.setMac2(macsFromToken.get(2));
        }

        ServiceResponseTO serviceResponse = this.execute("com.santander.commons.extlogin.LoginValidation",new Object[] {
                macsToValidate
        });

        if(!serviceResponse.isSuccess()) {
            throw new COBISInfrastructureRuntimeException("Problems when executing service to validate macs");
        }

        return (Boolean)serviceResponse.getValue("SERVICE_RESPONSE");

    }

    private ExtendedServiceResponse createEmptySuccessResponse() {
        ExtendedServiceResponse extendedServiceResponse = new ExtendedServiceResponse();
        extendedServiceResponse.setSuccess(true);
        return extendedServiceResponse;
    }

    public Map<String, Object> readObjectFromJson(String jsonObject) {
        ObjectMapper mapper = new ObjectMapper();
        try {
            Map<String, Object> object = mapper.readValue(jsonObject, HashMap.class);
            return object;
        } catch (IOException e) {
            throw new COBISInfrastructureRuntimeException("Problems when read json object", e);
        }


    }

    protected ServiceResponseTO execute(String serviceId,
                                        Object[] arrInData)
    {
        ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
        ServiceResponseTO serviceResponse;
        ServiceRequest header = new ServiceRequest();
        serviceRequestTO.addValue("com.cobiscorp.cobis.cts.service.header", header);
        serviceRequestTO.setServiceId(serviceId);
        serviceRequestTO.addValue("SERVICE_PARAMETERS", arrInData);
        String url = "Business";

        ServiceRequest serviceRequest = new ServiceRequest();
        serviceRequest.setServiceRequestTO(serviceRequestTO);
        serviceRequest.addFieldInHeader("serviceId", 'S', serviceRequestTO.getServiceId());

        serviceResponse = getServiceExecutorClient().execute(url, serviceRequest);
        return serviceResponse;

    }

    public ICTSServiceExecutorClient getServiceExecutorClient() {
        return serviceExecutorClient;
    }

    public void setServiceExecutorClient(ICTSServiceExecutorClient serviceExecutorClient) {
        this.serviceExecutorClient = serviceExecutorClient;
    }
}
