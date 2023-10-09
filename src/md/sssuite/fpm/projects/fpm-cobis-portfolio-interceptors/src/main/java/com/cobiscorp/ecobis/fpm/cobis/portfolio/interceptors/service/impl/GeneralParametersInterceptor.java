/*
 * File: GeneralParametersInterceptor.java
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
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleProcess;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleVersion;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.bpl.rules.engine.model.VariableProcess;
import com.cobiscorp.ecobis.bpl.rules.engine.services.IRuleManager;
import com.cobiscorp.ecobis.fpm.bo.PhysicalField;
import com.cobiscorp.ecobis.fpm.cobis.portfolio.interceptors.service.utils.MessageManager;
import com.cobiscorp.ecobis.fpm.cobis.portfolio.interceptors.service.utils.Utils;
import com.cobiscorp.ecobis.fpm.extractors.administration.service.IExtractorManager;
import com.cobiscorp.ecobis.fpm.interceptors.service.IDefaultValuesManager;
import com.cobiscorp.ecobis.fpm.model.CoreTable;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;
import com.cobiscorp.ecobis.fpm.model.NodeTypeCategory;
import com.cobiscorp.ecobis.fpm.model.RequiredFieldsByTable;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.operation.service.IGeneralParametersManager;
import com.cobiscorp.ecobis.fpm.operation.service.IMappingFieldManager;
import com.cobiscorp.ecobis.fpm.portfolio.service.IDefaultOperationManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;


/**
 * Intercepts the sp_crear_operacion stored procedure, read information from FPM
 * referent general parameters
 * 
 * @author oguano
 * 
 */
public class GeneralParametersInterceptor implements CobisInterceptor {

	// region Fields
	/** Cobis Logger */
	private static final ILogger logger = LogFactory.getLogger(GeneralParametersInterceptor.class);

	private static final String PORTFOLIO_DEFAULT_GP_TABLE = "ca_default_toperacion";
	// Contains 255 characteres {0}
	private static final String compareRule = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

	/** GeneralParametersManager Service */
	private IGeneralParametersManager generalParametersServices;

	/** DictionaryManager Service */
	private IMappingFieldManager mappingFieldManagerService;

	/** OperationManager Service */
	private IDefaultOperationManager operationManagerService;

	/** ExtractorManager Service */
	private IExtractorManager extractorManagerService;

	/** RuleManager Service */
	private IRuleManager rulesManager;

	/** BankingProductManager Service */
	private IBankingProductManager bankingProductManager;

	/** IDefaultValuesManager Service */
	private IDefaultValuesManager defaultValuesManager;

	// Rule object
	private Rule rule;
	// list process to get the condition list for execute the rule
	private List<VariableProcess> listVariableProcess;
	// private VariableProcess variableProcees;
	// result of execute rule
	private String resultValueRules;

	// end-region

	// region Properties
	/**
	 * @param rulesManager
	 */
	public void setRulesManager(IRuleManager rulesManager) {
		this.rulesManager = rulesManager;
	}

	/**
	 * @param generalParametersServices
	 */
	public void setGeneralParametersServices(IGeneralParametersManager generalParametersServices) {
		this.generalParametersServices = generalParametersServices;
	}

	/**
	 * @param operationManagerService
	 */
	public void setOperationManagerService(IDefaultOperationManager operationManagerService) {
		this.operationManagerService = operationManagerService;
	}

	/**
	 * @param extractorManagerService
	 */
	public void setExtractorManagerService(IExtractorManager extractorManagerService) {
		this.extractorManagerService = extractorManagerService;
	}

	/**
	 * @param mappingFieldManagerService
	 */
	public void setMappingFieldManagerService(IMappingFieldManager mappingFieldManagerService) {
		this.mappingFieldManagerService = mappingFieldManagerService;
	}

