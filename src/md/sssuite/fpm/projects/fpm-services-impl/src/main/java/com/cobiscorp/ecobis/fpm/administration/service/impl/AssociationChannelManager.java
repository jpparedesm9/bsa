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
import com.cobiscorp.ecobis.fpm.administration.service.IAssociationChannelManager;
import com.cobiscorp.ecobis.fpm.model.ChannelPaymentBase;
import com.cobiscorp.ecobis.fpm.model.TransactionChannelBase;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

public class AssociationChannelManager implements IAssociationChannelManager {

	/** CTS logger */
	private static final ILogger logger = LogFactory.getLogger(ServiceTransactionManager.class);
	/** Entity Manger */
	private EntityManager em;

	@PersistenceContext
	public void setEntityManager(EntityManager em) {
		this.em = em;
	}

	
	public Long insertChannelPaymentBase(ChannelPaymentBase channelPaymentBase) {
		try {
			logger.logDebug(MessageManager.getString("SERVICETRANSACTIONMANAGER.001", "insertChannelPaymentBase"));
			
			//Validar que la Forma de Pago/Cobro aun no este asociada al Canal
			TypedQuery<ChannelPaymentBase> st = em.createNamedQuery("ChannelPaymentBase.findByAll", ChannelPaymentBase.class)
								                  .setParameter("transactionChannelBaseId", channelPaymentBase.getTransactionChannelBase().getId())
								                  .setParameter("mnemonic", channelPaymentBase.getPaymentType().getMnemonic());
			if ((st != null) && (st.getResultList().size() > 0))
			{
			throw new BusinessException(6900269, "No se pudo asociar la Forma de Pago y Cobro seleccionada, puesto que ya existe.");
			}
			//realiza el insert si todo esta OK
			em.persist(channelPaymentBase);
			em.flush();
			return channelPaymentBase.getId();
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString("SERVICETRANSACTIONMANAGER.008"), eee);
			throw new BusinessException(6900214, "El servicio/transacción seleccionado no se pudo crear, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SERVICETRANSACTIONMANAGER.003", channelPaymentBase), ex);
			if(ex instanceof BusinessException &&(((BusinessException)ex).getClientErrorCode() == 6900269) )
				throw (BusinessException)ex;
			throw new BusinessException(6900215, "No se pudo crear el servicio/transacción requerido");
		} finally {
			logger.logDebug(MessageManager.getString("SERVICETRANSACTIONMANAGER.002", "insertChannelPaymentBase"));
		}

	}

	
	public Boolean deleteChannelPaymentBase(Long channelPaymentBaseId) {
		try {
			logger.logDebug(MessageManager.getString("SERVICETRANSACTIONMANAGER.001", "deleteChannelPaymentBase"));
			ChannelPaymentBase toDelete = em.find(ChannelPaymentBase.class, channelPaymentBaseId);
			if (null != toDelete) {
				em.remove(toDelete);
				em.flush();
				return true;
			}
		} catch (BusinessException exception) {
			logger.logError(MessageManager.getString("SERVICETRANSACTIONMANAGER.005", channelPaymentBaseId), exception);
			throw exception;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SERVICETRANSACTIONMANAGER.005", channelPaymentBaseId), ex);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString("SERVICETRANSACTIONMANAGER.002", "deleteChannelPaymentBase"));
		}
		return false;
	}

	
	public List<ChannelPaymentBase> getByTransactionChannelBaseId(Long transactionChannelBaseId) {
		try {
			logger.logDebug(MessageManager.getString("SERVICETRANSACTIONMANAGER.001", "getTransactionChannelBaseByTransactionChannelBaseId"));
			TypedQuery<ChannelPaymentBase> st = em.createNamedQuery("ChannelPaymentBase.findByTransactionChannelBaseId", ChannelPaymentBase.class)
					                              .setParameter("transactionChannelBaseId", transactionChannelBaseId);
			if (st != null)
				return st.getResultList();
			return null;
		} catch (NoResultException nre) {
			return null;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("SERVICETRANSACTIONMANAGER.009"), ex);
			throw new BusinessException(6900216, "No se pudo realizar la búsqueda del servicio o transacción requerido");
		} finally {
			logger.logDebug(MessageManager.getString("SERVICETRANSACTIONMANAGER.002", "getTransactionChannelBaseByTransactionChannelBaseId"));
		}
	}

}
