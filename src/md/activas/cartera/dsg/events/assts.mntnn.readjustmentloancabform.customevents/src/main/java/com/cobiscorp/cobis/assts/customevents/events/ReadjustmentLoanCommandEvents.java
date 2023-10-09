package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.ReadjustmentLoanRequest;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
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
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ReadjustmentLoanCommandEvents extends BaseEvent implements
		IExecuteCommand {
	private Parameter.TYPEEXECUTION typeExecution;

	private static final ILogger logger = LogFactory
			.getLogger(ReadjustmentLoanCommandEvents.class);

	public ReadjustmentLoanCommandEvents(
			ICTSServiceIntegration serviceIntegration,
			Parameter.TYPEEXECUTION typeExecution) {
		super(serviceIntegration);

		this.typeExecution = typeExecution;
	}

	@Override
	public void executeCommand(DynamicRequest arg0,
			IExecuteCommandEventArgs arg1) {

		DataEntity readjustment = arg0
				.getEntity(ReadjustmentLoanCab.ENTITY_NAME);
		DataEntity loan = arg0.getEntity(Loan.ENTITY_NAME);

		switch (this.typeExecution) {
		case UPDATE:
			this.updateReadjustmentLoan(readjustment, loan);
			break;

		case DELETE:
			this.deleteReadjustmentLoan(readjustment, loan);
			break;

		default:
			break;
		}
	}

	private DataEntityList updateReadjustmentLoan(DataEntity readjustmentCab,
			DataEntity loan) {
		ReadjustmentLoanRequest readjustmentLoanRequest = new ReadjustmentLoanRequest();

		readjustmentLoanRequest.setSecuencial(readjustmentCab
				.get(ReadjustmentLoanCab.SECUENCIAL));
		readjustmentLoanRequest.setEspecial(readjustmentCab
				.get(ReadjustmentLoanCab.MANTCUOTA));
		readjustmentLoanRequest.setDesagio(readjustmentCab
				.get(ReadjustmentLoanCab.DESAGIO));

		readjustmentLoanRequest.setDateReadjustmentL(GeneralFunction
				.convertDateToString(
						readjustmentCab.get(ReadjustmentLoanCab.DATE), true));
		readjustmentLoanRequest.setSecuencial(readjustmentCab
				.get(ReadjustmentLoanCab.SECUENCIAL));

		readjustmentLoanRequest.setBank(loan.get(Loan.LOANBANKID));
		readjustmentLoanRequest.setDateFormat(103);
		readjustmentLoanRequest.setNext(0);

		ServiceResponse response = this.execute(getServiceIntegration(),
				logger, Parameter.PROCESSUPDATEREADJUSTMENT,
				new Object[] { readjustmentLoanRequest });

		if (logger.isDebugEnabled()) {
			logger.logDebug("Response UpdateReadjustmentLoan: " + response);
		}

		ListGeneratorReadjustment generador = new ListGeneratorReadjustment(
				getServiceIntegration());

		return generador.listGeneratorReadjustmentLoan(response);
	}

	private DataEntityList deleteReadjustmentLoan(DataEntity readjustmentCab,
			DataEntity loan) {
		ReadjustmentLoanRequest readjustmentLoanRequest = new ReadjustmentLoanRequest();
		readjustmentLoanRequest.setBank(loan.get(Loan.LOANBANKID));
		readjustmentLoanRequest.setSecuencial(readjustmentCab
				.get(ReadjustmentLoanCab.SECUENCIAL));
		readjustmentLoanRequest.setDateFormat(103);
		readjustmentLoanRequest.setNext(0);

		ServiceResponse response = this.execute(getServiceIntegration(),
				logger, Parameter.PROCESSDELETEREADJUSTMENT,
				new Object[] { readjustmentLoanRequest });

		if (logger.isDebugEnabled()) {
			logger.logDebug("Response DeleteReadjustmentLoan: " + response);
		}

		ListGeneratorReadjustment generador = new ListGeneratorReadjustment(
				getServiceIntegration());

		return generador.listGeneratorReadjustmentLoan(response);
	}
}
