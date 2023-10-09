package com.cobiscorp.ecobis.cloud.service;

import javax.ws.rs.core.Response;

public interface B2BClientService {

	public Response searchCustomerGroupByName(String name, String type, int sequential);

}
