/*
 * File: PortfolioGenericInterceptor.java
 * Date: April 16, 2012
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

package com.cobiscorp.ecobis.fpm.cobis.portfolio.interceptors.service.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.IMessageBlock;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.IProcedureResponse;
import com.cobiscorp.cobis.cts.dtos.MessageBlock;
import com.cobiscorp.cobis.cts.dtos.ProcedureResponseAS;
import com.cobiscorp.cobis.cts.interceptors.CobisInterceptor;
import com.cobiscorp.cobis.cts.interceptors.CobisInterceptorContext;
import com.cobiscorp.cobisv.commons.context.ContextManager;
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
import com.cobiscorp.ecobis.fpm.model.NodeTypeCategory;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.operation.service.IGeneralParametersManager;
import com.cobiscorp.ecobis.fpm.operation.service.IItemsManager;
import com.cobiscorp.ecobis.fpm.portfolio.bo.OperationData;
import com.cobiscorp.ecobis.fpm.portfolio.service.IDefaultOperationManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;

/**
 * 
 * Intercepts the stored procedure sp_consulta_rubro
 * 
 * @author despinosa
 */
public class PortfolioGenericInterceptor implements CobisInterceptor {

	// region Fields

	/** Cobis Logger */
	private static final ILogger logger = LogFactory
			.getLogger(ItemsInterceptor.class);

	private IProcedureResponse interceptorResponse = null;
	// ItemsManager Service
	private IItemsManager itemsManagerService;
	// DefaultOperationManager Service
	private IDefaultOperationManager defaultOperationManager;

	// GeneralParametersManager Service
	private IGeneralParametersManager generalParametersServices;
	// RuleManager Service
	private IRuleManager rulesManager;
	// ExtractorManager Service
	private IExtractorManager extractorManagerService;

	/** BankingProductManager Service */
	private IBankingProductManager bankingProductManager;

	/** DefaultValuesManager Service */
	private IDefaultValuesManager defaultValuesManager;

	// Rule object
	private Rule rule;

	// List process to get the condition list for execute the rule
	private List<VariableProcess> listVariableProcess;
	// VariableProcess object
	private VariableProcess variableProcees;
	// Result of execute rule
	private String resultValueRules;

	private static final String COMPARE_RULE = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

	// Determine if message erros is throw
	private Boolean messageFlag;

	// Determine if the value for field ratechangerate must be set
	private static final String RATE = "I,M";
	
	private Map<String, String> defaultValues = null;

	// end-region

	// region Properties
	/**
	 * @param itemsManagerService
	 */
	public void setItemsManagerService(IItemsManager itemsManagerService) {
		this.itemsManagerService = itemsManagerService;
	}

	/**
	 * @param operationManagerService
	 */
	public void setDefaultOperationManager(
			IDefaultOperationManager defaultOperationManager) {
		this.defaultOperationManager = defaultOperationManager;
	}

	/**
	 * @param generalParametersServices
	 */
	public void setGeneralParametersServices(
			IGeneralParametersManager generalParametersServices) {
		this.generalParametersServices = generalParametersServices;
	}

	/**
	 * @param rulesManager
	 */
	public void setRulesManager(IRuleManager rulesManager) {
		this.rulesManager = rulesManager;
	}

	/**
	 * @param extractorManagerService
	 */
	public void setExtractorManagerService(
			IExtractorManager extractorManagerService) {
		this.extractorManagerService = extractorManagerService;
	}

	/**
	 * @param bankingProductManager
	 */
	public void setBankingProductManager(
			IBankingProductManager bankingProductManager) {
		this.bankingProductManager = bankingProductManager;
	}
	
