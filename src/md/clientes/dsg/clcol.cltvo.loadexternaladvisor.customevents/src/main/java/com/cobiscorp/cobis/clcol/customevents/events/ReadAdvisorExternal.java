package com.cobiscorp.cobis.clcol.customevents.events;

import java.util.List;

import com.cobiscorp.cobis.clcol.model.CollectiveAdvisor;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.collective.commons.services.AdvisorExternalManager;

import cobiscorp.ecobis.collective.dto.AdvisorExternalRequest;
import cobiscorp.ecobis.collective.dto.AdvisorExternalResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class ReadAdvisorExternal extends BaseEvent implements IExecuteQuery{
	
	private static final ILogger logger = LogFactory.getLogger(ReadAdvisorExternal.class);

	public ReadAdvisorExternal(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest arg0, IExecuteQueryEventArgs arg1) {
		// TODO Auto-generated method stub
		logger.logDebug("executeDataEvent ReadAdvisorExternal");
		DataEntityList listAdvisorExternal = new DataEntityList();
		AdvisorExternalRequest advisorExternalRequest =new AdvisorExternalRequest();
		advisorExternalRequest.setOperation("Q");
		logger.logDebug("arg0.getData().getidSecuencial"+arg0.getData().get("idSecuencial"));
		int idNotif = (arg0.getData().get("idSecuencial") == null ? 0 : Integer.parseInt(arg0.getData().get("idSecuencial").toString()));
		advisorExternalRequest.setIdSecuencial(idNotif);
		logger.logDebug("executeDataEvent operation "+advisorExternalRequest.getOperation());
		logger.logDebug("executeDataEvent idNotif "+advisorExternalRequest.getIdSecuencial());
		try {
			
			AdvisorExternalManager advisorExternalManager = new AdvisorExternalManager(getServiceIntegration());
			AdvisorExternalResponse[] advisorExternalList = advisorExternalManager.searchAdvisorExternal(advisorExternalRequest, arg1);
			if (advisorExternalList != null) {
				logger.logDebug("Entra datos del querry asesores externos");
				
				for (AdvisorExternalResponse externalList : advisorExternalList) {
					DataEntity asesorEntity = new DataEntity();
					asesorEntity.set(CollectiveAdvisor.IDSECUENCIAL, externalList.getIdSecuencial());
					asesorEntity.set(CollectiveAdvisor.COLLECTIVE, externalList.getCollective());
					asesorEntity.set(CollectiveAdvisor.CUSTOMERNAME, externalList.getCustomerName());
					asesorEntity.set(CollectiveAdvisor.CUSTOMERID, String.valueOf(externalList.getCustomerId()));
					asesorEntity.set(CollectiveAdvisor.CUSTOMERADDRESS, externalList.getCustumerAddress());		
					asesorEntity.set(CollectiveAdvisor.CUSTOMERCELL, externalList.getCustomerCell());
					asesorEntity.set(CollectiveAdvisor.CUSTOMERMAIL, externalList.getEmail());
					asesorEntity.set(CollectiveAdvisor.EXTERNALADVISOR, null!=externalList.getAsesorExterno()?externalList.getAsesorExterno():"");
					listAdvisorExternal.add(asesorEntity);
				}
				logger.logDebug("listAdvisorExternal  Size>>" + listAdvisorExternal.size());
			}
			
		}
		catch (Exception e) {
			logger.logDebug("Error ReadAdvisorExternal" ,e);
			}
		
		
		return listAdvisorExternal.getDataList();
	}

}
