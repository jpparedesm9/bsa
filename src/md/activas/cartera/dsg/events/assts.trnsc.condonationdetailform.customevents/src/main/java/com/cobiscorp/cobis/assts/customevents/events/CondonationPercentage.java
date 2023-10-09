package com.cobiscorp.cobis.assts.customevents.events;

import java.math.BigDecimal;
import java.util.Map;

import cobiscorp.ecobis.assets.cloud.dto.RuleRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assts.model.ServerParameter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class CondonationPercentage extends BaseEvent implements IInitDataEvent {

	private static final ILogger logger = LogFactory
			.getLogger(CondonationPercentage.class);

	public CondonationPercentage(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@SuppressWarnings("unchecked")
	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs eventArgs) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Incio executeDataEvent");
		}

		try {
			ServiceRequestTO request = new ServiceRequestTO();
			DataEntity loan = entities.getEntity(ServerParameter.ENTITY_NAME);
			
			if (logger.isDebugEnabled()) {
				logger.logDebug("DDDDDDDd");
				logger.logDebug(loan.getData());
			}

			RuleRequest ruleRequest = new RuleRequest();
			ruleRequest.setLoanBank(loan.get(ServerParameter.LOANBANKID));

			request.addValue("inRuleRequest", ruleRequest);
			ServiceResponse response = this.execute(getServiceIntegration(),
					logger, "Loan.Rules.GetCondonationPercentage", request);

			if (response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response
						.getData();

				Map<String, String> outRuleResponse = (Map<String, String>) resultado
						.getValue("com.cobiscorp.cobis.cts.service.response.output");
				BigDecimal percentage = BigDecimal.valueOf(0);

				if (outRuleResponse.get("@o_porcentaje") != null) {
					percentage = BigDecimal.valueOf(Double
							.parseDouble(outRuleResponse.get("@o_porcentaje")));
				}
				if (logger.isDebugEnabled()) {
					logger.logDebug("COND PERCENTAGE: " + percentage);
				}
				loan.set(ServerParameter.CONDONATIONPERCENTAGE, percentage);
			}
		} catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.logError(e);
			}
			this.manageException(e, logger);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finaliza executeDataEvent");
			}
		}
	}

}
