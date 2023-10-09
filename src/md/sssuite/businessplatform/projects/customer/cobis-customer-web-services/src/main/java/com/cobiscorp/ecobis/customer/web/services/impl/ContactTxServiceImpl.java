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
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.web.services.ContactTxService;

@Path("/cobis/web/ContactTxService")
@Component
@Service({ ContactTxService.class })
public class ContactTxServiceImpl extends ServiceBase implements ContactTxService {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private static ILogger logger = LogFactory.getLogger(ContactTxServiceImpl.class);

	@Path("/executeGetContact")
	@PUT
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@Override
	public ServiceResponse getContactsbyCustomer(CustomerDataRequest request) {
		return this.execute(serviceIntegration, logger, "ContactTxService.getContactsbyCustomer", new Object[] { request });
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

}
