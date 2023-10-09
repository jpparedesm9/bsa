package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.AddresseeDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Addressee;

public class AddresseeDaoImpl implements AddresseeDao {

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	@SuppressWarnings("unchecked")
	public List<Addressee> findAddresseeByProcessVersion(Integer idProcess, Short versionProcess) {

		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT a  FROM Addressee a ");
		sql.append(" WHERE  a.idProcess = :idProcess ");
		sql.append(" AND    a.versionProcess = :versionProcess ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idProcess", idProcess);
		query.setParameter("versionProcess", versionProcess);

		return query.getResultList();

	}

	@SuppressWarnings("unchecked")
	public Addressee findAddresseeByProcessVersionActivity(Integer idProcess, Short versionProcess, String nameActivity) {

		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT a  FROM Addressee a ");
		sql.append(" WHERE  a.idProcess = :idProcess ");
		sql.append(" AND    a.versionProcess = :versionProcess ");
		sql.append(" AND    a.activity.name = :nameActivity ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idProcess", idProcess);
		query.setParameter("versionProcess", versionProcess);
		query.setParameter("nameActivity", nameActivity);

		List<Addressee> addresseeList = query.getResultList();

		if (addresseeList.isEmpty()) {
			return null;
		}
		entityManager.detach(addresseeList.get(0));
		return addresseeList.get(0);

	}

	public void update(Addressee addressee) {
		
		entityManager.merge(addressee);

		// StringBuilder sql = new StringBuilder();
		// sql.append(" UPDATE Addressee a SET a.idAddressees = :idAddressees ");
		// sql.append(" WHERE a.idProcess = :idProcess ");
		// sql.append(" AND   a.versionProcess = :versionProcess ");
		// sql.append(" AND   a.activity.idActivity = :idActivity ");
		//
		// Query query = entityManager.createQuery(sql.toString());
		// query.setParameter("idAddressees", addressee.getIdAddressees());
		// query.setParameter("idProcess", addressee.getIdProcess());
		// query.setParameter("versionProcess", addressee.getVersionProcess());
		// query.setParameter("idActivity", addressee.getActivity().getIdActivity());
		//
		// query.executeUpdate();
	}
}