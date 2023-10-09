package com.cobis.cloud.lcr.b2b.service.integration;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.extractValue;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mobilelcr.dto.DocumentLcrRequest;
import cobiscorp.ecobis.mobilelcr.dto.DocumentLcrValidateResponse;

import com.cobis.cloud.lcr.b2b.service.common.RestServiceBase;
import com.cobis.cloud.lcr.b2b.service.dto.RevolvingDocumentRequest;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.google.gson.Gson;

public class RevolvingDocumentIntegration extends RestServiceBase {

	private final ILogger logger = LogFactory.getLogger(RevolvingDocumentIntegration.class);
	private final String className = "[RevolvingDocumentIntegration] ";

	public RevolvingDocumentIntegration(ICTSServiceIntegration integration) {
		super(integration);
		// TODO Auto-generated constructor stub
	}

	public void updateRevolvingDocument(RevolvingDocumentRequest revolvingDocumentRequest) {

		DocumentLcrRequest document = new DocumentLcrRequest();

		document.setInstProceso(revolvingDocumentRequest.getInstanceProcess());
		document.setInstActividad(revolvingDocumentRequest.getInstanceActivity());
		document.setLogginAsesor(revolvingDocumentRequest.getLogginAsesor());
		document.setStatusInterested(revolvingDocumentRequest.getStatusInterested());
		document.setCatalogue(revolvingDocumentRequest.getCatalogue());
		document.setDescription(revolvingDocumentRequest.getDescription());
		document.setOperacion('I');
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.setServiceId("DocumentLcrRequest.DocumentLcrRequest.CreateMobileLcrDocument");
		serviceRequestTO.addValue("inDocumentLcrRequest", document);
		ServiceResponse serviceResponse = this.execute("DocumentLcrRequest.DocumentLcrRequest.CreateMobileLcrDocument", serviceRequestTO);

		if (logger.isDebugEnabled()) {
			Gson gson = new Gson();
			logger.logDebug(className + "[CreateMobileLcrDocument][ServiceResponse]:" + gson.toJson(serviceResponse));
		}

		logger.logDebug("INGRESANDO A IDOCUMENT LCR REQUEST ---> " + serviceRequestTO.getData());

	}

	public void updateRevolvingRequisito(int instProces, int instActivity, int idDocument) {

		DocumentLcrRequest document = new DocumentLcrRequest();

		document.setInstProceso(instProces);
		document.setInstActividad(instActivity);
		document.setIdDocumet(idDocument);
		document.setOperacion('U');
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		serviceRequestTO.setServiceId("DocumentLcrRequest.DocumentLcrRequest.CreateMobileLcrDocument");
		serviceRequestTO.addValue("inDocumentLcrRequest", document);
		ServiceResponse serviceResponse = this.execute("DocumentLcrRequest.DocumentLcrRequest.CreateMobileLcrDocument", serviceRequestTO);

		if (logger.isDebugEnabled()) {
			Gson gson = new Gson();
			logger.logDebug(className + "[updateRevolvingRequisito][ServiceResponse]:" + gson.toJson(serviceResponse));
		}

		logger.logDebug("Inserccion en tablas de requisito ---> " + serviceRequestTO.getData());

	}

	public DocumentLcrValidateResponse[] searchDocuemntUp(int instProceso, String creditType) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		DocumentLcrRequest request = new DocumentLcrRequest();
		request.setOperacion('Q');
		request.setInstProceso(instProceso);
		request.setCreditType(creditType);
		requestTo.setServiceId("DocumentLcrRequest.DocumentLcrRequest.QueryMobileLcrValidateDocument");
		requestTo.addValue("inDocumentLcrRequest", request);
		ServiceResponse response = execute("DocumentLcrRequest.DocumentLcrRequest.QueryMobileLcrValidateDocument", requestTo);
		return extractValue(response, "returnDocumentLcrValidateResponse", DocumentLcrValidateResponse[].class);
	}

	public DocumentLcrValidateResponse[] searchInfoDocumentUp(int instProceso) {
		ServiceRequestTO requestTo = new ServiceRequestTO();
		DocumentLcrValidateResponse request = new DocumentLcrValidateResponse();
		request.setOperacion('T');
		request.setInstProceso(instProceso);
		requestTo.setServiceId("DocumentLcrRequest.DocumentLcrRequest.QueryInformationLcrDocument");
		requestTo.addValue("inDocumentLcrRequest", request);
		ServiceResponse response = execute("DocumentLcrRequest.DocumentLcrRequest.QueryInformationLcrDocument", requestTo);
		return extractValue(response, "returnDocumentLcrValidateResponse", DocumentLcrValidateResponse[].class);
	}

}
