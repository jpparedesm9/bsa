package com.cobiscorp.cobis.loans.customevents.events;

import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loangroup.dto.MemberRequest;
import cobiscorp.ecobis.loangroup.dto.MemberResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.commons.loansgroup.services.MemberManager;
import com.cobiscorp.cobis.loans.model.Credit;
import com.cobiscorp.cobis.loans.model.ScannedDocuments;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class SearchListMembers extends BaseEvent implements IExecuteQuery {

	private static final ILogger LOGGER = LogFactory
			.getLogger(SearchListMembers.class);

	public SearchListMembers(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0,
			IExecuteQueryEventArgs arg1) {

		LOGGER.logDebug("Ingreso executeQuery SearchGroup");
		LOGGER.logDebug("entra");
		DataEntityList lista = new DataEntityList();
		DataEntity miembros = new DataEntity();
		MemberRequest memberRequest = new MemberRequest();
		
		
		
		
		
		try {
			// Seteo del código del Grupo
			LOGGER.logDebug("Ingreso: groupId: " + arg0.getData().get("groupId"));
			LOGGER.logDebug("Ingreso: getApplicationCode: " + arg0.getData().get("applicationNumber"));
			int groupId = Integer.valueOf((String) arg0.getData()
					.get("groupId"));
			int applicationCode = (Integer) arg0.getData().get("applicationNumber");			
			memberRequest.setGroupId(groupId);
			memberRequest.setMode(5);
			
			memberRequest.setApplicationCode(applicationCode);
			LOGGER.logDebug("groupId: " + memberRequest.getGroupId());
			LOGGER.logDebug("getMode: " + memberRequest.getMode());
			LOGGER.logDebug("getApplicationCode: " + memberRequest.getApplicationCode());

			LOGGER.logDebug("--------------->>> Inicia busqueda de Miembros");
			MemberManager memberManager = new MemberManager(
					getServiceIntegration());
			MemberResponse[] memberResponses = memberManager.searchMember(
					memberRequest, arg1);

			if (memberResponses != null) {
				LOGGER.logDebug("Entra a memberResponse");
				String integrantes;
				for (MemberResponse member : memberResponses) {
					miembros = new DataEntity();
					integrantes = member.getCustomerId() + "-"
							+ member.getCustomer();
					miembros.set(ScannedDocuments.MEMBERS, integrantes);
					lista.add(miembros);
				}
			}
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Clients.SEARCH_GROUP, e,
					arg1, LOGGER);
		}
		return lista.getDataList();

	}
}
