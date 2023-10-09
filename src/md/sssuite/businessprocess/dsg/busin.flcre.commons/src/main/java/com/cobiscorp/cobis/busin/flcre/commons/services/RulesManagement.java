package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RuleRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RuleResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleProcess;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleVersion;
import com.cobiscorp.ecobis.bpl.rules.engine.model.VariableProcess;

public class RulesManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(RulesManagement.class);

	public RulesManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public List<String> getValues(String rulerAcronym, List<VariableProcess> vars, ICommonEventArgs arg1, BehaviorOption options) {
		try {
			Rule rul = new Rule();
			rul.setId(314);
			rul.setName("VALIDACION TIPO PRODUCTO - PRUEBA");
			rul.setAcronym("VTP");
			rul.setType("R");
			rul.setSubType("CRE");

			RuleVersion ruleVersion = new RuleVersion();
			ruleVersion.setId(257);
			ruleVersion.setRule(rul);
			Calendar cal = Calendar.getInstance();
			cal.set(Calendar.YEAR, 2015);
			cal.set(Calendar.MONTH, 6);
			cal.set(Calendar.DAY_OF_MONTH, 30);
			ruleVersion.setDateFinish(cal);

			/*
			 * List<VariableProcess> vars = new ArrayList<VariableProcess>();
			 * 
			 * VariableProcess var1 = new VariableProcess(); var1.setValue("CI");
			 * 
			 * Variable vr = new Variable(); vr.setCodigoVariable((short) 105);
			 * 
			 * var1.setVariable(vr);
			 * 
			 * vars.add(var1);
			 */

			Map<RuleVersion, List<VariableProcess>> valorHAS = new HashMap<RuleVersion, List<VariableProcess>>();
			valorHAS.put(ruleVersion, vars);

			ServiceResponse retorno = this.execute(super.getServiceIntegration(), logger, "Bpl.Rules.Engine.RuleManager.Generate", new Object[] { valorHAS, 0, "", 3 });
			if (retorno.isResult()) {
				@SuppressWarnings("unchecked")
				List<RuleProcess> rpList = (List<RuleProcess>) retorno.getData();
				if (rpList.size() > 0) {
					RuleProcess rp = rpList.get(0);
					List<String> returnList = new ArrayList<String>();
					for (VariableProcess ite : rp.getVariableProcesses()) {
						returnList.add(ite.getValue());
					}
					return returnList;
				}
			} else {
				MessageManagement.show(retorno, arg1, options);
			}
		} catch (Exception e) {
			if (logger.isDebugEnabled())
				logger.logDebug("ERROR EN TRAER REGLAS:", e);
			if (options.showMessageException())
				arg1.getMessageManager().showMessage(MessageLevel.ERROR, options.getCodeException(), e.getMessage());
			if (options.isSuccessFalse())
				arg1.setSuccess(false);
		}
		return null;
	}

	public RuleResponse[] readRule(int idRequest, ICommonEventArgs arg1, BehaviorOption options) {
		RuleRequest ruleRequest = new RuleRequest();
		ruleRequest.setIdRequested(idRequest);

		ServiceRequestTO serviceRequestTOException = new ServiceRequestTO();
		serviceRequestTOException.addValue(RequestName.INRULEREQUEST, ruleRequest);
		logger.logDebug("REGLAS DTO ENTRADA" + RequestName.INRULEREQUEST);
		ServiceResponse serviceResponseException = execute(getServiceIntegration(), logger, ServiceId.SERVICEREADRULE, serviceRequestTOException);
		if (serviceResponseException.isResult()) {

			ServiceResponseTO serviceExpceptionResponseTO = (ServiceResponseTO) serviceResponseException.getData();
			RuleResponse[] ruleResp = (RuleResponse[]) serviceExpceptionResponseTO.getValue(ReturnName.RETURNREADRULE);
			return ruleResp;
		} else {
			MessageManagement.show(serviceResponseException, arg1, options);
		}
		return null;
	}

	public boolean createRuleByRole(RuleRequest ruleRequest, ICommonEventArgs args, BehaviorOption options) {
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.addValue(RequestName.INRULEREQUEST, ruleRequest);

		ServiceResponse serviceResponse = execute(super.getServiceIntegration(), logger, ServiceId.SERVICECREATERULE, serviceRequestTO);
		if (serviceResponse.isResult()) {
			if (logger.isDebugEnabled())
				logger.logDebug("Servicio Ejecutado Correctamente: " + ServiceId.SERVICECREATERULE);
		} else {
			MessageManagement.show(serviceResponse, args, options);
			args.setSuccess(false);
		}
		return serviceResponse.isResult();
	}

}
