package com.cobiscorp.cobis.busin.customevents.events;

import java.math.BigDecimal;
import java.util.List;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ApplicationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.QuoteRequest;
import cobiscorp.ecobis.businessprocess.loanrequest.dto.ProcessedNumber;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.DetailLoanResponseList;
import cobiscorp.ecobis.loan.dto.HeaderLoanResponse;
import cobiscorp.ecobis.loan.dto.LoanRequest;
import cobiscorp.ecobis.loan.dto.ReadDisbursementFormResponse;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.ApplicationType;
import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.BankingProductInformationByProduct;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.DisbursementManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.OperationManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.QueryStoredProcedureManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.TransactionManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.Context;
import com.cobiscorp.cobis.busin.model.LoanHeader;
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

public class InitDataDisbursement extends BaseEvent implements IInitDataEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(InitDataDisbursement.class);
	private ReadDisbursementFormResponse[] readDisbursementFormResponseList;	

	public InitDataDisbursement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {
		
		
		try{
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Ingreso -> IInitDataEvent -> InitDataDisbursement");
			Integer destinationMoney = 0;
			String operationBank = "";
			this.readDisbursementFormResponseList = null;

			DataEntity loanHeader = entities.getEntity(LoanHeader.ENTITY_NAME);
			DataEntity context = entities.getEntity(Context.ENTITY_NAME);
			DataEntity generalData = entities.getEntity("generalData");
			TransactionManagement tranManager = new TransactionManagement(super.getServiceIntegration());
			DisbursementManagement disbursementMngmt = new DisbursementManagement(super.getServiceIntegration());
			BankingProductInformationByProduct bankingProductManager=new BankingProductInformationByProduct(getServiceIntegration());
			QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());
			
			loanHeader.set(LoanHeader.LOCKDELETE, false);
			loanHeader.set(LoanHeader.LOCKCODE, "__");		

			// RECUPERA NUMERO DE TRAMITE
			ProcessedNumber processedNumberDTO = tranManager.getProcessedNumber(loanHeader.get(LoanHeader.PROCESSNUMBER), args, new BehaviorOption(true));
			if (processedNumberDTO == null) {
				MessageManagement.show(args, new MessageOption("BUSIN.DLB_BUSIN_NMRREEUID_75532", MessageLevel.ERROR, true));
				return;
			}

			//Campo 7
			String fieldSeven = "";
			if (processedNumberDTO.getFieldSeven() != null) {
				fieldSeven = processedNumberDTO.getFieldSeven().trim();
			}

			// RECUPERA DATOS DEL TRAMITE
			ApplicationResponse applicationResponseDTO = tranManager.getApplication(processedNumberDTO.getTramite(), args, new BehaviorOption(true));
			if (applicationResponseDTO == null) {
				MessageManagement.show(args, new MessageOption("BUSIN.DLB_BUSIN_OENRIFRMS_01004", MessageLevel.ERROR, true));
				return;
			} else {
				if (applicationResponseDTO.getOperationNumberBank() != null && !applicationResponseDTO.getOperationNumberBank().isEmpty()) {
					operationBank = applicationResponseDTO.getOperationNumberBank();
				} else {
					operationBank = String.valueOf(processedNumberDTO.getTramite());
				}
			}
			
			if (fieldSeven.equals(ApplicationType.SOLIDARITY_GROUP)) {
				if (LOGGER.isDebugEnabled())
					LOGGER.logDebug("applicationResponseDTO.getSumRequestedAmountGroup()" + applicationResponseDTO.getSumRequestedAmountGroup());
				if(applicationResponseDTO.getSumRequestedAmountGroup() != null){
					context.set(Context.AMOUNTREQUESTED, applicationResponseDTO.getSumRequestedAmountGroup().doubleValue());
				}
				context.set(Context.CUSTOMERID, applicationResponseDTO.getGroup());
				context.set(Context.CYCLENUMBER, applicationResponseDTO.getCycleNumber());
			}else{
				if(applicationResponseDTO.getAmountRequested()!=null){
					context.set(Context.AMOUNTREQUESTED, applicationResponseDTO.getAmountRequested().doubleValue());	
				}					
			}
			if (applicationResponseDTO.getCreditLineNumBank() != null) {
				loanHeader.set(LoanHeader.CREDITLINEVALID, applicationResponseDTO.getCreditLineNumBank());
			}

			loanHeader.set(LoanHeader.OPERATION, String.valueOf(processedNumberDTO.getTramite()));
			loanHeader.set(LoanHeader.OPERATIONBANCK, operationBank);
			loanHeader.set(LoanHeader.INITIALDATE, applicationResponseDTO.getStartDate().getTime());
			generalData.set(new Property<Integer>("Term", Integer.class,true), applicationResponseDTO.getTerm());
			
			String frecuencia=applicationResponseDTO.getPaymentFrequency();
			
			LOGGER.logDebug("Carga del campo de vinculado");
			String clienteVinculado=applicationResponseDTO.getLinkedClient()+"";
			if(clienteVinculado.equalsIgnoreCase(Mnemonic.CHAR_S+""))
				generalData.set(new Property<String>("vinculado", String.class, false), "Si");
			else
				generalData.set(new Property<String>("vinculado", String.class, false), "No");
			
			LOGGER.logDebug("toma del campo simbolo de moneda");
			String simboloMoneda=applicationResponseDTO.getSymbolCurrency().trim();					
			generalData.set(new Property<String>("symbolCurrency", String.class, false), simboloMoneda);
			

			// BORRA OPERACION DE TABLAS TEMPORALES
			tranManager.deleteTmpTables(operationBank, args, new BehaviorOption(true));
			if (!operationBank.equals(String.valueOf(processedNumberDTO.getTramite()))) {
				tranManager.deleteTmpTables(String.valueOf(processedNumberDTO.getTramite()), args, new BehaviorOption(true));
			}

			// CONSULTA LAS FORMAS DE DESEMBOLSO PREVIAMENTE INGRESADAS
			
			if (!disbursementMngmt.searchDisbursementForm(operationBank, operationBank, args, new BehaviorOption(true))) {
				args.setSuccess(false);
				return;
			}
			
			this.readDisbursementFormResponseList = disbursementMngmt.getReadDisbursementFormResponseList();
			DetailLoanResponseList[] listDetailLoanResponseList = disbursementMngmt.getDetailLoanResponseList();
			HeaderLoanResponse headerLoanResponse = disbursementMngmt.getHeaderLoanResponse();

			// CONSULTA LA MONEDA(LOCAL) PARA OBTENER SU COTIZACION
			if (headerLoanResponse.getCurrency() != null) {
				destinationMoney = headerLoanResponse.getCurrency();
			}
			CatalogManagement catalogMngmnt = new CatalogManagement(super.getServiceIntegration());
			ParameterResponse parameterResponse = catalogMngmnt.getParameter(4, Mnemonic.PARAMETER_MLO, Mnemonic.PRODUCT_ADMIN, args, new BehaviorOption(true));
			if (parameterResponse != null) {
				String localMoney = parameterResponse.getParameterValue();
				QuoteRequest quoteRequest = new QuoteRequest();
				quoteRequest.setCurrencyOrigin(destinationMoney);// quoteRequest.setCurrencyOrigin(Integer.parseInt(localMoney));
				quoteRequest.setCurrencyDestination(Integer.parseInt(localMoney));// quoteRequest.setCurrencyDestination(destinationMoney);
				quoteRequest.setOffice(loanHeader.get(LoanHeader.OFFICEID));
				quoteRequest.setModule(Mnemonic.MODULE);
				Double cotization = null;

				if (destinationMoney == Integer.parseInt(localMoney))
					cotization = tranManager.getQuote(quoteRequest, args, new BehaviorOption(true));
				/*else
					cotization = tranManager.getQuoteUSD(quoteRequest, args, new BehaviorOption(true));*/

				if (cotization != null) {
					loanHeader.set(LoanHeader.PRICEQUOTE, cotization);
				}
			}		
			// DATOS CABECERA DE LA PANTALLA
			
			DisbursementManagement.mapLoanHeaderDisbursementForm(loanHeader, headerLoanResponse);
			// DETALLE VALORES A LIQUIDAR
			DisbursementManagement.mapDetailLoanResponseList(entities, listDetailLoanResponseList);
			// DETALLE DESEMBOLSO
			DisbursementManagement.mapDisbursementFormResponseList(entities, loanHeader, this.readDisbursementFormResponseList);
			if(loanHeader.get(LoanHeader.PRODUCTTYPE)!=null||loanHeader.get(LoanHeader.PRODUCTTYPE).trim()!=""){
				if (LOGGER.isDebugEnabled()){				
					LOGGER.logDebug(":>:>productType :>:>"+loanHeader.get(LoanHeader.PRODUCTTYPE));
				}				
				String productName = bankingProductManager.getProductName(args, loanHeader.get(LoanHeader.PRODUCTTYPE));
				generalData.set(new Property<String>("productTypeName", String.class, false), productName);
			}else{
				generalData.set(new Property<String>("productTypeName", String.class, false), "--");				
			}
			//nombre del oficial
			generalData.set(new Property<String>("officerName", String.class, false), "--");
			if(applicationResponseDTO.getOfficialDescription()!=null){													
				generalData.set(new Property<String>("officerName", String.class, false), applicationResponseDTO.getOfficialDescription());							
			}
			
			LOGGER.logDebug("---->Recupera el nombre de frecuencia de pago");
			if (frecuencia != null) {
				for (CatalogDto item : queryStoredProcedureManagement.getPaymentFrequency((ICommonEventArgs)args, new BehaviorOption(true))) {
					if (item.getCode().trim().equalsIgnoreCase(frecuencia.trim())) {
						generalData.set(new Property<String>("paymentFrecuencyName", String.class, false), item.getName());
					}
				}				
			}
			
			LOGGER.logDebug("---->Ejecucion de servicio para recuperar el sector desde apf");
			String bankingProductID = loanHeader.get(OriginalHeader.PRODUCTTYPE) == null ? "" : loanHeader.get(OriginalHeader.PRODUCTTYPE);
			Sector sector = bankingProductManager.getBankingProductSector(args, bankingProductID);
			loanHeader.set(OriginalHeader.PORTFOLIOTYPE, sector.getCode());
			generalData.set(new Property<String>("loanType", String.class, false), sector.getDescription());
			
			//Recupero el parámetro Sector
			List<GeneralParametersValuesHistory> generalParameterCatalog = bankingProductManager.getCatalogGeneralParameter(args,
					loanHeader.get(OriginalHeader.PRODUCTTYPE), "Sector");
			 
			//Asocio el valor del sector  
			for (GeneralParametersValuesHistory sectorNeg : generalParameterCatalog) {
				generalData.set(new Property<String>("sectorNeg", String.class, false), sectorNeg.getDescription());
			}
			
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.DISBURSEMENT_INITDATA, e, args, LOGGER);
		}
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Salida -> IInitDataEvent -> InitDataDisbursement");
	}

	private boolean validateDisbursementformForRefinancing(DynamicRequest entities, IDataEventArgs args,String operationBank) {
		// CONSULTA PARAMETRO DE - CODIGO PARA FORMA DE DESEMBOLSO DE REFINANCIAMIENTO
		CatalogManagement catalogMngmnt = new CatalogManagement(super.getServiceIntegration());
		ParameterResponse parameterResponse = catalogMngmnt.getParameter(4,Mnemonic.PARAMETER_FPREF, Mnemonic.PRODUCT, args, new BehaviorOption(true));
		if (parameterResponse == null) {
			args.getMessageManager().showErrorMsg("BUSIN.DLB_CANES_MEPPGDNAT_73269");
			args.setSuccess(false);
			return false;
		}
		DataEntity loanHeader = entities.getEntity(LoanHeader.ENTITY_NAME);
		loanHeader.set(LoanHeader.LOCKCODE, parameterResponse.getParameterValue());

		// BUSCA QUE EXISTA ESA FORMA DE DESEMBOLSO
		for (ReadDisbursementFormResponse disbur : this.readDisbursementFormResponseList) {
			if (disbur.getDisbursementrate().equals(parameterResponse.getParameterValue())) {
				return true;
			}
		}

		// SI LLEGO HASTA AQUI SIGNIFICA QUE NO EXISTE, HAY QUE CREAR LA FORMA DE DESEMBOLSO
		BigDecimal amountRequested = this.sumRefinancingAmount(Integer.parseInt(loanHeader.get(LoanHeader.CURRENCY)), Integer.parseInt(loanHeader.get(LoanHeader.OPERATION)), args);
		/*if (amountRequested) { //LA SUMA NUNCA VA A DAR NULL
			args.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_RRURLMSOA_90796");
			args.setSuccess(false);
			return false;
		}*/
		LoanRequest loanRequest = new LoanRequest();
		loanRequest.setRoyalBank(operationBank);
		loanRequest.setShellbank(operationBank);
		// loanRequest.setCotizOp(entityDisbursement.get(DisbursementIncome.QUOTATION));
		loanRequest.setAccount("");
		loanRequest.setOfficeChg(loanHeader.get(LoanHeader.OFFICEID));
		loanRequest.setBeneficiary("GENERACION AUTOMATICA");
		loanRequest.setAmountDs(amountRequested.doubleValue());
		loanRequest.setCurrencyDs(Integer.parseInt(loanHeader.get(LoanHeader.CURRENCY)));
		loanRequest.setCotizDs(loanHeader.get(LoanHeader.PRICEQUOTE));
		loanRequest.setCurrencyOP(Integer.parseInt(loanHeader.get(LoanHeader.CURRENCY)));
		loanRequest.setCotizOp(loanHeader.get(LoanHeader.PRICEQUOTE));
		loanRequest.setDescription(parameterResponse.getParameterName());
		loanRequest.setObservation("DESEMBOLSO AUTOMATICO - REFINANCIAMIENTO");
		// loanRequest.setAmountDsDec(entityDisbursement.get(DisbursementIncome.DISBURSEMENTVALUEDEC));
		loanRequest.setProduct(parameterResponse.getParameterValue());
		loanRequest.setTcotizOp(Mnemonic.CHAR_N);
		loanRequest.setTCotisDs(Mnemonic.CHAR_N);

		DisbursementManagement disbursementMngmt = new DisbursementManagement(super.getServiceIntegration());
		ReadDisbursementFormResponse[] listDisbursementForm = disbursementMngmt.createDisbursementForm(loanRequest, args, new BehaviorOption(true));
		if (listDisbursementForm != null) {
			return true;
		}
		return false;
	}

	private BigDecimal sumRefinancingAmount(int currencyDestination, int requetId, IDataEventArgs arg1) {
		BigDecimal amountRequested = new BigDecimal(0);
		OperationManagement operationManagement = new OperationManagement(super.getServiceIntegration());
		amountRequested = operationManagement.calculateAmountInAnyCurrency(currencyDestination, requetId, arg1);
		if (amountRequested == null) {
			amountRequested = new BigDecimal(0);
		}
		return amountRequested;
	}

}
