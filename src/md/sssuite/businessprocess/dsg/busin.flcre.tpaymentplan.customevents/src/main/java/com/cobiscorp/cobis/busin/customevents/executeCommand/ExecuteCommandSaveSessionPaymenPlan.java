package com.cobiscorp.cobis.busin.customevents.executeCommand;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.services.AmortizationTableManagement;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.Property;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

/**
 * @author jrueda
 * 
 */
public class ExecuteCommandSaveSessionPaymenPlan extends BaseEvent implements
		IExecuteCommand {
	private static ILogger LOGGER = LogFactory
			.getLogger(ExecuteCommandSaveSessionPaymenPlan.class);

	public ExecuteCommandSaveSessionPaymenPlan(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs arg1) {
		// TODO Auto-generated method stub
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("ExecuteCommandSaveSessionPaymenPlan starts executeCommand");
		try {
			DataEntity originalHeader = entities
					.getEntity(OriginalHeader.ENTITY_NAME);
			DataEntity paymentPlanHeader = entities
					.getEntity(PaymentPlanHeader.ENTITY_NAME);
			DataEntity generalData = entities.getEntity("generalData");

			String processInstanceIdentifier = "", clientId = "", bussinessInformationStringOne = "";
			int ownerIdentifier = 0;
			if (paymentPlanHeader.get(PaymentPlanHeader.APPLICATIONNUMBER) == null) {// IDREQUESTED
				processInstanceIdentifier = "";
			} else {
				processInstanceIdentifier = paymentPlanHeader.get(
						PaymentPlanHeader.APPLICATIONNUMBER).toString();
			}

			if (paymentPlanHeader.get(PaymentPlanHeader.CUSTOMERCODE) == null) {
				clientId = "";
			} else {
				clientId = paymentPlanHeader
						.get(PaymentPlanHeader.CUSTOMERCODE).toString();
			}

			if (generalData.get(new Property<String>(
					"BUSSINESSINFORMATIONSTRINGONE", String.class)) == null) {
				bussinessInformationStringOne = "";
			} else {
				bussinessInformationStringOne = generalData
						.get(new Property<String>(
								"BUSSINESSINFORMATIONSTRINGONE", String.class));
			}
			if (originalHeader.get(OriginalHeader.IDREQUESTED) == null) {
				ownerIdentifier = 0;
			} else {
				ownerIdentifier = Integer.parseInt(originalHeader
						.get(OriginalHeader.IDREQUESTED));
			}
			if (originalHeader.get(OriginalHeader.PRODUCTTYPE) == null) {
				originalHeader.set(OriginalHeader.PRODUCTTYPE, "");
			}

			LOGGER.logDebug("ExecuteCommandSaveSessionPaymenPlan cargando objeto");
			Object[] object = new Object[] { processInstanceIdentifier,
					clientId, bussinessInformationStringOne, ownerIdentifier,
					originalHeader.get(OriginalHeader.PRODUCTTYPE) // BUSSINESSINFORMATIONSTRINGTWO
			};
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("ExecuteCommandSaveSessionPaymenPlan envio a servicio");
				LOGGER.logDebug(":>:>ExecuteCommandSaveSessionPaymenPlan:>:>Datos:>processInstanceIdentifier:>"
						+ processInstanceIdentifier
						+ ":>clientId:>"
						+ clientId
						+ ":>bussinessInformationStringOne:>"
						+ bussinessInformationStringOne
						+ ":>ownerIdentifier:>"
						+ ownerIdentifier
						+ ":>:>"
						+ ":>BUSSINESSINFORMATIONSTRINGTWO:>"
						+ originalHeader.get(OriginalHeader.PRODUCTTYPE));
			}
			AmortizationTableManagement amortizationTableManagement = new AmortizationTableManagement(
					super.getServiceIntegration());
			amortizationTableManagement.commitPaymentPlan(object);
		} catch (Exception ex) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_EXECUTE_SAVESESSION, ex, arg1, LOGGER);
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("ExecuteCommandSaveSessionPaymenPlan finishes executeCommand");
		}

	}
}
