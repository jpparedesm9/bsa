package com.cobiscorp.ecobis.fpm.operation.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityExistsException;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.bo.DictionaryGroupLog;
import com.cobiscorp.ecobis.fpm.catalogs.service.ICatalogManager;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.DicFunctionalityGroup;
import com.cobiscorp.ecobis.fpm.model.DictionaryField;
import com.cobiscorp.ecobis.fpm.model.FieldValue;
import com.cobiscorp.ecobis.fpm.model.UnitFunctionalityValues;
import com.cobiscorp.ecobis.fpm.model.UnitFunctionalityValuesHistory;
import com.cobiscorp.ecobis.fpm.model.UnitFuntionalValuesId;
import com.cobiscorp.ecobis.fpm.operation.service.IUnitFunctionalityValues;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;
import com.cobiscorp.ecobis.fpm.service.utils.CatalogUtils;
import com.cobiscorp.ecobis.fpm.service.utils.MessageManager;

public class UnitFunctionalityValuesManager implements IUnitFunctionalityValues {

	public final ILogger logger = LogFactory
			.getLogger(UnitFunctionalityValuesManager.class);

	/** Catalog service */
	private ICatalogManager catalogManager;

	private EntityManager entityManager;

	/**
	 * Initialize the Entity Manager.
	 * 
	 * @param entityManager
	 *            Entity Manager
	 */
	@PersistenceContext(unitName = "JpaFpmAdministration")
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	public void setCatalogManager(ICatalogManager catalogManager) {
		this.catalogManager = catalogManager;
	}

	/**
	 * Sets the general parameters manager.
	 * 
	 * @param gPManager
	 *            the new general parameters manager
	 */
	@Override
	public List<UnitFunctionalityValues> getUnitFunctionalityValuesByProductAndDictionary(
			String bankingProductId, String dictinaryName) {
		List<UnitFunctionalityValues> responseUnitFuntionalities = new ArrayList<UnitFunctionalityValues>();
		try {
			logger.logDebug(MessageManager.getString(
					"UNITFUNCTIONALITYMANAGER.001",
					"getUnitFunctionalityValuesByProductAndDictionary"));

			List<UnitFunctionalityValues> unitFuntionalities = entityManager
					.createNamedQuery(
							"UnitFunctionalityValues.findAllByProductAndDictionary",
							UnitFunctionalityValues.class)
					.setParameter("productId", bankingProductId)
					.setParameter("dictionaryName", dictinaryName)
					.getResultList();

					return unitFuntionalities;
		} catch (NoResultException nre) {
			logger.logDebug("La consulta no devolvio resultados");
			return responseUnitFuntionalities;

		} finally {
			logger.logDebug(MessageManager.getString(
					"UNITFUNCTIONALITYMANAGER.002",
					"getUnitFunctionalityValuesByProductAndDictionary"));
		}
	}

