/**
 * Archivo: OrchestrationClientValidationService.java
 * Fecha..:
 * Autor..: Team Evac
 * <p>
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.BuroRequest;
import com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.BuroResponse;
import com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.bsl.IBuroCustomerService;
import com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.bsl.IBuroCustomerUtil;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroClientGroupRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroClientRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroExecutionResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.RuleExecution;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationBuroClientGroupServiceRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IWorkflowService;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerCoreInfo;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerData;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.SearchCustomerInfo;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.UpdateCustomerInfoRequest;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.serv.bsl.ICustomerService;
import com.cobiscorp.ecobis.cobiscloudsantander.bsl.dto.SantanderRequest;
import com.cobiscorp.ecobis.cobiscloudsantander.bsl.serv.bsl.ISantanderCoreService;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.htm.api.dto.TaskDTO;

//include imports with key: OrchestrationClientValidationService.imports

public class OrchestrationClientValidationServiceSERVImpl extends ServiceBase implements com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService {
	private static ILogger LOGGER = LogFactory.getLogger(OrchestrationClientValidationServiceSERVImpl.class);

	// include body with key: OrchestrationClientValidationService.body

	private static final String DIAS_ATRASO_GRUPAL_CICLO_ANTERIOR = "Días Atraso Grupal Ciclo Anterior";
	private static final String BURO_DE_CREDITO = "Buró de Crédito";
	private static final String NIVEL_DE_RIESGO = "Nivel de Riesgo";
	private static final String RULE = "RIESGO_GRP";
	private static final String LISTA_NEGRA = "Lista Negra";
	private static final String RIESGO_IND = "RIESGO_IND";
	private static final String RIESGO_INDIVIDUAL = "Riesgo Individual";
	private static final String RIESGO_INDIVIDUAL_EXT = "Riesgo Individual Externo";

	// Regla TIPCALCLI: Tipo de Calificacion
	private static final String TC_ANTERIOR = "EA009";
	private static final String TC_NUEVA = "EN017";
	private static final String TC_009 = "009";
	private static final String TC_017 = "017";

	private IBuroCustomerService buroServices;
	private ISantanderCoreService santanderCoreService;
	private ICustomerService customerService;
	private IWorkflowService workflowService;
	private IBuroCustomerUtil buroUtil;

	private ICTSServiceIntegration serviceIntegration;

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public ICTSServiceIntegration getServiceIntegration() {
		return this.serviceIntegration;
	}

	public void setBuroServices(IBuroCustomerService buroServices) {
		this.buroServices = buroServices;
	}

	public IBuroCustomerService getBuroServices() {
		return this.buroServices;
	}

	public void setSantanderCoreService(ISantanderCoreService santanderCoreService) {
		this.santanderCoreService = santanderCoreService;
	}

	public ISantanderCoreService getSantanderCoreService() {
		return this.santanderCoreService;
	}

	public void setCustomerService(ICustomerService customerService) {
		this.customerService = customerService;
	}

	public ICustomerService getCustomerService() {
		return this.customerService;
	}

	public void setWorkflowService(IWorkflowService workflowService) {
		this.workflowService = workflowService;
	}

	public IWorkflowService getWorkflowService() {
		return this.workflowService;
	}

	public IBuroCustomerUtil getBuroUtil() {
		return buroUtil;
	}

	public void setBuroUtil(IBuroCustomerUtil buroUtil) {
		this.buroUtil = buroUtil;
	}

	public CustomerData replaceDataBuro(CustomerData customerDataBuro) {
		
		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][replaceDataBuro] ";
		if (customerDataBuro.getName().getFirstName() != null) {
			customerDataBuro.getName().setFirstName(customerDataBuro.getName().getFirstName().replace("Ñ", "N").trim());
			customerDataBuro.getName().setFirstName(customerDataBuro.getName().getFirstName().replace("-", " ").trim());
			customerDataBuro.getName().setFirstName(customerDataBuro.getName().getFirstName().replace("_", " ").trim());
			customerDataBuro.getName().setFirstName(customerDataBuro.getName().getFirstName().replace(".", " ").trim());
			customerDataBuro.getName().setFirstName(customerDataBuro.getName().getFirstName().replace("  ", " ").trim());
		}
		
		if (customerDataBuro.getName().getSecondName() != null) {
			customerDataBuro.getName().setSecondName(customerDataBuro.getName().getSecondName().replace("Ñ", "N").trim());
			customerDataBuro.getName().setSecondName(customerDataBuro.getName().getSecondName().replace("-", " ").trim());
			customerDataBuro.getName().setSecondName(customerDataBuro.getName().getSecondName().replace("_", " ").trim());
			customerDataBuro.getName().setSecondName(customerDataBuro.getName().getSecondName().replace(".", " ").trim());
			customerDataBuro.getName().setSecondName(customerDataBuro.getName().getSecondName().replace("  ", " ").trim());
		} else
			customerDataBuro.getName().setSecondName("");

		if (customerDataBuro.getName().getFatherLastName() != null) {
			customerDataBuro.getName().setFatherLastName(customerDataBuro.getName().getFatherLastName().replace("Ñ", "N").trim());
			customerDataBuro.getName().setFatherLastName(customerDataBuro.getName().getFatherLastName().replace("-", " ").trim());
			customerDataBuro.getName().setFatherLastName(customerDataBuro.getName().getFatherLastName().replace("_", " ").trim());
			customerDataBuro.getName().setFatherLastName(customerDataBuro.getName().getFatherLastName().replace(".", " ").trim());
			customerDataBuro.getName().setFatherLastName(customerDataBuro.getName().getFatherLastName().replace("  ", " ").trim());
		}

		if (customerDataBuro.getName().getMotherLastName() != null) {
			customerDataBuro.getName().setMotherLastName(customerDataBuro.getName().getMotherLastName().replace("Ñ", "N").trim());
			customerDataBuro.getName().setMotherLastName(customerDataBuro.getName().getMotherLastName().replace("-", " ").trim());
			customerDataBuro.getName().setMotherLastName(customerDataBuro.getName().getMotherLastName().replace("_", " ").trim());
			customerDataBuro.getName().setMotherLastName(customerDataBuro.getName().getMotherLastName().replace(".", " ").trim());
			customerDataBuro.getName().setMotherLastName(customerDataBuro.getName().getMotherLastName().replace("  ", " ").trim());		
		} else 
			customerDataBuro.getName().setMotherLastName("");

		LOGGER.logDebug(wInfo + "Salida customerDataBuro: --> " + customerDataBuro);
		return customerDataBuro;
		
	}
	
	public CustomerData replaceDataAltair(CustomerData customerDataAltair) {
		
		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][replaceDataAltair] ";
		if (customerDataAltair.getName().getFirstName() != null) {
			customerDataAltair.getName().setFirstName(customerDataAltair.getName().getFirstName().replace("Ñ", "N").trim());
			customerDataAltair.getName().setFirstName(customerDataAltair.getName().getFirstName().replace("-", " ").trim());
			customerDataAltair.getName().setFirstName(customerDataAltair.getName().getFirstName().replace("_", " ").trim());
			customerDataAltair.getName().setFirstName(customerDataAltair.getName().getFirstName().replace(".", " ").trim());
			customerDataAltair.getName().setFirstName(customerDataAltair.getName().getFirstName().replace("  ", " ").trim());
		}
		
		if (customerDataAltair.getName().getSecondName() != null) {
			customerDataAltair.getName().setSecondName(customerDataAltair.getName().getSecondName().replace("Ñ", "N").trim());
			customerDataAltair.getName().setSecondName(customerDataAltair.getName().getSecondName().replace("-", " ").trim());
			customerDataAltair.getName().setSecondName(customerDataAltair.getName().getSecondName().replace("_", " ").trim());
			customerDataAltair.getName().setSecondName(customerDataAltair.getName().getSecondName().replace(".", " ").trim());
			customerDataAltair.getName().setSecondName(customerDataAltair.getName().getSecondName().replace("  ", " ").trim());
		} else
			customerDataAltair.getName().setSecondName("");

		if (customerDataAltair.getName().getFatherLastName() != null) {
			customerDataAltair.getName().setFatherLastName(customerDataAltair.getName().getFatherLastName().replace("Ñ", "N").trim());
			customerDataAltair.getName().setFatherLastName(customerDataAltair.getName().getFatherLastName().replace("-", " ").trim());
			customerDataAltair.getName().setFatherLastName(customerDataAltair.getName().getFatherLastName().replace("_", " ").trim());
			customerDataAltair.getName().setFatherLastName(customerDataAltair.getName().getFatherLastName().replace(".", " ").trim());
			customerDataAltair.getName().setFatherLastName(customerDataAltair.getName().getFatherLastName().replace("  ", " ").trim());
		}

		if (customerDataAltair.getName().getMotherLastName() != null) {
			customerDataAltair.getName().setMotherLastName(customerDataAltair.getName().getMotherLastName().replace("Ñ", "N").trim());
			customerDataAltair.getName().setMotherLastName(customerDataAltair.getName().getMotherLastName().replace("-", " ").trim());
			customerDataAltair.getName().setMotherLastName(customerDataAltair.getName().getMotherLastName().replace("_", " ").trim());
			customerDataAltair.getName().setMotherLastName(customerDataAltair.getName().getMotherLastName().replace(".", " ").trim());
			customerDataAltair.getName().setMotherLastName(customerDataAltair.getName().getMotherLastName().replace("  ", " ").trim());			
		} else
			customerDataAltair.getName().setMotherLastName("");
		
		LOGGER.logDebug(wInfo + "Salida customerDataAltair: --> " + customerDataAltair);
		return customerDataAltair;
		
	}
	
	// Desde la WEB
	public com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse validate(com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest aValidationRequestServiceRequest) {

		// to include in code order use key:
		// cobiscloudorchestration.OrchestrationClientValidationServiceImpl.validate
		com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse response = null;

		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][validate] ";
		if (aValidationRequestServiceRequest != null && aValidationRequestServiceRequest.getInValidationProspectRequest() != null) {
			Integer customerId = aValidationRequestServiceRequest.getInValidationProspectRequest().getCustomerId();

			String validateLetterN = "O"; // O para que retorne lo de la base, funcion sin tildes - ya no se usa, fn_filtra_acentos solo quita tildes 15/05/2023

			CustomerData customerData = getCustomerService().findCustomerById(customerId, validateLetterN);

			LOGGER.logDebug(wInfo + "customerData info real--> " + customerData);

			CustomerData customerDataBuro = customerData.clone();
			CustomerData customerDataAltair = customerData.clone();

			customerDataBuro = replaceDataBuro(customerDataBuro);
			customerDataAltair = replaceDataAltair(customerDataAltair);

			response = new com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse();

			LOGGER.logDebug(wInfo + "validate--validacion para campo null en Buro");
			if (customerDataBuro.getName().getMotherLastName() == null || customerDataBuro.getName().getMotherLastName().trim().equals("")) {
				customerDataBuro.getName().setMotherLastName("NO PROPORCIONADO");
			}

			BuroClientRequest buroClientRequest = new BuroClientRequest();
			buroClientRequest.setClientId(customerId);
			buroClientRequest.setIsProspect(true);
			buroClientRequest.setProcedureNumber(aValidationRequestServiceRequest.getInValidationProspectRequest().getProcedureNumber());
			buroClientRequest.setCustomerData(customerDataBuro);
			buroClientRequest.setInstProc(aValidationRequestServiceRequest.getInValidationProspectRequest().getInstProc());
			buroClientRequest.setChannel(aValidationRequestServiceRequest.getInValidationProspectRequest().getChannel());
			buroClientRequest.setDaysValidityBureau(aValidationRequestServiceRequest.getInValidationProspectRequest().getDaysValidityBureau());
			BuroExecutionResponse buroExecutionResponse = new BuroExecutionResponse();

			LOGGER.logDebug(wInfo + "buroClientRequest.toString: " + buroClientRequest.toString());

			try {
				buroExecutionResponse = validateBuroClientIndividualRule(buroClientRequest);
				response.setBuroResponse(buroExecutionResponse);
				LOGGER.logDebug(wInfo + "buroExecutionResponse.getListBlackCustomer()1 validate--> " + buroExecutionResponse.getListBlackCustomer());
				LOGGER.logDebug(wInfo + "buroExecutionResponse.getRuleExecutionResult() validate--> " + buroExecutionResponse.getRuleExecutionResult());
				LOGGER.logDebug(wInfo + "buroExecutionResponse.getRuleIndividualRiskResult() validate--> " + buroExecutionResponse.getRuleIndividualRiskResult());
				LOGGER.logDebug(wInfo + "buroExecutionResponse.getProblemConsultingBuro() validate--> " + buroExecutionResponse.getProblemConsultingBuro());
				if (buroExecutionResponse.getRuleIndividualRiskResult().equals("F")) {
					LOGGER.logDebug(wInfo + "Ya no se debe consultar a Santander");
					return response;
				}
			} catch (Exception e) {
				buroExecutionResponse.setProblemConsultingBuro(true);
				response.setBuroResponse(buroExecutionResponse);
				return response;
			}

			LOGGER.logDebug(wInfo + "Empieza Informacion para consultar a Santander/Altair");

			if ((customerDataAltair.getName().getFirstName() != null) && (customerDataAltair.getName().getSecondName() != null)) {
				String fullName = customerDataAltair.getName().getFirstName() + " " + customerDataAltair.getName().getSecondName();
				customerDataAltair.getName().setFirstName(fullName);
				customerDataAltair.getName().setSecondName(null);
			}

			LOGGER.logDebug(wInfo + "Para enviar PrimerNombre  --> " + customerDataAltair.getName().getFirstName());
			LOGGER.logDebug(wInfo + "Para enviar SegundoNombre --> " + customerDataAltair.getName().getSecondName());

			SearchCustomerInfo searchCustomerInfo = new SearchCustomerInfo(customerDataAltair.toMap());
			SantanderRequest santanderRequest = new SantanderRequest();
			santanderRequest.setSearchCustomerInfo(searchCustomerInfo);
			santanderRequest.setCustomerId(customerId);
			CustomerCoreInfo customerCoreInfo = getSantanderCoreService().getCustomerInformation(santanderRequest);

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "customerCoreInfo final --> " + customerCoreInfo);
			}
			response.setCustomerCoreInfo(customerCoreInfo);
		}
		return response;

	}

	// caso #203112 OT Modelo Aceptación Grupal, BC
	// Validacion Listas Negras
	public OrchestrationClientValidationResponse blackListValidation(ValidationProspectServiceRequest aValidationRequestServiceRequest) {
		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][blackListValidation]";
		LOGGER.logDebug(wInfo + "Inicia --- >>>> Ingresan aValidationRequestServiceRequest: " + aValidationRequestServiceRequest);

		OrchestrationClientValidationResponse response = new OrchestrationClientValidationResponse();
		BuroExecutionResponse buroExecutionResponse = new BuroExecutionResponse();
		String riskLevel = null;
		String riesgoIndExt = null;
		String blackList = null;

		Integer customerId = aValidationRequestServiceRequest.getInValidationProspectRequest().getCustomerId();

		try {
			if (aValidationRequestServiceRequest != null && aValidationRequestServiceRequest.getInValidationProspectRequest() != null) {

				Integer blackListCustomer = getBuroUtil().getBlackListCustomer(customerId);
				LOGGER.logDebug(wInfo + "blackListCustomer -->" + blackListCustomer);

				if (blackListCustomer == null) {
					throw new BusinessException(0, "Error getting the variables black list Customer needed for the rule");
				}

				if (blackListCustomer.intValue() == 3) {
					LOGGER.logDebug(wInfo + "El cliente " + customerId + " se encuentra en listas Negras o negative File");
					blackList = "SI";
					riesgoIndExt = "F";
					riskLevel = "ROJO";
				}

				buroExecutionResponse.setClientId(customerId);
				buroExecutionResponse.setListBlackCustomer(blackListCustomer);
				buroExecutionResponse.setRuleIndividualRiskResult(riesgoIndExt);
				buroExecutionResponse.setRuleExecutionResult(riskLevel);

				LOGGER.logDebug(wInfo + "customerId345-->" + customerId);
				LOGGER.logDebug(wInfo + "blackListCustomer345-->" + blackListCustomer);
				LOGGER.logDebug(wInfo + "blackList345-->" + blackList);
				LOGGER.logDebug(wInfo + "Letra--riesgoIndExt345-->" + riesgoIndExt);
				LOGGER.logDebug(wInfo + "Color--riskLevel345-->" + riskLevel);

				response.setBuroResponse(buroExecutionResponse);
			}
		} catch (Exception e) {
			LOGGER.logDebug(wInfo + "Ocurrio un error Exception", e);
		} finally {
			LOGGER.logDebug(wInfo + "Finaliza --- >>>> Los datos del cliente: " + customerId + " son: " + response);
		}

		return response;
	}

	// creacion prospecto movil
	@Override
	public OrchestrationClientValidationResponse validateBuro(ValidationProspectServiceRequest aValidationRequestServiceRequest) {
		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][validateBuro]..-- ";
		Integer customerId = aValidationRequestServiceRequest.getInValidationProspectRequest().getCustomerId();
		com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse response = new com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse();

		String validateLetterN = null; // No debe cambiar la definicion inicial, solo aplica para Altair - ya no se usa, fn_filtra_acentos solo quita tildes 15/05/2023

		CustomerData customerData = getCustomerService().findCustomerById(customerId, validateLetterN);

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "customerData: " + customerData);
		}
		
		// Caso #CLOUD_193221_V3
		customerData = replaceDataBuro(customerData);

		Integer instProc = aValidationRequestServiceRequest.getInValidationProspectRequest().getInstProc();
		LOGGER.logDebug(wInfo + "aValidationRequestServiceRequest.getInValidationProspectRequest().getChannel()" + aValidationRequestServiceRequest.getInValidationProspectRequest().getChannel());
		Integer channel = aValidationRequestServiceRequest.getInValidationProspectRequest().getChannel();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "instProc:" + instProc);
		}

		BuroClientRequest buroClientRequest = new BuroClientRequest();
		buroClientRequest.setClientId(customerId);
		buroClientRequest.setInstProc(instProc);
		buroClientRequest.setChannel(channel);
		buroClientRequest.setIsProspect(true);

		// getName
		LOGGER.logDebug(wInfo + "validacion para campo null en Buro");
		if (customerData.getName().getMotherLastName() == null || customerData.getName().getMotherLastName().trim().equals("")) {
			customerData.getName().setMotherLastName("NO PROPORCIONADO");
		}

		buroClientRequest.setCustomerData(customerData);
		LOGGER.logDebug(wInfo + "validacion para campo null en Buro" + buroClientRequest.toString());
		BuroExecutionResponse buroExecutionResponse = new BuroExecutionResponse();
		try {
			buroExecutionResponse = validateBuroClientIndividualRule(buroClientRequest);
			LOGGER.logDebug(wInfo + "buroExecutionResponse: " + buroExecutionResponse.toString());

			response.setBuroResponse(buroExecutionResponse);
			LOGGER.logDebug(wInfo + "validateBuro--buroExecutionResponse.getListBlackCustomer()1 --> " + buroExecutionResponse.getListBlackCustomer());
			LOGGER.logDebug(wInfo + "validateBuro--getRuleExecutionResult() --> " + buroExecutionResponse.getRuleExecutionResult());
			LOGGER.logDebug(wInfo + "validateBuro--getRuleIndividualRiskResult() --> " + buroExecutionResponse.getRuleIndividualRiskResult());
			LOGGER.logDebug(wInfo + "validateBuro--buroExecutionResponse.getProblemConsultingBuro():" + buroExecutionResponse.getProblemConsultingBuro());
			response.setBuroResponse(buroExecutionResponse);
		} catch (Exception e) {
			buroExecutionResponse.setProblemConsultingBuro(true);
			response.setBuroResponse(buroExecutionResponse);
			return response;
		}
		return response;
	}

	@Override
	public OrchestrationClientValidationResponse validateSantander(ValidationProspectServiceRequest aValidationRequestServiceRequest) {

		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][validateSantander]";
		Integer customerId = aValidationRequestServiceRequest.getInValidationProspectRequest().getCustomerId();
		com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse response = new com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse();

		String validateLetterN = "A"; // No debe cambiar la definicion inicial, solo aplica para Altair - ya no se usa, fn_filtra_acentos solo quita tildes 15/05/2023
		CustomerData customerData = getCustomerService().findCustomerById(customerId, validateLetterN);

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "customerData validateSantander--> " + customerData);
		}

		// Caso #CLOUD_193221_V3
		customerData = replaceDataAltair(customerData);

		// MotherLastName Original
		String motherLastNameAux = customerData.getName().getMotherLastName();

		if (motherLastNameAux != null) {
			customerData.getName().setMotherLastName(motherLastNameAux.trim());
		}

		LOGGER.logDebug(wInfo + "Mostrar el PrimerNombre Antes --> " + customerData.getName().getFirstName());
		if ((customerData.getName().getFirstName() != null) && (customerData.getName().getSecondName() != null)) {
			String fullName = customerData.getName().getFirstName() + " " + customerData.getName().getSecondName();
			customerData.getName().setFirstName(fullName);
			customerData.getName().setSecondName(null);
		}
		LOGGER.logDebug(wInfo + "Mostrar el PrimerNombre Despues --> " + customerData.getName().getFirstName());

		SearchCustomerInfo searchCustomerInfo = new SearchCustomerInfo(customerData.toMap());
		SantanderRequest santanderRequest = new SantanderRequest();
		santanderRequest.setSearchCustomerInfo(searchCustomerInfo);
		santanderRequest.setCustomerId(customerId);
		CustomerCoreInfo customerCoreInfo = getSantanderCoreService().getCustomerInformation(santanderRequest);
		LOGGER.logDebug("customerCoreInfo>>" + customerCoreInfo);
		response.setCustomerCoreInfo(customerCoreInfo);
		LOGGER.logDebug("response>>" + response);
		return response;

	}

	@Override
	public OrchestrationClientValidationResponse validateSantanderWithOutUpdate(ValidationProspectServiceRequest aValidationRequestServiceRequest) {

		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][validateSantanderWithOutUpdate]";
		Integer customerId = aValidationRequestServiceRequest.getInValidationProspectRequest().getCustomerId();
		com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse response = new com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse();
		String validateLetterN = "A"; // No debe cambiar la definicion inicial, solo aplica para Altair - ya no se usa, fn_filtra_acentos solo quita tildes 15/05/2023
		CustomerData customerData = getCustomerService().findCustomerById(customerId, validateLetterN);
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "customerData validateSantanderWithOutUpdate --> " + customerData);
		}

		// Caso #CLOUD_193221_V3
		customerData = replaceDataAltair(customerData);
		
		// MotherLastName Original
		String motherLastNameAux = customerData.getName().getMotherLastName();

		if (motherLastNameAux != null) {
			customerData.getName().setMotherLastName(motherLastNameAux.trim());
		}

		LOGGER.logDebug(wInfo + "Mostrar el PrimerNombre Antes validateSantanderWithOutUpdate --> " + customerData.getName().getFirstName());
		if ((customerData.getName().getFirstName() != null) && (customerData.getName().getSecondName() != null)) {
			String fullName = customerData.getName().getFirstName() + " " + customerData.getName().getSecondName();
			customerData.getName().setFirstName(fullName);
			customerData.getName().setSecondName(null);
		}
		LOGGER.logDebug(wInfo + "Mostrar el PrimerNombre Despues validateSantanderWithOutUpdate--> " + customerData.getName().getFirstName());

		SearchCustomerInfo searchCustomerInfo = new SearchCustomerInfo(customerData.toMap());
		SantanderRequest santanderRequest = new SantanderRequest();
		santanderRequest.setSearchCustomerInfo(searchCustomerInfo);
		santanderRequest.setCustomerId(customerId);
		CustomerCoreInfo customerCoreInfo = getSantanderCoreService().getCustomerInformationWithOutUpdate(santanderRequest);
		response.setCustomerCoreInfo(customerCoreInfo);
		return response;

	}

	public OrchestrationClientValidationResponse validateSantanderWithoutValidation(ValidationProspectServiceRequest aValidationRequestServiceRequest) {

		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][validateSantanderWithoutValidation]";
		Integer customerId = aValidationRequestServiceRequest.getInValidationProspectRequest().getCustomerId();
		com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse response = new com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse();
		String validateLetterN = "A"; // No debe cambiar la definicion inicial, solo aplica para Altair - ya no se usa, fn_filtra_acentos solo quita tildes 15/05/2023
		CustomerData customerData = getCustomerService().findCustomerById(customerId, validateLetterN);
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "customerData --> " + customerData);
		}

		// Caso #CLOUD_193221_V3
		customerData = replaceDataAltair(customerData);
		
		// MotherLastName Original
		String motherLastNameAux = customerData.getName().getMotherLastName();

		if (motherLastNameAux != null) {
			customerData.getName().setMotherLastName(motherLastNameAux.trim());
		}

		LOGGER.logDebug(wInfo + "Mostrar el PrimerNombre Antes --> " + customerData.getName().getFirstName());
		if ((customerData.getName().getFirstName() != null) && (customerData.getName().getSecondName() != null)) {
			String fullName = customerData.getName().getFirstName() + " " + customerData.getName().getSecondName();
			customerData.getName().setFirstName(fullName);
			customerData.getName().setSecondName(null);
		}
		LOGGER.logDebug(wInfo + "Mostrar el PrimerNombre Despues --> " + customerData.getName().getFirstName());

		SearchCustomerInfo searchCustomerInfo = new SearchCustomerInfo(customerData.toMap());
		SantanderRequest santanderRequest = new SantanderRequest();
		santanderRequest.setSearchCustomerInfo(searchCustomerInfo);
		santanderRequest.setCustomerId(customerId);
		CustomerCoreInfo customerCoreInfo = getSantanderCoreService().getCustomerInformationWithoutValidation(santanderRequest);
		response.setCustomerCoreInfo(customerCoreInfo);
		return response;

	}

	public java.util.List validateBuroClientGroup(com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationBuroClientGroupServiceRequest aValidationBuroClientGroupServiceRequest) {
		// llamado desde pantalla montos ingreso de datos
		// to include in code order use key:
		// cobiscloudorchestration.OrchestrationClientValidationServiceImpl.validateBuroClientGroup

		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][validateBuroClientGroup]";
		BuroClientGroupRequest aBuroClientGroupRequest = aValidationBuroClientGroupServiceRequest.getInBuroClientGroupRequest();
		LOGGER.logDebug(wInfo + "aBuroClientGroupRequest --> " + aBuroClientGroupRequest.toString());

		// Integer groupId = aBuroClientGroupRequest.getGroupId();
		List<BuroExecutionResponse> results = new ArrayList<BuroExecutionResponse>();
		for (Integer clientId : (List<Integer>) aBuroClientGroupRequest.getClientIds()) {
			ValidationProspectServiceRequest aValidationRequestServiceRequest = new ValidationProspectServiceRequest();
			ValidationProspectRequest aValidationProspectRequest = new ValidationProspectRequest();
			aValidationProspectRequest.setCustomerId(clientId);
			aValidationProspectRequest.setChannel(aBuroClientGroupRequest.getChannel());
			aValidationRequestServiceRequest.setInValidationProspectRequest(aValidationProspectRequest);

			OrchestrationClientValidationResponse orchestrationClientValidationResponse = new OrchestrationClientValidationResponse();
			BuroExecutionResponse buroExecutionResponse;
			try {
				orchestrationClientValidationResponse = validateBuro(aValidationRequestServiceRequest);
				buroExecutionResponse = orchestrationClientValidationResponse.getBuroResponse();
			} catch (BusinessException e) {
				LOGGER.logError(wInfo + " Error when validation buro client", e);
				continue;
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + " buroExecutionResponse --> " + buroExecutionResponse);
			}
			buroExecutionResponse.setClientId(clientId);
			results.add(buroExecutionResponse);
		}

		return results;

	}

	public com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroExecutionResponse validateBuroClientGroupRule(com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroClientRequest aBuroClientRequest) {

		// to include in code order use key:
		// cobiscloudorchestration.OrchestrationClientValidationServiceImpl.validateBuroClientGroupRule

		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][validateBuroClientGroupRule]";
		com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.BuroRequest buroRequest = new com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.BuroRequest();
		CustomerData customerData = aBuroClientRequest.getCustomerData();
		buroRequest.setResidence(customerData.getResidence());
		buroRequest.setName(customerData.getName());
		buroRequest.setIdCobis(aBuroClientRequest.getClientId());
		buroRequest.setChannel(aBuroClientRequest.getChannel());
		// buroRequest.setExpirationDays(null);

		com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.BuroResponse buroResponse = this.getBuroServices().verify(buroRequest);
		com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroExecutionResponse buroExecutionResponse = new com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroExecutionResponse();
		// buroExecutionResponse.setRiskScore(Integer.parseInt(buroResponse.getRiskScore()));
		String buroScore = "MALO";

		/*
		 * if(buroExecutionResponse.getRiskScore()!=null){
		 * if(buroExecutionResponse.getRiskScore()>0){ buroScore="BUENO"; } }
		 */

		LOGGER.logDebug(wInfo + "validateBuroClientGroupRule-aBuroClientRequest.getGroupId:" + aBuroClientRequest.getGroupId() + "--validateBuroClientGroupRule-aBuroClientRequest.getClientId:" + aBuroClientRequest.getClientId());
		buroScore = getCustomerService().getBuroScore(aBuroClientRequest.getGroupId(), aBuroClientRequest.getClientId(), "G");
		LOGGER.logDebug(wInfo + "buroScore valor--> " + buroScore);
		String delayDays;
		if (aBuroClientRequest.getIsProspect()) {
			delayDays = "0";
		} else {
			delayDays = getCustomerService().getDelayGroupDays(aBuroClientRequest.getGroupId()).toString();
		}

		Map<String, String> variablesLoanTypesProcess = new HashMap<String, String>();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "buroScore --> " + buroScore);
			LOGGER.logDebug(wInfo + "delayDays --> " + delayDays);
		}

		variablesLoanTypesProcess.put(BURO_DE_CREDITO, buroScore);
		variablesLoanTypesProcess.put(DIAS_ATRASO_GRUPAL_CICLO_ANTERIOR, delayDays);
		RuleExecution ruleExecution = new RuleExecution();
		ruleExecution.setAcronymRule(RULE);
		ruleExecution.setVariablesProcess(variablesLoanTypesProcess);
		Map<String, String> resultsApplyRule = (Map<String, String>) getWorkflowService().executeRule(ruleExecution);
		String riskLevel = resultsApplyRule.get(NIVEL_DE_RIESGO);

		if ("I".equals(buroResponse.getOperationType()) || "U".equals(buroResponse.getOperationType())) {
			UpdateCustomerInfoRequest updateCustomerInfoRequest = new UpdateCustomerInfoRequest();
			updateCustomerInfoRequest.setCustomerId(aBuroClientRequest.getClientId());
			updateCustomerInfoRequest.setRiskScore(riskLevel);
			this.getCustomerService().updateCustomerInfo(updateCustomerInfoRequest);
		}
		buroExecutionResponse.setRuleExecutionResult(riskLevel);

		return buroExecutionResponse;

	}

	//Usado en las pantallas de: creaciOn - mantenimiento de personas e ingreso de montos en web y movil
	public com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroExecutionResponse validateBuroClientIndividualRule(com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroClientRequest aRequest) {

		// to include in code order use key:
		// cobiscloudorchestration.OrchestrationClientValidationServiceImpl.validateBuroClientIndividualRule

		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][validateBuroClientIndividualRule]-->>";
		com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroExecutionResponse wResponse = new BuroExecutionResponse();
		Integer customerId = aRequest.getClientId();
		if (customerId == null) {
			throw new BusinessException(0, "Client Id cant be null");
		}

		// consulta parametro TIPCAL para definir si se ejecuta lo actual o lo nuevo
		String ratingTypeParam = getCobisParameter().getParameter(null, "CLI", "TIPCAL", String.class);
		String requiredProduct = "";
		String validityDays = "";
		String reqProdNumber = "";
		Integer validDays = null;

		reqProdNumber = TC_009;
		validDays = getCobisParameter().getParameter(null, "CRE", "BCPC", Long.class).intValue();

		LOGGER.logDebug(wInfo + "Cliente: " + customerId + ">> ratingTypeParam>>" + ratingTypeParam);

		if (ratingTypeParam != null && !"".equals(ratingTypeParam.trim()) && "S".equals(ratingTypeParam.trim())) {
			// llamado de la regla Tipo Calificacion Cliente: 009 o 017

			Map<String, Object> parameterMapRuleTIPOCALCLI = new HashMap<String, Object>();
			parameterMapRuleTIPOCALCLI.put("idRule", "TIPCALCLI");
			parameterMapRuleTIPOCALCLI.put("idCobis", customerId);
			parameterMapRuleTIPOCALCLI.put("idChannel", aRequest.getChannel());
			parameterMapRuleTIPOCALCLI.put("result", 0);

			Map<?, ?> ratingCustomerType = this.getBuroUtil().newCustomeRulesEvaluation(parameterMapRuleTIPOCALCLI);

			if (ratingCustomerType != null && ratingCustomerType.size() >= 1) {
				LOGGER.logDebug(wInfo + "------>>>1");
				validityDays = (String) ratingCustomerType.get("@o_vigencia");
				LOGGER.logDebug(wInfo + "------>>>2: " + validityDays);
				requiredProduct = (String) ratingCustomerType.get("@o_tipo_calif");
				LOGGER.logDebug(wInfo + "------>>>3: " + requiredProduct);
				if (requiredProduct != null && !"".equals(requiredProduct.trim())) {
					LOGGER.logDebug(wInfo + "------>>>4");
					reqProdNumber = requiredProduct.substring(requiredProduct.length() - 3);
					LOGGER.logDebug(wInfo + "------>>>5: " + reqProdNumber);
					validDays = Integer.parseInt(validityDays);
					LOGGER.logDebug(wInfo + "------>>>6: " + validDays);
				} else
					LOGGER.logDebug(wInfo + "------>>>7");
			} else
				LOGGER.logDebug(wInfo + "------>>>8");
		} else
			LOGGER.logDebug(wInfo + "------>>>9");

		CustomerData customerData = aRequest.getCustomerData();
		if (customerData == null) {
			String validateLetterN = null; // No debe cambiar la definicion inicial, solo aplica para Altair - ya no se usa, fn_filtra_acentos solo quita tildes 15/05/2023
			customerData = this.getCustomerService().findCustomerById(customerId, validateLetterN);
		}
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "customerData --> " + customerData);
			LOGGER.logDebug(wInfo + "instProc --> " + aRequest.getInstProc());
		}

		LOGGER.logDebug(wInfo + "Inicio cambios por caso CLOUD_203112 para el cliente: " + customerId + ">> ratingTypeParam>>" + ratingTypeParam + ">> tipo de consulta>>" + reqProdNumber + ">> validDays >>" + validDays);

		com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.BuroRequest buroRequest = new com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.BuroRequest();
		buroRequest.setResidence(customerData.getResidence());
		buroRequest.setName(customerData.getName());
		buroRequest.setIdCobis(customerId);
		buroRequest.setProcedureNumber(aRequest.getProcedureNumber());
		buroRequest.setInstProc(aRequest.getInstProc());
		buroRequest.setChannel(aRequest.getChannel());
		buroRequest.setExpirationDays(validDays);
		buroRequest.setProductRequired(reqProdNumber);

		LOGGER.logDebug(wInfo + "buroRequest.toString(): " + buroRequest.toString());

		com.cobiscorp.ecobis.cobiscloudburo.bsl.dto.BuroResponse buroResponse = this.getBuroServices().verify(buroRequest);

		LOGGER.logDebug(wInfo + "buroResponse.toString():" + buroResponse.toString());

		if (buroResponse != null && !buroResponse.getProblemConsultingBuro()) { // Error #174278-si es verdadero (hubo
																				// algun problema) no continue

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(wInfo + "buroResponse sin problema-continua");
			}

			// Integer riskScore = Integer.parseInt(buroResponse.getRiskScore());
			Integer blackListCustomer = this.getBuroUtil().getBlackListCustomer(customerId);
			LOGGER.logDebug(wInfo + "blackListCustomer -->" + blackListCustomer);
			if (blackListCustomer == null) {
				throw new BusinessException(0, "Error getting the variables black list Customer needed for the rule");
			}
			String blackList = null;
			if (blackListCustomer == 1) {
				blackList = "NO";
			} else {
				if (blackListCustomer == 3) {
					blackList = "SI";
				}
			}

			LOGGER.logDebug(wInfo + "blackList1234 -->" + blackList);

			String riesgoIndExt = null;
			String riskLevel = null;

			String evaluateRule = "N";
			if (buroResponse.getSearchBuro()) {
				evaluateRule = "S";
			}

			LOGGER.logDebug(wInfo + "Inicio cambios por caso CLOUD_203112 para el cliente: " + customerId + ">> reqProdNumber >>" + reqProdNumber + ">> validDays >>" + validDays + ">> evaluaRegla? >>" + evaluateRule);

			if (ratingTypeParam != null && !"".equals(ratingTypeParam.trim()) && "S".equals(ratingTypeParam.trim()) && reqProdNumber.equals(TC_017)) {

				LOGGER.logDebug(wInfo + "Ingreso a nueva validacion el cliente: " + customerId + "-->>validDaysBuro: " + validDays);
				Map<String, Object> parameterMapRuleCALFIN = new HashMap<String, Object>();
				parameterMapRuleCALFIN.put("idRule", "CALFIN");
				parameterMapRuleCALFIN.put("idCobis", customerId);
				parameterMapRuleCALFIN.put("result", 0);
				parameterMapRuleCALFIN.put("typeRatingCustomerEvaluation", TC_NUEVA);
				parameterMapRuleCALFIN.put("evaluateRule", evaluateRule);

				Map<?, ?> mapParamsRuleCalifCli = this.getBuroUtil().newCustomeRulesEvaluation(parameterMapRuleCALFIN);

				String color = (String) mapParamsRuleCalifCli.get("@o_color");
				String letra = (String) mapParamsRuleCalifCli.get("@o_letra");

				riskLevel = color;
				riesgoIndExt = letra;

			} else {

				LOGGER.logDebug(wInfo + "Ingreso a validacion antigua el cliente: " + customerId + "-->>validDaysBuro: " + validDays + ">> evaluaRegla? >>" + evaluateRule);
				if ("N".equals(evaluateRule)) {
					// Debe devolver lo que esta en la base sin ejecutar reglas
					Map<String, Object> parameterMap = new HashMap<String, Object>();
					parameterMap.put("clientId", customerId);
					parameterMap.put("validityBureauDays", validDays);
					parameterMap.put("result", 0);
					parameterMap.put("typeRatingCustomerEvaluation", TC_ANTERIOR);
					parameterMap.put("evaluateRule", evaluateRule);

					Map<?, ?> mapParamsRiesgoIndExtMap = this.getBuroUtil().riesgoIndExtMap(parameterMap);

					String color = (String) mapParamsRiesgoIndExtMap.get("@o_semaforo");
					String letra = (String) mapParamsRiesgoIndExtMap.get("@o_nivel");

					riskLevel = color;
					riesgoIndExt = letra;

				} else {
					riesgoIndExt = this.getBuroUtil().riesgoIndExt(customerId, validDays, TC_ANTERIOR, evaluateRule);
					if (blackList == null || riesgoIndExt == null) {
						throw new BusinessException(0, "Error getting the variables needed for the rule");
					}

					Map<String, String> ruleVariables = new HashMap<String, String>();
					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug(wInfo + "LISTA_NEGRA VALOR-->" + blackList);
						LOGGER.logDebug(wInfo + "RIESGO INDIVIDUAL EXTERNO VALOR-->" + riesgoIndExt);
					}

					ruleVariables.put(LISTA_NEGRA, blackList);
					ruleVariables.put(RIESGO_INDIVIDUAL_EXT, riesgoIndExt);

					RuleExecution ruleExecution = new RuleExecution();
					ruleExecution.setAcronymRule(RIESGO_IND);
					ruleExecution.setVariablesProcess(ruleVariables);
					Map<String, String> resultsApplyRule = (Map<String, String>) getWorkflowService().executeRule(ruleExecution);
					riskLevel = resultsApplyRule.get(RIESGO_INDIVIDUAL);
				}
			}

			LOGGER.logDebug(wInfo + "-->>customerId: " + customerId + "-->>color: " + riskLevel + "-->>letra: " + riesgoIndExt);

			UpdateCustomerInfoRequest updateCustomerInfoRequest = new UpdateCustomerInfoRequest();
			updateCustomerInfoRequest.setCustomerId(customerId);
			updateCustomerInfoRequest.setIndRiskScore(riskLevel);
			updateCustomerInfoRequest.setListBlackCustomer(blackListCustomer);
			LOGGER.logDebug(wInfo + "blackListCustomer123-->" + blackListCustomer);
			LOGGER.logDebug(wInfo + "blackList123-->" + blackList);

			this.getCustomerService().updateCustomerInfo(updateCustomerInfoRequest);
			wResponse.setClientId(customerId);
			// wResponse.setRiskScore(riskScore);
			wResponse.setRuleExecutionResult(riskLevel);
			wResponse.setRuleIndividualRiskResult(riesgoIndExt);
			wResponse.setListBlackCustomer(blackListCustomer);
			wResponse.setValidityDaysBureau(validDays);
		}

		if (buroResponse != null) {
			LOGGER.logDebug(wInfo + "buroResponse.getProblemConsultingBuro():" + buroResponse.getProblemConsultingBuro());
			wResponse.setProblemConsultingBuro(buroResponse.getProblemConsultingBuro());
		}

		return wResponse;

	}

	@Override
	public void getMatrixRulesInfoForGroup(ValidationBuroClientGroupServiceRequest aValidationBuroClientGroupServiceRequest) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("[OrchestrationClientValidationServiceSERVImpl][getMatrixRulesInfoForGroup]");
		}

		BuroClientGroupRequest aBuroClientGroupRequest = aValidationBuroClientGroupServiceRequest.getInBuroClientGroupRequest();

		List<Integer> clientsId = (List<Integer>) aBuroClientGroupRequest.getClientIds();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Group: " + aBuroClientGroupRequest.getGroupId());
			LOGGER.logDebug("Clients of Group: " + clientsId);
		}

		// ejecuta Matriz de riesgo
		CustomerRequest customerRequest = new CustomerRequest();
		customerRequest.setGroupCode(aBuroClientGroupRequest.getGroupId());
		customerRequest.setOperation('I');
		String serviceId = "CustomerDataManagementService.CustomerManagement.GenerateMatrix";
		String serviceResponseId = "result";
		Map<String, Object> serviceParameters = new HashMap<String, Object>(1);
		serviceParameters.put("inCustomerRequest", customerRequest);
		getWorkflowService().executeCTSService(serviceId, serviceParameters, serviceResponseId);

	}

	@Override
	public void getSantanderInfoForGroup(ValidationBuroClientGroupServiceRequest aValidationBuroClientGroupServiceRequest) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("[OrchestrationClientValidationServiceSERVImpl][getSantanderInfoForGroup]");
		}

		BuroClientGroupRequest aBuroClientGroupRequest = aValidationBuroClientGroupServiceRequest.getInBuroClientGroupRequest();

		List<Integer> clientsId = (List<Integer>) aBuroClientGroupRequest.getClientIds();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Group: " + aBuroClientGroupRequest.getGroupId());
			LOGGER.logDebug("Clients of Group: " + clientsId);
		}

		for (Integer clientId : clientsId) {
			ValidationProspectServiceRequest aValidationRequestServiceRequest = new ValidationProspectServiceRequest();
			aValidationRequestServiceRequest.getInValidationProspectRequest().setCustomerId(clientId);
			validateSantander(aValidationRequestServiceRequest);
		}
	}

	@Override
	public ServiceResponseTO getMatrixRulesInfoForClient(ValidationProspectServiceRequest aValidationRequestServiceRequest) throws Exception {
		try {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("[OrchestrationClientValidationServiceSERVImpl][getMatrixRulesInfoForClient]");
			}
			Integer customerId = aValidationRequestServiceRequest.getInValidationProspectRequest().getCustomerId();

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Clients for MatrixRules: " + customerId);
			}

			// ejecuta Matriz de riesgo
			CustomerRequest customerRequest = new CustomerRequest();
			customerRequest.setCustomerId(customerId);
			customerRequest.setOperation('I');
			String serviceId = "CustomerDataManagementService.CustomerManagement.GenerateMatrix";
			String serviceResponseId = "result";
			Map<String, Object> serviceParameters = new HashMap<String, Object>(1);
			serviceParameters.put("inCustomerRequest", customerRequest);
			ServiceResponseTO servicesResponse = (ServiceResponseTO) getWorkflowService().executeCTSService(serviceId, serviceParameters, serviceResponseId);
			LOGGER.logDebug("Impromo servicesResponseTO: " + servicesResponse);
			return servicesResponse;
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public ServiceResponseTO validateAccountAndBucFromSantander(ServiceRequestTO serviceRequesTO) throws Exception {
		LOGGER.logDebug("Inicia validateAccountAndBucFromSantander en bsl impl: ");
		ServiceResponseTO serviceResponseTO = new ServiceResponseTO();
		try {
			ValidationProspectServiceRequest validationProspectServiceRequest = (ValidationProspectServiceRequest) serviceRequesTO.getValue("inValidationProspectServiceRequest");
			com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse orchestrationClientValidationResponse = validateSantander(validationProspectServiceRequest);
			LOGGER.logDebug("orchestrationClientValidationResponse>>" + orchestrationClientValidationResponse);
			serviceResponseTO.addValue("outOrchestrationClientValidationResponse", orchestrationClientValidationResponse);
			serviceResponseTO.setSuccess(true);

		} catch (Exception e) {
			throw e;
		}
		return serviceResponseTO;
	}

	@Override
	public ServiceResponseTO validateBuroFromSantander(String processInstanceId) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start validateBuroFromSantander");
		}
		ServiceResponseTO serviceResponseTO = new ServiceResponseTO();
		try {

			TaskDTO taskDTO = workflowService.getCurrentTask(processInstanceId);
			ValidationProspectServiceRequest validationProspectServiceRequest = new ValidationProspectServiceRequest();
			ValidationProspectRequest validationProspectRequest = new ValidationProspectRequest();
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("taskDTO:" + taskDTO.toString());
				LOGGER.logDebug("ClientID:" + taskDTO.getClientId());
				LOGGER.logDebug("ClientName:" + taskDTO.getClientName());
			}

			validationProspectRequest.setCustomerId(taskDTO.getClientId() == null ? 0 : Integer.valueOf(taskDTO.getClientId()));

			validationProspectServiceRequest.setInValidationProspectRequest(validationProspectRequest);
			com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse orchestrationClientValidationResponse = validateBuro(validationProspectServiceRequest);

			serviceResponseTO.addValue("outOrchestrationClientValidationResponse", orchestrationClientValidationResponse);
			serviceResponseTO.setSuccess(true);

		} catch (Exception e) {
			LOGGER.logDebug("validateBuroFromSantander Exception", e);
			serviceResponseTO.setSuccess(false);
			serviceResponseTO.getMessages().add(e.getMessage());
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finish validateBuroFromSantander");
			}
		}
		return serviceResponseTO;
	}

	// caso #168293 Flujo de originación Auto onboarding
	public OrchestrationClientValidationResponse customerEvaluation(ValidationProspectServiceRequest aValidationRequestServiceRequest) {
		OrchestrationClientValidationResponse response = new OrchestrationClientValidationResponse();
		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][customerEvaluation] ";
		boolean validate = true;
		boolean next = true;
		LOGGER.logDebug(wInfo + "Inicia --- >>>> Ingresan aValidationRequestServiceRequest: " + aValidationRequestServiceRequest);

		Integer customerId = aValidationRequestServiceRequest.getInValidationProspectRequest().getCustomerId();
		if (customerId == null) {
			throw new BusinessException(0, "Error valor customerId: " + customerId);
		}

		// Consulta a Buro
		BuroResponse buroResponse = new BuroResponse();
		buroResponse = queryBureau(aValidationRequestServiceRequest);

		// Regla Monto de Credito
		BuroClientRequest aRequest = new BuroClientRequest();
		aRequest.setClientId(customerId);

		LOGGER.logDebug(wInfo + "customerId: " + customerId);

		try {
			if (buroResponse.getProblemConsultingBuro().booleanValue()) {
				next = false;
				LOGGER.logDebug(wInfo + "El cliente " + customerId + " tiene problemas con la consulta a Buro");
			}

			// Obtiene la calificacion de riesgo(A,B,C,D)--Regla Buró.Calif
			if (next) {
				String result = executionBUROCALDIG(aRequest);
				if (result != null) {
					String[] parts = result.split(";");
					String qualification = parts[0];
					String flagContinueCR = parts[1];

					response.setQualification(qualification);

					if (!flagContinueCR.equals("S")) {
						next = false;
						LOGGER.logDebug(wInfo + "El cliente " + customerId + " tiene una calificacion baja");
					}
				}
			}

			// Listas negras y negative file
			if (next) {
				String blackList = validateBlackListCustomer(customerId);
				if (blackList.equals("SI")) {
					next = false;
					LOGGER.logDebug(wInfo + "El cliente " + customerId + " se encuentra en listas Negras o negative File, no continua");
				}
			}

			// Obtiene el color, se añade para ejecutar lo mismo de los clientes normales
			if (next) {
				String flagContinueRI = executionRIESGO_IND(aRequest);

				if (!flagContinueRI.equals("S")) {
					next = false;
					LOGGER.logDebug(wInfo + "El cliente " + customerId + "  tiene un riesgo alto");
				}
			}

			// Matriz de riesgo
			if (next) {
				String flagContinueMR = executionGenerateMatrix(aRequest);

				if (!flagContinueMR.equals("S")) {
					next = false;
					LOGGER.logDebug(wInfo + "El cliente " + customerId + " tiene una una matriz de riesgo bloquente");
				}
			}

			// Regla Monto
			if (next) {
				Double amountApproved = executionMONINDCLID(aRequest);
				if (amountApproved < 0) {
					next = false;
					LOGGER.logDebug(wInfo + "El cliente " + customerId + " tiene un monto menor a 0");
				}
				response.setAmountApproved(amountApproved);
			}

			// Salida
			if (next)
				response.setEvaluation("SI");
			else
				response.setEvaluation("NO");

		} catch (Exception e) {
			LOGGER.logDebug(wInfo + "Ocurrio un error Exception", e);
			response.setEvaluation(null);

		} finally {
			LOGGER.logDebug(wInfo + "Los datos del cliente: " + customerId + " son: " + response);

		}
		return response;
	}

	// caso #193221 B2B Grupal Digital
	public OrchestrationClientValidationResponse clientEvaluation(ValidationProspectServiceRequest aValidationRequestServiceRequest) {
		OrchestrationClientValidationResponse response = new OrchestrationClientValidationResponse();
		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][clientEvaluation] ";

		LOGGER.logDebug(wInfo + "Inicia --- >>>> Ingresan aValidationRequestServiceRequest: " + aValidationRequestServiceRequest);

		boolean next = true;
		String riesgoIndExt = null;
		String riskLevel = null;
		String reqProdNumber = null;
		Integer validDays = null;
		String ratingTypeParam = null;
		String evaluateRule = "N";

		Integer customerId = aValidationRequestServiceRequest.getInValidationProspectRequest().getCustomerId();
		if (customerId == null) {
			throw new BusinessException(0, "Error valor customerId: " + customerId);
		}
		LOGGER.logDebug(wInfo + "customerId: " + customerId);

		try {
			// Listas negras y negative file (SI,NO)
			if (next) {
				String blackList = validateBlackListCustomer(customerId);
				if (blackList.equals("SI")) {
					next = false;
					LOGGER.logDebug(wInfo + "El cliente " + customerId + " se encuentra en listas Negras o negative File, no continua");
				}
				response.setBlackList(blackList);
			}

			if (next) {
				// Tipo Calificacion Cliente
				Map<String, Object> results = executionCustomerRatingType(aValidationRequestServiceRequest);
				reqProdNumber = (String) results.get("reqProdNumber");
				validDays = (Integer) results.get("validDays");
				ratingTypeParam = (String) results.get("ratingTypeParam");
				response.setValidDays(validDays);

				LOGGER.logDebug(wInfo + "Inicio cambios por caso CLOUD_203112 para el cliente: " + customerId + ">> ratingTypeParam>>" + ratingTypeParam + ">> tipo de consulta>>"
						+ reqProdNumber + ">> validDays >>" + validDays);

				// Consulta a Buro
				aValidationRequestServiceRequest.getInValidationProspectRequest().setReqProdNumber(reqProdNumber);
				aValidationRequestServiceRequest.getInValidationProspectRequest().setValidDays(validDays);
				BuroResponse buroResponse = new BuroResponse();
				buroResponse = queryBureau(aValidationRequestServiceRequest);

				// Buro
				if (buroResponse.getProblemConsultingBuro().booleanValue()) {
					next = false;
					LOGGER.logDebug(wInfo + "El cliente " + customerId + " tiene problemas con la consulta a Buro");
				}
				response.setProblemBuro(buroResponse.getProblemConsultingBuro().booleanValue());

				if (buroResponse.getSearchBuro()) {
					evaluateRule = "S";
				}
			}

			// Calificacion Cliente
			if (next) {
				LOGGER.logDebug(wInfo + "Inicio cambios por caso CLOUD_203112 para el cliente: " + customerId + ">> reqProdNumber >>" + reqProdNumber + ">> validDays >>"
						+ validDays + ">> evaluaRegla? >>" + evaluateRule);

				if (ratingTypeParam != null && !"".equals(ratingTypeParam.trim()) && "S".equals(ratingTypeParam.trim()) && reqProdNumber.equals(TC_017)) {
					LOGGER.logDebug(wInfo + "Ingreso a nueva validacion el cliente: " + customerId + "-->>validDaysBuro: " + validDays);
					Map<String, Object> resultsQ = executionFinalScore(customerId, TC_NUEVA, evaluateRule);
					riskLevel = (String) resultsQ.get("color");
					riesgoIndExt = (String) resultsQ.get("letra");
				} else {
					LOGGER.logDebug(wInfo + "Ingreso a validacion antigua el cliente: " + customerId + "-->>validDaysBuro: " + validDays + ">> evaluaRegla? >>" + evaluateRule);
					if ("N".equals(evaluateRule)) {
						// Debe devolver lo que esta en la base sin ejecutar reglas
						Map<String, Object> resultsM = executionExternalIndividualRiskMap(customerId, validDays, TC_ANTERIOR, evaluateRule);
						riskLevel = (String) resultsM.get("color");
						riesgoIndExt = (String) resultsM.get("letra");
					} else {
						// Riesgo Individual Externo(A,B,C,D,..)
						riesgoIndExt = executionExternalIndividualRisk(customerId, validDays, TC_ANTERIOR, evaluateRule);											

						// Regla Riesgo Individual (VERDE,ROJO,..)
						riskLevel = executionIndividualRisk(riesgoIndExt, response.getBlackList());						
					}
				}
				if ("F".equals(riesgoIndExt)) {
					next = false;
					LOGGER.logDebug(wInfo + "El cliente " + customerId + " tiene una calificacion baja");
				}	
				if ("ROJO".equals(riskLevel)) {
					next = false;
					LOGGER.logDebug(wInfo + "El cliente " + customerId + "  tiene un riesgo alto");
				}
				
				response.setQualification(riesgoIndExt);
				response.setRiskLevel(riskLevel);
				
				// Actualizacion Color del Cliente
				updateCustomer(riskLevel, customerId);
			}

			// Monto de Credito
			BuroClientRequest aRequest = new BuroClientRequest();
			aRequest.setClientId(customerId);

			// Monto Aprobado
			if (next) {
				Double amountApproved = executionAmountApproved(aRequest);
				if (amountApproved < 0) {
					next = false;
					LOGGER.logDebug(wInfo + "El cliente " + customerId + " tiene un monto menor a 0");
				}
				response.setAmountApproved(amountApproved);
			}

			// Salida
			if (next)
				response.setEvaluation("SI");
			else
				response.setEvaluation("NO");

		} catch (Exception e) {
			LOGGER.logDebug(wInfo + "Ocurrio un error Exception en clientEvaluation", e);
			response.setEvaluation(null);

		} finally {
			LOGGER.logDebug(wInfo + "Los datos del cliente: " + customerId + " son: " + response);

		}
		return response;
	}

	public BuroResponse queryBureau(ValidationProspectServiceRequest aValidationRequestServiceRequest) {
		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][queryBureau] ";

		LOGGER.logDebug(wInfo + "aValidationRequestServiceRequest: " + aValidationRequestServiceRequest);
		BuroResponse buroResponse = new BuroResponse();

		if ((aValidationRequestServiceRequest != null) && (aValidationRequestServiceRequest.getInValidationProspectRequest() != null)) {
			Integer customerId = aValidationRequestServiceRequest.getInValidationProspectRequest().getCustomerId();
			String validateLetterN = null;
			if (customerId == null) {
				throw new BusinessException(0, "Client Id cant be null");
			}
			LOGGER.logDebug(wInfo + "---->>>>customerId: " + customerId + "---->>>>validateLetterN: " + validateLetterN);
			try {
				CustomerData customerDataBuro = getCustomerService().findCustomerById(customerId, validateLetterN);

				LOGGER.logDebug(wInfo + "findCustomerById: " + customerDataBuro);
				
				// Caso #CLOUD_193221_V3
				customerDataBuro = replaceDataBuro(customerDataBuro);				
				
				if ((customerDataBuro.getName().getMotherLastName() == null) || (customerDataBuro.getName().getMotherLastName().trim().equals(""))) {
					customerDataBuro.getName().setMotherLastName("NO PROPORCIONADO");
				}
				LOGGER.logDebug(wInfo + "Datos que van customerDataBuro --> " + customerDataBuro);

				BuroRequest buroRequest = new BuroRequest();
				buroRequest.setResidence(customerDataBuro.getResidence());
				buroRequest.setName(customerDataBuro.getName());
				buroRequest.setIdCobis(customerId);
				buroRequest.setChannel(aValidationRequestServiceRequest.getInValidationProspectRequest().getChannel());
				buroRequest.setProcedureNumber(aValidationRequestServiceRequest.getInValidationProspectRequest().getProcedureNumber());
				buroRequest.setExpirationDays(aValidationRequestServiceRequest.getInValidationProspectRequest().getValidDays());
				buroRequest.setProductRequired(aValidationRequestServiceRequest.getInValidationProspectRequest().getReqProdNumber());

				LOGGER.logDebug(wInfo + "buroRequest.toString(): " + buroRequest.toString());
				buroResponse = getBuroServices().verify(buroRequest);
				LOGGER.logDebug(wInfo + "buroResponse.toString():" + buroResponse.toString());

				LOGGER.logDebug(wInfo + "Exito consulta a buro:" + buroResponse);
			} catch (Exception e) {
				LOGGER.logError(wInfo + "Ocurrio un problema al consultar Buro", e);
			}
		}
		return buroResponse;
	}

	public String validateBlackListCustomer(Integer customerId) {
		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][validateBlackListCustomer]";
		String blackList = null;
		Integer blackListCustomer = getBuroUtil().getBlackListCustomer(customerId);

		LOGGER.logDebug(wInfo + "blackListCustomer -->" + blackListCustomer);
		if (blackListCustomer == null) {
			throw new BusinessException(0, "Error getting the variables black list Customer needed for the rule");
		}
		if (blackListCustomer.intValue() == 1) {
			blackList = "NO";
		} else if (blackListCustomer.intValue() == 3) {
			blackList = "SI";
		}
		LOGGER.logDebug(wInfo + "--->>>Salida -->> validateBlackListCustomer -->" + blackList);

		return blackList;
	}

	// Calificacion Cliente Digitalizado, continua
	public String executionBUROCALDIG(BuroClientRequest aRequest) {
		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][executionBUROCALDIG]";
		String qualification = this.getBuroUtil().digCustomerQualification(aRequest.getClientId());

		LOGGER.logDebug(wInfo + "--->>>Salida -->> digCustomerQualification:" + qualification);
		return qualification;
	}

	// Riesgo Individual
	public String executionRIESGO_IND(BuroClientRequest aRequest) {
		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][executionMONINDCLID]";
		String following = this.getBuroUtil().riesgoIndividual(aRequest.getClientId());

		LOGGER.logDebug(wInfo + "--->>>Salida -->> executionRIESGO_IND:" + following);
		return following;
	}

	// Matriz de Riesgo
	public String executionGenerateMatrix(BuroClientRequest aRequest) {
		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][executionGenerateMatrix]";
		String following = this.getBuroUtil().generateMatrix(aRequest.getClientId());

		LOGGER.logDebug(wInfo + "--->>>Salida -->> executionGenerateMatrix:" + following);
		return following;
	}

	// Monto Cliente Digitalizado
	public Double executionMONINDCLID(BuroClientRequest aRequest) {
		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][executionMONINDCLID]";
		Double digCustomerCreditAmount = this.getBuroUtil().digCustomerCreditAmount(aRequest.getClientId());

		LOGGER.logDebug(wInfo + "--->>>Salida -->> digCustomerCreditAmount:" + digCustomerCreditAmount);
		return digCustomerCreditAmount;
	}

	// Riesgo Individual Externo - caso #193221 B2B Grupal Digital
	public String executionExternalIndividualRisk(Integer customerId, Integer validDays, String typeRatingCustomerEvaluation, String evaluateRule) {
		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][executionExternalIndividualRisk]";
		String riesgoIndExt = this.getBuroUtil().riesgoIndExt(customerId, validDays, typeRatingCustomerEvaluation, evaluateRule);

		if (riesgoIndExt == null) {
			throw new BusinessException(0, "Error getting the variables external individual risk Customer needed for the rule");
		}

		LOGGER.logDebug(wInfo + "--->>>Salida -->> riesgoIndExt:" + riesgoIndExt);
		return riesgoIndExt;
	}

	// Riesgo Individual Externo (Map)- caso #193221 B2B Grupal Digital
	public Map<String, Object> executionExternalIndividualRiskMap(Integer customerId, Integer validDays, String typeRatingCustomerEvaluation, String evaluateRule) {
		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][executionExternalIndividualRiskMap]";

		LOGGER.logDebug("Inicia" + wInfo);
		
		Map<String, Object> resultsM = new HashMap<String, Object>();
		
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		String riesgoIndExt = null;
		String riskLevel = null;		

		parameterMap.put("clientId", customerId);
		parameterMap.put("validityBureauDays", validDays);
		parameterMap.put("result", 0);
		parameterMap.put("typeRatingCustomerEvaluation", typeRatingCustomerEvaluation);
		parameterMap.put("evaluateRule", evaluateRule);

		Map<?, ?> mapParamsRiesgoIndExtMap = this.getBuroUtil().riesgoIndExtMap(parameterMap);

		String color = (String) mapParamsRiesgoIndExtMap.get("@o_semaforo");
		String letra = (String) mapParamsRiesgoIndExtMap.get("@o_nivel");

		riskLevel = color;
		riesgoIndExt = letra;

		resultsM.put("color", color);
		resultsM.put("letra", letra);

		LOGGER.logDebug(wInfo + "--->>>Salida -->> color:" + riskLevel);
		LOGGER.logDebug(wInfo + "--->>>Salida -->> letra:" + riesgoIndExt);

		return resultsM;
	}

	// Regla Riesgo Individual - caso #193221 B2B Grupal Digital
	public String executionIndividualRisk(String riesgoIndExt, String blackList) {
		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][executionIndividualRisk]";

		LOGGER.logDebug(wInfo + "--->>>Ingreso -->> riesgoIndExt:" + riesgoIndExt + " -->> blackList:" + blackList);
		if (blackList == null || riesgoIndExt == null) {
			throw new BusinessException(0, "Error getting the variables needed for the rule");
		}
		
		Map<String, String> ruleVariables = new HashMap<String, String>();
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug(wInfo + "LISTA_NEGRA VALOR-->" + blackList);
			LOGGER.logDebug(wInfo + "RIESGO INDIVIDUAL EXTERNO VALOR-->" + riesgoIndExt);
		}

		ruleVariables.put(LISTA_NEGRA, blackList);
		ruleVariables.put(RIESGO_INDIVIDUAL_EXT, riesgoIndExt);

		RuleExecution ruleExecution = new RuleExecution();
		ruleExecution.setAcronymRule(RIESGO_IND);
		ruleExecution.setVariablesProcess(ruleVariables);
		Map<String, String> resultsApplyRule = (Map<String, String>) getWorkflowService().executeRule(ruleExecution);
		String riskLevel = resultsApplyRule.get(RIESGO_INDIVIDUAL);

		LOGGER.logDebug(wInfo + "--->>>Salida -->> riskLevel:" + riskLevel);
		return riskLevel;
	}

	// Monto Aprobado - caso #193221 B2B Grupal Digital
	public Double executionAmountApproved(BuroClientRequest aRequest) {
		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][executionAmountApproved]";
		Double customerAmountApproved = this.getBuroUtil().customerAmountApproved(aRequest.getClientId());

		LOGGER.logDebug(wInfo + "--->>>Salida -->> customerAmountApproved:" + customerAmountApproved);
		return customerAmountApproved;
	}

	// Actualizacion Cliente - caso #203621 Mejoras adicionales B2B grupal
	public void updateCustomer(String riskLevel, Integer customerId) {
		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][updateCustomer]";

		UpdateCustomerInfoRequest updateCustomerInfoRequest = new UpdateCustomerInfoRequest();
		updateCustomerInfoRequest.setCustomerId(customerId);
		updateCustomerInfoRequest.setIndRiskScore(riskLevel);
		LOGGER.logDebug(wInfo + "customerId123-->" + customerId);
		LOGGER.logDebug(wInfo + "riskLevel123-->" + riskLevel);

		this.getCustomerService().updateCustomerInfo(updateCustomerInfoRequest);

		LOGGER.logDebug(wInfo + "--->>>Salida -->> updateCustomer");
	}

	// Tipo Calificacion Cliente - caso #193221 B2B Grupal Digital
	public Map<String, Object> executionCustomerRatingType(ValidationProspectServiceRequest aValidationRequestServiceRequest) {
		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][executionCustomerRatingType]";
		LOGGER.logDebug("Inicia" + wInfo + "aValidationRequestServiceRequest --> " + aValidationRequestServiceRequest.toString());

		Integer customerId = aValidationRequestServiceRequest.getInValidationProspectRequest().getCustomerId();
		Integer channel = aValidationRequestServiceRequest.getInValidationProspectRequest().getChannel();

		Map<String, Object> results = new HashMap<String, Object>();

		try {
			// consulta parametro TIPCAL para definir si se ejecuta lo actual o lo nuevo
			String ratingTypeParam = getCobisParameter().getParameter(null, "CLI", "TIPCAL", String.class);
			String requiredProduct = "";
			String validityDays = "";
			String reqProdNumber = "";
			Integer validDays = null;

			reqProdNumber = TC_009;
			validDays = getCobisParameter().getParameter(null, "CRE", "BCPC", Long.class).intValue();

			LOGGER.logDebug(wInfo + "Cliente: " + customerId + ">> ratingTypeParam>>" + ratingTypeParam);

			if (ratingTypeParam != null && !"".equals(ratingTypeParam.trim()) && "S".equals(ratingTypeParam.trim())) {
				// llamado de la regla Tipo Calificacion Cliente: 009 o 017

				Map<String, Object> parameterMapRuleTIPOCALCLI = new HashMap<String, Object>();
				parameterMapRuleTIPOCALCLI.put("idRule", "TIPCALCLI");
				parameterMapRuleTIPOCALCLI.put("idCobis", customerId);
				parameterMapRuleTIPOCALCLI.put("idChannel", channel);
				parameterMapRuleTIPOCALCLI.put("result", 0);

				Map<?, ?> ratingCustomerType = this.getBuroUtil().newCustomeRulesEvaluation(parameterMapRuleTIPOCALCLI);

				if (ratingCustomerType != null && ratingCustomerType.size() >= 1) {
					LOGGER.logDebug(wInfo + "------>>>1");
					validityDays = (String) ratingCustomerType.get("@o_vigencia");
					LOGGER.logDebug(wInfo + "------>>>2: " + validityDays);
					requiredProduct = (String) ratingCustomerType.get("@o_tipo_calif");
					LOGGER.logDebug(wInfo + "------>>>3: " + requiredProduct);
					if (requiredProduct != null && !"".equals(requiredProduct.trim())) {
						LOGGER.logDebug(wInfo + "------>>>4");
						reqProdNumber = requiredProduct.substring(requiredProduct.length() - 3);
						LOGGER.logDebug(wInfo + "------>>>5: " + reqProdNumber);
						validDays = Integer.parseInt(validityDays);
						LOGGER.logDebug(wInfo + "------>>>6: " + validDays);
					} else
						LOGGER.logDebug(wInfo + "------>>>7");
				} else
					LOGGER.logDebug(wInfo + "------>>>8");
			} else
				LOGGER.logDebug(wInfo + "------>>>9");

			results.put("reqProdNumber", reqProdNumber);
			results.put("validDays", validDays);
			results.put("ratingTypeParam", ratingTypeParam);
			LOGGER.logDebug(wInfo + "--->>>Salida -->> reqProdNumber:" + reqProdNumber);
			LOGGER.logDebug(wInfo + "--->>>Salida -->> validDays:" + validDays);
			LOGGER.logDebug(wInfo + "--->>>Salida -->> ratingTypeParam:" + ratingTypeParam);
		} catch (BusinessException e) {
			LOGGER.logError(wInfo + " Error en tipo de evaluacion cliente", e);
		}
		LOGGER.logDebug("Finaliza" + wInfo);

		return results;
	}

	// Regla Calificacion Final - caso #193221 B2B Grupal Digital
	public Map<String, Object> executionFinalScore(Integer customerId, String typeRatingCustomerEvaluation, String evaluateRule) {
		String wInfo = "[OrchestrationClientValidationServiceSERVImpl][executionFinalScore]";
		LOGGER.logDebug("Inicia" + wInfo);

		Map<String, Object> resultsQ = new HashMap<String, Object>();
		String riesgoIndExt = null;
		String riskLevel = null;

		try {
			Map<String, Object> parameterMapRuleCALFIN = new HashMap<String, Object>();
			parameterMapRuleCALFIN.put("idRule", "CALFIN");
			parameterMapRuleCALFIN.put("idCobis", customerId);
			parameterMapRuleCALFIN.put("result", 0);
			parameterMapRuleCALFIN.put("typeRatingCustomerEvaluation", typeRatingCustomerEvaluation);
			parameterMapRuleCALFIN.put("evaluateRule", evaluateRule);

			Map<?, ?> mapParamsRuleCalifCli = this.getBuroUtil().newCustomeRulesEvaluation(parameterMapRuleCALFIN);

			String color = (String) mapParamsRuleCalifCli.get("@o_color");
			String letra = (String) mapParamsRuleCalifCli.get("@o_letra");

			riskLevel = color;
			riesgoIndExt = letra;

			resultsQ.put("color", color);
			resultsQ.put("letra", letra);

			LOGGER.logDebug(wInfo + "--->>>Salida -->> color:" + riskLevel);
			LOGGER.logDebug(wInfo + "--->>>Salida -->> letra:" + riesgoIndExt);
		} catch (BusinessException e) {
			LOGGER.logError(wInfo + " Error en ejecucion regla de calificacion final", e);
		}
		LOGGER.logDebug("Finaliza" + wInfo);

		return resultsQ;
	}

}
