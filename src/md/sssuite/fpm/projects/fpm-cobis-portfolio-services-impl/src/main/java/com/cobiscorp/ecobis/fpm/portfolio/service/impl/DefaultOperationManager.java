package com.cobiscorp.ecobis.fpm.portfolio.service.impl;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.bo.PhysicalField;
import com.cobiscorp.ecobis.fpm.model.CoreTable;
import com.cobiscorp.ecobis.fpm.portfolio.bo.OperationData;
import com.cobiscorp.ecobis.fpm.portfolio.model.CreditLineOperationCurrency;
import com.cobiscorp.ecobis.fpm.portfolio.model.CreditOperation;
import com.cobiscorp.ecobis.fpm.portfolio.model.CreditOperationId;
import com.cobiscorp.ecobis.fpm.portfolio.model.DefaultOperation;
import com.cobiscorp.ecobis.fpm.portfolio.model.DefaultOperationId;
import com.cobiscorp.ecobis.fpm.portfolio.model.Operation;
import com.cobiscorp.ecobis.fpm.portfolio.model.OperationTemp;
import com.cobiscorp.ecobis.fpm.portfolio.model.ProcessedOperation;
import com.cobiscorp.ecobis.fpm.portfolio.service.IDefaultOperationManager;
import com.cobiscorp.ecobis.fpm.portfolio.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.portfolio.utils.MessageManager;
import com.cobiscorp.ecobis.fpm.portfolio.utils.PropertiesManager;

public class DefaultOperationManager implements IDefaultOperationManager {

	// region Fields
	/** Cobis Logger */
	private static final ILogger logger = LogFactory.getLogger(DefaultOperationManager.class);

	/** The database separator */
	private static final String CATALOG_SEPARATOR = "..";

	/** Entity Manager injected by the container */
	@PersistenceContext(unitName = "JpaFpmPortfolio")
	private EntityManager entityManager;

	// end-region

	// region Implements IDefaultOperationManager

	/**
	 * Manage <tt>DefaultOperation</tt>.
	 * 
	 * @param operation
	 *            the operation id
	 * @param defaultOperation
	 *            <tt>DefaultOperation</tt>
	 */
	public void manageDefaultOperation(String operation, DefaultOperation defaultOperation) {
		try {

			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.001", "manageDefaultOperation"));

			DefaultOperationId defaultOperationId = new DefaultOperationId(defaultOperation.getOperation(), defaultOperation.getCurrency());

			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.004", defaultOperationId.toString()));

			DefaultOperation existDefaultOperation = entityManager.find(DefaultOperation.class, defaultOperationId);

			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.005", existDefaultOperation));

			if (existDefaultOperation == null && operation.equals(Constants.INSERT_OPERATION)) {
				logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.003", defaultOperation));

				entityManager.persist(defaultOperation);

			} else if (existDefaultOperation != null && operation.equals(Constants.UPDATE_OPERATION)) {

				logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.006", existDefaultOperation.toString()));

				entityManager.merge(defaultOperation);
			} else if (existDefaultOperation != null && operation.equals(Constants.DELETE_OPERATION)) {

				logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.007", existDefaultOperation));

				entityManager.remove(existDefaultOperation);

			}
			entityManager.flush();

		} catch (Exception e) {

			logger.logError(MessageManager.getString("DEFAULTOPERATIONMANAGER.099"), e);
			throw new BusinessException(6904001, "Ocurrió un error al intentar guardar o eliminar la operacion ");

		} finally {

			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.002", "manageDefaultOperation"));

		}
	}

	/**
	 * Validate the execution rules
	 * 
	 * @param type
	 *            Type of operation
	 * 
	 * @return true or false
	 */

