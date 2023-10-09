package com.cobiscorp.cobis.busin.customevents.queryview;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.services.BonusManagement;
import com.cobiscorp.cobis.busin.model.ExecutiveBonusDetails;
import com.cobiscorp.cobis.busin.model.ExecutiveBonusHeader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowUpdating;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class QV_QRYXU8599_55_RowUpdating extends BaseEvent implements IGridRowUpdating {
	private static final ILogger logger = LogFactory.getLogger(QV_QRYXU8599_55_RowUpdating.class);

	public QV_QRYXU8599_55_RowUpdating(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs args) {
		if (logger.isDebugEnabled())
			logger.logDebug("Ingreso -> IGridRowUpdating -> QV_QRYXU8599_55_RowUpdating");
		args.setSuccess(false);

		DataEntity executiveBonusHeader = args.getDynamicRequest().getEntity(ExecutiveBonusHeader.ENTITY_NAME);
		int code = executiveBonusHeader.get(ExecutiveBonusHeader.IDCODE);
		int detailCode = row.get(ExecutiveBonusDetails.IDCODEDETAIL);
		double totalModify = row.get(ExecutiveBonusDetails.TOTALMODIFYEXECUTIVE).doubleValue();
		String observation = row.get(ExecutiveBonusDetails.OBSERVATION);

		BonusManagement bonusMngmnt = new BonusManagement(super.getServiceIntegration());
		if (bonusMngmnt.updateBonus(code, detailCode, totalModify, observation, args, new BehaviorOption(true))) {
			args.getMessageManager().showSuccessMsg("DSGNR.SYS_DSGNR_LBLEXECOK_00003");
		} else {
			args.getMessageManager().showErrorMsg("BUSIN.DLB_BUSIN_RUERAIRNS_65764");
			args.setCancel(true);
			return;
		}

		args.setSuccess(true);
		if (logger.isDebugEnabled())
			logger.logDebug("Salida -> IGridRowUpdating -> QV_QRYXU8599_55_RowUpdating");
	}
}
