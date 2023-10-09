/*
 * File: DictionaryManager.java
 * Date: September 27, 2011
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
package com.cobiscorp.ecobis.fpm.administration.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import javax.persistence.TypedQuery;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.administration.service.IDictionaryManager;
import com.cobiscorp.ecobis.fpm.model.DicCompanyProductType;
import com.cobiscorp.ecobis.fpm.model.DicCompanyProductTypeId;
import com.cobiscorp.ecobis.fpm.model.DicFunctionalityGroup;
import com.cobiscorp.ecobis.fpm.model.DictionaryField;
import com.cobiscorp.ecobis.fpm.model.FieldValidator;
import com.cobiscorp.ecobis.fpm.model.FieldValue;
import com.cobiscorp.ecobis.fpm.model.MappingField;
import com.cobiscorp.ecobis.fpm.model.PaymentTypeFields;
import com.cobiscorp.ecobis.fpm.model.TransactionField;
import com.cobiscorp.ecobis.fpm.operation.service.IGeneralParametersManager;
import com.cobiscorp.ecobis.fpm.operation.service.IItemsManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

public class DictionaryManager implements IDictionaryManager {

	// region Fields
	/** COBIS Logger */
	private static final ILogger logger = LogFactory.getLogger(DictionaryManager.class);

	/** Entity manager injected by the container */
	private EntityManager em;

	private IGeneralParametersManager generalParameterService;

	public void setGeneralParameterService(IGeneralParametersManager generalParameterService) {
		this.generalParameterService = generalParameterService;
	}

	private IItemsManager itemsManagerService;

	public void setItemsManagerService(IItemsManager itemsManagerService) {
		this.itemsManagerService = itemsManagerService;
	}

	// end-region

	// region Dictionary administrative methods
	/**
	 * Find a specific <tt>DicCompanyProductType</tt> by its identifier
	 * 
	 * @param dictionaryId
	 *            <tt>DicCompanyProductType</tt> Identifier
	 * @return <tt>DicCompanyProductTypeId</tt> instance if it was found
	 */
	public DicCompanyProductType getDictionaryById(DicCompanyProductTypeId dictionaryId) {
		try {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.001", "getDictionaryById"));
			TypedQuery<DicCompanyProductType> tq = em.createNamedQuery("DicCompanyProductType.findByIdTypeAndName", DicCompanyProductType.class)
					.setParameter("companyId", dictionaryId.getCompanyId()).setParameter("categoryId", dictionaryId.getNodeTypeCategoryId())
					.setParameter("type", dictionaryId.getType()).setParameter("name", dictionaryId.getName());
			DicCompanyProductType dictionary = null;
			if (tq != null)
				dictionary = tq.getSingleResult();

			if (null != dictionary) {
				if (null != dictionary.getDictFunctionalityGroups()) {
					dictionary.getDictFunctionalityGroups().size();
				}
			}
			return dictionary;
		} catch (NonUniqueResultException nur) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.006"), nur);
			throw new BusinessException(6900010, "No se pudo realizar la búsqueda del diccionario requerido");
		} catch (NoResultException nre) {
			return null;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.009"), ex);
			throw new BusinessException(6900010, "No se pudo realizar la búsqueda del diccionario requerido");
		} finally {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.002", "getDictionaryById"));
		}
	}

	/**
	 * Find all the dictionaries associated to the given <tt>Company</tt>
	 * identifier and <tt>NodeTypeCategory</tt> identifier
	 * 
	 * @param companyId
	 *            <tt>Company</tt> identifier
	 * @param categoryId
	 *            <tt>NodeTypeCategory</tt> identifier
	 * @return list of <tt><DicCompanyProductType</tt>
	 */
	public List<DicCompanyProductType> getDictionariesBasicInformation(Long companyId, Long categoryId) {
		try {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.001", "getDictionariesBasicInformation"));
			List<DicCompanyProductType> dpt = em.createNamedQuery("DicCompanyProductType.findAllBasic", DicCompanyProductType.class)
					.setParameter("companyId", companyId).setParameter("categoryId", categoryId).getResultList();

			for (DicCompanyProductType dicCompanyProductType : dpt) {
				dicCompanyProductType.setCompany(null);
				dicCompanyProductType.setNodeTypeCategory(null);
				dicCompanyProductType.setDictFunctionalityGroups(null);
			}

			return dpt;
		} catch (NoResultException nre) {
			return null;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.007"), ex);
			throw new BusinessException(6900011, "No se pudo obtener la información relacionada al diccionario requerido");
		} finally {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.002", "getDictionariesBasicInformation"));
		}
	}

	/**
	 * Insert a <tt>NodeTypeProduct</tt>
	 * 
	 * @param dictionary
	 *            The <tt>DicCompanyProductType</tt> to insert
	 * @throws BusinessException
	 *             if occurs an error
	 */
	public void insertDictionary(DicCompanyProductType dictionary) {
		try {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.001", "insertDictionary"));
			em.persist(dictionary);
			em.flush();
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.008"), eee);
			throw new BusinessException(6900012, "El diccionario seleccionado no se pudo crear, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.003", dictionary), ex);
			throw new BusinessException(6900013, "No se pudo crear el diccionario requerido");
		} finally {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.002", "insertDictionary"));
		}
	}

	/**
	 * Update the information related to a <tt>DicCompanyProductType</tt>
	 * including the related list of <tt>Functionalities</tt> and the
	 * modifications in the list of <tt>NodeTypeCategory</tt> except for delete
	 * operation
	 * 
	 * @param dictionary
	 *            The <tt>DicCompanyProductType</tt> to update
	 */
	public void updateDictionary(DicCompanyProductType dictionary) {
		try {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.001", "updateDictionary"));
			DicCompanyProductTypeId id = new DicCompanyProductTypeId();
			id.setCompanyId(dictionary.getCompanyId());
			id.setNodeTypeCategoryId(dictionary.getNodeTypeCategoryId());
			id.setType(dictionary.getType());
			id.setName(dictionary.getName());

			DicCompanyProductType dic = getDictionaryById(id);
			// Only description can be updated
			dic.setDescription(dictionary.getDescription());
			dic.setItemType(dictionary.getItemType());
			em.flush();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.004", dictionary), ex);
			throw new BusinessException(6900014, "No se pudo actualizar el diccionario seleccionado");
		} finally {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.002", "updateDictionary"));
		}
	}

	/**
	 * Delete a <tt>DicCompanyProductType</tt>
	 * 
	 * @param dictionaryId
	 *            The <tt>DicCompanyProductType</tt> identifier
	 * @throws BusinessException
	 *             if occurs an error or if this <tt>DicCompanyProductType</tt>
	 *             has relation with other entities
	 */
	public void deleteDictionary(DicCompanyProductTypeId dictionaryId) {
		try {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.001", "deleteDictionary"));
			DicCompanyProductType dictionary = getDictionaryById(dictionaryId);
			if (null != dictionary) {
				if (relatedInformation(dictionaryId))
					throw new BusinessException(6900015, "No se pudo eliminar el diccionario, porque tiene información relacionada");
				else {
					em.remove(dictionary);
					em.flush();
				}
			}
		} catch (BusinessException exception) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.005", dictionaryId), exception);
			throw exception;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.005", dictionaryId), ex);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.002", "deleteDictionary"));
		}
	}

	/*
	 * Check if a DicCompanyProductType has related information
	 */
	private Boolean relatedInformation(DicCompanyProductTypeId dictionaryId) {
		Long countDicFuntionalityGroup = em.createNamedQuery("DicCompanyProductType.countRelatedDicFuntionalityGroup", Long.class)
				.setParameter("companyId", dictionaryId.getCompanyId()).setParameter("nodeTypeCategoryId", dictionaryId.getNodeTypeCategoryId())
				.setParameter("typeId", dictionaryId.getType()).setParameter("nameId", dictionaryId.getName()).getSingleResult();

		return countDicFuntionalityGroup > 0;
	}

	// end-region

	// region Functionality Groups administrative methods
	/**
	 * This method manage the basic operations over a
	 * <tt>DicFunctionalityGroup</tt>
	 * 
	 * @param operation
	 *            The available operations
	 *            <ul>
	 *            <li>INSERT</li>
	 *            <li>UPDATE</li>
	 *            <li>DELETE</li>
	 *            </ul>
	 * @param functionalityGroup
	 *            The <tt>DicFunctionalityGroup</tt> on which the operation is
	 *            performed
	 * @return The generated identifier when the operation is INSERT otherwise 0
	 */
	public long mangeFunctionalityGroups(String operation, DicFunctionalityGroup functionalityGroup) {
		try {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.001", "mangeFunctionalityGroups"));
			if (operation.equals(Constants.INSERT_OPERATION)) {
				// Check if there is a functionality group with the same name
				if (em.createNamedQuery("DicFunctionalityGroup.countByName", Long.class)
						.setParameter("name", functionalityGroup.getName().toUpperCase())
						.setParameter(
								"dictionary",
								em.find(DicCompanyProductType.class, new DicCompanyProductTypeId(functionalityGroup.getDicCompanyProductType().getCompanyId(),
										functionalityGroup.getDicCompanyProductType().getNodeTypeCategoryId(), functionalityGroup.getDicCompanyProductType()
												.getType(), functionalityGroup.getDicCompanyProductType().getName()))).getSingleResult() > 0) {
					throw new BusinessException(6900184, "Existe un grupo de parámetros con el mismo nombre.");
				}
				em.persist(functionalityGroup);
				return functionalityGroup.getId();
			} else if (operation.equals(Constants.UPDATE_OPERATION)) {
				DicFunctionalityGroup fg = em.find(DicFunctionalityGroup.class, functionalityGroup.getId());
				fg.setDescription(functionalityGroup.getDescription());
				fg.setEnabled(functionalityGroup.getEnabled());
				fg.setName(functionalityGroup.getName());
			} else if (operation.equals(Constants.DELETE_OPERATION)) {
				functionalityGroup = em.find(DicFunctionalityGroup.class, functionalityGroup.getId());
				if (null != functionalityGroup) {
					if (relatedDicFunctionalityGroup(functionalityGroup.getId()))
						throw new BusinessException(6900018, "No se pudo eliminar el grupo funcional, porque tiene información relacionada");
					else
						em.remove(functionalityGroup);
				}
			}
			em.flush();
			return 0;
		} catch (BusinessException be) {
			throw be;
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.010"), eee);
			throw new BusinessException(6900016, "El grupo funcional seleccionado no se pudo ingresar, puesto que ya existe");
		} catch (PersistenceException pe) {
			if (operation.equals(Constants.INSERT_OPERATION)) {
				logger.logError(MessageManager.getString("DICTIONARYMANAGER.003", functionalityGroup), pe);
				throw new BusinessException(6900017, "No se pudo crear el grupo funcional requerido");
			}
			if (operation.equals(Constants.DELETE_OPERATION)) {
				logger.logError(MessageManager.getString("DICTIONARYMANAGER.005", functionalityGroup), pe);
				throw new BusinessException(6900186, "No se pudo eliminar el grupo funcional seleccionado.");
			} else {
				logger.logError(MessageManager.getString("DICTIONARYMANAGER.004", functionalityGroup), pe);
				throw new BusinessException(6900019, "No se pudo actualizar el grupo funcional seleccionado");
			}
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.099"), ex);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.002", "mangeFunctionalityGroups"));
		}
	}

	/*
	 * Check if a DicFunctionalityGroup has related information
	 */
	private Boolean relatedDicFunctionalityGroup(Long functionalityId) {

		Long countDictionaryFields = 0l;

		DicFunctionalityGroup dfg = em.find(DicFunctionalityGroup.class, functionalityId);

		String type = dfg.getDicCompanyProductType().getType();
		if (type.equals(Constants.TRANSACTION_TYPE)) {
			countDictionaryFields = em.createNamedQuery("TransactionField.countRelatedDictionaryFields", Long.class)
					.setParameter("functionalityId", functionalityId).getSingleResult();

		} else if (type.equals(Constants.PAYMENT_TYPE)) {
			countDictionaryFields = em.createNamedQuery("PaymentTypeFields.countRelatedDictionaryFields", Long.class)
					.setParameter("functionalityId", functionalityId).getSingleResult();
		} else {
			countDictionaryFields = em.createNamedQuery("DicFunctionalityGroup.countRelatedDictionaryFields", Long.class)
					.setParameter("functionalityId", functionalityId).getSingleResult();

		}
		return countDictionaryFields > 0;
	}

	/**
	 * Get the basic information of a functionality group by its identifier
	 * 
	 * @param id
	 *            The <tt>DicFunctionalityGroup</tt> identifier
	 * @return <tt>DicFunctionalityGroup</tt> instance
	 */
	public DicFunctionalityGroup getFunctionalityGroupBasicInformationById(Long id) {
		try {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.001", "getFunctionalityGroupBasicInformationById"));
			return em.createNamedQuery("DicFunctionalityGroup.findBasicInformation", DicFunctionalityGroup.class).setParameter("id", id).getSingleResult();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.014", id), ex);
			throw new BusinessException(6900020, "No se pudo obtener la información del grupo funcional seleccionado");
		} finally {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.002", "getFunctionalityGroupBasicInformationById"));
		}
	}

	// end-region

	// region Dictionary Fields administrative methods
	/**
	 * This method get all the fields a given dictionary
	 * 
	 * @param dictionary
	 *            <tt>DicCompanyProductType</tt> identifier
	 * @return List of <tt>DictionaryField</tt> entities
	 */
	public List<DictionaryField> getAllFieldsBasicInforamtionByFunctionalityGroup(Long dicFunctionalyGroupId) {
		try {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.001", "getAllFieldsBasicInforamtionByFunctionalityGroup"));
			return em.createNamedQuery("DictionaryField.findAllBasicByDictionaryForGroup", DictionaryField.class)
					.setParameter("dicFunctionalityGroupId", dicFunctionalyGroupId).getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.011"), ex);
			throw new BusinessException(6900021, "No se pudo obtener la información de los campos para el diccionario seleccionado");
		} finally {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.002", "getAllFieldsBasicInforamtionByFunctionalityGroup"));
		}
	}

	/**
	 * Get the basic information of a dictionary field by its identifier
	 * 
	 * @param id
	 *            The <tt>DictionaryField</tt> identifier
	 * @return <tt>DictionaryField</tt> instance
	 */
	public DictionaryField getFieldBasicInformationById(Long id) {
		try {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.001", "getFieldBasicInformationById"));
			return em.createNamedQuery("DictionaryField.findBasicInformationById", DictionaryField.class).setParameter("id", id).getSingleResult();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.015", id), ex);
			throw new BusinessException(6900029, "No se pudo obtener la información del campo seleccionado");
		} finally {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.002", "getFieldBasicInformationById"));
		}
	}

	/**
	 * This method manage the basic operations over a <tt>DictionaryField</tt>
	 * 
	 * @param operation
	 *            The available operations
	 *            <ul>
	 *            <li>INSERT</li>
	 *            <li>UPDATE</li>
	 *            <li>DELETE</li>
	 *            </ul>
	 * @param dictionaryField
	 *            The <tt>DictionaryField</tt> on which the operation is
	 *            performed
	 * @return The generated identifier when the operation is INSERT otherwise 0
	 */
	public long manageDictionaryFields(String operation, DictionaryField dictionaryField) {
		try {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.001", "manageDictionaryFields"));
			if (operation.equals(Constants.INSERT_OPERATION)) {
				// Check if there is a field with the same name
				if (em.createNamedQuery("DictionaryField.countByName", Long.class)
						.setParameter("name", dictionaryField.getName().toUpperCase())
						.setParameter("dictionary",
								em.find(DicFunctionalityGroup.class, dictionaryField.getDicFunctionalityGroup().getId()).getDicCompanyProductType())
						.getSingleResult() > 0) {
					throw new BusinessException(6900185, "Existe un parámetro con el mismo nombre.");
				}

				try {
					em.persist(dictionaryField);
					return dictionaryField.getId();
				} catch (Exception e) {
					logger.logError(e);
					throw new BusinessException(6900022, "El campo de diccionario seleccionado no se puede ingresar, puesto que ya existe");
				}

			} else if (operation.equals(Constants.UPDATE_OPERATION)) {
				DictionaryField field = em.find(DictionaryField.class, dictionaryField.getId());

				List<Long> multiValuesCount = em.createNamedQuery("GeneralParametersValues.countMultiValuesField", Long.class)
						.setParameter("dictionaryFieldId", dictionaryField.getId()).getResultList();

				if (multiValuesCount.size() > 0 && !field.getMultivalue().equals(dictionaryField.getMultivalue())
						&& dictionaryField.getMultivalue().equals("N")) {
					Long generalParametersCount = multiValuesCount.get(0);
					if (generalParametersCount > 1) {
						field.setMultivalue(dictionaryField.getMultivalue());
						logger.logError(MessageManager.getString("DICTIONARYMANAGER.016"));
						throw new BusinessException(8700029,
								"Exiten parámetros en los productos bancarios que utilizan múltiples valores para este diccionario. "
										+ "Elimine dichos valores antes de actualizar.");

					}
				} else {
					field.setName(dictionaryField.getName());
					field.setDescription(dictionaryField.getDescription());
					field.setDicFunctionalityGroup(em.find(DicFunctionalityGroup.class, dictionaryField.getDicFunctionalityGroup().getId()));
					field.setValueType(dictionaryField.getValueType());
					field.setModifyInherited(dictionaryField.getModifyInherited());
					field.setEnabled(dictionaryField.getEnabled());
					field.setRequired(dictionaryField.getRequired());
					field.setMultivalue(dictionaryField.getMultivalue());
					field.setEvaluationProduct(dictionaryField.getEvaluationProduct());
					field.setIsHead(dictionaryField.getIsHead());
				}

			} else if (operation.equals(Constants.DELETE_OPERATION)) {
				dictionaryField = em.find(DictionaryField.class, dictionaryField.getId());
				if (null != dictionaryField) {
					if (relatedDictionaryFields(dictionaryField.getId()))
						throw new BusinessException(6900023,
								"No se pudo eliminar el campo de diccionario porque tiene información relacionada en parámetros generales, unidades funcionales o rubros");
					else {
						List<MappingField> mappingFields = em.createNamedQuery("MappingField.findByFieldId", MappingField.class)
								.setParameter("fieldId", dictionaryField.getId()).getResultList();
						if (null != mappingFields) {
							for (MappingField mappingField : mappingFields) {
								em.remove(mappingField);
							}
						}

						try {
							em.remove(dictionaryField);
						} catch (Exception e) {
							logger.logError(e);
							throw new BusinessException(6900023,
									"No se pudo eliminar diccionario ya que tiene información relacionada en parámetros generales, "
											+ "unidades funcionales o rubros");

						}
					}
				}
			}

			em.flush();
			return 0;
		} catch (BusinessException be) {
			throw be;
		} catch (PersistenceException pe) {
			if (operation.equals(Constants.DELETE_OPERATION)) {
				logger.logError(MessageManager.getString("DICTIONARYMANAGER.005", dictionaryField), pe);
				throw new BusinessException(6900187,
						"No se pudo eliminar el campo de diccionario ya que tiene información relacionada en parámetros generales, unidades funcionales o rubros ");
			} else {
				logger.logError(MessageManager.getString("DICTIONARYMANAGER.004", dictionaryField), pe);
				throw new BusinessException(6900024, "No se pudo actualizar el campo de diccionario");
			}
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.099"), ex);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.002", "manageDictionaryFields"));
		}
	}

	/*
	 * Check if a DictionaryFields has related information
	 */
	private Boolean relatedDictionaryFields(Long fieldId) {
		Long countItemsValues = em.createNamedQuery("DictionaryField.countRelatedItemsValues", Long.class).setParameter("fieldId", fieldId).getSingleResult();
		Long countFieldValidator = em.createNamedQuery("DictionaryField.countRelatedFieldValidator", Long.class).setParameter("fieldId", fieldId)
				.getSingleResult();
		Long countGeneralParameters = em.createNamedQuery("DictionaryField.countRelatedGeneralParameters", Long.class).setParameter("fieldId", fieldId)
				.getSingleResult();
		Long countGenParametersHis = em.createNamedQuery("DictionaryField.countRelatedGenParametersHistory", Long.class).setParameter("fieldId", fieldId).getSingleResult();
		Long countFieldValue = em.createNamedQuery("DictionaryField.countRelatedFieldValue", Long.class).setParameter("fieldId", fieldId).getSingleResult();

		return (countItemsValues + countFieldValidator + countGeneralParameters + countGenParametersHis + countFieldValue) > 0;
	}

	// end-region

	// region Field Values administrative methods
	/**
	 * This method get all the values a given dictionary field
	 * 
	 * @param field
	 *            <tt>DictionaryField</tt> identifier
	 * @return List of <tt>FieldValue</tt> entities
	 */
	public List<FieldValue> getAllValuesByField(Long fieldId, String type) {
		try {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.001", "getAllValuesByField"));
			return em.createNamedQuery("FieldValue.findAllByField", FieldValue.class).setParameter("fieldId", fieldId).setParameter("type", type)
					.getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.012"), ex);
			throw new BusinessException(6900025, "No se pudo obtener los valores para el campo seleccionado");
		} finally {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.002", "getAllValuesByField"));
		}
	}

	/**
	 * This method manage the basic operations over a <tt>FieldValue</tt>
	 * 
	 * @param operation
	 *            The available operations
	 *            <ul>
	 *            <li>INSERT</li>
	 *            <li>UPDATE</li>
	 *            <li>DELETE</li>
	 *            </ul>
	 * @param fieldValue
	 *            The <tt>FieldValue</tt> on which the operation is performed
	 * @return The generated identifier when the operation is INSERT otherwise 0
	 */
	public long manageFieldValue(String operation, FieldValue fieldValue) {
		try {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.001", "manageFieldValue"));
			if (operation.equals(Constants.INSERT_OPERATION)) {
				em.persist(fieldValue);
				return fieldValue.getId();
			} else if (operation.equals(Constants.UPDATE_OPERATION)) {
				FieldValue value = em.find(FieldValue.class, fieldValue.getId());
				value.setValueSourceId(fieldValue.getValueSourceId());
				value.setValue(fieldValue.getValue());
				value.setDescription(fieldValue.getDescription());
				value.setDefualtValue(fieldValue.getDefualtValue());
				value.setDatabase(fieldValue.getDatabase());
			} else if (operation.equals(Constants.DELETE_OPERATION)) {

				fieldValue = em.find(FieldValue.class, fieldValue.getId());

				if (generalParameterService.getCountFieldsForGeneralParameter(fieldValue.getFieldsId(), fieldValue.getValue()) <= 0
						&& itemsManagerService.getCountFieldsForItems(fieldValue.getFieldsId(), fieldValue.getValue()) <= 0) {

					em.remove(fieldValue);
				} else {
					throw new BusinessException(6900027, "No se pudo eliminar el campo de valor porque tiene información relacionada");
				}
			}
			em.flush();
			return 0;
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.003", fieldValue), eee);
			throw new BusinessException(6900026, "El campo de valor seleccionado no se puede ingresar, puesto que ya existe");
		} catch (PersistenceException pe) {
			if (operation.equals(Constants.DELETE_OPERATION)) {
				logger.logError(MessageManager.getString("DICTIONARYMANAGER.005", fieldValue), pe);
				throw new BusinessException(6900027, "No se pudo eliminar el campo de valor porque tiene información relacionada");
			} else {
				logger.logError(MessageManager.getString("DICTIONARYMANAGER.004", fieldValue), pe);
				throw new BusinessException(6900028, "No se pudo actualizar el campo de valor");
			}
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.099"), ex);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.002", "manageFieldValue"));
		}
	}

	// end-region

	// region Field Validators
	/**
	 * This method get all the validators a given dictionary field
	 * 
	 * @param field
	 *            <tt>DictionaryField</tt> identifier
	 * @return List of <tt>FieldValidator</tt> entities
	 */
	public List<FieldValidator> getAllValidatorsByField(Long fieldId, String type) {
		try {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.001", "getAllValidatorsByField"));
			return em.createNamedQuery("FieldValidator.findAllByField", FieldValidator.class).setParameter("fieldId", fieldId).setParameter("type", type)
					.getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.012"), ex);
			throw new BusinessException(6900179, "No se pudo obtener los validadores para el campo seleccionado");
		} finally {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.002", "getAllValidatorsByField"));
		}
	}

	/**
	 * This method manage the basic operations over a <tt>FieldValidator</tt>
	 * 
	 * @param operation
	 *            The available operations
	 *            <ul>
	 *            <li>INSERT</li>
	 *            <li>UPDATE</li>
	 *            <li>DELETE</li>
	 *            </ul>
	 * @param validator
	 *            The <tt>FieldValidator</tt> on which the operation is
	 *            performed
	 */
	public long manageFieldValidators(String operation, FieldValidator validator) {
		try {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.001", "manageFieldValidators"));
			if (operation.equals(Constants.INSERT_OPERATION)) {
				em.persist(validator);
				return validator.getId();
			} else if (operation.equals(Constants.UPDATE_OPERATION)) {
				FieldValidator _validator = em.find(FieldValidator.class, validator.getId());
				_validator.setType(validator.getType());
				_validator.setValue(validator.getValue());
				_validator.setField(validator.getField());
				_validator.setApplyType(validator.getApplyType());
			} else if (operation.equals(Constants.DELETE_OPERATION)) {
				em.remove(em.find(FieldValidator.class, validator.getId()));
			}
			em.flush();
			return 0;
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.003", validator), eee);
			throw new BusinessException(6900180, "No se pudo ingresar el validador, puesto que ya existe");
		} catch (PersistenceException pe) {
			if (operation.equals(Constants.DELETE_OPERATION)) {
				logger.logError(MessageManager.getString("DICTIONARYMANAGER.005", validator), pe);
				throw new BusinessException(6900182, "Ocurrio un error al eliminar el validador");
			} else {
				logger.logError(MessageManager.getString("DICTIONARYMANAGER.004", validator), pe);
				throw new BusinessException(6900181, "Ocurrio un error al actualizar los campos del validador");
			}
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.099"), ex);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.002", "manageFieldValidators"));
		}
	}

	public List<DictionaryField> getFieldByDictionaryAndvalues(DicCompanyProductTypeId dictionaryId, Long groupId) {
		try {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.001", "getFieldByDictionaryAndvalues"));
			List<DictionaryField> dictionariFields = new ArrayList<DictionaryField>();
			DicCompanyProductType dicCompanyProductType = new DicCompanyProductType();
			dicCompanyProductType = getDictionaryById(dictionaryId);

			dicCompanyProductType.getDictFunctionalityGroups().size();

			for (DicFunctionalityGroup functionalityGroup : dicCompanyProductType.getDictFunctionalityGroups()) {
				// If the group is diferent of the selected group
				if (functionalityGroup.getId() != groupId) {
					if (Constants.TRANSACTION_TYPE.equals(dicCompanyProductType.getType().trim())) {
						TypedQuery<TransactionField> tf = em.createNamedQuery("TransactionField.findByGroup", TransactionField.class).setParameter("groupId",
								functionalityGroup.getId());
						List<TransactionField> serviceTran = tf.getResultList();
						for (TransactionField f : serviceTran) {
							if (countFieldValue(f.getId(), Constants.TRANSACTION_TYPE) > 0) {
								dictionariFields.add(getTransactionFieldWithValue(f));
							}

						}

					} else {
						if (Constants.PAYMENT_TYPE.equals(dicCompanyProductType.getType())) {
							TypedQuery<PaymentTypeFields> tf = em.createNamedQuery("PaymentTypeFields.findByFunctionalityGroup", PaymentTypeFields.class)
									.setParameter("groupId", functionalityGroup.getId());

							List<PaymentTypeFields> paymentField = tf.getResultList();
							for (PaymentTypeFields f : paymentField) {

								if (countFieldValue(f.getFieldId(), Constants.PAYMENT_TYPE) > 0) {
									dictionariFields.add(getPaymentTypeFieldWithValue(f));
								}

							}

						} else {
							for (DictionaryField f : functionalityGroup.getDictionaryFields()) {
								if (countFieldValue(f.getId(), functionalityGroup.getDicCompanyProductType().getType()) > 0) {
									dictionariFields.add(getDictionaryFieldWithValue(f, functionalityGroup.getDicCompanyProductType().getType()));
								}
							}

						}
					}

				}
			}
			return dictionariFields;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.012"), ex);
			throw new BusinessException(6900179, "No se pudo obtener los validadores para el grupo seleccionado");
		} finally {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.002", "getFieldByDictionaryAndvalues"));
		}
	}

	private Long countFieldValue(Long id, String type) {
		Long count = 0l;
		if (Constants.TRANSACTION_TYPE.equals(type)) {
			count = em.createNamedQuery("FieldValue.countRelatedFieldsValues", Long.class).setParameter("fieldId", id)
					.setParameter("type", Constants.TRANSACTION_TYPE).getSingleResult();
		} else {
			if (Constants.PAYMENT_TYPE.equals(type)) {
				count = em.createNamedQuery("FieldValue.countRelatedFieldsValues", Long.class).setParameter("fieldId", id)
						.setParameter("type", Constants.PAYMENT_TYPE).getSingleResult();
			} else {
				count = em.createNamedQuery("FieldValue.countRelatedFieldsValues", Long.class).setParameter("fieldId", id).setParameter("type", type)
						.getSingleResult();
			}
		}
		return count;
	}

	private DictionaryField getTransactionFieldWithValue(TransactionField f) {
		DictionaryField df = new DictionaryField();
		df.setId(f.getId());
		df.setName(f.getName());
		df.setDescription(f.getDescription());
		df.setValueType(f.getValueType());
		df.setEnabled(f.getEnabled());
		df.setRequired(f.getRequired());
		df.setModifyInherited(f.getModifyInherited());
		df.setFieldvalues(new ArrayList<FieldValue>());
		df.setValidators(new ArrayList<FieldValidator>());
		List<FieldValue> fieldValues = new ArrayList<FieldValue>();
		fieldValues = em.createNamedQuery("FieldValue.findAllByField", FieldValue.class).setParameter("fieldId", df.getId())
				.setParameter("type", Constants.TRANSACTION_TYPE).getResultList();
		logger.logInfo("fieldValues " + fieldValues);
		for (FieldValue fv : fieldValues) {
			FieldValue fvs = new FieldValue();
			fvs.setId(fv.getId());
			fvs.setFieldsId(fv.getFieldsId());
			fvs.setDefualtValue(fv.getDefualtValue());
			fvs.setDescription(fv.getDescription());
			fvs.setValue(fv.getValue());
			fvs.setType(fv.getType());
			fvs.setDictionaryField(df);
			df.getFieldvalues().add(fvs);

		}
		return df;
	}

	private DictionaryField getPaymentTypeFieldWithValue(PaymentTypeFields f) {
		DictionaryField df = new DictionaryField();
		df.setId(f.getFieldId());
		df.setName(f.getName());
		df.setDescription(f.getDescription());
		df.setValueType(f.getValueType());
		df.setEnabled(f.getEnabled());
		df.setRequired(f.getRequired());
		// df.setModifyInherited(f.getModifyInherited());
		df.setFieldvalues(new ArrayList<FieldValue>());
		df.setValidators(new ArrayList<FieldValidator>());
		List<FieldValue> fieldValues = new ArrayList<FieldValue>();
		fieldValues = em.createNamedQuery("FieldValue.findAllByField", FieldValue.class).setParameter("fieldId", df.getId())
				.setParameter("type", Constants.PAYMENT_TYPE).getResultList();
		for (FieldValue fv : fieldValues) {
			FieldValue fvs = new FieldValue();
			fvs.setId(fv.getId());
			fvs.setFieldsId(fv.getFieldsId());
			fvs.setDefualtValue(fv.getDefualtValue());
			fvs.setDescription(fv.getDescription());
			fvs.setValue(fv.getValue());
			fvs.setType(fv.getType());
			fvs.setDictionaryField(df);
			df.getFieldvalues().add(fvs);

		}
		return df;
	}

	private DictionaryField getDictionaryFieldWithValue(DictionaryField f, String type) {
		DictionaryField df = new DictionaryField();
		df.setId(f.getId());
		df.setName(f.getName());
		df.setDescription(f.getDescription());
		df.setValueType(f.getValueType());
		df.setEnabled(f.getEnabled());
		df.setRequired(f.getRequired());
		// df.setModifyInherited(f.getModifyInherited());
		df.setFieldvalues(new ArrayList<FieldValue>());
		df.setValidators(new ArrayList<FieldValidator>());
		List<FieldValue> fieldValues = new ArrayList<FieldValue>();
		fieldValues = em.createNamedQuery("FieldValue.findAllByField", FieldValue.class).setParameter("fieldId", df.getId()).setParameter("type", type)
				.getResultList();
		for (FieldValue fv : fieldValues) {
			FieldValue fvs = new FieldValue();
			fvs.setId(fv.getId());
			fvs.setFieldsId(fv.getFieldsId());
			fvs.setDefualtValue(fv.getDefualtValue());
			fvs.setDescription(fv.getDescription());
			fvs.setValue(fv.getValue());
			fvs.setType(fv.getType());
			fvs.setDictionaryField(df);
			df.getFieldvalues().add(fvs);

		}
		return df;
	}

	// end-region

	// region Properties
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

	// end-region

	public DictionaryField getDicFunctionalityByFieldId(Long id) {
		try {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.001", "getDicFunctionalityByFieldId"));
			return em.createNamedQuery("DictionaryField.findByFieldId", DictionaryField.class).setParameter("fieldId", id).getSingleResult();
		} catch (NonUniqueResultException nur) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.006"), nur);
			throw new BusinessException(6900010, "No se pudo obtener el grupo del campo solicitado");
		} catch (NoResultException nre) {
			return null;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.009"), ex);
			throw new BusinessException(6900010, "No se pudo obtener el grupo del campo solicitado");
		} finally {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.002", "getDicFunctionalityByFieldId"));
		}
	}

	/**
	 * Get the fields with head mark of dictionary
	 */
	public Map<Long, String> getHeaderDictionary(DicCompanyProductTypeId dictionaryId) {
		try {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.001", "getHeaderDictionary"));
			Map<Long, String> headDictionary = new HashMap<Long, String>();
			List<DicFunctionalityGroup> groups = new ArrayList<DicFunctionalityGroup>();
			logger.logDebug("dictionaryId-->" + dictionaryId.toString());
			DicCompanyProductType productType = getDictionaryById(dictionaryId);
			if (productType != null) {
				logger.logDebug("productType-->" + productType.toString());
				groups = productType.getDictFunctionalityGroups();
			} else
				logger.logDebug("productType--> NULL");

			if (groups != null) {
				logger.logDebug("groups-->" + groups.toString());
				for (DicFunctionalityGroup dicFunctionalityGroup : groups) {
					for (DictionaryField dictionary : dicFunctionalityGroup.getDictionaryFields()) {
						if (Constants.YES.equalsIgnoreCase(dictionary.getIsHead())) {
							// headDictionary.add(dictionary.getName(),
							// dictionary.getId());
							headDictionary.put(dictionary.getId(), dictionary.getName());
						}
					}
				}
			} else
				logger.logDebug("groups--> NULL");
			return headDictionary;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("DICTIONARYMANAGER.011"), ex);
			throw new BusinessException(6900021, "No se pudo obtener las cabeceras de los campos para el diccionario seleccionado");
		} finally {
			logger.logDebug(MessageManager.getString("DICTIONARYMANAGER.002", "getHeaderDictionary"));
		}
	}
}
