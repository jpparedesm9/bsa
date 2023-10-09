package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.ReadDisbursementFormRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.customevents.commons.UtilDisbursement;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IOnCloseModalEvent;
import com.cobiscorp.designer.api.customization.arguments.ICloseModalEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class LoadGridDetailPaymentForm extends BaseEvent implements
		IOnCloseModalEvent {
	private static final ILogger logger = LogFactory
			.getLogger(LoadGridDetailPaymentForm.class);

	public LoadGridDetailPaymentForm(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void onCloseModalEvent(DynamicRequest entities,
			ICloseModalEventArgs args) {
		ServiceRequestTO request = new ServiceRequestTO();
		ServiceResponse response = null;
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		String bankId = (String) loan.get(Loan.LOANBANKID);
		if (logger.isDebugEnabled()) {
			logger.logInfo("WATQ LoadGridDetailPaymentForm.onCloseModalEvent(..) :: entities="
					+ entities.getData());
			logger.logInfo("WATQ LoadGridDetailPaymentForm.onCloseModalEvent(..) :: bankId="
					+ bankId);
		}
		ReadDisbursementFormRequest readDisbursementFormRequest = new ReadDisbursementFormRequest();
		readDisbursementFormRequest.setBankReal(bankId.trim());
		readDisbursementFormRequest.setFictitiousBank(bankId.trim());
		readDisbursementFormRequest.setFormatDate(Integer
				.valueOf(Parameter.CODEDATEFORMAT));
		readDisbursementFormRequest
				.setFromCre(Parameter.PARAMETER_DISBURSEMENT);
		readDisbursementFormRequest
				.setRenewal(Parameter.PARAMETER_DISBURSEMENT);

		request.addValue("inReadDisbursementFormRequest",
				readDisbursementFormRequest);
		try {
			response = execute(getServiceIntegration(), logger,
					Parameter.LOAN_DISBURSEMENT_INFO, request);
		} catch (Exception e) {
			logger.logError("error en el archivo" , e);
		}

		if ((response != null) && (response.isResult())) {
			if (logger.isDebugEnabled()) {
				logger.logInfo("WATQ LoadGridDetailPaymentForm.onCloseModalEvent(..) :: Antes de utilDist.loadDataGridDetailDisbursement");
			}
			ServiceResponseTO responseTo = (ServiceResponseTO) response
					.getData();

			UtilDisbursement utilDist = new UtilDisbursement(
					this.getServiceIntegration());
			utilDist.loadDataGridDetailDisbursement(responseTo, entities);
			if (logger.isDebugEnabled()) {
				logger.logInfo("WATQ LoadGridDetailPaymentForm.onCloseModalEvent(..) :: dESPUES de utilDist.loadDataGridDetailDisbursement");
			}
		}
		GeneralFunction.handleResponse(args, response, null);
	}
}
