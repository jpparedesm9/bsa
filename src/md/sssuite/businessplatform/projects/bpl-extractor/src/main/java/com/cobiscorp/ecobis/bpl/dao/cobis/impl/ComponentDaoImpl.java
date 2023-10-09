package com.cobiscorp.ecobis.bpl.dao.cobis.impl;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.cobis.engine.model.Component;
import com.cobiscorp.ecobis.bpl.dao.cobis.ComponentDao;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;

public class ComponentDaoImpl implements ComponentDao {
	static int counter = 0;
	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	public Component findByName(String name) throws Exception {
		try {
			Query query = entityManager.createNamedQuery("Component.findByName");
			query.setParameter("name", name);
			return (Component) query.getSingleResult();
		} catch (NonUniqueResultException nurex) {
			return null;
		} catch (NoResultException nex) {
			return null;
		}
	}

	public Integer findMaxId() throws Exception {
		try {
			Query query = entityManager.createNamedQuery("Component.findMaxId");
			return (Integer) query.getSingleResult();
		} catch (NonUniqueResultException nurex) {
			return null;
		} catch (NoResultException nex) {
			return null;
		}
	}

	public Component saveComponent(Component component) throws Exception {
		entityManager.persist(component);
		return component;
	}

	public Component findAndSaveComponent(Component component, DriverManagerDataSource dataSource) throws Exception {
		++counter;
		Component searchComponent = hmComponent.get(component.getName());
		if (searchComponent == null) {
			searchComponent = findByName(component.getName());
			if (searchComponent == null) {
				component.setIdComponent(findMaxId() + counter);
				component = saveComponent(component);
				hmComponent.put(component.getName(), component);
				return component;
			}
			hmComponent.put(searchComponent.getName(), searchComponent);

		}
		return searchComponent;
	}
}
