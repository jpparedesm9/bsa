package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.ApprovalExceptionDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.StepDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ApprovalException;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.DocumentType;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Step;

public class ApprovalExceptionDaoImpl implements ApprovalExceptionDao {

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	@SuppressWarnings("unchecked")
	public List<ApprovalException> findApprovalExceptionByStep(Integer idStep) {
		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT ae FROM ApprovalException ae ");
		sql.append(" WHERE ae.step.idStep=:idStep ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idStep", idStep);

		return query.getResultList();
	}

	public DocumentType findDocumentTypeById(Integer idDocType) {
		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT dt FROM DocumentType dt ");
		sql.append(" WHERE dt.idDocumentType=:idDocType ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idDocType", idDocType);

		if (query.getResultList().isEmpty()) {
			return null;
		} else {
			return (DocumentType) query.getSingleResult();
		}
	}

	public DocumentType findDocumentTypeByName(String docTypeName) {
		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT dt FROM DocumentType dt ");
		sql.append(" WHERE dt.documentTypeName=:documentTypeName ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("documentTypeName", docTypeName);

		if (query.getResultList().isEmpty()) {
			return null;
		} else {
			return (DocumentType) query.getSingleResult();
		}
	}

	public DocumentType saveDocumentType(DocumentType docType) {

		entityManager.persist(docType);
		return docType;
	}

	public Step saveApprovalException(Step step) throws Exception {
		entityManager.persist(step);
		return step;
	}

	public void detach(Step step) {
		entityManager.detach(step);
	}

}
