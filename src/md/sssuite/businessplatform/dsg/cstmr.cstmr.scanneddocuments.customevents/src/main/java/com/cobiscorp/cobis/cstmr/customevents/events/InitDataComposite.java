package com.cobiscorp.cobis.cstmr.customevents.events;



import java.util.List;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.loanrequest.dto.ProcessedNumber;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.Context;
import com.cobiscorp.cobis.cstmr.model.GeneralData;
import com.cobiscorp.cobis.cstmr.model.OriginalHeader;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.MessageManagement;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.MessageOption;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;



public class InitDataComposite extends BaseEvent implements IInitDataEvent{
	private static final ILogger LOGGER = LogFactory.getLogger(InitDataComposite.class);

	public InitDataComposite(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
		// TODO Auto-generated method stub
		DataEntity generalData = entities.getEntity(GeneralData.ENTITY_NAME);
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		DataEntity context = entities.getEntity(Context.ENTITY_NAME);
		QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());
		CustomerRequest customerRequest = new CustomerRequest();

		try {
			int idCliente = generalData.get(GeneralData.CLIENTID)!= null ? generalData.get(GeneralData.CLIENTID): 0 ;
			LOGGER.logDebug("idCliente: "+idCliente);
			BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(getServiceIntegration());
			
			LOGGER.logDebug("APPLICATIONNUMBER: "+originalHeader.get(OriginalHeader.APPLICATIONNUMBER));
			int applicationNumber = originalHeader.get(OriginalHeader.APPLICATIONNUMBER) == null ? 0 : originalHeader.get(OriginalHeader.APPLICATIONNUMBER);
			String cycle = "";
			
			LOGGER.logDebug("---->Recupera el numero del tramite");
			TransactionManagement transactionManagement = new TransactionManagement(super.getServiceIntegration());
			ProcessedNumber processedNumber = transactionManagement.getProcessedNumber(applicationNumber, arg1, new BehaviorOption(true));
			if (processedNumber == null) {
				MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_NMRREEUID_75532", MessageLevel.ERROR, true));
				return;
			}
			int codigoTramite = processedNumber.getTramite();

			originalHeader.set(OriginalHeader.IDREQUESTED, codigoTramite + "");
			LOGGER.logDebug("---->codigoTramite" + codigoTramite);
			LOGGER.logDebug("---->Si el coddigo del tramite es diferente de cero recupera la informacion asociada al tramite");
			if (codigoTramite != 0) {
				LOGGER.logDebug("---->Recupera los datos del tramite");
				ApplicationResponse creditApplication = transactionManagement.getApplication(codigoTramite, arg1, new BehaviorOption(true));
				if (creditApplication != null) {
					context.set(Context.OFFICENAME, creditApplication.getOfficeDescriptionTr());
					LOGGER.logDebug("getOperationNumber: "+creditApplication.getOperationNumber());
					// Recupero el numero de operacion
					if (creditApplication.getOperationNumber() != null) {
						originalHeader.set(OriginalHeader.OPERATIONNUMBER, creditApplication.getOperationNumber());
					}
					LOGGER.logDebug("getOpertationType: "+creditApplication.getOpertationType());
					generalData.set(GeneralData.PRODUCTTYPENAME, creditApplication.getOpertationType());
					generalData.set(GeneralData.PAYMENTFRECUENCYNAME, creditApplication.getTermTypeDescrip());
					
					String clienteVinculado = creditApplication.getLinkedClient() + "";
					LOGGER.logDebug("getLinkedClient: "+creditApplication.getLinkedClient());
					if (clienteVinculado.equalsIgnoreCase("S"))
						generalData.set(GeneralData.VINCULADO, "Si");
					else
						generalData.set(GeneralData.VINCULADO, "No");

					originalHeader.set(OriginalHeader.CURRENCYREQUESTED, creditApplication.getCurrencyRequested().toString());
					originalHeader.set(OriginalHeader.AMOUNTAPROVED, creditApplication.getApprovedAmount());
					originalHeader.set(OriginalHeader.AMOUNTREQUESTED, creditApplication.getAmountRequested());
					originalHeader.set(OriginalHeader.TERM, creditApplication.getTerm());
					originalHeader.set(OriginalHeader.PRODUCTTYPE, creditApplication.getOpertationType());
					originalHeader.set(OriginalHeader.SUBTYPE, creditApplication.getSubtype());
					
					List<GeneralParametersValuesHistory> generalParameterCatalogCategory = bankingProductManager.getCatalogGeneralParameter(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE), "Categoría");
					for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalogCategory) {
						LOGGER.logDebug("CATEGORY: "+generalParametersValuesHistory.getDescription());
						originalHeader.set(OriginalHeader.CATEGORY, generalParametersValuesHistory.getDescription());
					}
					
					// Recupero el parámetro Sector
					List<GeneralParametersValuesHistory> generalParameterCatalogSector = bankingProductManager.getCatalogGeneralParameter(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE), "Sector");
					// Asocio el valor del sector
					for (GeneralParametersValuesHistory sectorNeg : generalParameterCatalogSector) {
						generalData.set(GeneralData.SECTORNEG, sectorNeg.getDescription());
					} 
					
					LOGGER.logDebug("---->Recupero los parametros del tipo de frecuencia");
					List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE), "Tipo de cuota");
					for (GeneralParametersValuesHistory generalParametersValuesHistory : generalParameterCatalog) {
						LOGGER.logDebug("Entra a frequencia: "+generalParametersValuesHistory.getDescription());
						originalHeader.set(OriginalHeader.PAYMENTFREQUENCY, generalParametersValuesHistory.getDescription());
					}
					LOGGER.logDebug("getPaymentFrequency: "+creditApplication.getPaymentFrequency());

					String simboloMoneda = creditApplication.getSymbolCurrency().trim();
					generalData.set(GeneralData.SYMBOLCURRENCY, simboloMoneda);
					
					customerRequest.setCustomerId(idCliente);
					customerRequest.setModo(0);
					CustomerResponse customerResponse = transactionManagement.readDataCustomer(customerRequest, arg1, new BehaviorOption(true));
					LOGGER.logDebug("getCicleNumberEn: "+customerResponse.getCicleNumberEn());
					int ciclo = customerResponse.getCicleNumberEn();
					context.set(Context.FLAG1, ciclo);
	
				} else {
					LOGGER.logDebug("Entra a error en data de tramite");
					MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_OENRIFRMS_01004", MessageLevel.ERROR, true));
					arg1.setSuccess(false);
					return;

				}
			}
			
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.INITDATA_SCANNED, e, arg1, LOGGER);
		}
	}

}
