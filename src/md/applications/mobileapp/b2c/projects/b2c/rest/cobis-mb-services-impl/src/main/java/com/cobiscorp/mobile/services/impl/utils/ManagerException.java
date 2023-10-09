/**
 * 
 */
package com.cobiscorp.mobile.services.impl.utils;

import java.util.Iterator;

import com.cobiscorp.cobis.commons.exceptions.COBISRuntimeException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.BaseRequest;
import com.cobiscorp.mobile.model.BaseResponse;
import com.cobiscorp.mobile.model.Message;

import cobiscorp.ecobis.commons.dto.MessageTO;

/**
 * @author hsalazar
 * 
 */
public class ManagerException {

	private static final ILogger logger = LogFactory.getLogger(ManagerException.class);
	private static final String CLASS_NAME = " [---> MB --->] ";
	private static final String MESSAGE_ERROR_CODE = "0001";
	private static final String MESSAGE_ERROR_MESSAGE = "Application Error";

	/**
	 * Permite administrar excepcion COBISRuntimeException
	 * 
	 * @param e COBISRuntimeException
	 * @param request
	 * @param methodName Nombre de método donde se generó la excepcion
	 * @return
	 */
	public static void manageException(Exception e, BaseRequest request, BaseResponse response) {
		String methodName = e.getStackTrace()[0].getMethodName();
		logger.logError(e, e);
		Message messageResponse = new Message();
		boolean isOtherException = false;
		if (e instanceof COBISRuntimeException) {
			COBISRuntimeException runtimeException = (COBISRuntimeException) e;
			if (logger.isDebugEnabled()) {
				logger.logDebug(CLASS_NAME + " COBISRuntimeException en metodo " + methodName + ":" + runtimeException.getClientErrorCode());
			}

			if (runtimeException.getClientErrorCode() == Constants.TIMEOUTCODEERROR) {
				messageResponse.setCode(String.valueOf(Constants.TIMEOUTCODEERROR));
				messageResponse.setMessage(MessagesUtil.getMessage(request.getCulture(), String.valueOf(Constants.TIMEOUTCODEERROR)));
			} else {
				isOtherException = true;
			}
		} else {
			isOtherException = true;
		}

		if (isOtherException) {
			messageResponse.setCode(Constants.ERROR_MB_DEFAULT);
			messageResponse.setMessage(MessagesUtil.getMessage(request.getCulture(), Constants.ERROR_MB_SERVICE_NOT_AVAILABLE));
		}

		response.setSuccess(false);
		response.setMessage(messageResponse);
	}
	
	public static void manageResponseError(ServiceResponse serviceResponse, ILogger logger) throws MobileServiceException {
		if (serviceResponse != null && serviceResponse.getMessages().size() > 0) {
			MobileServiceException exception = new MobileServiceException();
			for (Iterator iterator = serviceResponse.getMessages().iterator(); iterator.hasNext();) {
				MessageTO message = (MessageTO) iterator.next();
				if (!message.getCode().equals("0")){
					exception.addError(message.getCode(), message.getMessage());
				}
			}
			throw exception;
		} else {
			throw new MobileServiceException(MESSAGE_ERROR_CODE, MESSAGE_ERROR_MESSAGE);
		}
	}
	
	public static void manageResponseError(ILogger logger, MessageTO... messages) throws MobileServiceException {
		if (messages != null && messages.length > 0) {
			MobileServiceException exception = new MobileServiceException();
			for (MessageTO message : messages) {
				exception.addError(message.getCode(), message.getMessage());
			}
			throw exception;
		} else {
			throw new MobileServiceException(MESSAGE_ERROR_CODE, MESSAGE_ERROR_MESSAGE);
		}
	}
}
