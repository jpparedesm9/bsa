package com.cobis.cloud.lcr.b2b.service.rest;

import static com.cobis.cloud.lcr.b2b.service.utils.ServiceResponseUtil.objectToJson;
import static com.cobis.cloud.lcr.b2b.service.utils.ServiceResponseUtil.successResponse;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobis.cloud.lcr.b2b.service.RevolvingDocumentService;
import com.cobis.cloud.lcr.b2b.service.common.IntegrationException;
import com.cobis.cloud.lcr.b2b.service.dto.RevolvingDocumentRequest;
import com.cobis.cloud.lcr.b2b.service.dto.RevolvingDocumentResponse;
import com.cobis.cloud.lcr.b2b.service.dto.RevolvingInfoDocumentResponse;
import com.cobis.cloud.lcr.b2b.service.dto.RevolvingUpdateDocHederRequest;
import com.cobis.cloud.lcr.b2b.service.integration.RevolvingDocumentIntegration;
import com.cobis.cloud.lcr.b2b.service.integration.RevolvingUpdateDocumentIntegration;
import com.cobis.cloud.lcr.b2b.service.utils.Constants;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.integration.WorkflowService;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.htm.api.dto.TaskDTO;
import cobiscorp.ecobis.mobilelcr.dto.DocumentLcrValidateResponse;

@Path("/lcrdocument")
@Component
@Service({ RevolvingDocumentRest.class })
@Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
public class RevolvingDocumentRest implements RevolvingDocumentService {

	private final static ILogger logger = LogFactory.getLogger(RevolvingDocumentRest.class);

	private WorkflowService workflowService;
	private RevolvingDocumentIntegration revDocumentintegration;
	private RevolvingUpdateDocumentIntegration saveDocuementRequest;

	/**
	 * Servicio rest que recibe la informacion desde la movil para guardar en el caso de aceptar o no el credito revolvente, si acepta guarda la
	 * informacion, si no acepta guarda la informacion y rootea la actividad
	 */

	@Path("/acceptedlcr")
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response acceptedCredit(RevolvingDocumentRequest revolvingDocumentRequest) {
		logger.logDebug("INICIA METODO acceptedCredit DENTRO DE LA ETAPA DE DIGITALIZACION DE DOCUMENTOS LCR");
		logger.logDebug("/lcrdocument/acceptedlcr request>> " + objectToJson(revolvingDocumentRequest));
		ServiceResponse validate = new ServiceResponse();
		RevolvingDocumentRequest request = new RevolvingDocumentRequest();
		ServiceResponse response;

		try {

			if (revolvingDocumentRequest.getInstanceProcess() != 0 && revolvingDocumentRequest.getInstanceActivity() != 0 && revolvingDocumentRequest.getLogginAsesor() != ""
					&& revolvingDocumentRequest.getLogginAsesor() != null) {
				if (!revolvingDocumentRequest.getStatusInterested().equals(null) && revolvingDocumentRequest.getStatusInterested() != "") {

					request.setInstanceProcess(revolvingDocumentRequest.getInstanceProcess());
					request.setInstanceActivity(revolvingDocumentRequest.getInstanceActivity());
					request.setLogginAsesor(revolvingDocumentRequest.getLogginAsesor());
					request.setStatusInterested(revolvingDocumentRequest.getStatusInterested().toUpperCase());

					// Se coloca la informacion del catalogo y la observacion en
					// mayusculas en caso
					// de que la respuesta sea SI
					if (revolvingDocumentRequest.getCatalogue() != "" && revolvingDocumentRequest.getCatalogue() != null) {
						request.setCatalogue(revolvingDocumentRequest.getCatalogue().toUpperCase());
					} else {
						request.setCatalogue(revolvingDocumentRequest.getCatalogue());
					}

					if (revolvingDocumentRequest.getDescription() != "" && revolvingDocumentRequest.getDescription() != null) {
						request.setDescription(revolvingDocumentRequest.getDescription().toUpperCase());
					} else {
						request.setDescription(revolvingDocumentRequest.getDescription());
					}

					logger.logDebug("La respuesta de aceptacion es: " + request.getStatusInterested());

					if (request.getStatusInterested().equals("NO")) {
						logger.logDebug("CASO DE RESPUESTA NO");
						revDocumentintegration.updateRevolvingDocument(request);
						response = workflowService.completeWorkflowTask(request.getInstanceProcess());
						if (!response.isResult()) {
							response.setResult(false);
							response.setData(null);
							response.addMessage("5000", "Error al intentar continuar con el proceso");
							return successResponse(response, false, "/lcrdocument/acceptedlcr >> Error al ejecutar acceptedCredit");
						}

						validate.setResult(true);
						validate.setData(null);
						validate.addMessage(null);

					} else {
						revDocumentintegration.updateRevolvingDocument(request);
						validate.setResult(true);
						validate.setData(null);
						validate.addMessage(null);
					}

				} else {
					validate.setResult(false);
					validate.setData(null);
					validate.addMessage("300", "La petición debe traer un valor en el status");
					return successResponse(validate, false, "/lcrdocument/acceptedlcr >> Error al recuperar el status");
				}
			} else {

				validate.setResult(false);
				validate.setData(null);
				validate.addMessage("300", "La petición debe traer un valor en la instancia de proceso, instancia de actividad , asesor");
				return successResponse(validate, false, "/lcrdocument/acceptedlcr >> Error al recuperar la instancia de proceso, instancia de actividad y asesor");

			}

		} catch (IntegrationException ie) {
			logger.logError("/lcrdocument/acceptedlcr -ERROR AL GUARDAR LA RESPUESTA DE LA RENOVACION LCR", ie);
			validate.setResult(false);
			validate.setData(null);
			validate.addMessage("5000", "Error al ejecutar el metodo");
			return successResponse(validate, false, "/lcrdocument/acceptedlcr >> Error al ejecutar el metodo");
		} catch (Exception e) {
			logger.logError("/lcrdocument/acceptedlcr -ERROR AL GUARDAR LA RESPUESTA DE LA RENOVACION LCR", e);
			validate.setResult(false);
			validate.setData(null);
			validate.addMessage("5000", "Error al ejecutar el metodo");
			return successResponse(validate, false, "/lcrdocument/acceptedlcr >> Error al ejecutar el metodo");
		}

		return successResponse(validate, true, "/lcrdocument/acceptedlcr");
	}

