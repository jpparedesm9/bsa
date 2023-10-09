package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class QuestionsPartOne {

	public static final String EN_QUESTIOPN_589 = "EN_QUESTIOPN_589";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "QuestionsPartOne";
	
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final Property<Integer> NUMBER = new Property<Integer>("number", Integer.class, false);
	
	public static final Property<String> ANSWER = new Property<String>("answer", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
