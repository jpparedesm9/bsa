package com.cobiscorp.cobis.finpm.mprod.productgrouptask.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

/**
 * This visual attribute VA_ONPICAOVIW0305_0000741 corresponds to the CREATE
 * buttom of the main view of the Simulator
 * */

public class ExecuteProductServices extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(ExecuteProductServices.class);

	public ExecuteProductServices(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	/***
	 * Metodo que llama un servicio Product Manager
	 * 
	 * @param nameService
	 *            Nombre del servicio que se va a ejecutar
	 * @param obj
	 *            Arreglo de objetos que recibe el servicio
	 * @return
	 */
	public ServiceResponse manageServiceProduct(ICommonEventArgs arg1, String nameService, Object... obj) {
		ServiceResponse serviceResponse = new ServiceResponse();
		try {
			logger.logDebug("Star execute manageServiceProduct(" + nameService + ") method in ExecuteCompanyServices class");

			if (obj == null) {
				logger.logError("Error en los parámetros del servicio " + nameService);

			} else {
				serviceResponse = this.execute(getServiceIntegration(), logger, nameService, obj);

				if (!serviceResponse.isResult()) {
					for (Message msg : serviceResponse.getMessages()) {
						arg1.getMessageManager().showErrorMsg(msg.getMessage());
					}
					arg1.setSuccess(false);
				}
			}

		} catch (BusinessException bex) {
			logger.logError(bex);
			serviceResponse.setResult(false);
		} catch (Exception ex) {
			logger.logError(ex);
			serviceResponse.setResult(false);
		} finally {
			logger.logDebug("End execute manageServiceProduct(" + nameService + ") method in ExecuteCompanyServices class");
		}

		return serviceResponse;
	}

}