package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.ReadjustmentLoanRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.customevents.parameter.ListGeneratorReadjustment;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.ReadjustmentLoanCab;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ReadjustmentLoanManager extends BaseEvent implements
		IInitDataEvent {
	private static final ILogger logger = LogFactory
			.getLogger(ReadjustmentLoanManager.class);

	public ReadjustmentLoanManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

		logger.logDebug("INGRESO ReadjustmentLoanManager");
	}

	@Override
	public void executeDataEvent(DynamicRequest arg0, IDataEventArgs arg1) {
		arg0.setEntityList(ReadjustmentLoanCab.ENTITY_NAME,
				searchReadjustmentLoan(arg0.getEntity(Loan.ENTITY_NAME)));
	}

	private DataEntityList searchReadjustmentLoan(DataEntity loan) {
		ReadjustmentLoanRequest readjustmentLoanRequest = new ReadjustmentLoanRequest();
		readjustmentLoanRequest.setDateFormat(103);
		readjustmentLoanRequest.setBank(loan.get(Loan.LOANBANKID));
		readjustmentLoanRequest.setNext(0);

		logger.logDebug("PASA POR AQUI");

		ServiceResponse response = this.execute(getServiceIntegration(),
				logger, Parameter.PROCESSSEARCHREADJUSTMENT,
				new Object[] { readjustmentLoanRequest });

		if (logger.isDebugEnabled()) {
			logger.logDebug("*****************************************************ResponseJSI"
					+ response);
			logger.logDebug("ERROR");
		}

		ListGeneratorReadjustment generador = new ListGeneratorReadjustment(
				getServiceIntegration());

		return generador.listGeneratorReadjustmentLoan(response);
	}
}
