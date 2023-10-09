package com.cobiscorp.cobis.busin.custonevents.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.collateral.dto.PolicyAllInformation;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.model.WarrantyPoliciy;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowDeleting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class QV_ERWRL4097_89_RowDeleting extends BaseEvent implements IGridRowDeleting {

	public QV_ERWRL4097_89_RowDeleting(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	private static ILogger LOGGER = LogFactory.getLogger(QV_ERWRL4097_89_RowDeleting.class);

	public final static String DELETEPOLICYALLINFORMATION = "inPolicyAllInformation";

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs args) {
		LOGGER.logDebug("Ingreso rowAction QV_ERWRL4097_89_RowDeleting ");
		try {

			LOGGER.logDebug("row gvi -->  " + row.toString());

			PolicyAllInformation policyAllInformation = new PolicyAllInformation();

			policyAllInformation.setBranchOffice(row.get(WarrantyPoliciy.BRANCHOFFICE));
			LOGGER.logDebug("BRANCHOFFICE gvi -->  " + policyAllInformation.getBranchOffice());
			policyAllInformation.setTypeCustody(String.valueOf(row.get(WarrantyPoliciy.CUSTODYTYPE)));
			LOGGER.logDebug("CUSTODYTYPE gvi -->  " + policyAllInformation.getTypeCustody());
			policyAllInformation.setCustody(row.get(WarrantyPoliciy.CUSTODY));
			LOGGER.logDebug("CUSTODY gvi -->  " + policyAllInformation.getCustody());
			policyAllInformation.setInsurance(String.valueOf(row.get(WarrantyPoliciy.INSURANCE)));
			LOGGER.logDebug("INSURANCE gvi -->  " + policyAllInformation.getInsurance());
			policyAllInformation.setPolicy(String.valueOf(row.get(WarrantyPoliciy.NUMBERPOLICY)));
			LOGGER.logDebug("NUMBERPOLICY gvi -->  " + policyAllInformation.getPolicy());

			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			ServiceResponse serviceResponse;

			serviceRequestTO.getData().put(DELETEPOLICYALLINFORMATION, policyAllInformation);

			serviceResponse = execute(getServiceIntegration(), LOGGER, "Collateral.CollateralMaintenance.DeletePolicy", serviceRequestTO);

			if (serviceResponse != null && serviceResponse.isResult()) {

				args.getMessageManager().showSuccessMsg("BUSIN.DLB_BUSIN_SGCSLERER_06336");

				args.setSuccess(true);
			} else {

				List<Message> errorMessage = new ArrayList<Message>();

				args.setSuccess(false);
				if (serviceResponse != null)
					errorMessage = serviceResponse.getMessages();			
				for (Message message : errorMessage) {
					args.getMessageManager().showErrorMsg(message.getMessage() + "/n");
				}
			}

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.WARRANTIES_ROW_DELETING, e, args, LOGGER);
		} finally {
			LOGGER.logDebug("Finaliza rowAction ->QV_ERWRL4097_89_RowDeleting");
		}

	}
}

