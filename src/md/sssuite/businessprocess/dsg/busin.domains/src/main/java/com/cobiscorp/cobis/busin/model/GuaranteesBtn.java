package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class GuaranteesBtn {

	public static final String EN_GARATEBTN197 = "EN_GARATEBTN197";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "GuaranteesBtn";
	
	
	public static final Property<Integer> MONTO = new Property<Integer>("Monto", Integer.class, false);
	
	public static final Property<String> SEARCHBTN = new Property<String>("Searchbtn", String.class, false);
	
	public static final Property<String> ASSOCIATEBTN = new Property<String>("Associatebtn", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
