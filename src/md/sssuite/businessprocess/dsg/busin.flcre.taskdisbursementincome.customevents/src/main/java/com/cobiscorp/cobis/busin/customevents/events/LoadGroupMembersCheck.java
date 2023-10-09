package com.cobiscorp.cobis.busin.customevents.events;

import java.math.BigDecimal;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountRequest;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountResponse;
import cobiscorp.ecobis.loangroup.dto.GroupRequest;
import cobiscorp.ecobis.loangroup.dto.GroupResponse;

import com.cobiscorp.cobis.busin.flcre.commons.services.PaymentSelectionManager;
import com.cobiscorp.cobis.busin.model.DisbursementIncome;
import com.cobiscorp.cobis.busin.model.MemberAmount;
import com.cobiscorp.cobis.busin.model.MemberGroup;
import com.cobiscorp.cobis.busin.model.PaymentSelection;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class LoadGroupMembersCheck  extends BaseEvent implements IExecuteCommand{
	private static final ILogger LOGGER = LogFactory
			.getLogger(LoadGroupMembers.class);
	public LoadGroupMembersCheck(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs commandArgs) {
		// TODO Auto-generated method stub
		try {
			LOGGER.logDebug("Start changed in LoadGroupMembersCheck");
			// consultar la cuenta del grupo

			GroupLoanAmountRequest request = new GroupLoanAmountRequest();
			DataEntity paymentSelection = entities
					.getEntity(PaymentSelection.ENTITY_NAME);

			LOGGER.logDebug("Group id: "
					+ paymentSelection.get(PaymentSelection.GROUPID));
			LOGGER.logDebug("Tramite id: "
					+ paymentSelection.get(PaymentSelection.TRANSACTIONNUMBER));
			LOGGER.logDebug("Credit Type: "
					+ paymentSelection.get(PaymentSelection.CREDITTYPE));

			DataEntity disbursmentIncome = entities
					.getEntity(DisbursementIncome.ENTITY_NAME);
			
			if (paymentSelection.get(PaymentSelection.CREDITTYPE).equals("GRUPAL")) {
				// BUSCAR LOS DATOS DEL GRUPO, para obtener cuenta grupal
				GroupRequest groupRequest = new GroupRequest();
				String codeStr = paymentSelection.get(PaymentSelection.GROUPID);
				if (codeStr != null) {
					groupRequest.setCode(Integer.parseInt(codeStr));
				}

				PaymentSelectionManager paymentSelectionManager = new PaymentSelectionManager(
						getServiceIntegration());
				GroupResponse groupResponse = paymentSelectionManager
						.searchGroup(groupRequest, commandArgs);
				
				disbursmentIncome.set(DisbursementIncome.ACCOUNT,
						groupResponse.getGroupAccount());

				// Consultar los miembros del grupo y sus cuentas
				request.setGroupId(Integer.parseInt(paymentSelection
						.get(PaymentSelection.GROUPID)));
				request.setSolicitude(Integer.parseInt(paymentSelection
						.get(PaymentSelection.TRANSACTIONNUMBER)));

				GroupLoanAmountResponse[] listGroupAccounts = paymentSelectionManager
						.searchGroupAccounts(request, commandArgs);
				DataEntityList listAccounts = new DataEntityList();
				DataEntity account = null;

				for (GroupLoanAmountResponse temp : listGroupAccounts) {
					account = new DataEntity();
					
					account.set(MemberGroup.ACCOUNTNUMBER,
							temp.getAccountNumber());
					account.set(MemberGroup.GROUPID, request.getGroupId());
					account.set(MemberGroup.AMOUNT,
							new BigDecimal(temp.getAmount()));
					account.set(MemberGroup.CREDIT, request.getSolicitude());
					account.set(MemberGroup.MEMBERID, temp.getCustomerId());
					account.set(MemberGroup.MEMBERNAME, temp.getCustumerName());
					account.set(MemberGroup.ACCOUNTNUMBER,
							temp.getAccountNumber());
					account.set(MemberGroup.GROUPID, request.getGroupId());
					account.set(MemberGroup.AMOUNT,
							new BigDecimal(temp.getAmount()));
					account.set(MemberGroup.CREDIT, request.getSolicitude());
					account.set(MemberGroup.MEMBERID, temp.getCustomerId());
					account.set(MemberGroup.MEMBERNAME, temp.getCustumerName());
					account.set(MemberGroup.CHECK,temp.getBankCheck());
					//account.set(MemberGroup.CHECK,temp.get)
					//cheque null
					listAccounts.add(account);
				}

				entities.setEntityList(MemberGroup.ENTITY_NAME, listAccounts);
			}else{
			/*	CustomerRequest customerRequest=new CustomerRequest();
				customerRequest.setCustomerCode(paymentSelection.get(PaymentSelection.GROUPID));
				customerRequest.setCustomerId(Integer.parseInt(paymentSelection.get(PaymentSelection.GROUPID)));
				
				
				PaymentSelectionManager paymentSelectionManager=new PaymentSelectionManager(getServiceIntegration());
				CustomerResponse customerResponse = paymentSelectionManager.searchCustomer(customerRequest, commandArgs);
		        
		        LOGGER.logDebug("getAccountAuxiliary: " + customerResponse.getAccountAuxiliary());
		        disbursmentIncome.set(DisbursementIncome.ACCOUNT, customerResponse.getAccountAuxiliary());*/
			}
			commandArgs.setSuccess(true);

		} catch (Exception ex) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.DISBURSEMENTINCOME_EXECUTE_MEMBERCHECK, ex, commandArgs, LOGGER);
		}
		
	}

}
