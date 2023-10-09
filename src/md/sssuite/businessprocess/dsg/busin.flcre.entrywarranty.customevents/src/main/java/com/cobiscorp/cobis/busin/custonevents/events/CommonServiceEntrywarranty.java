package com.cobiscorp.cobis.busin.custonevents.events;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.CollateralApplicationRequest;
import cobiscorp.ecobis.businessprocess.creditmanagement.dto.CollateralApplicationResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.common.BaseEvent;

/**
 * @author jchacon
 * 
 */
public class CommonServiceEntrywarranty extends BaseEvent {
	private final static ILogger logger = LogFactory.getLogger(CommonServiceEntrywarranty.class);
	private final static String SERVICESDELETECOLLATERAL = "Businessprocess.Creditmanagement.CollateralApplicationManagement.DeleteCollateralApplication";
	private final static String INCOLLATERALAPPLICATIONREQUEST = "inCollateralApplicationRequest";
	private final static String RETURNCOLLATERALAPPLICATIONRESPONSE = "returnCollateralApplicationResponse";

	public CommonServiceEntrywarranty(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public CollateralApplicationResponse remove(CollateralApplicationRequest collateralApplicationRequest) {
		ServiceRequestTO serviceRequestCollateralTO = new ServiceRequestTO();
		ServiceResponseTO serviceResponseCollateralTO = new ServiceResponseTO();
		ServiceResponse serviceResponseCollate = new ServiceResponse();
		serviceRequestCollateralTO.getData().put(INCOLLATERALAPPLICATIONREQUEST, collateralApplicationRequest);

		logger.logInfo("************* LLAMANDO EL SERVICIO DE ELIMINACION ************");

		serviceResponseCollate = execute(getServiceIntegration(), logger, SERVICESDELETECOLLATERAL, serviceRequestCollateralTO);
		if (serviceResponseCollate.isResult()) {
			logger.logInfo("llego al isResult");
			serviceResponseCollateralTO = (ServiceResponseTO) serviceResponseCollate.getData();
			if (serviceResponseCollateralTO.isSuccess()) {
				CollateralApplicationResponse collateralsResponse = (CollateralApplicationResponse) serviceResponseCollateralTO.getValue(RETURNCOLLATERALAPPLICATIONRESPONSE);
				return collateralsResponse;
			}
		}
		return null;
	}
}