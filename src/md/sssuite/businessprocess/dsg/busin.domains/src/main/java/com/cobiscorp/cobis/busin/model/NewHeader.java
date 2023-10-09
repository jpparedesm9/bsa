package com.cobiscorp.cobis.busin.model;

import com.cobiscorp.designer.api.Property;
import java.util.ArrayList;
import java.util.List;

public class NewHeader {
	public static final String EN_NEWHEADRR_304 = "EN_NEWHEADRR_304";
	public static final String VERSION = "1.0.0";
	public static final String ENTITY_NAME = "NewHeader";
	public static final Property<String> CATEGORY = new Property("category", String.class, false);

	public static final Property<String> TYPE = new Property("type", String.class, false);

	public static final Property<String> SUBTYPE = new Property("subType", String.class, false);

	public static final List<Property<?>> getPks() {
		List pks = new ArrayList();
		return pks;
	}
}