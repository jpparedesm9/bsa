package com.cobiscorp.cobis.busin.flcre.commons.services;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DataVerificationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.DataVerificationResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class DataVerificationManagement extends BaseEvent {
	private static final ILogger logger = LogFactory.getLogger(DataVerificationManagement.class);

	public DataVerificationManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public boolean createDataVerification(DataVerificationRequest dataVerificationRequest, IExecuteCommandEventArgs args) {
		logger.logDebug("-----Inicio DataVerificationManagement - createDataVerification");
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.DATA_VERIFICATION_REQUEST, dataVerificationRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.DATA_VERIFICATION_CREATE, serviceRequestTO);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("createDataVerification result:" + serviceResponse.isResult());
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				return true;
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));
			}
		} else {
			if (logger.isDebugEnabled())
				logger.logDebug("Error en createDataVerification ");
			throw new BusinessException(703037, raiseException(serviceResponse));
		}
	}

	public boolean updateDataVerification(DataVerificationRequest dataVerificationRequest, ICommonEventArgs arg1, BehaviorOption options) throws BusinessException {
		logger.logDebug("-----Inicio DataVerificationManagement - updateDataVerification");
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.DATA_VERIFICATION_REQUEST, dataVerificationRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.DATA_VERIFICATION_UPDATE, serviceRequestApplicationTO);

		logger.logDebug("updateApplication serviceResponse" + serviceResponse);

		if (serviceResponse != null && serviceResponse.isResult()) {
			logger.logDebug("updateDataVerification result:" + serviceResponse.isResult());
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				logger.logDebug("updateDataVerification ok");
				return true;
			} else {
				logger.logDebug("updateDataVerification no ok");
				throw new BusinessException(703037, raiseException(serviceResponse));
			}
		} else {
			if(serviceResponse != null){
				logger.logDebug("updateDataVerification result:" + serviceResponse.isResult());
			}
			throw new BusinessException(703037, raiseException(serviceResponse));

		}
	}

	public DataVerificationResponse[] searchDataVerification(DataVerificationRequest dataVerificationRequest, ICommonEventArgs arg1, BehaviorOption options) {
		logger.logDebug("-----Inicio DataVerificationManagement - searchDataVerification");

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.DATA_VERIFICATION_REQUEST, dataVerificationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.DATA_VERIFICATION_SEARCH, serviceRequestTO);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("searchDataVerification result:" + serviceResponse.isResult());
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (DataVerificationResponse[]) serviceItemsResponseTO.getValue(ReturnName.DATA_VERIFICATION_RESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public String raiseException(ServiceResponse serviceResponse) {
		if (serviceResponse != null && serviceResponse.getMessages() != null) {
			StringBuffer errors = new StringBuffer();
			for (Message message : serviceResponse.getMessages()) {
				errors.append("Error ");
				errors.append(message.getCode());
				errors.append(": ");
				errors.append(message.getMessage());
				errors.append("\n");
			}
			return errors.toString();
		}
		return "";
	}
}
