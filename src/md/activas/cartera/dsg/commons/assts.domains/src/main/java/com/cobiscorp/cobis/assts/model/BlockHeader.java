package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class BlockHeader {

	public static final String EN_BLOCKHEEA_393 = "EN_BLOCKHEEA_393";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "BlockHeader";
	
	
	public static final Property<String> BLOCKED = new Property<String>("blocked", String.class, false);
	
	public static final Property<String> ACTIVE = new Property<String>("active", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
