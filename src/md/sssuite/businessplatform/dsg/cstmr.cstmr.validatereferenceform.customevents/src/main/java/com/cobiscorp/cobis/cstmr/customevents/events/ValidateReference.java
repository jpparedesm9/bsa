package com.cobiscorp.cobis.cstmr.customevents.events;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.ReferenceInfor;
import com.cobiscorp.cobis.cstmr.model.ReferenceReq;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.PurchaseReferenceRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.PurchaseReferenceResponse;
import com.cobiscorp.ecobis.customer.commons.prospect.services.BusinessPartnerReference;


public class ValidateReference extends BaseEvent implements IExecuteCommand{
    private static final ILogger LOGGER = LogFactory.getLogger(ValidateReference.class);

    public ValidateReference(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

    @Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.logDebug("Start executeCommand in ValidateReference");
            }
			validateReference(getPurchaseReferenceRequest(entities),args);


        } catch (BusinessException e) {
			LOGGER.logDebug("BusinessException: Error al Cambiar Vale" , e);
			args.setSuccess(false);
			args.getMessageManager().showErrorMsg(e.getMessage());
		} catch (Exception e) {
			LOGGER.logDebug("Exception: Error al Cambiar Vale" , e);
			args.setSuccess(false);
			args.getMessageManager().showErrorMsg("Error al Cambiar Vale");
		} finally {
			LOGGER.logDebug("Finish executeCommand in ValidateReference");			
		}
    }

	public void validateReference(PurchaseReferenceRequest wPurchaseReferenceRequest,IExecuteCommandEventArgs args) 
            throws BusinessException{
        if (LOGGER.isDebugEnabled()) {
            LOGGER.logDebug("Start validateReference in ValidateReference");
        }
        //PurchaseReferenceResponse wPurchaseRefResp = new PurchaseReferenceResponse();

        BusinessPartnerReference busPartRef = new BusinessPartnerReference(getServiceIntegration());
        HashMap<String, String> outputsError = busPartRef.validateReference(wPurchaseReferenceRequest, args);
        Integer errorNumber = Integer.valueOf(outputsError.get("@o_error"));
        if(errorNumber != null && errorNumber != 0){
            throw new BusinessException(errorNumber, String.valueOf(outputsError.get("@o_mensaje")));
        }
        if (LOGGER.isDebugEnabled()) {
            LOGGER.logDebug("Finish validateReference in ValidateReference");
        }
        //return wPurchaseRefResp;
    }

    private PurchaseReferenceRequest getPurchaseReferenceRequest(DynamicRequest entities){
        PurchaseReferenceRequest wPurchRefReq = new PurchaseReferenceRequest();
        if (LOGGER.isDebugEnabled()) {
            LOGGER.logDebug("Start getReferenceRequest in ValidateReference");
        }
        DataEntity refReq = entities.getEntity(ReferenceReq.ENTITY_NAME);
        String refNumber = refReq.get(ReferenceReq.REFERENCENUMBER);
        Calendar processDate =  getProcessDateAndTime(entities.getEntity(ReferenceInfor.ENTITY_NAME));
        Double purchaseAmount = refReq.get(ReferenceReq.PURCHASEAMOUNT);

        wPurchRefReq.setRefNumber(refNumber);
        wPurchRefReq.setDateProcess(processDate);
        wPurchRefReq.setAmountToRequest(purchaseAmount);

        if (LOGGER.isDebugEnabled()) {
            LOGGER.logDebug("Finish getReferenceRequest in ValidateReference");
        }
        return wPurchRefReq;
    }

    private Calendar getProcessDateAndTime(DataEntity statusInfor){
        Date dateIn = statusInfor.get(ReferenceInfor.OPERATIONDATE);
        Date timeIn = statusInfor.get(ReferenceInfor.OPERATIONTIME);
        Calendar dateCal = GregorianCalendar.getInstance();
        if(dateIn != null){
            dateCal.setTime(dateIn);
            Calendar timeCal = GregorianCalendar.getInstance();
            if(timeIn != null){
                timeCal.setTime(timeIn);
            }
            dateCal.set(Calendar.HOUR, timeCal.get(Calendar.HOUR));
            dateCal.set(Calendar.MINUTE, timeCal.get(Calendar.MINUTE));
            return dateCal;
        }
        return null;
    }
	
}