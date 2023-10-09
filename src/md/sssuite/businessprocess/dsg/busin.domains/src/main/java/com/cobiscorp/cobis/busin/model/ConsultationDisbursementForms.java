package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ConsultationDisbursementForms {

	public static final String EN_CUTIUSMNT286 = "EN_CUTIUSMNT286";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ConsultationDisbursementForms";
	
	
	public static final Property<String> PRODUCT = new Property<String>("Product", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("Description", String.class, false);
	
	public static final Property<Integer> RETENTION = new Property<Integer>("Retention", Integer.class, false);
	
	public static final Property<Integer> COBISPRODUCT = new Property<Integer>("CobisProduct", Integer.class, false);
	
	public static final Property<String> AUTOMATICPAYMENT = new Property<String>("AutomaticPayment", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
