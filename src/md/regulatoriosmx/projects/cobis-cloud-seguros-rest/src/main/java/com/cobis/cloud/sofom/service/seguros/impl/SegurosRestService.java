package com.cobis.cloud.sofom.service.seguros.impl;

import static com.cobis.cloud.sofom.service.seguros.utils.ServiceResponseUtil.objectToJson;
import static com.cobis.cloud.sofom.service.seguros.utils.ServiceResponseUtil.successResponse;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobis.cloud.sofom.service.seguros.SegurosService;
import com.cobis.cloud.sofom.service.seguros.common.ServiceResponseTool;
import com.cobis.cloud.sofom.service.seguros.dto.Collection;
import com.cobis.cloud.sofom.service.seguros.dto.CollectionResponse;
import com.cobis.cloud.sofom.service.seguros.dto.SolidarityPaymentRequest;
import com.cobis.cloud.sofom.service.seguros.integration.SegurosIntegration;
import com.cobis.cloud.sofom.service.seguros.utils.ServiceResponseUtil;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mccollect.dto.CollectPaymentsResponse;
import cobiscorp.ecobis.mccollect.dto.PaymentSolidarityRequest;

@Path("/extServices/cobranzas")
@Component
@Service({ SegurosService.class })
@Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
public class SegurosRestService implements SegurosService {

    private static final ILogger LOGGER = LogFactory.getLogger(SegurosRestService.class);

    private SegurosIntegration collectIntegration;

    @Path("/consulta/{LoanNumber}")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Override
    public Response consulta(@PathParam("LoanNumber") String loanNumber) {

	LOGGER.logDebug("Start Rest: /cobranzas/consulta/{LoanNumber} >> {" + loanNumber + "}");
	LOGGER.logDebug("Loan Number: " + loanNumber);

	CollectionResponse collectioResponse = new CollectionResponse();
	ServiceResponse serviceResponse = new ServiceResponse();

	try {

	    Collection collection = new Collection();
	    CollectPaymentsResponse[] listCollection = collectIntegration.searchListPaymentsCollect(loanNumber);
	    List<Collection> upListCollect = new ArrayList();

	    if (listCollection != null) {
		LOGGER.logDebug("Number of files to upload " + listCollection.length);
		if (listCollection.length > 0) {
		    for (int i = 0; i < listCollection.length; i++) {
			collection = new Collection();

			LOGGER.logDebug("collection >> " + listCollection[i].getCoFechaValor());
			LOGGER.logDebug("collection >> " + listCollection[i].getCdSecIng());
			LOGGER.logDebug("collection >> " + listCollection[i].getCoMonto());

			collection.setPaymentNumber(listCollection[i].getCdSecIng());
			collection.setPaymentDate(listCollection[i].getCoFechaValor());
			collection.setPaymentAmount(BigDecimal.valueOf(listCollection[i].getCoMonto()));

			LOGGER.logDebug(collection);

			upListCollect.add(collection);

		    }
		    collectioResponse.setPagos(upListCollect);
		} else {
		    LOGGER.logDebug("There is no payment list");
		}
	    } else {
		LOGGER.logDebug("There is no historical payment list for the operation");
	    }

	} catch (Exception e) {

	    LOGGER.logError("/cobranzas/consulta/{LoanNumber}", e);
	    serviceResponse.setResult(false);
	    serviceResponse.setData(null);
	    serviceResponse.addMessage("500", "Error al obtener histÃ³rico de pagos");

	}

	return successResponse(collectioResponse, true, "/cobranzas/consulta/{LoanNumber} >> Response >> " + objectToJson(collectioResponse));
    }
    
