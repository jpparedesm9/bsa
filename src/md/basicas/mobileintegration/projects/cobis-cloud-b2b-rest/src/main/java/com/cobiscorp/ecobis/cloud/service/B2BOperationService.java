package com.cobiscorp.ecobis.cloud.service;

import javax.ws.rs.core.Response;

public interface B2BOperationService {
	public Response searchOperations(Integer clientGroupCode, String type, String correspondent);
}
