package com.cobiscorp.mobile.service.interfaces;

import java.util.ArrayList;

import cobiscorp.ecobis.parameter.dto.ParameterSearchResponse;

import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.ConfigParameter;

public interface IParameterService {

	/**
	 * Obtains general parameters for the b2c
	 * 
	 * @param cobisSessionId
	 * @return ArrayList<ConfigParameter>
	 * @throws MobileServiceException
	 */
	ArrayList<ConfigParameter> getParameters(String cobisSessionId) throws MobileServiceException;

	/**
	 * Obtains any parameter.
	 * 
	 * @param nemonic
	 * @param product
	 * @param cobisSessionId
	 * @return ParameterSearchResponse
	 * @throws MobileServiceException
	 */
	ParameterSearchResponse searchParameter(String nemonic, String product, String cobisSessionId) throws MobileServiceException;
}