package com.cobiscorp.cobis.busin.queryview.events;

import java.util.Map;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.DebtorManagement;
import com.cobiscorp.cobis.busin.model.DebtorGeneral;
import com.cobiscorp.cobis.busin.model.OriginalHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowDeleting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class QV_BOREG0798_55_GridCommandDeleting extends BaseEvent implements IGridRowDeleting {
	
	private static final ILogger LOGGER = LogFactory.getLogger(QV_BOREG0798_55_GridCommandDeleting.class);
	
	public QV_BOREG0798_55_GridCommandDeleting(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void rowAction(DataEntity entity, IGridRowActionEventArgs arg1) {
		// TODO Auto-generated method stub
		try{
			LOGGER.logDebug("Ingreso a QV_BOREG0798_55_GridCommandDeleting");

			// DataEntity original = entity.getEntity(OriginalHeader.ENTITY_NAME);
			LOGGER.logDebug("-*---getData().keySet(): " + arg1.getDynamicRequest().getData().keySet());
			LOGGER.logDebug("-*---getData(): " + arg1.getDynamicRequest().getData());

			Map<String, Object> mapa = (Map<String, Object>) arg1.getDynamicRequest().getData().get(OriginalHeader.ENTITY_NAME);
			DataEntity original = new DataEntity(mapa);// Se asigna de esta manera porque el recuperar la data se recuperaba en null a pesar de que si había información en arg1.getDynamicRequest().getData()

			int idRequest = Integer.parseInt(original.get(OriginalHeader.IDREQUESTED));
			int idDebtor = entity.get(DebtorGeneral.CUSTOMERCODE);
			LOGGER.logDebug("-*---IONicia idRequest: " + idRequest);
			LOGGER.logDebug("-*---IONicia idDebtor: " + idDebtor);

			DebtorManagement debtorManagement = new DebtorManagement(getServiceIntegration());
			if (debtorManagement.deleteDebtors(idRequest, idDebtor, arg1, new BehaviorOption(false, false))) {
				arg1.setSuccess(true);
			} else {
				arg1.setSuccess(false);
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.DELETE_GENERIC_55, e, arg1, LOGGER);
		}

	}
}
