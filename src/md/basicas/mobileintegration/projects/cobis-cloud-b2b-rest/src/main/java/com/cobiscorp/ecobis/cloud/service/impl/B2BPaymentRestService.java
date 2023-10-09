package com.cobiscorp.ecobis.cloud.service.impl;

import static com.cobiscorp.ecobis.cloud.service.common.ServiceResponseTool.createEmptyServiceResponse;
import static com.cobiscorp.ecobis.cloud.service.common.ServiceResponseTool.errorResponse;
import static com.cobiscorp.ecobis.cloud.service.common.ServiceResponseTool.successResponse;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.cloud.service.B2BPaymentService;
import com.cobiscorp.ecobis.cloud.service.common.IntegrationException;
import com.cobiscorp.ecobis.cloud.service.dto.PaymentRequestDTO;
import com.cobiscorp.ecobis.cloud.service.integration.PaymentIntegration;

@Path("/cobis-cloud/mobile/b2b/paymentService")
@Component
@Service({ B2BPaymentService.class })
@Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
public class B2BPaymentRestService implements B2BPaymentService {

	private final ILogger LOGGER = LogFactory.getLogger(B2BPaymentRestService.class);
	private PaymentIntegration paymentIntegration;


	@Path("/applyPayment")
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response applyPayment(PaymentRequestDTO paymentRequestDTO) {
		try {
			paymentIntegration.applyPayment(paymentRequestDTO);
			return successResponse(createEmptyServiceResponse());
		} catch (IntegrationException ie) {
			LOGGER.logError("/cobis-cloud/mobile/b2b/paymentService/applyPayment Error en la aplicación del pago ", ie);
			return successResponse(ie.getResponse());
		} catch (Exception e) {
			LOGGER.logError("/cobis-cloud/mobile/b2b/paymentService/applyPayment Error en la aplicación del pago ", e);
			return errorResponse("/cobis-cloud/mobile/b2b/paymentService/queryPaymentInformation Error en la aplicación del pago ");
		}
	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.paymentIntegration = new PaymentIntegration(serviceIntegration);

	}

	protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.paymentIntegration = new PaymentIntegration(serviceIntegration);

	}
}
