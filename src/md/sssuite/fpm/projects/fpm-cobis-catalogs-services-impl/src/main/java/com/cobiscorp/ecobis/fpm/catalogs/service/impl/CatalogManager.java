/*
 * File: ICatalogManager.java
 * Date: October 6, 2011
 *
 * This application is part of banking packages owned by COBISCORP. 
 * Unauthorized use is prohibited as well as any alteration or 
 * addition made by any of its users without due due COBISCORP 
 * written consent.
 * This program is protected by copyright law and by international 
 * intellectual property conventions. Its unauthorized use COBISCORP 
 * right to give orders for retention and to prosecute those 
 * responsible for any breach.
 */
package com.cobiscorp.ecobis.fpm.catalogs.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.catalogs.service.ICatalogManager;
import com.cobiscorp.ecobis.fpm.catalogs.utils.MessageManager;
import com.cobiscorp.ecobis.fpm.cobis.catalogs.model.CatalogTable;
import com.cobiscorp.ecobis.fpm.cobis.catalogs.model.Currency;

/**
 * This service allows to query the information store in the COBIS Catalog
 * related to the cl_tabla and cl_catalogo
 * 
 * @author cloachamin
 */
public class CatalogManager implements ICatalogManager {

	/** Cobis Logger */
	private final ILogger logger = LogFactory.getLogger(CatalogManager.class);
	/** Represents the delete status in the COBIS catalog */
	private final String DELETE_STATUS = "E";
	/** Represents the valid status in the COBIS catalog */
	private final String VALID_STATUS = "V";
	/** Entity Manager injected by the container */
	@PersistenceContext(unitName = "JpaFpmCatalogs")
	private EntityManager em;

