package com.cobiscorp.cobis.busin.customevents.events;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.loanrequest.dto.ProcessedNumber;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.OfficeResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
//JTA import com.cobiscorp.cobis.busin.flcre.commons.services.DebtorManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.LocationManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
//JTA import com.cobiscorp.cobis.busin.model.DebtorGeneral;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.Property;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.fpm.bo.Sector;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;

public class InitDataRejectedApp extends BaseEvent implements IInitDataEvent {

	private static ILogger LOGGER = LogFactory.getLogger(InitDataRejectedApp.class);

	public InitDataRejectedApp(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("--- InitDataRejectedApp ---");
		}

		try {
			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
			DataEntity generalData = entities.getEntity("generalData");
			BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(getServiceIntegration());
			QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());

			int applicationNumber = originalHeader.get(OriginalHeader.APPLICATIONNUMBER);

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("RejectedApp - Load Transaction Number");
			}

			TransactionManagement transactionManagement = new TransactionManagement(super.getServiceIntegration());
			ProcessedNumber processedNumber = transactionManagement.getProcessedNumber(applicationNumber, arg1, new BehaviorOption(true));

			if (processedNumber == null) {
				MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_NMRREEUID_75532", MessageLevel.ERROR, true));
				return;
			}

			int codigoTramite = processedNumber.getTramite();

			// -------------------------------------
			if (codigoTramite != 0) {
				/*
				 * if (logger.isDebugEnabled()) {
				 * logger.logDebug("RejectedApp - Load debtor transaction"); } DebtorManagement
				 * debManagement = new DebtorManagement(super.getServiceIntegration());
				 * DataEntityList debtors = debManagement.getDebtorsEntityList(codigoTramite,
				 * arg1, new BehaviorOption(true));
				 * 
				 * if (debtors != null) { entities.setEntityList(DebtorGeneral.ENTITY_NAME,
				 * debtors); } else { MessageManagement.show(arg1, new MessageOption(
				 * "BUSIN.DLB_BUSIN_SAOUCENTD_07389", MessageLevel.ERROR, true)); return; }
				 */
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("RejectedApp - Load Header Transaction");
				}
				ApplicationResponse creditApplication = transactionManagement.getApplication(codigoTramite, arg1, new BehaviorOption(true));

				if (creditApplication != null) {
					originalHeader.set(OriginalHeader.IDREQUESTED, codigoTramite + "");
					originalHeader.set(OriginalHeader.PAYMENTFREQUENCY, creditApplication.getPaymentFrequency());
					originalHeader.set(OriginalHeader.AMOUNTREQUESTED, creditApplication.getAmountRequested());
					originalHeader.set(OriginalHeader.CURRENCYREQUESTED, String.valueOf(creditApplication.getCurrencyRequested()));
					originalHeader.set(OriginalHeader.QUOTA, creditApplication.getQuota());
					originalHeader.set(OriginalHeader.CREDITTARGET, creditApplication.getDestinationDescription());
					originalHeader.set(OriginalHeader.INITIALDATE, creditApplication.getStartDate().getTime());
					originalHeader.set(OriginalHeader.AGREEMENT, creditApplication.getAgreement());
					originalHeader.set(OriginalHeader.CODEAGREEMENT, creditApplication.getCompanyAgreement());
					originalHeader.set(OriginalHeader.OFFICERID, creditApplication.getOfficer().toString());
					originalHeader.set(OriginalHeader.OFFICERNAME, creditApplication.getOfficialDescription());
					originalHeader.set(OriginalHeader.TERM, String.valueOf(creditApplication.getTerm()));

					generalData.set(new Property<String>("destinoFinanciero", String.class, false), creditApplication.getDestination());
					generalData.set(new Property<String>("destinoEconomico", String.class, false), creditApplication.getActivityDestination());
					generalData.set(new Property<String>("oficina", String.class, false), String.valueOf(creditApplication.getOffice()));
					generalData.set(new Property<String>("sector", String.class, false), creditApplication.getDestination());

					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("RejectedApp - Rejection Data 1");
					}

					String rejectionExcuse = (creditApplication.getReasonOne() != null ? creditApplication.getReasonOne() : "")
							+ (creditApplication.getReasonTwo() != null ? creditApplication.getReasonTwo() : "");
					originalHeader.set(OriginalHeader.REJECTIONEXCUSE, rejectionExcuse);
					String reasonRejected = creditApplication.getReasonRejection() == null ? "" : creditApplication.getReasonRejection().replace(' ', ' ').trim();

					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("RejectedApp - Rejection Data 2");
					}
					originalHeader.set(OriginalHeader.REJECTIONREASON, (!reasonRejected.equalsIgnoreCase("") ? Integer.parseInt(reasonRejected) : null));
					if (creditApplication.getOffice() != null) {
						originalHeader.set(OriginalHeader.OFFICE, creditApplication.getOffice());
					}

					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("RejectedApp - Load Customer link");
					}

					String clienteVinculado = creditApplication.getLinkedClient() + "";
					if (clienteVinculado.equalsIgnoreCase(Mnemonic.CHAR_S + ""))
						generalData.set(new Property<String>("vinculado", String.class, false), "Si");
					else
						generalData.set(new Property<String>("vinculado", String.class, false), "No");

					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("RejectedApp - Currency value");
					}
					String simboloMoneda = creditApplication.getSymbolCurrency().trim();
					generalData.set(new Property<String>("symbolCurrency", String.class, false), simboloMoneda);

					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("RejectedApp - Banking Product ID");
					}
					String bankingProductID = originalHeader.get(OriginalHeader.PRODUCTTYPE) == null ? "" : originalHeader.get(OriginalHeader.PRODUCTTYPE);
					Sector sector = bankingProductManager.getBankingProductSector(arg1, bankingProductID);
					originalHeader.set(OriginalHeader.PORTFOLIOTYPE, sector.getCode());

				} else {
					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("RejectedApp - CreditApplication is null");
					}
					MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_OENRIFRMS_01004", MessageLevel.ERROR, true));
					arg1.setSuccess(false);
					return;
				}
			} else {
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("RejectedApp - Transaction number is 0");
				}
				originalHeader.set(OriginalHeader.INITIALDATE, new Date());
			}
			// -------------------------------------

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("RejectedApp - OriginalHeader" + originalHeader.getData());
			}

			if (originalHeader.get(OriginalHeader.PRODUCTTYPE) != null || originalHeader.get(OriginalHeader.PRODUCTTYPE).trim() != "") {

				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("RejectedApp - Product Name");
				}
				String productName = bankingProductManager.getProductName(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE));
				generalData.set(new Property<String>("productTypeName", String.class, false), productName);

				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("RejectedApp - APF Parameters");
				}
				List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1,
						originalHeader.get(OriginalHeader.PRODUCTTYPE), "Plazo Operación");
				for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
					generalData.set(new Property<String>("termLimit", String.class, false), generalParametersValuesHistory.getValue());
					originalHeader.set(OriginalHeader.TERMLIMIT, Integer.parseInt(generalParametersValuesHistory.getValue()));
				}

			} else {
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug("RejectedApp - Don´t have products");
				}
				generalData.set(new Property<String>("productTypeName", String.class, false), "--");
			}

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("RejectedApp - Approved amount");
			}

			if (originalHeader.get(OriginalHeader.AMOUNTAPROBED) == null && originalHeader.get(OriginalHeader.AMOUNTREQUESTED) != null
					&& originalHeader.get(OriginalHeader.AMOUNTREQUESTED).compareTo(new BigDecimal(0)) == 1) {
				originalHeader.set(OriginalHeader.AMOUNTAPROBED, originalHeader.get(OriginalHeader.AMOUNTREQUESTED));
			}

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("RejectedApp - Frequency of payment");
			}
			generalData.set(new Property<String>("paymentFrecuencyName", String.class, false), "--");
			if (originalHeader.get(OriginalHeader.PAYMENTFREQUENCY) != null) {

				for (CatalogDto item : queryStoredProcedureManagement.getPaymentFrequency((ICommonEventArgs) arg1, new BehaviorOption(true))) {
					if (item.getCode().trim().equalsIgnoreCase(originalHeader.get(OriginalHeader.PAYMENTFREQUENCY).trim())) {
						generalData.set(new Property<String>("paymentFrecuencyName", String.class, false), item.getName());
					}
				}
			}

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("RejectedApp - City Office");
			}
			LocationManagement locManagement = new LocationManagement(super.getServiceIntegration());
			OfficeResponse officeResponse = locManagement.getOffice(originalHeader.get(OriginalHeader.OFFICE), arg1, new BehaviorOption(true));
			if (officeResponse != null) {
				originalHeader.set(OriginalHeader.CITYCODE, officeResponse.getCityId());
			}

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("RejectedApp - APF Sector");
			}
			String bankingProductID = originalHeader.get(OriginalHeader.PRODUCTTYPE) == null ? "" : originalHeader.get(OriginalHeader.PRODUCTTYPE);
			Sector sector = bankingProductManager.getBankingProductSector(arg1, bankingProductID);
			originalHeader.set(OriginalHeader.PORTFOLIOTYPE, sector.getCode());
			generalData.set(new Property<String>("loanType", String.class, false), sector.getDescription());

			// Recupero el parámetro Sector
			List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE),
					"Sector");

			// Asocio el valor del sector
			for (GeneralParametersValuesHistory sectorNeg : generalParameterCatalog) {
				generalData.set(new Property<String>("sectorNeg", String.class, false), sectorNeg.getRuleName()); // getDescription
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("RejectedApp - End rejectedApplicatcion InitDataRejectedApp");
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.REJECTED_INITDATA_APP, e, arg1, LOGGER);
		}
	}
}
