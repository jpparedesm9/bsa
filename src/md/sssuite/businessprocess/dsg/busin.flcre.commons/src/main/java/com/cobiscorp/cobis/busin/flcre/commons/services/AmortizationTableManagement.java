package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.math.BigDecimal;
import java.util.List;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.ReadLoanAmortizationTableRequest;
import cobiscorp.ecobis.loan.dto.ReadLoanAmortizationTableResponse;
import cobiscorp.ecobis.loan.dto.ReadLoanAmortizationTableResponseTable;
import cobiscorp.ecobis.loan.dto.ReadLoanPaymentResponse;
import cobiscorp.ecobis.loan.dto.ReadLoanPaymentrequest;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.AmortizationTableHeader;
import com.cobiscorp.cobis.busin.model.AmortizationTableItem;
import com.cobiscorp.cobis.busin.model.PaymentPlan;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.busin.model.CatalogDto;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;

public class AmortizationTableManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(AmortizationTableManagement.class);

	public AmortizationTableManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public void getAndMapAmortizationTable(String bank, DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {
		getAmortizationTable(bank, ServiceId.AMORTIZATIONTABLE, entities, arg1, options);
	}

	public void getAndMapAmortizationTableTmp(String bank, DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {
		getAmortizationTable(bank, ServiceId.AMORTIZATIONTABLETMP, entities, arg1, options);
	}
	
	public void getAndMapAmortizationTableHeaderTmp(String bank, DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {
		getAmortizationTableHeader(bank, ServiceId.AMORTIZATIONTABLETMP, entities, arg1, options);
	}

	private void getAmortizationTable(String bank, String serviceId, DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {
		ReadLoanAmortizationTableRequest inDto = new ReadLoanAmortizationTableRequest();
		inDto.setBank(bank);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INLOANAMORTIZATIONTABLEREQUEST, inDto);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, serviceId, serviceRequestTO);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("OK resultado tabla amortizacion - BANCO: " + bank);
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			ReadLoanAmortizationTableResponse[] headerResponse = (ReadLoanAmortizationTableResponse[]) serviceResponseTO.getValue(ReturnName.AMORTIZATIONTABLEHEADERS);
			if (logger.isDebugEnabled())
				logger.logDebug("----->headerResponse" + headerResponse);
			ReadLoanAmortizationTableResponseTable[] itemsTableResponse = (ReadLoanAmortizationTableResponseTable[]) serviceResponseTO.getValue(ReturnName.AMORTIZATIONTABLEITEMS);

			if (headerResponse != null) {
				DataEntityList header = new DataEntityList();
				for (ReadLoanAmortizationTableResponse iteratorHeader : headerResponse) {
					DataEntity eHeader = new DataEntity();
					if (logger.isDebugEnabled())
						logger.logDebug("Descripcion: " + iteratorHeader.getDescription() + ", Concepto: " + iteratorHeader.getConcept());
					eHeader.set(AmortizationTableHeader.DESCRIPTION, iteratorHeader.getDescription());
					eHeader.set(AmortizationTableHeader.CONCEPT, iteratorHeader.getConcept());

					header.add(eHeader);
				}
				entities.setEntityList(AmortizationTableHeader.ENTITY_NAME, header);
			}
			if (itemsTableResponse != null) {
				DataEntityList items = new DataEntityList();
				for (ReadLoanAmortizationTableResponseTable iteratorItem : itemsTableResponse) {
					DataEntity eItem = new DataEntity();
					eItem.set(AmortizationTableItem.DIVIDEND, iteratorItem.getDividend());
					eItem.set(AmortizationTableItem.EXPIRATIONDATE, iteratorItem.getExpirationDate().getTime());
					eItem.set(AmortizationTableItem.BALANCE, iteratorItem.getBalance());
					eItem.set(AmortizationTableItem.ITEM1, iteratorItem.getItem1());
					eItem.set(AmortizationTableItem.ITEM2, iteratorItem.getItem2());
					eItem.set(AmortizationTableItem.ITEM3, iteratorItem.getItem3());
					eItem.set(AmortizationTableItem.ITEM4, iteratorItem.getItem4());
					eItem.set(AmortizationTableItem.ITEM5, iteratorItem.getItem5());
					eItem.set(AmortizationTableItem.ITEM6, iteratorItem.getItem6());
					eItem.set(AmortizationTableItem.ITEM7, iteratorItem.getItem7());
					eItem.set(AmortizationTableItem.ITEM8, iteratorItem.getItem8());
					eItem.set(AmortizationTableItem.ITEM9, iteratorItem.getItem9());
					eItem.set(AmortizationTableItem.ITEM10, iteratorItem.getItem10());
					eItem.set(AmortizationTableItem.ITEM11, iteratorItem.getItem11());
					eItem.set(AmortizationTableItem.ITEM12, iteratorItem.getItem12());
					eItem.set(AmortizationTableItem.ITEM13, iteratorItem.getItem13());
					eItem.set(AmortizationTableItem.FEE, iteratorItem.getShare());
					items.add(eItem);
				}
				entities.setEntityList(AmortizationTableItem.ENTITY_NAME, items);
			}
		} else {
			if (logger.isDebugEnabled())
				logger.logDebug("Error BUSCAR tabla amortizacion - BANCO: " + bank);
			MessageManagement.show(serviceResponse, arg1, options);
		}
	}

	private void getAmortizationTableHeader(String bank, String serviceId, DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {
		ReadLoanAmortizationTableRequest inDto = new ReadLoanAmortizationTableRequest();
		inDto.setBank(bank);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INLOANAMORTIZATIONTABLEREQUEST, inDto);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, serviceId, serviceRequestTO);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("OK resultado header tabla amortizacion - BANCO: " + bank);
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			ReadLoanAmortizationTableResponse[] headerResponse = (ReadLoanAmortizationTableResponse[]) serviceResponseTO.getValue(ReturnName.AMORTIZATIONTABLEHEADERS);
			if (logger.isDebugEnabled())
				logger.logDebug("----->headerResponse" + headerResponse);			

			if (headerResponse != null) {
				DataEntityList header = new DataEntityList();
				for (ReadLoanAmortizationTableResponse iteratorHeader : headerResponse) {
					DataEntity eHeader = new DataEntity();
					if (logger.isDebugEnabled())
						logger.logDebug("Descripcion: " + iteratorHeader.getDescription() + ", Concepto: " + iteratorHeader.getConcept());
					eHeader.set(AmortizationTableHeader.DESCRIPTION, iteratorHeader.getDescription());
					eHeader.set(AmortizationTableHeader.CONCEPT, iteratorHeader.getConcept());

					header.add(eHeader);
				}
				entities.setEntityList(AmortizationTableHeader.ENTITY_NAME, header);
			}
			
		} else {
			if (logger.isDebugEnabled())
				logger.logDebug("Error BUSCAR HEADER tabla amortizacion - BANCO: " + bank);
			MessageManagement.show(serviceResponse, arg1, options);
		}
	}
	
	public BigDecimal getFirstQuoteValue(int customerCode, int applicationNumber, ICommonEventArgs arg1, BehaviorOption options) {
		BigDecimal value = new BigDecimal(0);

		ReadLoanPaymentrequest readLoanPaymentrequest = new ReadLoanPaymentrequest();
		readLoanPaymentrequest.setCustomer(customerCode);
		readLoanPaymentrequest.setInstanciaWf(applicationNumber);
		ServiceRequestTO serviceRequestDisponibleSTO = new ServiceRequestTO();
		serviceRequestDisponibleSTO.getData().put(RequestName.INREADLOANPAYMENTREQUEST, readLoanPaymentrequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEREADLOANPAYMENT, serviceRequestDisponibleSTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceValidateResponseTO = (ServiceResponseTO) serviceResponse.getData();
			ReadLoanPaymentResponse[] readLoanPaymentResponseList = (ReadLoanPaymentResponse[]) serviceValidateResponseTO.getValue(ReturnName.LOANRESPONSE);
			if (readLoanPaymentResponseList != null && readLoanPaymentResponseList.length > 0) {
				for (ReadLoanPaymentResponse finanValoResponsea : readLoanPaymentResponseList) {
					if (finanValoResponsea.getPayment() != null) {
						value = new BigDecimal(finanValoResponsea.getPayment());
					}
				}
			}
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return value;
	}

	public boolean validateTermAndPaymentFrecuency(String paymentFrequency, Integer plazo, String productType, DynamicRequest entities, ICommonEventArgs args) throws Exception {

		Integer plazoApf = 0, factorApf = 0, factor = 0;
		Integer daysApf  = 0,  days = 0;
		String paymentFrequencyAfp = "", namePaymentFrequencyAfp = "";
		if (logger.isDebugEnabled())
			logger.logDebug("Start validateTermAndPaymentFrecuency in AmortizationTableManagement");
		try {
			QueryStoredProcedureManagement queryStoredProcedureManagement = new QueryStoredProcedureManagement(getServiceIntegration());
			BankingProductInformationByProduct bankingProductManager = new BankingProductInformationByProduct(getServiceIntegration());
			DataEntity paymentPlan = entities.getEntity(PaymentPlan.ENTITY_NAME);

			if (logger.isDebugEnabled())
				logger.logDebug("---->Valida variables de entrada");
			if ("".equals(paymentFrequency) && plazo == 0) {
				args.getMessageManager().showErrorMsg("El plazo debe ser diferente de cero y la frecuencia es obligatoria");
				return false;
			}

			if (logger.isDebugEnabled())
				logger.logDebug("---->Recuerapcion de parametro de plazo en apf");
			for (GeneralParametersValuesHistory generalParametersValuesHistory : bankingProductManager.getCatalogGeneralParameter(args, productType, Mnemonic.PLAZO)) {
				plazoApf = Integer.parseInt(generalParametersValuesHistory.getValue());

			}

			if (logger.isDebugEnabled())
				logger.logDebug("---->Recuerapcion de parametro de tipo cuota en apf");
			for (GeneralParametersValuesHistory generalParametersValuesHistory : bankingProductManager.getCatalogGeneralParameter(args, productType, Mnemonic.TIPO_CUOTA)) {
				paymentFrequencyAfp = generalParametersValuesHistory.getValue().trim();
			}

			if (logger.isDebugEnabled())
				logger.logDebug("---->Recupera del factor de acuerdo a la factor de pago del apf");
			List<CatalogDto> catalogDtoList = queryStoredProcedureManagement.getPaymentFrequency(args, new BehaviorOption(true));
			for (CatalogDto catalogDto : catalogDtoList) {
				logger.logDebug("---->Catalogo: "+catalogDto.getCode().trim());
				if (paymentFrequencyAfp.equals(catalogDto.getCode().trim())) {
					namePaymentFrequencyAfp = catalogDto.getName();
					factorApf = Integer.valueOf(catalogDto.getDescription1().trim());
					break;
				}
			}
			
				logger.logDebug("---->Recupera del factor de acuerdo a la factor de pago");
			for (CatalogDto catalogDto : catalogDtoList) {
				if (paymentFrequency.equals(catalogDto.getCode().trim())) {
					factor = Integer.valueOf(catalogDto.getDescription1().trim());
					break;
				}
			}
            
			if (logger.isDebugEnabled()){
				logger.logDebug("---->daysApf----> en apf --"+ String.valueOf(daysApf));
				logger.logDebug("---->plazoApf de parametro de tipo cuota en apf --" + String.valueOf(plazoApf));
				logger.logDebug("---->factorApf de parametro de tipo cuota en apf--"+String.valueOf(factorApf));
				logger.logDebug("---->days de parametro de tipo cuota en apf--"+String.valueOf(days));
				logger.logDebug("---->plazo de parametro de tipo cuota en apf--"+String.valueOf(plazo));
				logger.logDebug("---->factor de parametro de tipo cuota en apf--"+String.valueOf(factor));
				
			}
			
			 daysApf = plazoApf * factorApf;
			 days = plazo * factor;
			
			if (logger.isDebugEnabled()){
				logger.logDebug("---->daysApf----> en apf --" + String.valueOf(daysApf) );
				logger.logDebug("---->plazoApf de parametro de tipo cuota en apf --" + String.valueOf(plazoApf));
				logger.logDebug("---->factorApf de parametro de tipo cuota en apf--"+String.valueOf(factorApf));
				logger.logDebug("---->days de parametro de tipo cuota en apf--"+String.valueOf(days));
				logger.logDebug("---->plazo de parametro de tipo cuota en apf--"+String.valueOf(plazo));
				logger.logDebug("---->factor de parametro de tipo cuota en apf--"+String.valueOf(factor));
			}

			//if (days > 0 && days <= daysApf) {
			//	paymentPlan.set(PaymentPlan.TERM, plazo);
			//} else {
			//	throw new BusinessException(703037, "El plazo debe estar en el rango configurado el en producto ( Frecuencia: " + namePaymentFrequencyAfp + " Plazo: " + plazoApf
			//			+ " )");
			//}

		} catch (Exception ex) {
			if (logger.isDebugEnabled())
				logger.logError("Error validateTermAndPaymentFrecuency in AmortizationTableManagement: " + ex);
			throw ex;
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("Finish validateTermAndPaymentFrecuency in AmortizationTableManagement");
		}

		return true;

	}
	

	public void commitPaymentPlan(Object[] object){
		
		logger.logDebug(":>:>commitPaymentPlan:>:>");
		String serviceId="ICommitPaymentPlan.commitPaymentPlan";		
		ServiceResponse serviceResponse = null;
		serviceResponse = execute(getServiceIntegration(),logger,serviceId,object);
		if(serviceResponse.isResult()){
			logger.logDebug(":>:>commitPaymentPlan Servicio Retorna TRUE:>:>");
		}else
			logger.logDebug(":>:>commitPaymentPlan Servicio Retorna FALSE:>:>");
			
		logger.logDebug(":>:>Fin Service commitPaymentPlan:>:>");
	}
	
}
