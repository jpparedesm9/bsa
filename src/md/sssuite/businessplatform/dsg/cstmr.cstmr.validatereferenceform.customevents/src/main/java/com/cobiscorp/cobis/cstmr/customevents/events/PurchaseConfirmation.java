package com.cobiscorp.cobis.cstmr.customevents.events;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.text.SimpleDateFormat;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.ReferenceInfor;
import com.cobiscorp.cobis.cstmr.model.ReferenceReq;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import cobiscorp.ecobis.customerdatamanagement.dto.PurchaseReferenceRequest;
import com.cobiscorp.ecobis.customer.commons.prospect.services.BusinessPartnerReference;
import com.cobiscorp.cobis.cstmr.commons.events.GeneralFunction;

public class PurchaseConfirmation extends BaseEvent implements IExecuteCommand {
    private static final ILogger LOGGER = LogFactory.getLogger(PurchaseConfirmation.class);
    private static final String FORMATDATE20 = "yyyy-MM-dd HH:mm:ss";
    public PurchaseConfirmation(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

    @Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		DataEntity statusInfor = new DataEntity();
        try {
            LOGGER.logDebug("Start executeCommand in PurchaseConfirmation");
			statusInfor = entities.getEntity(ReferenceInfor.ENTITY_NAME);
			purchaseConfirmation(statusInfor, getPurchaseReferenceRequest(entities), args);
			

        } catch (BusinessException e) {
			LOGGER.logDebug("Error al Validar la Referencia" , e);
			args.setSuccess(false);
			args.getMessageManager().showErrorMsg("Error al Validar la Referencia "+e.getMessage());
        } catch (Exception e) {
			LOGGER.logDebug("Error al Validar la Referencia" , e);
			args.setSuccess(false);
			args.getMessageManager().showErrorMsg("Error al Validar la Referencia");
		} finally {
			LOGGER.logDebug("Finish executeCommand in PurchaseConfirmation");			
		}
    }

	public void purchaseConfirmation(DataEntity statusInfor, 
            PurchaseReferenceRequest wPurchaseReferenceRequest,
            IExecuteCommandEventArgs args) throws BusinessException{
        if (LOGGER.isDebugEnabled()) {
            LOGGER.logDebug("Start purchaseConfirmation in PurchaseConfirmation");
        }
        //PurchaseReferenceResponse wPurchaseRefResp = new PurchaseReferenceResponse();

        BusinessPartnerReference busPartRef = new BusinessPartnerReference(getServiceIntegration());
        //String authNumber = busPartRef.purchaseConfirmation(wPurchaseReferenceRequest, args);
        HashMap<String, String> outputsError = busPartRef.purchaseConfirmation(wPurchaseReferenceRequest, args);
        String authCode = String.valueOf(outputsError.get("@o_codigo_autorizacion"));
        if (LOGGER.isDebugEnabled()) {
            LOGGER.logDebug("Fecha y hora=" + outputsError.get("@o_fecha_autorizacion"));
        }
        if(outputsError.get("@o_fecha_autorizacion") != null && !"".equals(String.valueOf(outputsError.get("@o_fecha_autorizacion")))){
            String dateStr = String.valueOf(outputsError.get("@o_fecha_autorizacion")); //2021/10/12 18:39:18
            //Calendar authDate = Calendar.setTime(dateIn);
            Date dateIn = convertStringToDate(dateStr, FORMATDATE20);
            statusInfor.set(ReferenceInfor.OPERATIONDATE, dateIn);
            statusInfor.set(ReferenceInfor.OPERATIONTIME, dateIn);
        }
        statusInfor.set(ReferenceInfor.AUTHORIZATIONNUMBER, authCode);
        
        
        if (LOGGER.isDebugEnabled()) {
            LOGGER.logDebug("Finish purchaseConfirmation in PurchaseConfirmation");
        }
    }

	private PurchaseReferenceRequest getPurchaseReferenceRequest(DynamicRequest entities){
        PurchaseReferenceRequest wPurchRefReq = new PurchaseReferenceRequest();
        if (LOGGER.isDebugEnabled()) {
            LOGGER.logDebug("Start getReferenceRequest in ValidateReference");
        }
        DataEntity refReq = entities.getEntity(ReferenceReq.ENTITY_NAME);
        String refNumber = refReq.get(ReferenceReq.REFERENCENUMBER);
        Double purchaseAmount = refReq.get(ReferenceReq.PURCHASEAMOUNT);
        
        Calendar processDate =  getProcessDateAndTime(entities.getEntity(ReferenceInfor.ENTITY_NAME));
        // GeneralFunction.convertDateToCalendar(statusInfor.get(ReferenceInfor.OPERATIONDATE));

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
        }
        return dateCal;
    }

    private Date convertStringToDate(String dateVal, String dateFormat){
        //BD: 2021-10-12 18:52:25
        Date temp = new Date();
        try {
            return new SimpleDateFormat(dateFormat).parse(dateVal);
        }
        catch (Exception e) {
            LOGGER.logError("error convertStringToDate in PurchaseConfirmation: ",e);
        }
        return temp;

    }

}