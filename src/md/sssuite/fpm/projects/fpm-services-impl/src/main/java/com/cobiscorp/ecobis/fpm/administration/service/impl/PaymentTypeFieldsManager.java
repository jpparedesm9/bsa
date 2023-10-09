package com.cobiscorp.ecobis.fpm.administration.service.impl;

import java.util.List;

import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.administration.service.IPaymentTypeFieldsManager;
import com.cobiscorp.ecobis.fpm.model.DicFunctionalityGroup;
import com.cobiscorp.ecobis.fpm.model.PaymentType;
import com.cobiscorp.ecobis.fpm.model.DicCompanyProductType;
import com.cobiscorp.ecobis.fpm.model.PaymentTypeFields;
import com.cobiscorp.ecobis.fpm.model.PaymentTypeFieldsValues;
import com.cobiscorp.ecobis.fpm.model.ServiceTransaction;
import com.cobiscorp.ecobis.fpm.model.TransactionField;
import com.cobiscorp.ecobis.fpm.model.TransactionFieldValue;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

public class PaymentTypeFieldsManager implements IPaymentTypeFieldsManager {
	// region Fields
	/** COBIS Logger */
	private static final ILogger logger = LogFactory
			.getLogger(PaymentTypeFieldsManager.class);

	/** Entity manager injected by the container */
	private EntityManager em;

