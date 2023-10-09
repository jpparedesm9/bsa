package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.util.HashMap;
import java.util.Map;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.CollateralApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.CollateralApplicationResponse;
import cobiscorp.ecobis.collateral.dto.AccountData;
import cobiscorp.ecobis.collateral.dto.AccountInformation;
import cobiscorp.ecobis.collateral.dto.AccountResponse;
import cobiscorp.ecobis.collateral.dto.CustodyInformation;
import cobiscorp.ecobis.collateral.dto.DepositData;
import cobiscorp.ecobis.collateral.dto.FixedTermData;
import cobiscorp.ecobis.collateral.dto.FixedTermInformation;
import cobiscorp.ecobis.collateral.dto.GuaranteeInformation;
import cobiscorp.ecobis.collateral.dto.PolicyRequest;
import cobiscorp.ecobis.collateral.dto.PolicyResponse;
import cobiscorp.ecobis.collateral.dto.PreviousGuaranteeData;
import cobiscorp.ecobis.collateral.dto.SharedEntityResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loanrequest.general.dto.CommonParams;
import cobiscorp.ecobis.loanrequest.general.dto.CustomerData;

import com.cobiscorp.cobis.busin.flcre.commons.constants.Mnemonic;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.SessionContext;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;

public class CollateralManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(CollateralManagement.class);
	private boolean hasErrorIfExists = false;
	private int BRANCHOFFICE = 1;

	public CollateralManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public boolean getHasErrorIfExists() {
		return hasErrorIfExists;
	}

	public void setHasErrorIfExists(boolean hasErrorIfExists) {
		this.hasErrorIfExists = hasErrorIfExists;
	}

	public CollateralApplicationResponse[] searchCollateral(int idRequest, ICommonEventArgs arg1, BehaviorOption options) {
		CollateralApplicationRequest collateralAplicationRequest = new CollateralApplicationRequest();
		collateralAplicationRequest.setIdrequested(idRequest);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INCOLLATERALAPPLICATION, collateralAplicationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SEARCHCOLLATERAL, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("RESULTADO EXITOSO COLLATERAL ID: " + collateralAplicationRequest.getIdrequested());
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (CollateralApplicationResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNCOLLATERALAPPLICATION);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public PolicyResponse[] searchInsurance(String warrantyCode, ICommonEventArgs arg1, BehaviorOption options) {
		PolicyRequest policyRequest = new PolicyRequest();
		policyRequest.setWarrantyCode(warrantyCode);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.ININSURANCE, policyRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SEARCHINSURANCE, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("RESULTADO ABE: " + warrantyCode);
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (PolicyResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNINSURANCE);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public boolean createCollateralApplication(CollateralApplicationRequest collateralApplicationRequest, ICommonEventArgs arg1, BehaviorOption options,
			boolean removeMessageIfExists) {
		this.setHasErrorIfExists(false);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INCOLLATERALAPPLICATION, collateralApplicationRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESCREATECOLLATERAL, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("GARANTIA GUARDADA OK PARA: " + collateralApplicationRequest.getWarranty());
			return true;
		} else {
			if (logger.isDebugEnabled())
				logger.logDebug("GARANTIA ERROR PARA: " + collateralApplicationRequest.getWarranty());

			if (options.showMessage() && serviceResponse.getMessages() != null) {
				for (Message message : serviceResponse.getMessages()) {
					if (removeMessageIfExists && message.getCode().equals("2101002")) {
						serviceResponse.getMessages().remove(message);
						this.setHasErrorIfExists(true);
					} else {
						message.setMessage(message.getMessage() + " - " + collateralApplicationRequest.getWarranty());
					}
				}
			}
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return false;
	}

	public PreviousGuaranteeData[] searchPreviousGuarantees(Integer requestID, String previousGuarantee, ICommonEventArgs arg1, BehaviorOption options) {
		GuaranteeInformation gInformation = new GuaranteeInformation();
		gInformation.setRequestId(requestID);
		gInformation.setPreviousGuarantee(previousGuarantee);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INGUARANTEEINFORMATION, gInformation);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.GETSEARCHPREVIOUSGUARANTESS, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("RESULTADO: " + requestID);
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (PreviousGuaranteeData[]) serviceItemsResponseTO.getValue(ReturnName.RETURNPREVIOUSGUARANTEEDATA);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public boolean createCollateralPrevious(GuaranteeInformation guaranteeInformation, ICommonEventArgs arg1, BehaviorOption options) {
		return managementCollateralPrevious(guaranteeInformation, arg1, options, ServiceId.INSERTPREVIOUSGUARANTEES);
	}

	public boolean deleteCollateralPrevious(Integer requestID, String previousGuarantee, String newGuarantee, ICommonEventArgs arg1, BehaviorOption options) {
		GuaranteeInformation gInformation = new GuaranteeInformation();
		gInformation.setRequestId(requestID);
		gInformation.setPreviousGuarantee(previousGuarantee);
		gInformation.setNewGuarantee(newGuarantee);
		gInformation.setMode(Mnemonic.CHAR_5);

		return managementCollateralPrevious(gInformation, arg1, options, ServiceId.DELETEPREVIOUSGUARANTEES);
	}

	public boolean deleteCollateralPrevious(Integer requestID, String previousGuarantee, ICommonEventArgs arg1, BehaviorOption options) {
		GuaranteeInformation gInformation = new GuaranteeInformation();
		gInformation.setRequestId(requestID);
		gInformation.setPreviousGuarantee(previousGuarantee);
		gInformation.setMode(Mnemonic.CHAR_6);

		return managementCollateralPrevious(gInformation, arg1, options, ServiceId.DELETEPREVIOUSGUARANTEES);
	}

	private boolean managementCollateralPrevious(GuaranteeInformation guaranteeInformation, ICommonEventArgs arg1, BehaviorOption options, String ServiceId) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INGUARANTEEINFORMATION, guaranteeInformation);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId, serviceRequestTO);
		if (!serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("EEROR - GARANTIA ERROR PARA SERVICE ID: " + ServiceId);
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return serviceResponse.isResult();
	}

	public DepositData[] searchDepositByClient(int idClient, ICommonEventArgs arg1, BehaviorOption options) {
		// DTO in
		FixedTermInformation fixedTermInformation = new FixedTermInformation();
		fixedTermInformation.setStatus2("ACT");
		fixedTermInformation.setEnte(idClient);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INFIXEDTERMINFORMATION, fixedTermInformation);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHDEPOSTIBYENTE, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (DepositData[]) serviceItemsResponseTO.getValue(ReturnName.RETURNDEPOSITDATA);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public AccountData[] searchAccountByClient(int idClient, int currencyCode, ICommonEventArgs arg1, BehaviorOption options) {
		// DTO in
		AccountInformation accountInformation = new AccountInformation();
		accountInformation.setCustomerCode(idClient);
		accountInformation.setCurrencyCode(currencyCode);
		accountInformation.setAccount("");

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INACCOUNTINFORMATION, accountInformation);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICESEARCHACCOUNTBYENTE, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return (AccountData[]) serviceItemsResponseTO.getValue(ReturnName.RETURNACCOUNTDATA);
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}
	
	public FixedTermData queryFixedTermDetail(int idClient, String fixedTermNumber, ICommonEventArgs arg1, BehaviorOption options) {
		// DTO in
		FixedTermInformation fixedTermInformation = new FixedTermInformation();
		fixedTermInformation.setStatus2("ACT");
		fixedTermInformation.setEnte(idClient);
		fixedTermInformation.setAccount(fixedTermNumber);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INFIXEDTERMINFORMATION, fixedTermInformation);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEGETQUERYDEPOSIT, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			logger.logDebug(":>:>En el servicio queryFixedTermDetail:>:>");
			return ((FixedTermData[]) serviceItemsResponseTO.getValue(ReturnName.RETURNFIXEDTERMDATA))[0];
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public AccountResponse queryAccountDetail(int idClient, int currencyCode, String accountNumber, ICommonEventArgs arg1, BehaviorOption options) {
		// DTO in
		AccountInformation accountInformation = new AccountInformation();
		accountInformation.setCustomerCode(idClient);
		accountInformation.setCurrencyCode(currencyCode);
		accountInformation.setAccount(accountNumber);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INACCOUNTINFORMATION, accountInformation);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEGETQUERYACCOUNT, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			logger.logDebug(":>:>En el servicio queryAccountDetail:>:>");
			return ((AccountResponse[]) serviceItemsResponseTO.getValue(ReturnName.RETURNACCOUNTRESPONSE))[0];
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public Map<String, Object> getQueryGuaranteeData(int codeWarranty, String typeWarranty, int office, ICommonEventArgs arg1, BehaviorOption options) {
		CustodyInformation custodyInformation = new CustodyInformation();
		CommonParams commonsParams = new CommonParams();

		Map<String, Object> result = new HashMap<String, Object>();
		custodyInformation.setType(String.valueOf(typeWarranty));
		custodyInformation.setCustody1(codeWarranty);
		custodyInformation.setVerification('S');
		custodyInformation.setBranchOffice1(office);
		commonsParams.setDateFormat(SessionContext.getFormatDate());

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INCUSTODYINFORMATION, custodyInformation);
		serviceRequestTO.getData().put(RequestName.INCCOMMONPARAMS, commonsParams);

		try {
			ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEREADCOLLATERAL, serviceRequestTO);

			if (serviceResponse.isResult()) {
				if (logger.isDebugEnabled())
					logger.logDebug("RESULTADO EXITOSO CUSTODY getQueryGuaranteeData");
				ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
				if (serviceItemsResponseTO != null) {
					result.put("CustodyAllData", serviceItemsResponseTO.getValue(ReturnName.RETURNCUSTODYALLDATA));
					result.put("CustomerData", serviceItemsResponseTO.getValue(ReturnName.RETURNCUSTOMERWARRANTYDATA));
					result.put("WarrantyLocationResponse", serviceItemsResponseTO.getValue(ReturnName.RETURWARRANTYLOCATIONRESPONSE));
					result.put("CustodyAdditionalData", serviceItemsResponseTO.getValue(ReturnName.RETURCUSTODYADITTIONALDATA));
					return result;
				}

			} else {
				MessageManagement.show(serviceResponse, arg1, options);
			}
		} catch (Exception e) {
			arg1.getMessageManager().showMessage(MessageLevel.ERROR, 0, e.getMessage());
		}
		return null;
	}

	public CustomerData[] getQueryGuaranteeCustomer(int codeWarranty, String typeWarranty, ICommonEventArgs arg1, BehaviorOption options) {
		CustodyInformation custodyInformation = new CustodyInformation();
		CommonParams commonsParams = new CommonParams();
		custodyInformation.setType(String.valueOf(typeWarranty));
		custodyInformation.setCustody1(codeWarranty);
		custodyInformation.setVerification('S');
		custodyInformation.setBranchOffice1(BRANCHOFFICE);
		commonsParams.setDateFormat(SessionContext.getFormatDate());

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INCUSTODYINFORMATION, custodyInformation);
		serviceRequestTO.getData().put(RequestName.INCCOMMONPARAMS, commonsParams);

		try {
			ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEREADCOLLATERAL, serviceRequestTO);

			if (serviceResponse.isResult()) {
				if (logger.isDebugEnabled())
					logger.logDebug("RESULTADO EXITOSO CUSTODY getQueryGuaranteeCustomer");
				ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
				return (CustomerData[]) serviceItemsResponseTO.getValue(ReturnName.RETURNCUSTOMERWARRANTYDATA);
			} else {
				MessageManagement.show(serviceResponse, arg1, options);
			}
		} catch (Exception e) {
			arg1.getMessageManager().showMessage(MessageLevel.ERROR, 0, e.getMessage());
		}
		return null;
	}

	public SharedEntityResponse[] getEntities(String warrantyType, Integer custodyCode, Integer office, ICommonEventArgs args) throws BusinessException {

		CustodyInformation custodyInformation = new CustodyInformation();
		custodyInformation.setBranchOffice1(office);
		custodyInformation.setCustody1(custodyCode);
		custodyInformation.setType(warrantyType);

		CallServices callService = new CallServices(getServiceIntegration());
		Object[] objects = callService.callServiceWithReturnArray(RequestName.INCUSTODYINFORMATION, custodyInformation, ServiceId.SERVICEGETSHAREDENTITIES,
				ReturnName.RETURNSHAREDENTITYRESPONSE, args);
		return objects == null ? new SharedEntityResponse[0] : (SharedEntityResponse[]) objects;

	}

}