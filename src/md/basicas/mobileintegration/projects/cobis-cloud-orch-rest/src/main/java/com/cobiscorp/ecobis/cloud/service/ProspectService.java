package com.cobiscorp.ecobis.cloud.service;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;

import com.cobiscorp.ecobis.cloud.service.dto.prospect.ProspectClient;
import com.cobiscorp.ecobis.cloud.service.dto.prospect.ProspectDataRequest;

/**
 *
 * @author Cesar Loachamin
 */
public interface ProspectService {

	Response readProspect(int customerId);

	Response createProspect(ProspectDataRequest data);

	Response updateProspect(ProspectDataRequest data);

	Response prospectCreation(ProspectClient prospectCreateRequest, @Context HttpServletRequest httpRequest);

}
