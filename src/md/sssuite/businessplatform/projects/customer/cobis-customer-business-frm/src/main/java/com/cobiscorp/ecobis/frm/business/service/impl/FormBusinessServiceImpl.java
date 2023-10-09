package com.cobiscorp.ecobis.frm.business.service.impl;

import static com.cobiscorp.ecobis.frm.business.util.ServiceResponseUtil.errorResponse;
import static com.cobiscorp.ecobis.frm.business.util.ServiceResponseUtil.successResponse;

import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.frm.business.dto.FormAnswers;
import com.cobiscorp.ecobis.frm.business.exception.FormBusinessException;
import com.cobiscorp.ecobis.frm.business.manager.FormManager;
import com.cobiscorp.ecobis.frm.business.service.IFormBusinessService;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

@Path("/cobis/web/customerbusiness")
@Component
@Service({ IFormBusinessService.class })
@org.apache.felix.scr.annotations.Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)

public class FormBusinessServiceImpl implements IFormBusinessService {
	private final ILogger logger = LogFactory.getLogger(FormBusinessServiceImpl.class);

	private FormManager formManager;

	@Path("/formBusiness/{id}/{processIntance}/{stage}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response getFormData(@PathParam("id") Integer id, @PathParam("processIntance") Integer processIntance,
			@PathParam("stage") String stage) {
		logger.logInfo("Inicia getFormData");
		try {
			return successResponse(formManager.getFormData(id, processIntance, stage),
					"GET /cobis/web/customerbusiness/formBusiness");
		} catch (Exception e) {
			logger.logError("Error al obtener el formulario", e);
			return errorResponse("Error al obtener el formulario");
		} finally {
			logger.logInfo("Finaliza getFormData");
		}

	}

	@Path("/formBusiness")
	@PUT
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response saveAnswer(FormAnswers formAnswers) {
		logger.logInfo("Inicia saveAnswer");
		try {
			return successResponse(formManager.saveAnswer(formAnswers), "PUT /cobis/web/customerbusiness/formBusiness");
		} catch (FormBusinessException fe) {
			logger.logError("Error al grabar el formulario " + fe.getMessage());
			return errorResponse(fe.getMessage());
		} catch (Exception e) {
			logger.logError("Error al grabar la respuesta", e);
			return errorResponse("Error al grabar la respuesta");
		} finally {
			logger.logInfo("Finaliza saveAnswer");
		}

	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.formManager = new FormManager(serviceIntegration);
	}

	protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.formManager = new FormManager(serviceIntegration);
	}
}
