package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class Context {

	public static final String EN_CONTEXTTB762 = "EN_CONTEXTTB762";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Context";
	
	
	public static final Property<Integer> APPLICATION = new Property<Integer>("Application", Integer.class, false);
	
	public static final Property<String> APPLICATIONSUBJECT = new Property<String>("ApplicationSubject", String.class, false);
	
	public static final Property<Integer> REQUESTID = new Property<Integer>("RequestId", Integer.class, false);

	public static final Property<String> SYNCHRONIZE = new Property<String>("synchronize", String.class, false);
	
	public static final Property<String> REQUESTNAME = new Property<String>("RequestName", String.class, false);
	
	public static final Property<String> REQUESTTYPE = new Property<String>("RequestType", String.class, false);
	
	public static final Property<String> REQUESTSTAGE = new Property<String>("RequestStage", String.class, false);
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("CustomerId", Integer.class, false);
	
	public static final Property<String> BOOKMARK = new Property<String>("Bookmark", String.class, false);
	
	public static final Property<String> TYPE = new Property<String>("Type", String.class, false);
	
	public static final Property<Integer> TASKCOUNTLAP = new Property<Integer>("TaskCountLap", Integer.class, false);
	
	public static final Property<String> TASKSUBJECT = new Property<String>("TaskSubject", String.class, false);
	
	public static final Property<String> FLAG1 = new Property<String>("Flag1", String.class, false);
	
	public static final Property<String> FLAG2 = new Property<String>("Flag2", String.class, false);
	
	public static final Property<String> FIELDSEVEN = new Property<String>("fieldSeven", String.class, false);

	public static final Property<Double> AMOUNTAPPROVED = new Property<Double>("amountApproved", Double.class, false);
	
	public static final Property<Double> AMOUNTREQUESTED = new Property<Double>("amountRequested", Double.class, false);
	
	public static final Property<String> CYCLENUMBER = new Property<String>("cycleNumber", String.class, false);

	public static final Property<String> ENABLE = new Property<String>("enable", String.class, false);
	
	public static final Property<String> OFFICENAME = new Property<String>("officeName", String.class, false);

	public static final Property<Integer> CHANNEL = new Property<Integer>("channel", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
