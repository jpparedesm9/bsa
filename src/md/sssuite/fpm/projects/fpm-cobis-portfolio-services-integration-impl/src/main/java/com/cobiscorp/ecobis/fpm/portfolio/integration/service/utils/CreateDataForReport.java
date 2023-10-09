package com.cobiscorp.ecobis.fpm.portfolio.integration.service.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.bo.ItemValueInformation;
import com.cobiscorp.ecobis.fpm.bo.PhysicalField;
import com.cobiscorp.ecobis.fpm.interceptors.service.IDefaultValuesManager;
import com.cobiscorp.ecobis.fpm.model.AmountItemValue;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.CoreTable;
import com.cobiscorp.ecobis.fpm.model.CurrencyProduct;
import com.cobiscorp.ecobis.fpm.model.ItemAppliesWay;
import com.cobiscorp.ecobis.fpm.model.ItemByProduct;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.operation.service.IItemsManager;
import com.cobiscorp.ecobis.fpm.operation.service.IMappingFieldManager;
import com.cobiscorp.ecobis.fpm.portfolio.service.IDefaultOperationManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;

public class CreateDataForReport {

	/** COBIS Logger */
	private static final ILogger logger = LogFactory
			.getLogger(CreateDataForReport.class);
	private static Map<String, String> defaultValues;

