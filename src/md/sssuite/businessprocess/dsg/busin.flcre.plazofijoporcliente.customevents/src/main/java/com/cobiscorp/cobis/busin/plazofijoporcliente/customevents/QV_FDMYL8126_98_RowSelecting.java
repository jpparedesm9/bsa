package com.cobiscorp.cobis.busin.plazofijoporcliente.customevents;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowSelecting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class QV_FDMYL8126_98_RowSelecting extends BaseEvent implements IGridRowSelecting {

	private static ILogger logger = LogFactory.getLogger(QV_FDMYL8126_98_RowSelecting.class);
	
	public QV_FDMYL8126_98_RowSelecting(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs args) {
		if (logger.isDebugEnabled()){
			logger.logDebug(":>:>Ingreso gridrowselecting -> QV_FDMYL8126_98_RowSelecting");
		}
		this.queryTermDetail(row, args);		
		if (logger.isDebugEnabled()){
			logger.logDebug(":>:>Salida gridrowselecting -> QV_FDMYL8126_98_RowSelecting");
		}
	}

	private void queryTermDetail(DataEntity row, IGridRowActionEventArgs args) {
		if (logger.isDebugEnabled()){
			logger.logDebug(":>QV_FDMYL8126_98_RowSelecting:>metodo queryTermDetail:>:>");
		}	
		
		if (logger.isDebugEnabled()){
			logger.logDebug(":>QV_FDMYL8126_98_RowSelecting:>fin metodo queryTermDetail:> row seteada:>"+row.getData());
		}
	}
}