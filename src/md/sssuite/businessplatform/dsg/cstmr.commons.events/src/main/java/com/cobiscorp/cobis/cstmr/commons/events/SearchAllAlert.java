package com.cobiscorp.cobis.cstmr.commons.events;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AlertRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.AlertResponse;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.UnusualOperationsView;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.prospect.services.AlertManager;

public class SearchAllAlert extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchAllAlert.class);

	public SearchAllAlert(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	public void searchAlerts(DynamicRequest entities, ICommonEventArgs args) throws ParseException {

		LOGGER.logDebug("Start searchAlerts in SearchAllAlert");
		//DataEntity customerTmp = entities.getEntity(UnusualOperationsView.ENTITY_NAME);

		AlertRequest request = new AlertRequest();
		AlertManager businessManager = new AlertManager(getServiceIntegration());
		AlertResponse[] alertResponse = businessManager.searchAlert(request, args);

		DataEntityList alertsList = new DataEntityList();

		LOGGER.logDebug("addresses ---" + alertResponse);
		for (AlertResponse resp : alertResponse) {
			DataEntity alertEntity = new DataEntity();
			// alertEntity.set(UnusualOperationsView.CODE, resp.getCode());
			LOGGER.logDebug("businessList PoupForm Code>>" + resp.getCode());
			Date dateTmp = null;
			SimpleDateFormat formatDate = new SimpleDateFormat("dd/MM/yyyy");

			alertEntity.set(UnusualOperationsView.TYPEOPERATION, resp.getTypeOperation());

			if (resp.getHighDate() != null) {
				dateTmp = formatDate.parse(resp.getHighDate());
			}

			alertEntity.set(UnusualOperationsView.HIGHDATE, dateTmp);

			dateTmp = null;
			if (resp.getReportDate() != null) {
				dateTmp = formatDate.parse(resp.getReportDate());
			}
			alertEntity.set(UnusualOperationsView.REPORTDATE, dateTmp);
			alertEntity.set(UnusualOperationsView.CUSTOMERNAME, resp.getCustomerName());
			alertEntity.set(UnusualOperationsView.COMMENTARY, resp.getCommentary());

			alertsList.add(alertEntity);
		}
		LOGGER.logDebug("alertsList PoupForm Size>>" + alertsList.size());

		entities.setEntityList(UnusualOperationsView.ENTITY_NAME, alertsList);
	}

}