	@Override
	public UnitFunctionalityValues getUnitFunctionalityValuesById(
			Long registryId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Long insertUnitFunctionalityValues(String productId,
			ArrayList<UnitFunctionalityValues> values, String dictionaryName) {
		try {
			logger.logDebug(MessageManager.getString(
					"UNITFUNCTIONALITYMANAGER.001",
					"insertUnitFunctionalityValues"));
			BankingProduct bp = entityManager.find(BankingProduct.class,
					productId);
			if (bp == null) {
				logger.logError(MessageManager.getString(
						"BANKINGPRODUCTMANAGER.007", productId));
				throw new BusinessException(
						6900060,
						"No se pudo realizar la b�squeda del producto Bancario seleccionado requerido. No Existe");
			}
			Long idRegistry = countMaxRegistryUnitFunctionality() + 1L;
			logger.logDebug("idRegistry--->" + idRegistry);
			for (UnitFunctionalityValues unitFunctionalityValues : values) {
				unitFunctionalityValues.setBankingProduct(bp);
				DictionaryField df = entityManager.find(DictionaryField.class,
						unitFunctionalityValues.getDictionaryFieldId());
				if (df == null) {
					logger.logError(MessageManager.getString(
							"DICTIONARYMANAGER.007",
							unitFunctionalityValues.getDictionaryFieldId()));
					throw new BusinessException(6900010,
							"No se pudo obtener el diccionario indicado, puesto que no existe.");
				}
				unitFunctionalityValues.setRegistryId(idRegistry);
				unitFunctionalityValues.setDictionaryField(df);
				unitFunctionalityValues.setProductId(bp.getId());
				unitFunctionalityValues.setDictionaryFieldId(df.getId());
				
				
				entityManager.persist(unitFunctionalityValues);
			}
			entityManager.flush();

			return idRegistry;

		} catch (EntityExistsException eee) {
			logger.logError(
					MessageManager.getString("ITEMSMANAGER.008", values), eee);
			throw new BusinessException(
					6900193,
					"No se pudo insertar la información correspondiente a la pantalla del producto indicado, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"UNITFUNCTIONALITYMANAGER.003", values), ex);
			throw new BusinessException(
					6900193,
					"No se pudo insertar la información correspondiente a la pantalla del producto indicado");
		} finally {
			logger.logDebug(MessageManager.getString(
					"UNITFUNCTIONALITYMANAGER.002",
					"insertUnitFunctionalityValues"));
		}
	}

	@Override
	public void updateUnitFuntionalityValues(String productId,
			ArrayList<UnitFunctionalityValues> values, String dictionaryName) {
		try {
			logger.logDebug(MessageManager.getString(
					"UNITFUNCTIONALITYMANAGER.001",
					"updateUnitFuntionalityValues"));
			for (UnitFunctionalityValues unitFunctionalityValues : values) {

				UnitFuntionalValuesId unitId = new UnitFuntionalValuesId(
						unitFunctionalityValues.getRegistryId(),
						unitFunctionalityValues.getDictionaryFieldId(),
						unitFunctionalityValues.getProductId());
				logger.logDebug("Seteamos valores en UnitFuntionalValuesId--->"
						+ unitId);
				entityManager.merge(unitFunctionalityValues);
			}
			entityManager.flush();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"UNITFUNCTIONALITYMANAGER.003", values), ex);
			throw new BusinessException(
					6900193,
					"No se pudo actualizar la información correspondiente a la pantalla del producto indicado");
		} finally {
			logger.logDebug(MessageManager.getString(
					"UNITFUNCTIONALITYMANAGER.002",
					"updateUnitFuntionalityValues"));
		}

	}

	@Override
	public void deleteUnitFunctionalityValues(Long registryId) {
		try {
			logger.logDebug(MessageManager.getString(
					"UNITFUNCTIONALITYMANAGER.001",
					"deleteUnitFunctionalityValues"));
			List<UnitFunctionalityValues> unitFunctionalityValues = entityManager
					.createNamedQuery(
							"UnitFunctionalityValues.findUnitByRegistryId",
							UnitFunctionalityValues.class)
					.setParameter("registryId", registryId).getResultList();
			logger.logDebug("unitFunctionalityValues-->"
					+ unitFunctionalityValues.size());
			logger.logDebug("unitFunctionalityValues-->"
					+ unitFunctionalityValues.toString());
			for (UnitFunctionalityValues unitFunctionality : unitFunctionalityValues) {
				entityManager.remove(unitFunctionality);
			}
			entityManager.flush();

		} catch (NoResultException nre) {
			logger.logDebug("La consulta no devolvio resultados con el Id: "
					+ registryId);

		} finally {
			logger.logDebug(MessageManager.getString(
					"UNITFUNCTIONALITYMANAGER.002",
					"deleteUnitFunctionalityValues"));
		}

	}

