package com.cobiscorp.cobis.asscr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ResetImageMessage {

	public static final String EN_RESETIMGG_360 = "EN_RESETIMGG_360";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ResetImageMessage";
	
	
	public static final Property<Integer> CODRESETCLIENT = new Property<Integer>("codResetClient", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
