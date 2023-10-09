package com.cobiscorp.ecobis.fpm.portfolio.catalogs.service.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.jdbc.utils.CobisStoredProcedureUtils;
import com.cobiscorp.cobis.jdbc.CobisRowMapper;
import com.cobiscorp.cobis.jdbc.CobisStoredProcedure;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.catalogs.service.ICatalogManager;
import com.cobiscorp.ecobis.fpm.catalogs.service.impl.CatalogManager;
import com.cobiscorp.ecobis.fpm.catalogs.utils.MessageManager;
import com.cobiscorp.ecobis.fpm.portfolio.catalogs.service.IPortfolioCatalogManager;

public class PortfolioCatalogManager implements IPortfolioCatalogManager {

	private static final String DATABASE_NAME = "SYBCTS";
	private static final int ROW_COUNT = 20;
	private static final String ECONOMIC_DESTINATATION_CATALOG = "cr_destino";
	private static final String ECONOMIC_ACTIVITY_CATALOG = "cl_actividad_ec";
	private static final String PURPOSE_CATALOG = "cr_proposito_linea";

	private CobisStoredProcedureUtils storedProcedureUtils;
	private ICatalogManager catalogManager;
	
	/** COBIS Logger */
	private final ILogger logger = LogFactory.getLogger(CatalogManager.class);

	/**
	 * Return all Subsidiaries available by the core
	 * 
	 * @return List of <tt>Catalog</tt>
	 */
	@SuppressWarnings("unchecked")
	public List<Catalog> findAllSubsidiaries() {
		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOCATALOGMANAGER.001", "FindAllSubsidiaries"));
			CobisStoredProcedure storedProcedure = this.storedProcedureUtils
					.getStoredProcedureInstance();
			storedProcedure.setDatabase("cob_conta");
			storedProcedure.setName("sp_empresa");
			storedProcedure.setSkipUndeclaredResults(true);

			this.storedProcedureUtils.setContextParameters(DATABASE_NAME,
					storedProcedure);

			storedProcedure.addInParam("@t_trn", Types.SMALLINT, 6037);
			storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "A");
			storedProcedure.addInParam("@i_modo", Types.TINYINT, 0);

			storedProcedure.addResultSetMapper("CatalogList",
					new CobisRowMapper<Catalog>() {
						public Catalog mapRow(ResultSet rs, int rowNum)
								throws SQLException {
							String filial = rs.getString("Empresa");
							String description = rs.getString("Descripcion");
							return new Catalog(filial, description);
						}
					});

			Map<String, Object> resultMap = storedProcedure.execute();
			List<Catalog> filialList = (List<Catalog>) resultMap
					.get("CatalogList");

			int count = filialList.size();

			while (count >= ROW_COUNT) {
				storedProcedure = this.storedProcedureUtils
						.getStoredProcedureInstance();
				storedProcedure.setDatabase("cob_conta");
				storedProcedure.setName("sp_empresa");
				storedProcedure.setSkipUndeclaredResults(true);

				this.storedProcedureUtils.setContextParameters(DATABASE_NAME,
						storedProcedure);
				storedProcedure.addInParam("@t_trn", Types.SMALLINT, 6037);
				storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "A");
				storedProcedure.addInParam("@i_modo", Types.TINYINT, 1);
				storedProcedure.addInParam("@i_empresa", Types.TINYINT,
						filialList.get(filialList.size() - 1).getCode());

				storedProcedure.addResultSetMapper("CatalogList",
						new CobisRowMapper<Catalog>() {
							public Catalog mapRow(ResultSet rs, int rowNum)
									throws SQLException {
								String filial = rs.getString("13351");
								String description = rs
										.getString("Descripcion");
								return new Catalog(filial, description);
							}
						});

