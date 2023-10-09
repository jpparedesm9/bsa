package com.cobiscorp.mobile.service.interfaces;

import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.request.DocumentUploadRequest;

public interface IDocumentUpload {

	/**
	 * Realiza la evaluacion del cliente
	 * 
	 * @param curp
	 * @return evaluacion del cliente, id y monto
	 * @throws MobileServiceException cobis-mb-services-integration
	 */

	// metodo que dentro va a estar lo de los sg
	void documentUploadImp(DocumentUploadRequest documentUploadRequest) throws MobileServiceException;

}
