package com.cobiscorp.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.ClauseRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.AmortizationTable;
import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

/**
 * Implementa los eventos executeCommand para Aplicar la Clausula
 * 
 * @author rsanchez
 * 
 */
public class ClausuleManagement extends BaseEvent implements IExecuteCommand {

	private static final ILogger logger = LogFactory
			.getLogger(ClausuleManagement.class);

	public ClausuleManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs arg1) {
	
		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingreso log Manager de clausule");
		}
		applyClause(entities.getEntity(Loan.ENTITY_NAME), arg1);
		
		AmortizationTable amortizacion = new AmortizationTable(
				this.getServiceIntegration());
		amortizacion.amortizationQuery(entities);
	}

	/**
	 * @param clause
	 */
	public ServiceResponse applyClause(DataEntity clause,
			IExecuteCommandEventArgs args) {
		ServiceRequestTO request = new ServiceRequestTO();

		ClauseRequest clauseRequest = new ClauseRequest();
		clauseRequest.setBank(clause.get(Loan.LOANBANKID));
		request.addValue("inClauseRequest", clauseRequest);
		
		ServiceResponse response = execute(getServiceIntegration(), logger,
				"Loan.LoanTransaction.TransactionClause", request);

		GeneralFunction.handleResponse(args, response,null);
		return response;

	}

	
}
