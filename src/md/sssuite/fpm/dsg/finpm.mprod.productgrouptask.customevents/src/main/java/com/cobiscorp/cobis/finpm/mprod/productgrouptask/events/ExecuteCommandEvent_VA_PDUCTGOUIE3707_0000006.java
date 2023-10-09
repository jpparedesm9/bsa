package com.cobiscorp.cobis.finpm.mprod.productgrouptask.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.finpm.model.Ecatalog;
import com.cobiscorp.cobis.finpm.model.EnodeTypeCategory;
import com.cobiscorp.cobis.finpm.mprod.productgrouptask.utils.Constants;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.fpm.model.NodeTypeCategory;

public class ExecuteCommandEvent_VA_PDUCTGOUIE3707_0000006 extends BaseEvent implements IExecuteCommand {

	private static final ILogger logger = LogFactory.getLogger(ExecuteCommandEvent_VA_PDUCTGOUIE3707_0000006.class);

	private ExecuteProductServices productService;

	public ExecuteCommandEvent_VA_PDUCTGOUIE3707_0000006(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
		productService = new ExecuteProductServices(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs arg1) {
		logger.logDebug("Start executeCommand method in ExecuteCommandEvent_VA_PDUCTGOUIE3707_0000006 class");
		try {
			// manageCategories(String operation, Long
			// nodeTypeProductId,NodeTypeCategory category)
			DataEntity nodeTypeCategory = entities.getEntity(EnodeTypeCategory.ENTITY_NAME);

			DataEntityList selectedList = entities.getEntityList(Ecatalog.ENTITY_NAME);

			DataEntityList removedList = new DataEntityList();

			for (DataEntity entity : selectedList) {

				if (entity.get(Ecatalog.SELECTED)) {

					NodeTypeCategory ntc = new NodeTypeCategory();
					ntc.setName(entity.get(Ecatalog.VALUECATALOG));
					ntc.setDescription(entity.get(Ecatalog.VALUECATALOG));
					ntc.setMnemonic(entity.get(Ecatalog.CODE));

					ServiceResponse serv = productService.manageServiceProduct(arg1, Constants.MANAGECATEGORIES, Constants.CONSTANTINSERT, Constants.LEVELFOURBANKTYPE, ntc);
					removedList.add(entity);
				}
			}

			for (DataEntity removeObj : removedList) {
				selectedList.remove(removeObj);
			}
		} catch (Exception ex) {
			logger.logError(ex);
			arg1.getMessageManager().showErrorMsg("Falla de infraestructura, consulte al Administrador del Sistema ExecuteCommandEvent_VA_PDUCTGOUIE3707_0000006");
		} finally {
			logger.logDebug("Finish executeCommand method in ExecuteCommandEvent_VA_PDUCTGOUIE3707_0000006 class");
		}
	}

}
