package com.cobiscorp.cobis.mbile.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Terminal {

	public static final String EN_TERMINALL_822 = "EN_TERMINALL_822";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Terminal";
	
	
	public static final Property<String> REFERENCE1 = new Property<String>("reference1", String.class, false);
	
	public static final Property<String> REFERENCE2 = new Property<String>("reference2", String.class, false);
	
	public static final Property<String> MAC1 = new Property<String>("mac1", String.class, false);
	
	public static final Property<String> FILTERNAME = new Property<String>("filterName", String.class, false);
	
	public static final Property<String> FILTERVALUE = new Property<String>("filterValue", String.class, false);
	
	public static final Property<String> MAC2 = new Property<String>("mac2", String.class, false);
	
	public static final Property<String> MAC = new Property<String>("mac", String.class, false);
	
	public static final List<Property<?>> getPks() {
		return new ArrayList<Property<?>>();
	}

}
