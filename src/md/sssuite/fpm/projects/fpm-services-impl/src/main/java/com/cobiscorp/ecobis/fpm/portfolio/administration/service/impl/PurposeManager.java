/*
 * File: PurposeManager.java
 * Date: May 10 2012
 *
 * Copyright (c) 2011 Cobiscorp (Banking Technology Partners) SA, All Rights Reserved.
 *
 * This code is confidential to Cobiscorp and shall not be disclosed outside Cobiscorp                                      
 * without the prior written permission of the Technology Center.
 *
 * In the event that such disclosure is permitted the code shall not be copied
 * or distributed other than on a need-to-know basis and any recipients may be
 * required to sign a confidentiality undertaking in favor of Cobiscorp SA.
 */
package com.cobiscorp.ecobis.fpm.portfolio.administration.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TemporalType;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.bo.CatalogConstraintLog;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.CatalogConstraintHistory;
import com.cobiscorp.ecobis.fpm.model.Purpose;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.portfolio.administration.service.IPurposeManager;
import com.cobiscorp.ecobis.fpm.portfolio.catalogs.service.IPortfolioCatalogManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.service.utils.CatalogUtils;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

/**
 * This service allows manage Destination and Purposes for a product.
 * 
 * @author bron
 */

public class PurposeManager implements IPurposeManager {

	/** COBIS Logger */
	private final ILogger logger = LogFactory.getLogger(PurposeManager.class);

	/** Entity Manager injected by the container */
	private EntityManager entityManager;

