package com.cobiscorp.ecobis.cloud.service.integration;

import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.cloud.service.dto.solidaritypayment.SolidarityPaymentCustomerData;
import com.cobiscorp.ecobis.cloud.service.dto.solidaritypayment.SolidarityPaymentRequest;
import com.cobiscorp.ecobis.cloud.service.util.RestServiceBase;
import com.google.gson.Gson;

import cobiscorp.ecobis.assets.cloud.dto.SolidarityPayment;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Created by farid on 7/24/2017.
 */
public class SolidarityPaymentService extends RestServiceBase {
	private final ILogger logger = LogFactory.getLogger(SolidarityPaymentService.class);
	private final String className = "[SolidarityPaymentService] ";

	public SolidarityPaymentService(ICTSServiceIntegration integration) {
		super(integration);
	}

	public void createSolidarityPayment(SolidarityPaymentRequest request) {
		if (logger.isDebugEnabled()) {
			Gson gson = new Gson();
			logger.logDebug(className + "[createSolidarityPayment][SolidarityPaymentRequest]:" + gson.toJson(request));
		}
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		SolidarityPayment solidarityPayment = new SolidarityPayment();
		solidarityPayment.setGroupId(request.getSolidarityPaymentData().getGroupId());
		if (request.getSolidarityPaymentData().getDebitsSavingAccounts()) {
			solidarityPayment.setAffectsSavings('S');
		} else {
			solidarityPayment.setAffectsSavings('N');
		}
		solidarityPayment.setAmount(request.getSolidarityPaymentData().getGroupAmount());
		solidarityPayment.setPaymentsDetail(this.convertListMemberToString(request.getSolidarityPaymentCustomerData()));
		serviceRequestTO.addValue("inSolidarityPayment", solidarityPayment);

		if (logger.isDebugEnabled()) {
			Gson gson = new Gson();
			logger.logDebug(className + "[createSolidarityPayment][ServiceRequestTO]:" + gson.toJson(serviceRequestTO));
		}
		ServiceResponse serviceResponse = this.execute("Loan.SolidarityPayment.InsertSolidarityPayment", serviceRequestTO);
		if (logger.isDebugEnabled()) {
			Gson gson = new Gson();
			logger.logDebug(className + "[createSolidarityPayment][ServiceResponse]:" + gson.toJson(serviceResponse));
		}
	}

	private String convertListMemberToString(List<SolidarityPaymentCustomerData> members) {
		String value = "";
		Integer index = 0;
		for (SolidarityPaymentCustomerData member : members) {
			if (index == members.size() - 1) {
				value = value + member.getCustomerId() + "|" + member.getAmountPayWholePayment();
			} else {
				value = value + member.getCustomerId() + "|" + member.getAmountPayWholePayment() + ";";
			}
			index++;
		}
		return value;
	}
}
