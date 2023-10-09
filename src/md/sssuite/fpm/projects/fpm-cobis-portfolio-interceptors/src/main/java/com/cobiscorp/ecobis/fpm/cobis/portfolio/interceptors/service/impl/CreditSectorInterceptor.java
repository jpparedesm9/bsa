/*
 * File: CreditSectorInterceptor.java
 * Date: April 16, 2012
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

package com.cobiscorp.ecobis.fpm.cobis.portfolio.interceptors.service.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.IMessageBlock;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetBlock;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetData;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetHeader;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetRow;
import com.cobiscorp.cobis.cts.dtos.MessageBlock;
import com.cobiscorp.cobis.cts.dtos.ProcedureResponseAS;
import com.cobiscorp.cobis.cts.dtos.sp.ResultSetBlock;
import com.cobiscorp.cobis.cts.dtos.sp.ResultSetData;
import com.cobiscorp.cobis.cts.dtos.sp.ResultSetHeader;
import com.cobiscorp.cobis.cts.dtos.sp.ResultSetHeaderColumn;
import com.cobiscorp.cobis.cts.dtos.sp.ResultSetRow;
import com.cobiscorp.cobis.cts.dtos.sp.ResultSetRowColumnData;
import com.cobiscorp.cobis.cts.interceptors.CobisInterceptor;
import com.cobiscorp.cobis.cts.interceptors.CobisInterceptorContext;
import com.cobiscorp.cobis.cts.jdbc.utils.CobisStoredProcedureUtils;
import com.cobiscorp.cobis.jdbc.CobisRowMapper;
import com.cobiscorp.cobis.jdbc.CobisStoredProcedure;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.bo.Sector;
import com.cobiscorp.ecobis.fpm.cobis.portfolio.interceptors.service.utils.MessageManager;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;

/**
 * Intercepts the sp_sector stored procedure
 * 
 * @author despinosa
 * 
 */
public class CreditSectorInterceptor implements CobisInterceptor {

	// region Fields

	/** CTS logger */
	private static final ILogger logger = LogFactory
			.getLogger(QrOperationInterceptor.class);

	private static final String DATABASE_NAME = "SYBCTS";

	/** Consultar el sector asociado al producto bancario */
	private IBankingProductManager bankingProductSector;
	private CobisStoredProcedureUtils storedProcedureUtils;

	// end-region

	// region Properties
	public void setBankingProductSector(
			IBankingProductManager bankingProductSector) {
		this.bankingProductSector = bankingProductSector;
	}

	public void setStoredProcedureUtils(
			CobisStoredProcedureUtils storedProcedureUtils) {
		this.storedProcedureUtils = storedProcedureUtils;
	}

	// end-region

	// region Implements CobisInterceptor

