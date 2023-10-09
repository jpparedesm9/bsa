package com.cobiscorp.cobis.loans.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.MemberRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.commons.loansgroup.services.MemberManager;
import com.cobiscorp.cobis.loans.model.Member;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowDeleting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class QV_7978_25243_RowDeleting extends BaseEvent implements IGridRowDeleting {
	private static ILogger LOGGER = LogFactory.getLogger(QV_7978_25243_RowDeleting.class);

	public QV_7978_25243_RowDeleting(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void rowAction(DataEntity entity, IGridRowActionEventArgs arg1) {
		if (LOGGER.isDebugEnabled())
			LOGGER.logDebug("QV_7978_25243_RowDeleting -- Empezo");

		try {

			MemberRequest memberRequest = new cobiscorp.ecobis.loangroup.dto.MemberRequest();

			if (entity.get(Member.STATEID) != null) {
				memberRequest.setStateId(entity.get(Member.STATEID));
			}
			LOGGER.logDebug("MEMBER ESTADO:>>" + entity.get(Member.STATEID));
			LOGGER.logDebug("CUSTOMER ID:>>" + entity.get(Member.CUSTOMERID));
			LOGGER.logDebug("GROUPID.CODE:>>" + entity.get(Member.GROUPID));
			LOGGER.logDebug("numero de tramite borrar>>>> " + entity.get(Member.CREDITCODE));
			if (entity.get(Member.CREDITCODE) != null) {
				memberRequest.setApplicationCode(entity.get(Member.CREDITCODE));// mta
			}

			memberRequest.setCustomerId(entity.get(Member.CUSTOMERID));
			memberRequest.setGroupId(entity.get(Member.GROUPID));
			memberRequest.setStateId("C");
			if (LOGGER.isDebugEnabled())
				LOGGER.logDebug("-->QV_7978_25243_RowDeleting getGroupId:" + memberRequest.getGroupId());

			MemberManager memberManager = new MemberManager(getServiceIntegration());

			memberManager.disassociateMember(memberRequest, arg1);
			arg1.setSuccess(true);

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Clients.DESASOCIAR_MIENBROS, e, arg1, LOGGER);
		}
	}

}
