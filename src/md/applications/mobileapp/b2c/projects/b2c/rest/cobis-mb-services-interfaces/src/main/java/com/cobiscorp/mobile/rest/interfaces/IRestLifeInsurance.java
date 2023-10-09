package com.cobiscorp.mobile.rest.interfaces;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Response;

import com.cobiscorp.mobile.request.LifeInsuranceResquest;

public interface IRestLifeInsurance {

	// los metodos para la movil cobis-mb-services-integration
	public Response saveLifeInsurance(LifeInsuranceResquest lifeInsuranceResquest, HttpServletRequest httpRequest);

}
