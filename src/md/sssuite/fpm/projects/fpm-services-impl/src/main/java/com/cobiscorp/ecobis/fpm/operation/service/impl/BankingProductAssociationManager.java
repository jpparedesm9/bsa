package com.cobiscorp.ecobis.fpm.operation.service.impl;

import java.util.List;

import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.model.ServTranBankingProduct;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductAssociationManager;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

public class BankingProductAssociationManager implements
		IBankingProductAssociationManager {

	/** CTS logger */

	private static final ILogger logger = LogFactory
			.getLogger(BankingProductAssociationManager.class);
	/** Entity Manger */
	private EntityManager em;

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

	
	public List<ServTranBankingProduct> getTransactionsByBankingProduct(
			String product) {
		try {

			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTASSOCIATIONMANAGER.001",
					"getTransactionsByBankingProduct"));
			List<ServTranBankingProduct> dpt = em
					.createNamedQuery(
							"ServTranBankingProduct.findByBankinProduct",
							ServTranBankingProduct.class)
					.setParameter("tranBankingProductId", product)
					.getResultList();
			return dpt;
		} catch (NoResultException nre) {
			return null;
		} catch (Exception ex) {
			logger.logError(MessageManager
					.getString("BANKINGPRODUCTASSOCIATIONMANAGER.007"), ex);
			throw new BusinessException(
					6900264,
					"No se pudo obtener la información relacionada a las transacciones asociadas al producto bancario indicado");
		} finally {
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTASSOCIATIONMANAGER.002",
					"getTransactionsByBankingProduct"));
		}
	}

	
	public int insertServTranBankingProduct(
			ServTranBankingProduct tranBankingProduct) {
		try {
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTASSOCIATIONMANAGER.001",
					"insertServTranBankingProduct"));
			em.persist(tranBankingProduct);
			em.flush();
			return 1;
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager
					.getString("BANKINGPRODUCTASSOCIATIONMANAGER.008"), eee);
			throw new BusinessException(
					6900265,
					"La asociación del producto y transacción no se pudo crear, puesto que ya existe Id:"
							+ tranBankingProduct.getSbp_id());
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString(
							"BANKINGPRODUCTASSOCIATIONMANAGER.003",
							tranBankingProduct), ex);
			throw new BusinessException(6900266,
					"No se pudo crear la asociación entre el producto y transacción solicitado");
		} finally {
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTASSOCIATIONMANAGER.002",
					"insertServTranBankingProduct"));
		}
	}

	
	public void deleteServTranBankingProduct(
			ServTranBankingProduct tranBankingProduct) {
		try {
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTASSOCIATIONMANAGER.001",
					"deleteTransactionField"));
			ServTranBankingProduct f = em.find(ServTranBankingProduct.class,
					tranBankingProduct.getSbp_id());
			if (null != f) {
				em.remove(f);
				em.flush();
			}
		} catch (BusinessException exception) {
			logger.logError(
					MessageManager.getString(
							"BANKINGPRODUCTASSOCIATIONMANAGER.005",
							tranBankingProduct), exception);
			throw exception;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString(
							"BANKINGPRODUCTASSOCIATIONMANAGER.005",
							tranBankingProduct), ex);
			throw new BusinessException(
					6900267,
					"No se pudo eliminar la asociación entre el producto bancario y la transacción indicada "
							+ tranBankingProduct.getBankingProduct().getName());
		} finally {
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTASSOCIATIONMANAGER.002",
					"deleteServTranBankingProduct"));
		}

	}

	
	public void deleteServTranBankingProductById(Long tranBankingProductId) {
		try {
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTASSOCIATIONMANAGER.001",
					"deleteServTranBankingProductById"));
			ServTranBankingProduct f = em.find(ServTranBankingProduct.class,
					tranBankingProductId);
			if (null != f) {
				em.remove(f);
				em.flush();
			}
		} catch (BusinessException exception) {
			logger.logError(MessageManager.getString(
					"BANKINGPRODUCTASSOCIATIONMANAGER.005",
					tranBankingProductId), exception);
			throw exception;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"BANKINGPRODUCTASSOCIATIONMANAGER.005",
					tranBankingProductId), ex);
			throw new BusinessException(
					6900267,
					"No se pudo eliminar la asociación entre el producto bancario y la transacción indicada "
							+ tranBankingProductId);
		} finally {
			logger.logDebug(MessageManager.getString(
					"BANKINGPRODUCTASSOCIATIONMANAGER.002",
					"deleteServTranBankingProductById"));
		}

	}

}
