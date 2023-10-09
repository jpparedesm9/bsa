package com.cobiscorp.cobis.busin.customevents.form;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.busin.customevents.utils.Constants;
import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.AccounManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.CustomerManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.DebtorManagement;
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
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.SearchAddressesByCustomer;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.Property;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.AddressManager;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;

import cobiscorp.ecobis.account.dto.CustomerRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DebtorRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RuleAmountMaxResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SynchronizationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SynchronizationResponse;
import cobiscorp.ecobis.businessprocess.loanrequest.dto.ProcessedNumber;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;
import cobiscorp.ecobis.workflow.dto.InstanceProcess;

public class SaveLCR extends BaseEvent implements IExecuteCommand {
	private static ILogger LOGGER = LogFactory.getLogger(SaveLCR.class);

	public SaveLCR(ICTSServiceIntegration serviceIntegration) {
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

			/*
			 * if (!transactionMngmnt.validateOriginalApplication(entities, args)) {
			 * args.setSuccess(false); return; }
			 */

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
			LOGGER.logDebug("---->***ExecuteCommandCM_OIIRL51SVE80 - B");
			// Flujo Solicitud de Credito Grupal
			saveAndUpdateData(entities, fieldSeven, productType, args);
		} catch (Exception ex) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_GUARDAR, ex, args, LOGGER);
		}

	}

	// Método para Guardar y Actualizar Solicitud
	private void saveAndUpdateData(DynamicRequest entities, String fieldSeven, String productType, IExecuteCommandEventArgs args) throws Exception {

		// Entidades Designer
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		DataEntity entidadInfo = entities.getEntity(EntidadInfo.ENTITY_NAME);
		DataEntity newAliquot = entities.getEntity(NewAliquot.ENTITY_NAME);
		DataEntityList debtors = entities.getEntityList(DebtorGeneral.ENTITY_NAME);
		DataEntity context = entities.getEntity(Context.ENTITY_NAME);
		DataEntity applicationInfoAux = entities.getEntity(ApplicationInfoAux.ENTITY_NAME);
		// Validar porcentaje de Garatía
		CatalogManagement catalogMngmnt = new CatalogManagement(super.getServiceIntegration());
		ParameterResponse paramFrecuencyMonths = catalogMngmnt.getParameter("PFRMES", Mnemonic.MODULE, args, new BehaviorOption(true));

		BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(getServiceIntegration());
		TransactionManagement transactionMngmnt = new TransactionManagement(super.getServiceIntegration());
		DebtorManagement debManagement = new DebtorManagement(super.getServiceIntegration());
		SystemConfigurationManagement systemConfigurationManagement = new SystemConfigurationManagement(getServiceIntegration());
		TransactionManagement transactionManagement = new TransactionManagement(super.getServiceIntegration());
		RuleExecutionManagement ruleExecutionManagement = new RuleExecutionManagement(super.getServiceIntegration());
		WorkflowManagement workflowManagement = new WorkflowManagement(getServiceIntegration());
		AddressManager addressManager = new AddressManager(super.getServiceIntegration());
		Integer idProcess = originalHeader.get(OriginalHeader.APPLICATIONNUMBER);
		CustomerManagement customerMngmnt = new CustomerManagement(super.getServiceIntegration());
		LOGGER.logDebug("IDREQUESTED: " + originalHeader.get(OriginalHeader.IDREQUESTED));
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

		Calendar initalDateAux = Calendar.getInstance();
		Date initalDate = new Date();

		initalDate = systemConfigurationManagement.getDate(SessionContext.getFormatDate(), args, new BehaviorOption(true));
		initalDateAux.setTime(initalDate);
		LOGGER.logDebug("--->saveAndUpdateData: Fecha initalDateAux: " + initalDateAux);
		LOGGER.logDebug("--->saveAndUpdateData: Fecha initalDate: " + initalDate);

		// Recupero campos del Producto y seteo DTO

		int numeroTramite = 0;
		if (originalHeader.get(OriginalHeader.IDREQUESTED).equals("0")) {
			LOGGER.logDebug("El parametro esta vacio");
			ApplicationRequest application = new ApplicationRequest();
			application.setType("O");
			application.setOffice(originalHeader.get(OriginalHeader.OFFICE));
			application.setCreationDate(initalDateAux);

			if (newAliquot.get(NewAliquot.IDEJECUTIVO) != null) {
				application.setOfficer(Integer.parseInt(newAliquot.get(NewAliquot.IDEJECUTIVO)));
			} else {
				newAliquot.set(NewAliquot.IDEJECUTIVO, "");
				application.setOfficer(Integer.parseInt(newAliquot.get(NewAliquot.IDEJECUTIVO)));
			}

			List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(args, originalHeader.get(OriginalHeader.PRODUCTTYPE),
					"Pago de intereses");
			generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(args, originalHeader.get(OriginalHeader.PRODUCTTYPE), "Categoría");
			for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
				application.setSector(generalParametersValuesHistory.getValue());
				application.setPortfolioType(generalParametersValuesHistory.getValue());
				application.setSectorCustomer(generalParametersValuesHistory.getValue());
			}
			if (generalParameterCatalog.isEmpty()) {
				LOGGER.logDebug("El parametro esta vacio");
				application.setSector("S");
				application.setPortfolioType("F");
				application.setSectorCustomer("S");
			}
			for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
				application.setPaymentType(generalParametersValuesHistory.getValue().charAt(0));
			}

			if (entidadInfo.get(EntidadInfo.UBICACION) != null) {
				application.setCity(Integer.parseInt(entidadInfo.get(EntidadInfo.UBICACION)));
			}
			application.setOperationNumberBank(entidadInfo.get(EntidadInfo.BANCA));
			application.setPaymentFrequency(originalHeader.get(OriginalHeader.FREQUENCYREVOLVING));
			application.setAmountRequested(originalHeader.get(OriginalHeader.AMOUNTREQUESTED).doubleValue());
			if (originalHeader.get(OriginalHeader.TERMIND) != null) {
				application.setTerm(Integer.parseInt(originalHeader.get(OriginalHeader.TERMIND)));
			}
			application.setDetailTerm(paramFrecuencyMonths.getParameterValue());
			application.setClient(debtorRequest.getDebtorCode());
			application.setStartDate(initalDateAux);
			application.setOpertationType(originalHeader.get(OriginalHeader.PRODUCTTYPE));
			application.setProduct(productType);
			application.setAmount(originalHeader.get(OriginalHeader.AMOUNTREQUESTED).doubleValue());
			application.setMoney(Integer.parseInt(originalHeader.get(OriginalHeader.CURRENCYREQUESTED)));
			application.setDestination(entidadInfo.get(EntidadInfo.NUEVODESTINO));
			application.setCityDestination(Integer.parseInt(entidadInfo.get(EntidadInfo.GEOGRAPHICALDESTINATION)));
			application.setRevolving('S');
			application.setInstProcess(idProcess);
			application.setDestinationDescription(entidadInfo.get(EntidadInfo.NUEVODESTINO));
			application.setActivityDestination(entidadInfo.get(EntidadInfo.NUEVODESTINO));
			application.setTermType(originalHeader.get(OriginalHeader.FREQUENCYREVOLVING));

			/* Información del cliente */
			CustomerTotalRequest customerTotalRequest = new CustomerTotalRequest();
			customerTotalRequest.setCodePerson(debtorRequest.getDebtorCode());
			customerTotalRequest.setCollectiveLevel(applicationInfoAux.get(ApplicationInfoAux.NIVELCOLECTIVO));
			customerTotalRequest.setOtherIncome(applicationInfoAux.get(ApplicationInfoAux.INGRESOSMENSUALES));

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Nivel colectivo: " + applicationInfoAux.get(ApplicationInfoAux.NIVELCOLECTIVO));
				LOGGER.logDebug("Ingresos Mensuales: " + applicationInfoAux.get(ApplicationInfoAux.INGRESOSMENSUALES).toString());
			}

			/* Información sin llenar */
			application.setCreditLine2(null);
			application.setOperationRestructure(null);
			application.setFoundsSource(null);
			application.setCurrentAccount(null);

			DebtorRequest debtorR = new DebtorRequest();
			debtorR.setDebtorCode(application.getClient());
			String codeApplication = transactionMngmnt.createApplicationTramite(application, debtorR, args, new BehaviorOption(true));
			customerMngmnt.updateCustomer(customerTotalRequest);
			if (codeApplication != null) {
				numeroTramite = Integer.parseInt(codeApplication);
				if (numeroTramite > 0) {
					if (originalHeader.get(OriginalHeader.IDREQUESTED).equals("0")) {
						originalHeader.set(OriginalHeader.IDREQUESTED, String.valueOf(numeroTramite));
						application.setIdrequested(numeroTramite);
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

				AddressRequest addressRequest = new AddressRequest();
				addressRequest.setOperation('Z');
				addressRequest.setType(productType.equals(Constants.PRESTAMO_INDIVIDUAL) ? 'I' : 'G');
				addressRequest.setCustomerId(context.get(Context.CUSTOMERID));
				addressManager.validateDuplicateAddress(addressRequest, args);

				// Solo cuando es grupal - no se añaden los otros codeudores
				LOGGER.logDebug("----- Guarda codeudores si el tramite es grupal-fieldSeven:" + fieldSeven);

				// if (!fieldSeven.equals(ApplicationType.SOLIDARITY_GROUP)) {
				LOGGER.logDebug("----- Inicio guardado de deudores-tramite:" + numeroTramite);
				// LLmar a los deudores -- metodo que guardar deudores
				DebtorManagement debtorManagement = new DebtorManagement(getServiceIntegration());
				// Se modifica el sp para que no guarde en las temporales si no
				// en las definitivas
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
					// DLB_BUSIN_SAOUCENTD_07389 - No tiene registrado un
					// cliente deudor.
					MessageManagement.show(args, new MessageOption("BUSIN.DLB_BUSIN_SAOUCENTD_07389", MessageLevel.ERROR, true));
					return;
				}
				// entities.setEntityList(DebtorGeneral.ENTITY_NAME, debtors1);

				// LLAMA AL SERVICIO PARA CREAR REGISTRO EN LA TABLA
				// cob_credito..cr_tr_sincroniza PARA LA MOVIL
				LOGGER.logError("--->> Sincroniza movil para despues del GUARDAR");
				// Buscar si está sincronizado con el móvil
				SynchronizationManagement synchronizationManagement = new SynchronizationManagement(super.getServiceIntegration());
				if (context.get(Context.TASKSUBJECT).equals("INGRESAR SOLICITUD")) {
					LOGGER.logDebug("Ingresa a la sincronizacion>>> ");
					SynchronizationRequest synchronizationRequest = new SynchronizationRequest();
					synchronizationRequest.setApplicationNumber(numeroTramite); // nro
																				// de
																				// tramite
					synchronizationRequest.setNameActivity(context.get(Context.TASKSUBJECT)); // etapa
																								// del
																								// flujo
					LOGGER.logDebug("tramite sincronizacion>>> " + numeroTramite);
					LOGGER.logDebug("etapa sincronizacion>>> " + context.get(Context.TASKSUBJECT));
					SynchronizationResponse synchronizationResponse = synchronizationManagement.querySynchronizationActivity(synchronizationRequest, args,
							new BehaviorOption(true));
					if (synchronizationResponse != null) {
						LOGGER.logDebug("Devolvio consulta sincronizacion>>> " + synchronizationResponse.getSynchronization());
						if (synchronizationResponse.getSynchronization() != null) {
							if (synchronizationResponse.getSynchronization().equals("N")) {
								context.set(Context.SYNCHRONIZE, "N");
								context.set(Context.ENABLE, "N"); // bloquea
																	// boton
								LOGGER.logDebug("dos>>>");
							}
							if (synchronizationResponse.getSynchronization().equals("S")) {
								context.set(Context.SYNCHRONIZE, "S");
								context.set(Context.ENABLE, "N"); // bloquea
																	// boton
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
						int previousCredit = processedNumberAux.getFieldFive(); // Monto
																				// de
																				// credito
																				// anterior
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
			try {
				LOGGER.logDebug("Ingresa a actualizar");
				ApplicationRequest application = new ApplicationRequest();
				CustomerTotalRequest customerTotalRequest = new CustomerTotalRequest();
				LOGGER.logDebug("rastro 1");
				application.setIdrequested(Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED)));
				application.setClient(debtorRequest.getDebtorCode());
				LOGGER.logDebug("rastro 2 ");

				customerTotalRequest.setCodePerson(debtorRequest.getDebtorCode());
				LOGGER.logDebug("Codeperson " + debtorRequest.getDebtorCode().toString());
				LOGGER.logDebug("Nivel " + applicationInfoAux.get(ApplicationInfoAux.NIVELCOLECTIVO));
				LOGGER.logDebug("Ingresos " + applicationInfoAux.get(ApplicationInfoAux.INGRESOSMENSUALES));

				customerTotalRequest.setCollectiveLevel(applicationInfoAux.get(ApplicationInfoAux.NIVELCOLECTIVO));
				// LOGGER.logDebug("Nivel "+customerTotalRequest.getNivelColectivo());
				customerTotalRequest.setOtherIncome(applicationInfoAux.get(ApplicationInfoAux.INGRESOSMENSUALES));
				// LOGGER.logDebug("rastro 3 "+customerTotalRequest.getOtherIncome());

				LOGGER.logDebug("Devuelve frecuencia" + application.getTermType());
				application.setTermType(originalHeader.get(OriginalHeader.FREQUENCYREVOLVING));
				transactionMngmnt.saveApplicationTramite(application, args, new BehaviorOption(true));
				customerMngmnt.updateCustomer(customerTotalRequest);
			} catch (Exception e) {
				LOGGER.logError("Error " + e.toString());
				args.setSuccess(false);
				args.getMessageManager().showInfoMsg("Error al actualizar trámite");
			}

		}
		if (!debtorMngmnt.saveAllDebtorsTmp(numeroTramite, entities, args, new BehaviorOption(true))) {
			args.setSuccess(false);
			return;
		}

		if (productType.equals(Constants.PRESTAMO_INDIVIDUAL)) {
			LOGGER.logDebug("-----Inicio regla de montos Maximos");
			RuleAmountMaxResponse ruleAmountMaxResponse = ruleExecutionManagement.readRuleAmounMax(numeroTramite, "MONTO_IND", args, new BehaviorOption(true));
			String message = ruleExecutionManagement.readRuleAmounMaxMessage(numeroTramite, "VAL_TRAMITE", args, new BehaviorOption(true));
			LOGGER.logDebug("-----Inicio regla de montos Maximos-ruleAmountMaxResponse.getAmountMax():" + ruleAmountMaxResponse.getAmountMax());
			LOGGER.logDebug("-----message de la regla:" + message + "--");

			if (ruleAmountMaxResponse.getAmountMax() != null) {
				originalHeader.set(OriginalHeader.MAXIMUMAMOUNT, ruleAmountMaxResponse.getAmountMax());
			}
			LOGGER.logDebug("-----Inicio regla de montos Maximos" + originalHeader.get(OriginalHeader.MAXIMUMAMOUNT));

			if (message != null) {
				if (!message.trim().equals("")) {
					args.getMessageManager().showInfoMsg(message);
				}
			}
		}

	}

	public void setValidateReference(DynamicRequest entities, IExecuteCommandEventArgs args) {

		SearchAddressesByCustomer searchAddresses = new SearchAddressesByCustomer(getServiceIntegration());
		searchAddresses.searchAddressesByCustomer(entities, args);

	}
}
