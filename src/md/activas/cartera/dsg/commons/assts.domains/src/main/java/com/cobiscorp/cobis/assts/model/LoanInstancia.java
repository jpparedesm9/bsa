package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class LoanInstancia {

	public static final String EN_LOANINSTC_482 = "EN_LOANINSTC_482";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "LoanInstancia";
	
	
	public static final Property<String> IDOPTIONMENU = new Property<String>("idOptionMenu", String.class, false);
	
	public static final Property<Boolean> ERRORVALIDATION = new Property<Boolean>("errorValidation", Boolean.class, false);
	
	public static final Property<String> IDINSTANCIA = new Property<String>("idInstancia", String.class, false);
	
	public static final Property<String> TIPO = new Property<String>("tipo", String.class, false);
	
	public static final Property<String> GROUPSUMMARY = new Property<String>("groupSummary", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
