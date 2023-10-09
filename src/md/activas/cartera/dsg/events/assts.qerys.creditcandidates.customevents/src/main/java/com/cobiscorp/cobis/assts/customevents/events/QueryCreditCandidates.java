package com.cobiscorp.cobis.assts.customevents.events;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.CreditCandidatesRequest;
import cobiscorp.ecobis.assets.cloud.dto.CreditCandidatesResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.services.CreditCandidatesManagement;
import com.cobiscorp.cobis.assts.model.CreditCandidates;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class QueryCreditCandidates extends BaseEvent implements IExecuteQuery {

	private static final ILogger LOGGER = LogFactory.getLogger(QueryCreditCandidates.class);

	public QueryCreditCandidates(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public List<?> executeDataEvent(DynamicRequest entitie, IExecuteQueryEventArgs arg1) {
		LOGGER.logDebug("Start queryCandidates in QueryCreditCandidates");

		DataEntityList lista = new DataEntityList();
		CreditCandidatesRequest request = new CreditCandidatesRequest();
		try {
			LOGGER.logDebug("---->>> Inicia busqueda de Candidatos LCR");
			CreditCandidatesManagement candidatesManagement = new CreditCandidatesManagement(getServiceIntegration());
			CreditCandidatesResponse[] candidatesResponse = candidatesManagement.queryCandidates(request, arg1);

			if (candidatesResponse != null) {
				LOGGER.logDebug("Entra a scannedDocumentsResponses");
				for (CreditCandidatesResponse resp : candidatesResponse) {
					DataEntity candidatesEntity = new DataEntity();
					Date dateTmp = null;
					SimpleDateFormat formatDate = new SimpleDateFormat("dd/MM/yyyy");
					String descripcion = resp.getDescription();
					int numCortar = 30;
					
					if(descripcion == null){
						descripcion = "";
					}
					
					candidatesEntity.set(CreditCandidates.PERIODICITY, resp.getPeriodicity());

					if (resp.getDateInsertion() != null) {
						dateTmp = formatDate.parse(resp.getDateInsertion());
					}
					candidatesEntity.set(CreditCandidates.DATEINSERTION, dateTmp);
					dateTmp = null;
					if (resp.getDateDispersion() != null) {
						dateTmp = formatDate.parse(resp.getDateDispersion());
					}
					candidatesEntity.set(CreditCandidates.DATEDISPERSION, dateTmp);

					candidatesEntity.set(CreditCandidates.GROUPID, resp.getGroupId());
					candidatesEntity.set(CreditCandidates.GROUPNAME, resp.getGroupName());
					candidatesEntity.set(CreditCandidates.OFFICEID, resp.getOfficeId());
					candidatesEntity.set(CreditCandidates.OFFICENAME, resp.getOfficeName());
					candidatesEntity.set(CreditCandidates.CLIENTID, resp.getClientId());
					candidatesEntity.set(CreditCandidates.CLIENTNAME, resp.getClientName());
					candidatesEntity.set(CreditCandidates.OFFICERASSIGNEDID, resp.getOfficerAssignedId());
					candidatesEntity.set(CreditCandidates.OFFICERASSIGNED, resp.getOfficerAssigned());
					candidatesEntity.set(CreditCandidates.OFFICERREASSIGNEDID, resp.getOfficerReassignedId());
					candidatesEntity.set(CreditCandidates.OFFICERREASSIGNED, resp.getOfficerReassigned());
					candidatesEntity.set(CreditCandidates.DESCRIPTION, descripcion);
					if(descripcion != null){
						if(descripcion.length() < 30){
							numCortar = descripcion.length();
						}
						candidatesEntity.set(CreditCandidates.AUXTEXT, descripcion.substring(0,numCortar));
					}

					lista.add(candidatesEntity);
				}
			}
		} catch (Exception e) {
			ExceptionUtils.showError("Error al consultar candidatos a credito", e, arg1, LOGGER);
		}
		return lista.getDataList();

	}

}
