package com.cobis.cloud.lcr.b2b.service;

import javax.ws.rs.core.Response;

import com.cobis.cloud.lcr.b2b.service.dto.RevolvingDocumentRequest;
import com.cobis.cloud.lcr.b2b.service.dto.RevolvingUpdateDocHederRequest;

public interface RevolvingDocumentService {

	public Response acceptedCredit(RevolvingDocumentRequest revolvingDocumentRequest);
	public Response updateInformationDocumentLcr(RevolvingUpdateDocHederRequest updateDocumentRequest);
	public Response requestInfoDocumentLcr(int processInstance);
	

}
