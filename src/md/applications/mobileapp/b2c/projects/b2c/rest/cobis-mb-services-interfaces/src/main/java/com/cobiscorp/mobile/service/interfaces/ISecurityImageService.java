package com.cobiscorp.mobile.service.interfaces;

import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.SecurityImageRequest;
import com.cobiscorp.mobile.model.SecurityImageResponse;

public interface ISecurityImageService {
	SecurityImageResponse getRandomImages(SecurityImageRequest request,String cobisSessionId)throws MobileServiceException;

	SecurityImageResponse insertLoginImage(SecurityImageRequest request,String cobisSessionId)throws MobileServiceException;
	
	SecurityImageResponse getImageLogin(SecurityImageRequest request,String cobisSessionId)throws MobileServiceException;
	
	SecurityImageResponse updateImageLogin(SecurityImageRequest request,String cobisSessionId)throws MobileServiceException;
}
