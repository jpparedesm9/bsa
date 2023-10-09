package com.cobiscorp.cobis.loans.customevents.events;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.QualificationRangeRequest;
import cobiscorp.ecobis.loangroup.dto.QualificationRangeResponse;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.model.QualificationRange;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;


public class InitDataEvent extends BaseEvent implements IInitDataEvent {

    private static ILogger logger = LogFactory.getLogger(InitDataEvent.class);

    public InitDataEvent(ICTSServiceIntegration serviceIntegration) {
        super(serviceIntegration);
    }

    @Override
    public void executeDataEvent(DynamicRequest dynamicRequest, IDataEventArgs iDataEventArgs) {
        logger.logDebug("Start executeDataEvent");
        loadQualificationRange(dynamicRequest, iDataEventArgs);
    }

    private void loadQualificationRange(DynamicRequest entities, ICommonEventArgs args) {
        logger.logDebug("Start loadQualificationRange");

        QualificationRangeRequest qualificationRangeRequest = new QualificationRangeRequest();
        qualificationRangeRequest.setAcronymRule("CALFRISK");
        ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
        serviceRequestTO.addValue("inQualificationRangeRequest", qualificationRangeRequest);

        ServiceResponse serviceResponse =
                execute(getServiceIntegration(), logger, "LoanGroup.RiskLevelManagement.QueryQualificationRange", serviceRequestTO);

        logger.logDebug("ServiceResponse >> " + serviceResponse);
        logger.logDebug("ServiceResponse result >> " + serviceResponse != null ? serviceResponse.isResult() : null);

        QualificationRangeResponse[] qualificationRangeResponses = new QualificationRangeResponse[0];
        if (serviceResponse.isResult()) {
            logger.logDebug("ServiceResponse data " + serviceResponse.getData());
            ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
            qualificationRangeResponses = (QualificationRangeResponse[]) serviceItemsResponseTO.getValue("returnQualificationRangeResponse");
        } else {
            MessageManagement.show(serviceResponse, args, new BehaviorOption());
        }


        DataEntityList qualificationRange = entities.getEntityList(QualificationRange.ENTITY_NAME);
        qualificationRange.clear();
        DataEntity entity;
        for (QualificationRangeResponse qrr : qualificationRangeResponses) {

            entity = new DataEntity();
            entity.set(QualificationRange.DESCRIPTION, qrr.getRate());
            entity.set(QualificationRange.MINVALUE, qrr.getMinValue());
            entity.set(QualificationRange.MAXVALUE, qrr.getMaxValue());
            qualificationRange.add(entity);

        }
    }
}
