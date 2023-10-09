package com.cobiscorp.ecobis.customer.web.services.impl;

import java.text.ParseException;

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
import com.cobiscorp.ecobis.customer.services.dtos.PhoneDataRequest;
import com.cobiscorp.ecobis.customer.web.services.PhoneTxService;

@Path("/cobis/web/PhoneTxService")
@Component
@Service({ PhoneTxService.class })
public class PhoneTxServiceImpl extends ServiceBase implements PhoneTxService {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private static ILogger logger = LogFactory.getLogger(PhoneTxServiceImpl.class);

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	@Path("/executeGetPhoneAddress")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@PUT
	@Override
	public ServiceResponse getPhonebyCustomerAndAddress(PhoneDataRequest request) {
		return this.execute(serviceIntegration, logger, "PhoneTxService.getPhonebyCustomerAndAddress", new Object[] { request });
	}

	@Path("/executeGetPhone")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@PUT
	@Override
	public ServiceResponse getPhonebyCustomer(CustomerDataRequest request) throws ParseException {
		return this.execute(serviceIntegration, logger, "PhoneTxService.getPhonebyCustomer", new Object[] { request });
	}

}
