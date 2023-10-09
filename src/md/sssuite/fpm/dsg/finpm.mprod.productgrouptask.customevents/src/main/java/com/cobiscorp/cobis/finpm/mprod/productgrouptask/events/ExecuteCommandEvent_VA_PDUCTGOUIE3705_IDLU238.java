package com.cobiscorp.cobis.finpm.mprod.productgrouptask.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.finpm.model.EnodeTypeCommon;
import com.cobiscorp.cobis.finpm.mprod.productgrouptask.utils.Constants;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.fpm.model.NodeTypeProduct;

public class ExecuteCommandEvent_VA_PDUCTGOUIE3705_IDLU238 extends BaseEvent implements IExecuteCommand {

	private static final ILogger logger = LogFactory.getLogger(ExecuteCommandEvent_VA_PDUCTGOUIE3705_IDLU238.class);

	private ExecuteProductServices productService;

	public ExecuteCommandEvent_VA_PDUCTGOUIE3705_IDLU238(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
		productService = new ExecuteProductServices(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest arg0, IExecuteCommandEventArgs arg1) {
		logger.logDebug("Start executeCommand method in ExecuteCommandEvent_VA_PDUCTGOUIE3705_IDLU238 class");
		try {
			DataEntity nodeTypeCommon = arg0.getEntity(EnodeTypeCommon.ENTITY_NAME);
			long id = Long.parseLong(nodeTypeCommon.get(EnodeTypeCommon.IDNODE));
			String name = (nodeTypeCommon.get(EnodeTypeCommon.NAME));
			String description = (nodeTypeCommon.get(EnodeTypeCommon.DESCRIPTION));
			String finalProduct = nodeTypeCommon.get(EnodeTypeCommon.ISFINALPRODUCT) ? "S" : "N";
			String keepDictionary = nodeTypeCommon.get(EnodeTypeCommon.ISKEEPDICTIONARY) ? "S" : "N";
			NodeTypeProduct nodeTypeProduct = new NodeTypeProduct();
			nodeTypeProduct.setId(id);
			nodeTypeProduct.setName(name);
			nodeTypeProduct.setDescription(description);
			nodeTypeProduct.setFinalProduct(finalProduct);
			nodeTypeProduct.setKeepDictionary(keepDictionary);
			logger.logDebug("Node Product: " + id + " " + name + " " + description + " " + finalProduct);
			productService.manageServiceProduct(arg1, Constants.QUERYUPDATENODEPRODUCT, nodeTypeProduct);
		} catch (Exception ex) {
			logger.logError(ex);
			arg1.getMessageManager().showErrorMsg("Falla de infraestructura, consulte al Administrador del Sistema");
		} finally {
			logger.logDebug("Finish executeCommand method in ExecuteCommandEvent_VA_PDUCTGOUIE3705_IDLU238 class");
		}

	}
}
