package com.cobiscorp.ecobis.callcenter.commons.services.utils;

import java.util.HashMap;
import java.util.Map;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.callcenter.commons.constants.Outputs;


public class CallServices extends BaseEvent {
	private static final ILogger LOGGER = LogFactory.getLogger(CallServices.class);

	public CallServices(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public Object callServiceWithOutput(String requestName, Object object, String serviceId, String output, ICommonEventArgs arg1) throws BusinessException {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start callServiceWithOutput");
		try {
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			serviceRequestTO.addValue(requestName, object);
			ServiceResponse serviceResponse = execute(this.getServiceIntegration(), LOGGER, serviceId, serviceRequestTO);
			if (serviceResponse != null) {
				if (serviceResponse.isResult()) {
					ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
					HashMap<String, String> outputs = (HashMap<String, String>) serviceResponseTO.getValue(Outputs.OUTPUT);
					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("callServiceWithOutput service>>" + serviceId + " output>>" + output + " otputs recuperados>>" + outputs);
					}
					arg1.setSuccess(true);
					return outputs.get(output);
				} else {
					for (Message message : serviceResponse.getMessages()) {
						arg1.getMessageManager().showErrorMsg(message.getMessage());
					}

				}
			}
			arg1.setSuccess(false);
			LOGGER.logDebug("Finish callServiceWithOutput");
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Finish callServiceWithOutput");
		}
		return null;

	}

	public Object callServiceWithReturn(String requestName, Object object, String serviceId, String returnValue, ICommonEventArgs arg1) throws BusinessException {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start callServiceWithReturn");
		try {
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			serviceRequestTO.addValue(requestName, object);
			ServiceResponse serviceResponse = execute(this.getServiceIntegration(), LOGGER, serviceId, serviceRequestTO);
			if (serviceResponse != null) {
				if (serviceResponse.isResult()) {
					ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
					arg1.setSuccess(true);
					return serviceResponseTO.getValue(returnValue);

				} else {
					for (Message message : serviceResponse.getMessages()) {
						arg1.getMessageManager().showErrorMsg(message.getMessage());
					}

				}
			}

			arg1.setSuccess(false);
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Finish callServiceWithReturn");
		}
		return null;
	}
	
	public Object callServiceWithReturn(String requestName, Object object, String requestName1, Object object1, String serviceId, String returnValue, ICommonEventArgs arg1) throws BusinessException {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start callServiceWithReturn");
		try {
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			serviceRequestTO.addValue(requestName, object);
			serviceRequestTO.addValue(requestName1, object1);
			ServiceResponse serviceResponse = execute(this.getServiceIntegration(), LOGGER, serviceId, serviceRequestTO);
			if (serviceResponse != null) {
				if (serviceResponse.isResult()) {
					ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
					arg1.setSuccess(true);
					return serviceResponseTO.getValue(returnValue);

				} else {
					for (Message message : serviceResponse.getMessages()) {
						arg1.getMessageManager().showErrorMsg(message.getMessage());
					}

				}
			}

			arg1.setSuccess(false);
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Finish callServiceWithReturn");
		}
		return null;
	}

	public <T> T[] callServiceWithReturnArray(String requestName, Object object, String serviceId, String returnValue, ICommonEventArgs arg1) throws BusinessException {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start callServiceWithReturnArray");
		try {
			ServiceResponse serviceResponse = null;
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();

			if (requestName == null && object == null) {
				serviceResponse = execute(this.getServiceIntegration(), LOGGER, serviceId, serviceRequestTO);

			} else {

				serviceRequestTO.addValue(requestName, object);
				serviceResponse = execute(this.getServiceIntegration(), LOGGER, serviceId, serviceRequestTO);
			}
			LOGGER.logDebug("1 ---");
			if (serviceResponse != null) {
				LOGGER.logDebug("2 ---");
				if (serviceResponse.isResult()) {
					LOGGER.logDebug("3 ---");
					ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
					arg1.setSuccess(true);

					if (serviceResponseTO.getValue(returnValue) == null) {
						LOGGER.logDebug("callServiceWithReturnArray ---> null");
						return null;
					} else {
						LOGGER.logDebug("callServiceWithReturnArray --->" + serviceResponseTO.getValue(returnValue));
						return (T[]) serviceResponseTO.getValue(returnValue);

					}

				} else {
					LOGGER.logDebug("4 ---");
					for (Message message : serviceResponse.getMessages()) {
						arg1.getMessageManager().showErrorMsg(message.getMessage());
					}

				}
			}
			LOGGER.logDebug("5 ---");
			arg1.setSuccess(false);
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Finish callServiceWithReturnArray");
		}
		return null;
	}
	
