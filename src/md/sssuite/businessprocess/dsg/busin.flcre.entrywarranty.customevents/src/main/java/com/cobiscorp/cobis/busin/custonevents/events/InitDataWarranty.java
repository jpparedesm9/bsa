package com.cobiscorp.cobis.busin.custonevents.events;

import java.util.List;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.LineAditionalData;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.LineCreditData;
import cobiscorp.ecobis.businessprocess.loanrequest.dto.ProcessedNumber;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.CatalogResponse;
import cobiscorp.ecobis.systemconfiguration.dto.OfficeResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.GuaranteeManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.LocationManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.OfficerManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.LineHeader;
import com.cobiscorp.cobis.busin.model.OfficerAnalysis;
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

public class InitDataWarranty extends BaseEvent implements IInitDataEvent {
	public final static String INCOLLATERALAPPLICATIONREQUEST = "inCollateralApplicationRequest";
	public final static String RETURNCOLLATERALAPPLICATIONRESPONSE = "returnCollateralApplicationResponse";
	private static ILogger LOGGER = LogFactory.getLogger(InitDataWarranty.class);

	public InitDataWarranty(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Ingreso entrywarranty -> InitDataWarranty");

		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		DataEntity generalData = entities.getEntity("generalData");			
		BankingProductInformationByProduct bankingProductManager=new BankingProductInformationByProduct(getServiceIntegration());
		QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());
		int applicationNumber = originalHeader.get(OriginalHeader.APPLICATIONNUMBER);
		TransactionManagement transactionManagement;
		ProcessedNumber processedNumber;
		LocationManagement locManagement;
		ApplicationResponse applicationResponse;
		GuaranteeManagement warranties;

		try {
			// 1.- RECUPERA NUMERO DE TRAMITE
			transactionManagement = new TransactionManagement(super.getServiceIntegration());
			warranties = new GuaranteeManagement(super.getServiceIntegration());
			processedNumber = transactionManagement.getProcessedNumber(applicationNumber, arg1, new BehaviorOption(true));
			if (processedNumber == null) {
				MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_NMRREEUID_75532", MessageLevel.ERROR, true));
				return;
			}
			int codigoTramite = processedNumber.getTramite();
			originalHeader.set(OriginalHeader.IDREQUESTED, codigoTramite + "");

			// 3.- RECUPERA DATOS DEL TRAMITE
			applicationResponse = transactionManagement.getApplication(codigoTramite, arg1, new BehaviorOption(true));
			if (applicationResponse != null) {
				this.setDataApplication(applicationResponse, arg1, entities,generalData);
			} else {
				MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_OENRIFRMS_01004", MessageLevel.ERROR, true));
				return;
			}
			
			// 2.- RECUPERA DATOS DE OFICINA
			locManagement = new LocationManagement(super.getServiceIntegration());
			OfficeResponse officeResponse = locManagement.getOffice(originalHeader.get(OriginalHeader.OFFICE), arg1, new BehaviorOption(true));
			if (officeResponse != null) {
				originalHeader.set(OriginalHeader.CITYCODE, officeResponse.getCityId());
			}

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Application Type " + applicationResponse.getType());

			// 4.- RECUPERA DATOS CUANDO ES LINEA
			if (applicationResponse.getType() != null) {
				if (applicationResponse.getType().equals(Mnemonic.LINEREQUEST)) {
					this.searchLine(entities, arg1, applicationResponse);
				}
			}

			// 5.- RECUPERA DATOS DE LAS GARANTIAS
			GuaranteeManagement.searchCollateral(entities, arg1, super.getServiceIntegration());
			warranties.isWarrantiesHeritageLine(entities, arg1, super.getServiceIntegration());
			//Recupera las garantias heredadas
			if (originalHeader.get(OriginalHeader.TYPEREQUEST).equals("E")||originalHeader.get(OriginalHeader.TYPEREQUEST).equals("R")){
				warranties.isWarrantiesHeritageOtherRequest(entities, arg1, super.getServiceIntegration());
			}
			if(originalHeader.get(OriginalHeader.PRODUCTTYPE)!=null
					||originalHeader.get(OriginalHeader.PRODUCTTYPE).trim()!=""
					||originalHeader.get(OriginalHeader.PRODUCTTYPE)!="null"){
				if (LOGGER.isDebugEnabled()){				
					LOGGER.logDebug(":>:>productType :>:>"+originalHeader.get(OriginalHeader.PRODUCTTYPE));
				}				
				String productName = bankingProductManager.getProductName(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE));
				generalData.set(new Property<String>("productTypeName", String.class, false), productName);
			}else{
				generalData.set(new Property<String>("productTypeName", String.class, false), "--");				
			}
			//nombre de la frecuencia de pago
			generalData.set(new Property<String>("paymentFrecuencyName", String.class, false), "--");
			if(originalHeader.get(OriginalHeader.PAYMENTFREQUENCY)!=null){				
				
				CatalogManagement catalogManagement=new CatalogManagement(this.getServiceIntegration());
				CatalogResponse[] allItemsByTable = catalogManagement.getAllItemsByTable(Mnemonic.CATALOG_PAYMENTFRECUENCY, arg1, new BehaviorOption());
				if (allItemsByTable != null) {
					for (CatalogResponse item : allItemsByTable) {						
						if(item.getCode().trim().equalsIgnoreCase(originalHeader.get(OriginalHeader.PAYMENTFREQUENCY).trim())){							
							generalData.set(new Property<String>("paymentFrecuencyName", String.class, false), item.getValue());
						}
					}
				}				
			}
			
