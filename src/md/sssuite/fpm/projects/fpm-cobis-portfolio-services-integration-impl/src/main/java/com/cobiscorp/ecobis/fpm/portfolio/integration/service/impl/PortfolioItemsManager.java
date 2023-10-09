/*
 * File: PortfolioItemsManager.java
 * Date: April 25, 2012
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

package com.cobiscorp.ecobis.fpm.portfolio.integration.service.impl;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.bo.RateReferenceValue;
import com.cobiscorp.ecobis.fpm.bo.RateValue;
import com.cobiscorp.ecobis.fpm.interceptors.service.IDefaultValuesManager;
import com.cobiscorp.ecobis.fpm.model.AmountItemValue;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.CurrencyProduct;
import com.cobiscorp.ecobis.fpm.model.Item;
import com.cobiscorp.ecobis.fpm.model.ItemByProduct;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.operation.service.IItemsManager;
import com.cobiscorp.ecobis.fpm.operation.service.IMappingFieldManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.IPortfolioItemsManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.utils.CreateDataForReport;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.utils.MessageManager;
import com.cobiscorp.ecobis.fpm.portfolio.model.ConceptPortfolio;
import com.cobiscorp.ecobis.fpm.portfolio.model.ItemsPortfolio;
import com.cobiscorp.ecobis.fpm.portfolio.model.ReferencialValue;
import com.cobiscorp.ecobis.fpm.portfolio.model.ValuePortfolio;
import com.cobiscorp.ecobis.fpm.portfolio.service.IDefaultOperationManager;
import com.cobiscorp.ecobis.fpm.portfolio.service.IItemPortfolioManager;
import com.cobiscorp.ecobis.fpm.portfolio.service.IRatePortfolio;
import com.cobiscorp.ecobis.fpm.portfolio.service.commons.Constants;

/**
 * Implementation for the integration services in the items
 * 
 * @author oguano
 * 
 */
public class PortfolioItemsManager implements IPortfolioItemsManager {

	// region Field
	/** Cobis Logger */
	private final ILogger logger = LogFactory
			.getLogger(PortfolioItemsManager.class);
	
	/** IItemPortfolioManager Service */
	private IItemPortfolioManager itemPortfolioManagerService;
	/** IMappingFieldManager Service */
	private IMappingFieldManager mappingFieldManagerService;
	/** IItemsManager Service */
	private IItemsManager itemsManagerService;
	/** IRatePortfolio Service */
	private IRatePortfolio ratePortfolioService;
	/** IDefaultOperationManager Service */
	private IDefaultOperationManager defaultOperationService;
	/** IDefaultValuesManager Service */
	private IDefaultValuesManager defaultValuesManager;
	/** IBankingProductManager Service */
	private IBankingProductManager bankingProductManager;
	// end-region

	// region Properties
	/**
	 * @param itemsManagerService
	 */
	public void setItemsManagerService(IItemsManager itemsManagerService) {
		this.itemsManagerService = itemsManagerService;
	}

	/**
	 * @param itemPortfolioManagerService
	 */
	public void setItemPortfolioManagerService(
			IItemPortfolioManager itemPortfolioManagerService) {
		this.itemPortfolioManagerService = itemPortfolioManagerService;
	}

	/**
	 * @param mappingFieldManagerService
	 */
	public void setMappingFieldManagerService(
			IMappingFieldManager mappingFieldManagerService) {
		this.mappingFieldManagerService = mappingFieldManagerService;
	}

	/**
	 * @param ratePortfolioService
	 */
	public void setRatePortfolioService(IRatePortfolio ratePortfolioService) {
		this.ratePortfolioService = ratePortfolioService;
	}

	public void setDefaultOperationService(
			IDefaultOperationManager defaultOperationService) {
		this.defaultOperationService = defaultOperationService;
	}
	
	public void setDefaultValuesManager(IDefaultValuesManager defaultValuesManager) {
		this.defaultValuesManager = defaultValuesManager;
	}

	public void setBankingProductManager(
			IBankingProductManager bankingProductManager) {
		this.bankingProductManager = bankingProductManager;
	}

