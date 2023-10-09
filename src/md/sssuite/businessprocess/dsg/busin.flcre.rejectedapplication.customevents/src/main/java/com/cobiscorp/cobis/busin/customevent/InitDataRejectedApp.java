package com.cobiscorp.cobis.busin.customevent;

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
import com.cobiscorp.cobis.busin.flcre.commons.services.DebtorManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.LocationManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.DebtorGeneral;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
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

		LOGGER.logDebug("---->Entra al InitDataRejectedApp");

		try {

			LOGGER.logDebug("---->Instancia de la entidad hacia los objetos");
			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
			DataEntity generalData = entities.getEntity("generalData");
			BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(getServiceIntegration());
			QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());

			int applicationNumber = originalHeader.get(OriginalHeader.APPLICATIONNUMBER);

			LOGGER.logDebug("---->Recupera el numero del tramite");
			TransactionManagement transactionManagement = new TransactionManagement(super.getServiceIntegration());
			ProcessedNumber processedNumber = transactionManagement.getProcessedNumber(applicationNumber, arg1, new BehaviorOption(true));
			if (processedNumber == null) {
				MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_NMRREEUID_75532", MessageLevel.ERROR, true));
				return;
			}

			int codigoTramite = processedNumber.getTramite();

			LOGGER.logDebug("---->Si el coddigo del tramite es diferente de cero recupera la informacion asociada al tramite" + codigoTramite);
			if (codigoTramite != 0) {

				LOGGER.logDebug("---->Recupera los deudores en base al tramite");
				DebtorManagement debManagement = new DebtorManagement(super.getServiceIntegration());
				DataEntityList debtors = debManagement.getDebtorsEntityList(codigoTramite, arg1, new BehaviorOption(true));
				if (debtors != null) {
					entities.setEntityList(DebtorGeneral.ENTITY_NAME, debtors);
				} else {
					MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_SAOUCENTD_07389", MessageLevel.ERROR, true));
					return;
				}

				LOGGER.logDebug("---->Recupera los datos del tramite");
				ApplicationResponse creditApplication = transactionManagement.getApplication(codigoTramite, arg1, new BehaviorOption(true));
				if (creditApplication != null) {

					LOGGER.logDebug("---->Carga los datos del tramite recueperados" + creditApplication);
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

					LOGGER.logDebug("---->Campos de Rechazo 1");
					String rejectionExcuse = (creditApplication.getReasonOne() != null ? creditApplication.getReasonOne() : "")
							+ (creditApplication.getReasonTwo() != null ? creditApplication.getReasonTwo() : "");
					originalHeader.set(OriginalHeader.REJECTIONEXCUSE, rejectionExcuse);

					String reasonRejected = creditApplication.getReasonRejection() == null ? "" : creditApplication.getReasonRejection().replace(" ", "").trim();

					LOGGER.logDebug("---->Campos de Rechazo 2");
					originalHeader.set(OriginalHeader.REJECTIONREASON, (!reasonRejected.equalsIgnoreCase("") ? Integer.parseInt(reasonRejected) : null));
					if (creditApplication.getOffice() != null) {
						originalHeader.set(OriginalHeader.OFFICE, creditApplication.getOffice());
					}

					LOGGER.logDebug("Carga del campo de vinculado");
					String clienteVinculado = creditApplication.getLinkedClient() + "";
					if (clienteVinculado.equalsIgnoreCase(Mnemonic.CHAR_S + ""))
						generalData.set(new Property<String>("vinculado", String.class, false), "Si");
					else
						generalData.set(new Property<String>("vinculado", String.class, false), "No");

					LOGGER.logDebug("toma del campo simbolo de moneda");
					String simboloMoneda = creditApplication.getSymbolCurrency().trim();
					generalData.set(new Property<String>("symbolCurrency", String.class, false), simboloMoneda);

					LOGGER.logDebug("---->Recupera el nombre del producto que se esta atendiendo");
					String bankingProductID = originalHeader.get(OriginalHeader.PRODUCTTYPE) == null ? "" : originalHeader.get(OriginalHeader.PRODUCTTYPE);
					Sector sector = bankingProductManager.getBankingProductSector(arg1, bankingProductID);
					originalHeader.set(OriginalHeader.PORTFOLIOTYPE, sector.getCode());

				} else {

					LOGGER.logDebug("---->creditApplication is null");
					MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_OENRIFRMS_01004", MessageLevel.ERROR, true));
					arg1.setSuccess(false);
					return;
				}
			} else {
				LOGGER.logDebug("---->codigoTramite es 0");
				originalHeader.set(OriginalHeader.INITIALDATE, new Date());
			}

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug(":>:>OriginalHeader:>:>" + originalHeader.getData());
			}
			if (originalHeader.get(OriginalHeader.PRODUCTTYPE) != null || originalHeader.get(OriginalHeader.PRODUCTTYPE).trim() != "") {

				LOGGER.logDebug("---->Recupera el nombre del producto que se esta atendiendo");
				String productName = bankingProductManager.getProductName(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE));
				generalData.set(new Property<String>("productTypeName", String.class, false), productName);

				LOGGER.logDebug("---->Recupera los parametros configurados en el apf");
				List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1,
						originalHeader.get(OriginalHeader.PRODUCTTYPE), "Plazo Operación");
				for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
					generalData.set(new Property<String>("termLimit", String.class, false), generalParametersValuesHistory.getValue());
					originalHeader.set(OriginalHeader.TERMLIMIT, Integer.parseInt(generalParametersValuesHistory.getValue()));
				}

			} else {
				LOGGER.logDebug("---->No recupero producto");
				generalData.set(new Property<String>("productTypeName", String.class, false), "--");
			}

			LOGGER.logDebug("---->Set del campo monto aprobado");
			if (originalHeader.get(OriginalHeader.AMOUNTAPROBED) == null && originalHeader.get(OriginalHeader.AMOUNTREQUESTED) != null
					&& originalHeader.get(OriginalHeader.AMOUNTREQUESTED).compareTo(new BigDecimal(0)) == 1) {
				originalHeader.set(OriginalHeader.AMOUNTAPROBED, originalHeader.get(OriginalHeader.AMOUNTREQUESTED));
			}

			LOGGER.logDebug("---->Recupera el nombre de frecuencia de pago");
			generalData.set(new Property<String>("paymentFrecuencyName", String.class, false), "--");
			if (originalHeader.get(OriginalHeader.PAYMENTFREQUENCY) != null) {
				for (CatalogDto item : queryStoredProcedureManagement.getPaymentFrequency((ICommonEventArgs) arg1, new BehaviorOption(true))) {
					if (item.getCode().trim().equalsIgnoreCase(originalHeader.get(OriginalHeader.PAYMENTFREQUENCY).trim())) {
						generalData.set(new Property<String>("paymentFrecuencyName", String.class, false), item.getName());
					}
				}
			}

			LOGGER.logDebug("---->Recuepracion de la ciudad de la oficina");
			LocationManagement locManagement = new LocationManagement(super.getServiceIntegration());
			OfficeResponse officeResponse = locManagement.getOffice(originalHeader.get(OriginalHeader.OFFICE), arg1, new BehaviorOption(true));
			if (officeResponse != null) {
				originalHeader.set(OriginalHeader.CITYCODE, officeResponse.getCityId());
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

			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Salida rejectedApplicatcion InitDataRejectedApp");
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.REJECTED_INITDATA_APP, e, arg1, LOGGER);
		}
	}
}
