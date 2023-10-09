package com.cobiscorp.ecobis.commons.dal.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.ecobis.commons.dal.CatalogDAO;
import com.cobiscorp.ecobis.commons.dal.entities.Catalog;

public class CatalogDAOImpl implements CatalogDAO {

	private EntityManager em;

	/**
	 * Initialize the Entity Manager.
	 * 
	 * @param em
	 */
	@PersistenceContext(unitName = "JpaCommonsServices")
	public void setEm(EntityManager em) {
		this.em = em;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.commons.dal.CatalogDAO#getCatalogsByName(java.lang
	 * .String)
	 */
	public List<Catalog> getCatalogsByName(String name) {
		List<Catalog> coreCatalogs = em
				.createNamedQuery("Catalog.findValidCatalogsByTableName",
						Catalog.class).setParameter("tableName", name)
				.getResultList();
		return coreCatalogs;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.ecobis.commons.dal.CatalogDAO#getValueCatalog(java.lang
	 * .String, java.lang.String)
	 */
	@Override
	public String getValueCatalog(String name, String code) {

		List<String> resp = em
				.createNamedQuery("Catalog.getValue", String.class)
				.setParameter("tableName", name).setParameter("code", code)
				.getResultList();
		if (resp.size() > 0) {
			return resp.get(0);
		}
		return null;
	}
}