	public <T> T[] callServiceWithReturnArray(String requestName, Object object,String requestName1, Object object1, String serviceId, String returnValue, ICommonEventArgs arg1) throws BusinessException {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start callServiceWithReturnArray");
		try {
			ServiceResponse serviceResponse = null;
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();

			if (requestName == null && object == null) {
				serviceResponse = execute(this.getServiceIntegration(), LOGGER, serviceId, serviceRequestTO);

			} else {

				serviceRequestTO.addValue(requestName, object);
				serviceRequestTO.addValue(requestName1, object1);
				serviceResponse = execute(this.getServiceIntegration(), LOGGER, serviceId, serviceRequestTO);
			}
			LOGGER.logDebug("1 ---");
			if (serviceResponse != null) {
				LOGGER.logDebug("2 ---");
				if (serviceResponse.isResult()) {
					LOGGER.logDebug("3 ---");
					ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
					arg1.setSuccess(true);

					if (serviceResponseTO.getValue(returnValue) == null) {
						LOGGER.logDebug("callServiceWithReturnArray ---> null");
						return null;
					} else {
						LOGGER.logDebug("callServiceWithReturnArray --->" + serviceResponseTO.getValue(returnValue));
						return (T[]) serviceResponseTO.getValue(returnValue);

					}

				} else {
					LOGGER.logDebug("4 ---");
					for (Message message : serviceResponse.getMessages()) {
						arg1.getMessageManager().showErrorMsg(message.getMessage());
					}

				}
			}
			LOGGER.logDebug("5 ---");
			arg1.setSuccess(false);
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Finish callServiceWithReturnArray");
		}
		return null;
	}

	public HashMap<String, String> callServiceWithInputMapAndOutputMap(Map<String, Object> requests, String serviceId, ICommonEventArgs arg1) throws BusinessException {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start callServiceWithOutput");
		try {
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();

			for (Map.Entry<String, Object> entry : requests.entrySet()) {
				serviceRequestTO.addValue(entry.getKey(), entry.getValue());
			}

			ServiceResponse serviceResponse = execute(this.getServiceIntegration(), LOGGER, serviceId, serviceRequestTO);
			if (serviceResponse != null) {
				if (serviceResponse.isResult()) {
					ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
					HashMap<String, String> outputs = (HashMap<String, String>) serviceResponseTO.getValue(Outputs.OUTPUT);
					if (LOGGER.isDebugEnabled()) {
						LOGGER.logDebug("callServiceWithOutput service>>" + serviceId + ", otputs recuperados>>" + outputs);
					}
					arg1.setSuccess(true);

					return outputs;
				} else {
					for (Message message : serviceResponse.getMessages()) {
						arg1.getMessageManager().showErrorMsg(message.getMessage());
					}

				}
			}
			arg1.setSuccess(false);
			LOGGER.logDebug("Finish callServiceWithOutput");
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Finish callServiceWithOutput");
		}
		return null;

	}

	public void callService(String requestName, Object object, String serviceId, ICommonEventArgs arg1) throws BusinessException {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start callService: " + object);		
		
		try {
			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			serviceRequestTO.addValue(requestName, object);
		
			ServiceResponse serviceResponse = execute(this.getServiceIntegration(), LOGGER, serviceId, serviceRequestTO);
			if (serviceResponse != null) {
				if (serviceResponse.isResult()) {
					arg1.setSuccess(true);
				} else {
					for (Message message : serviceResponse.getMessages()) {
						arg1.getMessageManager().showErrorMsg(message.getMessage());
					}
					arg1.setSuccess(false);
				}
			}

		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Finish callService");
		}
	}
}
