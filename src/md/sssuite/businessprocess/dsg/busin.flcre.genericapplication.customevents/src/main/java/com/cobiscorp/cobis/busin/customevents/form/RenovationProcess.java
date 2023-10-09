package com.cobiscorp.cobis.busin.customevents.form;

import java.math.BigDecimal;
import java.util.Map;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RenewLoanRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RenewLoanResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.DebtorManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.OperationManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.SessionContext;
import com.cobiscorp.cobis.busin.model.DebtorGeneral;
import com.cobiscorp.cobis.busin.model.EntidadInfo;
import com.cobiscorp.cobis.busin.model.OfficerAnalysis;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.RefinancingOperations;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.Property;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class RenovationProcess {

	private static final ILogger LOGGER = LogFactory.getLogger(RenovationProcess.class);

	public static void initDataRenovation(DynamicRequest entities, IDataEventArgs arg1, ICTSServiceIntegration serviceIntegration) {
		try {
			LOGGER.logDebug("---->Recupero parametros de la URL enviada");
			@SuppressWarnings("unchecked")
			Map<String, Object> task = (Map<String, Object>) arg1.getParameters().getCustomParameters().get("Task");
			@SuppressWarnings("unchecked")
			Map<String, Object> url = (Map<String, Object>) task.get("urlParams");

			LOGGER.logDebug("---->Recupero entidades de presentacion ");
			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);

			if (url.get("TRAMITE") != null && url.get("TRAMITE").equals("RENOVATION")) {
				String tramite = originalHeader.get(OriginalHeader.IDREQUESTED) == null ? "0" : originalHeader.get(OriginalHeader.IDREQUESTED);
				if (tramite.equals("0")) {
					initDataNewRenovation(entities, arg1, serviceIntegration);
				} else {
					initDataExistsRenovation(entities, arg1, serviceIntegration);
				}
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_INITDATA, e, arg1, LOGGER);
		}
	}

	private static void initDataNewRenovation(DynamicRequest entities, IDataEventArgs arg1, ICTSServiceIntegration serviceIntegration) {

		LOGGER.logDebug("Recupero la lista de operaciones para seleccionar la operacion q se va a renovar");
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		DataEntity officerAnalysis = entities.getEntity(OfficerAnalysis.ENTITY_NAME);
		DataEntity entidadInfo = entities.getEntity(EntidadInfo.ENTITY_NAME);
		DataEntity generalData = entities.getEntity("generalData");
		DataEntityList refinancingOperations = entities.getEntityList(RefinancingOperations.ENTITY_NAME);

		LOGGER.logDebug("Transaction Manager");
		BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(serviceIntegration);
		QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(serviceIntegration);
		TransactionManagement transactionManagement = new TransactionManagement(serviceIntegration);
		OperationManagement operationMngt = new OperationManagement(serviceIntegration);
		DebtorManagement debManagement = new DebtorManagement(serviceIntegration);

		LOGGER.logDebug("Recupero el numero de operacion");
		Integer codigoTramite = 0;
		Double saldo = new Double("0");
		String numeroOperacionBanco = originalHeader.get(OriginalHeader.OPNUMBERBANK).trim();

		LOGGER.logDebug("Formo mi request");
		RenewLoanRequest renewDataRequest = new RenewLoanRequest();
		renewDataRequest.setNumBanc(numeroOperacionBanco);

		LOGGER.logDebug("Ejecuto mi transaccion para que me devuelva la operacion a renovar");
		RenewLoanResponse[] renewLoanResponseList = operationMngt.searchOperationsByOperation(renewDataRequest, arg1, new BehaviorOption(true));

		LOGGER.logDebug("Mapeo la lista de operaciones");
		for (RenewLoanResponse renewDataResponse : renewLoanResponseList) {
			DataEntity operationEntity = new DataEntity();
			operationEntity.set(RefinancingOperations.IDOPERATION, renewDataResponse.getNumOperation() + "");
			operationEntity.set(RefinancingOperations.OPERATIONBANK, renewDataResponse.getOpBanco());
			operationEntity.set(RefinancingOperations.REFINANCINGOPTION, "C");
			operationEntity.set(RefinancingOperations.CURRENCYOPERATION, Integer.parseInt(renewDataResponse.getOperationMoney()));
			operationEntity.set(RefinancingOperations.ORIGINALAMOUNT, new BigDecimal(renewDataResponse.getOriginalAmount()));
			operationEntity.set(RefinancingOperations.BALANCE, new BigDecimal(renewDataResponse.getBalance()));
			operationEntity.set(RefinancingOperations.ISBASE, true);
			operationEntity.set(RefinancingOperations.OFICIALOPERATION, 0);
			operationEntity.set(RefinancingOperations.CREDITTYPE, renewDataResponse.getTypeOperation().trim());
			operationEntity.set(RefinancingOperations.DATEGRANTING, renewDataResponse.getOpBegindate());
			operationEntity.set(RefinancingOperations.EXPIRATIONDATE, renewDataResponse.getOpLastdate());
			operationEntity.set(RefinancingOperations.IDREQUESTEDOPERATION, renewDataResponse.getNumRequest() + "");
			operationEntity.set(RefinancingOperations.INTERNALCUSTOMERCLASSIFICATION, renewDataResponse.getCustomerCalification());
			operationEntity.set(RefinancingOperations.OPERATIONQUALIFICATION, renewDataResponse.getRenewCalification() + "");
			operationEntity.set(RefinancingOperations.PAYOUTPERCENTAGE, renewDataResponse.getPayoutPercentage());
			operationEntity.set(RefinancingOperations.RATE, new Double(0));
			operationEntity.set(RefinancingOperations.SECTOR, renewDataResponse.getSector());
			operationEntity.set(RefinancingOperations.LOCALCURRENCYBALANCE, new BigDecimal(renewDataResponse.getBalance()));
			operationEntity.set(RefinancingOperations.LOCALCURRENCYAMOUNT, new BigDecimal(renewDataResponse.getOriginalAmount()));
			operationEntity.set(RefinancingOperations.MORATORY, renewDataResponse.getMoratory() == null ? 0 : renewDataResponse.getMoratory());
			operationEntity.set(RefinancingOperations.PAYMENT, new BigDecimal(0));
			operationEntity.set(RefinancingOperations.CAPITALIZE, false);
			operationEntity.set(RefinancingOperations.STATE, renewDataResponse.getState());
			operationEntity.set(RefinancingOperations.TYPEOPERATION, renewDataResponse.getOperationType());
			refinancingOperations.add(operationEntity);
			codigoTramite = renewDataResponse.getNumRequest();
			saldo = renewDataResponse.getBalance();
		}

		LOGGER.logDebug("Recupero datos del tramite de la operacion que se carga");
		ApplicationResponse creditApplication = transactionManagement.getApplication(codigoTramite, arg1, new BehaviorOption(true));
		if (creditApplication != null) {

			originalHeader.set(OriginalHeader.PAYMENTFREQUENCY, creditApplication.getPaymentFrequency());
			originalHeader.set(OriginalHeader.AMOUNTREQUESTED, new BigDecimal(saldo));
			originalHeader.set(OriginalHeader.CURRENCYREQUESTED, String.valueOf(creditApplication.getCurrencyRequested()));
			originalHeader.set(OriginalHeader.QUOTA, creditApplication.getQuota());
			originalHeader.set(OriginalHeader.CREDITTARGET, creditApplication.getDestinationDescription());
			originalHeader.set(OriginalHeader.INITIALDATE, creditApplication.getStartDate().getTime());
			originalHeader.set(OriginalHeader.AGREEMENT, creditApplication.getAgreement());
			originalHeader.set(OriginalHeader.PRODUCTTYPE, creditApplication.getOpertationType());
			originalHeader.set(OriginalHeader.CODEAGREEMENT, creditApplication.getCompanyAgreement());
			originalHeader.set(OriginalHeader.OFFICERID, creditApplication.getOfficer().toString());
			originalHeader.set(OriginalHeader.OFFICERNAME, creditApplication.getOfficialDescription());
			originalHeader.set(OriginalHeader.PRODUCTFIE, creditApplication.getProduct());
			officerAnalysis.set(OfficerAnalysis.PROVINCE, creditApplication.getProvince());
			officerAnalysis.set(OfficerAnalysis.CITY, creditApplication.getCityDestination());
			officerAnalysis.set(OfficerAnalysis.PARROQUIA, creditApplication.getParroquia());
			officerAnalysis.set(OfficerAnalysis.TERM, creditApplication.getTerm());

			LOGGER.logDebug("Nuevos campos se mapean");
			entidadInfo.set(EntidadInfo.DESTINOFINANCIERO, creditApplication.getDestination());
			entidadInfo.set(EntidadInfo.DESTINOECONOMICO, creditApplication.getActivityDestination());
			entidadInfo.set(EntidadInfo.OFICINA, String.valueOf(creditApplication.getOffice()));

			LOGGER.logDebug("Recupera los Segmentos y realiza el set para el primer segmento");
			entidadInfo.set(EntidadInfo.SECTOR, "");
			generalData.set(new Property<String>("segment", String.class), creditApplication.getSector());

			originalHeader.set(OriginalHeader.AMOUNTAPROBED, new BigDecimal(saldo));
			originalHeader.set(OriginalHeader.TERM, String.valueOf(creditApplication.getTerm()));
			LOGGER.logDebug("Carga del campo de vinculado");
			String clienteVinculado = creditApplication.getLinkedClient() + "";
			if (clienteVinculado.equalsIgnoreCase(Mnemonic.CHAR_S + ""))
				generalData.set(new Property<String>("vinculado", String.class, false), Mnemonic.String_Si);
			else
				generalData.set(new Property<String>("vinculado", String.class, false), Mnemonic.String_No);

			LOGGER.logDebug("toma del campo simbolo de moneda");
			String simboloMoneda = creditApplication.getSymbolCurrency().trim();
			generalData.set(new Property<String>("symbolCurrency", String.class, false), simboloMoneda);

			LOGGER.logDebug("Recupero campo otro destino");
			for (CatalogDto item : queryStoredProcedureManagement.getOtherDestinationByTramite(String.valueOf(codigoTramite), (ICommonEventArgs) arg1, new BehaviorOption(true))) {
				if (item.getDescription1() != null && !item.getDescription1().equals("")) {
					entidadInfo.set(EntidadInfo.OTRODESTINO, item.getDescription1());
				} else if (item.getDescription3() != null && !item.getDescription3().equals("")) {
					entidadInfo.set(EntidadInfo.OTRODESTINO, item.getDescription3());
				} else {
					entidadInfo.set(EntidadInfo.OTRODESTINO, null);
				}
			}

			LOGGER.logDebug("---->Recupera los deudores en base al tramite");
			DataEntityList debtors = debManagement.getDebtorsEntityList(codigoTramite, arg1, new BehaviorOption(true));
			if (debtors != null) {
				entities.setEntityList(DebtorGeneral.ENTITY_NAME, debtors);
			} else {
				MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_SAOUCENTD_07389", MessageLevel.ERROR, true));
				return;
			}

		}
	}

	private static void initDataExistsRenovation(DynamicRequest entities, IDataEventArgs arg1, ICTSServiceIntegration serviceIntegration) {

		// Recupero la lista de operaciones para seleccionar la operacion q se
		// va a renovar
		DataEntityList refinancingOperations = entities.getEntityList(RefinancingOperations.ENTITY_NAME);
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);

		// Recupero el tramite
		String tramite = originalHeader.get(OriginalHeader.IDREQUESTED);

		// Transaction Manager
		OperationManagement operationMngt = new OperationManagement(serviceIntegration);

		// RECUPERAR OPERACIONES
		RenewLoanRequest renewDataRequest = new RenewLoanRequest();
		renewDataRequest.setNumRequest(Integer.parseInt(tramite));
		renewDataRequest.setDateFormat(SessionContext.getFormatDate());
		renewDataRequest.setCustomerId(-1); // envio -1 pues no soporta
											// nulos

		RenewLoanResponse[] readCustomerOperation = operationMngt.searchCustomerOperations(renewDataRequest, arg1, new BehaviorOption(true));
		if (readCustomerOperation != null) {
			for (RenewLoanResponse renewDataResponse : readCustomerOperation) {
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("Ingreso searchOperationCustomerAndMapping");

				DataEntity operationEntity = new DataEntity();
				operationEntity.set(RefinancingOperations.IDOPERATION, renewDataResponse.getNumOperation() + "");
				operationEntity.set(RefinancingOperations.OPERATIONBANK, renewDataResponse.getOpBanco());
				operationEntity.set(RefinancingOperations.REFINANCINGOPTION, "C");
				operationEntity.set(RefinancingOperations.CURRENCYOPERATION, Integer.parseInt(renewDataResponse.getOperationMoney()));
				operationEntity.set(RefinancingOperations.ORIGINALAMOUNT, new BigDecimal(renewDataResponse.getOriginalAmount()));
				operationEntity.set(RefinancingOperations.BALANCE, new BigDecimal(renewDataResponse.getBalance()));
				operationEntity.set(RefinancingOperations.ISBASE, (renewDataResponse.getIsRenew() != null && renewDataResponse.getIsRenew().equals(Mnemonic.STRING_S)));
				operationEntity.set(RefinancingOperations.CREDITTYPE, renewDataResponse.getTypeOperation().trim());
				operationEntity.set(RefinancingOperations.DATEGRANTING, renewDataResponse.getOpBegindate());
				operationEntity.set(RefinancingOperations.EXPIRATIONDATE, renewDataResponse.getOpLastdate());
				operationEntity.set(RefinancingOperations.IDREQUESTEDOPERATION, renewDataResponse.getNumRequest() + "");
				operationEntity.set(RefinancingOperations.INTERNALCUSTOMERCLASSIFICATION, renewDataResponse.getCustomerCalification());
				operationEntity.set(RefinancingOperations.OPERATIONQUALIFICATION, renewDataResponse.getRenewCalification() + "");
				operationEntity.set(RefinancingOperations.PAYOUTPERCENTAGE, renewDataResponse.getPayoutPercentage());
				operationEntity.set(RefinancingOperations.RATE, new Double(0));
				operationEntity.set(RefinancingOperations.SECTOR, renewDataResponse.getSector());
				operationEntity.set(RefinancingOperations.LOCALCURRENCYBALANCE, new BigDecimal(renewDataResponse.getBalance()));
				operationEntity.set(RefinancingOperations.LOCALCURRENCYAMOUNT, new BigDecimal(renewDataResponse.getOriginalAmount()));
				operationEntity.set(RefinancingOperations.PAYMENT, new BigDecimal(renewDataResponse.getPayment()));
				operationEntity.set(RefinancingOperations.MORATORY, renewDataResponse.getMoratory() == null ? 0 : renewDataResponse.getMoratory());
				operationEntity.set(RefinancingOperations.CAPITALIZE,
						renewDataResponse.getCapitalize() != null && renewDataResponse.getCapitalize().trim().equals("S") ? true : false);
				operationEntity.set(RefinancingOperations.TYPEOPERATION, renewDataResponse.getOperationType());
				operationEntity.set(RefinancingOperations.STATE, renewDataResponse.getState());

				refinancingOperations.add(operationEntity);

			}
		}

	}

}