	/**
	 * Servcio Rest que actualiza la informacion en caso de haber aceptado en la movil y haber continuado con el proceso de cargar las imagenes por el
	 * servlet. Guarda la informacion en las tablas de workflow para asociar con la web porque son requisitos mandatorios y procede a rootear la
	 * actividad
	 */

	@Path("/updateInformationDocumentLcr")
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response updateInformationDocumentLcr(RevolvingUpdateDocHederRequest revolvingDoc) {
		// TODO Auto-generated method stub

		logger.logDebug("INICIA METODO updateInformationDocumentLcr DENTRO DE LA ETAPA DE DIGITALIZACION DE DOCUMENTOS LCR");
		logger.logDebug("/lcrdocument/updateInformationDocumentLcr>> " + objectToJson(revolvingDoc));
		int cantidad = 0;
		int cantidadFaltante = 0;
		boolean continueActivirty = false;
		ServiceResponse response;
		ServiceResponse validate = new ServiceResponse();

		if (revolvingDoc.getInstanceProcess() != 0 && revolvingDoc.getInstanceActivity() != 0 && revolvingDoc.getDocuments() != null) {
			cantidad = revolvingDoc.getDocuments().size();
			logger.logDebug("Cantidad de objetos Documents a guardar: " + cantidad);
		} else {
			validate.setResult(false);
			validate.setData(null);
			validate.addMessage("5000", "Error falta información");
			return successResponse(validate, false, "/lcrdocument/updateInformationDocumentLcr>> Error falta información");
		}

		try {

			logger.logDebug("INICIO BARRIDO DE DOCUMENTOS PARA GUARDAR");

			for (int i = 0; i < cantidad; i++) {

				// Guarda la informacion de los documentos en la base tablas de
				// workflow
				saveDocuementRequest.updateSaveDocument(revolvingDoc.getInstanceActivity(), Integer.valueOf(revolvingDoc.getDocuments().get(i).getCode()),
						revolvingDoc.getDocuments().get(i).getNameDocument(), revolvingDoc.getDocuments().get(i).getTypeDocument(), revolvingDoc.getDocuments().get(i).getCategory());

				// Actualiza la informacion en la tabla wf_requisito_actividad y
				// wf_requisito_actividad_det
				revDocumentintegration.updateRevolvingRequisito(revolvingDoc.getInstanceProcess(), revolvingDoc.getInstanceActivity(), Integer.valueOf(revolvingDoc.getDocuments().get(i).getCode()));

				// Consulta la cantidad de documentos faltan por subir
				DocumentLcrValidateResponse[] canDocFal = revDocumentintegration.searchDocuemntUp(revolvingDoc.getInstanceProcess(), Constants.REVOLVING_TYPE);

				if (canDocFal == null) {
					logger.logDebug("EL valor de DocumentLcrValidateResponse[] es null canDocFal >> " + canDocFal);
					validate.setResult(false);
					validate.setData(null);
					validate.addMessage("300", "Error no existen datos de documentos faltantes ");
					return successResponse(validate, false, "/lcrdocument/updateInformationDocumentLcr>> Error no existen datos de documentos faltantes");
				} else {
					cantidadFaltante = canDocFal.length;
					logger.logDebug("CANTIDAD DE DECUMENTOS FALTANTES POR SUBIR: " + canDocFal.length);
					if (cantidadFaltante == 0) {
						continueActivirty = true;
					}
				}

			}

			if (cantidadFaltante == 0 && continueActivirty == true) {
				response = workflowService.completeWorkflowTask(revolvingDoc.getInstanceProcess());
				if (!response.isResult()) {
					validate.setResult(false);
					validate.setData(null);
					validate.addMessage("5000", "Error no se puedo continuar con el proceso");
					return successResponse(validate, false, "/lcrdocument/updateInformationDocumentLcr>> Error no se puedo continuar con el proceso");

				} else {
					validate.setResult(true);
					validate.setData(null);
					validate.addMessage(null);
				}

			}

		} catch (IntegrationException e) {
			logger.logError("/lcrdocument/updateInformationDocumentLcr", e);
			validate.setResult(false);
			validate.setData(null);
			validate.addMessage("5000", "Error al procesar solicitud");
			return successResponse(validate, false, "/lcrdocument/updateInformationDocumentLcr>> Error al procesar solicitud");
		}

		return successResponse(validate, true, "/lcrdocument/updateInformationDocumentLcr");

	}

