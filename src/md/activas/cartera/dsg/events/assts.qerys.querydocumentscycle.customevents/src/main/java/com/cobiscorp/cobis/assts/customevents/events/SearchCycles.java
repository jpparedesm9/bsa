package com.cobiscorp.cobis.assts.customevents.events;

import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.QueryDocumentsRequest;
import cobiscorp.ecobis.assets.cloud.dto.QueryDocumentsResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.services.MembersAndDocuments;
import com.cobiscorp.cobis.assts.model.QueryDocumentsCycle;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;


public class SearchCycles extends BaseEvent implements IExecuteQuery {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchCycles.class);
	
	public SearchCycles(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, IExecuteQueryEventArgs arg1) {
		
		LOGGER.logDebug("Ingreso executeQuery SearchDocument");

		DataEntityList lista = new DataEntityList();
	    QueryDocumentsRequest queryDocumentsRequest = new QueryDocumentsRequest();
		try {
			//Seteo del código del Grupo
			LOGGER.logDebug("data: "+arg0.getData().toString());

			//Seteo de campos
			int groupId = (arg0.getData().get("groupId")!=null) ? ((Integer)arg0.getData().get("groupId")):0;
			if(groupId>0){
				queryDocumentsRequest.setGroupId(groupId);
				LOGGER.logDebug("groupId: "+queryDocumentsRequest.getGroupId());
			}
			queryDocumentsRequest.setOption("C");
			/*if(arg0.getData().get("loan")!=null){
				queryDocumentsRequest.setBank((String)arg0.getData().get("loan"));//prestamo
			}
			if(arg0.getData().get("procedure")!=null){
				queryDocumentsRequest.setProcedure((Integer)arg0.getData().get("procedure"));//tramite
			}
			int clientId = (arg0.getData().get("clientId")!=null) ? ((Integer)arg0.getData().get("clientId")):0;
			if(arg0.getData().get("clientId")!=null){
				queryDocumentsRequest.setClientId(clientId);
			}*/
			
			LOGGER.logDebug("--------------->>> Inicia busqueda");
			MembersAndDocuments memberManager = new MembersAndDocuments(getServiceIntegration());
			QueryDocumentsResponse[] queryMembersResponses = memberManager.queryCycles(queryDocumentsRequest);
			

			if (queryMembersResponses != null) {
				LOGGER.logDebug("Entra a queryMembersResponses");
				for (QueryDocumentsResponse membersResp : queryMembersResponses) {
					DataEntity members = new DataEntity();
					members.set(QueryDocumentsCycle.GROUPID, groupId);
					members.set(QueryDocumentsCycle.LOAN, membersResp.getLoan());
					members.set(QueryDocumentsCycle.PROCEDURE, membersResp.getProcedure());
					members.set(QueryDocumentsCycle.PROCESSINSTANCE, membersResp.getProcessInstance());
					members.set(QueryDocumentsCycle.GROUPCYCLE, membersResp.getGroupCycle());
					members.set(QueryDocumentsCycle.GROUPCYCLEDETAIL, membersResp.getGroupCycleDetail());
					lista.add(members);
				}
			}
		} catch (Exception e) {
			arg1.setSuccess(false);
			LOGGER.logError("Error al buscar los datos de clientes-->", e);
		}
		return lista.getDataList();
		
	}
}
