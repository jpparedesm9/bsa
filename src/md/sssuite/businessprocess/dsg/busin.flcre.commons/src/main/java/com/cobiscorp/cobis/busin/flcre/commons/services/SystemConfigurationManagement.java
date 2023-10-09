package com.cobiscorp.cobis.busin.flcre.commons.services;

import java.util.Date;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.DateResponse;
import cobiscorp.ecobis.systemconfiguration.dto.DateRequest;
import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.Convert;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class SystemConfigurationManagement extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(SystemConfigurationManagement.class);

	public SystemConfigurationManagement(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public String getProcessDate(int dateFormat, ICommonEventArgs arg1, BehaviorOption options) {
		DateRequest dateRequestDTO = new DateRequest();
		dateRequestDTO.setDateFormat(dateFormat);
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.getData().put(RequestName.INDATEREQUEST, dateRequestDTO);
		ServiceResponse serviceResponse = execute(getServiceIntegration(), logger, ServiceId.PROCESSDATE, serviceRequestTO);
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceItemsResponseTO = (ServiceResponseTO) serviceResponse.getData();
			return ((DateResponse) serviceItemsResponseTO.getValue(ReturnName.RETURNDATERESPONSE)).getProcessDate();
		} else {
			MessageManagement.show(serviceResponse, arg1, options);
		}
		return null;
	}

	public Date getDate(int dateFormat, ICommonEventArgs arg1, BehaviorOption options) {
		String strDate = getProcessDate(dateFormat, arg1, options);
		logger.logDebug("---> strDate: "+strDate);
		if (strDate != null) {
			return Convert.CString.toDate(strDate);
		}
		return null;
	}
}
