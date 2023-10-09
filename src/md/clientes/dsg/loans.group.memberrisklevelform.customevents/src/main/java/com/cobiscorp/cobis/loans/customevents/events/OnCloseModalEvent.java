package com.cobiscorp.cobis.loans.customevents.events;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.RiskLevelRequest;
import cobiscorp.ecobis.loangroup.dto.RiskMatrixResponse;
import cobiscorp.ecobis.loangroup.dto.RiskResultResponse;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.model.Member;
import com.cobiscorp.cobis.loans.model.QualificationResult;
import com.cobiscorp.cobis.loans.model.RiskLevel;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IOnCloseModalEvent;
import com.cobiscorp.designer.api.customization.arguments.ICloseModalEventArgs;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class OnCloseModalEvent extends BaseEvent implements IOnCloseModalEvent {

    private static ILogger logger = LogFactory.getLogger(OnCloseModalEvent.class);

    public OnCloseModalEvent(ICTSServiceIntegration serviceIntegration) {
        super(serviceIntegration);
    }


    @Override
    public void onCloseModalEvent(DynamicRequest dynamicRequest, ICloseModalEventArgs iCloseModalEventArgs) {
        logger.logDebug("Start onCloseModalEvent");
        DataEntity dataEntity = dynamicRequest.getEntity(Member.ENTITY_NAME);
        ServiceResponse serviceResponse = executeServiceQueryRiskMatrix(dataEntity.get(Member.CUSTOMERID), iCloseModalEventArgs);
        if (serviceResponse.isResult()) {
            RiskMatrixResponse[] riskMatrixResponses = getRiskMatrixResponse(serviceResponse, iCloseModalEventArgs);
            RiskResultResponse[] riskResultResponses = getRiskResultResponse(serviceResponse, iCloseModalEventArgs);
            loadGridRiskLevel(dynamicRequest, riskMatrixResponses);
            loadGridQualificationResult(dynamicRequest, riskResultResponses);
        }


    }

    private ServiceResponse executeServiceQueryRiskMatrix(long customerId, ICommonEventArgs args) {
        logger.logDebug("Start executeServiceQueryRiskMatrix");
        RiskLevelRequest riskLevelRequest = new RiskLevelRequest();
        riskLevelRequest.setCustomerId(customerId);
        ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
        serviceRequestTO.addValue("inRiskLevelRequest", riskLevelRequest);

        ServiceResponse serviceResponse =
                execute(getServiceIntegration(), logger, "LoanGroup.RiskLevelManagement.QueryRiskMatrix", serviceRequestTO);

        logger.logDebug("ServiceResponse >> " + serviceResponse);
        logger.logDebug("ServiceResponse result >> " + serviceResponse != null ? serviceResponse.isResult() : null);

        if (!serviceResponse.isResult()) {

            MessageManagement.show(serviceResponse, args, new BehaviorOption());
        }

        return serviceResponse;

    }

    private RiskMatrixResponse[] getRiskMatrixResponse(ServiceResponse serviceResponse, ICommonEventArgs args) {
        logger.logDebug("Start getRiskMatrixResponse");

        if (serviceResponse.isResult()) {
            ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
            return (RiskMatrixResponse[]) serviceItemsResponseTO.getValue("returnRiskMatrixResponse");
        } else {
            MessageManagement.show(serviceResponse, args, new BehaviorOption());
        }

        return new RiskMatrixResponse[0];
    }

    private RiskResultResponse[] getRiskResultResponse(ServiceResponse serviceResponse, ICommonEventArgs args) {
        logger.logDebug("Start getRiskResultResponse");

        if (serviceResponse.isResult()) {
            ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
            return (RiskResultResponse[]) serviceItemsResponseTO.getValue("returnRiskResultResponse");
        } else {
            MessageManagement.show(serviceResponse, args, new BehaviorOption());
        }

        return new RiskResultResponse[0];
    }


    private void loadGridRiskLevel(DynamicRequest entities, RiskMatrixResponse... riskMatrixResponses) {

        logger.logDebug("Start loadGridRiskLevel");

        DataEntityList risksLevel = entities.getEntityList(RiskLevel.ENTITY_NAME);
        risksLevel.clear();
        DataEntity entity;
        for (RiskMatrixResponse rmr : riskMatrixResponses) {
            entity = new DataEntity();
            entity.set(RiskLevel.VARIABLENAME, rmr.getVariableName());
            entity.set(RiskLevel.LEVEL, rmr.getLevel());
            entity.set(RiskLevel.POINTS, rmr.getPoints());
            risksLevel.add(entity);
        }
    }

    private void loadGridQualificationResult(DynamicRequest entities, RiskResultResponse... riskResultResponses) {

        logger.logDebug("Start loadGridQualificationResult");
        DataEntityList qualificationResult = entities.getEntityList(QualificationResult.ENTITY_NAME);
        qualificationResult.clear();
        DataEntity entity;

        for (RiskResultResponse rrr : riskResultResponses) {
            entity = new DataEntity();
            entity.set(QualificationResult.LEVEL, rrr.getRate());
            entity.set(QualificationResult.POINTS, rrr.getPoints());
            qualificationResult.add(entity);
        }

    }
}
