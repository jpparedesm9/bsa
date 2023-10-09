package com.cobiscorp.ecobis.cloud.service.integration;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.extractOutputValue;
import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.extractValue;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICobisParameter;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.busin.model.RenapoRequest;
import com.cobiscorp.ecobis.business.commons.platform.services.BiometricManager;
import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.MaxAmount;
import com.cobiscorp.ecobis.cloud.service.dto.group.GroupResult;
import com.cobiscorp.ecobis.cloud.service.dto.group.Member;
import com.cobiscorp.ecobis.cloud.service.util.ArrayUtil;
import com.cobiscorp.ecobis.cloud.service.util.CalendarUtil;
import com.cobiscorp.ecobis.cloud.service.util.Constants;
import com.cobiscorp.ecobis.cloud.service.util.IntegrationException;
import com.cobiscorp.ecobis.cloud.service.util.RestServiceBase;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.RenapoResponse;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerTotalRequest;
import cobiscorp.ecobis.loangroup.dto.ApplicationGroupResponse;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountRequest;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountResponse;
import cobiscorp.ecobis.loangroup.dto.GroupRequest;
import cobiscorp.ecobis.loangroup.dto.GroupResponse;
import cobiscorp.ecobis.loangroup.dto.MemberRequest;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;
import cobiscorp.ecobis.loangroup.dto.MemberResponseRenovation;

/**
 * @author Cesar Loachamin
 */
public class GroupIntegrationService extends RestServiceBase {

	private final ILogger LOGGER = LogFactory.getLogger(GroupIntegrationService.class);
	private ICTSServiceIntegration serviceIntegration = null;
	private ICobisParameter parameterService;

	public GroupIntegrationService(ICTSServiceIntegration integration) {
		super(integration);
		serviceIntegration = integration;
	}

	public GroupResponse searchGroup(int groupId) {
		GroupRequest request = new GroupRequest();
		request.setCode(groupId);
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inGroupRequest", request);
		ServiceResponse response = execute("LoanGroup.GroupMaintenance.SearchGroup", requestTo);
		return extractValue(response, "returnGroupResponse", GroupResponse.class);
	}

