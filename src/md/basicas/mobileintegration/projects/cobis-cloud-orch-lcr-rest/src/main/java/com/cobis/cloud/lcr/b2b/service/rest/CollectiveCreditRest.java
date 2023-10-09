package com.cobis.cloud.lcr.b2b.service.rest;

import static com.cobis.cloud.lcr.b2b.service.utils.ServiceResponseUtil.objectToJson;
import static com.cobis.cloud.lcr.b2b.service.utils.ServiceResponseUtil.successResponse;

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
import cobiscorp.ecobis.customerdatamanagement.dto.AddressResp;
import cobiscorp.ecobis.customerdatamanagement.dto.CollectiveCustomerRequest;
import cobiscorp.ecobis.mobilelcr.dto.DocumentLcrValidateResponse;
import cobiscorp.ecobis.parameter.dto.ParameterSearchResponse;

import com.cobis.cloud.lcr.b2b.service.CollectiveCreditService;
import com.cobis.cloud.lcr.b2b.service.common.IntegrationException;
import com.cobis.cloud.lcr.b2b.service.dto.CollectiveCreditRequest;
import com.cobis.cloud.lcr.b2b.service.dto.RevolvingUpdateDocumentRequest;
import com.cobis.cloud.lcr.b2b.service.integration.CollectiveQuestionIntegration;
import com.cobis.cloud.lcr.b2b.service.integration.RevolvingDocumentIntegration;
import com.cobis.cloud.lcr.b2b.service.integration.RevolvingUpdateDocumentIntegration;
import com.cobis.cloud.lcr.b2b.service.utils.Constants;
import com.cobis.cloud.lcr.b2b.service.utils.Util;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICobisParameter;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.dto.Coordenadas;
import com.cobiscorp.ecobis.cloud.service.dto.client.CollectiveCustomer;
import com.cobiscorp.ecobis.cloud.service.dto.verification.QuestionColective;
import com.cobiscorp.ecobis.cloud.service.integration.ParameterIntegrationService;
import com.cobiscorp.ecobis.cloud.service.integration.WorkflowService;
import com.cobiscorp.ecobis.cloud.service.integration.LocationService;
import com.cobiscorp.ecobis.cloud.service.integration.AddressIntegrationService;

@Path("/collective")
@Component
@Service({ CollectiveCreditService.class })
@Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
public class CollectiveCreditRest implements CollectiveCreditService {

	private final static ILogger LOGGER = LogFactory.getLogger(CollectiveCreditRest.class);

	@Reference(bind = "setParameterService", unbind = "unsetParameterService", target = "(service.impl=default)")
	private ICobisParameter parameterService;

	private WorkflowService workflowService;
	private RevolvingDocumentIntegration revDocumentintegration;
	private RevolvingUpdateDocumentIntegration saveDocumentIntegration;
	private ParameterIntegrationService parameterIntegrationService;
	private CollectiveQuestionIntegration collectiveQuestionIntegration;
	private AddressIntegrationService addressService;

	// private CustomerIntegrationService customerService;

