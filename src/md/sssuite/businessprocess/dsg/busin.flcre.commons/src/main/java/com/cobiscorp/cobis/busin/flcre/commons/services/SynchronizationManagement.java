package com.cobiscorp.cobis.busin.flcre.commons.services;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SynchronizationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SynchronizationResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.Context;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class SynchronizationManagement extends BaseEvent {
	private static final ILogger logger = LogFactory.getLogger(SynchronizationManagement.class);

	MessageManagement messageManagement = new MessageManagement();

	public SynchronizationManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public boolean createSynchronizationActivity(SynchronizationRequest synchronizationRequest, ICommonEventArgs args, BehaviorOption options) {
		logger.logDebug("-----Inicio SynchronizationManagement - " + ServiceId.CREATE_SYNCHRONIZATION);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.DATA_SYNCHRONIZATION_REQUEST, synchronizationRequest);
		logger.logDebug("Request del tramite sincroniza >>>" + synchronizationRequest.getProcessNumber());
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.CREATE_SYNCHRONIZATION, serviceRequestTO);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("createSynchronizationActivity result:" + serviceResponse.isResult());
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				logger.logDebug("createSynchronizationActivity ok");
				return true;
			} else {
				logger.logDebug("createSynchronizationActivity no ok");
				throw new BusinessException(703037, messageManagement.raiseException(serviceResponse));
			}
		} else {
			if (logger.isDebugEnabled())
				logger.logDebug("Error en createSynchronizationActivity ");
			throw new BusinessException(703037, messageManagement.raiseException(serviceResponse));
		}
	}

	public boolean updateSynchronizationActivity(SynchronizationRequest synchronizationRequest, ICommonEventArgs arg1, BehaviorOption options) throws BusinessException {
		logger.logDebug("-----Inicio SynchronizationManagement - " + ServiceId.UPDATE_SYNCHRONIZATION);
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.DATA_SYNCHRONIZATION_REQUEST, synchronizationRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.UPDATE_SYNCHRONIZATION, serviceRequestApplicationTO);

		if (serviceResponse != null && serviceResponse.isResult()) {
			logger.logDebug("updateSynchronizationActivity result:" + serviceResponse.isResult());
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				logger.logDebug("updateSynchronizationActivity ok");
				return true;
			} else {
				logger.logDebug("updateSynchronizationActivity no ok");
				throw new BusinessException(703037, messageManagement.raiseException(serviceResponse));
			}
		} else {
			if (serviceResponse != null) {
				logger.logDebug("updateDataVerification result:" + serviceResponse.isResult());
			}
			throw new BusinessException(703037, messageManagement.raiseException(serviceResponse));

		}
	}

	public SynchronizationResponse querySynchronizationActivity(SynchronizationRequest synchronizationRequest, ICommonEventArgs arg1, BehaviorOption options) {
		logger.logDebug("-----Inicio SynchronizationManagement - " + ServiceId.QUERY_SYNCHRONIZATION);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.DATA_SYNCHRONIZATION_REQUEST, synchronizationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.QUERY_SYNCHRONIZATION, serviceRequestTO);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("searchDataVerification result:" + serviceResponse.isResult());
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (SynchronizationResponse) serviceItemsResponseTO.getValue(ReturnName.RETURN_SYNCHRONIZATION_RESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}
	
	public boolean xMLQuestionnaire(SynchronizationRequest synchronizationRequest, ICommonEventArgs args, BehaviorOption options) {
		logger.logDebug("-----Inicio xMLQuestionnaire - " + ServiceId.XML_QUESTIONNAIRE);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.DATA_SYNCHRONIZATION_REQUEST, synchronizationRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.XML_QUESTIONNAIRE, serviceRequestTO);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("xMLQuestionnaire result:" + serviceResponse.isResult());
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				logger.logDebug("xMLQuestionnaire ok");
				return true;
			} else {
				logger.logDebug("xMLQuestionnaire no ok");
				throw new BusinessException(703037, messageManagement.raiseException(serviceResponse));
			}
		} else {
			if (logger.isDebugEnabled())
				logger.logDebug("Error en xMLQuestionnaire ");
			throw new BusinessException(703037, messageManagement.raiseException(serviceResponse));
		}
	}
	
	public boolean xMLIngresoGrupal(SynchronizationRequest synchronizationRequest, ICommonEventArgs args, BehaviorOption options){
		logger.logDebug("-----Inicio xMLIngresoGrupal - " + ServiceId.XML_GRUPAL);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.DATA_SYNCHRONIZATION_REQUEST, synchronizationRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.XML_GRUPAL, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("xMLGrupal result:" + serviceResponse.isResult());
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				logger.logDebug("xMLGrupal ok");
				return true;
			} else {
				logger.logDebug("xMLGrupal no ok");
				throw new BusinessException(703037, messageManagement.raiseException(serviceResponse));
			}
		} else {
			if (logger.isDebugEnabled())
				logger.logDebug("Error en xMLGrupal ");
			throw new BusinessException(703037, messageManagement.raiseException(serviceResponse));
		}
	}

	public boolean xMLIngresoIndividual(SynchronizationRequest synchronizationRequest, ICommonEventArgs args, BehaviorOption options){
		logger.logDebug("-----Inicio xMLIngresoIndividual - " + ServiceId.XML_INDIVIDUAL);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.DATA_SYNCHRONIZATION_REQUEST, synchronizationRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.XML_INDIVIDUAL, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("xMLIndividual result:" + serviceResponse.isResult());
			ServiceResponseTO serviceResponseTo = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTo.isSuccess()) {
				logger.logDebug("xMLIndividual ok");
				return true;
			} else {
				logger.logDebug("xMLIndividual no ok");
				throw new BusinessException(703037, messageManagement.raiseException(serviceResponse));
			}
		} else {
			if (logger.isDebugEnabled())
				logger.logDebug("Error en xMLIndividual ");
			throw new BusinessException(703037, messageManagement.raiseException(serviceResponse));
		}
	}
}