	public GroupResult createGroup(GroupRequest request) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inGroupRequest", request);
		ServiceResponse response = execute("LoanGroup.GroupMaintenance.CreateGroup", requestTo);
		return new GroupResult(extractOutputValue(response, "@o_grupo", Integer.class));
	}

	public void updateGroup(GroupRequest request) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inGroupRequest", request);
		execute("LoanGroup.GroupMaintenance.UpdateGroup", requestTo);
	}

	public MemberResponse[] searchMembers(int groupId) {
		MemberRequest request = new MemberRequest();
		request.setMode(0);
		request.setGroupId(groupId);
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inMemberRequest", request);
		ServiceResponse response = execute("LoanGroup.MemberMaintenance.SearchMember", requestTo);
		return extractValue(response, "returnMemberResponse", MemberResponse[].class);
	}

	public ApplicationGroupResponse readGroupApplication(int applicationId) {
		LOGGER.logDebug("Inicio servicio readGroupApplication:" + applicationId);
		GroupLoanAmountRequest request = new GroupLoanAmountRequest();
		request.setSolicitude(applicationId);
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inGroupLoanAmountRequest", request);
		ServiceResponse response = execute("LoanGroup.GroupLoanAmountMaintenance.ReadGroupApplication", requestTo);
		return extractValue(response, "returnApplicationGroupResponse", ApplicationGroupResponse.class);
	}

	public MemberResponse searchMember(int groupId, final int memberId) {
		return ArrayUtil.find(searchMembers(groupId), new ArrayUtil.Predicate<MemberResponse>() {
			@Override
			public boolean test(MemberResponse obj) {
				return obj.getCustomerId() == memberId;
			}
		});
	}

	public void createMember(MemberRequest request) {
		List<String> errorCodes = Arrays.asList("208916", "208917", "208918", "208919", "208920", "208921", "208922", "208923");
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inMemberRequest", request);
		try {
			execute("LoanGroup.MemberMaintenance.CreateMember", requestTo);
		} catch (IntegrationException ie) {
			// Check if there is a validation code to set the result as true
			for (Message message : ie.getResponse().getMessages()) {
				if (errorCodes.contains(message.getCode())) {
					ie.getResponse().setResult(true);
				}
			}
			throw ie;
		}
	}

	public void updateMember(MemberRequest request) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inMemberRequest", request);
		execute("LoanGroup.MemberMaintenance.UpdateMember", requestTo);
	}

	public void deleteMember(int groupId, int customerId) {
		MemberRequest request = new MemberRequest();
		request.setGroupId(groupId);
		request.setCustomerId(customerId);
		request.setStateId("C");
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inMemberRequest", request);
		execute("LoanGroup.MemberMaintenance.DeleteMember", requestTo);
	}

	public CustomerResponse[] searchMemberRelation(int customerId, int groupId) {

		String serviceId = "CustomerDataManagementService.CustomerManagement.SearchRelationClient";
		CustomerRequest request = new CustomerRequest();
		request.setCustomerId(customerId);
		request.setGroupCode(groupId);
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inCustomerRequest", request);
		ServiceResponse response = execute(serviceId, requestTo);
		return extractValue(response, "returnCustomerResponse", CustomerResponse[].class);
	}

	/**
	 * Obtiene los valores de los montos de cada cliente del grupo para el trÃ¡mite
	 * en curso
	 * 
	 * @param groupId             código del grupo
	 * @param creditApplicationId código del trámite
	 * @return
	 */
	public GroupLoanAmountResponse[] searchAmounts(int groupId, int creditApplicationId) {
		String serviceId = "LoanGroup.GroupLoanAmountMaintenance.ListLoanAmount";
		GroupLoanAmountRequest request = new GroupLoanAmountRequest();
		request.setGroupId(groupId);
		request.setSolicitude(creditApplicationId);
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inGroupLoanAmountRequest", request);
		ServiceResponse response = execute(serviceId, requestTo);
		return extractValue(response, "returnGroupLoanAmountResponse", GroupLoanAmountResponse[].class);
	}

	/**
	 * Obtiene los valores que se debe devolver a la app para pintar en la solicitud
	 * Puede ser: el valor mínimo entre monto máximo grupal e incremento, el valor
	 * del monto copiado de una solicitud anterior rechazada
	 * 
	 * @param groupId             código del grupo
	 * @param creditApplicationId código del trámite
	 * @return
	 */
	public List<MaxAmount> searchMaxAmounts(int groupId, int creditApplicationId, String requestType) {
		List<MaxAmount> maxAmounts = new ArrayList<MaxAmount>();

		if (Constants.TYPE_REQUEST_RENOVATION.equals(requestType)) {
			MemberResponseRenovation[] renovationAmounts = searchAmountsRenovation(groupId, creditApplicationId);

			// cuando se copia los montos de una solicitud rechazada
			for (MemberResponseRenovation amount : renovationAmounts) {
				MaxAmount amountTmp = new MaxAmount();
				if (amount.getAmount() != null && amount.getAmount() != 0) {
					amountTmp.setAmount(amount.getAmount());
				} else if (amount.getIncrement() != null && amount.getProposedMaximumSaving() != null && amount.getIncrement() <= amount.getProposedMaximumSaving()) {
					amountTmp.setAmount(amount.getIncrement());
				} else {
					amountTmp.setAmount(amount.getProposedMaximumSaving());
				}
				amountTmp.setPreviousBalance(amount.getBalance() == null ? 0.0 : amount.getBalance().doubleValue());
				amountTmp.setResultAmount(amountTmp.getAmount() - (amountTmp.getPreviousBalance() == null ? 0.0 : amountTmp.getPreviousBalance()));
				amountTmp.setCycleNumber(amount.getCycle() == null ? 1 : amount.getCycle());
				amountTmp.setCustomerCode(amount.getCustomer());
				maxAmounts.add(amountTmp);
			}

		} else {
			GroupLoanAmountResponse[] amounts = searchAmounts(groupId, creditApplicationId);
			for (GroupLoanAmountResponse amount : amounts) {
				MaxAmount amountTmp = new MaxAmount();
				// cuando se copia los montos de una solicitud rechazada
				if (amount.getAmount() != null && amount.getAmount() != 0) {
					amountTmp.setAmount(amount.getAmount());
				} else if (amount.getIncrement() != null && amount.getProposedMaximumSaving() != null && amount.getIncrement() <= amount.getProposedMaximumSaving()) {
					amountTmp.setAmount(amount.getIncrement());
				} else {
					amountTmp.setAmount(amount.getProposedMaximumSaving());
				}
				amountTmp.setCycleNumber(amount.getCycleNumber() == null ? 1 : amount.getCycleNumber());
				amountTmp.setCustomerCode(amount.getCustomerId());
				amountTmp.setPreviousBalance(0.0);
				amountTmp.setResultAmount(0.0);
				maxAmounts.add(amountTmp);
			}
		}
		return maxAmounts;
	}

	/**
	 * Obtiene los valores que se debe devolver a la app para pintar en la solicitud
	 * Puede ser: el valor mÃ­nimo entre monto maximo grupal e incremento, el valor
	 * del monto copiado de una solicitud anterior rechazada
	 * 
	 * @param groupId             código del grupo
	 * @param creditApplicationId código del trámite
	 * @return
	 */
	public ServiceResponse queryRenapo(Member[] members) throws BusinessException, Exception {
		String renapoParameter = parameterService.getParameter(null, "CLI", "RENAPO", String.class);
		ServiceResponse serviceResponse = new ServiceResponse();
		CustomerResponse customerResponse = null;
		BiometricManager biometricManager = new BiometricManager(serviceIntegration);

		if ("S".equals(renapoParameter)) {
			for (Member member : members) {
				int personCode = member.getCustomerId();
				/* Consultar Cliente */
				CustomerRequest customerRequest = new CustomerRequest();
				customerRequest.setOperation('M');
				customerRequest.setFormatDate(103);
				customerRequest.setCustomerId(personCode);
				ServiceRequestTO request = new ServiceRequestTO();
				request.addValue("inCustomerRequest", customerRequest);

				CustomerIntegrationService customerService = new CustomerIntegrationService(serviceIntegration);
				customerResponse = customerService.searchCustomer(personCode);
				LOGGER.logDebug("customerResponse getCheckRenapo(): " + customerResponse.getCheckRenapo());
				if (customerResponse.getCustomerName() != null) {
					if ("N".equals(customerResponse.getCheckRenapo()) || (customerResponse.getCheckRenapo() == null) || "E".equals(customerResponse.getCheckRenapo())
							|| "".equals(customerResponse.getCheckRenapo())) {

						StringBuilder name = new StringBuilder();
						name.append(customerResponse.getCustomerName());
						name.append(customerResponse.getCustomerSecondName() == null || customerResponse.getCustomerSecondName().trim().equals("") ? ""
								: " " + customerResponse.getCustomerSecondName());

						RenapoRequest renapoRequest = new RenapoRequest();
						renapoRequest.setName(name.toString());

						String convertDate = (null != customerResponse.getCustomerBirthdate() && "" != customerResponse.getCustomerBirthdate())
								? CalendarUtil.convertDate(customerResponse.getCustomerBirthdate())
								: null;

						LOGGER.logDebug("[GroupIntegrationService - queryRenapo]-----------customerResponse.getCustomerBirthdate(): " + customerResponse.getCustomerBirthdate()
								+ " --- Cliente:" + personCode);
						LOGGER.logDebug("[GroupIntegrationService - queryRenapo]-----------convertDate: " + convertDate + " --- Cliente:" + personCode);

						renapoRequest.setBirthDate(convertDate);
						renapoRequest.setBirthPlace(String.valueOf(customerResponse.getCountyOfBirth()));
						renapoRequest.setLastName(customerResponse.getCustomerLastName());
						renapoRequest.setSecondLastName(customerResponse.getCustomerSecondLastName());
						renapoRequest.setGender(customerResponse.getGenderCode());

						LOGGER.logDebug("RenapoRequest [" + renapoRequest.toString() + "]");

						RenapoResponse renapo = biometricManager.queryCurpFromRenapo(renapoRequest);
						LOGGER.logDebug("El CURP para el cliente " + personCode + " es " + renapo);

						String curp = renapo.getCurp() == null ? customerResponse.getCustomerIdentificaction() : renapo.getCurp();
						String status = renapo.getStatus() == null ? customerResponse.getCheckRenapo() : renapo.getStatus();

						CustomerTotalRequest customerTotalRequest = new CustomerTotalRequest();
						customerTotalRequest.setMode(1);
						customerTotalRequest.setIdentification(curp);
						customerTotalRequest.setCheckRenapo(status);
						customerTotalRequest.setCodePerson(personCode);

						customerService = new CustomerIntegrationService(serviceIntegration);
						customerService.updateCustomerRenapo(customerTotalRequest);

						member.setCheckRenapo(status);

					}
				} else {
					LOGGER.logDebug("Error al consultar datos del cliente.");
				}
			}
		}
		serviceResponse.setData(members);
		return serviceResponse;

	}

	public MemberResponseRenovation[] searchAmountsRenovation(int groupId, int creditApplicationId) {
		String serviceId = "LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation";
		GroupLoanAmountRequest request = new GroupLoanAmountRequest();
		request.setGroupId(groupId);
		request.setSolicitude(creditApplicationId);
		ServiceRequestTO requestTo = new ServiceRequestTO();
		requestTo.addValue("inGroupLoanAmountRequest", request);
		ServiceResponse response = execute(serviceId, requestTo);
		return extractValue(response, "returnMemberResponseRenovation", MemberResponseRenovation[].class);
	}

	public void setParameterService(ICobisParameter parameterService) {
		this.parameterService = parameterService;
	}

	public void unsetParameterService(ICobisParameter parameterService) {
		this.parameterService = null;
	}
}