package com.cobiscorp.mobile.rest.interfaces;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Response;

import com.cobiscorp.mobile.model.ExecuteMessageRequest;

public interface IRestMessagesService {

	public Response executeMessage(ExecuteMessageRequest executeMessageRequest, HttpServletRequest httpRequest);
}
