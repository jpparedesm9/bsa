package com.cobiscorp.cobis.cstmr.customevents.events;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AlertRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.RiskResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.GeneralFunction;
import com.cobiscorp.cobis.cstmr.model.WarningRisk;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.AlertManager;

public class SearchRisk extends BaseEvent implements IExecuteQuery {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchRisk.class);

	public SearchRisk(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, IExecuteQueryEventArgs args) {
		// TODO Auto-generated method stub
		LOGGER.logDebug("Inicia evento executeDataEvent ");
		DataEntityList alertsList = new DataEntityList();
		AlertRequest request = new AlertRequest();
		AlertManager businessManager = new AlertManager(getServiceIntegration());
		LOGGER.logDebug("data0: "+entities.getData().toString());
		LOGGER.logDebug("data1: "+entities.getData().toString());
		String typeList=(String) entities.getData().get("listType");
		Date fecha_Inicio=(Date) entities.getData().get("alertDate");
		Date fecha_Fin=(Date) entities.getData().get("consultDate");
		
		LOGGER.logDebug("entities.getData().get1: "+entities.getData().get("listType"));
		LOGGER.logDebug("entities.getData().get2: "+entities.getData().get("alertDate"));
		LOGGER.logDebug("entities.getData().get3: "+entities.getData().get("consultDate"));
		
		LOGGER.logDebug("typeList: "+typeList);
		LOGGER.logDebug("fecha_Inicio: "+fecha_Inicio);
		LOGGER.logDebug("fecha_Fin: "+fecha_Fin);
		
		request.setTypeOperation(typeList);
		
		if(entities.getData().get("alertDate")!=null)
		{
		request.setStartDate(GeneralFunction.convertDateToCalendar(fecha_Inicio));
		LOGGER.logDebug("request set operation"+request.getStartDate());
		}
		if(entities.getData().get("consultDate")!=null)
		{
		request.setFinishDate(GeneralFunction.convertDateToCalendar(fecha_Fin));
		LOGGER.logDebug("request set operation"+request.getFinishDate());
		}
		
		
		
		if(request.getStartDate()!=null && request.getFinishDate()!=null && request.getTypeOperation()==null)
		{
			request.setModo(0);
		}
		
		if(request.getStartDate()==null && request.getFinishDate()==null && request.getTypeOperation()!=null )
		{
			request.setModo(1);
		}
		
		try {
			LOGGER.logDebug("data: "+entities.getData().toString());

			RiskResponse[] riskResponse = businessManager.searchRisk(request, args);

			LOGGER.logDebug("riskResponse ---" + riskResponse);
			for (RiskResponse resp : riskResponse) {
				DataEntity alertEntity = new DataEntity();
				// alertEntity.set(WarningRisk.CODE, resp.getCode());
				LOGGER.logDebug("businessList PoupForm Code>>" + resp.getAlertCode());
				Date dateTmp = null;
				SimpleDateFormat formatDate = new SimpleDateFormat("dd/MM/yyyy");

				alertEntity.set(WarningRisk.ALERTCODE, resp.getAlertCode());
				alertEntity.set(WarningRisk.OFFICE, resp.getOffice());
				alertEntity.set(WarningRisk.GROUP, resp.getGroup());
				alertEntity.set(WarningRisk.CUSTOMERCODE, resp.getCustomerCode());
				alertEntity.set(WarningRisk.CUSTOMERNAME, resp.getCustomerName());
				alertEntity.set(WarningRisk.CONTRACT, resp.getContract());
				alertEntity.set(WarningRisk.PRODUCTTYPE, resp.getProductType());
				alertEntity.set(WarningRisk.LISTTYPE, resp.getListType());
				
				if (resp.getConsultDate() != null) {
					dateTmp = formatDate.parse(resp.getConsultDate());
				}
				
				alertEntity.set(WarningRisk.CONSULTDATE, dateTmp);
				
				if (resp.getAlertDate() != null) {
					dateTmp = formatDate.parse(resp.getAlertDate());
				}
				alertEntity.set(WarningRisk.ALERTDATE, dateTmp);

				dateTmp = null;
				if (resp.getOperationDate() != null) {
					dateTmp = formatDate.parse(resp.getOperationDate());
				}
				alertEntity.set(WarningRisk.OPERATIONDATE, dateTmp);
				
				dateTmp = null;
				if (resp.getDictatesDate() != null) {
					dateTmp = formatDate.parse(resp.getDictatesDate());
				}
				alertEntity.set(WarningRisk.DICTATESDATE, dateTmp);
				
				dateTmp = null;
				if (resp.getReportDate() != null) {
					dateTmp = formatDate.parse(resp.getReportDate());
				}
				alertEntity.set(WarningRisk.REPORTDATE, dateTmp);
				alertEntity.set(WarningRisk.OBSERVATIONS, resp.getObservations());
				alertEntity.set(WarningRisk.RISKLEVEL, resp.getRiskLevel());
				alertEntity.set(WarningRisk.ETIQUET, resp.getEtiquet());
				alertEntity.set(WarningRisk.STAGE, resp.getStage());
				alertEntity.set(WarningRisk.ALERTTYPE, resp.getAlertType());
				alertEntity.set(WarningRisk.OPERATIONTYPE, resp.getOperationType());
				alertEntity.set(WarningRisk.AMOUNT, resp.getAmount());
				alertEntity.set(WarningRisk.STATUSALERT, resp.getStatusAlert());
				alertEntity.set(WarningRisk.GENERATEREPORTS, resp.getGenerateReports());
				alertEntity.set(WarningRisk.GROUPNAME, resp.getGroupName());
				alertEntity.set(WarningRisk.CUSTOMERRFC, resp.getCustomerRFC());
				
				

				alertsList.add(alertEntity);
			}
			LOGGER.logDebug("alertsList PoupForm Size11>>" + alertsList.size());

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.SEARCH_RISK, e, args, LOGGER);
		}

		return alertsList.getDataList();
	}

}
