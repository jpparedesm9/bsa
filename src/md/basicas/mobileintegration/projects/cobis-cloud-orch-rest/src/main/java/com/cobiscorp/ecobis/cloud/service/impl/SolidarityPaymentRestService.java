package com.cobiscorp.ecobis.cloud.service.impl;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.cloud.service.SolidarityPaymentService;
import com.cobiscorp.ecobis.cloud.service.dto.solidaritypayment.SolidarityPaymentRequest;
import com.cobiscorp.ecobis.cloud.service.util.IntegrationException;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.errorResponse;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.objectToJson;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.successResponse;

/**
 * Created by farid on 7/24/2017.
 */

@Path("/cobis-cloud/mobile/solidarityPayment")
@Component
@Service({SolidarityPaymentService.class})
@Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
public class SolidarityPaymentRestService implements SolidarityPaymentService{

    private final ILogger logger = LogFactory.getLogger(SolidarityPaymentRestService.class);
    private com.cobiscorp.ecobis.cloud.service.integration.SolidarityPaymentService solidarityPaymentService;


    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Override
    public Response createSolidarityPayment(SolidarityPaymentRequest data) {
	
       try {
    		logger.logInfo(
    				"/cobis-cloud/mobile/group/createSolidarityPayment " + objectToJson(data));
            solidarityPaymentService.createSolidarityPayment(data);
            return successResponse(null,"/cobis-cloud/mobile/group/createSolidarityPayment");
       } catch (IntegrationException ie) {
			logger.logError("/cobis-cloud/mobile/group/createSolidarityPayment Error al crear pago solidario", ie);
			return errorResponse(ie.getResponse());
		} catch (Exception e) {
			logger.logError("/cobis-cloud/mobile/group/createSolidarityPayment Error al crear miembro", e);
			return errorResponse("/cobis-cloud/mobile/group/createSolidarityPayment Error al crear pago solidario");
		}
    }


    protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
        this.solidarityPaymentService = new com.cobiscorp.ecobis.cloud.service.integration.SolidarityPaymentService(serviceIntegration);
    }

    protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
        this.solidarityPaymentService = new com.cobiscorp.ecobis.cloud.service.integration.SolidarityPaymentService(serviceIntegration);
    }
}
