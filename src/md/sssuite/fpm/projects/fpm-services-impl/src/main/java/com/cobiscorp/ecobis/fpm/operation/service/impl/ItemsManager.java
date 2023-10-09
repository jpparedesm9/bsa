package com.cobiscorp.ecobis.fpm.operation.service.impl;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import javax.persistence.TypedQuery;

import com.cobiscorp.cobis.cache.ICache;
import com.cobiscorp.cobis.cache.ICacheManager;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.administration.service.IDictionaryManager;
import com.cobiscorp.ecobis.fpm.bo.AmountItemValueLog;
import com.cobiscorp.ecobis.fpm.bo.ApplicationFormsLog;
import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.bo.ChangeRateLog;
import com.cobiscorp.ecobis.fpm.bo.GeneralParameterValueLog;
import com.cobiscorp.ecobis.fpm.bo.ItemLog;
import com.cobiscorp.ecobis.fpm.bo.ItemParameterValueLog;
import com.cobiscorp.ecobis.fpm.bo.ItemValueInformation;
import com.cobiscorp.ecobis.fpm.bo.RateReferenceValue;
import com.cobiscorp.ecobis.fpm.bo.RateValue;
import com.cobiscorp.ecobis.fpm.catalogs.service.ICatalogManager;
import com.cobiscorp.ecobis.fpm.model.AmountItemValue;
import com.cobiscorp.ecobis.fpm.model.AmountItemValueHistory;
import com.cobiscorp.ecobis.fpm.model.AmountItemValueId;
import com.cobiscorp.ecobis.fpm.model.AppliesToWhenApply;
import com.cobiscorp.ecobis.fpm.model.AppliesToWhenApplyId;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.Company;
import com.cobiscorp.ecobis.fpm.model.CurrencyProduct;
import com.cobiscorp.ecobis.fpm.model.CurrencyProductId;
import com.cobiscorp.ecobis.fpm.model.DicCompanyProductType;
import com.cobiscorp.ecobis.fpm.model.DicFunctionalityGroup;
import com.cobiscorp.ecobis.fpm.model.DictionaryField;
import com.cobiscorp.ecobis.fpm.model.FieldValidator;
import com.cobiscorp.ecobis.fpm.model.FieldValue;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValues;
import com.cobiscorp.ecobis.fpm.model.Item;
import com.cobiscorp.ecobis.fpm.model.ItemAppliesWay;
import com.cobiscorp.ecobis.fpm.model.ItemAppliesWayHistory;
import com.cobiscorp.ecobis.fpm.model.ItemAppliesWayHistoryId;
import com.cobiscorp.ecobis.fpm.model.ItemByProduct;
import com.cobiscorp.ecobis.fpm.model.ItemByProductHistory;
import com.cobiscorp.ecobis.fpm.model.ItemByProductHistoryId;
import com.cobiscorp.ecobis.fpm.model.ItemByProductId;
import com.cobiscorp.ecobis.fpm.model.ItemsValues;
import com.cobiscorp.ecobis.fpm.model.ItemsValuesHistory;
import com.cobiscorp.ecobis.fpm.model.NodeTypeCategory;
import com.cobiscorp.ecobis.fpm.model.WhenApplyNodeType;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.operation.service.IGeneralParametersManager;
import com.cobiscorp.ecobis.fpm.operation.service.IItemsManager;
import com.cobiscorp.ecobis.fpm.operation.service.IMappingFieldManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.service.utils.CatalogUtils;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

/**
 * This service allows you manage all the items and the items for a product.
 * 
 * @author oguano
 */
@SuppressWarnings(value = "all")
public class ItemsManager implements IItemsManager {

	// region Fields
	protected IGeneralParametersManager generalParametersManager;
	protected IBankingProductManager bankingProductManager;
	private IMappingFieldManager mappingManagerService;
	private ICatalogManager catalogManagerService;
	private IDictionaryManager dicManagerService;
	private ICacheManager cacheManager;
	
	public final ILogger logger = LogFactory.getLogger(ItemsManager.class);

	/** The Constant RATE. */
	private static final String RATE = "I,M";
	private static final String COBIS_YES = "S";
	private static final String COBIS_NO = "N";
	private static final String REAJUSTMENT = "F";

	private static final String PROD_ID_PARAMETER = "productId";
	private static final String BAN_ID_PARAMETER = "bankingProductId";

	private static final String ITEM_ID = "itemId";
	private static final String FIND_BANKING_Q = "BankingProduct.findAllBankingProductChildrenId";
	/* Cache key */
	final String CACHE_KEY = "FPMCache";
	
	private EntityManager entityManager;

	// end-region

	// region Properties

	/**
	 * Initialize the Entity Manager.
	 * 
	 * @param entityManager
	 *            Entity Manager
	 */
	@PersistenceContext(unitName = "JpaFpmAdministration")
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	/**
	 * Sets the general parameters manager.
	 * 
	 * @param gPManager
	 *            the new general parameters manager
	 */
	public void setGeneralParametersManager(IGeneralParametersManager gPManager) {
		this.generalParametersManager = gPManager;
	}

	/**
	 * @param mappingManagerService
	 */
	public void setMappingManagerService(
			IMappingFieldManager mappingManagerService) {
		this.mappingManagerService = mappingManagerService;
	}

	/**
	 * @param bPManager
	 */
	public void setBankingProductManager(IBankingProductManager bPManager) {
		this.bankingProductManager = bPManager;
	}

	/**
	 * @param catalogManagerService
	 */
	public void setCatalogManagerService(ICatalogManager catalogManagerService) {
		this.catalogManagerService = catalogManagerService;
	}

	/**
	 * @param dicManagerService
	 */
	public void setDicManagerService(IDictionaryManager dicManagerService) {
		this.dicManagerService = dicManagerService;
	}

	/**
	 * @param cacheManager
	 */
	public void setCacheManager(ICacheManager cacheManager) {
		this.cacheManager = cacheManager;
	}

	// end-region

