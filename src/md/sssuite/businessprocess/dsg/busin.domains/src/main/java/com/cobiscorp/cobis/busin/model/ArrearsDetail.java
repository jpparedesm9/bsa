package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class ArrearsDetail {

	public static final String EN_ARRASDETA235 = "EN_ARRASDETA235";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ArrearsDetail";
	
	
	public static final Property<String> APPLICATIONTYPE = new Property<String>("applicationType", String.class, false);
	
	public static final Property<String> RANGEARREARS = new Property<String>("rangeArrears", String.class, false);
	
	public static final Property<Integer> RATEAMORTIZATION = new Property<Integer>("rateAmortization", Integer.class, false);
	
	public static final Property<Integer> CAPITALAMORTIZATION = new Property<Integer>("capitalAmortization", Integer.class, false);
	
	public static final Property<String> PROBLEMSANDNEGOTIATIONS = new Property<String>("problemsAndNegotiations", String.class, false);
	
	public static final Property<String> PERSONALGUARANTORSTATUS = new Property<String>("personalGuarantorStatus", String.class, false);
	
	public static final Property<String> CONSISTENCYCOMMENTS = new Property<String>("consistencyComments", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
