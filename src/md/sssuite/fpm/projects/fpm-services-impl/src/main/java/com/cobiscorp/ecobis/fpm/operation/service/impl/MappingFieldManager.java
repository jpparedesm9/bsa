package com.cobiscorp.ecobis.fpm.operation.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.bo.PhysicalField;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.CoreTable;
import com.cobiscorp.ecobis.fpm.model.CurrencyProduct;
import com.cobiscorp.ecobis.fpm.model.Module;
import com.cobiscorp.ecobis.fpm.model.RequiredFieldsByTable;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.operation.service.IMappingFieldManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

public class MappingFieldManager implements IMappingFieldManager {

	/** COBIS Logger */
	private static final ILogger logger = LogFactory.getLogger(BankingProductManager.class);

	/** Service that manage the operations over a banking product */
	private IBankingProductManager bankingProductService;

	/** Entity Manager injected by the container */
	private EntityManager em;

	public void setBankingProductService(IBankingProductManager bankingProductService) {
		this.bankingProductService = bankingProductService;
	}

	/**
	 * Find the Mapping field that represents a field in the core given a field
	 * name of the FPM
	 * 
	 * @param fieldName
	 *            <tt>DictionaryField</tt> name
	 * @return <tt>MappingField</tt> instance
	 */
	@SuppressWarnings("unchecked")
	public String findByPhysicalField(Long itemId, String fieldName) {
		try {
			logger.logDebug(MessageManager.getString("MAPPINGFIELDMANAGER.001", "findByPhysicalField"));
			List<String> resultList = ((List<String>) this.em.createNamedQuery("MappingField.findByPhysicalField")
					.setParameter("physicalfield", fieldName).setParameter("itemId", itemId).getResultList());

			if (resultList.size() > 0)
				return resultList.get(0);
			else
				return null;

		} catch (NonUniqueResultException ue) {
			logger.logError(MessageManager.getString("MAPPINGFIELDMANAGER.003", fieldName), ue);
			throw new BusinessException(6900081, "Se encontró más de una relación en el core asociada al campo seleccionado del FPM");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("MAPPINGFIELDMANAGER.004", fieldName), ex);
			throw new BusinessException(6900082, "No se pudo obtener la relación en el core asociada al campo seleccionado del FPM");
		} finally {
			logger.logDebug(MessageManager.getString("MAPPINGFIELDMANAGER.002", "findByPhysicalField"));
		}
	}

	/**
	 * Find the Mapping field that represents a field in the core given a field
	 * name of the FPM
	 * 
	 * @param fieldName
	 *            <tt>DictionaryField</tt> name
	 * @return <tt>MappingField</tt> instance
	 */
	@SuppressWarnings("unchecked")
	public String findByPhysicalField(String bankingProductId, Long itemId, String fieldName) {
		try {
			logger.logDebug(MessageManager.getString("MAPPINGFIELDMANAGER.001", "findByPhysicalField"));
			List<String> resultList = ((List<String>) this.em.createNamedQuery("MappingField.findByPhysicalFieldByProduct")
					.setParameter("physicalfield", fieldName).setParameter("itemId", itemId).setParameter("productId", bankingProductId)
					.getResultList());

			if (resultList.size() > 0)
				return resultList.get(0);
			else
				return null;

		} catch (NonUniqueResultException ue) {
			logger.logError(MessageManager.getString("MAPPINGFIELDMANAGER.003", fieldName), ue);
			throw new BusinessException(6900081, "Se encontró más de una relación en el core asociada al campo seleccionado del FPM");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("MAPPINGFIELDMANAGER.004", fieldName), ex);
			throw new BusinessException(6900082, "No se pudo obtener la relación en el core asociada al campo seleccionado del FPM");
		} finally {
			logger.logDebug(MessageManager.getString("MAPPINGFIELDMANAGER.002", "findByPhysicalField"));
		}
	}

	/**
	 * Gets the value in the FPM for specific physical field.
	 * 
	 * @param bankingProductId
	 *            the <tt>BankingProduct</tt> identifier
	 * @param physicalfield
	 *            the physical field name
	 * @return the value for specific field
	 */
	@SuppressWarnings("unchecked")
	public String getValueByPhisicalField(String bankingProductId, String physicalfield) {
		try {
			logger.logDebug(MessageManager.getString("MAPPINGFIELDMANAGER.001", "getValueByPhisicalField"));
			Long categoryId = bankingProductService.getCategoryIdKeepDictionaryFromParents(bankingProductId);

			if (null == categoryId || categoryId == 0) {
				logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.007", bankingProductId));
				throw new BusinessException(6900060, "No se pudo obtener el producto bancario indicado, puesto que no existe");
			}

			List<String> valueList = em.createNamedQuery("MappingField.findSpecificGPByProduct").setParameter("categoryId", categoryId)
					.setParameter("type", Constants.GENERAL_PARAMETERS_DICTIONARY).setParameter("productId", bankingProductId)
					.setParameter("physicalfield", physicalfield).getResultList();

			if (valueList.size() > 0)
				return valueList.get(0);
			else
				return null;

		} catch (BusinessException be) {
			throw be;
		} catch (NonUniqueResultException ue) {
			logger.logError(MessageManager.getString("MAPPINGFIELDMANAGER.006", physicalfield), ue);
			throw new BusinessException(6900084, "Se encontró más de un valor en el FPM para el campo seleccionado");
		} catch (NoResultException nre) {
			logger.logError(MessageManager.getString("MAPPINGFIELDMANAGER.007", physicalfield), nre);
			return null;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("MAPPINGFIELDMANAGER.005", physicalfield), ex);
			throw new BusinessException(6900083, "No se pudo obtener el valor en el FPM para el campo seleccionado");
		} finally {
			logger.logDebug(MessageManager.getString("MAPPINGFIELDMANAGER.002", "getValueByPhisicalField"));
		}
	}

	/**
	 * Gets the id for specific field.
	 * 
	 * @param bankingProductId
	 *            the banking product id
	 * @param physicalfield
	 *            the physical field
	 * @return the id for specific field
	 */
	public long getIdByPhisicalField(String bankingProductId, String physicalfield) {
		try {
			logger.logDebug(MessageManager.getString("MAPPINGFIELDMANAGER.001", "getIdByPhisicalField"));

			Long categoryId = bankingProductService.getCategoryIdKeepDictionaryFromParents(bankingProductId);

			if (null == categoryId || categoryId == 0) {
				logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.007", bankingProductId));
				throw new BusinessException(6900060, "No se pudo obtener el producto bancario indicado, puesto que no existe");
			}

			List<Long> identifiersList = em.createNamedQuery("MappingField.findIdSpecificGPByProduct", Long.class)
					.setParameter("categoryId", categoryId).setParameter("type", Constants.GENERAL_PARAMETERS_DICTIONARY)
					.setParameter("productId", bankingProductId).setParameter("physicalfield", physicalfield).getResultList();

			if (identifiersList.size() > 0) {
				return identifiersList.get(0);
			} else {
				return -1;
			}

		} catch (BusinessException be) {
			throw be;
		} catch (NonUniqueResultException ue) {
			logger.logError(MessageManager.getString("MAPPINGFIELDMANAGER.009", physicalfield), ue);
			throw new BusinessException(6900086, "Se encontró más de un código para el campo requerido en el FPM");
		} catch (NoResultException nre) {
			logger.logError(MessageManager.getString("MAPPINGFIELDMANAGER.007", physicalfield), nre);
			return -1;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("MAPPINGFIELDMANAGER.008", physicalfield), ex);
			throw new BusinessException(6900085, "No se pudo obtener el código del campo requerido en el FPM");
		} finally {
			logger.logDebug(MessageManager.getString("MAPPINGFIELDMANAGER.002", "getIdByPhisicalField"));
		}
	}

	/**
	 * Return all the available modules in the FPM
	 * 
	 * @return List<Module>
	 */
	public List<Module> getAllModules() {
		try {
			logger.logDebug(MessageManager.getString("MAPPINGFIELDMANAGER.001", "getAllModules"));
			return em.createNamedQuery("Module.findAll", Module.class).getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("MAPPINGFIELDMANAGER.010"), ex);
			throw new BusinessException(6900087, "No se pudo obtener la lista de módulos disponibles en el FPM");
		} finally {
			logger.logDebug(MessageManager.getString("MAPPINGFIELDMANAGER.002", "getAllModules"));
		}
	}

	/**
	 * This method returns a map whit the name of the table as key and a list of
	 * all physical fields mapped in the FPM
	 * 
	 * @param bankingProductId
	 *            <tt>BankingProduct</tt> identifier
	 * @param dictionaryType
	 *            The dictionary type PG or R
	 * @return a Map with the table name as key and the value as list of
	 *         physical fields
	 */
	public List<CoreTable> getPhysicalFieldsMappings(String bankingProductId, String dictionaryType, Date date) {
		try {
			logger.logDebug(MessageManager.getString("MAPPINGFIELDMANAGER.001", "getPhysicalFieldsMappings"));
			Long categoryId = bankingProductService.getCategoryIdKeepDictionaryFromParents(bankingProductId);
			if (null == categoryId || categoryId == 0) {
				logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.007", bankingProductId));
				throw new BusinessException(6900060, "No se pudo obtener el producto bancario indicado, puesto que no existe");
			}
			List<Object[]> result = null;

			if (dictionaryType.equals(Constants.GENERAL_PARAMETERS_DICTIONARY)) {
				// The data of the general parameters
				result = em.createNamedQuery("MappingField.findAllGPByProduct", Object[].class).setParameter("categoryId", categoryId)
						.setParameter("type", dictionaryType).setParameter("productId", bankingProductId).setParameter("systemDate", date)
						.getResultList();
			} else if (dictionaryType.equals(Constants.ITEMS_DICTIONARY)) {
				// The data of the general parameters
				result = em.createNamedQuery("MappingField.findAllIByProduct", Object[].class).setParameter("categoryId", categoryId)
						.setParameter("type", dictionaryType).setParameter("productId", bankingProductId).setParameter("systemDate", date)
						.getResultList();
			} 
			List<CoreTable> tables = new ArrayList<CoreTable>();
			logger.logDebug("result in MappingFields--->" + result.toString());
			for (Object[] data : result) {
				CoreTable table = new CoreTable(data[0].toString(), data[1].toString());
				// Se asigna id de la tabla
				table.setId(Long.parseLong(data[7].toString()));
				int tableIndex = 0;
				if ((tableIndex = tables.indexOf(table)) == -1) { // Add a new
					// table
					table.setPhysicalFields(new ArrayList<PhysicalField>());
					tables.add(table);
					tableIndex = tables.size() - 1;
				}
				tables.get(tableIndex)
				.getPhysicalFields()
				.add(new PhysicalField(data[2].toString(), data[3].toString(), Long.parseLong(data[4].toString()), data[5].toString(),
						data[6].toString()));
			}

			return tables;
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("MAPPINGFIELDMANAGER.011"), ex);
			throw new BusinessException(6900088, "No se pudo obtener la lista de las campos mapeados en el FPM");
		} finally {
			logger.logDebug(MessageManager.getString("MAPPINGFIELDMANAGER.002", "getPhysicalFieldsMappings"));
		}
	}

	public List<CoreTable> getPhysicalFieldsMappingsSpecific(String bankingProductId, String dictionaryType) {
		try {
			logger.logDebug(MessageManager.getString("MAPPINGFIELDMANAGER.001", "getPhysicalFieldsMappingsSpecific"));
			Long categoryId = bankingProductService.getCategoryIdKeepDictionaryFromParents(bankingProductId);
			PhysicalField physicalField = null;
			if (null == categoryId || categoryId == 0) {
				logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.007", bankingProductId));
				throw new BusinessException(6900060, "No se pudo obtener el producto bancario indicado, puesto que no existe");
			}
			List<Object[]> result = null;

			if (dictionaryType.equals(Constants.GENERAL_PARAMETERS_DICTIONARY_REPORT)) {
				// The data of the general parameters
				result = em.createNamedQuery("MappingField.findAllGPByProductSpecific", Object[].class).setParameter("categoryId", categoryId)
						.setParameter("type", dictionaryType).setParameter("productId", bankingProductId).getResultList();
			} else if (dictionaryType.equals(Constants.ITEMS_DICTIONARY_REPORT)) {
				// The data of the general parameters
				result = em.createNamedQuery("MappingField.findAllIByProductSpecific", Object[].class).setParameter("categoryId", categoryId)
						.setParameter("type", dictionaryType).setParameter("productId", bankingProductId).getResultList();
			}
			List<CoreTable> tables = new ArrayList<CoreTable>();
			for (Object[] data : result) {
				CoreTable table = new CoreTable(data[0].toString(), data[1].toString());
				int tableIndex = 0;
				if ((tableIndex = tables.indexOf(table)) == -1) { // Add a new
					// table
					table.setPhysicalFields(new ArrayList<PhysicalField>());
					tables.add(table);
					tableIndex = tables.size() - 1;
				}

				if (dictionaryType.equals(Constants.GENERAL_PARAMETERS_DICTIONARY_REPORT)) {
					physicalField = new PhysicalField(data[2].toString(), data[3].toString(), data[5].toString());
				} else if (dictionaryType.equals(Constants.ITEMS_DICTIONARY_REPORT)) {
					physicalField = new PhysicalField(data[2].toString(), data[3].toString(), data[5].toString(), Long.parseLong(data[6].toString()));
				} else if (dictionaryType.equals(Constants.RENDER_SCREEN)) {
					physicalField = new PhysicalField(data[2].toString(), data[3].toString(), data[5].toString(), Long.parseLong(data[6].toString()));
				}

				tables.get(tableIndex).getPhysicalFields().add(physicalField);
			}
			return tables;
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("MAPPINGFIELDMANAGER.011"), ex);
			throw new BusinessException(6900088, "No se pudo obtener la lista de las campos mapeados en el FPM");
		} finally {
			logger.logDebug(MessageManager.getString("MAPPINGFIELDMANAGER.002", "getPhysicalFieldsMappingsSpecific"));
		}
	}

	public Map<String, List<CoreTable>> getUnitFunctionalityValuesMapping(String bankingProductId, String dictionaryType) {
		try {
			Map<String, List<CoreTable>> unitFunctionaliTyValues = new HashMap<String, List<CoreTable>>();
			List<Object[]> result = null;
			List<Object[]> resultParent = null;
			Map<String, List<CoreTable>> unitFunctionaliTyValuesParent = new HashMap<String, List<CoreTable>>();
			Map<String, List<CoreTable>> setPhysicalFieldData = new HashMap<String, List<CoreTable>>();
			Map<String, List<CoreTable>> setPhysicalFieldDataParent = new HashMap<String, List<CoreTable>>();
			Map<String, List<CoreTable>> setPhysicalFieldDataTotal = new HashMap<String, List<CoreTable>>();
			BankingProduct bp = bankingProductService.getBankingProductBasicInformationById(bankingProductId);
			List<CoreTable> listTables = new ArrayList<CoreTable>();
			boolean existMoreCurrency = false;
			String requiredFieldsName = null;

			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("MAPPINGFIELDMANAGER.001", "getUnitFunctionalityValuesMapping"));
			}
			
			Long categoryId = bankingProductService.getCategoryIdKeepDictionaryFromParents(bankingProductId);
			if (null == categoryId || categoryId == 0) {
				logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.007", bankingProductId));
				throw new BusinessException(6900060, "No se pudo obtener el producto bancario indicado, puesto que no existe");
			}

			if (bp == null) {
				logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.007", bankingProductId));
				throw new BusinessException(6900060, "No se pudo realizar la b�squeda del producto Bancario seleccionado requerido. No Existe");
			}

			if (dictionaryType.equals(Constants.RENDER_SCREEN)) {
				// The data of the unit functionality
				result = em.createNamedQuery("MappingField.findByAllByTypeAndCategory", Object[].class).setParameter("categoryId", categoryId)
						.setParameter("type", dictionaryType).setParameter("productId", bankingProductId).getResultList();
				// The data of the unit functionality
				resultParent = em.createNamedQuery("MappingField.findByAllByTypeAndCategory", Object[].class).setParameter("categoryId", categoryId)
						.setParameter("type", dictionaryType).setParameter("productId", bp.getParentnode()).getResultList();
			}

			if(logger.isDebugEnabled()){
				logger.logDebug("resultParent.size()--->" + resultParent.size());
			}
			
			// Obtiene datos de pantallas renderizada en el hijo
			if (result != null) {
				unitFunctionaliTyValues = setValuesCoreTableList(result);
				setPhysicalFieldData = setPhysicalField(unitFunctionaliTyValues, bp, listTables, existMoreCurrency, requiredFieldsName);
				if (logger.isDebugEnabled()) {
					logger.logDebug("setPhysicalFieldData-->" + setPhysicalFieldData.size());
				}
			}
			// Obtiene datos de pantalla renderizada del padre
			if (resultParent != null) {
				unitFunctionaliTyValuesParent = setValuesCoreTableList(resultParent);
				BankingProduct bpParent = bankingProductService.getBankingProductBasicInformationById(bp.getParentnode());
				
				if (logger.isDebugEnabled()) {
					logger.logDebug("ParentNode-->" + bpParent.toString());
					logger.logDebug("ParentNode sector Id-->" + bpParent.getNodeTypeCategory().getMnemonic());
				}
				
				setPhysicalFieldDataParent = setPhysicalField(unitFunctionaliTyValuesParent, bpParent, listTables, existMoreCurrency,
						requiredFieldsName);
				if (logger.isDebugEnabled()) {
					logger.logDebug("setPhysicalFieldDataParent-->" + setPhysicalFieldDataParent.size());
				}
			}
			// Se asigna los valores obtenidos del padre como del hijo.
			Integer count = 1;
			for (Map.Entry<String, List<CoreTable>> entry : setPhysicalFieldData.entrySet()) {
				entry.getKey();
				setPhysicalFieldDataTotal.put(count.toString(), entry.getValue());
				count++;
			}
			
			for (Map.Entry<String, List<CoreTable>> entry : setPhysicalFieldDataParent.entrySet()) {
				entry.getKey();
				setPhysicalFieldDataTotal.put(count.toString(), entry.getValue());
				count++;
			}
			if(logger.isDebugEnabled()){
			logger.logDebug("setPhysicalFieldDataTotal-->"+ setPhysicalFieldDataTotal.toString());
			}
			
			return setPhysicalFieldDataTotal;
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("MAPPINGFIELDMANAGER.011"), ex);
			throw new BusinessException(6900088, "No se pudo obtener la lista de las campos mapeados en el FPM");
		} finally {
			if (logger.isDebugEnabled()) {
				logger.logDebug(MessageManager.getString("MAPPINGFIELDMANAGER.002", "getUnitFunctionalityValuesMapping"));
			}
		}
			}

	private Map<String, List<CoreTable>> setPhysicalField(Map<String, List<CoreTable>> unitFunctionaliTyValues, BankingProduct bp,
			List<CoreTable> listTables, boolean existMoreCurrency, String requiredFieldsName) {
		boolean flagGetCoreTable;
		try{
		for (String registry : unitFunctionaliTyValues.keySet()) { // unitFunctionaliTyValues
																	// Map <key,
																	// List<CoreTable>>
				listTables.clear();

				flagGetCoreTable = false;
			for (CoreTable table : unitFunctionaliTyValues.get(registry)) {// Lista
																			// de
																			// CoreTable

					if(!flagGetCoreTable){
						flagGetCoreTable = true;

						List<RequiredFieldsByTable> requiredFieldsByTable = getRequiredFieldsByTable(table.getId());
						if (requiredFieldsByTable.size() > 0) {

							PhysicalField pf = null;
							for (RequiredFieldsByTable requiredFields : requiredFieldsByTable) {//Requisitos Estáticos

								if (Constants.PRODUCTSECTOR.equals(requiredFields.getTypeField())) {
									pf = new PhysicalField(requiredFields.getPhysicalFields(), requiredFields.getDataTypeField(), String.valueOf(bp.getNodeTypeCategory().getMnemonic()), "N");
								} else if (Constants.PRODUCTOPERATION.equals(requiredFields.getTypeField())) {
									pf = new PhysicalField(requiredFields.getPhysicalFields(), requiredFields.getDataTypeField(), String.valueOf(bp.getId()), "N");
								} else if(Constants.PRODUCTCURRENCY.equals(requiredFields.getTypeField())){
									
									if(logger.isDebugEnabled()){
										logger.logDebug("Producto tiene más de una moneda configurada.");
									}
									
									pf = new PhysicalField(requiredFields.getPhysicalFields(), requiredFields.getDataTypeField(), ((CurrencyProduct)bp.getCurrencyProducts().get(0)).getId().getCurrencyId(), "N");
									
									if(bp.getCurrencyProducts().size() > 1){
										existMoreCurrency = true;
										requiredFieldsName = requiredFields.getPhysicalFields();
									}
								}
								//SMO para indicar que es clave primaria
								pf.setRequired(true);
								table.getPhysicalFields().add(pf);
							}//Requisitos Estáticos 
						}
					}//flagCoreTable
					listTables.add(table);
				}//Lista CoreTable
			}
			
			if(existMoreCurrency){//Lógica que se ejecuta cuando se tiene configurado un parametro de tipo moneda y el producto tienes más de una moneda configurada.
				Map<String, List<CoreTable>> unitFunctionaliTyValuesReturn = new HashMap<String, List<CoreTable>>();
				
				int row = 1;//Contador que permite añadir registros adicionales por moneda al Map
				for (Map.Entry<String, List<CoreTable>> entry : unitFunctionaliTyValues.entrySet()) {

					unitFunctionaliTyValuesReturn.put(entry.getKey(), entry.getValue());
					
					for(int i = 1; i < bp.getCurrencyProducts().size(); i++){
						
						List<CoreTable> newList = new ArrayList<CoreTable>(); //Se clona la lista a una nueva.
						for (CoreTable coreTable : entry.getValue()) {
							
							List<PhysicalField> listPhysicalFields = new ArrayList<PhysicalField>();
							
							for (PhysicalField physicalField : coreTable.getPhysicalFields()) {
								PhysicalField newPhysicalFields = new PhysicalField(physicalField.getPhysicalFieldName(), physicalField.getDataType(), physicalField.getValue(), physicalField.getMultivalue());
								listPhysicalFields.add(newPhysicalFields);
							}
							
							CoreTable newCoreTable = new CoreTable(coreTable.getId() ,coreTable.getTable(), coreTable.getDatabase(), null, listPhysicalFields);
							newList.add(newCoreTable);
						}
					

						for (CoreTable coreTable : newList) {//Se setea el valor de la nueva moneda.
							for (PhysicalField physicalField : coreTable.getPhysicalFields()) {
								if(physicalField.getPhysicalFieldName().trim().equals(requiredFieldsName.trim())){
									physicalField.setValue(((CurrencyProduct)bp.getCurrencyProducts().get(i)).getId().getCurrencyId());
								}
							}
						}
						
						unitFunctionaliTyValuesReturn.put(String.valueOf((unitFunctionaliTyValues.size() + row)), newList);//Se añade la nueva lista a un nuevo registro.
					}
					row++;
				}

				if(logger.isDebugEnabled()){
					logger.logDebug("Mapa modificado por tener más de una moneda. "+ unitFunctionaliTyValuesReturn);
				}

				return unitFunctionaliTyValuesReturn;
				
			}else{
				if(logger.isDebugEnabled()){
					logger.logDebug("Mapa original. "+ unitFunctionaliTyValues);
				}

					return unitFunctionaliTyValues;
			}
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("MAPPINGFIELDMANAGER.011"), ex);
			throw new BusinessException(6900088, "No se pudo obtener la lista de las campos mapeados en el FPM");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("MAPPINGFIELDMANAGER.002", "getUnitFunctionalityValuesMapping"));
			}
		}
	}

	public List<RequiredFieldsByTable> getRequiredFieldsByTable(Long tableId) {
		try {
			logger.logDebug(MessageManager.getString("MAPPINGFIELDMANAGER.001", "getRequiredFieldsByTable"));
			List<RequiredFieldsByTable> requiredField = null;
			if (tableId != null) {
				requiredField = em.createNamedQuery("RequiredFieldsByTable.findByTableId", RequiredFieldsByTable.class)
						.setParameter("tableId", tableId).getResultList();
			}
			return requiredField;
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("MAPPINGFIELDMANAGER.011"), ex);
			throw new BusinessException(6900088, "No se pudo obtener la lista de las campos requeridos de la tabla:en el FPM");
		} finally {
			logger.logDebug(MessageManager.getString("MAPPINGFIELDMANAGER.002", "getRequiredFieldsByTable"));
		}

	}

	private List<CoreTable> setValuesCoreTableList(Map<String, List<CoreTable>> unitFunctionaliTyValues, List<Object[]> resultParent,
			List<CoreTable> coreTableList) {
		boolean reg;
		int count = resultParent.size();
		List<Object[]> resultRequiredField = null;
		for (int i = 0; i < count; i++) {
			reg = false;
			Object[] obj = resultParent.get(i);
			if (i + 1 < count) {
				Object[] objNext = resultParent.get(i + 1);
				if (!obj[0].toString().equals(objNext[0].toString())) {
					reg = true;
				}
			}
			CoreTable coreTable = new CoreTable(obj[2].toString(), obj[3].toString());
			coreTable.setId(Long.parseLong(obj[1].toString()));
			coreTable.setPhysicalFields(new ArrayList<PhysicalField>());
			coreTable.getPhysicalFields().add(
					new PhysicalField(obj[4].toString(), obj[5].toString(), Long.parseLong(obj[6].toString()), obj[7].toString(), obj[8].toString()));
			coreTableList.add(coreTable);
			if (reg || i + 1 == count) {
				unitFunctionaliTyValues.put(obj[0].toString(), coreTableList);
				coreTableList = new ArrayList<CoreTable>();
			}
		}

		return coreTableList;
	}

	private Map<String, List<CoreTable>> setValuesCoreTableList(List<Object[]> resultParent) {
		Map<String, List<CoreTable>> unitFunctionaliTyValues = new HashMap<String, List<CoreTable>>();
		List<CoreTable> coreTableList = new ArrayList<CoreTable>();
		boolean reg;
		int count = resultParent.size();
		for (int i = 0; i < count; i++) {
			reg = false;
			Object[] obj = resultParent.get(i);
			if (i + 1 < count) {
				Object[] objNext = resultParent.get(i + 1);
				if (!obj[0].toString().equals(objNext[0].toString())) {
					reg = true;
				}
			}
			CoreTable coreTable = new CoreTable(obj[2].toString(), obj[3].toString());
			coreTable.setId(Long.parseLong(obj[1].toString()));
			coreTable.setPhysicalFields(new ArrayList<PhysicalField>());
			coreTable.getPhysicalFields().add(
					new PhysicalField(obj[4].toString(), obj[5].toString(), Long.parseLong(obj[6].toString()), obj[7].toString(), obj[8].toString()));
			coreTableList.add(coreTable);
			if (reg || i + 1 == count) {
				unitFunctionaliTyValues.put(obj[0].toString(), coreTableList);
				coreTableList = new ArrayList<CoreTable>();
			}
		}
		return unitFunctionaliTyValues;
	}


	/**
	 * Inject the JPA Entity Manager
	 * 
	 * @param em
	 *            entityManager
	 */
	@PersistenceContext(unitName = "JpaFpmAdministration")
	public void setEm(EntityManager em) {
		this.em = em;
	}
}