	public boolean validateValuePortfolio(String type) {

		try {

			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.001", "validateValuePortfolio"));

			List<String> valuePorFolio = entityManager.createNamedQuery("ValuePortfolio.FindByType", String.class).setParameter("type", type)
					.getResultList();

			return valuePorFolio.size() != 1 ? false : true;

		} catch (NoResultException nre) {

			logger.logError(MessageManager.getString("DEFAULTOPERATIONMANAGER.008"), nre);
			throw nre;

		} catch (Exception e) {

			logger.logError(MessageManager.getString("DEFAULTOPERATIONMANAGER.009"), e);
			throw new BusinessException(6904002, "La regla ejecutada no paso la validación necesaria");

		} finally {

			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.002", "validateValuePortfolio"));

		}
	}

	/**
	 * 
	 * Get operation data
	 * 
	 * @param bank
	 *            Bank Identifier
	 * @return <tt>OperationTemp</tt> object
	 */
	public OperationData getOperationData(String bank) {
		try {

			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.001", "getOperationData"));
			List<OperationTemp> operationTemp = entityManager.createNamedQuery("OperationTemp.FindOperationByBankId", OperationTemp.class)
					.setParameter("bank", bank).getResultList();

			if (operationTemp.size() > 0) {
				return new OperationData(operationTemp.get(0).getOperation(), operationTemp.get(0).gettOperation(), operationTemp.get(0)
						.getInitialDate(), operationTemp.get(0).getSector(), operationTemp.get(0).getCurrency(), operationTemp.get(0).getBank(),
						operationTemp.get(0).getState());
			} else {

				List<Operation> listOperation = entityManager.createNamedQuery("Operation.FindOperationByBankId", Operation.class)
						.setParameter("bank", bank).getResultList();

				if (listOperation.size() > 0) {
					return new OperationData(listOperation.get(0).getOperation(), listOperation.get(0).gettOperation(), listOperation.get(0)
							.getInitialDate(), listOperation.get(0).getSector(), listOperation.get(0).getCurrency(), listOperation.get(0).getBank(),
							listOperation.get(0).getState());
				} else {
					return null;
				}
			}

		} catch (Exception e) {

			logger.logError(MessageManager.getString("DEFAULTOPERATIONMANAGER.010"), e);
			throw new BusinessException(6904003, "Ocurrió un problema al intentar consultar la operación");
		} finally {

			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.002", "getOperationData"));
		}
	}

	/**
	 * Gets the code create operation.
	 * 
	 * @param operationId
	 *            the operation id
	 * @return the code create operation
	 */
	public Integer getCodeCreateOperation(String operationId) {
		try {

			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.001", "getCodeCreateOperation"));

			List<Integer> codeList = entityManager.createNamedQuery("OperationTemp.FindCodeOperation", Integer.class)
					.setParameter("tOperation", operationId).getResultList();

			if (codeList.size() > 0)
				return codeList.get(0);
			else
				return -1;

		} catch (NoResultException nre) {

			logger.logError(MessageManager.getString("DEFAULTOPERATIONMANAGER.011"), nre);
			throw nre;
		} catch (Exception e) {
			logger.logError(MessageManager.getString("DEFAULTOPERATIONMANAGER.099"), e);
			throw new BusinessException(6904004, "No se encotró el código de la operación creada.Comuniquese con el administrador");

		} finally {
			//
			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.002", "getCodeCreateOperation"));
		}
	}

	/**
	 * Gets the code create operation.
	 * 
	 * @param operationId
	 *            the operation id
	 * @return the code create operation
	 */
	public Integer getCodeCreateOperationDef(String operationId) {
		try {

			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.001", "getCodeCreateOperationDef"));

			List<Integer> codeList = entityManager.createNamedQuery("Operation.FindCodeOperation", Integer.class)
					.setParameter("tOperation", operationId).getResultList();

			if (codeList.size() > 0)
				return codeList.get(0);
			else
				return -1;

		} catch (NoResultException nre) {

			logger.logError(MessageManager.getString("DEFAULTOPERATIONMANAGER.011"), nre);
			throw nre;
		} catch (Exception e) {
			logger.logError(MessageManager.getString("DEFAULTOPERATIONMANAGER.099"), e);
			throw new BusinessException(6904004, "No se encotró el código de la operación creada.Comuniquese con el administrador");

		} finally {
			//
			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.002", "getCodeCreateOperationDef"));
		}
	}

