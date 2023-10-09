package com.cobiscorp.ecobis.cloud.service;

import com.cobiscorp.ecobis.cloud.service.dto.verification.VerificationData;

import javax.ws.rs.core.Response;


public interface VerificationService {

    Response updateDataVerification(int processInstance, VerificationData verificationData);

    Response completeGroupVerification(int processInstance);
}
