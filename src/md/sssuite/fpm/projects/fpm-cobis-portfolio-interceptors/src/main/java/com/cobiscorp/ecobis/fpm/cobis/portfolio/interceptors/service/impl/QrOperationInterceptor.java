/*
 * File: QrOperationInterceptor.java
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

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleProcess;
import com.cobiscorp.ecobis.bpl.rules.engine.model.RuleVersion;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.bpl.rules.engine.model.VariableProcess;
import com.cobiscorp.ecobis.bpl.rules.engine.services.IRuleManager;
import com.cobiscorp.ecobis.fpm.administration.service.IDictionaryManager;
import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.bo.PhysicalField;
import com.cobiscorp.ecobis.fpm.catalogs.service.ICatalogManager;
import com.cobiscorp.ecobis.fpm.cobis.portfolio.interceptors.service.utils.MessageManager;
import com.cobiscorp.ecobis.fpm.extractors.administration.service.IExtractorManager;
import com.cobiscorp.ecobis.fpm.interceptors.service.IDefaultValuesManager;
import com.cobiscorp.ecobis.fpm.model.CoreTable;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;
import com.cobiscorp.ecobis.fpm.model.NodeTypeCategory;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.operation.service.IGeneralParametersManager;
import com.cobiscorp.ecobis.fpm.operation.service.IMappingFieldManager;
import com.cobiscorp.ecobis.fpm.portfolio.bo.OperationData;
import com.cobiscorp.ecobis.fpm.portfolio.model.DefaultOperation;
import com.cobiscorp.ecobis.fpm.portfolio.service.IDefaultOperationManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;

/**
 * Intercepts the sp_qr_opeacion_tmp stored procedure
 * 
 * @author despinosa
 * 
 */
@SuppressWarnings(value = "all")
public class QrOperationInterceptor implements CobisInterceptor {

	// region fields

	/** Cobis Logger */

	// Contains 255 characteres {0}
	private static final String compareRule = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

	private static final String PORTFOLIO_DEFAULT_GP_TABLE = "ca_default_toperacion";

	private static final ILogger logger = LogFactory
			.getLogger(QrOperationInterceptor.class);

	/** CatalogManager Service */
	private ICatalogManager catalogManager;

	/** GeneralParametersManager Service */
	private IGeneralParametersManager generalParametersServices;

	/** DictionaryManager Service */
	private IMappingFieldManager mappingFieldManagerService;

	/** DictionaryManager Service */
	private IDictionaryManager dictionaryService;

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

	private Integer changePeriod;
	// Corresponds to the field dt_plazo
	private int timeLimit;
	// Corresponds to the field dt_periodo_cap
	private int capPeriod;
	// Corresponds to the field dt_periodo_int
	private int intPeriod;
	// Corresponds to the field dt_gracia_cap
	private int capGrace;
	// Corresponds to the field dt_gracia_int
	private int intGrace;
	// Corresponds to the field dt_dias_anio
	private int daysYear;
	// Corresponds to the field dt_dia_pago
	private long dayPayment;
	// Corresponds to the field dt_dias_gracia
	private long daysGrace;
	// Corresponds to the field dt_cuota_fija
	private String fixedQuota;
	// Corresponds to the field dt_mes_gracia
	private long monthGrace;
	// Corresponds to the field dt_prd_cobis
	private long prdCobis;
	// Corresponds to the field dt_moneda_ajuste
	private Long adjustmentCurrency;
	// Corresponds to the field dt_dia_ppago
	private long dayPPayment;
	// Corresponds to the field dt_filial
	private Long affiliate;
	// value to set the rule id
	private Rule rule;

	// Corresponds to the field dt_precancelacion
	private String preCancellation = null;
	// Corresponds to the field dt_cuota_completa
	private String completeQuota = null;
	// Corresponds to the field dt_tplazo
	private String tTimeLimit = null;
	// Corresponds to the field dt_tdividendo
	private String dividend = null;
	// Corresponds to the field dt_dist_gracia
	private String distGrace = null;
	// Corresponds to the field dt_cuota_menor
	private String lessQuota = null;
	// Corresponds to the field dt_subsidio
	private String subsidy = null;
	// Corresponds to the field dt_tpreferencial
	private String preference = null;
	// Corresponds to the field dt_modo_reest
	private String modeReest = null;
	// Corresponds to the field dt_efecto_pago
	private String effectPayment = null;
	// Corresponds to the field dt_tipo_prioridad
	private String priority = null;

