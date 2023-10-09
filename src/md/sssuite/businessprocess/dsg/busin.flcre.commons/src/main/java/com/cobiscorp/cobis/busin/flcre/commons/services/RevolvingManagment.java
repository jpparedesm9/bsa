package com.cobiscorp.cobis.busin.flcre.commons.services;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RenewDataRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RenewDataResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RevolvingRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.SessionContext;
import com.cobiscorp.cobis.busin.model.RefinancingOperations;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class RevolvingManagment extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(RevolvingManagment.class);

	public RevolvingManagment(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public boolean managementRevolvingOpApplication(RevolvingRequest revolvingRequestDto, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.getData().put(RequestName.INREVOLVINGREQUEST, revolvingRequestDto);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.CREATEREVOLVINGOPAPPLICATION,
				serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Operacion a renovar - Opcion:" + revolvingRequestDto.getOperation());
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return serviceResponse.isResult();
	}

	public boolean createRevolvingOpApplication(String operationRestructure, String operationFinal, int idRequested, ICommonEventArgs arg1,
			BehaviorOption options) {
		RevolvingRequest revolvingRequestDto = new RevolvingRequest();
		revolvingRequestDto.setOperation(Mnemonic.CHAR_I);
		revolvingRequestDto.setOperationRestructure(operationRestructure);
		revolvingRequestDto.setOperationFinal(operationFinal);
		revolvingRequestDto.setIdRequested(idRequested);
		return managementRevolvingOpApplication(revolvingRequestDto, arg1, options);
	}

	public boolean deleteRevolvingOpApplicationByRequest(int idRequested, ICommonEventArgs arg1, BehaviorOption options) {
		RevolvingRequest revolvingRequestDto = new RevolvingRequest();
		revolvingRequestDto.setOperation(Mnemonic.CHAR_X);
		revolvingRequestDto.setIdRequested(idRequested);
		return managementRevolvingOpApplication(revolvingRequestDto, arg1, options);
	}

	public boolean managementRenewManagement(RenewDataRequest renewDataRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INRENEWDATAREQUEST, renewDataRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESADDRENEWDATA, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Operacion a refinanciar - Opcion: " + renewDataRequest.getNum_tramite());
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return serviceResponse.isResult();
	}

	public boolean updateRenewManagement(RenewDataRequest renewDataRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INRENEWDATAREQUEST, renewDataRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESUPDATERENEWDATA, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Operacion a refinanciar - Opcion: " + renewDataRequest.getNum_tramite());
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return serviceResponse.isResult();
	}

	public boolean updateRenew(DataEntity refinancingOperation, String renewType, int idRequested, ICommonEventArgs arg1, BehaviorOption options) {
		RenewDataRequest renewDataRequest = new RenewDataRequest();
		renewDataRequest.setNum_tramite(idRequested);
		renewDataRequest.setNum_operation(refinancingOperation.get(RefinancingOperations.IDOPERATION));
		renewDataRequest.setRenew_numero(refinancingOperation.get(RefinancingOperations.OPERATIONBANK).trim());
		renewDataRequest.setRenew_producto(Mnemonic.MODULECCA);
		renewDataRequest.setPayment(refinancingOperation.get(RefinancingOperations.PAYMENT) == null ? new Double("0") : refinancingOperation.get(
				RefinancingOperations.PAYMENT).doubleValue());
		renewDataRequest.setPayment_currency(refinancingOperation.get(RefinancingOperations.CURRENCYOPERATION) + "");
		renewDataRequest.setOriginal_amount(Double.parseDouble(refinancingOperation.get(RefinancingOperations.ORIGINALAMOUNT).toString()));
		renewDataRequest.setOriginal_balance(Double.parseDouble(refinancingOperation.get(RefinancingOperations.BALANCE).toString()));
		renewDataRequest.setRenew_date_grant(null);
		renewDataRequest.setRenew_type_operation(refinancingOperation.get(RefinancingOperations.CREDITTYPE));
		renewDataRequest.setCurrency_origi(refinancingOperation.get(RefinancingOperations.CURRENCYOPERATION) + "");
		renewDataRequest.setRenew_type(renewType);
		renewDataRequest.setDate_format(SessionContext.getFormatDate());
		if (refinancingOperation.get(RefinancingOperations.ISBASE)) {
			renewDataRequest.setOp_base(Mnemonic.STRING_S);
		} else {
			renewDataRequest.setOp_base(Mnemonic.STRING_N);
		}
		return updateRenewManagement(renewDataRequest, arg1, options);
	}

	public boolean createRenew(DataEntity refinancingOperation, String renewType, int idRequested, ICommonEventArgs arg1, BehaviorOption options) {
		RenewDataRequest renewDataRequest = new RenewDataRequest();
		renewDataRequest.setNum_tramite(idRequested);
		renewDataRequest.setNum_operation(refinancingOperation.get(RefinancingOperations.IDOPERATION));
		renewDataRequest.setRenew_numero(refinancingOperation.get(RefinancingOperations.OPERATIONBANK).trim());
		renewDataRequest.setRenew_producto(Mnemonic.MODULECCA);
		renewDataRequest.setPayment(refinancingOperation.get(RefinancingOperations.PAYMENT) == null ? new Double("0") : refinancingOperation.get(
				RefinancingOperations.PAYMENT).doubleValue());
		renewDataRequest.setPayment_currency(refinancingOperation.get(RefinancingOperations.CURRENCYOPERATION) + "");
		renewDataRequest.setOriginal_amount(Double.parseDouble(refinancingOperation.get(RefinancingOperations.ORIGINALAMOUNT).toString()));
		renewDataRequest.setOriginal_balance(Double.parseDouble(refinancingOperation.get(RefinancingOperations.BALANCE).toString()));
		renewDataRequest.setRenew_date_grant(null);
		renewDataRequest.setRenew_type_operation(refinancingOperation.get(RefinancingOperations.CREDITTYPE));
		renewDataRequest.setCurrency_origi(refinancingOperation.get(RefinancingOperations.CURRENCYOPERATION) + "");
		renewDataRequest.setRenew_type(renewType);
		renewDataRequest.setDate_format(SessionContext.getFormatDate());
		if (refinancingOperation.get(RefinancingOperations.ISBASE)) {
			renewDataRequest.setOp_base(Mnemonic.STRING_S);
		} else {
			renewDataRequest.setOp_base(Mnemonic.STRING_N);
		}
		return managementRenewManagement(renewDataRequest, arg1, options);
	}

	public boolean deleteRenewData(RenewDataRequest renewDataRequest, ICommonEventArgs arg1, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INRENEWDATAREQUEST, renewDataRequest);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESDELETERENEWDATA, serviceRequestTO);
		if (serviceResponse.isResult()) {
			arg1.getMessageManager().showSuccessMsg("DSGNR.SYS_DSGNR_LBLEXECOK_00003");
		} else {
			if (logger.isDebugEnabled())
				logger.logDebug("Refinancing GUARDado error PARA: " + renewDataRequest.getNum_tramite());
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return serviceResponse.isResult();
	}

	public boolean deleteRenewDataByRequest(int idRequested, String bank, String creditType, ICommonEventArgs arg1, BehaviorOption options) {
		RenewDataRequest renewDataRequest = new RenewDataRequest();
		renewDataRequest.setNum_tramite(idRequested);
		renewDataRequest.setRenew_numero(bank);
		renewDataRequest.setRenew_type_operation(creditType);
		renewDataRequest.setRenew_producto(Mnemonic.MODULECCA);
		return deleteRenewData(renewDataRequest, arg1, options);
	}

	public RenewDataResponse[] searchRenewDataByTramite(int idRequested, ICommonEventArgs arg1, BehaviorOption options) {

		logger.logDebug("searchRenewDataByTramite--------------------------------------->1");

		RenewDataRequest renewDataRequest = new RenewDataRequest();
		renewDataRequest.setNum_tramite(idRequested);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INRENEWDATAREQUEST, renewDataRequest);

		logger.logDebug("searchRenewDataByTramite--------------------------------------->2");

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEOPERATIONSEARCH, serviceRequestTO);
		logger.logDebug("searchRenewDataByTramite--------------------------------------->3");
		if (serviceResponse.isResult()) {
			logger.logDebug("searchRenewDataByTramite--------------------------------------->4");
			ServiceResponseTO serviceOpResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (RenewDataResponse[]) serviceOpResponseTO.getValue(ReturnName.RETURNRENEWDATARESPONSE);
		} else {
			logger.logDebug("searchRenewDataByTramite--------------------------------------->5");
			MessageManagement.show(serviceResponse, arg1, options);
			logger.logDebug("NO TIENE DATOS searchCustomerOperations");
		}
		logger.logDebug("searchRenewDataByTramite--------------------------------------->6");
		return null;
	}
}