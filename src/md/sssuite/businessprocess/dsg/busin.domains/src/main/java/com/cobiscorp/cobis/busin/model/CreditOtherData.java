package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class CreditOtherData {

	public static final String EN_CDTTEDATA309 = "EN_CDTTEDATA309";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "CreditOtherData";
	
	
	public static final Property<String> CREDITPORPUSE = new Property<String>("CreditPorpuse", String.class, false);
	
	public static final Property<String> CREDITDESTINATION = new Property<String>("CreditDestination", String.class, false);
	
	public static final Property<String> SOURCEOFFUNDING = new Property<String>("SourceOfFunding", String.class, false);
	
	public static final Property<String> ECONOMICACTIVITYCREDIT = new Property<String>("EconomicActivityCredit", String.class, false);
	
	public static final Property<String> ACTIVITYDESTINATIONCREDIT = new Property<String>("ActivityDestinationCredit", String.class, false);
	
	public static final Property<String> DESCRIPTIONDESTINATIONREQUESTED = new Property<String>("DescriptionDestinationRequested", String.class, false);
	
	public static final Property<String> CREDITDESTINATIONVALUE = new Property<String>("CreditDestinationValue", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
