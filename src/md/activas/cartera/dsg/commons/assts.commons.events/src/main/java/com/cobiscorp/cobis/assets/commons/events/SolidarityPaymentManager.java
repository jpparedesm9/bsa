package com.cobiscorp.cobis.assets.commons.events;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import cobiscorp.ecobis.assets.cloud.dto.SolidarityPaymentDetailRequest;
import cobiscorp.ecobis.assets.cloud.dto.SolidarityPaymentDetailResponse;
import cobiscorp.ecobis.assets.cloud.dto.SolidarityPaymentRequest;
import cobiscorp.ecobis.assets.cloud.dto.SolidarityPaymentResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.SolidarityPayment;
import com.cobiscorp.cobis.assts.model.SolidarityPaymentDetail;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class SolidarityPaymentManager  extends BaseEvent {
	
	private static final ILogger LOGGER = LogFactory.getLogger(SolidarityPaymentManager.class);
	public static final String SOLIDARITY_REQUEST = "inSolidarityPaymentRequest";
	public static final String SOLIDARITY_RESPONSE = "returnSolidarityPaymentResponse";
	public static final String SOLIDARITYDETAIL_REQUEST = "inSolidarityPaymentDetailRequest";
	public static final String SOLIDARITYDETAIL_RESPONSE = "returnSolidarityPaymentDetailResponse";

	public SolidarityPaymentManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	
	public void readSolidarityByOperation(DynamicRequest entities, ICommonEventArgs args) throws ParseException {
		
		LOGGER.logDebug("Start readSolidarityByOperation in SolidarityPaymentManager");
		
		DataEntity solidarityTmp = entities.getEntity(SolidarityPayment.ENTITY_NAME);
		LOGGER.logDebug("solidarityTmp Solidarity---" + solidarityTmp);
		String operationCode = solidarityTmp.get(SolidarityPayment.GROUPOPERATIONCODE);
		LOGGER.logDebug("operationCode Solidarity---" + operationCode);
		
		SolidarityPaymentRequest request = new SolidarityPaymentRequest();
		request.setGroupOperationCode(operationCode);
		SolidarityPaymentManager solidarityManager = new SolidarityPaymentManager(getServiceIntegration());
		SolidarityPaymentResponse solidarity = solidarityManager.searchSolidarity(request, args);
		
		DataEntity solidarityEntity = new DataEntity();
		Date dateTmp = null;
		SimpleDateFormat formatDate = new SimpleDateFormat("dd/MM/yyyy");
		
		LOGGER.logDebug("SolidarityPayment SETEANDO >>");
		solidarityEntity.set(SolidarityPayment.GROUPOPERATIONCODE, operationCode);
		solidarityEntity.set(SolidarityPayment.GROUPCODE, solidarity.getGroupCode());
		solidarityEntity.set(SolidarityPayment.NAMEGROUP, solidarity.getNameGroup());
		LOGGER.logDebug("NAMEGROUP >>" + solidarity.getNameGroup());
		solidarityEntity.set(SolidarityPayment.GROUPCYCLE, solidarity.getGroupCycle());
		LOGGER.logDebug("GROUPCYCLE >>" + solidarity.getGroupCycle());
		
		if (solidarity.getApplicationDate() != null) {
			dateTmp = formatDate.parse(solidarity.getApplicationDate());
		}
		
		solidarityEntity.set(SolidarityPayment.APPLICATIONDATE, dateTmp);
		solidarityEntity.set(SolidarityPayment.ADVISOR, solidarity.getAdvisor());
		solidarityEntity.set(SolidarityPayment.BRANCHOFFICE, solidarity.getBranchOffice());
		solidarityEntity.set(SolidarityPayment.TYPECREDIT, solidarity.getTypeCredit());
		solidarityEntity.set(SolidarityPayment.GROUPAMOUNT, solidarity.getGroupAmount());
		LOGGER.logDebug("GROUPAMOUNT monto >>" + solidarity.getGroupAmount());
		solidarityEntity.set(SolidarityPayment.RATE, solidarity.getRate());
		solidarityEntity.set(SolidarityPayment.TERM, solidarity.getTerm());
		solidarityEntity.set(SolidarityPayment.BALANCEGUARANTEE, solidarity.getBalanceGuarantee());
		solidarityEntity.set(SolidarityPayment.OWEDQUOTAS, solidarity.getOwedQuotas());
		LOGGER.logDebug("OWEDQUOTAS Solidiarity >>" + solidarity.getOwedQuotas());
		
		dateTmp = null;
		if (solidarity.getExpirationDate() != null) {
			dateTmp = formatDate.parse(solidarity.getExpirationDate());
		}
		solidarityEntity.set(SolidarityPayment.EXPIRATIONDATE, dateTmp);
		solidarityEntity.set(SolidarityPayment.AMOUNTSOLIDARITYPAYMENT, solidarity.getAmountSolidarityPayment());
		solidarityEntity.set(SolidarityPayment.PAYDEBITACCOUNTS, ("S".equals(solidarity.getPayDebitAccounts()) ? true : false));
		solidarityEntity.set(SolidarityPayment.MODIFICATIONFEE, solidarity.getModificationFee());
		solidarityEntity.set(SolidarityPayment.MAXFEE, solidarity.getMaxFee());
		
		entities.setEntity(SolidarityPayment.ENTITY_NAME, solidarityEntity);
		
		LOGGER.logDebug("End readSolidarityByOperation in SolidarityPaymentManager");
			
	}
	
	
	public void searchSolidarityDetailByOperation(DynamicRequest entities, ICommonEventArgs args) throws ParseException {
		
		LOGGER.logDebug("Start searchSolidarityDetailByOperation in SolidarityPaymentManager");
		
		DataEntity solidarityTmp = entities.getEntity(SolidarityPayment.ENTITY_NAME);
		LOGGER.logDebug("solidarityTmp Solidarity---" + solidarityTmp);
		String operationCode = solidarityTmp.get(SolidarityPayment.GROUPOPERATIONCODE);
		LOGGER.logDebug("operationCode Solidarity---" + operationCode);
		Integer group = solidarityTmp.get(SolidarityPayment.GROUPCODE);
		LOGGER.logDebug("operationCode Solidarity---" + group);
		Integer dividendo = solidarityTmp.get(SolidarityPayment.MODIFICATIONFEE);
		
		SolidarityPaymentRequest request = new SolidarityPaymentRequest();
		request.setGroupOperationCode(operationCode);
		request.setGroupCode(group);
		request.setModificationFee(dividendo);
		SolidarityPaymentManager solidarityManager = new SolidarityPaymentManager(getServiceIntegration());
		SolidarityPaymentDetailResponse[] solidarityDetail = solidarityManager.searchSolidarityDetail(request, args);
		DataEntityList solidarityList = new DataEntityList();
		
		LOGGER.logDebug("SOLIDARITY DETAIL ---" + solidarityDetail);
		for (SolidarityPaymentDetailResponse resp : solidarityDetail) {
			DataEntity solidarityDetailEntity = new DataEntity();
			
			solidarityDetailEntity.set(SolidarityPaymentDetail.GROUPOPERATIONCODE, operationCode);
			solidarityDetailEntity.set(SolidarityPaymentDetail.GROUPCODE, group);
			LOGGER.logDebug("GROUPCODE EN EL FOR ---" + resp.getGroupCode());
			solidarityDetailEntity.set(SolidarityPaymentDetail.CUSTOMERCODE, resp.getCustomerCode());
			solidarityDetailEntity.set(SolidarityPaymentDetail.CUSTOMERNAME, resp.getCustomerName());
			solidarityDetailEntity.set(SolidarityPaymentDetail.PAYMENTAMOUNT, resp.getPaymentAmount());
			solidarityDetailEntity.set(SolidarityPaymentDetail.FEE, resp.getFee());
			solidarityDetailEntity.set(SolidarityPaymentDetail.PAIDOUT, resp.getPaidOut());
			solidarityDetailEntity.set(SolidarityPaymentDetail.EXPIRED, resp.getExpired());
			solidarityDetailEntity.set(SolidarityPaymentDetail.DIVIDEND, resp.getDividend());
			solidarityDetailEntity.set(SolidarityPaymentDetail.OPERATIONSON, resp.getOperationSon());
			
			LOGGER.logDebug("EXPIRED Solidiarity Detail >>" + resp.getExpired());
			
			solidarityList.add(solidarityDetailEntity);
		}
		LOGGER.logDebug("solidarityList Size>>" + solidarityList.size());

		entities.setEntityList(SolidarityPaymentDetail.ENTITY_NAME, solidarityList);
	}
	
	
	public void updateSolidarityDetail(DynamicRequest entities, ICommonEventArgs args ) throws ParseException {

		DataEntityList solidarity = entities.getEntityList(SolidarityPaymentDetail.ENTITY_NAME);
		entities.setEntityList(SolidarityPaymentDetail.ENTITY_NAME, solidarity);

		// Lista de Pago Solidario
		for (DataEntity dataEntity : solidarity) {
			SolidarityPaymentManager solidarityManager = new SolidarityPaymentManager(getServiceIntegration());
			SolidarityPaymentDetailRequest detailRequest = new SolidarityPaymentDetailRequest();
			
			detailRequest.setGroupOperationCode(dataEntity.get(SolidarityPaymentDetail.GROUPOPERATIONCODE));
			detailRequest.setOperationSon(dataEntity.get(SolidarityPaymentDetail.OPERATIONSON));
			detailRequest.setDividend(dataEntity.get(SolidarityPaymentDetail.DIVIDEND));
			detailRequest.setPaymentAmount(dataEntity.get(SolidarityPaymentDetail.PAYMENTAMOUNT));
			
			solidarityManager.updateSolidarityDetail(detailRequest, args);
		}
		
		
	}
	
	
	public SolidarityPaymentResponse searchSolidarity(SolidarityPaymentRequest solidarityRequest, ICommonEventArgs arg1) throws BusinessException {
		SolidarityPaymentManager callService = new SolidarityPaymentManager(getServiceIntegration());
		SolidarityPaymentResponse solidarityResponse = (SolidarityPaymentResponse) callService.callServiceWithReturn(SOLIDARITY_REQUEST, solidarityRequest, Parameter.READ_SOLIDARITY,
				SOLIDARITY_RESPONSE, arg1);
		return solidarityResponse;
	}
	
	public SolidarityPaymentDetailResponse[] searchSolidarityDetail(SolidarityPaymentRequest solidiarityRequest, ICommonEventArgs arg1) throws BusinessException {
		SolidarityPaymentManager callService = new SolidarityPaymentManager(getServiceIntegration());

		SolidarityPaymentDetailResponse[] business = callService.callServiceWithReturnArray(SOLIDARITY_REQUEST, solidiarityRequest, Parameter.SEARCH_SOLIDARITY_DETAIL,
				SOLIDARITYDETAIL_RESPONSE, arg1);
		return business == null ? new SolidarityPaymentDetailResponse[0] : business;
	}
	
	public void updateSolidarityDetail(SolidarityPaymentDetailRequest solidarityRequest, ICommonEventArgs arg1) throws BusinessException {
		SolidarityPaymentManager callService = new SolidarityPaymentManager(getServiceIntegration());
		callService.callService(SOLIDARITYDETAIL_REQUEST, solidarityRequest, Parameter.UPDATE_SOLIDARITY_DETAIL, arg1);
	}
	
	
	
	
	public void callService(String requestName, Object object, String serviceId, ICommonEventArgs arg1) throws BusinessException {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start callService");
		try {
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			serviceRequestTO.addValue(requestName, object);
			ServiceResponse serviceResponse = execute(this.getServiceIntegration(), LOGGER, serviceId, serviceRequestTO);
			if (serviceResponse != null) {
				if (serviceResponse.isResult()) {
					arg1.setSuccess(true);
				} else {
					for (Message message : serviceResponse.getMessages()) {
						arg1.getMessageManager().showErrorMsg(message.getMessage());
					}
					arg1.setSuccess(false);
				}
			}

		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Finish callService");
		}
	}
	
	public Object callServiceWithReturn(String requestName, Object object, String serviceId, String returnValue, ICommonEventArgs arg1) throws BusinessException {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start callServiceWithReturn");
		try {
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			serviceRequestTO.addValue(requestName, object);
			ServiceResponse serviceResponse = execute(this.getServiceIntegration(), LOGGER, serviceId, serviceRequestTO);
			if (serviceResponse != null) {
				if (serviceResponse.isResult()) {
					ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
					arg1.setSuccess(true);
					return serviceResponseTO.getValue(returnValue);

				} else {
					for (Message message : serviceResponse.getMessages()) {
						arg1.getMessageManager().showErrorMsg(message.getMessage());
					}

				}
			}

			arg1.setSuccess(false);
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Finish callServiceWithReturn");
		}
		return null;
	}

	public <T> T[] callServiceWithReturnArray(String requestName, Object object, String serviceId, String returnValue, ICommonEventArgs arg1) throws BusinessException {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start callServiceWithReturnArray");
		ServiceResponseTO serviceResponseTO = new ServiceResponseTO();
		serviceResponseTO.setSuccess(false);
		try {
			ServiceResponse serviceResponse = null;
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();

			if (requestName == null && object == null) {
				serviceResponse = execute(this.getServiceIntegration(), LOGGER, serviceId, serviceRequestTO);

			} else {

				serviceRequestTO.addValue(requestName, object);
				serviceResponse = execute(this.getServiceIntegration(), LOGGER, serviceId, serviceRequestTO);
			}
			LOGGER.logDebug("1 ---");
			if (serviceResponse != null) {
				LOGGER.logDebug("2 ---");
				if (serviceResponse.isResult()) {
					LOGGER.logDebug("3 ---");
					serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
					arg1.setSuccess(true);

					if (serviceResponseTO.getValue(returnValue) == null) {
						LOGGER.logDebug("callServiceWithReturnArray ---> null");
						return (T[]) serviceResponseTO.getValue(returnValue);
					} else {
						LOGGER.logDebug("callServiceWithReturnArray --->" + serviceResponseTO.getValue(returnValue));
						return (T[]) serviceResponseTO.getValue(returnValue);

					}

				} else {
					LOGGER.logDebug("4 ---");
					for (Message message : serviceResponse.getMessages()) {
						arg1.getMessageManager().showErrorMsg(message.getMessage());
					}

				}
			}
			LOGGER.logDebug("5 ---");
			arg1.setSuccess(false);
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Finish callServiceWithReturnArray");
		}
		return (T[]) serviceResponseTO.getValue(returnValue);
	}


}
