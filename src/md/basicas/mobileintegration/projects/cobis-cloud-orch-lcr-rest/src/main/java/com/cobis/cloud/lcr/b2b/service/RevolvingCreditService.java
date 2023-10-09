package com.cobis.cloud.lcr.b2b.service;

import javax.ws.rs.core.Response;

import com.cobis.cloud.lcr.b2b.service.dto.RevolvingCreditRequest;

public interface RevolvingCreditService {
	Response create(RevolvingCreditRequest revolvingCreditRequest);
	Response update(RevolvingCreditRequest revolvingCreditRequest);

	
}
