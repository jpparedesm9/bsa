package com.cobiscorp.cobis.assts.customevents.events;

import java.util.Date;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.ProjectionQuota;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.api.util.ServerParamUtil;

public class ProjectionDateChangeEvents implements IChangedEvent {

	private static final ILogger logger = LogFactory
			.getLogger(ProjectionQuotaCommandEvents.class);
	



	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {
		DataEntity projection = entities.getEntity(ProjectionQuota.ENTITY_NAME);
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);

		if (logger.isDebugEnabled()) {
			logger.logDebug("projection>>>>" + projection.getData());
			logger.logDebug("loan>>>>" + loan.getData());

		}

		applyProjecctionDays(projection, args);
	}

	private void applyProjecctionDays(DataEntity projection,
			IChangedEventArgs args) {
		try {

			Date parseProcessDate = new Date();
			parseProcessDate = GeneralFunction.convertStringToDate(
					ServerParamUtil.getProcessDate(),
					Parameter.TYPEDATEFORMAT.MMDDYYYY);
			if (parseProcessDate!= null){
			projection.set(ProjectionQuota.DATEPROCESS, parseProcessDate);
			}

			if (projection.get(ProjectionQuota.PROJECTIONDAYS) <= Parameter.DAYS) {

				projection
						.set(ProjectionQuota.PROJECTIONDATE,
								GeneralFunction.getDate(
										projection
												.get(ProjectionQuota.DATEPROCESS),
										projection
												.get(ProjectionQuota.PROJECTIONDAYS)));
			} else {
				args.getMessageManager().showErrorMsg(
						"El número de días no puede ser mayor a " + Parameter.DAYS);				
				projection.set(ProjectionQuota.PROJECTIONDATE, null);
				projection.set(ProjectionQuota.PROJECTIONDAYS, null);

			}
		} catch (Exception ex) {

			logger.logError("ERROR: " + ex);
		}
	}
}