	/** The catalog portfolio service */
	private IPortfolioCatalogManager portfolioCatalogService;
	/** The banking product manager service */
	private IBankingProductManager bankingProductService;

	
	public Long createPurpose(Purpose purpose) {
		try {
			logger.logDebug(MessageManager.getString("PURPOSEMANAGER.001",
					"createPurpose"));

			// The id must be null to JPA insert the sequential id number
			if (purpose.getId() != null) {
				purpose.setId(null);
			}
			entityManager.persist(purpose);
			entityManager.flush();
			return purpose.getId();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PURPOSEMANAGER.099"), ex);
			throw new BusinessException(6900207,
					"No se pudo crear el propósito del producto indicado");

		} finally {
			logger.logDebug(MessageManager.getString("PURPOSEMANAGER.002",
					"createPurpose"));
		}
	}

	
	public void deletePurpose(Long id) {
		try {
			logger.logDebug(MessageManager.getString("PURPOSEMANAGER.001",
					"deletePurpose"));
			Purpose purpose = entityManager.find(Purpose.class, id);

			if (purpose != null) {
				entityManager.remove(purpose);
				entityManager.flush();
			}
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PURPOSEMANAGER.099"), ex);
			throw new BusinessException(6900209,
					"No se pudo crear la información histórica del proposito del producto indicado");
		} finally {
			logger.logDebug(MessageManager.getString("PURPOSEMANAGER.002",
					"deletePurpose"));
		}

	}

	
	public List<Purpose> getPurpose(String productId) {
		try {
			logger.logDebug(MessageManager.getString("PURPOSEMANAGER.001",
					"getPurpose"));
			return entityManager
					.createNamedQuery("Purpose.findPurposeByProductId",
							Purpose.class).setParameter("productId", productId)
					.getResultList();
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("PURPOSEMANAGER.099", productId),
					ex);
			throw new BusinessException(6900199,
					"No se pudo encontrar el propósito  del producto bancario indicado");
		} finally {
			logger.logDebug(MessageManager.getString("PURPOSEMANAGER.002",
					"getPurpose"));
		}
	}

	/**
	 * Method for insert purpose in historic
	 * 
	 * @param bankingProductHistoryId
	 *            <tt>the sequential identifier of BankingProductHistory</tt>
	 * @param authorizationStatus
	 */
	
	public void createPurposeHistory(
			BankingProductHistory bankingProductHistoryId,
			String authorizationStatus) {
		try {
			BankingProductHistory bphistory = new BankingProductHistory();
			logger.logDebug(MessageManager.getString("PURPOSEMANAGER.001",
					"createPurposeHistory"));
			// Get all the economic destinations
			bphistory = entityManager.find(BankingProductHistory.class,
					bankingProductHistoryId.getId());

			List<Purpose> purposes = getPurpose(bphistory.getProductId());
			for (Purpose purpose : purposes) {
				// Create the history object to persist
				CatalogConstraintHistory history = new CatalogConstraintHistory();
				// Set the related banking product history
				history.setBankingProductHistory(new BankingProductHistory());
				history.getBankingProductHistory().setId(bphistory.getId());
				history.setCode(purpose.getCode());
				history.setType(purpose.getType());
				history.setProcessDate(new SimpleDateFormat(
						Constants.PROCESS_DATE_FORMAT).parse(ContextManager
						.getContext().getProcessDate()));
				entityManager.persist(history);
			}
			entityManager.flush();
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString("PURPOSEMANAGER.099",
					"createPurposeHistory"), eee);
			throw new BusinessException(6900208,
					"No se pudo crear la información histórica del proposito del producto indicado");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PURPOSEMANAGER.002",
					"createPurposeHistory"), ex);
			throw new BusinessException(6900208,
					"No se pudo crear la información histórica del proposito del producto indicado");
		} finally {
			logger.logDebug(MessageManager.getString("PURPOSEMANAGER.002",
					"createPurposeHistory"));
		}

	}

	
	public void restorePurpose(Long bankingProductHistory) {
		try {
			logger.logDebug(MessageManager.getString("PURPOSEMANAGER.001",
					"restorePurpose"));
			BankingProductHistory bphistory = new BankingProductHistory();
			bphistory = entityManager.find(BankingProductHistory.class,
					bankingProductHistory);

			List<CatalogConstraintHistory> histories = getHistoricalPurpose(bphistory);
			for (CatalogConstraintHistory history : histories) {
				Purpose purpose = new Purpose();
				purpose.setBankingProduct(new BankingProduct());
				purpose.getBankingProduct().setId(bphistory.getProductId());
				purpose.setCode(history.getCode());
				entityManager.persist(purpose);
			}
			entityManager.flush();
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString("PURPOSEMANAGER.099",
					"restorePurpose"), eee);
			throw new BusinessException(6900210,
					"No se pudo restaurar la información de los propóstos del producto indicado");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(

			"PURPOSEMANAGER.002", "restorePurpose"), ex);
			throw new BusinessException(6900210,
					"No se pudo restaurar la información de los propóstos del producto indicado");
		} finally {
			logger.logDebug(MessageManager.getString("PURPOSEMANAGER.002",
					"restorePurpose"));
		}

	}

	/**
	 * Get the latest historical log for Purpose information
	 * 
	 * @param bankingProductHistoryId
	 *            <tt>the sequential identifier of BankingProductHistory</tt>
	 * @return The business object with the Economic Destination log
	 */
	
	public List<CatalogConstraintLog> getPurposeHistoricalLog(
			Long bankingProductHistoryId) {
		try {
			logger.logDebug(MessageManager.getString("PURPOSEMANAGER.001",
					"getPurposeHistoricalLog"));
			BankingProductHistory bph = entityManager.find(
					BankingProductHistory.class, bankingProductHistoryId);
			if (null == bph) {
				throw new BusinessException(6900177,
						"No se encontro ningun historico del producto con la fecha indicada.");
			}
			// Get the latest historical
			List<CatalogConstraintHistory> histories = getHistoricalPurpose(bph);
			// Get the economic destinations catalog
			List<Catalog> catalogs = portfolioCatalogService.findAllPurposes();
			// Create the return list
			List<CatalogConstraintLog> logs = new ArrayList<CatalogConstraintLog>();
			for (CatalogConstraintHistory history : histories) {
				Catalog catalog = CatalogUtils.getFromCatalogList(catalogs,
						history.getCode());
				logs.add(new CatalogConstraintLog(history.getCode(),
						catalog == null ? "" : catalog.getName()));
			}
			return logs;
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PURPOSEMANAGER.099"), ex);
			throw new BusinessException(6900211,
					"Ocurrio un error al obtener la información del historico de los propósitos");
		} finally {
			logger.logDebug(MessageManager.getString("PURPOSEMANAGER.002",
					"getPurposeHistoricalLog"));
		}
	}

	
	public Map<String, List<CatalogConstraintLog>> getPurposeChanges(
			String productId) {
		try {
			logger.logDebug(MessageManager.getString("PURPOSEMANAGER.001",
					"getPurposeChanges"));
			// Create the map for the changes
			Map<String, List<CatalogConstraintLog>> changes = new HashMap<String, List<CatalogConstraintLog>>();
			// Get the economic destinations
			List<Purpose> purposes = getPurpose(productId);
			// Get the economic destinations catalog
			List<Catalog> catalogs = portfolioCatalogService.findAllPurposes();
			// Create the return list
			List<CatalogConstraintLog> logs = new ArrayList<CatalogConstraintLog>();
			for (Purpose history : purposes) {
				Catalog catalog = CatalogUtils.getFromCatalogList(catalogs,
						history.getCode());
				logs.add(new CatalogConstraintLog(history.getCode(),
						catalog == null ? "" : catalog.getName()));
			}
			changes.put(Constants.AFTER_VALUE, logs);
			BankingProductHistory bph = bankingProductService
					.getLatestHistorical(productId);
			// If there is not a historical
			if (bph == null) {
				changes.put(Constants.BEFORE_VALUE,
						new ArrayList<CatalogConstraintLog>());
				return changes;
			}

			changes.put(Constants.BEFORE_VALUE,
					getPurposeHistoricalLog(bph.getId()));
			return changes;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PURPOSEMANAGER.099"), ex);
			throw new BusinessException(6900212,
					"Ocurrio un error al obtener los cambios de los propósitos.");
		} finally {
			logger.logDebug(MessageManager.getString("PURPOSEMANAGER.002",
					"getPurposeChanges"));
		}
	}

	
	public Boolean checkPurposeConfigurationComplete(String productId) {
		try {
			logger.logDebug(MessageManager.getString("PURPOSEMANAGER.001",
					"checkPurposeConfigurationComplete"));
			return entityManager
					.createNamedQuery("Purpose.countPurposeByProductId",
							Long.class).setParameter("productId", productId)
					.getSingleResult() > 0;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("PURPOSEMANAGER.099", productId),
					ex);
			throw new BusinessException(6900199,
					"No se pudo encontrar el propósito  del producto bancario indicado");
		} finally {
			logger.logDebug(MessageManager.getString("PURPOSEMANAGER.002",
					"checkPurposeConfigurationComplete"));
		}
	}

	private List<CatalogConstraintHistory> getHistoricalPurpose(
			BankingProductHistory bankingProductHistory) {
		// Find all the economic destination history
		return entityManager
				.createNamedQuery(
						"CatalogConstraintHistory.getPurposeByHistoyId",
						CatalogConstraintHistory.class)
				.setParameter("productId", bankingProductHistory.getProductId())
				.setParameter("systemDateId",
						bankingProductHistory.getSystemDateId(),
						TemporalType.TIMESTAMP).getResultList();
	}

	/**
	 * Initialize the Entity Manager.
	 * 
	 * @param entityManager
	 *            Entity Manager
	 */
	@PersistenceContext(unitName = "JpaFpmAdministration")
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	/**
	 * @param portfolioCatalogService
	 *            the portfolioCatalogService to set
	 */
	public void setPortfolioCatalogService(
			IPortfolioCatalogManager portfolioCatalogService) {
		this.portfolioCatalogService = portfolioCatalogService;
	}

	/**
	 * @param bankingProductService
	 *            the bankingProductService to set
	 */
	public void setBankingProductService(
			IBankingProductManager bankingProductService) {
		this.bankingProductService = bankingProductService;
	}

	
	public void createPurposeList(ArrayList<String> purposeList,
			String bankinProductID) {
		// TODO Auto-generated method stub
		try {
			logger.logDebug(MessageManager.getString("PURPOSEMANAGER.001",
					"createPurposeList"));
			deleteAllPurposes(bankinProductID);
			BankingProduct bp = bankingProductService
					.getBankingProductById(bankinProductID);
			for (String purposeCode : purposeList) {
				Purpose purpose = new Purpose();
				purpose.setCode(purposeCode);
				purpose.setBankingProduct(bp);
				createPurpose(purpose);
			}

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PURPOSEMANAGER.099"), ex);
			throw new BusinessException(6900198,
					"No se pudo crear el destino económico del producto bancario indicado");
		} finally {
			logger.logDebug(MessageManager.getString("PURPOSEMANAGER.002",
					"createPurposeList"));
		}
	}

	private void deleteAllPurposes(String bankingProductId) {
		try {
			logger.logDebug(MessageManager.getString("PURPOSEMANAGER.001",
					"deleteAllPurposes"));
			List<Purpose> purposesList = getPurpose(bankingProductId);
			if (purposesList != null && purposesList.size() > 0) {
				for (Purpose p : purposesList) {
					entityManager.remove(p);
				}

				entityManager.flush();
			}
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("PURPOSEMANAGER.099"), ex);
			throw new BusinessException(6900198,
					"No se pudo eliminar datos de actividad económica");
		} finally {
			logger.logDebug(MessageManager.getString("PURPOSEMANAGER.002",
					"deleteAllPurposes"));
		}

	}

}
