package com.cobiscorp.ecobis.fpm.mock;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;

import com.cobiscorp.cobis.commons.configuration.IConfigurationReader;
import com.cobiscorp.cobis.cts.commons.exceptions.CTSInfrastructureException;
import com.cobiscorp.cobis.cts.commons.exceptions.CTSServiceException;
import com.cobiscorp.cobis.cts.services.servexecutor.IService;
import com.cobiscorp.cobis.cts.services.servexecutor.IServiceExecutor;

public class ServiceExecutorMock implements IServiceExecutor{

	
	public void loadConfiguration(IConfigurationReader arg0) {
		// TODO Auto-generated method stub
		
	}

	
	public ServiceResponseTO execute(ServiceRequestTO arg0) {
		// TODO Auto-generated method stub
		ServiceResponseTO response = new ServiceResponseTO();
		response.setSuccess(true);
		return response;
	}

	
	public ServiceResponseTO execute(ServiceRequestTO arg0, IService arg1) {
		// TODO Auto-generated method stub
		ServiceResponseTO response = new ServiceResponseTO();
		response.setSuccess(true);
		return response;
	}

	
	public IService getServiceById(String arg0, String arg1)
			throws CTSServiceException, CTSInfrastructureException {
		// TODO Auto-generated method stub
		return null;
	}

	
	public ServiceResponseTO serviceLicenseControl(String arg0, String arg1,
			String arg2) {
		// TODO Auto-generated method stub
		ServiceResponseTO response = new ServiceResponseTO();
		response.setSuccess(true);
		return response;
	}

}
