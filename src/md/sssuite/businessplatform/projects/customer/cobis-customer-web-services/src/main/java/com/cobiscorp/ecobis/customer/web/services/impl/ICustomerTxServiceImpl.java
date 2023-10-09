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
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.IdSearchRequest;
import com.cobiscorp.ecobis.customer.web.services.ICustomerTxService;

@Path("/cobis/web/CustomerTxService")
@Component
@Service({ ICustomerTxService.class })
public class ICustomerTxServiceImpl extends ServiceBase implements ICustomerTxService {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private static ILogger logger = LogFactory.getLogger(ICustomerTxServiceImpl.class);

	@Path("/getCustomerDetails")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@PUT
	@Override
	public ServiceResponse getCustomerDetails(CustomerDataRequest request) {
		return this.execute(serviceIntegration, logger, "CustomerTxService.getCustomerDetails", new Object[] { request });
	}

	@Path("/getCustomerAllData")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@PUT
	@Override
	public ServiceResponse getCustomerAllData(CustomerDataRequest request) {
		return this.execute(serviceIntegration, logger, "CustomerTxService.getCustomerAllData", new Object[] { request });
	}

	@Path("/searchById")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@PUT
	@Override
	public ServiceResponse searchById(IdSearchRequest request) {
		return this.execute(serviceIntegration, logger, "CustomerTxService.searchById", new Object[] { request });
	}

	@Path("/createCustomer")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@PUT
	@Override
	public ServiceResponse createCustomer(CustomerDataResponse request) throws ParseException {

		return this.execute(serviceIntegration, logger, "CustomerTxService.createCustomer", new Object[] { request });
	}

	@Path("/getCustomerNameById")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	@PUT
	@Override
	public ServiceResponse getCustomerNameById(CustomerDataRequest request) {
		return this.execute(serviceIntegration, logger, "CustomerTxService.getCustomerNameById", new Object[] { request });
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

}
