package com.cobiscorp.ecobis.fpm.portfolio.administration.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.bo.CatalogConstraintLog;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.CatalogConstraintHistory;
import com.cobiscorp.ecobis.fpm.model.EconomicDestination;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.portfolio.administration.service.IEconomicDestinationManager;
import com.cobiscorp.ecobis.fpm.portfolio.catalogs.service.IPortfolioCatalogManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.service.utils.CatalogUtils;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

public class EconomicDestinationManager implements IEconomicDestinationManager {

	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(EconomicDestinationManager.class);

	/** Entity Manager injected by the container */
	private EntityManager entityManager;

	/** The catalog portfolio service */
	private IPortfolioCatalogManager portfolioCatalogService;
	/** The banking product manager service */
	private IBankingProductManager bankingProductService;

	/**
	 * Method for create a Economic Destination
	 * 
	 * @param destination
	 * @param operation
	 */
	
	public Long createEconomicDestination(EconomicDestination destination) {
		try {
			logger.logDebug(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.001",
					"createEconomicDestination"));

			// The id must be null to JPA insert the sequential id number
			if (destination.getId() != null) {
				destination.setId(null);
			}
			entityManager.persist(destination);
			entityManager.flush();
			return destination.getId();
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("ECONOMICDESTINATIONMANAGER.099"),
					ex);
			throw new BusinessException(6900198,
					"No se pudo crear el destino económico del producto bancario indicado");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.002",
					"createEconomicDestination"));
		}
	}

	/**
	 * Delete a Economic Destination given the identifier
	 * 
	 * @param id
	 */
	
	public void deleteEconomicDestination(Long id) {
		try {
			logger.logDebug(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.001",
					"deleteEconomicDestination"));
			EconomicDestination ecoDestination = entityManager.find(
					EconomicDestination.class, id);
			entityManager.remove(ecoDestination);
			entityManager.flush();
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("ECONOMICDESTINATIONMANAGER.099"),
					ex);
			throw new BusinessException(6900202,
					"No se pudo eliminar el destino económico del producto bancario indicado");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.002",
					"deleteEconomicDestination"));
		}
	}

	/**
	 * Method for get Destination
	 * 
	 * @param productId
	 */
	
	public List<EconomicDestination> getEconomicDestinations(String productId) {
		try {
			logger.logDebug(MessageManager
					.getString("ECONOMICDESTINATIONMANAGER.001",
							"getEconomicDestinations"));
			return entityManager
					.createNamedQuery(
							"EconomicDestination.findDestinationByProductId",
							EconomicDestination.class)
					.setParameter("productId", productId).getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.099", productId), ex);
			throw new BusinessException(6900198,
					"No se pudo encontrar el destino económico del producto bancario indicado");
		} finally {
			logger.logDebug(MessageManager
					.getString("ECONOMICDESTINATIONMANAGER.002",
							"getEconomicDestinations"));
		}
	}

	/**
	 * Method for insert destination or purpose in historic
	 * 
	 * @param bankingProductHistoryId
	 *            <tt> the sequential identifier of BankingProductHistory
	 * @param authorizationStatus
	 */

	
	public void createEconomicDestinationHistory(
			BankingProductHistory bankingProductHistoryId,
			String authorizationStatus) {

		try {
			BankingProductHistory bphistory = new BankingProductHistory();
			logger.logDebug(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.001",
					"createEconomicDestinationHistory"));
			bphistory = entityManager.find(BankingProductHistory.class,
					bankingProductHistoryId.getId());

			// Get all the economic destinations
			List<EconomicDestination> destinations = getEconomicDestinations(bphistory
					.getProductId());
			for (EconomicDestination destination : destinations) {
				// Create the history object to persist

				CatalogConstraintHistory history = new CatalogConstraintHistory();
				// Set the related banking product history

				history.setBankingProductHistory(new BankingProductHistory());
				history.getBankingProductHistory().setId(bphistory.getId());
				history.setCode(destination.getCode());
				history.setType(destination.getType());
				history.setProcessDate(new SimpleDateFormat(
						Constants.PROCESS_DATE_FORMAT).parse(ContextManager
						.getContext().getProcessDate()));
				entityManager.persist(history);
			}
			entityManager.flush();
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.099",
					"createEconomicDestinationHistory"), eee);
			throw new BusinessException(
					6900202,
					"No se pudo crear la información histórica de los destinos del producto indicado");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(

			"ECONOMICDESTINATIONMANAGER.002",
					"createEconomicDestinationHistory"), ex);
			throw new BusinessException(
					6900202,
					"No se pudo crear la información histórica de los destinos del producto indicado");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.002",
					"createEconomicDestinationHistory"));
		}
	}

	/**
	 * Restore the economic destination information from the historical data
	 * given the banking product history identifier
	 * 
	 * @param bankingProductHistory
	 *            <tt>BankingProductHistory</tt> identifier
	 */
	public void restoreEconomicDestinationFromHistory(Long bankingProductHistory) {
		try {
			logger.logDebug(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.001",
					"restoreEconomicDestinationFromHistory"));
			BankingProductHistory bph = new BankingProductHistory();
			bph = entityManager.find(BankingProductHistory.class,
					bankingProductHistory);

			List<CatalogConstraintHistory> histories = getHistoricalEconomicaDestinations(bph);
			for (CatalogConstraintHistory history : histories) {
				EconomicDestination destination = new EconomicDestination();
				destination.setBankingProduct(new BankingProduct());
				destination.getBankingProduct().setId(bph.getProductId());
				destination.setCode(history.getCode());
				entityManager.persist(destination);
			}
			entityManager.flush();
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.099",
					"restoreEconomicDestinationFromHistory"), eee);
			throw new BusinessException(
					6900204,
					"No se pudo restaurar la información de los destino económicos del producto indicado");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(

			"ECONOMICDESTINATIONMANAGER.002",
					"restoreEconomicDestinationFromHistory"), ex);
			throw new BusinessException(
					6900204,
					"No se pudo restaurar la información de los destino económicos del producto indicado");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.002",
					"restoreEconomicDestinationFromHistory"));
		}
	}

	/**
	 * Get the latest historical log for Economic Destination information
	 * 
	 * @param bankingProductHistoryId
	 *            <tt>The sequential identifier of BankingProductHistory</tt>
	 * @return The business object with the Economic Destination log
	 */
	
	public List<CatalogConstraintLog> getEconomicDestinationHistoricalLog(
			Long bankingProductHistoryId) {
		try {
			logger.logDebug(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.001",
					"getEconomicDestinationHistoricalLog"));
			BankingProductHistory bph = entityManager.find(
					BankingProductHistory.class, bankingProductHistoryId);
			if (null == bph) {
				throw new BusinessException(6900177,
						"No se encontro ningun historico del producto con la fecha indicada.");
			}
			// Get the latest historical
			List<CatalogConstraintHistory> histories = getHistoricalEconomicaDestinations(bph);
			// Get the economic destinations catalog
			List<Catalog> catalogs = portfolioCatalogService
					.findAllEconomicDestinations();
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
			logger.logError(
					MessageManager.getString("ECONOMICDESTINATIONMANAGER.099"),
					ex);
			throw new BusinessException(
					6900205,
					"Ocurrio un error al obtener la información del historico de destinos económicos.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.002",
					"getEconomicDestinationHistoricalLog"));
		}
	}

	/**
	 * Get the economic destination changes for the banking product given
	 * 
	 * @param productId
	 *            <tt>The banking product id</tt>
	 * @return Map with the before and after values
	 */
	
	public Map<String, List<CatalogConstraintLog>> getEconomicDestinationChanges(
			String productId) {
		try {
			logger.logDebug(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.001",
					"getEconomicDestinationChanges"));
			// Create the map for the changes
			Map<String, List<CatalogConstraintLog>> changes = new HashMap<String, List<CatalogConstraintLog>>();
			// Get the economic destinations
			List<EconomicDestination> destinations = getEconomicDestinations(productId);
			// Get the economic destinations catalog
			List<Catalog> catalogs = portfolioCatalogService
					.findAllEconomicDestinations();
			// Create the return list
			List<CatalogConstraintLog> logs = new ArrayList<CatalogConstraintLog>();
			for (EconomicDestination history : destinations) {
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
					getEconomicDestinationHistoricalLog(bph.getId()));
			return changes;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("ECONOMICDESTINATIONMANAGER.099"),
					ex);
			throw new BusinessException(6900206,
					"Ocurrio un error al obtener los cambios de los destinos económicos.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.002",
					"getEconomicDestinationChanges"));
		}
	}

	/**
	 * Check if is complete the configuration required for the banking product
	 * 
	 * @param productId
	 *            <tt>BankingProduct</tt> identifier
	 * @return True or False
	 */
	
	public Boolean checkEconomicDestinationConfigurationComplete(
			String productId) {
		try {
			logger.logDebug(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.001",
					"checkEconomicDestinationConfigurationComplete"));
			return entityManager
					.createNamedQuery(
							"EconomicDestination.countDestinationByProductId",
							Long.class).setParameter("productId", productId)
					.getSingleResult() > 0;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.099", productId), ex);
			throw new BusinessException(6900203,
					"No se pudo encontrar el destino económico del producto bancario indicado");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.002",
					"checkEconomicDestinationConfigurationComplete"));
		}
	}

	private List<CatalogConstraintHistory> getHistoricalEconomicaDestinations(
			BankingProductHistory bankingProductHistory) {
		// Find all the economic destination history
		return entityManager
				.createNamedQuery(
						"CatalogConstraintHistory.getEconomicDestinationByHistoyId",
						CatalogConstraintHistory.class)
				.setParameter("id", bankingProductHistory.getId())
				.getResultList();

	}

	
	public void createEconomicDestinationList(
			ArrayList<String> destinationList,
			String bankingProductID) {
		// TODO Auto-generated method stub
		try {
			logger.logDebug(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.001",
					"createEconomicDestinationList"));
			deleteAllEconomicDestination(bankingProductID);
			BankingProduct bp = bankingProductService
					.getBankingProductById(bankingProductID);

			if (destinationList != null && destinationList.size() > 0) {
				for (String destination : destinationList) {
					EconomicDestination ed = new EconomicDestination();					
					ed.setBankingProduct(bp);
					ed.setCode(destination);
					createEconomicDestination(ed);
				}
			}
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("ECONOMICDESTINATIONMANAGER.099"),
					ex);
			throw new BusinessException(6900198,
					"No se pudo crear la naturaleza de gasto del producto bancario indicado");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.002",
					"createEconomicDestinationList"));
		}
	}

	private void deleteAllEconomicDestination(String bankingProductId) {
		try {
			logger.logDebug(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.001",
					"deleteAllEconomicDestination"));
			List<EconomicDestination> economicDestination = getEconomicDestinations(bankingProductId);
			if (economicDestination != null && economicDestination.size() > 0) {
				for (EconomicDestination ecoDestination : economicDestination) {
					entityManager.remove(ecoDestination);
				}
				entityManager.flush();
			}
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("ECONOMICDESTINATIONMANAGER.099"),
					ex);
			throw new BusinessException(6900198,
					"No se eliminar datos de naturaleza del gasto");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ECONOMICDESTINATIONMANAGER.002",
					"deleteAllEconomicDestination"));
		}

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

}
