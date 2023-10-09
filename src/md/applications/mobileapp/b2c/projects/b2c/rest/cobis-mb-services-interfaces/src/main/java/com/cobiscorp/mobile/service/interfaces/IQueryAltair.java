package com.cobiscorp.mobile.service.interfaces;

import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.request.CustomerRequest;
import com.cobiscorp.mobile.response.AltairResponse;

public interface IQueryAltair {

	/**
	 * Realiza la consulta a Renapo
	 * 
	 * @param curp
	 * @return información del cliente por curp
	 * @throws MobileServiceException cobis-mb-services-integration
	 */

	// metodo que dentro va a estar lo de los sg
	AltairResponse queryAltairImp(CustomerRequest altairRequest, String SessionId) throws MobileServiceException;

}