	@Path("/updateDocumentAndQuestionnaireCollective")
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response updateDocumentAndQuestionnaireCollective(CollectiveCreditRequest collectiveCreditRequest) {
		// TODO Auto-generated method stub
		LOGGER.logDebug("INICIA METODO updateDocumentAndQuestionnaireCollective DENTRO DE LA ETAPA DE CAPTURAR FIRMAS Y APLICAR CUESTIOANRIO");
		LOGGER.logDebug("/updateDocumentAndQuestionnaireCollective>> " + objectToJson(collectiveCreditRequest));
		int documentCount = 0;
		int questionCount = 0;
		int cantidadFaltante = 0;
		int collectiveQuestionsCount = 0;
		String civilStatus = "";
		StringBuilder questionMessages = new StringBuilder();
		StringBuilder errorMessages = new StringBuilder();
		ServiceResponse response;
		ServiceResponse validate = new ServiceResponse();

		try {

			if (collectiveCreditRequest.getInstanceProcess() != 0 && collectiveCreditRequest.getInstanceActivity() != 0 && collectiveCreditRequest.getDocuments() != null
					&& collectiveCreditRequest.getCollectiveCustomer() != null) {
				documentCount = collectiveCreditRequest.getDocuments().size();
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("Cantidad de objetos Documentos a guardar: " + documentCount);
				}

				if (Constants.OK.equals(collectiveCreditRequest.getDecision())) {
					LOGGER.logDebug("INICIO BARRIDO DE DOCUMENTOS PARA GUARDAR");

					for (int i = 0; i < documentCount; i++) {

						// Guarda la informacion de los documentos en la base tablas de
						// workflow
						RevolvingUpdateDocumentRequest documentRequest = collectiveCreditRequest.getDocuments().get(i);
						if (documentRequest != null && Constants.OWNER_INBOX.equals(documentRequest.getOwner())) {
							saveDocumentIntegration.updateSaveDocument(collectiveCreditRequest.getInstanceActivity(), Integer.valueOf(documentRequest.getCode()),
									documentRequest.getNameDocument(), documentRequest.getTypeDocument(), documentRequest.getCategory());

							revDocumentintegration.updateRevolvingRequisito(collectiveCreditRequest.getInstanceProcess(), collectiveCreditRequest.getInstanceActivity(),
									Integer.valueOf(documentRequest.getCode()));

							// Consulta la cantidad de documentos faltan por subir
							DocumentLcrValidateResponse[] canDocFal = revDocumentintegration.searchDocuemntUp(collectiveCreditRequest.getInstanceProcess(),
									Constants.COLLECTIVE_TYPE);

							if (canDocFal == null) {
								LOGGER.logDebug("EL valor de DocumentLcrValidateResponse[] es null canDocFal >> " + canDocFal);
								validate.setResult(false);
								validate.setData(null);
								validate.addMessage("300", "Error no existen datos de documentos faltantes");
								return successResponse(validate, false, "/updateDocumentAndQuestionnaireCollective>> Error no existen datos de documentos faltantes");
							} else {
								cantidadFaltante = canDocFal.length;
								LOGGER.logDebug("CANTIDAD DE DECUMENTOS FALTANTES POR SUBIR: " + canDocFal.length);

							}
						}
					}

					LocationService locationService = new LocationService();
					locationService.setParameterService(parameterService);
					AddressResp addressResponse = addressService.findHomeAddress(collectiveCreditRequest.getCustomerId());

					String addresGeo = addressResponse.getPostalCode() + "," + addressResponse.getCountryDescription() + "," + addressResponse.getProvinceDescription() + ","
							+ addressResponse.getCityDescription() + "," + addressResponse.getParishDescription() + "," + addressResponse.getStreet();

					LOGGER.logDebug("Direccion para encontrar la Geolocalizacion >> " + addresGeo);
					LOGGER.logDebug(" Id de la Direccion >> " + addressResponse.getAddress());
					Coordenadas co = new Coordenadas();
					// codigo de la Direccion

					co = locationService.isSearchGeolocalization(addresGeo);
					co.setIdAddress(addressResponse.getAddress());

					boolean completeCollectiveCustomerInfo = collectiveQuestionIntegration.updateCollectiveCustomerInfo(
							Util.setValuesToCollectiveCustomer(collectiveCreditRequest.getCollectiveCustomer(), collectiveCreditRequest.getCustomerId(), co));

					if (completeCollectiveCustomerInfo && cantidadFaltante == 0) {
						response = workflowService.completeWorkflowTask(collectiveCreditRequest.getInstanceProcess(), Constants.OK);
						if (!response.isResult()) {
							validate.setResult(false);
							validate.setData(null);
							validate.addMessage("500", "Error no se puedo continuar con el proceso");
							return successResponse(validate, false, "/updateDocumentAndQuestionnaireCollective>> Error no se puedo continuar con el proceso");

						}
						validate.setResult(true);
						validate.setData(null);
						validate.addMessage(null);

					} else {
						validate.setResult(false);
						validate.setData(null);
						errorMessages.append("ERROR:\n");
						errorMessages.append("No se han completado los documentos.\n");
						errorMessages.append(questionMessages.toString());
						validate.addMessage("300", errorMessages.toString());
						return successResponse(validate, false, "/updateDocumentAndQuestionnaireCollective>> Error no se ha completado los documentos o cuestionario.");

					}

				} else if (Constants.RECHAZAR.equals(collectiveCreditRequest.getDecision())) {
					response = workflowService.completeWorkflowTask(collectiveCreditRequest.getInstanceProcess(), Constants.RECHAZAR);
					if (!response.isResult()) {
						validate.setResult(false);
						validate.setData(null);
						validate.addMessage("500", "Error no se puedo continuar con el proceso");
						return successResponse(validate, false, "/updateDocumentAndQuestionnaireCollective>> Error no se puedo continuar con el proceso");

					}
					validate.setResult(true);
					validate.setData(null);
					validate.addMessage(null);
				}
			} else {
				validate.setResult(false);
				validate.setData(null);
				validate.addMessage("500", "Error falta información");
				return successResponse(validate, false, "/updateDocumentAndQuestionnaireCollective>> Error falta información");
			}

		} catch (IntegrationException e) {
			LOGGER.logError("/updateDocumentAndQuestionnaireCollective", e);
			validate.setResult(false);
			validate.setData(null);
			validate.addMessage("500", "Error al procesar solicitud");
			return successResponse(validate, false, "/updateDocumentAndQuestionnaireCollective>> Error al procesar solicitud");
		} catch (Exception ex) {
			LOGGER.logError("/updateDocumentAndQuestionnaireCollective", ex);
			validate.setResult(false);
			validate.setData(null);
			validate.addMessage("500", "Error al procesar solicitud");
			return successResponse(validate, false, "/updateDocumentAndQuestionnaireCollective>> Error al procesar solicitud");
		}

		return successResponse(validate, true, "/lcrdocument/updateInformationDocumentLcr");
	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.workflowService = new WorkflowService(serviceIntegration);
		this.parameterIntegrationService = new ParameterIntegrationService(serviceIntegration);
		this.revDocumentintegration = new RevolvingDocumentIntegration(serviceIntegration);
		this.saveDocumentIntegration = new RevolvingUpdateDocumentIntegration(serviceIntegration);
		this.collectiveQuestionIntegration = new CollectiveQuestionIntegration(serviceIntegration);
		this.addressService = new AddressIntegrationService(serviceIntegration);
	}

	protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.workflowService = new WorkflowService(serviceIntegration);
		this.parameterIntegrationService = new ParameterIntegrationService(serviceIntegration);
		this.revDocumentintegration = new RevolvingDocumentIntegration(serviceIntegration);
		this.saveDocumentIntegration = new RevolvingUpdateDocumentIntegration(serviceIntegration);
		this.collectiveQuestionIntegration = new CollectiveQuestionIntegration(serviceIntegration);
		this.addressService = new AddressIntegrationService(serviceIntegration);
	}

	public void setParameterService(ICobisParameter parameterService) {
		this.parameterService = parameterService;
	}

	public void unsetParameterService(ICobisParameter parameterService) {
		this.parameterService = null;
	}
}
