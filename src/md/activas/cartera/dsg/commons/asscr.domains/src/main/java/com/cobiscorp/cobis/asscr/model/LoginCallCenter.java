package com.cobiscorp.cobis.asscr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class LoginCallCenter {

	public static final String EN_LOGINCATR_641 = "EN_LOGINCATR_641";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "LoginCallCenter";
	
	
	public static final Property<String> IDCODREGISTER = new Property<String>("idCodRegister", String.class, false);
	
	public static final Property<String> OPRATION = new Property<String>("opration", String.class, false);
	
	public static final Property<Integer> PROCESSINST = new Property<Integer>("processInst", Integer.class, false);
	
	public static final Property<Integer> IDCLIENTE = new Property<Integer>("idCliente", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
