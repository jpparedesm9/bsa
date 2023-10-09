package com.cobis.cloud.lcr.b2b.service.rest;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.objectToJson;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.successResponse;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;

import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DebtorRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;
import cobiscorp.ecobis.htm.api.dto.TaskDTO;
import cobiscorp.ecobis.parameter.dto.ParameterSearchResponse;
import cobiscorp.ecobis.systemconfiguration.dto.OfficerResponse;

import com.cobis.cloud.lcr.b2b.service.RevolvingCreditService;
import com.cobis.cloud.lcr.b2b.service.common.IntegrationException;
import com.cobis.cloud.lcr.b2b.service.dto.RevolvingCreditRequest;
import com.cobis.cloud.lcr.b2b.service.dto.RevolvingCreditResponse;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICobisParameter;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CreditApplicationData;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CreditApplicationResponse;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.InstanceProcessData;
import com.cobiscorp.ecobis.cloud.service.integration.ApplicationService;
import com.cobiscorp.ecobis.cloud.service.integration.CustomerIntegrationService;
import com.cobiscorp.ecobis.cloud.service.integration.OfficerIntegrationService;
import com.cobiscorp.ecobis.cloud.service.integration.ParameterIntegrationService;
import com.cobiscorp.ecobis.cloud.service.integration.QueryBureauService;
import com.cobiscorp.ecobis.cloud.service.integration.WorkflowService;
import com.cobiscorp.ecobis.cloud.service.util.SessionUtil;

