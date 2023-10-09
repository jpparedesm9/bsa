package com.cobiscorp.cobis.cstmr.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ReferenceReq {

	public static final String EN_REFERENCC_475 = "EN_REFERENCC_475";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ReferenceReq";
	
	
	public static final Property<Integer> REFLENGHT = new Property<Integer>("refLenght", Integer.class, false);
	
	public static final Property<String> REFERENCENUMBER = new Property<String>("referenceNumber", String.class, false);
	
	public static final Property<Double> PURCHASEAMOUNT = new Property<Double>("purchaseAmount", Double.class, false);
	
	public static final Property<Double> AUTHORIZEDAMOUNT = new Property<Double>("authorizedAmount", Double.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
