/*
 * File: AccountingProfileManager.java
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

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.bo.AccountingProfileLog;
import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.model.AccountingProfile;
import com.cobiscorp.ecobis.fpm.model.AccountingProfileHistory;
import com.cobiscorp.ecobis.fpm.model.AccountingProfileId;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.portfolio.administration.service.IAccountingProfileManager;
import com.cobiscorp.ecobis.fpm.portfolio.catalogs.service.IPortfolioCatalogManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.service.utils.CatalogUtils;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

/**
 * This service allows you manage accounting profiles for a product.
 * 
 * @author bron
 */

public class AccountingProfileManager implements IAccountingProfileManager {

	public final ILogger logger = LogFactory
			.getLogger(AccountingProfileManager.class);

	private EntityManager entityManager;

	/** The banking product manager service */
	private IBankingProductManager bankingProductService;
	/** The portfolio catalog service */
	private IPortfolioCatalogManager portfolioCatalogService;

	/**
	 * Get the <tt>AccountingProfile</tt> List.
	 * 
	 * @param filterAccountingProfile
	 *            the accounting profile filter
	 * @return List of <tt>AccountingProfile</tt>
	 */
	public List<AccountingProfile> findAllAccountingProfile(
			AccountingProfileId filterAccountingProfile) {
		try {
			logger.logDebug(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.001", "FindAllAccountingProfile"));
			List<AccountingProfile> accProfileList = new ArrayList<AccountingProfile>();
			if (filterAccountingProfile.getFilialId() == null
					&& filterAccountingProfile.getTransactionTypeId() == null) {
				accProfileList = entityManager
						.createNamedQuery(
								"AccountingProfile.FindAllAccountingProfile",
								AccountingProfile.class)
						.setParameter("productId",
								filterAccountingProfile.getProductId())
						.getResultList();
			} else if (filterAccountingProfile.getFilialId() == null
					&& filterAccountingProfile.getTransactionTypeId() != null) {
				accProfileList = entityManager
						.createNamedQuery(
								"AccountingProfile.FindAccProfileByTransaction",
								AccountingProfile.class)
						.setParameter("productId",
								filterAccountingProfile.getProductId())
						.setParameter("transactionTypeId",
								filterAccountingProfile.getTransactionTypeId())
						.getResultList();
			} else if (filterAccountingProfile.getFilialId() != null
					&& filterAccountingProfile.getTransactionTypeId() == null) {
				accProfileList = entityManager
						.createNamedQuery(
								"AccountingProfile.FindAccProfileByFilial",
								AccountingProfile.class)
						.setParameter("productId",
								filterAccountingProfile.getProductId())
						.setParameter("filialId",
								filterAccountingProfile.getFilialId())
						.getResultList();
			} else {
				accProfileList = entityManager
						.createNamedQuery(
								"AccountingProfile.FindAccProfileByTranAndFilial",
								AccountingProfile.class)
						.setParameter("productId",
								filterAccountingProfile.getProductId())
						.setParameter("transactionTypeId",
								filterAccountingProfile.getTransactionTypeId())
						.setParameter("filialId",
								filterAccountingProfile.getFilialId())
						.getResultList();
			}
			return accProfileList;

		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("ACCOUNTINGPROFILEMANAGER.006"),
					ex);
			throw new BusinessException(6900042,
					"No se pudo obtener la información de perfiles contables.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.002", "FindAllAccountingProfile"));
		}
	}

	/**
	 * Update an Accounting Profile.
	 * 
	 * @param accountingProfile
	 *            the Accounting Profile to update.
	 */
	public void updateAccountingProfile(AccountingProfile accountingProfile) {
		try {
			logger.logDebug(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.001", "UpdateAccountingProfile"));
			AccountingProfile iAccProfile = entityManager.find(
					AccountingProfile.class,
					new AccountingProfileId(accountingProfile.getProductId(),
							accountingProfile.getTransactionTypeId(),
							accountingProfile.getFilialId()));
			iAccProfile.setProfileId(accountingProfile.getProfileId());
			entityManager.flush();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.004", accountingProfile), ex);
			throw new BusinessException(6900043,
					"No se pudo actualizar el perfil contable seleccionado");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.002", "UpdateAccountingProfile"));
		}
	}

	/**
	 * Insert an Accounting Profile.
	 * 
	 * @param accountingProfile
	 *            the accounting Profile to insert.
	 */
	public void insertAccountingProfile(AccountingProfile accountingProfile) {
		try {
			logger.logDebug(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.001", "InsertAccountingProfile"));
			entityManager.persist(accountingProfile);
			entityManager.flush();
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.007", accountingProfile), eee);
			throw new BusinessException(6900045,
					"No se pudo crear el perfil contable, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.003", accountingProfile), ex);
			throw new BusinessException(6900044,
					"No se pudo crear el perfil contable deseado");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.002", "InsertAccountingProfile"));
		}
	}

	/**
	 * Delete an Accounting Profile.
	 * 
	 * @param accountingProfile
	 *            the accounting Profile to delete.
	 */
	public void deleteAccountingProfile(AccountingProfile accountingProfile) {
		try {
			logger.logDebug(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.001", "DeleteAccountingProfile"));
			AccountingProfile iAccProfile = entityManager.find(
					AccountingProfile.class,
					new AccountingProfileId(accountingProfile.getProductId(),
							accountingProfile.getTransactionTypeId(),
							accountingProfile.getFilialId()));
			entityManager.remove(iAccProfile);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.005", accountingProfile), ex);
			throw new BusinessException(6900046,
					"No se pudo eliminar el perfil contable seleccionado");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.002", "DeleteAccountingProfile"));
		}
	}

	/**
	 * Create a history of accounting profile status
	 * 
	 * @param bankingProductHistoryId
	 */
	public void createAccountingProfileHistory(
			BankingProductHistory bankingProductHistoryId,
			String authorizationStatus) {

		try {
			BankingProductHistory bph = new BankingProductHistory();
			if (bankingProductHistoryId.getId() > 0) {
				logger.logDebug(MessageManager.getString(
						"ACCOUNTINGPROFILEMANAGER.001",
						"createAccountingProfileHistory"));

				bph = entityManager.find(BankingProductHistory.class,
						bankingProductHistoryId.getId());
				List<AccountingProfile> accountingProfile = new ArrayList<AccountingProfile>();
				accountingProfile = entityManager
						.createNamedQuery(
								"AccountingProfile.FindAllAccountingProfile",
								AccountingProfile.class)
						.setParameter("productId", bph.getProductId())
						.getResultList();
				for (AccountingProfile acp : accountingProfile) {
					AccountingProfileHistory accountingProfileHistory = new AccountingProfileHistory();
					accountingProfileHistory
							.setBankingProductHistory(new BankingProductHistory());
					accountingProfileHistory.getBankingProductHistory().setId(
							bph.getId());

					accountingProfileHistory.setTransactionTypeId(acp
							.getTransactionTypeId());
					accountingProfileHistory.setProfileId(acp.getProfileId());
					accountingProfileHistory.setFilialId(acp.getFilialId());
					accountingProfileHistory
							.setProcessDate(new SimpleDateFormat("MM/dd/yyyy")
									.parse(ContextManager.getContext()
											.getProcessDate()));

					entityManager.persist(accountingProfileHistory);
					entityManager.flush();

				}

			} else {
				throw new BusinessException(6900150,
						"No existe información historica del producto bancario");
			}

		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.007",
					"createAccountingProfileHistory"), eee);
			throw new BusinessException(6900150,
					"No se pudo crear  perfil contable en cuestion , puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(

			"ACCOUNTINGPROFILEMANAGER.003", "createAccountingProfileHistory"),
					ex);
			throw new BusinessException(6900149,
					"No se pudo crear el perfil contable deseado");

		} finally {

			logger.logDebug(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.002",
					"createAccountingProfileHistory"));

		}

	}

	/**
	 * Return all AccountingProfilesHistory available by the core
	 * 
	 * @param bankingProductHistoryId
	 *            <tt>The sequential of BankingProductHistory</tt>
	 * @return
	 */
	public List<AccountingProfileHistory> findAccountingProfileHistory(
			Long bankingProductHistory) {
		BankingProductHistory bph = new BankingProductHistory();
		try {

			bph = entityManager.find(BankingProductHistory.class,
					bankingProductHistory);
			if (bankingProductHistory == 0)
				throw new BusinessException(6900148,
						"No existe informacion histórica del producto bancario");

			logger.logDebug(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.001",
					"findAllAccountingProfileHistory"));
			List<AccountingProfileHistory> accProfileListHistory = new ArrayList<AccountingProfileHistory>();

			accProfileListHistory = entityManager
					.createNamedQuery(
							"AccountingProfileHistory.findAllAcountingProfileHistory",
							AccountingProfileHistory.class)
					.setParameter("productId", bph.getProductId())
					.setParameter("systemDateId", bph.getSystemDateId())
					.getResultList();

			return accProfileListHistory;
		} catch (Exception e) {

			logger.logError(
					MessageManager.getString("ACCOUNTINGPROFILEMANAGER.008"), e);
			throw new BusinessException(6900148,
					"No se pudo obtener la información del historico de perfiles contables.");

		} finally {

			logger.logDebug(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.002",
					"findAllAccountingProfileHistory"));

		}

	}

	/**
	 * Get the changes made in the accounting profiles
	 * 
	 * @param productId
	 *            <tt>BankingProduct</tt> identifier
	 */
	public Map<String, List<AccountingProfileLog>> getAccountingProfileChanges(
			String productId) {
		try {
			logger.logDebug(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.001",
					"getAccountingProfileChanges"));
			// Create the map with the changes
			Map<String, List<AccountingProfileLog>> changes = new HashMap<String, List<AccountingProfileLog>>();
			// Get the catalogs
			List<Catalog> subsidiaries = portfolioCatalogService
					.findAllSubsidiaries();
			List<Catalog> transactions = portfolioCatalogService
					.findAllTransactionType();
			List<Catalog> profiles = portfolioCatalogService.findAllProfiles();

			logger.logDebug("Catalogos de cartera encontrados filiales:"
					+ subsidiaries.size() + " transacciones: "
					+ transactions.size() + "perfiles:" + profiles.size());
			// Get the list of after accounting profiles from the intermediate
			// tables
			List<AccountingProfile> afterList = findAllAccountingProfile(new AccountingProfileId(
					productId, null, null));
			logger.logDebug("Lista de perfiles contables actuales: "
					+ afterList);
			// Create the after list to return
			List<AccountingProfileLog> afterListLog = new ArrayList<AccountingProfileLog>();
			for (AccountingProfile accountingProfile : afterList) {
				Catalog transaction = CatalogUtils.getFromCatalogList(
						transactions, accountingProfile.getTransactionTypeId());
				Catalog profile = CatalogUtils.getFromCatalogList(profiles,
						accountingProfile.getProfileId());
				Catalog subsidiary = CatalogUtils.getFromCatalogList(
						subsidiaries, accountingProfile.getFilialId()
								.toString());
				afterListLog.add(new AccountingProfileLog(
						transaction == null ? "" : transaction.getName(),
						profile == null ? "" : profile.getName(),
						subsidiary == null ? "" : subsidiary.getName()));
			}
			logger.logDebug("List de log de perfiles contables actuales: "
					+ afterListLog);
			// Set the after log list
			changes.put(Constants.AFTER_VALUE, afterListLog);
			// Find the latest banking product
			BankingProductHistory bph = bankingProductService
					.getLatestHistorical(productId);
			// return null if the before list is empty
			if (null == bph) {
				changes.put(Constants.BEFORE_VALUE,
						new ArrayList<AccountingProfileLog>());
				return changes;
			}
			if (0 == bph.getAccountingProfileHistories().size()) {
				changes.put(Constants.BEFORE_VALUE,
						new ArrayList<AccountingProfileLog>());
				return changes;
			}
			List<AccountingProfileLog> beforeListLog = buildAccountingProfileLog(
					bph, subsidiaries, transactions, profiles);
			logger.logDebug("List de log de perfiles contables anteriores: "
					+ beforeListLog);
			// Set the after log list
			changes.put(Constants.BEFORE_VALUE, beforeListLog);
			return changes;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("ACCOUNTINGPROFILEMANAGER.099"),
					ex);
			throw new BusinessException(6900149,
					"Ocurrio un error al obtener los cambios de los perfiles contables.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.002",
					"getAccountingProfileChanges"));
		}
	}

	/**
	 * Restore the AccountingProfile data from AccountingProfileHistory
	 * 
	 * @param bankinProductId
	 */

	public void restoreAccountingProfileFromHistory(String bankinProductId) {

		BankingProductHistory bankingProductHistory = new BankingProductHistory();
		BankingProduct bp = new BankingProduct();

		List<AccountingProfile> accountingProfileList = new ArrayList<AccountingProfile>();
		AccountingProfileId accountingProfileId = new AccountingProfileId();
		List<AccountingProfileHistory> accountingProfileHistory = new ArrayList<AccountingProfileHistory>();

		try {
			logger.logDebug(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.001",
					"restoreAccountingProfileFromHistory"));

			bp.setId(bankinProductId);

			bankingProductHistory = bankingProductService
					.getLatestHistorical(bankinProductId);

			accountingProfileId.setProductId(bankingProductHistory
					.getProductId());
			accountingProfileId.setTransactionTypeId(null);
			accountingProfileId.setFilialId(null);

			accountingProfileList = findAllAccountingProfile(accountingProfileId);

			for (AccountingProfile accountingProfile : accountingProfileList) {
				deleteAccountingProfile(accountingProfile);
			}

			bankingProductHistory.setId(bankingProductHistory.getId());

			accountingProfileHistory = findAccountingProfileHistory(bankingProductHistory
					.getId());

			for (AccountingProfileHistory accProfileHistory : accountingProfileHistory) {
				AccountingProfile accountingProfile = new AccountingProfile();
				accountingProfile.setBankingProduct(bp);
				accountingProfile.setProductId(accProfileHistory
						.getBankingProductHistory().getProductId());
				accountingProfile
						.setProfileId(accProfileHistory.getProfileId());
				accountingProfile.setTransactionTypeId(accProfileHistory
						.getTransactionTypeId());
				accountingProfile.setFilialId(accProfileHistory.getFilialId());

				insertAccountingProfile(accountingProfile);
			}
		} catch (Exception e) {

			logger.logError(
					MessageManager.getString("ACCOUNTINGPROFILEMANAGER.012"), e);

			throw new BusinessException(6900167,
					"No se pudo restaurar los perfiles contables desde su historico");
		} finally {

			logger.logDebug(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.002",
					"restoreAccountingProfileFromHistory"));
		}
	}

	/**
	 * Get the information related to the accounting profile history
	 * 
	 * @param bankingProductHistoryId
	 *            <tt>the sequential</tt> identifier of BankingProductHistory
	 * @return
	 */
	public List<AccountingProfileLog> getAccountingProfileHistoricalLog(
			Long bankingProductHistoryId) {
		try {
			logger.logDebug(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.001",
					"getAccountingProfileHistoricalLog"));
			BankingProductHistory bph = entityManager.find(
					BankingProductHistory.class, bankingProductHistoryId);
			if (null == bph) {
				throw new BusinessException(6900177,
						"No se encontro ningun historico del producto con la fecha indicada.");
			}
			return buildAccountingProfileLog(bph);
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("ACCOUNTINGPROFILEMANAGER.099"),
					ex);
			throw new BusinessException(
					6900174,
					"Ocurrio un error al obtener la información del historico de perfiles contables.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ACCOUNTINGPROFILEMANAGER.002",
					"getAccountingProfileHistoricalLog"));
		}
	}

	private List<AccountingProfileLog> buildAccountingProfileLog(
			BankingProductHistory bph) {
		// Get the catalogs
		List<Catalog> subsidiaries = portfolioCatalogService
				.findAllSubsidiaries();
		List<Catalog> transactions = portfolioCatalogService
				.findAllTransactionType();
		List<Catalog> profiles = portfolioCatalogService.findAllProfiles();

		logger.logDebug("Catalogos de cartera encontrados filiales:"
				+ subsidiaries.size() + " transacciones: "
				+ transactions.size() + "perfiles:" + profiles.size());
		// Get the list of after accounting profiles from the intermediate
		// tables
		List<AccountingProfile> afterList = findAllAccountingProfile(new AccountingProfileId(
				bph.getProductId(), null, null));
		logger.logDebug("Lista de perfiles contables actuales: " + afterList);
		return buildAccountingProfileLog(bph, subsidiaries, transactions,
				profiles);
	}

	private List<AccountingProfileLog> buildAccountingProfileLog(
			BankingProductHistory bph, List<Catalog> subsidiaries,
			List<Catalog> transactions, List<Catalog> profiles) {
		// Create the before list
		List<AccountingProfileLog> ListLog = new ArrayList<AccountingProfileLog>();
		for (AccountingProfileHistory apHistory : bph
				.getAccountingProfileHistories()) {
			Catalog transaction = CatalogUtils.getFromCatalogList(transactions,
					apHistory.getTransactionTypeId());
			Catalog profile = CatalogUtils.getFromCatalogList(profiles,
					apHistory.getProfileId());
			Catalog subsidiary = CatalogUtils.getFromCatalogList(subsidiaries,
					apHistory.getFilialId().toString());
			ListLog.add(new AccountingProfileLog(transaction == null ? ""
					: transaction.getName(), profile == null ? "" : profile
					.getName(), subsidiary == null ? "" : subsidiary.getName()));

		}
		return ListLog;
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
	 * Set the service injected by the container
	 * 
	 * @param bankingProductService
	 */
	public void setBankingProductService(
			IBankingProductManager bankingProductService) {
		this.bankingProductService = bankingProductService;
	}

	/**
	 * Set the service injected by the container
	 * 
	 * @param bankingProductService
	 */
	public void setPortfolioCatalogService(
			IPortfolioCatalogManager portfolioCatalogService) {
		this.portfolioCatalogService = portfolioCatalogService;
	}
}
