/*
 * File: RenderManager.java
 * Date: November 7, 2011
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

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import org.osgi.util.measurement.Unit;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.administration.service.IFieldsByProductManager;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.Company;
import com.cobiscorp.ecobis.fpm.model.DicCompanyProductType;
import com.cobiscorp.ecobis.fpm.model.DicFunctionalityGroup;
import com.cobiscorp.ecobis.fpm.model.DictionaryField;
import com.cobiscorp.ecobis.fpm.model.FieldByProduct;
import com.cobiscorp.ecobis.fpm.model.FieldByProductValues;
import com.cobiscorp.ecobis.fpm.model.FieldValidator;
import com.cobiscorp.ecobis.fpm.model.FieldValue;
import com.cobiscorp.ecobis.fpm.model.PaymentTypeFields;
import com.cobiscorp.ecobis.fpm.model.TransactionField;
import com.cobiscorp.ecobis.fpm.model.UnitFunctionalityValues;
import com.cobiscorp.ecobis.fpm.operation.service.IRenderManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

/**
 * This service manage all the operations related to obtain the meta data necessary to render the pages in the front-end
 * 
 * @author cloachamin
 */
public class RenderManager implements IRenderManager {

	/** String used to represent yes in the tables */
	public static final String YES = "S";
	/** String used to represent no in the tables */
	public static final String NO = "N";
	/** Cobis Logger */
	private static final ILogger logger = LogFactory.getLogger(RenderManager.class);

	/** Entity Manager injected by the container */
	private EntityManager em;

	IFieldsByProductManager fieldsByProductManager;

	public void setFieldsByProductManager(IFieldsByProductManager fieldsByProductManager) {
		this.fieldsByProductManager = fieldsByProductManager;
	}

