package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class SourceRevenueCustomer {

	public static final String EN_RERUCUTOR755 = "EN_RERUCUTOR755";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "SourceRevenueCustomer";
	
	
	public static final Property<String> SUBACTIVITYECONOMIC = new Property<String>("subActivityEconomic", String.class, false);
	
	public static final Property<Character> TYPE = new Property<Character>("Type", Character.class, false);
	
	public static final Property<String> SECTOR = new Property<String>("Sector", String.class, false);
	
	public static final Property<String> SUBSECTOR = new Property<String>("SubSector", String.class, false);
	
	public static final Property<String> ECONOMICACTIVITY = new Property<String>("EconomicActivity", String.class, false);
	
	public static final Property<String> EXPLANATIONACTIVITY = new Property<String>("ExplanationActivity", String.class, false);
	
	public static final Property<String> CODEFIE = new Property<String>("CodeFIE", String.class, false);
	
	public static final Property<String> SOURCEFINANCING = new Property<String>("SourceFinancing", String.class, false);
	
	public static final Property<String> ROL = new Property<String>("Rol", String.class, false);
	
	public static final Property<Integer> IDCLIENT = new Property<Integer>("IdClient", Integer.class, false);
	
	public static final Property<String> CLARIFICATION = new Property<String>("Clarification", String.class, false);
	
	public static final Property<String> DESCRIPTIONACTIVITY = new Property<String>("descriptionActivity", String.class, false);
	
	public static final Property<String> DETAILCLARIFICATION = new Property<String>("detailClarification", String.class, false);
	
	public static final Property<String> DETAILSUBACTIVITYECO = new Property<String>("detailSubActivityEco", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
