package com.cobiscorp.ecobis.cobiscloudsecurity.rest.api;


import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.security.model.User;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;
import java.util.Map;

/**
 * Created by fabad on 7/25/2017.
 */
public interface ISecurityServiceRest {
    Response login(Map<String, Object> loginRequest, @Context HttpServletRequest httpRequest);
    public ServiceResponse logout(Map<String, Object> logoutRequest, @Context HttpServletRequest httpRequest);
}
