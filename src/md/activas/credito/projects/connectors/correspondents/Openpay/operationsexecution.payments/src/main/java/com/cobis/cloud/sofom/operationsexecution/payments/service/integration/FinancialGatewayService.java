package com.cobis.cloud.sofom.operationsexecution.payments.service.integration;

import cobiscorp.ecobis.assets.cloud.dto.ConciliationRequest;
import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobis.cloud.sofom.operationsexecution.payments.service.common.RestServiceBase;
import com.cobis.cloud.sofom.operationsexecution.payments.service.integration.security.COBISSecurityManager;
import com.cobis.cloud.sofom.operationsexecution.payments.service.integration.security.ICustomCode;
import com.cobis.cloud.sofom.operationsexecution.payments.service.integration.security.SessionSecurityKey;
import com.cobis.cloud.sofom.operationsexecution.payments.service.integration.security.dto.CTSServiceResponseTO;
import com.cobis.cloud.sofom.operationsexecution.payments.service.openpay.dto.Event;
import com.cobiscorp.cobis.commons.components.ComponentLocator;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;
import org.apache.commons.lang.time.DateUtils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

/**
 * Created by pclavijo on 25/07/2017.
 */
public class FinancialGatewayService extends RestServiceBase {
    private final ILogger logger = LogFactory.getLogger(FinancialGatewayService.class);
    private static final String className = "[FinancialGatewayService]";

    public FinancialGatewayService(ICTSServiceIntegration integration) {
        super(integration);
    }

    public ServiceResponseTO registerLoanPayment(Event event, String decodedAuth) {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[registerLoanPayment]");
        }

        if (logger.isTraceEnabled()) {
            logger.logTrace("event: " + event);
        }

        ServiceResponseTO serviceResponseTO = new ServiceResponseTO();

        if (event.getType().contentEquals("verification")) {
            BufferedWriter output = null;
            try {
                File file = new File(System.getProperty("COBIS_HOME") + "/openpay.txt");
                output = new BufferedWriter(new FileWriter(file));
                output.write(event.getVerification_code());
            } catch (IOException e) {
                logger.logInfo("event.getVerification_code(): " + event.getVerification_code());
            } finally {
                if (output != null) {
                    try {
                        output.close();
                    } catch (IOException e) {
                        if (logger.isDebugEnabled()) {
                            logger.logDebug("ERROR closing Openpay verification file");
                        }
                    }
                }
            }

            serviceResponseTO.setSuccess(true);
            return serviceResponseTO;
        }

        ConciliationRequest conciliationRequest = new ConciliationRequest();
        conciliationRequest.setCorrespondent("OPEN_PAY");
        conciliationRequest.setCurrency(0); // event.getTransaction().getCurrency()
        conciliationRequest.setReference(event.getTransaction().getPayment_method().getReference());
        conciliationRequest.setStatus(event.getTransaction().getStatus());
        conciliationRequest.setValueDate(DateUtils.toCalendar(event.getTransaction().getOperation_date()));

        if (logger.isTraceEnabled()) {
            logger.logTrace("conciliationRequest: " + conciliationRequest.toString());
        }

        String operationName = "FinancialGatewayService.registerLoanPayment";
        ICustomCode customCode = null;

        CTSServiceResponseTO response = new CTSServiceResponseTO();

        ComponentLocator componentLocator = ComponentLocator.getInstance(this);
        ICTSServiceIntegration ctsServiceIntegration = componentLocator
                .find(ICTSServiceIntegration.class);
        if (ctsServiceIntegration == null) {
            String error = "Could not create implementation of ICTSServiceIntegration";
            handleErrorMessage(
                    operationName,
                    customCode,
                    new Exception(error),
                    response);

            serviceResponseTO.setSuccess(false);
            serviceResponseTO.addMessage(new MessageTO(error));
            return serviceResponseTO;
        }

        ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
        serviceRequestTO
                .setServiceId("Loan.ConciliationManagement.RegisterLoanPayment");
        serviceRequestTO.addValue("inConciliationRequest", conciliationRequest);

//        ServiceResponseTO serviceResponseTO = executeServiceAuthenticated(ctsServiceIntegration, serviceRequestTO);

