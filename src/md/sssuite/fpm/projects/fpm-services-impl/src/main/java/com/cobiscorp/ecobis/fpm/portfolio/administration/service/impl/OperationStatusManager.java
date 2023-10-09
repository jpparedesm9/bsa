package com.cobiscorp.ecobis.fpm.portfolio.administration.service.impl;

/*
 * File: OperationStatusManager.java
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
import com.cobiscorp.ecobis.fpm.bo.OperationStatusLog;
import com.cobiscorp.ecobis.fpm.catalogs.service.ICatalogManager;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;

import com.cobiscorp.ecobis.fpm.model.OperationStatus;
import com.cobiscorp.ecobis.fpm.model.OperationStatusHistory;
import com.cobiscorp.ecobis.fpm.model.OperationStatusId;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.portfolio.administration.service.IOperationStatusManager;
import com.cobiscorp.ecobis.fpm.portfolio.catalogs.service.IPortfolioCatalogManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.service.utils.CatalogUtils;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

/**
 * This service allows you manage OPeration Change Status for a product.
 * 
 * @author bron
 */

public class OperationStatusManager implements IOperationStatusManager {

	public final ILogger logger = LogFactory
			.getLogger(OperationStatusManager.class);

	private EntityManager entityManager;
	/** The banking product manager service */
	private IBankingProductManager bankingProductService;
	/** The portfolio catalog service */
	private IPortfolioCatalogManager portfolioCatalogService;
	/** The portfolio catalog service */
	private ICatalogManager catalogService;

