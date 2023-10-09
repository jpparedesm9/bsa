package com.cobiscorp.ecobis.collateral.services;

import java.util.HashMap;

import cobiscorp.ecobis.collateral.dto.CustodyItemData;
import cobiscorp.ecobis.collateral.dto.CustodyItemInformation;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.collateral.constants.RequestName;
import com.cobiscorp.ecobis.collateral.constants.ReturnName;
import com.cobiscorp.ecobis.collateral.constants.ServiceId;
import com.cobiscorp.ecobis.collateral.dto.GridColumn;
import com.cobiscorp.ecobis.collateral.utils.Utilities;

public class CollateralService extends ServiceBase {
	private ILogger LOGGER = LogFactory.getLogger(CollateralService.class);

	// private ICacheManager cacheManager;
	private static final String CACHE_KEY = "CollateralCache";
	private static final int GETALLCUSTODYITEM_SERVICE_ID_TRN = 19056;

	public HashMap<Integer, HashMap<String, String>> getCollateralDataSource(Integer collateralId, Integer branchOffice, String collateralType,
			ICTSServiceIntegration serviceIntegration) throws BusinessException {

		CustodyItemInformation custodyItemInformation = new CustodyItemInformation();
		custodyItemInformation.setMode(0);
		custodyItemInformation.setCustody(collateralId);
		custodyItemInformation.setCustodyType(collateralType);
		custodyItemInformation.setBranchOffice(branchOffice);
		custodyItemInformation.setSubsidiary(1);
		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		serviceRequest.addValue(RequestName.INCUSTODYITEMINFORMATION, custodyItemInformation);

		ServiceResponse serviceResponse = execute(serviceIntegration, LOGGER, ServiceId.GETSEARCHCUTODYITEM_SERVICE_ID, serviceRequest);
		if (serviceResponse != null && serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTO != null) {
				CustodyItemData[] custodyItemsData = (CustodyItemData[]) serviceResponseTO.getValue(ReturnName.RETURNCUSTODYITEMDATA);

				GridColumn[] columns = getColumns(collateralType, serviceIntegration);
				if (columns != null) {
					HashMap<Integer, HashMap<String, String>> gridData = new HashMap<Integer, HashMap<String, String>>();
					HashMap<String, String> objects = new HashMap<String, String>();
					int count = 0, rowId = 0;
					for (CustodyItemData custodyItemData : custodyItemsData) {

						for (GridColumn column : columns) {
							if (column.getTitle().equals(custodyItemData.getName())) {
								objects.put(column.getField(), custodyItemData.getDescription());
							}

						}
						count++;
						if (count == columns.length) {
							objects.put("sequential", String.valueOf(custodyItemData.getSequential()));
							gridData.put(rowId, objects);
							objects = new HashMap<String, String>();
							count = 0;
							rowId++;

						}

					}
					return gridData;
				}
			}
		} else {
			throw new BusinessException(19000, "Error al obtener la informaci�n espec�fica de la Garant�a.");
		}
		return null;
	}

	public GridColumn[] getColumns(String collateralType, ICTSServiceIntegration serviceIntegration) throws BusinessException {

		LOGGER.logDebug("Start getColumns");
		String wCacheCollateralKeyMapping = GETALLCUSTODYITEM_SERVICE_ID_TRN + "-" + collateralType;
		// ICache cache = cacheManager.getCache(CACHE_KEY);

		// if (cache.get(wCacheCollateralKeyMapping) == null) {
		GridColumn[] columns = null;
		CustodyItemInformation custodyItemInformation = new CustodyItemInformation();
		custodyItemInformation.setMode(0);
		custodyItemInformation.setCustodyType(collateralType);

		ServiceRequestTO serviceRequest = new ServiceRequestTO();
		serviceRequest.addValue(RequestName.INCUSTODYITEMINFORMATION, custodyItemInformation);

		ServiceResponse serviceResponse = this.execute(serviceIntegration, LOGGER, ServiceId.GETALLCUSTODYITEM_SERVICE_ID, serviceRequest);

		if (serviceResponse != null && serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTO != null) {
				CustodyItemData[] custodyItemsData = (CustodyItemData[]) serviceResponseTO.getValue(ReturnName.RETURNCUSTODYITEMDATA);
				LOGGER.logDebug("columns length -->" + custodyItemsData.length);
				columns = new GridColumn[custodyItemsData.length];
				for (int i = 0; i < custodyItemsData.length; i++) {
					boolean isMandatory = "N".equals(custodyItemsData[i].getMandatory()) || custodyItemsData[i].getMandatory() == null ? false : true;
					String name = custodyItemsData[i].getName();
					String style = "", format = "";

					name = Utilities.replace(name);

					if (custodyItemsData[i].getType() != null) {
						switch (custodyItemsData[i].getType().charValue()) {
						case 'N':
							style = "text-align: right";
							break;

						case 'D':
							style = "text-align: right";
							break;
						}
					}

					GridColumn column = new GridColumn(name, custodyItemsData[i].getName(), name, isMandatory, custodyItemsData[i].getItem(), custodyItemsData[i].getType(),
							"100px", style, format);
					columns[i] = column;
				}

				// cache.put(wCacheCollateralKeyMapping, columns);

			}
		} else {
			throw new BusinessException(19001, "Error al obtener los items de la Garant�a.");
		}

		LOGGER.logDebug("Finish getColumns");
		return columns;
		/*
		 * } else {
		 * 
		 * return (GridColumn[]) cache.get(wCacheCollateralKeyMapping);
		 * 
		 * }
		 */

	}
	/*
	 * public void setCacheManager(ICacheManager cacheManager) {
	 * this.cacheManager = cacheManager; }
	 */

}