			LOGGER.logDebug("---->Recupera el nombre de frecuencia de pago");
			if (originalHeader.get(OriginalHeader.PAYMENTFREQUENCY) != null) {
				for (CatalogDto item : queryStoredProcedureManagement.getPaymentFrequency((ICommonEventArgs)arg1, new BehaviorOption(true))) {
					if (item.getCode().trim().equalsIgnoreCase(originalHeader.get(OriginalHeader.PAYMENTFREQUENCY).trim())) {
						generalData.set(new Property<String>("paymentFrecuencyName", String.class, false), item.getName());
					}
				}				
			}

			LOGGER.logDebug("---->Ejecucion de servicio para recuperar el sector desde apf");
			String bankingProductID = originalHeader.get(OriginalHeader.PRODUCTTYPE) == null ? "" : originalHeader.get(OriginalHeader.PRODUCTTYPE);
			Sector sector = bankingProductManager.getBankingProductSector(arg1, bankingProductID);
			originalHeader.set(OriginalHeader.PORTFOLIOTYPE, sector.getCode());
			generalData.set(new Property<String>("loanType", String.class, false), sector.getDescription());
			
			//Recupero el parámetro Sector
			List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1,
					originalHeader.get(OriginalHeader.PRODUCTTYPE), "Sector");
			 
			//Asocio el valor del sector  
			for (GeneralParametersValuesHistory sectorNeg : generalParameterCatalog) {
				//generalData.set(new Property<String>("sectorNeg", String.class, false), sectorNeg.getDescription());
				generalData.set(new Property<String>("sectorNeg", String.class, false), sectorNeg.getInheritedFrom());
			}

			arg1.setSuccess(true);
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.INITDATA_WARRANTY, e, arg1, LOGGER);
		}

		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Salida entrywarranty -> InitDataWarranty");
	}

	private void setDataApplication(ApplicationResponse applicationResponse, IDataEventArgs arg1, DynamicRequest entities,DataEntity generalData) {
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		DataEntity officerAnalysis = entities.getEntity(OfficerAnalysis.ENTITY_NAME);		

		if (applicationResponse.getCurrencyRequested() != null) {
			originalHeader.set(OriginalHeader.CURRENCYREQUESTED, String.valueOf(applicationResponse.getCurrencyRequested()));
		}
		if (applicationResponse.getStartDate() != null) {
			originalHeader.set(OriginalHeader.INITIALDATE, applicationResponse.getStartDate().getTime());
		}
		if (applicationResponse.getAmountRequested() != null) {
			originalHeader.set(OriginalHeader.AMOUNTREQUESTED, applicationResponse.getAmountRequested());
		}
		if (applicationResponse.getQuota() != null) {
			originalHeader.set(OriginalHeader.QUOTA, applicationResponse.getQuota());
		}
		originalHeader.set(OriginalHeader.PAYMENTFREQUENCY, applicationResponse.getPaymentFrequency());
		originalHeader.set(OriginalHeader.CREDITTARGET, applicationResponse.getDestinationDescription());
		originalHeader.set(OriginalHeader.TYPEREQUEST, applicationResponse.getType());
		originalHeader.set(OriginalHeader.CREDITLINEVALID, applicationResponse.getCreditLineNumBank());
		originalHeader.set(OriginalHeader.PRODUCTFIE, applicationResponse.getProduct());
		originalHeader.set(OriginalHeader.OFFICERID,applicationResponse.getOfficer().toString());
		originalHeader.set(OriginalHeader.OFFICERNAME,applicationResponse.getOfficialDescription());
		originalHeader.set(OriginalHeader.AGREEMENT, applicationResponse.getAgreement());
		originalHeader.set(OriginalHeader.CODEAGREEMENT, applicationResponse.getCompanyAgreement());

		if (applicationResponse.getAmountRequested() != null) {
			officerAnalysis.set(OfficerAnalysis.SUGGESTEDAMOUNT, applicationResponse.getAmountRequested());
		}
		officerAnalysis.set(OfficerAnalysis.SUGGESTEDCURRENCY, applicationResponse.getCurrencyRequested());
		if (applicationResponse.getDisbursementAmount() != null) {
			officerAnalysis.set(OfficerAnalysis.AMOUNTTODISBURSE, applicationResponse.getDisbursementAmount());
		}
		officerAnalysis.set(OfficerAnalysis.PRODUCTTYPE, applicationResponse.getOpertationType());
		originalHeader.set(OriginalHeader.PRODUCTTYPE, applicationResponse.getOpertationType());
		officerAnalysis.set(OfficerAnalysis.TERM, applicationResponse.getTerm());
		officerAnalysis.set(OfficerAnalysis.TERMFRECUENCY, applicationResponse.getDetailTerm());

		if (applicationResponse.getOfficer() != null) {
			officerAnalysis.set(OfficerAnalysis.OFFICIERNAME, String.valueOf(applicationResponse.getOfficer()));

			// NOMBRE DEL OFICIAL
			OfficerManagement officerMngmt = new OfficerManagement(super.getServiceIntegration());
			String officerName = officerMngmt.getOfficerName(applicationResponse.getOfficer(), arg1, new BehaviorOption(false));
			officerAnalysis.set(OfficerAnalysis.OFFICER, officerName);

		}
		officerAnalysis.set(OfficerAnalysis.SECTOR, applicationResponse.getSectorCustomer());
		officerAnalysis.set(OfficerAnalysis.SERCTORNEG, applicationResponse.getSector());
		officerAnalysis.set(OfficerAnalysis.PROVINCE, applicationResponse.getProvince());
		officerAnalysis.set(OfficerAnalysis.CITY, applicationResponse.getCityDestination());
		officerAnalysis.set(OfficerAnalysis.CREDITLINE, applicationResponse.getPortfolioType());

		// Adry
		if (applicationResponse.getType().equals(Mnemonic.EXPROMISSIONREQUEST) && applicationResponse.getExpromission() != null) {
			LOGGER.logDebug("***** ---  EXPROMISSION!=NULL");
			if (applicationResponse.getExpromission() != null) {
				originalHeader.set(OriginalHeader.EXPROMISSION, applicationResponse.getExpromission());
			}
			if (applicationResponse.getFrequencyPayment() != null) {
				officerAnalysis.set(OfficerAnalysis.TERMFRECUENCY, applicationResponse.getFrequencyPayment());
			}
		}
		LOGGER.logDebug("Carga del campo de vinculado");
		String clienteVinculado=applicationResponse.getLinkedClient()+"";
		if(clienteVinculado.equalsIgnoreCase(Mnemonic.CHAR_S+""))
			generalData.set(new Property<String>("vinculado", String.class, false), Mnemonic.String_Si);
		else
			generalData.set(new Property<String>("vinculado", String.class, false), Mnemonic.String_No);
		
		LOGGER.logDebug("toma del campo simbolo de moneda");
		String simboloMoneda=applicationResponse.getSymbolCurrency().trim();					
		generalData.set(new Property<String>("symbolCurrency", String.class, false), simboloMoneda);
		
	}

	private void searchLine(DynamicRequest entities, IDataEventArgs arg1, ApplicationResponse applicationResponse) {
		DataEntity lineHeader = entities.getEntity(LineHeader.ENTITY_NAME);
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		int applicationNumber = originalHeader.get(OriginalHeader.APPLICATIONNUMBER);
		int codigoTramite = Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED));

		TransactionManagement transactionManagement = new TransactionManagement(super.getServiceIntegration());
		LineCreditData lineResponse = transactionManagement.getCreditLine(codigoTramite, arg1, new BehaviorOption(true));
		lineHeader.set(LineHeader.ROTARY, lineResponse.getRotary());
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Amount Proposed " + lineResponse.getLocalAmount());

		if (lineResponse.getLocalAmount() != null) {
			lineHeader.set(LineHeader.AMOUNTPROPOSED, lineResponse.getAmount().doubleValue());
		}
		if (lineResponse.getCurrency() != null) {
			lineHeader.set(LineHeader.CURRENCYPROPOSED, lineResponse.getCurrency().toString());// cambio
		}
		if (lineResponse.getLocalAmount() != null) {
			lineHeader.set(LineHeader.AMOUNTLOCALCURRENCY, lineResponse.getLocalAmount().doubleValue());
		}
		if (applicationResponse.getStartDate() != null) {
			lineHeader.set(LineHeader.ENTRYDATE, applicationResponse.getStartDate().getTime());
		}
		lineHeader.set(LineHeader.TERM, applicationResponse.getTerm());
		if (lineResponse.getExpirationDate() != null) {
			lineHeader.set(LineHeader.EXPIRATIONDATE, lineResponse.getExpirationDate().getTime());
		}
		lineHeader.set(LineHeader.SECTOR, applicationResponse.getSectorCustomer());
		lineHeader.set(LineHeader.PROVINCE, applicationResponse.getProvince());
		lineHeader.set(LineHeader.GEOGRAOHICDESTINATION, applicationResponse.getCityDestination());

		if (applicationResponse.getOfficer() != null) {
			lineHeader.set(LineHeader.OFFICER, applicationResponse.getOfficer().toString());

			// NOMBRE DEL OFICIAL
			OfficerManagement officerMngmt = new OfficerManagement(super.getServiceIntegration());
			String officerName = officerMngmt.getOfficerName(applicationResponse.getOfficer(), arg1, new BehaviorOption(false));
			lineHeader.set(LineHeader.OFFICERNAME, officerName);

		} // oficial

		LineAditionalData aditionalData = transactionManagement.getAditionalLine(codigoTramite, applicationNumber, arg1, new BehaviorOption(true));
		if (aditionalData != null) {
			lineHeader.set(LineHeader.COMMITTED, aditionalData.getCommitment());
		}
	}

}