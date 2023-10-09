package com.cobiscorp.ecobis.fpm.operation.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.model.FieldByProductValues;
import com.cobiscorp.ecobis.fpm.operation.service.IFieldsByProductValuesManager;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

public class FieldsByProductValuesManager implements
		IFieldsByProductValuesManager {
	/** COBIS Logger */
	private static final ILogger logger = LogFactory
			.getLogger(FieldsByProductValuesManager.class);

	/** Entity Manager injected by the container */
	private EntityManager em;
	
	@Override
	public List<FieldByProductValues> getAllSectionFieldsByProductValues(
			String bankingProductId, String request, String registerId) {
		try {
			logger.logDebug(MessageManager.getString(
					"FIELDSBYPRODUCVALUESTMANAGER.001",
					"getAllSectionFieldsByProductValues"));

			List<FieldByProductValues> fieldByProduct = new ArrayList<FieldByProductValues>();


			if (logger.isDebugEnabled()) {
				logger.logDebug("product -->" + bankingProductId + " registerId --> " + registerId + " request --> " + request);
			}
			
			
			fieldByProduct = em
					.createNamedQuery(
							"FieldByProductValues.findByProductAndRequest",
							FieldByProductValues.class)
					.setParameter("product", bankingProductId)
					.setParameter("registerId",registerId)
					.setParameter("request", request).getResultList();
			
			if (logger.isDebugEnabled()) {
				logger.logDebug("fieldByProduct in getAllSectionFieldsByProductValues -->"
						+ fieldByProduct.size());
			}
			return fieldByProduct;
		} catch (Exception ex) {
			logger.logError(MessageManager
					.getString("FIELDSBYPRODUCVALUESTMANAGER.003"), ex);
			throw new BusinessException(6900010,
					"No se pudo realizar la búsqueda del diccionario requerido");
		}

	}

	@Override
	public void insertListFieldByProductValues(
			ArrayList<FieldByProductValues> fieldByproductValues,
			String bankingProductId, String request, HashMap<String, String> map) {
		try {
			logger.logDebug(MessageManager.getString(
					"FIELDSBYPRODUCVALUESTMANAGER.001",
					"insertListFieldByProductValues"));
			// Elimino si existe datos para el producto
			if(map.get("documentNumber")==null){
				deleteFieldByProductValues(bankingProductId, request,request);
			}else{
			deleteFieldByProductValues(bankingProductId, request,map.get("documentNumber"));
			}
			
			// Inserto los valores enviados
			if (fieldByproductValues != null && fieldByproductValues.size() > 0) {
				for (FieldByProductValues fieldByProduct : fieldByproductValues) {
					if (fieldByProduct.getValue() != null) {
						em.persist(fieldByProduct);
					}else{
						logger.logDebug("El valor es nulo por lo que no se inserta");
					}
				}
				em.flush();
			}
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString(
					"FIELDSBYPRODUCVALUESTMANAGER.009",
					fieldByproductValues.toString()), eee);
			throw new BusinessException(
					6900031,
					"No se pudo insertar los valores para los campos seleccionados, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"FIELDSBYPRODUCVALUESTMANAGER.003",
					fieldByproductValues.toString()), ex);
			throw new BusinessException(6900032,
					"No se pudo crear el Nodo de Producto seleccionado.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"FIELDSBYPRODUCVALUESTMANAGER.002",
					"insertListFieldByProductValues"));
		}
	}

	@Override
	public void deleteFieldByProductValues(String bankingProductId,
			String request) {
		try {
//			logger.logDebug(MessageManager.getString(
//					"FIELDSBYPRODUCVALUESTMANAGER.001", "deleteFieldByProductValues"));
//			List<FieldByProductValues> fieldByproductValue = getAllSectionFieldsByProductValues(
//					bankingProductId, request);
//			if (fieldByproductValue != null && fieldByproductValue.size() > 0) {
//				if (logger.isDebugEnabled()) {
//					logger.logDebug("fieldByproductValue in deleteFieldByProductValues --->"
//							+ fieldByproductValue.size());
//				}
//				for (FieldByProductValues fieldsByProduct : fieldByproductValue) {
//					em.remove(fieldsByProduct);
//				}
//				em.flush();
//
//			}
			
			deleteFieldByProductValues(bankingProductId, request, request);
			
		} catch (PersistenceException pe) {
			logger.logError(MessageManager.getString(
					"FIELDSBYPRODUCVALUESTMANAGER.005", bankingProductId), pe);
			throw new BusinessException(
					6900034,
					"No se pudo eliminar los campos por producto porque tiene información relacionada.");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"FIELDSBYPRODUCVALUESTMANAGER.005", bankingProductId), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString(
					"FIELDSBYPRODUCVALUESTMANAGER.002", "deleteFieldByProductValues"));
		}

	}
	
	
	public void deleteFieldByProductValues(String bankingProductId,
			String request,String registerId) {
		try {
			logger.logDebug(MessageManager.getString(
					"FIELDSBYPRODUCVALUESTMANAGER.001", "deleteFieldByProductValues"));
			List<FieldByProductValues> fieldByproductValue = getAllSectionFieldsByProductValues(
					bankingProductId, request, registerId);
			if (fieldByproductValue != null && fieldByproductValue.size() > 0) {
				if (logger.isDebugEnabled()) {
					logger.logDebug("fieldByproductValue in deleteFieldByProductValues --->"
							+ fieldByproductValue.size());
				}
				for (FieldByProductValues fieldsByProduct : fieldByproductValue) {
					em.remove(fieldsByProduct);
				}
				em.flush();
			}
		} catch (PersistenceException pe) {
			logger.logError(MessageManager.getString(
					"FIELDSBYPRODUCVALUESTMANAGER.005", bankingProductId), pe);
			throw new BusinessException(
					6900034,
					"No se pudo eliminar los campos por producto porque tiene información relacionada.");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"FIELDSBYPRODUCVALUESTMANAGER.005", bankingProductId), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString(
					"FIELDSBYPRODUCVALUESTMANAGER.002", "deleteFieldByProductValues"));
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
