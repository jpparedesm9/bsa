/*
 * File: EvaluatorManager.java
 * Date: November 22, 2013
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
package com.cobiscorp.ecobis.fpm.service.utils;

import java.sql.Types;
import java.util.Map;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.jdbc.utils.CobisStoredProcedureUtils;
import com.cobiscorp.cobis.jdbc.CobisStoredProcedure;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.fpm.service.IEvaluatorManager;

/**
 * This service get values for rule's variable
 * 
 * @author bron
 */
public class EvaluatorManager implements IEvaluatorManager {

	private static final String DATABASE_NAME = "SYBCTS";
	private static final String BDD_DEFAULT = "cob_workflow";
	private CobisStoredProcedureUtils storedProcedureUtils;

	public void setStoredProcedureUtils(
			CobisStoredProcedureUtils storedProcedureUtils) {
		this.storedProcedureUtils = storedProcedureUtils;
	}

	/** COBIS Logger */
	private final ILogger logger = LogFactory.getLogger(EvaluatorManager.class);

	public String getVariableValue(Variable ruleCondition, int clientId,
			String oficialId, String productId) {
		logger.logDebug(MessageManager.getString("EVALUATIONMANAGER.001",
				"getVariableValue"));
		CobisStoredProcedure storedProcedure;

		try {

			storedProcedure = this.storedProcedureUtils
					.getStoredProcedureInstance(DATABASE_NAME);
			// If database name is empty set database by default
			if (ruleCondition.getPrograma().getNombreBdd() == null
					|| ruleCondition.getPrograma().getNombreBdd().equals(""))
				ruleCondition.getPrograma().setNombreBdd(BDD_DEFAULT);

			storedProcedure.setDatabase(ruleCondition.getPrograma()
					.getNombreBdd());
			storedProcedure.setName(ruleCondition.getPrograma()
					.getNombrePrograma());
			storedProcedure.setSkipUndeclaredResults(true);
			this.storedProcedureUtils.setContextParameters(DATABASE_NAME,
					storedProcedure);

			// Add sp parameters
			if (clientId > 0)
				storedProcedure.addInParam("@i_id_cliente", Types.INTEGER,
						clientId);
			if (oficialId != null && !oficialId.equals(""))
				storedProcedure.addInParam("@i_id_oficial", Types.VARCHAR,
						oficialId);
			if (productId != null && !productId.equals(""))
				storedProcedure.addInParam("@i_id_producto", Types.VARCHAR,
						productId);

			storedProcedure.addInParam("@i_origen", Types.VARCHAR, "VCC");
			storedProcedure.addInOutParam("@o_return_value", Types.VARCHAR,
					"0000000000");

			Map<String, Object> resultMap = storedProcedure.execute();

			if (resultMap.get("@o_return_value") != null) {
				return ((String) resultMap.get("@o_return_value")).trim();
			}

			return null;
		} catch (BusinessException be) {
			throw be;
		} catch (Exception e) {
			logger.logError(MessageManager.getString("EVALUATIONMANAGER.099"),
					e);
			throw new BusinessException(3107599,
					"Error al obtener el valor de la variable requerida.");
		} finally {
			logger.logDebug(MessageManager.getString("EVALUATIONMANAGER.002",
					"getVariableValue"));
		}
	}

}
