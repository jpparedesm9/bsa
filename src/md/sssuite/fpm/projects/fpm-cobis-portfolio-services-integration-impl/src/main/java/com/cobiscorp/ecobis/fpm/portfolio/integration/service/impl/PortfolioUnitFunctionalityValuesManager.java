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
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.text.StyledEditorKit.BoldAction;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.bo.PhysicalField;
import com.cobiscorp.cobisv.commons.exceptions.ValidationException;
import com.cobiscorp.cobisv.commons.exceptions.ValidationMessage;
import com.cobiscorp.ecobis.fpm.interceptors.service.IDefaultValuesManager;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.CoreTable;
import com.cobiscorp.ecobis.fpm.model.UnitFunctionalityValues;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.operation.service.IGeneralParametersManager;
import com.cobiscorp.ecobis.fpm.operation.service.IItemsManager;
import com.cobiscorp.ecobis.fpm.operation.service.IMappingFieldManager;
import com.cobiscorp.ecobis.fpm.operation.service.IUnitFunctionalityValues;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.IPortfolioUnitFunctionalityValuesManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.commons.ConstantsValidation;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.utils.MessageManager;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.validation.ValidationUnitFunctionalityRender;
import com.cobiscorp.ecobis.fpm.portfolio.service.IDefaultOperationManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;

/**
 * Implementation for the integration services in unit functionality
 * 
 * @author mcabay
 * 
 */
public class PortfolioUnitFunctionalityValuesManager implements IPortfolioUnitFunctionalityValuesManager {

	// region Field's
	/** COBIS Logger */
	private static final ILogger logger = LogFactory.getLogger(PortfolioUnitFunctionalityValuesManager.class);

	/** IMappingFieldManager Service */
	private IMappingFieldManager mappingFieldService;
	/** IDefaultOperationManager Service */
	private IDefaultOperationManager defaultOperationService;
	/** IDefaultValuesManager Service */
	private IDefaultValuesManager defaultValuesManager;
	/** IUnitFunctionalityValues Service */
	private IUnitFunctionalityValues unitFunctionalityServices;

	// end-region

	// region Properties
	public void setMappingFieldService(IMappingFieldManager mappingFieldService) {
		this.mappingFieldService = mappingFieldService;
	}

	public void setDefaultOperationService(IDefaultOperationManager defaultOperationService) {
		this.defaultOperationService = defaultOperationService;
	}

	public void setDefaultValuesManager(IDefaultValuesManager defaultValuesManager) {
		this.defaultValuesManager = defaultValuesManager;
	}

	// end-region

	// region Implements

	public void setUnitFunctionalityServices(IUnitFunctionalityValues unitFunctionalityServices) {
		this.unitFunctionalityServices = unitFunctionalityServices;
	}

