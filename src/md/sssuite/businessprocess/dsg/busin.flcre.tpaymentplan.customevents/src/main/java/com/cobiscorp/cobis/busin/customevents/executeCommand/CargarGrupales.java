package com.cobiscorp.cobis.busin.customevents.executeCommand;
import java.math.BigDecimal;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerResponse;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountRequest;
import cobiscorp.ecobis.loangroup.dto.GroupLoanAmountResponse;
import cobiscorp.ecobis.loangroup.dto.GroupRequest;
import cobiscorp.ecobis.loangroup.dto.GroupResponse;

import com.cobiscorp.cobis.busin.flcre.commons.services.PaymentSelectionManager;
import com.cobiscorp.cobis.busin.model.MemberAmount;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
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

public class CargarGrupales extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory
			.getLogger(CargarGrupales.class);

	public CargarGrupales(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs commandArgs) {
		try {
			LOGGER.logDebug("Start changed in CargarGrupales");
			
			GroupLoanAmountRequest request = new GroupLoanAmountRequest();
			DataEntity paymentSelection = entities.getEntity(PaymentSelection.ENTITY_NAME);

			LOGGER.logDebug("Group id: "+ paymentSelection.get(PaymentSelection.GROUPID));
			LOGGER.logDebug("Tramite id: "+ paymentSelection.get(PaymentSelection.TRANSACTIONNUMBER));
			LOGGER.logDebug("Credit Type grupal: "+ paymentSelection.get(PaymentSelection.CREDITTYPE));

			DataEntity paymentPlanHeader = entities.getEntity(PaymentPlanHeader.ENTITY_NAME);
			
			if (paymentSelection.get(PaymentSelection.CREDITTYPE).equals("GRUPAL")) {
				// BUSCAR LOS DATOS DEL GRUPO
				GroupRequest groupRequest = new GroupRequest();
				String codeStr = paymentSelection.get(PaymentSelection.GROUPID);
				if (codeStr != null) {
					groupRequest.setCode(Integer.parseInt(codeStr));
				}

				PaymentSelectionManager paymentSelectionManager = new PaymentSelectionManager(
						getServiceIntegration());
				GroupResponse groupResponse = paymentSelectionManager
						.searchGroup(groupRequest, commandArgs);
				
				paymentPlanHeader.set(PaymentPlanHeader.DEBITACCOUNT,
						groupResponse.getGroupAccount());
				LOGGER.logDebug("nueva cuenta 22>>>"+groupResponse.getGroupAccount());
				paymentPlanHeader.set(PaymentPlanHeader.ACCOUNT,
						groupResponse.getGroupAccount());
				LOGGER.logDebug("cuenta grupal 22 " + groupResponse.getGroupAccount());
				// Consultar los miembros del grupo y sus cuentas
				request.setGroupId(Integer.parseInt(paymentSelection
						.get(PaymentSelection.GROUPID)));
				request.setSolicitude(Integer.parseInt(paymentSelection
						.get(PaymentSelection.TRANSACTIONNUMBER)));

				GroupLoanAmountResponse[] listGroupAccounts = paymentSelectionManager
						.searchGroupAccounts(request, commandArgs);
				DataEntityList listAccounts = new DataEntityList();
				DataEntity account = null;
				LOGGER.logDebug("entro 22>>>>"+listGroupAccounts.length);
				for (GroupLoanAmountResponse temp : listGroupAccounts) {
					account = new DataEntity();
					LOGGER.logDebug("cuenta >>>"+temp.getAccountNumber());
					account.set(MemberAmount.ACCOUNTNUMBER,
							temp.getAccountNumber());
					account.set(MemberAmount.GROUPID, request.getGroupId());
					account.set(MemberAmount.AMOUNT,
							new BigDecimal(temp.getAmount()));
					account.set(MemberAmount.CREDIT, request.getSolicitude());
					account.set(MemberAmount.MEMBERID, temp.getCustomerId());
					account.set(MemberAmount.MEMBERNAME, temp.getCustumerName());
					listAccounts.add(account);
				}

				entities.setEntityList(MemberAmount.ENTITY_NAME, listAccounts);
			}else {
				//TODO: Obtener del cliente_aux
				LOGGER.logDebug("No es grupal >>>> " );
				CustomerRequest customerRequest=new CustomerRequest();
				customerRequest.setCustomerId(Integer.parseInt(paymentSelection.get(PaymentSelection.GROUPID)));
				PaymentSelectionManager paymentSelectionManager=new PaymentSelectionManager(getServiceIntegration());
				CustomerResponse customerResponse=paymentSelectionManager.searchCustomer(customerRequest, commandArgs);
				if(customerResponse.getAccountIndividual() != null){
					LOGGER.logDebug("No es grupal Cuenta >>>> " +customerResponse.getAccountIndividual());
					paymentPlanHeader.set(PaymentPlanHeader.ACCOUNT,customerResponse.getAccountIndividual());
				}
				
			}
			commandArgs.setSuccess(true);

		} catch (Exception ex) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_CARGA_GRUOUP, ex, commandArgs, LOGGER);
		}
	}

}
