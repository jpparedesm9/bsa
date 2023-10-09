package com.cobiscorp.ecobis.fpm.portfolio.service.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.catalogs.service.ICatalogManager;
import com.cobiscorp.ecobis.fpm.portfolio.model.ConceptPortfolio;
import com.cobiscorp.ecobis.fpm.portfolio.model.ItemsOperationPortfolio;
import com.cobiscorp.ecobis.fpm.portfolio.model.ItemsOperationPortfolioDef;
import com.cobiscorp.ecobis.fpm.portfolio.model.ItemsPortfolio;
import com.cobiscorp.ecobis.fpm.portfolio.model.ItemsPortfolioId;
import com.cobiscorp.ecobis.fpm.portfolio.service.IItemPortfolioManager;
import com.cobiscorp.ecobis.fpm.portfolio.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.portfolio.utils.MessageManager;

public class ItemPortfolioManager implements IItemPortfolioManager {

	// region Fields

	/** Cobis Logger */
	private static final ILogger logger = LogFactory
			.getLogger(DefaultOperationManager.class);

	protected ICatalogManager portfolioCatalogService;
	
	// private static final String CA_OPERATION_QUERY =
	// "select op_fecha_ini, op_sector, op_toperacion, op_moneda from cob_cartera..ca_operacion where op_banco=?";
	// private static final String CA_OPERATION_QUERY_TMP =
	// "select opt_fecha_ini, opt_sector, opt_toperacion, opt_moneda from cob_cartera..ca_operacion_tmp where opt_banco=?";

	/** Entity Manager injected by the container */
	@PersistenceContext(unitName = "JpaFpmPortfolio")
	private EntityManager entityManager;

	// end-region

	// region Properties

	/**
	 * @param portfolioCatalogService the portfolioCatalogService to set
	 */
	public void setPortfolioCatalogService(ICatalogManager portfolioCatalogService) {
		this.portfolioCatalogService = portfolioCatalogService;
	}

	// end-region
	
	

	// region Implements IItemPortfolioManager

	/**
	 * Find all <tt>ItemsPortfolio</tt>.
	 * 
	 * @param The
	 *            available operations
	 *            <ul>
	 *            <li>INSERT</li>
	 *            <li>UPDATE</li>
	 *            <li>DELETE</li>
	 *            </ul>
	 * @param currency
	 *            the currency id
	 * @return List <tt>ItemsPortfolio</tt>
	 */
	public List<ItemsPortfolio> findAllItemsPortfolios(String operation,
			Long currency) {
		try {

			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.001", "findAllItemsPortfolios"));

			return entityManager
					.createNamedQuery("ItemsPortfolio.FindSpecificItems",
							ItemsPortfolio.class)
					.setParameter("operation", operation)
					.setParameter("currency", currency).getResultList();
		} catch (Exception e) {
			logger.logError(
					MessageManager.getString("ITEMPORTFOLIOMANAGER.003"), e);

			throw new BusinessException(6904009,
					"Ocurrió un problema al intentar consultar los rubros asociados a la operación");

		} finally {

			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.002", "findAllItemsPortfolios"));

		}

	}
	

	/**
	 * Manage <tt>ItemsPortfolio</tt>.
	 * 
	 * @param The
	 *            available operations
	 *            <ul>
	 *            <li>INSERT</li>
	 *            <li>UPDATE</li>
	 *            <li>DELETE</li>
	 *            </ul>
	 * @param itemsPortfolio
	 *            <tt>ItemsPortfolio</tt>
	 */
	public void manageItemsPortfolio(String operation,
			ItemsPortfolio itemsPortfolio) {
		try {

			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.001", "manageItemsPortfolio"));

			if (operation.equals(Constants.INSERT_OPERATION)) {
				entityManager.persist(itemsPortfolio);
			} else {
				ItemsPortfolioId itemsPortfolioId = new ItemsPortfolioId(
						itemsPortfolio.getOperation(),
						itemsPortfolio.getCurrency(),
						itemsPortfolio.getConcept());

				ItemsPortfolio existItemsPortfolio = entityManager.find(
						ItemsPortfolio.class, itemsPortfolioId);

				if (existItemsPortfolio != null
						&& operation.equals(Constants.UPDATE_OPERATION)) {
					entityManager.merge(itemsPortfolio);
				} else if (existItemsPortfolio != null
						&& operation.equals(Constants.DELETE_OPERATION)) {
					entityManager.remove(existItemsPortfolio);
				}
			}

			entityManager.flush();
		} catch (Exception e) {

			logger.logError(
					MessageManager.getString("ITEMPORTFOLIOMANAGER.004"),
					e);

			throw new BusinessException(
					6904999,
					"Ocurrió un problema durante la ejecución de la operación.Comuniquese con el administrador");

		} finally {

			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.002", "manageItemsPortfolio"));

		}
	}

