package com.cobiscorp.cobis.asscr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CallCenterQuestion {

	public static final String EN_CALLCENON_616 = "EN_CALLCENON_616";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CallCenterQuestion";
	
	
	public static final Property<Integer> CLIENTCODE = new Property<Integer>("clientCode", Integer.class, false);
	
	public static final Property<String> CORRECTVALIDATION = new Property<String>("correctValidation", String.class, false);
	
	public static final Property<String> NOTENGO = new Property<String>("noTengo", String.class, false);
	
	public static final Property<String> ANSWER = new Property<String>("answer", String.class, false);
	
	public static final Property<String> TYPEANSWER = new Property<String>("typeAnswer", String.class, false);
	
	public static final Property<Integer> IDQUESTION = new Property<Integer>("idQuestion", Integer.class, false);
	
	public static final Property<String> QUESTION = new Property<String>("question", String.class, false);
	
	public static final Property<Boolean> BOOLEANHAS = new Property<Boolean>("booleanHas", Boolean.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