	// region CurrencyByProduct
	/**
	 * Get the list for <tt>CurrencyProduct</tt>.
	 * 
	 * @param productId
	 *            the product id
	 * @return List for <tt>CurrencyProduct</tt>
	 */
	public List<CurrencyProduct> getCurrenciesByProduct(String productId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
						"getCurrenciesByProduct"));
			}
			
			return entityManager
					.createNamedQuery("CurrencyProduct.findByProduct",
							CurrencyProduct.class)
					.setParameter(PROD_ID_PARAMETER, productId).getResultList();
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("ITEMSMANAGER.024", productId), ex);
			throw new BusinessException(6900110,
					"No se pudo obtener las monedas asociadas al producto");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
						"getCurrenciesByProduct"));
			}
		}
	}

	// end-region

	// region Method's

	// region Items

	/**
	 * Get list of <tt>Item</tt>.
	 * 
	 * @return List of <tt>Item</tt>
	 */
	public List<Item> getItems(String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
						"getItems"));
			}

			Long idCategory = bankingProductManager
					.getCategoryIdKeepDictionaryFromParents(bankingProductId);

			return entityManager.createNamedQuery("Item.findAll", Item.class)
					.setParameter("nodeTypeCategory", idCategory)
					.getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.003"), ex);
			throw new BusinessException(6900089,
					"No se pudo obtener la lista de rubros");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
						"getItems"));
			}
		}
	}

	/**
	 * Gets the all items for category.
	 * 
	 * @return List of <tt>Item</tt>
	 */
	public List<Item> getAllItemsForCategory(String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
						"getAllItemsForCategory"));
			}

			Long idCategory = bankingProductManager
					.getCategoryIdKeepDictionaryFromParents(bankingProductId);

			List<Item> queryItems = entityManager
					.createNamedQuery("Item.findAll", Item.class)
					.setParameter("nodeTypeCategory", idCategory)
					.getResultList();

			for (Item item : queryItems) {
				item.getNodeTypeCategory().getDicCompanyProductTypes().size();
				break;
			}

			return queryItems;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.007"), ex);
			throw new BusinessException(6900093,
					"No se pudo obtener la lista de rubros para una categoría específica");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
						"getAllItemsForCategory"));
			}
		}
	}

	/**
	 * Gets specific <tt>Item</tt>.
	 * 
	 * @param itemId
	 *            the item id
	 * @return <tt>Item</tt>
	 */
	public Item getItem(Long itemId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
						"getItem"));
			}
			
			Item item = entityManager
					.createNamedQuery("Item.findItemById", Item.class)
					.setParameter("itemIdentifier", itemId).getSingleResult();
			return item;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("ITEMSMANAGER.036", itemId), ex);
			throw new BusinessException(6900122,
					"No se pudo obtener un rubro requerido");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getItem"));
			}
		}

	}

	/**
	 * Gets specific <tt>Item</tt>.
	 * 
	 * @param itemId
	 *            the item id
	 * @return <tt>Item</tt>
	 */
	public Item getItemOpt(Long itemId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
						"getItemOpt"));
			}
			
			Item item = entityManager
					.createNamedQuery("Item.findItemByIdOpt", Item.class)
					.setParameter("itemIdentifier", itemId).getSingleResult();
			return item;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("ITEMSMANAGER.036", itemId), ex);
			throw new BusinessException(6900122,
					"No se pudo obtener un rubro requerido");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getItemOpt"));
			}
		}

	}
	
	/**
	 * Manage <tt>Item</tt>.
	 * 
	 * @param item
	 *            <tt>Item</tt>
	 * @return the Item id
	 */
	public Long manageItem(Item item, String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"manageItem"));
			}
			
			Item existItem = entityManager.find(Item.class, item.getId());

			Long code = 0L;

			if (existItem != null) {
				// entityManager.merge(item);
				existItem.setDescription(item.getDescription());
				existItem.setName(item.getName());
				existItem.setValueType((item.getValueType()));
				code = existItem.getId();
			} else {
				NodeTypeCategory nodeTypeCategory = bankingProductManager
						.getCategoryKeepDictionaryFromParents(bankingProductId);
				item.setNodeTypeCategory(nodeTypeCategory);

				entityManager.persist(item);
				code = item.getId();
			}
			entityManager.flush();
			return code;
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.033", item),
					eee);
			throw new BusinessException(
					6900119,
					"No se pudo insertar la información correspondiente al rubro, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.032", item),
					ex);
			throw new BusinessException(6900118,
					"No se pudo insertar o actualizar la información correspondiente al rubro");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"manageItem"));
			}
		}

	}

	/**
	 * Delete <tt>Item</tt>.
	 * 
	 * @param itemId
	 *            the item id
	 */
	public void deleteItem(Long itemId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"deleteItem"));
			}
			
			Item existItem = entityManager.find(Item.class, itemId);
			entityManager.remove(existItem);
			entityManager.flush();
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("ITEMSMANAGER.034", itemId), ex);
			throw new BusinessException(6900120,
					"No se pudo eliminar la información correspondiente al rubro.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"deleteItem"));
			}
		}

	}

	/**
	 * Get list dictionaries for category and parent category
	 * 
	 * @param bankingProductId
	 *            Banking product identifier
	 * @return
	 */
	public List<DicCompanyProductType> getDictionariesAssociate(
			String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getDictionariesAssociate"));
			}

			Long categoryId = bankingProductManager
					.getCategoryIdKeepDictionaryFromParents(bankingProductId);

			List<DicCompanyProductType> dicCompanyProductType = new ArrayList<DicCompanyProductType>();

			BankingProduct bankingProduct = bankingProductManager
					.getBankingProductBasicInformationById(bankingProductId);
			Company company = entityManager.find(Company.class, bankingProduct
					.getCompany().getId());

			do {
				List<DicCompanyProductType> dicCompanyProductTypeForCompany = dicManagerService
						.getDictionariesBasicInformation(company.getId(),
								categoryId);

				for (DicCompanyProductType specificDicCompanyProductTypeForCategory : dicCompanyProductTypeForCompany) {

					if (specificDicCompanyProductTypeForCategory.getType()
							.trim().equals(Constants.ITEMS_DICTIONARY)) {
						dicCompanyProductType
								.add(specificDicCompanyProductTypeForCategory);
					}
				}

				company = company.getParent();
			} while (company != null);

			return dicCompanyProductType;

		} catch (BusinessException e) {
			throw e;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSTATUSMANAGER.099"),
					ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getDictionariesAssociate"));
			}
		}

	}

	// end-region

	// region ItemsByProduct

	/**
	 * Get specific <tt>Item</tt> for <tt>ItemByProduct</tt> identifier.
	 * 
	 * @param itemByProductId
	 *            the id
	 * @return <tt>ItemByProduct</tt>
	 */
	public ItemByProduct getItemByProduct(ItemByProductId itemByProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getItemByProduct"));
			}
			
			ItemByProduct itemByProduct = entityManager.find(
					ItemByProduct.class, itemByProductId);
			if (itemByProduct == null) {
				return itemByProduct;
			}
			itemByProduct.getItemAppliesWaysList().size();
			return itemByProduct;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.006"), ex);
			throw new BusinessException(6900092,
					"No se pudo obtener un rubro por producto específico");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getItemByProduct"));
			}
		}
	}

	/**
	 * Get the list of <tt>ItemByProduct</tt>.
	 * 
	 * @param bankingProductId
	 *            the banking product id
	 * @return List of <tt>ItemByProduct</tt>.
	 */
	public List<ItemByProduct> getItemsByProduct(String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getItemsByProduct"));
			}
			
			List<ItemByProduct> queryItemByProductList = entityManager
					.createNamedQuery("ItemByProduct.findItemsByProduct",
							ItemByProduct.class)
					.setParameter(PROD_ID_PARAMETER, bankingProductId)
					.getResultList();

			return queryItemByProductList;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.004"), ex);
			throw new BusinessException(6900090,
					"No se pudo obtener la información de rubros por producto");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getItemsByProduct"));
			}
		}
	}

	/**
	 * Get list of <tt>Item</tt> associate by product.
	 * 
	 * @param bankingProductId
	 *            the banking product id
	 * @return List of <tt>Item</tt>.
	 */
	public List<Item> getItemListByProduct(String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getItemListByProduct"));
			}
			
			List<ItemByProduct> itemsByProduct = getItemsByProduct(bankingProductId);
			List<Item> items = new ArrayList<Item>();

			for (ItemByProduct itemByProduct : itemsByProduct) {
				items.add(itemByProduct.getItem());
			}
			return items;
		} catch (BusinessException ex) {
			throw ex;
		} catch (Exception e) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.005"), e);
			throw new BusinessException(6900091,
					"No se pudo obtener la información de rubros asociados al producto");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getItemListByProduct"));
			}
		}
	}

	/**
	 * Insert <tt>ItemByProduct</tt>.
	 * 
	 * @param itemByProduct
	 *            the item by product
	 */
	public void insertItemByProduct(ItemByProduct itemByProduct) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"insertItemByProduct"));
			}
			
			insertItemByProductOperation(itemByProduct);

			// Replica la información de los Rubros a los hijos
			replicateItemByProductForChildren(itemByProduct);
		} catch (EntityExistsException eee) {
			logger.logError(
					MessageManager.getString("ITEMSMANAGER.008", itemByProduct),
					eee);
			throw new BusinessException(
					6900094,
					"No se pudo insertar la información correspondiente al rubro por producto, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("ITEMSMANAGER.009", itemByProduct),
					ex);
			throw new BusinessException(6900095,
					"No se pudo insertar la información correspondiente al rubro por producto");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"insertItemByProduct"));
			}
		}
	}

	// end-region

	// region ItemsValue

	/**
	 * Get the <tt>ItemsValues</tt> for render section.
	 * 
	 * @param itemByProductId
	 *            the item by product id
	 * @return List of <tt>ItemsValues</tt>
	 */
	public List<ItemsValues> getItemsValuesForItemsByProduct(
			ItemByProductId itemByProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getItemsValuesForItemsByProduct"));
			}
			
			List<ItemsValues> itemValueList = new ArrayList<ItemsValues>();
			itemValueList = entityManager
					.createNamedQuery("ItemsValues.findForItemsByProduct",
							ItemsValues.class)
					.setParameter(PROD_ID_PARAMETER,
							itemByProductId.getProductId())
					.setParameter(ITEM_ID, itemByProductId.getItemId())
					.getResultList();
			return itemValueList;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.016"), ex);
			throw new BusinessException(6900102,
					"No se pudo obtener los valores para la renderización.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getItemsValuesForItemsByProduct"));
			}
		}
	}

	// end-region

	// region ItemsAppliesWay
	/**
	 * Find all <tt>WhenApplyNodeType</tt>
	 * 
	 * @return List of <tt>WhenApplyNodeType</tt>
	 */
	public List<WhenApplyNodeType> getWhenApplyNodeType() {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getWhenApplyNodeType"));
			}
			
			List<WhenApplyNodeType> whenApplyNodeTypes = null;
			whenApplyNodeTypes = entityManager.createNamedQuery(
					"WhenApplyNodeType.findAll", WhenApplyNodeType.class)
					.getResultList();

			for (WhenApplyNodeType whenApplyNodeType : whenApplyNodeTypes) {
				whenApplyNodeType.getAppliesToList().size();
			}

			return whenApplyNodeTypes;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.040"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getWhenApplyNodeType"));
			}
		}
	}

	public AppliesToWhenApply getAppliesToWhenApply(AppliesToWhenApplyId id) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getAppliesToWhenApply"));
			}
			return entityManager.find(AppliesToWhenApply.class, id);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.041"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getAppliesToWhenApply"));
			}
		}
	}

	// end-region

	// region AmountItemValue

	/**
	 * Get the list for <tt>AmountItemValue</tt>.
	 * 
	 * @param amountItemValueId
	 *            the amount item value id
	 * @return List for <tt>AmountItemValue</tt>
	 */
	public List<AmountItemValue> getAmountItemValues(
			AmountItemValueId amountItemValueId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getAmountItemValues"));
			}
			
			return entityManager
					.createNamedQuery("AmountItemValue.findAllById",
							AmountItemValue.class)
					.setParameter("appliesWayId",
							amountItemValueId.getAppliesWayId())
					.setParameter(
							PROD_ID_PARAMETER,
							amountItemValueId.getCurrencyProductId()
									.getProductId()).getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.020",
					amountItemValueId), ex);
			throw new BusinessException(6900106,
					"No se pudo obtener los valores de montos del rubro");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getAmountItemValues"));
			}
		}
	}

	/**
	 * Delete amount item values.
	 * 
	 * @param itemAppliesWayId
	 *            the item applies way id
	 * @param productId
	 *            the product id
	 * @throws Exception
	 *             the exception
	 */

	public void deleteAmountItems(ArrayList<AmountItemValue> amountItemValues) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"deleteAmountItems"));
			}
			
			deleteAmountItemsOperation(amountItemValues);
			// Se elimina los AmountItemValue replicando la eliminación del
			// padre

			long itemId = entityManager
					.createNamedQuery("ItemAppliesWay.findItemId", Long.class)
					.setParameter(
							"appliesWayId",
							amountItemValues.get(0).getAmountItemValuesId()
									.getAppliesWayId())
					.setParameter(
							"productId",
							amountItemValues.get(0).getAmountItemValuesId()
									.getCurrencyProductId().getProductId())
					.getSingleResult();

			replicateDeleteAmountItems(amountItemValues, itemId);
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.023"), ex);
			throw new BusinessException(6900109,
					"No se pudo al eliminar todos los valores de montos asociados al rubro");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"deleteAmountItems"));
			}
		}
	}

	// end-region

	// region General Items By Product

	/**
	 * Save information for items by product
	 * 
	 * @param itemByProductId
	 *            identifier <tt>ItemByProductId</tt>
	 * @param manageItemsValues
	 *            list of <tt>ItemsValues</tt>
	 * @param itemByProductParam
	 *            <tt>ItemByProduct</tt>
	 * @param operation
	 *            identifier of operation
	 * @param itemAppliesWay
	 *            <tt>ItemAppliesWay</tt>
	 * @param amountItemValueList
	 *            list of <tt>AmountItemValue</tt>
	 * @param available
	 *            state
	 */
	public Long saveItemsInformation(ItemByProductId itemByProductId,
			ArrayList<ItemsValues> manageItemsValues,
			ItemByProduct itemByProductParam, String operation,
			ItemAppliesWay itemAppliesWay,
			ArrayList<AmountItemValue> amountItemValueList) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"saveItemsInformation"));
			}

			List<ItemsValues> itemsValuesExist = getItemsValuesForItemsByProduct(itemByProductId);
			ArrayList<ItemsValues> itemsReplicateValues = new ArrayList<ItemsValues>();

			for (ItemsValues manageItemsValue : manageItemsValues) {
				itemsReplicateValues.add(manageItemsValue);
			}

			for (ItemsValues itemsExistValue : itemsValuesExist) {
				if (!itemsReplicateValues.contains(itemsExistValue)) {
					ItemsValues itemValuesUpdate = itemsExistValue;
					itemValuesUpdate.setValue("");
					itemsReplicateValues.add(itemValuesUpdate);
				}
			}

			long itemAppliesWayId = saveItemsInformationOperation(
					itemByProductId, itemsReplicateValues, itemByProductParam,
					operation, itemAppliesWay, amountItemValueList, true);
			if (itemByProductParam.getBankingProduct().getNodeTypeCategory()
					.getNodeTypeProduct().getId() != 5) {
				replicateItemsInformationForChildren(itemByProductId,
						itemsReplicateValues, itemByProductParam, operation,
						itemAppliesWay, amountItemValueList);
			}

			return itemAppliesWayId;

		} catch (Exception e) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.030",
					itemByProductId), e);
			throw new BusinessException(6900116,
					"No se pudo almacenar la información para el rubro");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"saveItemsInformation"));
			}
		}
	}

	/**
	 * Delete information for <tt>ItemByProduct</tt>.
	 * 
	 * @param itemAppliesWayId
	 *            the item applies way id
	 * @param itemByProductId
	 *            the item by product id
	 */
	public void deleteInformationForItemByProduct(
			ItemByProductId itemByProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"deleteInformationForItemByProduct"));
			}
			
			long itemAppliesWayId = -1;

			ItemByProduct mItemByProduct = getItemByProduct(itemByProductId);

			if (mItemByProduct != null
					&& mItemByProduct.getItemAppliesWaysList() != null
					&& !mItemByProduct.getItemAppliesWaysList().isEmpty()) {
				itemAppliesWayId = mItemByProduct.getItemAppliesWaysList()
						.get(0).getAppliesWayId();
			}
			deleteInformationForItemByProductOperation(itemAppliesWayId,
					itemByProductId);
			replicateDeleteInformationForItemByProduct(itemByProductId);

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.025",
					itemByProductId), ex);
			throw new BusinessException(
					6900111,
					"No se pudo al momento de eliminar el rubro, puesto que esta tiene información relacionada.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"deleteInformationForItemByProduct"));
			}
		}
	}

	/**
	 * Copy the information from the parent.
	 * 
	 * @param currentBankingProduct
	 *            the current banking product
	 */
	public void copyDataItemByProductFromParent(
			BankingProduct currentBankingProduct) {

		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"copyDataItemByProductFromParent"));
			}
			
			String bankingProduct = currentBankingProduct.getId();
			List<ItemByProduct> itemsByProductList = getAllDataForItemsByProduct(currentBankingProduct
					.getParentnode());
			if (itemsByProductList != null && itemsByProductList.size() > 0) {
				copyData(itemsByProductList, bankingProduct);
			}
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.099"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"copyDataItemByProductFromParent"));
			}
		}
	}

	/**
	 * Verified if Banking Product is available or not
	 * 
	 * @param bankingProductId
	 *            the banking product id
	 */
	public Map<String, Boolean> itemsIsAvailable(String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){	
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"itemsIsAvailable"));
			}
			
			// boolean breakFor = false;
			boolean capital = false;
			boolean interest = false;
			boolean overdue = false;

			boolean capitalInterestOverdue = true;
			boolean requieredItemsParameters = true;
			boolean requieredAppliesWay = true;
			boolean currencyByItems = true;
			boolean periodByItems = true;
			boolean requiredCompleteConfiguration = true;

			Map<String, Boolean> checkItemsIsAvailable = new HashMap<String, Boolean>();

			BankingProduct bankingProduct = bankingProductManager
					.getBankingProductBasicInformationById(bankingProductId);

			int currencies = bankingProduct.getCurrencyProducts().size();

			for (CurrencyProduct currencyProduct : bankingProduct
					.getCurrencyProducts()) {
				if (currencyProduct.getStatus() != null
						&& !currencyProduct.getStatus().equals(Constants.YES))
					currencies--;
			}

			// get all items configurate by banking product
			List<ItemByProduct> itemsByproductList = getAllDataForItemsByProduct(bankingProductId);

			if(logger.isDebugEnabled()){
				logger.logDebug("CAPITAL INTERES" + itemsByproductList);
			}
			
			if (itemsByproductList.size() < 3) {

				if (capitalInterestOverdue) {
					capitalInterestOverdue = false;
				}

			} else {

				for (ItemByProduct itemByProduct : itemsByproductList) {

					if(logger.isDebugEnabled()){
						logger.logDebug(MessageManager.getString(
							"ITEMSMANAGER.043", itemByProduct.getItem()
									.getName(), itemByProduct.getByProductId()
									.getItemId()));
					}

					if (!isAllFieldsConfig(itemByProduct.getByProductId()
							.getProductId(), itemByProduct.getByProductId()
							.getItemId(), itemByProduct.getItem()
							.getDicAssociate())) {

						if (requieredItemsParameters)
							requieredItemsParameters = false;

						if(logger.isDebugEnabled()){
							logger.logDebug(MessageManager
								.getString("ITEMSMANAGER.046"));
						}
					}

					// Verified that the banking product contains minimus 3
					// items corresponds to (C, I, M)
					String typeItem = null;

					if (itemByProduct.getItemType() != null) {
						typeItem = itemByProduct.getItemType().trim();

						if(logger.isDebugEnabled()){
							logger.logDebug(MessageManager.getString(
								"ITEMSMANAGER.047", typeItem));
						}

						if (typeItem.equals("C")) {
							capital = true;
						} else if (typeItem.equals("I")) {
							interest = true;
						} else if (typeItem.equals("M")) {
							overdue = true;
						}
					} else {
						if (requiredCompleteConfiguration) {
							requiredCompleteConfiguration = false;
						}
					}

					if (typeItem != null && !typeItem.equals("C")) {
						// star code

						if (itemByProduct.getItemAppliesWaysList().size() == 0) {

							if(logger.isDebugEnabled()){
								logger.logDebug(MessageManager
									.getString("ITEMSMANAGER.048"));
							}

							if (requieredAppliesWay)
								requieredAppliesWay = false;
						} else {

							for (ItemAppliesWay itemAppliesWay : itemByProduct
									.getItemAppliesWaysList()) {

								// Verify that the configuration is for all
								// currency
								if (itemAppliesWay.getItemValuesList() != null) {

									if (RATE.contains(itemByProduct
											.getItemType().trim())) {

										int amountCount = 0;

										for (AmountItemValue amount : itemAppliesWay
												.getItemValuesList()) {
											if (amount.getCurrencyProduct()
													.getStatus()
													.equals(Constants.YES))
												amountCount++;
										}

										if (amountCount == currencies) {
											for (AmountItemValue amountItemValue : itemAppliesWay
													.getItemValuesList()) {

												if (RATE.contains(itemByProduct
														.getItemType().trim())) {
													if (amountItemValue
															.getTypeReadJustment()
															.trim().equals("S")
															|| amountItemValue
																	.getTypeReadJustment()
																	.trim()
																	.equals("F")) {
														if (amountItemValue
																.getPeriodReadJustment() <= 0) {
															if(logger.isDebugEnabled()){
																logger.logDebug(MessageManager
																	.getString("ITEMSMANAGER.045"));
															}

															if (periodByItems) {
																periodByItems = false;
															}
														}
													}
												}
											}

										} else {
											if(logger.isDebugEnabled()){
												logger.logDebug(MessageManager
													.getString("ITEMSMANAGER.044"));
											}
											
											if (currencyByItems) {
												currencyByItems = false;
											}
										}
									} else {
										if (itemAppliesWay.getItemValuesList()
												.size() == 0) {
											if(logger.isDebugEnabled()){
												logger.logDebug(MessageManager
													.getString("ITEMSMANAGER.044"));
											}
											
											if (currencyByItems) {
												currencyByItems = false;
											}
										}

									}

								} else {
									if(logger.isDebugEnabled()){
										logger.logDebug(MessageManager
											.getString("ITEMSMANAGER.044"));
									}
									
									if (currencyByItems) {
										currencyByItems = false;
									}
								}
							}

						}

					}
				}
			}

			if (!capital || !interest || !overdue) {
				capitalInterestOverdue = false;
			}

			checkItemsIsAvailable.put(Constants.REQUIRED_CIO,
					capitalInterestOverdue);
			checkItemsIsAvailable.put(Constants.REQUIRED_PI,
					requieredItemsParameters);
			checkItemsIsAvailable.put(Constants.REQUIRED_APPLICATION_WAY,
					requieredAppliesWay);
			checkItemsIsAvailable.put(Constants.CURRENCY_BY_ITEMS,
					currencyByItems);
			checkItemsIsAvailable.put(Constants.PERIOD_BY_ITEMS, periodByItems);
			checkItemsIsAvailable.put(Constants.REQUIRED_CONFIGURATION_ITEM,
					requiredCompleteConfiguration);

			return checkItemsIsAvailable;

		} catch (BusinessException be) {
			throw be;
		} catch (Exception e) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.028",
					bankingProductId), e);
			throw new BusinessException(
					6900114,
					"No se pudo verificar si la información se encuentra completa para los rubros del producto.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"itemsIsAvailable"));
			}
		}
	}

	/**
	 * Update value for rate change and special change for product.
	 * 
	 * @param bankingProductId
	 *            the banking product id
	 * @param typeReadJustment
	 *            the value rate change
	 * @param typeSpecialReadJustment
	 *            the value special change
	 */
	public void updateReadjustmentForProduct(String bankingProductId,
			String typeReadJustment, String periodReadJustment,
			String typeSpecialReadJustment) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"updateReadjustmentForProduct"));
			}
			
			List<ItemByProduct> itemsByProduct = this
					.getItemsByProduct(bankingProductId);

			for (ItemByProduct itemByProduct : itemsByProduct) {

				if (itemByProduct.getItemType() != null
						&& RATE.contains(itemByProduct.getItemType().trim())) {
					if (itemByProduct.getItemAppliesWaysList().size() > 0) {
						List<AmountItemValue> amountItemValueList = itemByProduct
								.getItemAppliesWaysList().get(0)
								.getItemValuesList();

						for (AmountItemValue amountItemValue : amountItemValueList) {

							if (typeReadJustment == null
									|| typeReadJustment.trim().equals(COBIS_NO)) {

								amountItemValue.setTypeReadJustment(COBIS_NO);
								amountItemValue.setPeriodReadJustment(0);
								amountItemValue.setFormReadJustment(null);
								amountItemValue.setReferenceRateReadJustment(null);

							} else {
								amountItemValue
										.setTypeReadJustment(typeReadJustment);
								amountItemValue.setPeriodReadJustment(Long
										.parseLong(periodReadJustment));
								amountItemValue
										.setFormReadJustment(typeSpecialReadJustment
												.trim());

							}
						}
					}
				}
			}

			List<BankingProduct> bankingProductList = entityManager
					.createNamedQuery(FIND_BANKING_Q, BankingProduct.class)
					.setParameter(BAN_ID_PARAMETER, bankingProductId)
					.getResultList();

			if(logger.isDebugEnabled()){
				logger.logDebug("________LISTA DE PRODUCTOS " + bankingProductList
					+ " SIZE " + bankingProductList.size());
			}

			for (BankingProduct bankingProduct : bankingProductList) {
				updateReadjustmentForProduct(bankingProduct.getId(),
						typeReadJustment, periodReadJustment,
						typeSpecialReadJustment);
			}

			entityManager.flush();

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.037"), ex);
			throw new BusinessException(6900123,
					"No se pudo actualizar el reajuste de tasa");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"updateReadjustmentForProduct"));
			}
		}
	}

	/**
	 * Gets the <tt>ValuePortfolio</tt>.
	 * 
	 * @return List <tt>ValuePortfolio</tt>
	 */
	public List<RateValue> getRateValue(String bankingProductId) {

		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getRateValue"));
			}
			
			List<RateValue> rateValueList = new ArrayList<RateValue>();
			return rateValueList;

		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getRateValue"));
			}
		}
	}

	/**
	 * Get the list for <tt>RateReferenceValue</tt>.
	 * 
	 * @param bankingProductId
	 * @return List for <tt>RateReferenceValue</tt>
	 */
	public List<RateReferenceValue> getRateReferenceValue(
			String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getRateReferenceValue"));
			}
			
			List<RateReferenceValue> rateReferenceValueList = new ArrayList<RateReferenceValue>();

			return rateReferenceValueList;

		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getRateReferenceValue"));
			}
		}
	}

	/**
	 * Delete registry in struct from modules
	 * 
	 * @param operation
	 *            Banking Product Id
	 */
	public void deleteItemByOperationReplication(String operation) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"deleteItemPortfolioByOperation"));
			}
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"deleteItemPortfolioByOperation"));
			}
		}
	}

	/**
	 * Get change rate
	 * 
	 * @param bankingProductId
	 * @return Value corresponding to change rate
	 */
	public String getChangeRate(String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getChangeRate"));
			}

			return null;

		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getChangeRate"));
			}
		}
	}

	/**
	 * Get special change rate
	 * 
	 * @param bankingProductId
	 * @return Value corresponding to special change rate
	 */
	public String getSpecialChangeRate(String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getSpecialChangeRate"));
			}

			return null;

		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getSpecialChangeRate"));
			}
		}
	}

	/**
	 * Get period change rate
	 * 
	 * @param bankingProductId
	 * @return Value corresponding to special change rate
	 */
	public String getPeriodChangerate(String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getPeriodChangerate"));
			}

			return null;

		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getPeriodChangerate"));
			}
		}
	}

	// end-region

	// region Items History

	/**
	 * Create a new registry for history of items by product.
	 * 
	 * @param bankingProductHistoryId
	 *            Banking peroduct identifier
	 */
	public void createItemsHistory(
			BankingProductHistory bankingProductHistorId,
			String authorizationStatus) {
		BankingProductHistory bph=new BankingProductHistory();
		
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"createItemsHistory(String productId, Date date)"));
			}
			
			bph=entityManager.find(BankingProductHistory.class, bankingProductHistorId.getId());
			Date processDate = getProcessDate();

			if (processDate == null) {
				processDate = new Date();
			}
			List<ItemByProduct> itemByProductList = getAllDataForItemsByProduct(bph
					.getProductId());

			if (processDate != null) {
				for (ItemByProduct itemByProduct : itemByProductList) {
					insertItemByProductHistory(itemByProduct,
							bph.getId());
							
					insertItemValuesHistory(itemByProduct.getByProductId()
							.getProductId(), itemByProduct.getByProductId()
							.getItemId(), itemByProduct.getItemsValuesList(),
							bph.getId());
					
					if (itemByProduct.getItemAppliesWaysList() != null
							&& itemByProduct.getItemAppliesWaysList().size() > 0) {
						insertItemAppliesWayHistory(itemByProduct
								.getByProductId().getProductId(), itemByProduct
								.getByProductId().getItemId(), itemByProduct
								.getItemAppliesWaysList().get(0),
			
								processDate,bph.getId());
						insertAmountItemValueHistory(itemByProduct
								.getByProductId().getProductId(), itemByProduct
								.getByProductId().getItemId(), itemByProduct
								.getItemAppliesWaysList().get(0)
								.getItemValuesList(),
								
								processDate,bph.getId());
						
					}
				}
			}
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.027",
					bph.getProductId()), eee);
			throw new BusinessException(
					6900113,
					"No se pudo insertar los hist�ricos para los rubros del producto, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.026",
					bph.getProductId()), ex);
			throw new BusinessException(6900112,
					"No se pudo insertar los hist�ricos para los rubros del producto seleccionado");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"createItemsHistory(String productId, Date date)"));
			}
		}
	}

	/**
	 * Gets the history records for <tt>ItemByProduct</tt>.
	 * 
	 * @param operationDate
	 *            the date history
	 * @param bankingProductId
	 *            the banking product id
	 * @param currencyId
	 *            the currency id
	 * @return the history records
	 */		
	public List<HashMap<String, Object>> getHistory(Date operationDate, String bankingProductId, Long currencyId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getHistory"));
			}
			
			List<HashMap<String, Object>> historiesList = new ArrayList<HashMap<String, Object>>();
		
			Calendar calendarOperationDate = Calendar.getInstance();
			calendarOperationDate.setTime(operationDate);
			calendarOperationDate.set(Calendar.MILLISECOND, 0);
			calendarOperationDate.set(Calendar.SECOND, 0);
			calendarOperationDate.set(Calendar.MINUTE, 0);
	        calendarOperationDate.set(Calendar.HOUR, 0);
	        
	        BankingProductHistory bankingProductHistory = entityManager
			.createNamedQuery(
					"BankingProductHistory.FindByDateAndProductOpt",
					BankingProductHistory.class)
			.setParameter("systemDateId", calendarOperationDate.getTime())
			.setParameter("productId", bankingProductId)
			.getSingleResult(); 
	        
	        Long bphistoryId = null;
	        if (bankingProductHistory != null){
	        	bphistoryId = bankingProductHistory.getId(); 
	        }
	        
	        if (bphistoryId == null) {
				logger.logError(MessageManager.getString(
						"BANKINGPRODUCTMANAGER.007", bankingProductId));
				throw new BusinessException(6900060,
						"No se pudo obtener el id del producto bancario en los datos históricos");
			}
	        
			List<ItemByProductHistory> itemsByProductHistoryList = this
					.getItemByProductHistory(bphistoryId);
			
			
			Long categoryId = bankingProductManager
					.getCategoryIdKeepDictionaryFromParents(bankingProductId);
			
			if (null == categoryId || categoryId == 0) {
				logger.logError(MessageManager.getString(
						"BANKINGPRODUCTMANAGER.007", bankingProductId));
				throw new BusinessException(6900060,
						"No se pudo obtener el producto bancario indicado, puesto que no existe");
			}

			
			//OGU: Obtengo la lista de todos los registros itemAppliesWayHistories por producto
			List<ItemAppliesWayHistory> itemAppliesWayHistories = this
					.getItemAppliesWayHistoryOpt(bphistoryId,
							bankingProductId);
			//OGU: Obtengo la lista de todos los registros AmountItemValueHistory por producto
			List<AmountItemValueHistory> amountItemValueHistories =  getAmountItemValueHistoryOpt(bphistoryId, currencyId.toString());
			

			long time_start, time_end;
			
			for (ItemByProductHistory itemByProductHistory : itemsByProductHistoryList) {
				HashMap<String, Object> history = new HashMap<String, Object>();
				// ItemsByProductHistory
				history.put(Constants.ITEMS_BY_PRODUCT, itemByProductHistory);
				
				time_start = System.currentTimeMillis();	
				List<Object[]> itemsValuesHistoryList = this
						.getItemsValuesHistoryOpt(bphistoryId, 
								itemByProductHistory.getItemIdentifier());
				time_end = System.currentTimeMillis();
				
				logger.logError("CONSULTA HISTORICOS DE RUBROS --> " + ( time_end - time_start ) +" milliseconds");
				
				HashMap<String, ItemValueInformation> itemsValues = new HashMap<String, ItemValueInformation>();
				
				for (Object[] itemsValuesHistory : itemsValuesHistoryList) {
	
					
					BigDecimal fieldId = new BigDecimal(0);
					if(itemsValuesHistory[0] instanceof BigDecimal) {
						fieldId = (BigDecimal) itemsValuesHistory[0];
					}    
					Object[] physicalName = getFields(categoryId,
					Constants.ITEMS_DICTIONARY,
					itemByProductHistory.getItemIdentifier(),
					fieldId.longValue());

					if (physicalName != null) {

						ItemValueInformation itemValueInformation = new ItemValueInformation(
								(String) physicalName[0],
								(String) physicalName[2],
								(String) physicalName[3],
								(String) physicalName[1],
								itemsValuesHistory[1].toString());

						itemsValues.put((String) physicalName[0],
								itemValueInformation);
					}
				}
				// ItemsValues
				history.put(Constants.ITEMS_VALUES, itemsValues);

				//OGU: Método utilitario que me permite obtener un registro de una lista.
				ItemAppliesWayHistory itemAppliesWayHistory = getItemAppliesWay(itemAppliesWayHistories, itemByProductHistory.getItemIdentifier());
				
				if (itemAppliesWayHistory != null) {
					// ItemsAppliesWay
					history.put(Constants.ITEMS_APPLIES_WAY,
							itemAppliesWayHistory);
					// AmountItemsValues
					history.put(Constants.AMOUNT_ITEMS_VALUES, getAmountItemValues(amountItemValueHistories, itemAppliesWayHistory.getAppliesWayId()));
					
					
				} else {
					history.put(Constants.ITEMS_APPLIES_WAY, null);
					history.put(Constants.AMOUNT_ITEMS_VALUES, null);
				}

				historiesList.add(history);
			}

			if(logger.isDebugEnabled()){
				logger.logDebug("HISTORICOLIST " + historiesList);
			}
			
			return historiesList;
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.035",
					bankingProductId), ex);
			throw new BusinessException(6900121,
					"No se pudo obtener los históricos para el rubros por producto seleccionado");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getHistory"));
			}
		}
	}

	
	
	private List<HashMap<String, Object>> getLastItemsHistory(
			String bankingProductId) {

		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getLastItemsHistory"));
			}

			// Keep history data from ItemByProduct
			List<HashMap<String, Object>> historiesList = new ArrayList<HashMap<String, Object>>();

			// Get last historical banking product
			BankingProductHistory productManagerHistory = bankingProductManager
					.getLatestHistorical(bankingProductId);


