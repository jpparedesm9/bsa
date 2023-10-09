package com.cobiscorp.ecobis.busin.web.impl.warranties;

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

import cobiscorp.ecobis.collateral.dto.CollateralTypeRequest;
import cobiscorp.ecobis.collateral.dto.TypeGuaranteeInformation;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.ecobis.busin.web.services.warranties.IWarrantiesManagerService;

@Path("/cobis/web/busin/WarrantiesManager")
@Component
@Service({ WarrantiesManagerImpl.class })
public class WarrantiesManagerImpl extends ServiceBase implements IWarrantiesManagerService {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private static ILogger logger = LogFactory.getLogger(WarrantiesManagerImpl.class);

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	@Override
	@PUT
	@Path("/getAllWarrantiesTypes/{warrantyType}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getAllWarrantiesTypes(@PathParam("warrantyType") String warrantyType) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getAllWarrantiesTypes start");
			}
			CollateralTypeRequest collateralTypeRequest = new CollateralTypeRequest();
			collateralTypeRequest.setMode(0);
			collateralTypeRequest.setOperation("H");
			logger.logDebug("warrantyType ---->"+warrantyType);
			collateralTypeRequest.setType(warrantyType);

			ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
			serviceRequestApplicationTO.addValue(RequestName.INCOLLATERALTYPEREQUEST, collateralTypeRequest);

			return this.execute(serviceIntegration, logger, ServiceId.SERVICEALLWARRANTIESTYPES, serviceRequestApplicationTO);
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getAllWarrantiesTypes end");
			}
		}
	}
	
	@Override
	@PUT
	@Path("/getWarrantyType/{warrantyType}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getWarrantyType(@PathParam("warrantyType") String warrantyType) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getWarrantyType start");
			}
			TypeGuaranteeInformation typeGuaranteeInformation = new TypeGuaranteeInformation();
			typeGuaranteeInformation.setMode(0);				
			if (logger.isDebugEnabled()) {
				logger.logDebug("warrantyType ---->"+warrantyType);
			}
			typeGuaranteeInformation.setTypeOfGuarantee(warrantyType);

			ServiceRequestTO serviceRequestApplicationTO = new ServiceRequestTO();
			serviceRequestApplicationTO.addValue(RequestName.INTYPEGUARANTEEINFORMATION, typeGuaranteeInformation);

			return this.execute(serviceIntegration, logger, ServiceId.SERVICEGETQUERYTYPEGUARANTEEDATA, serviceRequestApplicationTO);
		} catch (Exception ex) {
			return this.manageException(ex, logger);
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug("getWarrantyType end");
			}
		}
	}

}
