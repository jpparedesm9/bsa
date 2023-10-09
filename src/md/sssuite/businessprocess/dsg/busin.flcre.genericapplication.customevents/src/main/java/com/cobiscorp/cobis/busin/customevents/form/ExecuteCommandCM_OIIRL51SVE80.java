package com.cobiscorp.cobis.busin.customevents.form;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.busin.customevents.utils.Constants;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ApplicationType;
import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.AccounManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.CustomerManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.DebtorManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.OperationManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.RevolvingManagment;
import com.cobiscorp.cobis.busin.flcre.commons.services.RuleExecutionManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.SynchronizationManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.SystemConfigurationManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.WorkflowManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.DebtorUtil;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.SessionContext;
import com.cobiscorp.cobis.busin.model.ApplicationInfoAux;
import com.cobiscorp.cobis.busin.model.Aval;
import com.cobiscorp.cobis.busin.model.Context;
import com.cobiscorp.cobis.busin.model.DebtorGeneral;
import com.cobiscorp.cobis.busin.model.EntidadInfo;
import com.cobiscorp.cobis.busin.model.NewAliquot;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.RefinancingOperations;
import com.cobiscorp.cobis.busin.model.VariableData;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.Property;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleProcess;
import com.cobiscorp.ecobis.bpl.rules.engine.model.VariableProcess;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.AddressManager;
import com.cobiscorp.ecobis.fpm.model.FieldByProductValues;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;

import cobiscorp.ecobis.account.dto.CustomerRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationNewRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DebtorRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RenewLoanRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RenewLoanResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RuleAmountMaxResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SynchronizationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SynchronizationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.VariableDataRequest;
import cobiscorp.ecobis.businessprocess.loanrequest.dto.ProcessedNumber;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressRequest;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;
import cobiscorp.ecobis.workflow.dto.InstanceProcess;

public class ExecuteCommandCM_OIIRL51SVE80 extends BaseEvent implements IExecuteCommand {
	private static ILogger LOGGER = LogFactory.getLogger(ExecuteCommandCM_OIIRL51SVE80.class);
	private static final String RENOVATION_MODE = "R";