	/**
	 * Update operation create .
	 * 
	 * @param codeCreateOperationId
	 *            the code identifier for operation create
	 * @param tOperation
	 *            value for update
	 */
	public Integer updateCreateOperation(Integer codeCreateOperationId, String tOperation) {
		try {

			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.001", "updateCreateOperation"));

			OperationTemp operationTemp = entityManager.createNamedQuery("OperationTemp.FindSpecificOperation", OperationTemp.class)
					.setParameter("operation", codeCreateOperationId).getSingleResult();

			if (operationTemp != null) {

				operationTemp.settOperation(tOperation);
				entityManager.flush();
				return 1;
			} else {
				logger.logError("La consulta de una operación especifica no arrojo resultados");
				return 0;
			}

		} catch (NoResultException nre) {

			logger.logError(MessageManager.getString("DEFAULTOPERATIONMANAGER.013"), nre);
			return 0;

		} catch (Exception e) {
			logger.logError(MessageManager.getString("DEFAULTOPERATIONMANAGER.012"), e);
			throw new BusinessException(6904006, "Ocurrió un error al intentar actualizar la operación");

		} finally {

			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.002", "updateCreateOperation"));
		}
	}

	/**
	 * Update OperationDef .
	 * 
	 * @param codeCreateOperationId
	 *            the code identifier for operation create
	 * @param tOperation
	 *            value for update into ca_operacion table
	 */

	public void updateCreateOperationDef(Integer codeCreateOperationId, String tOperation) {
		try {

			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.001", "updateCreateOperationDef"));

			Operation operationDef = entityManager.createNamedQuery("Operation.FindSpecificOperation", Operation.class)
					.setParameter("operation", codeCreateOperationId).getSingleResult();

			if (operationDef != null) {
				operationDef.settOperation(tOperation);
				entityManager.flush();
			} else {
				logger.logError("La consulta de una operación especifica no arrojo resultados");
			}

		} catch (NoResultException nre) {
			logger.logError(MessageManager.getString("DEFAULTOPERATIONMANAGER.013"), nre);

		} catch (Exception e) {
			logger.logError(MessageManager.getString("DEFAULTOPERATIONMANAGER.014"), e);
			throw new BusinessException(6904008, "Ocurrió un problema con la actualización de la operación");

		} finally {

			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.002", "updateCreateOperationDef"));
		}

	}

	// end-region

	/**
	 * Create the operation information in the credit catalog
	 * 
	 * @param operationCode
	 *            operation code - banking product identifier
	 * @param product
	 *            COBIS product
	 * @param description
	 *            operation description - banking product name
	 */
	public void createCreditOperation(String operationCode, String product, String description, String status) {
		try {
			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.001", "createCreditOperation"));
			CreditOperation creditOperation = entityManager.find(CreditOperation.class, new CreditOperationId(operationCode, product));
			if (creditOperation == null) {
				CreditOperation newOperation = new CreditOperation(operationCode);
				newOperation.setProduct(product);
				newOperation.setDescription(description);
				newOperation.setModificationDate(new Date());
				newOperation.setStatus(status);
				entityManager.persist(newOperation);
			} else {
				creditOperation.setDescription(description);
				creditOperation.setModificationDate(new Date());
				creditOperation.setStatus(status);
			}
		} catch (Exception e) {
			logger.logError(MessageManager.getString("DEFAULTOPERATIONMANAGER.015"), e);
			throw new BusinessException(6900183, "Ocurrio un error al crear la operacion en el modulo de crédito.");
		} finally {
			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.002", "createCreditOperation"));
		}
	}

