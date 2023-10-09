package com.cobiscorp.ecobis.cloud.service.integration;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.extractOutputValue;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.extractValue;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICobisParameter;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.cloud.service.dto.client.CustomerResult;
import com.cobiscorp.ecobis.cloud.service.dto.client.ReferenceResult;
import com.cobiscorp.ecobis.cloud.service.dto.prospect.ProspectClient;
import com.cobiscorp.ecobis.cloud.service.dto.prospect.ProspectCreateResponse;
import com.cobiscorp.ecobis.cloud.service.impl.ProspectRestService;
import com.cobiscorp.ecobis.cloud.service.util.ArrayUtil;
import com.cobiscorp.ecobis.cloud.service.util.ArrayUtil.Predicate;
import com.cobiscorp.ecobis.cloud.service.util.RestServiceBase;

import cobiscorp.ecobis.businesstoconsumer.dto.OnboardingCustomerRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerReferenceRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerReferenceResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.EconomicActivityDataRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.EconomicActivityDataResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.NaturalProspectRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.RelationPersonResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.RelationRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.SpouseProspectRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.SpouseProspectResponse;

/**
 * @author Cesar Loachamin
 */
public class CustomerIntegrationService extends RestServiceBase {

	private final ILogger logger = LogFactory.getLogger(ProspectRestService.class);
	private ICobisParameter parameterService;

	public CustomerIntegrationService(ICTSServiceIntegration integration) {
		super(integration);
	}

	public void updateCustomer(CustomerTotalRequest request) throws BusinessException, Exception {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		request.setOperation('U');
		requestTo.addValue("inCustomerTotalRequest", request);
		execute("CustomerDataManagementService.CustomerManagement.UpdateCustomerMobile", requestTo);
	}

	public CustomerResult createProspect(NaturalProspectRequest request) throws BusinessException, Exception {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		request.setChannel("B2B");
		requestTo.addValue("inNaturalProspectRequest", request);
		requestTo.addValue("inSpouseProspectRequest", new SpouseProspectRequest());

		ServiceResponse response = execute("CustomerDataManagementService.NaturalProspectManagement.CreateNaturalProspectAndSpouse", requestTo);
		return new CustomerResult(extractOutputValue(response, "@o_ente", Integer.class), extractOutputValue(response, "@o_curp", String.class),
				extractOutputValue(response, "@o_rfc", String.class), extractOutputValue(response, "@o_dire", Integer.class));
	}

	public CustomerResponse searchCustomer(int customerId) {
		return executeReadCustomerService(customerId, "CustomerDataManagementService.CustomerManagement.ReadDataCustomer", 0);
	}

	public CustomerResponse readCustomerInfo(int customerId) {
		return executeReadCustomerService(customerId, "CustomerDataManagementService.CustomerManagement.ReadCustomerInfo", 1);
	}

	public CustomerReferenceResponse searchReference(int customerId, final int referenceId) {
		CustomerReferenceResponse[] references = searchReferences(customerId);
		return ArrayUtil.find(references, new Predicate<CustomerReferenceResponse>() {
			@Override
			public boolean test(CustomerReferenceResponse obj) {
				return obj.getReferences() == referenceId;
			}
		});
	}

