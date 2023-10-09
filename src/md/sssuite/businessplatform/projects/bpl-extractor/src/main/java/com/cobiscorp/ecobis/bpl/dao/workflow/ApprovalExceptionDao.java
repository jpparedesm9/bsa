package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.ApprovalException;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.DocumentType;

public interface ApprovalExceptionDao {

	List<ApprovalException> findApprovalExceptionByStep(Integer idStep);

	//se busca en la tabla approvalException
	DocumentType findDocumentTypeById(Integer idDocType);
	
	DocumentType saveDocumentType(DocumentType docType);
	
	//se busca en la tabla documentType
	DocumentType findDocumentTypeByName(String docTypeName);

}
