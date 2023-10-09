package com.cobiscorp.mobile.service.interfaces;

import java.util.List;

import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.Task;

public interface IProcessService {

	public List<Task> getTaskList(String identification, String cobisSessionId) throws MobileServiceException;

	public void startProcess(String processName, String identification, Integer customerId, String cobisSessionId)
			throws MobileServiceException;

	public void nextActivity(Task task, String cobisSessionId) throws MobileServiceException;
}