	/**
	 * @param bankingProductManager
	 */
	public void setBankingProductManager(IBankingProductManager bankingProductManager) {
		this.bankingProductManager = bankingProductManager;
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
	public void execute(CobisInterceptorContext context) {

		logger.logDebug(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.001", "execute"));

		IProcedureResponse interceptorResponse = null;
		IProcedureRequest request = null;

		// Date sent from frontend
		String requestDate = null;
		// Date operation
		String dateOperation = null;
		// Date type conversion from Frontend
		Date operationDate = null;
		// Date history
		Date systemDate = null;
		// Date history in milliseconds
		Long systemDateInLong;
		// Contains concat date from Frontend and date in milliseconds
		String systemDateString = null;
		// Colums name list and field identifier
		List<CoreTable> coreTableList = null;
		// Registry history corresponds gemeral parameters
		List<GeneralParametersValuesHistory> gpValuesHistoryList = null;
		// Correspondence between columns name and general parameters values.
		HashMap<String, PhysicalField> gpMapping = new HashMap<String, PhysicalField>();

		// Reference rate
		String resultExecRule = null;

		// RuleVersion object
		RuleVersion versionRule = null;

		interceptorResponse = new ProcedureResponseAS();

		request = context.getValue(CobisInterceptorContext.PROCEDURE_REQUEST_KEY);

		// Verified if logic must be executed
		Boolean execute = false;
		// Contains the metadata and information necessary to construct the
		// dynamic inserts
		HashMap<CoreTable, List> coreTableInformation = new HashMap<CoreTable, List>();

		// Module mnemonic
		String mnemonic = "";

		try {

			if (request.readParam("@i_producto") != null) {
				mnemonic = request.readParam("@i_producto").getValue();

			} else {
				if (request.readParam("@i_toperacion") != null) {

					NodeTypeCategory category = bankingProductManager.getCategoryKeepDictionaryFromParents(request.readParam("@i_toperacion").getValue().trim());
					mnemonic = category.getModule().getMnemonic();
				}
			}

			// Add module mnemonic
			context.addValue(request.readParam("@s_ssn").getValue().concat("mnemonic"), mnemonic);

			if (mnemonic.equals("CCA")) {
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

				logger.logDebug(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.003", request.getSpName()));

				// Get date from Frontend
				if (request.readParam("@i_fecha_ini") != null) {
					dateOperation = request.readParam("@i_fecha_ini").getValue();
					requestDate = request.readParam("@i_fecha_ini").getValue();

				} else {
					dateOperation = request.readParam("@i_fecha_inicio").getValue();
					requestDate = request.readParam("@i_fecha_inicio").getValue();
				}

				// Add date unmodified
				context.addValue(request.readParam("@s_ssn").getValue().concat("date"), dateOperation);

				// Convert to date
				operationDate = Utils.parseDate(Utils.replaceLongTimeDate(requestDate));
				
				if (operationDate == null) {
					IMessageBlock message = new MessageBlock(6901020, "No existe una configuración a la fecha para el producto solicitado.");
					interceptorResponse.addResponseBlock(message);
					interceptorResponse.setReturnCode(6901020);

					context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);

					return;
				}
				// Get value date history
				systemDate = generalParametersServices.getDateHistory(operationDate, request.readParam("@i_toperacion").getValue());

				if (systemDate == null) {
					logger.logError(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.022"));

					IMessageBlock message = new MessageBlock(6901020, "No existe una configuración a la fecha para el producto solicitado.");
					interceptorResponse.addResponseBlock(message);
					interceptorResponse.setReturnCode(6901020);

					context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);

					return;
				}

				// Get date in milliseconds
				systemDateInLong = systemDate.getTime();

				// Concat date from Frontend and date in milliseconds
				systemDateString = requestDate.concat("-").concat(systemDateInLong.toString());

				// Modified date parameter
				if (request.readParam("@i_fecha_ini") != null) {
					request.readParam("@i_fecha_ini").setValue(systemDateString);
				} else {
					request.readParam("@i_fecha_inicio").setValue(systemDateString);
				}
				// Get information corresponding column data and idetifier
				// fields
				coreTableList = mappingFieldManagerService.getPhysicalFieldsMappings(request.readParam("@i_toperacion").getValue(), Constants.GENERAL_PARAMETERS_DICTIONARY,
						systemDate);

				logger.logDebug(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.004"));
				// Get history data
				gpValuesHistoryList = generalParametersServices.getGeneralParametersBySystemDate(systemDate, request.readParam("@i_toperacion").getValue());

				if (coreTableList.size() <= 0) {

					logger.logError(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.005"));

					IMessageBlock message = new MessageBlock(6901006, "No se pudo recuperar los valores correspondientes a parámetros generales del FPM.");
					interceptorResponse.addResponseBlock(message);
					interceptorResponse.setReturnCode(6901006);

					context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);

					return;
				}

				// Mapping is performed between the name fields and general
				// parameters value

				for (CoreTable table : coreTableList) {
					boolean isMultiValue = false;
					List<Map> rowFields = new ArrayList<Map>();
					gpMapping = new HashMap<String, PhysicalField>();
					List<String> valuesInserted = new ArrayList<String>();
					PhysicalField physicalFieldtemp = new PhysicalField();
					//Obtengo los campos asignados como producto y moneda
					
					logger.logError("TABLA --> " + table.getId());
					
					List<RequiredFieldsByTable> fieldsByTables = mappingFieldManagerService.getRequiredFieldsByTable(table.getId());
					
					
					for (RequiredFieldsByTable requiredFieldsByTable : fieldsByTables) {
						logger.logError("CAMPOS fieldsByTables --> " + requiredFieldsByTable.getPhysicalFields());
					}


					for (PhysicalField physicalField : table.getPhysicalFields()) {
						// logger.logDebug("1_for_physicalField--------------------------------------------------->"+physicalField.getPhysicalFieldName());
						// logger.logDebug("1_for_getFieldId------------------------------------------------------>"+physicalField.getValue());
						for (GeneralParametersValuesHistory generalParametersValuesHistory : gpValuesHistoryList) {
							if (physicalField.getFieldId() == generalParametersValuesHistory.getDictionaryFieldId()) {
								listVariableProcess = new ArrayList<VariableProcess>();
								if (generalParametersValuesHistory.getRuleId() > 0) {
									logger.logDebug(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.006", generalParametersValuesHistory.getRuleId(),
											physicalField.getPhysicalFieldName()));
									// Create and initialize Rule object
									rule = new Rule();
									rule.setId(generalParametersValuesHistory.getRuleId());
									versionRule = rulesManager.queryRuleVersionActive(rule);
									if (versionRule == null) {

										logger.logDebug(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.007", rule.getId(), physicalField.getPhysicalFieldName()));

										IMessageBlock message = new MessageBlock(6901009,
												"No se pudo recuperar una versión activa de la regla asociada a un parámetro general del FPM. ");
										interceptorResponse.addResponseBlock(message);
										interceptorResponse.setReturnCode(6901009);

										context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);
										return;
									} else {

										logger.logDebug(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.008.", versionRule.getId()));
										// Create new instance RuleVersion
										RuleVersion versionRuleExecution = new RuleVersion();
										versionRuleExecution.setId(versionRule.getId());
										versionRuleExecution.setRule(rule);
										// Get conditions for rule
										List<Variable> variableList = rulesManager.queryConditionRuleVersionActive(versionRule);
										if (variableList.size() == 0) {
											logger.logError(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.009", versionRule.getId()));

											IMessageBlock message = new MessageBlock(6901007,
													"No se pudo recuperar la lista de condiciones correspondientes a la regla activa asociada al parámetro general del FPM.");
											interceptorResponse.addResponseBlock(message);
											interceptorResponse.setReturnCode(6901007);
											context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);
											return;
										} else {
											logger.logError(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.010", versionRule.getId()));
											for (Variable ruleCondition : variableList) {
												logger.logDebug(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.011", ruleCondition.getNombreVariable()));
												String valueOfVariable = extractorManagerService.getVariableExtractor(ruleCondition.getNombreVariable(), request);
												if (valueOfVariable == null) {
													logger.logError(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.012", ruleCondition.getNombreVariable()));
													IMessageBlock message = new MessageBlock(6901010,
															"No se pudo extraer el valor para una condición de una regla, asociada a un parámetro general.");
													interceptorResponse.addResponseBlock(message);
													interceptorResponse.setReturnCode(6901010);
													context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);
													return;
												}
												Variable variable = new Variable();
												variable.setCodigoVariable(ruleCondition.getCodigoVariable());
												VariableProcess variableProcees = new VariableProcess();
												variableProcees.setVariable(variable);
												variableProcees.setValue(valueOfVariable);
												listVariableProcess.add(variableProcees);
											}
											HashMap<RuleVersion, List<VariableProcess>> valuesRules = new HashMap<RuleVersion, List<VariableProcess>>();
											valuesRules.put(versionRuleExecution, listVariableProcess);
											logger.logDebug(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.013", versionRule.getId()));
											List<RuleProcess> proceesRule = rulesManager.generate(valuesRules);
											for (RuleProcess procesos : proceesRule) {
												for (VariableProcess iterator : procesos.getVariableProcesses()) {
													logger.logDebug(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.014", versionRule.getId()));
													resultValueRules = iterator.getValue();
												}
											}
											logger.logDebug(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.015"));
											if (verifiedExtractorValue(resultValueRules)) {

												logger.logDebug(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.016", physicalField.getPhysicalFieldName()));
												resultExecRule = resultValueRules;
												if ("S".equals(physicalField.getMultivalue())) {
													physicalFieldtemp = new PhysicalField();
													physicalFieldtemp.setDataType(physicalField.getDataType());
													physicalFieldtemp.setFieldId(physicalField.getFieldId());
													physicalFieldtemp.setPhysicalFieldName(physicalField.getPhysicalFieldName());
													physicalFieldtemp.setDataType(physicalField.getDataType());
													physicalFieldtemp.setMultivalue(physicalField.getMultivalue());
													logger.logDebug(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.018", physicalField.getPhysicalFieldName()));
													physicalFieldtemp.setValue(generalParametersValuesHistory.getValue());
													gpMapping.put(physicalField.getPhysicalFieldName(), physicalFieldtemp);
												} else {
													logger.logDebug(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.018", physicalField.getPhysicalFieldName()));
													physicalField.setValue(generalParametersValuesHistory.getValue());
													gpMapping.put(physicalField.getPhysicalFieldName(), physicalField);
												}
											} else {
												logger.logDebug(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.017"));

												IMessageBlock message = new MessageBlock(6901024,
														"Existió un problema al evaluar la regla asociada a un parámetro general del producto.");
												interceptorResponse.addResponseBlock(message);
												interceptorResponse.setReturnCode(6901024);
												context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);
												return;
											}
										}
									}

								} else {
									if ("S".equals(physicalField.getMultivalue())) {

										physicalFieldtemp = new PhysicalField();
										physicalFieldtemp.setDataType(physicalField.getDataType());
										physicalFieldtemp.setFieldId(physicalField.getFieldId());
										physicalFieldtemp.setMultivalue(physicalField.getMultivalue());
										physicalFieldtemp.setPhysicalFieldName(physicalField.getPhysicalFieldName());
										physicalFieldtemp.setDataType(physicalField.getDataType());
										logger.logDebug(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.018", physicalField.getPhysicalFieldName()));
										physicalFieldtemp.setValue(generalParametersValuesHistory.getValue());
										gpMapping.put(physicalField.getPhysicalFieldName(), physicalFieldtemp);
									} else {
										logger.logDebug(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.018", physicalField.getPhysicalFieldName()));
										physicalField.setValue(generalParametersValuesHistory.getValue());
										gpMapping.put(physicalField.getPhysicalFieldName(), physicalField);
									}
								}
								if ("S".equals(physicalField.getMultivalue())) {

									if (!valuesInserted.contains(physicalField.getPhysicalFieldName() + physicalFieldtemp.getValue())) {

										for (RequiredFieldsByTable requiredFieldsByTable : fieldsByTables) {
											if(Constants.PRODUCTOPERATION.trim().equals(requiredFieldsByTable.getTypeField().trim()))
											{
												if(logger.isDebugEnabled()){
													logger.logDebug("Seteo campo correpondiente a Operación: "+ requiredFieldsByTable.getPhysicalFields());
												}
												
										// logger.logDebug("2_for_generalParametersValuesHistory--------------------------------------------------->"+physicalFieldtemp.getValue());
										// logger.logDebug("Multivalor--------------------------------------------------->");
												if (!gpMapping.containsKey(requiredFieldsByTable.getPhysicalFields().trim())) {
													PhysicalField operation = new PhysicalField(requiredFieldsByTable.getPhysicalFields().trim(), "varchar(10)", request.readParam("@s_ssn").getValue());
													gpMapping.put(requiredFieldsByTable.getPhysicalFields(), operation);
												}
											}else if(Constants.PRODUCTCURRENCY.trim().equals(requiredFieldsByTable.getTypeField().trim())){
												
												if(logger.isDebugEnabled()){
													logger.logDebug("Seteo campo correpondiente a Moneda: "+ requiredFieldsByTable.getPhysicalFields());
										}

										// Get identifier corresponding to
										// currency
												if (!gpMapping.containsKey(requiredFieldsByTable.getPhysicalFields().trim())) {
													PhysicalField currency = new PhysicalField(requiredFieldsByTable.getPhysicalFields().trim(), "tinyint", request.readParam("@i_moneda").getValue());
													gpMapping.put(requiredFieldsByTable.getPhysicalFields().trim(), currency);
												}
											}
										}

										if (table.getTable().trim().equals(PORTFOLIO_DEFAULT_GP_TABLE)) {
											// Verified data
											this.verifiedValueForDefault(gpMapping);
										}
										rowFields.add(gpMapping);
										valuesInserted.add(physicalField.getPhysicalFieldName() + physicalFieldtemp.getValue());
										isMultiValue = true;
									}
								}
							}

						}// end history fields for

					}// end fields for
						// Set the default values for PORTFOLIO general
						// parameters table
					if (!isMultiValue) {
						
						for (RequiredFieldsByTable requiredFieldsByTable : fieldsByTables) {

							if(Constants.PRODUCTOPERATION.trim().equals(requiredFieldsByTable.getTypeField().trim()))
							{
								if(logger.isDebugEnabled()){
									logger.logDebug("Seteo campo correpondiente a Operación: "+ requiredFieldsByTable.getPhysicalFields());
								}

								if (!gpMapping.containsKey(requiredFieldsByTable.getPhysicalFields().trim())) {
									PhysicalField operation = new PhysicalField(requiredFieldsByTable.getPhysicalFields(), "varchar(10)", request.readParam("@s_ssn").getValue());
									gpMapping.put(requiredFieldsByTable.getPhysicalFields(), operation);
								}

							}else if(Constants.PRODUCTCURRENCY.trim().equals(requiredFieldsByTable.getTypeField().trim())){
								
								if(logger.isDebugEnabled()){
									logger.logDebug("Seteo campo correpondiente a Moneda: "+ requiredFieldsByTable.getPhysicalFields());
						}

						// Get identifier corresponding to currency
								if (!gpMapping.containsKey(requiredFieldsByTable.getPhysicalFields())) {
									PhysicalField currency = new PhysicalField(requiredFieldsByTable.getPhysicalFields(), "tinyint", request.readParam("@i_moneda").getValue());
									gpMapping.put(requiredFieldsByTable.getPhysicalFields(), currency);
								}
							}
						}

						if (table.getTable().trim().equals(PORTFOLIO_DEFAULT_GP_TABLE)) {
							// Verified data
							this.verifiedValueForDefault(gpMapping);
						}

						rowFields.add(gpMapping);
					}
					coreTableInformation.put(table, rowFields);

				}// end for
				logger.logDebug(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.020"));
				// Save DefaultOperation object
				operationManagerService.insertDynamicCreditOperationGeneralParameters(coreTableInformation);

				context.addValue("CORE_INFORMATION", coreTableInformation);
			} else {
				logger.logError(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.022"));
				IMessageBlock message = new MessageBlock(6901020, "No existe una configuración a la fecha para el producto solicitado.");
				interceptorResponse.addResponseBlock(message);
				interceptorResponse.setReturnCode(6901020);
			}

		} catch (Exception ex) {

			logger.logError(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.021"), ex);

			IMessageBlock message = null;

			if (ex instanceof BusinessException) {
				message = new MessageBlock(((BusinessException) ex).getClientErrorCode(), ((BusinessException) ex).getMessage());
				interceptorResponse.setReturnCode(((BusinessException) ex).getClientErrorCode());

			} else {
				message = new MessageBlock(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");
				interceptorResponse.setReturnCode(6900001);
			}

			interceptorResponse.addResponseBlock(message);
			context.addValue(CobisInterceptorContext.PROCEDURE_RESPONSE_KEY, interceptorResponse);
		} finally {
			logger.logDebug(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.002", "execute"));

		}
	}

	// end-region

	// region Utility methods

	/**
	 * 
	 * Verified Value
	 * 
	 * @param gpMapping
	 */
	private void verifiedValueForDefault(HashMap<String, PhysicalField> gpMapping) {

		logger.logDebug(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.001", "verifiedValueForDefault"));

		try {
			Map<String, String> defaultValues = defaultValuesManager.getDefaultValues();
			//Si no esta configurado en el APF se pone el valor por defecto
			if (!gpMapping.containsKey("dt_precancelacion")) {
				PhysicalField prepayment = new PhysicalField("dt_precancelacion", "varchar(10)", defaultValues.get(Constants.INTERCEPTORS.PREPAYMENT));
				gpMapping.put("dt_precancelacion", prepayment);
			}
			if (!gpMapping.containsKey("dt_cuota_completa")) {
				PhysicalField fullQuota = new PhysicalField("dt_cuota_completa", "char(1)", defaultValues.get(Constants.INTERCEPTORS.COMPLETE_QUOTA));
				gpMapping.put("dt_cuota_completa", fullQuota);
			}
			if (!gpMapping.containsKey("dt_tplazo")) {
				PhysicalField tTimeLimit = new PhysicalField("dt_tplazo", "varchar(1)", defaultValues.get(Constants.INTERCEPTORS.T_TERM));
				gpMapping.put("dt_tplazo", tTimeLimit);
			}
			if (!gpMapping.containsKey("dt_plazo")) {
				PhysicalField timeLimit = new PhysicalField("dt_plazo", "smallint", defaultValues.get(Constants.INTERCEPTORS.TERM));
				gpMapping.put("dt_plazo", timeLimit);
			}
			if (!gpMapping.containsKey("dt_tdividendo")) {
				PhysicalField dividend = new PhysicalField("dt_tdividendo", "varchar(10)", defaultValues.get(Constants.INTERCEPTORS.DIVIDEND));
				gpMapping.put("dt_tdividendo", dividend);
			}
			if (!gpMapping.containsKey("dt_periodo_cap")) {
				PhysicalField capPeriod = new PhysicalField("dt_periodo_cap", "smallint", defaultValues.get(Constants.INTERCEPTORS.PERIOD_CAP));
				gpMapping.put("dt_periodo_cap", capPeriod);
			}
			if (!gpMapping.containsKey("dt_periodo_int")) {
				PhysicalField intPeriod = new PhysicalField("dt_periodo_int", "smallint", defaultValues.get(Constants.INTERCEPTORS.PERIOD_INT));
				gpMapping.put("dt_periodo_int", intPeriod);
			}
			if (!gpMapping.containsKey("dt_gracia_cap")) {
				PhysicalField capGain = new PhysicalField("dt_gracia_cap", "smallint", defaultValues.get(Constants.INTERCEPTORS.GRACE_CAP));
				gpMapping.put("dt_gracia_cap", capGain);
			}
			if (!gpMapping.containsKey("dt_gracia_int")) {
				PhysicalField intGain = new PhysicalField("dt_gracia_int", "smallint", defaultValues.get(Constants.INTERCEPTORS.GRACE_INT));
				gpMapping.put("dt_gracia_int", intGain);
			}
			if (!gpMapping.containsKey("dt_dist_gracia")) {
				PhysicalField distGain = new PhysicalField("dt_dist_gracia", "char(1)", defaultValues.get(Constants.INTERCEPTORS.DIST_GRACE));
				gpMapping.put("dt_dist_gracia", distGain);
			}
			if (!gpMapping.containsKey("dt_dias_gracia")) {
				PhysicalField daysGain = new PhysicalField("dt_dias_gracia", "tinyint", defaultValues.get(Constants.INTERCEPTORS.DAYS_OF_GRACE));
				gpMapping.put("dt_dias_gracia", daysGain);
			}
			if (!gpMapping.containsKey("dt_mes_gracia")) {
				PhysicalField monthGain = new PhysicalField("dt_mes_gracia", "tinyint", defaultValues.get(Constants.INTERCEPTORS.MONTH_OF_GRACE));
				gpMapping.put("dt_mes_gracia", monthGain);
			}
			if (!gpMapping.containsKey("dt_prd_cobis")) {
				PhysicalField prdCOBIS = new PhysicalField("dt_prd_cobis", "tinyint", defaultValues.get(Constants.INTERCEPTORS.PRD_COBIS));
				gpMapping.put("dt_prd_cobis", prdCOBIS);
			}
			if (!gpMapping.containsKey("dt_dias_anio")) {
				PhysicalField daysYear = new PhysicalField("dt_dias_anio", "smallint", defaultValues.get(Constants.INTERCEPTORS.DAYS_OF_YEARS));

				gpMapping.put("dt_dias_anio", daysYear);
			}
			if (!gpMapping.containsKey("dt_dia_pago")) {
				PhysicalField dayPayment = new PhysicalField("dt_dia_pago", "tinyint", defaultValues.get(Constants.INTERCEPTORS.DAY_OF_PAYMENT));

				gpMapping.put("dt_dia_pago", dayPayment);
			}
			if (!gpMapping.containsKey("dt_cuota_fija")) {

				PhysicalField priorityType = new PhysicalField("dt_cuota_fija", "char(1)",
						gpMapping.get("dt_tipo_amortizacion") != null
								&& gpMapping.get("dt_tipo_amortizacion").getValue() == defaultValues.get(Constants.INTERCEPTORS.AMORTIZATION_TYPE) ? defaultValues
								.get(Constants.INTERCEPTORS.FIX_QUOTA_N) : defaultValues.get(Constants.INTERCEPTORS.FIX_QUOTA_S));

				gpMapping.put("dt_cuota_fija", priorityType);
			}

			if (!gpMapping.containsKey("dt_aceptar_anticipos")) {
				PhysicalField acceptAdvances = new PhysicalField("dt_aceptar_anticipos", "char(1)", defaultValues.get(Constants.INTERCEPTORS.ACCEPT_ADVANCES));

				gpMapping.put("dt_aceptar_anticipos", acceptAdvances);
			}

			// dt_evitar_feriados
			if (!gpMapping.containsKey("dt_evitar_feriados")) {
				PhysicalField avoidHolidays = new PhysicalField("dt_evitar_feriados", "char(1)", defaultValues.get(Constants.INTERCEPTORS.PREVENT_HOLIDAYS));

				gpMapping.put("dt_evitar_feriados", avoidHolidays);
			}
			
			logger.logDebug(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.019"));

		} finally {
			logger.logDebug(MessageManager.getString("GENERALPARAMETERSINTERCEPTOR.002", "verifiedValueForDefault"));
		}
	}
	
	/**
	 * Verified extractor value
	 * 
	 * @param extractorValue
	 * @return Indicates whether the extractor to use default values
	 */
	private Boolean verifiedExtractorValue(String extractorValue) {
		if (extractorValue.equals(compareRule)) {
			return false; 
		} else if (extractorValue == "0") {
			return false;
		} else if (extractorValue == "") {
			return false;
		} else {
			return true;
		}

	}
	// end-region

}
