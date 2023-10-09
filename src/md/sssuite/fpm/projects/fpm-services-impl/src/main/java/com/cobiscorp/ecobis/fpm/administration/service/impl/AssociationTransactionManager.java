package com.cobiscorp.ecobis.fpm.administration.service.impl;

import java.util.List;

import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.administration.service.IAssociationTransactionManager;
import com.cobiscorp.ecobis.fpm.model.TransactionChannelBase;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

public class AssociationTransactionManager implements IAssociationTransactionManager {

	/** CTS logger */
	private static final ILogger logger = LogFactory.getLogger(ServiceTransactionManager.class);
	/** Entity Manger */
	private EntityManager em;

	@PersistenceContext
	public void setEntityManager(EntityManager em) {
		this.em = em;
	}

	
	public Long insertTransactionChannelBase(TransactionChannelBase transactionChannelBase) throws BusinessException {
		try {
			logger.logDebug(MessageManager.getString("SERVICETRANSACTIONMANAGER.001", "insertTransactionChannelBase"));
			logger.logDebug(MessageManager.getString("insertServiceTransaction", transactionChannelBase.toString()));
			
			//Validar que el Canal aun no este asociado a la Transaccion
			TypedQuery<TransactionChannelBase> st = em.createNamedQuery("TransactionChannelBase.findByAll", TransactionChannelBase.class)
					                                  .setParameter("serviceTranId", transactionChannelBase.getServiceTransaction().getServicesTransactionsId().getServiceTranId())
					                                  .setParameter("categoryId", transactionChannelBase.getServiceTransaction().getServicesTransactionsId().getCategoryId())
							                          .setParameter("channel", transactionChannelBase.getChannel());
			if ((st != null) && (st.getResultList().size() > 0))
			{
				throw new BusinessException(6900268, "No se pudo asociar el canal seleccionado, puesto que ya existe.");
			}
			//realiza el insert si todo esta OK
			em.persist(transactionChannelBase);
			em.flush();
			return transactionChannelBase.getId();
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString("SERVICETRANSACTIONMANAGER.008"), eee);
			throw new BusinessException(6900214, "El servicio/transacción seleccionado no se pudo crear, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SERVICETRANSACTIONMANAGER.003", transactionChannelBase), ex);
			if(ex instanceof BusinessException &&(((BusinessException)ex).getClientErrorCode() == 6900268) )
			{
				throw (BusinessException)ex;
			}
			throw new BusinessException(6900215, "No se pudo crear el servicio/transacción requerido");
		} finally {
			logger.logDebug(MessageManager.getString("SERVICETRANSACTIONMANAGER.002", "insertTransactionChannelBase"));
		}

	}

	
	public Boolean deleteTransactionChannelBase(Long transactionChannelBaseId) {
		try {
			logger.logDebug(MessageManager.getString("SERVICETRANSACTIONMANAGER.001", "deleteTransactionChannelBase"));

			TransactionChannelBase toDelete = em.find(TransactionChannelBase.class, transactionChannelBaseId);
			if (null != toDelete) {
				em.remove(toDelete);
				em.flush();
				return true;
			}

		} catch (BusinessException exception) {
			logger.logError(MessageManager.getString("SERVICETRANSACTIONMANAGER.005", transactionChannelBaseId), exception);
			throw exception;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SERVICETRANSACTIONMANAGER.005", transactionChannelBaseId), ex);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString("SERVICETRANSACTIONMANAGER.002", "deleteTransactionChannelBase"));
		}
		return false;
	}

	
	public List<TransactionChannelBase> getTransactionChannelBaseByServicetransactionId(String serviceTransactionId, Long categoryId) {
		try {
			logger.logDebug(MessageManager.getString("SERVICETRANSACTIONMANAGER.001", "getInformationServiceTransactionById"));
			TypedQuery<TransactionChannelBase> st = em.createNamedQuery("TransactionChannelBase.findByServiceTransactionId", TransactionChannelBase.class)
					                                  .setParameter("serviceTranId", serviceTransactionId)
					                                  .setParameter("categoryId", categoryId);
			List<TransactionChannelBase> transactionChannelBaseList = null;
			if (st != null)
				transactionChannelBaseList = st.getResultList();
			return transactionChannelBaseList;
		} catch (NoResultException nre) {
			return null;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SERVICETRANSACTIONMANAGER.009"), ex);
			throw new BusinessException(6900216, "No se pudo realizar la búsqueda del servicio o transacción requerido");
		} finally {
			logger.logDebug(MessageManager.getString("SERVICETRANSACTIONMANAGER.002", "getInformationServiceTransactionById"));
		}
	}

}
