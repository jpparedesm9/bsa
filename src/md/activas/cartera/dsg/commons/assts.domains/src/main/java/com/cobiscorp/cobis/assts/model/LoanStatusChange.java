package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class LoanStatusChange {

	public static final String EN_LOANSTATU_584 = "EN_LOANSTATU_584";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "LoanStatusChange";
	
	
	public static final Property<Integer> LOANID = new Property<Integer>("loanID", Integer.class, false);
	
	public static final Property<String> CURRENTSTATUS = new Property<String>("currentStatus", String.class, false);
	
	public static final Property<String> NEWSTATUS = new Property<String>("newStatus", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
