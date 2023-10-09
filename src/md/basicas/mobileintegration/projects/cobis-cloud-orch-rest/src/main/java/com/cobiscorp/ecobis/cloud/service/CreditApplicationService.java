package com.cobiscorp.ecobis.cloud.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;

import com.cobiscorp.ecobis.cloud.service.dto.creditapplication.CreditApplicationRequest;
import com.cobiscorp.ecobis.cloud.service.dto.group.GroupValidation;

/**
 * Created by ntrujillo on 14/07/2017.
 */
public interface CreditApplicationService {

	Response updateCreditApplication(int processIntance, CreditApplicationRequest creditApplicationRequest, @Context HttpServletRequest httpRequest);

	Response validateGroups(List<GroupValidation> groups);

	Response readCreditApplication(int applicationId);

	Response createCreditApplicationIncomplete(CreditApplicationRequest creditApplicationRequest);

	Response updatePromotion(CreditApplicationRequest creditApplicationRequest);

}