	@Override
	public Long managerUnitFunctionaltyValues() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Long countMaxRegistryUnitFunctionality() {
		try {
			logger.logDebug(MessageManager.getString(
					"UNITFUNCTIONALITYMANAGER.001",
					"countMaxRegistryUnitFunctionality"));

			Number maxRegistry = entityManager.createNamedQuery(
					"UnitFunctionalityValues.CountRegistry", Number.class)
					.getSingleResult();
			logger.logDebug("Number-->" + maxRegistry);
			if (maxRegistry != null) {
				return maxRegistry.longValue();
			} else {
				return 0L;
			}
		} catch (NonUniqueResultException nur) {
			logger.logError(
					MessageManager.getString("UNITFUNCTIONALITYMANAGER.006"),
					nur);
			throw new BusinessException(
					6900194,
					"No se pudo realizar la búsqueda del máximo id para los campos de pantallas renderizadas");
		} catch (NoResultException nre) {
			logger.logDebug("La consulta no devolvio resultados retorna 0");
			return 0L;
		} finally {
			logger.logDebug(MessageManager.getString(
					"UNITFUNCTIONALITYMANAGER.002",
					"countMaxRegistryUnitFunctionality"));
		}
	}

	
	@Override
	public List<UnitFunctionalityValues> getAllFunctionlityValuesByProduct(String productId){
		try {
			logger.logDebug(MessageManager.getString(
					"UNITFUNCTIONALITYMANAGER.001",
					"getAllFunctionlityValuesByProduct"));
			return entityManager
					.createNamedQuery(
							"UnitFunctionalityValues.findAllByProduct",
							UnitFunctionalityValues.class)
					.setParameter("productId", productId).getResultList();
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"UNITFUNCTIONALITYMANAGER.004", productId), ex);
			//TODO: Error CODE
			throw new BusinessException(
					6900071,
					"No se pudo obtener los valores para las pantallas renderizadas del producto bancario seleccionado");
		} finally {
			logger.logDebug(MessageManager.getString(
					"UNITFUNCTIONALITYMANAGER.002",
					"getAllFunctionlityValuesByProduct"));
		}

	}
	
	@Override
	public void createUnitFunctionalityValuesHistory(String productId, 
			String authorizationStatus,long bankingProductHistoryId) {

		UnitFunctionalityValuesHistory history = null;
		try {
			logger.logDebug(MessageManager.getString(
					"UNITFUNCTIONALITYMANAGER.001", "createUnitFunctionalityValuesHistory"));			

			List<UnitFunctionalityValues> ufValues = getAllFunctionlityValuesByProduct(productId);
			
			
			for (UnitFunctionalityValues gpValue : ufValues) {
				history = new UnitFunctionalityValuesHistory(
						gpValue);
				history.getBankingProductHistory().setId(bankingProductHistoryId);
				history.setProcessDate(new SimpleDateFormat(
						Constants.PROCESS_DATE_FORMAT).parse(ContextManager
						.getContext().getProcessDate()));
				entityManager.persist(history);
			}
		} catch (EntityExistsException eee) {
			logger.logError(MessageManager.getString(
					"UNITFUNCTIONALITYMANAGER.003", history+" bankingProductHistoryId:"+bankingProductHistoryId),
					eee);
			throw new BusinessException(6900195,
					"No se pudo guardar el histórico de pantallas renderizadas, puesto que ya existe");
		} catch (Exception ex) {
			logger.logError(MessageManager.getString(
					"UNITFUNCTIONALITYMANAGER.003", history+" BankingProductHistory:"+bankingProductHistoryId),
					ex);
			throw new BusinessException(6900196,
					"No se pudo guardar el histórico de pantallas renderizadas");
		} finally {
			logger.logDebug(MessageManager.getString(
					"UNITFUNCTIONALITYMANAGER.002", "createUnitFunctionalityValuesHistory"));
		}

		
		
	}
