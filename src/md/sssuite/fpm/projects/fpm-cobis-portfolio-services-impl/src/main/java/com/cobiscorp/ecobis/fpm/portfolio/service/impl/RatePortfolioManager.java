package com.cobiscorp.ecobis.fpm.portfolio.service.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.portfolio.model.ReferencialValue;
import com.cobiscorp.ecobis.fpm.portfolio.model.ValueDetailPortfolio;
import com.cobiscorp.ecobis.fpm.portfolio.model.ValueDetailPortfolioId;
import com.cobiscorp.ecobis.fpm.portfolio.model.ValuePortfolio;
import com.cobiscorp.ecobis.fpm.portfolio.service.IRatePortfolio;
import com.cobiscorp.ecobis.fpm.portfolio.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.portfolio.utils.MessageManager;

public class RatePortfolioManager implements IRatePortfolio {

	// region Field

	/** Cobis Logger */
	private static final ILogger logger = LogFactory
			.getLogger(DefaultOperationManager.class);

	/** Entity Manager injected by the container */
	private EntityManager entityManager;

	// end-region

	// region Properties

	/**
	 * Initialize the Entity Manager.
	 * 
	 * @param entityManager
	 *            Entity Manager
	 */
	@PersistenceContext(unitName = "JpaFpmPortfolio")
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	// end-region

	// region Implements IRatePortfolio
	/**
	 * Gets the <tt>ValuePortfolio</tt>.
	 * 
	 * @return List <tt>ValuePortfolio</tt>
	 */
	public List<ValuePortfolio> getValuePortfolio() {
		try {

			logger.logDebug(MessageManager.getString(
					"RATEPORTFOLIOMANAGER.001", "getValuePortfolio"));

			return entityManager.createNamedQuery("ValuePortfolio.FindAll",
					ValuePortfolio.class).getResultList();
		} catch (Exception e) {

			logger.logError(
					MessageManager.getString("RATEPORTFOLIOMANAGER.003"),
					e);

			throw new BusinessException(6904015,
					"Ocurrio un problema al intentar obtener los valores de las cuentas.");

		} finally {
			logger.logDebug(MessageManager.getString(
					"DEFAULTOPERATIONMANAGER.002", "getValuePortfolio"));
		}
	}

	/**
	 * Get the list for <tt>ReferencialValue</tt>.
	 * 
	 * @return List for <tt>ReferencialValue</tt>
	 */
	public List<ReferencialValue> getReferenceValueByState() {

		try {

			logger.logDebug(MessageManager.getString(
					"RATEPORTFOLIOMANAGER.001", "getReferenceValueByState"));

			return entityManager.createNamedQuery(
					"ReferencialValue.findByState", ReferencialValue.class)
					.getResultList();
		} catch (Exception ex) {

			logger.logError(MessageManager.getString(
					"RATEPORTFOLIOMANAGER.004."), ex);

			throw new BusinessException(6904016,
					"Ocurrió un error al intentar obtener valor de referencia por Estado");

		} finally {

			logger.logDebug(MessageManager.getString(
					"RATEPORTFOLIOMANAGER.002", "getReferenceValueByState"));

		}

	}

	/**
	 * Manager <tt>ValuePortfolio</tt>.
	 * 
	 * @param The
	 *            available operations
	 *            <ul>
	 *            <li>INSERT</li>
	 *            <li>UPDATE</li>
	 *            <li>DELETE</li>
	 *            </ul>
	 * @param valuePortfolio
	 *            the <tt>ValuePortfolio</tt>
	 * @return the string
	 */
	public String managerValuePortfolio(String operation,
			ValuePortfolio valuePortfolio) {
		try {

			logger.logDebug(MessageManager.getString(
					"RATEPORTFOLIOMANAGER.001", "managerValuePortfolio"));

			if (operation.equals(Constants.INSERT_OPERATION)) {

				entityManager.persist(valuePortfolio);

				
				logger.logDebug(MessageManager.getString(
						"RATEPORTFOLIOMANAGER.006", valuePortfolio.getType()));

				
				valuePortfolio.setDescription(valuePortfolio.getType());
				

				entityManager.flush();
				return valuePortfolio.getType();
			} else {
				ValuePortfolio valuePortfolioExiste = entityManager.find(
						ValuePortfolio.class, valuePortfolio.getType());
				if (valuePortfolioExiste != null) {
					entityManager.remove(valuePortfolioExiste);
					entityManager.flush();
				} else {
					logger.logDebug(MessageManager
							.getString("ITEMSMANAGER.ERROR.69104"));
				}
				return null;
			}
		} catch (Exception e) {

			logger.logError(MessageManager.getString(
					"RATEPORTFOLIOMANAGER.005", valuePortfolio.getType()), e);

			throw new BusinessException(6904017,
					"Ocurrió un error al intentar crear o eliminar la operación en la cuenta");

		} finally {

			logger.logDebug(MessageManager.getString(
					"RATEPORTFOLIOMANAGER.002", "managerValuePortfolio"));

		}

	}

	/**
	 * Manager <tt>ValueDetailPortfolio</tt>.
	 * 
	 * @param The
	 *            available operations
	 *            <ul>
	 *            <li>INSERT</li>
	 *            <li>UPDATE</li>
	 *            <li>DELETE</li>
	 *            </ul>
	 * @param valueDetailPortfolio
	 *            the <tt>ValueDetailPortfolio</tt>
	 */
	public void managerValueDetailPortfolio(String operation,
			ValueDetailPortfolio valueDetailPortfolio) {
		try {
			
			logger.logDebug(MessageManager.getString(
					"RATEPORTFOLIOMANAGER.001", "managerValueDetailPortfolio"));
			
			if (operation.equals(Constants.INSERT_OPERATION)) {
				entityManager.persist(valueDetailPortfolio);
				entityManager.flush();
			} else {
				ValueDetailPortfolioId id = new ValueDetailPortfolioId(
						valueDetailPortfolio.getType(),
						valueDetailPortfolio.getSector());

				ValueDetailPortfolio valueDetailPortfolioExist = entityManager
						.find(ValueDetailPortfolio.class, id);

				if (valueDetailPortfolioExist != null) {
					entityManager.remove(valueDetailPortfolioExist);
					entityManager.flush();
				} else {
				
					logger.logDebug(MessageManager.getString(
							"RATEPORTFOLIOMANAGER.007"));
					
					
				}
			}
		} catch (Exception e) {
			
			 logger.logError((MessageManager.getString(
						"RATEPORTFOLIOMANAGER.099")), e);
			
			 throw new BusinessException(6904018,
			"Ocurrio un error al intentar insertar o modificar la operación");
		} finally {
			logger.logDebug(MessageManager.getString(
					"RATEPORTFOLIOMANAGER.002", "managerValueDetailPortfolio"));
		}

	}

	// end-region
}
