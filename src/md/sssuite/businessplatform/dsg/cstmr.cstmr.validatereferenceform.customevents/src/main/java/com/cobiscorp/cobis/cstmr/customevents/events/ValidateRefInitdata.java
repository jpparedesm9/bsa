package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.parameters.CatalogManagement;
import com.cobiscorp.cobis.cstmr.model.ReferenceReq;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.ecobis.business.commons.platform.services.messages.BehaviorOption;

public class ValidateRefInitdata extends BaseEvent implements IInitDataEvent {
    public ValidateRefInitdata(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

    private static final ILogger LOGGER = LogFactory.getLogger(ValidateRefInitdata.class);

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {
		DataEntity statusReq = new DataEntity();
        try {
            if (LOGGER.isDebugEnabled()) {
                LOGGER.logDebug("Start intidata in ValidateRefInitdata");
            }
            CatalogManagement ctlgMng = new CatalogManagement(getServiceIntegration());
            ParameterResponse refLenParam = ctlgMng.getParameter(4, "LOREVR", "CCA", args, new BehaviorOption(false, false));
			int parametro = Integer.parseInt(refLenParam.getParameterValue());

			
			statusReq = entities.getEntity(ReferenceReq.ENTITY_NAME);
            statusReq.set(ReferenceReq.REFLENGHT, parametro);

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

}