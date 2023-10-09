/*
 * File: ItemStatusManager.java
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
import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.bo.ItemStatusLog;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.Item;
import com.cobiscorp.ecobis.fpm.model.ItemByProduct;
import com.cobiscorp.ecobis.fpm.model.ItemByProductId;
import com.cobiscorp.ecobis.fpm.model.ItemStatus;
import com.cobiscorp.ecobis.fpm.model.ItemStatusHistory;
import com.cobiscorp.ecobis.fpm.model.ItemStatusId;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.operation.service.IItemsManager;
import com.cobiscorp.ecobis.fpm.portfolio.administration.service.IItemStatusManager;
import com.cobiscorp.ecobis.fpm.portfolio.catalogs.service.IPortfolioCatalogManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.service.utils.CatalogUtils;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

/**
 * This service allows you manage all the items status for a product.
 * 
 * @author bron
 */

public class ItemStatusManager implements IItemStatusManager {

	public final ILogger logger = LogFactory.getLogger(ItemStatusManager.class);

	private EntityManager entityManager;
	/** The banking product manager service */
	private IBankingProductManager bankingProductService;
	/** The portfolio catalog service */
	private IPortfolioCatalogManager portfolioCatalogService;
	/** The item manager service */
	private IItemsManager itemService;

	/**
	 * Get the <tt>ItemStatus</tt>.
	 * 
	 * @param itemstatus
	 *            the item status
	 * @return List of <tt>ItemStatus</tt>
	 */
	public List<ItemStatus> findItemStatus(ItemStatus itemstatus) {
		try {
			logger.logDebug(MessageManager.getString("ITEMSTATUSMANAGER.001",
					"FindItemStatus"));
			List<ItemStatus> itemStatusList = new ArrayList<ItemStatus>();
			itemStatusList = entityManager
					.createNamedQuery("ItemsValues.FindItemStatus",
							ItemStatus.class)
					.setParameter("productId", itemstatus.getProductId())
					.getResultList();
			return itemStatusList;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSTATUSMANAGER.006"),
					ex);
			throw new BusinessException(
					6900047,
					"No se pudo obtener la información de los estados de los rubros asociados al producto");
		} finally {
			logger.logDebug(MessageManager.getString("ITEMSTATUSMANAGER.002",
					"FindItemStatus"));
		}
	}

	/**
	 * Update an Items Status.
	 * 
	 * @param itemStatus
	 *            the Item Status to update.
	 */
	public void updateItemStatus(ItemStatus itemStatus) {
		try {
			logger.logDebug(MessageManager.getString("ITEMSTATUSMANAGER.001",
					"UpdateItemStatus"));
			if (validateUpdateItemStatus(itemStatus).size() > 0) {
				throw new BusinessException(710080,
						"Rango de días corresponde a un rango ya existente.");
			}
			ItemStatus istatus = entityManager.find(
					ItemStatus.class,
					new ItemStatusId(itemStatus.getProductId(), itemStatus
							.getItemId(), itemStatus.getStatusId()));
			istatus.setStartdays(itemStatus.getStartdays());
			istatus.setFinishdays(itemStatus.getFinishdays());
			entityManager.flush();

		} catch (BusinessException be) {
			logger.logError(MessageManager.getString("ITEMSTATUSMANAGER.004",
					itemStatus), be);
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSTATUSMANAGER.004",
					itemStatus), ex);
			throw new BusinessException(6900048,
					"No se pudo actualizar el estado del rubro seleccionado");
		} finally {
			logger.logDebug(MessageManager.getString("ITEMSTATUSMANAGER.002",
					"UpdateItemStatus"));
		}
	}

	/**
	 * Insert an Items Status.
	 * 
	 * @param itemStatus
	 *            the Item Status to insert.
	 */
	public void insertItemStatus(ItemStatus itemStatus) {
		try {
			logger.logDebug(MessageManager.getString("ITEMSTATUSMANAGER.001",
					"InsertItemStatus"));
			
			
			if (validateInsertItemStatus(itemStatus).size() > 0) {
				throw new BusinessException(710080,
						"Rango de dias corresponde a un rango ya existente.");
			}
			entityManager.persist(itemStatus);
			entityManager.flush();
		} catch (BusinessException be) {
			logger.logError(MessageManager.getString("ITEMSTATUSMANAGER.003",
					itemStatus), be);
			throw be;
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString("ITEMSTATUSMANAGER.007",
					itemStatus), eee);
			throw new BusinessException(6900050,
					"No se pudo crear el rubro, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSTATUSMANAGER.003",
					itemStatus), ex);
			throw new BusinessException(6900049,
					"No se pudo crear los estados para el rubro deseado");
		} finally {
			logger.logDebug(MessageManager.getString("ITEMSTATUSMANAGER.002",
					"InsertItemStatus"));
		}
	}

	/**
	 * Delete an Items Status.
	 * 
	 * @param itemStatus
	 *            the Item Status to delete
	 */
	public void deleteItemStatus(ItemStatus itemStatus) {
		try {
			logger.logDebug(MessageManager.getString("ITEMSTATUSMANAGER.001",
					"DeleteItemStatus"));
			ItemStatus istatus = entityManager.find(
					ItemStatus.class,
					new ItemStatusId(itemStatus.getProductId(), itemStatus
							.getItemId(), itemStatus.getStatusId()));
			
		
			
			entityManager.remove(istatus);
			entityManager.flush();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSTATUSMANAGER.005",
					itemStatus), ex);
			throw new BusinessException(6900051,
					"No se pudo eliminar el rubro seleccionado");
		} finally {
			logger.logDebug(MessageManager.getString("ITEMSTATUSMANAGER.002",
					"DeleteItemStatus"));
		}
	}

	/**
	 * Find the history given the <tt>BankingProductHistory</tt> identifier
	 * 
	 * @param itemstatus
	 *            <tt>BankingProductHistory</tt>sequential identifier of BankingProductHistory
	 * @return List of <tt>ItemStatusHistory</tt> founded
	 */
	public List<ItemStatusHistory> findItemStatusHistory(
			Long bankingProductHistoryId) {
		
		try {
BankingProductHistory bph = new BankingProductHistory();
			logger.logDebug(MessageManager.getString("ITEMSTATUSMANAGER.001",
					"findItemStatusHistory"));
			bph = entityManager.find(BankingProductHistory.class,
					bankingProductHistoryId);
			logger.logDebug("CONSULTABUSQUEDAA" + bph);

			logger.logDebug(MessageManager.getString("CODIGOPRODBANCARISTATUS"
					+ bankingProductHistoryId, "findItemStatusHistory"));

			List<ItemStatusHistory> itemStatusList = new ArrayList<ItemStatusHistory>();
			itemStatusList = entityManager
					.createNamedQuery("ItemsValues.FindItemStatusHistory",
							ItemStatusHistory.class)
					
					.setParameter("systemDateId", bph.getSystemDateId())
					.setParameter("productId", bph.getProductId())
					.getResultList();

			return itemStatusList;

		} catch (Exception e) {

			logger.logError(MessageManager.getString("ITEMSTATUSMANAGER.008"),
					e);
			throw new BusinessException(6900156,
					"Información historica de estado rubros no encontrada");

		} finally {
			logger.logDebug(MessageManager.getString("ITEMSTATUSMANAGER.002",
					"findItemStatusHistory"));

		}

	}

	/**
	 * Method for create itemstatusHistory
	 * 
	 * @param itemStatus
	 * @param bankingProductHistoryId 
	 *                                <tt>the sequential number of banking product history</tt>
	 */
	public void createItemStatusHistory(BankingProductHistory bankingProductHistoryId,
			String authorizationStatus) {
		BankingProductHistory bphistory = new BankingProductHistory();
		try {
	
			logger.logDebug(MessageManager.getString("ITEMSTATUSMANAGER.001",
					"createItemStatusHistory"));

			bphistory = entityManager.find(BankingProductHistory.class,
					bankingProductHistoryId.getId());

			List<ItemStatus> itemStatus = new ArrayList<ItemStatus>();
			itemStatus = entityManager
					.createNamedQuery("ItemsValues.FindItemStatus",
							ItemStatus.class)
					.setParameter("productId", bphistory.getProductId())
					.getResultList();

			for (ItemStatus item : itemStatus) {
				ItemStatusHistory statusHistory = new ItemStatusHistory();

				statusHistory

						.setBankingProductHistory(new BankingProductHistory());
				statusHistory.getBankingProductHistory().setId(
						bankingProductHistoryId.getId());

				statusHistory.setItemId(item.getItemId());
				statusHistory.setStatusId(item.getStatusId());
				statusHistory.setStartdays(item.getStartdays());
				statusHistory.setFinishdays(item.getFinishdays());
				statusHistory.setProcessDate(new SimpleDateFormat("MM/dd/yyyy")
						.parse(ContextManager.getContext().getProcessDate()));

				

				entityManager.persist(statusHistory);
				entityManager.flush();

			}

		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString("ITEMSTATUSMANAGER.011",
					bphistory), eee);
			throw new BusinessException(6900160,
					"No se pudo crear el estado rubro, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSTATUSMANAGER.003",
					bphistory), ex);
			throw new BusinessException(6900159,
					"No se pudo crear los estados para el rubro deseado");
		} finally {
			logger.logDebug(MessageManager.getString("ITEMSTATUSMANAGER.002",
					"createItemStatusHistory"));
		}

	}

	/**
	 * Get the changes made in the item status
	 * 
	 * @param productId
	 *            <tt>BankingProduct</tt> identifier
	 */
	public Map<String, List<ItemStatusLog>> getItemStatusChanges(
			String productId) {
		try {
			logger.logDebug(MessageManager.getString("ITEMSTATUSMANAGER.001",
					"getItemStatusChanges"));
			// Create the map with the changes
			Map<String, List<ItemStatusLog>> changes = new HashMap<String, List<ItemStatusLog>>();
			// Get the catalogs
			List<Catalog> statusList = portfolioCatalogService.findAllStatus();
			List<Item> items = itemService.getItemListByProduct(productId);
			logger.logDebug("Catalogos de cartera encontrados estados:"
					+ statusList.size());
			logger.logDebug("Rubros por productos encontrados : "
					+ items.size());
			// Get the list of after accounting profiles from the intermediate
			// tables
			ItemStatus filter = new ItemStatus();
			filter.setProductId(productId);
			List<ItemStatus> afterList = findItemStatus(filter);
			logger.logDebug("Lista de estados rubros actuales: " + afterList);
			// Create the after list to return
			List<ItemStatusLog> afterListLog = new ArrayList<ItemStatusLog>();
			for (ItemStatus itemStatus : afterList) {
				Catalog status = CatalogUtils.getFromCatalogList(statusList,
						String.valueOf(itemStatus.getStatusId()));
				Item item = CatalogUtils.getItemFromList(items,
						itemStatus.getItemId());
				afterListLog.add(new ItemStatusLog(item == null ? "" : item
						.getName(), status == null ? "" : status.getName(),
						itemStatus.getStartdays(), itemStatus.getFinishdays()));
			}
			logger.logDebug("List de log de estados rubros actuales: "
					+ afterListLog);
			// Set the after log list
			changes.put(Constants.AFTER_VALUE, afterListLog);
			// Find the latest banking product
			BankingProductHistory bph = bankingProductService
					.getLatestHistorical(productId);
			// return null if the before list is empty
			if (null == bph) {
				changes.put(Constants.BEFORE_VALUE,
						new ArrayList<ItemStatusLog>());
				return changes;
			}
			if (0 == bph.getItemStatusHistories().size()) {
				changes.put(Constants.BEFORE_VALUE,
						new ArrayList<ItemStatusLog>());
				return changes;
			}
			// Create the before list
			List<ItemStatusLog> beforeListLog = buildItemStatusLog(bph,
					statusList, items);
			logger.logDebug("List de log de estados rubros anteriores: "
					+ beforeListLog);
			// Set the after log list
			changes.put(Constants.BEFORE_VALUE, beforeListLog);
			return changes;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSTATUSMANAGER.099"),
					ex);
			throw new BusinessException(6900150,
					"Ocurrio un error al obtener los cambios de los estados de rubros.");
		} finally {
			logger.logDebug(MessageManager.getString("ITEMSTATUSMANAGER.002",
					"getItemStatusChanges"));
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
	 * Set the service injected by the container
	 * 
	 * @param bankingProductService
	 */
	public void setBankingProductService(
			IBankingProductManager bankingProductService) {
		this.bankingProductService = bankingProductService;
	}

	/**
	 * Restore the ItemStaus data from ItemStausHistory
	 * 
	 * @param bankinProductId
	 */
	public void restoreItemStatusManagerFromHistory(String bankinProductId) {

		
		BankingProductHistory bankingProductHistory = new BankingProductHistory();

		List<ItemStatus> itemStatusList = new ArrayList<ItemStatus>();
		List<ItemStatusHistory> itemStatusHistory = new ArrayList<ItemStatusHistory>();

		try {
			logger.logDebug(MessageManager.getString("ITEMSTATUSMANAGER.001",
					"restoreItemStatusManagerFromHistory"));

			// Find specific ItemStatus object
			BankingProduct bp = new BankingProduct();
			bp.setId(bankinProductId);
			ItemStatus itemStatus = new ItemStatus();
			itemStatus.setBankingProduct(bp);
			itemStatus.setProductId(bankinProductId);
			itemStatusList = findItemStatus(itemStatus);

			

			// Delete ItemStatus objects
			for (ItemStatus iStatus : itemStatusList) {
				deleteItemStatus(iStatus);
			}

			// Find ItemStatusHistory
			bankingProductHistory = bankingProductService
					.getLatestHistorical(bankinProductId);



			itemStatusHistory = findItemStatusHistory(bankingProductHistory
					.getId());

			logger.logDebug("CONSULTAHISTORICO" + itemStatusHistory);

			// Create ItemStatus with information of history
			for (ItemStatusHistory itemStatusHis : itemStatusHistory) {

				ItemByProductId byProductId = new ItemByProductId(itemStatusHis
						.getBankingProductHistory().getProductId(),
						itemStatusHis.getItemId());

				ItemByProduct itemByProduct = itemService
						.getItemByProduct(byProductId);

				BankingProduct bankingProduct = bankingProductService
						.getBankingProductBasicInformationById(itemStatusHis
								.getBankingProductHistory().getProductId());

				ItemStatus itemStatusProfile = new ItemStatus();
				itemStatusProfile.setBankingProduct(bankingProduct);
				itemStatusProfile.setProductId(itemStatusHis
						.getBankingProductHistory().getProductId());
				itemStatusProfile.setFinishdays(itemStatusHis.getFinishdays());
				itemStatusProfile.setItemId(itemStatusHis.getItemId());
				itemStatusProfile.setStartdays(itemStatusHis.getStartdays());
				itemStatusProfile.setItem(itemByProduct);
				itemStatusProfile.setStatusId(itemStatusHis.getStatusId());

				insertItemStatus(itemStatusProfile);
			}
		} catch (Exception e) {
			logger.logError(MessageManager.getString("ITEMSTATUSMANAGER.012"),
					e);
			throw new BusinessException(6900168,
					"No se pudo restaurar los estados de los rubros  desde su historico");
		} finally {
			logger.logDebug(MessageManager.getString("ITEMSTATUSMANAGER.002",
					"restoreItemStatusManagerFromHistory"));
		}

	}

	/**
	 * Get the information related to the item status history
	 * 
	 * @param bankingProductHistory
	 *            <tt>BankingProductHistory</tt> identifier
	 * @return
	 */
	public List<ItemStatusLog> getItemStatusHistoricalLog(
			Long bankingProductHistoryId) {
		try {
			logger.logDebug(MessageManager.getString("ITEMSTATUSMANAGER.001",
					"getItemStatusHistoricalLog"));
			BankingProductHistory bph = entityManager.find(
					BankingProductHistory.class, bankingProductHistoryId);
			if (null == bph) {
				throw new BusinessException(6900177,
						"No se encontro ningun historico del producto con la fecha indicada.");
			}
			return buildItemStatusLog(bph);
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSTATUSMANAGER.099"),
					ex);
			throw new BusinessException(6900176,
					"Ocurrio un error al obtener la información del historico de estado de rubros.");
		} finally {
			logger.logDebug(MessageManager.getString("ITEMSTATUSMANAGER.002",
					"getItemStatusHistoricalLog"));
		}
	}

	private List<ItemStatusLog> buildItemStatusLog(BankingProductHistory bph) {
		// Get the catalogs
		List<Catalog> statusList = portfolioCatalogService.findAllStatus();
		List<Item> items = itemService.getItemListByProduct(bph.getProductId());
		logger.logDebug("Catalogos de cartera encontrados estados:"
				+ statusList.size());
		logger.logDebug("Rubros por productos encontrados : " + items.size());
		return buildItemStatusLog(bph, statusList, items);
	}

	private List<ItemStatusLog> buildItemStatusLog(BankingProductHistory bph,
			List<Catalog> statusList, List<Item> items) {
		List<ItemStatusLog> beforeListLog = new ArrayList<ItemStatusLog>();
		for (ItemStatusHistory iHistory : bph.getItemStatusHistories()) {
			Catalog status = CatalogUtils.getFromCatalogList(statusList,
					String.valueOf(iHistory.getStatusId()));
			Item item = CatalogUtils.getItemFromList(items,
					iHistory.getItemId());
			beforeListLog.add(new ItemStatusLog(item == null ? "" : item
					.getName(), status == null ? "" : status.getName(),
					iHistory.getStartdays(), iHistory.getFinishdays()));
		}
		return beforeListLog;
	}

	/**
	 * Validate data before insert an ItemStatus
	 * 
	 * @param itemstatus
	 * @return
	 */
	private List<ItemStatus> validateInsertItemStatus(ItemStatus itemstatus) {
		logger.logDebug(MessageManager.getString("ITEMSTATUSMANAGER.001",
				"validateInsertItemStatus"));
		List<ItemStatus> itemStatusList = new ArrayList<ItemStatus>();
		itemStatusList = entityManager
				.createNamedQuery("ItemsValues.ValidateInsertItemStatus",
						ItemStatus.class)
				.setParameter("productId", itemstatus.getProductId())
				.setParameter("itemId", itemstatus.getItemId())
				.setParameter("startdays", itemstatus.getStartdays())
				.setParameter("finishdays", itemstatus.getFinishdays())
				.getResultList();
		
		
		
		return itemStatusList;
		
		
		
	}

	/**
	 * Validate data before update an ItemStatus
	 * 
	 * @param itemstatus
	 * @return
	 */
	private List<ItemStatus> validateUpdateItemStatus(ItemStatus itemstatus) {
		logger.logDebug(MessageManager.getString("ITEMSTATUSMANAGER.001",
				"validateDeleteItemStatus"));
		List<ItemStatus> itemStatusList = new ArrayList<ItemStatus>();
		itemStatusList = entityManager
				.createNamedQuery("ItemsValues.ValidateUpdateItemStatus",
						ItemStatus.class)
				.setParameter("productId", itemstatus.getProductId())
				.setParameter("itemId", itemstatus.getItemId())
				.setParameter("statusId", itemstatus.getStatusId())
				.setParameter("startdays", itemstatus.getStartdays())
				.setParameter("finishdays", itemstatus.getFinishdays())
				.getResultList();
		return itemStatusList;
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

	/**
	 * Set the service injected by the container
	 * 
	 * @param bankingProductService
	 */
	public void setItemService(IItemsManager itemService) {
		this.itemService = itemService;
	}

}
