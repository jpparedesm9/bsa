package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.util.Calendar;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.loan.dto.HolidayRequest;
import cobiscorp.ecobis.loan.dto.HolidayResponse;

import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.model.Holiday;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class HolidaysManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(HolidaysManagement.class);

	public HolidaysManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	public void getHolidays(DynamicRequest entities, ICommonEventArgs arg1) throws Exception {

		try {
			if (logger.isTraceEnabled()) {
				logger.logDebug("Method getHolidays starts in class HolidaysManagement");

			}

			ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
			HolidayRequest holidayRequest = new HolidayRequest();
			holidayRequest.setOffice(null);
			serviceRequestTO.getData().put("inHolidayRequest", holidayRequest);

			ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.SERVICEGETHOLIDAYS, serviceRequestTO);
			if (serviceResponse != null && serviceResponse.isResult()) {
				ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
				logger.logDebug("serviceResponseTO holidays:" + serviceResponseTO);
				HolidayResponse[] holidays = (HolidayResponse[]) serviceResponseTO.getValue(ReturnName.RETURNHOLIDAYS);
				DataEntityList dataEntityList = new DataEntityList();
				for (HolidayResponse holiday : holidays) {
					Calendar calendar = holiday.getHolidayDate();

					if (calendar != null) {
						DataEntity dataEntity = new DataEntity();
						dataEntity.set(Holiday.HOLIDAYDATE, calendar.getTime());
						dataEntityList.add(dataEntity);
					}

				}
				entities.setEntityList(Holiday.ENTITY_NAME, dataEntityList);
				arg1.setSuccess(true);
			} else {
				arg1.setSuccess(true);
			}
		} catch (Exception ex) {
			logger.logError("ERROR:" + ex);
			throw ex;
		} finally {

			if (logger.isTraceEnabled()) {
				logger.logDebug("Method getHolidays finishes in class HolidaysManagement");

			}
		}

	}
}
