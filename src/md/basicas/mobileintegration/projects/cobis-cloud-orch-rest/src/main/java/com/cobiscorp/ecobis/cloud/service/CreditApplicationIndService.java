package com.cobiscorp.ecobis.cloud.service;

import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CreditApplicationIndRequest;

import javax.ws.rs.core.Response;

public interface CreditApplicationIndService {

    Response createApplication(CreditApplicationIndRequest creditApplicationIndRequest);

    Response updateCreditApplication(int processIntance, CreditApplicationIndRequest creditApplicationIndRequest);
}