	public static void createDataForReport(
			IMappingFieldManager mappingFieldService,
			IDefaultValuesManager defaultValuesManager,
			IBankingProductManager bankingProductManager,
			IDefaultOperationManager defaultOperationService,
			BankingProductHistory bankingProductHistorId, String dictionaryType, IItemsManager itemsManagerService) {
		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOGENERALPARAMETERMANAGER.001",
					"createDataForReport"));

			List<Map> rowFields = new ArrayList<Map>();
			HashMap<String, PhysicalField> gpMapping = new HashMap<String, PhysicalField>();
			HashMap<String, PhysicalField> gpMappingDelete = new HashMap<String, PhysicalField>();
			HashMap<CoreTable, List> coreTableInformation = new HashMap<CoreTable, List>();
			Map<CoreTable, Map<String, PhysicalField>> deleteCoreTableInformation = new HashMap<CoreTable, Map<String, PhysicalField>>();

			List<CoreTable> coreTableList = mappingFieldService
					.getPhysicalFieldsMappingsSpecific(bankingProductHistorId.getProductId(), dictionaryType);
			
			defaultValues = defaultValuesManager.getDefaultValues();

			if (logger.isDebugEnabled())
				logger.logDebug("Recupero List<CoreTable> size: "
						+ coreTableList.size());

				if (Constants.GENERAL_PARAMETERS_DICTIONARY_REPORT.equals(dictionaryType)) {
					for (CoreTable coreTable : coreTableList) {
						if (logger.isDebugEnabled())
							logger.logDebug("Table : " + coreTable.getTable());

						gpMapping.clear();
					
						for (PhysicalField physicalField : coreTable.getPhysicalFields()) {
	
							if (logger.isDebugEnabled())
								logger.logDebug("PhysicalField name: "
										+ physicalField.getPhysicalFieldName()
										+ "PhysicalField value: "
										+ physicalField.getValue());
	
							gpMapping.put(physicalField.getPhysicalFieldName(), physicalField);
						}
						
						if (!gpMapping.containsKey("dt_toperacion")) {
							PhysicalField operation = new PhysicalField("dt_toperacion", "varchar(10)", bankingProductHistorId.getProductId());
							gpMapping.put("dt_toperacion", operation);
	
							PhysicalField operationDelete = new PhysicalField("dt_toperacion", "varchar(10)", bankingProductHistorId.getProductId());
							gpMappingDelete.put("dt_toperacion", operationDelete);
						}
	
						verifiedValueForDefault(defaultValuesManager, gpMapping);
						
						BankingProduct bankingProduct = bankingProductManager.getBankingProductBasicInformationById(bankingProductHistorId.getProductId());
	
						if (logger.isDebugEnabled())
							logger.logDebug("Recupero currencies size: "
									+ bankingProduct.getCurrencyProducts().size());
	
						for (CurrencyProduct currencyProduct : bankingProduct.getCurrencyProducts()) {
	
								if (!gpMapping.containsKey("dt_moneda")) {
									PhysicalField currency = new PhysicalField("dt_moneda", "tinyint", currencyProduct.getId().getCurrencyId());
									gpMapping.put("dt_moneda", currency);
	
									PhysicalField currencyDelete = new PhysicalField("dt_moneda", "tinyint", currencyProduct.getId().getCurrencyId());
									gpMappingDelete.put("dt_moneda", currencyDelete);
	
									if (logger.isDebugEnabled()) {
										logger.logDebug("Código de moneda: "
												+ currencyProduct.getId()
														.getCurrencyId());
									}
	
								} else {
									((PhysicalField) gpMapping.get("dt_moneda")).setValue(currencyProduct.getId().getCurrencyId());
	
									((PhysicalField) gpMappingDelete.get("dt_moneda")).setValue(currencyProduct.getId().getCurrencyId());
	
									if (logger.isDebugEnabled()) {
										logger.logDebug("Código de moneda: "
												+ currencyProduct.getId()
														.getCurrencyId());
									}
								}
								
								rowFields.clear();
								rowFields.add(gpMapping);
	
								coreTableInformation.clear();
								coreTableInformation.put(coreTable, rowFields);
	
								deleteCoreTableInformation.clear();
								deleteCoreTableInformation.put(coreTable, gpMappingDelete);
								defaultOperationService.deleteDynamicCredit(deleteCoreTableInformation);
								defaultOperationService.insertDynamicCreditOperationGeneralParameters(coreTableInformation);
						}
					}
			  }else{//Sección Rubros para reporte
				  
					initializeDeleteValues(bankingProductHistorId.getProductId(), gpMappingDelete);
					for (CoreTable coreTable : coreTableList) {
						deleteCoreTableInformation.clear();
						deleteCoreTableInformation.put(coreTable, gpMappingDelete);
						defaultOperationService.deleteDynamicCredit(deleteCoreTableInformation);
					}
				  
					List<ItemByProduct> itemByProducts = itemsManagerService.getAllDataForItemsByProduct(bankingProductHistorId.getProductId());
					
					for (ItemByProduct itemByProduct : itemByProducts) {
						
						gpMapping.clear();
						
						if (logger.isDebugEnabled())
							logger.logDebug("Data corresponde a Rubro: "+ itemByProduct.getItem().getName());
						
						if(!"C".equals(itemByProduct.getItemType()))
						{
							for (ItemAppliesWay itemAppliesWay : itemByProduct.getItemAppliesWaysList()) {
	
								for (AmountItemValue amountItemValue : itemAppliesWay.getItemValuesList()) {
									
									String name = itemByProduct.getItem().getName();
									String type = itemByProduct.getItemType();
									String applyNodeType = itemAppliesWay.getAppliesToWhenApply().getWhenApplyNodeType().getApplyNodeTypeId();
									String valueReference = amountItemValue.getValueReference();
									String rateChangeRate = amountItemValue.getRateReadJustment();
									String conceptAssociated = null;
									if (itemAppliesWay.getItemReference() != null && !"".equals(itemAppliesWay.getItemReference().trim()))
									{
										conceptAssociated = itemsManagerService
												.getItem(
														Long.parseLong(itemAppliesWay
																.getItemReference())).getName();
									}
									String maximumLimit =  ((Long)amountItemValue.getMaximumLimit()).toString();
									String minimumLimit = ((Long)amountItemValue.getMinimumLimit()).toString();
									
									for (CoreTable coreTable : coreTableList) {
										
										if (logger.isDebugEnabled())
											logger.logDebug("Table : " + coreTable.getTable());
										
										List<PhysicalField> physicalFieldForItem = new ArrayList<PhysicalField>();
										
										for (PhysicalField physicalField : coreTable.getPhysicalFields()) {
											
											if(physicalField.getItemId() == itemByProduct.getItem().getId()){
												physicalFieldForItem.add(physicalField);
											}
										}
										
										if (logger.isDebugEnabled())
											logger.logDebug("Tamaño valores diccionario: "+ physicalFieldForItem.size());
										
										initializeValues(bankingProductHistorId.getProductId(),
										amountItemValue.getAmountItemValuesId().getCurrencyProductId().getCurrencyId(), 
										name, type,
										applyNodeType,
										valueReference, rateChangeRate, conceptAssociated,
										maximumLimit, minimumLimit,physicalFieldForItem, gpMapping, gpMappingDelete);
										
										rowFields.clear();
										rowFields.add(gpMapping);
			
										coreTableInformation.clear();
										coreTableInformation.put(coreTable, rowFields);
			
										deleteCoreTableInformation.clear();
										deleteCoreTableInformation.put(coreTable, gpMappingDelete);
										defaultOperationService.deleteDynamicCredit(deleteCoreTableInformation);
										defaultOperationService.insertDynamicCreditOperationGeneralParameters(coreTableInformation);
									}
								}
							}
						}else{
							
							for (ItemAppliesWay itemAppliesWay : itemByProduct.getItemAppliesWaysList()) {
								
								String name = itemByProduct.getItem().getName();
								String type = itemByProduct.getItemType();
								String applyNodeType = itemAppliesWay.getAppliesToWhenApply().getWhenApplyNodeType().getApplyNodeTypeId();
								String valueReference = null;
								String rateChangeRate = null;
								String conceptAssociated = null;
								if (itemAppliesWay.getItemReference() != null && !"".equals(itemAppliesWay.getItemReference().trim()))
								{
									conceptAssociated = itemsManagerService
											.getItem(
													Long.parseLong(itemAppliesWay
															.getItemReference())).getName();
								}
								String maximumLimit =  null;
								String minimumLimit = null;
								
								for (CoreTable coreTable : coreTableList) {
									
									if (logger.isDebugEnabled())
										logger.logDebug("Table : " + coreTable.getTable());
									
									List<PhysicalField> physicalFieldForItem = new ArrayList<PhysicalField>();
									
									for (PhysicalField physicalField : coreTable.getPhysicalFields()) {
										
										if(physicalField.getItemId() == itemByProduct.getItem().getId()){
											physicalFieldForItem.add(physicalField);
										}
									}
									
									if (logger.isDebugEnabled())
										logger.logDebug("Tamaño valores diccionario: "+ physicalFieldForItem.size());
									
									BankingProduct bankingProduct = bankingProductManager.getBankingProductBasicInformationById(bankingProductHistorId.getProductId());
									
									for (CurrencyProduct currencyProduct : bankingProduct.getCurrencyProducts()) {

										initializeValues(bankingProductHistorId.getProductId(),
										currencyProduct.getId().getCurrencyId(), 
										name, type,
										applyNodeType,
										valueReference, rateChangeRate, conceptAssociated,
										maximumLimit, minimumLimit,physicalFieldForItem, gpMapping, gpMappingDelete);
										
										rowFields.clear();
										rowFields.add(gpMapping);
			
										coreTableInformation.clear();
										coreTableInformation.put(coreTable, rowFields);
			
										deleteCoreTableInformation.clear();
										deleteCoreTableInformation.put(coreTable, gpMappingDelete);
										defaultOperationService.deleteDynamicCredit(deleteCoreTableInformation);
										defaultOperationService.insertDynamicCreditOperationGeneralParameters(coreTableInformation);
									}
								}
							}
							
						}
					}
			  }
			

		} catch (BusinessException be) {
			throw be;
		} catch (Exception e) {
			logger.logError(MessageManager
					.getString("PORTFOLIOGENERALPARAMETERMANAGER.003"), e);
			throw new BusinessException(6900001,
					"Existió un fallo en la operación. Comuníquese con el Administrador.");

		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOGENERALPARAMETERMANAGER.002",
					"createDataForReport"));
		}
	}

	/**
	 * 
	 * Verified Value
	 * 
	 * @param gpMapping
	 */
	private static void verifiedValueForDefault(
			IDefaultValuesManager defaultValuesManager,
			HashMap<String, PhysicalField> gpMapping) {

		logger.logDebug(MessageManager.getString(
				"GENERALPARAMETERSINTERCEPTOR.001", "verifiedValueForDefault"));

		try {

			PhysicalField fundsOwn = null;

			Map<String, String> defaultValues = defaultValuesManager
					.getDefaultValues();

			// Verified origin for determine origin own funds
			/*if (gpMapping.get("dt_origen_fondo") != null
					&& gpMapping
							.get("dt_origen_fondo")
							.getValue()
							.trim()
							.equals(defaultValues
									.get(Constants.INTERCEPTORS.SOURCE_OF_FUNDS))) {
				fundsOwn = new PhysicalField("dt_fondos_propios", "char(1)",
						defaultValues
								.get(Constants.INTERCEPTORS.SOURCE_OF_FUNDS_S));

				gpMapping.put("dt_fondos_propios", fundsOwn);
			} else {
				fundsOwn = new PhysicalField("dt_fondos_propios", "char(1)",
						defaultValues
								.get(Constants.INTERCEPTORS.SOURCE_OF_FUNDS_N));
				gpMapping.put("dt_fondos_propios", fundsOwn);
			}*/

			if (!gpMapping.containsKey("dt_precancelacion")) {
				PhysicalField prepayment = new PhysicalField(
						"dt_precancelacion", "varchar(10)",
						defaultValues.get(Constants.INTERCEPTORS.PREPAYMENT));
				gpMapping.put("dt_precancelacion", prepayment);
			}
			if (!gpMapping.containsKey("dt_cuota_completa")) {
				PhysicalField fullQuota = new PhysicalField(
						"dt_cuota_completa", "char(1)",
						defaultValues
								.get(Constants.INTERCEPTORS.COMPLETE_QUOTA));
				gpMapping.put("dt_cuota_completa", fullQuota);
			}
			if (!gpMapping.containsKey("dt_tplazo")) {
				PhysicalField tTimeLimit = new PhysicalField("dt_tplazo",
						"varchar(1)",
						defaultValues.get(Constants.INTERCEPTORS.T_TERM));
				gpMapping.put("dt_tplazo", tTimeLimit);
			}
			if (!gpMapping.containsKey("dt_plazo")) {
				PhysicalField timeLimit = new PhysicalField("dt_plazo",
						"smallint",
						defaultValues.get(Constants.INTERCEPTORS.TERM));
				gpMapping.put("dt_plazo", timeLimit);
			}
			if (!gpMapping.containsKey("dt_tdividendo")) {
				PhysicalField dividend = new PhysicalField("dt_tdividendo",
						"varchar(10)",
						defaultValues.get(Constants.INTERCEPTORS.DIVIDEND));
				gpMapping.put("dt_tdividendo", dividend);
			}
			if (!gpMapping.containsKey("dt_periodo_cap")) {
				PhysicalField capPeriod = new PhysicalField("dt_periodo_cap",
						"smallint",
						defaultValues.get(Constants.INTERCEPTORS.PERIOD_CAP));
				gpMapping.put("dt_periodo_cap", capPeriod);
			}
			if (!gpMapping.containsKey("dt_periodo_int")) {
				PhysicalField intPeriod = new PhysicalField("dt_periodo_int",
						"smallint",
						defaultValues.get(Constants.INTERCEPTORS.PERIOD_INT));
				gpMapping.put("dt_periodo_int", intPeriod);
			}
			if (!gpMapping.containsKey("dt_gracia_cap")) {
				PhysicalField capGain = new PhysicalField("dt_gracia_cap",
						"smallint",
						defaultValues.get(Constants.INTERCEPTORS.GRACE_CAP));
				gpMapping.put("dt_gracia_cap", capGain);
			}
			if (!gpMapping.containsKey("dt_gracia_int")) {
				PhysicalField intGain = new PhysicalField("dt_gracia_int",
						"smallint",
						defaultValues.get(Constants.INTERCEPTORS.GRACE_INT));
				gpMapping.put("dt_gracia_int", intGain);
			}
			if (!gpMapping.containsKey("dt_dist_gracia")) {
				PhysicalField distGain = new PhysicalField("dt_dist_gracia",
						"char(1)",
						defaultValues.get(Constants.INTERCEPTORS.DIST_GRACE));
				gpMapping.put("dt_dist_gracia", distGain);
			}
			if (!gpMapping.containsKey("dt_dias_gracia")) {
				PhysicalField daysGain = new PhysicalField("dt_dias_gracia",
						"tinyint",
						defaultValues.get(Constants.INTERCEPTORS.DAYS_OF_GRACE));
				gpMapping.put("dt_dias_gracia", daysGain);
			}
			if (!gpMapping.containsKey("dt_mes_gracia")) {
				PhysicalField monthGain = new PhysicalField("dt_mes_gracia",
						"tinyint",
						defaultValues
								.get(Constants.INTERCEPTORS.MONTH_OF_GRACE));
				gpMapping.put("dt_mes_gracia", monthGain);
			}
			/*if (!gpMapping.containsKey("dt_cuota_menor")) {
				PhysicalField lessQuota = new PhysicalField("dt_cuota_menor",
						"char(1)",
						defaultValues.get(Constants.INTERCEPTORS.SMALL_QUOTA));
				gpMapping.put("dt_cuota_menor", lessQuota);
			}*/
			if (!gpMapping.containsKey("dt_prd_cobis")) {
				PhysicalField prdCOBIS = new PhysicalField("dt_prd_cobis",
						"tinyint",
						defaultValues.get(Constants.INTERCEPTORS.PRD_COBIS));
				gpMapping.put("dt_prd_cobis", prdCOBIS);
			}
			/*if (!gpMapping.containsKey("dt_dia_ppago")) {
				PhysicalField dayPayment = new PhysicalField("dt_dia_ppago",
						"tinyint",
						defaultValues.get(Constants.INTERCEPTORS.DAY_PPAYMENT));
				gpMapping.put("dt_dia_ppago", dayPayment);
			}
			if (!gpMapping.containsKey("dt_subsidio")) {
				PhysicalField subsidy = new PhysicalField("dt_subsidio",
						"char(1)",
						defaultValues.get(Constants.INTERCEPTORS.SUBSIDY));
				gpMapping.put("dt_subsidio", subsidy);
			}
			if (!gpMapping.containsKey("dt_tpreferencial")) {
				PhysicalField tPreference = new PhysicalField(
						"dt_tpreferencial", "char(1)",
						defaultValues
								.get(Constants.INTERCEPTORS.T_PREFERENTIAL));
				gpMapping.put("dt_tpreferencial", tPreference);
			}
			if (!gpMapping.containsKey("dt_modo_reest")) {
				PhysicalField reestMode = new PhysicalField("dt_modo_reest",
						"char(1)",
						defaultValues.get(Constants.INTERCEPTORS.MODE_REEST));
				gpMapping.put("dt_modo_reest", reestMode);
			}
			if (!gpMapping.containsKey("dt_efecto_pago")) {
				PhysicalField effectPayment = new PhysicalField(
						"dt_efecto_pago", "char(1)",
						defaultValues
								.get(Constants.INTERCEPTORS.EFFECT_PAYMENT));
				gpMapping.put("dt_efecto_pago", effectPayment);
			}*/
			if (!gpMapping.containsKey("dt_dias_anio")) {
				PhysicalField daysYear = new PhysicalField("dt_dias_anio",
						"smallint",
						defaultValues.get(Constants.INTERCEPTORS.DAYS_OF_YEARS));

				gpMapping.put("dt_dias_anio", daysYear);
			}
			if (!gpMapping.containsKey("dt_dia_pago")) {
				PhysicalField dayPayment = new PhysicalField("dt_dia_pago",
						"tinyint",
						defaultValues
								.get(Constants.INTERCEPTORS.DAY_OF_PAYMENT));

				gpMapping.put("dt_dia_pago", dayPayment);
			}
			/*if (!gpMapping.containsKey("dt_tipo_prioridad")) {
				PhysicalField priorityType = new PhysicalField(
						"dt_tipo_prioridad", "char(1)",
						defaultValues.get(Constants.INTERCEPTORS.PRIORITY_TYPE));

				gpMapping.put("dt_tipo_prioridad", priorityType);
			}*/
			if (!gpMapping.containsKey("dt_cuota_fija")) {

				PhysicalField priorityType = new PhysicalField(
						"dt_cuota_fija",
						"char(1)",
						gpMapping.get("dt_tipo_amortizacion") != null
								&& gpMapping.get("dt_tipo_amortizacion")
										.getValue() == defaultValues
										.get(Constants.INTERCEPTORS.AMORTIZATION_TYPE) ? defaultValues
								.get(Constants.INTERCEPTORS.FIX_QUOTA_N)
								: defaultValues
										.get(Constants.INTERCEPTORS.FIX_QUOTA_S));

				gpMapping.put("dt_cuota_fija", priorityType);
			}

			if (!gpMapping.containsKey("dt_aceptar_anticipos")) {
				PhysicalField acceptAdvances = new PhysicalField(
						"dt_aceptar_anticipos", "char(1)",
						defaultValues
								.get(Constants.INTERCEPTORS.ACCEPT_ADVANCES));

				gpMapping.put("dt_aceptar_anticipos", acceptAdvances);
			}

			// dt_evitar_feriados
			if (!gpMapping.containsKey("dt_evitar_feriados")) {
				PhysicalField avoidHolidays = new PhysicalField(
						"dt_evitar_feriados", "char(1)",
						defaultValues
								.get(Constants.INTERCEPTORS.PREVENT_HOLIDAYS));

				gpMapping.put("dt_evitar_feriados", avoidHolidays);
			}
			
			//mappins excel
			if (!gpMapping.containsKey("dt_evitar_feriados")) {
				PhysicalField avoidHolidays = new PhysicalField(
						"dt_evitar_feriados", "char(1)",
						defaultValues
								.get(Constants.INTERCEPTORS.PREVENT_HOLIDAYS));

				gpMapping.put("dt_evitar_feriados", avoidHolidays);
			}

			logger.logDebug(MessageManager
					.getString("GENERALPARAMETERSINTERCEPTOR.019"));

		} finally {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERSINTERCEPTOR.002",
					"verifiedValueForDefault"));
		}
	}
	
	private static void initializeValues(String operation, String currency,
			String itemName, String itemType, String formPayment,
			String valueReference, String rateChangeRate,
			String conceptAssociated, String maximumLimit, String minimumLimit,
			List<PhysicalField> physicalFieldList, 
			HashMap<String, PhysicalField> gpMapping, HashMap<String, PhysicalField> gpMappingDelete) {

		try {
			logger.logDebug(MessageManager.getString("ITEMSINTERCEPTOR.001",
					"initializeValues"));
			
			PhysicalField operationPF = new PhysicalField("ru_toperacion",  "varchar(10)", operation);
			if (gpMapping.containsKey("ru_toperacion")) {
				gpMapping.remove("ru_toperacion");
			}
			gpMapping.put("ru_toperacion", operationPF);
			
			if (gpMappingDelete.containsKey("ru_toperacion")) {
				gpMappingDelete.remove("ru_toperacion");
			}
			gpMappingDelete.put("ru_toperacion", operationPF);
			
			PhysicalField currencyPF = new PhysicalField("ru_moneda", "tinyint", currency);
			if (gpMapping.containsKey("ru_moneda")) {
				gpMapping.remove("ru_moneda");
			}
			gpMapping.put("ru_moneda", currencyPF);

			if (gpMappingDelete.containsKey("ru_moneda")) {
				gpMappingDelete.remove("ru_moneda");
			}
			gpMappingDelete.put("ru_moneda", currencyPF);

			PhysicalField itemNamePF = new PhysicalField("ru_concepto", "varchar(10)", itemName);
			if (gpMapping.containsKey("ru_concepto")) {
				gpMapping.remove("ru_concepto");
			}
			gpMapping.put("ru_concepto", itemNamePF);

			if (gpMappingDelete.containsKey("ru_concepto")) {
				gpMappingDelete.remove("ru_concepto");
			}
			gpMappingDelete.put("ru_concepto", itemNamePF);


			PhysicalField itemTypePF = new PhysicalField("ru_tipo_rubro", "varchar(10)", itemType);
			if (gpMapping.containsKey("ru_tipo_rubro")) {
				gpMapping.remove("ru_tipo_rubro");
			}
			gpMapping.put("ru_tipo_rubro", itemTypePF);

			PhysicalField formPaymentPF = new PhysicalField("ru_fpago", "char(1)", formPayment);
			if (gpMapping.containsKey("ru_fpago")) {
				gpMapping.remove("ru_fpago");
			}
			gpMapping.put("ru_fpago", formPaymentPF);
			
			if (gpMappingDelete.containsKey("ru_fpago")) {
				gpMappingDelete.remove("ru_fpago");
			}
			gpMappingDelete.put("ru_fpago", formPaymentPF);

			if (valueReference != null && !valueReference.trim().equals("")) {
				PhysicalField valueReferencePF = new PhysicalField( "ru_referencial", "char(1)", valueReference);
				if (gpMapping.containsKey("ru_referencial")) {
					gpMapping.remove("ru_referencial");
				}
				gpMapping.put("ru_referencial", valueReferencePF);
			}

			if (rateChangeRate != null && !rateChangeRate.trim().equals("")) {
				PhysicalField rateChangeRatePF = new PhysicalField( "ru_reajuste", "varchar(10)", rateChangeRate);
				if (gpMapping.containsKey( "ru_reajuste")) {
					gpMapping.remove("ru_reajuste");
				}
				gpMapping.put("ru_reajuste", rateChangeRatePF);
			}

			if (conceptAssociated != null && !conceptAssociated.trim().equals("")) {
				PhysicalField conceptAssociatedPF = new PhysicalField( "ru_concepto_asociado", "varchar(10)", conceptAssociated);
				if (gpMapping.containsKey( "ru_concepto_asociado")) {
					gpMapping.remove( "ru_concepto_asociado");
				}
				gpMapping.put( "ru_concepto_asociado", conceptAssociatedPF);
			}
			
			if (!gpMapping.containsKey("ru_estado")) {
				PhysicalField state = new PhysicalField("ru_estado", "varchar(10)", defaultValues.get(Constants.INTERCEPTORS.STATE));
				gpMapping.put("ru_estado", state);
			}

			if (!gpMapping.containsKey( "ru_valor_max")) {
				PhysicalField maximumLimitPF = new PhysicalField( "ru_valor_max", "int", defaultValues.get(Constants.INTERCEPTORS.VALUE_MAX));
				gpMapping.put("ru_valor_max", maximumLimitPF);
			}

			if (!gpMapping.containsKey( "ru_valor_min")) {
				PhysicalField minimumLimitPF = new PhysicalField( "ru_valor_min", "int", defaultValues.get(Constants.INTERCEPTORS.VALUE_MIN));
				gpMapping.put("ru_valor_min", minimumLimitPF);
			}
			
			if (!gpMapping.containsKey("ru_prioridad")) {
				PhysicalField priority = new PhysicalField( "ru_prioridad", "tinyint", defaultValues.get(Constants.INTERCEPTORS.PRIORITY));
				gpMapping.put("ru_prioridad", priority);
			}
			
			if (!gpMapping.containsKey("ru_paga_mora")) {
				PhysicalField paymentDue = new PhysicalField( "ru_paga_mora", "char(1)", defaultValues.get(Constants.INTERCEPTORS.PAYMENT_DUE));
				gpMapping.put("ru_paga_mora", paymentDue);
			}
			
			if (!gpMapping.containsKey("ru_provisiona")) {
				PhysicalField provisioned = new PhysicalField( "ru_provisiona", "char(1)",defaultValues.get(Constants.INTERCEPTORS.PROVISIONED));
				gpMapping.put("ru_provisiona", provisioned);
			}

			if (!gpMapping.containsKey("ru_diferir")) {
				PhysicalField defer = new PhysicalField( "ru_diferir", "char(1)",defaultValues.get(Constants.INTERCEPTORS.DEFER));
				gpMapping.put("ru_diferir", defer);
			}

			//Lista de valor del diccionario de datos
			for (PhysicalField physicalField : physicalFieldList) {
				gpMapping.put(physicalField.getPhysicalFieldName(), physicalField);
			}
		} finally {
			logger.logDebug(MessageManager.getString("ITEMSINTERCEPTOR.002", "initializeValues"));
		}

	}
	
	
	private static void initializeDeleteValues(String operation, HashMap<String, PhysicalField> gpMappingDelete) {

		try {
			logger.logDebug(MessageManager.getString("ITEMSINTERCEPTOR.001",
					"initializeDeleteValues"));
			
			PhysicalField operationPF = new PhysicalField("ru_toperacion",  "varchar(10)", operation);
			
			if (gpMappingDelete.containsKey("ru_toperacion")) {
				gpMappingDelete.remove("ru_toperacion");
			}
			gpMappingDelete.put("ru_toperacion", operationPF);
			
		} finally {
			logger.logDebug(MessageManager.getString("ITEMSINTERCEPTOR.002", "initializeDeleteValues"));
		}

	}
}