        SessionSecurityKey wSessionSecurityKey = new SessionSecurityKey();
        COBISSecurityManager.ClearSessionId(wSessionSecurityKey);
        if (!COBISSecurityManager.initializeSession(ctsServiceIntegration,
                wSessionSecurityKey, response, decodedAuth)) {
            if (logger.isErrorEnabled()) {
                logger.logError(response);
            }
            throw new COBISInfrastructureRuntimeException("It is not possible to initialize a new COBIS Session");
        }
        if (logger.isDebugEnabled()) {
            logger.logDebug("sessionId: " + COBISSecurityManager
                    .getSessionId(wSessionSecurityKey));
            logger.logDebug("It is going to assign SessionId to ServiceRequestTO");
        }
        serviceRequestTO.setSessionId(COBISSecurityManager
                .getSessionId(wSessionSecurityKey));
        if (logger.isDebugEnabled()) {
            logger.logDebug("It is going to execute service");
            logger.logDebug("serviceRequestTO.sessionId: " + serviceRequestTO.getSessionId());
        }

        ServiceRequest header = new ServiceRequest();
        header.addFieldInHeader("sessionId", 'S', serviceRequestTO.getSessionId());
        serviceRequestTO.addValue("com.cobiscorp.cobis.cts.service.header", header);
        if (logger.isDebugEnabled()) {
            logger.logDebug("header: " + header.readFieldInHeader("sessionId"));
            logger.logDebug("serviceRequestTO.header: " + serviceRequestTO.getValue("com.cobiscorp.cobis.cts.service.header"));
        }

        serviceResponseTO = ctsServiceIntegration
                .getResponseFromCTS(serviceRequestTO);

/*
        ServiceResponse response = execute(
                "Loan.ConciliationManagement.RegisterLoanPayment",
                serviceRequestTO
        );
*/

        if (logger.isDebugEnabled()) {
            logger.logDebug("serviceResponseTO.isSuccess: " + serviceResponseTO.isSuccess());
        }

        return serviceResponseTO;
    }

    private ServiceResponseTO executeServiceAuthenticated(ICTSServiceIntegration ctsServiceIntegration, ServiceRequestTO serviceRequestTO) {
        try {
            return ctsServiceIntegration
                    .getResponseFromCTS(serviceRequestTO);
        } catch (COBISInfrastructureRuntimeException ex) {
            if (logger.isDebugEnabled()) {
                logger.logDebug("ERROR executing authenticated service", ex);
            }
            return null;
        }
    }

    private void handleErrorMessage(String operationName,
                                    ICustomCode customCode, Object exception, Object serviceResponse) {
        MessageTO msg = null;
        MessageTO[] msgs = null;
        Boolean isCTSServiceResponseTO = CTSServiceResponseTO.class
                .isAssignableFrom(serviceResponse.getClass());
        if (exception != null) {
            if (ServiceResponseTO.class.isAssignableFrom(exception.getClass())) {
                ServiceResponseTO serviceResponseTO = (ServiceResponseTO) exception;
                List<MessageTO> messages = serviceResponseTO
                        .getMessages();
                if (messages != null) {
                    msgs = new MessageTO[messages.size()];
                    int n = 0;
                    for (cobiscorp.ecobis.commons.dto.MessageTO messageTO : messages) {
                        if (logger.isDebugEnabled()) {
                            logger.logDebug(String.format(
                                    "Message [Code:%s Type:%s Text:%s]",
                                    messageTO.getCode(), messageTO.getType(),
                                    messageTO.getMessage()));
                        }
                        msg = new MessageTO();
                        msg.setCode(messageTO.getCode());
                        msg.setMessage(messageTO.getMessage());
                        msg.setType(messageTO.getType());
                        msgs[n++] = msg;
                    }
                }
            } else if (CTSServiceResponseTO.class.isAssignableFrom(exception
                    .getClass())) {
                CTSServiceResponseTO ctsServiceResponseTO = (CTSServiceResponseTO) exception;
                msgs = ctsServiceResponseTO.getMessages();
            } else if (Exception.class.isAssignableFrom(exception.getClass())) {
                Exception ex = (Exception) exception;
                msg = new MessageTO();
                msg.setCode("");
                msg.setMessage(ex.getMessage());
                msgs = new MessageTO[1];
                msgs[0] = msg;
            }
            if (isCTSServiceResponseTO && msgs != null) {
                ((CTSServiceResponseTO) serviceResponse).setMessages(msgs);
            }
        }
    }
}
