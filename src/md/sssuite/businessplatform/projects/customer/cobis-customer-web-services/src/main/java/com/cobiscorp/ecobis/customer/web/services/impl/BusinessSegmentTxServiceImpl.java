package com.cobiscorp.ecobis.customer.web.services.impl;

import javax.ws.rs.Consumes;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.ecobis.customer.services.dtos.BusinessSegmentResponse;
import com.cobiscorp.ecobis.customer.web.services.BusinessSegmentTxService;

@Path("/cobis/web/BusinessSegmentTxService")
@Component
@Service({ BusinessSegmentTxService.class })
public class BusinessSegmentTxServiceImpl extends ServiceBase implements BusinessSegmentTxService {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private static ILogger logger = LogFactory.getLogger(BusinessSegmentTxServiceImpl.class);

	@Path("/executeGetBusinessSegment")
	@PUT
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@Override
	public ServiceResponse getBusinessSegment(BusinessSegmentResponse request) {
		return this.execute(serviceIntegration, logger, "BusinessSegmentTxService.getBusinessSegment", new Object[] { request });
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

}