	// list process to get the condition list for execute the rule
	private List<VariableProcess> listVariableProcess;
	private VariableProcess variableProcees;
	// result of execute rule
	private String resultValueRules;

	RuleVersion versionRule = null;

	// end-region

	// region Properties
	public void setOperationManagerService(
			IDefaultOperationManager operationManagerService) {
		this.operationManagerService = operationManagerService;
	}

	public void setDictionaryService(IDictionaryManager dictionaryService) {
		this.dictionaryService = dictionaryService;
	}

	public void setGeneralParametersServices(
			IGeneralParametersManager generalParametersServices) {
		this.generalParametersServices = generalParametersServices;
	}

	public void setRulesManager(IRuleManager rulesManager) {
		this.rulesManager = rulesManager;
	}

	public void setExtractorManagerService(
			IExtractorManager extractorManagerService) {
		this.extractorManagerService = extractorManagerService;
	}

	public void setCatalogManager(ICatalogManager catalogManager) {
		this.catalogManager = catalogManager;
	}

	public void setMappingFieldManagerService(
			IMappingFieldManager mappingFieldManagerService) {
		this.mappingFieldManagerService = mappingFieldManagerService;
	}

	public void setBankingProductManager(
			IBankingProductManager bankingProductManager) {
		this.bankingProductManager = bankingProductManager;
	}

	// end-region

	public void setDefaultValuesManager(
			IDefaultValuesManager defaultValuesManager) {
		this.defaultValuesManager = defaultValuesManager;
	}