	/**
	 * Servicio Rest para enviar información relacionado con la carga de documentos al momento de sincronizar la tarea , en la tarea automatica la
	 * instancia de actividad se desfazada entre el movil con la web por tal motivo se envia la información adicional información de las imagenes que
	 * fueron cargadas por la web para poder sincronizarlas en el movil
	 */

	@Path("/requestInfoDocumentLcr/{id}")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response requestInfoDocumentLcr(@PathParam("id") int processInstance) {

		logger.logDebug("Inicia método requestInfoDocumentLcr ");
		logger.logDebug("/requestInfoDocumentLcr/{processInstance} >> " + processInstance);
		ServiceResponse serviceResponse = new ServiceResponse();
		RevolvingInfoDocumentResponse revolvingInfoDoc = new RevolvingInfoDocumentResponse();
		int cantidadDocUp = 0;
		TaskDTO taskDTO;
		String validateAct = "";

		try {
			// verificar si viene instancia de proceso 0
			// Obtener la informacion necesaria utilizando la instancia de
			// proceso
			serviceResponse = workflowService.getCurrentTask(processInstance);
			taskDTO = (TaskDTO) serviceResponse.getData();
			RevolvingDocumentResponse upDocment;
			List<RevolvingDocumentResponse> listUpDocument = new ArrayList<RevolvingDocumentResponse>();

			if (taskDTO != null) {
				logger.logDebug("TaskDTO >> " + taskDTO.toString());

				// Seteamos la informacion que se necesita enviar en el servicio
				revolvingInfoDoc.setNameActivity(taskDTO.getTaskSubject());
				revolvingInfoDoc.setInstanceActivity(Integer.parseInt(taskDTO.getTaskInstanceIdentifier()));
				revolvingInfoDoc.setProcessSubject(taskDTO.getProcessSubject());
				revolvingInfoDoc.setProcessInstanceIdentifier(Integer.parseInt(taskDTO.getProcessInstanceIdentifier()));
				revolvingInfoDoc.setRol(taskDTO.getRolName());
				if (logger.isDebugEnabled()) {
					logger.logDebug("Task Subject" + taskDTO.getTaskSubject());
					logger.logDebug("Task Instance Identifier" + taskDTO.getTaskInstanceIdentifier());
					logger.logDebug("Process Subject" + taskDTO.getProcessSubject());
					logger.logDebug("Process Instance Identifier" + taskDTO.getProcessInstanceIdentifier());
					logger.logDebug("Rol Name" + taskDTO.getRolName());
				}

				if ("CAPTURAR FIRMAS Y DOCUMENTOS".equals(taskDTO.getTaskSubject()) || "CAPTURAR FIRMAS Y CUESTIONARIO".equals(taskDTO.getTaskSubject())) {

					revolvingInfoDoc.setContinueActivity("SI");
					DocumentLcrValidateResponse[] upCountDoc = revDocumentintegration.searchInfoDocumentUp(processInstance);
					if (upCountDoc == null) {
						logger.logDebug("No existen documentos para la instancia de proceso " + processInstance);
					} else {
						cantidadDocUp = upCountDoc.length;
						logger.logDebug("La cantidad de documentos cargados es: " + cantidadDocUp);
						for (int i = 0; i < cantidadDocUp; i++) {

							logger.logDebug("Nombre documento " + upCountDoc[i].getRiNombreDoc());
							logger.logDebug("Instacia proceso " + upCountDoc[i].getRiIdInstProc());
							logger.logDebug("Tipo documento " + upCountDoc[i].getRiCodigoTipoDoc());
							
							String actividaNameDoc = upCountDoc[i].getRiNombreDoc();
							String [] parts = actividaNameDoc.split("\\.");
						
							for (int j = 0; j < parts.length; j++) {
								logger.logDebug("SPLIT_" + j +" " +  parts[j]);
							}
						
							Pattern pattern = Pattern.compile("^(\\d+)_[A-Z]_((\\S|\\s)+|(\\((\\S|\\s)+\\)))");
							Matcher matcher = pattern.matcher(parts[0]);

							if (matcher.matches()) {
								validateAct = matcher.group(1);
								logger.logDebug("ACTVD : " + matcher.group(1));

							}
							logger.logDebug("validateAct:" + validateAct);
							if (Integer.parseInt(validateAct) == Integer.parseInt(taskDTO.getTaskInstanceIdentifier())) {
								upDocment = new RevolvingDocumentResponse();
								upDocment.setId_inst_proc(upCountDoc[i].getRiIdInstProc());
								upDocment.setCodigo_tipo_doc(upCountDoc[i].getRiCodigoTipoDoc());
								upDocment.setNombre_doc(actividaNameDoc);
								listUpDocument.add(upDocment);
							}

						}

						revolvingInfoDoc.setDocuments(listUpDocument);
					}

				} else {
					revolvingInfoDoc.setContinueActivity("NO");
				}

			} else {
				serviceResponse.setResult(false);
				serviceResponse.setData(null);
				serviceResponse.addMessage("5000", "No existe información para la instancia de proceso:  " + processInstance);
				return successResponse(serviceResponse, false, "/requestInfoDocumentLcr/{id} >> Error al recuperar la información");
			}

		} catch (IntegrationException e) {
			logger.logError("/requestInfoDocumentLcr/{processInstance} >>", e);
			serviceResponse.setResult(false);
			serviceResponse.setData(null);
			serviceResponse.addMessage("5000", "Error al procesar la solicitud");
			return successResponse(serviceResponse, false, "/requestInfoDocumentLcr/{id} >> Error al procesar la solicitud");
		}

		return successResponse(revolvingInfoDoc, true, "/requestInfoDocumentLcr/{id} >> Response >> " + objectToJson(revolvingInfoDoc));
	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.workflowService = new WorkflowService(serviceIntegration);
		this.revDocumentintegration = new RevolvingDocumentIntegration(serviceIntegration);
		this.saveDocuementRequest = new RevolvingUpdateDocumentIntegration(serviceIntegration);
	}

	protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.workflowService = new WorkflowService(serviceIntegration);
		this.revDocumentintegration = new RevolvingDocumentIntegration(serviceIntegration);
		this.saveDocuementRequest = new RevolvingUpdateDocumentIntegration(serviceIntegration);
	}

}
