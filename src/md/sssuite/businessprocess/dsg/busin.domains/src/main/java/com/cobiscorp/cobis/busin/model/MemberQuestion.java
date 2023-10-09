package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class MemberQuestion {

	public static final String EN_MEMBERQSO_636 = "EN_MEMBERQSO_636";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "MemberQuestion";
	
	
	public static final Property<String> NAMEMEMBER = new Property<String>("nameMember", String.class, false);
	
	public static final Property<Integer> CODEMEMBER = new Property<Integer>("codeMember", Integer.class, false);
	
	public static final Property<Integer> ANSWER = new Property<Integer>("answer", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