	@Override
	public void createUnitFunctionalityValuesHistory(String productId, String autorization) {
		try {
			logger.logDebug(MessageManager.getString("PORTFOLIOUNITFUNCTIONALITYVALUESMANAGER.001", "createUnitFunctionalityValuesHistory"));
			// Contains the metadata and information necessary to construct the
			// dynamic inserts
			HashMap<CoreTable, List> coreTableInformation = new HashMap<CoreTable, List>();
			// Colums name list and field identifier
			// List<CoreTable> coreTableList = null;

			Date systemDate = null; // para unidades funcionales no se necesita la fecha.

			// Get information corresponding column data and idetifier
			// fields
			logger.logDebug("Antes del coretable");
			Map<String, List<CoreTable>> coreTableList = mappingFieldService.getUnitFunctionalityValuesMapping(productId, Constants.RENDER_SCREEN);
			logger.logDebug("-->coreTableList: " + coreTableList);
			logger.logDebug("-->coreTableList.keySet(): " + coreTableList.keySet());
			
			
			HashMap<String, PhysicalField> gpMapping = new HashMap<String, PhysicalField>();
			Map<CoreTable, Map<String, PhysicalField>> deleteCoreTableInformation = new HashMap<CoreTable, Map<String, PhysicalField>>();
			int ejecutarBorrado=0;
			for (String registry : coreTableList.keySet()) {
				gpMapping.clear();
				logger.logDebug("-->registry: " + registry);
				List<Map> rowFields = new ArrayList<Map>();
				
				for (Object coreTable : coreTableList.get(registry)) {
					deleteCoreTableInformation.clear();
					CoreTable tables = (CoreTable) coreTable;
					//List<getRequiredFieldsByTable> requiredField = mappingFieldService.get
					logger.logDebug("tables.getPhysicalFields()--->" + tables.getPhysicalFields());
					for (PhysicalField physicalField : tables.getPhysicalFields()) {
						if (logger.isDebugEnabled())
							logger.logDebug("PhysicalField name: " + physicalField.getPhysicalFieldName() + "PhysicalField value: "
									+ physicalField.getValue());

						gpMapping.put(physicalField.getPhysicalFieldName(), physicalField);
					}
					rowFields.clear();
					rowFields.add(gpMapping);
					coreTableInformation.clear();
					deleteCoreTableInformation.put(tables, gpMapping);
					coreTableInformation.put(tables, rowFields);
					
				}
				logger.logDebug("-->coreTableInformation: " + coreTableInformation);
				logger.logDebug("-->deleteCoreTableInformation: " + deleteCoreTableInformation);
				//para que mande a borrar una sola vez y luego inserte en cada iteracion
				if(ejecutarBorrado==0){
					logger.logDebug("Borra una sola vez");
				defaultOperationService.deleteDynamicCredit(deleteCoreTableInformation);
					ejecutarBorrado++;
				}
				defaultOperationService.insertDynamicCreditOperationGeneralParameters(coreTableInformation);
			}
			logger.logDebug("Luego del coretable");

			// Map<String, String> defaultValues = defaultValuesManager.getDefaultValues();

		} catch (Exception e) {
			logger.logError(MessageManager.getString("PORTFOLIOUNITFUNCTIONALITYVALUESMANAGER.003"), e);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");

		} finally {
			logger.logDebug(MessageManager.getString("PORTFOLIOUNITFUNCTIONALITYVALUESMANAGER.002", "createUnitFunctionalityValuesHistory"));
		}
	
	}

	@Override
	public void insertUnitFunctionalityValues(String bankingProductId, ArrayList<UnitFunctionalityValues> values, String dictionaryName) {

		try {
			
			if(ConstantsValidation.VALIDATION_RENDER.equals(dictionaryName)){
				
			List<UnitFunctionalityValues> valuesBeforeList = unitFunctionalityServices.getUnitFunctionalityValuesByProductAndDictionary(
					bankingProductId, dictionaryName);

				ValidationUnitFunctionalityRender functionalityRender = new ValidationUnitFunctionalityRender();
				functionalityRender.validateInsertValues(bankingProductId, values, dictionaryName, valuesBeforeList);				
				
			}
			
		}catch (BusinessException bex){
			logger.logError(MessageManager.getString("PORTFOLIOUNITFUNCTIONALITYVALUESMANAGER.003"), bex);
			throw bex;	
		} catch (Exception e) {
			logger.logError(MessageManager.getString("PORTFOLIOUNITFUNCTIONALITYVALUESMANAGER.003"), e);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");

		} finally {
			logger.logDebug(MessageManager.getString("PORTFOLIOUNITFUNCTIONALITYVALUESMANAGER.002", "insertUnitFunctionalityValues"));
		}

	}

	@Override
	public void updateUnitFuntionalityValues(String bankingProductId, ArrayList<UnitFunctionalityValues> values, String dictionaryName) {

		try {
			
			if(ConstantsValidation.VALIDATION_RENDER.equals(dictionaryName)){
			List<UnitFunctionalityValues> valuesBeforeList = unitFunctionalityServices.getUnitFunctionalityValuesByProductAndDictionary(
					bankingProductId, dictionaryName);
				ValidationUnitFunctionalityRender functionalityRender = new ValidationUnitFunctionalityRender();
				functionalityRender.validateUpdateValues(bankingProductId, values, dictionaryName, valuesBeforeList);
			}
			
		}catch (BusinessException bex){
			logger.logError(MessageManager.getString("PORTFOLIOUNITFUNCTIONALITYVALUESMANAGER.003"), bex);
			throw bex;
		} catch (Exception e) {
			logger.logError(MessageManager.getString("PORTFOLIOUNITFUNCTIONALITYVALUESMANAGER.003"), e);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");

		} finally {
			logger.logDebug(MessageManager.getString("PORTFOLIOUNITFUNCTIONALITYVALUESMANAGER.002", "updateUnitFuntionalityValues"));
		}

	}
}
