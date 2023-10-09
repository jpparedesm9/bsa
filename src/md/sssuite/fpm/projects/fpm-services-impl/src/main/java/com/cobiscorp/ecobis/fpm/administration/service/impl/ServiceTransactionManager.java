package com.cobiscorp.ecobis.fpm.administration.service.impl;

import java.util.List;

import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.administration.service.IServiceTransactionManager;
import com.cobiscorp.ecobis.fpm.model.ServiceTransaction;
import com.cobiscorp.ecobis.fpm.model.ServiceTransactionId;
import com.cobiscorp.ecobis.fpm.model.TransactionField;
import com.cobiscorp.ecobis.fpm.model.TransactionFieldValue;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

public class ServiceTransactionManager implements IServiceTransactionManager {

	/** CTS logger */

	private static final ILogger logger = LogFactory
			.getLogger(ServiceTransactionManager.class);
	/** Entity Manger */
	private EntityManager em;

	
	public List<ServiceTransaction> getInformationServiceTransactionByProductCategory(
			Long categoryId) {
		try {

			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.001",
					"getInformationServiceTransactionByProductCategory"));
			List<ServiceTransaction> dpt = em
					.createNamedQuery("ServiceTransaction.findByCategory",
							ServiceTransaction.class)
					.setParameter("productCategoryId", categoryId)
					.getResultList();
			for (ServiceTransaction serviceTransaction : dpt) {
				serviceTransaction.getTransactionFieldValues().size();
			}

