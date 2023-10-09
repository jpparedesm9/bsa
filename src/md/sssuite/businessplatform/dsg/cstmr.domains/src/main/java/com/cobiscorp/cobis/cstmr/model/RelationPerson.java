package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class RelationPerson {

	public static final String EN_RELATIOSS_414 = "EN_RELATIOSS_414";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "RelationPerson";
	
	
	public static final Property<Integer> SECUENTIALPERSONLEFT = new Property<Integer>("secuentialPersonLeft", Integer.class, false);
	
	public static final Property<String> NAMEPERSONLEFT = new Property<String>("namePersonLeft", String.class, false);
	
	public static final Property<String> NAMEPERSONRIGHT = new Property<String>("namePersonRight", String.class, false);
	
	public static final Property<String> NAMERELATION = new Property<String>("nameRelation", String.class, false);
	
	public static final Property<Integer> SECUENTIALPERSONRIGHT = new Property<Integer>("secuentialPersonRight", Integer.class, false);
	
	public static final Property<String> SIDE = new Property<String>("side", String.class, false);
	
	public static final Property<String> RELATIONID = new Property<String>("relationId", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
