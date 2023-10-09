package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.List;

import com.cobiscorp.ecobis.bpl.dao.workflow.ApprovalExceptionDao;
import com.cobiscorp.ecobis.bpl.service.workflow.ApprovalExceptionService;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ApprovalException;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.DocumentType;

public class ApprovalExceptionServiceImpl implements ApprovalExceptionService {

	private ApprovalExceptionDao approvalExceptionDao;

	public ApprovalExceptionDao getApprovalExceptionDao() {
		return approvalExceptionDao;
	}

	public void setApprovalExceptionDao(ApprovalExceptionDao approvalExceptionDao) {
		this.approvalExceptionDao = approvalExceptionDao;
	}

	public List<ApprovalException> findByStep(Integer idStep) {
		return approvalExceptionDao.findApprovalExceptionByStep(idStep);
	}

	public DocumentType findDocumentTypeById(Integer idDocType) {
		return approvalExceptionDao.findDocumentTypeById(idDocType);
	}

	public DocumentType saveDocumentType(DocumentType docType) {
		return approvalExceptionDao.saveDocumentType(docType);
	}

}