	/**
	 * Change operation name in the cr_tramite
	 * 
	 * @param operationOld
	 *            Old operation name
	 * @param operationNew
	 *            New operation name
	 */
	public void findAndChangeProcessedOperation(String operationOld, String operationNew) {

		List<ProcessedOperation> processedeList = entityManager
				.createNamedQuery("ProcessedOperation.FindProcessedOperation", ProcessedOperation.class).setParameter("operation", operationOld)
				.getResultList();

		if (processedeList.size() > 0) {
			processedeList.get(0).setOperation(operationNew);
			entityManager.flush();
		}
	}

	/**
	 * Get the number of days given a dividend
	 * 
	 * @param dividend
	 * @return number of days - Factor
	 */
	public Integer getFactorByDividend(String dividend) {
		@SuppressWarnings("unchecked")
		// Find the dividend in the PORTFOLIO table
		List<Integer> dividends = entityManager
				.createNativeQuery("SELECT td_factor FROM cob_cartera..ca_tdividendo WHERE td_tdividendo = ?1 AND td_estado = 'V'", Integer.class)
				.setParameter(1, dividend).getResultList();
		// Use result list because if there is not a dividend single result
		// throw a exception
		return dividends.isEmpty() ? null : dividends.get(0);
	}

	/**
	 * Modified product value in cr_lin_ope_moneda
	 * 
	 * @param numberBank
	 *            number bank
	 * @param operation
	 *            product id
	 * @param product
	 *            product type
	 * @param purpose
	 *            product purpose
	 * @param currency
	 *            currency product
	 * @param newCreditLineOperation
	 *            new value for operation
	 */
	public void modifiedCreditLineNumberCurrency(String numberBank, String operation, String product, String purpose, int currency,
			String newCreditLineOperation) {

		try {

			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.001", "modifiedCreditLineNumberCurrency"));

			List<Integer> lineNumberList = entityManager.createNamedQuery("CreditLine.FindLine", Integer.class)
					.setParameter("lineNumberBank", numberBank).getResultList();

			if (lineNumberList.size() > 0) {

				String updateCreditLine = "UPDATE cob_credito..cr_lin_ope_moneda SET om_toperacion = ?1 WHERE om_moneda = ?2 AND om_linea = ?3 AND om_producto = ?4 AND om_proposito_op = ?5 AND om_toperacion = ?6";

				entityManager.createNativeQuery(updateCreditLine).setParameter(1, newCreditLineOperation).setParameter(2, currency)
						.setParameter(3, lineNumberList.get(0)).setParameter(4, product).setParameter(5, purpose).setParameter(6, operation)
						.executeUpdate();

				List<CreditLineOperationCurrency> creditLineOperationList = entityManager
						.createNamedQuery("CreditLineOperationCurrency.Find", CreditLineOperationCurrency.class)
						.setParameter("line", lineNumberList.get(0)).setParameter("operation", newCreditLineOperation)
						.setParameter("product", product).setParameter("purpose", purpose).setParameter("currency", currency).getResultList();

				if (creditLineOperationList.size() > 0)
					entityManager.flush();
			}
		} catch (Exception e) {
			logger.logError(MessageManager.getString("DEFAULTOPERATIONMANAGER.099"), e);
			throw new BusinessException(6904999, "Ocurrió un problema durante la ejecución de la operación.Comuniquese con el administrador");
		} finally {

			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.002", "modifiedCreditLineNumberCurrency"));
		}

	}

