package com.cobiscorp.mobile.service.interfaces;

import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.CustomerResponse;
import com.cobiscorp.mobile.model.OnboardingRequest;
import com.cobiscorp.mobile.response.ValidateParemeterResponse;

public interface IOnboardingService {

	public CustomerResponse onBoardingRegister(OnboardingRequest onboardingRequest) throws MobileServiceException;
	public ValidateParemeterResponse validateResponse() throws MobileServiceException;

}
