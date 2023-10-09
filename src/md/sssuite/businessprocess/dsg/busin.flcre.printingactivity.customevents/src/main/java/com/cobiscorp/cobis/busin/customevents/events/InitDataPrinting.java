package com.cobiscorp.cobis.busin.customevents.events;

import java.util.List;

import com.cobiscorp.cobis.busin.customevents.services.ConsultingClientTeamServices;
import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.DebtorManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.LocationManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.DebtorUtil;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.Context;
import com.cobiscorp.cobis.busin.model.DebtorGeneral;
import com.cobiscorp.cobis.busin.model.DocumentProduct;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.PrintClientsTeam;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
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

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DocumentsResponse;
import cobiscorp.ecobis.businessprocess.loanrequest.dto.ProcessedNumber;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.sales.cloud.dto.ConsultingClientTeamResponse;
import cobiscorp.ecobis.systemconfiguration.dto.CatalogResponse;
import cobiscorp.ecobis.systemconfiguration.dto.OfficeResponse;

public class InitDataPrinting extends BaseEvent implements IInitDataEvent {
	
	private static ILogger LOGGER = LogFactory.getLogger(InitDataPrinting.class);

	public InitDataPrinting(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@SuppressWarnings("unchecked")
	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
		try{
			LOGGER.logDebug("Ingresa A executeDataEvent Init Data>>");
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		DataEntity generalData = entities.getEntity("generalData");			
		DataEntity context = entities.getEntity(Context.ENTITY_NAME);
		BankingProductInformationByProduct bankingProductManager=new BankingProductInformationByProduct(getServiceIntegration());
		QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());
		Boolean haveTramite = false;
		String type="";
		
		TransactionManagement transactionManagement = new TransactionManagement(super.getServiceIntegration());
		ProcessedNumber processedNumber = transactionManagement.getProcessedNumber(originalHeader.get(OriginalHeader.APPLICATIONNUMBER), arg1, new BehaviorOption(true));
		if (processedNumber == null) {
			
			MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_NMRREEUID_75532", MessageLevel.ERROR, true));
			return;
		}
		
		int codigoTramite;		
		codigoTramite= processedNumber.getTramite();		
		LOGGER.logDebug("Ingresa A clientOfTeam Init Data>> 86");
		clientOfTeam( entities, String.valueOf(codigoTramite));
		LOGGER.logDebug("finaliza A clientOfTeam Init Data>> 88");
		
		
		DebtorManagement debManagement = new DebtorManagement(super.getServiceIntegration());
		
		DataEntityList debtors = debManagement.getDebtorsEntityList(codigoTramite, arg1, new BehaviorOption(true));
		
		if(!generalData.get(new Property<String>("Mode", String.class)).equals("NH")){
			
			if (debtors != null){
				
				DataEntity debtor = DebtorUtil.getDebtorEntity(debtors, arg1, new BehaviorOption(false, true));
				
				if(debtor != null) {
					entities.setEntityList(DebtorGeneral.ENTITY_NAME, debtors);
					
				}		
			}
		}
		
		originalHeader.set(OriginalHeader.IDREQUESTED, codigoTramite + "");
		if(!generalData.get(new Property<String>("Mode", String.class)).equals("NH")){
				ApplicationResponse applicationResponse = transactionManagement.getApplication(codigoTramite, arg1, new BehaviorOption(true));
			
			if (applicationResponse != null) {
				haveTramite = true;
				
			} else {
				
				haveTramite = false;
			}
			
			originalHeader.set(OriginalHeader.IDREQUESTED, codigoTramite + "");		
			if (codigoTramite > 0 && haveTramite) {
					
				if (applicationResponse.getMoney() != null) {
					originalHeader.set(OriginalHeader.CURRENCYREQUESTED, String.valueOf(applicationResponse.getMoney()));
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
				if (applicationResponse.getOffice() != null) {
					originalHeader.set(OriginalHeader.OFFICE, applicationResponse.getOffice());
				}
				if (applicationResponse.getPaymentFrequency() != null) {
					originalHeader.set(OriginalHeader.PAYMENTFREQUENCY, applicationResponse.getPaymentFrequency());
				}
				if (applicationResponse.getDestinationDescription() != null) {
					originalHeader.set(OriginalHeader.CREDITTARGET, applicationResponse.getDestinationDescription());
				}
				if (applicationResponse.getType() != null) {
					originalHeader.set(OriginalHeader.TYPEREQUEST, applicationResponse.getType());
				}
	
				if (applicationResponse.getOperationNumberBank() != null) {
					originalHeader.set(OriginalHeader.OPNUMBERBANK, applicationResponse.getOperationNumberBank());
				}
				
				originalHeader.set(OriginalHeader.EXPROMISSION, applicationResponse.getExpromission());
				originalHeader.set(OriginalHeader.TERM, String.valueOf(applicationResponse.getTerm()));
				if (applicationResponse.getCreditLine() != null) {
					LOGGER.logDebug("LINEA: " + applicationResponse.getCreditLine());
					originalHeader.set(OriginalHeader.CREDITLINEVALID, applicationResponse.getCreditLine().toString());
				}
				type=(applicationResponse.getType()!=null)?applicationResponse.getType():"";
				
				originalHeader.set(OriginalHeader.OFFICERID,applicationResponse.getOfficer().toString());
				originalHeader.set(OriginalHeader.OFFICERNAME,applicationResponse.getOfficialDescription());
				originalHeader.set(OriginalHeader.PRODUCTTYPE, applicationResponse.getOpertationType());
				originalHeader.set(OriginalHeader.PRODUCTFIE, applicationResponse.getProduct());
				
				String clienteVinculado=applicationResponse.getLinkedClient()+"";
				if(clienteVinculado.equalsIgnoreCase(Mnemonic.CHAR_S+""))
					generalData.set(new Property<String>("vinculado", String.class, false), Mnemonic.String_Si);
				else
					generalData.set(new Property<String>("vinculado", String.class, false), Mnemonic.String_No);
				
				String simboloMoneda=applicationResponse.getSymbolCurrency().trim();					
				generalData.set(new Property<String>("symbolCurrency", String.class, false), simboloMoneda);
				
				LOGGER.logDebug("---->Oficina TramiteDesc: "+applicationResponse.getOfficeDescriptionTr());
				context.set(Context.OFFICENAME, applicationResponse.getOfficeDescriptionTr());
				
			}
			
				if (originalHeader.get(OriginalHeader.PRODUCTTYPE) != null || originalHeader.get(OriginalHeader.PRODUCTTYPE).trim() != "" || originalHeader.get(OriginalHeader.PRODUCTTYPE) != "null") {
				if (LOGGER.isDebugEnabled()){				
					LOGGER.logDebug(":>:>productType :>:>"+originalHeader.get(OriginalHeader.PRODUCTTYPE));
				}				
				String productName = bankingProductManager.getProductName(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE));
				generalData.set(new Property<String>("productTypeName", String.class, false), productName);				
			}else{
				generalData.set(new Property<String>("productTypeName", String.class, false), "--");				
			}
			
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
			
			if (originalHeader.get(OriginalHeader.PAYMENTFREQUENCY) != null) {
				for (CatalogDto item : queryStoredProcedureManagement.getPaymentFrequency((ICommonEventArgs)arg1, new BehaviorOption(true))) {
					if (item.getCode().trim().equalsIgnoreCase(originalHeader.get(OriginalHeader.PAYMENTFREQUENCY).trim())) {
						generalData.set(new Property<String>("paymentFrecuencyName", String.class, false), item.getName());
					}
				}				
			}

			String bankingProductID = originalHeader.get(OriginalHeader.PRODUCTTYPE) == null ? "" : originalHeader.get(OriginalHeader.PRODUCTTYPE);
			Sector sector = bankingProductManager.getBankingProductSector(arg1, bankingProductID);
			originalHeader.set(OriginalHeader.PORTFOLIOTYPE, sector.getCode());
			generalData.set(new Property<String>("loanType", String.class, false), sector.getDescription());
			
				List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(arg1, originalHeader.get(OriginalHeader.PRODUCTTYPE), "Sector");
			
			for (GeneralParametersValuesHistory sectorNeg : generalParameterCatalog) {
				generalData.set(new Property<String>("sectorNeg", String.class, false), sectorNeg.getDescription());
			}
		}else{
			
			type="C";
			originalHeader.set(OriginalHeader.TYPEREQUEST,type);
		}

		LocationManagement locManagement = new LocationManagement(super.getServiceIntegration());
			
		if(!generalData.get(new Property<String>("Mode", String.class)).equals("NH")){
			OfficeResponse officeResponse = locManagement.getOffice(originalHeader.get(OriginalHeader.OFFICE), arg1, new BehaviorOption(true));
			
			if (officeResponse != null) {				
				originalHeader.set(OriginalHeader.CITYCODE, officeResponse.getCityId());
			} else {
				MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_NODNCOFCI_45206", MessageLevel.ERROR, true));
				return;
				
			}
		}
				
		DocumentsRequest documentsRequest = new DocumentsRequest();
		ServiceRequestTO serviceRequestDocumentsTO = new ServiceRequestTO();
		ServiceResponse serviceResponseDocument = null;
		ServiceResponseTO serviceResponseDocumentsTO = null;		
		documentsRequest.setMode(0);
		documentsRequest.setSubOption(1);
		documentsRequest.setType(type);	
		documentsRequest.setTypeOperation(originalHeader.get(OriginalHeader.PRODUCTTYPE));
		LOGGER.logDebug(":>:>TIPO DE OPERACION:>:>"+documentsRequest.getTypeOperation());
		documentsRequest.setRequest(Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED)));
		serviceRequestDocumentsTO.getData().put(RequestName.INDOCUMENTSREQUEST, documentsRequest);
		
		serviceResponseDocument = execute(getServiceIntegration(), LOGGER, ServiceId.SERVICESEARCHDOCUMENTS, serviceRequestDocumentsTO);
		
		if (serviceResponseDocument.isResult()) {	
			
			serviceResponseDocumentsTO = (ServiceResponseTO) serviceResponseDocument.getData();
			DocumentsResponse[] documentsResponseList = (DocumentsResponse[]) serviceResponseDocumentsTO.getValue(ReturnName.DOCUMENTS);
			DataEntityList documentsEntity = new DataEntityList();

			DocumentsApplicationRequest documentsApplicationRequest = new DocumentsApplicationRequest();
			ServiceRequestTO serviceRequestDocumentsApplicationTO = new ServiceRequestTO();
			ServiceResponse serviceResponseDocumentsApplication = null;
			ServiceResponseTO serviceResponseDocumentsApplictionTO = null;

			documentsApplicationRequest.setIdRequested(Integer.valueOf(originalHeader.get(OriginalHeader.IDREQUESTED)));			
			serviceRequestDocumentsApplicationTO.getData().put(RequestName.INDOCUMENTSAPPLICATIONREQUEST, documentsApplicationRequest);
			serviceResponseDocumentsApplication = execute(getServiceIntegration(), LOGGER, ServiceId.ARCHDOCUMENTSAPPLICATION, serviceRequestDocumentsApplicationTO);
			
			if (serviceResponseDocumentsApplication.isResult()) {
				
				serviceResponseDocumentsApplictionTO = (ServiceResponseTO) serviceResponseDocumentsApplication.getData();
				DocumentsApplicationResponse[] documentsApplicationResponseList = (DocumentsApplicationResponse[]) serviceResponseDocumentsApplictionTO.getValue(ReturnName.DOCUMENTSAPPLICATION);
				
				for (DocumentsResponse documentResponse : documentsResponseList) {
						if (documentResponse.getState() != null) {
							if (!documentResponse.getState().trim().equals("C")) {
					
					DataEntity document = new DataEntity();
					document.set(DocumentProduct.DOCUMENT, documentResponse.getIdDocument().toString());
					document.set(DocumentProduct.YESNOT, false);
					document.set(DocumentProduct.NEMONIC, documentResponse.getMnemonico());
					document.set(DocumentProduct.DESCRIPTION, documentResponse.getDescription());
					document.set(DocumentProduct.TEMPLATE, documentResponse.getTemplate());
					document.set(DocumentProduct.NROIMPRESSIONS, Mnemonic.STRING_0);
					document.set(DocumentProduct.REPORTPARAMGUARANTOR, " ");

					if (documentsApplicationResponseList.length > 0) {
						for (DocumentsApplicationResponse documentApplicationResponse : documentsApplicationResponseList) {
							if (documentResponse.getIdDocument().equals(documentApplicationResponse.getIdDocument())) {
								document.set(DocumentProduct.NROIMPRESSIONS, documentApplicationResponse.getNumber().toString());
							}
						}
					} else {
						document.set(DocumentProduct.NROIMPRESSIONS, Mnemonic.STRING_0);
					}
					documentsEntity.add(document);
				}
						} else {
							LOGGER.logDebug("InitDataPrinting - Algun estado de la imp_documento viene null");
						}
					}
					
				entities.setEntityList(DocumentProduct.ENTITY_NAME, documentsEntity);
			}
		}		
			
		} catch (Exception e) {
			LOGGER.logDebug(">>>>>>>>ERROR>>>>>>>>"+e);
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PRINTACTIVITY_INITDATA_PRINT, e, arg1, LOGGER);
		}
	}
	
	public void clientOfTeam(DynamicRequest entities,String idProcess) throws Exception {
		if (LOGGER.isDebugEnabled()) 
			LOGGER.logDebug(" *****Starting of calling clientOfTeam>>>>>315>>>>"+idProcess);
			DataEntityList clientOfTeam = new DataEntityList();
		ConsultingClientTeamServices consultingClientTeamServices=new ConsultingClientTeamServices(getServiceIntegration());
		ConsultingClientTeamResponse[] responseDataClient= consultingClientTeamServices.consultingClientOfteams(idProcess, getServiceIntegration());
		if(responseDataClient!=null && responseDataClient.length>0) {
			for (ConsultingClientTeamResponse resultDataClientServices : responseDataClient) {				
				if(resultDataClientServices.getTypeSecure()!=null && !resultDataClientServices.getTypeSecure().isEmpty()) {
					DataEntity clientDataResult = new DataEntity();
					clientDataResult.set(PrintClientsTeam.OPERATION, resultDataClientServices.getOperation());
					clientDataResult.set(PrintClientsTeam.IDBANK, resultDataClientServices.getIdBank());
					clientDataResult.set(PrintClientsTeam.IDCLIENT, resultDataClientServices.getIdclient());
					clientDataResult.set(PrintClientsTeam.DATESTART, resultDataClientServices.getDateStart());
					clientDataResult.set(PrintClientsTeam.DATEEND, resultDataClientServices.getDateEnd());
					clientDataResult.set(PrintClientsTeam.AMOUNT, resultDataClientServices.getAmount());
					clientDataResult.set(PrintClientsTeam.STATUSCLIENT, String.valueOf(resultDataClientServices.getStatus()));
					clientDataResult.set(PrintClientsTeam.DATEREPORT, resultDataClientServices.getDateReport());
					clientDataResult.set(PrintClientsTeam.IDPROCESS, resultDataClientServices.getIdProcess());
					clientDataResult.set(PrintClientsTeam.IDTEAM, resultDataClientServices.getIdTeam());
					clientDataResult.set(PrintClientsTeam.AMOUNTPAID, resultDataClientServices.getAmountPaid());
					clientDataResult.set(PrintClientsTeam.AMOUNTRETURNED, resultDataClientServices.getAmountReturned());
					clientDataResult.set(PrintClientsTeam.FORMPAID, resultDataClientServices.getFormPaid());
					clientDataResult.set(PrintClientsTeam.TYPESECURE, resultDataClientServices.getTypeSecure());
					clientOfTeam.add(clientDataResult);
				}
			}
			
			if (LOGGER.isDebugEnabled()) 
				LOGGER.logDebug(" *****SIZE ARRAY>>>>>343>>>"+clientOfTeam.size());
			entities.setEntityList(PrintClientsTeam.ENTITY_NAME, clientOfTeam);
		}
		
		if (LOGGER.isDebugEnabled()) 
			LOGGER.logDebug(" *****END of calling clientOfTeam>>>>>345");
	}
	
}