	/**
	 * Find all <tt>DicFunctionalityGroup</tt> with the related entities given the dictionary
	 * 
	 * @param companyId
	 *            The <tt>Company</tt> identifier
	 * @param categoryId
	 *            The <tt>NodeTypeCategory</tt> identifier
	 * @param dictionaryType
	 *            The dictionary type (General Parameters, Item)
	 * @return a list of all <tt>DicFunctionalityGroup</tt>
	 */
	public DicCompanyProductType getMetadataByDictionary(Long companyId, Long categoryId, String dictionaryType) {
		try {

			logger.logDebug(MessageManager.getString("RENDERMANAGER.001", "getMetadataByDictionary"));
			DicCompanyProductType dic = new DicCompanyProductType();
			dic.setCompanyId(companyId);
			dic.setNodeTypeCategoryId(categoryId);
			dic.setType(dictionaryType);
			dic.setDictFunctionalityGroups(new ArrayList<DicFunctionalityGroup>());
			logger.logDebug("dictionaryType--Render-->" + dictionaryType);
			Company company = em.find(Company.class, companyId);
			do {
				try {
					DicCompanyProductType dictionary = null;
					dictionary = em.createNamedQuery("DicCompanyProductType.findByIdAndType", DicCompanyProductType.class)
							.setParameter("companyId", company.getId()).setParameter("categoryId", categoryId).setParameter("type", dictionaryType)
							.getSingleResult();

					for (DicFunctionalityGroup fg : dictionary.getDictFunctionalityGroups()) {
						DicFunctionalityGroup dfg = new DicFunctionalityGroup();
						dfg.setId(fg.getId());
						dfg.setName(fg.getName());
						dfg.setDescription(fg.getDescription());
						dfg.setEnabled(fg.getEnabled());
						dfg.setDictionaryFields(new ArrayList<DictionaryField>());

						// Carga los VALIDADORES por Grupo
						this.LoadFieldValidatorsForGroup(dfg, Constants.GROUP_TYPE);

						if (Constants.TRANSACTION_TYPE.equals(dictionaryType)) {
							TypedQuery<TransactionField> tf = em.createNamedQuery("TransactionField.findByGroup", TransactionField.class)
									.setParameter("groupId", fg.getId());
							List<TransactionField> serviceTran = tf.getResultList();
							for (TransactionField f : serviceTran) {
								DictionaryField df = new DictionaryField();
								df.setId(f.getId());
								df.setName(f.getName());
								df.setDescription(f.getDescription());
								df.setValueType(f.getValueType());
								df.setEnabled(f.getEnabled());
								df.setRequired(f.getRequired());
								df.setModifyInherited(f.getModifyInherited());
								df.setFieldvalues(new ArrayList<FieldValue>());
								List<FieldValue> fieldValues = new ArrayList<FieldValue>();
								fieldValues = em.createNamedQuery("FieldValue.findAllByField", FieldValue.class).setParameter("fieldId", df.getId())
										.setParameter("type", Constants.TRANSACTION_TYPE).getResultList();
								for (FieldValue fv : fieldValues) {
									FieldValue fvs = new FieldValue();
									fvs.setId(fv.getId());
									fvs.setFieldsId(fv.getFieldsId());
									fvs.setDefualtValue(fv.getDefualtValue());
									fvs.setDescription(fv.getDescription());
									fvs.setValue(fv.getValue());
									fvs.setType(fv.getType());
									fvs.setValueSourceId(fv.getValueSourceId());
									fvs.setDictionaryField(df);
									fvs.setDatabase(fv.getDatabase());
									df.getFieldvalues().add(fvs);

								}
								// Traer Validadores por TRANSACTION_TYPE
								this.LoadFieldValidatorsForFiels(df, Constants.TRANSACTION_TYPE);
								dfg.getDictionaryFields().add(df);

							}
						} else {
							if (Constants.PAYMENT_TYPE.equals(dictionaryType)) {
								TypedQuery<PaymentTypeFields> tf = em.createNamedQuery("PaymentTypeFields.findByFunctionalityGroup",
										PaymentTypeFields.class).setParameter("groupId", fg.getId());

								List<PaymentTypeFields> paymentField = tf.getResultList();

								for (PaymentTypeFields f : paymentField) {
									DictionaryField df = new DictionaryField();
									df.setId(f.getFieldId());
									df.setName(f.getName());
									df.setDescription(f.getDescription());
									df.setValueType(f.getValueType());
									df.setEnabled(f.getEnabled());
									df.setRequired(f.getRequired());
									df.setModifyInherited(null);
									df.setFieldvalues(new ArrayList<FieldValue>());
									List<FieldValue> fieldValues = new ArrayList<FieldValue>();
									fieldValues = em.createNamedQuery("FieldValue.findAllByField", FieldValue.class)
											.setParameter("fieldId", df.getId()).setParameter("type", Constants.PAYMENT_TYPE).getResultList();
									for (FieldValue fv : fieldValues) {
										FieldValue fvs = new FieldValue();
										fvs.setId(fv.getId());
										fvs.setFieldsId(fv.getFieldsId());
										fvs.setDefualtValue(fv.getDefualtValue());
										fvs.setDescription(fv.getDescription());
										fvs.setValue(fv.getValue());
										fvs.setType(fv.getType());
										fvs.setValueSourceId(fv.getValueSourceId());
										fvs.setDatabase(fv.getDatabase());
										fvs.setDictionaryField(df);
										df.getFieldvalues().add(fvs);
									}
									// Traer Validadores por PAYMENT_TYPE
									this.LoadFieldValidatorsForFiels(df, Constants.PAYMENT_TYPE);
									dfg.getDictionaryFields().add(df);
								}
							} else {
								logger.logDebug("dictionaryType--->" + dictionaryType);
								if (Constants.SCREEN_RENDER_TYPE.equals(dictionaryType)) {
									for (DictionaryField f : fg.getDictionaryFields()) {
										DictionaryField df = new DictionaryField();
										df.setId(f.getId());
										df.setName(f.getName());
										df.setDescription(f.getDescription());
										df.setValueType(f.getValueType());
										df.setEnabled(f.getEnabled());
										df.setRequired(f.getRequired());
										// if dictionary field accept multiple values
										df.setMultivalue(f.getMultivalue());
										df.setEvaluationProduct(f.getEvaluationProduct());
										df.setModifyInherited(f.getModifyInherited());
										df.setUnitFunctionalityvaluesList(new ArrayList<UnitFunctionalityValues>());

										List<UnitFunctionalityValues> unitFunctionalityValues = new ArrayList<UnitFunctionalityValues>();
										logger.logDebug("fieldId--> Metadata-->" + df.getId());
										unitFunctionalityValues = em
												.createNamedQuery("UnitFunctionalityValues.findAllByField", UnitFunctionalityValues.class)
												.setParameter("fieldId", df.getId()).getResultList();
										logger.logDebug("unitFunctionalityValues-->" + unitFunctionalityValues);
										for (UnitFunctionalityValues uf : unitFunctionalityValues) {
											UnitFunctionalityValues ufv = new UnitFunctionalityValues();
											BankingProduct bp = em.find(BankingProduct.class, uf.getProductId());
											if (bp == null) {
												logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.007", uf.getProductId()));
												throw new BusinessException(6900060,
														"No se pudo realizar la b�squeda del producto Bancario seleccionado requerido. No Existe");
											}
											ufv.setBankingProduct(bp);
											ufv.setProductId(bp.getId());
											ufv.setDictionaryField(df);
											ufv.setDictionaryFieldId(uf.getDictionaryFieldId());
											ufv.setRegistryId(uf.getRegistryId());
											ufv.setValue(uf.getValue());
											df.getUnitFunctionalityvaluesList().add(ufv);

										}
										// Traer Validadores por dictionaryType
										this.LoadFieldValidatorsForFiels(df, dictionaryType);
										dfg.getDictionaryFields().add(df);
									}
								} else {
									if (Constants.RENDER_SECTION.equals(dictionaryType)) {
									for (DictionaryField f : fg.getDictionaryFields()) {
										DictionaryField df = new DictionaryField();
										df.setId(f.getId());
										df.setName(f.getName());
										df.setDescription(f.getDescription());
										df.setValueType(f.getValueType());
										df.setEnabled(f.getEnabled());
										df.setRequired(f.getRequired());
											// if dictionary field accept
											// multiple values
										df.setMultivalue(f.getMultivalue());
										df.setEvaluationProduct(f.getEvaluationProduct());
										df.setModifyInherited(f.getModifyInherited());
										df.setFieldvalues(new ArrayList<FieldValue>());
										df.setUnitFunctionalityvaluesList(new ArrayList<UnitFunctionalityValues>());
										List<FieldValue> fieldValues = new ArrayList<FieldValue>();
										fieldValues = em.createNamedQuery("FieldValue.findAllByField", FieldValue.class)
												.setParameter("fieldId", df.getId()).setParameter("type", dictionaryType).getResultList();

											for (FieldValue fv : fieldValues) {
												FieldValue fvs = new FieldValue();
												fvs.setId(fv.getId());
												fvs.setFieldsId(fv.getFieldsId());
												fvs.setDefualtValue(fv.getDefualtValue());
												fvs.setDescription(fv.getDescription());
												fvs.setValue(fv.getValue());
												fvs.setType(fv.getType());
												fvs.setValueSourceId(fv.getValueSourceId());
												fvs.setDictionaryField(df);
												fvs.setDatabase(fv.getDatabase());
												df.getFieldvalues().add(fvs);

											}
											// Traer Validadores por
											// dictionaryType
											this.LoadFieldValidatorsForFiels(df, dictionaryType);
											dfg.getDictionaryFields().add(df);
										}
									} else {
										for (DictionaryField f : fg.getDictionaryFields()) {
											DictionaryField df = new DictionaryField();
											df.setId(f.getId());
											df.setName(f.getName());
											df.setDescription(f.getDescription());
											df.setValueType(f.getValueType());
											df.setEnabled(f.getEnabled());
											df.setRequired(f.getRequired());
											// if dictionary field accept
											// multiple values
											df.setMultivalue(f.getMultivalue());
											df.setEvaluationProduct(f.getEvaluationProduct());
											df.setModifyInherited(f.getModifyInherited());
											df.setFieldvalues(new ArrayList<FieldValue>());
											df.setUnitFunctionalityvaluesList(new ArrayList<UnitFunctionalityValues>());
											List<FieldValue> fieldValues = new ArrayList<FieldValue>();
											fieldValues = em.createNamedQuery("FieldValue.findAllByField", FieldValue.class)
													.setParameter("fieldId", df.getId()).setParameter("type", dictionaryType).getResultList();
										for (FieldValue fv : fieldValues) {
											FieldValue fvs = new FieldValue();
											fvs.setId(fv.getId());
											fvs.setFieldsId(fv.getFieldsId());
											fvs.setDefualtValue(fv.getDefualtValue());
											fvs.setDescription(fv.getDescription());
											fvs.setValue(fv.getValue());
											fvs.setType(fv.getType());
											fvs.setValueSourceId(fv.getValueSourceId());
											fvs.setDatabase(fv.getDatabase());
											fvs.setDictionaryField(df);
											df.getFieldvalues().add(fvs);

										}
											// Traer Validadores por
											// dictionaryType
										this.LoadFieldValidatorsForFiels(df, dictionaryType);
										dfg.getDictionaryFields().add(df);
									}
								}
							}
						}
						}
						dic.getDictFunctionalityGroups().add(dfg);

					}
				} catch (NoResultException nre) {
				}
				company = company.getParent();
			} while (company != null);
			return dic;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("RENDERMANAGER.003"), ex);
			throw new BusinessException(6900080, "No se pudo obtener la información del diccionario de datos para renderizar la pantalla");
		} finally {
			logger.logDebug(MessageManager.getString("RENDERMANAGER.002", "getMetadataByDictionary"));
		}
	}

	public DicCompanyProductType getMetadataByTypeAndNameDictionary(Long companyId, Long categoryId, String dictionaryType, String dictionaryName) {
		try {
			logger.logDebug(MessageManager.getString("RENDERMANAGER.001", "getMetadataByTypeAndNameDictionary"));
			DicCompanyProductType dic = new DicCompanyProductType();
			dic.setCompanyId(companyId);
			dic.setNodeTypeCategoryId(categoryId);
			dic.setType(dictionaryType);
			dic.setName(dictionaryName);

			dic.setDictFunctionalityGroups(new ArrayList<DicFunctionalityGroup>());
			Company company = em.find(Company.class, companyId);
			do {
				try {
					DicCompanyProductType dictionary = em.createNamedQuery("DicCompanyProductType.findByIdTypeAndName", DicCompanyProductType.class)
							.setParameter("companyId", company.getId()).setParameter("categoryId", categoryId).setParameter("type", dictionaryType)
							.setParameter("name", dictionaryName).getSingleResult();
					for (DicFunctionalityGroup fg : dictionary.getDictFunctionalityGroups()) {
						DicFunctionalityGroup dfg = new DicFunctionalityGroup();
						dfg.setId(fg.getId());
						dfg.setName(fg.getName());
						dfg.setDescription(fg.getDescription());
						dfg.setEnabled(fg.getEnabled());
						dfg.setDictionaryFields(new ArrayList<DictionaryField>());
						for (DictionaryField f : fg.getDictionaryFields()) {
							DictionaryField df = new DictionaryField();
							df.setId(f.getId());
							df.setName(f.getName());
							df.setDescription(f.getDescription());
							df.setValueType(f.getValueType());
							df.setEnabled(f.getEnabled());
							df.setRequired(f.getRequired());
							df.setModifyInherited(f.getModifyInherited());
							df.setMultivalue(f.getMultivalue());
							df.setEvaluationProduct(f.getEvaluationProduct());
							df.setFieldvalues(new ArrayList<FieldValue>());
							df.setUnitFunctionalityvaluesList(new ArrayList<UnitFunctionalityValues>());
							df.setFieldByProductValuesList(new ArrayList<FieldByProductValues>());
								List<FieldValue> fieldValues = new ArrayList<FieldValue>();
								fieldValues = em.createNamedQuery("FieldValue.findAllByField", FieldValue.class).setParameter("fieldId", df.getId())
										.setParameter("type", dictionaryType).getResultList();
								for (FieldValue fv : fieldValues) {
									FieldValue fvs = new FieldValue();
									fvs.setId(fv.getId());
									fvs.setFieldsId(fv.getFieldsId());
									fvs.setDefualtValue(fv.getDefualtValue());
									fvs.setDescription(fv.getDescription());
									fvs.setValue(fv.getValue());
									fvs.setType(fv.getType());
									fvs.setValueSourceId(fv.getValueSourceId());
									fvs.setDatabase(fv.getDatabase());
									fvs.setDictionaryField(df);
									df.getFieldvalues().add(fvs);

								}
							
								List<UnitFunctionalityValues> unitFunctionalityValues = new ArrayList<UnitFunctionalityValues>();
								logger.logDebug("fieldId--> Metadata-->" + df.getId());
								unitFunctionalityValues = em
										.createNamedQuery("UnitFunctionalityValues.findAllByField", UnitFunctionalityValues.class)
										.setParameter("fieldId", df.getId()).getResultList();
								logger.logDebug("unitFunctionalityValues-->" + unitFunctionalityValues);
								for (UnitFunctionalityValues uf : unitFunctionalityValues) {
									UnitFunctionalityValues ufv = new UnitFunctionalityValues();
									BankingProduct bp = em.find(BankingProduct.class, uf.getProductId());
									if (bp == null) {
										logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.007", uf.getProductId()));
										throw new BusinessException(6900060,
												"No se pudo realizar la b�squeda del producto Bancario seleccionado requerido. No Existe");
									}
									//TODO: validar parece innecesaria la copia
									ufv.setBankingProduct(bp);
									ufv.setProductId(bp.getId());
									ufv.setDictionaryField(df);
									ufv.setDictionaryFieldId(uf.getDictionaryFieldId());
									ufv.setRegistryId(uf.getRegistryId());
									ufv.setValue(uf.getValue());
									ufv.setDescription(uf.getDescription());
									df.getUnitFunctionalityvaluesList().add(ufv);
									logger.logDebug("df.getUnitFunctionalityvaluesList()-->"+df.getUnitFunctionalityvaluesList().toString());

							}
							// Traer Validadores por dictionaryType
							this.LoadFieldValidatorsForFiels(df, dictionaryType);
							dfg.getDictionaryFields().add(df);

						}
						dic.getDictFunctionalityGroups().add(dfg);

					}
				} catch (NoResultException nre) {
				}
				company = company.getParent();
			} while (company != null);
			return dic;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("RENDERMANAGER.003"), ex);
			throw new BusinessException(6900080, "No se pudo obtener la información del diccionario de datos para renderizar la pantalla");
		} finally {
			logger.logDebug(MessageManager.getString("RENDERMANAGER.002", "getMetadataByTypeAndNameDictionary"));
		}
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


	private void LoadFieldValidatorsForGroup(DicFunctionalityGroup dfg, String transactionType) {
		dfg.setValidators(new ArrayList<FieldValidator>());
		List<FieldValidator> fieldValidator = em.createNamedQuery("FieldValidator.findAllByField", FieldValidator.class)
				.setParameter("fieldId", dfg.getId()).setParameter("type", transactionType).getResultList();
		for (FieldValidator val : fieldValidator) {
			FieldValidator fval = new FieldValidator();
			fval.setId(val.getId());
			fval.setFieldsId(val.getFieldsId());
			fval.setField(val.getField());
			fval.setValue(val.getValue());
			fval.setType(val.getType());
			fval.setTypeParam(val.getTypeParam());
			fval.setApplyType(val.getApplyType());
			fval.setDicFunctionalityGroup(dfg);
			dfg.getValidators().add(fval);
		}
	}

	private void LoadFieldValidatorsForFiels(DictionaryField df, String transactionType) {
		df.setValidators(new ArrayList<FieldValidator>());
		List<FieldValidator> fieldValidator = em.createNamedQuery("FieldValidator.findAllByField", FieldValidator.class)
				.setParameter("fieldId", df.getId()).setParameter("type", transactionType).getResultList();
		for (FieldValidator val : fieldValidator) {
			FieldValidator fval = new FieldValidator();
			fval.setId(val.getId());
			fval.setFieldsId(val.getFieldsId());
			fval.setField(val.getField());
			fval.setValue(val.getValue());
			fval.setType(val.getType());
			fval.setTypeParam(val.getTypeParam());
			fval.setApplyType(val.getApplyType());
			fval.setDictionaryField(df);
			df.getValidators().add(fval);
		}
	}

	@Override
	public DicCompanyProductType getMetadataByProductAndType(String BankingProductId, String dictionaryType, String request) {
		try {		
			logger.logDebug(MessageManager.getString("RENDERMANAGER.001", "getMetadataByProductAndType"));
			BankingProduct bankingProduct = em.find(BankingProduct.class, BankingProductId);
			if(bankingProduct==null){
				return null;
			}
			DicCompanyProductType dic = new DicCompanyProductType();
			Long companyId = bankingProduct.getCompany().getId();
			dic.setCompanyId(companyId);
			Long categoryId = 0L;
			if (logger.isDebugEnabled()) {
				logger.logDebug("bankingProduct.getNodeTypeCategory().getId()-->" + bankingProduct.getNodeTypeCategory().getId());

			}
			BankingProduct bankingProductParent = new BankingProduct();
			long nodeTypeProductId=bankingProduct.getNodeTypeCategory().getNodeTypeProduct().getId();
			logger.logDebug("NodeTypeProductId---->"+nodeTypeProductId);
			//Verifica si el tipo de producto bancario es de nivel 3 4 o 5
			if (nodeTypeProductId == 3L) {
				categoryId = bankingProduct.getNodeTypeCategory().getId();
			} else if (nodeTypeProductId == 4L) {
				bankingProductParent = em.find(BankingProduct.class, bankingProduct.getParentnode());
				categoryId = bankingProductParent.getNodeTypeCategory().getId();
				//si es de nivel 5 el padre puede ser de nivel 3 o 4
				//si el padre es de nivel 3 toma la categoria del padre
				//si el padre es de nivel 4 sube un nivel adicional para tomar la categoria
			} else if (nodeTypeProductId == 5L) {
				
				bankingProductParent = em.find(BankingProduct.class, bankingProduct.getParentnode());
				if(bankingProductParent.getNodeTypeCategory().getNodeTypeProduct().getId()==3){
					logger.logDebug("Padre es nivel 3");
					categoryId = bankingProductParent.getNodeTypeCategory().getId();
				}else if(bankingProductParent.getNodeTypeCategory().getNodeTypeProduct().getId()==4){
					logger.logDebug("Padre es nivel 4");
					BankingProduct grandParent = em.find(BankingProduct.class, bankingProductParent.getParentnode());
					categoryId = grandParent.getNodeTypeCategory().getId();
				}
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug("Categoría encontrada de acuerdo al nivel y tipo de producto-->" + categoryId);
			}

			dic.setNodeTypeCategoryId(categoryId);
			dic.setType(dictionaryType);
			dic.setDictFunctionalityGroups(new ArrayList<DicFunctionalityGroup>());
			logger.logDebug("dictionaryType--Render-->" + dictionaryType);
			Company company = em.find(Company.class, companyId);
			do {
				try {
					DicCompanyProductType dictionary = null;
					dictionary = em.createNamedQuery("DicCompanyProductType.findByIdAndType", DicCompanyProductType.class)
							.setParameter("companyId", company.getId()).setParameter("categoryId", categoryId).setParameter("type", dictionaryType)
							.getSingleResult();

					for (DicFunctionalityGroup fg : dictionary.getDictFunctionalityGroups()) {
						DicFunctionalityGroup dfg = new DicFunctionalityGroup();
						dfg.setId(fg.getId());
						dfg.setName(fg.getName());
						dfg.setDescription(fg.getDescription());
						dfg.setEnabled(fg.getEnabled());
						dfg.setDictionaryFields(new ArrayList<DictionaryField>());

						// Carga los VALIDADORES por Grupo
						this.LoadFieldValidatorsForGroup(dfg, Constants.GROUP_TYPE);

						if (Constants.TRANSACTION_TYPE.equals(dictionaryType)) {
							TypedQuery<TransactionField> tf = em.createNamedQuery("TransactionField.findByGroup", TransactionField.class)
									.setParameter("groupId", fg.getId());
							List<TransactionField> serviceTran = tf.getResultList();
							for (TransactionField f : serviceTran) {
								DictionaryField df = new DictionaryField();
								df.setId(f.getId());
								df.setName(f.getName());
								df.setDescription(f.getDescription());
								df.setValueType(f.getValueType());
								df.setEnabled(f.getEnabled());
								df.setRequired(f.getRequired());
								df.setModifyInherited(f.getModifyInherited());
								df.setFieldvalues(new ArrayList<FieldValue>());
								List<FieldValue> fieldValues = new ArrayList<FieldValue>();
								fieldValues = em.createNamedQuery("FieldValue.findAllByField", FieldValue.class).setParameter("fieldId", df.getId())
										.setParameter("type", Constants.TRANSACTION_TYPE).getResultList();
								for (FieldValue fv : fieldValues) {
									FieldValue fvs = new FieldValue();
									fvs.setId(fv.getId());
									fvs.setFieldsId(fv.getFieldsId());
									fvs.setDefualtValue(fv.getDefualtValue());
									fvs.setDescription(fv.getDescription());
									fvs.setValue(fv.getValue());
									fvs.setType(fv.getType());
									fvs.setValueSourceId(fv.getValueSourceId());
									fvs.setDatabase(fv.getDatabase());
									fvs.setDictionaryField(df);
									df.getFieldvalues().add(fvs);

								}
								// Traer Validadores por TRANSACTION_TYPE
								this.LoadFieldValidatorsForFiels(df, Constants.TRANSACTION_TYPE);
								dfg.getDictionaryFields().add(df);

							}
						} else {
							if (Constants.PAYMENT_TYPE.equals(dictionaryType)) {
								TypedQuery<PaymentTypeFields> tf = em.createNamedQuery("PaymentTypeFields.findByFunctionalityGroup",
										PaymentTypeFields.class).setParameter("groupId", fg.getId());

								List<PaymentTypeFields> paymentField = tf.getResultList();

								for (PaymentTypeFields f : paymentField) {
									DictionaryField df = new DictionaryField();
									df.setId(f.getFieldId());
									df.setName(f.getName());
									df.setDescription(f.getDescription());
									df.setValueType(f.getValueType());
									df.setEnabled(f.getEnabled());
									df.setRequired(f.getRequired());
									df.setModifyInherited(null);
									df.setFieldvalues(new ArrayList<FieldValue>());
									List<FieldValue> fieldValues = new ArrayList<FieldValue>();
									fieldValues = em.createNamedQuery("FieldValue.findAllByField", FieldValue.class)
											.setParameter("fieldId", df.getId()).setParameter("type", Constants.PAYMENT_TYPE).getResultList();
									for (FieldValue fv : fieldValues) {
										FieldValue fvs = new FieldValue();
										fvs.setId(fv.getId());
										fvs.setFieldsId(fv.getFieldsId());
										fvs.setDefualtValue(fv.getDefualtValue());
										fvs.setDescription(fv.getDescription());
										fvs.setValue(fv.getValue());
										fvs.setType(fv.getType());
										fvs.setValueSourceId(fv.getValueSourceId());
										fvs.setDatabase(fv.getDatabase());
										fvs.setDictionaryField(df);
										df.getFieldvalues().add(fvs);
									}
									// Traer Validadores por PAYMENT_TYPE
									this.LoadFieldValidatorsForFiels(df, Constants.PAYMENT_TYPE);
									dfg.getDictionaryFields().add(df);
								}
							} else {
								logger.logDebug("dictionaryType--->" + dictionaryType);
								if (Constants.SCREEN_RENDER_TYPE.equals(dictionaryType)) {
									for (DictionaryField f : fg.getDictionaryFields()) {
										DictionaryField df = new DictionaryField();
										df.setId(f.getId());
										df.setName(f.getName());
										df.setDescription(f.getDescription());
										df.setValueType(f.getValueType());
										df.setEnabled(f.getEnabled());
										df.setRequired(f.getRequired());
										// if dictionary field accept multiple
										// values
										df.setMultivalue(f.getMultivalue());
										df.setEvaluationProduct(f.getEvaluationProduct());
										df.setModifyInherited(f.getModifyInherited());
										df.setUnitFunctionalityvaluesList(new ArrayList<UnitFunctionalityValues>());

										List<UnitFunctionalityValues> unitFunctionalityValues = new ArrayList<UnitFunctionalityValues>();
										logger.logDebug("fieldId--> Metadata-->" + df.getId());
										unitFunctionalityValues = em
												.createNamedQuery("UnitFunctionalityValues.findAllByField", UnitFunctionalityValues.class)
												.setParameter("fieldId", df.getId()).getResultList();
										logger.logDebug("unitFunctionalityValues-->" + unitFunctionalityValues);
										for (UnitFunctionalityValues uf : unitFunctionalityValues) {
											UnitFunctionalityValues ufv = new UnitFunctionalityValues();
											BankingProduct bp = em.find(BankingProduct.class, uf.getProductId());
											if (bp == null) {
												logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.007", uf.getProductId()));
												throw new BusinessException(6900060,
														"No se pudo realizar la b?squeda del producto Bancario seleccionado requerido. No Existe");
											}
											ufv.setBankingProduct(bp);
											ufv.setProductId(bp.getId());
											ufv.setDictionaryField(df);
											ufv.setDictionaryFieldId(uf.getDictionaryFieldId());
											ufv.setRegistryId(uf.getRegistryId());
											ufv.setValue(uf.getValue());
											df.getUnitFunctionalityvaluesList().add(ufv);

										}
										// Traer Validadores por dictionaryType
										this.LoadFieldValidatorsForFiels(df, dictionaryType);
										dfg.getDictionaryFields().add(df);
									}
								} else {
									if (Constants.RENDER_SECTION.equals(dictionaryType)) {
										logger.logDebug("bankingProduct.getId()-->" + bankingProduct.getId() + "fg.getId()-->" + fg.getId());
										List<DictionaryField> dictioFieldByProduct = fieldsByProductManager.getAllSectionFieldsByProductAndGrp(
												bankingProduct.getId(), fg.getId());
										//TODO indicar a este nivel si es mandatory cada uno!!
										for (DictionaryField f : dictioFieldByProduct) {
											DictionaryField df = new DictionaryField();
											df.setId(f.getId());
											df.setName(f.getName());
											df.setDescription(f.getDescription());
											df.setValueType(f.getValueType());
											df.setEnabled(f.getEnabled());
											df.setMultivalue(f.getMultivalue());
											df.setEvaluationProduct(f.getEvaluationProduct());
											df.setModifyInherited(f.getModifyInherited());
											df.setFieldvalues(new ArrayList<FieldValue>());
											df.setFieldByProductValuesList(new ArrayList<FieldByProductValues>());
											df.setUnitFunctionalityvaluesList(new ArrayList<UnitFunctionalityValues>());
											
											FieldByProduct fieldByProduct=em.createNamedQuery("FieldByProduct.findByProductAndField",FieldByProduct.class).setParameter("product", bankingProduct.getId()).
											setParameter("fieldId", df.getId()).getSingleResult();
											logger.logDebug("MANDATORIO-->Campo: "+fieldByProduct.getField() + "Valor "+fieldByProduct.getMandatory());
											df.setRequired(fieldByProduct.getMandatory()== true?Constants.YES: Constants.NO);
												
											//Para cargar la info que se guardo asociada a un campo
											List<FieldByProductValues> fieldBPValues = new ArrayList<FieldByProductValues>();
											
											fieldBPValues = em.createNamedQuery("FieldByProductValues.findAllByField", FieldByProductValues.class)
													.setParameter("product", bankingProduct.getId())
													.setParameter("field", df.getId())
													.setParameter("request", request).getResultList();													
											logger.logDebug("valores para diccionario FieldByProductValues>>> "+ fieldBPValues);
											for (FieldByProductValues fv : fieldBPValues) {
												FieldByProductValues fvs = new FieldByProductValues();
												fvs.setField(fv.getField());
												/*if(fv.getFieldByProduct() != null){
													logger.logDebug("MANDATORIO-->Campo: "+fv.getField() + "Valor "+fv.getFieldByProduct().getMandatory());
													df.setRequired(fv.getFieldByProduct().getMandatory()== true?Constants.YES: Constants.NO);
												}*/
												fvs.setProduct(fv.getProduct());
												fvs.setRequest(fv.getRequest());
												fvs.setValue(fv.getValue());
												fvs.setRegisterId(fv.getRegisterId());
												df.getFieldByProductValuesList().add(fvs);
											}
											
											//SMO - para recuperar los valores a pintarse en cada campo, por ejemplo para llenar un combo 
											List<FieldValue> fieldValues = new ArrayList<FieldValue>();
											fieldValues = em.createNamedQuery("FieldValue.findAllByField", FieldValue.class).setParameter("fieldId", df.getId())
													.setParameter("type", dictionaryType).getResultList();
											logger.logDebug("Recuperando valores para llenar cada campo>>>"+fieldValues);
											for (FieldValue fv : fieldValues) {
												FieldValue fvs = new FieldValue();
												fvs.setId(fv.getId());
												fvs.setFieldsId(fv.getFieldsId());
												fvs.setDefualtValue(fv.getDefualtValue());
												fvs.setDescription(fv.getDescription());
												fvs.setValue(fv.getValue());
												fvs.setType(fv.getType());
												fvs.setValueSourceId(fv.getValueSourceId());
												fvs.setDatabase(fv.getDatabase());
												fvs.setDictionaryField(df);
												df.getFieldvalues().add(fvs);
											}

											

											// Traer Validadores por
											// dictionaryType
											this.LoadFieldValidatorsForFiels(df, dictionaryType);
											dfg.getDictionaryFields().add(df);
										}
									} else {
										for (DictionaryField f : fg.getDictionaryFields()) {
											DictionaryField df = new DictionaryField();
											df.setId(f.getId());
											df.setName(f.getName());
											df.setDescription(f.getDescription());
											df.setValueType(f.getValueType());
											df.setEnabled(f.getEnabled());
											df.setRequired(f.getRequired());
											// if dictionary field accept
											// multiple values
											df.setMultivalue(f.getMultivalue());
											df.setEvaluationProduct(f.getEvaluationProduct());
											df.setModifyInherited(f.getModifyInherited());
											df.setFieldvalues(new ArrayList<FieldValue>());
											df.setUnitFunctionalityvaluesList(new ArrayList<UnitFunctionalityValues>());
											List<FieldValue> fieldValues = new ArrayList<FieldValue>();
											fieldValues = em.createNamedQuery("FieldValue.findAllByField", FieldValue.class)
													.setParameter("fieldId", df.getId()).setParameter("type", dictionaryType).getResultList();
											List<FieldByProduct> fieldByProduct = fieldsByProductManager.getAllSectionFieldsByProduct("");// bankingProductId);

											for (FieldValue fv : fieldValues) {
												FieldValue fvs = new FieldValue();
												fvs.setId(fv.getId());
												fvs.setFieldsId(fv.getFieldsId());
												fvs.setDefualtValue(fv.getDefualtValue());
												fvs.setDescription(fv.getDescription());
												fvs.setValue(fv.getValue());
												fvs.setType(fv.getType());
												fvs.setValueSourceId(fv.getValueSourceId());
												fvs.setDatabase(fv.getDatabase());
												fvs.setDictionaryField(df);
												df.getFieldvalues().add(fvs);

											}
											// Traer Validadores por
											// dictionaryType
											this.LoadFieldValidatorsForFiels(df, dictionaryType);
											dfg.getDictionaryFields().add(df);
										}
									}
								}
							}
						}
						dic.getDictFunctionalityGroups().add(dfg);

					}
				} catch (NoResultException nre) {
				}
				company = company.getParent();
			} while (company != null);
			return dic;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("RENDERMANAGER.003"), ex);
			throw new BusinessException(6900080, "No se pudo obtener la información del diccionario de datos para renderizar la pantalla");
		} finally {
			logger.logDebug(MessageManager.getString("RENDERMANAGER.002", "getMetadataByProductAndType"));
		}
	}
	
	public DicCompanyProductType getItemsByFieldAndRegister(String BankingProductId, String dictionaryType, String request, String registerId) {
		try {

			logger.logDebug(MessageManager.getString("RENDERMANAGER.001", "getItemsByFieldAndRegister"));
			BankingProduct bankingProduct = em.find(BankingProduct.class, BankingProductId);
			if(bankingProduct==null){
				return null;
			}
			DicCompanyProductType dic = new DicCompanyProductType();
			Long companyId = bankingProduct.getCompany().getId();
			dic.setCompanyId(companyId);
			Long categoryId = 0L;
			if (logger.isDebugEnabled()) {
				logger.logDebug("bankingProduct.getNodeTypeCategory().getId()-->" + bankingProduct.getNodeTypeCategory().getId());

			}
			BankingProduct bankingProductParent = new BankingProduct();
			long nodeTypeProductId=bankingProduct.getNodeTypeCategory().getNodeTypeProduct().getId();
			logger.logDebug("NodeTypeProductId---->"+nodeTypeProductId);
			//Verifica si el tipo de producto bancario es de nivel 3 4 o 5
			if (nodeTypeProductId == 3L) {
				categoryId = bankingProduct.getNodeTypeCategory().getId();
			} else if (nodeTypeProductId == 4L) {
				bankingProductParent = em.find(BankingProduct.class, bankingProduct.getParentnode());
				categoryId = bankingProductParent.getNodeTypeCategory().getId();
				//si es de nivel 5 el padre puede ser de nivel 3 o 4
				//si el padre es de nivel 3 toma la categoria del padre
				//si el padre es de nivel 4 sube un nivel adicional para tomar la categoria
			} else if (nodeTypeProductId == 5L) {
				
				bankingProductParent = em.find(BankingProduct.class, bankingProduct.getParentnode());
				if(bankingProductParent.getNodeTypeCategory().getNodeTypeProduct().getId()==3){
					logger.logDebug("Padre es nivel 3");
					categoryId = bankingProductParent.getNodeTypeCategory().getId();
				}else if(bankingProductParent.getNodeTypeCategory().getNodeTypeProduct().getId()==4){
					logger.logDebug("Padre es nivel 4");
					BankingProduct grandParent = em.find(BankingProduct.class, bankingProductParent.getParentnode());
					categoryId = grandParent.getNodeTypeCategory().getId();
				}
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug("Categoría encontrada de acuerdo al nivel y tipo de producto-->" + categoryId);
			}

			dic.setNodeTypeCategoryId(categoryId);
			dic.setType(dictionaryType);
			dic.setDictFunctionalityGroups(new ArrayList<DicFunctionalityGroup>());
			logger.logDebug("dictionaryType--Render-->" + dictionaryType);
			Company company = em.find(Company.class, companyId);
			do {
				try {
					DicCompanyProductType dictionary = null;
					dictionary = em.createNamedQuery("DicCompanyProductType.findByIdAndType", DicCompanyProductType.class)
							.setParameter("companyId", company.getId()).setParameter("categoryId", categoryId).setParameter("type", dictionaryType)
							.getSingleResult();

					for (DicFunctionalityGroup fg : dictionary.getDictFunctionalityGroups()) {
						DicFunctionalityGroup dfg = new DicFunctionalityGroup();
						dfg.setId(fg.getId());
						dfg.setName(fg.getName());
						dfg.setDescription(fg.getDescription());
						dfg.setEnabled(fg.getEnabled());
						dfg.setDictionaryFields(new ArrayList<DictionaryField>());

						// Carga los VALIDADORES por Grupo
						this.LoadFieldValidatorsForGroup(dfg, Constants.GROUP_TYPE);

						if (Constants.TRANSACTION_TYPE.equals(dictionaryType)) {
							TypedQuery<TransactionField> tf = em.createNamedQuery("TransactionField.findByGroup", TransactionField.class)
									.setParameter("groupId", fg.getId());
							List<TransactionField> serviceTran = tf.getResultList();
							for (TransactionField f : serviceTran) {
								DictionaryField df = new DictionaryField();
								df.setId(f.getId());
								df.setName(f.getName());
								df.setDescription(f.getDescription());
								df.setValueType(f.getValueType());
								df.setEnabled(f.getEnabled());
								df.setRequired(f.getRequired());
								df.setModifyInherited(f.getModifyInherited());
								df.setFieldvalues(new ArrayList<FieldValue>());
								List<FieldValue> fieldValues = new ArrayList<FieldValue>();
								fieldValues = em.createNamedQuery("FieldValue.findAllByField", FieldValue.class).setParameter("fieldId", df.getId())
										.setParameter("type", Constants.TRANSACTION_TYPE).getResultList();
								for (FieldValue fv : fieldValues) {
									FieldValue fvs = new FieldValue();
									fvs.setId(fv.getId());
									fvs.setFieldsId(fv.getFieldsId());
									fvs.setDefualtValue(fv.getDefualtValue());
									fvs.setDescription(fv.getDescription());
									fvs.setValue(fv.getValue());
									fvs.setType(fv.getType());
									fvs.setValueSourceId(fv.getValueSourceId());
									fvs.setDatabase(fv.getDatabase());
									fvs.setDictionaryField(df);
									df.getFieldvalues().add(fvs);

								}
								// Traer Validadores por TRANSACTION_TYPE
								this.LoadFieldValidatorsForFiels(df, Constants.TRANSACTION_TYPE);
								dfg.getDictionaryFields().add(df);

							}
						} else {
							if (Constants.PAYMENT_TYPE.equals(dictionaryType)) {
								TypedQuery<PaymentTypeFields> tf = em.createNamedQuery("PaymentTypeFields.findByFunctionalityGroup",
										PaymentTypeFields.class).setParameter("groupId", fg.getId());

								List<PaymentTypeFields> paymentField = tf.getResultList();

								for (PaymentTypeFields f : paymentField) {
									DictionaryField df = new DictionaryField();
									df.setId(f.getFieldId());
									df.setName(f.getName());
									df.setDescription(f.getDescription());
									df.setValueType(f.getValueType());
									df.setEnabled(f.getEnabled());
									df.setRequired(f.getRequired());
									df.setModifyInherited(null);
									df.setFieldvalues(new ArrayList<FieldValue>());
									List<FieldValue> fieldValues = new ArrayList<FieldValue>();
									fieldValues = em.createNamedQuery("FieldValue.findAllByField", FieldValue.class)
											.setParameter("fieldId", df.getId()).setParameter("type", Constants.PAYMENT_TYPE).getResultList();
									for (FieldValue fv : fieldValues) {
										FieldValue fvs = new FieldValue();
										fvs.setId(fv.getId());
										fvs.setFieldsId(fv.getFieldsId());
										fvs.setDefualtValue(fv.getDefualtValue());
										fvs.setDescription(fv.getDescription());
										fvs.setValue(fv.getValue());
										fvs.setType(fv.getType());
										fvs.setValueSourceId(fv.getValueSourceId());
										fvs.setDatabase(fv.getDatabase());
										fvs.setDictionaryField(df);
										df.getFieldvalues().add(fvs);
									}
									// Traer Validadores por PAYMENT_TYPE
									this.LoadFieldValidatorsForFiels(df, Constants.PAYMENT_TYPE);
									dfg.getDictionaryFields().add(df);
								}
							} else {
								logger.logDebug("dictionaryType--->" + dictionaryType);
								if (Constants.SCREEN_RENDER_TYPE.equals(dictionaryType)) {
									for (DictionaryField f : fg.getDictionaryFields()) {
										DictionaryField df = new DictionaryField();
										df.setId(f.getId());
										df.setName(f.getName());
										df.setDescription(f.getDescription());
										df.setValueType(f.getValueType());
										df.setEnabled(f.getEnabled());
										df.setRequired(f.getRequired());
										// if dictionary field accept multiple
										// values
										df.setMultivalue(f.getMultivalue());
										df.setEvaluationProduct(f.getEvaluationProduct());
										df.setModifyInherited(f.getModifyInherited());
										df.setUnitFunctionalityvaluesList(new ArrayList<UnitFunctionalityValues>());

										List<UnitFunctionalityValues> unitFunctionalityValues = new ArrayList<UnitFunctionalityValues>();
										logger.logDebug("fieldId--> Metadata-->" + df.getId());
										unitFunctionalityValues = em
												.createNamedQuery("UnitFunctionalityValues.findAllByField", UnitFunctionalityValues.class)
												.setParameter("fieldId", df.getId()).getResultList();
										logger.logDebug("unitFunctionalityValues-->" + unitFunctionalityValues);
										for (UnitFunctionalityValues uf : unitFunctionalityValues) {
											UnitFunctionalityValues ufv = new UnitFunctionalityValues();
											BankingProduct bp = em.find(BankingProduct.class, uf.getProductId());
											if (bp == null) {
												logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.007", uf.getProductId()));
												throw new BusinessException(6900060,
														"No se pudo realizar la b?squeda del producto Bancario seleccionado requerido. No Existe");
											}
											ufv.setBankingProduct(bp);
											ufv.setProductId(bp.getId());
											ufv.setDictionaryField(df);
											ufv.setDictionaryFieldId(uf.getDictionaryFieldId());
											ufv.setRegistryId(uf.getRegistryId());
											ufv.setValue(uf.getValue());
											df.getUnitFunctionalityvaluesList().add(ufv);

										}
										// Traer Validadores por dictionaryType
										this.LoadFieldValidatorsForFiels(df, dictionaryType);
										dfg.getDictionaryFields().add(df);
									}
								} else {
									if (Constants.RENDER_SECTION.equals(dictionaryType)) {
										logger.logDebug("bankingProduct.getId()-->" + bankingProduct.getId() + "fg.getId()-->" + fg.getId());
										List<DictionaryField> dictioFieldByProduct = fieldsByProductManager.getAllSectionFieldsByProductAndGrp(
												bankingProduct.getId(), fg.getId());
										//TODO indicar a este nivel si es mandatory cada uno!!
										for (DictionaryField f : dictioFieldByProduct) {
											DictionaryField df = new DictionaryField();
											df.setId(f.getId());
											df.setName(f.getName());
											df.setDescription(f.getDescription());
											df.setValueType(f.getValueType());
											df.setEnabled(f.getEnabled());
											df.setMultivalue(f.getMultivalue());
											df.setEvaluationProduct(f.getEvaluationProduct());
											df.setModifyInherited(f.getModifyInherited());
											df.setFieldvalues(new ArrayList<FieldValue>());
											df.setFieldByProductValuesList(new ArrayList<FieldByProductValues>());
											df.setUnitFunctionalityvaluesList(new ArrayList<UnitFunctionalityValues>());
											
											FieldByProduct fieldByProduct=em.createNamedQuery("FieldByProduct.findByProductAndField",FieldByProduct.class).setParameter("product", bankingProduct.getId()).
											setParameter("fieldId", df.getId()).getSingleResult();
											logger.logDebug("MANDATORIO-->Campo: "+fieldByProduct.getField() + "Valor "+fieldByProduct.getMandatory());
											df.setRequired(fieldByProduct.getMandatory()== true?Constants.YES: Constants.NO);
												
											//Para cargar la info que se guardo asociada a un campo
											List<FieldByProductValues> fieldBPValues = new ArrayList<FieldByProductValues>();
											
											fieldBPValues = em.createNamedQuery("FieldByProductValues.findAllByFieldAndRegister", FieldByProductValues.class)
													.setParameter("product", bankingProduct.getId())
													.setParameter("field", df.getId())
													.setParameter("request", request)
													.setParameter("registerId", registerId).getResultList();
											logger.logDebug("valores para diccionario FieldByProductValues>>> "+ fieldBPValues);
											for (FieldByProductValues fv : fieldBPValues) {
												FieldByProductValues fvs = new FieldByProductValues();
												fvs.setField(fv.getField());
												/*if(fv.getFieldByProduct() != null){
													logger.logDebug("MANDATORIO-->Campo: "+fv.getField() + "Valor "+fv.getFieldByProduct().getMandatory());
													df.setRequired(fv.getFieldByProduct().getMandatory()== true?Constants.YES: Constants.NO);
												}*/
												fvs.setProduct(fv.getProduct());
												fvs.setRequest(fv.getRequest());
												fvs.setValue(fv.getValue());
												fvs.setRegisterId(fv.getRegisterId());
												df.getFieldByProductValuesList().add(fvs);
											}
											
											//SMO - para recuperar los valores a pintarse en cada campo, por ejemplo para llenar un combo 
											List<FieldValue> fieldValues = new ArrayList<FieldValue>();
											fieldValues = em.createNamedQuery("FieldValue.findAllByField", FieldValue.class).setParameter("fieldId", df.getId())
													.setParameter("type", dictionaryType).getResultList();
											logger.logDebug("Recuperando valores para llenar cada campo>>>"+fieldValues);
											for (FieldValue fv : fieldValues) {
												FieldValue fvs = new FieldValue();
												fvs.setId(fv.getId());
												fvs.setFieldsId(fv.getFieldsId());
												fvs.setDefualtValue(fv.getDefualtValue());
												fvs.setDescription(fv.getDescription());
												fvs.setValue(fv.getValue());
												fvs.setType(fv.getType());
												fvs.setValueSourceId(fv.getValueSourceId());
												fvs.setDatabase(fv.getDatabase());
												fvs.setDictionaryField(df);
												df.getFieldvalues().add(fvs);
											}
											// Traer Validadores por
											// dictionaryType
											this.LoadFieldValidatorsForFiels(df, dictionaryType);
											dfg.getDictionaryFields().add(df);
										}
									} else {
										for (DictionaryField f : fg.getDictionaryFields()) {
											DictionaryField df = new DictionaryField();
											df.setId(f.getId());
											df.setName(f.getName());
											df.setDescription(f.getDescription());
											df.setValueType(f.getValueType());
											df.setEnabled(f.getEnabled());
											df.setRequired(f.getRequired());
											// if dictionary field accept
											// multiple values
											df.setMultivalue(f.getMultivalue());
											df.setEvaluationProduct(f.getEvaluationProduct());
											df.setModifyInherited(f.getModifyInherited());
											df.setFieldvalues(new ArrayList<FieldValue>());
											df.setUnitFunctionalityvaluesList(new ArrayList<UnitFunctionalityValues>());
											List<FieldValue> fieldValues = new ArrayList<FieldValue>();
											fieldValues = em.createNamedQuery("FieldValue.findAllByField", FieldValue.class)
													.setParameter("fieldId", df.getId()).setParameter("type", dictionaryType).getResultList();
											List<FieldByProduct> fieldByProduct = fieldsByProductManager.getAllSectionFieldsByProduct("");// bankingProductId);

											for (FieldValue fv : fieldValues) {
												FieldValue fvs = new FieldValue();
												fvs.setId(fv.getId());
												fvs.setFieldsId(fv.getFieldsId());
												fvs.setDefualtValue(fv.getDefualtValue());
												fvs.setDescription(fv.getDescription());
												fvs.setValue(fv.getValue());
												fvs.setType(fv.getType());
												fvs.setValueSourceId(fv.getValueSourceId());
												fvs.setDatabase(fv.getDatabase());
												fvs.setDictionaryField(df);
												df.getFieldvalues().add(fvs);

											}
											// Traer Validadores por
											// dictionaryType
											this.LoadFieldValidatorsForFiels(df, dictionaryType);
											dfg.getDictionaryFields().add(df);
										}
									}
								}
							}
						}
						dic.getDictFunctionalityGroups().add(dfg);

					}
				} catch (NoResultException nre) {
				}
				company = company.getParent();
			} while (company != null);
			return dic;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("RENDERMANAGER.003"), ex);
			throw new BusinessException(6900080, "No se pudo obtener la información del diccionario de datos para renderizar la pantalla");
		} finally {
			logger.logDebug(MessageManager.getString("RENDERMANAGER.002", "getItemsByFieldAndRegister"));
		}
	}
}
