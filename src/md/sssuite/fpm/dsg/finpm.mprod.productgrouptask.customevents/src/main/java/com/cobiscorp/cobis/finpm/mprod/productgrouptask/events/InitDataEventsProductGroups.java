package com.cobiscorp.cobis.finpm.mprod.productgrouptask.events;

import java.util.ArrayList;
import java.util.List;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.finpm.model.Ecatalog;
import com.cobiscorp.cobis.finpm.mprod.productgrouptask.utils.Constants;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.fpm.bo.Catalog;

public class InitDataEventsProductGroups extends BaseEvent implements IInitDataEvent {

	private static final ILogger logger = LogFactory.getLogger(InitDataEventsProductGroups.class);

	private ExecuteProductServices productService;

	public InitDataEventsProductGroups(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		productService = new ExecuteProductServices(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
		try {
			DataEntityList entitiesList = entities.getEntityList(Ecatalog.ENTITY_NAME);
			List<Catalog> catalogs = getCatalogsByName(arg1);

			entitiesList.clear();
			for (Catalog catalog : catalogs) {
				DataEntity details = new DataEntity();
				details.set(Ecatalog.CODE, catalog.getCode());
				details.set(Ecatalog.VALUECATALOG, catalog.getName());
				details.set(Ecatalog.SELECTED, false);
				entitiesList.add(details);
			}
		} catch (Exception ex) {
			logger.logError(ex);
			arg1.getMessageManager().showErrorMsg("Falla de infraestructura, consulte al Administrador del Sistema");
		} finally {
			logger.logDebug("Finish execute loadItems method in executeDataEvent class");
		}
	}

	public List<Catalog> getCatalogsByName(IDataEventArgs arg1) {

		logger.logDebug("Star getCatalogsByName method in ExecuteCommandEvent_VA_PDUCTGOUIE3705_IDLU238 class");
		List<Catalog> resultCatalogs = null;
		ServiceResponse serviceResponse;

		try {
			List<Catalog> catalogs = new ArrayList<Catalog>();
			serviceResponse = productService.manageServiceProduct(arg1, Constants.QUERYCATALOGSBYNAME, Constants.SECTORCATALOGNAME);
			if (serviceResponse.isResult()) {
				logger.logDebug("start ServiceResponse");

				resultCatalogs = (List<Catalog>) serviceResponse.getData();
			}
		} catch (BusinessException bx) {
			logger.logDebug(bx);
		} catch (Exception e) {
			logger.logDebug(e);
		} finally {
			logger.logDebug("End getCatalogsByName method in ExecuteCommandEvent_VA_PDUCTGOUIE3705_IDLU238 class");
		}

		return resultCatalogs;
	}

}
