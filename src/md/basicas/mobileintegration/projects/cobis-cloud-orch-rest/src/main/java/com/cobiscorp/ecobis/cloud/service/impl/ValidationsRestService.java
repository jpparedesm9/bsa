package com.cobiscorp.ecobis.cloud.service.impl;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.errorResponse;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.objectToJson;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.successResponse;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.ValidationsService;
import com.cobiscorp.ecobis.cloud.service.integration.EquivalencesService;
import com.cobiscorp.ecobis.cloud.service.util.Constants;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.RenapoClientRequest;
import com.cobiscorp.mobile.model.RenapoClientResponse;
import com.cobiscorp.mobile.service.interfaces.IBioOnbording;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

@Path("/cobis-cloud/mobile/validations")
@Component
@Service({ ValidationsService.class })
@Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)

public class ValidationsRestService implements ValidationsService {
	private final ILogger logger = LogFactory.getLogger(ValidationsRestService.class);

	// Referencias
	@Reference(bind = "setBioOnbording", unbind = "unsetBioOnbording", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IBioOnbording bioOnbording;
	private EquivalencesService equivalencesService;

	public void setBioOnbording(IBioOnbording bioOnbording) {
		this.bioOnbording = bioOnbording;
	}

	public void unsetBioOnbording(IBioOnbording bioOnbording) {
		this.bioOnbording = null;
	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		equivalencesService = new EquivalencesService(serviceIntegration);
	}

	protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		equivalencesService = null;
	}

	@POST
	@Path("renapo/curp")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response queryRenapoByCurp(@Valid RenapoClientRequest clientRequest) {

		logger.logDebug("/cobis-cloud/mobile/validations/renapo/curp >> " + objectToJson(clientRequest));

		try {
			RenapoClientResponse renapoClientResponse = bioOnbording.generateQuery(clientRequest, SessionManager.getSessionId());
			logger.logDebug("/cobis-cloud/mobile/validations/renapo/curp >> renapoClientResponse=" + renapoClientResponse);
			if (renapoClientResponse == null)
				return errorResponse("/cobis-cloud/mobile/validations/renapo/curp Error al consultar Renapo");
			
			renapoClientResponse.setBirthPlace(equivalencesService.getBirthPlaceEquivalence(renapoClientResponse.getBirthPlace()));
			renapoClientResponse.setSex(Constants.RENAPO_FEMALE.equals(renapoClientResponse.getSex()) ? Constants.RENAPO_EQUIV_FEMALE : Constants.RENAPO_EQUIV_MALE);
			renapoClientResponse.setNationality(Constants.MEX_COUNTRY_CODE);
			return successResponse(renapoClientResponse, "/cobis-cloud/mobile/validations/renapo/curp");

		} catch (MobileServiceException e) {
			logger.logError("Error MobileServiceException: ", e);
			ServiceResponse servResp = new ServiceResponse();
			servResp.setResult(false);
			List<Message> lstMsg = new ArrayList<Message>();
			Message msg = new Message();
			if(e.getMessage() != null) {
				msg.setMessage(e.getMessage());
			}
			else{
				msg.setMessage("/cobis-cloud/mobile/validations/renapo/curp Error al consultar Renapo");
		    }
			lstMsg.add(msg);
			servResp.setMessages(lstMsg);
			
			return errorResponse(servResp);
		} catch (Exception e) {
			logger.logError("Error Exception: ", e);
			return errorResponse("/cobis-cloud/mobile/validations/renapo/curp Error al consultar Renapo");
		}

	}

}
