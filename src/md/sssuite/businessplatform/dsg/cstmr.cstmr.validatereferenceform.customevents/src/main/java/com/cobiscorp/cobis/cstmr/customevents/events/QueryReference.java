package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.ReferenceInfor;
import com.cobiscorp.cobis.cstmr.model.ReferenceReq;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.prospect.services.BusinessPartnerReference;
import cobiscorp.ecobis.customerdatamanagement.dto.PurchaseReferenceRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.PurchaseReferenceResponse;
import com.cobiscorp.cobis.cstmr.commons.events.GeneralFunction;

public class QueryReference extends BaseEvent implements IChangedEvent{
    
    private static final ILogger LOGGER = LogFactory.getLogger(QueryReference.class);    
    
    public QueryReference (ICTSServiceIntegration serviceIntegration){
        super(serviceIntegration);
    }

    @Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {
        DataEntity statusReq = new DataEntity();
        DataEntity statusInfor = new DataEntity();
        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.logDebug("Start changed in QueryReference");
            }
            PurchaseReferenceResponse resp = queryReferenceStatus(getPurchaseReferenceRequest(entities),args);

            statusReq = entities.getEntity(ReferenceReq.ENTITY_NAME);
            statusReq.set(ReferenceReq.AUTHORIZEDAMOUNT, resp.getAmount());
            
            statusInfor = entities.getEntity(ReferenceInfor.ENTITY_NAME);
            statusInfor.set(ReferenceInfor.REFVALIDITY, GeneralFunction.convertCalendarToDate(resp.getProcessDate()));
            statusInfor.set(ReferenceInfor.REFSTATUS, resp.getStatus()); //CADUCADA,VIGENTE

        } catch (BusinessException e) {
			LOGGER.logDebug("Error al Consultar Referencia0=" , e);
			args.setSuccess(false);
		} catch (Exception e) {
			LOGGER.logDebug("Error al Consultar Referencia1=" , e);
			args.setSuccess(false);
		} finally {
			LOGGER.logDebug("Finish changed in QueryReference");			
		}
    }

    public PurchaseReferenceResponse queryReferenceStatus(
            PurchaseReferenceRequest wPurchaseReferenceRequest,IChangedEventArgs args)
                throws BusinessException{
        if (LOGGER.isDebugEnabled()) {
            LOGGER.logDebug("Start queryReferenceStatus in QueryReference");
        }
        PurchaseReferenceResponse wPurchaseRefResp = new PurchaseReferenceResponse();// Para pruebas en DESA

        BusinessPartnerReference busPartRef = new BusinessPartnerReference(getServiceIntegration());
        wPurchaseRefResp = busPartRef.queryReferenceStatus(wPurchaseReferenceRequest, args);

        if (LOGGER.isDebugEnabled()) {
            LOGGER.logDebug("Finish queryReferenceStatus in QueryReference");
        }
        return wPurchaseRefResp;
    }

    private PurchaseReferenceRequest getPurchaseReferenceRequest(DynamicRequest entities){
        PurchaseReferenceRequest wPurchRefReq = new PurchaseReferenceRequest();
        if (LOGGER.isDebugEnabled()) {
            LOGGER.logDebug("Start getReferenceRequest in QueryReference");
        }
        DataEntity refReq = entities.getEntity(ReferenceReq.ENTITY_NAME);
        String refNumber = refReq.get(ReferenceReq.REFERENCENUMBER);

        wPurchRefReq.setRefNumber(refNumber);

        if (LOGGER.isDebugEnabled()) {
            LOGGER.logDebug("Finish getReferenceRequest in QueryReference");
        }
        return wPurchRefReq;
    }

}