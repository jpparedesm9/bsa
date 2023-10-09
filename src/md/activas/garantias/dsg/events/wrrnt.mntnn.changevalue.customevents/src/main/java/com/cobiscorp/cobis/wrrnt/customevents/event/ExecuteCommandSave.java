package com.cobiscorp.cobis.wrrnt.customevents.event;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import cobiscorp.ecobis.collateral.dto.GuaranteeTranRequest;
import cobiscorp.ecobis.collateral.dto.GuaranteeTranResponse;
import cobiscorp.ecobis.collateral.dto.TypeGuaranteeData;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.wrrnt.commons.utils.Constant;
import com.cobiscorp.cobis.wrrnt.commons.utils.Function;
import com.cobiscorp.cobis.wrrnt.model.GenericTransaction;
import com.cobiscorp.cobis.wrrnt.model.Warranty;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.api.util.ServerParamUtil;
import com.cobiscorp.designer.api.util.SessionUtil;
import com.cobiscorp.designer.common.BaseEvent;

public class ExecuteCommandSave extends BaseEvent implements IExecuteCommand{
	
	public ExecuteCommandSave(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	private static final ILogger LOGGER = LogFactory
			.getLogger(ExecuteCommandSave.class);

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		changeValue(entities, args);
		
	}
	
	public Map<String, Object> getAditionalData(DynamicRequest entities, IExecuteCommandEventArgs args){
		if (LOGGER.isDebugEnabled()){
			LOGGER.logDebug("getTransactionData***");
		}
		
		GuaranteeTranResponse guaranteeTranResponse = new GuaranteeTranResponse();
		TypeGuaranteeData typeGuaranteeData = new TypeGuaranteeData();
		Map<String, Object> result = new HashMap<String, Object>();
		
		ServiceRequestTO request = new ServiceRequestTO();
		GuaranteeTranRequest guaranteeTranRequest = new GuaranteeTranRequest();
		DataEntity warranty = entities.getEntity(Warranty.ENTITY_NAME);
		
		Integer filial=1;
		
		
		if (SessionUtil.getFilial()!=null)
		{
		filial = Integer.parseInt(SessionUtil.getFilial());
		}
		
		guaranteeTranRequest.setCompany(filial);
		guaranteeTranRequest.setOffice(warranty.get(Warranty.OFFICE));
		guaranteeTranRequest.setCustodyType(warranty.get(Warranty.TYPE));
		guaranteeTranRequest.setCustody(warranty.get(Warranty.CUSTODY));
		guaranteeTranRequest.setFormatDate(Constant.INT_103);
		guaranteeTranRequest.setOperation(Constant.CHAR_S);
		
		request.addValue("inGuaranteeTranRequest", guaranteeTranRequest);
		ServiceResponse response = this.execute(getServiceIntegration(), LOGGER,
				com.cobiscorp.cobis.wrrnt.commons.utils.Constant.SERVICE_READTRANSACTION, request);

		
		if (response != null && response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response
					.getData();
			
			GuaranteeTranResponse[] guaranteeTranResponseList = (GuaranteeTranResponse[]) resultado.getValue(Constant.RETURN_GUARANTEETRANRESPONSE);

			if (guaranteeTranResponseList != null && guaranteeTranResponseList.length > 0 ) {
				guaranteeTranResponse = guaranteeTranResponseList[0];
			}
            TypeGuaranteeData[] typeGuaranteeDataList = (TypeGuaranteeData[]) resultado.getValue(Constant.RETURN_TYPEGUARANTEEDATA);
			
			if (typeGuaranteeDataList != null && typeGuaranteeDataList.length > 0 ) {
				typeGuaranteeData = typeGuaranteeDataList[0];
			}
			result.put(Constant.RETURN_GUARANTEETRANRESPONSE, guaranteeTranResponse);
			result.put(Constant.RETURN_TYPEGUARANTEEDATA, typeGuaranteeData);
		} else {
			Function.handleResponse(args, response, null);
		}
		return result;

	}
	
	
	public void changeValue(DynamicRequest entities,
			IExecuteCommandEventArgs args){
		if (LOGGER.isDebugEnabled()){
			LOGGER.logDebug("CHANGE VALUE***");
		}
		//OBTENER VARIABLES DE ENTORNO: FILIA, OFICINA, FECHA
		Integer filial=1;
		String user = "";
		BigDecimal coverageAmount=new BigDecimal(0);
		BigDecimal transactionValue = new BigDecimal(0);
		BigDecimal compPercent = new BigDecimal(0);
		BigDecimal valueComp = new BigDecimal(0);
		
		
		if (SessionUtil.getFilial()!=null)	filial = Integer.parseInt(SessionUtil.getFilial());
		if (SessionUtil.getUser()!=null) user = SessionUtil.getUser();
		
		String processDate = ServerParamUtil.getProcessDate();
		Date tranDate= Function.convertStringToFullDate(processDate, Constant.DATEFORMAT_MMddyyyy);
		
		//OBTENER VARIABLES DESDE LOS SERVICIOS
		
		ServiceRequestTO request = new ServiceRequestTO();
		
		GuaranteeTranRequest guaranteeTranRequest = new GuaranteeTranRequest();
		GuaranteeTranResponse transaction;
		TypeGuaranteeData typeGuarantee;
		
		BigDecimal newValue;
		
		Map<String, Object> aditionalData = new HashMap<String, Object>();
		
		aditionalData = getAditionalData(entities, args);
		
		transaction= (GuaranteeTranResponse)aditionalData.get(Constant.RETURN_GUARANTEETRANRESPONSE);
		typeGuarantee = (TypeGuaranteeData)aditionalData.get(Constant.RETURN_TYPEGUARANTEEDATA);
		
		DataEntity warranty = entities.getEntity(Warranty.ENTITY_NAME);
		DataEntity genericTransaction = entities.getEntity(GenericTransaction.ENTITY_NAME);
		genericTransaction.set(GenericTransaction.CAUSE, "CAMBIO DE VALOR DE LA GARANTIA");
		
		if (typeGuarantee.getPercentage()!= null && typeGuarantee.getPercentage()> 0){
			coverageAmount = genericTransaction.get(GenericTransaction.NEWVALUE).multiply(new BigDecimal(typeGuarantee.getPercentage()/100));
		}else {
			coverageAmount = genericTransaction.get(GenericTransaction.NEWVALUE);
		}
		
		newValue = genericTransaction.get(GenericTransaction.NEWVALUE);
		if (transaction.getPercent() !=null){
			compPercent = new BigDecimal(transaction.getPercent()/100);	
		}
		valueComp = newValue.multiply(compPercent);
		
		transactionValue = transaction.getActualValue().add(valueComp).add(transaction.getRecoveredValue());
		
		guaranteeTranRequest.setCompany(filial);
		guaranteeTranRequest.setOffice(warranty.get(Warranty.OFFICE));
		guaranteeTranRequest.setCustodyType(warranty.get(Warranty.TYPE));
		guaranteeTranRequest.setCustody(warranty.get(Warranty.CUSTODY));
		guaranteeTranRequest.setTransactionDate(Function.dateToCalendar(tranDate));
		guaranteeTranRequest.setNewCommercialAmount(newValue);
		guaranteeTranRequest.setCoverageAmount(coverageAmount.abs());
		
		if (transactionValue.compareTo(new BigDecimal(0))>1){
			guaranteeTranRequest.setTransactionType(Constant.CHAR_C);	
		}else{
			guaranteeTranRequest.setTransactionType(Constant.CHAR_D);
		}
		guaranteeTranRequest.setAmount(transactionValue);//CALCULAR
		guaranteeTranRequest.setSharesNumber(Constant.INT_0);//En el monolítico envía cuando existe parametro VCUACC
		guaranteeTranRequest.setShareAmount(new BigDecimal(Constant.INT_0));//En el monolítico envía cuando existe parametro VCUACC
		guaranteeTranRequest.setDescription(genericTransaction.get(GenericTransaction.CAUSE));
		guaranteeTranRequest.setLogin(user);
		guaranteeTranRequest.setOperation(Constant.CHAR_I);
		
		request.addValue("inGuaranteeTranRequest", guaranteeTranRequest);
		ServiceResponse response = this.execute(getServiceIntegration(), LOGGER,
				com.cobiscorp.cobis.wrrnt.commons.utils.Constant.SERVICECHANGEVALUE, request);
		
		Function.handleResponse(args, response, null);		
	}

}
