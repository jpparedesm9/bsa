/*
 * File: NodeProductManagerTest.java
 * Date: September 13, 2011
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

package com.cobiscorp.ecobis.fpm.administration.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.administration.service.INodeProductManager;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.Functionality;
import com.cobiscorp.ecobis.fpm.model.NodeTypeCategory;
import com.cobiscorp.ecobis.fpm.model.NodeTypeProduct;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

/**
 * This service allows you to manage information related to a node of a product
 * 
 * @author cloachamin
 * 
 */
public class NodeProductManager implements INodeProductManager {

	private IBankingProductManager bankinProduct;
	private static final ILogger logger = LogFactory
			.getLogger(NodeProductManager.class);

	private EntityManager em;

	public void setBankinProduct(IBankingProductManager bankinProduct) {
		this.bankinProduct = bankinProduct;
	}

	/**
	 * Find all <tt>NodeTypeProduct</tt>
	 * 
	 * @return List of <tt>NodeTypeProduct</tt>
	 */
	public List<NodeTypeProduct> getAllNodeProducts() {
		try {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.001",
					"getAllNodeProducts"));
			List<NodeTypeProduct> nodes = em.createNamedQuery(
					"NodeTypeProduct.findAll", NodeTypeProduct.class)
					.getResultList();
			for (NodeTypeProduct nodeTypeProduct : nodes) {
				nodeTypeProduct.getFunctionalities().size();
				nodeTypeProduct.getNodeTypeCategories().size();
			}
			return nodes;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.007"),
					ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.002",
					"getAllNodeProducts"));
		}
	}

	/**
	 * Find a specific <tt>NodeTypeProduct</tt> by its identifier
	 * 
	 * @param nodeProductID
	 *            <tt>NodeTypeProduct</tt> Identifier
	 * @return <tt>NodeTypeProduct</tt> instance if it was found
	 * @throws BusinessException
	 *             if any <tt>NodeTypeProduct</tt> was found
	 */
	public NodeTypeProduct getNodeProductById(Long nodeProductID) {
		try {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.001",
					"getNodeProductById"));
			NodeTypeProduct node = em
					.find(NodeTypeProduct.class, nodeProductID);
			if (null == node) {
				throw new BusinessException(6900005,
						"No existe el nodo de producto con el id requerido");
			}
			if (null != node.getNodeTypeCategories()) {
				node.getNodeTypeCategories().size();
			}
			if (null != node.getFunctionalities()) {
				node.getFunctionalities().size();
			}
			return node;
		} catch (BusinessException be) {
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.008",
					nodeProductID), be);
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.008",
					nodeProductID), ex);
			throw new BusinessException(6900030,
					"No se pudo realizar la búsqueda del tipo de producto requerido");
		} finally {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.002",
					"getNodeProductById"));
		}
	}

	/**
	 * Insert a <tt>NodeTypeProduct</tt>
	 * 
	 * @param nodeProduct
	 *            The <tt>NodeTypeProduct</tt> to insert
	 * @return The <tt>NodeTypeProduct</tt> identifier
	 * @throws BusinessException
	 *             if occurs an error
	 */
	public Long insertNodeProduct(NodeTypeProduct nodeProduct) {
		try {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.001",
					"insertNodeProduct"));
			// By Definition only the node with id 3 keep dictionary
			nodeProduct.setKeepDictionary(Constants.NO);
			em.persist(nodeProduct);
			em.flush();
			return nodeProduct.getId();
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.009",
					nodeProduct), eee);
			throw new BusinessException(6900031,
					"El Nodo de Producto seleccionado no se pudo insertar, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.003",
					nodeProduct), ex);
			throw new BusinessException(6900032,
					"No se pudo crear el Nodo de Producto seleccionado.");
		} finally {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.002",
					"insertNodeProduct"));
		}
	}

	/**
	 * Update the information related to a <tt>NodeTypeProduct</tt>
	 * 
	 * @param nodeProduct
	 *            The <tt>NodeTypeProduct</tt> to update
	 */
	public void updateNodeProduct(NodeTypeProduct nodeProduct) {
		try {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.001",
					"updateNodeProduct"));
			NodeTypeProduct node = getNodeProductById(nodeProduct.getId());
			node.setName(nodeProduct.getName());
			node.setDescription(nodeProduct.getDescription());
			node.setFinalProduct(nodeProduct.getFinalProduct());
			em.flush();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.004",
					nodeProduct), ex);
			throw new BusinessException(6900033,
					"No se pudo actualizar el Nodo de Producto seleccionado.");
		} finally {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.002",
					"updateNodeProduct"));
		}
	}

	/**
	 * Delete a <tt>NodeTypeProduct</tt>
	 * 
	 * @param nodeProduct
	 *            The <tt>NodeTypeProduct</tt> to delete
	 * @throws BusinessException
	 *             if occurs an error or if this <tt>NodeTypeProduct</tt> has
	 *             relation with other entities
	 */
	public void deleteNodeProduct(Long nodeProductId) {
		try {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.001",
					"deleteNodeProduct"));
			NodeTypeProduct node = getNodeProductById(nodeProductId);
			em.remove(node);
			em.flush();
		} catch (PersistenceException pe) {
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.005",
					nodeProductId), pe);
			throw new BusinessException(6900034,
					"No se pudo eliminar el Nodo de Producto porque tiene información relacionada.");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.005",
					nodeProductId), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.002",
					"deleteNodeProduct"));
		}
	}

	/**
	 * Find all <tt>Functionality</tt>
	 * 
	 * @return List of <tt>Functionality</tt>
	 */
	public List<Functionality> getAllFunctionalities() {
		try {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.001",
					"getAllFunctionalities"));
			return em.createNamedQuery("Functionality.findAll",
					Functionality.class).getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.099"),
					ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.002",
					"getAllFunctionalities"));
		}
	}

	/**
	 * This method manage the basic operations over a
	 * <tt>DicFunctionalityGroup</tt>, the operations available are:
	 * <ul>
	 * <li>I - Insert</li>
	 * <li>U - Update</li>
	 * <li>D - Delete</li>
	 * </ul>
	 * 
	 * @param operation
	 *            The available operations
	 * 
	 * @param functionalityGroup
	 *            The <tt>DicFunctionalityGroup</tt> on which the operation is
	 *            performed
	 */
	public NodeTypeProduct getDictionaryNodeProduct() {
		try {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.001",
					"getDictionaryNodeProduct"));
			NodeTypeProduct nodeTypeProduct = em
					.createNamedQuery("NodeTypeProduct.findDictionaryNode",
							NodeTypeProduct.class).getSingleResult();
			nodeTypeProduct.getFunctionalities().size();
			nodeTypeProduct.getNodeTypeCategories().size();
			return nodeTypeProduct;
		} catch (NoResultException nre) {
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.006"),
					nre);
			throw new BusinessException(6900035,
					"No existe un Nodo de Producto configurado que define diccionario");
		} catch (NonUniqueResultException nue) {
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.006"),
					nue);
			throw new BusinessException(6900036,
					"Existe mas de un Nodo de Producto configurado que define diccionario");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.006"),
					ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.002",
					"getDictionaryNodeProduct"));
		}
	}

	/**
	 * This method manage the basic operations over a <tt>NodeTypeCategory</tt>
	 * 
	 * @param operation
	 *            The available operations
	 *            <ul>
	 *            <li>INSERT</li>
	 *            <li>UPDATE</li>
	 *            <li>DELETE</li>
	 *            </ul>
	 * @param nodeTypeProductId
	 *            the id of the <tt>NodeTypeProduct</tt> relation
	 * @param dictionaryField
	 *            The <tt>NodeTypeCategory</tt> on which the operation is
	 *            performed
	 * @return The generated identifier when the operation is INSERT otherwise 0
	 */
	public long manageCategories(String operation, Long nodeTypeProductId,
			NodeTypeCategory category) {
		try {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.001",
					"manageCategories"));
			if (operation.equals(Constants.INSERT_OPERATION)) {
				category.setNodeTypeProduct(getNodeProductById(nodeTypeProductId));
				em.persist(category);
				logger.logDebug(MessageManager.getString(
						"NODEPRODUCTMANAGER.012", category));
				if (category.getNodeTypeProduct().getId() == Constants.CATEGORY_NODE_TYPE_PRODUCT_ID) {
					List<BankingProduct> products = em
							.createNamedQuery(
									"BankingProduct.findAllProductsByCategory",
									BankingProduct.class)
							.setParameter("categoryId",
									Constants.MODULE_NODE_TYPE_PRODUCT_ID)
							.getResultList();

					if (products.size() > 0) {
						logger.logDebug(MessageManager.getString(
								"NODEPRODUCTMANAGER.013", products.size(),
								category.getNodeTypeProduct().getId()));
						int cont = 1;
						for (BankingProduct bprd : products) {
							logger.logDebug("Producto encontrado a agregar nueva categoria "
									+ bprd);
							BankingProduct bp = new BankingProduct();
							bp.setId(category.getName() + String.valueOf(cont));
							bp.setName(category.getName());
							bp.setDescription(category.getName());
							bp.setAvailable("N");

							bp.setParentnode(bprd.getId());
							bp.setCompany(bprd.getCompany());
							bp.setNodeTypeCategory(category);
							bankinProduct.createBankingProduct(bp);
							logger.logDebug(MessageManager.getString(
									"NODEPRODUCTMANAGER.014", bp.getId()));
							cont++;
						}
					}
				}
				return category.getId();
			} else if (operation.equals(Constants.UPDATE_OPERATION)) {
				NodeTypeCategory categoryUpdate = em.find(
						NodeTypeCategory.class, category.getId());
				categoryUpdate.setName(category.getName());
				categoryUpdate.setDescription(category.getDescription());
				categoryUpdate.setMnemonic(category.getMnemonic());
				categoryUpdate.setModule(category.getModule());
			} else if (operation.equals(Constants.DELETE_OPERATION)) {

				if (bankinProduct.getProductsAssociatedSector(category.getId()) <= 0L) {
					category = getNodeCateogyById(category.getId());
					em.remove(category);
				} else {
					logger.logError(MessageManager
							.getString("NODEPRODUCTMANAGER.015"));
					throw new BusinessException(
							6900213,
							"No se puede desasociar el sector deseado puesto que tiene información relacionada.");
				}
			}
			em.flush();
			return 0;
		} catch (PersistenceException pe) {
			pe.printStackTrace();
			if (operation.equals(Constants.INSERT_OPERATION)) {
				logger.logError(MessageManager.getString(
						"NODEPRODUCTMANAGER.009", category), pe);
				throw new BusinessException(
						6900039,
						"La Categoria seleccionada no se pudo insertar, puesto que ya existe - Verificar Producto bancario");
			} else if (operation.equals(Constants.DELETE_OPERATION)) {
				logger.logError(MessageManager.getString(
						"NODEPRODUCTMANAGER.005", category), pe);
				throw new BusinessException(6900037,
						"No se pudo eliminar la Categoría porque tiene información relacionada");
			} else {
				pe.printStackTrace();
				logger.logError(MessageManager.getString(
						"NODEPRODUCTMANAGER.004", category), pe);
				throw new BusinessException(6900038,
						"No se pudo actualizar la Categoría");
			}
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.099"),
					ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.002",
					"manageCategories"));
		}
	}

	/**
	 * Update the list of functionalities
	 * 
	 * @param functionalities
	 *            The list of <tt>Functionality</tt> to update
	 */
	public void updateFunctionalities(Long nodeTypeProductId,
			ArrayList<Functionality> functionalities) {
		try {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.001",
					"updateFunctionalities"));
			NodeTypeProduct node = getNodeProductById(nodeTypeProductId);
			node.setFunctionalities(functionalities);
			em.flush();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.004",
					nodeTypeProductId), ex);
			throw new BusinessException(6900040,
					"No se pudo actualizar las funcionalidades del producto seleccionado");
		} finally {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.002",
					"updateFunctionalities"));
		}
	}

	/**
	 * Update the list of functionalities of a given Category
	 * 
	 * @param the
	 *            <tt>NodeTypeCategor</tt> identifier
	 * @param functionalities
	 *            the list of <tt>Functionality</tt>
	 */
	public void updateCategoryFunctionalities(Long nodeTypeCategoryId,
			ArrayList<Functionality> functionalities) {
		try {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.001",
					"updateCategoryFunctionalities"));
			NodeTypeCategory category = getNodeCateogyById(nodeTypeCategoryId);
			category.setFunctionalities(functionalities);
			em.flush();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.004",
					nodeTypeCategoryId), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.002",
					"updateCategoryFunctionalities"));
		}
	}

	/**
	 * Find all categories given the <tt>NodeTypeProduct</tt> identifier
	 * 
	 * @param nodeTypeProductId
	 *            <tt>NodeTypeProduct</tt> identifier
	 * @return <tt>NodeTypeCategory</tt> list
	 */
	public List<NodeTypeCategory> getCategoriesByGroup(Long nodeTypeProductId) {
		try {

			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.001",
					"getCategoriesByGroup"));

			return em
					.createNamedQuery("NodeTypeCategory.findCategoryByGroup",
							NodeTypeCategory.class)
					.setParameter("categoryId", nodeTypeProductId)
					.getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.010",
					nodeTypeProductId, nodeTypeProductId), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.002",
					"getCategoriesByGroup"));
		}
	}

	/**
	 * Find a <tt>NodeTypeCategory</tt> given its identifier
	 * 
	 * @param categoryId
	 *            <tt>NodeTypeCategory</tt> identifier
	 * @return <tt>NodeTypeCategory</tt> entity
	 */
	public NodeTypeCategory getNodeCateogyById(Long categoryId) {
		try {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.001",
					"getNodeCateogyById"));
			NodeTypeCategory category = em.find(NodeTypeCategory.class,
					categoryId);
			if (null == category) {
				throw new BusinessException(6900041,
						"No se pudo obtener la Categoria requerida, puesto que no existe.");
			}
			if (null != category.getFunctionalities()) {
				category.getFunctionalities().size();
			}
			return category;
		} catch (BusinessException be) {
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.010",
					categoryId), be);
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.099"),
					ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.002",
					"getNodeCateogyById"));
		}
	}

	/**
	 * Find categories by Category and groupId
	 * 
	 * @param nodeTypeProductId
	 * @param groupId
	 * @return
	 */

	public List<NodeTypeCategory> getCategoriesByProductTypeAndGroup(
			Long nodeTypeProductId, Long groupId) {
		try {

			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.001",
					"getCategoriesByProductTypeAndGroup"));

			return em
					.createNamedQuery("NodeTypeCategory.findByProductAndGroup",
							NodeTypeCategory.class)
					.setParameter("nodeProductId", nodeTypeProductId)
					.setParameter("groupId", groupId).getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.010",
					nodeTypeProductId, groupId), ex);
			throw new BusinessException(6900001,
					"Existion un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.002",
					"getCategoriesByProductTypeAndGroup"));
		}
	}

	/**
	 * Get a list of all <tt>NodeTypeCategory</tt> that have related
	 * functionalities
	 * 
	 * @return List of <tt>NodeTypeCategory</tt> with <tt>Functionality</tt>
	 */
	public List<NodeTypeCategory> getAllCategoriesWithFunctionalities() {
		try {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.001",
					"getAllCategoriesWithFunctionalities"));
			List<NodeTypeCategory> categories = em
					.createNamedQuery(
							"NodeTypeCategory.findAllCategoriesByDictionary",
							NodeTypeCategory.class)
					.setParameter("keepDictionary", Constants.YES)
					.getResultList();

			return categories;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.099"),
					ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.002",
					"getAllCategoriesWithFunctionalities"));
		}
	}

	/***
	 * 
	 * @return true if APF configuration is Dynamic
	 */
	public boolean isDynamicAPFConfiguration() {
		try {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.001",
					"isDynamicAPFConfiguration"));
			List<Functionality> functionalities = em
					.createNamedQuery("Functionality.findDynamic",
							Functionality.class)
					.setParameter("paramUrl", "%?DIC=%").getResultList();
			if (functionalities.size() > 0) {
				return true;
			} else {
				return false;
			}
		} catch (Exception ex) {
			logger.logError("Error al ejecutar la consulta",
					ex);
			return false;
		} finally {
			logger.logDebug(MessageManager.getString("NODEPRODUCTMANAGER.002",
					"isDynamicAPFConfiguration"));
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
}