	/**
	 * Insert the credit operation values used a dynamic insert command given by the FPM metadata
	 * 
	 * @param coreTableInformation
	 */
	public void insertDynamicCreditOperationGeneralParameters(Map<CoreTable, List> coreTableInformation) {

		try {
			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.001", "insertDynamicCreditOperationGeneralParameters"));

			for (CoreTable table : coreTableInformation.keySet()) {
				
				for (Object iterator : coreTableInformation.get(table)) {
					
					StringBuffer insertCommand = new StringBuffer(String.format("INSERT INTO %s%s%s (", table.getDatabase(), CATALOG_SEPARATOR,
							table.getTable()));
					StringBuffer parameters = new StringBuffer(" VALUES (");
					Map<String, PhysicalField> fields = (Map<String, PhysicalField>) iterator;
					int i = 1;
					for (String fieldName : fields.keySet()) {
						insertCommand.append(String.format("%s,", fieldName));
						parameters.append(String.format("?%d,", i++));
					}
					int indexOf = insertCommand.lastIndexOf(",");
					insertCommand.replace(indexOf, indexOf + 1, ")");
					indexOf = parameters.lastIndexOf(",");
					parameters.replace(indexOf, indexOf + 1, ")");
					String dynamicInsert = insertCommand.toString() + parameters.toString();
					logger.logDebug("Insert generado: " + dynamicInsert);
					logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.016",
							dynamicInsert.substring(11, dynamicInsert.indexOf("VALUES ("))));

					Query insertQuery = entityManager.createNativeQuery(dynamicInsert);
					i = 1;
					for (String fieldName : fields.keySet()) {

						PhysicalField physicalField = fields.get(fieldName);
						setParameter(insertQuery, i++, physicalField);

						logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.017", physicalField));
					}

					insertQuery.executeUpdate();
					entityManager.flush();
				}
				
				
			}

		} catch (Exception e) {
			logger.logError(MessageManager.getString("DEFAULTOPERATIONMANAGER.099"), e);
			throw new BusinessException(6904999, "Ocurrió un problema durante la ejecución de la operación.Comuniquese con el administrador");
		} finally {
			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.002", "insertDynamicCreditOperationGeneralParameters"));
		}

	}

	public void insertDynamicCreditOperation(Map<CoreTable, Map<String, PhysicalField>> coreTableInformation) {

		try {
			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.001", "insertDynamicCreditOperation"));

			for (CoreTable table : coreTableInformation.keySet()) {
				StringBuffer insertCommand = new StringBuffer(String.format("INSERT INTO %s%s%s (", table.getDatabase(), CATALOG_SEPARATOR,
						table.getTable()));
				StringBuffer parameters = new StringBuffer(" VALUES (");
				Map<String, PhysicalField> fields = coreTableInformation.get(table);
				int i = 1;
				for (String fieldName : fields.keySet()) {
					insertCommand.append(String.format("%s,", fieldName));
					parameters.append(String.format("?%d,", i++));
				}
				int indexOf = insertCommand.lastIndexOf(",");
				insertCommand.replace(indexOf, indexOf + 1, ")");
				indexOf = parameters.lastIndexOf(",");
				parameters.replace(indexOf, indexOf + 1, ")");
				String dynamicInsert = insertCommand.toString() + parameters.toString();

				logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.016",
						dynamicInsert.substring(11, dynamicInsert.indexOf("VALUES ("))));

				Query insertQuery = entityManager.createNativeQuery(dynamicInsert);
				i = 1;
				for (String fieldName : fields.keySet()) {

					PhysicalField physicalField = fields.get(fieldName);
					setParameter(insertQuery, i++, physicalField);

					logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.017", physicalField));
				}

				insertQuery.executeUpdate();
				entityManager.flush();
			}
		} catch (Exception e) {
			logger.logError(MessageManager.getString("DEFAULTOPERATIONMANAGER.099"), e);
			throw new BusinessException(6904999, "Ocurrió un problema durante la ejecución de la operación.Comuniquese con el administrador");
		} finally {
			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.002", "insertDynamicCreditOperation"));
		}

	}

