package com.cobiscorp.ecobis.fpm.administration.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.administration.service.IFieldsByProductManager;
import com.cobiscorp.ecobis.fpm.model.DictionaryField;
import com.cobiscorp.ecobis.fpm.model.FieldByProduct;
import com.cobiscorp.ecobis.fpm.model.FieldByProductId;
import com.cobiscorp.ecobis.fpm.operation.service.IFieldsByProductValuesManager;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

public class FieldsByProductManager implements IFieldsByProductManager {
	/** COBIS Logger */
	private static final ILogger logger = LogFactory
			.getLogger(FieldsByProductManager.class);

	/** Entity Manager injected by the container */
	private EntityManager em;

	IFieldsByProductValuesManager fieldsByProductValuesManager;

	@Override
	public List<FieldByProduct> getAllSectionFieldsByProduct(
			String bankingProductId) {
		try {
			logger.logDebug(MessageManager.getString(
					"FIELDSBYPRODUCTMANAGER.001",
					"getAllSectionFieldsByProduct"));

			List<FieldByProduct> fieldByProduct = new ArrayList<FieldByProduct>();

			fieldByProduct = em
					.createNamedQuery("FieldByProduct.findByProduct",
							FieldByProduct.class)
					.setParameter("product", bankingProductId).getResultList();
			if (logger.isDebugEnabled()) {
				logger.logDebug("fieldByProduct in getAllSectionFieldsByProduct -->"
						+ fieldByProduct.size());
			}
			return fieldByProduct;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("FIELDSBYPRODUCTMANAGER.006"), ex);
			throw new BusinessException(6900010,
					"No se pudo realizar la búsqueda del diccionario requerido");
		}

	}

	public void insertListFieldByProduct(
			ArrayList<FieldByProduct> fieldByproductList,
			String BankingProductId) {
		try {
			logger.logDebug("insertListFieldByProduct lista de Productos>> "
					+ fieldByproductList);
			logger.logDebug(MessageManager.getString(
					"FIELDSBYPRODUCTMANAGER.001", "insertListFieldByProduct"));
			// Elimino si existe datos para el producto
			// deleteFieldByProduct(BankingProductId);
			// Inserto los valores enviados
			if (fieldByproductList != null && fieldByproductList.size() > 0) {
				for (FieldByProduct fieldByProduct : fieldByproductList) {
					logger.logDebug("insertListFieldByProduct producto>>"+fieldByProduct);
					FieldByProductId fielId = new FieldByProductId(
							BankingProductId, fieldByProduct.getField());
					FieldByProduct field = em
							.find(FieldByProduct.class, fielId);
					if (field == null) {
						// Inserta si no encuentra
						if (fieldByProduct.getSelect()) {
							if (logger.isDebugEnabled()) {
								logger.logDebug("Ingresa al persist con: "
										+ fieldByProduct);
							}
							em.persist(fieldByProduct);
							em.flush();
						}
					} else {
						// Update si encuentra y esta seleccionado
						if (fieldByProduct.getSelect()!=null && fieldByProduct.getSelect()) {
							if (logger.isDebugEnabled()) {
								logger.logDebug("Ingresa al merge con: "
										+ fieldByProduct);
							}
							em.merge(fieldByProduct);
							em.flush();
							
						} else {
							// Lo encontro almacenado en la bdd pero ya no
							// se encuentra seleccionado en FE por lo que
							// elimina
							if (logger.isDebugEnabled()) {
								logger.logDebug("Ingresa al remove con: "
										+ field);
							}
							em.remove(field);
							em.flush();
							
						}

					}
				}

			}
		} catch (PersistenceException eee) {
			logger.logError(MessageManager.getString("FIELDSBYPRODUCTMANAGER.009", fieldByproductList == null ? null : fieldByproductList.toString()), eee);
			throw new BusinessException(6900023, "No se pudo ingresar la información correspondiente a la configuración, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("FIELDSBYPRODUCTMANAGER.003", fieldByproductList == null ? null : fieldByproductList.toString()), ex);
			// TODO: CAMBIAR ESTE MENSAJE EN LA BASE DE DATOS esta dando no se
			// puede eliminar
			throw new BusinessException(6900023, "No se pudo ingresar la información correspondiente a la configuración.");
		} finally {
			logger.logDebug(MessageManager.getString("FIELDSBYPRODUCTMANAGER.002", "insertListFieldByProduct"));
		}
	}

	public void insertFieldByProduct(FieldByProduct fieldByproduct) {
		try {
			logger.logDebug(MessageManager.getString("FIELDSBYPRODUCTMANAGER.001", "insertFieldByProduct"));
			// Inserto los valores enviados
			em.persist(fieldByproduct);
			em.flush();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"FIELDSBYPRODUCTMANAGER.003", fieldByproduct.toString()),
					ex);
			//TODO REVISAR EL NUMERO DEL ERROR
			throw new BusinessException(6900032, "No se pudo ingresar  la información.");
		} finally {
			logger.logDebug(MessageManager.getString("FIELDSBYPRODUCTMANAGER.002", "insertFieldByProduct"));
		}
	}

	@Override
	public void deleteFieldByProduct(String bankingProductId) {
		try {
			logger.logDebug(MessageManager.getString(
					"FIELDSBYPRODUCTMANAGER.001", "deleteFieldByProduct"));
			List<FieldByProduct> fieldByproduct = getAllSectionFieldsByProduct(bankingProductId);
			if (fieldByproduct != null && fieldByproduct.size() > 0) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("fieldByproduct in deleteFieldByProduct --->"
							+ fieldByproduct.size());
				}
				for (FieldByProduct field : fieldByproduct) {
					em.remove(field);
				}
				em.flush();

			}
		} catch (PersistenceException pe) {
			logger.logError(MessageManager.getString(
					"FIELDSBYPRODUCTMANAGER.005", bankingProductId), pe);
			throw new BusinessException(
					6900034,
					"No se pudo eliminar los campos por producto porque tiene información relacionada.");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"FIELDSBYPRODUCTMANAGER.005", bankingProductId), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString(
					"FIELDSBYPRODUCTMANAGER.002", "deleteFieldByProduct"));
		}

	}

	@Override
	public FieldByProduct getFieldByProductById(
			FieldByProductId fieldByProductId) {
		try {
			logger.logDebug(MessageManager.getString(
					"FIELDSBYPRODUCTMANAGER.001", "getFieldByProductById"));
			FieldByProduct fieldByProduct = em.find(FieldByProduct.class,
					fieldByProductId);
			if (null == fieldByProduct) {
				throw new BusinessException(6900005,
						"No existe el campo asociado al producto con el id requerido");
			}
			return fieldByProduct;
		} catch (BusinessException be) {
			logger.logError(MessageManager.getString("FIELDSBYPRODUCTMANAGER.008", fieldByProductId == null ? null : fieldByProductId.toString()), be);
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("FIELDSBYPRODUCTMANAGER.008", fieldByProductId == null ? null : fieldByProductId.toString()), ex);
			throw new BusinessException(6900030, "No se pudo realizar la búsqueda del tipo de producto requerido");
		} finally {
			logger.logDebug(MessageManager.getString("FIELDSBYPRODUCTMANAGER.002", "getFieldByProductById"));
		}
	}

	@Override
	public List<DictionaryField> getAllSectionFieldsByProductAndGrp(String bankingProductId, Long funtionalityGroup) {
		try {
			logger.logDebug(MessageManager.getString(
					"FIELDSBYPRODUCTMANAGER.001",
					"getAllSectionFieldsByProduct"));

			List<DictionaryField> dictioFieldByProduct = new ArrayList<DictionaryField>();

			List<FieldByProduct> fieldByProduct = em
					.createNamedQuery("FieldByProduct.findByProductAndGrp",
							FieldByProduct.class)
					.setParameter("product", bankingProductId)
					.setParameter("funGroup", funtionalityGroup)
					.getResultList();

			for (FieldByProduct fieldByProduct2 : fieldByProduct) {
				dictioFieldByProduct.add(fieldByProduct2.getDictionaryField());
			}

			if (logger.isDebugEnabled()) {
				logger.logDebug("findByProductAndGrp in getAllSectionFieldsByProduct -->"
						+ dictioFieldByProduct.size());
			}

			return dictioFieldByProduct;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("FIELDSBYPRODUCTMANAGER.006"), ex);
			throw new BusinessException(
					6900010,
					"No se pudo realizar la búsqueda de los campos por producto y grupo funcional requerido "
							+ funtionalityGroup);
		}
	}

	// region Properties
	/**
	 * Inject the EntityManager by the container
	 * 
	 * @param em
	 */
	@PersistenceContext
	public void setEntityManager(EntityManager em) {
		this.em = em;
	}

}
