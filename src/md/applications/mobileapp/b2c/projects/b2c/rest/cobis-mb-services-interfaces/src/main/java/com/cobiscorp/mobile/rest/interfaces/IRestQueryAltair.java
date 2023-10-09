package com.cobiscorp.mobile.rest.interfaces;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Response;

import com.cobiscorp.mobile.request.CustomerRequest;

public interface IRestQueryAltair {

	// los metodos para la movil cobis-mb-services-integration
	public Response queryAltair(CustomerRequest altairRequest, HttpServletRequest httpRequest);

}
