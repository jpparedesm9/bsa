/*
 * File: PortfolioGeneralParametersManager.java
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.cobisv.commons.exceptions.ValidationException;
import com.cobiscorp.cobisv.commons.exceptions.ValidationMessage;
import com.cobiscorp.ecobis.fpm.bo.PhysicalField;
import com.cobiscorp.ecobis.fpm.interceptors.service.IDefaultValuesManager;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.CoreTable;
import com.cobiscorp.ecobis.fpm.model.CurrencyProduct;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValues;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.operation.service.IGeneralParametersManager;
import com.cobiscorp.ecobis.fpm.operation.service.IItemsManager;
import com.cobiscorp.ecobis.fpm.operation.service.IMappingFieldManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.IPortfolioGeneralParametersManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.utils.CreateDataForReport;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.utils.MessageManager;
import com.cobiscorp.ecobis.fpm.portfolio.service.IDefaultOperationManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;

/**
 * Implementation for the integration services in general parameter
 * 
 * @author oguano
 * 
 */
public class PortfolioGeneralParametersManager implements
		IPortfolioGeneralParametersManager {

	// region Field's
	/** COBIS Logger */
	private static final ILogger logger = LogFactory
			.getLogger(PortfolioGeneralParametersManager.class);

	/** IMappingFieldManager Service */
	private IMappingFieldManager mappingFieldService;
	/** IItemsManager Service */
	private IItemsManager itemService;
	/** IGeneralParametersManager Service */
	private IGeneralParametersManager generalParametersManager;
	/** IDefaultOperationManager Service */
	private IDefaultOperationManager defaultOperationService;
	/** IDefaultValuesManager Service */
	private IDefaultValuesManager defaultValuesManager;
	/** IBankingProductManager Service */
	private IBankingProductManager bankingProductManager;

	// end-region

	// region Properties
	public void setMappingFieldService(IMappingFieldManager mappingFieldService) {
		this.mappingFieldService = mappingFieldService;
	}

	public void setItemService(IItemsManager itemService) {
		this.itemService = itemService;
	}

	public void setGeneralParametersManager(
			IGeneralParametersManager generalParametersManager) {
		this.generalParametersManager = generalParametersManager;
	}

	public void setDefaultOperationService(
			IDefaultOperationManager defaultOperationService) {
		this.defaultOperationService = defaultOperationService;
	}

	public void setDefaultValuesManager(
			IDefaultValuesManager defaultValuesManager) {
		this.defaultValuesManager = defaultValuesManager;
	}

	public void setBankingProductManager(
			IBankingProductManager bankingProductManager) {
		this.bankingProductManager = bankingProductManager;
	}

	// end-region

	// region Implements

	@Override
	public void saveGeneralParametersValues(String productId,
			ArrayList<GeneralParametersValues> updateValues, Boolean isFinished) {

		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOGENERALPARAMETERMANAGER.001",
					"saveGeneralParametersValues"));
			// Validate the parameters
			validateGeneralParameters(productId,
					prepareGeneralParameters(productId));
			// Items Readjustments
			ReadjustmentItems(productId);
		} catch (ValidationException ve) {
			throw ve;
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
					"saveGeneralParametersValues"));
		}
	}

	/**
	 * Validate the given parameters by banking product
	 * 
	 * @param productId
	 *            Banking product identifier
	 * @param parameters
	 *            A Map that contains the core parameter identifier as key and
	 *            the parameter value as value
	 */
	public void validateGeneralParameters(String productId,
			HashMap<String, String> parameters) {
		try {
			logger.logDebug(MessageManager.getString(
					"PORTFOLIOGENERALPARAMETERMANAGER.001",
					"validateGeneralParameters"));
			if (logger.isDebugEnabled()) {
				logger.logDebug("Parameters received");
				for (String key : parameters.keySet()) {
					logger.logDebug(String.format("Parameter: %s Value: %s",
							key, parameters.get(key)));
				}
			}
			ValidationException ve = new ValidationException();
			ve.setValidationMessages(new ArrayList<ValidationMessage>());
			Integer periodicidadPagoCapital = null;
			if (parameters.containsKey("dt_periodo_cap")
					&& parameters.get("dt_periodo_cap") != null) {
				periodicidadPagoCapital = Integer.valueOf(parameters
						.get("dt_periodo_cap"));
			}
			Integer periodicidadPagoInteres = null;
			if (parameters.containsKey("dt_periodo_int")
					&& parameters.get("dt_periodo_int") != null) {
				periodicidadPagoInteres = Integer.valueOf(parameters
						.get("dt_periodo_int"));
			}
			String unidadTiempo = parameters.containsKey("dt_tplazo") ? parameters
					.get("dt_tplazo") : null;
			String tipoCuota = parameters.containsKey("dt_tdividendo") ? parameters
					.get("dt_tdividendo") : null;
			Integer campoPlazo = null;
			if (parameters.containsKey("dt_plazo")
					&& parameters.get("dt_plazo") != null) {
				campoPlazo = Integer.valueOf(parameters.get("dt_plazo"));
			}
			Integer periodoGraciaCapital = null;
			if (parameters.containsKey("dt_gracia_cap")
					&& parameters.get("dt_gracia_cap") != null) {
				periodoGraciaCapital = Integer.valueOf(parameters
						.get("dt_gracia_cap"));
			}
			Integer periodoGraciaInteres = null;
			if (parameters.containsKey("dt_gracia_int")
					&& parameters.get("dt_gracia_int") != null) {
				periodoGraciaInteres = Integer.valueOf(parameters
						.get("dt_gracia_int"));
			}
			Integer diasCalculoInteres = null;
			if (parameters.containsKey("dt_dias_anio")
					&& parameters.get("dt_dias_anio") != null) {
				diasCalculoInteres = Integer.valueOf(parameters
						.get("dt_dias_anio"));
			}
			Integer diasGraciaMora = null;
			if (parameters.containsKey("dt_dias_gracia")
					&& parameters.get("dt_dias_gracia") != null) {
				diasGraciaMora = Integer.valueOf(parameters
						.get("dt_dias_gracia"));
			}
			String cambioTasa = parameters.containsKey("dt_reajustable") ? parameters
					.get("dt_reajustable") : null;
			Integer periodoCambioTasa = null;
			if (parameters.containsKey("dt_periodo_reaj")
					&& parameters.get("dt_periodo_reaj") != null) {
				periodoCambioTasa = Integer.valueOf(parameters
						.get("dt_periodo_reaj"));
			}
			if (periodicidadPagoCapital != null
					&& periodicidadPagoInteres != null && unidadTiempo != null
					& tipoCuota != null) {
				// Get the factor values
				Integer vtValor = defaultOperationService
						.getFactorByDividend(unidadTiempo);
				if (vtValor == null) {
					ve.addValidationMessage(6900193,
							"No existe factor de dividendo para la unidad de tiempo ingresada");
				}
				logger.logDebug(String.format("The factor for %s is %s",
						unidadTiempo, vtValor));
				Integer vtValor1 = defaultOperationService
						.getFactorByDividend(tipoCuota);
				if (vtValor1 == null) {
					ve.addValidationMessage(6900194,
							"No existe factor de dividendo para el tipo de cuota ingresada");
				}
				logger.logDebug(String.format("The factor for %s is %s",
						tipoCuota, vtValor1));
				if (vtValor != null && vtValor1 != null && campoPlazo != null) {
					if (vtValor == 0) {
						ve.addValidationMessage(230833, "División para cero");
					}
					double vtTotal = (vtValor * campoPlazo) / vtValor1;
					int vtResto = (vtValor * campoPlazo)
							% (vtValor1 * periodicidadPagoCapital);
					int vtResto1 = (vtValor * campoPlazo)
							% (vtValor1 * periodicidadPagoInteres);
					int vtResto2 = (vtValor1 * periodicidadPagoCapital)
							% (vtValor1 * periodicidadPagoInteres);
					double vtTot = (vtValor * campoPlazo) / vtValor1
							* periodicidadPagoCapital;
					logger.logDebug(String
							.format("Result of operations: vtTotal: %f  vtResto: %d vtResto1: %d vtResto2: %d vtTot: %f",
									vtTotal, vtResto, vtResto1, vtResto2, vtTot));

					if (vtResto != 0) {
						ve.addValidationMessage(230834,
								"La Periodicidad de Pago de Capital no genera número exacto de dividendos");
					}
					if (vtResto1 != 0) {
						ve.addValidationMessage(230835,
								"La Periodicidad de Pago del Interés no genera número exacto de dividendos");
					}
					if (vtResto2 != 0) {
						ve.addValidationMessage(230832,
								"La Periodicidad de Pago del Interés debe ser submultiplo del Capital");
					}
					if (periodoGraciaCapital != null
							&& periodoGraciaCapital >= vtTot) {
						ve.addValidationMessage(
								230838,
								"La Periodicidad de Gracia de Capital no debe exceder los dividendos creados por la Periodicidad de Pago del Capital");
					}
					if (periodoGraciaInteres != null
							&& periodoGraciaInteres >= vtTot) {
						ve.addValidationMessage(
								230839,
								"La Periodicidad de Gracia de Interés no debe exceder los dividendos creados por la Periodicidad de Pago del Interés");
					}
					if (periodoCambioTasa != null && periodoCambioTasa >= vtTot) {
						ve.addValidationMessage(
								230847,
								"El Período de reajuste no puede ser mayor o igual al número de cuotas generadas");
					}
				}
			}
			if (diasCalculoInteres != null && diasGraciaMora != null
					&& diasGraciaMora > diasCalculoInteres) {
				ve.addValidationMessage(230843, String.format(
						"El periodo de gracia no puede sobrepasar los %d días",
						diasCalculoInteres));
			}
			if (cambioTasa != null && cambioTasa.equals("S")
					&& (periodoCambioTasa == null || periodoCambioTasa < 0)) {
				ve.addValidationMessage(230845,
						"El Período de Reajuste es obligatorio");
			}

			if (cambioTasa != null && cambioTasa.equals("N")
					&& periodoCambioTasa != null && (periodoCambioTasa > 0)) {
				ve.addValidationMessage(230846,
						"El Período de Reajuste no puede ser mayor a cero");
			}

			if (!ve.getValidationMessages().isEmpty()) {
				throw ve;
			}
		} catch (ValidationException ve) {
			throw ve;
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
					"saveGeneralParametersValues"));
		}
	}

	private HashMap<String, String> prepareGeneralParameters(String productId) {
		// Get the first parameters to validate
		logger.logDebug(MessageManager.getString(
				"PORTFOLIOGENERALPARAMETERMANAGER.001",
				"prepareGeneralParameters"));
		HashMap<String, String> values = new HashMap<String, String>();
		values.put("dt_periodo_cap", mappingFieldService
				.getValueByPhisicalField(productId, "dt_periodo_cap"));
		values.put("dt_periodo_int", mappingFieldService
				.getValueByPhisicalField(productId, "dt_periodo_int"));
		values.put("dt_tplazo", mappingFieldService.getValueByPhisicalField(
				productId, "dt_tplazo"));
		values.put("dt_tdividendo", mappingFieldService
				.getValueByPhisicalField(productId, "dt_tdividendo"));
		values.put("dt_plazo", mappingFieldService.getValueByPhisicalField(
				productId, "dt_plazo"));
		values.put("dt_gracia_cap", mappingFieldService
				.getValueByPhisicalField(productId, "dt_gracia_cap"));
		values.put("dt_gracia_int", mappingFieldService
				.getValueByPhisicalField(productId, "dt_gracia_int"));
		values.put("dt_dias_anio", mappingFieldService.getValueByPhisicalField(
				productId, "dt_dias_anio"));
		values.put("dt_dias_gracia", mappingFieldService
				.getValueByPhisicalField(productId, "dt_dias_gracia"));
		values.put("dt_reajustable", mappingFieldService
				.getValueByPhisicalField(productId, "dt_reajustable"));
		values.put("dt_periodo_reaj", mappingFieldService
				.getValueByPhisicalField(productId, "dt_periodo_reaj"));
		logger.logDebug(MessageManager.getString(
				"PORTFOLIOGENERALPARAMETERMANAGER.002",
				"prepareGeneralParameters"));
		return values;
	}

	/***
	 * Items readjustments
	 * 
	 * @param productId
	 */
	private void ReadjustmentItems(String productId) {
		String valueReadjustment = null;
		String valueSpecialReadjustment = null;
		String valuePeriodReadjustment = null;

		long idReadjustment = mappingFieldService
				.getIdByPhisicalField(
						productId,
						com.cobiscorp.ecobis.fpm.portfolio.service.commons.Constants.CHANGERATE);
		long idSpecialReadjustment = mappingFieldService
				.getIdByPhisicalField(
						productId,
						com.cobiscorp.ecobis.fpm.portfolio.service.commons.Constants.SPECIAL_CHANGERATE);

		long idPeriodReadjustment = mappingFieldService.getIdByPhisicalField(
				productId, "dt_periodo_reaj");

		List<GeneralParametersValues> actualValues = generalParametersManager
				.getValuesByBankingProduct(productId);

		for (GeneralParametersValues generalParametersValues : actualValues) {
			if (generalParametersValues.getDictionaryFieldId() == idReadjustment) {
				valueReadjustment = generalParametersValues.getValue();
			} else if (generalParametersValues.getDictionaryFieldId() == idSpecialReadjustment) {
				valueSpecialReadjustment = generalParametersValues.getValue();
			} else if (generalParametersValues.getDictionaryFieldId() == idPeriodReadjustment) {
				valuePeriodReadjustment = generalParametersValues.getValue();
			}
		}

		if (valueReadjustment != null) {
			if (valueReadjustment.equals(Constants.YES)) {

				itemService.updateReadjustmentForProduct(productId,
						valueReadjustment, valuePeriodReadjustment,
						valueSpecialReadjustment);

			} else if (valueReadjustment.equals(Constants.NO)) {

				itemService.updateReadjustmentForProduct(productId,
						valueReadjustment, null, null);
			} else if (valueReadjustment.equals(Constants.FLOAT_RATE)) {

				itemService.updateReadjustmentForProduct(productId,
						valueReadjustment, "0", valueSpecialReadjustment);
			}
		}
	}

	public void createGenearalParametersHistory(
			BankingProductHistory bankingProductHistorId,
			String authorizationStatus) {

		if ("A".equals(authorizationStatus)) {
			CreateDataForReport.createDataForReport(mappingFieldService,
					defaultValuesManager, bankingProductManager,
					defaultOperationService, bankingProductHistorId,
					Constants.GENERAL_PARAMETERS_DICTIONARY_REPORT, null);
		}

	}
}
