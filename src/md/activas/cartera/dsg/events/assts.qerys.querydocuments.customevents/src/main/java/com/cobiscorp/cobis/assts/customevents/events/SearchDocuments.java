package com.cobiscorp.cobis.assts.customevents.events;

import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.QueryDocumentsRequest;
import cobiscorp.ecobis.assets.cloud.dto.QueryDocumentsResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.services.MembersAndDocuments;
import com.cobiscorp.cobis.assts.model.QueryDocumentCredit;
import com.cobiscorp.cobis.assts.model.QueryDocumentsGrid;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;


public class SearchDocuments extends BaseEvent implements IExecuteQuery {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchDocuments.class);
	
	public SearchDocuments(ICTSServiceIntegration serviceIntegration) {
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
			int clientId = (arg0.getData().get("clientId")!=null) ? ((Integer)arg0.getData().get("clientId")):0;
			LOGGER.logDebug("clientId: " + arg0.getData().get("clientId"));
			if(arg0.getData().get("clientId")!=null){
				queryDocumentsRequest.setClientId(clientId);
				LOGGER.logDebug("clientId: "+queryDocumentsRequest.getClientId());
			}
			int groupId = (arg0.getData().get("groupId")!=null) ? ((Integer)arg0.getData().get("groupId")):0;
			if(groupId>0){
				queryDocumentsRequest.setGroupId(groupId);
				LOGGER.logDebug("groupId: "+queryDocumentsRequest.getGroupId());
			}
			queryDocumentsRequest.setOption("B");
			if(arg0.getData().get("loan")!=null){
				queryDocumentsRequest.setBank((String)arg0.getData().get("loan"));//este valor corresponde al prestamo
				LOGGER.logDebug("prestamo: "+queryDocumentsRequest.getBank());
			}
			if(arg0.getData().get("procedure")!=null){
				queryDocumentsRequest.setProcedure((Integer)arg0.getData().get("procedure"));//tramite
				LOGGER.logDebug("tramite: "+queryDocumentsRequest.getProcedure());
			}
			
			LOGGER.logDebug("--------------->>> Inicia busqueda");
			MembersAndDocuments memberManager = new MembersAndDocuments(getServiceIntegration());
			QueryDocumentsResponse[] queryMembersResponses = memberManager.queryMembers(queryDocumentsRequest);
			

			if (queryMembersResponses != null) {
				LOGGER.logDebug("Entra a queryMembersResponses");
				for (QueryDocumentsResponse membersResp : queryMembersResponses) {
					DataEntity members = new DataEntity();
					members.set(QueryDocumentsGrid.CLIENTNAME,membersResp.getName());
					members.set(QueryDocumentsGrid.CLIENTID, membersResp.getClientId());
					members.set(QueryDocumentsGrid.GROUPID, membersResp.getGroupId());
					members.set(QueryDocumentsGrid.LOAN, membersResp.getLoan());
					members.set(QueryDocumentsGrid.PROCEDURE, membersResp.getProcedure());
					members.set(QueryDocumentsGrid.PROCESSINSTANCE, membersResp.getProcessInstance());
					members.set(QueryDocumentsGrid.ISGROUP, membersResp.getIsGroup());

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
