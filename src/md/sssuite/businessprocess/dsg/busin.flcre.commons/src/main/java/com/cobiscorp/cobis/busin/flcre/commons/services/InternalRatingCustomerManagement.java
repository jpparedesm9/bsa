package com.cobiscorp.cobis.busin.flcre.commons.services;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ProcessRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RatingApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RatingApplicationResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Format;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.SessionContext;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.Validate;
import com.cobiscorp.cobis.busin.model.Context;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;

public class InternalRatingCustomerManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(InternalRatingCustomerManagement.class);

	public InternalRatingCustomerManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public RatingApplicationResponse getRatingApplicationResponseScoreDTO(int idEnte, ICommonEventArgs arg1, BehaviorOption options) {
		RatingApplicationRequest ratingRequest = new RatingApplicationRequest();
		ratingRequest.setIdEnte(idEnte);
		ratingRequest.setOperation(String.valueOf(Format.OPERATION_ITEMS_DETAIL_OTHER));

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INRATINGAPPLICATIONREQUEST, ratingRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEQUERYSCORERATINGAPPLICATION, serviceRequestTO);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Información de puntaje para el cliente:" + idEnte);
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (RatingApplicationResponse) serviceItemsResponseTO.getValue(ReturnName.RETURNRATINGAPPLICATIONRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public RatingApplicationResponse getRatingApplicationResponseDTO(int idRequest, int idEnte, ICommonEventArgs arg1, BehaviorOption options) {
		RatingApplicationRequest ratingRequest = new RatingApplicationRequest();
		ratingRequest.setIdEnte(idEnte);
		ratingRequest.setOperation(String.valueOf(Format.OPERATION_ITEMS_DETAIL_SHOW));
		ratingRequest.setIdTramit(idRequest);
		ratingRequest.setFormat_date(SessionContext.getFormatDate());

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INRATINGAPPLICATIONREQUEST, ratingRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEQUERYRATINGAPPLICATION, serviceRequestTO);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Información preguntas recuperados para Tramite:" + idRequest);
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (RatingApplicationResponse) serviceItemsResponseTO.getValue(ReturnName.RETURNRATINGAPPLICATIONRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public boolean blackListValidation(ProcessRequest processRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INPROCESSREQUEST, processRequest);
		boolean hasMessageError = false;

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.BLACKLISTVALIDATION, serviceRequestTO);
		if (!serviceResponse.isResult()) {
			if (options.showMessage() && serviceResponse.getMessages() != null) {
				String messageFinal = "";
				for (Message message : serviceResponse.getMessages()) {
					if (message.getMessage().startsWith(".:.")) {
						messageFinal = messageFinal + "<br>" + message.getMessage() + "<br>";
						hasMessageError = true;
					}
				}
				if (hasMessageError) {
					arg1.getMessageManager().showMessage(MessageLevel.ERROR, 0, messageFinal, null, true);
				} else {
					MessageManagement.show(serviceResponse, arg1, options);
				}
				if (options.isSuccessFalse()) {
					arg1.setSuccess(false);
				}
			}
			if (logger.isDebugEnabled()) {
				if (processRequest.getRequestId() != null)
					logger.logDebug("Error ejecucion servicio:'" + ServiceId.BLACKLISTVALIDATION + "', para el tramite:" + processRequest.getRequestId());
				if (processRequest.getInstanceId() != null)
					logger.logDebug("Error ejecucion servicio:'" + ServiceId.BLACKLISTVALIDATION + "', para la solicitud:" + processRequest.getInstanceId());
			}
		}
		return serviceResponse.isResult();
	}

	public boolean blackListValidation(DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {
		DataEntity context = entities.getEntity(Context.ENTITY_NAME);
		if (context == null) {
			arg1.setSuccess(false);
			arg1.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_ECOTEXASI_69364");
			return false;
		}
		if (!Validate.Integers.isNotNullAndGreaterThanZero(context.get(Context.APPLICATION)) && !Validate.Integers.isNotNullAndGreaterThanZero(context.get(Context.REQUESTID))) {
			arg1.setSuccess(false);
			arg1.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_ONSDELIIM_67402");
			return false;
		}

		ProcessRequest processRequest = new ProcessRequest();
		if (Validate.Integers.isNotNullAndGreaterThanZero(context.get(Context.APPLICATION))) {
			processRequest.setInstanceId(context.get(Context.APPLICATION));
		}
		if (Validate.Integers.isNotNullAndGreaterThanZero(context.get(Context.REQUESTID))) {
			processRequest.setRequestId(context.get(Context.REQUESTID));
		}
		if (Validate.Strings.isNotNullOrEmptyOrWhiteSpace(context.get(Context.APPLICATIONSUBJECT))) {
			processRequest.setProcessName(context.get(Context.APPLICATIONSUBJECT));
		}
		if (Validate.Strings.isNotNullOrEmptyOrWhiteSpace(context.get(Context.TASKSUBJECT))) {
			processRequest.setActivityName(context.get(Context.TASKSUBJECT));
		}

		return blackListValidation(processRequest, arg1, options);
	}

	public boolean blackListValidation(DynamicRequest entities, int requestId, ICommonEventArgs arg1, BehaviorOption options) {
		DataEntity context = entities.getEntity(Context.ENTITY_NAME);
		if (context == null) {
			arg1.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_ECOTEXASI_69364");
			arg1.setSuccess(false);
			return false;
		}
		context.set(Context.REQUESTID, requestId);
		return blackListValidation(entities, arg1, options);
	}
}
