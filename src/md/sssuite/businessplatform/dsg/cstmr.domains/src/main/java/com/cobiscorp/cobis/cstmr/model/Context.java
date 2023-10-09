package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Context {

	public static final String EN_CREDITLBQ_215 = "EN_CREDITLBQ_215";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Context";
	
	
	public static final Property<Integer> FLAG1 = new Property<Integer>("flag1", Integer.class, false);
	
	public static final Property<String> FLAG2 = new Property<String>("flag2", String.class, false);
	
	public static final Property<String> FLAG3 = new Property<String>("flag3", String.class, false);
	
	public static final Property<Integer> PARENTS = new Property<Integer>("parents", Integer.class, false);
	
	public static final Property<String> COUPLE = new Property<String>("couple", String.class, false);
	
	public static final Property<String> MARRIED = new Property<String>("married", String.class, false);
	
	public static final Property<Integer> MINIMUMAGE = new Property<Integer>("minimumAge", Integer.class, false);
	
	public static final Property<String> ACCOUNTINDIVIDUAL = new Property<String>("accountIndividual", String.class, false);
	
	public static final Property<String> FREEUNION = new Property<String>("freeUnion", String.class, false);
	
	public static final Property<String> NAMEREPORT = new Property<String>("nameReport", String.class, false);
	
	public static final Property<String> COLLECTIVELEVEL = new Property<String>("collectiveLevel", String.class, false);
	
	public static final Property<String> OFFICENAME = new Property<String>("officeName", String.class, false);
	
	public static final Property<Integer> MAXIMUMAGE = new Property<Integer>("maximumAge", Integer.class, false);
	
	public static final Property<Integer> SON = new Property<Integer>("son", Integer.class, false);
	
	public static final Property<Integer> DEFAULTCOUNTRY = new Property<Integer>("defaultCountry", Integer.class, false);
	
	public static final Property<String> COLLECTIVE = new Property<String>("collective", String.class, false);
	
	public static final Property<Boolean> GENERATEREPORT = new Property<Boolean>("generateReport", Boolean.class, false);

	public static final Property<String> RENAPO = new Property<String>("renapo", String.class, false);
	
	public static final Property<Boolean> PRINTREPORT = new Property<Boolean>("printReport", Boolean.class, false);

	public static final Property<String> ROLEENABLEDQUERYACCOUNT = new Property<String>("roleEnabledQueryAccount", String.class, false);
	
	public static final Property<String> ROLEENABLEDDATAMODREQUEST = new Property<String>("roleEnabledDataModRequest", String.class, false);
	
	public static final Property<String> ADDRESSSTATE = new Property<String>("addressState", String.class, false);
	
	public static final Property<String> MAILSTATE = new Property<String>("mailState", String.class, false);

	public static final Property<Integer> CHANNEL = new Property<Integer>("channel", Integer.class, false);

	public static final Property<String> RENAPOBYCURP = new Property<String>("renapoByCurp", String.class, false);
		
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
