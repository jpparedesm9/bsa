package com.cobiscorp.cobis.cstmr.customevents.events;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AlertRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.AlertResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.UnusualOperationsView;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.AlertManager;

public class SearchAlert extends BaseEvent implements IExecuteQuery {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchAlert.class);

	public SearchAlert(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public List<?> executeDataEvent(DynamicRequest entities, IExecuteQueryEventArgs args) {
		// TODO Auto-generated method stub

		DataEntityList alertsList = new DataEntityList();
		AlertRequest request = new AlertRequest();
		AlertManager businessManager = new AlertManager(getServiceIntegration());

		try {

			AlertResponse[] alertResponse = businessManager.searchAlert(request, args);

			LOGGER.logDebug("alertResponse ---" + alertResponse);
			for (AlertResponse resp : alertResponse) {
				DataEntity alertEntity = new DataEntity();
				// alertEntity.set(UnusualOperationsView.CODE, resp.getCode());
				LOGGER.logDebug("businessList PoupForm Code>>" + resp.getCode());
				Date dateTmp = null;
				SimpleDateFormat formatDate = new SimpleDateFormat("dd/MM/yyyy");

				alertEntity.set(UnusualOperationsView.CODE, resp.getCode());
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

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.SEARCH_ALERT, e, args, LOGGER);
		}

		// entities.setEntityList(UnusualOperationsView.ENTITY_NAME, alertsList);

		return alertsList.getDataList();
	}

}
