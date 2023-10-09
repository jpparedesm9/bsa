package com.cobiscorp.ecobis.busin.web.impl.economicActivity;

import javax.ws.rs.Consumes;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.businessprocess.creditmanagement.dto.EconomicActivityDataRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.ecobis.busin.web.services.economicActivity.IEconomicActivityManagerService;

@Path("/cobis/web/busin/EconomicActivityManager")
@Component
@Service({ EconomicActivityManagerImpl.class })
public class EconomicActivityManagerImpl extends ServiceBase implements IEconomicActivityManagerService {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private static ILogger logger = LogFactory.getLogger(EconomicActivityManagerImpl.class);

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	@Override
	@PUT
	@Path("/getAllEconomicActivityTypes/{economicActivityCode}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getAllEconomicActivityTypes(@PathParam("economicActivityCode") String economicActivityCode) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getAllEconomicActivityTypes start");
			}
			logger.logDebug("economicActivityCode ---> " + economicActivityCode);
			EconomicActivityDataRequest economicActivityRequest = new EconomicActivityDataRequest();
			economicActivityRequest.setCodigo(economicActivityCode);
			economicActivityRequest.setDestinoBce("TF");
			economicActivityRequest.setModo(0);
			economicActivityRequest.setOperacion('B');
			economicActivityRequest.setSegmento("4");

			ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
			serviceRequestApplicationTO.addValue(RequestName.INECONOMICACTIVITYDATA, economicActivityRequest);

			return this.execute(serviceIntegration, logger, ServiceId.SERVICEECONOMICACTIVITY, serviceRequestApplicationTO);
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getAllEconomicActivityTypes end");
			}
		}
	}
	
}