public void deleteDynamicCreditByProductOpt(String param, String value, String table, String database){
		try{
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString(
						"DEFAULTOPERATIONMANAGER.001", "deleteDynamicCreditByProductOpt"));
			}
			
			if(param != null){
				
				StringBuffer deleteCommand = new StringBuffer(String.format(
						"DELETE FROM %s%s%s WHERE ", database,
						CATALOG_SEPARATOR, table));
				Query deleteQuery = null;
				String dynamicDelete = null;				
				
				deleteCommand.append(param);
				deleteCommand.append(" = '");
				deleteCommand.append(value);
				deleteCommand.append("'");	
											
				dynamicDelete = deleteCommand.toString();
				
				deleteQuery = entityManager
						.createNativeQuery(dynamicDelete);
				
				if(logger.isDebugEnabled()){
				    logger.logDebug("EJECUTA sentencia --> " + dynamicDelete);
				}
				deleteQuery.executeUpdate();
				entityManager.flush();
				
			}
			
		}finally{
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString(
						"DEFAULTOPERATIONMANAGER.002", "deleteDynamicCreditByProductOpt"));
			}
		}
		
	}

	/**
	 * Delete the credit operation values used a dynamic delete command given by the FPM metadata
	 * 
	 * @param coreTableInformation
	 */
	public void deleteDynamicCredit(Map<CoreTable, Map<String, PhysicalField>> coreTableInformation) {

		try {
			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.001", "deleteDynamicCredit"));

			for (CoreTable table : coreTableInformation.keySet()) {
				StringBuffer deleteCommand = new StringBuffer(String.format("DELETE FROM %s%s%s ", table.getDatabase(), CATALOG_SEPARATOR,
						table.getTable()));
				StringBuffer parameters = new StringBuffer(" WHERE ");
				
				if (coreTableInformation.get(table) instanceof Map) {
					
					Map<String, PhysicalField> fields = coreTableInformation.get(table);
					
					int i = 1;
					
					int numberOfRequiredFields=0;
					for (String fieldName : fields.keySet()) {
						//SMO-si el campo es clave primaria forma parte de la sentencia DELETE
						if(fields.get(fieldName).isRequired()){
							numberOfRequiredFields++;
							parameters.append(String.format("%s=?%d and ", fieldName, i++));
						}
					}
					logger.logDebug("numberOfRequiredFields:"+numberOfRequiredFields);
					//SMO-se ejecuta el DELETE solo si hubo requiredFields configurados
					if(numberOfRequiredFields>0){
						int indexOf = parameters.lastIndexOf("and");
						String dynamicDelete = deleteCommand.toString() + parameters.substring(0, indexOf);
						logger.logDebug("sentencia delete usando solo requiredFields>>"+dynamicDelete);
						Query deleteQuery = entityManager.createNativeQuery(dynamicDelete);
						i = 1;
						for (String fieldName : fields.keySet()) {
							if(fields.get(fieldName).isRequired()){
								setParameter(deleteQuery, i++, fields.get(fieldName));
							}
						}
						deleteQuery.executeUpdate();
						entityManager.flush();
					}else{
						logger.logDebug("No se detectan los requiredFields en la petición de la tabla"+table.getDatabase()+"-"+table.getTable());
						i=1;
						//cuando se invoca desde otros lados sin required fields
						//UpdateQrOperationInterceptor
					for (String fieldName : fields.keySet()) {
						parameters.append(String.format("%s=?%d and ", fieldName, i++));
					}
					int indexOf = parameters.lastIndexOf("and");
					String dynamicDelete = deleteCommand.toString() + parameters.substring(0, indexOf);
						logger.logDebug("sentencia delete usando todos los campos>>"+dynamicDelete);
					Query deleteQuery = entityManager.createNativeQuery(dynamicDelete);
					i = 1;
					for (String fieldName : fields.keySet()) {
						setParameter(deleteQuery, i++, fields.get(fieldName));
					}
					deleteQuery.executeUpdate();
					entityManager.flush();
				}
			}
			}
		} catch (Exception e) {
			logger.logError(MessageManager.getString("DEFAULTOPERATIONMANAGER.099"), e);
			throw new BusinessException(6904999, "Ocurrió un problema durante la ejecución de la operación.Comuniquese con el administrador");
		} finally {
			logger.logDebug(MessageManager.getString("DEFAULTOPERATIONMANAGER.002", "deleteDynamicCredit"));
		}
	}

