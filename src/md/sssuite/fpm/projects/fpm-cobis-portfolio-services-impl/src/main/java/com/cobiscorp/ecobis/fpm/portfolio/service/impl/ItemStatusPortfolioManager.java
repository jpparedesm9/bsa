/*
 * File: TranOperationManager.java
 * Date: April 23, 2012
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

package com.cobiscorp.ecobis.fpm.portfolio.service.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.jdbc.utils.CobisStoredProcedureUtils;
import com.cobiscorp.cobis.jdbc.CobisDataException;
import com.cobiscorp.cobis.jdbc.CobisRowMapper;
import com.cobiscorp.cobis.jdbc.CobisStoredProcedure;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.portfolio.bo.ItemStatusPortfolio;
import com.cobiscorp.ecobis.fpm.portfolio.service.IItemStatusPortfolioManager;
import com.cobiscorp.ecobis.fpm.portfolio.utils.MessageManager;

public class ItemStatusPortfolioManager implements IItemStatusPortfolioManager {

	private static final String DATABASE_NAME = "SYBCTS";
	private static final int ROW_COUNT = 35;
	private CobisStoredProcedureUtils storedProcedureUtils;

	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(ItemStatusPortfolioManager.class);

	private void insertItemStatusPortfolio(
			ItemStatusPortfolio itemStatusPortfolio) {
		try {
			logger.logDebug(MessageManager.getString(
					"ITEMSTATUSPORTFOLIOMANAGER.001",
					"insertItemStatusPortfolio"));

			CobisStoredProcedure storedProcedure = this.storedProcedureUtils
					.getStoredProcedureInstance();
			storedProcedure.setDatabase("cob_fpm");
			storedProcedure.setName("sp_estados_rubro_fpm");
			storedProcedure.setSkipUndeclaredResults(true);

			this.storedProcedureUtils.setContextParameters(DATABASE_NAME,
					storedProcedure);

			// Add parameters of business
			storedProcedure.addInParam("@t_trn", Types.SMALLINT, 7047);
			storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "I");
			storedProcedure.addInParam("@i_toperacion", Types.VARCHAR,
					itemStatusPortfolio.getOperation());
			storedProcedure.addInParam("@i_concepto", Types.VARCHAR,
					itemStatusPortfolio.getItemId());
			storedProcedure.addInParam("@i_estado", Types.VARCHAR,
					itemStatusPortfolio.getStatusId());
			storedProcedure.addInParam("@i_dias_cont", Types.INTEGER,
					itemStatusPortfolio.getStartdays());
			storedProcedure.addInParam("@i_dias_fin", Types.INTEGER,
					itemStatusPortfolio.getFinishdays());

			// Execute sp with parameters.
			storedProcedure.execute();
		} catch (CobisDataException de) {
			logger.logError(MessageManager.getString(
					"ITEMSTATUSPORTFOLIOMANAGER.003", itemStatusPortfolio), de);
			throw new BusinessException(de.getSQLErrorCode(), de
					.getSQLException().getMessage());
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"PORTFOLIOITEMSTATUSMANAGER.003", itemStatusPortfolio), ex);
			throw new BusinessException(6900049,
					"No se pudo crear los estados para el rubro deseado.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ITEMSTATUSPORTFOLIOMANAGER.002",
					"insertItemStatusPortfolio"));
		}
	}

	private void updateItemStatusPortfolio(
			ItemStatusPortfolio itemStatusPortfolio) {
		try {
			logger.logDebug(MessageManager.getString(
					"ITEMSTATUSPORTFOLIOMANAGER.001",
					"updateItemStatusPortfolio"));

			CobisStoredProcedure storedProcedure = this.storedProcedureUtils
					.getStoredProcedureInstance();
			storedProcedure.setDatabase("cob_fpm");
			storedProcedure.setName("sp_estados_rubro_fpm");
			storedProcedure.setSkipUndeclaredResults(true);

			this.storedProcedureUtils.setContextParameters(DATABASE_NAME,
					storedProcedure);

			// Add parameters of business
			storedProcedure.addInParam("@t_trn", Types.SMALLINT, 7048);
			storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "U");
			storedProcedure.addInParam("@i_toperacion", Types.VARCHAR,
					itemStatusPortfolio.getOperation());
			storedProcedure.addInParam("@i_concepto", Types.VARCHAR,
					itemStatusPortfolio.getItemId());
			storedProcedure.addInParam("@i_estado", Types.VARCHAR,
					itemStatusPortfolio.getStatusId());
			storedProcedure.addInParam("@i_dias_cont", Types.INTEGER,
					itemStatusPortfolio.getStartdays());
			storedProcedure.addInParam("@i_dias_fin", Types.INTEGER,
					itemStatusPortfolio.getFinishdays());

			// Execute sp with parameters.
			storedProcedure.execute();
		} catch (CobisDataException de) {
			logger.logError(MessageManager.getString(
					"ITEMSTATUSPORTFOLIOMANAGER.004", itemStatusPortfolio), de);
			throw new BusinessException(de.getSQLErrorCode(), de
					.getSQLException().getMessage());
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"ITEMSTATUSPORTFOLIOMANAGER.004", itemStatusPortfolio), ex);
			throw new BusinessException(6900048,
					"No se pudo actualizar el estado del rubro seleccionado.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ITEMSTATUSPORTFOLIOMANAGER.002",
					"updateItemStatusPortfolio"));
		}
	}

	private void deleteItemStatusPortfolio(
			ItemStatusPortfolio itemStatusPortfolio) {
		try {
			logger.logDebug(MessageManager.getString(
					"ITEMSTATUSPORTFOLIOMANAGER.001",
					"deleteItemStatusPortfolio"));
			CobisStoredProcedure storedProcedure = this.storedProcedureUtils
					.getStoredProcedureInstance();
			storedProcedure.setDatabase("cob_fpm");
			storedProcedure.setName("sp_estados_rubro_fpm");
			storedProcedure.setSkipUndeclaredResults(true);

			this.storedProcedureUtils.setContextParameters(DATABASE_NAME,
					storedProcedure);

			// Add parameters of business
			storedProcedure.addInParam("@t_trn", Types.SMALLINT, 7046);
			storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "D");
			storedProcedure.addInParam("@i_toperacion", Types.VARCHAR,
					itemStatusPortfolio.getOperation());
			storedProcedure.addInParam("@i_concepto", Types.VARCHAR,
					itemStatusPortfolio.getItemId());
			storedProcedure.addInParam("@i_estado", Types.VARCHAR,
					itemStatusPortfolio.getStatusId());

			// Execute sp with parameters.
			storedProcedure.execute();
		} catch (CobisDataException de) {
			logger.logError(MessageManager.getString(
					"ITEMSTATUSPORTFOLIOMANAGER.005", itemStatusPortfolio), de);
			throw new BusinessException(de.getSQLErrorCode(), de
					.getSQLException().getMessage());
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"ITEMSTATUSPORTFOLIOMANAGER.005", itemStatusPortfolio), ex);
			throw new BusinessException(6900051,
					"No se pudo eliminar el rubro seleccionado.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ITEMSTATUSPORTFOLIOMANAGER.002",
					"deleteItemStatusPortfolio"));
		}
	}

	@SuppressWarnings("unchecked")
	public List<ItemStatusPortfolio> findItemStatusPortfolio(String productId) {
		try {
			logger.logDebug(MessageManager
					.getString("ITEMSTATUSPORTFOLIOMANAGER.001",
							"findItemStatusPortfolio"));
			// Method for search item
			CobisStoredProcedure storedProcedure = this.storedProcedureUtils
					.getStoredProcedureInstance();
			storedProcedure.setDatabase("cob_fpm");
			storedProcedure.setName("sp_estados_rubro_fpm");
			storedProcedure.setSkipUndeclaredResults(true);

			this.storedProcedureUtils.setContextParameters(DATABASE_NAME,
					storedProcedure);

			// Add parameters of business
			storedProcedure.addInParam("@t_trn", Types.SMALLINT, 7045);
			storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "S");
			storedProcedure.addInParam("@i_toperacion", Types.VARCHAR,
					productId);
			storedProcedure.addInParam("@i_concepto", Types.VARCHAR, "");

			// Define as return the ResultSet
			storedProcedure.addResultSetMapper("ItemStatusPortfolioList",
					new CobisRowMapper<ItemStatusPortfolio>() {
						public ItemStatusPortfolio mapRow(ResultSet rs,
								int rowNum) throws SQLException {
							String operation = rs.getString("233406");
							String itemId = rs.getString("233408");
							String statusId = rs.getString("233410");
							int starDay = rs.getInt("233411");
							int finishDay = rs.getInt("233412");
							return new ItemStatusPortfolio(operation, itemId,
									statusId, finishDay, starDay);
						}
					});

			Map<String, Object> resultMap = storedProcedure.execute();
			List<ItemStatusPortfolio> itemStatusPortfolioList = (List<ItemStatusPortfolio>) resultMap
					.get("ItemStatusPortfolioList");

			int count = itemStatusPortfolioList.size();

			while (count >= ROW_COUNT) {

				storedProcedure = this.storedProcedureUtils
						.getStoredProcedureInstance();
				storedProcedure.setDatabase("cob_fpm");
				storedProcedure.setName("sp_estados_rubro_fpm");
				storedProcedure.setSkipUndeclaredResults(true);

				this.storedProcedureUtils.setContextParameters(DATABASE_NAME,
						storedProcedure);

				// Add parameters of business
				storedProcedure.addInParam("@t_trn", Types.SMALLINT, 7045);
				storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "S");
				storedProcedure.addInParam("@i_toperacion", Types.VARCHAR,
						productId);
				storedProcedure
						.addInParam(
								"@i_concepto",
								Types.VARCHAR,
								itemStatusPortfolioList.get(
										itemStatusPortfolioList.size() - 1)
										.getItemId());

				// Define as return the ResultSet
				storedProcedure.addResultSetMapper("ItemStatusPortfolioList",
						new CobisRowMapper<ItemStatusPortfolio>() {
							public ItemStatusPortfolio mapRow(ResultSet rs,
									int rowNum) throws SQLException {
								String operation = rs.getString("233406");
								String itemId = rs.getString("233408");
								String statusId = rs.getString("233410");
								int starDay = rs.getInt("233411");
								int finishDay = rs.getInt("233412");
								return new ItemStatusPortfolio(operation,
										itemId, statusId, finishDay, starDay);
							}
						});

				resultMap = storedProcedure.execute();
				List<ItemStatusPortfolio> temp = (List<ItemStatusPortfolio>) resultMap
						.get("ItemStatusPortfolioList");
				itemStatusPortfolioList.addAll(temp);
				count = temp.size();
			}

			return itemStatusPortfolioList;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"ITEMSTATUSPORTFOLIOMANAGER.003", productId), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager
					.getString("ITEMSTATUSPORTFOLIOMANAGER.002",
							"findItemStatusPortfolio"));
		}
	}

	public void insertItemStatusPortfolio(
			List<ItemStatusPortfolio> itemStatusPortfolioList,
			String bankingProductId) {
		try {
			logger.logDebug(MessageManager.getString(
					"ITEMSTATUSPORTFOLIOMANAGER.001",
					"insertItemStatusPortfolio"));

			if (itemStatusPortfolioList != null) {

				List<ItemStatusPortfolio> iStatusPortfolioList = findItemStatusPortfolio(bankingProductId);

				// Delete data of ca_estados_rubro
				for (ItemStatusPortfolio iStatusPort : iStatusPortfolioList) {
					deleteItemStatusPortfolio(iStatusPort);
				}

				// Insert and Update new data from fp_itemstatus
				updateItemStatusPortfolio(iStatusPortfolioList,
						itemStatusPortfolioList);
			}
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("ITEMSTATUSPORTFOLIOMANAGER.007"),
					ex);
			throw new BusinessException(6904020,
					"Ocurrió un error al intentar insertar el estado de rubro.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ITEMSTATUSPORTFOLIOMANAGER.002",
					"insertItemStatusPortfolio"));
		}
	}

	private void updateItemStatusPortfolio(
			List<ItemStatusPortfolio> iStatusPortfolioList,
			List<ItemStatusPortfolio> itemStatusPortfolioList) {
		// Insert and Update new data from fp_itemstatus
		for (ItemStatusPortfolio iStatusPort : itemStatusPortfolioList) {
			insertItemStatusPortfolio(iStatusPort);
		}
	}

	/**
	 * 
	 * @param storedProcedureUtils
	 */
	public void setStoredProcedureUtils(
			CobisStoredProcedureUtils storedProcedureUtils) {
		this.storedProcedureUtils = storedProcedureUtils;
	}

}