	public ReferenceResult createReference(CustomerReferenceRequest request) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inCustomerReferenceRequest", request);
		ServiceResponse response = execute("CustomerDataManagementService.CustomerManagement.CreateCustomerReference", requestTo);
		return new ReferenceResult(extractOutputValue(response, "@o_siguiente", Integer.class));
	}

	public void updateReference(CustomerReferenceRequest request) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inCustomerReferenceRequest", request);
		execute("CustomerDataManagementService.CustomerManagement.UpdateCustomerReference", requestTo);
	}

	public void updateComplementary(CustomerTotalRequest request) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		request.setOperation('C');
		request.setIfeNumber(request.getIfeNumber());
		request.setElectronicSignature(request.getElectronicSignature());
		request.setPhoneErrands(request.getPhoneErrands());
		request.setPersonNameMessages(request.getPersonNameMessages());
		request.setPhoneErrands(request.getPhoneErrands());
		request.setIsCryptoUsed(request.getIsCryptoUsed());
		request.setProfessionalActivity(request.getProfessionalActivity());
		requestTo.addValue("inCustomerTotalRequest", request);
		execute("CustomerDataManagementService.CustomerManagement.UpdateCustomerComplementaryData", requestTo);
	}

	public CustomerResponse readComplementaryData(int customerId) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		CustomerRequest request = new CustomerRequest();
		request.setCustomerId(customerId);
		request.setFormatDate(101);
		// request.setModo(modo);
		requestTo.addValue("inCustomerRequest", request);

		ServiceResponse response = execute("CustomerDataManagementService.CustomerManagement.ReadComplementary", requestTo);
		return extractValue(response, "returnCustomerResponse", CustomerResponse.class);
	}

	public CustomerResponse searchSpouse(int customerId) {
		RelationPersonResponse spouseRelation = searchSpouseRelation(customerId);
		if (spouseRelation == null) {
			return null;
		}
		int spouseId = spouseRelation.getRight();
		CustomerResponse customerResponse = searchCustomer(spouseId);
		if (customerResponse != null) {
			customerResponse.setCustomerId(spouseId);
		}
		return customerResponse;
	}

	public void createSpouseRelation(int customerId, int spouseId) {
		RelationRequest request = new RelationRequest();
		request.setLeft(customerId);
		request.setRight(spouseId);
		request.setRelation(209);
		request.setSide('I');

		createRelation(request);
	}

	public ServiceResponse checkRelationship(RelationRequest request) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inRelationRequest", request);
		logger.logDebug("invoca a  checkRelationship" + request);
		ServiceResponse response = execute("CustomerDataManagementService.CustomerManagement.CheckRelationship", requestTo);
		return response;
	}

	public ServiceResponse createRelation(RelationRequest request) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inRelationRequest", request);
		logger.logDebug("invoca a  createRelation" + request);
		ServiceResponse response = execute("CustomerDataManagementService.NaturalProspectManagement.InsertRelationNaturalProspect", requestTo);
		return response;
	}

	public void removeRelation(RelationRequest request) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inRelationRequest", request);
		logger.logDebug("invoca a  removeRelation" + request);
		execute("CustomerDataManagementService.CustomerManagement.DeleteRelation", requestTo);
	}

	public ServiceResponse removeAllRelation(RelationRequest request) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inRelationRequest", request);
		logger.logDebug("invoca a  removeAllRelation" + request);
		ServiceResponse response = execute("CustomerDataManagementService.CustomerManagement.DeleteAllRelation", requestTo);
		return response;
	}

	public CustomerReferenceResponse[] searchReferences(int customerId) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		CustomerReferenceRequest request = new CustomerReferenceRequest();
		request.setCustomerCode(customerId);
		requestTo.addValue("inCustomerReferenceRequest", request);
		ServiceResponse response = execute("CustomerDataManagementService.CustomerManagement.SearchCustomerReference", requestTo);
		return extractValue(response, "returnCustomerReferenceResponse", CustomerReferenceResponse[].class);
	}

	public String createEconomicActivity(EconomicActivityDataRequest request) {
		ServiceResponse response = executeEconomicActivityService("CustomerDataManagementService.CustomerManagement.CreateEconomicActivity", request);
		return extractOutputValue(response, "@o_secuencial", String.class);
	}

	public void updateEconomicActivity(EconomicActivityDataRequest request) {
		executeEconomicActivityService("CustomerDataManagementService.CustomerManagement.UpdateEconomicActivity", request);
	}

	public EconomicActivityDataResponse findFirstEconomicActivity(int customerId) {
		EconomicActivityDataRequest request = new EconomicActivityDataRequest();
		request.setCustomer(customerId);
		request.setMode(0);
		request.setSequential(0);

		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inEconomicActivityDataRequest", request);

		ServiceResponse response = execute("CustomerDataManagementService.CustomerManagement.SearchEconomicActivity", requestTo);
		EconomicActivityDataResponse[] activities = extractValue(response, "returnEconomicActivityDataResponse", EconomicActivityDataResponse[].class);
		if (activities == null || activities.length == 0) {
			return null;
		}
		return activities[0];
	}

	private CustomerResponse executeReadCustomerService(int customerId, String serviceId, int modo) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		CustomerRequest request = new CustomerRequest();
		request.setCustomerId(customerId);
		request.setFormatDate(101);
		request.setModo(modo);
		requestTo.addValue("inCustomerRequest", request);
		ServiceResponse response = execute(serviceId, requestTo);
		return extractValue(response, "returnCustomerResponse", CustomerResponse.class);
	}

	public CustomerResult updateCustomerRenapo(CustomerTotalRequest customerTotalRequest) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inCustomerTotalRequest", customerTotalRequest);
		ServiceResponse response = execute("CustomerDataManagementService.CustomerManagement.UpdateCustomerRENAPO", requestTo);
		if (response.isResult()) {
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) response.getData();
			if (serviceResponseTo == null) {
				return new CustomerResult();
			} else if (serviceResponseTo.isSuccess()) {
				logger.logDebug("updateCustomerRenapo serviceResponseTo success");
				return new CustomerResult(customerTotalRequest.getCodePerson(), extractOutputValue(response, "@o_curp", String.class),
						extractOutputValue(response, "@o_rfc", String.class), 0);
			} else {
				logger.logError("updateCustomerRenapo serviceResponseTo isn't success");
				throw new BusinessException(2103057, "Error al actualizar RENAPO para el cliente " + customerTotalRequest.getCodePerson());
			}
		}
		return null;
	}

	public void updateCustomerInfo(CustomerTotalRequest customerTotalRequest) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		customerTotalRequest.setOperation('M');
		serviceRequestTO.addValue("inCustomerTotalRequest", customerTotalRequest);
		execute("CustomerDataManagementService.CustomerManagement.UpdateCustomerMobile", serviceRequestTO);
	}

	public RelationPersonResponse searchSpouseRelation(int customerId) {
		RelationRequest request = new RelationRequest();
		request.setLeft(customerId);
		request.setMode(0);
		request.setRelation(209);

		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inRelationRequest", request);
		ServiceResponse response = execute("CustomerDataManagementService.CustomerManagement.SearchRelationPerson", requestTo);
		RelationPersonResponse[] relations = extractValue(response, "returnRelationPersonResponse", RelationPersonResponse[].class);
		if (relations == null || relations.length == 0) {
			return null;
		}
		return relations[0];
	}

	private ServiceResponse executeEconomicActivityService(String serviceId, EconomicActivityDataRequest request) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inEconomicActivityDataRequest", request);
		return execute(serviceId, requestTo);
	}

	public ServiceResponse createSponse(SpouseProspectRequest request) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inSpouseProspectRequest", request);
		return execute("CustomerDataManagementService.NaturalProspectManagement.CreateNaturalProspectSpouse", requestTo);
	}

	public SpouseProspectResponse searchSpouse(SpouseProspectRequest request) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inSpouseProspectRequest", request);
		ServiceResponse response = execute("CustomerDataManagementService.CustomerManagement.SearchSpouseCustomer", requestTo);
		SpouseProspectResponse spouses = extractValue(response, "returnSpouseProspectResponse", SpouseProspectResponse.class);
		return spouses;
	}

	// caso #193221 B2B Grupal Digital
	public ProspectCreateResponse prospectCreation(ProspectClient client, int channel) {
		logger.logDebug("CustomerIntegrationService --> prospectCreation");

		ProspectCreateResponse object = new ProspectCreateResponse();
		ServiceRequestTO requestTo = new ServiceRequestTO();
		OnboardingCustomerRequest onboardingCustomer = new OnboardingCustomerRequest();

		// Consent
		onboardingCustomer.setState(client.getClient().getConsent().getState());
		// Data
		onboardingCustomer.setCellphoneNumber(client.getClient().getData().getCellphoneNumber());
		onboardingCustomer.setNombre(client.getClient().getData().getFirstName());
		onboardingCustomer.setSegNombre(client.getClient().getData().getSecondName());
		onboardingCustomer.setApellido(client.getClient().getData().getLastName());
		onboardingCustomer.setSegApellido(client.getClient().getData().getSecondLastName());

		logger.logDebug("prospectCreation-FechaNac: " + client.getClient().getData().getBirthdate());
		onboardingCustomer.setFechaNacStr(client.getClient().getData().getBirthdate());

		onboardingCustomer.setLugarNac(client.getClient().getData().getBirthplace());
		onboardingCustomer.setSexo(client.getClient().getData().getGender());
		onboardingCustomer.setCurp(client.getClient().getData().getCurp());
		onboardingCustomer.setTipoIdentificacion(client.getClient().getData().getBioIdentificationType());
		onboardingCustomer.setBioOCR(client.getClient().getData().getBioOCR());
		onboardingCustomer.setNumEmisor(client.getClient().getData().getBioEmissionNumber());
		onboardingCustomer.setCic(client.getClient().getData().getBioCic());
		onboardingCustomer.setBioClaveLector(client.getClient().getData().getBioReaderKey());
		onboardingCustomer.setBioEmissionDate(client.getClient().getData().getBioEmissionDate());
		onboardingCustomer.setBioRegisterDate(client.getClient().getData().getBioRegisterDate());
		onboardingCustomer.setBioHuellaDactilar(client.getClient().getData().isBioSinHuella());
		// simulation
		onboardingCustomer.setRequestedAmount(client.getClient().getSimulation().getAmount());
		onboardingCustomer.setTerm(client.getClient().getSimulation().getTerm());
		onboardingCustomer.setFrequency(client.getClient().getSimulation().getPeriodicity());
		onboardingCustomer.setTypeOperation(client.getClient().getSimulation().getOperationType());
		onboardingCustomer.setSubtype(client.getClient().getSimulation().getSubType());
		onboardingCustomer.setCurrency(client.getClient().getSimulation().getCurrency());
		onboardingCustomer.setSimulationDate(client.getClient().getSimulation().getIniDate());
		onboardingCustomer.setRate(client.getClient().getSimulation().getRate());
		onboardingCustomer.setQuote(client.getClient().getSimulation().getQuota());
		// authorization
		onboardingCustomer.setTipoAut(client.getClient().getAuthorization().getTypeAuthorization());
		onboardingCustomer.setDateAut(client.getClient().getAuthorization().getDateAuthorization());
		//
		onboardingCustomer.setModo(client.getClient().getModo());
		onboardingCustomer.setChannel(channel);

		requestTo.addValue("inOnboardingCustomerRequest", onboardingCustomer);

		ServiceResponse response = execute("BusinessToConsumer.CustomerManagement.OnboardingRegister", requestTo);
		if (response != null) {
			object.setEnte(extractOutputValue(response, "@o_ente", Integer.class));
			object.setDireccion(extractOutputValue(response, "@o_direccion", Integer.class));
			object.setTelefono(extractOutputValue(response, "@o_telefono", Integer.class));
			object.setLi_negra(extractOutputValue(response, "@o_li_negra", String.class));
			object.setNeg_file(extractOutputValue(response, "@o_neg_file", String.class));
			object.setEnrol_estatus(extractOutputValue(response, "@o_enrol_estatus", String.class));
			object.setRfc(extractOutputValue(response, "@o_rfc", String.class));
			object.setNomlar(extractOutputValue(response, "@o_nomlar", String.class));

			return object;
		}
		return null;
	}

	public void setParameterService(ICobisParameter parameterService) {
		this.parameterService = parameterService;
	}

	public void unsetParameterService(ICobisParameter parameterService) {
		this.parameterService = null;
	};
}
