package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RuleAmountMaxResponse;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RuleCreditSectorRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RuleRateRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RuleRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RuleScoreRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.TransactionContext;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.SessionContext;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.api.util.SessionUtil;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleProcess;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleVersion;
import com.cobiscorp.ecobis.bpl.rules.engine.model.VariableProcess;

public class RuleExecutionManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(RuleExecutionManagement.class);

	public RuleExecutionManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	/**
	 * @param acronym - ACRONIMO DE LA REGAL, CUYA VERSION SE VA A CONSULTAR
	 * @param arg1 - ICommonEventArgs
	 * @param options - BehaviorOption
	 * @return
	 */
	public RuleVersion readVersion(String acronym, ICommonEventArgs arg1, BehaviorOption options) {
		// BUSCA LA ULTIMA VERSION DISPONIBLE DE LA REGLA
		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.BPL_FINDRULEACTIVEBYACRONYM, new Object[] { acronym });
		if (serviceResponse != null && serviceResponse.isResult()) {
			@SuppressWarnings("unchecked")
			List<RuleVersion> ruleList = (List<RuleVersion>) serviceResponse.getData();
			if (!ruleList.isEmpty()) {
				return ruleList.get(0);
			} else {
				arg1.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_UALQUETNO_54424", new String[] { acronym }, true);
				return null;
			}
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	/**
	 * @param ruleVersion - ULTIMA VERSION DISPONIBLE DE LA REGLA
	 * @param varProList - LISTA DE VARIABLES PROCESO
	 * @param customerId - id del cliente cuando existen excepciones
	 * @param creditCardNumber - numero de la tarjeta de crédito cuando existen excepciones
	 * @param arg1 - ICommonEventArgs
	 * @param options - BehaviorOption
	 * @return
	 */
	public List<RuleProcess> executeRule(RuleVersion ruleVersion, List<VariableProcess> varProList, int customerId, String creditCardNumber, ICommonEventArgs arg1, BehaviorOption options) {
		// CREACION DE MAPA CON LA REGLA Y LA LISTA DE VARIABLES PROCESO
		HashMap<RuleVersion, List<VariableProcess>> valueRequest = new HashMap<RuleVersion, List<VariableProcess>>();
		valueRequest.put(ruleVersion, varProList);

		// CREACION DEL OBJETO DE REQUEST
		// [0] -> (valueRequest) = es le mapa creado
		// [1] -> (customerId) = id del cliente cuando existen excepciones
		// [2] -> (creditCardNumber) = numero de la tarjeta de crédito cuando existen excepciones
		// [3] -> (SessionUtil.getRol) = es el id del role que se logueo el usuario.
		Object[] objectRequest = new Object[] { valueRequest, customerId, creditCardNumber, Integer.valueOf(SessionUtil.getRol()) };

		// EJECUCION DEL SERVICIO, DONDE LOS PARAMETROS SON:
		ServiceResponse serviceResponse = this.execute(getServiceIntegration(), logger, ServiceId.BPL_GENERATE, objectRequest);

		if (serviceResponse != null && serviceResponse.isResult()) {
			@SuppressWarnings("unchecked")
			List<RuleProcess> ruleProcessList = (List<RuleProcess>) serviceResponse.getData();
			return ruleProcessList;
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public TransactionContext readRuleForRateCreditLine(int requestId, ICommonEventArgs arg1, BehaviorOption options) {
		TransactionContext retorno = new TransactionContext();

		RuleRateRequest ruleRateRequest = new RuleRateRequest();
		ruleRateRequest.setRequestId(requestId);
		ruleRateRequest.setDateFormat(SessionContext.getFormatDate());

		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.RULE_RATEREQUEST, ruleRateRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.RULE_QUERYVALUESFORRATECREDITLINE, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();
			@SuppressWarnings("unchecked")
			Map<String, Object> ruleRateResponse = (Map<String, Object>) serviceResponseApplicationTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
			if (ruleRateResponse.get("@o_resultado") != null) {
				retorno.addValue("ValueForRateCreditLine", Double.parseDouble(ruleRateResponse.get("@o_resultado").toString()));
				retorno.setSuccess(true);
				return retorno;
			}
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return retorno;
	}

	public TransactionContext readRuleForScoreType(int requestId, ICommonEventArgs arg1, BehaviorOption options) {
		TransactionContext retorno = new TransactionContext();

		RuleScoreRequest ruleScoreRequest = new RuleScoreRequest();
		ruleScoreRequest.setRequestId(requestId);
		ruleScoreRequest.setDateFormat(SessionContext.getFormatDate());

		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.RULE_SCOREREQUEST, ruleScoreRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.RULE_QUERYVALUESFORSCORETYPE, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();
			@SuppressWarnings("unchecked")
			Map<String, Object> ruleRateResponse = (Map<String, Object>) serviceResponseApplicationTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
			if (ruleRateResponse.get("@o_resultado") != null) {
				retorno.addValue("ValueForRateCreditLine", ruleRateResponse.get("@o_resultado"));
				retorno.setSuccess(true);
				return retorno;
			}
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return retorno;
	}

	public TransactionContext queryDataForRuleCreditSector(int requestId, String object, Double index, ICommonEventArgs arg1, BehaviorOption options) {
		TransactionContext retorno = new TransactionContext();

		RuleCreditSectorRequest ruleCreditSectorRequest = new RuleCreditSectorRequest();
		ruleCreditSectorRequest.setRequestId(requestId);
		ruleCreditSectorRequest.setDateFormat(SessionContext.getFormatDate());
		ruleCreditSectorRequest.setObjet(object);
		ruleCreditSectorRequest.setIndexSize(index);

		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.RULE_CREDIT_SECTOR_REQUEST, ruleCreditSectorRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.RULE_QUERY_CREDIT_SECTOR, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();
			@SuppressWarnings("unchecked")
			Map<String, Object> ruleCreditSectorResponse = (Map<String, Object>) serviceResponseApplicationTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
			if (ruleCreditSectorResponse.get("@o_resultado") != null) {
				retorno.addValue("ValorQueryDataForRuleCreditSector", ruleCreditSectorResponse.get("@o_resultado"));
				retorno.setSuccess(true);
				return retorno;
			}
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return retorno;
	}

	public void ejectRuleCreditSector(int requestId, String object, Double index, IExecuteCommandEventArgs arg1) {
		logger.logDebug("---------> ingreso a ejecutar la regla - queryDataForRuleCreditSector");
		TransactionContext transactionContext = queryDataForRuleCreditSector(requestId, object, index, arg1, new BehaviorOption(true));
		if (!transactionContext.isSuccess()) {
			arg1.setSuccess(false);
		}
	}

	public String readRuleAmounMaxMessage(int requestId, String id_rule, ICommonEventArgs arg1, BehaviorOption options) {

		logger.logDebug("Inicio de Servicio readRuleAmounMaxMessage");

		String retorno = "No hay mensaje";

		RuleRequest ruleRequest = new RuleRequest();
		ruleRequest.setIdRequested(requestId);
		ruleRequest.setIdRule(id_rule);

		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INRULEREQUEST, ruleRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICE_RULE_AMOUNT_MAX, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseApplicationTO = (ServiceResponseTO) serviceResponse.getData();

			if (serviceResponseApplicationTO.isSuccess()) {
				@SuppressWarnings("unchecked")
				Map<String, Object> ruleAmountMaxResponse = (Map<String, Object>) serviceResponseApplicationTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
				if (ruleAmountMaxResponse.get("@o_msg1") != null) {
					retorno = ruleAmountMaxResponse.get("@o_msg1").toString();
					return retorno;
				}
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));
			}
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return retorno;
	}

	public RuleAmountMaxResponse readRuleAmounMax(int requestId, String id_rule, ICommonEventArgs arg1, BehaviorOption options) {

		logger.logDebug("Inicio de Servicio readRuleAmounMax");

		RuleRequest ruleRequest = new RuleRequest();
		ruleRequest.setIdRequested(requestId);
		ruleRequest.setIdRule(id_rule);

		ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
		serviceRequestApplicationTO.addValue(RequestName.INRULEREQUEST, ruleRequest);

		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICE_RULE_AMOUNT_MAX, serviceRequestApplicationTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			RuleAmountMaxResponse ruleAmountMaxResponse = (RuleAmountMaxResponse) serviceItemsResponseTO.getValue((ReturnName.RETURN_RULE_AMOUNT_MAX));
			if (serviceItemsResponseTO.isSuccess()) {
				return ruleAmountMaxResponse;
			} else {
				throw new BusinessException(703037, raiseException(serviceResponse));
			}
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public String raiseException(ServiceResponse serviceResponse) {
		if (serviceResponse != null && serviceResponse.getMessages() != null) {
			StringBuffer errors = new StringBuffer();
			for (Message message : serviceResponse.getMessages()) {
				errors.append("Error ");
				errors.append(message.getCode());
				errors.append(": ");
				errors.append(message.getMessage());
				errors.append("\n");
			}
			return errors.toString();
		}
		return "";
	}

}
