package com.cobiscorp.cobis.busin.view.customevents.events;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.LineCreditData;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.dto.MessageOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.CreditLineManagement;
import com.cobiscorp.cobis.busin.flcre.commons.services.DebtorManagement;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.busin.model.DebtorGeneral;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.SourceRevenueCustomer;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ChangeVA_ORIAHEADER8602_EVAL957 extends BaseEvent implements IChangedEvent {

	private static ILogger LOGGER = LogFactory.getLogger(ChangeVA_ORIAHEADER8602_EVAL957.class);

	public ChangeVA_ORIAHEADER8602_EVAL957(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest arg0, IChangedEventArgs arg1) {
		try{
			LOGGER.logDebug("Start ChangeVA_ORIAHEADER8602_EVAL957 in " + this.getClass().toString());
			DataEntity originalHeader = arg0.getEntity(OriginalHeader.ENTITY_NAME);
			DataEntityList debtors = null;

			if (originalHeader.get(OriginalHeader.CREDITLINEVALID) != null) {
				// 1-INFORMACION DE LA LINEA
				CreditLineManagement creditLineManager = new CreditLineManagement(super.getServiceIntegration());
				LineCreditData creditLineDTO = creditLineManager.getByBank(originalHeader.get(OriginalHeader.CREDITLINEVALID), arg1, new BehaviorOption(true));

				// 5-BUSCA DEUDORES - TRAMITE ORIGINAL (LINEA)
				LOGGER.logDebug("CODIGO CREDITO LINEA:  " + creditLineDTO.getCreditCode());
				DebtorManagement debManagement = new DebtorManagement(super.getServiceIntegration());
				debtors = debManagement.getDebtorsEntityList(creditLineDTO.getCreditCode(), arg1, new BehaviorOption(true));
				if (debtors == null) {
					MessageManagement.show(arg1, new MessageOption("BUSIN.DLB_BUSIN_SAOUCENTD_07389", MessageLevel.ERROR, true));
					return;
				}
				// 9-MAPEO DE DATOS - DEUDORES			
				arg0.setEntityList(DebtorGeneral.ENTITY_NAME,debtors);
				
				// 8.- BUSCA ACTIVIDAD ECONOMICA
				DataEntityList economicActivityEntity = new DataEntityList();			
				for (DataEntity debtorEntity : debtors) {
					DataEntityList economicActivityTmp = debManagement.readEconomicActivityAndMapping(debtorEntity, arg1, new BehaviorOption(false, false));
					if (economicActivityTmp != null && economicActivityTmp.size() > 0) {
						economicActivityEntity.addAll(economicActivityTmp);
					}
				}
				arg0.setEntityList(SourceRevenueCustomer.ENTITY_NAME, economicActivityEntity);

				LOGGER.logDebug("DEudores " + debtors.size());
			}		
			LOGGER.logDebug("End ChangeVA_ORIAHEADER8602_EVAL957 in " + this.getClass().toString());
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.GENERICAP_CHANGE_ACTIVITY_957, e, arg1, LOGGER);
		}
	}
}
