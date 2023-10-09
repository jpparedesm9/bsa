package com.cobiscorp.cobis.busin.custonevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.services.GuaranteeManagement;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.OtherWarranty;
import com.cobiscorp.cobis.busin.model.PersonalGuarantor;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class ExecuteComandWarranty extends BaseEvent implements IExecuteCommand {
	private static ILogger LOGGER = LogFactory.getLogger(ExecuteComandWarranty.class);

	public ExecuteComandWarranty(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs arg1) {
		
		try{

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Entra entrywarranty -> ExecuteComandWarranty");

			DataEntity originalHeader = entities.getEntity(OriginalHeader.ENTITY_NAME);
			DataEntityList collaterals = entities.getEntityList(PersonalGuarantor.ENTITY_NAME);
			DataEntityList collateralg = entities.getEntityList(OtherWarranty.ENTITY_NAME);
			int idRequest = Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED));

			// 1.- GUARDA TODAS LAS - GARANTIA PERSONAL - Y - OTROS TIPOS DE
			// GARANTIA
			if ((collaterals != null && !collaterals.isEmpty()) || (collateralg != null && !collateralg.isEmpty())) {

				GuaranteeManagement guaranteeMngmnt = new GuaranteeManagement(super.getServiceIntegration());
				boolean saveisOk = guaranteeMngmnt.saveCollateral(entities, idRequest, arg1);

				// 2.- RECUPERA DATOS DE LAS GARANTIAS
				GuaranteeManagement.searchCollateral(entities, arg1, super.getServiceIntegration());
				guaranteeMngmnt.isWarrantiesHeritageLine(entities, arg1, super.getServiceIntegration());

				// Recupera las garantias heredadas
				if (originalHeader.get(OriginalHeader.TYPEREQUEST).equals("E") || originalHeader.get(OriginalHeader.TYPEREQUEST).equals("R")) {
					guaranteeMngmnt.isWarrantiesHeritageOtherRequest(entities, arg1, super.getServiceIntegration());
				}

				if (saveisOk) {
					arg1.getMessageManager().showSuccessMsg("BUSIN.DLB_BUSIN_IEJTAITMT_92625");
					arg1.setSuccess(true);
				} else {
					arg1.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_EOLESLCII_85566");
					arg1.setSuccess(false);
				}

			}else {
				arg1.getMessageManager().showInfoMsg("BUSIN.DLB_BUSIN_AGRGGNAUR_68251");
				arg1.setSuccess(false);
			}

			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Salida entrywarranty -> ExecuteComandWarranty");
			
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.EXECUTE_WARRANTY, e, arg1, LOGGER);
		}
		
	}

}