			return dpt;
		} catch (NoResultException nre) {
			return null;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("SERVICETRANSACTIONMANAGER.007"),
					ex);
			throw new BusinessException(
					6900213,
					"No se pudo obtener la información relacionada a la transacción con la categoría requerida");
		} finally {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.002",
					"getInformationServiceTransactionByProductCategory"));
		}
	}

	
	public void insertServiceTransaction(
			ServiceTransaction nodeServiceTransaction) {
		try {
			logger.logDebug(MessageManager
					.getString("SERVICETRANSACTIONMANAGER.001",
							"insertServiceTransaction"));
			logger.logDebug(MessageManager.getString(
					"insertServiceTransaction",
					nodeServiceTransaction.toString()));
			em.persist(nodeServiceTransaction);
			em.flush();
		} catch (EntityExistsException eee) {
			logger.logError(
					MessageManager.getString("SERVICETRANSACTIONMANAGER.008"),
					eee);
			throw new BusinessException(6900214,
					"El servicio/transacción seleccionado no se pudo crear, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.003", nodeServiceTransaction),
					ex);
			throw new BusinessException(6900215,
					"No se pudo crear el servicio/transacción requerido");
		} finally {
			logger.logDebug(MessageManager
					.getString("SERVICETRANSACTIONMANAGER.002",
							"insertServiceTransaction"));
		}
	}

	
	public ServiceTransaction getInformationServiceTransactionById(
			String transactionId) {
		try {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.001",
					"getInformationServiceTransactionById"));

			TypedQuery<ServiceTransaction> st = em.createNamedQuery(
					"ServiceTransaction.findById", ServiceTransaction.class)
					.setParameter("serviceTranId", transactionId);
			ServiceTransaction serviceTran = null;
			if (st != null) {
				serviceTran = st.getSingleResult();
				serviceTran.getTransactionFieldValues().size();
			}
			return serviceTran;
		} catch (NonUniqueResultException nur) {
			logger.logError(
					MessageManager.getString("SERVICETRANSACTIONMANAGER.006"),
					nur);
			throw new BusinessException(6900217,
					"No se pudo realizar la búsqueda del servicio o transacción requerido por varios resultados");
		} catch (NoResultException nre) {
			return null;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("SERVICETRANSACTIONMANAGER.009"),
					ex);
			throw new BusinessException(6900216,
					"No se pudo realizar la búsqueda del servicio o transacción requerido");
		} finally {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.002",
					"getInformationServiceTransactionById"));
		}
	}

	/***********************************************************
	 * /** Initialize the Entity Manager
	 * 
	 * @param em
	 *            Entity Manager
	 */
	@PersistenceContext
	public void setEntityManager(EntityManager em) {
		this.em = em;
	}

	
	public List<TransactionField> getAllTransactionFields() {
		try {

			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.001", "getAllTransactionFields"));
			List<TransactionField> tf = em.createNamedQuery(
					"TransactionField.findAll", TransactionField.class)
					.getResultList();

			return tf;
		} catch (NoResultException nre) {
			return null;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("SERVICETRANSACTIONMANAGER.007"),
					ex);
			throw new BusinessException(6900218,
					"No se pudo obtener la información relacionada al campo de la transacción");
		} finally {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.002", "getAllTransactionFields"));
		}
	}

	
	public TransactionField getTransactionFieldById(Long transactionFieldId) {
		try {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.001", "getTransactionFieldById"));

			TypedQuery<TransactionField> tf = em.createNamedQuery(
					"TransactionField.findById", TransactionField.class)
					.setParameter("transactionFieldId", transactionFieldId);
			TransactionField serviceTran = null;
			if (tf != null)
				serviceTran = tf.getSingleResult();
			return serviceTran;
		} catch (NonUniqueResultException nur) {
			logger.logError(
					MessageManager.getString("SERVICETRANSACTIONMANAGER.006"),
					nur);
			throw new BusinessException(6900219,
					"No se pudo realizar la búsqueda del campo de transacción requerido, por varios resultados");
		} catch (NoResultException nre) {
			return null;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("SERVICETRANSACTIONMANAGER.009"),
					ex);
			throw new BusinessException(6900220,
					"No se pudo realizar la búsqueda del campo de transacción requerido");
		} finally {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.002", "getTransactionFieldById"));
		}
	}

	
	public List<TransactionField> getTransactionFieldByGroup(Long groupId) {
		try {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.001",
					"getTransactionFieldByGroup"));

			TypedQuery<TransactionField> tf = em.createNamedQuery(
					"TransactionField.findByGroup", TransactionField.class)
					.setParameter("groupId", groupId);
			List<TransactionField> serviceTran = null;
			if (tf != null)
				serviceTran = tf.getResultList();
			return serviceTran;
		} catch (NonUniqueResultException nur) {
			logger.logError(
					MessageManager.getString("SERVICETRANSACTIONMANAGER.006"),
					nur);
			throw new BusinessException(
					6900221,
					"No se pudo realizar la búsqueda del campo de transacción requerido por medio del grupo por varios resultados");
		} catch (NoResultException nre) {
			return null;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("SERVICETRANSACTIONMANAGER.009"),
					ex);
			throw new BusinessException(
					6900222,
					"No se pudo realizar la búsqueda del campo de transacción requerido por medio del grupo");
		} finally {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.002",
					"getTransactionFieldByGroup"));
		}
	}

	
	public List<TransactionField> getTransactionFieldByCategory(Long categoryId) {
		try {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.001",
					"getTransactionFieldByGroup"));

			TypedQuery<TransactionField> tf = em.createNamedQuery(
					"TransactionField.findByCategory", TransactionField.class)
					.setParameter("categoryId", categoryId);
			List<TransactionField> serviceTran = null;
			if (tf != null)
				serviceTran = tf.getResultList();
			return serviceTran;
		} catch (NonUniqueResultException nur) {
			logger.logError(
					MessageManager.getString("SERVICETRANSACTIONMANAGER.006"),
					nur);
			throw new BusinessException(
					6900223,
					"No se pudo realizar la búsqueda del campo de transacción requerido por medio de la categoria, por varios resultados");
		} catch (NoResultException nre) {
			return null;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("SERVICETRANSACTIONMANAGER.009"),
					ex);
			throw new BusinessException(
					6900224,
					"No se pudo realizar la búsqueda del campo de transacción requerido por medio de la categoria");
		} finally {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.002",
					"getTransactionFieldByGroup"));
		}
	}

	
	public List<TransactionFieldValue> getAllTransactionFieldValues() {
		try {

			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.001",
					"getAllTransactionFieldValues"));
			List<TransactionFieldValue> tfv = em.createNamedQuery(
					"TransactionFieldValue.findAll",
					TransactionFieldValue.class).getResultList();

			return tfv;
		} catch (NoResultException nre) {
			return null;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("SERVICETRANSACTIONMANAGER.007"),
					ex);
			throw new BusinessException(
					6900225,
					"No se pudo obtener la información relacionada al valor del campo de la transacción");
		} finally {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.002",
					"getAllTransactionFieldValues"));
		}
	}

	
	public TransactionFieldValue getTransactionFieldValueById(
			Long transactionFieldValueId) {
		try {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.001",
					"getTransactionFieldByGroup"));

			TypedQuery<TransactionFieldValue> tfv = em.createNamedQuery(
					"TransactionFieldValue.findById",
					TransactionFieldValue.class).setParameter(
					"transactionFieldValueId", transactionFieldValueId);
			TransactionFieldValue serviceTran = null;
			if (tfv != null)
				serviceTran = tfv.getSingleResult();
			return serviceTran;
		} catch (NonUniqueResultException nur) {
			logger.logError(
					MessageManager.getString("SERVICETRANSACTIONMANAGER.006"),
					nur);
			throw new BusinessException(
					6900226,
					"No se pudo realizar la búsqueda del valor para el campo de transacción requerido a traves del id, por varios resultados");
		} catch (NoResultException nre) {
			return null;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("SERVICETRANSACTIONMANAGER.009"),
					ex);
			throw new BusinessException(
					6900227,
					"No se pudo realizar la búsqueda del valor para el campo de transacción requerido a traves del id");
		} finally {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.002",
					"getTransactionFieldByGroup"));
		}
	}

	
	public List<TransactionFieldValue> getTransactionFieldValueByTransactionId(
			String transactionFieldValueId) {
		try {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.001",
					"getTransactionFieldValueByTransactionId"));

			TypedQuery<TransactionFieldValue> tfv = em.createNamedQuery(
					"TransactionFieldValue.findByTransactionId",
					TransactionFieldValue.class).setParameter(
					"transactionFieldValueId", transactionFieldValueId);
			List<TransactionFieldValue> servTransactioFields = null;
			if (tfv != null)
				servTransactioFields = tfv.getResultList();
			return servTransactioFields;
		} catch (NonUniqueResultException nur) {
			logger.logError(
					MessageManager.getString("SERVICETRANSACTIONMANAGER.006"),
					nur);
			throw new BusinessException(6900228,
					"No se pudo realizar la búsqueda del valor para la transacción requerida por varios resultados");
		} catch (NoResultException nre) {
			return null;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("SERVICETRANSACTIONMANAGER.009"),
					ex);
			throw new BusinessException(6900229,
					"No se pudo realizar la búsqueda del valor para la transacción requerida");
		} finally {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.002",
					"getTransactionFieldValueByTransactionId"));
		}
	}

	
	public Long insertTransactionField(TransactionField transactionField) {
		try {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.001", "insertTransactionField"));
			em.persist(transactionField);
			em.flush();
			return transactionField.getId();
		} catch (EntityExistsException eee) {
			logger.logError(
					MessageManager.getString("SERVICETRANSACTIONMANAGER.008"),
					eee);
			throw new BusinessException(
					6900230,
					"El campo de transacción seleccionado no se pudo crear, puesto que ya existe Id:"
							+ transactionField.getId());
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.003", transactionField), ex);
			throw new BusinessException(6900231,
					"No se pudo crear el campo de transacción requerido");
		} finally {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.002", "insertTransactionField"));
		}
	}

	
	public void updateTransactionField(TransactionField transactionField) {
		try {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.001", "updateTransactionField"));

			TransactionField f = getTransactionFieldById(transactionField
					.getId());
			// Only description can be updated
			f.setDicFunctionalityGroup(transactionField
					.getDicFunctionalityGroup());
			f.setName(transactionField.getName());
			f.setDescription(transactionField.getDescription());
			f.setValueType(transactionField.getValueType());
			f.setEnabled(transactionField.getEnabled());
			f.setModifyInherited(transactionField.getModifyInherited());
			f.setRequired(transactionField.getRequired());
			em.flush();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.004", transactionField), ex);
			throw new BusinessException(6900232,
					"No se pudo actualizar el campo de transacción seleccionado");
		} finally {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.002", "updateTransactionField"));
		}
	}

	
	public void deleteTransactionField(Long transactionFieldId) {
		try {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.001", "deleteTransactionField"));
			TransactionField f = getTransactionFieldById(transactionFieldId);
			if (null != f) {
				em.remove(f);
				em.flush();
			}
		} catch (BusinessException exception) {
			logger.logError(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.005", transactionFieldId),
					exception);
			throw exception;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.005", transactionFieldId), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.002", "deleteTransactionField"));
		}
	}

	
	public Long insertTransactionFieldValue(
			TransactionFieldValue transactionFieldValue) {
		try {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.001",
					"insertTransactionFieldValue"));
			em.persist(transactionFieldValue);
			em.flush();
			return transactionFieldValue.getId();
		} catch (EntityExistsException eee) {
			logger.logError(
					MessageManager.getString("SERVICETRANSACTIONMANAGER.008"),
					eee);
			throw new BusinessException(
					6900237,
					"El valor del campo de transacción seleccionado no se pudo crear, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.003", transactionFieldValue), ex);
			throw new BusinessException(6900233,
					"No se pudo crear el valor del campo para la transacción requerida");
		} finally {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.002",
					"insertTransactionFieldValue"));
		}
	}

	
	public void updateTransactionFieldValue(
			TransactionFieldValue transactionFieldValue) {
		try {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.001",
					"updateTransactionFieldValue"));

			TransactionFieldValue f = getTransactionFieldValueById(transactionFieldValue
					.getId());
			// Only description can be updated
			f.setValueSourceId(transactionFieldValue.getValueSourceId());
			f.setDescription(transactionFieldValue.getDescription());
			f.setDefualtValue(transactionFieldValue.getDefualtValue());
			em.flush();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.004", transactionFieldValue), ex);
			throw new BusinessException(6900234,
					"No se pudo actualizar el valor del campo de transacción seleccionado");
		} finally {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.002",
					"updateTransactionFieldValue"));
		}

	}

	
	public void deleteTransactionFieldValue(Long transactionFieldValueId) {
		try {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.001",
					"deleteTransactionFieldValue"));
			TransactionField f = getTransactionFieldById(transactionFieldValueId);
			if (null != f) {
				em.remove(f);
				em.flush();
			}
		} catch (BusinessException exception) {
			logger.logError(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.005", transactionFieldValueId),
					exception);
			throw exception;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.005", transactionFieldValueId),
					ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.002",
					"deleteTransactionFieldValue"));
		}
	}

	
	public void deleteServiceTransaction(ServiceTransactionId transactionId) {
		ServiceTransaction serviceTransaction = null;
		try {
			// log method entry
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.001", "deleteCompany"));
			// Get a managed entity to remove
			serviceTransaction = em.find(ServiceTransaction.class,
					transactionId);
			// If one was found delete
			if (serviceTransaction != null) {
				em.remove(serviceTransaction);
			} else {// else throw a exception
				throw new BusinessException(6900235,
						"No existe el servicio o transaccion correspondiente al id seleccionado");
			}
			// Always flush the transaction to capture the exceptions in this
			// method
			em.flush();
		} catch (BusinessException exception) {
			logger.logError(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.006", serviceTransaction),
					exception);
			throw exception;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.006", serviceTransaction), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			// log method exit
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.002",
					"deleteServiceTransactionById"));
		}

	}

	
	public void updateServiceTransaction(ServiceTransaction transaction) {
		try {
			// log method entry
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.001",
					"updateServiceTransactionById"));
			// Use the merge method of the entity manager to update the changes
			em.merge(transaction);
			// Always flush the transaction to capture the exceptions in this
			// method
			em.flush();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.007", transaction), ex);
			throw new BusinessException(6900236,
					"No se pudo actualizar el servicio o transacción seleccionada");
		} finally {
			// log method exit
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.002",
					"updateServiceTransactionById"));
		}

	}

	
	public void deleteTransactionFieldValues(
			List<TransactionFieldValue> transactionFielValues) {
		try {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.001",
					"deleteTransactionFieldValues"));

			em.remove(transactionFielValues);
			em.flush();
		} catch (BusinessException exception) {
			logger.logError(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.005", transactionFielValues),
					exception);
			throw exception;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.005", transactionFielValues), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.002",
					"deleteTransactionFieldValues"));
		}

	}

	
	public void deleteTransactionFieldValueByTransaction(
			String mnemonictransaction) {
		try {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.001",
					"deleteTransactionFieldValueByTransaction"));
			List<TransactionFieldValue> transactionFieldValues = getTransactionFieldValueByTransactionId(mnemonictransaction);
			if (transactionFieldValues != null) {
				for (TransactionFieldValue transactionFieldValue : transactionFieldValues) {
					em.remove(transactionFieldValue);
				}			

			}else {// else throw a exception
				throw new BusinessException(6900238,
						"No existe el campo del valor de la transacción correspondiente al mnemonico seleccionado");
			}
		

		} catch (BusinessException exception) {
			logger.logError(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.005",
					mnemonictransaction), exception);
			throw exception;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.005",
					mnemonictransaction), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.002",
					"deleteTransactionFieldValueByTransaction"));
		}

	}
	
	
	public ServiceTransaction getInformationServiceTransactionByIdAndCategory(
			String transactionId, Long categoryId) {
		try {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.001",
					"getInformationServiceTransactionByIdAndCategory"));

			TypedQuery<ServiceTransaction> st = em.createNamedQuery(
					"ServiceTransaction.findByIdAndCategory", ServiceTransaction.class)
					.setParameter("serviceTranId", transactionId)
					.setParameter("productCategoryId", categoryId);
			ServiceTransaction serviceTran = null;
			if (st != null) {
				serviceTran = st.getSingleResult();
				serviceTran.getTransactionFieldValues().size();
			}
			return serviceTran;
		} catch (NonUniqueResultException nur) {
			logger.logError(
					MessageManager.getString("SERVICETRANSACTIONMANAGER.006"),
					nur);
			throw new BusinessException(6900217,
					"No se pudo realizar la búsqueda del servicio o transacción requerido por varios resultados");
		} catch (NoResultException nre) {
			return null;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("SERVICETRANSACTIONMANAGER.009"),
					ex);
			throw new BusinessException(6900216,
					"No se pudo realizar la búsqueda del servicio o transacción requerido");
		} finally {
			logger.logDebug(MessageManager.getString(
					"SERVICETRANSACTIONMANAGER.002",
					"getInformationServiceTransactionByIdAndCategory"));
		}
	}


}
