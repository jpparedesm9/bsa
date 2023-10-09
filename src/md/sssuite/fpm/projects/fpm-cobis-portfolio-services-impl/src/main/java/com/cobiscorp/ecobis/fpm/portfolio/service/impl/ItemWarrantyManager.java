package com.cobiscorp.ecobis.fpm.portfolio.service.impl;

import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.jdbc.utils.CobisStoredProcedureUtils;
import com.cobiscorp.cobis.jdbc.CobisDataException;
import com.cobiscorp.cobis.jdbc.CobisStoredProcedure;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.model.DictionaryField;
import com.cobiscorp.ecobis.fpm.model.FieldByProductValues;
import com.cobiscorp.ecobis.fpm.portfolio.service.IItemWarrantyManager;
import com.cobiscorp.ecobis.fpm.portfolio.utils.MessageManager;

public class ItemWarrantyManager implements IItemWarrantyManager{

	
	/** COBIS Logger */
	private final ILogger logger = LogFactory
			.getLogger(ItemWarrantyManager.class);

	private static final String DATABASE_NAME = "SYBCTS";
	
	private CobisStoredProcedureUtils storedProcedureUtils;

	/** Entity Manager injected by the container */
	@PersistenceContext(unitName = "JpaFpmPortfolio")
	private EntityManager entityManager;

	
	public void setStoredProcedureUtils(
			CobisStoredProcedureUtils storedProcedureUtils) {
		this.storedProcedureUtils = storedProcedureUtils;
	}
	
	public void insertAditionalItems(
			ArrayList<FieldByProductValues> fieldByproductValues,
			String bankinProductId, String request, HashMap<String, String> map) {		
		if(logger.isDebugEnabled()){
			logger.logDebug("--> insertAditionalItems");
		}
try {
			
			logger.logDebug(MessageManager.getString(
					"ITEMGUARANTIESMANAGER.001", "insertAditionalItems"));
			//si existen datos adicionales
			if(fieldByproductValues.size()>0){			
				CobisStoredProcedure storedProcedure = this.storedProcedureUtils
						.getStoredProcedureInstance();
				storedProcedure.setDatabase("cob_custodia");
				storedProcedure.setName("sp_items_new");
				storedProcedure.setSkipUndeclaredResults(true);
	
				this.storedProcedureUtils.setContextParameters(DATABASE_NAME,storedProcedure);
				// Add business parameters
				
				storedProcedure.addInParam("@t_trn", Types.SMALLINT, 19750);
				storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "I");		
				storedProcedure.addInParam("@i_modo", Types.SMALLINT, 0);
				if(map.get("isNew").equals("N")){
					storedProcedure.addInParam("@t_trn", Types.SMALLINT, 19751);
					storedProcedure.addInParam("@i_operacion", Types.VARCHAR, "U");							
				}
							
				storedProcedure.addInParam("@i_filial", Types.INTEGER,map.get("filial"));
				storedProcedure.addInParam("@i_sucursal", Types.SMALLINT,map.get("sucursal"));
				storedProcedure.addInParam("@i_tipo_cust", Types.VARCHAR, map.get("tipoCust"));//tipo de garantia
				storedProcedure.addInParam("@i_custodia", Types.INTEGER,Integer.parseInt(map.get("codId")));//codigo de garantia -> cod
				
				storedProcedure.addInParam("@i_secuencial", Types.SMALLINT,3); //no se utiliza para CPN
				storedProcedure.addInParam("@i_items", Types.INTEGER,fieldByproductValues.size());
				int cont=0;
				for (FieldByProductValues fieldByProductValuesEnt : fieldByproductValues) {
					cont++;		
					if(logger.isDebugEnabled())
						logger.logDebug(":>Contador:>"+cont);
					storedProcedure.addInParam("@i_nombre"+cont, Types.VARCHAR, fieldByProductValuesEnt.getDictionaryField().getName());					
					storedProcedure.addInParam("@i_valor_item"+cont, Types.VARCHAR, fieldByProductValuesEnt.getValue());				
					if(logger.isDebugEnabled())
						logger.logDebug(":>@i_nombre:>"+fieldByProductValuesEnt.getDictionaryField().getName()+":>@i_valor_item:>"+fieldByProductValuesEnt.getValue());
					
				}			
				
				storedProcedure.execute();
			}
		} catch (CobisDataException de) {
			logger.logError(MessageManager.getString(
					"ITEMGUARANTIESMANAGER.003", fieldByproductValues), de);
			throw new BusinessException(de.getSQLErrorCode(), de
					.getSQLException().getMessage());

		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"ITEMGUARANTIESMANAGER.003", fieldByproductValues), ex);
			throw new BusinessException(6900044,
					"No se pudo crear el perfil contable deseado.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"ITEMGUARANTIESMANAGER.002", "insertAditionalItems"));
		}
	}	
}
