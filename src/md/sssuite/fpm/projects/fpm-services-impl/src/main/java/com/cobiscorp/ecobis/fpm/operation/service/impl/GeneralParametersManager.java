/*
 * File: GeneralParametersManager.java
 * Date: November 12, 2011
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
package com.cobiscorp.ecobis.fpm.operation.service.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.bo.GeneralParameterValueLog;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.Company;
import com.cobiscorp.ecobis.fpm.model.FieldValue;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValues;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesId;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.operation.service.IGeneralParametersManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

/**
 * This service manage all the operations related to the general parameters of a
 * banking product
 * 
 * @author cloachamin
 */
public class GeneralParametersManager implements IGeneralParametersManager {

	/** COBIS Logger */
	private static final ILogger logger = LogFactory
			.getLogger(BankingProductManager.class);
	/** Service that manage the operations over a banking product */
	private IBankingProductManager bankingProductService;

	/** Entity Manager injected by the container */
	private EntityManager em;

	/**
	 * Get the general parameters values of a banking product
	 * 
	 * @param productId
	 *            The banking product identifier
	 * @return list of <tt>GeneralParametersValues</tt>
	 */
	public List<GeneralParametersValues> getValuesByBankingProduct(
			String productId) {
		try {
			logger.logDebug(MessageManager
					.getString("GENERALPARAMETERSMANAGER.001",
							"getValuesByBankingProduct"));
			return em
					.createNamedQuery("GeneralParametersValues.findByProduct",
							GeneralParametersValues.class)
					.setParameter("productId", productId).getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.003", productId), ex);
			throw new BusinessException(
					6900071,
					"No se pudo obtener los parámetros generales del producto bancario seleccionado");
		} finally {
			logger.logDebug(MessageManager
					.getString("GENERALPARAMETERSMANAGER.002",
							"getValuesByBankingProduct"));
		}
	}

