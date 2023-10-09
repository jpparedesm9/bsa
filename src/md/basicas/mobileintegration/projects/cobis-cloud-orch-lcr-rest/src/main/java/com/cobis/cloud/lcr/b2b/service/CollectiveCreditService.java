package com.cobis.cloud.lcr.b2b.service;

import javax.ws.rs.core.Response;

import com.cobis.cloud.lcr.b2b.service.dto.CollectiveCreditRequest;

public interface CollectiveCreditService {
	public Response updateDocumentAndQuestionnaireCollective(CollectiveCreditRequest collectiveCreditRequest);

}
