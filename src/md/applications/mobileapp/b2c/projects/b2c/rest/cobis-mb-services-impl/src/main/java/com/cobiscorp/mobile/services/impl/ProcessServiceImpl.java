package com.cobiscorp.mobile.services.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.services.impl.utils.Constants;
import com.cobiscorp.mobile.model.Task;
import com.cobiscorp.mobile.service.interfaces.IProcessService;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.htm.api.dto.ClaimInfo;
import cobiscorp.ecobis.htm.api.dto.ProcessDTO;
import cobiscorp.ecobis.htm.api.dto.TaskDTO;
import cobiscorp.ecobis.htm.api.dto.TaskListRequest;

@Component
@Service({ IProcessService.class })
@Properties({ @Property(name = "service.impl", value = "current") })
public class ProcessServiceImpl extends ServiceBase implements IProcessService {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private ILogger LOGGER = LogFactory.getLogger(ProcessServiceImpl.class);

	@Override
	public List<Task> getTaskList(String identification, String cobisSessionId) throws MobileServiceException {
		List<Task> tasks = new ArrayList<Task>();
		TaskListRequest taskListRequest = new TaskListRequest();
		taskListRequest.setClientIdentification(identification);

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		serviceRequest.addValue("inTaskListRequest", taskListRequest);

		try {
			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER,
					"HTM.API.HumanTask.GetTaskListCriteria", cobisSessionId, serviceRequest);
			if (serviceResponseTO.isSuccess()) {
				TaskDTO[] taskDTOs = (TaskDTO[]) serviceResponseTO.getData().get("returnTaskDTO");
				for (TaskDTO iterator : taskDTOs) {
					Task task = new Task();
					task.setProcessInstanceIdentifier(iterator.getProcessInstanceIdentifier());
					task.setTaskDescription(iterator.getTaskDescription());
					task.setAlternateCode(iterator.getAlternateCode());
					task.setCobisAssignAct(iterator.getCobisAssignAct());
					task.setTaskInstanceIdentifier(iterator.getTaskInstanceIdentifier());
					tasks.add(task);
				}
			} else {
				manageResponseError(serviceResponseTO, LOGGER);
			}
		} catch (Exception e) {
			throw new MobileServiceException(e);
		}
		return tasks;
	}

	public void startProcess(String processName, String identification, Integer clientId, String cobisSessionId)
			throws MobileServiceException {

		ProcessDTO processDTO = new ProcessDTO();
		processDTO.setTemplateName(processName);
		processDTO.setBussinessInformationStringOne(identification);
		processDTO.setBussinessInformationIntOne(clientId);

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		serviceRequest.addValue("inProcessDTO", processDTO);

		try {
			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER,
					"HTM.API.HumanTask.CreateProcessInstance", cobisSessionId, serviceRequest);
			if (!serviceResponseTO.isSuccess()) {
				manageResponseError(serviceResponseTO, LOGGER);
			}
		} catch (Exception e) {
			throw new MobileServiceException(e);
		}
	}

	public void nextActivity(Task task, String cobisSessionId) throws MobileServiceException {

		ClaimInfo claimInfo = new ClaimInfo();
		claimInfo.setProcessInstanceId(task.getProcessInstanceIdentifier());
		claimInfo.setTaskInstanceId(task.getTaskInstanceIdentifier());
		claimInfo.setCobisAssignAct(task.getCobisAssignAct());
		claimInfo.setCobisStepId(task.getCobisStepId());
		claimInfo.setDecision(Constants.PROCESS_OK_CODE);
		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		serviceRequest.addValue("inClaimInfo", claimInfo);

		try {
			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER, "HTM.API.HumanTask.CompleteTask",
					cobisSessionId, serviceRequest);
			if (!serviceResponseTO.isSuccess()) {
				manageResponseError(serviceResponseTO, LOGGER);
			}
		} catch (Exception e) {
			throw new MobileServiceException(e);
		}
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

}