	/***********************************************************
	 * /** Initialize the Entity Manager
	 * 
	 * @param em
	 *            Entity Manager
	 */
	@PersistenceContext(unitName = "JpaFpmAdministration")
	public void setEntityManager(EntityManager em) {
		this.em = em;
	}

	
	public List<PaymentTypeFields> getPaymentTypeFieldsAll() {
		try {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.001", "getPaymentTypeFieldsAll"));

			Query q = em.createNamedQuery("PaymentTypeFields.findAll",
					PaymentTypeFields.class);
			return q.getResultList();
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("PAYMENTTYPEFIELDSMANAGER.012"),
					ex);
			throw new BusinessException(
					6900239,
					"No se pudo obtener el listado de los campos de las formas de pago y cobro existentes");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.002", "getPaymentTypeFieldsAll"));
		}

	}

	
	public List<PaymentTypeFields> getPaymentTypeFieldsByProductType(
			DicCompanyProductType dicCompanyProductType) {
		try {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.001",
					"getPaymentTypeFieldsByProductType"));

			Query q = em.createNamedQuery(
					"PaymentTypeFields.findByProductType",
					PaymentTypeFields.class);
			q.setParameter("companyId", dicCompanyProductType.getCompanyId());
			q.setParameter("nodeTypeCategoryId",
					dicCompanyProductType.getNodeTypeCategoryId());
			q.setParameter("type", dicCompanyProductType.getType());
			q.setParameter("name", dicCompanyProductType.getName());
			return q.getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.011",
					dicCompanyProductType.getCompanyId()), ex);
			throw new BusinessException(6900240,
					"No se pudo obtener el listado de las formas de pago y cobro por compania");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.002",
					"getPaymentTypeFieldsByProductType"));
		}
	}

	
	public PaymentTypeFields getPaymentTypeFieldsById(Long id) {
		try {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.001", "getPaymentTypeFieldsById"));

			TypedQuery<PaymentTypeFields> tq = em.createNamedQuery(
					"PaymentTypeFields.findById", PaymentTypeFields.class);
			tq.setParameter("id", id);
			return tq.getSingleResult();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.010", id), ex);
			throw new BusinessException(6900241,
					"No se pudo obtener el campo de forma de pago o cobro por id");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.002", "getPaymentTypeFieldsById"));
		}
	}

	
	public long insertPaymentTypeFields(PaymentTypeFields field) {
		try {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.001", "insertPaymentTypeFields"));
			em.persist(field);
			em.flush();
			return field.getFieldId();
		} catch (EntityExistsException eee) {
			logger.logError(
					MessageManager.getString("PAYMENTTYPEFIELDSMANAGER.008"),
					eee);
			throw new BusinessException(
					6900242,
					"El item de formas de pago y cobro seleccionado no se pudo crear, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.003",
					new Long(field.getFieldId())), ex);
			throw new BusinessException(6900243,
					"No se pudo crear el campo de forma de pago o cobro requerido");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.002", "insertPaymentTypeFields"));
		}
	}

	
	public void updatePaymentTypeFields(PaymentTypeFields field) {
		try {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.001", "updatePaymentTypeFields"));

			PaymentTypeFields f = getPaymentTypeFieldsById(field.getFieldId());
			// Only description can be updated
			f.setDescription(field.getDescription());
			f.setEnabled(field.getEnabled());
			f.setName(field.getName());
			f.setRequired(field.getRequired());
			f.setValueType(field.getValueType());
			f.setModifyinherited(field.getModifyinherited());
			em.flush();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.004", field.getFieldId()), ex);
			throw new BusinessException(6900244,
					"No se pudo actualizar el item de la forma de pago o cobro seleccionada");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.002", "updatePaymentTypeFields"));
		}
	}

	
	public void deletePaymentTypeFields(Long id) {
		try {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.001", "deletePaymentTypeFields"));
			PaymentTypeFields f = getPaymentTypeFieldsById(id);
			if (null != f) {
				em.remove(f);
				em.flush();
			}
		} catch (BusinessException exception) {
			logger.logError(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.005", id), exception);
			throw exception;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.005", id), ex);
			throw new BusinessException(6900245,
					"Existió un fallo al eliminar el ítem de forma de pago o cobro. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.002", "deletePaymentTypeFields"));
		}
	}

	
	public List<PaymentType> getAllPaymentType() {
		try {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.001", "getAllPaymentType"));
			/**
			 * TypedQuery<PaymentType> cp = em.createNamedQuery(
			 * "PaymentType.findAll", PaymentType.class); List<PaymentType>
			 * collectionPayment = null; if (cp != null) collectionPayment =
			 * cp.getResultList(); return collectionPayment;
			 */
			List<PaymentType> ptList = em.createNamedQuery(
					"PaymentType.findAll", PaymentType.class).getResultList();
			for (PaymentType paymentType : ptList) {

				paymentType.getPaymentTypeFieldsValues().size();

			}
			return ptList;

		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("PAYMENTTYPEFIELDSMANAGER.012"),
					ex);
			throw new BusinessException(6900246,
					"No se pudo obtener el listado de todas las formas de pago y cobro");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.002", "getAllPaymentType"));
		}

	}

	
	public PaymentType getPaymentTypeById(String mnemonicPaymentType) {
		try {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.001", "getPaymentTypeById"));
			/**
			 
			PaymentType pt = em
					.createNamedQuery("PaymentType.findById", PaymentType.class)
					.setParameter("collectionTypeMnemonic", mnemonicPaymentType);*/
			TypedQuery<PaymentType> pt = em.createNamedQuery(
					"PaymentType.findById", PaymentType.class)
					.setParameter("collectionTypeMnemonic",mnemonicPaymentType);		
			PaymentType paymentType = null;
			if (pt != null) {
				paymentType = pt.getSingleResult();
				paymentType.getPaymentTypeFieldsValues().size();
			}

			return paymentType;
		} catch (Exception ex) {
			MessageManager.getString("PAYMENTTYPEFIELDSMANAGER.012", ex);
			throw new BusinessException(6900247,
					"No se pudo obtener el listado de las formas de pago y cobro por mnemonic");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.002", "getPaymentTypeById"));
		}
	}

	
	public int insertPaymentType(PaymentType paymentType) {
		try {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.001", "insertPaymentType"));
			em.persist(paymentType);
			em.flush();
			return 1;
		} catch (EntityExistsException eee) {
			logger.logError(
					MessageManager.getString("PAYMENTTYPEFIELDSMANAGER.008"),
					eee);
			throw new BusinessException(
					6900248,
					"La forma de pago y cobro seleccionada no se pudo crear, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.003", ex));
			throw new BusinessException(6900249,
					"No se pudo crear la forma de pago y cobro requerido");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.002", "insertPaymentType"));
		}
	}

	
	public int updatePaymentType(PaymentType paymentType) {
		try {
			// log method entry
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.001", "updatePaymentType"));
			// Use the merge method of the entity manager to update the changes
			em.merge(paymentType);
			// Always flush the transaction to capture the exceptions in this
			// method
			em.flush();
			return 1;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.007", paymentType), ex);
			throw new BusinessException(6900250,
					"No se pudo actualizar la forma de pago o cobro indicada");
		} finally {
			// log method exit
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.002", "updatePaymentType"));
		}
	}

	
	public int deletePaymentType(String mnemonicPaymentType) {
		try {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.001", "deleteAllPaymentType"));
			PaymentType cp = em.find(PaymentType.class, mnemonicPaymentType);
			if (null != cp) {
				em.remove(cp);
				em.flush();
			}
			return 1;
		} catch (BusinessException exception) {
			logger.logError(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.005", mnemonicPaymentType),
					exception);
			throw exception;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.005", mnemonicPaymentType), ex);
			throw new BusinessException(6900251,
					"No se pudo eliminar la forma de pago o cobro indicada.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.002", "deleteAllPaymentType"));
		}
	}

	
	public int insertPaymentTypeFieldsvalue(
			PaymentTypeFieldsValues paymentFieldsValues) {

		try {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.001",
					"insertPaymentTypeFieldsvalue"));
			em.persist(paymentFieldsValues);
			em.flush();
			return 1;
		} catch (EntityExistsException eee) {
			logger.logError(
					MessageManager.getString("PAYMENTTYPEFIELDSMANAGER.008"),
					eee);
			throw new BusinessException(
					6900252,
					"El valor para el ítem de formas de pago y cobro seleccionado no se pudo crear, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.003", ex));
			throw new BusinessException(6900253,
					"No se pudo crear el valor del ítem de forma de pago o cobro requerido");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.002",
					"insertPaymentTypeFieldsvalue"));
		}
	}

	
	public int updatePaymentTypeFieldsvalue(
			PaymentTypeFieldsValues paymentFieldsValues) {
		try {
			// log method entry
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.001",
					"updatePaymentTypeFieldsvalue"));
			// Use the merge method of the entity manager to update the changes
			em.merge(paymentFieldsValues);
			// Always flush the transaction to capture the exceptions in this
			// method
			em.flush();
			return 1;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.007", paymentFieldsValues), ex);
			throw new BusinessException(6900254,
					"No se pudo actualizar el valor del ítem de pago o cobro indicado");
		} finally {
			// log method exit
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.002",
					"updatePaymentTypeFieldsvalue"));
		}
	}

	
	public int deletePaymentTypeFieldsvalue(
			List<PaymentTypeFieldsValues> paymentFielValues) {
		try {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.001",
					"deletePaymentTypeFieldsvalue"));
			PaymentType cp = em.find(PaymentType.class, paymentFielValues);
			if (null != cp) {
				em.remove(cp);
				em.flush();
			}
			return 1;
		} catch (BusinessException exception) {
			logger.logError(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.005", paymentFielValues),
					exception);
			throw exception;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.005", paymentFielValues), ex);
			throw new BusinessException(6900255,
					"No se pudo eliminar el valor del ítem pago o cobro indicado.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.002",
					"deletePaymentTypeFieldsvalue"));
		}
	}

	
	public List<PaymentTypeFieldsValues> getPaymentTypeFieldsValuesByMnemonic(
			String paymentTypeMnemonic) {

		try {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.001",
					"getPaymentTypeFieldsValuesByMnemonic"));

			Query q = em.createNamedQuery(
					"PaymentTypeFieldsValues.findByPaymentType",
					PaymentTypeFieldsValues.class);
			q.setParameter("mnemonic", paymentTypeMnemonic);

			return q.getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.011", paymentTypeMnemonic), ex);
			throw new BusinessException(6900256,
					"No se pudo obtener el listado de los valores de una forma de pago o cobro por nemónico.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.002",
					"getPaymentTypeFieldsValuesByMnemonic"));
		}

	}

	
	public List<PaymentTypeFieldsValues> getPaymentTypeFieldsValuesByFieldId(
			Long fieldId) {
		try {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.001",
					"getPaymentTypeFieldsValuesByFieldId"));

			Query q = em.createNamedQuery(
					"PaymentTypeFieldsValues.findByPaymentTypeField",
					PaymentTypeFieldsValues.class);
			q.setParameter("id", fieldId);

			return q.getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.011", fieldId), ex);
			throw new BusinessException(6900257,
					"No se pudo obtener el listado valores de un ítem de forma de pago o cobro por ítem id.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PAYMENTTYPEFIELDSMANAGER.002",
					"getPaymentTypeFieldsValuesByFieldId"));
		}
	}
	
	
	public void deletePaymentFieldValueByPayment(
			String mnemonicPayment) {
		try {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.001",
					"deletePaymentFieldValueByPayment"));
			List<PaymentTypeFieldsValues> paymentFieldValues = getPaymentTypeFieldsValuesByMnemonic(mnemonicPayment);
			if (paymentFieldValues != null) {
				for (PaymentTypeFieldsValues paymentTypeFieldsValues : paymentFieldValues) {
					em.remove(paymentTypeFieldsValues);
				}

			}

		} catch (BusinessException exception) {
			logger.logError(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.005",
					mnemonicPayment), exception);
			throw exception;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.005",
					mnemonicPayment), ex);
			throw new BusinessException(6900258,
					"Existió un fallo en al eliminar el valor de un ítem de forma de pago o cobro. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.002",
					"deletePaymentFieldValueByPayment"));
		}

	}

	
	public List<PaymentTypeFields> getPaymentTypeFieldsByGroupId(
			DicFunctionalityGroup group) {
	try {
		logger.logDebug(MessageManager.getString(
				"PAYMENTTYPEFIELDSMANAGER.001",
				"getPaymentTypeFieldsByGroupId"));

		Query q = em.createNamedQuery(
				"PaymentTypeFields.findByFunctionalityGroup",
				PaymentTypeFields.class);
		q.setParameter("groupId", group.getId());
		return q.getResultList();
	} catch (Exception ex) {
		logger.logError(MessageManager.getString(
				"PAYMENTTYPEFIELDSMANAGER.011",
				group.getId()), ex);
		throw new BusinessException(6900259,
				"No se pudo obtener el listado de las formas de pago y cobro por grupo");
	} finally {
		logger.logDebug(MessageManager.getString(
				"PAYMENTTYPEFIELDSMANAGER.002",
				"getPaymentTypeFieldsByGroupId"));
	}

	}

}
