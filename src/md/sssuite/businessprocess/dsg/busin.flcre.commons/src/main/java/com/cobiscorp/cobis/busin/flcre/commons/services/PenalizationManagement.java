package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.util.Calendar;
import java.util.Map;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ConsolidatePenalizationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.ConsolidatePenalizationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.PenalizationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.PenalizationResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SummaryAmountResponse;
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
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;

public class PenalizationManagement extends BaseEvent {
	private static final ILogger logger = LogFactory.getLogger(PenalizationManagement.class);
	private ConsolidatePenalizationResponse consolidatePenalizationResponse;
	private PenalizationResponse[] penalizationList;
	private SummaryAmountResponse[] summaryAmountList;

	public PenalizationResponse[] getPenalizationResponse() {
		return this.penalizationList;
	}

	public ConsolidatePenalizationResponse getConsolidatePenalizationResponse() {
		return this.consolidatePenalizationResponse;
	}

	public SummaryAmountResponse[] getSummaryAmountResponse() {
		return summaryAmountList;
	}

	public PenalizationManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public boolean createPenalization(PenalizationRequest penalizationRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INPENALIZATIONREQUEST, penalizationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICECREATEPENALIZATION, serviceRequestTO);//trn 21865
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return serviceResponseTO.isSuccess();
		} else {
			logger.logDebug(" +***** createPenalization FALLO");
			MessageManagement.show(serviceResponse, arg1, options);
			return false;
		}
	}

	// Obtiene informacion de la tabla ca_candidata_castigo
	public cobiscorp.ecobis.loan.dto.PenalizationResponse getPenalizationData(String bank, DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {
		cobiscorp.ecobis.loan.dto.PenalizationRequest penalizationRequest = new cobiscorp.ecobis.loan.dto.PenalizationRequest();
		penalizationRequest.setBank(bank);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INPENALIZATIONREQUEST, penalizationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEGETPENALIZATIONLOAN, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("OK resultado tabla candidata castigo");

			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			cobiscorp.ecobis.loan.dto.PenalizationResponse response = (cobiscorp.ecobis.loan.dto.PenalizationResponse) serviceResponseTO.getValue(ReturnName.RETURNPENALIZATIONRESPONSE);
			if (response != null) {
				return (cobiscorp.ecobis.loan.dto.PenalizationResponse) response;
			}
		}
		return null;
	}

	// Busca las operaciones candidatas
	public cobiscorp.ecobis.loan.dto.PenalizationResponse[] searchPunishment(DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTOException = new ServiceRequestTO();
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHPUNISHMENT, serviceRequestTOException);

		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("LISTA DE OPERACIONES CANDIDATAS - ca_candidatas_castigo");
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			cobiscorp.ecobis.loan.dto.PenalizationResponse[] penalizationResponseList = (cobiscorp.ecobis.loan.dto.PenalizationResponse[]) serviceItemsResponseTO
					.getValue(ReturnName.RETURNPENALIZATIONRESPONSE);
			return penalizationResponseList;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;

	}

	// Busca informacion de la tabla cr_castigo_operacion
	public cobiscorp.ecobis.loan.dto.PenalizationResponse getPenalizationDataOperation(DynamicRequest entities, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTOException = new ServiceRequestTO();
		execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHPUNISHMENT, serviceRequestTOException);
		/*
		 * if (serviceResponse.isResult()) { if (logger.isDebugEnabled()) logger.logDebug("LISTA DE OPERACIONES CANDIDATAS - ca_candidatas_castigo");
		 * ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData(); PenalizationResponse[] penalizationResponseList =
		 * (PenalizationResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNPENALIZATIONRESPONSE); return penalizationResponseList; } else {
		 * MessageManagement.show(serviceResponse, arg1, options); }
		 */
		return null;

	}

	public boolean updatePenalization(PenalizationRequest penalizationRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INPENALIZATIONREQUEST, penalizationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEUPDATEPENALIZATION, serviceRequestTO);//trn 21865
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return serviceResponseTO.isSuccess();
		} else {
			logger.logDebug(" +***** updatePenalization FALLO");
			MessageManagement.show(serviceResponse, arg1, options);
			return false;
		}

	}

	public boolean updatePublishment(String idOperation, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		PenalizationRequest pr = new PenalizationRequest();
		pr.setIdOperation(idOperation);
		serviceRequestTO.getData().put(RequestName.INPENALIZATIONREQUEST, pr);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEUPDATEPUNISHMENT, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return serviceResponseTO.isSuccess();
		} else {
			logger.logDebug("3............ SERVICEUPDATEPUNISHMENTn FALLO...");
			MessageManagement.show(serviceResponse, arg1, options);
			return false;
		}
	}

	public PenalizationResponse queryPenalization(int idProcess, ICommonEventArgs arg1, BehaviorOption options) {
		PenalizationRequest penalizationRequest = new PenalizationRequest();
		penalizationRequest.setIdProcess(idProcess);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INPENALIZATIONREQUEST, penalizationRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEGETPENALIZATION, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (PenalizationResponse) serviceResponseTO.getValue(ReturnName.RETURNPENALIZATIONRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			return null;
		}
	}

	public boolean queryConsolidatePenalizationLoan(ConsolidatePenalizationRequest penalizationRequest, ICommonEventArgs arg1, BehaviorOption options) {
		this.penalizationList = null;
		this.consolidatePenalizationResponse = null;
		this.summaryAmountList = null;
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INCONSOLIDATEPENALIZATIONREQUEST, penalizationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.QUERYCONSOLIDATEPENALIZATIONLOAN, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			this.consolidatePenalizationResponse = (ConsolidatePenalizationResponse) serviceResponseTO.getValue(ReturnName.RETURNCONSOLIDATEPENALIZATION);
			this.penalizationList = (PenalizationResponse[]) serviceResponseTO.getValue(ReturnName.RETURNPENALIZATIONRESPONSE);
			this.summaryAmountList = (SummaryAmountResponse[]) serviceResponseTO.getValue(ReturnName.SUMMARYAMOUNTRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return serviceResponse.isResult();
	}

	public int insertConsolidatePenalizationLoan(ConsolidatePenalizationRequest penalizationRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INCONSOLIDATEPENALIZATIONREQUEST, penalizationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.INSERTCONSOLIDATEPENALIZATIONLOAN, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();

			@SuppressWarnings("unchecked")
			Map<String, Object> applicationResponse = (Map<String, Object>) serviceResponseTO.getValue(ReturnName.OUTPUT);
			return Integer.parseInt(applicationResponse.get("@o_grupo").toString());
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			return 0;
		}
	}

	public boolean updateConsolidatePenalizationLoan(int groupId, int ssn, ICommonEventArgs arg1, BehaviorOption options) {
		ConsolidatePenalizationRequest penalizationRequest = new ConsolidatePenalizationRequest();
		penalizationRequest.setSsn(ssn);
		penalizationRequest.setGroupCode(groupId);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INCONSOLIDATEPENALIZATIONREQUEST, penalizationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.UPDATECONSOLIDATEPENALIZATIONLOAN, serviceRequestTO);
		if (!serviceResponse.isResult()) {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return serviceResponse.isResult();
	}

	public boolean changeStateConsolidatePenalizationLoan(ConsolidatePenalizationRequest penalizationRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INCONSOLIDATEPENALIZATIONREQUEST, penalizationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.CHANGESTATECONSOLIDATEPENALIZATIONLOAN, serviceRequestTO);
		if (!serviceResponse.isResult()) {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return serviceResponse.isResult();
	}

	public PenalizationResponse insertDetailPenalizationLoanTmp(PenalizationRequest penalizationRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INPENALIZATIONREQUEST, penalizationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.INSERTDETAILPENALIZATIONLOANTMP, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (PenalizationResponse) serviceResponseTO.getValue(ReturnName.RETURNPENALIZATIONRESPONSE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
			return null;
		}
	}

	// Update de los sindicos del grupo de operaciones a castigar
	public boolean updatePenalizationLegal(int groupId, String sindico1, String sindico2, ICommonEventArgs arg1, BehaviorOption options) {
		ConsolidatePenalizationRequest penalizationRequest = new ConsolidatePenalizationRequest();
		penalizationRequest.setGroupCode(groupId);
		penalizationRequest.setSindico1(sindico1);
		penalizationRequest.setSindico2(sindico2);
		penalizationRequest.setCutoffDate(Calendar.getInstance());
		penalizationRequest.setType("");
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INCONSOLIDATEPENALIZATIONREQUEST, penalizationRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.UPDATEPENALIZATIONLEGAL, serviceRequestTO);
		if (!serviceResponse.isResult()) {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return serviceResponse.isResult();
	}

}
