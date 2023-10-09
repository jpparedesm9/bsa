package com.cobiscorp.ecobis.business.commons.platform.services.utils;

import com.cobiscorp.cobisv.commons.context.Context;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;

public class ContainerContext {
	
	public Context getContext(ICommonEventArgs arg1){
		Context wContext = ContextManager.getContext();
		if(wContext==null){
			arg1.getMessageManager().showErrorMsg("Se perdió la sesión");
		}
		return wContext;
	}

}
