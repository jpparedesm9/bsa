package com.cobiscorp.ecobis.bpl.dao.cobis.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.log4j.Logger;

import com.cobiscorp.ecobis.bpl.cobis.engine.model.Catalog;
import com.cobiscorp.ecobis.bpl.cobis.engine.model.CobisTable;
import com.cobiscorp.ecobis.bpl.cobis.engine.model.IdCatalog;
import com.cobiscorp.ecobis.bpl.dao.cobis.CatalogDao;

public class CatalogDaoImpl implements CatalogDao {

	static Logger log = Logger.getLogger(CatalogDaoImpl.class);

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	public Catalog findCatalogByObservation(String observacionId) throws Exception {
		try {
			Query query = entityManager.createNamedQuery("Catalog.findByObservation");
			query.setParameter("codigo", observacionId);
			return (Catalog) query.getSingleResult();
		} catch (NonUniqueResultException nurex) {
			return null;
		} catch (NoResultException e) {
			return null;
		}

	}

	public Catalog saveCatalog(Catalog catalog) throws Exception {
		entityManager.persist(catalog);
		return catalog;

	}

	public Catalog findAndSave(Catalog catalog) throws Exception {

		Catalog searchCatalog = hmCatalog.get(catalog.getTable().getTable() + "-" + catalog.getCodigo());

		log.debug("Catalog---------------------------->1");

		if (searchCatalog == null) {

			log.debug("Catalog---------------------------->2");

			CobisTable cobisTable = hmTable.get(catalog.getTable().getTable());

			if (cobisTable == null) {

				log.debug("Catalog---------------------------->3");

				Query query = entityManager.createNamedQuery("CobisTable.findByTable", CobisTable.class);
				query.setParameter("tabla", catalog.getTable().getTable());
				List<CobisTable> tableList = query.getResultList();
				if (!tableList.isEmpty()) {
					log.debug("Catalog---------------------------->4");
					cobisTable = tableList.get(0);
				}
				log.debug("Catalog---------------------------->5");

			}

			if (cobisTable != null) {

				log.debug("Catalog---------------------------->6");

				searchCatalog = findCatalogByObservation(catalog.getCodigo());

				log.debug("Catalog---------------------------->7");

				if (searchCatalog == null) {
					log.debug("Catalog---------------------------->8");
					searchCatalog = new Catalog();
					searchCatalog.setCodigo(catalog.getCodigo());
					searchCatalog.setCulture(catalog.getCulture());
					searchCatalog.setEquivCode(catalog.getEquivCode());
					searchCatalog.setIdCatalog(new IdCatalog(catalog.getCodigo(), cobisTable.getIdTable()));
					searchCatalog.setStatus(catalog.getStatus());
					searchCatalog.setTable(cobisTable);
					searchCatalog.setType(catalog.getType());
					searchCatalog.setValue(catalog.getValue());
					searchCatalog = saveCatalog(searchCatalog);
					log.debug("Catalog---------------------------->9");
					hmCatalog.put(cobisTable.getTable() + "-" + searchCatalog.getCodigo(), searchCatalog);
					return searchCatalog;
				} else {
					log.debug("Catalog---------------------------->10");
					hmCatalog.put(cobisTable.getTable() + "-" + searchCatalog.getCodigo(), searchCatalog);
					return searchCatalog;
				}
			} else {
				return null;
			}

		}
		return searchCatalog;
	}
}