	public void execute(CobisInterceptorContext context) {
		logger.logDebug(MessageManager.getString("CREDITSECTORINTERCEPTOR.001",
				"execute"));

		IProcedureResponse procedureResponse = new ProcedureResponseAS();
		IResultSetBlock resultsetBlock = null;
		IResultSetHeader resultsetHeader = new ResultSetHeader();
		IResultSetData resultSetData = new ResultSetData();
		IProcedureRequest request = null;

		request = context
				.getValue(CobisInterceptorContext.PROCEDURE_REQUEST_KEY);

		try {

			if (request.readParam("@t_trn") == null
					|| request.readParam("@t_trn").getValue() == null) {
				logger.logError(MessageManager
						.getString("CREDITSECTORINTERCEPTOR.004"));

				IMessageBlock message = new MessageBlock(6901000,
						"No se pudo recuperar el identificador de la transacción.");
				procedureResponse.addResponseBlock(message);
				procedureResponse.setReturnCode(6901000);

				context.addValue(
						CobisInterceptorContext.PROCEDURE_RESPONSE_KEY,
						procedureResponse);

				return;

			} else {

				if (request.readParam("@t_trn").getValue().trim()
						.equals("21627")) {

					resultsetHeader
							.addColumnMetaData(new ResultSetHeaderColumn(
									"Sector", 47, 10));
					resultsetHeader
							.addColumnMetaData(new ResultSetHeaderColumn(
									"Descripcion", 39, 64));

					if (request.readParam("@i_toperacion") == null) {
						logger.logError(MessageManager
								.getString("CREDITSECTORINTERCEPTOR.004"));

						IMessageBlock message = new MessageBlock(6901000,
								"No se pudo recuperar el identificador de la transacción.");
						procedureResponse.addResponseBlock(message);
						procedureResponse.setReturnCode(6901000);

						context.addValue(
								CobisInterceptorContext.PROCEDURE_RESPONSE_KEY,
								procedureResponse);

						return;
					}

					logger.logDebug(MessageManager.getString(
							"CREDITSECTORINTERCEPTOR.003", request.getSpName()));

					Sector sector = bankingProductSector
							.getBankingProductSector(request.readParam(
									"@i_toperacion").getValue());

					if (sector.getCode().equals("T")) {

						Map<String, String> parameters = new HashMap<String, String>();

						parameters.put("@t_trn", request.readParam("@t_trn")
								.getValue());
						parameters.put("@i_operacion",
								request.readParam("@i_operacion").getValue());
						parameters.put("@i_toperacion",
								request.readParam("@i_toperacion").getValue());

						List<Sector> sectorList = executeProcedureSector(parameters);

						IResultSetRow resultSetRow = null;

						for (Sector sectorVar : sectorList) {

							resultSetRow = new ResultSetRow();

							resultSetRow.addRowData(
									1,
									new ResultSetRowColumnData(false, sectorVar
											.getCode()));

							resultSetRow.addRowData(
									2,
									new ResultSetRowColumnData(false, sectorVar
											.getDescription()));

							resultSetData.addRow(resultSetRow);
						}

						resultsetBlock = new ResultSetBlock(resultsetHeader,
								resultSetData);
						procedureResponse.addResponseBlock(resultsetBlock);

					} else {

						IResultSetRow resultSetRow = new ResultSetRow();
						resultSetRow.addRowData(1, new ResultSetRowColumnData(
								false, sector.getCode()));

						resultSetRow.addRowData(2, new ResultSetRowColumnData(
								false, sector.getDescription()));
						resultSetData.addRow(resultSetRow);

						resultsetBlock = new ResultSetBlock(resultsetHeader,
								resultSetData);
						procedureResponse.addResponseBlock(resultsetBlock);
					}

				} else if (request.readParam("@t_trn").getValue().trim()
						.equals("21327")) {

					resultsetHeader
							.addColumnMetaData(new ResultSetHeaderColumn(
									"valor", 39, 64));

					if (request.readParam("@i_toperacion") == null) {
						logger.logError(MessageManager
								.getString("CREDITSECTORINTERCEPTOR.004"));

						IMessageBlock message = new MessageBlock(6901000,
								"No se pudo recuperar el identificador de la transacción.");
						procedureResponse.addResponseBlock(message);
						procedureResponse.setReturnCode(6901000);

						context.addValue(
								CobisInterceptorContext.PROCEDURE_RESPONSE_KEY,
								procedureResponse);

						return;
					}

					logger.logDebug(MessageManager.getString(
							"CREDITSECTORINTERCEPTOR.003", request.getSpName()));

					Sector sector = bankingProductSector
							.getBankingProductSector(request.readParam(
									"@i_toperacion").getValue());

					if (sector.getCode().equals("T")) {

						Map<String, String> parameters = new HashMap<String, String>();

						parameters.put("@t_trn", request.readParam("@t_trn")
								.getValue());
						parameters.put("@i_operacion",
								request.readParam("@i_operacion").getValue());
						parameters.put("@i_toperacion",
								request.readParam("@i_toperacion").getValue());
						parameters.put("@i_sector",
								request.readParam("@i_sector").getValue());

						List<Sector> sectorList = null;
						try {
							sectorList = executeProcedureSector(parameters);
						} catch (BusinessException be) {
							logger.logError(MessageManager
									.getString("CREDITSECTORINTERCEPTOR.004"));

							IMessageBlock message = new MessageBlock(6901022,
									"No existe registro.");
							procedureResponse.addResponseBlock(message);
							procedureResponse.setReturnCode(6901022);

							context.addValue(
									CobisInterceptorContext.PROCEDURE_RESPONSE_KEY,
									procedureResponse);

							return;
						}

						IResultSetRow resultSetRow = null;

						for (Sector sectorVar : sectorList) {

							resultSetRow = new ResultSetRow();

							resultSetRow.addRowData(
									1,
									new ResultSetRowColumnData(false, sectorVar
											.getDescription()));

							resultSetData.addRow(resultSetRow);
						}

						resultsetBlock = new ResultSetBlock(resultsetHeader,
								resultSetData);
						procedureResponse.addResponseBlock(resultsetBlock);

					} else {

						String description = bankingProductSector
								.getBankingProductSectorDescription(request
										.readParam("@i_toperacion").getValue(),
										request.readParam("@i_sector")
												.getValue());

						if (description != null) {

							IResultSetRow resultSetRow = new ResultSetRow();
							resultSetRow.addRowData(1,
									new ResultSetRowColumnData(false,
											description));

							resultSetData.addRow(resultSetRow);

							resultsetBlock = new ResultSetBlock(
									resultsetHeader, resultSetData);
							procedureResponse.addResponseBlock(resultsetBlock);
						} else {

							logger.logError(MessageManager
									.getString("CREDITSECTORINTERCEPTOR.004"));

							IMessageBlock message = new MessageBlock(6901000,
									"No existe sector.");
							procedureResponse.addResponseBlock(message);
							procedureResponse.setReturnCode(6901000);

							context.addValue(
									CobisInterceptorContext.PROCEDURE_RESPONSE_KEY,
									procedureResponse);

							return;

						}
					}
				}

			}

		} catch (Exception e) {

			logger.logError(
					MessageManager.getString("CREDITSECTORINTERCEPTOR.004"), e);

			IMessageBlock message = new MessageBlock(6901018,
					"No se pudieron obtener los datos de los sectores. ");
			procedureResponse.addResponseBlock(message);
			procedureResponse.setReturnCode(6901018);
			throw new BusinessException(6901018,
					"Ocurrió un error al intentar obtener el sector vinculado al producto bancario");

		} finally {
			context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY,
					procedureResponse);
			logger.logDebug(MessageManager.getString(
					"CREDITSECTORINTERCEPTOR.002", "execute"));
		}

	}

	// end-region

	// region Utilities
	@SuppressWarnings("unchecked")
	private List<Sector> executeProcedureSector(Map<String, String> parameters) {
		// Method for search item
		CobisStoredProcedure storedProcedure = this.storedProcedureUtils
				.getStoredProcedureInstance();
		storedProcedure.setDatabase("cob_credito");
		storedProcedure.setName("sp_sector");
		storedProcedure.setSkipUndeclaredResults(true);

		this.storedProcedureUtils.setContextParameters(DATABASE_NAME,
				storedProcedure);

		// Add parameters of business
		if (parameters.containsKey("@t_trn")) {
			storedProcedure.addInParam("@t_trn", Types.SMALLINT,
					Integer.parseInt(parameters.get("@t_trn")));
		}
		if (parameters.containsKey("@i_operacion")) {
			storedProcedure.addInParam("@i_operacion", Types.VARCHAR,
					parameters.get("@i_operacion"));
		}
		if (parameters.containsKey("@i_toperacion")) {
			storedProcedure.addInParam("@i_toperacion", Types.VARCHAR,
					parameters.get("@i_toperacion"));
		}
		if (parameters.containsKey("@i_sector")) {
			storedProcedure.addInParam("@i_sector", Types.VARCHAR,
					parameters.get("@i_sector"));
		}

		if (parameters.get("@t_trn").equals("21627")) {
			// Define as return the ResultSet
			storedProcedure.addResultSetMapper("sectorList",
					new CobisRowMapper<Sector>() {
						public Sector mapRow(ResultSet rs, int rowNum)
								throws SQLException {

							String sectorId = rs.getString("Sector");
							String sectorDescription = rs
									.getString("Descripcion");

							return new Sector(sectorId, sectorDescription);
						}
					});
		} else if (parameters.get("@t_trn").equals("21327")) {

			// Define as return the ResultSet
			storedProcedure.addResultSetMapper("sectorList",
					new CobisRowMapper<Sector>() {
						public Sector mapRow(ResultSet rs, int rowNum)
								throws SQLException {

							String sectorDescription = rs.getString("valor");

							return new Sector(null, sectorDescription);
						}
					});
		}

		Map<String, Object> resultMap = null;
		try {
			resultMap = storedProcedure.execute();
		} catch (Exception ex) {
			throw new BusinessException(6901022, "No existe registro");
		}

		return ((List<Sector>) resultMap.get("sectorList"));

	}
	// endregion

}