//					productManagerHistory.getSystemDateId(), bankingProductId);
			BankingProductHistory bankingProductHistory=new BankingProductHistory();
			bankingProductHistory.setProductId(bankingProductId);
			bankingProductHistory.setSystemDateId(productManagerHistory.getSystemDateId());
			entityManager.persist(bankingProductHistory);


			return getSpecificItemsHistory(bankingProductHistory);
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.035",
					bankingProductId), ex);
			throw new BusinessException(6900121,
					"No se pudo obtener los históricos para el rubros por producto seleccionado");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getLastItemsHistory"));
			}
		}
	}

	private List<HashMap<String, Object>> getSpecificItemsHistory(
			BankingProductHistory bankingProductHistory) {

		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getSpecificItemsHistory"));
			}

			// Keep history data from ItemByProduct
			List<HashMap<String, Object>> historiesList = new ArrayList<HashMap<String, Object>>();

			// Get list Items associate to product
			List<ItemByProductHistory> itemsByProductHistoryList = this
					.getItemByProductHistory(bankingProductHistory.getId());
			

			// Go around the list ItemByProduct and get data asosociate to Item
			// by Product
			for (ItemByProductHistory itemByProductHistory : itemsByProductHistoryList) {
				HashMap<String, Object> history = new HashMap<String, Object>();

				// Put ItemsByProductHistory object in the map
				history.put(Constants.ITEMS_BY_PRODUCT, itemByProductHistory);

				// Get a list of ItemsValuesHistory object associate to item
				List<ItemsValuesHistory> itemsValuesHistoryList = this
						.getItemsValuesHistory(
								bankingProductHistory.getId(),
								
								itemByProductHistory.getItemIdentifier());

				// Put the list of ItemsValuesHistory associate to item
				history.put(Constants.ITEMS_VALUES, itemsValuesHistoryList);

				// Get ItemAppliesWayHistory object associate to item
				ItemAppliesWayHistory itemAppliesWayHistory = this
						.getItemAppliesWayHistory(
								bankingProductHistory.getId(),
								bankingProductHistory.getProductId(),
								itemByProductHistory.getItemIdentifier());

				if (itemAppliesWayHistory != null) {

					// Put ItemsAppliesWay object asscoate to item
					history.put(Constants.ITEMS_APPLIES_WAY,
							itemAppliesWayHistory);

					// Get List AmountItemValuesHistory an Put in the map
					history.put(Constants.AMOUNT_ITEMS_VALUES, this
							.getListAmountItemValueHistory(
									bankingProductHistory.getId(),
									itemAppliesWayHistory.getAppliesWayId(),
									bankingProductHistory.getProductId()));
					
				} else {
					throw new BusinessException(
							6900121,
							"Exitió un error al momento de recuperar la información del histórico asociado al producto");
				}

				historiesList.add(history);
			}

			return historiesList;
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.035",
					bankingProductHistory.getProductId()), ex);
			throw new BusinessException(6900121,
					"No se pudo obtener los históricos para el rubros por producto seleccionado");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getSpecificItemsHistory"));
			}
		}
	}

	/**
	 * Get the last date existing in the ItemByProductHistory entity
	 * 
	 * @return Last date existing in the ItemByProductHistory entity
	 */
	private Date findLastDateHistory() {
		return entityManager.createNamedQuery(
				"ItemByProductHistory.findFinalDateHistory", Date.class)
				.getSingleResult();
	}

	/**
	 * Revert change existing in the intermediate entities items
	 */
	public void restoreItems(Long bankingProductHistory) {
		BankingProductHistory bphistory=new BankingProductHistory();
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"revertChangesItems"));
			}
			
			bphistory=entityManager.find(BankingProductHistory.class, bankingProductHistory);

			List<ItemByProduct> itemByProductIntermediate = getItemsByProduct(bphistory
					.getProductId());

			// Delete registry existing in the intermediate entities items
			for (ItemByProduct itemByProduct : itemByProductIntermediate) {
				deleteInformationForItemByProduct(itemByProduct
						.getByProductId());
			}

			// Get the last data history of items by product
			List<HashMap<String, Object>> itemsByproductData = getLastItemsHistory(bphistory
					.getProductId());

			for (HashMap<String, Object> hashMap : itemsByproductData) {

				// Get ItemByProductHistory object
				ItemByProductHistory itemByProductHistory = (ItemByProductHistory) hashMap
						.get(Constants.ITEMS_BY_PRODUCT);

				// Get item object corresponds to itemByProductHistory
				// identifier
				Item item = getItem(itemByProductHistory.getItemIdentifier());

				if (item != null) {

					// Create ItemByProduct object with the data of history
					ItemByProduct itemByProduct = new ItemByProduct(
							new ItemByProductId(itemByProductHistory
									.getBankingProductHistory().getProductId(),
									itemByProductHistory.getItemIdentifier()),
							itemByProductHistory.getItemType());
					itemByProduct.setItem(item);

					// Save ItemByProduct object
					insertItemByProduct(itemByProduct);

					List<ItemsValuesHistory> itemsValuesHistoryList = (List<ItemsValuesHistory>) hashMap
							.get(Constants.ITEMS_VALUES);

					List<ItemsValues> itemsValuesList = new ArrayList<ItemsValues>();
					for (ItemsValuesHistory itemsValuesHistory : itemsValuesHistoryList) {
						// Save ItemsValues object
						ItemsValues itemsValues = new ItemsValues(
								itemsValuesHistory.getDictionaryFieldId(),
								itemsValuesHistory.getItemByProductHistory()
										.getBankingProductHistory()
										.getProductId(),
								itemByProductHistory.getItemIdentifier(),
								itemsValuesHistory.getValue());
						itemsValues.setItemByProduct(itemByProduct);

						itemsValuesList.add(itemsValues);

					}

					// Save ItemsValues objects
					manageItemsValuesForItemsByProduct(
							itemByProduct.getByProductId(),
							(ArrayList) itemsValuesList);

					// Get ItemAppliesWayHistory objectc
					ItemAppliesWayHistory itemAppliesWayHistory = (ItemAppliesWayHistory) hashMap
							.get(Constants.ITEMS_APPLIES_WAY);

					// Create ItemAppliesWay object
					ItemAppliesWay itemAppliesWay = new ItemAppliesWay(
							itemAppliesWayHistory.getItemIncluded(),
							itemAppliesWayHistory.getItemReference());
					itemAppliesWay.setItemsByProduct(itemByProduct);

					// Save ItemAppliesWay objects
					long itemAppliesWayIdentifier = manageItemAppliesWay(
							itemByProduct.getByProductId().getProductId(),
							itemAppliesWay);

					List<AmountItemValueHistory> AmountItemValueHistoryList = (List<AmountItemValueHistory>) hashMap
							.get(Constants.AMOUNT_ITEMS_VALUES);

					List<AmountItemValue> amountItemValueList = new ArrayList<AmountItemValue>();
					for (AmountItemValueHistory amountItemValueHistory : AmountItemValueHistoryList) {

						// Create CurrencyProductId object
						CurrencyProductId currencyProductId = new CurrencyProductId(
								amountItemValueHistory.getCurrencyId(),
								amountItemValueHistory
										.getItemAppliesWayHistory()
										.getItemByProductHistory()
										.getBankingProductHistory()
										.getProductId());

						// Create AmountItemValueId object
						AmountItemValueId amountItemValueId = new AmountItemValueId(
								currencyProductId, amountItemValueHistory
										.getItemAppliesWayHistory()
										.getAppliesWayId());

						AmountItemValue amountItemValue = new AmountItemValue(
								amountItemValueId,
								amountItemValueHistory.getAllowReadJustment(),
								amountItemValueHistory.getBaseName(),
								amountItemValueHistory.getBaseReadJustment(),
								amountItemValueHistory.getBaseSign(),
								amountItemValueHistory
										.getBaseSignReadJustment(),
								amountItemValueHistory.getBusinessRule(),
								amountItemValueHistory.getBusinessRuleLimits(),
								amountItemValueHistory.getCurrencyCharge(),
								amountItemValueHistory.getFormReadJustment(),
								amountItemValueHistory.getMaximum(),
								amountItemValueHistory.getMaximumLimit(),
								amountItemValueHistory.getMaximumLimitType(),
								amountItemValueHistory.getMaximumLimitVar(),
								amountItemValueHistory.getMaximumReagJustment(),
								amountItemValueHistory.getMaximumSign(),
								amountItemValueHistory
										.getMaximumSignReadJustment(),
								amountItemValueHistory.getMinimum(),
								amountItemValueHistory.getMinimumLimit(),
								amountItemValueHistory.getMinimumLimitType(),
								amountItemValueHistory.getMinimumLimitVar(),
								amountItemValueHistory.getMinimumReadJustment(),
								amountItemValueHistory.getMinimumSign(),
								amountItemValueHistory
										.getMinimumSignReadJustment(),
								amountItemValueHistory.getPeriodReadJustment(),
								amountItemValueHistory
										.getPeriodTypeReadJustment(),
								amountItemValueHistory.getRangeType(),
								amountItemValueHistory.getRateReadJustment(),
								amountItemValueHistory.getValueReference(),
								amountItemValueHistory.getRateReference(),
								amountItemValueHistory
										.getReferenceRateReadJustment(),
								amountItemValueHistory.getTypeReadJustment(),
								amountItemValueHistory.getUseRange(),
								amountItemValueHistory.getPolicyId(),
								amountItemValueHistory.getPolicyName(),
								amountItemValueHistory.getSp());

						amountItemValueList.add(amountItemValue);
					}
					manageAmountItemValues((ArrayList) amountItemValueList);

				}
			}

		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"revertChangesItems"));
			}
		}
	}

	
	public List<String> getItemLog(
			Long bankingProductHistoryId) {
		BankingProductHistory bphistory=new BankingProductHistory();

		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getItemLog"));
			}

			bphistory=entityManager.find(BankingProductHistory.class, bankingProductHistoryId);			// Get the list item by produt history
			List<ItemByProductHistory> itemByProductHistoryList = getItemByProductHistory(
					bphistory.getId());

			// Create the list by string for save before name items by product
			List<String> beforeNameItemByProduct = new ArrayList<String>();

			for (ItemByProductHistory itemByProductHistory : itemByProductHistoryList) {

				beforeNameItemByProduct
						.add(getItemNameById(itemByProductHistory
								.getItemIdentifier()));
			}

			return beforeNameItemByProduct;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.099"), ex);
			throw new BusinessException(6900090,
					"No se pudo obtener la información de rubros por producto.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getItemLog"));
			}
		}
		
	}

	public Map<String, List<String>> getItemsChanges(String productId) {

		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getItemsChanges"));
			}

			Map<String, List<String>> changes = new HashMap<String, List<String>>();

			// Get list items associate to the banking product
			List<Item> itemList = getItemListByProduct(productId);

			// Create a list of strings
			List<String> afterNameItemByProduct = new ArrayList<String>();

			// Get names of items by product and add in the list
			// afterNameItemByProduct
			for (Item item : itemList) {
				afterNameItemByProduct.add(item.getName());
			}

			// Put the list name in the map, corresponds After
			changes.put(Constants.AFTER_VALUE, afterNameItemByProduct);

			if(logger.isDebugEnabled()){
				logger.logDebug("Numero de parámetros actuales: "
					+ changes.get(Constants.AFTER_VALUE).size());
			}

			BankingProductHistory productManagerHistory = bankingProductManager
					.getLatestHistorical(productId);

			if (productManagerHistory != null) {

				List<String> beforeNameItemByProduct = getItemLog(productManagerHistory.getId());

				// Put the list name in the map, corresponds Before
				changes.put(Constants.BEFORE_VALUE, beforeNameItemByProduct);

				if(logger.isDebugEnabled()){
					logger.logDebug("Numero de parámetros anteriores: "
						+ changes.get(Constants.BEFORE_VALUE).size());
				}
				
				return changes;
			} else {
				// Put the list name in the map, corresponds Before
				changes.put(Constants.BEFORE_VALUE, new ArrayList<String>());

				return changes;
			}

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.099"), ex);
			throw new BusinessException(6900164,
					"Ocurrio un error al obtener los cambios de los rubros asociados al producto.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getItemsChanges"));
			}
		}
	}

	public ItemLog getItemByProductLog(
			Long bankingProductHistory) {

		BankingProductHistory bphistory=new BankingProductHistory();
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getItemsByProductLog"));
			}
			
			bphistory=entityManager.find(BankingProductHistory.class, bankingProductHistory);

			// Get the last data history of items by product
			List<HashMap<String, Object>> itemsByproductData = getSpecificItemsHistory(bphistory);

			List<ItemParameterValueLog> beforeParametersList = new ArrayList<ItemParameterValueLog>();
			List<ApplicationFormsLog> beforeApplicationFormsList = new ArrayList<ApplicationFormsLog>();
			List<ChangeRateLog> beforeChangeRatesList = new ArrayList<ChangeRateLog>();
			List<AmountItemValueLog> beforeAmItemValuesList = new ArrayList<AmountItemValueLog>();

			for (HashMap<String, Object> hashMap : itemsByproductData) {
				ItemByProductHistory byProductHistory = (ItemByProductHistory) hashMap
						.get(Constants.ITEMS_BY_PRODUCT);
				List<ItemsValuesHistory> itemsValuesHistoryList = (List<ItemsValuesHistory>) hashMap
						.get(Constants.ITEMS_VALUES);
				ItemAppliesWayHistory itemAppliesWayHistory = (ItemAppliesWayHistory) hashMap
						.get(Constants.ITEMS_APPLIES_WAY);
				List<AmountItemValueHistory> amountItemValueHistoryList = (List<AmountItemValueHistory>) hashMap
						.get(Constants.AMOUNT_ITEMS_VALUES);

				// Get items values
				for (ItemsValuesHistory itemsValuesHistory : itemsValuesHistoryList) {

					DictionaryField field = entityManager.find(
							DictionaryField.class,
							itemsValuesHistory.getDictionaryFieldId());
					FieldValue fv = CatalogUtils.getFieldValueList(
							field.getFieldvalues(),
							itemsValuesHistory.getValue());

					// Create ItemParameterValueLog object
					ItemParameterValueLog beforeParameterValueLog = new ItemParameterValueLog(
							getItemNameById(byProductHistory
									.getItemIdentifier()),
							field.getName(), itemsValuesHistory.getValue(),
							fv == null ? "" : fv.getDescription());

					// Add parameterValueLog object to list afterParametersList
					beforeParametersList.add(beforeParameterValueLog);
				}

				// Find AppliesToWhenApply object from AppliesToWhenApplyId
				// object
				AppliesToWhenApplyId appliesToWhenApplyId = new AppliesToWhenApplyId(
						itemAppliesWayHistory.getAppliesTo(),
						itemAppliesWayHistory.getApplyNodeType());
				AppliesToWhenApply appliesToWhenApply = entityManager.find(
						AppliesToWhenApply.class, appliesToWhenApplyId);

				// Create ApplicationFormsLog object
				ApplicationFormsLog beforeApplicationFormsLog = new ApplicationFormsLog(
						getItemNameById(byProductHistory.getItemIdentifier()),
						itemAppliesWayHistory.getItemReference(),
						appliesToWhenApply.getAppliesTo().getDescription(),
						appliesToWhenApply.getWhenApplyNodeType()
								.getApplyNodeTypeDescription(),
						itemAppliesWayHistory.getItemIncluded() == "S" ? true
								: false);

				// Add applicationFormsLog object to list
				// afterApplicationFormsList
				beforeApplicationFormsList.add(beforeApplicationFormsLog);

				for (AmountItemValueHistory amountItemValueHistory : amountItemValueHistoryList) {

					// Create ChangeRateLog object
					ChangeRateLog beforeChangeRateLog = new ChangeRateLog(
							getItemNameById(byProductHistory
									.getItemIdentifier()),
							getCatalogName("fp_reajuste",
									amountItemValueHistory
											.getTypeReadJustment()),
							amountItemValueHistory.getPeriodReadJustment(),
							getCatalogName("fp_forma_reajuste",
									amountItemValueHistory
											.getFormReadJustment()),
							amountItemValueHistory.getRateReadJustment());

					// Add changeRateLog object to list afterChangeRatesList
					beforeChangeRatesList.add(beforeChangeRateLog);

					// Create AmountItemValueLog object
					AmountItemValueLog beforeAmountItemValueLog = new AmountItemValueLog(
							getItemNameById(byProductHistory
									.getItemIdentifier()),
							getCurrencyName(amountItemValueHistory
									.getCurrencyId()),
							getCurrencyName(amountItemValueHistory
									.getCurrencyCharge()),
							amountItemValueHistory.getValueReference(),
							amountItemValueHistory.getPolicyName(),
							amountItemValueHistory.getSp());

					// Add amountItemValueLog object to list
					// afterAmItemValuesList
					beforeAmItemValuesList.add(beforeAmountItemValueLog);
				}

			}

			// Create ItemLog object
			ItemLog beforeItemLog = new ItemLog(beforeParametersList,
					beforeApplicationFormsList, beforeChangeRatesList,
					beforeAmItemValuesList);

			return beforeItemLog;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.099"), ex);
			throw new BusinessException(6900090,
					"No se pudo obtener la información de rubros por producto.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getItemsByProductLog"));
			}
		}
	}

	public Map<String, ItemLog> getItemsByProductChanges(String productId) {

		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getItemsByProductChanges"));
			}

			Map<String, ItemLog> changes = new HashMap<String, ItemLog>();

			// Get all information by itembyproduct;
			List<ItemByProduct> itemByProductList = getAllDataForItemsByProduct(productId);

			List<ItemParameterValueLog> afterParametersList = new ArrayList<ItemParameterValueLog>();
			List<ApplicationFormsLog> afterApplicationFormsList = new ArrayList<ApplicationFormsLog>();
			List<ChangeRateLog> afterChangeRatesList = new ArrayList<ChangeRateLog>();
			List<AmountItemValueLog> afterAmItemValuesList = new ArrayList<AmountItemValueLog>();

			for (ItemByProduct itemByProduct : itemByProductList) {

				// Get items values
				for (ItemsValues itemsValues : itemByProduct
						.getItemsValuesList()) {
					FieldValue fv = CatalogUtils.getFieldValueList(itemsValues
							.getDictionaryField().getFieldvalues(), itemsValues
							.getValue());
					// Create ItemParameterValueLog object
					ItemParameterValueLog parameterValueLog = new ItemParameterValueLog(
							itemByProduct.getItem().getName(), itemsValues
									.getDictionaryField().getName(),
							itemsValues.getValue(), fv == null ? ""
									: fv.getDescription());

					// Add parameterValueLog object to list afterParametersList
					afterParametersList.add(parameterValueLog);
				}

				// Create ApplicationFormsLog object
				ApplicationFormsLog applicationFormsLog = new ApplicationFormsLog(
						itemByProduct.getItem().getName(), itemByProduct
								.getItemAppliesWaysList().get(0)
								.getItemReference(), itemByProduct
								.getItemAppliesWaysList().get(0)
								.getAppliesToWhenApply().getAppliesTo()
								.getDescription(), itemByProduct
								.getItemAppliesWaysList().get(0)
								.getAppliesToWhenApply().getWhenApplyNodeType()
								.getApplyNodeTypeDescription(), itemByProduct
								.getItemAppliesWaysList().get(0)
								.getItemIncluded() == "S" ? true : false);

				// Add applicationFormsLog object to list
				// afterApplicationFormsList
				afterApplicationFormsList.add(applicationFormsLog);

				for (AmountItemValue amountItemValue : itemByProduct
						.getItemAppliesWaysList().get(0).getItemValuesList()) {

					// Create ChangeRateLog object
					ChangeRateLog changeRateLog = new ChangeRateLog(
							itemByProduct.getItem().getName(), getCatalogName(
									"fp_reajuste",
									amountItemValue.getTypeReadJustment()),
							amountItemValue.getPeriodReadJustment(),
							getCatalogName("fp_forma_reajuste",
									amountItemValue.getFormReadJustment()),
							amountItemValue.getRateReadJustment());

					// Add changeRateLog object to list afterChangeRatesList
					afterChangeRatesList.add(changeRateLog);

					// Create AmountItemValueLog object
					AmountItemValueLog amountItemValueLog = new AmountItemValueLog(
							itemByProduct.getItem().getName(),
							getCurrencyName(amountItemValue
									.getCurrencyProduct().getId()
									.getCurrencyId()),
							getCurrencyName(amountItemValue.getCurrencyCharge()),
							amountItemValue.getValueReference(),
							amountItemValue.getPolicyName(), amountItemValue
									.getSp());

					// Add amountItemValueLog object to list
					// afterAmItemValuesList
					afterAmItemValuesList.add(amountItemValueLog);
				}

			}

			// Create ItemLog object
			ItemLog afterItemLog = new ItemLog(afterParametersList,
					afterApplicationFormsList, afterChangeRatesList,
					afterAmItemValuesList);

			// Put ItemLog object
			changes.put(Constants.AFTER_VALUE, afterItemLog);

			if(logger.isDebugEnabled()){
				logger.logDebug("Numero de par�metros actuales: "
					+ changes.get(Constants.AFTER_VALUE).getAmItemValues()
							.size());
			}

			BankingProductHistory productManagerHistory = bankingProductManager
					.getLatestHistorical(productId);

			if (productManagerHistory != null) {

				// Get ItemLog object
				ItemLog beforeItemLog = getItemByProductLog(productManagerHistory.getId());

				// Put the list name in the map, corresponds Before
				changes.put(Constants.BEFORE_VALUE, beforeItemLog);

				if(logger.isDebugEnabled()){
					logger.logDebug("Numero de par�metros anteriores: "
						+ changes.get(Constants.BEFORE_VALUE).getAmItemValues()
								.size());
				}
				
				return changes;
			} else {

				// Put the list name in the map, corresponds Before
				changes.put(Constants.BEFORE_VALUE, new ItemLog(
						new ArrayList<ItemParameterValueLog>(),
						new ArrayList<ApplicationFormsLog>(),
						new ArrayList<ChangeRateLog>(),
						new ArrayList<AmountItemValueLog>()));

				return changes;
			}

		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.099"), ex);
			throw new BusinessException(6900164,
					"Ocurrio un error al obtener los cambios de los rubros asociados al producto.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getItemsByProductChanges"));
			}
		}
	}

	private String getCatalogName(String table, String code) {

		if(logger.isDebugEnabled()){
			logger.logDebug("------- CATLOG " + table + " --" + code);
		}

		if (code != null && !code.trim().equals("")) {
			return catalogManagerService.getCatalog(table.trim(), code.trim())
					.getName();
		} else {
			return null;
		}

	}

	/**
	 * Get currency name for specific code
	 * 
	 * @param code
	 *            currency identifier
	 * @return currency name
	 */
	private String getCurrencyName(String code) {
		String currencyName = null;
		if (code != null) {
			for (Catalog catalog : catalogManagerService.getAllCurrencies()) {
				if (catalog.getCode().trim().equals(code.trim())) {
					currencyName = catalog.getName();
				}
			}
		}
		return currencyName;
	}

	/**
	 * Get item name by item identifier
	 * 
	 * @param itemId
	 *            item identifier
	 * @return item name
	 */
	private String getItemNameById(long itemId) {

		// Get specific item
		Item findItem = getItemOpt(itemId);
		return findItem.getName();

		// List<Item> generalItemList = getItems();
		// String itemName = null;
		//
		// for (Item item : generalItemList) {
		// if (item.getId() == itemId) {
		// itemName = item.getName();
		// break;
		// }
		// }
		// return itemName;
	}

	// end-region

	/**
	 * 
	 * Get count for values associated for any banking product
	 * 
	 * @param dictionaryFieldId
	 *            Dictionary Field Identifier
	 * @param value
	 *            Value for Dictionary Field
	 * @return
	 */
	public long getCountFieldsForItems(long dictionaryFieldId, String value) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getCountFieldsForItems"));
			}
			
			Long associated = entityManager
					.createNamedQuery("ItemsValues.countFindSpecificFields",
							Long.class)
					.setParameter("dictionaryFieldId", dictionaryFieldId)
					.setParameter("value", value).getSingleResult();

			if (associated == 0) {
				associated = entityManager
						.createNamedQuery(
								"ItemsValuesHistory.countFindSpecificFields",
								Long.class)
						.setParameter("dictionaryFieldId", dictionaryFieldId)
						.setParameter("value", value).getSingleResult();
			}

			return associated;

		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.099"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getCountFieldsForItems"));
			}
		}
	}

	// end-region

	// region Utility Method's

	private void insertItemByProductOperation(ItemByProduct itemByProduct) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"insertItemByProductOperation"));
			}
			
			entityManager.persist(itemByProduct);
			entityManager.flush();
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"insertItemByProductOperation"));
			}
		}
	}

	/**
	 * Update <tt>ItemByProduct</tt>.
	 * 
	 * @param itemByProductP
	 *            the item by product
	 */
	private void updateItemByProduct(ItemByProduct itemByProductP) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"updateItemByProduct"));
			}
			
			ItemByProduct itemByProduct = getItemByProduct(itemByProductP
					.getByProductId());
			if (itemByProduct != null) {
				entityManager.merge(itemByProductP);
				entityManager.flush();
			}
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.010",
					itemByProductP), ex);
			throw new BusinessException(6900096,
					"No se pudo actualizar la información correspondiente al rubro por producto");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"updateItemByProduct"));
			}
		}
	}

	/**
	 * Delete item by product.
	 * 
	 * @param itemByProductId
	 *            the item by product id
	 */
	private void deleteItemByProduct(ItemByProductId itemByProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"deleteItemByProduct"));
			}
			
			ItemByProduct itemByProduct = entityManager.find(
					ItemByProduct.class, itemByProductId);
			if (null != itemByProduct) {
				entityManager.remove(itemByProduct);
				entityManager.flush();
			}
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.011",
					itemByProductId), ex);
			throw new BusinessException(6900097,
					"No se pudo eliminar la información correspondiente al rubro por producto");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"deleteItemByProduct"));
			}
		}
	}

	/**
	 * Manage the insert or update for <tt>ItemAppliesWay</tt>.
	 * 
	 * @param operation
	 *            verified if the operation is insert or update
	 * @param itemAppliesWay
	 *            the item applies way
	 * @return <tt>ItemAppliesWay</tt> identifier
	 */
	private long manageItemAppliesWay(String operation,
			ItemAppliesWay itemAppliesWay) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"manageItemAppliesWay"));
			}
			
			if (operation.equals(Constants.INSERT_OPERATION)) {
				entityManager.persist(itemAppliesWay);
				entityManager.flush();
				return itemAppliesWay.getAppliesWayId();
			} else if (operation.equals(Constants.UPDATE_OPERATION)) {
				ItemAppliesWay iAppliesWay = entityManager.find(
						ItemAppliesWay.class, itemAppliesWay.getAppliesWayId());
				iAppliesWay.setItemReference(itemAppliesWay.getItemReference());
				iAppliesWay.setItemIncluded(itemAppliesWay.getItemIncluded());
				iAppliesWay.setAppliesToWhenApply(itemAppliesWay
						.getAppliesToWhenApply());
				entityManager.flush();
				return itemAppliesWay.getAppliesWayId();
			} else {
				return 0;
			}

		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.012",
					itemAppliesWay), eee);
			throw new BusinessException(
					6900098,
					"No se pudo insertar la información correspondiente a la forma de aplicación, puesto que ya exíste");
		} catch (Exception ex) {
			if (operation.equals(Constants.INSERT_OPERATION)) {
				logger.logError(MessageManager.getString("ITEMSMANAGER.013",
						itemAppliesWay), ex);
				throw new BusinessException(6900099,
						"No se pudo insertar la información correspondiente a la forma de aplicación");
			} else {
				logger.logError(MessageManager.getString("ITEMSMANAGER.014",
						itemAppliesWay), ex);
				throw new BusinessException(
						6900100,
						"No se pudo actualizar la información correspondiente a la forma de aplicación seleccionada");
			}
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"manageItemAppliesWay"));
			}
		}
	}

	/**
	 * Delete item applies way.
	 * 
	 * @param itemAppliesWayId
	 *            the item applies way id
	 */
	private void deleteItemAppliesWay(long itemAppliesWayId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"deleteItemAppliesWay"));
			}
			
			if (itemAppliesWayId != -1) {

				ItemAppliesWay itemAppliesWay = null;
				itemAppliesWay = entityManager.find(ItemAppliesWay.class,
						itemAppliesWayId);

				if (itemAppliesWay != null) {
					entityManager.remove(itemAppliesWay);
					entityManager.flush();
				}
			}
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.015",
					itemAppliesWayId), ex);
			throw new BusinessException(6900101,
					"No se pudo eliminar la información correspondiente a la forma de aplicación");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"deleteItemAppliesWay"));
			}
		}

	}

	/**
	 * Manage <tt>ItemsValues</tt> for items by product.
	 * 
	 * @param itemByProductId
	 *            the item by product id
	 * @param manageItemsValues
	 *            the manage items values
	 */
	private void manageItemsValuesForItemsByProduct(
			ItemByProductId itemByProductId,
			ArrayList<ItemsValues> manageItemsValues) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"manageItemsValuesForItemsByProduct"));
			}
			
			List<ItemsValues> itemsValuesExist = getItemsValuesForItemsByProduct(itemByProductId);
			
			for (ItemsValues itemValue : manageItemsValues) {
				if (itemsValuesExist.contains(itemValue)) {
					ItemsValues itemsValuesUpdate = itemsValuesExist
							.get(itemsValuesExist.indexOf(itemValue));
					
					itemsValuesUpdate.setValue(itemValue.getValue() != null ? itemValue.getValue().trim(): "");
				} else {
					// Not persist if value is empty or null
					if (itemValue.getValue()!=null && !itemValue.getValue().trim().isEmpty()) {
						entityManager.persist(itemValue);
						entityManager.flush();
					}
				}
			}
			// Search for new values
			for (ItemsValues itemsValues : itemsValuesExist) {
				if (manageItemsValues.contains(itemsValues)) {
					ItemsValues itemsValuesUpdate = manageItemsValues
							.get(manageItemsValues.indexOf(itemsValues));
					// Remove if new value is empty
					if (itemsValuesUpdate.getValue() == null || itemsValuesUpdate.getValue().trim().isEmpty()) {
						entityManager.remove(itemsValues);
						entityManager.flush();
					}
				}
			}
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.018",
					itemByProductId), eee);
			throw new BusinessException(
					6900104,
					"No se pudo insertar los valores de rubros para la renderización, puesto que ya existe.");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.017"), ex);
			throw new BusinessException(6900103,
					"No se pudo insertar o actualizar los valores de rubros para la renderización");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"manageItemsValuesForItemsByProduct"));
			}
		}

	}

	/**
	 * Delete items values for items by product.
	 * 
	 * @param itemByProductId
	 *            the item by product id
	 */
	private void deleteItemsValuesForItemsByProduct(
			ItemByProductId itemByProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"deleteItemsValuesForItemsByProduct"));
			}
			
			entityManager
					.createNamedQuery("ItemsValues.DeleteAllByItemsByProduct")
					.setParameter(1, itemByProductId.getProductId())
					.setParameter(2, itemByProductId.getItemId())
					.executeUpdate();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.019",
					itemByProductId), ex);
			throw new BusinessException(6900105,
					"No se pudo eliminar los valores de rubro para la renderización.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"deleteItemsValuesForItemsByProduct"));
			}
		}
	}

	/**
	 * Manage <tt>AmountItemValue</tt>.
	 * 
	 * @param amountItemValues
	 *            the amount item value list
	 */
	private void manageAmountItemValues(
			ArrayList<AmountItemValue> amountItemValues) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"manageAmountItemValues"));
			}
			
			for (AmountItemValue amountItemValue : amountItemValues) {
				List<AmountItemValue> amountItemValueT = entityManager
						.createNamedQuery("AmountItemValue.findById",
								AmountItemValue.class)
						.setParameter(
								"appliesWayId",
								amountItemValue.getAmountItemValuesId()
										.getAppliesWayId())
						.setParameter(
								PROD_ID_PARAMETER,
								amountItemValue.getAmountItemValuesId()
										.getCurrencyProductId().getProductId())
						.setParameter(
								"currencyId",
								amountItemValue.getAmountItemValuesId()
										.getCurrencyProductId().getCurrencyId())
						.getResultList();

				if (amountItemValueT != null && !amountItemValueT.isEmpty()) {
					entityManager.merge(amountItemValue);
				} else {
					entityManager.persist(amountItemValue);
				}
				entityManager.flush();
			}
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.022"), eee);
			throw new BusinessException(6900108,
					"No se pudo insertar los valores de montos del rubro, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.021"), ex);
			throw new BusinessException(6900107,
					"No se pudo insertar o crear los valores de montos del rubro");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"manageAmountItemValues"));
			}
		}
	}

	/**
	 * Delete information for <tt>AmountItemValue</tt>.
	 * 
	 * @param amountItemValues
	 *            the amount item value list
	 */
	private void deleteAmountItemsOperation(
			ArrayList<AmountItemValue> amountItemValues) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"deleteAmountItemsOperation"));
			}

			for (AmountItemValue amountItemValue : amountItemValues) {
				AmountItemValue amountItVal = entityManager.find(
						AmountItemValue.class,
						amountItemValue.getAmountItemValuesId());
				entityManager.remove(amountItVal);
			}
			entityManager.flush();
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"deleteAmountItemsOperation"));
			}
		}
	}

	private void deleteAmountItemValues(long itemAppliesWayId, String productId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"deleteAmountItemValues"));
			}
			entityManager.createNamedQuery("AmountItemValue.DeleteAllById")
					.setParameter(1, itemAppliesWayId)
					.setParameter(2, productId).executeUpdate();
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"deleteAmountItemValues"));
			}
		}
	}

	private void deleteInformationForItemByProductOperation(
			Long itemAppliesWayId, ItemByProductId itemByProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"deleteInformationForItemByProductOperation"));
			}
			
			deleteItemsValuesForItemsByProduct(itemByProductId);

			if (itemAppliesWayId != -1) {
				deleteAmountItemValues(itemAppliesWayId,
						itemByProductId.getProductId());
				deleteItemAppliesWay(itemAppliesWayId);
			}
			deleteItemByProduct(itemByProductId);
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"deleteInformationForItemByProductOperation"));
			}
		}
	}

	private void replicateDeleteInformationForItemByProduct(
			ItemByProductId itemByProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"replicateDeleteInformationForItemByProduct"));
			}
			
			List<BankingProduct> bankingProducts = entityManager
					.createNamedQuery(FIND_BANKING_Q, BankingProduct.class)
					.setParameter(BAN_ID_PARAMETER,
							itemByProductId.getProductId()).getResultList();
			for (BankingProduct bankingProduct : bankingProducts) {

				if (bankingProduct.getNodeTypeCategory().getNodeTypeProduct()
						.getId() == 5
						&& bankingProduct.getAuthorization().equals(
								Constants.YES)) {
					continue;

				} else {

					ItemByProductId iByProductId = new ItemByProductId(
							bankingProduct.getId(), itemByProductId.getItemId());
					ItemByProduct mItemByProduct = getItemByProduct(iByProductId);
					if (mItemByProduct != null) {
						if (mItemByProduct.getItemAppliesWaysList() != null
								&& mItemByProduct.getItemAppliesWaysList()
										.size() > 0) {
							deleteInformationForItemByProductOperation(
									mItemByProduct.getItemAppliesWaysList()
											.get(0).getAppliesWayId(),
									iByProductId);
						} else {
							deleteInformationForItemByProductOperation(
									(long) -1, iByProductId);
						}
					}
					replicateDeleteInformationForItemByProduct(iByProductId);
				}
			}
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"replicateDeleteInformationForItemByProduct"));
			}
		}
	}

	/**
	 * Insert a new <tt>ItemByProductHistory</tt>.
	 * 
	 * @param Identifier
	 *            for <tt>ItemByProduct</tt>
	 * @param System
	 *            Date
	 * @param Process
	 *            Date
	 * @throws Exception
	 *             the exception
	 */
	private void insertItemByProductHistory(ItemByProduct itemByProduct,
			long idBankingProductHistory) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"insertItemByProductHistory"));
			}

			
			ItemByProductHistoryId iBPHistoryId = new ItemByProductHistoryId(idBankingProductHistory, itemByProduct.getByProductId().getItemId());
			
			BankingProductHistory bankingProductHistory = entityManager.find(
					BankingProductHistory.class,idBankingProductHistory);
			
			if(logger.isDebugEnabled()){
				logger.logDebug("PRODUCTO BANCARIO "+bankingProductHistory);
			}

			// Create ItemByProductHistory object for the persist
			ItemByProductHistory iBPHistory = new ItemByProductHistory();
			iBPHistory.setBankingProductHistory(bankingProductHistory);
			iBPHistory.getBankingProductHistory().setId(bankingProductHistory.getId());
			iBPHistory.setItemIdentifier(itemByProduct.getByProductId()
					.getItemId());
			iBPHistory.setItemType(itemByProduct.getItemType());
			iBPHistory.setProcessDate(bankingProductHistory.getProcessDate());
			

			entityManager.persist(iBPHistory);
			entityManager.flush();
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"insertItemByProductHistory"));
			}
		}
	}

	/**
	 * Insert a new <tt>ItemsValuesHistory</tt>
	 * 
	 * @param List
	 *            of <tt>itemsValuesList</tt>
	 * @param System
	 *            Date
	 * @param Process
	 *            Date
	 * @throws Exception
	 *             the exception
	 */
	private void insertItemValuesHistory(String bankingProductId,
			long itemIdentifier, List<ItemsValues> itemsValuesList,
			long idBankingProductHistory) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"insertItemValuesHistory"));
			}

			// Create ItemByProductHistoryId object
			ItemByProductHistoryId itemByProductHistoryId = new ItemByProductHistoryId(
					idBankingProductHistory,
					itemIdentifier);

			// Find ItemByProductHistory object
			ItemByProductHistory itemByProductHistory = entityManager.find(
					ItemByProductHistory.class, itemByProductHistoryId);

			BankingProductHistory bph=new BankingProductHistory();
			bph=itemByProductHistory.getBankingProductHistory();
			
			for (ItemsValues itemsValues : itemsValuesList) {

				// Create ItemsValuesHistory object
				ItemsValuesHistory iVHistory = new ItemsValuesHistory(
						itemsValues.getDictionaryFieldId(), bph.getProcessDate(),
						itemsValues.getValue());
				iVHistory.setItemByProductHistory(itemByProductHistory);


				entityManager.persist(iVHistory);
				entityManager.flush();
			}
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"insertItemValuesHistory"));
			}
		}
	}

	/**
	 * Insert a new <tt>ItemAppliesWayHistory</tt>
	 * 
	 * @param <tt>ItemAppliesWay</tt>
	 * @param System
	 *            Date
	 * @param Process
	 *            Date
	 * @throws Exception
	 *             the exception
	 */
	private void insertItemAppliesWayHistory(String bankingProductId,
			long itemIdentifier, ItemAppliesWay itemAppliesWay,
			 Date processDate,long idbankingProductHistory) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"insertItemAppliesWayHistory"));
			}
			
			ItemAppliesWayHistory iAWayHistory = new ItemAppliesWayHistory(
					processDate, itemAppliesWay.getAppliesWayId(),
					itemAppliesWay.getAppliesToWhenApply()
							.getWhenApplyNodeType().getApplyNodeTypeId(),
					itemAppliesWay.getAppliesToWhenApply().getAppliesTo()
							.getAppliesId(), itemAppliesWay.getItemIncluded(),
					itemAppliesWay.getItemReference());

			// Create ItemByProductHistoryId object
			ItemByProductHistoryId itemByProductHistoryId = new ItemByProductHistoryId(
					idbankingProductHistory,
					itemIdentifier);
			// Find ItemByProductHistory object
			ItemByProductHistory itemByProductHistory = entityManager.find(
					ItemByProductHistory.class, itemByProductHistoryId);

			iAWayHistory.setItemByProductHistory(itemByProductHistory);

			entityManager.persist(iAWayHistory);
			entityManager.flush();
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"insertItemAppliesWayHistory"));
			}
		}
	}

	/**
	 * Insert a new <tt>AmountItemValueHistory</tt>.
	 * 
	 * @param List
	 *            of <tt>AmountItemValue</tt>
	 * @param System
	 *            Date
	 * @param Process
	 *            Date
	 * @throws Exception
	 *             the exception
	 */
	private void insertAmountItemValueHistory(String bankingProductId,
			long itemIdentifier, List<AmountItemValue> amountItemValue,
			 Date processDate,long idBankingProductHistory) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"insertAmountItemValueHistory"));
			}
			
			for (AmountItemValue amountItemValueObject : amountItemValue) {
				if (!amountItemValueObject.getCurrencyProduct().getStatus()
						.equals(Constants.YES))
					continue;
				AmountItemValueHistory aIValueHistory = new AmountItemValueHistory(
						processDate, amountItemValueObject
								.getAmountItemValuesId().getCurrencyProductId()
								.getCurrencyId(),
						amountItemValueObject.getAllowReadJustment(),
						amountItemValueObject.getBaseName(),
						amountItemValueObject.getBaseReadJustment(),
						amountItemValueObject.getBaseSign(),
						amountItemValueObject.getBaseSignReadJustment(),
						amountItemValueObject.getBusinessRule(),
						amountItemValueObject.getBusinessRuleLimits(),
						amountItemValueObject.getCurrencyCharge(),
						amountItemValueObject.getFormReadJustment(),
						amountItemValueObject.getMaximum(),
						amountItemValueObject.getMaximumLimit(),
						amountItemValueObject.getMaximumLimitType(),
						amountItemValueObject.getMaximumLimitVar(),
						amountItemValueObject.getMaximumReagJustment(),
						amountItemValueObject.getMaximumSign(),
						amountItemValueObject.getMaximumSignReadJustment(),
						amountItemValueObject.getMinimum(),
						amountItemValueObject.getMinimumLimit(),
						amountItemValueObject.getMinimumLimitType(),
						amountItemValueObject.getMinimumLimitVar(),
						amountItemValueObject.getMinimumReadJustment(),
						amountItemValueObject.getMinimumSign(),
						amountItemValueObject.getMinimumSignReadJustment(),
						amountItemValueObject.getPeriodReadJustment(),
						amountItemValueObject.getPeriodTypeReadJustment(),
						amountItemValueObject.getRangeType(),
						amountItemValueObject.getRateReadJustment(),
						amountItemValueObject.getValueReference(),
						amountItemValueObject.getRateReference(),
						amountItemValueObject.getReferenceRateReadJustment(),
						amountItemValueObject.getTypeReadJustment(),
						amountItemValueObject.getUseRange(),
						amountItemValueObject.getPolicyId(),
						amountItemValueObject.getPolicyName(),
						amountItemValueObject.getSp());

				// Create ItemByProductHistoryId object
				ItemByProductHistoryId itemByProductHistoryId = new ItemByProductHistoryId(
						idBankingProductHistory, itemIdentifier);
//						new BankingProductHistoryId(systemDate,
//								bankingProductId), itemIdentifier);

				ItemAppliesWayHistoryId itemAppliesWayHistoryId = new ItemAppliesWayHistoryId(
						itemByProductHistoryId, amountItemValueObject
								.getAmountItemValuesId().getAppliesWayId());

				ItemAppliesWayHistory itemAppliesWayHistory = entityManager
						.find(ItemAppliesWayHistory.class,
								itemAppliesWayHistoryId);

				aIValueHistory.setItemAppliesWayHistory(itemAppliesWayHistory);

				entityManager.persist(aIValueHistory);
				entityManager.flush();
			}
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"insertAmountItemValueHistory"));
			}
		}
	}

	/**
	 * Gets all list of <tt>ItemByProduct</tt>
	 * 
	 * @param bankingProductId
	 *            the banking product id
	 * @return List of <tt>ItemByProduct</tt>
	 * @throws Exception
	 *             the exception
	 */
	public List<ItemByProduct> getAllDataForItemsByProduct(
			String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getAllDataForItemsByProduct"));
			}
			
			List<ItemByProduct> itemsByproductList = new ArrayList<ItemByProduct>();

			itemsByproductList = entityManager
					.createNamedQuery("ItemByProduct.findItemsByProduct",
							ItemByProduct.class)
					.setParameter(PROD_ID_PARAMETER, bankingProductId)
					.getResultList();

			for (ItemByProduct itemByProduct : itemsByproductList) {
				itemByProduct.getItemAppliesWaysList().size();
				itemByProduct.getItemsValuesList().size();

				for (ItemAppliesWay itemAppliesWay : itemByProduct
						.getItemAppliesWaysList()) {
					if (itemAppliesWay.getItemValuesList() != null)
						itemAppliesWay.getItemValuesList().size();
				}
			}
			return itemsByproductList;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSMANAGER.099"), ex);
			throw new BusinessException(6900090,
					"No se pudo obtener la información de rubros por producto.");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getAllDataForItemsByProduct"));
			}
		}
	}

	/**
	 * Gets the process date.
	 * 
	 * @return the process date
	 * @throws Exception
	 *             the exception
	 */
	private Date getProcessDate() throws Exception {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getProcessDate"));
			}
			
			Date processDate = null;
			if (ContextManager.getContext() != null) {
				String processDateString = ContextManager.getContext()
						.getProcessDate();
				if (processDateString != null && processDateString != "") {
					processDate = new SimpleDateFormat("MM/dd/yyyy")
							.parse(processDateString);
				}
			}
			return processDate;
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getProcessDate"));
			}
		}
	}

	private String getTypeItem(long itemId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getTypeItem"));
			}
			
			Item item = entityManager
					.createNamedQuery("Item.findItemById", Item.class)
					.setParameter("itemIdentifier", itemId).getSingleResult();

			if (item != null) {
				return item.getValueType();
			} else
				return null;
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getTypeItem"));
			}
		}
	}

	private Boolean isAllFieldsConfig(String productId, long itemId,
			String diccAssociate) {

		BankingProduct bp = entityManager.find(BankingProduct.class, productId);
		if (bp == null) {
			logger.logError(MessageManager.getString(
					"BANKINGPRODUCTMANAGER.007", productId));
			throw new BusinessException(6900060,
					"No se pudo obtener el producto bancario indicado, puesto que no existe");
		}
		long nodeTypeCategoryId = bankingProductManager
				.getCategoryIdKeepDictionaryFromParents(productId);
		Company company = bp.getCompany();
		Long fieldsCount = 0l;
		while (company != null) { // For all the hierarchy of the companies
			// count the number of dictionary fields
			Long fieldsCountCompany = entityManager
					.createNamedQuery(
							"DictionaryField.countAllByDictionaryItems",
							Long.class)
					.setParameter("companyId", company.getId())
					.setParameter("nodeTypeCategoryId", nodeTypeCategoryId)
					// The category parent that keep dictionary
					.setParameter("type", Constants.ITEMS_DICTIONARY)
					.setParameter("name", diccAssociate).getSingleResult();
			fieldsCount += fieldsCountCompany;
			company = company.getParent();
		}
		Long generalParametersCount = entityManager
				.createNamedQuery("ItemsValues.countAllFieldsByProduct",
						Long.class).setParameter(PROD_ID_PARAMETER, productId)
				.setParameter(ITEM_ID, itemId).getSingleResult();
		return fieldsCount.equals(generalParametersCount);
	}

	private Long saveItemsInformationOperation(ItemByProductId itemByProductId,
			ArrayList<ItemsValues> manageItemsValues,
			ItemByProduct itemByProductParam, String operation,
			ItemAppliesWay itemAppliesWay,
			ArrayList<AmountItemValue> amountItemValueList, boolean notReview)
			throws Exception {
		long itemAppliesWayId;
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"saveItemsInformationOperation"));
			}
			
			manageItemsValuesForItemsByProduct(itemByProductId,
					manageItemsValues);
			updateItemByProduct(itemByProductParam);

			if (notReview) {
				itemAppliesWayId = manageItemAppliesWay(operation,
						itemAppliesWay);
			} else {

				ItemByProduct itemByProduct = null;

				try {
					itemByProduct = entityManager
							.createNamedQuery(
									"ItemByProduct.findItemByProduct",
									ItemByProduct.class)
							.setParameter(
									PROD_ID_PARAMETER,
									itemByProductParam.getByProductId()
											.getProductId())
							.setParameter(
									"itemIdentifier",
									itemByProductParam.getByProductId()
											.getItemId()).getSingleResult();
				} catch (NoResultException nre) {
					logger.logError("No existe el rubro --> "
							+ itemByProductParam.getByProductId());
					return (long) 0;
				}

				if (itemByProduct.getItemAppliesWaysList() != null
						&& itemByProduct.getItemAppliesWaysList().size() > 0)

				{

					itemAppliesWayId = itemByProduct.getItemAppliesWaysList()
							.get(0).getAppliesWayId();
					itemAppliesWay.setAppliesWayId(itemAppliesWayId);
					manageItemAppliesWay(Constants.UPDATE_OPERATION,
							itemAppliesWay);
				} else {
					itemAppliesWayId = manageItemAppliesWay(
							Constants.INSERT_OPERATION, itemAppliesWay);
				}

			}

			for (AmountItemValue amountItemValue : amountItemValueList) {
				amountItemValue.getAmountItemValuesId().setAppliesWayId(
						itemAppliesWayId);
			}

			manageAmountItemValues(amountItemValueList);

			return itemAppliesWayId;
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"saveItemsInformationOperation"));
			}
		}

	}

	private void replicateItemByProductForChildren(ItemByProduct itemByProduct)
			throws Exception {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"replicateItemByProductForChildren"));
			}
			
			List<BankingProduct> bankingProductList = entityManager
					.createNamedQuery(FIND_BANKING_Q, BankingProduct.class)
					.setParameter(BAN_ID_PARAMETER,
							itemByProduct.getByProductId().getProductId())
					.getResultList();

			for (BankingProduct bankingProduct : bankingProductList) {

				if (bankingProduct.getNodeTypeCategory().getNodeTypeProduct()
						.getId() == 5
						&& bankingProduct.getAuthorization().equals(
								Constants.YES)) {
					// changeStateProduct(bankingProduct.getId(), false);
					continue;

				} else {

					ItemByProductId newItemByProductId = new ItemByProductId(
							bankingProduct.getId(), itemByProduct
									.getByProductId().getItemId());

					ItemByProduct manageItemByProduct = getItemByProduct(newItemByProductId);

					if (manageItemByProduct == null) {
						ItemByProduct newItemByProduct = new ItemByProduct(
								newItemByProductId, itemByProduct.getItemType());
						insertItemByProductOperation(newItemByProduct);
						replicateItemByProductForChildren(newItemByProduct);
					} else {
						replicateItemByProductForChildren(manageItemByProduct);
					}
				}
			}
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"replicateItemByProductForChildren"));
			}
		}
	}

	private void replicateDeleteAmountItems(
			ArrayList<AmountItemValue> amountItemValueList, long itemId)
			throws Exception {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"replicateDeleteAmountItems"));
			}
			
			if (amountItemValueList.size() > 0) {
				String bankingProductId = amountItemValueList.get(0)
						.getAmountItemValuesId().getCurrencyProductId()
						.getProductId();

				List<BankingProduct> bankingProductList = entityManager
						.createNamedQuery(FIND_BANKING_Q, BankingProduct.class)
						.setParameter(BAN_ID_PARAMETER, bankingProductId)
						.getResultList();

				for (BankingProduct bankingProduct : bankingProductList) {

					if ((bankingProduct.getNodeTypeCategory()
							.getNodeTypeProduct().getId() == 5 && bankingProduct
							.getAuthorization().equals(Constants.YES))
							|| bankingProduct.getDelete().equals(Constants.YES)) {
						continue;

					} else {
						long itemAppliesWayId = entityManager
								.createNamedQuery(
										"ItemAppliesWay.findItemAppliesWayId",
										Long.class)
								.setParameter("itemId", itemId)
								.setParameter("productId",
										bankingProduct.getId())
								.getSingleResult();
						ArrayList<AmountItemValue> deleteAmountItemValueList = new ArrayList<AmountItemValue>();
						for (AmountItemValue amountItemValue : amountItemValueList) {

							List<AmountItemValue> deleteAmountItemValue = entityManager
									.createNamedQuery(
											"AmountItemValue.findById",
											AmountItemValue.class)
									.setParameter("appliesWayId",
											itemAppliesWayId)
									.setParameter("productId",
											bankingProduct.getId())
									.setParameter(
											"currencyId",
											amountItemValue
													.getAmountItemValuesId()
													.getCurrencyProductId()
													.getCurrencyId())
									.getResultList();

							for (AmountItemValue amountItVal : deleteAmountItemValue) {
								deleteAmountItemValueList.add(amountItVal);
							}
						}
						if (deleteAmountItemValueList.size() > 0)
							deleteAmountItemsOperation(deleteAmountItemValueList);

						if (bankingProduct.getNodeTypeCategory()
								.getNodeTypeProduct().getId() != 5)
							replicateDeleteAmountItems(amountItemValueList,
									itemId);
					}
				}
			}
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"replicateDeleteAmountItems"));
			}
		}
	}

	private void replicateItemsInformationForChildren(
			ItemByProductId itemByProductId,
			ArrayList<ItemsValues> manageItemsValues,
			ItemByProduct itemByProductParam, String operation,
			ItemAppliesWay itemAppliesWay,
			ArrayList<AmountItemValue> amountItemValueList) throws Exception {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"replicateItemsInformationForChildren"));
			}
			
			List<BankingProduct> bankingProductList = entityManager
					.createNamedQuery(FIND_BANKING_Q, BankingProduct.class)
					.setParameter(BAN_ID_PARAMETER,
							itemByProductId.getProductId()).getResultList();

			for (BankingProduct bankingProduct : bankingProductList) {

				if ((bankingProduct.getNodeTypeCategory().getNodeTypeProduct()
						.getId() == 5 && bankingProduct.getAuthorization()
						.equals(Constants.YES))
						|| bankingProduct.getDelete().equals(Constants.YES)) {
					continue;

				} else {
					List<CurrencyProduct> currencyProduct = getCurrenciesByProduct(bankingProduct
							.getId());
					ItemByProductId updateItemByProductId = new ItemByProductId(
							bankingProduct.getId(), itemByProductId.getItemId());

					// ArrayList<ItemsValues>
					ArrayList<ItemsValues> updateItemsValuesList = new ArrayList<ItemsValues>();
					for (ItemsValues itemsValues : manageItemsValues) {

						ItemsValues updateItemsValues = new ItemsValues(
								itemsValues.getDictionaryFieldId(),
								bankingProduct.getId(),
								itemsValues.getItemId(), itemsValues.getValue());
						updateItemsValuesList.add(updateItemsValues);
					}

					// ItemByProduct
					ItemByProduct updateItemByProduct = new ItemByProduct(
							updateItemByProductId,
							itemByProductParam.getItemType());

					// ItemAppliesWay
					ItemAppliesWay updateItemAppliesWay = new ItemAppliesWay(
							itemAppliesWay.getItemIncluded(),
							itemAppliesWay.getItemReference());
					updateItemAppliesWay.setItemsByProduct(updateItemByProduct);
					updateItemAppliesWay.setAppliesToWhenApply(itemAppliesWay
							.getAppliesToWhenApply());

					// AmountItemValue
					ArrayList<AmountItemValue> updateAmountItemValueList = new ArrayList<AmountItemValue>();
					for (AmountItemValue amountItemValue : amountItemValueList) {

						CurrencyProductId newCurrencyProductId = new CurrencyProductId(
								amountItemValue.getAmountItemValuesId()
										.getCurrencyProductId().getCurrencyId(),
								bankingProduct.getId());

						if (currencyProduct.contains(new CurrencyProduct(
								bankingProduct.getId(), newCurrencyProductId
										.getCurrencyId(), ""))) {

							AmountItemValueId updateAmountItemValueId = new AmountItemValueId(
									newCurrencyProductId, 0);

							AmountItemValue updateAmountItemValue = new AmountItemValue(
									updateAmountItemValueId,
									amountItemValue.getAllowReadJustment(),
									amountItemValue.getBaseName(),
									amountItemValue.getBaseReadJustment(),
									amountItemValue.getBaseSign(),
									amountItemValue.getBaseSignReadJustment(),
									amountItemValue.getBusinessRule(),
									amountItemValue.getBusinessRuleLimits(),
									amountItemValue.getCurrencyCharge(),
									amountItemValue.getFormReadJustment(),
									amountItemValue.getMaximum(),
									amountItemValue.getMaximumLimit(),
									amountItemValue.getMaximumLimitType(),
									amountItemValue.getMaximumLimitVar(),
									amountItemValue.getMaximumReagJustment(),
									amountItemValue.getMaximumSign(),
									amountItemValue
											.getMaximumSignReadJustment(),
									amountItemValue.getMinimum(),
									amountItemValue.getMinimumLimit(),
									amountItemValue.getMinimumLimitType(),
									amountItemValue.getMinimumLimitVar(),
									amountItemValue.getMinimumReadJustment(),
									amountItemValue.getMinimumSign(),
									amountItemValue
											.getMinimumSignReadJustment(),
									amountItemValue.getPeriodReadJustment(),
									amountItemValue.getPeriodTypeReadJustment(),
									amountItemValue.getRangeType(),
									amountItemValue.getRateReadJustment(),
									amountItemValue.getValueReference(),
									amountItemValue.getRateReference(),
									amountItemValue
											.getReferenceRateReadJustment(),
									amountItemValue.getTypeReadJustment(),
									amountItemValue.getUseRange(),
									amountItemValue.getPolicyId(),
									amountItemValue.getPolicyName(),
									amountItemValue.getSp());

							updateAmountItemValueList
									.add(updateAmountItemValue);
						}
					}
					saveItemsInformationOperation(updateItemByProductId,
							updateItemsValuesList, updateItemByProduct,
							operation, updateItemAppliesWay,
							updateAmountItemValueList, false);

					replicateItemsInformationForChildren(updateItemByProductId,
							updateItemsValuesList, updateItemByProduct,
							operation, updateItemAppliesWay,
							updateAmountItemValueList);
				}
			}
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"replicateItemsInformationForChildren"));
			}
		}
	}

	private void copyData(List<ItemByProduct> itemsByProductList,
			String bankingProductId) throws Exception {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"copyData"));
			}
			
			for (ItemByProduct itemByProduct : itemsByProductList) {

				ItemByProductId newItemByProductId = new ItemByProductId(
						bankingProductId, itemByProduct.getByProductId()
								.getItemId());
				ItemByProduct newItemByProduct = new ItemByProduct(
						newItemByProductId, itemByProduct.getItemType());
				insertItemByProduct(newItemByProduct);

				// Inserción de ItemsValues
				ArrayList<ItemsValues> newItemsValuesList = new ArrayList<ItemsValues>();
				for (ItemsValues itemsValues : itemByProduct
						.getItemsValuesList()) {

					ItemsValues newItemsValues = new ItemsValues(
							itemsValues.getDictionaryFieldId(),
							bankingProductId, itemsValues.getItemId(),
							itemsValues.getValue());
					newItemsValuesList.add(newItemsValues);
				}
				manageItemsValuesForItemsByProduct(newItemByProductId,
						newItemsValuesList);

				// Inserción ItemsappliesWay
				if (itemByProduct.getItemAppliesWaysList().size() > 0) {

					ItemAppliesWay newItemAppliesWay = new ItemAppliesWay(
							itemByProduct.getItemAppliesWaysList().get(0)
									.getItemIncluded(), itemByProduct
									.getItemAppliesWaysList().get(0)
									.getItemReference());

					newItemAppliesWay.setItemsByProduct(newItemByProduct);
					newItemAppliesWay.setAppliesToWhenApply(itemByProduct
							.getItemAppliesWaysList().get(0)
							.getAppliesToWhenApply());

					long newItemAppliesWayId = manageItemAppliesWay(
							Constants.INSERT_OPERATION, newItemAppliesWay);

					// Inserción AmountItemValues
					if (itemByProduct.getItemAppliesWaysList().get(0)
							.getItemValuesList().size() > 0) {

						ArrayList<AmountItemValue> newAmountItemValueList = new ArrayList<AmountItemValue>();

						for (AmountItemValue amountItemValue : itemByProduct
								.getItemAppliesWaysList().get(0)
								.getItemValuesList()) {

							CurrencyProductId newCurrencyProductId = new CurrencyProductId(
									amountItemValue.getAmountItemValuesId()
											.getCurrencyProductId()
											.getCurrencyId(), bankingProductId);

							AmountItemValueId newAmountItemValueId = new AmountItemValueId(
									newCurrencyProductId, newItemAppliesWayId);

							AmountItemValue newAmountItemValue = new AmountItemValue(
									newAmountItemValueId,
									amountItemValue.getAllowReadJustment(),
									amountItemValue.getBaseName(),
									amountItemValue.getBaseReadJustment(),
									amountItemValue.getBaseSign(),
									amountItemValue.getBaseSignReadJustment(),
									amountItemValue.getBusinessRule(),
									amountItemValue.getBusinessRuleLimits(),
									amountItemValue.getCurrencyCharge(),
									amountItemValue.getFormReadJustment(),
									amountItemValue.getMaximum(),
									amountItemValue.getMaximumLimit(),
									amountItemValue.getMaximumLimitType(),
									amountItemValue.getMaximumLimitVar(),
									amountItemValue.getMaximumReagJustment(),
									amountItemValue.getMaximumSign(),
									amountItemValue
											.getMaximumSignReadJustment(),
									amountItemValue.getMinimum(),
									amountItemValue.getMinimumLimit(),
									amountItemValue.getMinimumLimitType(),
									amountItemValue.getMinimumLimitVar(),
									amountItemValue.getMinimumReadJustment(),
									amountItemValue.getMinimumSign(),
									amountItemValue
											.getMinimumSignReadJustment(),
									amountItemValue.getPeriodReadJustment(),
									amountItemValue.getPeriodTypeReadJustment(),
									amountItemValue.getRangeType(),
									amountItemValue.getRateReadJustment(),
									amountItemValue.getValueReference(),
									amountItemValue.getRateReference(),
									amountItemValue
											.getReferenceRateReadJustment(),
									amountItemValue.getTypeReadJustment(),
									amountItemValue.getUseRange(),
									amountItemValue.getPolicyId(),
									amountItemValue.getPolicyName(),
									amountItemValue.getSp());

							newAmountItemValueList.add(newAmountItemValue);
						}

						this.manageAmountItemValues(newAmountItemValueList);
					}
				}
			}
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"copyData"));
			}
		}
	}

	private List<ItemByProductHistory> getItemByProductHistory(long idBankingProductHistory) throws Exception {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getItemByProductHistory"));
				logger.logDebug("SECUENCIALITEMS" + idBankingProductHistory);
			}

			
			return entityManager
					.createNamedQuery("ItemByProductHistory.findItemsHistoryOpt",
							ItemByProductHistory.class)
					.setParameter("id", idBankingProductHistory)
					
					
					.getResultList();
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getItemByProductHistory"));
			}
		}
	}

	private List<ItemsValuesHistory> getItemsValuesHistory(long idBankingProductHistory,
			 Long itemId) throws Exception {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getItemsValuesHistory"));
			}
			
			return entityManager
					.createNamedQuery(
							"ItemsValuesHistory.findItemsValuesHistory",
							ItemsValuesHistory.class)
					.setParameter("id", idBankingProductHistory)
					
					.setParameter(ITEM_ID, itemId).getResultList();
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getItemsValuesHistory"));
			}
		}
	}
	
	
	private List<Object[]> getItemsValuesHistoryOpt(long idBankingProductHistory,
			 Long itemId) throws Exception {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getItemsValuesHistoryOpt"));
			}
			
			return entityManager
					.createNamedQuery("ItemsValuesHistory.findItemsValuesHistoryOpt")
					.setParameter(1, idBankingProductHistory)
					.setParameter(2, itemId).getResultList();
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getItemsValuesHistoryOpt"));
			}
		}
	}
	

	private ItemAppliesWayHistory getItemAppliesWayHistory(long idBankingProductHistory,
			String bankingProductId, Long itemId) throws Exception {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
						"getItemAppliesWayHistory"));
				logger.logDebug("ITEMS: " + itemId);
			}
			
			return entityManager
					.createNamedQuery(
							"ItemAppliesWayHistory.getItemAppliesWayHistory",
							ItemAppliesWayHistory.class)
					.setParameter("id", idBankingProductHistory)
					.setParameter("itemIdentifier", itemId)
					.getSingleResult();
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getItemAppliesWayHistory"));
			}
		}
	}

	
	private List<ItemAppliesWayHistory> getItemAppliesWayHistoryOpt(long idBankingProductHistory,
			String bankingProductId) throws Exception {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
						"getItemAppliesWayHistoryOpt"));
				logger.logDebug("Producto: " + bankingProductId + " - "+ idBankingProductHistory);
			}
			
			return entityManager
					.createNamedQuery(
							"ItemAppliesWayHistory.getItemAppliesWayHistoryOpt",
							ItemAppliesWayHistory.class)
					.setParameter("id", idBankingProductHistory).getResultList();
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getItemAppliesWayHistoryOpt"));
			}
		}
	}
	
	private ItemAppliesWayHistory getItemAppliesWay(List<ItemAppliesWayHistory> appliesWayHistories,  Long itemId){
		
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
						"getItemAppliesWay"));
			}
			
			ItemAppliesWayHistory appliesWayHistory = null;
			
			
			if(appliesWayHistories != null && appliesWayHistories.size() > 0){
				for (ItemAppliesWayHistory itemAppliesWayHistory : appliesWayHistories) {
					if(itemAppliesWayHistory.getItemByProductHistory().getItemIdentifier() == itemId){
						appliesWayHistory = itemAppliesWayHistory;
						break;
					}
				}
			}

			if(appliesWayHistory == null){
				if(logger.isDebugEnabled()){
					logger.logDebug("AppliesWayHistory no existe.  ItemId: " + itemId);
				}
				throw new BusinessException(6900001,
						"Existió un fallo en la operación. Comuníquese con el Administrador");
			}
			
			return appliesWayHistory;
		
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getItemAppliesWay"));
			}
		}
		
	}
	
	
	
	

	
	/**
	 * Get the list for <tt>AmountItemValueHistory</tt>.
	 * 
	 * @param idBankingProductHistory
	 *            the sequential identifier of BankingProductHistory
	 * @return List for <tt>AmountItemValue</tt>
	 */
	
	private AmountItemValueHistory getAmountItemValueHistory(long idBankingProductHistory,
			Long itemAppliesWayHistoryId, String bankingProductId,
			String currencyId) throws Exception {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getAmountItemValueHistory"));
			}
			
			List<AmountItemValueHistory> amountHistoryList = entityManager
					.createNamedQuery(
							"AmountItemValueHistory.findAmountItemValueHistory",
							AmountItemValueHistory.class)
					.setParameter("id", idBankingProductHistory)
					.setParameter("appliesWayId", itemAppliesWayHistoryId)
					//.setParameter(PROD_ID_PARAMETER, bankingProductId)
					.setParameter("currencyId", currencyId).getResultList();

			if (amountHistoryList.size() > 0)
				return amountHistoryList.get(0);
			else
				return null;

		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getAmountItemValueHistory"));
			}
		}
	}
	
	private List<AmountItemValueHistory> getAmountItemValueHistoryOpt(long idBankingProductHistory, 
			String currencyId) throws Exception {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getAmountItemValueHistoryOpt"));
				logger.logDebug("Producto: " + idBankingProductHistory);
				logger.logDebug("Moneda: " + currencyId);
			}
			
			return entityManager
					.createNamedQuery(
							"AmountItemValueHistory.findAmountItemValueHistoryOpt",
							AmountItemValueHistory.class)
					.setParameter("id", idBankingProductHistory)
					.setParameter("currencyId", currencyId).getResultList();

		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getAmountItemValueHistoryOpt"));
			}
		}
	}
	
	//OGU: Utilitario que permite obtener la lista de AmountItemValueHistory
	private AmountItemValueHistory getAmountItemValues(List<AmountItemValueHistory> amountItemValueHistories, Long itemAppliesWayHistoryId){
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
						"getAmountItemValues"));
			}
			
			AmountItemValueHistory amount = null;
			
			
			if(amountItemValueHistories != null && amountItemValueHistories.size() > 0){
				for (AmountItemValueHistory amountItemValueHistory : amountItemValueHistories) {
					
					if(amountItemValueHistory.getItemAppliesWayHistory().getAppliesWayId() == itemAppliesWayHistoryId){
						amount = amountItemValueHistory;
						break;
					}
				}
			}

			/*if(amount == null){
				if(logger.isDebugEnabled()){
					logger.logDebug("itemAppliesWayHistoryId: " + itemAppliesWayHistoryId);
					logger.logDebug("Num AmountItemValueHistories: " + amountItemValueHistories.size());
				}
				throw new BusinessException(6900001,
						"Existió un fallo en la operación. Comuníquese con el Administrador");
			}*/
			
			return amount;
		
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getAmountItemValues"));
			}
		}
	}

	/**
	 * Get the list of AmountItemValueHistory by banking product
	 * 
	 * @param date
	 *            Registry date
	 * @param itemAppliesWayHistoryId
	 *            Applies way history identifier
	 * @param bankingProductId
	 *            Banking product id
	 * @return list of AmountItemValueHistory by banking product
	 */
	private List<AmountItemValueHistory> getListAmountItemValueHistory(
			long idBankinProduct, Long itemAppliesWayHistoryId, String bankingProductId)
			throws Exception {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getListAmountItemValueHistory"));
			}
			
			return entityManager
					.createNamedQuery(
							"AmountItemValueHistory.findListAmountItemValueHistory",
							AmountItemValueHistory.class)
					.setParameter("id", idBankinProduct)
					.setParameter("appliesWayId", itemAppliesWayHistoryId)
					//.setParameter(PROD_ID_PARAMETER, bankingProductId)
					.getResultList();
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getListAmountItemValueHistory"));
			}
		}
	}


	private Object[] getFields(String bankingProductId, String dictionaryType,
			Long itemId, Long fieldId) throws Exception {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getFields"));
			}
			
			Long categoryId = bankingProductManager
					.getCategoryIdKeepDictionaryFromParents(bankingProductId);
			if (null == categoryId || categoryId == 0) {
				logger.logError(MessageManager.getString(
						"BANKINGPRODUCTMANAGER.007", bankingProductId));
				throw new BusinessException(6900060,
						"No se pudo obtener el producto bancario indicado, puesto que no existe");
			}
			// The data of the general parameters
			List<Object[]> resultList = entityManager
					.createNamedQuery("MappingField.findField", Object[].class)
					.setParameter("categoryId", categoryId)
					.setParameter("type", dictionaryType)
					.setParameter("fieldId", fieldId).getResultList();

			if (resultList.size() > 0)
				return resultList.get(0);
			else
				return null;
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getFields"));
			}
		}
	}
	
	
	private Object[] getFields(Long categoryId, String dictionaryType,
			Long itemId, Long fieldId) throws Exception {
		try{
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
						"getFields"));
			}
			
			ICache cache = cacheManager.getCache(CACHE_KEY);
			String wCacheKeyMappingField = "MAPPINGFIELD-"
					+ (categoryId== null ? null
							: categoryId.toString()); 
			wCacheKeyMappingField = wCacheKeyMappingField + "-" + dictionaryType; 
			wCacheKeyMappingField = wCacheKeyMappingField + "-"
					+ (fieldId == null ? null
					: fieldId.toString()); 
			if (logger.isDebugEnabled()) {
				logger.logDebug("wCacheKeyMappingField : " + wCacheKeyMappingField);
			}

			Object[] result = null;
			// Se obtiene de caché
			if (cache.get(wCacheKeyMappingField) != null) {
				if (logger.isDebugEnabled()) {
					logger.logDebug(MessageManager.getString("ITEMSMANAGER.049",
							"getFields"));
				}
				result = (Object[]) cache.get(wCacheKeyMappingField);
			}else{
				
				// The data of the general parameters
				List<Object[]> resultList = entityManager
						.createNamedQuery("MappingField.findField", Object[].class)
						.setParameter("categoryId", categoryId)
						.setParameter("type", dictionaryType)
						.setParameter("fieldId", fieldId).getResultList();

				if (resultList.size() > 0){
					result = resultList.get(0);
					//Guardar en caché
					cache.put(wCacheKeyMappingField, result);
				}	
			}		
			return result;			
		}finally{
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
						"getFields"));
			}
		}
	}
	

	/**
	 * Get the Portfolio group code associated to FPM value type code
	 * 
	 * @return Portfolio group code
	 */
	public List<String> getTypeByGroup(String groupId, String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getTypeByGroup"));
			}

			NodeTypeCategory category = bankingProductManager
					.getCategoryKeepDictionaryFromParents(bankingProductId);

			return entityManager
					.createNamedQuery("MappingTypeGroup.findMappingByGroup",
							String.class).setParameter("group", groupId)
					.setParameter("module", category.getModule())
					.getResultList();

		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("ITEMSMANAGER.042", groupId), ex);
			throw new BusinessException(6900110,
					"No se pudo obtener las monedas asociadas al producto");
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getTypeByGroup"));
			}
		}
	}

	/**
	 * Get Items Group Catalog
	 * 
	 * @param bankingProductId
	 * @return List of Items Group
	 */
	public List<Catalog> getItemsGroup(String bankingProductId) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getItemType"));
			}
			
			return null;
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getItemType"));
			}
		}
	}
	// end-region
	
	public void insertItemByProductList(ArrayList<ItemByProduct> itemByProductList) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"insertItemByProductList"));
			}
			
			for (ItemByProduct ibp : itemByProductList) {
				insertItemByProduct(ibp);				
			}
		} catch (EntityExistsException eee) {
			logger.logError(
					MessageManager.getString("ITEMSMANAGER.008", itemByProductList),
					eee);
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("ITEMSMANAGER.009", itemByProductList),
					ex);
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"insertItemByProductList"));
			}
		}		
	}

	@Override
	public List<Object[]> getParameterOfItemsByProduct(String bankingProduct, String parameterName) {
		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.001",
					"getParameterOfItemsByProduct"));
			}
			
	        BankingProductHistory bankingProductHistory = entityManager
			.createNamedQuery(
					"BankingProductHistory.FindByDateAndProductOpt",
					BankingProductHistory.class)
			.setParameter("systemDateId", new Date())
			.setParameter("productId", bankingProduct)
			.getSingleResult(); 
	        
	        Long idBankingProductHistory = null;
	        if (bankingProductHistory != null){
	        	idBankingProductHistory = bankingProductHistory.getId(); 
	        }
	        return entityManager
					.createNamedQuery("ItemsValuesHistory.findParameterOfItemsByProduct")
					.setParameter(1, idBankingProductHistory)
					.setParameter(2, parameterName).getResultList();
	        
		} catch (BusinessException e) {
			throw e;
		} catch (Exception ex) {
			logger.logError(MessageManager.getString("ITEMSTATUSMANAGER.099"),
					ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");	        
		} finally {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("ITEMSMANAGER.002",
					"getParameterOfItemsByProduct"));
			}
		}
	}

	

}
