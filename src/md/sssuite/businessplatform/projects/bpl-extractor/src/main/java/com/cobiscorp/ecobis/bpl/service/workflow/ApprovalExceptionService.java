package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.ApprovalException;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.DocumentType;

public interface ApprovalExceptionService {

	List<ApprovalException> findByStep(Integer idStep);

	//busca en la tabla ApprovalException
	DocumentType findDocumentTypeById(Integer idDocType);
	
	//Guarda en la tabla DocumentType
	DocumentType saveDocumentType(DocumentType docType);

}
