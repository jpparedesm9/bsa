/*
 * File: CompanyManager.java
 * Date: August 31, 2011
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

import java.util.List;

import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.administration.service.ICompanyManager;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.Company;
import com.cobiscorp.ecobis.fpm.model.NodeTypeCategory;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

/**
 * This service allows you to manage information for Companies.
 * 
 * @author cloachamin
 */
public class CompanyManager implements ICompanyManager {

	// region Fields

	/** CTS logger */

	private static final ILogger logger = LogFactory
			.getLogger(CompanyManager.class);

	/** Entity Manger */
	private EntityManager em;

	// end-region

	// region Company administrative methods
	/**
	 * Obtain a <tt>Company</tt>
	 * 
	 * @param companyId
	 *            <tt>Company</tt> Id
	 * @return Company
	 * @throws BusinessException
	 *             if <tt>Company</tt> don't found.
	 */
	public Company getCompanyById(Long companyId) {
		try {
			// log method entry
			logger.logDebug(MessageManager.getString("COMPANYMANAGER.001",
					"getCompanyById"));
			// Find the company by its primary class
			Company company = em.find(Company.class, companyId);
			// If an instance was found, load the child companies
			if (company != null)
				company.getChildCompanies().size();
			else
				// else throw a exception
				throw new BusinessException(6900002,
						"No existe la compañía correspondiente al id seleccionado");
			// Return the company with its child companies loaded
			return company;
		} catch (BusinessException be) {
			logger.logError(MessageManager.getString("COMPANYMANAGER.003"), be);
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("COMPANYMANAGER.008"), ex);
			throw new BusinessException(6900008,
					"No se pudo realizar la búsqueda de la Compañía requerida");
		} finally {
			// log method exit
			logger.logDebug(MessageManager.getString("COMPANYMANAGER.002",
					"getCompanyById"));
		}
	}

	/**
	 * Find all <tt>Company</tt> in the FPM
	 * 
	 * @return List of <tt>Company</tt>
	 */
	public List<Company> getAllCompanies() {
		try {
			// log method entry
			logger.logDebug(MessageManager.getString("COMPANYMANAGER.001",
					"getAllCompanies"));
			// Find all the companies
			List<Company> companies = em.createNamedQuery("Company.findAll",
					Company.class).getResultList();
			// For each company found load the parent company object
			for (Company c : companies) {
				if (c.getParent() != null)
					c.getParent().getId();
			}
			return companies;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("COMPANYMANAGER.009"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			// log method exit
			logger.logDebug(MessageManager.getString("COMPANYMANAGER.002",
					"getAllCompanies"));
		}
	}

	/**
	 * Create a <tt>Company</tt>
	 * 
	 * @param id
	 *            <tt>Company</tt> Id
	 * @param name
	 *            <tt>Company</tt> name
	 * @param parentId
	 *            parent <tt>Company</tt>
	 * @throws BusinessException
	 *             if there are errors when trying to insert a <tt>Company</tt>
	 */
	public Long createCompany(String name, Long parentId, String description) {
		try {
			// log method entry
			logger.logDebug(MessageManager.getString("COMPANYMANAGER.001",
					"createCompany"));
			// If it's creating the root company
			Company companyParent = null;
			if (parentId == -1) {
				companyParent = null;
			} else {
				// get a managed entity for the parent company
				companyParent = getCompanyById(parentId);
			}
			// Create the entity to persist
			Company company = new Company();
			company.setName(name);
			company.setParent(companyParent);
			company.setDescription(description);
			// Persist the entity
			em.persist(company);
			if (parentId == -1) { // If create a root company create a root
									// Banking Product
				BankingProduct product = new BankingProduct();
				product.setId(Constants.ROOT_BANKING_PRODUCT_ID);
				product.setName(name);
				product.setParentnode(null);
				product.setCompany(company);
				product.setAvailable(Constants.NO);
				// Not set because the localization
				product.setDescription("");
				product.setNodeTypeCategory(em.find(NodeTypeCategory.class, 1l));
				em.persist(product);

				List<NodeTypeCategory> categorybyModule = em
						.createNamedQuery(
								"NodeTypeCategory.findCategoryByModule",
								NodeTypeCategory.class)
						.setParameter("categoryId",
								Constants.MODULE_NODE_TYPE_PRODUCT_ID)
						.getResultList();

				if (categorybyModule.size() > 0) {
					int cont = 1;
					for (NodeTypeCategory ntc : categorybyModule) {
						BankingProduct childproduct = new BankingProduct();
						childproduct
								.setId(ntc.getName() + String.valueOf(cont));
						childproduct.setName(ntc.getName());
						childproduct.setParentnode(product.getId());
						childproduct.setCompany(company);
						childproduct.setAvailable(Constants.NO);
						// Not set because the localization
						childproduct.setDescription("");
						childproduct.setNodeTypeCategory(em.find(
								NodeTypeCategory.class, ntc.getId()));
						em.persist(childproduct);

					}
				}
			}
			// Always flush the transaction to capture the exceptions in this
			// method
			em.flush();
			return company.getId();
		} catch (EntityExistsException exception) {
			logger.logError(MessageManager.getString("COMPANYMANAGER.004"),
					exception);
			throw new BusinessException(6900004,
					"No se pudo añadir la Compañía deseada, esta ya existe");
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("COMPANYMANAGER.005", name), ex);
			throw new BusinessException(6900009,
					"No se pudo crear la Compañía deseada");
		} finally {
			// log method exit
			logger.logDebug(MessageManager.getString("COMPANYMANAGER.002",
					"createCompany"));
		}
	}

	/**
	 * Delete a <tt>Company</tt>
	 * 
	 * @param companyId
	 *            <tt>Company</tt>Id
	 * @throws BusinessException
	 *             if there are errors when trying to delete a <tt>Company</tt>
	 */
	public void deleteCompany(Long companyId) {
		Company company = null;
		try {
			// log method entry
			logger.logDebug(MessageManager.getString("COMPANYMANAGER.001",
					"deleteCompany"));
			// Get a managed entity to remove
			company = em.find(Company.class, companyId);
			// If one was found delete
			if (company != null) {
				if (relatedInformation(companyId))
					throw new BusinessException(6900006,
							"No se pudo eliminar la Compañía deseada, esta tiene información relacionada");
				else
					em.remove(company);
			} else {// else throw a exception
				throw new BusinessException(6900002,
						"No existe la compañía correspondiente al id seleccionado");
			}
			// Always flush the transaction to capture the exceptions in this
			// method
			em.flush();
		} catch (BusinessException exception) {
			logger.logError(
					MessageManager.getString("COMPANYMANAGER.006", company),
					exception);
			throw exception;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("COMPANYMANAGER.006", company), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			// log method exit
			logger.logDebug(MessageManager.getString("COMPANYMANAGER.002",
					"deleteCompany"));
		}
	}

	/*
	 * Check if a company has related information
	 */
	private Boolean relatedInformation(Long companyId) {
		Long countBankingProduct = em
				.createNamedQuery("Company.countRelatedBankingProduct",
						Long.class).setParameter("companyId", companyId)
				.getSingleResult();

		Long countDicCompany = em
				.createNamedQuery("Company.countRelatedDicCompanyProdType",
						Long.class).setParameter("companyId", companyId)
				.getSingleResult();

		return (countBankingProduct + countDicCompany) > 0;
	}

	/**
	 * Update a <tt>Company</tt>
	 * 
	 * @param companyId
	 *            <tt>Company</tt>Id
	 * @throws BusinessException
	 *             if there are errors when trying to update a <tt>Company</tt>
	 */
	public void updateCompany(Company company) {
		try {
			// log method entry
			logger.logDebug(MessageManager.getString("COMPANYMANAGER.001",
					"updateCompany"));
			// Use the merge method of the entity manager to update the changes
			em.merge(company);
			// Always flush the transaction to capture the exceptions in this
			// method
			em.flush();
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("COMPANYMANAGER.007", company), ex);
			throw new BusinessException(6900007,
					"No se pudo actualizar la Compañía seleccionada");
		} finally {
			// log method exit
			logger.logDebug(MessageManager.getString("COMPANYMANAGER.002",
					"updateCompany"));
		}
	}

	// end-region

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
	// end-region
}
