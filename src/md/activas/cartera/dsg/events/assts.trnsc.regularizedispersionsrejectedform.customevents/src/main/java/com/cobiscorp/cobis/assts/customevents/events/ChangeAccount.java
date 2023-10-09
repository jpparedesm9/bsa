package com.cobiscorp.cobis.assts.customevents.events;

import java.text.SimpleDateFormat;

import cobiscorp.ecobis.assets.cloud.dto.RejectedDispersionsRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobis.cloud.sofom.customers.utils.santander.dto.ConnectionInfo;
import com.cobiscorp.cobis.assets.commons.services.RejectedDispersionManagement;
import com.cobiscorp.cobis.assts.model.DetailRejectedDispersions;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.services.utilservices.api.ICobisParameter;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
//import com.cobis.cloud.sofom.customers.utils.santander.dto.ConnectionInfo;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerCoreInfo;

public class ChangeAccount extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(ChangeAccount.class);

	protected ICobisParameter cobisParameter;

	public ChangeAccount(ICTSServiceIntegration serviceIntegration, ICobisParameter cobisParameter) {
		super(serviceIntegration);
		this.cobisParameter = cobisParameter;
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs arg1) {

		LOGGER.logDebug(">>>>> Inicia ChangeAccount");

		try {
			RejectedDispersionsRequest rejectedDispersionsRequest = new RejectedDispersionsRequest();
			DataEntityList rejectedDispersionsList = entities.getEntityList(DetailRejectedDispersions.ENTITY_NAME);

			LOGGER.logInfo(">>>>> ChangeAccount - entidad:" + rejectedDispersionsList.toString());
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			for (DataEntity row : rejectedDispersionsList) {

				LOGGER.logInfo(">>>>> ChangeAccount - for: " + DetailRejectedDispersions.SELECTION);

				if (row.get(DetailRejectedDispersions.SELECTION) != null && row.get(DetailRejectedDispersions.SELECTION)) {

					QuerySantander santander = new QuerySantander(this.getServiceIntegration());
					Integer codeCustomer = Integer.parseInt(row.get(DetailRejectedDispersions.CUSTOMERCODE));
					CustomerCoreInfo customerCoreInfo = santander.querySantander(codeCustomer, arg1);

					if (customerCoreInfo != null) {
						LOGGER.logInfo("---->>> ChangeAccount - customerCoreInfo: " + customerCoreInfo);
						String newAccount = customerCoreInfo.getCustomerAccountId();
						LOGGER.logInfo("---->>> ChangeAccount - newAccount: " + newAccount);

						//Disbursement disbursement = new Disbursement();
						//disbursement.researchAccountForDisbursement(row.get(DetailRejectedDispersions.BUC), connectionInfo);

						rejectedDispersionsRequest.setStartDate(sdf.format(row.get(DetailRejectedDispersions.DATE)));
						rejectedDispersionsRequest.setConsecutive(row.get(DetailRejectedDispersions.CONSECUTIVE));
						rejectedDispersionsRequest.setLine(row.get(DetailRejectedDispersions.LINE));
						rejectedDispersionsRequest.setAccount(newAccount);

						rejectedDispersionsRequest.setAction(2);

						RejectedDispersionManagement dispersionManagement = new RejectedDispersionManagement(getServiceIntegration());

						rejectedDispersionsRequest.setOperation('C');

						dispersionManagement.dispersionActions(rejectedDispersionsRequest, arg1);
						 
						LOGGER.logInfo("---->>> ChangeAccount - Fin Actualizo Metodo");
						arg1.getMessageManager().showSuccessMsg("Operación Ejecutada Exitosamente");
						
					} else {
						LOGGER.logDebug(">>>>>Inicia ChangeAccount - No tiene cuenta en Santander");
						ExceptionUtils.showError("No tiene cuenta en Santander", null, arg1, LOGGER);
					}
				}
			}
		} catch (Exception e) {
			LOGGER.logDebug(">>>>>Inicia ChangeAccount - Error al ejecutar acción Cambiar Cuenta");
			ExceptionUtils.showError("Error al ejecutar acción Cambiar Cuenta", e, arg1, LOGGER);
		}
	}

}
