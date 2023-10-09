/*
 * File: OpManualStatusManager.java
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
import com.cobiscorp.ecobis.fpm.portfolio.bo.OpManualStatus;
import com.cobiscorp.ecobis.fpm.portfolio.service.IOpManualStatusManager;
import com.cobiscorp.ecobis.fpm.portfolio.utils.MessageManager;

public class OpManualStatusManager implements IOpManualStatusManager {

	private static final String DATABASE_NAME = "SYBCTS";
	private static final int ROW_COUNT = 30;
	private CobisStoredProcedureUtils storedProcedureUtils;

	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(OpManualStatusManager.class);

	private void insertOpManualStatus(OpManualStatus opManualStatus) {
		try {
			logger.logDebug(MessageManager.getString(
					"OPMANUALSTATUSMANAGER.001", "insertOpManualStatus"));

			CobisStoredProcedure storedProcedure = this.storedProcedureUtils
					.getStoredProcedureInstance();
			storedProcedure.setDatabase("cob_cartera");
			storedProcedure.setName("sp_estados_man");
			storedProcedure.setSkipUndeclaredResults(true);

			this.storedProcedureUtils.setContextParameters(DATABASE_NAME,
					storedProcedure);

			// Se agregan los parÃ¡metros de negocio
			storedProcedure.addInParam("@t_trn", Types.SMALLINT, 7041);
			storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "I");
			storedProcedure.addInParam("@i_toperacion", Types.VARCHAR,
					opManualStatus.getProductId());
			storedProcedure.addInParam("@i_tipo", Types.VARCHAR,
					opManualStatus.getChangeType());

			storedProcedure.addInParam("@i_dias_cont", Types.INTEGER,
					opManualStatus.getStartDays());

			if (opManualStatus.getChangeType().equals("D")
					|| opManualStatus.getChangeType().equals("O")) {
				storedProcedure.addInParam("@i_dias_fin", Types.INTEGER,
						opManualStatus.getFinishDays());

			} else if (opManualStatus.getFinalStatusId() != null) {
				storedProcedure.addInParam("@i_estado_fin", Types.VARCHAR,
						opManualStatus.getFinalStatusId());
			}
			storedProcedure.addInParam("@i_estado_ini", Types.VARCHAR,
					opManualStatus.getInitialStatusId());

			storedProcedure.execute();
		} catch (CobisDataException de) {
			logger.logError(MessageManager.getString(
					"OPMANUALSTATUSMANAGER.003", opManualStatus), de);
			throw new BusinessException(de.getSQLErrorCode(), de
					.getSQLException().getMessage());
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"OPMANUALSTATUSMANAGER.003", opManualStatus), ex);
			throw new BusinessException(6900054,
					"No se pudo crear los estados para la operación deseada.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"OPMANUALSTATUSMANAGER.002", "insertOpManualStatus"));
		}
	}

	private void deleteOpManualStatus(OpManualStatus opManualStatus) {
		try {
			logger.logDebug(MessageManager.getString(
					"OPMANUALSTATUSMANAGER.001", "deleteOpManualStatus"));

			CobisStoredProcedure storedProcedure = this.storedProcedureUtils
					.getStoredProcedureInstance();
			storedProcedure.setDatabase("cob_cartera");
			storedProcedure.setName("sp_estados_man");
			storedProcedure.setSkipUndeclaredResults(true);

			this.storedProcedureUtils.setContextParameters(DATABASE_NAME,
					storedProcedure);

			// Se agregan los parametros de negocio
			storedProcedure.addInParam("@t_trn", Types.SMALLINT, 7040);
			storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "D");
			storedProcedure.addInParam("@i_toperacion", Types.VARCHAR,
					opManualStatus.getProductId());
			storedProcedure.addInParam("@i_tipo", Types.VARCHAR,
					opManualStatus.getChangeType());
			storedProcedure.addInParam("@i_estado_ini", Types.VARCHAR,
					opManualStatus.getInitialStatusId());
			storedProcedure.addInParam("@i_estado_fin", Types.VARCHAR,
					opManualStatus.getFinalStatusId());

			storedProcedure.execute();
		} catch (CobisDataException de) {
			logger.logError(MessageManager.getString(
					"OPMANUALSTATUSMANAGER.005", opManualStatus), de);
			throw new BusinessException(de.getSQLErrorCode(), de
					.getSQLException().getMessage());
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"OPMANUALSTATUSMANAGER.005", opManualStatus), ex);
			throw new BusinessException(6900056,
					"No se pudo eliminar la operación seleccionada.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"OPMANUALSTATUSMANAGER.002", "deleteOpManualStatus"));
		}
	}

	public void updateOperationChangeStatus(OpManualStatus opManualStatus) {
		try {
			logger.logDebug(MessageManager.getString(
					"OPMANUALSTATUSMANAGER.001", "updateOperationChangeStatus"));

			CobisStoredProcedure storedProcedure = this.storedProcedureUtils
					.getStoredProcedureInstance();
			storedProcedure.setDatabase("cob_cartera");
			storedProcedure.setName("sp_estados_man");
			storedProcedure.setSkipUndeclaredResults(true);

			this.storedProcedureUtils.setContextParameters(DATABASE_NAME,
					storedProcedure);

			// Se agregan los parÃ¡metros de negocio
			storedProcedure.addInParam("@t_trn", Types.SMALLINT, 7042);
			storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "U");
			storedProcedure.addInParam("@i_toperacion", Types.VARCHAR,
					opManualStatus.getProductId());
			storedProcedure.addInParam("@i_tipo", Types.VARCHAR,
					opManualStatus.getChangeType());
			storedProcedure.addInParam("@i_dias_cont", Types.INTEGER,
					opManualStatus.getStartDays());

			if (opManualStatus.getChangeType().equals("D")
					|| opManualStatus.getChangeType().equals("O")) {
				storedProcedure.addInParam("@i_dias_fin", Types.INTEGER,
						opManualStatus.getFinishDays());

			} else if (opManualStatus.getFinalStatusId() != null) {
				storedProcedure.addInParam("@i_estado_fin", Types.VARCHAR,
						opManualStatus.getFinalStatusId());
			}
			storedProcedure.addInParam("@i_estado_ini", Types.VARCHAR,
					opManualStatus.getInitialStatusId());
			storedProcedure.execute();
		} catch (CobisDataException de) {
			logger.logError(MessageManager.getString(
					"OPMANUALSTATUSMANAGER.005", opManualStatus), de);
			throw new BusinessException(de.getSQLErrorCode(), de
					.getSQLException().getMessage());
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"OPMANUALSTATUSMANAGER.005", opManualStatus), ex);
			throw new BusinessException(6900053,
					"No se pudo actualizar el estado de la operación seleccionada.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"OPMANUALSTATUSMANAGER.002", "updateOperationChangeStatus"));
		}
	}

	@SuppressWarnings("unchecked")
	public List<OpManualStatus> findOperationChangeStatus(String productId) {
		try {
			logger.logDebug(MessageManager.getString(
					"OPMANUALSTATUSMANAGER.001", "findOperationChangeStatus"));
			CobisStoredProcedure storedProcedure = this.storedProcedureUtils
					.getStoredProcedureInstance();
			storedProcedure.setDatabase("cob_cartera");
			storedProcedure.setName("sp_estados_man");
			storedProcedure.setSkipUndeclaredResults(true);

			this.storedProcedureUtils.setContextParameters(DATABASE_NAME,
					storedProcedure);

			// Se agregan los parÃ¡metros de negocio
			storedProcedure.addInParam("@t_trn", Types.SMALLINT, 7039);
			storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "S");

			storedProcedure.addInParam("@i_toperacion", Types.VARCHAR,
					productId);

			// Se define como se van retornar los ResultSet
			storedProcedure.addResultSetMapper("OpManualStatusList",
					new CobisRowMapper<OpManualStatus>() {
						public OpManualStatus mapRow(ResultSet rs, int rowNum)
								throws SQLException {
							String operation = rs.getString("TIPO OP.");
							String changeType = rs.getString("TIPO");
							String initialStatus = rs.getString("ESTADO ANT.");
							String finalStatus = rs.getString("ESTADO FINAL");
							int startDays = rs.getInt("DIAS INICIO");
							int finishDays = rs.getInt("DIAS FIN");
							return new OpManualStatus(operation, changeType,
									initialStatus, finalStatus, startDays,
									finishDays);
						}
					});

			Map<String, Object> resultMap = storedProcedure.execute();
			List<OpManualStatus> opManualStatusList = (List<OpManualStatus>) resultMap
					.get("OpManualStatusList");

			int count = opManualStatusList.size();

			while (count >= ROW_COUNT) {
				storedProcedure = this.storedProcedureUtils
						.getStoredProcedureInstance();
				storedProcedure.setDatabase("cob_cartera");
				storedProcedure.setName("sp_estados_man");
				storedProcedure.setSkipUndeclaredResults(true);

				this.storedProcedureUtils.setContextParameters(DATABASE_NAME,
						storedProcedure);

				// Se agregan los parÃ¡metros de negocio
				storedProcedure.addInParam("@t_trn", Types.SMALLINT, 7039);
				storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "S");
				storedProcedure.addInParam("@i_toperacion", Types.VARCHAR,
						productId);
				storedProcedure.addInParam("@i_tipo", Types.VARCHAR,
						opManualStatusList.get(opManualStatusList.size() - 1)
								.getChangeType());
				storedProcedure.addInParam("@i_estado_ini", Types.VARCHAR,
						opManualStatusList.get(opManualStatusList.size() - 1)
								.getInitialStatusId());
				storedProcedure.addInParam("@i_estado_fin", Types.VARCHAR,
						opManualStatusList.get(opManualStatusList.size() - 1)
								.getFinalStatusId());

				// Se define como se van retornar los ResultSet
				storedProcedure.addResultSetMapper("OpManualStatusList",
						new CobisRowMapper<OpManualStatus>() {
							public OpManualStatus mapRow(ResultSet rs,
									int rowNum) throws SQLException {
								String operation = rs.getString("TIPO OP.");
								String changeType = rs.getString("TIPO");
								String initialStatus = rs.getString("ESTADO ANT.");
								String finalStatus = rs.getString("ESTADO FINAL");
								int startDays = rs.getInt("DIAS INICIO");
								int finishDays = rs.getInt("DIAS FIN");
								return new OpManualStatus(operation,
										changeType, initialStatus, finalStatus,
										startDays, finishDays);
							}
						});

				resultMap = storedProcedure.execute();
				List<OpManualStatus> temp = (List<OpManualStatus>) resultMap
						.get("OpManualStatusList");
				opManualStatusList.addAll(temp);
				count = temp.size();
			}
			return opManualStatusList;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"OPMANUALSTATUSMANAGER.003", productId), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"OPMANUALSTATUSMANAGER.002", "findOperationChangeStatus"));
		}
	}

	public void insertOpManualStatus(List<OpManualStatus> opManualStatusList) {
		try {
			logger.logDebug(MessageManager.getString(
					"OPMANUALSTATUSMANAGER.001", "insertOpManualStatus"));

			if (opManualStatusList != null && !opManualStatusList.isEmpty()) {

				List<OpManualStatus> opManStatusList = findOperationChangeStatus(opManualStatusList
						.get(0).getProductId());

				// Delete data of ca_estados_man
				for (OpManualStatus opManStatus : opManStatusList) {
					deleteOpManualStatus(opManStatus);
				}

				// Insert and Update new data from fp_operationstatus
				updateOpManualStatus(opManStatusList, opManualStatusList);
			}
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("OPMANUALSTATUSMANAGER.007"), ex);
			throw new BusinessException(6904020,
					"Ocurrio un error al intentar insertar el estado de operación.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"OPMANUALSTATUSMANAGER.002", "insertOpManualStatus"));
		}
	}

	private void updateOpManualStatus(List<OpManualStatus> opManStatusList,
			List<OpManualStatus> opManualStatusList) {
		// Insert and Update new data from fp_operationstatus
		for (OpManualStatus opManStatus : opManualStatusList) {
			insertOpManualStatus(opManStatus);
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
