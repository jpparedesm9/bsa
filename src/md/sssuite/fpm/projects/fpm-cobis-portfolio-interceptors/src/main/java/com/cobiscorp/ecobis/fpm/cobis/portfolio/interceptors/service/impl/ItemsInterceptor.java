/*
 * File: ItemsInterceptor.java
 * Date: April 04 2012
 *
 * Copyright (c) 2011 Cobiscorp (Banking Technology Partners) SA, All Rights Reserved.
 *
 * This code is confidential to Cobiscorp and shall not be disclosed outside Cobiscorp                                      
 * without the prior written permission of the Technology Center.
 *
 * In the event that such disclosure is permitted the code shall not be copied
 * or distributed other than on a need-to-know basis and any recipients may be
 * required to sign a confidentiality undertaking in favor of Cobiscorp SA.
 */

package com.cobiscorp.ecobis.fpm.cobis.portfolio.interceptors.service.impl;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IMessageBlock;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.dtos.MessageBlock;
import com.cobiscorp.cobis.cts.dtos.ProcedureResponseAS;
import com.cobiscorp.cobis.cts.interceptors.CobisInterceptor;
import com.cobiscorp.cobis.cts.interceptors.CobisInterceptorContext;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleProcess;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleVersion;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.bpl.rules.engine.model.VariableProcess;
import com.cobiscorp.ecobis.bpl.rules.engine.services.IRuleManager;
import com.cobiscorp.ecobis.fpm.bo.ItemValueInformation;
import com.cobiscorp.ecobis.fpm.bo.PhysicalField;
import com.cobiscorp.ecobis.fpm.cobis.portfolio.interceptors.service.utils.MessageManager;
import com.cobiscorp.ecobis.fpm.extractors.administration.service.IExtractorManager;
import com.cobiscorp.ecobis.fpm.interceptors.service.IDefaultValuesManager;
import com.cobiscorp.ecobis.fpm.model.AmountItemValueHistory;
import com.cobiscorp.ecobis.fpm.model.CoreTable;
import com.cobiscorp.ecobis.fpm.model.Item;
import com.cobiscorp.ecobis.fpm.model.ItemAppliesWayHistory;
import com.cobiscorp.ecobis.fpm.model.ItemByProductHistory;
import com.cobiscorp.ecobis.fpm.operation.service.IItemsManager;
import com.cobiscorp.ecobis.fpm.portfolio.service.IDefaultOperationManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;

/**
 * Intercepts the sp_crear_operacion stored procedure, read information from FPM
 * referent items
 * 
 * @author oguano
 * 
 */
public class ItemsInterceptor implements CobisInterceptor {

	List<Map<CoreTable, Map<String, PhysicalField>>> coreTableInformationList = new ArrayList<Map<CoreTable, Map<String, PhysicalField>>>();
	Map<String, String> defaultValues = null;

	// region Fields
	/** Cobis Logger */
	private static final ILogger logger = LogFactory.getLogger(ItemsInterceptor.class);

	/** ItemsManager Service */
	private IItemsManager itemsManagerService;
	/** OperationManager Service */
	private IDefaultOperationManager defaultOperationManager;

	/** ExtractorManager Service */
	private IExtractorManager extractorManagerService;
	/** IRuleManager Service */
	private IRuleManager rulesManager;

	// Rule object
	private Rule rule;

	// list process to get the condition list for execute the rule
	private List<VariableProcess> listVariableProcess;
	// VariableProcess object
	private VariableProcess variableProcees;
	// result of execute rule
	private String resultValueRules;

	private static final String COMPARE_RULE = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

	// Determine if the value for field ratechangerate must be set
	private static final String RATE = "I,M";

	/** IDefaultValuesManager Service */
	private IDefaultValuesManager defaultValuesManager;

	// end-region

	// region Properties
	/**
	 * @param rulesManager
	 */
	public void setRulesManager(IRuleManager rulesManager) {
		this.rulesManager = rulesManager;
	}

	/**
	 * @param extractorManagerService
	 */
	public void setExtractorManagerService(IExtractorManager extractorManagerService) {
		this.extractorManagerService = extractorManagerService;
	}

	/**
	 * @param itemsManagerService
	 */
	public void setItemsManagerService(IItemsManager itemsManagerService) {
		this.itemsManagerService = itemsManagerService;
	}

