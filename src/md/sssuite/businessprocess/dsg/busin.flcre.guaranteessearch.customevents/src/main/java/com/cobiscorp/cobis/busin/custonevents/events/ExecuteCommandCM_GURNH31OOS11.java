package com.cobiscorp.cobis.busin.custonevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.busin.model.WarrantieComext;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ExecuteCommandCM_GURNH31OOS11 extends BaseEvent implements IExecuteCommand {

	public ExecuteCommandCM_GURNH31OOS11(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	private static ILogger LOGGER = LogFactory.getLogger(ExecuteCommandCM_GURNH31OOS11.class);

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs arg1) {
		try{
			DataEntity warrantieComext = entities.getEntity(WarrantieComext.ENTITY_NAME);
			CatalogManagement catalogMngnt = new CatalogManagement(super.getServiceIntegration());
			String warrantieType = warrantieComext.get(WarrantieComext.WARRANTIETYPE);
			Integer currecyWarrantie = warrantieComext.get(WarrantieComext.CURRENCYWARRANTIE);
			Integer currencyComext = warrantieComext.get(WarrantieComext.CURRENCYCOMEXT);

			if (warrantieType != null && currecyWarrantie != null && currencyComext != null) {
				ParameterResponse paramGARAHO = catalogMngnt.getParameter("GARAHO", "GAR", arg1, new BehaviorOption(true));
				ParameterResponse paramGARCTE = catalogMngnt.getParameter("GARCTE", "GAR", arg1, new BehaviorOption(true));
				ParameterResponse paramGARDPF = catalogMngnt.getParameter("GARDPF", "GAR", arg1, new BehaviorOption(true));
				ParameterResponse paramMONUFV = catalogMngnt.getParameter("MONUFV", "CON", arg1, new BehaviorOption(true));
				ParameterResponse paramMLOCR = catalogMngnt.getParameter("MLOCR", "CRE", arg1, new BehaviorOption(true));
				if (LOGGER.isDebugEnabled()) {
					LOGGER.logDebug(">> TIPO WARRANTIE: " + warrantieType + ">> MONEDA COMEXT: " + currencyComext + ">> MONEDA WARRANTIE: " + currecyWarrantie);
					LOGGER.logDebug(">> GARAHO " + paramGARAHO.getParameterValue());
					LOGGER.logDebug(">> GARCTE " + paramGARCTE.getParameterValue());
					LOGGER.logDebug(">> GARDPF: " + paramGARDPF.getParameterValue());
					LOGGER.logDebug(">> MONUFV" + paramMONUFV.getParameterValue());
					LOGGER.logDebug(">> MLOCR" + paramMLOCR.getParameterValue());
				}
				if (warrantieType.equals(paramGARAHO.getParameterValue()) || warrantieType.equals(paramGARCTE.getParameterValue()) || warrantieType.equals(paramGARDPF.getParameterValue())) {
					if (currencyComext.equals(Integer.valueOf(paramMONUFV.getParameterValue())) && currecyWarrantie.equals(Integer.valueOf(paramMLOCR.getParameterValue()))) {
						arg1.setSuccess(true);
					} else if (!currencyComext.equals(currecyWarrantie)) {
						arg1.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_MSUEDAIXI_39271");
						arg1.setSuccess(false);
						return;
					} else {
						arg1.setSuccess(true);
					}
				} else {
					arg1.setSuccess(true);
				}
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GUARANTEE_EXECUTE_GARANTEE, e, arg1, LOGGER);
		}
	}
}
