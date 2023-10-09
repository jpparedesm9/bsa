package com.cobiscorp.ecobis.customer.impl;

import java.text.ParseException;

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

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.ecobis.customer.ICustomerService;

@Path("/cobis/web/clientviewer/CustomerService")
@Component
@Service({ ICustomerService.class })
public class CustomerService extends ServiceBase implements ICustomerService {

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private ILogger logger = LogFactory.getLogger(CustomerService.class);

	@Override
	@PUT
	@Path("/getCustomer/{customerCode}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getCustomer(@PathParam("customerCode") Integer customerCode) throws ParseException {
		return this.execute(serviceIntegration, logger, "clientviewer.CustomerService.queryClient", new Object[] { customerCode });
	}

	@Override
	@PUT
	@Path("/getGroupDetail/{groupCode}/{type}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getGroupDetail(@PathParam("groupCode") Integer groupCode, @PathParam("type") String type) throws ParseException {
		return this.execute(serviceIntegration, logger, "clientviewer.CustomerService.queryGroupDetail", new Object[] { groupCode, type });
	}

	/**
	 * Method that set the instance of ICTSServiceIntegration
	 * 
	 * @param serviceIntegration
	 *            Instance of ICTSServiceIntegration
	 */
	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	/**
	 * Method that unset the instance of ICTSServiceIntegration
	 * 
	 * @param serviceIntegration
	 *            Instance of ICTSServiceIntegration
	 */
	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

}