	/**
	 * @param defaultOperationManager
	 */
	public void setDefaultOperationManager(IDefaultOperationManager defaultOperationManager) {
		this.defaultOperationManager = defaultOperationManager;
	}

	/**
	 * @param defaultValuesManager
	 */
	public void setDefaultValuesManager(IDefaultValuesManager defaultValuesManager) {
		this.defaultValuesManager = defaultValuesManager;
	}

	// end-region

	// region Implements CobisInterceptor
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.cobiscorp.cobis.cts.interceptors.CobisInterceptor#execute(com.cobiscorp
	 * .cobis.cts.interceptors.CobisInterceptorContext)
	 */
	@SuppressWarnings("unchecked")
	public void execute(CobisInterceptorContext context) {

		logger.logDebug(MessageManager.getString("ITEMSINTERCEPTOR.001", "execute"));

		IProcedureResponse interceptorResponse = null;
		IProcedureRequest request = null;
		// Date history
		String systemDateHistory = null;
		// Date in milliseconds
		Timestamp operationDate;
		// Save banking product id
		String tOperation = null;
		// List items history
		List<HashMap<String, Object>> historyItemsList = null;
		// ItemByProductHistory object
		ItemByProductHistory itemByProductHistory = null;
		// Item object
		Item item = null;
		// itemsValuesHistory
		HashMap<String, ItemValueInformation> itemsValuesHistory = null;
		// ItemAppliesWayHistory object
		ItemAppliesWayHistory itemAppliesWayHistory = null;
		// AmountItemValueHistory obejct
		AmountItemValueHistory amountItemValueHistory = null;
		// items reference
		String conceptAssociated = null;
		// Date sent from frontend
		String date = null;
		// Rate reference
		String valueReference = null;
		// Rate change rate
		String rateChangeRate = null;
		// Maximum limit
		Long maximumLimit = 0L;
		// Minimum limit
		Long minimumLimit = 0L;

		// Map<CoreTable, Map<String, PhysicalField>> coreTableInformation = new
		// HashMap<CoreTable, Map<String, PhysicalField>>();

		interceptorResponse = new ProcedureResponseAS();
		request = context.getValue(CobisInterceptorContext.PROCEDURE_REQUEST_KEY);

		// Verified if logic must be executed
		Boolean execute = false;

		try {

			// Get module mnemonic
			if (context.getValue(request.readParam("@s_ssn").getValue().concat("mnemonic")).equals("CCA")) {
				execute = true;

				if (request.readParam("@t_trn") != null) {
					if (request.readParam("@t_trn").getValue().trim().equals("1800140")) {
						if (request.readParam("@i_operacion") != null) {
							if (!request.readParam("@i_operacion").getValue().trim().equals("C")) {
								execute = false;
							}
						}
					}

				}
			}

			if (execute) {
				logger.logDebug("Interceptando SP: " + request.getSpName());

				if (request.readParam("@t_trn") == null || request.readParam("@t_trn").getValue() == null)
					return;

				// Get date history

				if (request.readParam("@i_fecha_ini") != null) {

					systemDateHistory = request.readParam("@i_fecha_ini").getValue()
							.substring(request.readParam("@i_fecha_ini").getValue().indexOf("-") + 1, request.readParam("@i_fecha_ini").getValue().length());
				} else {
					systemDateHistory = request.readParam("@i_fecha_inicio").getValue()
							.substring(request.readParam("@i_fecha_inicio").getValue().indexOf("-") + 1, request.readParam("@i_fecha_inicio").getValue().length());
				}

				// Convert date history to Timestamp
				operationDate = new Timestamp(Long.parseLong(systemDateHistory));

				// Get operation value
				tOperation = request.readParam("@i_toperacion").getValue();

				// Get items history data
				historyItemsList = itemsManagerService.getHistory(operationDate, tOperation, Long.parseLong(request.readParam("@i_moneda").getValue()));

				if (historyItemsList.size() == 0) {
					logger.logError(MessageManager.getString("ITEMSINTERCEPTOR.004"));

					IMessageBlock message = new MessageBlock(6901011, "No se pudo recuperar los valores correspondientes a rubros del FPM.");
					interceptorResponse.addResponseBlock(message);
					interceptorResponse.setReturnCode(6901011);

					context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);

					return;
				}

				defaultValues = defaultValuesManager.getDefaultValues();

				for (HashMap<String, Object> historyItem : historyItemsList) {

					Map<CoreTable, Map<String, PhysicalField>> coreTableInformation = new HashMap<CoreTable, Map<String, PhysicalField>>();

					// Get data for ItemByProductHistory
					if (historyItem.get(Constants.ITEMS_BY_PRODUCT) != null) {
						itemByProductHistory = (ItemByProductHistory) historyItem.get(Constants.ITEMS_BY_PRODUCT);

						item = itemsManagerService.getItem(itemByProductHistory.getItemIdentifier());

					} else {
						logger.logError(MessageManager.getString("ITEMSINTERCEPTOR.005", "ItemByProductHistory"));

						IMessageBlock message = new MessageBlock(6901011, "No se pudo recuperar los valores correspondientes a rubros del FPM.");
						interceptorResponse.addResponseBlock(message);
						interceptorResponse.setReturnCode(6901011);

						context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);
						return;
					}

					// Get data for ItemsValuesHistory
					if (historyItem.get(Constants.ITEMS_VALUES) != null) {
						itemsValuesHistory = ((HashMap<String, ItemValueInformation>) historyItem.get(Constants.ITEMS_VALUES));
					} else {
						logger.logError(MessageManager.getString("ITEMSINTERCEPTOR.005", "ItemsValuesHistory"));

						IMessageBlock message = new MessageBlock(6901011, "No se pudo recuperar los valores correspondientes a rubros del FPM.");
						interceptorResponse.addResponseBlock(message);
						interceptorResponse.setReturnCode(6901011);

						context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);
						return;
					}

					// Get data for ItemAppliesWayHistory
					if (historyItem.get(Constants.ITEMS_APPLIES_WAY) != null) {
						itemAppliesWayHistory = (ItemAppliesWayHistory) historyItem.get(Constants.ITEMS_APPLIES_WAY);
					} else {
						logger.logError(MessageManager.getString("ITEMSINTERCEPTOR.005", "ItemAppliesWayHistory"));

						IMessageBlock message = new MessageBlock(6901011, "No se pudo recuperar los valores correspondientes a rubros del FPM.");
						interceptorResponse.addResponseBlock(message);
						interceptorResponse.setReturnCode(6901011);

						context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);
						return;
					}

					if (itemAppliesWayHistory.getItemReference() != null && !"".equals(itemAppliesWayHistory.getItemReference().trim())) {
						conceptAssociated = itemsManagerService.getItem(Long.parseLong(itemAppliesWayHistory.getItemReference())).getName();
					}

					if (!itemByProductHistory.getItemType().equals("C")) {

						if (historyItem.get(Constants.AMOUNT_ITEMS_VALUES) == null
								&& (!itemByProductHistory.getItemType().equals("I") || !itemByProductHistory.getItemType().equals("M"))) {

							logger.logDebug("RUBRO NO DEFINE CONFIGURACION " + item.getName());

							continue;
						}

						// Get data for AmountItemValueHistory
						if (historyItem.get(Constants.AMOUNT_ITEMS_VALUES) != null) {
							amountItemValueHistory = (AmountItemValueHistory) historyItem.get(Constants.AMOUNT_ITEMS_VALUES);
						} else {
							logger.logError(MessageManager.getString("ITEMSINTERCEPTOR.005", "AmountItemValueHistory"));

							IMessageBlock message = new MessageBlock(6901021, "No existe una configuración del producto para la moneda seleccionada.");
							interceptorResponse.addResponseBlock(message);
							interceptorResponse.setReturnCode(6901021);

							context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);
							return;
						}

						listVariableProcess = new ArrayList<VariableProcess>();

						// Execute rules
						if (amountItemValueHistory.getPolicyId() > 0) {

							logger.logDebug(MessageManager.getString("ITEMSINTERCEPTOR.006", amountItemValueHistory.getPolicyId(), item.getName()));

							rule = new Rule();
							rule.setId(amountItemValueHistory.getPolicyId());

							// Get rule version active
							RuleVersion versionRule = rulesManager.queryRuleVersionActive(rule);

							if (versionRule == null) {

								logger.logDebug(MessageManager.getString("ITEMSINTERCEPTOR.007"));

								IMessageBlock message = new MessageBlock(6901012, "No se pudo recuperar una versión activa de la regla asociada a un rubro del FPM. ");
								interceptorResponse.addResponseBlock(message);
								interceptorResponse.setReturnCode(6901012);

								context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);

								return;

							} else {

								logger.logDebug(MessageManager.getString("ITEMSINTERCEPTOR.008.", versionRule.getId()));

								RuleVersion versionRuleExecution = new RuleVersion();
								versionRuleExecution.setId(versionRule.getId());
								versionRuleExecution.setRule(rule);

								// Get conditions for rule
								List<Variable> variableList = rulesManager.queryConditionRuleVersionActive(versionRule);

								if (variableList.size() == 0) {
									logger.logError(MessageManager.getString("ITEMSINTERCEPTOR.009", versionRule.getId()));

									IMessageBlock message = new MessageBlock(6901013,
											"No se pudo recuperar la lista de condiciones correspondientes a la regla activa asociada al rubro del FPM.");
									interceptorResponse.addResponseBlock(message);
									interceptorResponse.setReturnCode(6901013);

									context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);

									return;

								} else {

									logger.logError(MessageManager.getString("ITEMSINTERCEPTOR.010", versionRule.getId()));

									for (Variable ruleCondition : variableList) {

										logger.logDebug(MessageManager.getString("ITEMSINTERCEPTOR.011", ruleCondition.getNombreVariable()));

										String valueOfVariable = extractorManagerService.getVariableExtractor(ruleCondition.getNombreVariable(), request);

										if (valueOfVariable == null) {
											logger.logError(MessageManager.getString("ITEMSINTERCEPTOR.012", ruleCondition.getNombreVariable()));

											IMessageBlock message = new MessageBlock(6901016, "No se pudo extraer el valor para una condición de una regla, asociada a un rubro.");
											interceptorResponse.addResponseBlock(message);
											interceptorResponse.setReturnCode(6901016);

											context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);

											return;

										}

										Variable variable = new Variable();
										variable.setCodigoVariable(ruleCondition.getCodigoVariable());

										variableProcees = new VariableProcess();
										variableProcees.setVariable(variable);
										variableProcees.setValue(valueOfVariable);
										listVariableProcess.add(variableProcees);

									}
									HashMap<RuleVersion, List<VariableProcess>> valuesRules = new HashMap<RuleVersion, List<VariableProcess>>();
									valuesRules.put(versionRuleExecution, listVariableProcess);

									logger.logDebug(MessageManager.getString("ITEMSINTERCEPTOR.013", versionRule.getId()));

									List<RuleProcess> proceesRule = rulesManager.generate(valuesRules);

									for (RuleProcess procesos : proceesRule) {
										for (VariableProcess iterator : procesos.getVariableProcesses()) {
											logger.logDebug(MessageManager.getString("ITEMSINTERCEPTOR.014", versionRule.getId()));

											resultValueRules = iterator.getValue();
										}

									}
								}

								logger.logDebug(MessageManager.getString("ITEMSINTERCEPTOR.015"));

								if (verifiedExtractorValue(resultValueRules)) {

									logger.logDebug(MessageManager.getString("ITEMSINTERCEPTOR.016"));
									if (defaultOperationManager.validateValuePortfolio(resultValueRules)) {

										valueReference = resultValueRules;

									} else {

										logger.logError(MessageManager.getString("ITEMSINTERCEPTOR.017", resultValueRules));

										IMessageBlock message = new MessageBlock(6901014,
												"No existe una configuración en Cartera de la tasa obtenida mediante la ejecución de la regla.");
										interceptorResponse.addResponseBlock(message);
										interceptorResponse.setReturnCode(6901014);

										context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);

										return;

									}

								} else {

									logger.logDebug(MessageManager.getString("ITEMSINTERCEPTOR.018", item.getName()));
									logger.logWarning("Existió un problema al evaluar la regla asociada a un rubro del producto. La regla no devolvio resultados");
									/*
									 * IMessageBlock message = new MessageBlock(
									 * 6901023,
									 * "Existió un problema al evaluar la regla asociada a un rubro del producto."
									 * ); interceptorResponse
									 * .addResponseBlock(message);
									 * interceptorResponse
									 * .setReturnCode(6901023);
									 * 
									 * context.addValue(
									 * CobisInterceptorContext.
									 * PROCEDURE_RESPONSE_KEY,
									 * interceptorResponse);
									 * 
									 * return;
									 */
									valueReference = amountItemValueHistory.getValueReference();
								}
							}

						} else {
							logger.logDebug(MessageManager.getString("ITEMSINTERCEPTOR.019", item.getName()));

							valueReference = amountItemValueHistory.getValueReference();
						}

						if (RATE.contains(itemByProductHistory.getItemType().trim())) {

							rateChangeRate = amountItemValueHistory.getRateReadJustment();
						} else {

							rateChangeRate = null;
						}

						maximumLimit = amountItemValueHistory.getMaximumLimit();
						minimumLimit = amountItemValueHistory.getMinimumLimit();

					} else {
						valueReference = null;
						rateChangeRate = null;
					}

					initializeDefaultValues(itemsValuesHistory);

					HashMap<String, PhysicalField> gpMapping = null;
					CoreTable coreTable = null;
					PhysicalField itemValuesPhysicalField = null;

					for (String itemValue : itemsValuesHistory.keySet()) {

						coreTable = new CoreTable(itemsValuesHistory.get(itemValue).getTable(), itemsValuesHistory.get(itemValue).getDatabase());

						if (!coreTableInformation.containsKey(coreTable)) {

							gpMapping = new HashMap<String, PhysicalField>();

							itemValuesPhysicalField = new PhysicalField(itemsValuesHistory.get(itemValue).getPhysicalFields(), itemsValuesHistory.get(itemValue).getDataType(),
									itemsValuesHistory.get(itemValue).getValue());

							gpMapping.put(itemsValuesHistory.get(itemValue).getPhysicalFields(), itemValuesPhysicalField);

							coreTableInformation.put(coreTable, gpMapping);
						} else {

							if (!coreTableInformation.get(coreTable).containsKey(itemsValuesHistory.get(itemValue).getPhysicalFields())) {

								itemValuesPhysicalField = new PhysicalField(itemsValuesHistory.get(itemValue).getPhysicalFields(), itemsValuesHistory.get(itemValue).getDataType(),
										itemsValuesHistory.get(itemValue).getValue());

								coreTableInformation.get(coreTable).remove(itemsValuesHistory.get(itemValue).getPhysicalFields());

								coreTableInformation.get(coreTable).put(itemsValuesHistory.get(itemValue).getPhysicalFields(), itemValuesPhysicalField);
							}
						}
					}

					initializeValues(request.readParam("@s_ssn").getValue(), request.readParam("@i_moneda").getValue(), item.getName(), itemByProductHistory.getItemType(),
							itemAppliesWayHistory.getApplyNodeType().trim(), valueReference, rateChangeRate, conceptAssociated, maximumLimit.toString(), minimumLimit.toString(),
							coreTableInformation);

					logger.logDebug(MessageManager.getString("ITEMSINTERCEPTOR.020") + coreTableInformation);

					defaultOperationManager.insertDynamicCreditOperation(coreTableInformation);

					coreTableInformationList.add(coreTableInformation);

				}// end for

				context.addValue("CORETABLE_LIST", coreTableInformationList);

				date = context.getValue(request.readParam("@s_ssn").getValue().concat("date"));

				if (request.readParam("@i_fecha_ini") != null) {
					request.readParam("@i_fecha_ini").setValue(date);
				} else {
					request.readParam("@i_fecha_inicio").setValue(date);
				}

				// Modified Line Credit
				if (request.readParam("@i_linea_credito") != null && request.readParam("@i_toperacion") != null && request.readParam("@i_producto") != null
						&& request.readParam("@i_proposito_op") != null && request.readParam("@i_moneda") != null) {

					// Modified registry line credit product for currency with
					// value SSN
					defaultOperationManager.modifiedCreditLineNumberCurrency(request.readParam("@i_linea_credito").getValue(), request.readParam("@i_toperacion").getValue(),
							request.readParam("@i_producto").getValue(), request.readParam("@i_proposito_op").getValue(),
							Integer.parseInt(request.readParam("@i_moneda").getValue()), request.readParam("@s_ssn").getValue());

				}

				// Verified exist the parameter @i_toperacion_int for set value
				if (request.readParam("@i_toperacion_int") != null) {
					request.readParam("@i_toperacion_int").setValue(request.readParam("@i_toperacion").getValue());
				}

				context.addValue("@i_toperacion_ori", request.readParam("@i_toperacion"));

				request.addInputParam("@i_toperacion_ori", ICTSTypes.SQLVARCHAR, request.readParam("@i_toperacion").getValue());
				// Modified value parameter @i_toperacion for value SSN
				request.readParam("@i_toperacion").setValue(request.readParam("@s_ssn").getValue());

				// Add operation identifier
				context.addValue(request.readParam("@s_ssn").getValue().concat("tOperation"), tOperation);
			}

		} catch (Exception e) {

			logger.logError(MessageManager.getString("ITEMSINTERCEPTOR.021"), e);

			IMessageBlock message = null;

			if (e instanceof BusinessException) {
				message = new MessageBlock(((BusinessException) e).getClientErrorCode(), ((BusinessException) e).getMessage());
				interceptorResponse.setReturnCode(((BusinessException) e).getClientErrorCode());

			} else {
				message = new MessageBlock(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");
				interceptorResponse.setReturnCode(6900001);
			}

			interceptorResponse.addResponseBlock(message);

			context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);
		} finally {
			logger.logDebug(MessageManager.getString("ITEMSINTERCEPTOR.002", "execute"));
		}
	}

	// end-region

	// region Utility Methods

	/**
	 * Verified extractor value
	 * 
	 * @param extractorValue
	 * @return Indicates whether the extractor to use default values
	 */
	private Boolean verifiedExtractorValue(String extractorValue) {
		if (extractorValue.equals(COMPARE_RULE)) {
			return false;
		} else if (extractorValue == "0") {
			return false;
		} else if (extractorValue == "") {
			return false;
		} else {
			return true;
		}
	}

	private void initializeDefaultValues(HashMap<String, ItemValueInformation> itemsMap) {

		logger.logDebug(MessageManager.getString("ITEMSINTERCEPTOR.001", "initializeDefaultValues"));
		try {

			if (!itemsMap.containsKey("ru_prioridad")) {
				itemsMap.put("ru_prioridad", new ItemValueInformation("ru_prioridad", "cob_cartera", "ca_rubro", "tinyint", defaultValues.get(Constants.INTERCEPTORS.PRIORITY)));
			}

			if (!itemsMap.containsKey("ru_paga_mora")) {
				itemsMap.put("ru_paga_mora", new ItemValueInformation("ru_paga_mora", "cob_cartera", "ca_rubro", "char(1)", defaultValues.get(Constants.INTERCEPTORS.PAYMENT_DUE)));
			}

			if (!itemsMap.containsKey("ru_provisiona")) {
				itemsMap.put("ru_provisiona",
						new ItemValueInformation("ru_provisiona", "cob_cartera", "ca_rubro", "char(1)", defaultValues.get(Constants.INTERCEPTORS.PROVISIONED)));
			}

			if (itemsMap.get("ru_diferir") != null) {
				itemsMap.put("ru_diferir", new ItemValueInformation("ru_diferir", "cob_cartera", "ca_rubro", "char(1)", defaultValues.get(Constants.INTERCEPTORS.DEFER)));
			}
		} finally {
			logger.logDebug(MessageManager.getString("ITEMSINTERCEPTOR.002", "initializeDefaultValues"));
		}
	}

	private void initializeValues(String operation, String currency, String itemName, String itemType, String formPayment, String valueReference, String rateChangeRate,
			String conceptAssociated, String maximumLimit, String minimumLimit, Map<CoreTable, Map<String, PhysicalField>> coreTableInformation) {

		try {
			logger.logDebug(MessageManager.getString("ITEMSINTERCEPTOR.001", "initializeValues"));

			CoreTable coreTable = new CoreTable("ca_rubro", "cob_cartera");
			if (coreTableInformation.containsKey(coreTable)) {

				if (!coreTableInformation.get(coreTable).containsKey("ru_estado")) {
					PhysicalField state = new PhysicalField("ru_estado", "varchar(10)", defaultValues.get(Constants.INTERCEPTORS.STATE));
					coreTableInformation.get(coreTable).put("ru_estado", state);
				}

				PhysicalField itemNamePF = new PhysicalField("ru_concepto", "varchar(10)", itemName);
				if (coreTableInformation.get(coreTable).containsKey("ru_concepto")) {
					coreTableInformation.get(coreTable).remove("ru_concepto");
				}
				coreTableInformation.get(coreTable).put("ru_concepto", itemNamePF);

				PhysicalField itemTypePF = new PhysicalField("ru_tipo_rubro", "varchar(10)", itemType);
				if (coreTableInformation.get(coreTable).containsKey("ru_tipo_rubro")) {

					coreTableInformation.get(coreTable).remove("ru_tipo_rubro");
				}
				coreTableInformation.get(coreTable).put("ru_tipo_rubro", itemTypePF);

				PhysicalField formPaymentPF = new PhysicalField("ru_fpago", "char(1)", formPayment);
				if (coreTableInformation.get(coreTable).containsKey("ru_fpago")) {
					coreTableInformation.get(coreTable).remove("ru_fpago");
				}
				coreTableInformation.get(coreTable).put("ru_fpago", formPaymentPF);

				if (valueReference != null && !valueReference.trim().equals("")) {
					PhysicalField valueReferencePF = new PhysicalField("ru_referencial", "char(1)", valueReference);
					if (coreTableInformation.get(coreTable).containsKey("ru_referencial")) {

						coreTableInformation.get(coreTable).remove("ru_referencial");
					}
					coreTableInformation.get(coreTable).put("ru_referencial", valueReferencePF);
				}

				if (rateChangeRate != null && !rateChangeRate.trim().equals("")) {

					PhysicalField rateChangeRatePF = new PhysicalField("ru_reajuste", "varchar(10)", rateChangeRate);

					if (coreTableInformation.get(coreTable).containsKey("ru_reajuste")) {

						coreTableInformation.get(coreTable).remove("ru_reajuste");
					}

					coreTableInformation.get(coreTable).put("ru_reajuste", rateChangeRatePF);
				}

				if (conceptAssociated != null && !conceptAssociated.trim().equals("")) {
					PhysicalField conceptAssociatedPF = new PhysicalField("ru_concepto_asociado", "varchar(10)", conceptAssociated);
					if (coreTableInformation.get(coreTable).containsKey("ru_concepto_asociado")) {
						coreTableInformation.get(coreTable).remove("ru_concepto_asociado");
					}
					coreTableInformation.get(coreTable).put("ru_concepto_asociado", conceptAssociatedPF);
				}

				if (!coreTableInformation.get(coreTable).containsKey("ru_valor_max")) {
					PhysicalField maximumLimitPF = new PhysicalField("ru_valor_max", "int", defaultValues.get(Constants.INTERCEPTORS.VALUE_MAX));
					coreTableInformation.get(coreTable).put("ru_valor_max", maximumLimitPF);
				}

				if (!coreTableInformation.get(coreTable).containsKey("ru_valor_min")) {
					PhysicalField minimumLimitPF = new PhysicalField("ru_valor_min", "int", defaultValues.get(Constants.INTERCEPTORS.VALUE_MIN));
					coreTableInformation.get(coreTable).put("ru_valor_min", minimumLimitPF);
				}
			}

			for (CoreTable coreTableVar : coreTableInformation.keySet()) {

				PhysicalField operationPF = new PhysicalField("ru_toperacion", "varchar(10)", operation);
				if (coreTableInformation.get(coreTableVar).containsKey("ru_toperacion")) {

					coreTableInformation.get(coreTableVar).remove("ru_toperacion");
				}
				coreTableInformation.get(coreTableVar).put("ru_toperacion", operationPF);

				PhysicalField currencyPF = new PhysicalField("ru_moneda", "tinyint", currency);
				if (coreTableInformation.get(coreTableVar).containsKey("ru_moneda")) {
					coreTableInformation.get(coreTableVar).remove("ru_moneda");
				}
				coreTableInformation.get(coreTableVar).put("ru_moneda", currencyPF);
			}

		} finally {
			logger.logDebug(MessageManager.getString("ITEMSINTERCEPTOR.002", "initializeValues"));
		}

	}
	// end-region

}