@Path("/lcr")
@Component
@Service({ RevolvingCreditService.class })
@Reference(name = "serviceIntegration", referenceInterface = ICTSServiceIntegration.class, bind = "setServiceIntegration", unbind = "unSetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
public class RevolvingCreditRest implements RevolvingCreditService {

	@Reference(bind = "setParameterService", unbind = "unsetParameterService", target = "(service.impl=default)")
	private ICobisParameter parameterService;

	private OfficerIntegrationService officerIntegrationService;
	private WorkflowService workflowService;
	private QueryBureauService queryBureauService;
	private ApplicationService applicationService;
	private ParameterIntegrationService parameterIntegrationService;
	private CustomerIntegrationService customerService;

	private final static ILogger logger = LogFactory.getLogger(RevolvingCreditRest.class);

	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response create(RevolvingCreditRequest revolvingCreditRequest) {
		logger.logDebug("/lcr/create request>> " + objectToJson(revolvingCreditRequest));

		int processInstanceNumber = 0;
		RevolvingCreditResponse revolvingCreditResponse = new RevolvingCreditResponse();
		TaskDTO taskDTO = null;

		ServiceResponse processInstanceResponse = createProcessInstance(revolvingCreditRequest);
		if (!processInstanceResponse.isResult()) {
			revolvingCreditResponse.setProcessInstance(processInstanceResponse);
			return successResponse(revolvingCreditResponse, false, "/lcr/create>> no recupera instancia de proceso");
		} else {
			if (processInstanceResponse.getData() != null) {
				processInstanceNumber = ((InstanceProcessData) processInstanceResponse.getData()).getProcessInstance();
			}
		}
		logger.logDebug("/lcr/create>> processInstance created " + processInstanceNumber);
		revolvingCreditResponse.setProcessInstance(processInstanceResponse);
		revolvingCreditRequest.setProcessInstance(processInstanceNumber);

		ServiceResponse currentTaskResponse = workflowService.getCurrentTask(revolvingCreditRequest.getProcessInstance());
		if (currentTaskResponse.isResult()) {
			taskDTO = (TaskDTO) currentTaskResponse.getData();
		} else {
			return successResponse(revolvingCreditResponse, "/lcr/create>>  Error al obtener la tarea actual");
		}

		// return successResponse(revolvingCreditResponse,
		// "/lcr/create>> Para pruebas solamente crea la instancia de proceso");
		return updateRevolvingCredit(revolvingCreditRequest, revolvingCreditResponse, taskDTO);
	}

	@PUT
	@Produces(MediaType.APPLICATION_JSON)
	@Override
	public Response update(RevolvingCreditRequest revolvingCreditRequest) {
		logger.logDebug("/lcr/update>> request >> " + objectToJson(revolvingCreditRequest));
		RevolvingCreditResponse revolvingCreditResponse = new RevolvingCreditResponse();
		ServiceResponse processInstanceResponse = new ServiceResponse();
		ServiceResponse creditApplicationResponse = new ServiceResponse();

		InstanceProcessData instanceProcessData = new InstanceProcessData();
		instanceProcessData.setProcessInstance(revolvingCreditRequest.getProcessInstance());
		processInstanceResponse.setData(instanceProcessData);
		processInstanceResponse.setResult(true);
		processInstanceResponse.setData(instanceProcessData);
		revolvingCreditResponse.setProcessInstance(processInstanceResponse);

		ServiceResponse currentTaskResponse = workflowService.getCurrentTask(revolvingCreditRequest.getProcessInstance());
		TaskDTO taskDTO = null;
		if (revolvingCreditRequest.getProcessInstance() == 0) {
			// TODO: Cambiar el metodo a ServiceResponseUtil
			creditApplicationResponse.setResult(false);
			creditApplicationResponse.setData(null);
			creditApplicationResponse.addMessage("300", "La petición debe traer una instancia de proceso");
			revolvingCreditResponse.setCreditApplication(creditApplicationResponse);
			return successResponse(revolvingCreditResponse, false, "/lcr/update>> La petición debe traer una instancia de proceso ");
		}

		if (currentTaskResponse.isResult()) {
			taskDTO = (TaskDTO) currentTaskResponse.getData();
		} else {
			creditApplicationResponse.setResult(false);
			creditApplicationResponse.setData(null);
			creditApplicationResponse.addMessage("400", "Error al recuperar la instancia de proceso");
			revolvingCreditResponse.setCreditApplication(creditApplicationResponse);
			return successResponse(revolvingCreditResponse, false, "/lcr/update>> Error al recuperar la instancia de proceso");
		}

		instanceProcessData.setAlternateCode(taskDTO.getAlternateCode());
		logger.logDebug("/lcr/update>> Recupera la tarea Actual >> " + taskDTO);

		return updateRevolvingCredit(revolvingCreditRequest, revolvingCreditResponse, taskDTO);

	}

	private Response updateRevolvingCredit(RevolvingCreditRequest revolvingCreditRequest, RevolvingCreditResponse revolvingCreditResponse, TaskDTO taskDTO) {
		// Métodos que se disparan en el init de la pantalla
		// consulta individual de buró

		ServiceResponse buroResponse = executeQueryBureau(revolvingCreditRequest);
		revolvingCreditResponse.setCreditApplication(buroResponse);
		if (!buroResponse.isResult()) {
			return successResponse(revolvingCreditResponse, false, "/lcr/create>> error al consultar Buró ");
		}
		logger.logDebug("/lcr/updateRevolvingCredit>> luego de consultar buró");

		// Crear el trámite -Guardar la solicitud
		ServiceResponse creditApplicationResponse = new ServiceResponse();

		if (revolvingCreditRequest.getApplicationCode() == 0) {
			creditApplicationResponse = createApplication(revolvingCreditRequest);
		} else {
			creditApplicationResponse = updateApplication(revolvingCreditRequest);
		}

		revolvingCreditResponse.setCreditApplication(creditApplicationResponse);
		if (!creditApplicationResponse.isResult()) {
			return successResponse(revolvingCreditResponse, false, "/lcr/create>> error al crear el trámite ");
		}

		logger.logDebug("/lcr/updateRevolvingCredit>> luego de consultar o actualizar el trámite");

		// SRO. Evaluación de Políticas
		ServiceResponse evaluatePoliticsResponse = workflowService.evaluatePolicies(taskDTO);
		revolvingCreditResponse.setEvaluatePolitics(evaluatePoliticsResponse);
		if (!evaluatePoliticsResponse.isResult()) {
			revolvingCreditResponse.setCreditApplication(creditApplicationResponse);
			return successResponse(revolvingCreditResponse, false, "/lcr/create>> Error al evaluar políticas. Políticas no cumplen.");
		}

		ServiceResponse completeTaskResponse = completeTask(taskDTO, revolvingCreditRequest.getProcessInstance());
		revolvingCreditResponse.setCompleteTask(completeTaskResponse);
		if (!completeTaskResponse.isResult()) {
			return successResponse(revolvingCreditResponse, false, "/lcr/create>> Error al rutear la tarea ");
		}

		// Rutear a la siguiente etapa
		return successResponse(revolvingCreditResponse, "/lcr/create>> fin del proceso");
	}

	private ServiceResponse executeQueryBureau(RevolvingCreditRequest revolvingCreditRequest) {
		ServiceResponse buroResponse = new ServiceResponse();
		try {
			queryBureauService.executeQueryBureau(revolvingCreditRequest.getCustomerCode());
			buroResponse.setResult(true);
		} catch (IntegrationException ie) {
			logger.logError("Error al consultar Buró ", ie);
			buroResponse = ie.getResponse();
		} catch (Exception e) {
			buroResponse.setResult(false);
			buroResponse.setData(null);
			logger.logError("Error al crear el trámite ", e);
		}
		return buroResponse;
	}

	private ServiceResponse createProcessInstance(RevolvingCreditRequest revolvingCreditRequest) {
		ServiceResponse processInstanceResponse;
		logger.logDebug("/lcr/create start createProcessInstance>> ");

		int officerId = 0;
		if (officerIntegrationService != null) {
			OfficerResponse officerResponse = officerIntegrationService.getOfficerByLogin(SessionUtil.getUser());
			officerId = officerResponse.getOfficerId();
		}

		if (SessionUtil.getOffice() == 0) {
			revolvingCreditRequest.setOffice(1101);
		} else {
			revolvingCreditRequest.setOffice(SessionUtil.getOffice());
		}

		revolvingCreditRequest.setOfficer(officerId);

		logger.logDebug("/lcr/create office>>" + revolvingCreditRequest.getOffice());
		logger.logDebug("/lcr/create officer>>" + revolvingCreditRequest.getOfficer());

		String processNamePart1 = parameterService.getParameter(null, "CRE", "WSCRE1", String.class);
		String processNamePart2 = parameterService.getParameter(null, "CRE", "WSCRE2", String.class);

		String processName = processNamePart1.concat(processNamePart2);

		logger.logDebug("/lcr/create 1 - Create process Instance");

		processInstanceResponse = workflowService.createProcessIntance(processName, revolvingCreditRequest.getCustomerCode(), 0, null, "REVOLVENTE", "P",
				revolvingCreditRequest.getOffice(), 12);

		logger.logDebug("/lcr/create finish createProcessInstance>> ");

		return processInstanceResponse;
	}

	private ServiceResponse completeTask(TaskDTO taskDTO, int processInstance) {

		ServiceResponse completeTaskResponse = workflowService.completeWorkflowTask(Integer.valueOf(taskDTO.getProcessInstanceIdentifier()),
				Integer.valueOf(taskDTO.getTaskInstanceIdentifier()), taskDTO.getCobisAssignAct(), taskDTO.getCobisStepId());
		// TODO: Validar si esta en la etapa correcta, aunque solo deberia ser
		// en actualizacion

		return completeTaskResponse;

	}

	private ServiceResponse createApplication(RevolvingCreditRequest revolvingCreditRequest) {
		CreditApplicationData creditApplicationData = new CreditApplicationData();
		ServiceResponse creditApplicationResponse = new ServiceResponse();
		try {

			DebtorRequest debtorRequest = new DebtorRequest();
			debtorRequest.setDebtorCode(revolvingCreditRequest.getCustomerCode());

			Calendar initalDateAux = Calendar.getInstance();
			Date initalDate = new Date();

			// initalDate = //recuperar del servicio la fecha de proceso
			initalDateAux.setTime(initalDate);

			ApplicationRequest application = new ApplicationRequest();
			application.setType("O");
			application.setClient(revolvingCreditRequest.getCustomerCode());

			application.setOffice(revolvingCreditRequest.getOffice());
			application.setCreationDate(null);// obtener la fecha de proceso
			application.setOfficer(revolvingCreditRequest.getOfficer());
			application.setSector("S");
			application.setPortfolioType("F");
			application.setSectorCustomer("S");
			application.setCity(1);// colocar valor por defecto o recuperar del
									// cliente, copiar del log

			ParameterSearchResponse pfrmesResponse = parameterIntegrationService.searchParameter("PFRMES", "CRE");
			// application.setOperationNumberBank(entidadInfo.get(EntidadInfo.BANCA));
			application.setOperationNumberBank("1");// copiar del log

			application.setPaymentFrequency(revolvingCreditRequest.getPaymentFrecuency());

			// application.setAmountRequested(originalHeader.get(OriginalHeader.AMOUNTREQUESTED).doubleValue());
			application.setAmountRequested(0.0);
			application.setTerm(1);

			application.setClient(debtorRequest.getDebtorCode());
			application.setStartDate(initalDateAux);
			// en el grupal creditApplicationRequest.getApplicationType()
			application.setOpertationType("REVOLVENTE");

			// normal/intercuiclos/grupal
			application.setProduct("REVOLVENTE");

			application.setAmount(0.0);// copiar del front end
			application.setMoney(0);// copiar del front end (en grupal no esta)
			application.setDestination("01");// copiar del front end (en grupal
												// no esta)
			application.setCityDestination(1);// copiar dle front campo nuevo
			application.setRevolving('S');
			application.setInstProcess(revolvingCreditRequest.getProcessInstance());
			application.setDestinationDescription("01");// copiar dle front
														// campo nuevo
			application.setActivityDestination("01");// copiar dle front campo
														// nuevo
			// application.setTermType("M");//copiar del front(en grupal esta
			// quemado)

			logger.logDebug("Frecuencia de Pago>>" + revolvingCreditRequest.getPaymentFrecuency());
			application.setDetailTerm(revolvingCreditRequest.getPaymentFrecuency());
			application.setTermType(revolvingCreditRequest.getPaymentFrecuency());

			/* Información sin llenar */
			application.setCreditLine2(null);
			application.setOperationRestructure(null);
			application.setFoundsSource(null);
			application.setCurrentAccount(null);

			DebtorRequest debtorR = new DebtorRequest();
			debtorR.setDebtorCode(revolvingCreditRequest.getCustomerCode());

			String value = applicationService.createRevolvingApplication(application, debtorRequest);

			if (value != null) {
				creditApplicationData.setApplicationCode(Integer.parseInt(value));
				creditApplicationResponse.setData(creditApplicationData);
				creditApplicationResponse.setResult(true);

				workflowService.updateInstanceProcess(revolvingCreditRequest.getProcessInstance(), creditApplicationData.getApplicationCode());
				/* Inicio se anade campo 5 */
				logger.logDebug("/cobis-cloud/mobile/creditapplication/ Inicia metodo pdateFieldFive desde la movil:" + revolvingCreditRequest.getProcessInstance());
				ApplicationRequest applicationRequest = new ApplicationRequest();
				applicationRequest.setInstProcess(revolvingCreditRequest.getProcessInstance());
				workflowService.updateFieldFive(applicationRequest);
				logger.logDebug("/cobis-cloud/mobile/creditapplication/ Fin metodo updateFieldFive desde la movil");

				debtorRequest.setApplicationCode(creditApplicationData.getApplicationCode());
				debtorRequest.setRole("D");// deudor principal
				debtorRequest.setDebtorIdentification(revolvingCreditRequest.getCurp());

				ServiceResponse debtorResponse = applicationService.saveDebtorTmp(debtorRequest);
				if (!debtorResponse.isResult()) {
					creditApplicationResponse.setResult(false);
					creditApplicationResponse.setMessages(debtorResponse.getMessages());
				}

			}

		} catch (IntegrationException ie) {
			logger.logError("Error al crear el trámite ", ie);
			creditApplicationResponse = ie.getResponse();

		} catch (Exception e) {
			creditApplicationResponse.setResult(false);
			creditApplicationResponse.setData(null);
			logger.logError("Error al crear el trámite ", e);
		}
		return creditApplicationResponse;
	}

	private ServiceResponse updateApplication(RevolvingCreditRequest revolvingCreditRequest) {
		ServiceResponse creditApplicationResponse = new ServiceResponse();

		CustomerTotalRequest customerTotalRequest = new CustomerTotalRequest();
		ApplicationRequest application = new ApplicationRequest();
		application.setIdrequested(revolvingCreditRequest.getApplicationCode());
		application.setTermType(revolvingCreditRequest.getPaymentFrecuency());

		customerTotalRequest.setCodePerson(revolvingCreditRequest.getCustomerCode());
		customerTotalRequest.setCollectiveLevel(revolvingCreditRequest.getCollectiveClientLevel());
		customerTotalRequest.setOtherIncome(BigDecimal.valueOf(revolvingCreditRequest.getMonthlyIncome() == null ? 0.0 : revolvingCreditRequest.getMonthlyIncome()));

		ServiceResponse updateResponse = applicationService.updateRevolvingApplication(application);
		customerService.updateCustomerInfo(customerTotalRequest);
		if (updateResponse.isResult()) {
			CreditApplicationData creditApplicationData = new CreditApplicationData();
			creditApplicationData.setApplicationCode(revolvingCreditRequest.getApplicationCode());
			creditApplicationResponse.setResult(true);
			creditApplicationResponse.setData(creditApplicationData);
		} else {
			creditApplicationResponse.setResult(false);
			creditApplicationResponse.setMessages(updateResponse.getMessages());
		}

		return creditApplicationResponse;
	}

	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.officerIntegrationService = new OfficerIntegrationService(serviceIntegration);
		this.workflowService = new WorkflowService(serviceIntegration);
		this.queryBureauService = new QueryBureauService(serviceIntegration);
		this.parameterIntegrationService = new ParameterIntegrationService(serviceIntegration);
		this.applicationService = new ApplicationService(serviceIntegration);
		this.customerService = new CustomerIntegrationService(serviceIntegration);
	}

	protected void unSetServiceIntegration(ICTSServiceIntegration serviceIntegration) {

	}

	public void setParameterService(ICobisParameter parameterService) {
		this.parameterService = parameterService;
	}

	public void unsetParameterService(ICobisParameter parameterService) {
		this.parameterService = null;
	}
}