	/**
	 * Query a catalog by the catalog name
	 * 
	 * @param name
	 *            The name of the catalog
	 * 
	 * @return A list of <tt>Catalog</tt> business objects
	 */
	public List<Catalog> getCatalogsByName(String name) {
		try {
			logger.logDebug(MessageManager.getString("CATALOGMANAGER.001",
					"GetCatalogsByName"));
			List<com.cobiscorp.ecobis.fpm.cobis.catalogs.model.Catalog> coreCatalogs = em
					.createNamedQuery(
							"Catalog.findValidCatalogsByTableName",
							com.cobiscorp.ecobis.fpm.cobis.catalogs.model.Catalog.class)
					.setParameter("tableName", name).getResultList();
			// Convert the found entities to the Catalog business objects
			List<Catalog> catalogs = new ArrayList<Catalog>();
			for (com.cobiscorp.ecobis.fpm.cobis.catalogs.model.Catalog coreCatalog : coreCatalogs) {
				catalogs.add(new Catalog(coreCatalog.getCode().trim(),
						coreCatalog.getValue()));
			}
			return catalogs;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("COMPANYMANAGER.003"), ex);
			throw new BusinessException(6900126,
					"No se pudo obtener el catálogo requerido");
		} finally {
			logger.logDebug(MessageManager.getString("CATALOGMANAGER.002",
					"getCompanyById"));
		}
	}

	/**
	 * Get a specific catalog given the name and code
	 * 
	 * @param name
	 *            Catalog name
	 * @param code
	 *            Catalog specific code identifier
	 * @return Catalog found
	 */
	public Catalog getCatalog(String name, String code) {
		try {
			logger.logDebug(MessageManager.getString("CATALOGMANAGER.001",
					"getCatalog"));

			com.cobiscorp.ecobis.fpm.cobis.catalogs.model.Catalog catalog = getCatalogEntity(
					name, code);
			// If was not found throw a exception
			if (catalog == null || !catalog.getStatus().trim().equals(VALID_STATUS)) {
				logger.logError(MessageManager.getString("COMPANYMANAGER.003"));
				throw new BusinessException(6900126,
						"No se pudo obtener el catálogo requerido");
			}
			return new Catalog(catalog.getCode(), catalog.getValue());
		} catch (BusinessException be) {
			throw be;
		} catch (NoResultException nre) {
			logger.logError(
					MessageManager.getString("CATALOGMANAGER.005", name), nre);
			throw new BusinessException(6900132,
					"No se pudo encontrar la tabla asociada al catálogo");
		} catch (Exception e) {
			logger.logError(
					MessageManager.getString("CATALOGMANAGER.010", code), e);

			throw new BusinessException(6900137,
					"No se pudo encontrar el catálogo");
		} finally {
			logger.logDebug(MessageManager.getString("CATALOGMANAGER.002",
					"getCatalog"));
		}
	}

	public Catalog getCatalogRegardlessState(String name, String code) {
		try {
			logger.logDebug(MessageManager.getString("CATALOGMANAGER.001",
					"getSpecificCatalog"));

			com.cobiscorp.ecobis.fpm.cobis.catalogs.model.Catalog catalog = getCatalogEntity(
					name, code);
			// If was not found throw a exception
			if (catalog == null) {
				logger.logError(MessageManager.getString("COMPANYMANAGER.003"));

				return null;
			}
			return new Catalog(catalog.getCode(), catalog.getValue());
		} catch (BusinessException be) {
			throw be;
		} catch (NoResultException nre) {
			logger.logError(
					MessageManager.getString("CATALOGMANAGER.005", name), nre);
			throw new BusinessException(6900132,
					"No se pudo encontrar la tabla asociada al catálogo");
		} catch (Exception e) {
			logger.logError(
					MessageManager.getString("CATALOGMANAGER.010", code), e);

			throw new BusinessException(6900137,
					"No se pudo encontrar el catálogo");
		} finally {
			logger.logDebug(MessageManager.getString("CATALOGMANAGER.002",
					"getSpecificCatalog"));
		}
	}

	/**
	 * Create a new Catalog
	 * 
	 * @param name
	 *            Catalog name
	 * @param catalog
	 *            catalog to create
	 */
	public void createCatalog(String name, Catalog catalog) {

		try {

			logger.logDebug(MessageManager.getString("CATALOGMANAGER.001",
					"createCatalog"));
			// Find if a deleted catalog exist
			com.cobiscorp.ecobis.fpm.cobis.catalogs.model.Catalog foundCatalog = getCatalogEntity(
					name, catalog.getCode());
			// If no catalog was found, create new one
			if (foundCatalog == null) {
				// Find the table to use the sequential table code
				CatalogTable table = this.em
						.createNamedQuery("CatalogTable.findByTableName",
								CatalogTable.class)
						.setParameter("tableName", name).getSingleResult();
				com.cobiscorp.ecobis.fpm.cobis.catalogs.model.Catalog newCatalog = new com.cobiscorp.ecobis.fpm.cobis.catalogs.model.Catalog();
				newCatalog.setCode(catalog.getCode());
				newCatalog.setValue(catalog.getName());
				newCatalog.setStatus(VALID_STATUS);
				newCatalog.setCatalogTable(table);
				this.em.persist(newCatalog);
			} else { // Change the status to V
				foundCatalog.setStatus(VALID_STATUS);
				foundCatalog.setValue(catalog.getName());
			}
			this.em.flush();
		} catch (NoResultException nre) {
			logger.logError(
					MessageManager.getString("CATALOGMANAGER.005", name), nre);
			throw new BusinessException(6900132,
					"No se pudo encontrar la tabla asociada al catálogo");
		} catch (EntityExistsException eex) {
			logger.logError(MessageManager.getString("CATALOGMANAGER.006"), eex);
			throw new BusinessException(6900133,
					"El catálogo que desea crear ya existe");

		} catch (Exception e) {
			logger.logError(
					MessageManager.getString("CATALOGMANAGER.007",
							catalog.getName()), e);
			throw new BusinessException(6900134, "No se pudo crear el catálogo");
		} finally {
			logger.logDebug(MessageManager.getString("CATALOGMANAGER.002",
					"createCatalog"));
		}

	}

	/**
	 * Delete a specific Catalog given the code
	 * 
	 * @param name
	 *            Catalog name
	 * @param code
	 *            Catalog code
	 */
	public void deleteCatalog(String name, Catalog catalog) {
		try {

			logger.logDebug(MessageManager.getString("CATALOGMANAGER.001",
					"deleteCatalog"));
			com.cobiscorp.ecobis.fpm.cobis.catalogs.model.Catalog deleteCatalog = getCatalogEntity(
					name, catalog.getCode());
			// If was not found throw a exception
			if (deleteCatalog == null) {
				logger.logError(MessageManager.getString("CATALOGMANAGER.008"));
				throw new BusinessException(6900135,
						"No se encuentra el catálogo que se desea eliminar");
			}
			this.em.remove(deleteCatalog);
			this.em.flush();
		} catch (NoResultException nre) {
			logger.logError(
					MessageManager.getString("CATALOGMANAGER.005", name), nre);
			throw new BusinessException(6900132,
					"No se pudo encontrar la tabla asociada al catálogo");
		} catch (BusinessException be) {
			throw be;
		} catch (Exception e) {
			logger.logError(
					MessageManager.getString("CATALOGMANAGER.009",
							catalog.getCode()), e);
			throw new BusinessException(6900136,
					"No se pudo eliminar el catálogo");
		} finally {
			logger.logDebug(MessageManager.getString("CATALOGMANAGER.002",
					"deleteCatalog"));

		}
	}

	public void disableCatalog(String name, Catalog catalog) {
		try {

			logger.logDebug(MessageManager.getString("CATALOGMANAGER.001",
					"deleteCatalog"));
			// Get a managed entity for the given catalog
			com.cobiscorp.ecobis.fpm.cobis.catalogs.model.Catalog catalogEntity = getCatalogEntity(
					name, catalog.getCode());
			// If was not found throw a exception
			if (catalogEntity == null) {
				logger.logError(MessageManager.getString("COMPANYMANAGER.003"));
				throw new BusinessException(6900126,
						"No se pudo obtener el catálogo requerido");
			}
			// Update the status to D
			catalogEntity.setStatus(DELETE_STATUS);
			// flush the transaction
			em.flush();
		} catch (NoResultException nre) {
			logger.logError(
					MessageManager.getString("CATALOGMANAGER.005", name), nre);
			throw new BusinessException(6900132,
					"No se pudo encontrar la tabla asociada al catálogo");
		} catch (BusinessException be) {
			throw be;
		} catch (Exception e) {
			logger.logError(
					MessageManager.getString("CATALOGMANAGER.012",
							catalog.getCode()), e);
			throw new BusinessException(6900140,
					"Ocurrio un error al establecer el catálogo como no disponible");
		} finally {
			logger.logDebug(MessageManager.getString("CATALOGMANAGER.002",
					"deleteCatalog"));

		}
	}

	/**
	 * Change the status of the catalog to enable
	 * 
	 * @param name
	 *            Catalog name
	 * @param catalog
	 *            Catalog object
	 */
	public void enableCatalog(String name, Catalog catalog) {
		try {

			logger.logDebug(MessageManager.getString("CATALOGMANAGER.001",
					"enableCatalog"));
			// Get a managed entity for the given catalog
			com.cobiscorp.ecobis.fpm.cobis.catalogs.model.Catalog catalogEntity = getCatalogEntity(
					name, catalog.getCode());
			// Update the status to D
			catalogEntity.setStatus(VALID_STATUS);
			// flush the transaction
			em.flush();
		} catch (NoResultException nre) {
			logger.logError(
					MessageManager.getString("CATALOGMANAGER.005", name), nre);
			throw new BusinessException(6900132,
					"No se pudo encontrar la tabla asociada al catálogo");
		} catch (BusinessException be) {
			throw be;
		} catch (Exception e) {
			logger.logError(
					MessageManager.getString("CATALOGMANAGER.012",
							catalog.getCode()), e);
			throw new BusinessException(6900140,
					"Ocurrio un error al establecer el catálogo como disponible");
		} finally {
			logger.logDebug(MessageManager.getString("CATALOGMANAGER.002",
					"enableCatalog"));

		}
	}

	/**
	 * Find a managed entity that represents a catalog
	 * 
	 * @param tableName
	 *            COBIS catalog table name
	 * @param code
	 *            COBIS catalog code
	 * @return Managed entity bean
	 */
	private com.cobiscorp.ecobis.fpm.cobis.catalogs.model.Catalog getCatalogEntity(
			String tableName, String code) {
		// Find a table catalog
		CatalogTable table = this.em
				.createNamedQuery("CatalogTable.findByTableName",
						CatalogTable.class)
				.setParameter("tableName", tableName).getSingleResult();
		// Find the specific catalog given the primary key
		com.cobiscorp.ecobis.fpm.cobis.catalogs.model.Catalog catalogEntity = this.em
				.find(com.cobiscorp.ecobis.fpm.cobis.catalogs.model.Catalog.class,
						new com.cobiscorp.ecobis.fpm.cobis.catalogs.model.CatalogId(
								code, table.getCode()));
		logger.logDebug(MessageManager.getString("CATALOGMANAGER.013",
				tableName, code, catalogEntity));
		return catalogEntity;
	}

	/**
	 * Verify if the given catalog exist in the core
	 * 
	 * @param name
	 * @return true If the catalog has data otherwise false
	 */
	public Boolean verifyCatalog(String name) {

		try {
			logger.logDebug(MessageManager.getString("CATALOGMANAGER.001",
					"verifyCatalog"));
			// Find a table catalog
			Long catalogs = this.em
					.createNamedQuery("Catalog.countCatalogsByTableName",
							Long.class).setParameter("tableName", name)
					.getSingleResult();
			return catalogs > 0;
		} catch (Exception e) {
			logger.logError(
					MessageManager.getString("CATALOGMANAGER.014", name), e);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString("CATALOGMANAGER.002",
					"verifyCatalog"));
		}
	}

	/**
	 * Return all the currency available by the core
	 * 
	 * @return List of <tt>Currency</tt> business objects
	 */
	public List<Catalog> getAllCurrencies() {
		try {
			logger.logDebug(MessageManager.getString("CATALOGMANAGER.001",
					"getAllCurrencies"));
			// Find the available currencies in the core tables
			List<Currency> currencies = em.createNamedQuery(
					"Currency.findAllValidCurrencies", Currency.class)
					.getResultList();
			// Convert the found entities to the Catalog business objects
			List<Catalog> catalogs = new ArrayList<Catalog>();
			for (Currency currency : currencies) {
				catalogs.add(new Catalog(String.valueOf(currency.getId()),
						currency.getDescription()));
			}
			return catalogs;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("COMPANYMANAGER.004"), ex);
			throw new BusinessException(6900127,
					"No se pudo obtener el catálogo de monedas disponibles");
		} finally {
			logger.logDebug(MessageManager.getString("CATALOGMANAGER.002",
					"getAllCurrencies"));
		}
	}

}
