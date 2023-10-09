package com.cobiscorp.ecobis.cloud.service;

import javax.validation.Valid;
import javax.ws.rs.core.Response;

import com.cobiscorp.mobile.model.RenapoClientRequest;

public interface ValidationsService {
	Response queryRenapoByCurp(@Valid RenapoClientRequest clientRequest);

}
