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

import java.sql.Types;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.jdbc.utils.CobisStoredProcedureUtils;
import com.cobiscorp.cobis.jdbc.CobisDataException;
import com.cobiscorp.cobis.jdbc.CobisStoredProcedure;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.portfolio.model.TranOperation;
import com.cobiscorp.ecobis.fpm.portfolio.service.ITranOperationManager;
import com.cobiscorp.ecobis.fpm.portfolio.utils.MessageManager;

public class TranOperationManager implements ITranOperationManager {

	private static final String DATABASE_NAME = "SYBCTS";
	private CobisStoredProcedureUtils storedProcedureUtils;

	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(TranOperationManager.class);

	/** Entity Manager injected by the container */
	@PersistenceContext(unitName = "JpaFpmPortfolio")
	private EntityManager entityManager;

	private void insertTranOperationOne(TranOperation tranOperation) {
		try {
			logger.logDebug(MessageManager.getString(
					"TRANOPERATIONMANAGER.001", "insertTranOperation"));

			CobisStoredProcedure storedProcedure = this.storedProcedureUtils
					.getStoredProcedureInstance();
			storedProcedure.setDatabase("cob_cartera");
			storedProcedure.setName("sp_trn_oper");
			storedProcedure.setSkipUndeclaredResults(true);

			this.storedProcedureUtils.setContextParameters(DATABASE_NAME,
					storedProcedure);
			// Add business parameters
			storedProcedure.addInParam("@t_trn", Types.SMALLINT, 7117);
			storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "I");
			storedProcedure.addInParam("@i_toperacion", Types.VARCHAR,
					tranOperation.getOperation());
			storedProcedure.addInParam("@i_tipo_trn", Types.VARCHAR,
					tranOperation.getType());
			storedProcedure.addInParam("@i_perfil", Types.VARCHAR,
					tranOperation.getProfile());
			storedProcedure.addInParam("@i_filial", Types.INTEGER,
					tranOperation.getFilial());
			storedProcedure.execute();
		} catch (CobisDataException de) {
			logger.logError(MessageManager.getString(
					"TRANOPERATIONMANAGER.003", tranOperation), de);
			throw new BusinessException(de.getSQLErrorCode(), de
					.getSQLException().getMessage());

		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"TRANOPERATIONMANAGER.003", tranOperation), ex);
			throw new BusinessException(6900044,
					"No se pudo crear el perfil contable deseado.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"TRANOPERATIONMANAGER.002", "insertTranOperation"));
		}
	}

	private void deleteTranOperation(TranOperation tranOperation) {
		try {
			logger.logDebug(MessageManager.getString(
					"TRANOPERATIONMANAGER.001", "deleteTranOperation"));

			CobisStoredProcedure storedProcedure = this.storedProcedureUtils
					.getStoredProcedureInstance();
			storedProcedure.setDatabase("cob_cartera");
			storedProcedure.setName("sp_trn_oper");
			storedProcedure.setSkipUndeclaredResults(true);

			this.storedProcedureUtils.setContextParameters(DATABASE_NAME,
					storedProcedure);

			// Add business parameters
			storedProcedure.addInParam("@t_trn", Types.SMALLINT, 7116);
			storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "D");
			storedProcedure.addInParam("@i_toperacion", Types.VARCHAR,
					tranOperation.getOperation());
			storedProcedure.addInParam("@i_tipo_trn", Types.VARCHAR,
					tranOperation.getType());
			storedProcedure.addInParam("@i_filial", Types.INTEGER,
					tranOperation.getFilial());

			storedProcedure.execute();
		} catch (CobisDataException de) {
			logger.logError(MessageManager.getString(
					"TRANOPERATIONMANAGER.005", tranOperation), de);
			throw new BusinessException(de.getSQLErrorCode(), de
					.getSQLException().getMessage());
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"TRANOPERATIONMANAGER.005", tranOperation), ex);
			throw new BusinessException(6900045,
					"No se pudo eliminar el perfil contable seleccionado.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"TRANOPERATIONMANAGER.002", "deleteTranOperation"));
		}
	}

	public void insertTranOperation(List<TranOperation> trnOperationList) {
		try {

			logger.logDebug(MessageManager.getString(
					"TRANOPERATIONMANAGER.001", "insertTranOperation"));

			if (trnOperationList != null && trnOperationList.size() > 0) {
				List<TranOperation> trnOpList = findAllTranOperation(trnOperationList
						.get(0).getOperation());
				// Delete all data from ca_trn_oper
				for (TranOperation tranOperation : trnOpList)
					deleteTranOperation(tranOperation);
				entityManager.flush();
				// Insert new data from fp_accountingprofile
				for (TranOperation tranOperation : trnOperationList)
				{
					insertTranOperationOne(tranOperation);
				}
			}
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("TRANOPERATIONMANAGER.007"), ex);
			throw new BusinessException(6904020,
					"Ocurrio un error al intentar insertar los perfiles contables.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"TRANOPERATIONMANAGER.002", "insertTranOperation"));
		}
	}

	private List<TranOperation> findAllTranOperation(String productId) {
		try {
			logger.logDebug(MessageManager.getString(
					"TRANOPERATIONMANAGER.001", "findAllTranOperation"));

			return entityManager
					.createNamedQuery("TranOperation.findAllByOperation",
							TranOperation.class)
					.setParameter("operation", productId).getResultList();
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("TRANOPERATIONMANAGER.007"), ex);
			throw new BusinessException(6904021,
					"Ocurrio un error al intentar obtener los perfiles contables.");
		}finally {
			logger.logDebug(MessageManager.getString(
					"TRANOPERATIONMANAGER.002", "findAllTranOperation"));
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
