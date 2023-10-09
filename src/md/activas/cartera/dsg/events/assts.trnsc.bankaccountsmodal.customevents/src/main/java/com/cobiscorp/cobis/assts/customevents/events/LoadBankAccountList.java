package com.cobiscorp.cobis.assts.customevents.events;

import java.util.Map;

import cobiscorp.ecobis.assets.cloud.dto.ReadAccountRequest;
import cobiscorp.ecobis.assets.cloud.dto.ReadAccountResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.UtilDisbursement;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.BankAccount;
import com.cobiscorp.cobis.assts.model.Entity1;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.PaymentForm;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class LoadBankAccountList extends BaseEvent implements IInitDataEvent {

	private static final ILogger logger = LogFactory
			.getLogger(LoadBankAccountList.class);

	public LoadBankAccountList(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("WATQ LoadBankAccountList.executeDataEvent(..) :: entities= "
					+ entities.getData());
			logger.logDebug("WATQ LoadBankAccountList.executeDataEvent(..) :: Parameters= "
					+ args.getParameters().getCustomParameters());
		}
		ServiceResponse response = null;
		ServiceRequestTO request = new ServiceRequestTO();
		ServiceResponseTO responseTo = null;
		ReadAccountResponse[] returnReadAccountResponse = null;
		DataEntity entity1 = entities.getEntity(Entity1.ENTITY_NAME);
		DataEntityList itemList = new DataEntityList();
		if (args.getParameters().getCustomParameters() != null
				&& args.getParameters().getCustomParameters().get("customerID") != null
				&& args.getParameters().getCustomParameters().get("payFormId") != null
				&& args.getParameters().getCustomParameters().get("desOpeType") != null
				&& args.getParameters().getCustomParameters().get("currencyId") != null
				&& validatePaymentFormCategory(args.getParameters()
						.getCustomParameters())) {

			if (logger.isDebugEnabled()) {
				logger.logDebug("WATQ LoadBankAccountList.executeDataEvent(..) : customerID= "
						+ args.getParameters().getCustomParameters()
								.get("customerID")
						+ " :: paymentType= "
						+ args.getParameters().getCustomParameters()
								.get("payFormId"));
			}

			ReadAccountRequest readAccountRequest = new ReadAccountRequest();
			readAccountRequest.setOperation(Parameter.OPERATIONH);
			readAccountRequest.setCustomerId(Integer.valueOf(args
					.getParameters().getCustomParameters().get("customerID")
					.toString().trim()));
			readAccountRequest.setProduct(args.getParameters()
					.getCustomParameters().get("payFormId").toString().trim());
			if (logger.isDebugEnabled()) {
				logger.logDebug("WATQ LoadBankAccountList.executeDataEvent(..) :: inReadAccountRequest");
			}
			request.addValue("inReadAccountRequest", readAccountRequest);
			response = execute(getServiceIntegration(), logger,
					Parameter.QUERY_COBIS_ACCOUNTS, request);
		}

		if ((response != null) && (response.isResult())) {
			responseTo = (ServiceResponseTO) response.getData();
		}
		if (responseTo != null) {
			returnReadAccountResponse = (ReadAccountResponse[]) responseTo
					.getValue("returnReadAccountResponse");
		}
		if (returnReadAccountResponse != null) {

			for (ReadAccountResponse readAccountResponse : returnReadAccountResponse) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("WATQ LoadBankAccountList.executeDataEvent(..) :: AccountNumber="
							+ readAccountResponse.getAccountNumber());
				}
				DataEntity item = new DataEntity();
				item.set(BankAccount.ACCOUNT,
						readAccountResponse.getAccountNumber());
				item.set(BankAccount.CUSTOMERCODE,
						readAccountResponse.getCustomerId());
				item.set(BankAccount.ACCOUNTNAME,
						readAccountResponse.getCustomerFullname());
				itemList.add(item);

			}
			entities.setEntityList(BankAccount.ENTITY_NAME, itemList);
			args.setSuccess(true);

		}

		if (itemList.getDataList() == null || itemList.getDataList().isEmpty()) {
			entity1.set(Entity1.ATTRIBUTE2, "ASSTS.MSG_ASSTS_NOEXISTSG_21670");
		}
	}

	public boolean validatePaymentFormCategory(
			Map<String, Object> customParameters) {
		String payFormCategory = null;
		DataEntity paymentForm = new DataEntity();
		DataEntity loanInf = new DataEntity();
		String[] productValidTypeA = new String[] { "NCAH", "NCCC", "NDAH",
				"NDCC", "ACHC", "CHGE" };
		UtilDisbursement utils = new UtilDisbursement(
				this.getServiceIntegration());
		paymentForm.set(PaymentForm.PAYFORMID, customParameters
				.get("payFormId").toString());
		loanInf.set(Loan.DESOPERATIONTYPE, customParameters.get("desOpeType")
				.toString());
		paymentForm.set(PaymentForm.CURRENCYID,
				Integer.valueOf(customParameters.get("currencyId").toString()));

		if (logger.isDebugEnabled()) {
			logger.logDebug("WATQ LoadBankAccountList.executeDataEvent(..) :: Antes de ejecutar utils.getPaymentFormCategory");
		}
		payFormCategory = utils.getPaymentFormCategory(paymentForm, loanInf);
		if (logger.isDebugEnabled()) {
			logger.logDebug("WATQ LoadBankAccountList.executeDataEvent(..) :: Despues de ejecutar utils.getPaymentFormCategory");
			logger.logDebug("WATQ LoadBankAccountList.executeDataEvent(..) :: payFormCategory= "
					+ payFormCategory);
		}
		if (payFormCategory != null
				&& useLoop(productValidTypeA, payFormCategory)) {
			return true;
		}
		return false;
	}

	private boolean useLoop(String[] arr, String targetValue) {
		for (String s : arr) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("WATQ LoadBankAccountList.executeDataEvent(..) : s= "+s.trim()
						+" :: targetValue= "+targetValue.trim());
			}
			if (s.trim().equals(targetValue.trim())) {
				return true;
			}
		}
		return false;
	}
}