    @Path("/paymentService/updateSolidarityPayment")
    @PUT
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response updateSolidarityPayment(SolidarityPaymentRequest solidarityPaymentRequest) {
    	LOGGER.logDebug("/paymentService/updateSolidarityPayment request >> ");
    	LOGGER.logDebug("/paymentService/updateSolidarityPayment request >> "+ objectToJson(solidarityPaymentRequest));
		ServiceResponse serviceResponse = new ServiceResponse();
    	
    	
		try {
			PaymentSolidarityRequest paymentSolidarityRequest = new PaymentSolidarityRequest();
			paymentSolidarityRequest.setIdContrato(solidarityPaymentRequest.getGroupOperation());
			paymentSolidarityRequest.setTotalAmount(String.valueOf(solidarityPaymentRequest.getTotalValue()));
			paymentSolidarityRequest.setPaymentChannel(solidarityPaymentRequest.getPaymentChannel());
			paymentSolidarityRequest.setDelete("S");

			LOGGER.logDebug("solidarityPaymentRequest.getGroupOperation" + paymentSolidarityRequest.getOperation());

			for (int i = 0; i < solidarityPaymentRequest.getPayments().size(); i++) {
				LOGGER.logDebug("Opcion I");
				paymentSolidarityRequest.setOperation("I");
				paymentSolidarityRequest.setIdClient(solidarityPaymentRequest.getPayments().get(i).getIdClient());
				paymentSolidarityRequest.setCustomerAmount(String.valueOf(solidarityPaymentRequest.getPayments().get(i).getPayment()));
				LOGGER.logDebug("solidarityPaymentRequest.getPayments().get(i).getIdClient() " + solidarityPaymentRequest.getPayments().get(i).getIdClient());
				LOGGER.logDebug("solidarityPaymentRequest.getPayments().get(i).getPayment() " + solidarityPaymentRequest.getPayments().get(i).getPayment());
				LOGGER.logDebug("solidarityPaymentRequest.getPayments().get(i).getPayment() String " + String.valueOf(solidarityPaymentRequest.getPayments().get(i).getPayment()));
				// ejecucion del servicio con opcion I
				collectIntegration.insertTempPaymentSolidarity(paymentSolidarityRequest);
				paymentSolidarityRequest.setDelete("N");
				LOGGER.logDebug("Finaliza opcion I");

			}
			// Ininia validaciones al sp
			paymentSolidarityRequest.setOperation("V");
			serviceResponse = collectIntegration.validatePaymentSolidarity(paymentSolidarityRequest);		
			if (!serviceResponse.isResult()) {
				for (Message message : serviceResponse.getMessages()) {
					LOGGER.logDebug("eroor mesaje-->" + message.getCode());
					LOGGER.logDebug("eroor mesaje-->" + message.getMessage());		
					return ServiceResponseUtil.successResponse(serviceResponse, false, "/paymentService/validatePaymentSolidarity request>> ");
				}

			}
			LOGGER.logDebug("Finaliza opcion V");
			
			//pasa las validaciones llega al ingreso
			
			paymentSolidarityRequest.setOperation("P");
			serviceResponse = collectIntegration.updatePaymentSolidarity(paymentSolidarityRequest);		
			if (!serviceResponse.isResult()) {
				for (Message message : serviceResponse.getMessages()) {
					LOGGER.logDebug("eroor mesaje-->" + message.getCode());
					LOGGER.logDebug("eroor mesaje-->" + message.getMessage());		
					return ServiceResponseUtil.successResponse(serviceResponse, false, "/paymentService/updateSolidarityPayment request>> ");
				}

			}
			LOGGER.logDebug("Finaliza opcion P");
			
			

		} catch (Exception e) {
			// TODO: handle exception
			LOGGER.logDebug("serviceResponse.getData()" + serviceResponse.getData());
			LOGGER.logDebug("serviceResponse.getMessages()" + serviceResponse.getMessages());
			LOGGER.logDebug("Error", e);

			return ServiceResponseTool.errorResponse(e.getMessage());
		
			
		}

		LOGGER.logDebug("/paymentService/updateSolidarityPayment request >> ");
		serviceResponse.setData("ok");
		serviceResponse.setMessages(null);
		serviceResponse.setResult(true);
		return ServiceResponseUtil.successResponse(serviceResponse, true, "OK");
    	
    }

    protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
	this.collectIntegration = new SegurosIntegration(serviceIntegration);
    }

    protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
	this.collectIntegration = new SegurosIntegration(serviceIntegration);
    }

}
