package com.cobiscorp.mobile.service.interfaces;

import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.KYCFormRequestLocal;
import com.cobiscorp.mobile.request.LifeInsuranceResquest;

import cobiscorp.ecobis.commons.dto.ServiceResponseTO;

public interface ILifeInsurance {

	/**
	 * Realiza la evaluacion del seguro de vida
	 * 
	 * @param request
	 * @return si existe seguro de vida
	 * @throws MobileServiceException cobis-mb-services-integration
	 */

	// metodo que dentro va a estar lo de los sg
	ServiceResponseTO saveLifeInsuranceImp(LifeInsuranceResquest lifeInsuranceRequest, String sessionID) throws MobileServiceException;


}
