package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.math.BigDecimal;
import java.util.Map;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.DetailLoanResponseList;
import cobiscorp.ecobis.loan.dto.HeaderLoanResponse;
import cobiscorp.ecobis.loan.dto.LoanRequest;
import cobiscorp.ecobis.loan.dto.ReadDisbursementFormRequest;
import cobiscorp.ecobis.loan.dto.ReadDisbursementFormResponse;
import cobiscorp.ecobis.loan.dto.ReadDisbursmentFormResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.Convert;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.SessionContext;
import com.cobiscorp.cobis.busin.model.DetailLiquidateValues;
import com.cobiscorp.cobis.busin.model.DisbursementDetail;
import com.cobiscorp.cobis.busin.model.LoanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class DisbursementManagement extends BaseEvent {
	private static final ILogger logger = LogFactory.getLogger(DisbursementManagement.class);
	private ReadDisbursementFormResponse[] readDisbursementFormResponseList;
	private DetailLoanResponseList[] detailLoanResponseList;
	private HeaderLoanResponse headerLoanResponse;

	public ReadDisbursementFormResponse[] getReadDisbursementFormResponseList() {
		return readDisbursementFormResponseList;
	}

	public DetailLoanResponseList[] getDetailLoanResponseList() {
		return detailLoanResponseList;
	}

	public HeaderLoanResponse getHeaderLoanResponse() {
		return headerLoanResponse;
	}

	public DisbursementManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public ReadDisbursmentFormResponse[] readDisbursementForm(ICommonEventArgs arg1, BehaviorOption options) {
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEDISBURSMENTFORM, new ServiceRequestTO());
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("RESULTADO RESULTADO EXISTOSO: " + serviceResponse);
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (ReadDisbursmentFormResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNREADDISBURSMENTFORMRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public boolean searchDisbursementForm(String realBank, String fictitiousBank, ICommonEventArgs arg1, BehaviorOption options) {
		this.readDisbursementFormResponseList = null;
		this.detailLoanResponseList = null;
		this.headerLoanResponse = null;

		ReadDisbursementFormRequest readDisbursementFormRequest = new ReadDisbursementFormRequest();
		readDisbursementFormRequest.setBankReal(realBank);
		readDisbursementFormRequest.setFictitiousBank(fictitiousBank);
		readDisbursementFormRequest.setStepTmp(Mnemonic.STRING_S);
		readDisbursementFormRequest.setFormatDate(SessionContext.getFormatDate());		
		

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INDISBURSEMENTFORM, readDisbursementFormRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEQUERYDISFORMSINFORMATION_BUSIN, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			this.readDisbursementFormResponseList = (ReadDisbursementFormResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNDISBURSEMENT);
			this.detailLoanResponseList = (DetailLoanResponseList[]) serviceItemsResponseTO.getValue(ReturnName.RETURNDETAILRESPONSE);
			this.headerLoanResponse = (HeaderLoanResponse) serviceItemsResponseTO.getValue(ReturnName.RETURNHEADERLOANRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		logger.logDebug(":>:>readDisbursementFormResponseList-length:>:>"+readDisbursementFormResponseList.length);
		logger.logDebug(":>:>detailLoanResponseList-length:>:>"+detailLoanResponseList.length);
		return serviceResponse.isResult();
	}

	public ReadDisbursementFormResponse[] createDisbursementForm(LoanRequest loanRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INLOANREQUEST, loanRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICECREATEDISBURSEMENT, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("RESULTADO RESULTADO EXISTOSO: " + serviceResponse);
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			Map mapa=  serviceItemsResponseTO.getData();
			logger.logDebug("Resultado create disbursement");
			for(Object key:mapa.keySet()){
				logger.logDebug("KEY>>"+key);
				logger.logDebug("VALUE>>"+mapa.get(key));
			}
			return (ReadDisbursementFormResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNDISBURSEMENT);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public static void mapLoanHeaderDisbursementForm(DataEntity loanHeader, HeaderLoanResponse headerLoanResponse) {
		if (headerLoanResponse.getOperationType() != null) {
			loanHeader.set(LoanHeader.PRODUCTTYPE, headerLoanResponse.getOperationType());
		}
		if (headerLoanResponse.getCurrency() != null) {
			loanHeader.set(LoanHeader.CURRENCY, headerLoanResponse.getCurrency().toString());
		}
		if (headerLoanResponse.getOfficeName() != null) {
			loanHeader.set(LoanHeader.OFFICE, headerLoanResponse.getOfficeName());
		}
		if (headerLoanResponse.getAmountApproved() != null) {
			loanHeader.set(LoanHeader.PROPOSEDAMOUNT, new BigDecimal(headerLoanResponse.getAmountApproved()));
		}
		if (headerLoanResponse.getAmountOpt() != null) {
			loanHeader.set(LoanHeader.AMOUNTTODISBURSE, new BigDecimal(headerLoanResponse.getAmountOpt()));
		}
		if (headerLoanResponse.getInitialDate() != null) {
			loanHeader.set(LoanHeader.INITIALDATE, Convert.CString.toDate(headerLoanResponse.getInitialDate()));
		}
		if (headerLoanResponse.getValueDiscount() != null) {
			loanHeader.set(LoanHeader.VALUEDISCOUNT, new BigDecimal(headerLoanResponse.getValueDiscount()));
		}
		if (headerLoanResponse.getValueDisburse() != null) {
			loanHeader.set(LoanHeader.VALUETODISBURSE, new BigDecimal(headerLoanResponse.getValueDisburse()));
		}
		if (headerLoanResponse.getAmountOpt() != null && headerLoanResponse.getValueDiscount() != null) {
			loanHeader.set(LoanHeader.BALANCEOPERATION,
					new BigDecimal(headerLoanResponse.getAmountOpt()).subtract(new BigDecimal(headerLoanResponse.getValueDiscount())).setScale(2, BigDecimal.ROUND_HALF_UP));
		}
	}

	public static void mapDetailLoanResponseList(DynamicRequest entities, DetailLoanResponseList[] listDetailLoanResponseList) {
		DataEntityList detailLiquidateValues = new DataEntityList();
		for (DetailLoanResponseList detailResponselist : listDetailLoanResponseList) {
			DataEntity eDetailLoan = new DataEntity();
			eDetailLoan.set(DetailLiquidateValues.CONCEPT, Convert.StringToString(detailResponselist.getConcept(), ""));
			eDetailLoan.set(DetailLiquidateValues.DESCRIPTION, Convert.StringToString(detailResponselist.getDescription(), ""));
			eDetailLoan.set(DetailLiquidateValues.VALUE, Convert.DoubleToBigDecimal(detailResponselist.getAmount(), new BigDecimal(0)));
			eDetailLoan.set(DetailLiquidateValues.SIGN, Convert.StringToString(detailResponselist.getSign(), ""));

			detailLiquidateValues.add(eDetailLoan);
		}
		entities.setEntityList(DetailLiquidateValues.ENTITY_NAME, detailLiquidateValues);
		if(logger.isDebugEnabled()){
			logger.logDebug(":>:>detailLiquidateValues:>:>"+detailLiquidateValues.getDataList());			
		}
	}

	public static void mapDisbursementFormResponseList(DynamicRequest entities, DataEntity loanHeader, ReadDisbursementFormResponse[] readDisbursementFormResponseList) {
		DataEntityList disbursementEntity = new DataEntityList();
		for (ReadDisbursementFormResponse disbur : readDisbursementFormResponseList) {
			DataEntity eDisburment = new DataEntity();
			eDisburment.set(DisbursementDetail.SEQUENTIAL, disbur.getSequential());
			eDisburment.set(DisbursementDetail.DISBURSEMENTID, disbur.getDisbursementId());
			eDisburment.set(DisbursementDetail.DISBURSEMENTFORM, Convert.StringToString(disbur.getDisbursementrate(), ""));
			eDisburment.set(DisbursementDetail.CURRENCY, Convert.StringToString(disbur.getCurrency(), ""));
			eDisburment.set(DisbursementDetail.DISBURSEMENTVALUE, (disbur.getAmount() != null) ? disbur.getAmount() : new BigDecimal(0));
			eDisburment.set(DisbursementDetail.AMOUNTMOP, Convert.DoubleToBigDecimal(disbur.getAmountm(), new BigDecimal(0)));
			eDisburment.set(DisbursementDetail.VALUEML, Convert.DoubleToBigDecimal(disbur.getAmountmn(), new BigDecimal(0)));
			if (disbur.getAmountm() != null) {
				loanHeader.set(LoanHeader.BALANCEOPERATION, loanHeader.get(LoanHeader.BALANCEOPERATION).subtract(new BigDecimal(disbur.getAmountm())).setScale(2, BigDecimal.ROUND_HALF_UP));
			}
			eDisburment.set(DisbursementDetail.PRICEQUOTE, BigDecimal.valueOf(disbur.getQuote()));

			disbursementEntity.add(eDisburment);
		}
		entities.setEntityList(DisbursementDetail.ENTITY_NAME, disbursementEntity);
		if(logger.isDebugEnabled()){
			logger.logDebug(":>:>disbursmentDetail:>:>"+disbursementEntity.getDataList());			
		}
	}


}
