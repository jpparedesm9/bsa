package com.cobiscorp.cobis.busin.flcre.commons.bli;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RuleRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.RuleResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.cobis.busin.flcre.commons.constants.Format;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.RulesManagement;
import com.cobiscorp.cobis.busin.model.Exceptions;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;

public class Ruler_BLI {
	private static ILogger logger = LogFactory.getLogger(Ruler_BLI.class);

	public static void changeCurrencyRequested(DynamicRequest entities, IChangedEventArgs arg1, ICTSServiceIntegration serviceIntegration) {
	}

	public static void createByRequestId(DynamicRequest entities, IExecuteCommandEventArgs args, ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled())
			logger.logDebug("Ingreso -> GRABAR REGLAS POR TRAMITE -> Ruler_BLI : IExecuteCommandEventArgs");
		DataEntityList exceptions = entities.getEntityList(Exceptions.ENTITY_NAME);
		DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
		int idRequest = 0;
		RuleRequest ruleRequest = new RuleRequest();
		RulesManagement rulesMngmnt = new RulesManagement(serviceIntegration);
		try {
			if(originalHeader!=null&&originalHeader.get(OriginalHeader.IDREQUESTED)!=null){
				idRequest = Integer.valueOf(originalHeader.get(OriginalHeader.IDREQUESTED));
				ruleRequest.setIdRequested(idRequest);
				ruleRequest.setIduser(args.getParameters().getUser());
				if (hasRulers(args, idRequest, serviceIntegration))
					ruleRequest.setOperation(Format.OPERATION_ITEMS_DETAIL_UPDATE);
				else
					ruleRequest.setOperation(Format.OPERATION_ITEMS_DETAIL_INSERT);
				if(logger.isDebugEnabled()){
					logger.logDebug(":>:>excepciones:>:>"+exceptions.getDataList());
				}				
				args.setSuccess(true);
				for (DataEntity excp : exceptions) {
					ruleRequest.setIdRule(excp.get(Exceptions.MNEMONIC));
					ruleRequest.setAutorized(excp.get(Exceptions.APROVED));
	
					logger.logDebug("VALOR CHEK:" + excp.get(Exceptions.MNEMONIC) + "-" + excp.get(Exceptions.APROVED));
	
					if (!rulesMngmnt.createRuleByRole(ruleRequest, args, new BehaviorOption(true))) {
						args.setSuccess(false);
					}
					if(!excp.get(Exceptions.APROVED)){
						args.setSuccess(false);
						logger.logDebug("APROVED FALSO-> NO DEBE PASAR LA TAREA");
					}
				}
			}else{
				args.setSuccess(false);
			}
		} catch (Exception e) {
			logger.logDebug("Exception -> GRABAR REGLAS POR TRAMITE -> Ruler_BLI : IExecuteCommandEventArgs", e);
			args.getMessageManager().showErrorMsg("Error: " + e.getMessage());
			args.setSuccess(false);
			return;
		}
		args.getMessageManager().showSuccessMsg("BUSIN.DLB_BUSIN_IEJTAITMT_92625");

		if (logger.isDebugEnabled())
			logger.logDebug("Salida -> GRABAR REGLAS POR TRAMITE -> Ruler_BLI : IExecuteCommandEventArgs");
	}

	private static boolean hasRulers(IExecuteCommandEventArgs arg1, Integer idRequest, ICTSServiceIntegration serviceIntegration) {
		RulesManagement rulesMngt = new RulesManagement(serviceIntegration);
		RuleResponse[] ruleResponse = rulesMngt.readRule(idRequest, arg1, new BehaviorOption(false, false));
		return (ruleResponse != null) && (ruleResponse.length > 0);
	}
}