				resultMap = storedProcedure.execute();
				List<Catalog> temp = (List<Catalog>) resultMap
						.get("CatalogList");
				filialList.addAll(temp);
				count = temp.size();
			}
			return filialList;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("PORTFOLIOCATALOGMANAGER.003"), ex);
			throw new BusinessException(6900128,
					"No se pudo obtener el catálogo de filiales");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOCATALOGMANAGER.002", "FindAllSubsidiaries"));
		}
	}

	/**
	 * Return all TransactionType available by the core
	 * 
	 * @return List of <tt>Catalog</tt>
	 */
	@SuppressWarnings("unchecked")
	public List<Catalog> findAllTransactionType() {
		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOCATALOGMANAGER.001", "FindAllTransactionType"));
			CobisStoredProcedure storedProcedure = this.storedProcedureUtils
					.getStoredProcedureInstance();
			storedProcedure.setDatabase("cob_cartera");
			storedProcedure.setName("sp_tiptran");
			storedProcedure.setSkipUndeclaredResults(true);

			this.storedProcedureUtils.setContextParameters(DATABASE_NAME,
					storedProcedure);

			storedProcedure.addInParam("@t_trn", Types.SMALLINT, 7112);
			storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "F");

			storedProcedure.addResultSetMapper("TransactionTypeList",
					new CobisRowMapper<Catalog>() {
						public Catalog mapRow(ResultSet rs, int rowNum)
								throws SQLException {
							String ttCode = rs.getString("Codigo");
							String ttdescription = rs.getString("Descripcion");
							return new Catalog(ttCode, ttdescription);
						}
					});

			Map<String, Object> resultMap = storedProcedure.execute();
			return (List<Catalog>) resultMap.get("TransactionTypeList");
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("PORTFOLIOCATALOGMANAGER.004"), ex);
			throw new BusinessException(6900129,
					"No se pudo obtener el catálogo de de tipo de transacciónes");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOCATALOGMANAGER.002", "FindAllTransactionType"));
		}
	}

	/**
	 * Return all the status available by the core
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Catalog> findAllStatus() {
		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOCATALOGMANAGER.001", "FindAllStatus"));
			CobisStoredProcedure storedProcedure = this.storedProcedureUtils
					.getStoredProcedureInstance();
			storedProcedure.setDatabase("cob_fpm");
			storedProcedure.setName("sp_estados_fpm");
			storedProcedure.setSkipUndeclaredResults(true);

			this.storedProcedureUtils.setContextParameters(DATABASE_NAME,
					storedProcedure);

			// Add parameters of business
			storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "H");
			storedProcedure.addInParam("@t_trn", Types.SMALLINT, 7131);

			// Define as return the ResultSet
			storedProcedure.addResultSetMapper("StatusList",
					new CobisRowMapper<Catalog>() {
						public Catalog mapRow(ResultSet rs, int rowNum)
								throws SQLException {
							String statusDescription = rs.getString("233403");
							Integer statusId = rs.getInt("233405");
							return new Catalog(String.valueOf(statusId),
									statusDescription);
						}
					});

			Map<String, Object> resultMap = storedProcedure.execute();
			return (List<Catalog>) resultMap.get("StatusList");
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("PORTFOLIOCATALOGMANAGER.005"), ex);
			throw new BusinessException(6900130,
					"No se pudo obtener el catálogo de tipo de estados");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOCATALOGMANAGER.002", "FindAllStatus"));
		}
	}

	/**
	 * Return description of an specific status id available by the core
	 * 
	 * @return
	 */
	public String findStatusByCode(int code) {
		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOCATALOGMANAGER.001", "FindStatusByCode"));
			String description = "";
			List<Catalog> desc = findAllStatus();

			logger.logDebug("desc.size: " + desc.size());
			if (desc.size() > 0) {
				for (Catalog cat : desc)
					if (cat.getCode().equals(String.valueOf(code))) {
						description = cat.getName();
						break;
					}
			}

			logger.logDebug("description: " + description);
			return description;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("PORTFOLIOCATALOGMANAGER.005"), ex);
			throw new BusinessException(6900130,
					"No se pudo obtener el catálogo de tipo de estados");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOCATALOGMANAGER.002", "FindStatusByCode"));
		}
	}

	/**
	 * Return all concepts available by the core
	 * 
	 * @param concept
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Catalog> findAllConcepts() {
		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOCATALOGMANAGER.001", "FindAllConcepts"));
			CobisStoredProcedure storedProcedure = this.storedProcedureUtils
					.getStoredProcedureInstance();
			storedProcedure.setDatabase("cob_cartera");
			storedProcedure.setName("sp_concepto");
			storedProcedure.setSkipUndeclaredResults(true);

			this.storedProcedureUtils.setContextParameters(DATABASE_NAME,
					storedProcedure);

			// Add parameters of business
			storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "H");
			storedProcedure.addInParam("@t_trn", Types.SMALLINT, 7007);
			storedProcedure.addInParam("@i_tipo", Types.VARCHAR, "A");
			storedProcedure.addInParam("@i_modo", Types.TINYINT, 0);

			// Define as return the ResultSet
			storedProcedure.addResultSetMapper("ConceptList",
					new CobisRowMapper<Catalog>() {
						public Catalog mapRow(ResultSet rs, int rowNum)
								throws SQLException {
							String conceptDescription = rs.getString("233170");
							Integer conceptId = rs.getInt("233171");
							return new Catalog(String.valueOf(conceptId),
									conceptDescription);
						}
					});
			Map<String, Object> resultMap = storedProcedure.execute();
			return (List<Catalog>) resultMap.get("ConceptList");
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("PORTFOLIOCATALOGMANAGER.006"), ex);
			throw new BusinessException(6900131,
					"No se pudo obtener el catálogo de de tipo de conceptos");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOCATALOGMANAGER.002", "FindAllConcepts"));
		}
	}

	/**
	 * 
	 * @return
	 */

	@SuppressWarnings("unchecked")
	public List<Catalog> findAllProfiles() {
		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOCATALOGMANAGER.001", "FindAllProfiles"));
			CobisStoredProcedure storedProcedure = this.storedProcedureUtils
					.getStoredProcedureInstance();
			storedProcedure.setDatabase("cob_cartera");
			storedProcedure.setName("sp_estados_man");
			storedProcedure.setSkipUndeclaredResults(true);

			this.storedProcedureUtils.setContextParameters(DATABASE_NAME,
					storedProcedure);

			// Add business parameters
			storedProcedure.addInParam("@t_trn", Types.SMALLINT, 7043);
			storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "A");
			storedProcedure.addInParam("@i_perfil", Types.VARCHAR, "0");

			// Define the return values in ResultSet
			storedProcedure.addResultSetMapper("ProfileList",
					new CobisRowMapper<Catalog>() {
						public Catalog mapRow(ResultSet rs, int rowNum)
								throws SQLException {
							String profile = rs.getString("Perfil");
							String description = rs.getString("Descripción");
							return new Catalog(profile, description);
						}
					});
			Map<String, Object> resultMap = storedProcedure.execute();
			List<Catalog> profileList = (List<Catalog>) resultMap
					.get("ProfileList");

			int count = profileList.size();

			while (count >= ROW_COUNT) {

				storedProcedure = this.storedProcedureUtils
						.getStoredProcedureInstance();
				storedProcedure.setDatabase("cob_cartera");
				storedProcedure.setName("sp_estados_man");
				storedProcedure.setSkipUndeclaredResults(true);

				this.storedProcedureUtils.setContextParameters(DATABASE_NAME,
						storedProcedure);

				// Add business parameters
				storedProcedure.addInParam("@t_trn", Types.SMALLINT, 7043);
				storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "A");
				storedProcedure.addInParam("@i_perfil", Types.VARCHAR,
						profileList.get(profileList.size() - 1).getCode());

				// Define the return values in ResultSet
				storedProcedure.addResultSetMapper("ProfileList",
						new CobisRowMapper<Catalog>() {
							public Catalog mapRow(ResultSet rs, int rowNum)
									throws SQLException {
								String profile = rs.getString("Perfil");
								String description = rs.getString("Descripción");
								return new Catalog(profile, description);
							}
						});
				resultMap = storedProcedure.execute();
				List<Catalog> temp = (List<Catalog>) resultMap
						.get("ProfileList");
				profileList.addAll(temp);
				count = temp.size();
			}
			return profileList;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("PORTFOLIOCATALOGMANAGER.007"), ex);
			throw new BusinessException(6900138,
					"No se pudo obtener el catálogo de perfiles");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOCATALOGMANAGER.002", "FindAllProfile"));
		}
	}
	
	
	/**
	 * Return all the available economic destinations in the core
	 * @return
	 */
	public List<Catalog> findAllEconomicDestinations() {
		return catalogManager.getCatalogsByName(ECONOMIC_DESTINATATION_CATALOG);
	}
	
	/**
	 * Return all the available purposes in the core
	 * @return
	 */
	public List<Catalog> findAllPurposes() {
		return catalogManager.getCatalogsByName(PURPOSE_CATALOG);
	}

	/**
	 * Return all the available economic activities in the core
	 * @return
	 */
	public List<Catalog> findAllEconomicActivities() {
		return catalogManager.getCatalogsByName(ECONOMIC_ACTIVITY_CATALOG);
	}

	/**
	 * @param storedProcedureUtils
	 */
	public void setStoredProcedureUtils(
			CobisStoredProcedureUtils storedProcedureUtils) {
		this.storedProcedureUtils = storedProcedureUtils;
	}

	/**
	 * @param catalogManager the catalogManager to set
	 */
	public void setCatalogManager(ICatalogManager catalogManager) {
		this.catalogManager = catalogManager;
	}
		
}
