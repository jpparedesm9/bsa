package com.cobiscorp.cobis.busin.customevents.form;

import java.math.BigDecimal;
import java.util.List;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SynchronizationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SynchronizationResponse;
import cobiscorp.ecobis.businessprocess.loanrequest.dto.ProcessedNumber;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.loangroup.dto.GroupRequest;
import cobiscorp.ecobis.loangroup.dto.GroupResponse;
import cobiscorp.ecobis.loansbusiness.dto.ClientInsuranceResponse;
import cobiscorp.ecobis.loansbusiness.dto.InsuranceRequest;
import cobiscorp.ecobis.systemconfiguration.dto.OfficerResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.busin.customevents.utils.Constants;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ApplicationType;
import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.CustomerManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.DebtorManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.GroupManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryBureau;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.SynchronizationManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.ApplicationInfoAux;
import com.cobiscorp.cobis.busin.model.Aval;
import com.cobiscorp.cobis.busin.model.Context;
import com.cobiscorp.cobis.busin.model.DebtorGeneral;
import com.cobiscorp.cobis.busin.model.EntidadInfo;
import com.cobiscorp.cobis.busin.model.GeneralData;
import com.cobiscorp.cobis.busin.model.NewAliquot;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.Property;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.api.util.ServerParamUtil;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.business.commons.platform.services.InsuranceManager;
import com.cobiscorp.ecobis.business.commons.platform.services.OfficerManagement;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.BuroExecutionResponse;
import com.cobiscorp.ecobis.fpm.bo.Sector;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;

