package com.cobiscorp.cobis.latfo.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.latfo.model.VccProperties;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowDeleting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class GridRowDeletingProperties extends BaseEvent implements IGridRowDeleting {

	private static final ILogger logger = LogFactory.getLogger(GridRowDeletingProperties.class);

	public GridRowDeletingProperties(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs arg1) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("Igresa al método rowAction de la clase GridRowDeletingProperties");
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug("1)--------------------->Declaro los servicios");
			}
			ServiceResponse serviceResponse = null;
			if (logger.isDebugEnabled()) {
				logger.logDebug("2)--------------------->Recupero la informacion desde la presentacion");
			}
			Integer idProperties = row.get(VccProperties.PROID);
			if (logger.isDebugEnabled()) {
				logger.logDebug("3)--------------------->Ejecuto el servicio");
			}
			serviceResponse = execute(logger, "clientviewer.Administration.deletePropertiesSection", new Object[] { idProperties });
			if (serviceResponse.isResult()) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("4)--------------------->Elimina el registro");
				}
				arg1.setSuccess(true);
				arg1.getMessageManager().showSuccessMsg("LATFO.DLB_LATFO_ELIAIOSCS_69033");
			} else {
				logger.logError(serviceResponse.getMessages());
				arg1.setSuccess(false);
				arg1.getMessageManager().showErrorMsg("LATFO.DLB_LATFO_EAELMRERO_86463");
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug("Finaliza al método rowAction de la clase GridRowDeletingProperties");
			}
		} catch (Exception e) {
			logger.logError("Error al insertar registros-->" + e.getMessage());
			arg1.getMessageManager().showErrorMsg("LATFO.DLB_LATFO_EAELMRERO_86463");
		}
	}
}