	/**
	 * This method store the general parameters values for the given product id,
	 * update the values for the child banking products and change the inherited
	 * parent for the value to store
	 * 
	 * @param productId
	 *            <tt>BankingProduct</tt> identifier
	 * @param values
	 *            List of <tt>GeneralParametersValues</tt> that contains the
	 *            information of the values
	 */
	public void saveGeneralParametersValues(String productId,
			ArrayList<GeneralParametersValues> updateValues, Boolean isFinished) {
		try {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.001",
					"saveGeneralParametersValues"));
			// The list that contains all the banking products available to set
			// history
			String valueTmp = "";
			Set<String> availableBP = new HashSet<String>();
			BankingProduct bp = em.find(BankingProduct.class, productId);
			if (bp == null) {
				logger.logError(MessageManager.getString(
						"BANKINGPRODUCTMANAGER.007", productId));
				throw new BusinessException(6900060,
						"No se pudo obtener el producto bancario indicado, puesto que no existe.");
			}
			if (bp.getAvailable().equals(Constants.YES)) {
				availableBP.add(productId);
			}
			List<GeneralParametersValues> actualValues = getAllGeneralParametersByProduct(productId);
			// Search for the modified values
			for (GeneralParametersValues value : actualValues) {
				logger.logDebug("Enter to Actual values");
				if (updateValues.contains(value)) {
					logger.logDebug("Enter to contains values");
					GeneralParametersValues updateValue = updateValues
							.get(updateValues.indexOf(value));
					valueTmp = value.getValue();
					value.setValue(updateValue.getValue());
					value.setRuleId(updateValue.getRuleId());
					value.setRuleName(updateValue.getRuleName());
					value.setDescription(updateValue.getDescription());
					value.setTemporalValue(updateValue.getValue());

					if (updateValue.getInheritedFrom() != null) {
						if (valueTmp.equals(updateValue.getValue()))
							value.setInheritedFrom(updateValue
									.getInheritedFrom());
						else
							value.setInheritedFrom(productId);
						createGeneralParemetersValuesInChildren(productId,
								value, availableBP);
					} else {
						// Update the values for the child products
						value.setInheritedFrom(productId);
						createGeneralParemetersValuesInChildren(productId,
								value, availableBP);
					}
				} else {
					logger.logDebug("Enter to no contains values");

					// Update value to empty in order to delete this value on
					// child
					value.setTemporalValue("");
					value.setInheritedFrom(productId);
					createGeneralParemetersValuesInChildren(productId, value,
							availableBP);
					// Remove if value is empty
					em.remove(value);
					em.flush();
				}
			}
			// Search for new values
			for (GeneralParametersValues value : updateValues) {
				logger.logDebug("updatevalue:" + value.getValue());
				if (!actualValues.contains(value)) {
					value.setInheritedFrom(productId);
					// Not persist if value is empty
					if (value != null && value.getValue() != null
							&& !value.getValue().trim().isEmpty())
						em.persist(value);
					createGeneralParemetersValuesInChildren(productId, value,
							availableBP);
				}
			}
			em.flush();
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.004", productId), ex);
			throw new BusinessException(6900072,
					"No se pudo guardar los parámetros generales.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.002",
					"saveGeneralParametersValues"));
		}
	}

	private void createGeneralParemetersValuesInChildren(String productId,
			GeneralParametersValues value, Set<String> availableBP) {
		List<Object[]> productChildrenIdList = em
				.createNamedQuery("BankingProduct.findAllChildrenId",
						Object[].class)
				.setParameter("bankingProductId", productId).getResultList();
		for (Object[] information : productChildrenIdList) {
			String id = information[0].toString();
			BankingProduct bp = em.find(BankingProduct.class, id);
			if (bp.getNodeTypeCategory().getNodeTypeProduct().getId() == 5
					&& bp.getAuthorization().equals(Constants.YES))
				continue;
			else {
				GeneralParametersValues gp = em.find(
						GeneralParametersValues.class,
						new GeneralParametersValuesId(value
								.getDictionaryFieldId(), id, value.getValue()));
				if (gp == null) {
					// Not persist if value is empty
					if (!value.getValue().trim().isEmpty()) {
						gp = new GeneralParametersValues(value.getValue(),
								value.getDictionaryFieldId(), id);
						gp.setInheritedFrom(value.getInheritedFrom());
						em.persist(gp);
					}
				} else {
					// Remove if value is empty
					
					if (value.getTemporalValue() != null && value.getTemporalValue().trim().isEmpty()) {
						em.remove(gp);
						em.flush();
					} else {
						if (!(gp.getValue().equals(value.getValue()) && gp
								.getInheritedFrom().equals(
										value.getInheritedFrom()))) {
							gp.setValue(value.getValue());
							gp.setInheritedFrom(value.getInheritedFrom());
						}
					}
				}
				if (information[1] != null
						&& information[1].toString().equals(Constants.NO)) {
					availableBP.add(id);
				}
				createGeneralParemetersValuesInChildren(id, value, availableBP);
			}
		}
	}

	/**
	 * Save the history records for the banking product at given date .
	 * 
	 * @param bankingProductHistoryId
	 *            <tt>then sequential number of BankingProductHistory</tt>
	 */
	public void createGenearalParametersHistory(BankingProductHistory bankingProductHistorId, String authorizationStatus) {
		BankingProductHistory bphistory = new BankingProductHistory();
		try {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.001", "saveHistory"));

			//bphistory = em.find(BankingProductHistory.class, bankingProductHistorId);
			bphistory = bankingProductHistorId;
			

			List<GeneralParametersValues> gpValues = getAllGeneralParametersByProduct(bphistory
					.getProductId());
			for (GeneralParametersValues gpValue : gpValues) {
				GeneralParametersValuesHistory history = new GeneralParametersValuesHistory(
						gpValue);
				history.getBankingProductHistory().setId(bphistory.getId());
				history.setProcessDate(new SimpleDateFormat(
						Constants.PROCESS_DATE_FORMAT).parse(ContextManager
						.getContext().getProcessDate()));
				em.persist(history);
			}
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.006", bphistory.getProductId()),
					eee);
			throw new BusinessException(6900074,
					"No se pudo guardar el histórico de parámetros generales, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.005", bphistory.getProductId()),
					ex);
			throw new BusinessException(6900073,
					"No se pudo guardar el histórico de parámetros generales.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.002", "saveHistory"));
		}
	}

	public Boolean isBankingProductAvailable(String productId) {
		try {
			logger.logDebug(MessageManager
					.getString("GENERALPARAMETERSMANAGER.001",
							"isBankingProductAvailable"));
			// check if the productId is correct
			BankingProduct bp = em.find(BankingProduct.class, productId);
			if (bp == null) {
				logger.logError(MessageManager.getString(
						"BANKINGPRODUCTMANAGER.007", productId));
				throw new BusinessException(6900060,
						"No se pudo obtener el producto bancario indicado, puesto que no existe");
			}
			long nodeTypeCategoryId = bankingProductService
					.getCategoryIdKeepDictionaryFromParents(productId);
			Company company = bp.getCompany();
			Long fieldsCount = 0l;
			while (company != null) { // For all the hierarchy of the companies
				// count the number of dictionary fields
				Long fieldsCountCompany = em
						.createNamedQuery(
								"DictionaryField.countAllByDictionary",
								Long.class)
						.setParameter("companyId", company.getId())
						.setParameter("nodeTypeCategoryId", nodeTypeCategoryId)
						// The category parent that keep dictionary
						.setParameter("type",
								Constants.GENERAL_PARAMETERS_DICTIONARY)
						.getSingleResult();
				fieldsCount += fieldsCountCompany;
				company = company.getParent();
			}
			Long generalParametersCount = em
					.createNamedQuery(
							"GeneralParametersValues.countAllFieldsByProduct",
							Long.class).setParameter("productId", productId)
					.getSingleResult();

			return fieldsCount.equals(generalParametersCount);
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.007", productId), ex);
			throw new BusinessException(
					6900075,
					"No se pudo determinar si el producto bancario seleccionado está disponible para la venta");
		} finally {
			logger.logDebug(MessageManager
					.getString("GENERALPARAMETERSMANAGER.002",
							"isBankingProductAvailable"));
		}
	}

	/**
	 * Create the inherited general parameters for a new banking product
	 * 
	 * @param productId
	 *            <tt>BankingProduct</tt> identifier
	 */
	public void createGeneralParametersForNewBankingProduct(String productId) {
		try {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.001",
					"createGeneralParametersForNewBankingProduct"));
			// check if the productId is correct
			BankingProduct bp = em.find(BankingProduct.class, productId);
			if (bp == null) {
				logger.logError(MessageManager.getString(
						"BANKINGPRODUCTMANAGER.007", productId));
				throw new BusinessException(6900060,
						"No se pudo obtener el producto bancario indicado, puesto que no existe");
			}
			// If it banking product has no parent
			if (bp.getParentnode() == null)
				return;
			List<GeneralParametersValues> gpValues = getAllGeneralParametersByProduct(bp
					.getParentnode());
			for (GeneralParametersValues gpValue : gpValues) {
				GeneralParametersValues newValue = new GeneralParametersValues(
						gpValue.getValue(), gpValue.getDictionaryFieldId(),
						productId);
				newValue.setInheritedFrom(gpValue.getInheritedFrom());
				em.persist(newValue);
			}
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("GENERALPARAMETERSMANAGER.008"),
					ex);
			throw new BusinessException(
					6900076,
					"No se pudo crear los parámetros generales heredados para el nuevo producto bancario");
		} finally {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.002",
					"createGeneralParametersForNewBankingProduct"));
		}
	}

	/**
	 * Obtains the date for the historical record.
	 * 
	 * @param operationDate
	 *            the system date
	 * @return the date history
	 */
	public Date getDateHistory(Date operationDate, String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString(
						"GENERALPARAMETERSMANAGER.001", "getDateHistory"));
			}

			DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
			String dateOperation = dateFormat.format(operationDate);
			Date dateSearch = new SimpleDateFormat("MM/dd/yyyy")
					.parse(dateOperation);

			if(logger.isDebugEnabled()){
				logger.logDebug("DAETSEARCH: " + dateSearch);
			}
			BankingProductHistory bankingProductHistory = em
					.createNamedQuery(
							"BankingProductHistory.FindByDateAndProductOpt",
							BankingProductHistory.class)
					.setParameter("systemDateId", dateSearch)
					.setParameter("productId", bankingProductId)
					.getSingleResult();


			// bankingProductHistory=bankingProductService.getLatestHistorical(bankingProductId);

			if (bankingProductHistory != null) {
				if (bankingProductHistory.getAvailable().equals("S")) {
					if(logger.isDebugEnabled()){
						logger.logDebug("FECHA HISOTRICO " + bankingProductHistory.getSystemDateId());
					}

					return bankingProductHistory.getSystemDateId();

				} else {
					return null;
				}
			} else {
				return null;
			}

		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("GENERALPARAMETERSMANAGER.009"),
					ex);
			throw new BusinessException(6900077,
					"No se pudo obtener la fecha para el registro de históricos");

		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString(
						"GENERALPARAMETERSMANAGER.002", "getDateHistory"));
			}
		}
	}

	/**
	 * Gets the historical records for general parameters.
	 * 
	 * @param systemDateHistory
	 *            the date history
	 * @param bankingProductId
	 *            the banking product id
	 * @return the general parameters by system date
	 */
	public List<GeneralParametersValuesHistory> getGeneralParametersBySystemDate(
			Date systemDateHistory, String bankingProductId) {
		try {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.001",
					"getGeneralParametersBySystemDate"));
			return em
					.createNamedQuery(
							"GeneralParametersValuesHistory.FindAllByDate",
							GeneralParametersValuesHistory.class)
					.setParameter("systemDate", systemDateHistory)
					.setParameter("productId", bankingProductId)
					.getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.010",
					systemDateHistory.toString()), ex);
			throw new BusinessException(6900078,
					"No se pudo obtener los parámetros generales para la fecha seleccionada");
		} finally {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.002",
					"getGeneralParametersBySystemDate"));
		}
	}

	/**
	 * Get all general parameters related to the given banking product
	 * 
	 * @param productId
	 *            <tt>BankingProduct</tt> identifier
	 * @return The list of <tt>GeneralParametersValues</tt> found
	 */
	public List<GeneralParametersValues> getAllGeneralParametersByProduct(
			String productId) {
		try {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.001",
					"getAllGeneralParametersByProduct"));
			return em
					.createNamedQuery(
							"GeneralParametersValues.findAllFieldsByProduct",
							GeneralParametersValues.class)
					.setParameter("productId", productId).getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.003", productId), ex);
			throw new BusinessException(
					6900071,
					"No se pudo obtener los parámetros generales del producto bancario seleccionado");
		} finally {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.002",
					"getAllGeneralParametersByProduct"));
		}
	}

	/**
	 * Get the changes made in the general parameter values
	 * 
	 * @param productId
	 *            <tt>BankingProduct</tt> identifier
	 * @return Map with the before and after values
	 */
	// Foreach
	public Map<String, List<GeneralParameterValueLog>> getValuesChanges(
			String productId) {
		try {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.001", "getChanges"));
			List<GeneralParameterValueLog> listGeneralParamLog = new ArrayList<GeneralParameterValueLog>();
			List<GeneralParametersValues> listGeneralParam = em
					.createNamedQuery("GeneralParametersValues.findLog",
							GeneralParametersValues.class)
					.setParameter("productId", productId).getResultList();
			if (listGeneralParam != null) {
				List<Long> ids = new ArrayList<Long>();
				for (GeneralParametersValues generalParameterValue : listGeneralParam) {
					ids.add(generalParameterValue.getDictionaryField().getId());
				}
				List<FieldValue> listFiedValues = em
						.createNamedQuery(
								"FieldValue.findAllByGeneralParameter",
								FieldValue.class)
						.setParameter("paramFields", ids).getResultList();
				if (listFiedValues != null) {
					Map<Long, FieldValue> mapFieldsValues = new HashMap<Long, FieldValue>();
					for (FieldValue fieldValue : listFiedValues) {
						mapFieldsValues.put(fieldValue.getFieldsId(),
								fieldValue);
					}
					for (GeneralParametersValues fieldGeneral : listGeneralParam) {
						FieldValue field = mapFieldsValues.get(fieldGeneral
								.getDictionaryFieldId());
						if (field != null) {
							GeneralParameterValueLog val = new GeneralParameterValueLog(
									fieldGeneral.getDictionaryField().getName(),
									fieldGeneral.getValue(), field
											.getDescription(), fieldGeneral
											.getRuleName());
							listGeneralParamLog.add(val);
						}
					}

				}
			}
			// Create the map for the changes
			Map<String, List<GeneralParameterValueLog>> changes = new HashMap<String, List<GeneralParameterValueLog>>();
			changes.put(Constants.AFTER_VALUE, listGeneralParamLog);
			// em.createNamedQuery("GeneralParametersValues.findLog",
			// GeneralParameterValueLog.class)
			// .setParameter("productId", productId)
			// .getResultList());
			logger.logDebug("Numero de parámetros actuales: "
					+ changes.get(Constants.AFTER_VALUE).size());
			BankingProductHistory bph = bankingProductService
					.getLatestHistorical(productId);
			// If there is not a historical
			if (bph == null) {
				changes.put(Constants.BEFORE_VALUE,
						new ArrayList<GeneralParameterValueLog>());
				return changes;
			}
			changes.put(Constants.BEFORE_VALUE, buildGeneralParametersLog(bph));
			logger.logDebug("Numero de parámetros anteriores: "
					+ changes.get(Constants.BEFORE_VALUE).size());
			return changes;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("GENERALPARAMETERSMANAGER.099"),
					ex);
			throw new BusinessException(6900147,
					"Ocurrio un error al obtener los cambios de los parámetros generales.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.002", "getChanges"));
		}
	}

	/**
	 * Get the information related to the general parameters history
	 * 
	 * @param bankingProductHistoryId
	 *            <tt>the sequential number of baking product history</tt>
	 *            identifier
	 * @return List<GeneralParameterValueLog>
	 */
	public List<GeneralParameterValueLog> getGeneralParametersHistoricalLog(
			Long bankingProductHistoryId) {
		try {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.001",
					"getGeneralParametersHistoricalLog"));

			BankingProductHistory bph = em.find(BankingProductHistory.class,
					bankingProductHistoryId);
			if (null == bph) {
				throw new BusinessException(6900177,
						"No se encontro ningun historico del producto con la fecha indicada.");
			}
			return buildGeneralParametersLog(bph);
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("GENERALPARAMETERSMANAGER.099"),
					ex);
			throw new BusinessException(
					6900172,
					"Ocurrio un error al obtener la información del historico de parámetros generales.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.002",
					"getGeneralParametersHistoricalLog"));
		}
	}

	/**
	 * 
	 * Get count for values associated for any banking product
	 * 
	 * @param dictionaryFieldId
	 *            Dictionary Field Identifier
	 * @param value
	 *            Value for Dictionary Field
	 * @return
	 */
	public long getCountFieldsForGeneralParameter(long dictionaryFieldId,
			String value) {
		try {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.001",
					"getCountFieldsForGeneralParameter"));
			Long associated = em
					.createNamedQuery(
							"GeneralParametersValues.countFindSpecificFields",
							Long.class)
					.setParameter("dictionaryFieldId", dictionaryFieldId)
					.setParameter("value", value).getSingleResult();

			if (associated == 0) {
				associated = em
						.createNamedQuery(
								"GeneralParametersValuesHistory.countFindSpecificFields",
								Long.class)
						.setParameter("dictionaryFieldId", dictionaryFieldId)
						.setParameter("value", value).getSingleResult();
			}

			return associated;

		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("GENERALPARAMETERSMANAGER.099"),
					ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.002",
					"getCountFieldsForGeneralParameter"));
		}
	}

	private List<GeneralParameterValueLog> buildGeneralParametersLog(
			BankingProductHistory bph) {
		List<GeneralParameterValueLog> listGeneralParamLog = new ArrayList<GeneralParameterValueLog>();
		List<GeneralParametersValuesHistory> listGeneralParam = em
				.createNamedQuery(
						"GeneralParametersValuesHistory.FindLatestLog",
						GeneralParametersValuesHistory.class)
				.setParameter("id", bph.getId())
				.setParameter("productId", bph.getProductId()).getResultList();
		if (listGeneralParam != null) {
			List<Long> ids = new ArrayList<Long>();
			for (GeneralParametersValuesHistory generalParameterValue : listGeneralParam) {
				ids.add(generalParameterValue.getDictionaryFieldId());
			}
			if (ids.size() > 0) {
				List<FieldValue> listFiedValues = em
						.createNamedQuery(
								"FieldValue.findAllByGeneralParameter",
								FieldValue.class)
						.setParameter("paramFields", ids).getResultList();
				if (listFiedValues != null) {
					Map<Long, FieldValue> mapFieldsValues = new HashMap<Long, FieldValue>();
					for (FieldValue fieldValue : listFiedValues) {
						mapFieldsValues.put(fieldValue.getFieldsId(),
								fieldValue);
					}
					for (GeneralParametersValuesHistory fieldGeneral : listGeneralParam) {
						FieldValue field = mapFieldsValues.get(fieldGeneral
								.getDictionaryFieldId());
						if (field != null) {
							GeneralParameterValueLog val = new GeneralParameterValueLog(
									field.getDictionaryField().getName(),
									fieldGeneral.getValue(),
									field.getDescription(),
									fieldGeneral.getRuleName());
							listGeneralParamLog.add(val);
						}

					}
				}

			}
		}
		return listGeneralParamLog;
		/*
		 * return em .createNamedQuery(
		 * "GeneralParametersValuesHistory.FindLatestLog",
		 * GeneralParameterValueLog.class) .setParameter("id", bph.getId())
		 * .setParameter("productId", bph.getProductId()).getResultList();
		 */
	}

	/**
	 * @param productId
	 * @param dictionaryName
	 * @description Get the last records in GeneralParameterValuesHistory by
	 *              product id and dictionary field name
	 * @return
	 */

	@SuppressWarnings("unchecked")
	public List<GeneralParametersValuesHistory> findGeneralParameterValuesDescription(
			String productId, String dictionaryName) {
		List<GeneralParametersValuesHistory> generalParametersValuesHistories = new ArrayList<GeneralParametersValuesHistory>();
		try {
			Query query = em.createNamedQuery(
					"GeneralParametersValuesHistory.findValues",
					GeneralParametersValuesHistory.class);
			query.setParameter("processDate", new Date());
			query.setParameter("productId", productId);
			query.setParameter("dictionaryName", dictionaryName);

			generalParametersValuesHistories = (List<GeneralParametersValuesHistory>) query
					.getResultList();
		} catch (BusinessException be) {
			throw be;
		} catch (NoResultException nre) {
			return new ArrayList<GeneralParametersValuesHistory>();
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("GENERALPARAMETERSMANAGER.099"),
					ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.002",
					"findGeneralParameterValuesDescription"));
		}
		return generalParametersValuesHistories;
	}
	
	@SuppressWarnings("unchecked")
	public List<GeneralParametersValuesHistory> findGeneralParameterProductsDescription(
			String productId) {
		List<GeneralParametersValuesHistory> generalParametersProductsHistories = new ArrayList<GeneralParametersValuesHistory>();
		try {
			Query query = em.createNamedQuery(
					"GeneralParametersValuesHistory.finByProduct",
					GeneralParametersValuesHistory.class);
			query.setParameter("productId", productId);

			generalParametersProductsHistories = (List<GeneralParametersValuesHistory>) query
					.getResultList();
		} catch (BusinessException be) {
			throw be;
		} catch (NoResultException nre) {
			return new ArrayList<GeneralParametersValuesHistory>();
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("GENERALPARAMETERSMANAGER.099"),
					ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSMANAGER.002",
					"findGeneralParameterProductsDescription"));
		}
		return generalParametersProductsHistories;
	}

	/**
	 * Validate the given parameters by banking product
	 * 
	 * @param productId
	 *            Banking product identifier
	 * @param parameters
	 *            A Map that contains the core parameter identifier as key and
	 *            the parameter value as value
	 */
	public void validateGeneralParameters(String productId,
			HashMap<String, String> parameters) {

	}

	/**
	 * Set the BankingProductManager manager used by the container to inject the
	 * instance
	 * 
	 * @param bankingProductService
	 */
	public void setBankingProductService(
			IBankingProductManager bankingProductService) {
		this.bankingProductService = bankingProductService;
	}

	/**
	 * Initialize the Entity Manager
	 * 
	 * @param em
	 *            Entity Manager
	 */
	@PersistenceContext(unitName = "JpaFpmAdministration")
	public void setEntityManager(EntityManager em) {
		this.em = em;
	}

}