public class InitDataOriginalApplication extends BaseEvent implements IInitDataEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(InitDataOriginalApplication.class);

	public InitDataOriginalApplication(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
		LOGGER.logDebug("---->Entra al InitDataOriginalApplication");

		try {

			LOGGER.logDebug("---->Recueracion de entidades de front end");
			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
			DataEntity entidadInfo = entities.getEntity(EntidadInfo.ENTITY_NAME);
			DataEntity generalData = entities.getEntity("generalData");
			DataEntity newAliquot = entities.getEntity(NewAliquot.ENTITY_NAME);
			DataEntity context = entities.getEntity(Context.ENTITY_NAME);
			DataEntity applicationInfoAux = entities.getEntity(ApplicationInfoAux.ENTITY_NAME);
			BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(getServiceIntegration());
			QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());
			CatalogManagement catalogMngmnt = new CatalogManagement(super.getServiceIntegration());
			DebtorManagement debManagement = new DebtorManagement(super.getServiceIntegration());
			GroupManagement groupManagement = new GroupManagement(super.getServiceIntegration());
			InsuranceManager insuranceManager = new InsuranceManager(getServiceIntegration());
			SynchronizationManagement synchronizationManagement = new SynchronizationManagement(super.getServiceIntegration());
			QueryBureau queryBureau = new QueryBureau(super.getServiceIntegration());

			DataEntity aval = entities.getEntity(Aval.ENTITY_NAME);
			int applicationNumber = originalHeader.get(OriginalHeader.APPLICATIONNUMBER) == null ? 0 : originalHeader.get(OriginalHeader.APPLICATIONNUMBER);
			String cycle = "";
			String productType = originalHeader.get(OriginalHeader.PRODUCTTYPE);
			CustomerRequest customerRequest = new CustomerRequest();
			// entities.Context.CustomerId
			LOGGER.logDebug("---->Recupera el numero del tramite");
			TransactionManagement transactionManagement = new TransactionManagement(super.getServiceIntegration());
			ProcessedNumber processedNumber = transactionManagement.getProcessedNumber(applicationNumber, arg1, new BehaviorOption(true));
			if (processedNumber == null) {
				MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_NMRREEUID_75532", MessageLevel.ERROR, true));
				return;
			}

			int codigoTramite = processedNumber.getTramite();

			LOGGER.logError("---->A continuacion Monto de credito anterior");
			if (processedNumber.getFieldFive() != null) {
				int previousCredit = processedNumber.getFieldFive(); // Monto de credito anterior
				if (previousCredit > 0) {
					ApplicationResponse creditApplicationPrevious = transactionManagement.getApplication(previousCredit, arg1, new BehaviorOption(true));
					originalHeader.set(OriginalHeader.PREVIOUSCREDITAMOUNT, creditApplicationPrevious.getAmount());
				}
			}

			LOGGER.logDebug("---->Recupera el Campo 7 Para identificar si es grupal:--" + processedNumber.getFieldSeven() + "--");
			String fieldSeven = "";
			if (processedNumber.getFieldSeven() != null) {
				fieldSeven = processedNumber.getFieldSeven().trim();
			}
			context.set(Context.FIELDSEVEN, fieldSeven);
			LOGGER.logDebug("---->Paso del campo 7");
			int idCustomer = context.get(Context.CUSTOMERID);
			originalHeader.set(OriginalHeader.IDREQUESTED, codigoTramite + "");
			LOGGER.logDebug("---->codigoTramite" + codigoTramite);
			LOGGER.logDebug("---->Initdata de la renovacion");
			RenovationProcess.initDataRenovation(entities, arg1, super.getServiceIntegration());
			LOGGER.logDebug("---->Paso del initDataRenovation");
			LOGGER.logDebug("---->Recupera el subtipo del producto para habilitar o deshabilar campo Grupal");
			ParameterResponse parameterResponseDTO = catalogMngmnt.getParameter("CSMIC", Mnemonic.MODULECCA, arg1, new BehaviorOption(true));
			// ParameterResponse paramFrecuencyMonths = catalogMngmnt.getParameter("PFRMES",
			// Mnemonic.MODULE, arg1, new BehaviorOption(true));
			generalData.set(new Property<String>("subtypeProductId", String.class, false), parameterResponseDTO.getParameterValue());

			LOGGER.logDebug("---->Si el coddigo del tramite es diferente de cero recupera la informacion asociada al tramite");

			if (fieldSeven.equals(ApplicationType.SOLIDARITY_GROUP)) {
				// Para el clico del grupo
				GroupRequest groupRequest = new GroupRequest();
				groupRequest.setCode(idCustomer);
				GroupResponse groupResponse = groupManagement.searchGroup(groupRequest, arg1);
				if (groupResponse != null) {
					cycle = groupResponse.getCycleNumber();
				}
				context.set(Context.FLAG1, cycle);
			}

			if (Constants.PRESTAMO_INDIVIDUAL.equals(productType)) {
				customerRequest.setCustomerId(idCustomer);
				customerRequest.setModo(2);
				CustomerResponse customerResponse = transactionManagement.readDataCustomer(customerRequest, arg1, new BehaviorOption(true));
				/*
				 * LOGGER.logDebug("--->>customerResponse.getCicleNumberEn():" +
				 * customerResponse.getCicleNumberEn()); context.set(Context.FLAG1,
				 * String.valueOf(customerResponse.getCicleNumberEn()));
				 */
				applicationInfoAux.set(ApplicationInfoAux.ISPARTNER, customerResponse.getPartner());
				LOGGER.logDebug("--->>customerResponse.getPartner():" + customerResponse.getPartner());
				originalHeader.set(OriginalHeader.BCBLACKLISTSCLIENT, customerResponse.getListBlack());
				LOGGER.logDebug("--->>customerResponse.getListBlack():" + customerResponse.getListBlack());
			}

			if (!Constants.PRESTAMO_INDIVIDUAL.equals(productType)) {
				List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1,
						originalHeader.get(OriginalHeader.PRODUCTTYPE), "Tipo de cuota");
				for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
					LOGGER.logDebug("Valor --->" + generalParametersValuesHistory.getDescription());
					originalHeader.set(OriginalHeader.PAYMENTFREQUENCY, generalParametersValuesHistory.getDescription());
					generalData.set(GeneralData.PAYMENTFRECUENCYNAME, generalParametersValuesHistory.getDescription());
				}

			}

			if (codigoTramite != 0) {
				LOGGER.logDebug("----------- Original Data Actualizacion");
				LOGGER.logDebug("---->Recupera los deudores en base al tramite");
				LOGGER.logDebug("Etapa >>>> " + context.get(Context.TASKSUBJECT));
				// Buscar si está sincronizado con el móvil
				if (context.get(Context.TASKSUBJECT).equals("INGRESAR SOLICITUD")) {
					LOGGER.logDebug("Ingresa a la sincronizacion>>> ");
					SynchronizationRequest synchronizationRequest = new SynchronizationRequest();
					synchronizationRequest.setApplicationNumber(context.get(Context.REQUESTID)); // nro de tramite
					synchronizationRequest.setNameActivity(context.get(Context.TASKSUBJECT)); // etapa del flujo
					LOGGER.logDebug("tramite sincronizacion>>> " + context.get(Context.REQUESTID));
					LOGGER.logDebug("etapa sincronizacion>>> " + context.get(Context.TASKSUBJECT));
					SynchronizationResponse synchronizationResponse = synchronizationManagement.querySynchronizationActivity(synchronizationRequest, arg1,
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
						synchronizationManagement.createSynchronizationActivity(synchronizationRequest, arg1, new BehaviorOption(true));
						context.set(Context.SYNCHRONIZE, null);
						context.set(Context.ENABLE, "S"); // habilita boton
					}

				}

				DataEntityList debtors = debManagement.getDebtorsEntityList(codigoTramite, arg1, new BehaviorOption(true));
				if (debtors != null) {
					LOGGER.logDebug("Entra a deudores");
					entities.setEntityList(DebtorGeneral.ENTITY_NAME, debtors);
				} else {
					// No tiene registrado un cliente deudor = DLB_BUSIN_SAOUCENTD_07389
					MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_SAOUCENTD_07389", MessageLevel.ERROR, true));
					return;
				}

				// consulta a buro de credito
				if ((Constants.PRESTAMO_INDIVIDUAL.equals(productType)) || (Constants.PRESTAMO_REVOLVENTE.equals(productType))) {
					setRiskLevelDebtor(entities);
				}

				LOGGER.logDebug("---->Recupera los datos del tramite");
				ApplicationResponse creditApplication = transactionManagement.getApplication(codigoTramite, arg1, new BehaviorOption(true));

				if (creditApplication != null) {
					LOGGER.logDebug("Entra a success en data de tramite");
					LOGGER.logDebug("---->Nuevos Campos<-----");
					LOGGER.logDebug("---->Informacion General");
					// Recupero el numero de operacion
					if (creditApplication.getOperationNumber() != null) {
						originalHeader.set(OriginalHeader.OPERATIONNUMBER, creditApplication.getOperationNumber());
					}
					LOGGER.logDebug("--->>Muestra productType:" + productType);
					if (Constants.PRESTAMO_REVOLVENTE.equals(productType)) {
						originalHeader.set(OriginalHeader.FREQUENCYREVOLVING, creditApplication.getPeriodShare());
						LOGGER.logDebug("--->>customerResponse.getPeriodShare():" + creditApplication.getPeriodShare());
					}

					// EntidadInfo
					if (creditApplication.getOffice() != null) {
						entidadInfo.set(EntidadInfo.OFICINA, String.valueOf(creditApplication.getOffice()));
					}
					LOGGER.logDebug("---->Oficina TramiteDesc: " + creditApplication.getOfficeDescriptionTr());
					context.set(Context.OFFICENAME, creditApplication.getOfficeDescriptionTr());

					entidadInfo.set(EntidadInfo.TIPOPRODUCTO, creditApplication.getOpertationType());

					if (creditApplication.getCity() != null) {
						entidadInfo.set(EntidadInfo.UBICACION, creditApplication.getCity().toString());
					}
					if (creditApplication.getCityDestination() != null) {
						entidadInfo.set(EntidadInfo.GEOGRAPHICALDESTINATION, creditApplication.getCityDestination().toString());
					}
					entidadInfo.set(EntidadInfo.NUEVODESTINO, creditApplication.getDestination().trim());
					LOGGER.logDebug("---->Informacion General-*creditApplication.getBanking():" + creditApplication.getBanking());
					entidadInfo.set(EntidadInfo.BANCA, creditApplication.getBanking().trim());

					// OriginalHeader
					LOGGER.logDebug("1... originalHeader.get(OriginalHeader.AMOUNTAPROBED):" + originalHeader.get(OriginalHeader.AMOUNTAPROBED));
					LOGGER.logDebug("1... originalHeader.get(OriginalHeader.AMOUNTREQUESTED):" + originalHeader.get(OriginalHeader.AMOUNTREQUESTED));
					originalHeader.set(OriginalHeader.CURRENCYREQUESTED, creditApplication.getCurrencyRequested().toString());
					originalHeader.set(OriginalHeader.AMOUNTAPROBED, creditApplication.getApprovedAmount());

					LOGGER.logDebug("creditApplication.getTerm():" + creditApplication.getTerm());
					LOGGER.logDebug("creditApplication.getDisplacement():" + creditApplication.getDisplacement());
					originalHeader.set(OriginalHeader.TERM, String.valueOf(creditApplication.getTerm()));
					originalHeader.set(OriginalHeader.DISPLACEMENT, creditApplication.getDisplacement() == null ? "0" : String.valueOf(creditApplication.getDisplacement()));

					if (productType.equals(Constants.PRESTAMO_INDIVIDUAL)) {
						generalData.set(GeneralData.PAYMENTFRECUENCYNAME, creditApplication.getTermTypeDescrip());
						// Ciclo individual
						LOGGER.logDebug("--->>creditApplication.getCycleNumber():" + creditApplication.getCycleNumber());
						context.set(Context.FLAG1, String.valueOf(creditApplication.getCycleNumber()));
						LOGGER.logDebug("--->>creditApplication.getIsPartner():" + creditApplication.getIsPartner());
						applicationInfoAux.set(ApplicationInfoAux.ISPARTNER, creditApplication.getIsPartner());
						LOGGER.logDebug("GetInsurance of client " + idCustomer + "- " + codigoTramite);
						// SRO. 185234 - Tipo de Seguro cliente individual
						InsuranceRequest insuranceRequest = new InsuranceRequest();
						insuranceRequest.setSeCliente(String.valueOf(idCustomer));
						insuranceRequest.setSeTramite(codigoTramite);
						ClientInsuranceResponse clientInsuranceResponse = insuranceManager.getClientInsurance(getServiceIntegration(), arg1, insuranceRequest);
						entidadInfo.set(EntidadInfo.INSURANCEPACKAGE, clientInsuranceResponse == null ? "" : clientInsuranceResponse.getSeTipoSeguro());
						entidadInfo.set(EntidadInfo.TERMMEDICALASSISTANCE, clientInsuranceResponse == null ? null : clientInsuranceResponse.getSePlazoAsisMed());
					}
					// Pantalla de Aval
					int avalId = creditApplication.getAlliance();
					LOGGER.logDebug("---->Entra al InitdataOriginalApplication - avalId:" + avalId + "--");
					if (avalId > 0) {
						customerRequest.setCustomerId(avalId);
						customerRequest.setModo(0);

						CustomerResponse customerResponse = transactionManagement.readDataCustomer(customerRequest, arg1, new BehaviorOption(true));

						if (customerResponse != null) {
							LOGGER.logDebug("---->Entra al InitdataOriginalApplication - getCustomerRFC:" + customerResponse.getCustomerRFC());

							String nameAval = "";
							if (customerResponse.getCustomerLastName() != null) {
								nameAval = customerResponse.getCustomerLastName() + " ";
							}

							if (customerResponse.getCustomerSecondLastName() != null) {
								nameAval = nameAval + customerResponse.getCustomerSecondLastName() + " ";
							}

							if (customerResponse.getCustomerName() != null) {
								nameAval = nameAval + customerResponse.getCustomerName() + " ";
							}

							if (customerResponse.getCustomerSecondName() != null) {
								nameAval = nameAval + customerResponse.getCustomerSecondName() + " ";
							}

							aval.set(Aval.CUSTOMERNAME, avalId + " - " + nameAval);
							aval.set(Aval.IDCUSTOMER, avalId);
							aval.set(Aval.RFC, customerResponse.getCustomerRFC());
							ExecuteQueryBureauAval bureauAval = new ExecuteQueryBureauAval(getServiceIntegration());
							bureauAval.mapBuro(entities, avalId);
						}
					}
					// Fin Pantalla de Aval
					// Se requiere que se vea la suma de los montos de la tr_tramite_grupal solo
					// cuando es grupal
					if (fieldSeven.equals(ApplicationType.SOLIDARITY_GROUP)) {
						if (creditApplication.getSumRequestedAmountGroup() != null && creditApplication.getSumAmountGroup() != null) {
							if (BigDecimal.ZERO.equals(BigDecimal.valueOf(creditApplication.getSumRequestedAmountGroup().doubleValue()))
									&& BigDecimal.ZERO.equals(BigDecimal.valueOf(creditApplication.getSumAmountGroup().doubleValue()))) {
								originalHeader.set(OriginalHeader.AMOUNTREQUESTED, creditApplication.getAmountRequested());
							} else {
								originalHeader.set(OriginalHeader.AMOUNTREQUESTED, creditApplication.getSumRequestedAmountGroup());
							}
						} else {
							originalHeader.set(OriginalHeader.AMOUNTREQUESTED, creditApplication.getAmountRequested());
						}
					} else {
						originalHeader.set(OriginalHeader.AMOUNTREQUESTED, creditApplication.getAmountRequested());
					}

					// prueba*
					LOGGER.logDebug("---->Recupero los parametros del tipo de frecuencia");
					List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1,
							originalHeader.get(OriginalHeader.PRODUCTTYPE), "Tipo de cuota");
					for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
						originalHeader.set(OriginalHeader.PAYMENTFREQUENCY, generalParametersValuesHistory.getDescription());
					}

					// Campos nuevos para entidad Original Header
					if (creditApplication.getTerm() != null) {
						originalHeader.set(OriginalHeader.TERMIND, creditApplication.getTerm().toString());
					}
					originalHeader.set(OriginalHeader.FREQUENCY, creditApplication.getPeriod());

					// originalHeader.set(OriginalHeader.BCBLACKLISTSCLIENT,
					// creditApplication.getBCBlackListsClient());
					originalHeader.set(OriginalHeader.MAXIMUMAMOUNT, creditApplication.getAmountMaximunTr());
					LOGGER.logDebug("---->Informacion Adicional");
					// NewAliquot
					if (creditApplication.getOfficer() != null) {
						newAliquot.set(NewAliquot.EJECUTIVO, creditApplication.getOfficer().toString());
						newAliquot.set(NewAliquot.IDEJECUTIVO, creditApplication.getOfficer().toString());
					}
					newAliquot.set(NewAliquot.REFERENCIA, creditApplication.getCommentary());

					String simboloMoneda = creditApplication.getSymbolCurrency().trim();
					generalData.set(new Property<String>("symbolCurrency", String.class, false), simboloMoneda);
					LOGGER.logDebug("symbolCurrency: " + simboloMoneda);

					String clienteVinculado = creditApplication.getLinkedClient() + "";
					if (clienteVinculado.equalsIgnoreCase(Mnemonic.CHAR_S + ""))
						generalData.set(new Property<String>("vinculado", String.class, false), Mnemonic.String_Si);
					else
						generalData.set(new Property<String>("vinculado", String.class, false), Mnemonic.String_No);

					LOGGER.logDebug("---->Fin Nuevos Campos<-----");

					// Campos Nuevos
					applicationInfoAux.set(ApplicationInfoAux.ISPROMOTION, creditApplication.getPromotion());
					applicationInfoAux.set(ApplicationInfoAux.GROUPACCEPTRENEW, creditApplication.getGroupAgreesToRenew());
					applicationInfoAux.set(ApplicationInfoAux.REASONNOTACCEPTED, creditApplication.getReasonForNotRenewing());
					applicationInfoAux.set(ApplicationInfoAux.ISENTREPRENEURSHIP, creditApplication.getEntrepreneurship());
					applicationInfoAux.set(ApplicationInfoAux.PERCENTAGEGUARANTEE, creditApplication.getPercentageGuarantee());
					applicationInfoAux.set(ApplicationInfoAux.CUSTOMEREXPERIENCE, creditApplication.getCustomerExperience());
					applicationInfoAux.set(ApplicationInfoAux.NIVELCOLECTIVO, creditApplication.getNivelColectivo());
					applicationInfoAux.set(ApplicationInfoAux.INGRESOSMENSUALES, creditApplication.getIngresosMensuales());
					applicationInfoAux.set(ApplicationInfoAux.MONTHLYPAYMENTCAPACITY, creditApplication.getMonthlyPaymentCapacity());
					applicationInfoAux.set(ApplicationInfoAux.COLECTIVO, creditApplication.getColectivo());
					LOGGER.logDebug("---->Campos colectivos<-----");
					LOGGER.logDebug("COLECTIVO---->" + applicationInfoAux.get(ApplicationInfoAux.COLECTIVO));
					LOGGER.logDebug("NIVEL COLECTIVO---->" + applicationInfoAux.get(ApplicationInfoAux.NIVELCOLECTIVO));
					LOGGER.logDebug("INGRESOS MENSUALES---->" + applicationInfoAux.get(ApplicationInfoAux.INGRESOSMENSUALES).toString());
				} else {
					LOGGER.logDebug("Entra a error en data de tramite");
					MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_OENRIFRMS_01004", MessageLevel.ERROR, true));
					arg1.setSuccess(false);
					return;

				}
			} else {
				LOGGER.logDebug("-----------Original Data Ingreso");
				Integer customerId = generalData.get(new Property<Integer>("clientId", Integer.class));
				CustomerManagement customerManagement = new CustomerManagement(getServiceIntegration());
				LOGGER.logDebug("---->customerId: " + customerId);
				LOGGER.logDebug("generalData" + generalData);

				if (Constants.PRESTAMO_REVOLVENTE.equals(productType)) {
					customerRequest.setCustomerId(idCustomer);
					customerRequest.setModo(0);
					CustomerResponse customerResponse = transactionManagement.readDataCustomer(customerRequest, arg1, new BehaviorOption(true));
					applicationInfoAux.set(ApplicationInfoAux.COLECTIVO, customerResponse.getColectivo());
					applicationInfoAux.set(ApplicationInfoAux.NIVELCOLECTIVO, customerResponse.getNivelColectivo());
					applicationInfoAux.set(ApplicationInfoAux.INGRESOSMENSUALES, new BigDecimal(customerResponse.getMonthlySalesIncome()));
					applicationInfoAux.set(ApplicationInfoAux.MONTHLYPAYMENTCAPACITY, new BigDecimal(customerResponse.getMonthlyPaymentCapacity()));
					LOGGER.logDebug("OTROS INGRESOS Inicial---->" + applicationInfoAux.get(ApplicationInfoAux.INGRESOSMENSUALES).toString());
				}

				OfficerManagement officeMngt = new OfficerManagement(getServiceIntegration());
				OfficerResponse officeResponseDTO;
				officeResponseDTO = officeMngt.getOfficerByLogin(newAliquot.get(NewAliquot.EJECUTIVO), arg1);
				if (officeResponseDTO != null && officeResponseDTO.getOfficerId() != null) {
					LOGGER.logDebug("ID del oficial:" + officeResponseDTO.getOfficerId());
					newAliquot.set(NewAliquot.IDEJECUTIVO, String.valueOf(officeResponseDTO.getOfficerId()));
				}

//				if (productType.equals(Constants.PRESTAMO_INDIVIDUAL)) {
//					// Consulta de Parametro
//					if (paramFrecuencyMonths != null) {
//						originalHeader.set(OriginalHeader.FREQUENCY, paramFrecuencyMonths.getParameterValue());
//					}
//				}

				if (customerId != 0) {
					char vinculado = customerManagement.getEntailmentCustomer(customerId);
					LOGGER.logDebug("----->vinculado:" + vinculado);
					if (vinculado == 'S')
						generalData.set(new Property<String>("vinculado", String.class, false), Mnemonic.String_Si);
					else
						generalData.set(new Property<String>("vinculado", String.class, false), Mnemonic.String_No);
				}

				LOGGER.logDebug("---->REcupera los datos del cliente");
				LOGGER.logDebug("---->Fecha de inicio seteada:>:>****" + originalHeader.getData());

				if (fieldSeven.equals(ApplicationType.SOLIDARITY_GROUP)) {
					LOGGER.logDebug("---->Ingreso a tramite tipo:" + fieldSeven);
					DataEntityList dataEntityCustomer = debManagement.getCustomerEntityList(entities, arg1, 'G');
					if (dataEntityCustomer != null) {
						entities.setEntityList(DebtorGeneral.ENTITY_NAME, dataEntityCustomer);
					} else {
						MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_SAOUCENTD_07389", MessageLevel.ERROR, true));
						return;
					}
				} else {
					LOGGER.logDebug("---->Ingreso a tramite diferente a:" + fieldSeven);
					DataEntityList dataEntityCustomer = debManagement.getCustomerEntityList(entities, arg1);
					if (dataEntityCustomer != null) {
						entities.setEntityList(DebtorGeneral.ENTITY_NAME, dataEntityCustomer);
					} else {
						MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_SAOUCENTD_07389", MessageLevel.ERROR, true));
						return;
					}
				}

				// consulta a buro de credito
				if ((Constants.PRESTAMO_INDIVIDUAL.equals(productType)) || (Constants.PRESTAMO_REVOLVENTE.equals(productType))) {
					setRiskLevelDebtor(entities);
				}

				// Recupera los Segmentos y realiza el set para el primer
				// segmento
				String bankingProductID = originalHeader.get(OriginalHeader.PRODUCTTYPE) == null ? "" : originalHeader.get(OriginalHeader.PRODUCTTYPE);
				LOGGER.logDebug("PRODUCTTYPE: " + originalHeader.get(OriginalHeader.PRODUCTTYPE));
				Sector sector = bankingProductManager.getBankingProductSector(arg1, bankingProductID);
				LOGGER.logDebug("sector: " + sector);
				List<CatalogDto> catalogDtoList = queryStoredProcedureManagement.getSegmentListByPortfolioType(sector.getCode(), (ICommonEventArgs) arg1, new BehaviorOption(true));
				if (catalogDtoList != null && !catalogDtoList.isEmpty()) {
					entidadInfo.set(EntidadInfo.SECTOR, "");
					generalData.set(new Property<String>("segment", String.class), catalogDtoList.get(0).getCode().trim());
				}

				// REQ#162288 Cambios Simple F1
				ParameterResponse parameterFrequency = catalogMngmnt.getParameter("FPDIND", Mnemonic.MODULE, arg1, new BehaviorOption(true));
				String frequency = "W"; // Valor por defecto
				String terIInd = "16"; // Valor por defecto
				if (parameterFrequency != null) {
					String param = parameterFrequency.getParameterValue();
					String[] params = param.split(";");
					if (params.length > 1) {
						frequency = params[0]; // W
						terIInd = params[1]; // 16
					}
				}
				originalHeader.set(OriginalHeader.FREQUENCY, frequency);
				originalHeader.set(OriginalHeader.TERMIND, terIInd);
			}
			generalData.set(new Property<String>("productTypeName", String.class, false), "--");

			LOGGER.logDebug("ProductoTipo: " + originalHeader.get(OriginalHeader.PRODUCTTYPE));
			if (originalHeader.get(OriginalHeader.PRODUCTTYPE) != null || originalHeader.get(OriginalHeader.PRODUCTTYPE).trim() != "") {

				LOGGER.logDebug("---->Recupera el nombre del producto que se esta atendiendo");
				String productName = bankingProductManager.getProductName(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE));
				generalData.set(new Property<String>("productTypeName", String.class, false), productName);
				entidadInfo.set(EntidadInfo.TIPOPRODUCTO, originalHeader.get(OriginalHeader.PRODUCTTYPE).trim());
				if (originalHeader.get(OriginalHeader.IDREQUESTED).equals("0")) {

					List<GeneralParametersValuesHistory> generalParameterCatalogTerm = bankingProductManager.getCatalogGeneralParameter(arg1,
							originalHeader.get(OriginalHeader.PRODUCTTYPE), "Plazo");

					// SRO
					for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalogTerm) {
						LOGGER.logDebug("value:" + generalParametersValuesHistory.getValue());
						originalHeader.set(OriginalHeader.TERM, generalParametersValuesHistory.getValue());
					}

					List<GeneralParametersValuesHistory> generalParameterCatalogGrace = bankingProductManager.getCatalogGeneralParameter(arg1,
							originalHeader.get(OriginalHeader.PRODUCTTYPE), "Gracia");

					for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalogGrace) {
						LOGGER.logDebug("value:" + generalParametersValuesHistory.getValue());
						originalHeader.set(OriginalHeader.DISPLACEMENT, generalParametersValuesHistory.getValue());
					}

					LOGGER.logDebug("---->Recupero los parametros del tipo de frecuencia");
					List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1,
							originalHeader.get(OriginalHeader.PRODUCTTYPE), "Tipo de cuota");
					LOGGER.logDebug("generalParameterCatalog" + generalParameterCatalog.size());
					for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
						LOGGER.logDebug("Valor --->" + generalParametersValuesHistory.getDescription());
						originalHeader.set(OriginalHeader.PAYMENTFREQUENCY, generalParametersValuesHistory.getDescription());
						generalData.set(GeneralData.PAYMENTFRECUENCYNAME, generalParametersValuesHistory.getDescription());
					}

					if (Constants.PRESTAMO_INDIVIDUAL.equals(productType)) {
						generalData.set(GeneralData.PAYMENTFRECUENCYNAME, "--");
					}
				}
				try {
					LOGGER.logDebug("---->Recupero los parametros de categoria");
					List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1,
							originalHeader.get(OriginalHeader.PRODUCTTYPE), "Categoría");
					for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
						originalHeader.set(OriginalHeader.CATEGORY, generalParametersValuesHistory.getDescription());
					}

					LOGGER.logDebug("---->Recupero los parametros de tipo");
					generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE), "Tipo");
					for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
						originalHeader.set(OriginalHeader.TYPE, generalParametersValuesHistory.getDescription());
					}

					LOGGER.logDebug("---->Recupero los parametros de subtipo");
					generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE), "Subtipo");
					for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
						originalHeader.set(OriginalHeader.SUBTYPE, generalParametersValuesHistory.getDescription());
						originalHeader.set(OriginalHeader.SUBTYPEID, generalParametersValuesHistory.getValue());
					}
				} catch (BusinessException e) {
					LOGGER.logError("Error---> " + e.getMessage());
				}

			}

			LOGGER.logDebug("0... originalHeader.get(OriginalHeader.AMOUNTAPROBED):" + originalHeader.get(OriginalHeader.AMOUNTAPROBED));
			LOGGER.logDebug("0... originalHeader.get(OriginalHeader.AMOUNTREQUESTED):" + originalHeader.get(OriginalHeader.AMOUNTREQUESTED));
			if (originalHeader.get(OriginalHeader.AMOUNTAPROBED) == null && originalHeader.get(OriginalHeader.AMOUNTREQUESTED) != null
					&& originalHeader.get(OriginalHeader.AMOUNTREQUESTED).compareTo(new BigDecimal(0)) == 1) {
				LOGGER.logDebug("montos >>>");
				originalHeader.set(OriginalHeader.AMOUNTAPROBED, originalHeader.get(OriginalHeader.AMOUNTREQUESTED));
			}

			LOGGER.logDebug("---->Ejecucion de servicio para recuperar el sector desde apf");
			String bankingProductID = originalHeader.get(OriginalHeader.PRODUCTTYPE) == null ? "" : originalHeader.get(OriginalHeader.PRODUCTTYPE);
			Sector sector = bankingProductManager.getBankingProductSector(arg1, bankingProductID);
			originalHeader.set(OriginalHeader.PORTFOLIOTYPE, sector.getCode());
			generalData.set(new Property<String>("loanType", String.class, false), sector.getDescription());

			// Recupero el parámetro Sector
			List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE),
					"Sector");
			// Asocio el valor del sector
			for (GeneralParametersValuesHistory sectorNeg : generalParameterCatalog) {
				generalData.set(new Property<String>("sectorNeg", String.class, false), sectorNeg.getDescription());
			}

			String fechaProceso = ServerParamUtil.getProcessDate();

			LOGGER.logDebug("Fecha de proceso SANTANDER>>>" + fechaProceso);
			entidadInfo.set(EntidadInfo.FECHAPROCESO, fechaProceso);

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_INITDATA, e, arg1, LOGGER);
		}
	}

	private void setRiskLevelDebtor(DynamicRequest entities) {
		LOGGER.logDebug("Start setRiskLevelDebtor ");
		DataEntityList debtors = entities.getEntityList(DebtorGeneral.ENTITY_NAME);
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		
		DataEntity context = entities.getEntity(Context.ENTITY_NAME);		
		Integer channel = context.get(Context.CHANNEL);
		
		if (debtors != null && debtors.size() > 0) {
			QueryBureau queryBureau = new QueryBureau(super.getServiceIntegration());
			DataEntity debtor = debtors.get(0);
			try {

				int debtorId = debtor.get(DebtorGeneral.CUSTOMERCODE);
				int instProc = originalHeader.get(OriginalHeader.APPLICATIONNUMBER);

				if (debtorId > 0) {
					LOGGER.logDebug("Queryng credit Bureay debtor " + debtorId);
					BuroExecutionResponse buroDebtorResponse = queryBureau.queryBureau(debtorId, instProc, channel);
					// debtor.set(DebtorGeneral.CREDITBUREAU,
					// String.valueOf(buroDebtorResponse.getRiskScore()));
					debtor.set(DebtorGeneral.RISKLEVEL, buroDebtorResponse.getRuleExecutionResult());
				}

			} catch (Exception e) {
				LOGGER.logError("Error queryBureau ", e);
				debtor.set(DebtorGeneral.CREDITBUREAU, "Error");

			}
		}
	}

}
