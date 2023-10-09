package com.cobiscorp.ecobis.customer.commons.web.services.impl;

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
import com.cobiscorp.ecobis.customer.commons.dto.SearchCustomerDTO;
import com.cobiscorp.ecobis.customer.commons.dto.SearchGroupDTO;
import com.cobiscorp.ecobis.customer.commons.web.services.ICustomerCommonsServices;

@Path("/cobis/web/CustomerCommons")
@Component
@Service({ ICustomerCommonsServices.class })
public class ICustomerCommonsServiceImpl extends ServiceBase implements ICustomerCommonsServices {
	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private static ILogger logger = LogFactory.getLogger(ICustomerCommonsServiceImpl.class);

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	@Override
	@PUT
	@Path("/getCustomerType/{customerCode}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getCustomerType(@PathParam("customerCode") Integer customerCode) throws ParseException {
		// TODO Auto-generated method stub
		return this.execute(serviceIntegration, logger, "CustomerService.getCustomerType", new Object[] { customerCode });
	}

	@Override
	@PUT
	@Path("/getCustomersByParameters")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getCustomersByParameters(SearchCustomerDTO searchCustomer) throws ParseException {
		// TODO Auto-generated method stub
		return this.execute(serviceIntegration, logger, "CustomerService.getCustomersByParameters", new Object[] { searchCustomer });
	}

	@Override
	@PUT
	@Path("/getCustomersByAutoCompleteText")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getCustomersByAutoCompleteText(SearchCustomerDTO searchCustomer) throws ParseException {
		// TODO Auto-generated method stub
		return this.execute(serviceIntegration, logger, "CustomerService.getCustomersByAutoCompleteText", new Object[] { searchCustomer });
	}

	@Override
	@PUT
	@Path("/getGroup")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getGroup(SearchGroupDTO searchGroup) throws ParseException {
		// TODO Auto-generated method stub
		logger.logInfo("*****************************METODO QUERY GROUP");
		return this.execute(serviceIntegration, logger, "CustomerService.queryGroup", new Object[] { searchGroup });
	}

	@Override
	@PUT
	@Path("/getGroupsByParameters")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getGroupsByParameters(SearchGroupDTO searchGroup) throws ParseException {
		// TODO Auto-generated method stub
		logger.logInfo("*****************************METODO QUERY GROUP BY PARAMETERS");
		return this.execute(serviceIntegration, logger, "CustomerService.getGroupsByParameters", new Object[] { searchGroup });
	}

	@Override
	@PUT
	@Path("/getCustomer/{customerCode}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getCustomer(@PathParam("customerCode") Integer customerCode) throws ParseException {
		// TODO Auto-generated method stub
		return this.execute(serviceIntegration, logger, "CustomerService.queryClient", new Object[] { customerCode });
	}

	@Override
	@PUT
	@Path("/getGroupMembers/{groupCode}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getGroupMembers(@PathParam("groupCode") Integer groupCode) throws ParseException {
		// TODO Auto-generated method stub
		return this.execute(serviceIntegration, logger, "CustomerService.getGroupMembers", new Object[] { groupCode });
	}

	@Override
	@PUT
	@Path("/getLegalCustomer/{customerCode}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getLegalCustomer(@PathParam("customerCode") Integer customerCode) throws ParseException {
		// TODO Auto-generated method stub
		return this.execute(serviceIntegration, logger, "CustomerService.getQueryLegalClient", new Object[] { customerCode });
	}

	@Override
	@PUT
	@Path("/getCustomerAddresses/{customerCode}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getCustomerAddresses(@PathParam("customerCode") Integer customerCode) throws ParseException {
		// TODO Auto-generated method stub
		return this.execute(serviceIntegration, logger, "CustomerService.getQueryClientAddress", new Object[] { customerCode });
	}

	@Override
	@PUT
	@Path("/getCustomerRate/{customerCode}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getCustomerRate(@PathParam("customerCode") Integer customerCode) throws ParseException {
		// TODO Auto-generated method stub
		return this.execute(serviceIntegration, logger, "CustomerService.queryClientRate", new Object[] { customerCode });
	}

	@Override
	@PUT
	@Path("/getGroupDetail/{groupCode}/{type}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse getGroupDetail(@PathParam("groupCode") Integer groupCode, @PathParam("type") String type) throws ParseException {
		// TODO Auto-generated method stub
		return this.execute(serviceIntegration, logger, "CustomerService.getGroupDetail", new Object[] { groupCode, type });
	}

	@Override
	@PUT
	@Path("/checkColumnExist/{database}/{table}/{column}")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public ServiceResponse checkColumnExist(@PathParam("database") String database, @PathParam("table") String table, @PathParam("column") String column) throws ParseException {
		// TODO Auto-generated method stub
		return this.execute(serviceIntegration, logger, "CustomerService.checkColumnExist", new Object[] { database, table, column });
	}

}
