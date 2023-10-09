package com.cobis.cloud.sofom.operationsexecution.payments.service.openpay.impl;

import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobis.cloud.sofom.operationsexecution.payments.service.IFinancialGateway;
import com.cobis.cloud.sofom.operationsexecution.payments.service.common.IntegrationException;
import com.cobis.cloud.sofom.operationsexecution.payments.service.integration.FinancialGatewayService;
import com.cobis.cloud.sofom.operationsexecution.payments.service.openpay.dto.Event;
import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;
import sun.misc.BASE64Decoder;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.HeaderParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.IOException;

import static com.cobis.cloud.sofom.operationsexecution.payments.service.common.ServiceResponseTool.errorResponse;
import static com.cobis.cloud.sofom.operationsexecution.payments.service.common.ServiceResponseTool.successResponse;

/**
 * Created by pclavijo on 24/07/2017.
 */
@Path("/cobis/web/openpay-listener")
@Component
@Service({IFinancialGateway.class})
@Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
public class FinancialGatewayRest implements IFinancialGateway {
    private final static ILogger logger = LogFactory.getLogger(FinancialGatewayRest.class);
    private static final String className = "[FinancialGatewayRest]";

    private FinancialGatewayService financialGatewayService;

    @Path("/receive-event")
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Override
    public Response receivePaymentEvent(Event event, @HeaderParam("authorization") String authString, @Context HttpServletRequest requestContext) {
//    public Response receivePaymentEvent(Event event) {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[receivePaymentEvent]");
            logger.logDebug("Remote Address: " + requestContext.getRemoteAddr());
        }

        String messageError;

        String decodedAuth = "";
        if (authString == null) {
            return errorResponse("{\"error\":\"Authentication information required\"}");
        } else {
            decodedAuth = getAuthenticationInformation(authString);
            String[] authentication = decodedAuth.split(":");
/*
            if (logger.isTraceEnabled()) {
                logger.logTrace("authentication[0]: " + authentication[0]);
                logger.logTrace("authentication[1]: " + authentication[1]);
            }
*/
            if (!authentication[0].contentEquals("openpay")) {
                return errorResponse("{\"error\":\"User not authenticated\"}");
            }
        }

        try {
            ServiceResponseTO serviceResponseTO = financialGatewayService.registerLoanPayment(event, decodedAuth);
            if (serviceResponseTO.isSuccess()) {
                return successResponse(serviceResponseTO.getMessages());
            } else {
                if (logger.isErrorEnabled()) {
                    logger.logError(serviceResponseTO.getMessages());
                }
                if (serviceResponseTO.getData().get("message") == null || "".equals(serviceResponseTO.getData().get("message").toString().trim())) {
                    messageError = "Error al recibir Notificación de Openpay";
                } else {
                    messageError = serviceResponseTO.getData().get("message").toString();
                }
                return errorResponse(new MessageTO(messageError));
            }
        } catch (IntegrationException ie) {
            messageError = "Integration Error in rest service to receive payments from Openpay";
            if (logger.isErrorEnabled()) {
                logger.logError(messageError, ie);
            }
            return errorResponse(new MessageTO(messageError));
        } catch (Exception e) {
            messageError = "Error in rest service to receive payments from Openpay";
            if (logger.isErrorEnabled()) {
                logger.logError(messageError, e);
            }
            return errorResponse(new MessageTO(messageError));
        }
    }

    private String getAuthenticationInformation(String authString) {
        if (logger.isTraceEnabled()) {
            logger.logTrace("authString: " + authString);
        }

        String decodedAuth = "";

        // Header is in the format "Basic 5tyc0uiDat4"
        // We need to extract data before decoding it back to original string
        String[] authParts = authString.split("\\s+");
        String authInfo = authParts[1];
        if (logger.isTraceEnabled()) {
            logger.logTrace("authInfo: " + authInfo.toString());
        }
        // Decode the data back to original string
        byte[] bytes = null;
        try {
            bytes = new BASE64Decoder().decodeBuffer(authInfo);
        } catch (IOException e) {
            String errorMessage = "Error receiving Authentication information";
            if (logger.isErrorEnabled()) {
                logger.logError(errorMessage, e);
            }
            throw new COBISInfrastructureRuntimeException(errorMessage);
        }
        decodedAuth = new String(bytes);
/*
        if (logger.isTraceEnabled()) {
            logger.logTrace("decodedAuth: " + decodedAuth);
        }
*/

        return decodedAuth;
    }

    protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
        this.financialGatewayService = new FinancialGatewayService(serviceIntegration);
    }

    protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
        this.financialGatewayService = new FinancialGatewayService(serviceIntegration);
    }
}