	// end-region

	
	
	
	/**
	 * Replicate data to ca_rubro
	 */
	public void createItemsHistory(
			BankingProductHistory bankingProductHistoryId,
			String authorizationStatus) {

		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.001", "createItemsHistory"));

			String bankingProductId = bankingProductHistoryId.getProductId();

			// Get all data of item by product
			List<ItemByProduct> itemByProductList = itemsManagerService
					.getAllDataForItemsByProduct(bankingProductId);

			for (ItemByProduct itemByProduct : itemByProductList) {

				/*if(!"C".equals(itemByProduct.getItemType())){

					if(itemByProduct.getItemAppliesWaysList().size() > 0){
					for (AmountItemValue amountItemValue : itemByProduct
							.getItemAppliesWaysList().get(0)
							.getItemValuesList()) {

						ItemsPortfolio itemPortfolio = new ItemsPortfolio();
						itemPortfolio.setOperation(itemByProduct
								.getBankingProduct().getId());
						itemPortfolio
								.setCurrency(Long
										.parseLong(amountItemValue
												.getAmountItemValuesId()
												.getCurrencyProductId()
												.getCurrencyId()));
						itemPortfolio.setConcept(itemByProduct.getItem()
								.getName());
						itemPortfolio.setPriority(Long.parseLong(this
								.getPortfolioValue(bankingProductId,
										itemByProduct.getItem().getId(),
										"ru_prioridad").trim()));
						itemPortfolio.setItemType(itemByProduct.getItemType());
						itemPortfolio.setRu_paga_mora(this.getPortfolioValue(
								bankingProductId, itemByProduct.getItem()
										.getId(), "ru_paga_mora"));
						itemPortfolio.setProvision(this.getPortfolioValue(
								bankingProductId, itemByProduct.getItem()
										.getId(), "ru_provisiona"));
						itemPortfolio
								.setfPayment(itemByProduct
										.getItemAppliesWaysList().size() > 0 && ?
										itemByProduct
										.getItemAppliesWaysList().get(0)
										.getAppliesToWhenApply()
										.getAppliesToWhenApplyId()
										.getApplyNodeTypeId():null);
						itemPortfolio.setAlwaysCreate(this.getPortfolioValue(
								bankingProductId, itemByProduct.getItem()
										.getId(), "ru_crear_siempre"));
						itemPortfolio.settPeriod(null);
						itemPortfolio.setPeriod(0);
						itemPortfolio.setReference(amountItemValue
								.getValueReference());
						itemPortfolio.setChangeRate(null);
						itemPortfolio.setBank(this.getPortfolioValue(
								bankingProductId, itemByProduct.getItem()
										.getId(), "ru_banco"));
						itemPortfolio.setState("V");

						if(itemByProduct.getItemAppliesWaysList().size() > 0){
							if (itemByProduct.getItemAppliesWaysList().get(0)
									.getItemReference() == null
									|| "".equals(itemByProduct
											.getItemAppliesWaysList().get(0)
											.getItemReference().trim())) {
								itemPortfolio.setConceptAssociated(null);
							} else {
								itemPortfolio
										.setConceptAssociated(itemsManagerService
												.getItem(
														Long.parseLong(itemByProduct
																.getItemAppliesWaysList()
																.get(0)
																.getItemReference()))
												.getName());
							}
						}else{
							itemPortfolio.setConceptAssociated(null);
						}
						
						
						itemPortfolio.setMaxValue(amountItemValue
								.getMaximumLimit());
						itemPortfolio.setMinValue(amountItemValue
								.getMinimumLimit());
						itemPortfolio.setAffectation(0);
						itemPortfolio.setDefer(this.getPortfolioValue(
								bankingProductId, itemByProduct.getItem()
										.getId(), "ru_diferir"));
						itemPortfolio.setSecureType(this.getPortfolioValue(
								bankingProductId, itemByProduct.getItem()
										.getId(), "ru_tipo_seguro"));
						itemPortfolio.setEffectiveRate(this.getPortfolioValue(
								bankingProductId, itemByProduct.getItem()
										.getId(), "ru_tasa_efectiva"));

						if (this.itemPortfolioManagerService
								.findItemPortfolio(itemPortfolio) == null) {
							this.itemPortfolioManagerService
									.manageItemsPortfolio(
											Constants.INSERT_OPERATION,
											itemPortfolio);
						} else {
							this.itemPortfolioManagerService
									.manageItemsPortfolio(
											Constants.UPDATE_OPERATION,
											itemPortfolio);
						}

					}
				}

				} else {

					List<CurrencyProduct> listCurrencyProduct = itemByProduct
							.getBankingProduct().getCurrencyProducts();

					for (CurrencyProduct currencyProduct : listCurrencyProduct) {

						if("S".equals(currencyProduct.getStatus())){

							ItemsPortfolio itemPortfolio = new ItemsPortfolio();
							itemPortfolio.setOperation(itemByProduct
									.getBankingProduct().getId());
							itemPortfolio.setCurrency(Long
									.parseLong(currencyProduct.getId()
											.getCurrencyId()));
							itemPortfolio.setConcept(itemByProduct.getItem()
									.getName());
							itemPortfolio.setPriority(Long.parseLong(this
									.getPortfolioValue(bankingProductId,
											itemByProduct.getItem().getId(),
											"ru_prioridad").trim()));
							itemPortfolio.setItemType(itemByProduct
									.getItemType());
							itemPortfolio.setRu_paga_mora(this
									.getPortfolioValue(bankingProductId,
											itemByProduct.getItem().getId(),
											"ru_paga_mora"));
							itemPortfolio.setProvision(this.getPortfolioValue(
									bankingProductId, itemByProduct.getItem()
											.getId(), "ru_provisiona"));
							itemPortfolio.setfPayment(itemByProduct
									.getItemAppliesWaysList().size() > 0?
									itemByProduct
									.getItemAppliesWaysList().get(0)
									.getAppliesToWhenApply()
									.getAppliesToWhenApplyId()
									.getApplyNodeTypeId():null);
							itemPortfolio.setAlwaysCreate(this
									.getPortfolioValue(bankingProductId,
											itemByProduct.getItem().getId(),
											"ru_crear_siempre"));
							itemPortfolio.settPeriod(null);
							itemPortfolio.setPeriod(0);
							itemPortfolio.setReference(null);// --
							itemPortfolio.setChangeRate(null);
							itemPortfolio.setBank(this.getPortfolioValue(
									bankingProductId, itemByProduct.getItem()
											.getId(), "ru_banco"));
							itemPortfolio.setState("V");

							if(itemByProduct.getItemAppliesWaysList().size() > 0){
								if (itemByProduct.getItemAppliesWaysList().get(0)
										.getItemReference() == null
										|| "".equals(itemByProduct
												.getItemAppliesWaysList().get(0)
												.getItemReference().trim())) {
									itemPortfolio.setConceptAssociated(null);
								} else {
									itemPortfolio
											.setConceptAssociated(itemsManagerService
													.getItem(
															Long.parseLong(itemByProduct
																	.getItemAppliesWaysList()
																	.get(0)
																	.getItemReference()))
													.getName());
								}
							}else{
								itemPortfolio.setConceptAssociated(null);
							}
							
							
							itemPortfolio.setMaxValue(0);// --
							itemPortfolio.setMinValue(0);// --
							itemPortfolio.setAffectation(0);
							itemPortfolio.setDefer(this.getPortfolioValue(
									bankingProductId, itemByProduct.getItem()
											.getId(), "ru_diferir"));
							itemPortfolio.setSecureType(this.getPortfolioValue(
									bankingProductId, itemByProduct.getItem()
											.getId(), "ru_tipo_seguro"));
							itemPortfolio.setEffectiveRate(this
									.getPortfolioValue(bankingProductId,
											itemByProduct.getItem().getId(),
											"ru_tasa_efectiva"));

							if (this.itemPortfolioManagerService
									.findItemPortfolio(itemPortfolio) == null) {
								this.itemPortfolioManagerService
										.manageItemsPortfolio(
												Constants.INSERT_OPERATION,
												itemPortfolio);
							} else {
								this.itemPortfolioManagerService
										.manageItemsPortfolio(
												Constants.UPDATE_OPERATION,
												itemPortfolio);
							}
						}

					}

				}*/

			}

			//createItemForReport(bankingProductHistoryId, authorizationStatus);
			
			if ("A".equals(authorizationStatus)) {

				CreateDataForReport.createDataForReport(mappingFieldManagerService,
						defaultValuesManager, bankingProductManager,
						defaultOperationService, bankingProductHistoryId,
						com.cobiscorp.ecobis.fpm.service.commons.Constants.ITEMS_DICTIONARY_REPORT, itemsManagerService);
			}

			
		} catch (Exception e) {
			logger.logError(
					MessageManager.getString("PORTFOLIOITEMMANAGER.003"), e);
			throw new BusinessException(6900001,
					"ExistiÃ³ un fallo en la operaciÃ³n. ComunÃ­quese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.002", "createItemsHistory"));
		}

	}

	/*private void createItemForReport(
			BankingProductHistory bankingProductHistoryId,
			String authorizationStatus) {

		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.001", "createItemForReport"));

			List<Map> rowFields = new ArrayList<Map>();
			HashMap<String, PhysicalField> gpMapping = new HashMap<String, PhysicalField>();
			HashMap<CoreTable, List> coreTableInformation = new HashMap<CoreTable, List>();

			if ("A".equals(authorizationStatus)) {
				List<CoreTable> coreTableList = mappingFieldManagerService
						.getPhysicalFieldsMappingsSpecific(
								bankingProductHistoryId.getProductId(),
								com.cobiscorp.ecobis.fpm.service.commons.Constants.ITEMS_DICTIONARY_REPORT);

				if (logger.isDebugEnabled())
					logger.logDebug("Recupero List<CoreTable> size: "
							+ coreTableList.size());

				for (CoreTable coreTable : coreTableList) {
					if (logger.isDebugEnabled())
						logger.logDebug("Table : " + coreTable.getTable());

					for (PhysicalField physicalField : coreTable
							.getPhysicalFields()) {

						if (logger.isDebugEnabled())
							logger.logDebug("PhysicalField name: "
									+ physicalField.getPhysicalFieldName()
									+ "PhysicalField value: "
									+ physicalField.getValue());

						gpMapping.put(physicalField.getPhysicalFieldName(),
								physicalField);
					}

					rowFields.add(gpMapping);
					coreTableInformation.put(coreTable, rowFields);
					defaultOperationService
							.insertDynamicCreditOperationGeneralParameters(coreTableInformation);
				}

			}

		} catch (BusinessException be) {
			throw be;
		} catch (Exception e) {
			logger.logError(
					MessageManager.getString("PORTFOLIOITEMMANAGER.003"), e);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.002", "createItemForReport"));
		}
	}*/

	public List<RateValue> getRateValue(String bankingProductId) {
		try {

			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.001", "getRateValue"));

			List<RateValue> rateValueList = new ArrayList<RateValue>();

			List<ValuePortfolio> valuePortfolioList = ratePortfolioService
					.getValuePortfolio();

			for (ValuePortfolio valuePortfolio : valuePortfolioList) {
				RateValue bo = new RateValue(valuePortfolio.getType(),
						valuePortfolio.getDescription());
				rateValueList.add(bo);
			}

			return rateValueList;

		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("PORTFOLIOITEMMANAGER.005"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operaciÃ³n. ComunÃ­quese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.002", "getRateValue"));
		}
	}

	public List<RateReferenceValue> getRateReferenceValue(
			String bankingProductId) {
		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.001", "getRateReferenceValue"));
			List<RateReferenceValue> rateReferenceValueList = new ArrayList<RateReferenceValue>();

			List<ReferencialValue> referencialValueList = ratePortfolioService
					.getReferenceValueByState();

			for (ReferencialValue referencialValue : referencialValueList) {
				RateReferenceValue bo = new RateReferenceValue(
						referencialValue.getSequencial(),
						referencialValue.getRate(),
						referencialValue.getDescription());
				rateReferenceValueList.add(bo);
			}

			return rateReferenceValueList;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("PORTFOLIOITEMMANAGER.006"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.002", "getRateReferenceValue"));
		}
	}

	public String getChangeRate(String bankingProductId) {
		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.001", "getChangeRate"));
			return mappingFieldManagerService
					.getValueByPhisicalField(
							bankingProductId,
							com.cobiscorp.ecobis.fpm.portfolio.service.commons.Constants.CHANGERATE);
		} catch (Exception e) {
			logger.logError(
					MessageManager.getString("PORTFOLIOITEMMANAGER.007"), e);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.002", "getChangeRate"));
		}
	}

	public String getSpecialChangeRate(String bankingProductId) {
		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.001", "getSpecialChangeRate"));
			return mappingFieldManagerService
					.getValueByPhisicalField(
							bankingProductId,
							com.cobiscorp.ecobis.fpm.portfolio.service.commons.Constants.SPECIAL_CHANGERATE);
		} catch (Exception e) {
			logger.logError(
					MessageManager.getString("PORTFOLIOITEMMANAGER.008"), e);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");

		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.002", "getSpecialChangeRate"));
		}
	}

	public String getPeriodChangerate(String bankingProductId) {
		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.001", "getPeriodChangerate"));
			return mappingFieldManagerService
					.getValueByPhisicalField(
							bankingProductId,
							com.cobiscorp.ecobis.fpm.portfolio.service.commons.Constants.PERIOD_CHANGERATE);
		} catch (Exception e) {
			logger.logError(
					MessageManager.getString("PORTFOLIOITEMMANAGER.008"), e);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");

		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.002", "getPeriodChangerate"));
		}
	}

	private String getPortfolioValue(String bankingProductId, Long itemId,
			String fieldName) {
		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.001", "getPortfolioValue"));
			String fieldMappingName = mappingFieldManagerService
					.findByPhysicalField(bankingProductId, itemId, fieldName);

			if("ru_prioridad".equals(fieldName)){
				if (fieldMappingName != null) {
					return fieldMappingName;
				} else {
					return "0";
				}
			} else if ("ru_paga_mora".equals(fieldName)) {
				if (fieldMappingName != null) {
					return fieldMappingName;
				} else {
					return "N";
				}
			} else if ("ru_provisiona".equals(fieldName)) {
				if (fieldMappingName != null) {
					return fieldMappingName;
				} else {
					return "N";
				}
			} else if ("ru_diferir".equals(fieldName)) {
				if (fieldMappingName != null) {
					return fieldMappingName;
				} else {
					return "N";
				}
			} else {
				return fieldMappingName;
			}
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.002", "getPortfolioValue"));
		}
	}

	public Long manageItem(Item item) {
		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.001", "manageItem"));

			Integer sequential = itemPortfolioManagerService
					.getSequentialItemCode();

			item.setCode(sequential);

			ConceptPortfolio concept = new ConceptPortfolio(item.getName(),
					item.getDescription(), sequential, item.getValueType());

			itemPortfolioManagerService.manageConcept(concept);

			return item.getId();
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("PORTFOLIOITEMMANAGER.099"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.002", "manageItem"));
		}
	}

	public void deleteItem(Long itemId) {
		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.001", "deleteItem"));

			Item existItem = itemsManagerService.getItem(itemId);
			itemPortfolioManagerService.deleteConcept(existItem.getName());

		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("PORTFOLIOITEMMANAGER.099"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.002", "deleteItem"));
		}
	}

	public List<Catalog> getItemsGroup() {
		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.001", "getItemsGroup"));

			return itemPortfolioManagerService.getItemsGroup();

		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("PORTFOLIOITEMMANAGER.099"), ex);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador");
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOITEMMANAGER.002", "getItemsGroup"));
		}
	}

}