//Cada DictionaryGroupLog tiene una lista de los unitfunctionalityvalues correspondientes al mismo
	public List<DictionaryGroupLog> getUnitFunctionalityValuesHistoricalLog(
			Long bankingProductHistoryId) {
		try {
			//TODO: Cambiar log
			logger.logDebug(MessageManager.getString(
					"UNITFUNCTIONALITYMANAGER.001",
					"getUnitFunctionalityValuesHistoricalLog"));
			

			BankingProductHistory bph = entityManager.find(BankingProductHistory.class,
					bankingProductHistoryId);

			logger.logDebug(">>getUnitFunctionalityValuesHistoricalLog bph:"+bph);
			if (null == bph) {
				throw new BusinessException(6900197,
						"No se encontró ningún histórico del producto con la fecha indicada.");
			}
			
			//consultar todos los historicos por productos
			List<UnitFunctionalityValuesHistory> ufValues=getFunctionalityValuesByProduct(bph);
			logger.logDebug(">>>>Encuentra UnitFunctionalityValuesHistory: "+ufValues.size());
			
			//construir la lista de DictionaryLog
			return createDictionaryGroupLogs(ufValues);
			
		} catch (BusinessException be) {
			throw be;
		} catch (Exception ex) {
			logger.logError(
					MessageManager.getString("UNITFUNCTIONALITYMANAGER.003"),
					ex);
			throw new BusinessException(
					6900198,
					"Ocurrió un error al obtener la información del histórico para pantallas renderizadas.");
		} finally {
			logger.logDebug(MessageManager.getString(
					"GENERALPARAMETERvSMANAGER.002",
					"getUnitFunctionalityValuesHistoricalLog"));
		}
	}
	
	public List<UnitFunctionalityValuesHistory> getFunctionalityValuesByProduct(BankingProductHistory bph){
		//query find
		logger.logDebug(">>>>getFunctionalityValuesByProduct>> productId:"+bph.getProductId()+" >>id:"+bph.getId());
		Query query=entityManager.createNamedQuery(
				"UnitFunctionalityValuesHistory.FindByProductAndBankingProductHistory",
				UnitFunctionalityValuesHistory.class);
		
		query.setParameter("productId", bph.getProductId());
		query.setParameter("id", bph.getId());
		return query.getResultList();
	}
	
	private List<DictionaryGroupLog> createDictionaryGroupLogs(List<UnitFunctionalityValuesHistory> ufValuesHistory){
		List<DictionaryGroupLog> dictionaryList=new ArrayList<DictionaryGroupLog>();
		for(UnitFunctionalityValuesHistory ufValueHistory:ufValuesHistory){
			addToDictionaryGroupLog(dictionaryList, ufValueHistory);
		}
		logger.logDebug("crea y retorna>>>"+dictionaryList.size());
		return dictionaryList;
	}
	
	private void addToDictionaryGroupLog(List<DictionaryGroupLog> dictionaryList, UnitFunctionalityValuesHistory  ufValueHistory){
		logger.logDebug("addToDictionaryGroupLog "+ufValueHistory);
		DictionaryGroupLog dictionaryGroupLogBuscado=null;
		DicFunctionalityGroup dicFunctionalityGroup=ufValueHistory.getDictionaryField().getDicFunctionalityGroup();
		for(DictionaryGroupLog dictionaryGroupLog:dictionaryList){
			if(dictionaryGroupLog.getDictionaryGroupId()==dicFunctionalityGroup.getId()){
				dictionaryGroupLogBuscado=dictionaryGroupLog;
			}
		}
		//si no existe en la lista
		if(dictionaryGroupLogBuscado==null){
			dictionaryGroupLogBuscado=new DictionaryGroupLog(dicFunctionalityGroup.getName(),(int)dicFunctionalityGroup.getId());
			dictionaryList.add(dictionaryGroupLogBuscado);
		}
		dictionaryGroupLogBuscado.addUnitFunctionalityValueLog(ufValueHistory.getDictionaryField().getName(), ufValueHistory.getValue(),dicFunctionalityGroup.getId(),ufValueHistory.getDescription(),ufValueHistory.getRegistryId());
		//agrega a la lista
		
	}
	

}