	/**
	 * Get the <tt>OperationStatus</tt> List.
	 * 
	 * @param operationStatus
	 *            the Operation Status
	 * @return List of <tt>OperationStatus</tt>
	 */
	public List<OperationStatus> findOperationChangeStatus(
			OperationStatus operationStatus) {
		try {
			logger.logDebug(MessageManager.getString(
					"OPERATIONSTATUSMANAGER.001", "FindOperationChangeStatus"));
			List<OperationStatus> operStatusList = new ArrayList<OperationStatus>();
			operStatusList = entityManager
					.createNamedQuery(
							"OperationStatus.FindOperationChangeStatus",
							OperationStatus.class)
					.setParameter("productId", operationStatus.getProductId())
					.getResultList();
			return operStatusList;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("OPERATIONSTATUSMANAGER.006"), ex);
			throw new BusinessException(
					6900052,
					"No se pudo obtener la información de los estados de las operaciones asociada al producto");
		} finally {
			logger.logDebug(MessageManager.getString(
					"OPERATIONSTATUSMANAGER.002", "FindOperationChangeStatus"));
		}
	}

	/**
	 * Update an Operation Status.
	 * 
	 * @param operationStatus
	 *            the Operation Status to update.
	 */
	public void updateOperationChangeStatus(OperationStatus operationStatus) {
		try {
			logger.logDebug(MessageManager
					.getString("OPERATIONSTATUSMANAGER.001",
							"UpdateOperationChangeStatus"));

			if (validateUpdateOpStatus(operationStatus))
				throw new BusinessException(710080,
						"Rango de dias corresponde a un rango ya existente.");
			else {
				OperationStatus ioperStatus = entityManager.find(
						OperationStatus.class,
						new OperationStatusId(operationStatus.getProductId(),
								operationStatus.getChangeType(),
								operationStatus.getInitialStatusId(),
								operationStatus.getFinalStatusId()));
				ioperStatus.setStartDays(operationStatus.getStartDays());
				ioperStatus.setFinishDays(operationStatus.getFinishDays());
				entityManager.flush();
			}
		} catch (BusinessException be) {
			logger.logError(MessageManager.getString(
					"OPERATIONSTATUSMANAGER.004", operationStatus), be);
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"OPERATIONSTATUSMANAGER.004", operationStatus), ex);
			throw new BusinessException(6900053,
					"No se pudo actualizar el estado de la operación seleccionada");
		} finally {
			logger.logDebug(MessageManager
					.getString("OPERATIONSTATUSMANAGER.002",
							"UpdateOperationChangeStatus"));
		}

	}

	/**
	 * Insert an Operation Status
	 * 
	 * @param operationStatus
	 *            the Operation Status to insert.
	 */
	public void insertOperationChangeStatus(OperationStatus operationStatus) {
		try {
			logger.logDebug(MessageManager
					.getString("OPERATIONSTATUSMANAGER.001",
							"InsertOperationChangeStatus"));
			if (!operationStatus.getChangeType().equals("M"))
				operationStatus.setFinalStatusId(operationStatus
						.getInitialStatusId());

			if (validateInsertOpStatus(operationStatus))
				throw new BusinessException(710015,
						"Ya existe un cambio para el estado inicial.");
			else if (validateInsertOpStatusDays(operationStatus))
				throw new BusinessException(710080,
						"Rango de dias corresponde a un rango ya existente.");
			else {
				entityManager.persist(operationStatus);
				entityManager.flush();
			}
		} catch (BusinessException be) {
			logger.logError(MessageManager.getString(
					"OPERATIONSTATUSMANAGER.003", operationStatus), be);
			throw be;
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString(
					"OPERATIONSTATUSMANAGER.007", operationStatus), eee);
			throw new BusinessException(6900055,
					"No se pudo crear los estados para la operación, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"OPERATIONSTATUSMANAGER.003", operationStatus), ex);
			throw new BusinessException(6900054,
					"No se pudo crear los estados para la operación deseada");
		} finally {
			logger.logDebug(MessageManager
					.getString("OPERATIONSTATUSMANAGER.002",
							"InsertOperationChangeStatus"));
		}
	}

	/**
	 * Delete an Operation Status
	 * 
	 * @param operationStatus
	 *            the Operation Status to delete.
	 */
	public void deleteOperationChangeStatus(OperationStatus operationStatus) {
		try {
			logger.logDebug(MessageManager
					.getString("OPERATIONSTATUSMANAGER.001",
							"DeleteOperationChangeStatus"));
			OperationStatus ioperStatus = entityManager.find(
					OperationStatus.class,
					new OperationStatusId(operationStatus.getProductId(),
							operationStatus.getChangeType(), operationStatus
									.getInitialStatusId(), operationStatus
									.getFinalStatusId()));
			entityManager.remove(ioperStatus);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"OPERATIONSTATUSMANAGER.005", operationStatus), ex);
			throw new BusinessException(6900056,
					"No se pudo eliminar la operación seleccionada");
		} finally {
			logger.logDebug(MessageManager
					.getString("OPERATIONSTATUSMANAGER.002",
							"DeleteOperationChangeStatus"));
		}
	}


	/**
	 * Return OperationStatusHistory available by the core
	 * @param bankingProductHistoryId <tt>the sequential identifier of BankingProductHistory</tt>
	 * @return List of<tt>OpeationStatusHistory</tt>
	 */
	public List<OperationStatusHistory> findOperationChangeStatusHistory(
			Long bankingProductHistoryId) {

		BankingProductHistory bphistory=new BankingProductHistory();
		try {
			logger.logDebug(MessageManager.getString(
					"OPERATIONSTATUSMANAGER.001",
					"findOperationChangeStatusHistory"));
			bphistory=entityManager.find(BankingProductHistory.class, bankingProductHistoryId);
			
			List<OperationStatusHistory> operStatusList = new ArrayList<OperationStatusHistory>();
			operStatusList = entityManager
					.createNamedQuery(
							"OperationStatus.FindOperationChangeStatusHistory",
							OperationStatusHistory.class)
					.setParameter("productId",
							bphistory.getProductId())
					.setParameter("id",
							bankingProductService.getLatestHistorical(bphistory.getProductId()).getId())
					.getResultList();
			return operStatusList;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("OPERATIONSTATUSMANAGER.008"), ex);
			throw new BusinessException(
					6900161,
					"No se pudo obtener la información de los estados de las operaciones asociada al producto");
		} finally {
			logger.logDebug(MessageManager.getString(
					"OPERATIONSTATUSMANAGER.002",
					"findOperationChangeStatusHistory"));
		}

	}

	/**
	 * Create operation status history
	 * @param bankingProductHistoryId <tt>the sequential identifier of BankingProductHistory</tt>
	 * @param authorizationStatus <tt>the authorization status for  BankingProductHistory</tt>
	 */
	public void createOperationStatusHistory(
			BankingProductHistory bankingProductHistoryId,
			String authorizationStatus) {
		BankingProductHistory bphistory=new BankingProductHistory();
		try {

			
			logger.logDebug(MessageManager.getString(
					"OPERATIONSTATUSMANAGER.001",
					"createOperationStatusHistory"));
			bphistory=entityManager.find(BankingProductHistory.class, bankingProductHistoryId.getId());

			List<OperationStatus> operStatusList = new ArrayList<OperationStatus>();
			operStatusList = entityManager
					.createNamedQuery(
							"OperationStatus.FindOperationChangeStatus",
							OperationStatus.class)
					.setParameter("productId",
							bphistory.getProductId())
					.getResultList();
			for (OperationStatus statusItem : operStatusList) {

				OperationStatusHistory operSatusHistory = new OperationStatusHistory();
				operSatusHistory
						.setBankingProductHistory(new BankingProductHistory());
				operSatusHistory.getBankingProductHistory().setId(bphistory.getId());
				operSatusHistory.setChangeType(statusItem.getChangeType());
				operSatusHistory.setInitialStatusId(statusItem
						.getInitialStatusId());
				operSatusHistory
						.setFinalStatusId(statusItem.getFinalStatusId());
				operSatusHistory.setStartDays(statusItem.getStartDays());
				operSatusHistory.setFinishDays(statusItem.getFinishDays());
				operSatusHistory.setProcessDate(new SimpleDateFormat(
						"MM/dd/yyyy").parse(ContextManager.getContext()
						.getProcessDate()));

				entityManager.persist(operSatusHistory);
				entityManager.flush();

			}

		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString(
					"OPERATIONSTATUSMANAGER.007", bphistory), eee);
			throw new BusinessException(6900055,
					"No se pudo crear los estados para la operación, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"OPERATIONSTATUSMANAGER.003", bphistory), ex);
			throw new BusinessException(6900054,
					"No se pudo crear los estados para la operación deseada");
		} finally {
			logger.logDebug(MessageManager.getString(
					"OPERATIONSTATUSMANAGER.002",
					"createOperationStatusHistory"));
		}

	}

	/**
	 * Get the changes made in the operation change status
	 * 
	 * @param productId
	 *            <tt>BankingProduct</tt> identifier
	 */
	public Map<String, List<OperationStatusLog>> getOperationStatusChanges(
			String productId) {
		try {
			logger.logDebug(MessageManager.getString(
					"OPERATIONSTATUSMANAGER.001", "getOperationStatusChanges"));
			// Create the map with the changes
			Map<String, List<OperationStatusLog>> changes = new HashMap<String, List<OperationStatusLog>>();
			// Get the catalogs
			List<Catalog> statusList = portfolioCatalogService.findAllStatus();
			List<Catalog> changeTypes = catalogService
					.getCatalogsByName(Constants.CATALOGS.CHANGE_OPERATION_TYPE);
			logger.logDebug("Catalogos de cartera encontrados estados:"
					+ statusList.size());
			logger.logDebug("Catalogos de cambio de operaciones : "
					+ changeTypes.size());
			// Get the list of after operation status from the intermediate
			// tables
			OperationStatus filter = new OperationStatus();
			filter.setProductId(productId);
			List<OperationStatus> afterList = findOperationChangeStatus(filter);
			logger.logDebug("Lista de estados de operaciones actuales: "
					+ afterList);
			// Create the after list to return
			List<OperationStatusLog> afterListLog = new ArrayList<OperationStatusLog>();
			for (OperationStatus operationStatus : afterList) {
				Catalog initialStatus = CatalogUtils.getFromCatalogList(
						statusList,
						String.valueOf(operationStatus.getInitialStatusId()));
				Catalog finalStatus = CatalogUtils.getFromCatalogList(
						statusList,
						String.valueOf(operationStatus.getFinalStatusId()));
				Catalog changeType = CatalogUtils.getFromCatalogList(
						changeTypes, operationStatus.getChangeType());
				afterListLog.add(new OperationStatusLog(changeType == null ? ""
						: changeType.getName(), initialStatus == null ? ""
						: initialStatus.getName(), finalStatus == null ? ""
						: finalStatus.getName(),
						operationStatus.getStartDays(), operationStatus
								.getFinishDays()));
			}
			logger.logDebug("List de log de estados de operaciones actuales: "
					+ afterListLog);
			// Set the after log list
			changes.put(Constants.AFTER_VALUE, afterListLog);
			// Find the latest banking product
			BankingProductHistory bph = bankingProductService
					.getLatestHistorical(productId);
			// return null if the before list is empty
			if (null == bph) {
				changes.put(Constants.BEFORE_VALUE,
						new ArrayList<OperationStatusLog>());
				return changes;
			}
			if (0 == bph.getOperationStatusHistories().size()) {
				changes.put(Constants.BEFORE_VALUE,
						new ArrayList<OperationStatusLog>());
				return changes;
			}
			// Create the before list
			List<OperationStatusLog> beforeListLog = buildOperationStatusLog(
					bph, statusList, changeTypes);
			logger.logDebug("List de log de estados de operaciones anteriores: "
					+ beforeListLog);
			// Set the after log list
			changes.put(Constants.BEFORE_VALUE, beforeListLog);
			return changes;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("OPERATIONSTATUSMANAGER.099"), ex);
			throw new BusinessException(6900151,
					"Ocurrio un error al obtener los cambios de los estados de operaciones.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"OPERATIONSTATUSMANAGER.002", "getOperationStatusChanges"));
		}
	}

	/**
	 * Restore OperationStatus data from OperationStatusHistory
	 * 
	 * @param bankingProductId
	 */
	public void restoreOperationStatusFromHistory(String bankingProductId) {
		BankingProduct bp = new BankingProduct();
		BankingProductHistory bankingProductHistory = new BankingProductHistory();
		

		List<OperationStatus> operationStatusList = new ArrayList<OperationStatus>();
		OperationStatus operationStatus = new OperationStatus();

		try {
			logger.logDebug(MessageManager.getString(
					"OPERATIONSTATUSMANAGER.001",
					"restoreOperationStatusFromHistory"));

			bankingProductHistory = bankingProductService
					.getLatestHistorical(bankingProductId);

			bp.setId(bankingProductId);
			
			operationStatus.setBankingProduct(bp);
			operationStatus.setProductId(bankingProductId);
			operationStatusList = findOperationChangeStatus(operationStatus);

			for (OperationStatus opStatus : operationStatusList) {
				deleteOperationChangeStatus(opStatus);
			}

			List<OperationStatusHistory> opsHistory = new ArrayList<OperationStatusHistory>();

			
			bankingProductHistory.setProductId(bankingProductHistory
					.getProductId());
			bankingProductHistory.setSystemDateId(bankingProductHistory
					.getSystemDateId());

			opsHistory = findOperationChangeStatusHistory(bankingProductHistory.getId());
			

			for (OperationStatusHistory opeStatusHistory : opsHistory) {
				OperationStatus opStatus = new OperationStatus();
				opStatus.setBankingProduct(bp);
				opStatus.setChangeType(opeStatusHistory.getChangeType());
				opStatus.setFinalStatusId(opeStatusHistory.getFinalStatusId());
				opStatus.setFinishDays(opeStatusHistory.getFinishDays());
				opStatus.setInitialStatusId(opeStatusHistory
						.getInitialStatusId());
				opStatus.setProductId(bankingProductId);
				opStatus.setStartDays(opeStatusHistory.getStartDays());
				insertOperationChangeStatus(opStatus);
			}
		} catch (Exception e) {
			logger.logError(
					MessageManager.getString("OPERATIONSTATUSMANAGER.009"), e);
			throw new BusinessException(6900169,
					"No se pudo restaurar los estados de las operaciones  desde su historico");
		} finally {

			logger.logDebug(MessageManager.getString("ITEMSTATUSMANAGER.002",
					"restoreOperationStatusFromHistory"));
		}
	}

	/**
	 * Get the information related to the operation status history
	 * @param bankingProductHistoryId <tt>the sequential identifier of BankingProductHistory</tt>
	 * @return
	 */
	public List<OperationStatusLog> getOperationStatusHistoricalLog(
			Long bankingProductHistoryId) {
		try {
			logger.logDebug(MessageManager.getString(
					"OPERATIONSTATUSMANAGER.001",
					"getAccountingProfileHistoricalLog"));
			BankingProductHistory bph = entityManager.find(
					BankingProductHistory.class, bankingProductHistoryId);
			if (null == bph) {
				throw new BusinessException(6900177,
						"No se encontro ningun historico del producto con la fecha indicada.");
			}
			return buildOperationStatusLog(bph);
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("OPERATIONSTATUSMANAGER.099"), ex);
			throw new BusinessException(
					6900175,
					"Ocurrio un error al obtener la información del historico de estado de operaciones.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"OPERATIONSTATUSMANAGER.002",
					"getAccountingProfileHistoricalLog"));
		}
	}

	private List<OperationStatusLog> buildOperationStatusLog(
			BankingProductHistory bph) {
		// Get the catalogs
		List<Catalog> statusList = portfolioCatalogService.findAllStatus();
		List<Catalog> changeTypes = catalogService
				.getCatalogsByName(Constants.CATALOGS.CHANGE_OPERATION_TYPE);
		logger.logDebug("Catalogos de cartera encontrados estados:"
				+ statusList.size());
		logger.logDebug("Catalogos de cambio de operaciones : "
				+ changeTypes.size());
		return buildOperationStatusLog(bph, statusList, changeTypes);
	}

	private List<OperationStatusLog> buildOperationStatusLog(
			BankingProductHistory bph, List<Catalog> statusList,
			List<Catalog> changeTypes) {
		List<OperationStatusLog> beforeListLog = new ArrayList<OperationStatusLog>();
		for (OperationStatusHistory oHistory : bph
				.getOperationStatusHistories()) {
			Catalog initialStatus = CatalogUtils.getFromCatalogList(statusList,
					String.valueOf(oHistory.getInitialStatusId()));
			Catalog finalStatus = CatalogUtils.getFromCatalogList(statusList,
					String.valueOf(oHistory.getFinalStatusId()));
			Catalog changeType = CatalogUtils.getFromCatalogList(changeTypes,
					oHistory.getChangeType());
			beforeListLog.add(new OperationStatusLog(changeType == null ? ""
					: changeType.getName(), initialStatus == null ? ""
					: initialStatus.getName(), finalStatus == null ? ""
					: finalStatus.getName(), oHistory.getStartDays(), oHistory
					.getFinishDays()));
		}
		return beforeListLog;
	}

	/**
	 * Validate data before insert an OperationStatus
	 * 
	 * @param itemstatus
	 * @return
	 */
	private boolean validateInsertOpStatus(OperationStatus operationStatus) {
		logger.logDebug(MessageManager.getString("OPERATIONSTATUSMANAGER.001",
				"validateInsertOpStatus"));

		List<OperationStatus> opStatusList = new ArrayList<OperationStatus>();
		opStatusList = entityManager
				.createNamedQuery("OperationStatus.ValidateInsertOpStatus",
						OperationStatus.class)
				.setParameter("productId", operationStatus.getProductId())
				.setParameter("initialStatusId",
						operationStatus.getInitialStatusId())
				.setParameter("changeType", operationStatus.getChangeType())
				.getResultList();

		return (!operationStatus.getChangeType().equals("M") && opStatusList
				.size() > 0);

	}

	/**
	 * Second validation before insert an OperationStatus
	 * 
	 * @param itemstatus
	 * @return
	 */
	private boolean validateInsertOpStatusDays(OperationStatus operationStatus) {
		logger.logDebug(MessageManager.getString("OPERATIONSTATUSMANAGER.001",
				"validateInsertOpStatusDays"));

		List<OperationStatus> opStatusList = new ArrayList<OperationStatus>();
		opStatusList = entityManager
				.createNamedQuery("OperationStatus.ValidateInsertOpStatusDays",
						OperationStatus.class)
				.setParameter("productId", operationStatus.getProductId())
				.setParameter("changeType", operationStatus.getChangeType())
				.setParameter("startDays", operationStatus.getStartDays())
				.setParameter("finishDays", operationStatus.getFinishDays())
				.getResultList();

		return (!operationStatus.getChangeType().equals("M") && opStatusList
				.size() > 0);

	}

	/**
	 * Validate data before update an OperationStatus
	 * 
	 * @param itemstatus
	 * @return
	 */
	private boolean validateUpdateOpStatus(OperationStatus operationStatus) {
		logger.logDebug(MessageManager.getString("OPERATIONSTATUSMANAGER.001",
				"validateUpdateOpStatus"));

		List<OperationStatus> opStatusList = new ArrayList<OperationStatus>();
		opStatusList = entityManager
				.createNamedQuery("OperationStatus.ValidateUpdateOpStatus",
						OperationStatus.class)
				.setParameter("productId", operationStatus.getProductId())
				.setParameter("changeType", operationStatus.getChangeType())
				.setParameter("initialStatusId",
						operationStatus.getInitialStatusId())
				.setParameter("finalStatusId",
						operationStatus.getFinalStatusId())
				.setParameter("startDays", operationStatus.getStartDays())
				.setParameter("finishDays", operationStatus.getFinishDays())
				.getResultList();

		return (!operationStatus.getChangeType().equals("M") && opStatusList
				.size() > 0);
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
	 * @param portfolioCatalogService
	 */
	public void setPortfolioCatalogService(
			IPortfolioCatalogManager portfolioCatalogService) {
		this.portfolioCatalogService = portfolioCatalogService;
	}

	/**
	 * Set the service injected by the container
	 * 
	 * @param catalogService
	 */
	public void setCatalogService(ICatalogManager catalogService) {
		this.catalogService = catalogService;
	}

}