	public ExecuteCommandCM_OIIRL51SVE80(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@SuppressWarnings({ "unchecked", "unused" })
	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {

		try {
			LOGGER.logDebug("---->Entra al ExecuteCommandCM_OIIRL51SVE80");
			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
			DataEntity aval = entities.getEntity(Aval.ENTITY_NAME);
			AccounManagement accountManagement = new AccounManagement(getServiceIntegration());
			CustomerManagement customerManagement = new CustomerManagement(getServiceIntegration());
			WorkflowManagement workflowManagement = new WorkflowManagement(getServiceIntegration());
			TransactionManagement transactionMngmnt = new TransactionManagement(super.getServiceIntegration());
			ProcessedNumber processedNumber = transactionMngmnt.getProcessedNumber(originalHeader.get(OriginalHeader.APPLICATIONNUMBER), args, new BehaviorOption(true));
			if (processedNumber == null) {
				MessageManagement.show(args, new MessageOption("BUSIN.DLB_BUSIN_NMRREEUID_75532", MessageLevel.ERROR, true));
				return;
			}

			LOGGER.logDebug("---->Recupera el Campo 7 Para identificar si es grupal:--" + processedNumber.getFieldSeven() + "--");
			String fieldSeven = "";
			if (processedNumber.getFieldSeven() != null) {
				fieldSeven = processedNumber.getFieldSeven().trim();
			}

			if (!transactionMngmnt.validateOriginalApplication(entities, args)) {
				args.setSuccess(false);
				return;
			}

			DataEntity generalData = entities.getEntity("generalData");

			Double requestedAmount = originalHeader.get(OriginalHeader.AMOUNTREQUESTED) == null ? null : originalHeader.get(OriginalHeader.AMOUNTREQUESTED).doubleValue();
			Integer customerId = generalData.get(new Property<Integer>("clientId", Integer.class));
			String productType = originalHeader.get(OriginalHeader.PRODUCTTYPE);// normal/intercuiclos/grupal

			Map<String, Object> task = (Map<String, Object>) args.getParameters().getCustomParameters().get("Task");
			Map<String, Object> url = (Map<String, Object>) task.get("urlParams");

			DataEntity taskTmp = entities.getEntity("TaskTemp");

			Integer processId = 0;
			if (taskTmp != null)
				processId = taskTmp.get(new Property<Integer>("processId", Integer.class, true));

			LOGGER.logError("---->Crea request de tramite");

			CustomerRequest customerRequest = new CustomerRequest();
			customerRequest.setClientId(customerId);
			customerRequest.setRequestedAmount(requestedAmount);

			// Flujo Prestamo Emergente (Interciclo Grupal)
			LOGGER.logDebug("---->***ExecuteCommandCM_OIIRL51SVE80 - productType:" + productType);
			if (Constants.PRESTAMO_EMERGENTE.equals(productType)) {
				LOGGER.logDebug("---->***ExecuteCommandCM_OIIRL51SVE80 - A");
				if (accountManagement.validateAmountSavingAccounts(customerRequest, args) == 1) {

					Integer customerCycleNumber = customerManagement.getCustomerCycleNumber(customerId, args);
					LOGGER.logDebug("customerCycleNumber" + customerCycleNumber);
					Map<String, Object> variables = new HashMap<String, Object>();

					variables.put("Número de Ciclos Préstamo Emergente", customerCycleNumber);
					List<RuleProcess> resultRules = workflowManagement.executeRule("LIMEMER", variables, args, new BehaviorOption(true));

					Integer maxAmount = 0, minAmount = 0;
					RuleProcess ruleProcess = resultRules.get(0);

					List<VariableProcess> variableProcesses = ruleProcess.getVariableProcesses();
					if (variableProcesses == null) {
						args.setSuccess(false);
						return;
					}

					for (VariableProcess variableProcess : variableProcesses) {
						if (variableProcess != null && variableProcess.getVariable() != null
								&& Constants.VAR_MONTO_MIN_EMERGENTE.equals(variableProcess.getVariable().getNombreVariable())) {
							minAmount = variableProcess != null ? Integer.valueOf(variableProcess.getValue()) : null;
						}
						if (variableProcess != null && variableProcess.getVariable() != null
								&& Constants.VAR_MONTO_MAX_EMERGENTE.equals(variableProcess.getVariable().getNombreVariable())) {
							maxAmount = variableProcess != null ? Integer.valueOf(variableProcess.getValue()) : null;
						}
					}
					if (requestedAmount >= minAmount && requestedAmount <= maxAmount) {
						saveAndUpdateData(entities, fieldSeven, productType, args);
					} else {
						args.setSuccess(false);
						args.getMessageManager().showErrorMsg("El monto solicitado no se encuentra dentro de lo límites establecidos para el ciclo: " + customerCycleNumber + ".");
					}
				} else {
					args.setSuccess(false);
					args.getMessageManager().showErrorMsg("El monto solicitado es mayor al 50% del saldo equivalente en las cuentas de ahorros");
				}
			} else {
				LOGGER.logDebug("---->***ExecuteCommandCM_OIIRL51SVE80 - B");
				// Flujo Solicitud de Credito Grupal
				saveAndUpdateData(entities, fieldSeven, productType, args);
			}
		} catch (BusinessException be) {
			LOGGER.logDebug("be.getMessage()>>" + be.getMessage() + " getCause()>>" + be.getCause() + "be.getClientErrorMessage()>>" + be.getClientErrorMessage());
			ExceptionUtils.showError(be.getMessage(), be, args, LOGGER);
		} catch (Exception ex) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_GUARDAR, ex, args, LOGGER);
		}

	}

	private void saveDataRenderSection(DynamicRequest entities, IExecuteCommandEventArgs args) {
		try {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("---->Ingresa al método saveDataRenderSection");
			}
			Map<String, Object> task = (Map<String, Object>) args.getParameters().getCustomParameters().get("Task");
			if (task != null && task.get("urlParams") != null) {
				Map<String, Object> url = (Map<String, Object>) task.get("urlParams");
				// si esta activada la sección renderizada ingresa a la carga de
				// datos
				if (url != null && url.get("RENDER_SECTION") != null && url.get("RENDER_SECTION").equals("S")) {
					BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(super.getServiceIntegration());
					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("RENDER_SECTION---> " + url.get("RENDER_SECTION"));
					}
					// lista de valores render que se carga en el initData de la
					// pantalla
					ArrayList<FieldByProductValues> valuesList = new ArrayList<FieldByProductValues>();
					// values render se cargo en evento
					DataEntityList valuesFieldByProduct = entities.getEntityList("Values");
					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("valuesFieldByProduct---> " + valuesFieldByProduct.size());
					}
					DataEntity bankingProduct = entities.getEntity(OriginalHeader.ENTITY_NAME);
					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("----------->Coloca valores en valuesList");
					}
					String bankingProductId = bankingProduct.get(OriginalHeader.PRODUCTTYPE);
					String request = bankingProduct.get(OriginalHeader.IDREQUESTED);
					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("request " + request);
					}
					if (valuesFieldByProduct.size() > 0) {
						for (DataEntity d : valuesFieldByProduct) {
							FieldByProductValues fpv = new FieldByProductValues();
							fpv.setField(d.get(com.cobiscorp.cobis.busin.model.FieldByProductValues.FIELDID).longValue());
							fpv.setProduct(d.get(com.cobiscorp.cobis.busin.model.FieldByProductValues.PRODUCTID));
							fpv.setRequest(request);
							fpv.setValue(d.get(com.cobiscorp.cobis.busin.model.FieldByProductValues.VALUE));
							valuesList.add(fpv);

						}
					}

					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("----------->valuesList " + valuesList.size() + " bankingProductId+ " + bankingProductId + "request " + request);
					}

					bankingProductManager.insertListFieldByProduct(args, bankingProductId, request, valuesList);
					LOGGER.logDebug("Ejecución del servicio insertListFieldByProduct");
				} else {
					if (LOGGER.isDebugEnabled()) {
					}
				}
			} else {
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("No existe parametros definidos");
				}
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("---->Finaliza el método saveDataRenderSection");
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_GUARDAR_SECCION, e, args, LOGGER);
		}
	}

	private void saveDataRenovation(DynamicRequest entities, IExecuteCommandEventArgs args) {

		LOGGER.logDebug("---->Recupero parametros de la URL enviada");
		@SuppressWarnings("unchecked")
		Map<String, Object> task = (Map<String, Object>) args.getParameters().getCustomParameters().get("Task");
		@SuppressWarnings("unchecked")
		Map<String, Object> url = (Map<String, Object>) task.get("urlParams");

		if (url.get("TRAMITE") != null && url.get("TRAMITE").equals("RENOVATION")) {

			LOGGER.logDebug("---->Recupero entidades de presentacion ");
			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
			DataEntityList refinancingOperations = entities.getEntityList(RefinancingOperations.ENTITY_NAME);

			LOGGER.logDebug("Declaro servicio que va a ejecutar la insercion de la operacion");
			RevolvingManagment revolvingManagment = new RevolvingManagment(getServiceIntegration());
			OperationManagement opMagnament = new OperationManagement(super.getServiceIntegration());
			LOGGER.logDebug("Save Renovacion----->1");

			int idRequested = Integer.valueOf(originalHeader.get(OriginalHeader.IDREQUESTED));
			LOGGER.logDebug("Save Renovacion----->2");
			if (url.get("TRAMITE") != null && url.get("TRAMITE").equals("RENOVATION")) {

				LOGGER.logDebug("Save Renovacion----->3");
				HashMap<String, RenewLoanResponse> hmRenewLoanRequest = new HashMap<String, RenewLoanResponse>();

				// Recupero las operaciones del tramite para saber si se
				// actualiza o se inserta
				RenewLoanRequest renewDataRequest = new RenewLoanRequest();
				renewDataRequest.setNumRequest(idRequested);
				renewDataRequest.setDateFormat(SessionContext.getFormatDate());
				renewDataRequest.setCustomerId(-1);

				RenewLoanResponse[] readCustomerOperation = opMagnament.searchCustomerOperations(renewDataRequest, args, new BehaviorOption(false, false));

				if (readCustomerOperation != null) {
					for (RenewLoanResponse renewLoanResponse : readCustomerOperation) {
						hmRenewLoanRequest.put(renewLoanResponse.getNumOperation().trim(), renewLoanResponse);
					}
				}

				LOGGER.logDebug("Save Renovacion----->4");

				LOGGER.logDebug("Save Renovacion----->5");
				for (DataEntity operation : refinancingOperations) {
					LOGGER.logDebug("Save Renovacion----->6");
					String capitalize = operation.get(RefinancingOperations.CAPITALIZE) == true ? "S" : "N";
					if (hmRenewLoanRequest.containsKey(operation.get(RefinancingOperations.OPERATIONBANK).trim())) {
						LOGGER.logDebug("Save Renovacion----->7");
						revolvingManagment.updateRenew(operation, capitalize, idRequested, args, new BehaviorOption(false, false));
						LOGGER.logDebug("Save Renovacion----->8");
					} else {
						LOGGER.logDebug("Save Renovacion----->9");
						revolvingManagment.createRenew(operation, capitalize, idRequested, args, new BehaviorOption(false, false));
						LOGGER.logDebug("Save Renovacion----->10");
					}
				}
			}
		}

	}

	private void variableData(DynamicRequest entities, DataEntity originalHeader) {
		/* Datos Variables */

		VariableDataRequest variableDataRequest = new VariableDataRequest();
		DataEntityList variableDataEntities = new DataEntityList();
		variableDataEntities = entities.getEntityList(VariableData.ENTITY_NAME);
		entities.setEntityList(VariableData.ENTITY_NAME, variableDataEntities);
		for (DataEntity dataEntity : variableDataEntities) {

			if (!dataEntity.get(VariableData.VALUE).equals("")) {
				variableDataRequest.setCreditCode(Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED)));
				variableDataRequest.setOperationType(originalHeader.get(OriginalHeader.PRODUCTTYPE));
				variableDataRequest.setCobisProductMnemonic("CCA");
				variableDataRequest.setData(dataEntity.get(VariableData.IDFIELDVARIABLEDATA));
				variableDataRequest.setValue(dataEntity.get(VariableData.VALUE));

				ServiceRequestTO serviceRequestCreateVariableTO = new ServiceRequestTO();
				ServiceResponse serviceCreateVariableResponse = null;
				serviceRequestCreateVariableTO.addValue(RequestName.INVARIABLEDATAREQUEST, variableDataRequest);
				serviceCreateVariableResponse = execute(getServiceIntegration(), LOGGER, ServiceId.SERVICECREATEVARIABLEDATA, serviceRequestCreateVariableTO);

				if (serviceCreateVariableResponse.isResult()) {
					// args.getMessageManager().showSuccessMsg("SE GUARDO CON
					// EXITO");
				} else {
					// args.getMessageManager().showSuccessMsg("NO SE GUARDO");
				}
			}
		}
	}

	// Método para Guardar y Actualizar Solicitud
	private void saveAndUpdateData(DynamicRequest entities, String fieldSeven, String productType, IExecuteCommandEventArgs args) throws Exception {

		// Entidades Designer
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		DataEntity entidadInfo = entities.getEntity(EntidadInfo.ENTITY_NAME);
		DataEntity newAliquot = entities.getEntity(NewAliquot.ENTITY_NAME);
		DataEntityList debtors = entities.getEntityList(DebtorGeneral.ENTITY_NAME);
		DataEntity applicationInfoAux = entities.getEntity(ApplicationInfoAux.ENTITY_NAME);
		DataEntity context = entities.getEntity(Context.ENTITY_NAME);
		DataEntity aval = entities.getEntity(Aval.ENTITY_NAME);
		// Validar porcentaje de Garatía
		CatalogManagement catalogMngmnt = new CatalogManagement(super.getServiceIntegration());
		// ParameterResponse paramFrecuencyMonths = catalogMngmnt.getParameter("PFRMES",
		// Mnemonic.MODULE, args, new BehaviorOption(true));

		if ((applicationInfoAux.get(ApplicationInfoAux.PERCENTAGEGUARANTEE) == null) || (applicationInfoAux.get(ApplicationInfoAux.PERCENTAGEGUARANTEE) == 0)) {
			// ParameterResponse parameterResponseDTO = catalogMngmnt.getParameter("PORCGP",
			// Mnemonic.MODULECCA, args, new BehaviorOption(true));
			ParameterResponse parameterResponseDTO = catalogMngmnt.getParameter("PGARGR", Mnemonic.MODULECCA, args, new BehaviorOption(true));
			applicationInfoAux.set(ApplicationInfoAux.PERCENTAGEGUARANTEE, Double.parseDouble(parameterResponseDTO.getParameterValue()));
			LOGGER.logDebug("El Parametro nuevo Porcentaje es: " + applicationInfoAux.get(ApplicationInfoAux.PERCENTAGEGUARANTEE));
		}

		BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(getServiceIntegration());
		TransactionManagement transactionMngmnt = new TransactionManagement(super.getServiceIntegration());
		DebtorManagement debManagement = new DebtorManagement(super.getServiceIntegration());
		SystemConfigurationManagement systemConfigurationManagement = new SystemConfigurationManagement(getServiceIntegration());
		TransactionManagement transactionManagement = new TransactionManagement(super.getServiceIntegration());
		RuleExecutionManagement ruleExecutionManagement = new RuleExecutionManagement(super.getServiceIntegration());
		WorkflowManagement workflowManagement = new WorkflowManagement(getServiceIntegration());
		ApplicationRequest creditApplicationRequest = new ApplicationRequest();
		ApplicationNewRequest creditApplicationNewRequest = new ApplicationNewRequest();
		Integer idProcess = originalHeader.get(OriginalHeader.APPLICATIONNUMBER);
		LOGGER.logDebug("IDREQUESTED: " + originalHeader.get(OriginalHeader.IDREQUESTED));

		creditApplicationNewRequest.setIdRequested(0);

		LOGGER.logDebug("---->>>debtors.getDataList(): " + debtors.getDataList());

		DataEntity mainDebtor = DebtorUtil.getDebtorEntity(debtors, args, new BehaviorOption(true));
		if (mainDebtor == null) {
			args.setSuccess(false);
			return;
		}
		DebtorRequest debtorRequest = new DebtorRequest();
		debtorRequest.setDebtorCode(mainDebtor.get(DebtorGeneral.CUSTOMERCODE));

		// GUARDA LOS DEUDORES
		DebtorManagement debtorMngmnt = new DebtorManagement(super.getServiceIntegration());
		AddressManager addressManager = new AddressManager(super.getServiceIntegration());

		Calendar initalDateAux = Calendar.getInstance();
		Date initalDate = new Date();
		Calendar initalDateAux11 = Calendar.getInstance();

		initalDate = systemConfigurationManagement.getDate(SessionContext.getFormatDate(), args, new BehaviorOption(true));
		initalDateAux.setTime(initalDate);
		LOGGER.logDebug("--->saveAndUpdateData: Fecha initalDateAux11: " + initalDateAux11);
		LOGGER.logDebug("--->saveAndUpdateData: Fecha initalDateAux: " + initalDateAux);
		LOGGER.logDebug("--->saveAndUpdateData: Fecha initalDate: " + initalDate);
		LOGGER.logDebug("--->mainDebtor.get(DebtorGeneral.CUSTOMERNAME):" + mainDebtor.get(DebtorGeneral.CUSTOMERNAME));
		creditApplicationNewRequest.setOffice(Integer.parseInt(entidadInfo.get(EntidadInfo.OFICINA)));
		creditApplicationNewRequest.setMoney(Integer.parseInt(originalHeader.get(OriginalHeader.CURRENCYREQUESTED)));
		creditApplicationNewRequest.setDestination(entidadInfo.get(EntidadInfo.NUEVODESTINO));
		creditApplicationNewRequest.setName(mainDebtor.get(DebtorGeneral.CUSTOMERNAME));
		creditApplicationNewRequest.setStartDate(initalDateAux);
		creditApplicationNewRequest.setOpertationType(originalHeader.get(OriginalHeader.PRODUCTTYPE));
		creditApplicationNewRequest.setBanking(entidadInfo.get(EntidadInfo.BANCA));
		creditApplicationNewRequest.setClient(debtorRequest.getDebtorCode());// CODIGO DEL CLIENTE
		// Campos Nuevos **
		LOGGER.logDebug("---->Inicio Nuevos Campos<-----");
		creditApplicationNewRequest.setPromotion(applicationInfoAux.get(ApplicationInfoAux.ISPROMOTION));
		creditApplicationNewRequest.setGroupAgreesToRenew(applicationInfoAux.get(ApplicationInfoAux.GROUPACCEPTRENEW));
		creditApplicationNewRequest.setReasonForNotRenewing(applicationInfoAux.get(ApplicationInfoAux.REASONNOTACCEPTED));
		creditApplicationNewRequest.setEntrepreneurship(applicationInfoAux.get(ApplicationInfoAux.ISENTREPRENEURSHIP));
		creditApplicationNewRequest.setPercentageGuarantee(applicationInfoAux.get(ApplicationInfoAux.PERCENTAGEGUARANTEE));

		LOGGER.logDebug("---->Fin Nuevos Campos**:getPromotion<-----" + applicationInfoAux.get(ApplicationInfoAux.ISPROMOTION));
		LOGGER.logDebug("---->Fin Nuevos Campos**:getGroupAgreesToRenew<-----" + applicationInfoAux.get(ApplicationInfoAux.GROUPACCEPTRENEW));
		LOGGER.logDebug("---->Fin Nuevos Campos**:getReasonForNotRenewing<-----" + applicationInfoAux.get(ApplicationInfoAux.REASONNOTACCEPTED));
		LOGGER.logDebug("---->Fin Nuevos Campos**:getEntrepreneurship<-----" + applicationInfoAux.get(ApplicationInfoAux.ISENTREPRENEURSHIP));
		LOGGER.logDebug("---->Fin Nuevos Campos**:getPercentageGuarantee<-----" + applicationInfoAux.get(ApplicationInfoAux.PERCENTAGEGUARANTEE));
		LOGGER.logDebug("---->Fin Nuevos Campos**:IDEJECUTIVO<-----" + newAliquot.get(NewAliquot.IDEJECUTIVO) + "--");
		LOGGER.logDebug("---->Fin Nuevos Campos**:EJECUTIVO<-----" + newAliquot.get(NewAliquot.EJECUTIVO) + "--");

		if (newAliquot.get(NewAliquot.REFERENCIA) != null) {
			creditApplicationNewRequest.setComentary(newAliquot.get(NewAliquot.REFERENCIA));
		} else {
			newAliquot.set(NewAliquot.REFERENCIA, "");
		}

		if (newAliquot.get(NewAliquot.IDEJECUTIVO) != null) {
			creditApplicationNewRequest.setOfficer(Integer.parseInt(newAliquot.get(NewAliquot.IDEJECUTIVO)));
		} else {
			newAliquot.set(NewAliquot.IDEJECUTIVO, "");
			creditApplicationNewRequest.setOfficer(Integer.parseInt(newAliquot.get(NewAliquot.IDEJECUTIVO)));
		}
		if (newAliquot.get(NewAliquot.GRUPAL) != null) {
			creditApplicationNewRequest.setGroup(newAliquot.get(NewAliquot.GRUPAL));
		}

		if (entidadInfo.get(EntidadInfo.UBICACION) != null) {
			creditApplicationNewRequest.setCity(Integer.parseInt(entidadInfo.get(EntidadInfo.UBICACION)));
		}

		if (entidadInfo.get(EntidadInfo.GEOGRAPHICALDESTINATION) != null) {
			creditApplicationNewRequest.setCityDestination(Integer.parseInt(entidadInfo.get(EntidadInfo.GEOGRAPHICALDESTINATION)));
		}
		if (RENOVATION_MODE.equals(context.get(Context.TYPE))) {
			creditApplicationNewRequest.setType(RENOVATION_MODE);
		} else {
			creditApplicationNewRequest.setType("O");
		}

		// Recupero campos del Producto y seteo DTO
		List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(args, originalHeader.get(OriginalHeader.PRODUCTTYPE),
				"Pago de intereses");
		for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
			creditApplicationRequest.setPaymentType(generalParametersValuesHistory.getValue().charAt(0));
		}

		generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(args, originalHeader.get(OriginalHeader.PRODUCTTYPE), "Categoría");
		for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
			creditApplicationNewRequest.setSector(generalParametersValuesHistory.getValue());
			creditApplicationNewRequest.setPortafolioClass(generalParametersValuesHistory.getValue());
		}

		// Para los dos grupal e individual
		creditApplicationNewRequest.setPeriodCap(1);
		creditApplicationNewRequest.setPeriodInt(1);
		// Campos nuevos
		if (productType.equals(Constants.PRESTAMO_INDIVIDUAL)) {
			LOGGER.logDebug("------>>>AAA***-->>Plazo Ind");
			if (originalHeader.get(OriginalHeader.TERMIND) != null) {
				creditApplicationNewRequest.setTerm(Integer.parseInt(originalHeader.get(OriginalHeader.TERMIND)));
			}

			LOGGER.logDebug("FRECUENCIA>>" + originalHeader.get(OriginalHeader.FREQUENCY));
			creditApplicationNewRequest.setTermType(originalHeader.get(OriginalHeader.FREQUENCY));
			creditApplicationNewRequest.setTDividend(originalHeader.get(OriginalHeader.FREQUENCY));
			creditApplicationNewRequest.setAlliance(aval.get(Aval.IDCUSTOMER));
			LOGGER.logDebug("experiencia ind <<<<: " + applicationInfoAux.get(ApplicationInfoAux.CUSTOMEREXPERIENCE));
			creditApplicationNewRequest.setCustomerExperience('S');// Por defecto para flujo individual
		} else if (productType.equals(Constants.PRESTAMO_GRUPAL)) {
			LOGGER.logDebug("---> PRESTAMO_GRUPAL");
			LOGGER.logDebug("originalHeader.get(OriginalHeader.TERM):" + originalHeader.get(OriginalHeader.TERM));
			LOGGER.logDebug("originalHeader.get(OriginalHeader.DISPLACEMENT):" + originalHeader.get(OriginalHeader.DISPLACEMENT));
			creditApplicationNewRequest.setTerm(originalHeader.get(OriginalHeader.TERM) == null ? 0 : Integer.valueOf(originalHeader.get(OriginalHeader.TERM)));
			creditApplicationNewRequest
					.setDisplacement(originalHeader.get(OriginalHeader.DISPLACEMENT) == null ? 0 : Integer.valueOf(originalHeader.get(OriginalHeader.DISPLACEMENT)));
		}

		creditApplicationNewRequest.setAmountMaximunTr(originalHeader.get(OriginalHeader.MAXIMUMAMOUNT));
		// LOGGER.logDebug("experiencia gr <<<<:
		// "+applicationInfoAux.get(ApplicationInfoAux.CUSTOMEREXPERIENCE));
		// creditApplicationNewRequest.setCustomerExperience(applicationInfoAux.get(ApplicationInfoAux.CUSTOMEREXPERIENCE));

		int numeroTramite = 0;
		if (originalHeader.get(OriginalHeader.IDREQUESTED).equals("0")) {
			LOGGER.logDebug("originalHeader.get(OriginalHeader.AMOUNTAPROBED):" + originalHeader.get(OriginalHeader.AMOUNTAPROBED));
			LOGGER.logDebug("originalHeader.get(OriginalHeader.AMOUNTREQUESTED):" + originalHeader.get(OriginalHeader.AMOUNTREQUESTED));
			creditApplicationNewRequest.setApprovedAmount(originalHeader.get(OriginalHeader.AMOUNTAPROBED).doubleValue());
			creditApplicationNewRequest.setAmount(originalHeader.get(OriginalHeader.AMOUNTREQUESTED).doubleValue());

			LOGGER.logDebug("----->>>Sin tramite:---->> getAmount: " + creditApplicationNewRequest.getAmount());
			// Deudor Principal
			// creditApplicationNewRequest.setClient(debtorRequest.getDebtorCode());
			// Recupero el codeudor
			/*
			 * Se comenta por que se seta el solo codeudor for (DataEntity d : debtors) { if
			 * (d.get(DebtorGeneral.CUSTOMERCODE) !=
			 * creditApplicationNewRequest.getClient()) {
			 * creditApplicationNewRequest.setDebtorCode(d.get(DebtorGeneral.CUSTOMERCODE));
			 * } }
			 */
			creditApplicationNewRequest.setProcessInstance(originalHeader.get(OriginalHeader.APPLICATIONNUMBER));
			if (transactionMngmnt.saveApplication(creditApplicationNewRequest, args, new BehaviorOption(true))) {
				numeroTramite = transactionMngmnt.getApplicationCode();
				int numeroOperacion = transactionMngmnt.getOperationCode();
				if (numeroTramite > 0) {
					if (originalHeader.get(OriginalHeader.IDREQUESTED).equals("0")) {
						originalHeader.set(OriginalHeader.IDREQUESTED, String.valueOf(numeroTramite));
						creditApplicationNewRequest.setIdRequested(numeroTramite);
						originalHeader.set(OriginalHeader.OPERATIONNUMBER, numeroOperacion);
						creditApplicationNewRequest.setOperationCa(numeroOperacion);
					}
				} else {
					args.getMessageManager().showErrorMsg("Error al Generar el Trámite");
					return;
				}

				ApplicationResponse creditApplication = transactionManagement.getApplication(numeroTramite, args, new BehaviorOption(true));

				if (creditApplication != null) {
					String cycle = "";
					cycle = creditApplication.getCycleNumber();
					context.set(Context.FLAG1, cycle);
				}

				// Solo cuando es grupal - no se añaden los otros codeudores
				LOGGER.logDebug("----- Guarda codeudores si el tramite es grupal-fieldSeven:" + fieldSeven);

				// if (!fieldSeven.equals(ApplicationType.SOLIDARITY_GROUP)) {
				LOGGER.logDebug("----- Inicio guardado de deudores-tramite:" + numeroTramite);
				// LLmar a los deudores -- metodo que guardar deudores
				DebtorManagement debtorManagement = new DebtorManagement(getServiceIntegration());
				// Se modifica el sp para que no guarde en las temporales si no en las
				// definitivas
				// en la policia solo se guardaba el deudor y no codeudores
				if (!debtorManagement.saveAllDebtorsTmp(numeroTramite, entities, args, new BehaviorOption(true))) {
					args.getMessageManager().showErrorMsg("Error al Guardar los deudores");
					args.setSuccess(false);
					return;
				}
				LOGGER.logDebug("----- paso guardado de deudores");
				// }
				InstanceProcess processeInsnumber = new InstanceProcess();
				processeInsnumber.setIdInstProc(originalHeader.get(OriginalHeader.APPLICATIONNUMBER));
				processeInsnumber.setCampo3(numeroTramite);

				if (!transactionMngmnt.updateInstanceProcess(processeInsnumber, args, new BehaviorOption(true))) {
					args.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_UJERDOEAN_89022");
					args.setSuccess(false);
					return;
				}
				args.setSuccess(true);

				DataEntityList debtors1 = debManagement.getDebtorsEntityList(Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED)), args, new BehaviorOption(true));
				DataEntity debtor = DebtorUtil.getDebtorEntity(debtors1, args, new BehaviorOption(true));
				LOGGER.logError("--->> genericApplication - debtors1:" + debtors1);
				LOGGER.logError("--->> genericApplication - debtor:" + debtor);
				if (debtors1 == null || debtor == null) {
					// DLB_BUSIN_SAOUCENTD_07389 - No tiene registrado un cliente deudor.
					MessageManagement.show(args, new MessageOption("BUSIN.DLB_BUSIN_SAOUCENTD_07389", MessageLevel.ERROR, true));
					return;
				}
				entities.setEntityList(DebtorGeneral.ENTITY_NAME, debtors1);

				// LLAMA AL SERVICIO PARA CREAR REGISTRO EN LA TABLA
				// cob_credito..cr_tr_sincroniza PARA LA MOVIL
				LOGGER.logError("--->> Sincroniza movil para despues del GUARDAR");
				// Buscar si está sincronizado con el móvil
				SynchronizationManagement synchronizationManagement = new SynchronizationManagement(super.getServiceIntegration());
				if (context.get(Context.TASKSUBJECT).equals("INGRESAR SOLICITUD")) {
					LOGGER.logDebug("Ingresa a la sincronizacion>>> ");
					SynchronizationRequest synchronizationRequest = new SynchronizationRequest();
					synchronizationRequest.setApplicationNumber(numeroTramite); // nro de tramite
					synchronizationRequest.setNameActivity(context.get(Context.TASKSUBJECT)); // etapa del flujo
					LOGGER.logDebug("tramite sincronizacion>>> " + numeroTramite);
					LOGGER.logDebug("etapa sincronizacion>>> " + context.get(Context.TASKSUBJECT));
					SynchronizationResponse synchronizationResponse = synchronizationManagement.querySynchronizationActivity(synchronizationRequest, args,
							new BehaviorOption(true));
					if (synchronizationResponse != null) {
						LOGGER.logDebug("Devolvio consulta sincronizacion>>> " + synchronizationResponse.getSynchronization());
						if (synchronizationResponse.getSynchronization() != null) {
							if (synchronizationResponse.getSynchronization().equals("N")) {
								context.set(Context.SYNCHRONIZE, "N");
								context.set(Context.ENABLE, "N"); // bloquea boton
								LOGGER.logDebug("dos>>>");
							}
							if (synchronizationResponse.getSynchronization().equals("S")) {
								context.set(Context.SYNCHRONIZE, "S");
								context.set(Context.ENABLE, "N"); // bloquea boton
								LOGGER.logDebug("tres>>>>");
							}
						} else {
							context.set(Context.SYNCHRONIZE, null);
							context.set(Context.ENABLE, "S"); // habilita boton
							LOGGER.logDebug("uno>>>>");
						}
					} else {
						LOGGER.logDebug("Crea sincronizacion>>> ");
						synchronizationManagement.createSynchronizationActivity(synchronizationRequest, args, new BehaviorOption(true));
						context.set(Context.SYNCHRONIZE, null);
						context.set(Context.ENABLE, "S"); // habilita boton
					}

				}

				LOGGER.logDebug("Inicia UpdateFieldFive desde el guardar-processId:" + idProcess);
				ApplicationRequest applicationRequest = new ApplicationRequest();
				applicationRequest.setInstProcess(idProcess);
				workflowManagement.UpdateFieldFive(applicationRequest, args);

				// Consulta otra vez para traer el campo 5
				ProcessedNumber processedNumberAux = transactionMngmnt.getProcessedNumber(originalHeader.get(OriginalHeader.APPLICATIONNUMBER), args, new BehaviorOption(true));
				if (processedNumberAux != null) {
					if (processedNumberAux.getFieldFive() != null) {
						int previousCredit = processedNumberAux.getFieldFive(); // Monto de credito anterior
						LOGGER.logDebug("Tramite anterior:" + previousCredit);
						if (previousCredit > 0) {
							ApplicationResponse creditApplicationPrevious = transactionManagement.getApplication(previousCredit, args, new BehaviorOption(true));
							originalHeader.set(OriginalHeader.PREVIOUSCREDITAMOUNT, creditApplicationPrevious.getAmount());
						}
					}
				}

			} else {
				LOGGER.logError("Error en el servicio Businessprocess.Creditmanagement.ApplicationManagment.CreateApplication");
				args.setSuccess(false);
			}
		} else {
			LOGGER.logDebug("Pasa la actualizacion");
			String numBank = "";
			numeroTramite = Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED));
			creditApplicationNewRequest.setIdRequested(numeroTramite);

			ApplicationResponse creditApplication = transactionManagement.getApplication(Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED)), args,
					new BehaviorOption(true));
			if (creditApplication != null) {
				numBank = creditApplication.getOperationNumberBank();
			}
			if (fieldSeven.equals(ApplicationType.SOLIDARITY_GROUP)) {
				// Si da guardar otra vez sin salir de la pantalla de ingreso de datos
				if (creditApplication != null) {
					creditApplicationNewRequest.setApprovedAmount(creditApplication.getApprovedAmount().doubleValue());
					creditApplicationNewRequest.setAmount(creditApplication.getAmountRequested().doubleValue());
				}
			} else {
				LOGGER.logDebug("2... originalHeader.get(OriginalHeader.AMOUNTAPROBED):" + originalHeader.get(OriginalHeader.AMOUNTAPROBED));
				LOGGER.logDebug("2... originalHeader.get(OriginalHeader.AMOUNTREQUESTED):" + originalHeader.get(OriginalHeader.AMOUNTREQUESTED));
				creditApplicationNewRequest.setAmount(originalHeader.get(OriginalHeader.AMOUNTREQUESTED).doubleValue());
				creditApplicationNewRequest.setApprovedAmount(originalHeader.get(OriginalHeader.AMOUNTAPROBED).doubleValue());
			}

			creditApplicationNewRequest.setBank(numBank);
			// creditApplicationNewRequest.setOperationCa(numeroOperacion);
			// COPIA DE DEFINITIVAS A TEMPORALES
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Borra de temporales, numeroBbanco --->" + numBank);
			transactionMngmnt.deleteTmpTables(numBank, args, new BehaviorOption(true));
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Copia de definivas a temporales, numeroBbanco --->" + numBank);
			transactionMngmnt.copyFinalTablesToTmpTables(numBank, args, new BehaviorOption(true));

			LOGGER.logError("---->Llamo servicio para actualizar el tramite");
			if (!transactionMngmnt.updateApplicationWithoutPrints(creditApplicationNewRequest, args, new BehaviorOption(true))) {
				args.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_UJERDOEAN_89022");
				return;
			}

		}

		AddressRequest addressRequest = new AddressRequest();
		addressRequest.setOperation('Z');
		addressRequest.setType(productType.equals(Constants.PRESTAMO_INDIVIDUAL) ? 'I' : 'G');
		addressRequest.setCustomerId(context.get(Context.CUSTOMERID));
		addressManager.validateDuplicateAddress(addressRequest, args);

		if (!debtorMngmnt.saveAllDebtorsTmp(numeroTramite, entities, args, new BehaviorOption(true))) {
			args.setSuccess(false);
			return;
		}

		if (productType.equals(Constants.PRESTAMO_INDIVIDUAL)) {
			LOGGER.logDebug("-----Inicio regla de montos Maximos");
			RuleAmountMaxResponse ruleAmountMaxResponse = ruleExecutionManagement.readRuleAmounMax(numeroTramite, "MONTO_IND", args, new BehaviorOption(true));

			LOGGER.logDebug("-----Inicio regla de montos Maximos para encontrar el valor");
			RuleAmountMaxResponse ruleAmountMaxResponseResult = ruleExecutionManagement.readRuleAmounMax(numeroTramite, "VAL_MONTON_MAXIND", args, new BehaviorOption(true));

			String message = ruleExecutionManagement.readRuleAmounMaxMessage(numeroTramite, "VAL_TRAMITE", args, new BehaviorOption(true));

			LOGGER.logDebug("-----Inicio regla de montos Maximos-ruleAmountMaxResponse.getAmountMax():" + ruleAmountMaxResponseResult.getAmountMax());
			LOGGER.logDebug("-----message de la regla:" + message + "--");
			LOGGER.logDebug("-----ruleAmountMaxResponseResult.getAmountMax()e" + ruleAmountMaxResponseResult.getAmountMax());
			if (ruleAmountMaxResponseResult.getAmountMax() != null) {
				originalHeader.set(OriginalHeader.MAXIMUMAMOUNT, ruleAmountMaxResponseResult.getAmountMax());
			}
			LOGGER.logDebug("-----Inicio regla de montos Maximos" + originalHeader.get(OriginalHeader.MAXIMUMAMOUNT));

			if (message != null) {
				if (message.equals("No hay mensaje")) {
					LOGGER.logDebug("-----Ingresa cuando el mensaje es:No hay mensaje");
					message = "";
				}
				if (!message.trim().equals("")) {

					args.getMessageManager().showInfoMsg(message);
				}
			}
		}

		LOGGER.logDebug("---->Llamo metodo para guardar renovaciones");
		saveDataRenovation(entities, args);

		LOGGER.logDebug("----> Llamo al método para guardar items renderizados");
		saveDataRenderSection(entities, args);

		LOGGER.logDebug("---->Llamo servicio para  validar los deudores en las listas negras");

	}

}
