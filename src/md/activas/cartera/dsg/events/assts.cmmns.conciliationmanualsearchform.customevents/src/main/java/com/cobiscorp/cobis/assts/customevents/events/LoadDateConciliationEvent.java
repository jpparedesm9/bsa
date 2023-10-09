package com.cobiscorp.cobis.assts.customevents.events;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assts.model.ConciliationManualSearchFilter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.api.util.ServerParamUtil;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.assets.cloud.dto.ConciliationManualRequest;
import cobiscorp.ecobis.assets.cloud.dto.ConciliationManualResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class LoadDateConciliationEvent extends BaseEvent implements IInitDataEvent {

	private static final ILogger logger = LogFactory.getLogger(LoadDateConciliationEvent.class);

	private static final String MINOR_DATE_CONCILIATE = "S";

	private static final String DATE_FORMAT = "MM/dd/yyyy";

	public LoadDateConciliationEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingreso LoadDateConciliationEvent - executeDataEvent");
		}

		String dateProcess = ServerParamUtil.getProcessDate();
		
		try {
			ServiceRequestTO request = new ServiceRequestTO();

			DataEntity conciliationSearchFilter = entities.getEntity(ConciliationManualSearchFilter.ENTITY_NAME);

			ConciliationManualRequest conciliationManualRequest = new ConciliationManualRequest();
			conciliationManualRequest.setOperation(MINOR_DATE_CONCILIATE);

			request.addValue("inConciliationManualRequest", conciliationManualRequest);
			ServiceResponse response = this.execute(getServiceIntegration(), logger, "Loan.ConciliationManagement.SearchMinorDateNotConciled", request);

			Date date = null;
			
			date = new SimpleDateFormat(DATE_FORMAT).parse(dateProcess);

			if (response != null && response.isResult()) {
				ServiceResponseTO resultado = (ServiceResponseTO) response.getData();

				ConciliationManualResponse[] cmResponse = (ConciliationManualResponse[]) resultado.getValue("returnConciliationManualResponse");

				conciliationSearchFilter.set(ConciliationManualSearchFilter.DATEFROM, GeneralFunction.convertCalendarToDate(cmResponse[0].getRecordsDate()));
				conciliationSearchFilter.set(ConciliationManualSearchFilter.DATEUNTIL, date);
				
				entities.setEntity(ConciliationManualSearchFilter.ENTITY_NAME, conciliationSearchFilter);
			}
		} catch (ParseException errorDate) {
			logger.logError("ERROR: AL INTENTAR PARSEAR ESTA FECHA " + dateProcess + " : " + errorDate);
		} catch (Exception error) {
			logger.logError("ERROR: AL OBTENER LAS FECHAS ", error);
		}
	}
}
