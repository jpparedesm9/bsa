package com.cobiscorp.cobis.asscr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class QuestionValidation {

	public static final String EN_VALIDATCT_676 = "EN_VALIDATCT_676";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "QuestionValidation";
	
	
	public static final Property<String> CORRETVALIDATION = new Property<String>("corretValidation", String.class, false);
	
	public static final Property<String> MSMVALIDATION = new Property<String>("msmValidation", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