	// region methods of class
	/**
	 * Is executed before the sp_qr_operacion_tmp.Inserts and updates the
	 * ca_default_toperacion, ca_operacion_tmp and cl_catalogo tables.
	 */
	public void execute(CobisInterceptorContext context) {

		logger.logDebug(MessageManager.getString("QROPERATIONINTERCEPTOR.001",
				"execute"));

		String resultExecRule = null;
		DefaultOperation defaultTOperation = null;
		IProcedureRequest request = null;
		IProcedureResponse interceptorResponse = new ProcedureResponseAS();

		List<CoreTable> coreTableList = null;
		// Date type conversion from Frontend
		Date operationDateInitial = null;
		// Date history
		Date systemDate = null;
		Date operationDate = null;
		// Registry history corresponds general parameters
		List<GeneralParametersValuesHistory> gpValuesHistoryList = null; 
		HashMap<String, PhysicalField> gpMapping = new HashMap<String, PhysicalField>();

		// Contains the metadata and information necessary to construct the
		// dynamic inserts
		Map<CoreTable, Map<String, PhysicalField>> coreTableInformation = new HashMap<CoreTable, Map<String, PhysicalField>>();

		request = context
				.getValue(CobisInterceptorContext.PROCEDURE_REQUEST_KEY);

		try {

			logger.logDebug(MessageManager.getString(
					"QROPERATIONINTERCEPTOR.003", request.getSpName()));

			OperationData opData = this.operationManagerService
					.getOperationData(request.readParam("@i_codigo").getValue());

			NodeTypeCategory category = bankingProductManager
					.getCategoryKeepDictionaryFromParents(opData
							.gettOperation());

			// Add module mnemonic
			context.addValue(
					request.readParam("@s_ssn").getValue().concat("mnemonic"),
					category.getModule().getMnemonic().trim());

			
			if (category.getModule().getMnemonic().equals("CCA")) {

				context.addValue("opData2", opData.gettOperation());// [2].toString());
				
				//Se añade un parámetro con la información original del tipo de operacion
				request.addInputParam("@i_toperacion_ori", ICTSTypes.SQLVARCHAR, opData.gettOperation().trim());
				
				logger.logDebug(MessageManager
						.getString("GENERALPARAMETERSINTERCEPTOR.004"));

				if (opData.getState() == 0 || opData.getState() == 99) {

					operationDateInitial = opData.getInitialDate();// [0].toString());

					DateFormat dateFormat = new SimpleDateFormat(
							"MM/dd/yyyy HH:mm");

					String dateInitial = dateFormat
							.format(operationDateInitial);

					if (dateInitial.contains("00:00")) {
						dateInitial = dateInitial.replaceAll("00:00", "23:59");
					}

					operationDate = new SimpleDateFormat(
							"MM/dd/yyyy HH:mm").parse(dateInitial);

				} else {
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

				// Get value date history
				systemDate = generalParametersServices
						.getDateHistory(operationDate,
								opData.gettOperation());

				// Get information corresponding column data and idetifier
				// fields

				coreTableList = mappingFieldManagerService
						.getPhysicalFieldsMappings(
								opData.gettOperation(),// [2].toString(),
								Constants.GENERAL_PARAMETERS_DICTIONARY,
								systemDate);

				// Get history data
				gpValuesHistoryList = generalParametersServices
						.getGeneralParametersBySystemDate(systemDate,
								opData.gettOperation());// [2].toString());
				if (coreTableList.size() <= 0) {

					logger.logError(MessageManager
							.getString("QROPERATIONINTERCEPTOR.005"));

					IMessageBlock message = new MessageBlock(6901006,
							"No se pudieron recuperar los valores correspondientes a parámetros generales.");
					interceptorResponse.addResponseBlock(message);
					interceptorResponse.setReturnCode(6901006);

					context.addValue(
							CobisInterceptorContext.PROCEDURE_RESPONSE_KEY,
							interceptorResponse);
					return;
				}
				for (CoreTable table : coreTableList) {
					gpMapping = new HashMap<String, PhysicalField>();

					for (PhysicalField physicalField : table
							.getPhysicalFields()) {
						for (GeneralParametersValuesHistory generalParametersValuesHistory : gpValuesHistoryList) {
							if (physicalField.getFieldId() == generalParametersValuesHistory
									.getDictionaryFieldId()) {
								if (physicalField.getFieldId() == generalParametersValuesHistory
										.getDictionaryFieldId()) {

									if (generalParametersValuesHistory
											.getRuleId() > 0) {

										logger.logDebug(MessageManager
												.getString(
														"QROPERATIONINTERCEPTOR.006",
														generalParametersValuesHistory
																.getRuleId(),
														physicalField
																.getPhysicalFieldName()));

										rule = new Rule();
										rule.setId(generalParametersValuesHistory
												.getRuleId());

										versionRule = rulesManager
												.queryRuleVersionActive(rule);

										if (versionRule == null) {

											logger.logDebug(MessageManager
													.getString(
															"QROPERATIONINTERCEPTOR.007",
															rule.getId(),
															physicalField
																	.getPhysicalFieldName()));

											IMessageBlock message = new MessageBlock(
													6901009,
													"No se pudo recuperar una versión activa de la regla asociada a un parámetro general del FPM. ");
											interceptorResponse
													.addResponseBlock(message);
											interceptorResponse
													.setReturnCode(6901009);

											context.addValue(
													CobisInterceptorContext.PROCEDURE_RESPONSE_KEY,
													interceptorResponse);

											return;

										} else {

											logger.logDebug(MessageManager
													.getString(
															"QROPERATIONINTERCEPTOR.008",
															versionRule.getId()));

											// versionRule = rulesManager
											// .queryRuleVersionActive(rule);
											RuleVersion versionRuleExecution = new RuleVersion();
											versionRuleExecution
													.setId(versionRule.getId());
											versionRuleExecution.setRule(rule);
											// Get conditions for rule
											List<Variable> variableList = rulesManager
													.queryConditionRuleVersionActive(versionRule);

											if (variableList.size() == 0) {
												logger.logError(MessageManager
														.getString(
																"QROPERATIONINTERCEPTOR.009",
																versionRule
																		.getId()));
												IMessageBlock message = new MessageBlock(
														6901007,
														"No se pudo recuperar la lista de condiciones correspondientes a la regla activa asociada al parámetro general del FPM.");
												interceptorResponse
														.addResponseBlock(message);
												interceptorResponse
														.setReturnCode(6901007);

												context.addValue(
														CobisInterceptorContext.PROCEDURE_RESPONSE_KEY,
														interceptorResponse);
												return;

											} else {

												logger.logError(MessageManager
														.getString(
																"QROPERATIONINTERCEPTOR.010",
																versionRule
																		.getId()));

												for (Variable ruleCondition : variableList) {

													logger.logDebug(MessageManager
															.getString(
																	"QROPERATIONINTERCEPTOR.011",
																	ruleCondition
																			.getNombreVariable()));

													String name = ruleCondition
															.getNombreVariable();

													String valueOfVariable = extractorManagerService
															.getVariableExtractor(
																	name,
																	request);

													if (valueOfVariable == null) {

														logger.logError(MessageManager
																.getString(
																		"QROPERATIONINTERCEPTOR.012",
																		ruleCondition
																				.getNombreVariable()));

														IMessageBlock message = new MessageBlock(
																6901010,
																"No se pudo extraer el valor para una condición de una regla, asociada a un parámetro general.");
														interceptorResponse
																.addResponseBlock(message);
														interceptorResponse
																.setReturnCode(6901010);

														context.addValue(
																CobisInterceptorContext.PROCEDURE_RESPONSE_KEY,
																interceptorResponse);

														return;
													}

													Variable variable = new Variable();
													variable.setCodigoVariable(ruleCondition
															.getCodigoVariable());

													VariableProcess variableProcees = new VariableProcess();
													variableProcees
															.setVariable(variable);
													variableProcees
															.setValue(valueOfVariable);

													listVariableProcess
															.add(variableProcees);

												}

												HashMap<RuleVersion, List<VariableProcess>> valuesRules = new HashMap<RuleVersion, List<VariableProcess>>();
												valuesRules.put(
														versionRuleExecution,
														listVariableProcess);

												logger.logDebug(MessageManager
														.getString(
																"QROPERATIONINTERCEPTOR.013",
																versionRule
																		.getId()));

												List<RuleProcess> proceesRule = rulesManager
														.generate(valuesRules);

												for (RuleProcess procesos : proceesRule) {

													for (VariableProcess iterator : procesos
															.getVariableProcesses()) {

														logger.logDebug(MessageManager
																.getString(
																		"QROPERATIONINTERCEPTOR.014",
																		versionRule
																				.getId()));

														resultValueRules = iterator
																.getValue();
													}

												}

												logger.logDebug(MessageManager
														.getString("QROPERATIONINTERCEPTOR.015"));

												if (verifiedExtractorValue(resultValueRules)) {

													logger.logDebug(MessageManager
															.getString(
																	"QROPERATIONINTERCEPTOR.016",
																	physicalField
																			.getPhysicalFieldName()));

													resultExecRule = resultValueRules;
													physicalField
															.setValue(resultExecRule);
													gpMapping
															.put(physicalField
																	.getPhysicalFieldName(),
																	physicalField);

												} else {

													logger.logDebug(MessageManager
															.getString("GENERALPARAMETERSINTERCEPTOR.017"));
													IMessageBlock message = new MessageBlock(
															6901024,
															"Existió un problema al evaluar la regla asociada a un parámetro general del producto.");
													interceptorResponse
															.addResponseBlock(message);
													interceptorResponse
															.setReturnCode(6901024);
													context.addValue(
															CobisInterceptorContext.PROCEDURE_RESPONSE_KEY,
															interceptorResponse);
													return;
												}
											}
										}

									} else {

										logger.logDebug(MessageManager
												.getString(
														"GENERALPARAMETERSINTERCEPTOR.018",
														physicalField
																.getPhysicalFieldName()));
										physicalField
												.setValue(generalParametersValuesHistory
														.getValue());
										gpMapping.put(physicalField
												.getPhysicalFieldName(),
												physicalField);
									}

								}

							}
						}// end history fields for

						// update ca_operacion_tmp fields
						Integer registry = this.operationManagerService
								.updateCreateOperation(opData.getOperation(),
										request.readParam("@s_ssn").getValue());

						if (registry <= 0) {
							this.operationManagerService
									.updateCreateOperationDef(opData
											.getOperation(),
											request.readParam("@s_ssn")
													.getValue());
						}

						// Insert in COBIS cl_catalog

						Catalog newCatalog = new Catalog(request
								.readParam("@s_ssn").getValue().trim(), "");
						this.catalogManager.createCatalog("ca_toperacion",
								newCatalog);
					}// end fields for

					// Set the default values for PORTFOLIO general
					// parameters table
					if (!gpMapping.containsKey("dt_toperacion")) {
						PhysicalField operation = new PhysicalField(
								"dt_toperacion", "varchar(10)", request
										.readParam("@s_ssn").getValue());
						gpMapping.put("dt_toperacion", operation);
					}
					// Get identifier corresponding to currency
					if (!gpMapping.containsKey("dt_moneda")) {

						PhysicalField currency = new PhysicalField("dt_moneda",
								"tinyint", opData.getCurrency().toString());
						gpMapping.put("dt_moneda", currency);
					}

					if (table.getTable().trim()
							.equals(PORTFOLIO_DEFAULT_GP_TABLE)) {
						// Verified data
						this.verifiedValueForDefault(gpMapping);
					}
					coreTableInformation.put(table, gpMapping);

				}// end for

				logger.logDebug(MessageManager
						.getString("QROPERATIONINTERCEPTOR.020"));
				// Save DefaultOperation object
				operationManagerService
						.insertDynamicCreditOperation(coreTableInformation);

				context.addValue("CORE_INFORMATION", coreTableInformation);

			}

		} catch (Exception e) {

			logger.logError(
					MessageManager.getString("QROPERATIONINTERCEPTOR.019"), e);

			IMessageBlock message = null;

			if (e instanceof BusinessException) {
				message = new MessageBlock(
						((BusinessException) e).getClientErrorCode(),
						((BusinessException) e).getMessage());
				interceptorResponse.setReturnCode(((BusinessException) e)
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
					"QROPERATIONINTERCEPTOR.002", "execute"));

		}

	}

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

	private void verifiedValueForDefault(
			HashMap<String, PhysicalField> gpMapping) {

		PhysicalField fundsOwn = null;

			Map<String, String> defaultValues = defaultValuesManager.getDefaultValues();

		// Verified origin for determine origin own funds
			/*if (gpMapping.get("dt_origen_fondo") != null && gpMapping.get("dt_origen_fondo").getValue().trim().equals(defaultValues.get(Constants.INTERCEPTORS.SOURCE_OF_FUNDS))) {
				fundsOwn = new PhysicalField("dt_fondos_propios", "char(1)", defaultValues.get(Constants.INTERCEPTORS.SOURCE_OF_FUNDS_S));

			gpMapping.put("dt_fondos_propios", fundsOwn);
		} else {
				fundsOwn = new PhysicalField("dt_fondos_propios", "char(1)", defaultValues.get(Constants.INTERCEPTORS.SOURCE_OF_FUNDS_N));
			gpMapping.put("dt_fondos_propios", fundsOwn);
			}*/

		if (!gpMapping.containsKey("dt_precancelacion")) {
			PhysicalField prepayment = new PhysicalField("dt_precancelacion",
					"varchar(10)",
					defaultValues.get(Constants.INTERCEPTORS.PREPAYMENT));
			gpMapping.put("dt_precancelacion", prepayment);
		}
		if (!gpMapping.containsKey("dt_cuota_completa")) {
			PhysicalField fullQuota = new PhysicalField("dt_cuota_completa",
					"char(1)",
					defaultValues.get(Constants.INTERCEPTORS.COMPLETE_QUOTA));
			gpMapping.put("dt_cuota_completa", fullQuota);
		}
		if (!gpMapping.containsKey("dt_tplazo")) {
			PhysicalField tTimeLimit = new PhysicalField("dt_tplazo",
					"varchar(1)",
					defaultValues.get(Constants.INTERCEPTORS.T_TERM));
			gpMapping.put("dt_tplazo", tTimeLimit);
		}
		if (!gpMapping.containsKey("dt_plazo")) {
			PhysicalField timeLimit = new PhysicalField("dt_plazo", "smallint",
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
					defaultValues.get(Constants.INTERCEPTORS.MONTH_OF_GRACE));
			gpMapping.put("dt_mes_gracia", monthGain);
		}
			/*if (!gpMapping.containsKey("dt_cuota_menor")) {
				PhysicalField lessQuota = new PhysicalField("dt_cuota_menor", "char(1)", defaultValues.get(Constants.INTERCEPTORS.SMALL_QUOTA));
			gpMapping.put("dt_cuota_menor", lessQuota);
			}*/
			/*if (!gpMapping.containsKey("dt_prd_cobis")) {
				PhysicalField prdCOBIS = new PhysicalField("dt_prd_cobis", "tinyint", defaultValues.get(Constants.INTERCEPTORS.PRD_COBIS));
			gpMapping.put("dt_prd_cobis", prdCOBIS);
			}*/
			/*if (!gpMapping.containsKey("dt_dia_ppago")) {
				PhysicalField dayPayment = new PhysicalField("dt_dia_ppago", "tinyint", defaultValues.get(Constants.INTERCEPTORS.DAY_PPAYMENT));
			gpMapping.put("dt_dia_ppago", dayPayment);
			}*/
			/*if (!gpMapping.containsKey("dt_subsidio")) {
				PhysicalField subsidy = new PhysicalField("dt_subsidio", "char(1)", defaultValues.get(Constants.INTERCEPTORS.SUBSIDY));
			gpMapping.put("dt_subsidio", subsidy);
			}*/
			/*if (!gpMapping.containsKey("dt_tpreferencial")) {
				PhysicalField tPreference = new PhysicalField("dt_tpreferencial", "char(1)", defaultValues.get(Constants.INTERCEPTORS.T_PREFERENTIAL));
			gpMapping.put("dt_tpreferencial", tPreference);
			}*/
			/*if (!gpMapping.containsKey("dt_modo_reest")) {
				PhysicalField reestMode = new PhysicalField("dt_modo_reest", "char(1)", defaultValues.get(Constants.INTERCEPTORS.MODE_REEST));
			gpMapping.put("dt_modo_reest", reestMode);
			}*/
			/*if (!gpMapping.containsKey("dt_efecto_pago")) {
				PhysicalField effectPayment = new PhysicalField("dt_efecto_pago", "char(1)", defaultValues.get(Constants.INTERCEPTORS.EFFECT_PAYMENT));
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
					defaultValues.get(Constants.INTERCEPTORS.DAY_OF_PAYMENT));

			gpMapping.put("dt_dia_pago", dayPayment);
		}
			/*if (!gpMapping.containsKey("dt_tipo_prioridad")) {
				PhysicalField priorityType = new PhysicalField("dt_tipo_prioridad", "char(1)", defaultValues.get(Constants.INTERCEPTORS.PRIORITY_TYPE));

			gpMapping.put("dt_tipo_prioridad", priorityType);
			}*/
		if (!gpMapping.containsKey("dt_cuota_fija")) {

			PhysicalField priorityType = new PhysicalField(
					"dt_cuota_fija",
					"char(1)",
					gpMapping.get("dt_tipo_amortizacion") != null
							&& gpMapping.get("dt_tipo_amortizacion").getValue() == defaultValues
									.get(Constants.INTERCEPTORS.AMORTIZATION_TYPE) ? defaultValues
							.get(Constants.INTERCEPTORS.FIX_QUOTA_N)
							: defaultValues
									.get(Constants.INTERCEPTORS.FIX_QUOTA_S));

			gpMapping.put("dt_cuota_fija", priorityType);
		}

		if (!gpMapping.containsKey("dt_aceptar_anticipos")) {
			PhysicalField acceptAdvances = new PhysicalField(
					"dt_aceptar_anticipos", "char(1)",
					defaultValues.get(Constants.INTERCEPTORS.ACCEPT_ADVANCES));

			gpMapping.put("dt_aceptar_anticipos", acceptAdvances);
		}

		// dt_evitar_feriados
		if (!gpMapping.containsKey("dt_evitar_feriados")) {
			PhysicalField avoidHolidays = new PhysicalField(
					"dt_evitar_feriados", "char(1)",
					defaultValues.get(Constants.INTERCEPTORS.PREVENT_HOLIDAYS));

			gpMapping.put("dt_evitar_feriados", avoidHolidays);
		}

		logger.logDebug(MessageManager
				.getString("GENERALPARAMETERSINTERCEPTOR.019"));
	}

	// end-region

}