	/**
	 * @param defaultValuesManager
	 */
	public void setDefaultValuesManager(
			IDefaultValuesManager defaultValuesManager) {
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
	public void execute(CobisInterceptorContext context) {

		logger.logDebug(MessageManager.getString(
				"PORTFOLIOGENERICINTERCEPTOR.001", "execute"));

		interceptorResponse = new ProcedureResponseAS();
		messageFlag = false;

		try {

			// Get context
			IProcedureRequest request = context
					.getValue(CobisInterceptorContext.PROCEDURE_REQUEST_KEY);

			if (request.readParam("@i_banco") != null) {

				logger.logDebug(MessageManager.getString(
						"PORTFOLIOGENERICINTERCEPTOR.003", request.getSpName()));

				if (request.getSpName().trim()
						.equals("cob_cartera..sp_rubro_tmp")) {
					if (request.readParam("@i_operacion") != null) {
						if (!request.readParam("@i_operacion").getValue()
								.trim().equals("S")
								&& !request.readParam("@i_operacion")
										.getValue().trim().equals("M")) {
							portfolioGenericOperation(request, context);
						}
					} else {
						portfolioGenericOperation(request, context);
					}
				} else {
					portfolioGenericOperation(request, context);
				}

				if (messageFlag) {
					context.addValue(
							CobisInterceptorContext.PROCEDURE_RESPONSE_KEY,
							interceptorResponse);
				}

			}
		} catch (Exception ex) {

			logger.logError(
					MessageManager.getString("PORTFOLIOGENERICINTERCEPTOR.021"),
					ex);

			IMessageBlock message = null;

			if (ex instanceof BusinessException) {
				message = new MessageBlock(
						((BusinessException) ex).getClientErrorCode(),
						((BusinessException)ex).getMessage());
				interceptorResponse.setReturnCode(((BusinessException) ex)
						.getClientErrorCode());
				
			} else {
				message = new MessageBlock(6900001,
						"Existió un fallo en la operación. Comuníquese con el Administrador.");
				interceptorResponse.setReturnCode(6900001);
			}

			interceptorResponse.addResponseBlock(message);
			
			context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY,
					interceptorResponse);

		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOGENERICINTERCEPTOR.002", "execute"));
		}

	}

	// end-region

