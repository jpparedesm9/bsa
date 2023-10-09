package com.cobiscorp.ecobis.fpm.portfolio.integration.service.impl;

import java.util.ArrayList;
import java.util.HashMap;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.model.FieldByProductValues;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.IPortfolioItemWarranties;
import com.cobiscorp.ecobis.fpm.portfolio.integration.service.utils.MessageManager;
import com.cobiscorp.ecobis.fpm.portfolio.service.IItemWarrantyManager;

public class PortfolioItemWarranties implements IPortfolioItemWarranties {

	private static final ILogger logger = LogFactory.getLogger(PortfolioItemWarranties.class);
	private IItemWarrantyManager iItemWarrantyManagerService;
		
	public void setiItemWarrantyManagerService(
			IItemWarrantyManager iItemWarrantyManagerService) {
		this.iItemWarrantyManagerService = iItemWarrantyManagerService;
	}

	public void insertListFieldByProductValues(ArrayList<FieldByProductValues> fieldByproductValues, String bankinProductId, String request, HashMap<String, String> map){
		
		try {			
			logger.logDebug(MessageManager.getString("PORTFOLIOITEMGUARANTIES.001", "insertListFieldByProductValues"));
			logger.logDebug(":>insertListFieldByProductValues:>:>en el metodo interceptado");
			iItemWarrantyManagerService.insertAditionalItems(fieldByproductValues, bankinProductId,request, map);
			
		}catch (BusinessException bex){
			logger.logError(MessageManager.getString("PORTFOLIOITEMGUARANTIES.003"), bex);
			throw bex;	
		} catch (Exception e) {
			logger.logError(MessageManager.getString("PORTFOLIOITEMGUARANTIES.003"), e);
			throw new BusinessException(6900001, "Existió un fallo en la operación. Comuníquese con el Administrador.");

		} finally {
			logger.logDebug(MessageManager.getString("PORTFOLIOITEMGUARANTIES.002", "insertUnitFunctionalityValues"));
		}

	}
	
}
