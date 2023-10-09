package com.cobiscorp.cobis.busin.customevents.executeCommand;

import java.util.Map;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SourceFundingRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.SourceFundingResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.CreditOtherData;
import com.cobiscorp.cobis.busin.model.PaymentPlanHeader;
import com.cobiscorp.cobis.busin.model.SourceFunding;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ExecuteAplicarFuenteVA_VWPAYMENLA2621_NCRI285 extends BaseEvent
		implements IExecuteCommand {

	private static ILogger LOGGER = LogFactory
			.getLogger(ExecuteAplicarFuenteVA_VWPAYMENLA2621_NCRI285.class);

	public ExecuteAplicarFuenteVA_VWPAYMENLA2621_NCRI285(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Ingreso ExecuteAplicarFuenteVA_VWPAYMENLA2621_NCRI285");
		try {

			DataEntity paymentPlanHeader = entities
					.getEntity(PaymentPlanHeader.ENTITY_NAME);
			DataEntity creditOtherData = entities
					.getEntity(CreditOtherData.ENTITY_NAME);

			SourceFundingRequest sourceFundingRequest = new SourceFundingRequest();

			Integer numeroTramite = paymentPlanHeader
					.get(PaymentPlanHeader.IDREQUESTED);

			sourceFundingRequest.setTramite(numeroTramite);
			sourceFundingRequest.setFuenteFinanciamiento(creditOtherData
					.get(CreditOtherData.SOURCEOFFUNDING));

			LOGGER.logInfo("1..............numeroTramiteActualizar..................."
					+ numeroTramite);
			LOGGER.logInfo("1..............sourceFundingRequest.getFuenteFinanciamiento..................."
					+ sourceFundingRequest.getFuenteFinanciamiento());

			if (numeroTramite != null) {
				ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
				serviceRequestTO.getData().put("inSourceFundingRequest",
						sourceFundingRequest);
				ServiceResponse serviceResponse = execute(
						getServiceIntegration(), LOGGER,
						ServiceId.SERVICEUPATESOURCEREQUEST, serviceRequestTO);

				if (serviceResponse.isResult()) {
					if (LOGGER.isDebugEnabled())
						LOGGER.logDebug("Servicio Ejecutado Correctamente Update: "
								+ ServiceId.SERVICEUPATESOURCEREQUEST);
					args.getMessageManager().showSuccessMsg(
							"BUSIN.DLB_BUSIN_IEJTAITMT_92625");
				} else {
					MessageManagement.show(serviceResponse, args,
							new BehaviorOption(false));
					args.setSuccess(false);
				}
			}

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_EXECUTE_FUENTE, e, args, LOGGER);
		}

	}
}