	// region Utility methods
	@SuppressWarnings("unchecked")
	private void portfolioGenericOperation(IProcedureRequest request,
			CobisInterceptorContext context) throws Exception {

		List<Map<CoreTable, Map<String, PhysicalField>>> coreTableInformationList = new ArrayList<Map<CoreTable, Map<String, PhysicalField>>>();

		ItemByProductHistory itemByProductHistory = null;
		HashMap<String, ItemValueInformation> itemsValuesHistory = null;
		ItemAppliesWayHistory itemAppliesWayHistory = null;
		AmountItemValueHistory amountItemValueHistory = null;
		String conceptAssociated = null;
		Date operationDate = null;
		// Item object
		Item item = null;

		// Save currency id
		Long iCurrency = null;

		/*
		 * Consult date and history operation 0 --> fecha 1 --> sector 2 -->
		 * operacion 3 --> moneda
		 */
		OperationData dataOperation = this.defaultOperationManager
				.getOperationData(request.readParam("@i_banco").getValue());

		
		
		if(dataOperation.getState() == 0 ||  dataOperation.getState() == 99)
		{
			Date operationDateInitial = dataOperation.getInitialDate();

			DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm");

			String dateInitial = dateFormat.format(operationDateInitial);

			if (dateInitial.contains("00:00")) {
				dateInitial = dateInitial.replaceAll("00:00", "23:59");
			}

			operationDate = new SimpleDateFormat("MM/dd/yyyy HH:mm")
					.parse(dateInitial);
		}else{
			if (ContextManager.getContext() != null) {
				String processDateString = ContextManager.getContext()
						.getProcessDate();
				if (processDateString != null
						&& processDateString != "") {
					operationDate = new SimpleDateFormat(
							"MM/dd/yyyy").parse(processDateString);

				}
			}
			
		}



		String tOperation = null;
		// Referencial Rate
		String valueReference = null;
		// Rate change rate
		String rateChangeRate = null;
		// Maximum limit
		Long maximumLimit = 0L;
		// Minimum limit
		Long minimumLimit = 0L;

		if (request.readParam("@i_toperacion") != null) {

			// Save operation name
			tOperation = request.readParam("@i_toperacion").getValue();
		} else {
			tOperation = dataOperation.gettOperation();// [2].toString();
		}

		NodeTypeCategory category = bankingProductManager
				.getCategoryKeepDictionaryFromParents(tOperation.trim());

		// Add module mnemonic
		context.addValue(
				request.readParam("@s_ssn").getValue().concat("mnemonic"),
				category.getModule().getMnemonic().trim());

		if (category.getModule().getMnemonic().equals("CCA")) {

			// Get history date
			Date systemDateHistory = generalParametersServices.getDateHistory(
					operationDate, tOperation);

			if (request.readParam("@i_moneda") != null) {
				iCurrency = Long.parseLong(request.readParam("@i_moneda")
						.getValue());
			} else {
				iCurrency = dataOperation.getCurrency();
			}

			// Update create operation
			Integer registry = defaultOperationManager.updateCreateOperation(
					dataOperation.getOperation(), request.readParam("@s_ssn")
							.getValue());

			if (registry <= 0) {
				defaultOperationManager.updateCreateOperationDef(
						dataOperation.getOperation(),
						request.readParam("@s_ssn").getValue());
			}

			// Get history date
			List<HashMap<String, Object>> historyItemsList = this.itemsManagerService
					.getHistory(systemDateHistory, tOperation, iCurrency);

			if (historyItemsList.size() == 0) {
				// Indicate exist message error
				messageFlag = true;

				logger.logError(MessageManager
						.getString("PORTFOLIOGENERICINTERCEPTOR.004"));

				IMessageBlock message = new MessageBlock(6901011,
						"No se pudo recuperar los valores correspondientes a rubros del FPM.");
				interceptorResponse.addResponseBlock(message);
				interceptorResponse.setReturnCode(6901011);

				return;
			}
			
			defaultValues = defaultValuesManager.getDefaultValues();

			for (HashMap<String, Object> historyItem : historyItemsList) {

				Map<CoreTable, Map<String, PhysicalField>> coreTableInformation = new HashMap<CoreTable, Map<String, PhysicalField>>();

				// Get ItemByProductHistory
				if (historyItem.get(Constants.ITEMS_BY_PRODUCT) != null) {
					itemByProductHistory = (ItemByProductHistory) historyItem
							.get(Constants.ITEMS_BY_PRODUCT);

					item = itemsManagerService.getItem(itemByProductHistory
							.getItemIdentifier());

				} else {
					logger.logError(MessageManager.getString(
							"PORTFOLIOGENERICINTERCEPTOR.005",
							"ItemByProductHistory"));

					messageFlag = true;

					IMessageBlock message = new MessageBlock(6901011,
							"No se pudo recuperar los valores correspondientes a rubros del FPM.");
					interceptorResponse.addResponseBlock(message);
					interceptorResponse.setReturnCode(6901011);

					return;
				}

				// Get ItemsValuesHistory
				if (historyItem.get(Constants.ITEMS_VALUES) != null) {
					itemsValuesHistory = ((HashMap<String, ItemValueInformation>) historyItem
							.get(Constants.ITEMS_VALUES));

				} else {
					logger.logError(MessageManager.getString(
							"PORTFOLIOGENERICINTERCEPTOR.005",
							"ItemsValuesHistory"));

					messageFlag = true;

					IMessageBlock message = new MessageBlock(6901011,
							"No se pudo recuperar los valores correspondientes a rubros del FPM.");
					interceptorResponse.addResponseBlock(message);
					interceptorResponse.setReturnCode(6901011);

					return;
				}

				// Get ItemAppliesWayHistory
				if (historyItem.get(Constants.ITEMS_APPLIES_WAY) != null) {
					itemAppliesWayHistory = (ItemAppliesWayHistory) historyItem
							.get(Constants.ITEMS_APPLIES_WAY);
				} else {
					logger.logError(MessageManager.getString(
							"PORTFOLIOGENERICINTERCEPTOR.005",
							"ItemAppliesWayHistory"));

					messageFlag = true;

					IMessageBlock message = new MessageBlock(6901011,
							"No se pudo recuperar los valores correspondientes a rubros del FPM.");
					interceptorResponse.addResponseBlock(message);
					interceptorResponse.setReturnCode(6901011);

					return;
				}

				// Get concept associated
				if (itemAppliesWayHistory.getItemReference() != null && !("".equals(itemAppliesWayHistory.getItemReference().trim())) ) {
					conceptAssociated = itemsManagerService.getItem(
							Long.parseLong(itemAppliesWayHistory
									.getItemReference())).getName();
				}

				if (!itemByProductHistory.getItemType().equals("C")) {

					if (historyItem.get(Constants.AMOUNT_ITEMS_VALUES) == null
							&& (!itemByProductHistory.getItemType().equals("I") || !itemByProductHistory
									.getItemType().equals("M"))) {

						logger.logDebug("RUBRO NO DEFINE CONFIGURACION "
								+ item.getName());

						continue;
					}

					// Get AmountItemValueHistory
					if (historyItem.get(Constants.AMOUNT_ITEMS_VALUES) != null) {
						amountItemValueHistory = (AmountItemValueHistory) historyItem
								.get(Constants.AMOUNT_ITEMS_VALUES);
					} else {
						logger.logError(MessageManager.getString(
								"PORTFOLIOGENERICINTERCEPTOR.005",
								"AmountItemValueHistory"));

						messageFlag = true;

						IMessageBlock message = new MessageBlock(6901011,
								"No se pudo recuperar los valores correspondientes a rubros del FPM.");
						interceptorResponse.addResponseBlock(message);
						interceptorResponse.setReturnCode(6901011);

						return;
					}
					
					listVariableProcess = new ArrayList<VariableProcess>();

					// Execute rules
					if (amountItemValueHistory.getPolicyId() > 0) {

						logger.logDebug(MessageManager.getString(
								"PORTFOLIOGENERICINTERCEPTOR.006",
								amountItemValueHistory.getPolicyId(),
								item.getName()));

						rule = new Rule();
						rule.setId(amountItemValueHistory.getPolicyId());

						// Get rule version active
						RuleVersion versionRule = rulesManager
								.queryRuleVersionActive(rule);

						if (versionRule == null) {

							logger.logDebug(MessageManager
									.getString("PORTFOLIOGENERICINTERCEPTOR.007"));

							messageFlag = true;

							IMessageBlock message = new MessageBlock(
									6901012,
									"No se pudo recuperar una versión activa de la regla asociada a un rubro del FPM. ");
							interceptorResponse.addResponseBlock(message);
							interceptorResponse.setReturnCode(6901012);

							return;

						} else {

							logger.logDebug(MessageManager.getString(
									"PORTFOLIOGENERICINTERCEPTOR.008.",
									versionRule.getId()));

							RuleVersion versionRuleExecution = new RuleVersion();
							versionRuleExecution.setId(versionRule.getId());
							versionRuleExecution.setRule(rule);

							// Get conditions for rule
							List<Variable> variableList = rulesManager
									.queryConditionRuleVersionActive(versionRule);

							if (variableList.size() == 0) {
								logger.logError(MessageManager.getString(
										"PORTFOLIOGENERICINTERCEPTOR.009",
										versionRule.getId()));

								messageFlag = true;

								IMessageBlock message = new MessageBlock(
										6901013,
										"No se pudo recuperar la lista de condiciones correspondientes a la regla activa asociada al rubro del FPM.");
								interceptorResponse.addResponseBlock(message);
								interceptorResponse.setReturnCode(6901013);

								return;

							} else {

								logger.logError(MessageManager.getString(
										"PORTFOLIOGENERICINTERCEPTOR.010",
										versionRule.getId()));

								for (Variable ruleCondition : variableList) {

									logger.logDebug(MessageManager.getString(
											"PORTFOLIOGENERICINTERCEPTOR.011",
											ruleCondition.getNombreVariable()));

									String valueOfVariable = extractorManagerService
											.getVariableExtractor(ruleCondition
													.getNombreVariable(),
													request);

									if (valueOfVariable == null) {
										logger.logError(MessageManager
												.getString(
														"PORTFOLIOGENERICINTERCEPTOR.012",
														ruleCondition
																.getNombreVariable()));

										messageFlag = true;

										IMessageBlock message = new MessageBlock(
												6901016,
												"No se pudo extraer el valor para una condición de una regla, asociada a un rubro.");
										interceptorResponse
												.addResponseBlock(message);
										interceptorResponse
												.setReturnCode(6901016);

										return;

									}

									Variable variable = new Variable();
									variable.setCodigoVariable(ruleCondition
											.getCodigoVariable());

									variableProcees = new VariableProcess();
									variableProcees.setVariable(variable);
									variableProcees.setValue(valueOfVariable);
									listVariableProcess.add(variableProcees);

								}
								HashMap<RuleVersion, List<VariableProcess>> valuesRules = new HashMap<RuleVersion, List<VariableProcess>>();
								valuesRules.put(versionRuleExecution,
										listVariableProcess);

								logger.logDebug(MessageManager.getString(
										"PORTFOLIOGENERICINTERCEPTOR.013",
										versionRule.getId()));

								List<RuleProcess> proceesRule = rulesManager
										.generate(valuesRules);

								for (RuleProcess procesos : proceesRule) {
									for (VariableProcess iterator : procesos
											.getVariableProcesses()) {
										logger.logDebug(MessageManager
												.getString(
														"PORTFOLIOGENERICINTERCEPTOR.014",
														versionRule.getId()));

										resultValueRules = iterator.getValue();
									}

								}
							}

							logger.logDebug(MessageManager
									.getString("PORTFOLIOGENERICINTERCEPTOR.015"));

							if (verifiedExtractorValue(resultValueRules)) {

								logger.logDebug(MessageManager
										.getString("PORTFOLIOGENERICINTERCEPTOR.016"));
								if (defaultOperationManager
										.validateValuePortfolio(resultValueRules)) {

									valueReference = resultValueRules;

								} else {

									logger.logError(MessageManager.getString(
											"PORTFOLIOGENERICINTERCEPTOR.017",
											resultValueRules));

									messageFlag = true;

									IMessageBlock message = new MessageBlock(
											6901014,
											"No existe una configuración en Cartera de la tasa obtenida mediante la ejecución de la regla.");
									interceptorResponse
											.addResponseBlock(message);
									interceptorResponse.setReturnCode(6901014);

									return;

								}

							} else {

								logger.logDebug(MessageManager.getString(
										"ITEMSINTERCEPTOR.018",
										item.getName()));
								logger.logWarning("Existió un problema al evaluar la regla asociada a un rubro del producto. La regla no devolvio resultados")	;

								valueReference = amountItemValueHistory
										.getValueReference();
							}
						}

					} else {
						logger.logDebug(MessageManager.getString(
								"PORTFOLIOGENERICINTERCEPTOR.019",
								item.getName()));

						valueReference = amountItemValueHistory
								.getValueReference();
					}

					if (RATE.contains(itemByProductHistory.getItemType().trim())) {

						rateChangeRate = amountItemValueHistory
								.getRateReadJustment();
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

					coreTable = new CoreTable(itemsValuesHistory.get(itemValue)
							.getTable(), itemsValuesHistory.get(itemValue)
							.getDatabase());

					if (!coreTableInformation.containsKey(coreTable)) {

						gpMapping = new HashMap<String, PhysicalField>();

						itemValuesPhysicalField = new PhysicalField(
								itemsValuesHistory.get(itemValue)
										.getPhysicalFields(),
								itemsValuesHistory.get(itemValue).getDataType(),
								itemsValuesHistory.get(itemValue).getValue());

						gpMapping.put(itemsValuesHistory.get(itemValue)
								.getPhysicalFields(), itemValuesPhysicalField);

						coreTableInformation.put(coreTable, gpMapping);
					} else {

						if (!coreTableInformation.get(coreTable).containsKey(
								itemsValuesHistory.get(itemValue)
										.getPhysicalFields())) {

							itemValuesPhysicalField = new PhysicalField(
									itemsValuesHistory.get(itemValue)
											.getPhysicalFields(),
									itemsValuesHistory.get(itemValue)
											.getDataType(), itemsValuesHistory
											.get(itemValue).getValue());

							coreTableInformation.get(coreTable).remove(
									itemsValuesHistory.get(itemValue)
											.getPhysicalFields());

							coreTableInformation.get(coreTable).put(
									itemsValuesHistory.get(itemValue)
											.getPhysicalFields(),
									itemValuesPhysicalField);
						}
					}
				}

				initializeValues(request.readParam("@s_ssn").getValue(),
						iCurrency.toString(), item.getName(),
						itemByProductHistory.getItemType(),
						itemAppliesWayHistory.getApplyNodeType().trim(),
						valueReference, rateChangeRate, conceptAssociated,
						maximumLimit.toString(), minimumLimit.toString(),
						coreTableInformation);

				logger.logDebug(MessageManager
						.getString("PORTFOLIOGENERICINTERCEPTOR.020"));

				// Inserto registro en la tabla ca_rubro
				defaultOperationManager
						.insertDynamicCreditOperation(coreTableInformation);

				coreTableInformationList.add(coreTableInformation);

			}

			context.addValue("CORETABLE_LIST", coreTableInformationList);

			// Modified parameters in the context
			if (request.readParam("@i_toperacion") != null) {
				request.readParam("@i_toperacion").setValue(
						request.readParam("@s_ssn").getValue());
			}

			context.addValue(
					request.readParam("@s_ssn").getValue().concat("tOperation"),
					tOperation);
			context.addValue(
					request.readParam("@s_ssn").getValue().concat("sector"),
					dataOperation.getSector());// [1].toString());

		}
	}

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

	private void initializeDefaultValues(
			HashMap<String, ItemValueInformation> itemsMap) {

		logger.logDebug(MessageManager.getString(
				"PORTFOLIOGENERICINTERCEPTOR.001", "initializeDefaultValues"));
		try {
			if (!itemsMap.containsKey("ru_prioridad")) {
				itemsMap.put("ru_prioridad", new ItemValueInformation(
						"ru_prioridad", "cob_cartera", "ca_rubro", "tinyint",
						defaultValues.get(Constants.INTERCEPTORS.PRIORITY)));
			}

			if (!itemsMap.containsKey("ru_paga_mora")) {
				itemsMap.put("ru_paga_mora", new ItemValueInformation(
						"ru_paga_mora", "cob_cartera", "ca_rubro", "char(1)",
						defaultValues.get(Constants.INTERCEPTORS.PAYMENT_DUE)));
			}

			if (!itemsMap.containsKey("ru_provisiona")) {
				itemsMap.put("ru_provisiona", new ItemValueInformation(
						"ru_provisiona", "cob_cartera", "ca_rubro", "char(1)",
						defaultValues.get(Constants.INTERCEPTORS.PROVISIONED)));
			}

			if (itemsMap.get("ru_diferir") != null) {
				itemsMap.put("ru_diferir", new ItemValueInformation(
						"ru_diferir", "cob_cartera", "ca_rubro", "char(1)",
						defaultValues.get(Constants.INTERCEPTORS.DEFER)));
			}
		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOGENERICINTERCEPTOR.002",
					"initializeDefaultValues"));

		}
	}

	private void initializeValues(String operation, String currency,
			String itemName, String itemType, String formPayment,
			String valueReference, String rateChangeRate,
			String conceptAssociated, String maximumLimit, String minimumLimit,
			Map<CoreTable, Map<String, PhysicalField>> coreTableInformation) {

		try {

			logger.logDebug(MessageManager.getString(
					"PORTFOLIOGENERICINTERCEPTOR.001", "initializeValues"));

			CoreTable coreTable = new CoreTable("ca_rubro", "cob_cartera");
			if (coreTableInformation.containsKey(coreTable)) {

				if (!coreTableInformation.get(coreTable).containsKey(
						"ru_estado")) {
					PhysicalField state = new PhysicalField("ru_estado",
							"varchar(10)",
							defaultValues.get(Constants.INTERCEPTORS.STATE));
					coreTableInformation.get(coreTable).put("ru_estado", state);
				}

				PhysicalField itemNamePF = new PhysicalField("ru_concepto",
						"varchar(10)", itemName);
				if (coreTableInformation.get(coreTable).containsKey(
						"ru_concepto")) {
					coreTableInformation.get(coreTable).remove("ru_concepto");
				}
				coreTableInformation.get(coreTable).put("ru_concepto",
						itemNamePF);

				PhysicalField itemTypePF = new PhysicalField("ru_tipo_rubro",
						"varchar(10)", itemType);
				if (coreTableInformation.get(coreTable).containsKey(
						"ru_tipo_rubro")) {

					coreTableInformation.get(coreTable).remove("ru_tipo_rubro");
				}
				coreTableInformation.get(coreTable).put("ru_tipo_rubro",
						itemTypePF);

				PhysicalField formPaymentPF = new PhysicalField("ru_fpago",
						"char(1)", formPayment);
				if (coreTableInformation.get(coreTable).containsKey("ru_fpago")) {
					coreTableInformation.get(coreTable).remove("ru_fpago");
				}
				coreTableInformation.get(coreTable).put("ru_fpago",
						formPaymentPF);

				if (valueReference != null && !valueReference.trim().equals("")) {
					PhysicalField valueReferencePF = new PhysicalField(
							"ru_referencial", "char(1)", valueReference);
					if (coreTableInformation.get(coreTable).containsKey(
							"ru_referencial")) {

						coreTableInformation.get(coreTable).remove(
								"ru_referencial");
					}
					coreTableInformation.get(coreTable).put("ru_referencial",
							valueReferencePF);
				}

				if (rateChangeRate != null && !rateChangeRate.trim().equals("")) {

					PhysicalField rateChangeRatePF = new PhysicalField(
							"ru_reajuste", "varchar(10)", rateChangeRate);

					if (coreTableInformation.get(coreTable).containsKey(
							"ru_reajuste")) {

						coreTableInformation.get(coreTable).remove(
								"ru_reajuste");
					}

					coreTableInformation.get(coreTable).put("ru_reajuste",
							rateChangeRatePF);
				}

				if (conceptAssociated != null
						&& !conceptAssociated.trim().equals("")) {
					PhysicalField conceptAssociatedPF = new PhysicalField(
							"ru_concepto_asociado", "varchar(10)",
							conceptAssociated);
					if (coreTableInformation.get(coreTable).containsKey(
							"ru_concepto_asociado")) {
						coreTableInformation.get(coreTable).remove(
								"ru_concepto_asociado");
					}
					coreTableInformation.get(coreTable).put(
							"ru_concepto_asociado", conceptAssociatedPF);
				}

				if (!coreTableInformation.get(coreTable).containsKey(
						"ru_valor_max")) {
					PhysicalField maximumLimitPF = new PhysicalField(
							"ru_valor_max", "int",
							defaultValues.get(Constants.INTERCEPTORS.VALUE_MAX));
					coreTableInformation.get(coreTable).put("ru_valor_max",
							maximumLimitPF);
				}

				if (!coreTableInformation.get(coreTable).containsKey(
						"ru_valor_min")) {
					PhysicalField minimumLimitPF = new PhysicalField(
							"ru_valor_min", "int",
							defaultValues.get(Constants.INTERCEPTORS.VALUE_MIN));
					coreTableInformation.get(coreTable).put("ru_valor_min",
							minimumLimitPF);
				}
			}

			for (CoreTable coreTableVar : coreTableInformation.keySet()) {

				PhysicalField operationPF = new PhysicalField("ru_toperacion",
						"varchar(10)", operation);
				if (coreTableInformation.get(coreTableVar).containsKey(
						"ru_toperacion")) {

					coreTableInformation.get(coreTableVar).remove(
							"ru_toperacion");
				}
				coreTableInformation.get(coreTableVar).put("ru_toperacion",
						operationPF);

				PhysicalField currencyPF = new PhysicalField("ru_moneda",
						"tinyint", currency);
				if (coreTableInformation.get(coreTableVar).containsKey(
						"ru_moneda")) {
					coreTableInformation.get(coreTableVar).remove("ru_moneda");
				}
				coreTableInformation.get(coreTableVar).put("ru_moneda",
						currencyPF);
			}

		} finally {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOGENERICINTERCEPTOR.002", "initializeValues"));
		}

	}

	// end-region

}