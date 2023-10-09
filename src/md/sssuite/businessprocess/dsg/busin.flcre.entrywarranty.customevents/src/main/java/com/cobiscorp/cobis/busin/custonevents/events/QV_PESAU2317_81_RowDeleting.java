package com.cobiscorp.cobis.busin.custonevents.events;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.CollateralApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.CollateralApplicationResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.busin.model.PersonalGuarantor;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IGridRowDeleting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.designer.common.MessageLevel;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class QV_PESAU2317_81_RowDeleting extends BaseEvent implements IGridRowDeleting {
	
	private static ILogger LOGGER = LogFactory.getLogger(QV_PESAU2317_81_RowDeleting.class);
	private CommonServiceEntrywarranty commonServiceEntryWarranty;
	private CommonServiceEntryWarrantyModifyLine commonServiceEntryWarrantyModifyLine;

	public QV_PESAU2317_81_RowDeleting(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		this.commonServiceEntryWarranty = new CommonServiceEntrywarranty(serviceIntegration);
		this.commonServiceEntryWarrantyModifyLine = new CommonServiceEntryWarrantyModifyLine(serviceIntegration);
	}

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs args) {
		try{
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Ingreso gridRowDeleting -> QV_PESAU2317_81_RowDeleting");

			String taskId = args.getParameters().getTaskId();
			if (taskId.equals("T_FLCRE_21_EYWRY63")) {
				this.entrywarranty(row, args);
			} else if (taskId.equals("T_FLCRE_54_EATLI88")) {
				this.entrywarrantymodifyline(row, args);
				this.entrywarranty(row, args);
			} else if(taskId.equals("T_FLCRE_16_NTATT53")){
				this.entrywarranty(row, args);
			}
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("Salida gridRowDeleting -> QV_PESAU2317_81_RowDeleting");
			
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.DELETE_WARRANTY_81, e, args, LOGGER);
		}
		
		
	}

	private void entrywarranty(DataEntity row, IGridRowActionEventArgs args) {
		LOGGER.logInfo("entro al row action");
		DynamicRequest request = args.getDynamicRequest();
		DataEntity originalHeader = request.getEntity(OriginalHeader.ENTITY_NAME);

		CollateralApplicationRequest collateralApplicationRequest = new CollateralApplicationRequest();
		collateralApplicationRequest.setWarranty(row.get(PersonalGuarantor.CODEWARRANTY));
		collateralApplicationRequest.setIdrequested(Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED)));
		// collateralApplicationRequest.setIdrequested(188);
		CollateralApplicationResponse collateralsResponse = this.commonServiceEntryWarranty.remove(collateralApplicationRequest);
		if (collateralsResponse == null) {
			// args.getMessageManager().showMessage(MessageLevel.INFO, 1200,
			// "Elimino Registro");
			args.getMessageManager().showSuccessMsg("DSGNR.SYS_DSGNR_LBLEXECOK_00003");
			args.setSuccess(true);
		}
	}

	private void entrywarrantymodifyline(DataEntity row, IGridRowActionEventArgs args) {
		LOGGER.logInfo("entro al row action");
		DynamicRequest request = args.getDynamicRequest();
		DataEntity originalHeader = request.getEntity(OriginalHeader.ENTITY_NAME);

		CollateralApplicationRequest collateralApplicationRequest = new CollateralApplicationRequest();
		collateralApplicationRequest.setWarranty(row.get(PersonalGuarantor.CODEWARRANTY));
		collateralApplicationRequest.setIdrequested(Integer.parseInt(originalHeader.get(OriginalHeader.IDREQUESTED)));
		// collateralApplicationRequest.setIdrequested(188);
		CollateralApplicationResponse collateralsResponse = this.commonServiceEntryWarrantyModifyLine.remove(collateralApplicationRequest);
		if (collateralsResponse == null) {
			args.getMessageManager().showMessage(MessageLevel.INFO, 1200, "Elimino Registro");
			args.setSuccess(true);
		}
	}

}
