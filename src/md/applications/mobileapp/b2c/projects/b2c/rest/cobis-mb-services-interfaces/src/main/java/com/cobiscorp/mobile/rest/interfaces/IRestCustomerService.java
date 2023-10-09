package com.cobiscorp.mobile.rest.interfaces;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;

import com.cobiscorp.mobile.model.Address;
import com.cobiscorp.mobile.model.Customer;

public interface IRestCustomerService {

	public Response updateProspect(@Valid Customer prospectRequest, @Context HttpServletRequest httpRequest);

	public Response createAddress(@Valid Address addressRequest, @Context HttpServletRequest httpRequest);

	public Response updateAddress(@Valid Address addressRequest, @Context HttpServletRequest httpRequest);

	public Response createEmail(@Valid Address addressRequest, @Context HttpServletRequest httpRequest);
}