	public void deleteItemsPortfolioForIdOperation(String idOperation) {
		try {

			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.001",
					"deleteItemsPortfolioForIdOperation"));

			List<ItemsPortfolio> itemsPortfolioList = entityManager
					.createNamedQuery("ItemsPortfolio.FindByOperation",
							ItemsPortfolio.class)
					.setParameter("operation", idOperation).getResultList();

			for (ItemsPortfolio itemsPortfolio : itemsPortfolioList) {
				entityManager.remove(itemsPortfolio);
			}
			entityManager.flush();
		} catch (Exception e) {
			logger.logError(
					MessageManager.getString("ITEMPORTFOLIOMANAGER.005"),
					e);

			throw new BusinessException(6904010,
					"Ocurrió un problema durante la eliminacion del rubro");

		} finally {

			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.002",
					"deleteItemsPortfolioForIdOperation"));
		}
	}

	/**
	 * Update <tt>ItemsOperationPortfolio</tt>.
	 * 
	 * @param operationId
	 *            the operation id
	 * @param reference
	 *            the reference with you search the operation to update
	 * @param newReference
	 *            the new reference
	 */
	public void updateItemsOperationPortfolio(Integer operationId,
			String reference, String newReference) {

		try {

			logger.logDebug(MessageManager
					.getString("ITEMPORTFOLIOMANAGER.001",
							"updateItemsOperationPortfolio"));

			List<ItemsOperationPortfolio> itemsOperationPortfolio = entityManager
					.createNamedQuery(
							"ItemsOperationPortfolio.FindSpecificItemOperation",
							ItemsOperationPortfolio.class)
					.setParameter("operation", operationId)
					.setParameter("reference", reference).getResultList();

			if (itemsOperationPortfolio.size() != 1) {

				throw new BusinessException(6904011,
						"No existieron rubros asociados a la busqueda indicada");

			} else {

				itemsOperationPortfolio.get(0).setReference(newReference);
				entityManager.merge(itemsOperationPortfolio);
				entityManager.flush();

			}

		} catch (Exception e) {

			logger.logError(
					MessageManager.getString("ITEMPORTFOLIOMANAGER.006"),
					e);

			throw new BusinessException(
					6904012,
					"Ocurrió un problema durante la actualización de la referencia asociada a rubro");

		} finally {
			logger.logDebug(MessageManager
					.getString("ITEMPORTFOLIOMANAGER.002",
							"updateItemsOperationPortfolio"));
		}

	}

	/**
	 * 
	 * @param operationId
	 *            the operation Id
	 * @param reference
	 *            the reference
	 * @param newReference
	 *            the new reference
	 */
	public void updateItemsOperationPortfolioDef(Integer operationId,
			String reference, String newReference) {

		try {

			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.001",
					"updateItemsOperationPortfolioDef"));

			List<ItemsOperationPortfolioDef> itemsOperationPortfolioDef = entityManager
					.createNamedQuery(
							"ItemsOperationPorfolioDef.FindSpecificItemOperation",
							ItemsOperationPortfolioDef.class)
					.setParameter("operation", operationId)
					.setParameter("reference", reference).getResultList();

			if (itemsOperationPortfolioDef.size() != 1) {

				throw new BusinessException(6904012,
						"No existieron rubros asociados a la busqueda indicada");

			} else {

				itemsOperationPortfolioDef.get(0).setReference(newReference);
				entityManager.merge(itemsOperationPortfolioDef);
				entityManager.flush();

			}

		} catch (Exception e) {

			logger.logError(
					MessageManager.getString("ITEMPORTFOLIOMANAGER.006"),
					e);
			throw new BusinessException(
					6904999,
					"Ocurrió un problema durante la ejecución de la operación.Comuniquese con el administrador");

		} finally {

			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.002",
					"updateItemsOperationPortfolioDef"));

		}

	}

	public void updateItemsOperationPortfolioForConcept(Integer operationId,
			String concept, String newReference) {
		try {

			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.001",
					"updateItemsOperationPortfolioForConcept"));

			List<ItemsOperationPortfolio> itemsOperationPortfolio = entityManager
					.createNamedQuery(
							"ItemsOperationPortfolio.FindSpecificItemOperationForConcept",
							ItemsOperationPortfolio.class)
					.setParameter("operation", operationId)
					.setParameter("concept", concept).getResultList();

			if (itemsOperationPortfolio.size() != 1) {

				throw new BusinessException(6904012,
						"No existieron rubros asociados a la busqueda indicada");
			} else {
				itemsOperationPortfolio.get(0).setReference(newReference);
				entityManager.merge(itemsOperationPortfolio);
				entityManager.flush();
			}

		} catch (Exception e) {
			logger.logError(
					MessageManager.getString("ITEMPORTFOLIOMANAGER.007"),
					e);

			throw new BusinessException(
					6904013,
					"Ocurrió un problema al intentar modificar las operaciones de cartera por concepto");

		} finally {

			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.002",
					"updateItemsOperationPortfolioForConcept"));

		}
	}

	public void updateItemsOperationPortfolioForConcept(Integer operationId,
			String concept, String newReference, String newReferenceChangeRate) {
		try {
			
			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.001",
					"updateItemsOperationPortfolioDef"));
			
			List<ItemsOperationPortfolio> itemsOperationPortfolio = entityManager
					.createNamedQuery(
							"ItemsOperationPortfolio.FindSpecificItemOperationForConcept",
							ItemsOperationPortfolio.class)
					.setParameter("operation", operationId)
					.setParameter("concept", concept).getResultList();
			if (itemsOperationPortfolio.size() != 1) 
			{
				throw new BusinessException(6904012,
						"No existieron rubros asociados a la busqueda indicada");
				
			}else{
				itemsOperationPortfolio.get(0).setReference(newReference);
				itemsOperationPortfolio.get(0)
						.setChangeReference(newReferenceChangeRate);

				entityManager.merge(itemsOperationPortfolio);
				entityManager.flush();
				
			}

				

		
		} catch (Exception e) {
			
			logger.logError(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.008"
					),e);
			
			throw new BusinessException(6904999,"Ocurrió un problema durante la ejecución de la operación.Comuniquese con el administrador");
			
		} finally {
			
			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.002",
					"updateItemsOperationPortfolioDef"));
			
		}
	}

	public void updateItemsOperationPortfolioChangeRate(Integer operationId,
			String referenceChangeRate, String newReferenceChangeRate) {
		try {

			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.001",
					"updateItemsOperationPortfolioChangeRate"));
			
			List<ItemsOperationPortfolio> itemsOperationPortfolio = entityManager
					.createNamedQuery(
							"ItemsOperationPortfolio.FindSpecificItemOperationForChangeRate",
							ItemsOperationPortfolio.class)
					.setParameter("operation", operationId)
					.setParameter("changeReference", referenceChangeRate)
					.getResultList();

			if (itemsOperationPortfolio.size() != 1) {
				throw new BusinessException(6904013,
						"No existieron rubros asociados a la busqueda indicada");
				
			}else{
				
				itemsOperationPortfolio.get(0)
				.setChangeReference(newReferenceChangeRate);
		entityManager.merge(itemsOperationPortfolio);
		entityManager.flush();
		
			}
			
			
			
		} catch (Exception e) {
			
			logger.logError(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.099"
					),e);
			throw new BusinessException(6904999,"Ocurrió un problema durante la ejecución de la operación.Comuniquese con el administrador");
		
			
		} finally {
			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.002",
					"updateItemsOperationPortfolioChangeRate"));
			
		}
	}

	public ItemsPortfolio findItemPortfolio(ItemsPortfolio itemPortfolio) {
		ItemsPortfolioId id = new ItemsPortfolioId();
		id.setOperation(itemPortfolio.getOperation());
		id.setConcept(itemPortfolio.getConcept());
		id.setCurrency(itemPortfolio.getCurrency());
		return this.entityManager.find(ItemsPortfolio.class, id);
	}

	public void deleteItemPortfolioByOperationAndConcept(
			ItemsPortfolio itemPortfolio) {
		
		logger.logDebug(MessageManager.getString(
				"ITEMPORTFOLIOMANAGER.001",
				"deleteItemPortfolioByOperationAndConcept"));
		
		
		logger.logDebug(MessageManager.getString(
				"ITEMPORTFOLIOMANAGER.009"
				));
		
		
		
		List<ItemsPortfolio> itemsPortfolioList = this.entityManager
				.createNamedQuery("ItemsPortfolio.findByOperationAndConcept",
						ItemsPortfolio.class)
				.setParameter("operation", itemPortfolio.getOperation())
				.setParameter("concept", itemPortfolio.getConcept())
				.getResultList();
		for (ItemsPortfolio iP : itemsPortfolioList) {
			this.entityManager.remove(iP);
		}
		
		logger.logDebug(MessageManager.getString(
				"ITEMPORTFOLIOMANAGER.010"
				));
		
		logger.logDebug(MessageManager.getString(
				"ITEMPORTFOLIOMANAGER.002",
				"deleteItemPortfolioByOperationAndConcept"));
		
		
		
	}

	public void deleteItemPortfolioByOperation(String operation) {
		try {
			
			
			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.001",
					"deleteItemPortfolioByOperation"));
			
			List<ItemsPortfolio> itemPortfolioList = this.entityManager
					.createNamedQuery("ItemsPortfolio.FindByOperation",
							ItemsPortfolio.class)
					.setParameter("operation", operation).getResultList();
			for (ItemsPortfolio item : itemPortfolioList) {
				this.entityManager.remove(item);
			}
			this.entityManager.flush();

		} catch (Exception e) {
			
			logger.logError(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.011",
					operation),e);
			
			 throw new BusinessException(6904014,
			 "Ocurrió un error al intentar eliminar el rubro vinculado a esta operación");
		} finally {
			
			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.002",
					"deleteItemPortfolioByOperation"));
			
		}
	}

	public void manageConcept(ConceptPortfolio concept) {
		try {
			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.001", "manageConcept"));

			ConceptPortfolio existItem = entityManager.find(
					ConceptPortfolio.class, concept.getConcept().trim());

			if (existItem != null) {
				existItem.setDescription(concept.getDescription());
				existItem.setConcept(concept.getConcept());
				existItem.setGroup((concept.getGroup()));
			} else {
				entityManager.persist(concept);
			}
			entityManager.flush();
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("ITEMPORTFOLIOMANAGER.099"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.002", "manageConcept"));
		}
	}
	
	public Integer getSequentialItemCode() {

		try {
			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.001", "getSequentialItemCode"));
			Integer maxSequential = entityManager.createNamedQuery(
					"ConceptPortfolio.findNextCodeItem", Integer.class)
					.getSingleResult();

			return ++maxSequential;
		} catch (Exception e) {
			logger.logError(
					MessageManager.getString("ITEMPORTFOLIOMANAGER.099"), e);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.002", "manageConcept"));
		}
	}

	
	public void deleteConcept(String concept) {
		try {
			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.001", "deleteConcept"));

			ConceptPortfolio existItemPortfolio = entityManager.find(
					ConceptPortfolio.class, concept);
			
			entityManager.remove(existItemPortfolio);
			entityManager.flush();
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("ITEMPORTFOLIOMANAGER.099"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.002", "deleteConcept"));
		}
	}
	
	public List<Catalog> getItemsGroup() {
		try {
			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.001", "getItemsGroup"));

			return portfolioCatalogService.getCatalogsByName("ca_rubro_grupo");
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("ITEMPORTFOLIOMANAGER.099"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ITEMPORTFOLIOMANAGER.002", "getItemsGroup"));
		}
	}
	// end-region

}
