/*
 * File: BankingProductManager.java
 * Date: October 21, 2011
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
package com.cobiscorp.ecobis.fpm.operation.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.htm.api.dto.ProcessDTO;
import cobiscorp.ecobis.htm.api.dto.UserDTO;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;
import com.cobiscorp.cobis.cts.services.servexecutor.IServiceExecutor;
import com.cobiscorp.cobis.cts.services.session.SessionCrypt;
import com.cobiscorp.cobisv.commons.context.CobisContext;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleProcess;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleVersion;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.bpl.rules.engine.model.VariableProcess;
import com.cobiscorp.ecobis.bpl.rules.engine.services.IRuleManager;
import com.cobiscorp.ecobis.fpm.administration.service.INodeProductManager;
import com.cobiscorp.ecobis.fpm.bo.BankingProductLog;
import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.bo.CheckBankingProductConfiguration;
import com.cobiscorp.ecobis.fpm.bo.CurrencyProductLog;
import com.cobiscorp.ecobis.fpm.bo.ProductProcessLog;
import com.cobiscorp.ecobis.fpm.bo.ProductRuleLog;
import com.cobiscorp.ecobis.fpm.bo.Sector;
import com.cobiscorp.ecobis.fpm.catalogs.service.ICatalogManager;
import com.cobiscorp.ecobis.fpm.model.AccountingProfile;
import com.cobiscorp.ecobis.fpm.model.AccountingProfileHistory;
import com.cobiscorp.ecobis.fpm.model.AccountingProfileId;
import com.cobiscorp.ecobis.fpm.model.AmountItemValue;
import com.cobiscorp.ecobis.fpm.model.AmountItemValueHistory;
import com.cobiscorp.ecobis.fpm.model.AmountItemValueId;
import com.cobiscorp.ecobis.fpm.model.AppliesToWhenApply;
import com.cobiscorp.ecobis.fpm.model.AppliesToWhenApplyId;
import com.cobiscorp.ecobis.fpm.model.Authorization;
import com.cobiscorp.ecobis.fpm.model.AuthorizationHistory;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.Company;
import com.cobiscorp.ecobis.fpm.model.CurrencyProduct;
import com.cobiscorp.ecobis.fpm.model.CurrencyProductHistory;
import com.cobiscorp.ecobis.fpm.model.CurrencyProductId;
import com.cobiscorp.ecobis.fpm.model.Functionality;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValues;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;
import com.cobiscorp.ecobis.fpm.model.ItemAppliesWay;
import com.cobiscorp.ecobis.fpm.model.ItemAppliesWayHistory;
import com.cobiscorp.ecobis.fpm.model.ItemByProduct;
import com.cobiscorp.ecobis.fpm.model.ItemByProductHistory;
import com.cobiscorp.ecobis.fpm.model.ItemByProductId;
import com.cobiscorp.ecobis.fpm.model.ItemStatus;
import com.cobiscorp.ecobis.fpm.model.ItemStatusHistory;
import com.cobiscorp.ecobis.fpm.model.ItemsValues;
import com.cobiscorp.ecobis.fpm.model.ItemsValuesHistory;
import com.cobiscorp.ecobis.fpm.model.NodeTypeCategory;
import com.cobiscorp.ecobis.fpm.model.NodeTypeProduct;
import com.cobiscorp.ecobis.fpm.model.OperationStatus;
import com.cobiscorp.ecobis.fpm.model.OperationStatusHistory;
import com.cobiscorp.ecobis.fpm.model.PolicyProduct;
import com.cobiscorp.ecobis.fpm.model.PolicyProductHistory;
import com.cobiscorp.ecobis.fpm.model.ProductProcess;
import com.cobiscorp.ecobis.fpm.model.ProductProcessHistory;
import com.cobiscorp.ecobis.fpm.model.ProductRule;
import com.cobiscorp.ecobis.fpm.model.ProductRuleHistory;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.operation.service.IGeneralParametersManager;
import com.cobiscorp.ecobis.fpm.operation.service.IItemsManager;
import com.cobiscorp.ecobis.fpm.operation.service.IUnitFunctionalityValues;
import com.cobiscorp.ecobis.fpm.portfolio.administration.service.IAccountingProfileManager;
import com.cobiscorp.ecobis.fpm.portfolio.administration.service.IEconomicActivityManager;
import com.cobiscorp.ecobis.fpm.portfolio.administration.service.IEconomicDestinationManager;
import com.cobiscorp.ecobis.fpm.portfolio.administration.service.IItemStatusManager;
import com.cobiscorp.ecobis.fpm.portfolio.administration.service.IOperationStatusManager;
import com.cobiscorp.ecobis.fpm.portfolio.administration.service.IPurposeManager;
import com.cobiscorp.ecobis.fpm.service.IEvaluatorManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.service.commons.Modules;
import com.cobiscorp.ecobis.fpm.service.utils.CatalogUtils;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

public class BankingProductManager implements IBankingProductManager {

	private static final String FILTER_FIELD = "SPExecutorServiceFactoryFilter";
	private static final String TRANSACTIONAL_FILTER_VALUE = "(service.impl=transactional)";
	private static final String OPERATION_BY_PROCESS_QUERY = "select fp_operation  from cob_fpm..fp_processbyoperation where fp_process = ?1";
	private static final String PROCESS_BY_MODULE_QUERY = "select pm_process_id  from cob_fpm..fp_processbymodule where mod_module_idfk = ?1";
	private static final String COMPARE_RULE = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

	/** COBIS Logger */
	private final ILogger logger = LogFactory.getLogger(BankingProductManager.class);

	/** Entity Manager injected by the container */
	private EntityManager entityManager;
	/** GeneralParametersManager service */
	private IGeneralParametersManager generalParametersService;
	/** Items Manager service */
	private IItemsManager itemsService;
	/** NodeProduct Manager service */
	private INodeProductManager nodeProductService;
	/** Catalog service */
	private ICatalogManager catalogManager;
	/** Catalog service */
	private IEconomicDestinationManager economicDestinationService;

	private IPurposeManager purposeManager;

	private IEconomicActivityManager economicActivityService;

	/** CTS Service Executor */
	private IServiceExecutor serviceExecutor;
	/**
	 * AccountingProfileManager service
	 */
	private IAccountingProfileManager accountingProfileService;
	/**
	 * ItemStatusManager service
	 */
	private IItemStatusManager itemStatusService;
	/**
	 * OperationStatusManager service
	 */
	private IOperationStatusManager operationStatusService;

	/** Rule Evaluator Service **/
	private IEvaluatorManager evaluatorManager;

	/** RuleManager Service **/
	private IRuleManager rulesManager;
	
	private IUnitFunctionalityValues unitFunctionalityServices;

	public List<BankingProduct> getBankinProductsStructure() {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getBankinProductsStructure"));
			}
			return entityManager.createNamedQuery("BankingProduct.findStructure", BankingProduct.class).getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.011"), ex);
			throw new BusinessException(6900057, "No se pudo cargar el árbol de productos bancarios");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getBankinProductsStructure"));
			}
		}
	}

	/**
	 * This method create a new Banking Product with the related currencies and
	 * policies
	 * 
	 * @param bankingProduct
	 *            the data for the banking product
	 */
	public void createBankingProduct(BankingProduct bankingProduct) {
		try {
			bankingProduct.setId(bankingProduct.getId().toUpperCase().trim());
			
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "createBankingProduct"));
			}
			
			if (entityManager.find(BankingProduct.class, bankingProduct.getId()) != null) {
				throw new BusinessException(6900058, "No se pudo crear el producto bancario puesto que el código ingresado ya existe");
			}
			bankingProduct.setAuthorization(new Authorization());
			bankingProduct.getAuthorization().setBankingProduct(bankingProduct);
			bankingProduct.getAuthorization().setStatus(Constants.NO);
			bankingProduct.setDelete(Constants.NO);

			// Get list process associated with product
			List<ProductProcess> productProcesses = bankingProduct.getProcesses();

			if (productProcesses != null && productProcesses.size() > 0) {

				for (ProductProcess productProcess : productProcesses) {
					// Set value for default 0
					productProcess.setProcessByProductId(0);
				}
				// Associating new list with product
				bankingProduct.setProcesses(productProcesses);
			}

			// Get list rules associated with product
			List<ProductRule> productRules = bankingProduct.getRules();

			if (productRules != null && productRules.size() > 0) {

				for (ProductRule productRule : productRules) {
					// Set value for default 0
					productRule.setRulesByProductId(0);
				}
				// Associating new list with product
				bankingProduct.setRules(productRules);
			}

			entityManager.persist(bankingProduct);

			if (bankingProduct.getParentnode() != null && !bankingProduct.getParentnode().equals("")) {
				generalParametersService.createGeneralParametersForNewBankingProduct(bankingProduct.getId());
				// Copy currencies and policies from parent
				BankingProduct bp = getBankingProductById(bankingProduct.getParentnode());
				bp.getCurrencyProducts().size();
				copyCurrenciesAndPoliciesFromParent(bankingProduct.getId(), bp.getCurrencyProducts(), bankingProduct.getParentnode());

				itemsService.copyDataItemByProductFromParent(bankingProduct);
			}
			entityManager.flush();
		} catch (BusinessException be) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.006"), be);
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.005", bankingProduct), ex);
			throw new BusinessException(6900059, "No se pudo crear el producto bancario deseado");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "createBankingProduct"));
			}
		}
	}

	public BankingProduct getBankingProductBasicInformationById(String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getBankingProductBasicInformationById"));
			}
			
			BankingProduct bProduct = getBankingProductById(bankingProductId);
			BankingProduct bankingProduct = new BankingProduct();
			bankingProduct.setId(bProduct.getId());
			bankingProduct.setName(bProduct.getName());
			bankingProduct.setDescription(bProduct.getDescription());
			bankingProduct.setAvailable(bProduct.getAvailable());
			bankingProduct.setAuthorization(bProduct.getAuthorization());
			bankingProduct.setParentnode(bProduct.getParentnode());
			bankingProduct.setSectorId(bProduct.getSectorId());
			bankingProduct.setStartDate(bProduct.getStartDate());
			bankingProduct.setExpirationDate(bProduct.getExpirationDate());
			bankingProduct.setSubstantiation(bProduct.getSubstantiation());
			bankingProduct.setCompany(new Company());
			bankingProduct.getCompany().setId(bProduct.getCompany().getId());
			bankingProduct.getCompany().setName(bProduct.getCompany().getName());
			bankingProduct.setNodeTypeCategory(new NodeTypeCategory());
			bankingProduct.getNodeTypeCategory().setId(bProduct.getNodeTypeCategory().getId());
			bankingProduct.getNodeTypeCategory().setName(bProduct.getNodeTypeCategory().getName());
			bankingProduct.getNodeTypeCategory().setNodeTypeProduct(new NodeTypeProduct());
			bankingProduct.getNodeTypeCategory().getNodeTypeProduct().setId(bProduct.getNodeTypeCategory().getNodeTypeProduct().getId());
			bankingProduct.getNodeTypeCategory().setModule(bProduct.getNodeTypeCategory().getModule());
			bankingProduct.getNodeTypeCategory().getNodeTypeProduct().setName(bProduct.getNodeTypeCategory().getNodeTypeProduct().getName());
			bankingProduct.getNodeTypeCategory().setMnemonic(bProduct.getNodeTypeCategory().getMnemonic());
			bankingProduct.setCurrencyProducts(new ArrayList<CurrencyProduct>());
			if (bProduct.getNodeTypeCategory().getNodeTypeProduct().getId() == Constants.FINAL_NODE_TYPE_PRODUCT_ID) {
				bankingProduct.setProcesses(bProduct.getProcesses());
				bankingProduct.setRules(bProduct.getRules());
			}
			for (CurrencyProduct cp : bProduct.getCurrencyProducts()) {
				if (cp.getStatus().equals(Constants.YES)) {
					CurrencyProduct cpi = new CurrencyProduct();
					cpi.setId(new CurrencyProductId(cp.getId().getCurrencyId(), null));
					bankingProduct.getCurrencyProducts().add(cpi);
				}
			}
			return bankingProduct;
		} catch (BusinessException be) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.007", bankingProductId));
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.008", bankingProductId), ex);
			throw new BusinessException(6900061, "No se pudo obtener el producto bancario");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getBankingProductBasicInformationById"));
			}
		}
	}

	/**
	 * Update the basic data related to a banking product
	 * 
	 * @param bankingProduct
	 *            Contains the data to be updated, The name of the
	 *            <tt>BankingProduct</tt> The description of the
	 *            <tt>BankingProduct</tt> with the list of Currencies and
	 *            policies
	 */
	public void updateBankingProductInformation(BankingProduct bankingProduct) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "updateBankingProductInformation"));
			}
			
			BankingProduct bp = getBankingProductById(bankingProduct.getId());
			// Update only the name and description
			bp.setName(bankingProduct.getName());
			bp.setDescription(bankingProduct.getDescription());
			bp.setStartDate(bankingProduct.getStartDate());
			bp.setExpirationDate(bankingProduct.getExpirationDate());
			bp.setSubstantiation(bankingProduct.getSubstantiation());

			if (bankingProduct.getAvailable() != null && !bankingProduct.getAvailable().trim().equals(""))
				bp.setAvailable(bankingProduct.getAvailable());

			if (bp.getNodeTypeCategory().getNodeTypeProduct().getId() == Constants.FINAL_NODE_TYPE_PRODUCT_ID) {
				for (ProductProcess pp : bp.getProcesses()) {
					entityManager.remove(pp);
				}
				for (ProductProcess ppInsert : bankingProduct.getProcesses()) {
					ppInsert.setProcessByProductId(0);
					ppInsert.setBankingProduct(bp);
					entityManager.persist(ppInsert);
				}

				for (ProductRule pr : bp.getRules()) {
					entityManager.remove(pr);
				}
				for (ProductRule prInsert : bankingProduct.getRules()) {
					prInsert.setRulesByProductId(0);
					entityManager.persist(prInsert);
				}

			}
			// Create the history of a banking product
		} catch (BusinessException be) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.007", bankingProduct.getId()), be);
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.009", bankingProduct), ex);
			throw new BusinessException(6900062, "No se pudo actualizar la información del producto bancario seleccionado.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "updateBankingProductInformation"));
			}
		}
	}

	/**
	 * Get the id of the category id that keep dictionary, this value will find
	 * navigating in the parents hierarchy
	 * 
	 * @param bankingProductId
	 *            <tt>BankingProduct</tt> identifier
	 * @return <tt>NodeTypeCategory</tt> identifier
	 */
	public Long getCategoryIdKeepDictionaryFromParents(String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getCategoryIdKeepDictionaryFromParents"));
			}
			
			return getCategoryKeepDictionaryFromParents(bankingProductId).getId();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.010"), ex);
			throw new BusinessException(6900063, "No se pudo obtener la categoría del producto bancario que define el diccionario.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getCategoryIdKeepDictionaryFromParents"));
			}
		}
	}

	/**
	 * Get the category that keep dictionary, this value will find navigating in
	 * the parents hierarchy
	 * 
	 * @param bankingProductId
	 *            <tt>BankingProduct</tt> identifier
	 * @return <tt>NodeTypeCategory</tt>
	 */
	public NodeTypeCategory getCategoryKeepDictionaryFromParents(String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getCategoryKeepDictionaryFromParents"));
			}
			
			BankingProduct product = getBankingProductById(bankingProductId);
			while (!product.getNodeTypeCategory().getNodeTypeProduct().getKeepDictionary().equals(Constants.YES)) {
				product = entityManager.find(BankingProduct.class, product.getParentnode());
				if (product == null)
					throw new BusinessException(6900061, "No se pudo obtener el producto bancario.");
			}
			// Not needed for the service's logic
			entityManager.detach(product);
			entityManager.detach(product.getNodeTypeCategory());
			product.getNodeTypeCategory().setNodeTypeProduct(null);
			return product.getNodeTypeCategory();
		} catch (BusinessException be) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.008", bankingProductId), be);
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099"), ex);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getCategoryKeepDictionaryFromParents"));
			}
		}
	}

	public BankingProduct findFinalBankingProductById(String productId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "findFinalBankingProductById"));
			}
			
			List<BankingProduct> products = entityManager.createNamedQuery("BankingProduct.findFinalBankingProductById", BankingProduct.class)
					.setParameter("bankingProductId", productId).getResultList();
			return products.size() != 1 ? null : products.get(0);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.011", productId), ex);
			throw new BusinessException(6900064, "No se pudo encontrar el producto bancario final deseado");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "findFinalBankingProductById"));
			}
		}
	}

	/**
	 * Find All the banking products available to sale, this method is used by
	 * an interceptor and only return the id and name of the
	 * <tt>BankingProduct</tt> entity
	 * 
	 * @return List of <tt>BankingProduct</tt>
	 */
	public List<BankingProduct> findAllAvailableBankingProducts() {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "findAllAvailableBankingProducts"));
			}
			
			return entityManager.createNamedQuery("BankingProduct.findAllAvailableFinalBankingProduct", BankingProduct.class).getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.012"), ex);
			throw new BusinessException(6900065, "No se pudo obtener la lista de productos bancarios");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "findAllAvailableBankingProducts"));
			}
		}
	}

	/**
	 * Check if a banking product applies for a given currency, this method is
	 * used by an interceptor
	 * 
	 * @param productId
	 *            <tt>BankingProduct</tt> identifier
	 * @param currencyId
	 *            The id for the currency
	 * @return True if exist a banking product for the given currency - False
	 *         otherwise
	 */
	public Boolean checkBankingProductForCurrency(String productId, String currencyId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "checkBankingProductForCurrency"));
			}
			
			Long count = entityManager.createNamedQuery("BankingProduct.countProductsByCurrency", Long.class).setParameter("productId", productId)
					.setParameter("currencyId", currencyId).getSingleResult();
			return count > 0;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.013"), ex);
			throw new BusinessException(6900066, "No se pudo obtener las monedas por producto bancario");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "checkBankingProductForCurrency"));
			}
		}
	}

	/**
	 * This method manage the currencies related to the banking product also
	 * manage the policies of them, and handle the information inherited
	 * 
	 * @param bankingProductId
	 *            <tt>BankingProduct</tt> identifier
	 * @param currencies
	 *            the list of <tt>CurrencyProduct</tt> to handle
	 */
	public void manageCurrenciesByBankingProduct(String bankingProductId, ArrayList<CurrencyProduct> currencies) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "manageCurrenciesByBankingProduct"));
			}

			manageCurrenciesByBankingProduct(bankingProductId, bankingProductId, currencies);
			entityManager.flush();
		} catch (BusinessException be) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.008", bankingProductId), be);
			throw be;
		} catch (EntityExistsException eee) {
			eee.printStackTrace();
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.014", bankingProductId), eee);
			throw new BusinessException(6900067, "No se pudo asociar la moneda para el producto bancario seleccionado");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("NODEPRODUCTMANAGER.099"), ex);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "manageCurrenciesByBankingProduct"));
			}
		}
	}

	private void manageCurrenciesByBankingProduct(String productInheritedFromId, String bankingProductId, List<CurrencyProduct> currencies) {
		if(logger.isDebugEnabled()){
			logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "manageCurrenciesByBankingProduct"));
		}
		
		BankingProduct bp = getBankingProductById(bankingProductId);
		// Load the currencies catalogs
		List<Catalog> currenciesList = catalogManager.getAllCurrencies();

		if (bp.getDelete().equals(Constants.NO)) {
			// Apply the changes to the currencies
			for (CurrencyProduct cp : currencies) {
				// Managed CurrencyProduct for policies operations
				CurrencyProduct cpm = null;
				// Set the product id to the current product identifier child
				cp.getId().setProductId(bankingProductId);
				// if the currencies exist in the database
				int index = bp.getCurrencyProducts().indexOf(cp);
				logger.logDebug("Index:" + index);
				// Delete currencies
				if (cp.getOperation().equals(Constants.DELETE_OPERATION) && index != -1) {
					List<AmountItemValue> amountItemValueList = entityManager
							.createNamedQuery("AmountItemValue.findByCurrency", AmountItemValue.class)
							.setParameter("currencyId", cp.getId().getCurrencyId()).setParameter("productId", cp.getId().getProductId())
							.getResultList();
					if (amountItemValueList.size() > 0) {
						// Get currency description
						Catalog currencyCatalog = CatalogUtils.getFromCatalogList(currenciesList, cp.getId().getCurrencyId());
						logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.030", cp));
						throw new BusinessException(6900214, "No se pudo deshabilitar la moneda " + currencyCatalog.getName()
								+ " para el producto bancario \"" + bp.getName() + "\", puesto que tiene información relacionada en rubros.");
					}
					bp.getCurrencyProducts().get(index).setStatus(Constants.NO);
					// Clean the policies
					for (PolicyProduct pp : bp.getCurrencyProducts().get(index).getPolicyProducts()) {
						entityManager.remove(pp);
					}
					continue;
				}
				// If new currency found
				if ((cp.getOperation().equals(Constants.INSERT_OPERATION) || cp.getOperation().equals(Constants.UPDATE_OPERATION)) && index != -1
						&& bp.getCurrencyProducts().get(index).getStatus().equals(Constants.NO)) {
					bp.getCurrencyProducts().get(index).setStatus(Constants.YES);
				}
				if (cp.getOperation().equals(Constants.INSERT_OPERATION) && index == -1) {
					if(logger.isDebugEnabled()){
						logger.logDebug("INSERT CURRENCY");
					}
					
					CurrencyProduct cpNew = new CurrencyProduct();
					cpNew.setId(new CurrencyProductId(cp.getId().getCurrencyId(), bankingProductId));
					cpNew.setStatus(Constants.YES);
					cpNew.setInheritedFrom(productInheritedFromId);
					cpNew.setPolicyProducts(new ArrayList<PolicyProduct>());
					entityManager.persist(cpNew);
					entityManager.flush();
					// bp.getCurrencyProducts().add(cpNew);
					cpm = cpNew;
				} else {
					if(logger.isDebugEnabled()){
						logger.logDebug("UPDATE CURRENCY");
					}
					cpm = entityManager.find(CurrencyProduct.class, new CurrencyProductId(cp.getId().getCurrencyId(), bankingProductId));
				}
				// find the CurrencyProduct
				/*
				 * fschnabel comento por que no le veo utilidad si funca borro
				 * if (cpm == null) {
				 * 
				 * logger.logDebug(
				 * "Moneda encontrada para realizar actuarlizacion: " + cpm); }
				 * if (cpm == null) {
				 * logger.logDebug("Creando nueva moneda para producto: " +
				 * bankingProductId + " moneda: " + cp.getId().getCurrencyId());
				 * CurrencyProduct cpNew = new CurrencyProduct();
				 * cpNew.setId(new CurrencyProductId(cp.getId()
				 * .getCurrencyId(), bankingProductId));
				 * cpNew.setStatus(Constants.YES); cpNew.setPolicyProducts(new
				 * ArrayList<PolicyProduct>());
				 * cpNew.setInheritedFrom(productInheritedFromId);
				 * //entityManager.persist(cpNew);
				 * bp.getCurrencyProducts().add(cpNew); cpm = cpNew; }
				 */

				// Check the policies
				for (PolicyProduct pp : cp.getPolicyProducts()) {
					// Set the product id to the current product identifier
					// child
					pp.setProductId(bankingProductId);
					// Get the managed CurrencyProdut to policies operations
					// find the policy in the database
					index = cpm.getPolicyProducts().indexOf(pp);
					// Persist the policy if not exist in the database
					if (pp.getOperation().equals(Constants.INSERT_OPERATION) && index == -1) {
						PolicyProduct ppNew = new PolicyProduct(pp.getProductId(), pp.getCurrencyId(), pp.getPolicyId());

						ppNew.setName(pp.getName());
						ppNew.setInheritedFrom(productInheritedFromId);
						ppNew.setCurrencyProduct(cpm);
						cpm.getPolicyProducts().add(ppNew);
						// Delete if exist in the database
					} else if (pp.getOperation().equals(Constants.DELETE_OPERATION) && index != -1) {
						entityManager.remove(cpm.getPolicyProducts().get(index));
					}
				}
				entityManager.merge(cpm);

			}
		}
		// Apply the changes recursively to the children banking products
		for (BankingProduct bpChildren : bp.getChildrenProducts()) {
			if (bpChildren.getNodeTypeCategory().getNodeTypeProduct().getId() == Constants.FINAL_NODE_TYPE_PRODUCT_ID
					&& bpChildren.getAuthorization().equals(Constants.YES))
				continue;
			else
				manageCurrenciesByBankingProduct(productInheritedFromId, bpChildren.getId(), currencies);
		}
		
		if(logger.isDebugEnabled()){
			logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "manageCurrenciesByBankingProduct"));
		}
	}

	/**
	 * This method crates the historic information related with a banking
	 * product
	 * 
	 * @param bankingProductId
	 *            <tt>BankingProduct</tt> identifier
	 */
	public Long createBankingProductHistory(BankingProductHistory bankingProductHistory, String authorizationOperation) {
		BankingProductHistory bph = new BankingProductHistory();

		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "createBankingProductHistory"));
			}

			// System Date
			// Get the process date for the context
			Date processDate = new SimpleDateFormat("MM/dd/yyyy").parse(ContextManager.getContext().getProcessDate());

			BankingProduct bp = getBankingProductById(bankingProductHistory.getProductId());

			CobisContext context = (CobisContext) ContextManager.getContext();
			// Create the history of banking product
			bph.setProductId(bp.getId());
			bph.setSystemDateId(bankingProductHistory.getSystemDateId());
			bph.setProcessDate(processDate);
			bph.setName(bp.getName());
			bph.setDescription(bp.getDescription());
			bph.setAvailable(bp.getAvailable());
			bph.setStartDate(bp.getStartDate());
			bph.setExpirationDate(bp.getExpirationDate());
			bph.setSubstantiation(bp.getSubstantiation());
			// Set the authorization information
			bph.setAuthorizationHistory(new AuthorizationHistory());
			bph.getAuthorizationHistory().setAuthorizationTerminal(context.getSession().getTerminal());
			bph.getAuthorizationHistory().setAuthorizationUserName(context.getSession().getUser());
			bph.getAuthorizationHistory().setBankingProductHistory(bph);
			bph.getAuthorizationHistory().setProcessId(bp.getAuthorization().getProcessId());
			bph.getAuthorizationHistory().setRequestTerminal(bp.getAuthorization().getTerminal());
			bph.getAuthorizationHistory().setRequestUserName(bp.getAuthorization().getUserName());
			bph.getAuthorizationHistory().setStatus(authorizationOperation);
			entityManager.persist(bph);

			// Create the history for the processes
			for (ProductProcess process : bp.getProcesses()) {
				ProductProcessHistory pph = new ProductProcessHistory();
				pph.setBankingProductHistory(bph);
				pph.setFlowId(process.getFlowId());
				pph.setProcessId(process.getProcessId());
				pph.setGeneric(process.getGeneric());
				pph.setIsNotGeneric(process.getIsNotGeneric());
				pph.setCreditLine(process.getCreditLine());

				pph.setProcessByProductId(process.getProcessByProductId());

				pph.setProcessDate(processDate);
				pph.setProcessName(process.getProcessName());

				entityManager.persist(pph);
			}

			// Create the history for the rules
			for (ProductRule rule : bp.getRules()) {
				ProductRuleHistory prh = new ProductRuleHistory();
				prh.setBankingProductHistory(bph);
				prh.setRuleId(rule.getRuleId());
				prh.setRuleName(rule.getRuleName());
				prh.setRulesByProductId(rule.getRulesByProductId());

				prh.setProcessDate(processDate);

				entityManager.persist(prh);
			}
			// Create the history of the currencies
			for (CurrencyProduct cp : bp.getCurrencyProducts()) {
				if (entityManager.contains(cp)) {// If is managed
					CurrencyProductHistory cph = new CurrencyProductHistory();
					cph.setBankingProductHistory(bph);
					cph.setCurrencyId(cp.getId().getCurrencyId());
					cph.setProcessDate(processDate);
					cph.setStatus(cp.getStatus());
					cph.setInheritedFrom(cp.getInheritedFrom());
					entityManager.persist(cph);
					if (null == cp.getPolicyProducts())
						continue;
					// Create the history for the policies
					for (PolicyProduct pp : cp.getPolicyProducts()) {
						if (entityManager.contains(pp)) {
							PolicyProductHistory pph = new PolicyProductHistory();
							pph.setCurrencyProduct(cph);
							pph.setPolicyId(pp.getPolicyId());
							pph.setProcessDate(processDate);
							pph.setInheritedFrom(pp.getInheritedFrom());
							pph.setPolicyName(pp.getName());
							entityManager.persist(pph);
						}
					}
				}
			}
			entityManager.flush();
			return bph.getId();

		} catch (BusinessException be) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.007", bankingProductHistory.getProductId()));
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.015", bph), ex);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "createBankingProductHistory"));
			}
		}

	}

	/**
	 * This method find all the currencies and policies related to a given
	 * <tt>BankingProduct</tt>
	 * 
	 * @param productId
	 *            <tt>BankingProduct</tt> identifier
	 * @return a list with all the currencies found
	 */
	public List<CurrencyProduct> findAllCurrenciesAndPoliciesByProduct(String productId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "findAllCurrenciesAndPoliciesByProduct"));
			}
			
			// Find all the currencies with status S and the name of the product
			// which was inherited
			List<CurrencyProduct> currencies = entityManager.createNamedQuery("CurrencyProduct.findByProductInherited", CurrencyProduct.class)
					.setParameter("productId", productId).getResultList();
			for (CurrencyProduct cp : currencies) {
				// Find the policies by currencies with the name of the product
				// which was inherited
				cp.setPolicyProducts(entityManager.createNamedQuery("PolicyProduct.findAllByCurrencyId", PolicyProduct.class)
						.setParameter("productId", productId).setParameter("currencyId", cp.getId().getCurrencyId()).getResultList());
			}
			return currencies;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.016", productId), ex);
			throw new BusinessException(6900069, "No se pudo obtener las monedas y políticas para el producto bancario seleccionado");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "findAllCurrenciesAndPoliciesByProduct"));
			}
		}
	}

	/**
	 * This method allow to set a banking product available to sale
	 * 
	 * @param bankingProductId
	 *            The <tt>BankingProduct</tt> identifier
	 * @param isAvailable
	 *            A string that indicate if a is or not available to sale
	 */
	public void changeBankingProductAvailableToSale(String bankingProductId, String isAvailable) {
		try {
			if(logger.isDebugEnabled()){
				// log the method entry
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "changeBankingProductAvailableToSale"));
			}
			
			// Find the entity give the identifier
			BankingProduct bp = getBankingProductById(bankingProductId);
			bp.setAvailable(isAvailable);
			// Send the changes to database
			entityManager.flush();

		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.018", bankingProductId), ex);
			throw new BusinessException(6900070, "No se pudo establecer el producto bancario seleccionado como disponible a la venta");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "changeBankingProductAvailableToSale"));
			}
		}
	}

	/**
	 * Get the sector associated to the banking product
	 * 
	 * @param productId
	 *            <tt>BankingProduct</tt> identifier
	 * @return Sector business object found
	 */
	public Sector getBankingProductSector(String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				// log the method entry
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getBankingProductSector"));
			}
			
			// find the banking product
			BankingProduct bp = getBankingProductById(bankingProductId);
			if (bp.getNodeTypeCategory().getNodeTypeProduct().getId() != Constants.FINAL_NODE_TYPE_PRODUCT_ID) {
				logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.020", bankingProductId));
				throw new BusinessException(6900141, "El producto bancario indicado no posee sector puesto que no es un producto final");
			}
			// Get the category associated to the sector
			NodeTypeCategory category = nodeProductService.getNodeCateogyById(bp.getSectorId());
			// Return the sector object, the category mnemonic represents the
			// sector code
			return new Sector(category.getMnemonic(), category.getName());
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.019", bankingProductId), ex);
			throw new BusinessException(6900139, "Ocurrio un error al obtener el sector del producto bancario");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getBankingProductSector"));
			}
		}
	}

	/**
	 * Get the sector description associated to the banking product
	 * 
	 * @param bankingProductId
	 *            <tt>BankingProduct</tt> identifier
	 * @param sectorId
	 *            Sector Id
	 * @return Sector Description found
	 */
	public String getBankingProductSectorDescription(String bankingProductId, String sectorMnemonic) {
		try {
			if(logger.isDebugEnabled()){
				// log the method entry
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getBankingProductSectorDescription"));
			}
			
			// find the banking product
			BankingProduct bp = getBankingProductById(bankingProductId);
			if (bp.getNodeTypeCategory().getNodeTypeProduct().getId() != Constants.FINAL_NODE_TYPE_PRODUCT_ID) {
				logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.020", bankingProductId));
				throw new BusinessException(6900141, "El producto bancario indicado no posee sector puesto que no es un producto final");
			}
			// Get the category associated to the sector
			NodeTypeCategory category = nodeProductService.getNodeCateogyById(bp.getSectorId());
			// Return the sector description
			if (category.getMnemonic().equals(sectorMnemonic))
				return category.getName();
			else
				return null;
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.019", bankingProductId), ex);
			throw new BusinessException(6900139, "Ocurrio un error al obtener el sector del producto bancario");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getBankingProductSectorDescription"));
			}
		}
	}

	/**
	 * This method get the process related to product
	 * 
	 * @param productId
	 *            the code of the banking product
	 * @return List<ProductProcess>
	 */
	public List<ProductProcess> getProcessByProduct(String productId) {

		try {
			if(logger.isDebugEnabled()){
				// log the method entry
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getProcessByProduct"));

				logger.logDebug(MessageManager.getString(
						"getProcessByProductTest",
						entityManager.createNamedQuery("BankingProduct.findBankingProduct", BankingProduct.class)
						.setParameter("bankingProductId", productId).getResultList().get(0).getProcesses()));
			}

			return entityManager.createNamedQuery("BankingProduct.findBankingProduct", BankingProduct.class)
					.setParameter("bankingProductId", productId).getResultList().get(0).getProcesses();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099"), ex);
			throw new BusinessException(6900170, "Ocurrio un error al obtener los procesos del producto.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getProcessByProduct"));
			}
		}

	}

	/**
	 * This method get the rules related to product
	 * 
	 * @param productId
	 *            the code of the banking product
	 * @return List<ProductProcess>
	 */
	public List<ProductRule> getRulesByProduct(String productId) {

		try {
			if(logger.isDebugEnabled()){
				// log the method entry
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getRulesByProduct"));

				logger.logDebug(MessageManager.getString(
						"getRulesByProductTest",
						entityManager.createNamedQuery("BankingProduct.findBankingProduct", BankingProduct.class)
						.setParameter("bankingProductId", productId).getResultList().get(0).getProcesses()));
			}

			return entityManager.createNamedQuery("BankingProduct.findBankingProduct", BankingProduct.class)
					.setParameter("bankingProductId", productId).getResultList().get(0).getRules();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099"), ex);
			throw new BusinessException(6900170, "Ocurrio un error al obtener las reglas de segmentación del producto.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getRulesByProduct"));
			}
		}

	}

	/**
	 * Get the list of process related to the module of the given product
	 * 
	 * @param productId
	 *            <tt>BankingProduct</tt> identifier
	 * @return list of Process catalog codes
	 */
	public List<String> getRelatedProcessByProduct(String productId) {
		try {
			if(logger.isDebugEnabled()){
				// log the method entry
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getRelatedProcessByProduct"));
			}
			
			
			// find the category associated to the module
			NodeTypeCategory category = getCategoryKeepDictionaryFromParents(productId);
			// if the module is null throw a exception
			if (null == category || null == category.getModule())
				throw new BusinessException(6900143, "No se pudo obtener el módulo asociado al producto bancario.");
			
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.021", category.getModule().getName(), category.getModule().getProcess()));
			}
			// return the process list of the module
			return category.getModule().getProcess();
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			throw new BusinessException(6900144, "No se pudo obtener la lista de procesos asociados al producto bancario.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getRelatedProcessByProduct"));
			}
		}
	}

	/**
	 * Get the changes made in the banking product information
	 * 
	 * @param productId
	 *            <tt>BankingProduct</tt> identifier
	 * @return Map with two keys for the before and after changes
	 */
	public Map<String, BankingProductLog> getChanges(String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				// log the method entry
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getChanges"));
			}

			// Create the map for the changes
			Map<String, BankingProductLog> changes = new HashMap<String, BankingProductLog>();
			
			if(logger.isDebugEnabled()){
				logger.logDebug("Obteniendo catalogos de procesos");
			}
			
			// Load the process catalogs
			List<Catalog> processCatalogs = catalogManager.getCatalogsByName(Constants.CATALOGS.PRODUCT_PROCESS);
			
			if(logger.isDebugEnabled()){
				// Load the currencies
				logger.logDebug("Obteniendo catalogo de monedas");
			}
			
			List<Catalog> currencies = catalogManager.getAllCurrencies();
			// get the after banking product
			BankingProduct bp = getBankingProductById(bankingProductId);
			
			if(logger.isDebugEnabled()){
				logger.logDebug("Se obtiene producto bancario actual: " + bp);
			}
			
			// Create the after products changes BO
			BankingProductLog bpAfter = new BankingProductLog(bp.getName(), bp.getDescription(), bp.getAvailable().equals(Constants.YES),
					bp.getStartDate(), bp.getExpirationDate(), bp.getSubstantiation());
			bpAfter.setProcesses(new ArrayList<ProductProcessLog>());
			bpAfter.setRules(new ArrayList<ProductRuleLog>());
			bpAfter.setCurrencies(new ArrayList<CurrencyProductLog>());
			
			if(logger.isDebugEnabled()){
				logger.logDebug("Se crea objeto log para producto actual: " + bpAfter);
			}
			// Set the process if exist
			if (null != bp.getProcesses() && !bp.getProcesses().isEmpty()) {
				for (final ProductProcess pp : bp.getProcesses()) {
					// Get the name for the process in the catalog list
					Catalog processCatalog = CatalogUtils.getFromCatalogList(processCatalogs, pp.getProcessId());
					// Create the product process after object
					bpAfter.getProcesses().add(
							new ProductProcessLog(processCatalog == null ? "" : processCatalog.getName(), pp.getProcessName(),
									pp.getGeneric() == null ? false : pp.getGeneric().equals(Constants.YES), pp.getIsNotGeneric() == null ? false
											: pp.getIsNotGeneric().equals(Constants.YES), pp.getCreditLine() == null ? false : pp.getCreditLine()
													.equals(Constants.YES)));
				}
				if(logger.isDebugEnabled()){
					logger.logDebug("Se crea lista de procesos" + bpAfter.getProcesses());
				}
			}

			// Set the rules if exist
			if (null != bp.getRules() && !bp.getRules().isEmpty()) {
				for (final ProductRule pr : bp.getRules()) {
					// Create the product rule after object
					bpAfter.getRules().add(new ProductRuleLog(pr.getRuleId(), pr.getRuleName()));
				}
				
				if(logger.isDebugEnabled()){
					logger.logDebug("Se crea lista de reglas" + bpAfter.getRules());
				}
			}

			// Set the currencies and policies if exist
			List<CurrencyProduct> productCurrencies = findAllCurrenciesAndPoliciesByProduct(bankingProductId);
			if (currencies != null && !currencies.isEmpty()) {
				// For each currency
				for (final CurrencyProduct cp : productCurrencies) {
					// Search the currency name
					Catalog currencyCatalog = CatalogUtils.getFromCatalogList(currencies, cp.getId().getCurrencyId());
					// Create the after currency
					CurrencyProductLog cpLog = new CurrencyProductLog(currencyCatalog.getName());
					cpLog.setPolicies(new ArrayList<String>());
					// For each policy
					for (PolicyProduct policy : cp.getPolicyProducts()) {
						// Add the policy name
						cpLog.getPolicies().add(policy.getName());
					}
					// Add the currency to the banking product list
					bpAfter.getCurrencies().add(cpLog);
				}
				
				if(logger.isDebugEnabled()){
					logger.logDebug("Se crea la lista de monedas " + bpAfter.getCurrencies());
				}
			}
			// Add the after banking product to the Map
			changes.put(Constants.AFTER_VALUE, bpAfter);

			// Get the latest historical
			BankingProductHistory bph = getLatestHistorical(bankingProductId);
			// If there is not historical
			if (bph == null) {
				changes.put(Constants.BEFORE_VALUE, null);
				return changes;
			}
			// Create the before banking product log
			BankingProductLog bpBefore = buildHistoricalLog(bph, currencies, processCatalogs);
			// Add the before banking product to the Map
			changes.put(Constants.BEFORE_VALUE, bpBefore);
			return changes;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099", bankingProductId), ex);
			throw new BusinessException(6900146, "Ocurrio un error al obtener los cambios de un producto bancario.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getChanges"));
			}
		}
	}

	/**
	 * Get the latest history entry for the banking product information
	 * 
	 * @return BankingProductHistory latest <tt>BankingProductHistory</tt> if
	 *         one was founded otherwise null
	 */
	public BankingProductHistory getLatestHistorical(String bankingProductId) {
		if(logger.isDebugEnabled()){
			// log the method entry
			logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getLatestHistorical"));
		}
		// Get the actual values
		List<BankingProductHistory> bphList = entityManager.createNamedQuery("BankingProductHistory.FindLatest", BankingProductHistory.class)
				.setParameter("productId", bankingProductId).getResultList();
		// If not exist history
		if (bphList.isEmpty()) {
			logger.logError("No existe historico para el producto bancario " + bankingProductId);
			return null;
		}
		// If there is more that one result error
		if (bphList.size() > 1) {
			logger.logError("Ocurrio un error se obtuvo mas de un último registro historico");
			throw new IllegalStateException();
		}
		
		if(logger.isDebugEnabled()){
			logger.logDebug("Producto historico " + bphList.get(0));
			// log the method entry
			logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getLatestHistorical"));
		}
		
		return bphList.get(0);

	}

	/**
	 * Find a <tt>BankingProduct</tt> given the identifier
	 * 
	 * @param bankingProductId
	 *            <tt>BankingProduct</tt> identifier
	 * @return an <tt>BankingProduct</tt> entity
	 */
	public BankingProduct getBankingProductById(String bankingProductId) {
		// Find the entity give the identifier
		BankingProduct bp = entityManager.find(BankingProduct.class, bankingProductId);
		// If it was not found throw a exception
		if (null == bp) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.007", bankingProductId));
			throw new BusinessException(6900060, "No se pudo obtener el producto bancario indicado, puesto que no existe");
		}else{
			if(logger.isDebugEnabled()){
				logger.logDebug("BankingProduct --> "+ bp.toString());
			}
		}
		
		return bp;
	}

	/**
	 * Construct the object that contains the log information of a historical
	 * banking product
	 * 
	 * @param bph
	 *            <tt>BankingProductHistory</tt> entity
	 * @return <tt>BankingProductLog</tt> instance
	 */
	private BankingProductLog buildHistoricalLog(BankingProductHistory bph, List<Catalog> currencies, List<Catalog> processCatalogs) {
		// Create the before banking product log
		BankingProductLog bpLog = new BankingProductLog(bph.getName(), bph.getDescription(), bph.getAvailable().equals(Constants.YES),
				bph.getStartDate(), bph.getExpirationDate(), bph.getSubstantiation());
		bpLog.setProcesses(new ArrayList<ProductProcessLog>());
		bpLog.setRules(new ArrayList<ProductRuleLog>());
		bpLog.setCurrencies(new ArrayList<CurrencyProductLog>());
		
		if(logger.isDebugEnabled()){
			logger.logDebug("Se crea objeto log para before " + bpLog);
		}
		
		// Set the process if exist
		if (null != bph.getProcessHistories() && !bph.getProcessHistories().isEmpty()) {
			for (final ProductProcessHistory pp : bph.getProcessHistories()) {
				// Get the name for the process in the catalog list
				Catalog processCatalog = CatalogUtils.getFromCatalogList(processCatalogs, pp.getProcessId());
				// Create the product process after object
				bpLog.getProcesses().add(
						new ProductProcessLog(processCatalog == null ? "" : processCatalog.getName(), pp.getProcessName(),
								pp.getGeneric() == null ? false : pp.getGeneric().equals(Constants.YES), pp.getIsNotGeneric() == null ? false : pp
										.getIsNotGeneric().equals(Constants.YES), pp.getCreditLine() == null ? false : pp.getCreditLine().equals(
												Constants.YES)));
			}
			
			if(logger.isDebugEnabled()){
				logger.logDebug("Se crea lista de procesos" + bpLog.getProcesses());
			}
		}

		// Set the rules if exist
		if (null != bph.getRulesHistories() && !bph.getRulesHistories().isEmpty()) {
			for (final ProductRuleHistory pr : bph.getRulesHistories()) {

				bpLog.getRules().add(new ProductRuleLog(pr.getRuleId(), pr.getRuleName()));
			}
			
			if(logger.isDebugEnabled()){
				logger.logDebug("Se crea lista de reglas" + bpLog.getRules());
			}
		}

		// Set the currencies if exist
		if (bph.getCurrencyProductsHistory() != null && !bph.getCurrencyProductsHistory().isEmpty()) {
			// For each currency
			for (final CurrencyProductHistory cp : bph.getCurrencyProductsHistory()) {
				// Only get the available currencies
				if (cp.getStatus().equals(Constants.NO)) {
					continue;
				}
				// Search the currency name
				Catalog currencyCatalog = CatalogUtils.getFromCatalogList(currencies, cp.getCurrencyId());
				// Create the after currency
				CurrencyProductLog cpLog = new CurrencyProductLog(currencyCatalog == null ? "" : currencyCatalog.getName());
				cpLog.setPolicies(new ArrayList<String>());
				// For each policy
				for (PolicyProductHistory policy : cp.getPoliciesProducts()) {
					// Add the policy name
					cpLog.getPolicies().add(policy.getPolicyName());
				}
				// Add the currency to the banking product list
				bpLog.getCurrencies().add(cpLog);
			}
			
			if(logger.isDebugEnabled()){
				logger.logDebug("Se crea la lista de monedas " + bpLog.getCurrencies());
			}
		}
		return bpLog;
	}

	/**
	 * This method allow consult request authorization for specific banking
	 * product
	 * 
	 * @param bankingProductId
	 * @return
	 */
	public Boolean getRequestAuthorization(String bankingProductId) {

		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getRequestAuthorization"));
			}
			
			if (getBankingProductBasicInformationById(bankingProductId).getAuthorization().getStatus().trim().equals(Constants.YES)) {
				return true;
			} else {
				return false;
			}
		} catch (BusinessException be) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099", bankingProductId), be);
			throw be;

		} catch (Exception e) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099", bankingProductId), e);
			throw new BusinessException(6900061, "No se pudo obtener el producto bancario.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getRequestAuthorization"));
			}
		}
	}

	/**
	 * This method allow indicate that is has requested authorization
	 * 
	 * @param bankingProductId
	 * @param requestAuthorization
	 */
	public void changeRequestAuthorization(String bankingProductId, Boolean requestAuthorization) {

		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "changeRequestAuthorization"));
			}

			BankingProduct bankingProduct = entityManager.find(BankingProduct.class, bankingProductId);
			if (bankingProduct.getAuthorization() == null) {
				bankingProduct.setAuthorization(new Authorization());
				bankingProduct.getAuthorization().setBankingProduct(bankingProduct);
			}
			if (requestAuthorization) {
				bankingProduct.getAuthorization().setStatus(Constants.YES);
				CobisContext context = (CobisContext) ContextManager.getContext();
				bankingProduct.getAuthorization().setUserName(context.getSession().getUser());
				bankingProduct.getAuthorization().setTerminal(context.getSession().getTerminal());
			} else {
				bankingProduct.getAuthorization().setStatus(Constants.NO);
			}
			entityManager.flush();

		} catch (BusinessException be) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099", bankingProductId), be);
			throw be;

		} catch (Exception e) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099", bankingProductId), e);
			throw new BusinessException(6900062, "No se pudo actualizar la información del producto bancario seleccionado.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "changeRequestAuthorization"));
			}
		}
	}

	/**
	 * Change processId associated to banking product
	 * 
	 * @param bankingProductId
	 * @param processId
	 */
	public void changeProcessId(String bankingProductId, String processId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "changeProcessId"));
			}

			BankingProduct bankingProduct = entityManager.find(BankingProduct.class, bankingProductId);
			if (bankingProduct.getAuthorization() == null) {
				bankingProduct.setAuthorization(new Authorization());
				bankingProduct.getAuthorization().setBankingProduct(bankingProduct);
			}
			bankingProduct.getAuthorization().setProcessId(processId);
			entityManager.flush();

		} catch (BusinessException be) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099", bankingProductId), be);
			throw be;

		} catch (Exception e) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099", bankingProductId), e);
			throw new BusinessException(6900062, "No se pudo actualizar la información del producto bancario seleccionado.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "changeProcessId"));
			}
		}

	}

	/**
	 * Get the latest history entry for the banking product information
	 * 
	 * @return BankingProductHistory latest <tt>BankingProductHistory</tt> if
	 *         one was founded otherwise null
	 */
	public BankingProductHistory getAllLatestHistorical(String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getAllLatestHistorical"));
			}
			// Get the actual values
			List<BankingProductHistory> bphList = entityManager.createNamedQuery("BankingProductHistory.FindAllLatest", BankingProductHistory.class)
					.setParameter("productId", bankingProductId).getResultList();
			// If not exist history
			if (bphList.isEmpty()) {
				logger.logError("No existe historico para el producto bancario " + bankingProductId);
				return null;
			}
			// If there is more that one result error
			if (bphList.size() > 1) {
				logger.logError("Ocurrio un error se obtuvo mas de un último registro historico");
				throw new IllegalStateException();
			}
			return bphList.get(0);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.013"), ex);
			throw new BusinessException(6900066, "No se pudo obtener las monedas por producto bancario");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getAllLatestHistorical"));
			}
		}

	}

	/**
	 * Check the minimum configuration of a Currency to the banking product may
	 * be available for sale
	 * 
	 * @param productId
	 *            <tt>BankingProduct</tt> identifier
	 * @return True if exist a Currency for the selected banking product - False
	 *         otherwise
	 */
	public Boolean checkBankingProductCurrenciesConfiguration(String productId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "checkBankingProductCurrenciesConfiguration"));
			}
			
			int count = findAllCurrenciesAndPoliciesByProduct(productId).size();
			return count > 0;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.013"), ex);
			throw new BusinessException(6900066, "No se pudo obtener las monedas por producto bancario");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "checkBankingProductCurrenciesConfiguration"));
			}
		}
	}

	/**
	 * Check the minimum configuration of Accounting Profile to the banking
	 * product may be available for sale
	 * 
	 * @param productId
	 *            <tt>BankingProduct</tt> identifier
	 * @return True if exist an Accounting Profile for the selected banking
	 *         product - False otherwise
	 */
	private Boolean checkAccountingProfileConfiguration(String productId) {
		AccountingProfileId accProfileId = new AccountingProfileId();
		accProfileId.setProductId(productId);
		return accountingProfileService.findAllAccountingProfile(accProfileId).size() > 0;
	}

	/**
	 * Restore data from Historic
	 * 
	 * @param bankinProductId
	 */
	public void restoreFromHistory(String bankingProductId) {
		BankingProductHistory bankingProductHistory = new BankingProductHistory();
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "restoreFromHistory"));
			}

		/*	BankingProduct bpInitial = getBankingProductById(bankingProductId);
			bankingProductHistory = getAllLatestHistorical(bankingProductId);
			// Verified history, if don't exist return
			if (bankingProductHistory == null) {
				return;
			}
			// BankingProductHistoryId bankingProductHistoryId = new
			// BankingProductHistoryId(
			// bankingProductHistory.getSystemDateId(),
			// bankingProductHistory.getProductId());
			//
			entityManager.remove(bpInitial);
			entityManager.flush();
			entityManager.detach(bpInitial);
			// BankingProduct
			BankingProduct bp = new BankingProduct();
			bp.setId(bpInitial.getId());
			bp.setCompany(bpInitial.getCompany());
			bp.setNodeTypeCategory(bpInitial.getNodeTypeCategory());
			bp.setName(bankingProductHistory.getName());
			bp.setDescription(bankingProductHistory.getDescription());
			bp.setParentnode(bpInitial.getParentnode());
			bp.setAvailable(bpInitial.getAvailable());
			bp.setStartDate(bpInitial.getStartDate());
			bp.setExpirationDate(bpInitial.getExpirationDate());
			bp.setSubstantiation(bpInitial.getSubstantiation());
			bp.setSectorId(bpInitial.getSectorId());
			bp.setAuthorization(new Authorization());
			bp.getAuthorization().setBankingProduct(bp);
			bp.getAuthorization().setStatus(Constants.NO);
			bp.setDelete(Constants.NO);
			entityManager.persist(bp);

			// Currencies
			CurrencyProduct cp;
			for (CurrencyProductHistory cph : bankingProductHistory.getCurrencyProductsHistory()) {

				cp = new CurrencyProduct();
				cp.setId(new CurrencyProductId(cph.getCurrencyId(), cph.getBankingProductHistory().getProductId()));
				cp.setStatus(cph.getStatus());
				cp.setInheritedFrom(cph.getInheritedFrom());
				cp.setPolicyProducts(new ArrayList<PolicyProduct>());

				// Policies
				for (PolicyProductHistory pph : cph.getPoliciesProducts()) {
					PolicyProduct policy = new PolicyProduct();
					policy.setPolicyId(pph.getPolicyId());
					policy.setProductId(pph.getCurrencyProduct().getBankingProductHistory().getProductId());
					policy.setCurrencyId(pph.getCurrencyProduct().getCurrencyId());
					policy.setName(pph.getPolicyName());
					policy.setInheritedFrom(pph.getInheritedFrom());
					cp.getPolicyProducts().add(policy);
				}
				entityManager.persist(cp);
			}

			// GeneralParametersValues
			GeneralParametersValues gp;
			for (GeneralParametersValuesHistory gph : bankingProductHistory.getGeneralParametersValuesHistories()) {
				gp = new GeneralParametersValues(gph.getValue(), gph.getDictionaryFieldId(), gph.getBankingProductHistory().getProductId());
				gp.setInheritedFrom(gph.getInheritedFrom());
				gp.setRuleId(gph.getRuleId());
				gp.setRuleName(gph.getRuleName());
				entityManager.persist(gp);
			}

			// ProcessByProduct
			ProductProcess pp;
			for (ProductProcessHistory pph : bankingProductHistory.getProcessHistories()) {
				pp = new ProductProcess();
				pp.setBankingProduct(bp);
				pp.setFlowId(pph.getFlowId());
				pp.setProcessId(pph.getProcessId());
				pp.setGeneric(pph.getGeneric());
				pp.setIsNotGeneric(pph.getIsNotGeneric());
				pp.setProcessName(pph.getProcessName());
				pp.setCreditLine(pph.getCreditLine());
				entityManager.persist(pp);

			}

			// RulesByProduct
			ProductRule pr;
			for (ProductRuleHistory prh : bankingProductHistory.getRulesHistories()) {
				pr = new ProductRule();
				pr.setBankingProduct(bp);
				pr.setRuleId(prh.getRuleId());
				pr.setRuleName(prh.getRuleName());
				entityManager.persist(pr);

			}

			// AccountingProfile
			AccountingProfile ap;
			for (AccountingProfileHistory aph : bankingProductHistory.getAccountingProfileHistories()) {
				ap = new AccountingProfile(aph.getBankingProductHistory().getProductId(), aph.getTransactionTypeId(), aph.getFilialId(),
						aph.getProfileId());
				entityManager.persist(ap);
			}

			// ItemsByProduct
			ItemByProduct ip;
			for (ItemByProductHistory iph : bankingProductHistory.getItemByProductHistories()) {
				ItemByProductId ipId = new ItemByProductId(iph.getBankingProductHistory().getProductId(), iph.getItemIdentifier());
				ip = new ItemByProduct(ipId, iph.getItemType());
				ip.setItemsValuesList(new ArrayList<ItemsValues>());
				ip.setItemAppliesWaysList(new ArrayList<ItemAppliesWay>());
				ip.setItemStatus(new ArrayList<ItemStatus>());

				// ItemsValues
				for (ItemsValuesHistory ivh : iph.getItemsValuesHistories()) {
					ItemsValues iv = new ItemsValues(ivh.getDictionaryFieldId(), ivh.getItemByProductHistory().getBankingProductHistory()
							.getProductId(), ivh.getItemByProductHistory().getItemIdentifier(), ivh.getValue());
					ip.getItemsValuesList().add(iv);
				}

				// ItemAppliesWay
				for (ItemAppliesWayHistory iawh : iph.getItemAppliesWaysHistories()) {
					AppliesToWhenApplyId awaId = new AppliesToWhenApplyId(iawh.getAppliesTo(), iawh.getApplyNodeType());
					AppliesToWhenApply awa = new AppliesToWhenApply();
					awa.setAppliesToWhenApplyId(awaId);
					ItemAppliesWay iaw = new ItemAppliesWay();
					iaw.setItemsByProduct(ip);
					iaw.setAppliesToWhenApply(awa);
					iaw.setOnWhatPeriod(iawh.getOnWhatPeriod());
					iaw.setOnwhatperiodtype(iawh.getOnwhatperiodtype());
					iaw.setItemReference(iawh.getItemReference());
					iaw.setItemIncluded(iawh.getItemIncluded());
					iaw.setItemValuesList(new ArrayList<AmountItemValue>());

					// AmountItemValues
					for (AmountItemValueHistory aivh : iawh.getAmountItemValueHistory()) {
						CurrencyProductId cpId = new CurrencyProductId(aivh.getCurrencyId(), aivh.getItemAppliesWayHistory()
								.getItemByProductHistory().getBankingProductHistory().getProductId());
						AmountItemValueId avId = new AmountItemValueId(cpId, 0);
						AmountItemValue amountItemValue = new AmountItemValue(avId, aivh.getAllowReadJustment(), aivh.getBaseName(),
								aivh.getBaseReadJustment(), aivh.getBaseSign(), aivh.getBaseSignReadJustment(), aivh.getBusinessRule(),
								aivh.getBusinessRuleLimits(), aivh.getCurrencyCharge(), aivh.getFormReadJustment(), aivh.getMaximum(),
								aivh.getMaximumLimit(), aivh.getMaximumLimitType(), aivh.getMaximumLimitVar(), aivh.getMaximumReagJustment(),
								aivh.getMaximumSign(), aivh.getMaximumSignReadJustment(), aivh.getMinimum(), aivh.getMinimumLimit(),
								aivh.getMinimumLimitType(), aivh.getMinimumLimitVar(), aivh.getMinimumReadJustment(), aivh.getMinimumSign(),
								aivh.getMinimumSignReadJustment(), aivh.getPeriodReadJustment(), aivh.getPeriodTypeReadJustment(),
								aivh.getRangeType(), aivh.getRateReadJustment(), aivh.getValueReference(), aivh.getRateReference(),
								aivh.getReferenceRateReadJustment(), aivh.getTypeReadJustment(), aivh.getUseRange(), aivh.getPolicyId(),
								aivh.getPolicyName(), aivh.getSp());
						amountItemValue.setAppliesWay(iaw);
						iaw.getItemValuesList().add(amountItemValue);
					}
					ip.getItemAppliesWaysList().add(iaw);
				}
				entityManager.persist(ip);
			}

			// Checks for portfolio module
			// Find the category that define a module
			NodeTypeCategory category = getCategoryKeepDictionaryFromParents(bankingProductHistory.getProductId());
			if (category.getModule().getModuleId() == Modules.PORTFOLIO.getModuleId()) {
				// ItemStatus
				ItemStatus is;
				for (ItemStatusHistory ish : bankingProductHistory.getItemStatusHistories()) {
					is = new ItemStatus(ish.getBankingProductHistory().getProductId(), ish.getItemId(), ish.getStatusId(), ish.getStartdays(),
							ish.getFinishdays());
					entityManager.persist(is);
				}

				// OperationStatus
				OperationStatus os;
				for (OperationStatusHistory osh : bankingProductHistory.getOperationStatusHistories()) {
					os = new OperationStatus(osh.getBankingProductHistory().getProductId(), osh.getChangeType(), osh.getInitialStatusId(),
							osh.getFinalStatusId(), osh.getStartDays(), osh.getFinishDays());
					entityManager.persist(os);
				}
				// Economic destination
				economicDestinationService.restoreEconomicDestinationFromHistory(bankingProductHistory.getId());
				// Purpose
				// purposeManager.restorePurpose(bankingProductHistory.getId());
				economicActivityService.restoreEconomicActivity(bankingProductHistory.getId());
			}
			entityManager.flush();*/
			logger.logDebug("--->Se rechaza la autorizacion");
		} catch (Exception e) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.028", bankingProductId), e);
			throw new BusinessException(6900178, "No se pudo restaurar la informacion del producto bancario seleccionado desde los históricos");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "restoreFromHistory"));
			}
		}
	}

	/**
	 * Apply change when they were authorized
	 * 
	 * @param bankingProductId
	 */
	public void applyChange(String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "applyChange"));
			}
			
			// region Change status product
			BankingProductHistory bphistory = new BankingProductHistory();
			bphistory.setId(0);
			bphistory.setProductId(bankingProductId);
			bphistory.setSystemDateId(new Date());

			BankingProduct bp = getBankingProductById(bankingProductId);
			if (bp.getAuthorization().equals(Constants.NO)) {

				// Change state product available to S (Available to sale)
				bp.setAvailable(Constants.YES);
				createHistoryInApplyChange(bphistory, Constants.CATALOGS.AUTHORIZATION_STATUS_CATALOG.APRROVED);

			} else {
				createHistoryInApplyChange(bphistory, Constants.CATALOGS.AUTHORIZATION_STATUS_CATALOG.APRROVED);
				// Change state request authorization to N (Authorized)
				changeRequestAuthorization(bankingProductId, false);
			}
			entityManager.flush();
			// end-region
			// region Create history
			// end-region
		} catch (Exception e) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099"), e);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "applyChange"));
			}
		}
	}

	/**
	 * Create the historical log in cascade for the all related information of
	 * the banking product
	 * 
	 * @param bankingProductHistoryId
	 *            <tt>BankingProductHistory</tt>sequential identifier of
	 *            BankingProductHistory
	 * @param authorizationStatus
	 *            The code for the authorization operation A Approved, R
	 *            Rejected, C Canceled
	 */
	private void createHistoryInApplyChange(BankingProductHistory bankingProductHistoryId, String authorizationStatus) {

		//TODO:validar si se deben guardar históricos de tablas o históricos de pantallas renderizadas
		
		Long bankingProductId = createBankingProductHistory(bankingProductHistoryId, authorizationStatus);

		BankingProductHistory bankingHistory = new BankingProductHistory();
		bankingHistory.setId(bankingProductId);
		bankingHistory.setProductId(bankingProductHistoryId.getProductId());

		generalParametersService.createGenearalParametersHistory(bankingHistory, authorizationStatus);

		itemsService.createItemsHistory(bankingHistory, authorizationStatus);

		accountingProfileService.createAccountingProfileHistory(bankingHistory, authorizationStatus);
		
		// Find the category that define a module
		NodeTypeCategory category = getCategoryKeepDictionaryFromParents(bankingHistory.getProductId());

		// Checks for portfolio module
		if (category.getModule().getModuleId() == Modules.PORTFOLIO.getModuleId()) {

			itemStatusService.createItemStatusHistory(bankingHistory, authorizationStatus);

			operationStatusService.createOperationStatusHistory(bankingHistory, authorizationStatus);

			economicDestinationService.createEconomicDestinationHistory(bankingHistory, authorizationStatus);

			/*
			 * purposeManager.createPurposeHistory(bankingHistory,
			 * authorizationStatus);
			 */
			economicActivityService.createEconomicActivityHistory(bankingHistory, authorizationStatus);
			
			unitFunctionalityServices.createUnitFunctionalityValuesHistory(bankingHistory.getProductId(),authorizationStatus,bankingHistory.getId());
		}
	}

	/**
	 * Apply change when they were authorized, called by the BPM
	 * 
	 * @param parameters
	 *            parameters send by the BPM
	 */
	public void applyChangeTask(String processId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "applyChangeTask"));
				logger.logDebug("Aplicando cambios proceso asociado: " + processId);
			}
			
			String productId = entityManager.createNamedQuery("BankingProduct.findProductByProcess", String.class)
					.setParameter("processId", processId).getSingleResult();
			applyChange(productId);
		} catch (Exception e) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099"), e);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "applyChangeTask"));
			}
		}
	}

	/**
	 * Revert change when they were not authorized
	 * 
	 * @param bankingProductId
	 */
	public void denyChange(String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "denyChange"));
			}
			
			// Create a history for the reject product
			BankingProductHistory bphistory = new BankingProductHistory();
			bphistory.setSystemDateId(new Date());
			bphistory.setProductId(bankingProductId);

			createHistoryInApplyChange(bphistory, Constants.CATALOGS.AUTHORIZATION_STATUS_CATALOG.REJECT);
			changeProcessId(bankingProductId, "");
			// Change state request authorization to N (Authorized)
			changeRequestAuthorization(bankingProductId, false);
			// Restore information from historic structures
			restoreFromHistory(bankingProductId);
		} catch (Exception e) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099"), e);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "denyChange"));
			}
		}
	}

	/**
	 * Revert change when they were not authorized, call by the BPM
	 * 
	 * @param parameters
	 *            parameters send by the BPM
	 */
	public void denyChangeTask(String processId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "denyChangeTask"));
				logger.logDebug("Denegando cambios proceso asociado: " + processId);
			}
			
			String productId = entityManager.createNamedQuery("BankingProduct.findProductByProcess", String.class)
					.setParameter("processId", processId).getSingleResult();
			denyChange(productId);
		} catch (Exception e) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099"), e);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "denyChangeTask"));
			}
		}
	}

	/**
	 * Check the complete configuration for specific product banking
	 * 
	 * @param productId
	 *            <tt>BankingProduct</tt> identifier
	 * @return CheckBankingProductConfiguration object
	 */
	public CheckBankingProductConfiguration checkCompleteBankingProductConfiguration(String productId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "checkCompleteBankingProductConfiguration"));
			}

			CheckBankingProductConfiguration checkBankingProductConfiguration = new CheckBankingProductConfiguration();
			Map<String, Boolean> checkConfiguration = new HashMap<String, Boolean>();
			Map<String, String> checkFunctionalities = getCheckFunctionalities();

			// Check General Parameters
			if (Constants.YES.equals(checkFunctionalities.get("PAR_GEN") == null ? Constants.YES : checkFunctionalities.get("PAR_GEN").toUpperCase()
					.trim())) {
				checkConfiguration.put(Constants.REQUIRED_PG, generalParametersService.isBankingProductAvailable(productId));
			}

			// Check Currency and Policies
			if (Constants.YES.equals(checkFunctionalities.get("CURR_PROD") == null ? Constants.YES : checkFunctionalities.get("CURR_PROD")
					.toUpperCase().trim())) {
				checkConfiguration.put(Constants.CURRENCY_BY_PRODUCT, checkBankingProductCurrenciesConfiguration(productId));
			}

			// Check Items
			if (Constants.YES.equals(checkFunctionalities.get("ITEM_PROD") == null ? Constants.YES : checkFunctionalities.get("ITEM_PROD")
					.toUpperCase().trim())) {
				Map<String, Boolean> checkItems = itemsService.itemsIsAvailable(productId);
				checkConfiguration.put(Constants.REQUIRED_CONFIGURATION_ITEM, checkItems.get(Constants.REQUIRED_CONFIGURATION_ITEM));
				checkConfiguration.put(Constants.REQUIRED_CIO, checkItems.get(Constants.REQUIRED_CIO));
				checkConfiguration.put(Constants.REQUIRED_PI, checkItems.get(Constants.REQUIRED_PI));
				checkConfiguration.put(Constants.CURRENCY_BY_ITEMS, checkItems.get(Constants.CURRENCY_BY_ITEMS));
				checkConfiguration.put(Constants.REQUIRED_APPLICATION_WAY, checkItems.get(Constants.REQUIRED_APPLICATION_WAY));
				checkConfiguration.put(Constants.PERIOD_BY_ITEMS, checkItems.get(Constants.PERIOD_BY_ITEMS));
			}

			// Check Accounting Profiles
			if (Constants.YES.equals(checkFunctionalities.get("ACC_PROF") == null ? Constants.YES : checkFunctionalities.get("ACC_PROF")
					.toUpperCase().trim())) {
				checkConfiguration.put(Constants.REQUIRED_ACC_PROFILE, checkAccountingProfileConfiguration(productId));
			}

			// Checks for portfolio module
			// Find the category that define a module
			NodeTypeCategory category = getCategoryKeepDictionaryFromParents(productId);
			// The identifier of the portfolio module is 1
			if (category.getModule().getModuleId() == Modules.PORTFOLIO.getModuleId()) {

				// Check Operation Status
				if (Constants.YES.equals(checkFunctionalities.get("OPER_STAT") == null ? Constants.YES : checkFunctionalities.get("OPER_STAT")
						.toUpperCase().trim())) {

					OperationStatus operStatus = new OperationStatus();
					operStatus.setProductId(productId);
					checkConfiguration.put(Constants.REQUIRED_OPER_STATUS, operationStatusService.findOperationChangeStatus(operStatus).size() > 0);
				}

				// Check Destinations
				if (Constants.YES.equals(checkFunctionalities.get("ECO_DEST") == null ? Constants.YES : checkFunctionalities.get("ECO_DEST")
						.toUpperCase().trim())) {

					checkConfiguration.put(Constants.REQUIRED_DESTINATION,
							economicDestinationService.checkEconomicDestinationConfigurationComplete(productId));
				}

				// Check Economic Activity
				if (Constants.YES.equals(checkFunctionalities.get("PURP_ASO") == null ? Constants.YES : checkFunctionalities.get("PURP_ASO")
						.toUpperCase().trim())) {

					checkConfiguration
					.put(Constants.REQUIRED_ACTIVITY, economicActivityService.checkEconomicActivityConfigurationComplete(productId));
				}

				checkBankingProductConfiguration.setSuccess(!checkConfiguration.containsValue(false));

				if (!checkBankingProductConfiguration.isSuccess()) {
					checkBankingProductConfiguration.setConfiguration(checkConfiguration);
				}
			} else {
				checkBankingProductConfiguration.setSuccess(true);
			}
			return checkBankingProductConfiguration;
		} catch (Exception e) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099"), e);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "checkCompleteBankingProductConfiguration"));
			}
		}
	}

	/**
	 * Get all data for functionalities
	 * 
	 * @return
	 */
	private Map<String, String> getCheckFunctionalities() {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getCheckFunctionalities"));
			}

			Map<String, String> checkFunctionalities = new HashMap<String, String>();

			List<Functionality> functionalities = nodeProductService.getAllFunctionalities();

			for (Functionality functionality : functionalities) {
				checkFunctionalities.put(functionality.getId(), functionality.getCheck());
			}

			return checkFunctionalities;

		} catch (Exception e) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099"), e);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getCheckFunctionalities"));
			}
		}
	}

	/**
	 * Copy the Currencies and Policies from Parent.
	 * 
	 * @param bankingProductId
	 * @param currencies
	 */
	private void copyCurrenciesAndPoliciesFromParent(String bankingProductId, List<CurrencyProduct> currencies, String bankingProductParentId) {

		for (CurrencyProduct cp : currencies) {
			CurrencyProduct cpNew = new CurrencyProduct(bankingProductId, cp.getId().getCurrencyId(), cp.getInheritedFromName());
			cpNew.setStatus(cp.getStatus());
			cpNew.setInheritedFrom(cp.getInheritedFrom() == null ? bankingProductParentId : cp.getInheritedFrom());
			cpNew.setPolicyProducts(new ArrayList<PolicyProduct>());
			entityManager.persist(cpNew);

			// Policies
			for (PolicyProduct pp : cp.getPolicyProducts()) {
				PolicyProduct policy = new PolicyProduct();
				policy.setPolicyId(pp.getPolicyId());
				policy.setProductId(bankingProductId);
				policy.setCurrencyId(cp.getId().getCurrencyId());
				policy.setName(pp.getName());
				policy.setInheritedFrom(pp.getInheritedFrom() == null ? bankingProductParentId : pp.getInheritedFrom());
				entityManager.persist(policy);
			}
		}
	}

	/**
	 * Find all banking products childrens with authorization state available
	 * 
	 * @param bankingproductParentId
	 *            Banking product parent Id
	 * @return List of name banking product with authorization state available
	 */
	public List<String> findChildrensForAuthorizationState(String bankingproductParentId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "findChildrensForAuthorizationState"));
			}
			
			List<String> bankingProductName = new ArrayList<String>();
			List<String> namelist = findChildrensForAuthorizationStateOperation(bankingproductParentId, bankingProductName);
			return namelist;
		} catch (Exception e) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099"), e);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "findChildrensForAuthorizationState"));
			}
		}
	}

	private List<String> findChildrensForAuthorizationStateOperation(String bankingproductParentId, List<String> listName) {
		List<BankingProduct> bankingProductList = entityManager
				.createNamedQuery("BankingProduct.findAllBankingProductChildrenId", BankingProduct.class)
				.setParameter("bankingProductId", bankingproductParentId).getResultList();

		for (BankingProduct bankingProduct : bankingProductList) {

			if (bankingProduct.getNodeTypeCategory().getNodeTypeProduct().getId() == Constants.FINAL_NODE_TYPE_PRODUCT_ID) {

				if (bankingProduct.getAuthorization().getStatus().trim().equals(Constants.YES)) {
					listName.add(bankingProduct.getName());
				}
			} else {
				findChildrensForAuthorizationStateOperation(bankingProduct.getId(), listName);
			}
		}

		return listName;
	}

	@SuppressWarnings("unchecked")
	public String requestAuthorization(String productId, String processName) {

		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "requestAuthorization"));
			}

			CobisContext wCobisContext = (CobisContext) ContextManager.getContext();
			String sessionID = SessionCrypt.encriptSessionID(wCobisContext.getSession().getSessionId(), "", "");
			// Create the processDTO
			ProcessDTO processDTO = new ProcessDTO();
			processDTO.setBussinessInformationStringOne(productId);
			processDTO.setBussinessInformationStringTwo(wCobisContext.getSession().getUser());
			processDTO.setCobisUserName(wCobisContext.getSession().getUser());
			processDTO.setTemplateName(processName);
			processDTO.setRoutingType(Constants.CREATE_PROCESS_ROUTING_TYPE);
			// The service request
			ServiceRequestTO processApiRequestTO = new ServiceRequestTO();
			ServiceRequest header = new ServiceRequest();
			processApiRequestTO.setSessionId(sessionID);
			header.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionID);
			processApiRequestTO.addValue("inUserDTO", new UserDTO());
			processApiRequestTO.addValue("inProcessDTO", processDTO);
			processApiRequestTO.addValue(ServiceRequestTO.SERVICE_HEADER, header);
			processApiRequestTO.setServiceId(Constants.CREATE_PROCESS_INSTANCE_ID);
			header.addFieldInHeader(FILTER_FIELD, ICOBISTS.HEADER_STRING_TYPE, TRANSACTIONAL_FILTER_VALUE);
			header.addFieldInHeader("compositeService", ICOBISTS.HEADER_STRING_TYPE, "true");

			// Execute the service
			ServiceResponseTO response = serviceExecutor.execute(processApiRequestTO);
			// Check for errors
			if (!response.isSuccess()) {
				List<MessageTO> messages = response.getMessages();

				logger.logError("Error al crear la instancia del proceso" + " codigo de error " + messages.get(0).getCode() + " mensaje: "
						+ messages.get(0).getMessage());

				throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");
			}
			// Get the response object
			Map<String, String> processesResponse = (Map<String, String>) response.getValue("com.cobiscorp.cobis.cts.service.response.output");

			String processId = "";
			if (processesResponse.containsKey("@o_siguiente")) {
				processId = processesResponse.get("@o_siguiente");
				changeRequestAuthorization(productId, true);
				changeProcessId(productId, processId);
			}
			return processId;
		} catch (BusinessException be) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099", productId), be);
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099", productId), ex);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "requestAuthorization"));
			}
		}
	}

	public void deleteBankingProduct(String bankingproductId) {
		try {

			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "deleteBankingProduct"));
			}
			
			// Find a product with the given identifier
			BankingProduct bp = getBankingProductById(bankingproductId);
			// If is a product final don't delete only change a status to delete
			if (bp.getNodeTypeCategory().getNodeTypeProduct().getId() == Constants.FINAL_NODE_TYPE_PRODUCT_ID) {
				// Only can delete a final product if it is not available to
				// sale
				if (bp.getAvailable().equals(Constants.NO)) {
					// Verify if the product has historic
					long cant = entityManager.createNamedQuery("BankingProductHistory.countHistoricByProduct", long.class)
							.setParameter("productId", bankingproductId).getSingleResult();
					// If the product has historic throw a exception
					if (cant > 0) {
						throw new BusinessException(6900195, "No se puede eliminar el producto bancario porque contiene registros en historicos");
					}
					List<ItemByProduct> itemsList = bp.getItemByProducts();
					for (ItemByProduct itemByProduct : itemsList) {
						List<ItemAppliesWay> itemAppliesWayList = itemByProduct.getItemAppliesWaysList();
						for (ItemAppliesWay itemAppliesWay : itemAppliesWayList) {
							for (AmountItemValue amountItemValue : itemAppliesWay.getItemValuesList()) {
								if(logger.isDebugEnabled()){
									logger.logDebug("Eliminando amountItemValue " + amountItemValue.getAmountItemValuesId().toString());
								}
								entityManager.remove(amountItemValue);
							}
						}

					}
					entityManager.flush();
					bp = getBankingProductById(bankingproductId);

					// Update to state for delete
					entityManager.remove(bp);

				} else {// Can't delete a final product available to sale
					throw new BusinessException(6900196, "No se puede eliminar el producto bancario porque se encuentra a la venta.");
				}
			} else { // If not is a final product we can delete the product
				long childrenNumber = entityManager.createNamedQuery("BankingProduct.countChildrenProducts", Long.class)
						.setParameter("bankingProductId", bankingproductId).getSingleResult();
				// If the product has not product children remove
				if (childrenNumber == 0) {
					entityManager.remove(bp);
				} else { // else throw a exception
					throw new BusinessException(6900197, "No se puede eliminar el producto bancario puesto que tiene productos hijos asociados");
				}
			}
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.029", bankingproductId), ex);
			throw new BusinessException(6900001, "No se pudo eliminar el producto bancario");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "deleteBankingProduct"));
			}
		}
	}

	public String getBankingProductByProcessId(String processId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getBankingProductByProcessId"));
				logger.logDebug("Aplicando cambios proceso asociado: " + processId);
			}
			
			return entityManager.createNamedQuery("BankingProduct.findProductByProcess", String.class).setParameter("processId", processId)
					.getSingleResult();

		} catch (Exception e) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099"), e);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getBankingProductByProcessId"));
			}
		}
	}

	/**
	 * Revert change when they were not authorized
	 * 
	 * @param bankingProductId
	 */
	private void CancelChange(String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "denyChange"));
			}
			
			// Create a history for the reject product
			BankingProductHistory bphistory = new BankingProductHistory();
			bphistory.setSystemDateId(new Date());
			bphistory.setProductId(bankingProductId);
			entityManager.persist(bphistory);
			entityManager.flush();

			createHistoryInApplyChange(bphistory, Constants.CATALOGS.AUTHORIZATION_STATUS_CATALOG.CANCELED);
			// Restore information from historic structures
			changeRequestAuthorization(bankingProductId, false);
			changeProcessId(bankingProductId, "");
			restoreFromHistory(bankingProductId);

		} catch (Exception e) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099"), e);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "denyChange"));
			}
		}
	}

	/**
	 * Revert change when they were not authorized, call by the BPM
	 * 
	 * @param parameters
	 *            parameters send by the BPM
	 */
	private void cancelChangeTask(String processId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "denyChangeTask"));
				logger.logDebug("Denegando cambios proceso asociado: " + processId);
			}
			
			String productId = entityManager.createNamedQuery("BankingProduct.findProductByProcess", String.class)
					.setParameter("processId", processId).getSingleResult();
			CancelChange(productId);
		} catch (Exception e) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099"), e);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "denyChangeTask"));
			}
		}
	}

	public List<BankingProduct> getBankinProductsRulesFiltered(Integer clientId, String oficialId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getBankinProductsRulesFiltered"));
			}
			
			// Rule object
			Rule rule;
			// VariableProcess object
			VariableProcess variableProcess;
			// List process to get the condition list for execute the rule
			List<VariableProcess> listVariableProcess = new ArrayList<VariableProcess>();
			// Result of execute rule
			String resultValueRules = "";
			// Banking Product List that not satisfy with this rules
			List<BankingProduct> removeList = new ArrayList<BankingProduct>();
			// Get Approved Banking Products for sale
			List<BankingProduct> approvedProducts = getBankinProductsApprovedStructure();

			if (clientId > 0 && (oficialId != null && !oficialId.equals(""))) {

				// 1.- INI for each banking product
				for (BankingProduct bankingProduct : approvedProducts) {
					// INI Validate final product
					if (bankingProduct.getNodeTypeCategory().getNodeTypeProduct().getId() == Constants.FINAL_NODE_TYPE_PRODUCT_ID) {
						// INI Validate if banking product has rules
						if (bankingProduct.getRules() != null && bankingProduct.getRules().size() > 0) {
							List<ProductRule> ruleList = bankingProduct.getRules();
							// 2.- INI Get Rules for each banking product
							for (ProductRule productRule : ruleList) {
								// Get rule version for each banking product
								// rule
								rule = new Rule();
								rule.setId(productRule.getRuleId());

								// Get rule version active
								RuleVersion versionRule = rulesManager.queryRuleVersionActive(rule);

								// INI Validate if exists active version rule
								if (versionRule == null) {

									logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.031", rule.getId(), bankingProduct.getId()));

									throw new BusinessException(6900214,
											"Ocurrió un error al recuperar la versión activa de la regla asociada a un producto bancario de FPM.");

								} else {

									if(logger.isDebugEnabled()){
										logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.034", versionRule.getId()));
									}

									RuleVersion versionRuleExecution = new RuleVersion();
									versionRuleExecution.setId(versionRule.getId());
									versionRuleExecution.setRule(rule);

									// Get conditions for rule
									List<Variable> variableList = rulesManager.queryConditionRuleVersionActive(versionRule);

									// INI Validate if rule has conditions
									if (variableList.size() == 0) {

										logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.032", versionRule.getId(),
												bankingProduct.getId()));

										throw new BusinessException(6900215,
												"Ocurrió un error al recuperar la lista de condiciones correspondientes a la regla activa asociada a un producto bancario de FPM.");

									} else {

										logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.035", versionRule.getId()));

										// 3.- INI for each rule condition
										for (Variable ruleCondition : variableList) {

											if(logger.isDebugEnabled()){
												logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.036", ruleCondition.getNombreVariable()));
											}

											String valueOfVariable = evaluatorManager.getVariableValue(ruleCondition, clientId, oficialId,
													bankingProduct.getId());

											if (valueOfVariable == null) {
												logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.033",
														ruleCondition.getNombreVariable(), rule.getId(), bankingProduct.getId()));

												throw new BusinessException(6900215,
														"Ocurrió un error al obtener el valor para una condición de una regla asociada a un producto bancario de FPM.");
											}

											Variable variable = new Variable();
											variable.setCodigoVariable(ruleCondition.getCodigoVariable());

											variableProcess = new VariableProcess();
											variableProcess.setVariable(variable);
											variableProcess.setValue(valueOfVariable);
											listVariableProcess.add(variableProcess);

										} // 3.- FIN for each rule condition

										HashMap<RuleVersion, List<VariableProcess>> valuesRules = new HashMap<RuleVersion, List<VariableProcess>>();
										valuesRules.put(versionRuleExecution, listVariableProcess);

										if(logger.isDebugEnabled()){
											logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.037", versionRule.getId()));
										}

										// Execute rule and return result
										List<RuleProcess> proceesRule = rulesManager.generate(valuesRules);

										for (RuleProcess procesos : proceesRule) {
											for (VariableProcess iterator : procesos.getVariableProcesses()) {
												if(logger.isDebugEnabled()){
													logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.038", versionRule.getId()));
												}

												resultValueRules = iterator.getValue();
											}
										}
										
										if (!verifiedRuleValue(resultValueRules)) {
											removeList.add(bankingProduct);
											break;
										}
									}// FIN Validate if rule has conditions
								}// FIN Validate if exists active version rule
							}// 2.- FIN Get Rules for each banking product
						} // FIN Validate if banking product has rules
					}// FIN Validate final product
				}// 1.- FIN for each banking product

				// Remove the final products
				approvedProducts.removeAll(removeList);
				// Clean products without children products
				for (long level = Constants.FINAL_NODE_TYPE_PRODUCT_ID - 1; level > 1; level--) {
					removeList = getBankingProductsWithoutChildren(approvedProducts, level);
					approvedProducts.removeAll(removeList);
				}
			}
			return approvedProducts;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099"), ex);
			throw new BusinessException(6900057, "No se pudo cargar el árbol de productos bancarios");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getBankinProductsRulesFiltered"));
			}
		}

	}

	/**
	 * Verified evaluation rule result
	 * 
	 * @param ruleValue
	 * @return Indicates whether rule's result is true or false
	 */
	private Boolean verifiedRuleValue(String rulerValue) {
		if (rulerValue.equals(COMPARE_RULE)) {
			return false;
		} else if (rulerValue.equals("0")) {
			return true;
		} else if (rulerValue.equals("")) {
			return false;
		} else if (rulerValue.equals("1")) {
			return false;
		} else {
			return true;
		}
	}

	/**
	 * Get the approved data necessary to construct the banking products tree
	 * 
	 * @return
	 */
	public List<BankingProduct> getBankinProductsApprovedStructure() {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getBankinProductsApprovedStructure"));
			}
			// The list of open JPA is read only, because create new ArrayList

			SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
			Date processDate = formatter.parse(ContextManager.getContext().getProcessDate());

			if(logger.isDebugEnabled()){
				logger.logDebug("Process Date: " + processDate);
			}
			
			List<BankingProduct> products = new ArrayList<BankingProduct>(entityManager.createNamedQuery("BankingProduct.findStructure",
					BankingProduct.class).getResultList());

			if(logger.isDebugEnabled()){
				logger.logDebug("Size getBankinProductsApprovedStructure --> " + products.size());
			}

			List<BankingProduct> removeList = new ArrayList<BankingProduct>();
			// Clean the final products without history and not available
			for (BankingProduct bp : products) {
				if (bp.getNodeTypeCategory().getNodeTypeProduct().getId() == Constants.FINAL_NODE_TYPE_PRODUCT_ID) {
					BankingProductHistory bph = getLatestHistorical(bp.getId());

					// Si no cumple con la restriccón de la fecha
					if (bph != null) {
						if (bph.getStartDate() != null && bph.getExpirationDate() != null) {

							Date startDate = bph.getStartDate();
							Date expirationDate = bph.getExpirationDate(); 

							startDate.setMinutes(0);
							startDate.setHours(0);
							startDate.setSeconds(0);

							expirationDate.setMinutes(0);
							expirationDate.setHours(0);
							expirationDate.setSeconds(0);

							if (!(startDate.compareTo(processDate) <= 0 && expirationDate.compareTo(processDate) >= 0)) {
								logger.logError("El producto " + bp.getId() + " No cumple con el período de vigencia de la fecha inicio: "
										+ bph.getStartDate() + " fecha fin: " + bph.getExpirationDate());
								removeList.add(bp);
							}
						} else {
							logger.logError("El producto " + bp.getId() + " No cumple con el período de vigencia de la fecha inicio: "
									+ bph.getStartDate() + " fecha fin: " + bph.getExpirationDate());
							removeList.add(bp);
						}
					}

					// If not has history or is not available to sale
					if (null == bph || !bph.getAvailable().equals(Constants.YES)) {
						removeList.add(bp);
					} else {
						// Set the data from the history
						bp.setName(bph.getName());
						bp.setDescription(bph.getDescription());
						bp.setAvailable(bph.getAvailable());
						bp.setStartDate(bph.getStartDate());
						bp.setExpirationDate(bph.getExpirationDate());
						bp.setSubstantiation(bph.getSubstantiation());
						// Process
						bp.setProcesses(new ArrayList<ProductProcess>());
						for (ProductProcessHistory pph : bph.getProcessHistories()) {
							ProductProcess pp = new ProductProcess();
							pp.setBankingProduct(bp);
							pp.setFlowId(pph.getFlowId());
							pp.setProcessByProductId(pph.getProcessByProductId());
							pp.setProcessId(pph.getProcessId());
							pp.setGeneric(pph.getGeneric());
							pp.setProcessName(pph.getProcessName());
							pp.setIsNotGeneric(pph.getIsNotGeneric());
							pp.setCreditLine(pph.getCreditLine());
							bp.getProcesses().add(pp);
						}
						// Rules
						bp.setRules(new ArrayList<ProductRule>());
						for (ProductRuleHistory prh : bph.getRulesHistories()) {
							ProductRule pr = new ProductRule();
							pr.setBankingProduct(bp);
							pr.setRuleId(prh.getRuleId());
							pr.setRuleName(prh.getRuleName());
							pr.setRulesByProductId(prh.getRulesByProductId());
							bp.getRules().add(pr);
						}
					}
				}
			}
			// Remove the final products
			products.removeAll(removeList);
			// Clean products without children products
			for (long level = Constants.FINAL_NODE_TYPE_PRODUCT_ID - 1; level > 1; level--) {
				removeList = getBankingProductsWithoutChildren(products, level);
				products.removeAll(removeList);
			}

			if(logger.isDebugEnabled()){
				logger.logDebug("Final Products --> " + products.size());
			}

			return products;

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099"), ex);
			throw new BusinessException(6900057, "No se pudo cargar el árbol de productos bancarios");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getBankinProductsApprovedStructure"));
			}
		}
	}

	/**
	 * Find a list of products without children given a level of products
	 * indicated by nodeTypeProducId
	 * 
	 * @param products
	 *            List of banking products
	 * @param nodeTypeProductId
	 *            Level to find
	 * @return List of BankingProduct founded
	 */
	private List<BankingProduct> getBankingProductsWithoutChildren(List<BankingProduct> products, long nodeTypeProductId) {
		// The list of parents without children
		List<BankingProduct> parents = new ArrayList<BankingProduct>();
		for (BankingProduct bp : products) {
			// If is the same level
			if (bp.getNodeTypeCategory().getNodeTypeProduct().getId() == nodeTypeProductId) {
				// Add the product
				parents.add(bp);
				for (BankingProduct bpSearch : products) {
					// If contains one children break and remove of the list
					if (bpSearch.getParentnode() != null && bpSearch.getParentnode().equals(bp.getId())) {
						parents.remove(bp);
						break;
					}
				}
			}
		}
		return parents;
	}

	/**
	 * Find the historical of banking product by the date.
	 * 
	 * @param bankingProductId
	 * @param dateSys
	 * @return BankingProductHistory
	 */

	public BankingProductHistory getLatestHistoricalByDate(String bankingProductId, Date systemDate) {

		if(logger.isDebugEnabled()){
			// log the method entry
			logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getLatestHistoricalByDate"));
		}
		
		// Get the actual values
		List<BankingProductHistory> bphList = entityManager.createNamedQuery("BankingProductHistory.FindLatestByDate", BankingProductHistory.class)
				.setParameter("productId", bankingProductId).setParameter("processDate", systemDate).getResultList();
		// If not exist history
		if (bphList.isEmpty()) {
			logger.logError("No existe historico para el producto bancario " + bankingProductId);
			return null;
		}
		// If there is more that one result error
		if (bphList.size() > 1) {
			logger.logError("Ocurrio un error se obtuvo mas de un último registro historico");
			throw new IllegalStateException();
		}
		
		if(logger.isDebugEnabled()){
			logger.logDebug("Producto historico " + bphList.get(0));
			// log the method entry
			logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getLatestHistoricalByDate"));
		}
		
		return bphList.get(0);

	}

	/**
	 * Get the basic data related to the banking product approved, this method
	 * returns a object with only fill the id and name of the related entities
	 * 
	 * @param bankingProductId
	 *            Id of the <tt>BankingProduct</tt>
	 * @return <tt>BankingProduct</tt> entity
	 */
	public BankingProduct getBankingProductApprovedInformationById(String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getBankingProductApprovedInformationById"));
			}
			// Get the process date for the context

			BankingProductHistory bph = getLatestHistorical(bankingProductId);

			if (null == bph || bph.getAvailable().equals(Constants.NO)) {
				throw new BusinessException(6900192, "El producto bancario indicado no posee información aprobada");
			}
			// Return only the basic information
			return setBankingProductValues(bph, bankingProductId);
		} catch (BusinessException be) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.007", bankingProductId));
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.008", bankingProductId), ex);
			throw new BusinessException(6900061, "No se pudo obtener el producto bancario");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getBankingProductApprovedInformationById"));
			}
		}
	}

	/**
	 * Get the basic data related to the banking product approved, this method
	 * returns a object with only fill the id and name of the related entities
	 * by date
	 * 
	 * @param bankingProductId
	 *            Id of the <tt>BankingProduct</tt>
	 * @return <tt>BankingProduct</tt> entity
	 */
	public BankingProduct getBankingProductApprovedInformationById(String bankingProductId, Date systemDate) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getBankingProductApprovedInformationById"));
			}

			BankingProductHistory bph = getLatestHistoricalByDate(bankingProductId, systemDate);

			if (null == bph || bph.getAvailable().equals(Constants.NO)) {
				throw new BusinessException(6900192, "El producto bancario indicado no posee información aprobada");
			}
			// Return only the basic information
			return setBankingProductValues(bph, bankingProductId);
		} catch (BusinessException be) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.007", bankingProductId));
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.008", bankingProductId), ex);
			throw new BusinessException(6900061, "No se pudo obtener el producto bancario");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getBankingProductApprovedInformationById"));
			}
		}
	}

	public BankingProduct setBankingProductValues(BankingProductHistory bph, String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "setBankingProductValues"));
			}

			// Return only the basic information
			BankingProduct bProduct = getBankingProductById(bankingProductId);

			BankingProduct bankingProduct = new BankingProduct();
			bankingProduct.setId(bph.getProductId());
			bankingProduct.setName(bph.getName());
			bankingProduct.setDescription(bph.getDescription());
			bankingProduct.setAvailable(bph.getAvailable());
			bankingProduct.setStartDate(bph.getStartDate());
			bankingProduct.setExpirationDate(bph.getExpirationDate());
			bankingProduct.setSubstantiation(bph.getSubstantiation());
			bankingProduct.setParentnode(bProduct.getParentnode());
			bankingProduct.setCompany(new Company());
			bankingProduct.getCompany().setId(bProduct.getCompany().getId());
			bankingProduct.getCompany().setName(bProduct.getCompany().getName());
			bankingProduct.setNodeTypeCategory(new NodeTypeCategory());
			bankingProduct.getNodeTypeCategory().setId(bProduct.getNodeTypeCategory().getId());
			bankingProduct.getNodeTypeCategory().setName(bProduct.getNodeTypeCategory().getName());
			bankingProduct.getNodeTypeCategory().setNodeTypeProduct(new NodeTypeProduct());
			bankingProduct.getNodeTypeCategory().getNodeTypeProduct().setId(bProduct.getNodeTypeCategory().getNodeTypeProduct().getId());
			bankingProduct.getNodeTypeCategory().setModule(bProduct.getNodeTypeCategory().getModule());
			bankingProduct.getNodeTypeCategory().getNodeTypeProduct().setName(bProduct.getNodeTypeCategory().getNodeTypeProduct().getName());
			bankingProduct.setCurrencyProducts(new ArrayList<CurrencyProduct>());
			// If is a final product check for process and rules
			if (bProduct.getNodeTypeCategory().getNodeTypeProduct().getId() == Constants.FINAL_NODE_TYPE_PRODUCT_ID) {
				bankingProduct.setProcesses(new ArrayList<ProductProcess>());
				// Get all process for the history
				for (ProductProcessHistory pph : bph.getProcessHistories()) {
					ProductProcess pp = new ProductProcess();
					pp.setBankingProduct(bProduct);
					pp.setFlowId(pph.getFlowId());
					pp.setProcessByProductId(pph.getProcessByProductId());
					pp.setProcessId(pph.getProcessId());
					pp.setGeneric(pph.getGeneric());
					pp.setProcessName(pph.getProcessName());
					pp.setIsNotGeneric(pph.getIsNotGeneric());
					pp.setCreditLine(pph.getCreditLine());
					bankingProduct.getProcesses().add(pp);
				}

				bankingProduct.setRules(new ArrayList<ProductRule>());
				// Get all rules for the history
				for (ProductRuleHistory prh : bph.getRulesHistories()) {
					ProductRule pr = new ProductRule();
					pr.setBankingProduct(bProduct);
					pr.setRuleId(prh.getRuleId());
					pr.setRuleName(prh.getRuleName());
					pr.setRulesByProductId(prh.getRulesByProductId());
					bankingProduct.getRules().add(pr);
				}

			}
			// Return the approved currencies and policies

			for (CurrencyProductHistory cph : bph.getCurrencyProductsHistory()) {
				// Check for a valid status and exist in the history
				if (cph.getStatus().equals(Constants.YES)) {
					CurrencyProduct cpi = new CurrencyProduct();
					cpi.setId(new CurrencyProductId(cph.getCurrencyId(), null));
					cpi.setPolicyProducts(new ArrayList<PolicyProduct>());
					// If the currency exist in the history return the
					// policies
					for (PolicyProductHistory pph : cph.getPoliciesProducts()) {
						PolicyProduct pp = new PolicyProduct(bProduct.getId(), cph.getCurrencyId(), pph.getPolicyId(), pph.getPolicyName(),
								pph.getInheritedFrom());
						cpi.getPolicyProducts().add(pp);
					}
					bankingProduct.getCurrencyProducts().add(cpi);
				}
			}

			return bankingProduct;
		} catch (BusinessException be) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.007", bankingProductId));
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.008", bankingProductId), ex);
			throw new BusinessException(6900061, "No se pudo obtener el producto bancario");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "setBankingProductValues"));
			}
		}
	}

	/**
	 * Revert change when cancel tasks, call by the BPM
	 * 
	 * @param parameters
	 *            parameters send by the BPM
	 */
	public void denyChangeTasks(String[] Processes) {
		for (String process : Processes) {
			cancelChangeTask(process);
		}
	}

	/**
	 * Get the status of the authorization process
	 * 
	 * @param processId
	 *            The id of the process
	 * @return The catalog that represent the status
	 */
	public Catalog GetProcessAuthorizationStatus(String processId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getBankingProductApprovedInformationById"));
			}
			// If there is a one product associate to the process the status of
			// the authorization is in progress
			// I us the result list because getSingleResult throws a exception
			// if the result is empty
			if (!entityManager.createNamedQuery("BankingProduct.findProductByProcess", String.class).setParameter("processId", processId)
					.getResultList().isEmpty()) {
				// because there is not a catalog for in progress return null,
				// and the service client must validate the null value
				return null;
			}
			// Get the catalog list for authorization statuses
			List<Catalog> statuses = catalogManager.getCatalogsByName(Constants.CATALOGS.AUTHORIZATION_STATUS);
			// Get the status authorization for the last history
			String statusCode = entityManager.createNamedQuery("BankingProductHistoryId.FindAuthorizationStatusByProcessId", String.class)
					.setParameter("processId", processId).getSingleResult();

			// Match the code with the catalog list
			return CatalogUtils.getFromCatalogList(statuses, statusCode);
		} catch (NoResultException nre) {
			return null;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099"), ex);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getBankingProductApprovedInformationById"));
			}
		}
	}

	@SuppressWarnings("unchecked")
	/**
	 * Get the process  by module given a banking product id
	 */
	public List<Catalog> getProcessByModule(String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getProcessByModule"));
			}

			Long categoryId = getCategoryIdKeepDictionaryFromParents(bankingProductId);

			NodeTypeCategory category = nodeProductService.getNodeCateogyById(categoryId);
			List<Catalog> process = catalogManager.getCatalogsByName(Constants.CATALOGS.PRODUCT_PROCESS);

			List<String> queryProcess = entityManager.createNativeQuery(PROCESS_BY_MODULE_QUERY, String.class)
					.setParameter(1, category.getModule().getModuleId()).getResultList();

			List<Catalog> processbymodule = new ArrayList<Catalog>();
			if (queryProcess != null) {
				if (queryProcess.size() > 0) {
					for (String qprocess : (List<String>) queryProcess) {
						for (Catalog catalog : process) {
							if (catalog.getCode().equals(qprocess)) {
								processbymodule.add(catalog);
							}
						}
					}
				}
			}

			return processbymodule;
		} catch (NoResultException nre) {
			return null;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099"), ex);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getProcessByModule"));
			}
		}
	}

	/**
	 * Get operation given the process
	 */
	public List<Catalog> getOperationByProcess(String processId) {
		try {
			List<Catalog> processbyoperation = new ArrayList<Catalog>();
			
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getOperationByProcess"));
			}

			List<Catalog> processType = catalogManager.getCatalogsByName(Constants.CATALOGS.TYPE_PROCESS);

			@SuppressWarnings("unchecked")
			List<String> queryProcess = entityManager.createNativeQuery(OPERATION_BY_PROCESS_QUERY, String.class).setParameter(1, processId)
			.getResultList();
			if (queryProcess != null) {
				if (queryProcess.size() > 0) {
					for (String qprocess : (List<String>) queryProcess) {
						for (Catalog catalog : processType) {
							if (catalog.getCode().equals(qprocess)) {
								processbyoperation.add(catalog);
							}
						}
					}
				}
			}

			return processbyoperation;
		} catch (NoResultException nre) {
			return null;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099"), ex);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getOperationByProcess"));
			}
		}
	}

	/**
	 * 
	 * @param sectorId
	 * @return
	 */
	public Long getProductsAssociatedSector(Long sectorId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "getProductsAssociatedSector"));
			}
			
			return entityManager.createNamedQuery("BankingProduct.countProductAssociatedSector", Long.class).setParameter("sectorId", sectorId)
					.getSingleResult();
		} catch (NoResultException nre) {
			return 0L;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099"), ex);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "getProductsAssociatedSector"));
			}
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
		this.entityManager = em;
	}

	/**
	 * Set the injected instance of the service for
	 * 
	 * @param generalParametersService
	 */
	public void setGeneralParametersService(IGeneralParametersManager generalParametersService) {
		this.generalParametersService = generalParametersService;
	}

	public void setItemsService(IItemsManager itemsService) {
		this.itemsService = itemsService;
	}

	/**
	 * Inject the instance for the INodeProductManager service
	 * 
	 * @param nodeProductService
	 *            instance injected
	 */
	public void setNodeProductService(INodeProductManager nodeProductService) {
		this.nodeProductService = nodeProductService;
	}

	/**
	 * Inject the instance for the ICatalogManager service
	 * 
	 * @param catalogManager
	 *            instance injected
	 */
	public void setCatalogManager(ICatalogManager catalogManager) {
		this.catalogManager = catalogManager;
	}

	/**
	 * Inject the instance for the IServiceExecutor service
	 * 
	 * @param serviceExecutor
	 *            instance injected
	 */
	public void setServiceExecutor(IServiceExecutor serviceExecutor) {
		this.serviceExecutor = serviceExecutor;
	}

	/**
	 * Inject the instance for the IAccountingProfileManager service
	 * 
	 * @param accountingProfileManagerService
	 *            instance injected
	 */
	public void setAccountingProfileService(IAccountingProfileManager accountingProfileService) {
		this.accountingProfileService = accountingProfileService;
	}

	/**
	 * Inject the instance for the IItemStatusManager service
	 * 
	 * @param itemStatusManagerService
	 *            instance injected
	 */
	public void setItemStatusService(IItemStatusManager itemStatusService) {
		this.itemStatusService = itemStatusService;
	}

	/**
	 * Inject the instance for the IOperationStatusManager service
	 * 
	 * @param operationStatusManagerService
	 *            instance injected
	 */
	public void setOperationStatusService(IOperationStatusManager operationStatusService) {
		this.operationStatusService = operationStatusService;
	}

	/**
	 * @param economicDestinationService
	 *            the economicDestinationService to set
	 */
	public void setEconomicDestinationService(IEconomicDestinationManager economicDestinationService) {
		this.economicDestinationService = economicDestinationService;
	}

	public void setPurposeManager(IPurposeManager purposeManager) {
		this.purposeManager = purposeManager;
	}

	public IEconomicActivityManager getEconomicActivityService() {
		return economicActivityService;
	}

	public void setEconomicActivityService(IEconomicActivityManager economicActivityService) {
		this.economicActivityService = economicActivityService;
	}

	/**
	 * @param rulesManager
	 */
	public void setRulesManager(IRuleManager rulesManager) {
		this.rulesManager = rulesManager;
	}

	/**
	 * @param evaluatorManager
	 */
	public void setEvaluatorManager(IEvaluatorManager evaluatorManager) {
		this.evaluatorManager = evaluatorManager;
	}

	
	public void setUnitFunctionalityServices(
			IUnitFunctionalityValues unitFunctionalityServices) {
		this.unitFunctionalityServices = unitFunctionalityServices;
	}

	public List<BankingProduct> findAllBankingProductChildrenId(String bankingproductParentId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001", "findAllBankingProductChildrenId"));
			}
			
			List<BankingProduct> bankingProductList = entityManager
					.createNamedQuery("BankingProduct.findAllBankingProductChildrenId", BankingProduct.class)
					.setParameter("bankingProductId", bankingproductParentId).getResultList();
			return bankingProductList;
		} catch (NoResultException nre) {
			return null;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099"), ex);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "findAllBankingProductChildrenId"));
			}
		}
	}

	public List<BankingProduct> findBankingProductByModule(String nemonic) {
		try {

			List<BankingProduct> bankingProductList = getBankinProductsApprovedStructure();

			HashMap<String, BankingProduct> hmBankingProduct1 = new HashMap<String, BankingProduct>();
			HashMap<String, BankingProduct> hmBankingProduct2 = new HashMap<String, BankingProduct>();
			List<BankingProduct> bankingProductListResult = new ArrayList<BankingProduct>();

			if (nemonic.equals("")) {
				for (BankingProduct bankingProduct : bankingProductList) {
					if (bankingProduct.getNodeTypeCategory().getModule() != null) {
						hmBankingProduct1.put(bankingProduct.getId(), bankingProduct);
					}
				}
			} else {
				for (BankingProduct bankingProduct : bankingProductList) {
					if (bankingProduct.getNodeTypeCategory().getModule() != null
							&& bankingProduct.getNodeTypeCategory().getModule().getMnemonic().equals(nemonic)) {
						hmBankingProduct1.put(bankingProduct.getId(), bankingProduct);
					}
				}
			}

			for (BankingProduct bankingProduct : bankingProductList) {
				if (hmBankingProduct1.containsKey(bankingProduct.getParentnode())) {
					if (bankingProduct.getNodeTypeCategory().getNodeTypeProduct().getId() == Constants.FINAL_NODE_TYPE_PRODUCT_ID) {
						bankingProductListResult.add(bankingProduct);
					} else {
						hmBankingProduct2.put(bankingProduct.getId(), bankingProduct);
					}
				}
			}

			for (BankingProduct bankingProduct : bankingProductList) {
				if (hmBankingProduct2.containsKey(bankingProduct.getParentnode())) {
					if (bankingProduct.getNodeTypeCategory().getNodeTypeProduct().getId() == Constants.FINAL_NODE_TYPE_PRODUCT_ID) {
						bankingProductListResult.add(bankingProduct);
					}
				}
			}

			return bankingProductListResult;

		} catch (NoResultException nre) {
			return null;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("BANKINGPRODUCTMANAGER.099"), ex);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.002", "findBankingProductByModule"));
			}
		}
	}

	/**
	 * Get the approved data necessary to construct the banking products tree
	 * 
	 * @return
	 */
	public List<BankingProduct> getBankinProductsLatestByModule(Long module) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("BANKINGPRODUCTMANAGER.001","getBankinProductsLatestByModule"));
			}
			// The list of open JPA is read only, because create new ArrayList

			SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
			Date processDate = formatter.parse(ContextManager.getContext().getProcessDate());

			if(logger.isDebugEnabled()){
				logger.logDebug("Process Date: " + processDate);
			}
			
			List<BankingProduct> products = new ArrayList<BankingProduct>(
					entityManager.createNamedQuery(
							"BankingProduct.findStructure",
							BankingProduct.class).getResultList());

			if(logger.isDebugEnabled()){
				logger.logDebug("Size getBankinProductsLatestByModule --> "+ products.size());
			}

			List<BankingProduct> removeList = new ArrayList<BankingProduct>();
			// Clean the final products without history and not available
			for (BankingProduct bp : products) {
				if (bp.getNodeTypeCategory().getNodeTypeProduct().getId() == Constants.FINAL_NODE_TYPE_PRODUCT_ID) {
					
					BankingProductHistory bph = getLatestHistorical(bp.getId());

					// Si no cumple con la restriccón de la fecha
					if (bph != null) {
						if (bph.getStartDate() != null
								&& bph.getExpirationDate() != null) {

							Date startDate = formatter.parse(formatter.format(bph.getStartDate()));
							Date expirationDate = formatter.parse(formatter.format(bph.getStartDate()));

							if (!(startDate.compareTo(processDate) <= 0 && expirationDate.compareTo(processDate) >= 0)) {
								logger.logError("El producto "
										+ bp.getId()
										+ " No cumple con el período de vigencia de la fecha inicio: "
										+ bph.getStartDate() + " fecha fin: "
										+ bph.getExpirationDate());
								removeList.add(bp);
							}
						} else {
							logger.logError("El producto "
									+ bp.getId()
									+ " No cumple con el período de vigencia de la fecha inicio: "
									+ bph.getStartDate() + " fecha fin: "
									+ bph.getExpirationDate());
							removeList.add(bp);
						}
					}

					// If not has history or is not available to sale or isn't the filter module
					if ((null == bph
							|| !bph.getAvailable().equals(Constants.YES))
							&&bp.getNodeTypeCategory().getModuleId()!=module) {
						removeList.add(bp);
					} else {						
						// Set the data from the history
						bp.setName(bph.getName());
						bp.setDescription(bph.getDescription());
						bp.setAvailable(bph.getAvailable());
						bp.setStartDate(bph.getStartDate());
						bp.setExpirationDate(bph.getExpirationDate());
						bp.setSubstantiation(bph.getSubstantiation());
						// Process
						bp.setProcesses(new ArrayList<ProductProcess>());
						for (ProductProcessHistory pph : bph
								.getProcessHistories()) {
							ProductProcess pp = new ProductProcess();
							pp.setBankingProduct(bp);
							pp.setFlowId(pph.getFlowId());
							pp.setProcessByProductId(pph
									.getProcessByProductId());
							pp.setProcessId(pph.getProcessId());
							pp.setGeneric(pph.getGeneric());
							pp.setProcessName(pph.getProcessName());
							pp.setIsNotGeneric(pph.getIsNotGeneric());
							pp.setCreditLine(pph.getCreditLine());
							bp.getProcesses().add(pp);
						}
						// Rules
						bp.setRules(new ArrayList<ProductRule>());
						for (ProductRuleHistory prh : bph.getRulesHistories()) {
							ProductRule pr = new ProductRule();
							pr.setBankingProduct(bp);
							pr.setRuleId(prh.getRuleId());
							pr.setRuleName(prh.getRuleName());
							pr.setRulesByProductId(prh.getRulesByProductId());
							bp.getRules().add(pr);
						}						
					}
				}else{//elimina todos los productos que no son finales
					removeList.add(bp);
				}				
			}
			// Remove the final products
			products.removeAll(removeList);
			// Clean products without children products
			for (long level = Constants.FINAL_NODE_TYPE_PRODUCT_ID - 1; level > 1; level--) {
				removeList = getBankingProductsWithoutChildren(products, level);
				products.removeAll(removeList);
			}

			if(logger.isDebugEnabled()){
				logger.logDebug("Final Products --> " + products.size());
			}

			return products;

		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("BANKINGPRODUCTMANAGER.099"), ex);
			throw new BusinessException(6900057,
					"No se pudo cargar el árbol de productos bancarios");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString(
						"BANKINGPRODUCTMANAGER.002",
						"getBankinProductsLatestByModule"));
			}
		}
	}

}
