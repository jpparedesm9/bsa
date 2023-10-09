package com.cobiscorp.cobis.busin.flcre.commons.utiles;

import java.util.List;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.Infocred;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.services.InfoCredManagement;
import com.cobiscorp.cobis.busin.model.DebtorGeneral;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;

public class InforCredUtil extends BaseEvent implements IExecuteCommand {

	public final static String TYPEDEUDOR = "D";

	private static ILogger logger = LogFactory.getLogger(InforCredUtil.class);

	public InforCredUtil(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		Integer customerDebtorId = this.getCodeDebtor(entities.getEntityList(DebtorGeneral.ENTITY_NAME), args);
		if (customerDebtorId > 0) {
			Infocred infocredDTO = new Infocred();
			infocredDTO.setCustomerCode(customerDebtorId);
			
			InfoCredManagement infoCredManagement = new InfoCredManagement(getServiceIntegration());
			//infoCredManagement.getInfoCred(entities, args);

			/*ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			serviceRequestTO.getData().put("inInfocred", infocredDTO);

			ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, "Businessprocess.Creditmanagement.CreditBureauOperations.ValidateInfocred", serviceRequestTO);

			if (serviceResponse.isResult()) {
				if (logger.isDebugEnabled())
					logger.logDebug("VALIDACION REGISTRO INFOCRED OK");
			} else {
				this.managementMessage(serviceResponse.getMessages(), args);
				args.setSuccess(false);
			}*/
		}
	}

	private int getCodeDebtor(DataEntityList debtors, IExecuteCommandEventArgs args) {
		for (DataEntity dataEntity : debtors) {
			if (TYPEDEUDOR.equals(dataEntity.get(DebtorGeneral.ROLE))) {
				return dataEntity.get(DebtorGeneral.CUSTOMERCODE);
			}
		}
		args.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_SAOUCENTD_07389");
		args.setSuccess(false);
		return -1;
	}

	/*private void managementMessage(List<Message> errMessage, IExecuteCommandEventArgs args) {
		if (errMessage != null)
			for (Message message : errMessage) {
				args.getMessageManager().showMessage(MessageLevel.ERROR, Integer.parseInt(message.getCode()), message.getMessage());
			}
	}*/

}
