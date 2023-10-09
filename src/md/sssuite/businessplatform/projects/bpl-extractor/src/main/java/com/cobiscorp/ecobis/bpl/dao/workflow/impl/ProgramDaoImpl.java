package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.log4j.Logger;

import com.cobiscorp.ecobis.bpl.dao.workflow.ProgramDao;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Programa;

public class ProgramDaoImpl implements ProgramDao {

	static Logger log = Logger.getLogger(ProgramDaoImpl.class);

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	public Programa findByNombreBddAndNombrePrograma(String nombreBdd, String nombrePrograma) {

		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT u  FROM Programa u ");
		sql.append(" WHERE  u.nombrePrograma = :nombrePrograma ");
		sql.append(" AND    u.nombreBdd = :nombreBdd ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("nombrePrograma", nombrePrograma);
		query.setParameter("nombreBdd", nombreBdd);

		List<Programa> programList = query.getResultList();

		if (programList.isEmpty()) {
			return null;
		}

		return programList.get(0);
	}

	public Programa findByNombrePrograma(String nombrePrograma) {
		
		log.debug("Programa--------------------------->1");

//		StringBuilder sql = new StringBuilder();
//		sql.append(" SELECT new Programa(u.idPrograma, u.descPrograma, u.nombreBdd, u.nombrePrograma, u.nombreServidor, u.tipoPrograma, u.ubicacionPrograma) FROM Programa u ");
//		sql.append(" WHERE  u.nombrePrograma = :nombrePrograma ");
		
		log.debug("Programa--------------------------->2");

		Query query = entityManager.createNamedQuery("Programa.findByNombrePrograma",Programa.class);
		query.setParameter("nombrePrograma", nombrePrograma);
		
		log.debug("Programa--------------------------->3");

		List<Programa> programList = query.getResultList();
		
		log.debug("Programa--------------------------->4");

		if (programList.isEmpty()) {
			return null;
		}

		return programList.get(0);

	}

	public Programa saveAndFlush(Programa programa) {
		entityManager.persist(programa);
		return programa;
	}

}
