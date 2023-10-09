package com.cobiscorp.cobis.busin.flcre.commons.services;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.htm.api.dto.TaskDTO;
import cobiscorp.ecobis.inbox.commons.dto.Record;
import cobiscorp.ecobis.workflow.dto.HierarchyRole;

import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class InboxManager extends BaseEvent {
	private static final ILogger logger = LogFactory.getLogger(InboxManager.class);

	public InboxManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public Record[] getHistoricOfitial(String instanceProcess, String taskInstanceIdentifier, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO requestTO = new ServiceRequestTO();
		TaskDTO taskDTO = new TaskDTO();
		taskDTO.setProcessInstanceIdentifier(instanceProcess);
		taskDTO.setTaskInstanceIdentifier(taskInstanceIdentifier);

		requestTO.getData().put("inTaskDTO", taskDTO);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESTASKHISTORYFLOW, requestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("ProcessInstance para getHistoricOfitial:" + instanceProcess);
			ServiceResponseTO serviceHistoricalResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (Record[]) serviceHistoricalResponseTO.getValue(ReturnName.HISTORICALRECORD);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}
}