@Override
	public void deleteDynamicCreditUnique(
			Map<CoreTable, Map<String, PhysicalField>> coreTableInformation,
			Map<String, List<PhysicalField>> deleteSentencesExecuted) {

		try {
			logger.logDebug(MessageManager.getString(
					"DEFAULTOPERATIONMANAGER.001", "deleteDynamicCredit sin delete repetidos"));

			for (CoreTable table : coreTableInformation.keySet()) {

				StringBuffer deleteCommand = new StringBuffer(String.format(
						"DELETE FROM %s%s%s ", table.getDatabase(),
						CATALOG_SEPARATOR, table.getTable()));
				StringBuffer parameters = new StringBuffer(" WHERE ");
				Query deleteQuery = null;
				String dynamicDelete = "";
				List<PhysicalField> fieldsToValidate = new ArrayList<PhysicalField>();

				if (coreTableInformation.get(table) instanceof Map) {

					Map<String, PhysicalField> fields = coreTableInformation
							.get(table);

					int i = 1;

					int numberOfRequiredFields = 0;
					for (String fieldName : fields.keySet()) {
						// SMO-si el campo es clave primaria forma parte de la
						// sentencia DELETE
						if (fields.get(fieldName).isRequired()) {
							numberOfRequiredFields++;
							parameters.append(String.format("%s=?%d and ",
									fieldName, i++));
						}
					}
					logger.logDebug("numberOfRequiredFields:"
							+ numberOfRequiredFields);
					// SMO-se ejecuta el DELETE solo si hubo requiredFields
					// configurados
					if (numberOfRequiredFields > 0) {
						int indexOf = parameters.lastIndexOf("and");
						dynamicDelete = deleteCommand.toString()
								+ parameters.substring(0, indexOf);
						logger.logDebug("sentencia delete usando required fields>>"
								+ dynamicDelete);
						fieldsToValidate.clear();
						deleteQuery = entityManager
								.createNativeQuery(dynamicDelete);
						i = 1;
						for (String fieldName : fields.keySet()) {
							if (fields.get(fieldName).isRequired()) {
								setParameter(deleteQuery, i++,
										fields.get(fieldName));
								fieldsToValidate.add(fields.get(fieldName));
							}
						}
					}else{
						logger.logDebug("No se detectan los requiredFields en la petición de la tabla"
								+ table.getDatabase() + "-" + table.getTable());
						i=1;
						// cuando se invoca desde otros lados sin required
						// fields
						//UpdateQrOperationInterceptor
					for (String fieldName : fields.keySet()) {
							parameters.append(String.format("%s=?%d and ",
									fieldName, i++));
					}
					int indexOf = parameters.lastIndexOf("and");
						dynamicDelete = deleteCommand.toString()
								+ parameters.substring(0, indexOf);
						logger.logDebug("sentencia delete usando todos los campos>>"
								+ dynamicDelete);
						fieldsToValidate.clear();
						deleteQuery = entityManager
								.createNativeQuery(dynamicDelete);
					i = 1;
					for (String fieldName : fields.keySet()) {
							setParameter(deleteQuery, i++,
									fields.get(fieldName));
							fieldsToValidate.add(fields.get(fieldName));
					}
					}
					if (!isRepeatedSentence(deleteSentencesExecuted,
							dynamicDelete, fieldsToValidate)) {
					deleteQuery.executeUpdate();
					entityManager.flush();
						deleteSentencesExecuted.put(dynamicDelete,
								fieldsToValidate);
						if(logger.isDebugEnabled()){
						logger.logDebug("EJECUTA sentencia delete>>"
								+ dynamicDelete);
						}
					} else {
						if(logger.isDebugEnabled()){
						logger.logDebug("NO EJECUTA sentencia delete>>"
								+ dynamicDelete);
				}
			}
			}
			}
		} catch (Exception e) {
			logger.logError(MessageManager.getString("DEFAULTOPERATIONMANAGER.099"), e);
			throw new BusinessException(6904999, "Ocurrió un problema durante la ejecución de la operación.Comuniquese con el administrador");
		} finally {
			logger.logDebug(MessageManager.getString(
					"DEFAULTOPERATIONMANAGER.002", "deleteDynamicCredit sin delete repetidos"));
		}
	}

	private boolean isRepeatedSentence(
			Map<String, List<PhysicalField>> deleteSentencesExecuted,
			String dynamicQuery, List<PhysicalField> fieldsToValidate) {

		List<PhysicalField> fieldsInDeleted = deleteSentencesExecuted
				.get(dynamicQuery);
		if(logger.isDebugEnabled()){
			logger.logDebug("sentencia a validar>>"+dynamicQuery);
			logger.logDebug("claves de deleteSentencesExecuted>>"+deleteSentencesExecuted.keySet());
			logger.logDebug("mapaCompleto de deleteSentencesExecuted>>"+deleteSentencesExecuted.keySet());
		}
		// si no existe en query repetido
		if (fieldsInDeleted == null) {
			if(logger.isDebugEnabled()){
				logger.logDebug("retorna false porque no encuentra la sentencia en el mapa");
			}
			return false;
		} else {
			if(logger.isDebugEnabled()){
				logger.logDebug("fields a validar>>"+fieldsToValidate);
				logger.logDebug("fields del mapa>>"+fieldsInDeleted);
			// si el query se repite incluso tiene los mismos campos, solo
			// validamos los valores de dichos campos para concluir que se
			// repite la sentencia
			}
			int iguales=0;
			for (PhysicalField fieldToValidate : fieldsToValidate) {
				for (PhysicalField fieldInDeleted : fieldsInDeleted) {
					if (fieldToValidate.getFieldId() == fieldInDeleted
							.getFieldId()) {
						if (fieldToValidate.getValue().equals(
								fieldInDeleted.getValue())) {
							iguales++;
						}
					}
				}
						}
			if(iguales==fieldsToValidate.size()){
				if(logger.isDebugEnabled()){
					logger.logDebug("todos son iguales");
					}
				return true;
			}else{
				if(logger.isDebugEnabled()){
					logger.logDebug("no son iguales");
		}
				return false;
	}
		}


	}

	private void setParameter(Query q, int index, PhysicalField physicalField) {
		
		if(logger.isDebugEnabled()){
			logger.logDebug("physicalField --> " + physicalField);
		}
		
		String type = physicalField.getDataType().replaceAll("\\([^\\(]*\\)", "");
		String javaType = PropertiesManager.getProperty(type, "String");
		String value = physicalField.getValue();
		if (javaType.equals("String")) {
			setString(q, index, value);
		} else if (javaType.equals("Integer")) {
			setInt(q, index, value);
		} else if (javaType.equals("BigInteger")) {
			setBigInteger(q, index, value);
		} else if (javaType.equals("BigDecimal")) {
			setBigDecimal(q, index, value);
		} else if (javaType.equals("Boolean")) {
			setBoolean(q, index, value);
		} else if (javaType.equals("Float")) {
			setFloat(q, index, value);
		} else if (javaType.equals("Double")) {
			setDouble(q, index, value);
		}
	}

	private void setString(Query q, int index, String value) {
		q.setParameter(index, value == null ? "" : value);
	}

	private void setInt(Query q, int index, String value) {
		q.setParameter(index, value == null ? 0 : new Integer(value));
	}

	private void setBigInteger(Query q, int index, String value) {
		q.setParameter(index, value == null ? 0 : new BigInteger(value));
	}

	private void setBigDecimal(Query q, int index, String value) {
		q.setParameter(index, value == null ? 0.0 : new BigDecimal(value));
	}

	private void setBoolean(Query q, int index, String value) {
		q.setParameter(index, value == null ? false : new Boolean(value));
	}

	private void setDouble(Query q, int index, String value) {
		q.setParameter(index, value == null ? 0.0 : new Double(value));
	}

	private void setFloat(Query q, int index, String value) {
		q.setParameter(index, value == null ? 0.0F : new Float(value));
	}

}
