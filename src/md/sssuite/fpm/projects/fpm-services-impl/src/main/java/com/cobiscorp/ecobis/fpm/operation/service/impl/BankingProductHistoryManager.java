/*
 * File: BankingProductHistoryManager.java
 * Date: July 27, 2012
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
package com.cobiscorp.ecobis.fpm.operation.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.context.CobisContext;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.bo.AuthorizationLog;
import com.cobiscorp.ecobis.fpm.bo.BankingProductLog;
import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.bo.CurrencyProductLog;
import com.cobiscorp.ecobis.fpm.bo.ProductProcessLog;
import com.cobiscorp.ecobis.fpm.bo.ProductRuleLog;
import com.cobiscorp.ecobis.fpm.catalogs.service.ICatalogManager;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.CurrencyProductHistory;
import com.cobiscorp.ecobis.fpm.model.PolicyProductHistory;
import com.cobiscorp.ecobis.fpm.model.ProductProcessHistory;
import com.cobiscorp.ecobis.fpm.model.ProductRuleHistory;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductHistoryManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.service.utils.CatalogUtils;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

public class BankingProductHistoryManager implements
		IBankingProductHistoryManager {

	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(BankingProductHistoryManager.class);
	/** Entity Manager injected by the container */
	private EntityManager entityManager;
	/** Catalog service */
	private ICatalogManager catalogManager;

	/**
	 * Find all historical related to the banking product
	 * 
	 * @return List of <tt>BankingProductHistory</tt> found
	 */
	
	public List<BankingProductHistory> findAllBankingProductHistorical(
			String productId) {
		try {
			// log the method entry
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTHISTORYMANAGER.001",
					"findAllBankingProductHistorical"));
			return entityManager
					.createNamedQuery(
							"BankingProductHistory.FindAllByProductId",
							BankingProductHistory.class)
					.setParameter("productId", productId).getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager
					.getString("BANKINGPRODUCTHISTORYMANAGER.099"), ex);
			throw new BusinessException(6900170,
					"Ocurrio un error al obtener los historicos del producto.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTHISTORYMANAGER.002",
					"findAllBankingProductHistorical"));
		}
	}

	/**
	 * Find all historical related to the banking product given a status code
	 * 
	 * @return List of <tt>BankingProductHistory</tt> found
	 */
	
	public List<BankingProductHistory> findBankingProductHistoricalByStatus(
			String productId, String authorizationStatus, String processDate,
			String formatDate) {
		try {
			// log the method entry
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTHISTORYMANAGER.001",
					"findAllBankingProductHistorical"));
			logger.logDebug("processDate inicial-->" + processDate);
			String oldFormat = formatDate; // "yyyy/MM/dd HH:mm:ss"; //formato q viene del contenedor
			String newFormat = "MM/dd/yyyy HH:mm:ss"; //xq es el formato de la bdd
			SimpleDateFormat sdfOldFormat = new SimpleDateFormat(oldFormat);
			SimpleDateFormat sdfNewFormat = new SimpleDateFormat(newFormat);
			CobisContext CobisContext = (CobisContext) ContextManager
					.getContext();

			if (processDate != null && processDate.trim() != "") {

				String dateSearch = sdfNewFormat.format(sdfOldFormat
						.parse(processDate));

				Date datefind = new SimpleDateFormat("MM/dd/yyyy")
						.parse(dateSearch);

				logger.logDebug("PROCESSDATE " + datefind.toString());

				return entityManager
						.createNamedQuery(
								"BankingProductHistory.FindAllByProductIdAndStatus",
								BankingProductHistory.class)
						.setParameter("productId", productId)
						.setParameter("status", authorizationStatus)
						.setParameter("processDate", datefind).getResultList();
			} else {
				return new ArrayList<BankingProductHistory>();
			}
		} catch (Exception ex) {
			logger.logError(MessageManager
					.getString("BANKINGPRODUCTHISTORYMANAGER.099"), ex);
			throw new BusinessException(6900170,
					"Ocurrio un error al obtener los historicos del producto.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTHISTORYMANAGER.002",
					"findAllBankingProductHistorical"));
		}
	}

	public List<Date> findHistoricalProcessDateBySatus(String productId,
			String authorizationStatus) {

		try {
			// log the method entry

			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTHISTORYMANAGER.001",
					"findHistoricalProcessDateBySatus"));
			return entityManager
					.createNamedQuery(
							"BankingProductHistory.FindProcessDateByProductAndStatus",
							Date.class).setParameter("productId", productId)
					.setParameter("status", authorizationStatus)
					.getResultList();

		} catch (Exception ex) {
			logger.logError(MessageManager
					.getString("BANKINGPRODUCTHISTORYMANAGER.099"), ex);
			throw new BusinessException(6900170,
					"Ocurrio un error al obtener la fechas de proceso");
		} finally {
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTHISTORYMANAGER.002",
					"findHistoricalProcessDateBySatus"));
		}

	}

	/**
	 * Get the historical information given a historical Identifier
	 * 
	 * @param bankingProductHistory
	 *            <tt>BankingProductHistory</tt>
	 * @return The banking product log with the historical information
	 */
	
	public BankingProductLog getHistoricalLog(
			BankingProductHistory bankingProductHistory) {
		try {
			// log the method entry
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTHISTORYMANAGER.001", "getHistoricalLog"));

			BankingProductHistory bph = entityManager
					.createNamedQuery(
							"BankingProductHistory.FindBySystemDateAndProduct",
							BankingProductHistory.class)
					.setParameter("productId",
							bankingProductHistory.getProductId())
					.setParameter("systemDateId",
							bankingProductHistory.getSystemDateId())
					.getSingleResult();

			if (null == bph) {
				throw new BusinessException(6900177,
						"No se encontro ningun historico del producto con la fecha indicada."
								+ bankingProductHistory);
			}
			return buildHistoricalLog(bph);

		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"BANKINGPRODUCTHISTORYMANAGER.099", bankingProductHistory),
					ex);
			throw new BusinessException(
					6900171,
					"Ocurrio un error al obtener la información del historico del producto bancario.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTHISTORYMANAGER.002", "getHistoricalLog"));
		}
	}

	/**
	 * 
	 * @param bph
	 * @return
	 */
	private BankingProductLog buildHistoricalLog(BankingProductHistory bph) {
		// Get the catalogs
		logger.logDebug("Obteniendo catalogos de procesos");
		// Load the process catalogs
		List<Catalog> processCatalogs = catalogManager
				.getCatalogsByName(Constants.CATALOGS.PRODUCT_PROCESS);
		// Load the currencies
		logger.logDebug("Obteniendo catalogo de monedas");
		List<Catalog> currencies = catalogManager.getAllCurrencies();
		return buildHistoricalLog(bph, currencies, processCatalogs);
	}

	/**
	 * Construct the object that contains the log information of a historical
	 * banking product
	 * 
	 * @param bph
	 *            <tt>BankingProductHistory</tt> entity
	 * @return <tt>BankingProductLog</tt> instance
	 */
	private BankingProductLog buildHistoricalLog(BankingProductHistory bph,
			List<Catalog> currencies, List<Catalog> processCatalogs) {
		// Create the before banking product log
		BankingProductLog bpLog = new BankingProductLog(bph.getName(),
				bph.getDescription(), bph.getAvailable().equals(Constants.YES),
				bph.getStartDate(), bph.getExpirationDate(),
				bph.getSubstantiation());
		bpLog.setProcesses(new ArrayList<ProductProcessLog>());
		bpLog.setRules(new ArrayList<ProductRuleLog>());
		bpLog.setCurrencies(new ArrayList<CurrencyProductLog>());
		logger.logDebug("Se crea objeto log para before " + bpLog);
		// Set the process if exist
		if (null != bph.getProcessHistories()
				&& !bph.getProcessHistories().isEmpty()) {
			for (final ProductProcessHistory pp : bph.getProcessHistories()) {
				// Get the name for the process in the catalog list
				Catalog processCatalog = CatalogUtils.getFromCatalogList(
						processCatalogs, pp.getProcessId());
				// Create the product process after object
				bpLog.getProcesses()
						.add(new ProductProcessLog(processCatalog == null ? ""
								: processCatalog.getName(),
								pp.getProcessName(),
								pp.getGeneric() == null ? false : pp
										.getGeneric().equals(Constants.YES), pp
										.getIsNotGeneric() == null ? false : pp
										.getIsNotGeneric()
										.equals(Constants.YES), pp
										.getCreditLine() == null ? false : pp
										.getCreditLine().equals(Constants.YES)));
			}
			logger.logDebug("Se crea lista de procesos" + bpLog.getProcesses());

			// Set the rules if exist
			if (null != bph.getRulesHistories()
					&& !bph.getRulesHistories().isEmpty()) {
				for (final ProductRuleHistory pr : bph.getRulesHistories()) {

					bpLog.getRules()
							.add(new ProductRuleLog(pr.getRuleId(), pr
									.getRuleName()));
				}
				logger.logDebug("Se crea lista de reglas" + bpLog.getRules());
			}
		}

		// Set the currencies if exist
		if (bph.getCurrencyProductsHistory() != null
				&& !bph.getCurrencyProductsHistory().isEmpty()) {
			// For each currency
			for (final CurrencyProductHistory cp : bph
					.getCurrencyProductsHistory()) {
				// Only get the available currencies
				if (cp.getStatus().equals(Constants.NO)) {
					continue;
				}
				// Search the currency name
				Catalog currencyCatalog = CatalogUtils.getFromCatalogList(
						currencies, cp.getCurrencyId());
				// Create the after currency
				CurrencyProductLog cpLog = new CurrencyProductLog(
						currencyCatalog == null ? ""
								: currencyCatalog.getName());
				cpLog.setPolicies(new ArrayList<String>());
				// For each policy
				for (PolicyProductHistory policy : cp.getPoliciesProducts()) {
					// Add the policy name
					cpLog.getPolicies().add(policy.getPolicyName());
				}
				// Add the currency to the banking product list
				bpLog.getCurrencies().add(cpLog);
			}
			logger.logDebug("Se crea la lista de monedas "
					+ bpLog.getCurrencies());
		}
		// Create the authorization log
		bpLog.setAuthorization(new AuthorizationLog());
		bpLog.getAuthorization().setAuthorizationTerminal(
				bph.getAuthorizationHistory().getAuthorizationTerminal());
		bpLog.getAuthorization().setAuthorizationUserName(
				bph.getAuthorizationHistory().getAuthorizationUserName());
		bpLog.getAuthorization().setProcessId(
				bph.getAuthorizationHistory().getProcessId());
		bpLog.getAuthorization().setRequestTerminal(
				bph.getAuthorizationHistory().getRequestTerminal());
		bpLog.getAuthorization().setRequestUserName(
				bph.getAuthorizationHistory().getRequestUserName());

		return bpLog;
	}

	/**
	 * Get the historical information given a sequential
	 * 
	 * @param bankingProductHistoryId
	 *            <tt>sequential of BankingProductHistory</tt>
	 * @return The banking product historical information by sequential
	 */
	
	public BankingProductHistory getBankingProductHistoryById(
			Long bankingProductHistoryId) {
		BankingProductHistory bph = new BankingProductHistory();

		try {
			// log the method entry
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTHISTORYMANAGER.001",
					"getBankingProductHistoryById"));
			bph = entityManager
					.createNamedQuery("BankingProductHistory.FindBySequential",
							BankingProductHistory.class)
					.setParameter("id", bankingProductHistoryId)
					.getSingleResult();

			if (bph != null) {
				logger.logDebug("Historico Producto Bancario por secuencial"
						+ bph);

			} else {
				logger.logDebug("La busqueda del historico devolvio nullo"
						+ bph);

			}
			return bph;

		} catch (Exception ex) {
			logger.logError(MessageManager
					.getString("BANKINGPRODUCTHISTORYMANAGER.099"), ex);
			throw new BusinessException(6900170,
					"Ocurrio un error al obtener los historicos del basado en el secuencial.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTHISTORYMANAGER.002",
					"getBankingProductHistoryById"));
		}

	}

	/**
	 * Initialize the Entity Manager
	 * 
	 * @param em
	 *            Entity Manager
	 */
	@PersistenceContext(unitName = "JpaFpmAdministration")
	public void setEntityManager(EntityManager em) {
		this.entityManager = em;
	}

	/*
	 * Inject the instance for the ICatalogManager service
	 * 
	 * @param catalogManager instance injected
	 */
	public void setCatalogManager(ICatalogManager catalogManager) {
		this.catalogManager = catalogManager;
	}

}
