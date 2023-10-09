package com.cobiscorp.ecobis.customer.commons.prospect.services;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AlertRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.AlertResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.OperationInusualRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.RiskRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.RiskResponse;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.services.utils.CallServices;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.RequestName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ReturnName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ServiceId;

public class AlertManager extends BaseEvent {

	public AlertManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public void createAlert(AlertRequest alertRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.ALERT_REQUEST, alertRequest, ServiceId.CREATE_ALERT, arg1);
	}

	public void updateAlert(RiskRequest ariskRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.RISK_REQUEST, ariskRequest, ServiceId.UPDATE_RISK, arg1);
	}
	
	public void deleteAlert(AlertRequest alertRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.ALERT_REQUEST, alertRequest, ServiceId.DELETE_ALERT, arg1);
	}

	public AlertResponse[] searchAlert(AlertRequest alertRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());

		AlertResponse[] alert = callService.callServiceWithReturnArray(RequestName.ALERT_REQUEST, alertRequest, ServiceId.SEARCH_ALERT, ReturnName.ALERT_RESPONSE, arg1);
		return alert == null ? new AlertResponse[0] : alert;
	}
	
	public RiskResponse[] searchRisk(AlertRequest alertRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());

		RiskResponse[] risk = callService.callServiceWithReturnArray(RequestName.ALERT_REQUEST, alertRequest, ServiceId.SEARCH_RISK, ReturnName.RISK_RESPONSE, arg1);
		return risk == null ? new RiskResponse[0] : risk;
	}
	
	public void createReportOpeInusual(OperationInusualRequest operationInusualRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.OPERATION_REPORT_REQUEST, operationInusualRequest, ServiceId.CREATE_REPORT_OPERATION_INISUAL, arg1);
	}
}
