package com.cobiscorp.ecobis.cloud.service.impl;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.createServiceResponse;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.errorResponse;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.objectToJson;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.successResponse;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
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

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.VerificationService;
import com.cobiscorp.ecobis.cloud.service.dto.verification.VerificationData;
import com.cobiscorp.ecobis.cloud.service.dto.verification.VerificationResponse;
import com.cobiscorp.ecobis.cloud.service.dto.verification.VerificationResult;
import com.cobiscorp.ecobis.cloud.service.integration.AddressIntegrationService;
import com.cobiscorp.ecobis.cloud.service.integration.VerificationIntegrationService;
import com.cobiscorp.ecobis.cloud.service.integration.WorkflowService;
import com.cobiscorp.ecobis.cloud.service.util.IntegrationException;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.GeoreferencingRequest;

@Path("/cobis-cloud/mobile/verification")
@Component
@Service({ VerificationService.class })
@Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)

public class VerificationServiceRest implements VerificationService {

	private final ILogger logger = LogFactory.getLogger(VerificationServiceRest.class);
	private VerificationIntegrationService integrationService;
	private WorkflowService workflowService;
	private AddressIntegrationService addressService;

	@Path(("/{processInstance}"))
	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response updateDataVerification(@PathParam("processInstance") int processInstance,
			VerificationData verificationData) {
		logger.logInfo("Inicia /cobis-cloud/mobile/verification/updateDataVerification processInstance"
				+ processInstance + " Request>>" + objectToJson(verificationData));
		try {

			VerificationResponse verificationResponse = new VerificationResponse();
			integrationService.updateDataVerification(verificationData.getVerification().toRequest());
			VerificationResult verification = integrationService
					.getResultVerification(verificationData.getVerification().toRequest());
			verificationResponse.setVerification(createServiceResponse(verification));

			if (verificationData.getVerification().getBusinessAddressGeoReference() != null) {
				// actualizacion de los puntos de geolocalizacion
				// BusinessAddressGeoRefence
				GeoreferencingRequest georeferencingBusinessAddressRequest = new GeoreferencingRequest();
				georeferencingBusinessAddressRequest.setCustomerId(verificationData.getVerification().getCustomerId());
				georeferencingBusinessAddressRequest.setAddressId(verificationData.getVerification().getBusinessAddressGeoReference().getAddressId());
				georeferencingBusinessAddressRequest.setLatitudeSeg(
						verificationData.getVerification().getBusinessAddressGeoReference().getLatitude());
				georeferencingBusinessAddressRequest.setLongitudSeg(
						verificationData.getVerification().getBusinessAddressGeoReference().getLongitude());
				addressService.createGeoReference(georeferencingBusinessAddressRequest);
			}
			// actualizacion de los puntos de geolocalizacion
			// HomeAddressGeoReference
			if (verificationData.getVerification().getHomeAddressGeoReference() != null) {
				GeoreferencingRequest georeferencingHomeAddressRequest = new GeoreferencingRequest();
				georeferencingHomeAddressRequest.setCustomerId(verificationData.getVerification().getCustomerId());
				georeferencingHomeAddressRequest.setAddressId(verificationData.getVerification().getHomeAddressGeoReference().getAddressId());
			
				georeferencingHomeAddressRequest
						.setLatitudeSeg(verificationData.getVerification().getHomeAddressGeoReference().getLatitude());
				georeferencingHomeAddressRequest
						.setLongitudSeg(verificationData.getVerification().getHomeAddressGeoReference().getLongitude());
				addressService.createGeoReference(georeferencingHomeAddressRequest);
			}
			
			if (verificationData.getVerification().getOfficialGeoReference() != null) {
				GeoreferencingRequest georeferencingOfficialRequest = new GeoreferencingRequest();
				georeferencingOfficialRequest.setCustomerId(verificationData.getVerification().getCustomerId());
				georeferencingOfficialRequest.setAddressId(verificationData.getVerification().getOfficialGeoReference().getAddressId()+100);
				
				georeferencingOfficialRequest
						.setLatitudeSeg(verificationData.getVerification().getOfficialGeoReference().getLatitude());
				georeferencingOfficialRequest
						.setLongitudSeg(verificationData.getVerification().getOfficialGeoReference().getLongitude());
				addressService.createGeoReference(georeferencingOfficialRequest);
			}else{
				logger.logError("/cobis-cloud/mobile/verification/updateDataVerification La petición no incluye Geolocalización ");
				return errorResponse("Debe instalar la versión del APK que incluye Geolocalización");
			}
			return successResponse(verificationResponse, "/cobis-cloud/mobile/verification/updateDataVerification");

		} catch (IntegrationException e) {
			logger.logError(
					"/cobis-cloud/mobile/verification/updateDataVerification Error al actualizar el Cuestionario Grupal",
					e);
			return errorResponse("Error al actualizar el Cuestionario Grupal");
		} catch (Exception e) {
			logger.logError(
					"/cobis-cloud/mobile/verification/updateDataVerification Error al actualizar el Cuestionario Grupal",
					e);
			return errorResponse("Error al actualizar el Cuestionario Grupal");
		}
	}

	@Path("/{processInstance}/complete")
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response completeGroupVerification(@PathParam("processInstance") int processInstance) {
		logger.logInfo("/cobis-cloud/mobile/verification/completeGroupVerification processInstance" + processInstance);
		try {
			ServiceResponse serviceResponse = workflowService.completeWorkflowTask(processInstance);
			if (!serviceResponse.isResult()) {
				return successResponse(serviceResponse, false,
						"/cobis-cloud/mobile/verification/completeGroupVerification");
			}
			return successResponse(serviceResponse, "/cobis-cloud/mobile/verification/completeGroupVerification");

		} catch (IntegrationException e) {
			logger.logError(
					"/cobis-cloud/mobile/verification/completeGroupVerification Error al completar el Cuestionario Grupal",
					e);
			return errorResponse("Error al completar el Cuestionario Grupal");
		} catch (Exception e) {
			logger.logError(
					"/cobis-cloud/mobile/verification/completeGroupVerification Error al completar el Cuestionario Grupal",
					e);
			return errorResponse("Error al completar el Cuestionario Grupal");
		}
	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.integrationService = new VerificationIntegrationService(serviceIntegration);
		this.workflowService = new WorkflowService(serviceIntegration);
		this.addressService = new AddressIntegrationService(serviceIntegration);
	}

	protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.integrationService = new VerificationIntegrationService(serviceIntegration);
		this.workflowService = new WorkflowService(serviceIntegration);
		this.addressService = new AddressIntegrationService(serviceIntegration);
	}

}
