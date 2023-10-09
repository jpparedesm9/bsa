package com.cobiscorp.cobis.busin.customevents.change;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.WorkflowManagement;
import com.cobiscorp.cobis.busin.model.ApprovalCriteriaQuestion;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleProcess;
import com.cobiscorp.ecobis.bpl.rules.engine.model.VariableProcess;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

/***
 * Change event of input rebate request in discount rate tag to apply for rebate
 * rate
 * 
 * @author ntrujillo
 * 
 */
public class ChangeRebateRequest extends BaseEvent implements IChangedEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(ChangeRebateRequest.class);

	public ChangeRebateRequest(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest arg0, IChangedEventArgs arg1) {
		// TODO Auto-generated method stub
		// Ejecución de regla REBAJA DE TASA nemonic RT para validación de
		// solicitud de rebaja máxima de tasa por cargo
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("Start changed in " + this.getClass().toString());
		DataEntity entity;
		int value;
		String rebateRequest;
		WorkflowManagement workflowManagement;
		Map<String, Object> variables;
		List<RuleProcess> resultados;
		arg1.setSuccess(true);

		try {
			resultados = new ArrayList<RuleProcess>();
			entity = arg0.getEntity(ApprovalCriteriaQuestion.ENTITY_NAME);
			value = entity.get(ApprovalCriteriaQuestion.REBATE);			
			rebateRequest = entity.get(ApprovalCriteriaQuestion.REBATEREQUEST);
			
			if (rebateRequest != null && !rebateRequest.isEmpty()) {
				if(value<0){
					arg1.getMessageManager().showInfoMsg("DLB_BUSIN_IPAESOZEO_95873");
					entity.set(ApprovalCriteriaQuestion.REBATE,0);
					arg1.setSuccess(false);	
					return;
				}
				workflowManagement = new WorkflowManagement(super.getServiceIntegration());
				variables = new HashMap<String, Object>();
				variables.put("CARGOS", rebateRequest);
				variables.put("REBAJA_TASA", String.valueOf(value));
				resultados = workflowManagement.executeRule("RT", variables, arg1, new BehaviorOption(true));

				for (RuleProcess iterador : resultados) {				
					for (VariableProcess iterador2 : iterador.getVariableProcesses()) {					
						arg1.getMessageManager().showErrorMsg("Máxima rebaja de tasa" + " " + iterador2.getValue());
						arg1.setSuccess(false);							
						break;
					}
				}

			} else {
				arg1.getMessageManager().showInfoMsg("DLB_BUSIN_SEATRQUET_39085");
				entity.set(ApprovalCriteriaQuestion.REBATE,0);
				arg1.setSuccess(false);	
			}			

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.PAYMENTPLAN_CHANGE_REBATE, e, arg1, LOGGER);
		}

		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("End changed in " + this.getClass().toString());

	}

}
