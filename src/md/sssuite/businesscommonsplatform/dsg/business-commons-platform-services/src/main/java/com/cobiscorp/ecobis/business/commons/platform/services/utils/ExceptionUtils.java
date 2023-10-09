package com.cobiscorp.ecobis.business.commons.platform.services.utils;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;

public class ExceptionUtils {

	public static void showError(String mensaje, Exception e, ICommonEventArgs args, ILogger log) {

		log.logError(mensaje, e);
		args.setSuccess(false);

		if (e instanceof Exception) {
			args.getMessageManager().showErrorMsg(mensaje);
		} else {
			args.getMessageManager().showErrorMsg(mensaje + " " + e.getMessage());
		}

	}

}
