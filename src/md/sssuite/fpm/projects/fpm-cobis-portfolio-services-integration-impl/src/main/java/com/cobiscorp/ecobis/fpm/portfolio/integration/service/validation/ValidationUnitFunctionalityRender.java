package com.cobiscorp.ecobis.fpm.portfolio.integration.service.validation;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.model.UnitFunctionalityValues;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.utils.MessageManager;

public class ValidationUnitFunctionalityRender {

	// region Field's
	/** COBIS Logger */
	private static final ILogger logger = LogFactory.getLogger(ValidationUnitFunctionalityRender.class);

	
	public void validateInsertValues(String bankingProductId, ArrayList<UnitFunctionalityValues> values, String dictionaryName, List<UnitFunctionalityValues> valuesBeforeList) {

		try {
			if(logger.isDebugEnabled()){
				logger.logDebug(MessageManager.getString("PORTFOLIOUNITFUNCTIONALITYVALUESMANAGER.001", "validateInsertValues"));
				logger.logDebug("---> Lista renderizada: " + values);
				logger.logDebug("dictionaryName --> "+ dictionaryName);
			}
			
			Boolean validator = false;
			int countDuplicate = 0;
			List<String> idDuplicate = new ArrayList();
			ArrayList<UnitFunctionalityValues> valuesBefore = new ArrayList(valuesBeforeList);

			for (UnitFunctionalityValues renderValue : values) {
				for (UnitFunctionalityValues initialValue : valuesBefore) {
					if (renderValue.getDictionaryFieldId() == initialValue.getDictionaryFieldId()
							&& renderValue.getProductId().equals(initialValue.getProductId())
							&& renderValue.getValue().equals(initialValue.getValue())) {
						if(logger.isDebugEnabled()){
							logger.logDebug("-->Impresion: " + renderValue + " -- " + initialValue);
						}
						idDuplicate.add(String.valueOf(initialValue.getRegistryId()));
					}
				}
			}
			
			if(logger.isDebugEnabled()){
				logger.logDebug("-->Lista Id repetidos: " + idDuplicate);
			}
			
			for(int i = 0; i < idDuplicate.size() ; i++){
				for(int j = i+1; j < idDuplicate.size() ; j++){
					if(idDuplicate.get(i).equals(idDuplicate.get(j))){
						countDuplicate+= 1;
					}
				}
			}
			if (countDuplicate != 0) {
				validator = true;
			}

			if (validator) {
				throw new BusinessException(6900194, "Existió un error a nivel de validación de los datos.");
			}
		}catch (BusinessException bex){
			throw bex;
		} catch (Exception e) {
			logger.logError(MessageManager.getString("PORTFOLIOUNITFUNCTIONALITYVALUESMANAGER.003"), e);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");

		} finally {
			logger.logDebug(MessageManager.getString("PORTFOLIOUNITFUNCTIONALITYVALUESMANAGER.002", "validateInsertValues"));
		}

	}

	
	public void validateUpdateValues(String bankingProductId, ArrayList<UnitFunctionalityValues> values, String dictionaryName, List<UnitFunctionalityValues> valuesBeforeList) {

		try {
			if(logger.isDebugEnabled())
			{
				logger.logDebug(MessageManager.getString("PORTFOLIOUNITFUNCTIONALITYVALUESMANAGER.001", "validateUpdateValues"));
				logger.logDebug("---> Lista renderizada: " + values);
			}
			
			Boolean validator = false;
			int countDuplicate = 0;
			List<String> idDuplicate = new ArrayList();
			ArrayList<UnitFunctionalityValues> valuesBefore = new ArrayList(valuesBeforeList);

			for (UnitFunctionalityValues renderValue : values) {
				for (UnitFunctionalityValues initialValue : valuesBefore) {
					if (renderValue.getDictionaryFieldId() == initialValue.getDictionaryFieldId()
							&& renderValue.getProductId().equals(initialValue.getProductId())
							&& renderValue.getValue().equals(initialValue.getValue())) {
						if(renderValue.getRegistryId() != initialValue.getRegistryId()){
							if(logger.isDebugEnabled()){
								logger.logDebug("-->Impresion: " + renderValue + " -- " + initialValue);
							}
							idDuplicate.add(String.valueOf(initialValue.getRegistryId()));
						}
					}
				}
			}
			if(logger.isDebugEnabled()){
				logger.logDebug("-->Lista Id repetidos: " + idDuplicate);
			}
			
			for(int i = 0; i < idDuplicate.size() ; i++){
				for(int j = i+1; j < idDuplicate.size() ; j++){
					if(idDuplicate.get(i).equals(idDuplicate.get(j))){
						countDuplicate+= 1;
					}
				}
			}
			if (countDuplicate != 0) {
				validator = true;
			}
			if (validator) {
				throw new BusinessException(6900194, "Existió un error a nivel de validación de los datos.");
			}
		}catch (BusinessException bex){
			throw bex;
		} catch (Exception e) {
			logger.logError(MessageManager.getString("PORTFOLIOUNITFUNCTIONALITYVALUESMANAGER.003"), e);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");

		} finally {
			logger.logDebug(MessageManager.getString("PORTFOLIOUNITFUNCTIONALITYVALUESMANAGER.002", "validateUpdateValues"));
		}
	}



}
