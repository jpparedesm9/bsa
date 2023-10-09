package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class InfocredHeader {

	public static final String EN_INFOREDHD260 = "EN_INFOREDHD260";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "InfocredHeader";
	
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("CustomerId", Integer.class, false);
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("CustomerName", String.class, false);
	
	public static final Property<String> EXPIRATIONDATE = new Property<String>("ExpirationDate", String.class, false);
	
	public static final Property<Integer> COUNT = new Property<Integer>("Count", Integer.class, false);
	
	public static final Property<Character> ASSOCIATETO = new Property<Character>("AssociateTo", Character.class, false);
	
	public static final Property<Integer> EXISTSLOANID = new Property<Integer>("ExistsLoanId", Integer.class, false);
	
	public static final Property<Character> ASSOCIATEWITH = new Property<Character>("AssociateWith", Character.class, false);
	
	public static final Property<Integer> NEWLOANID = new Property<Integer>("NewLoanId", Integer.class, false);
	
	public static final Property<Integer> NEWREQUESTID = new Property<Integer>("NewRequestId", Integer.class, false);
	
	public static final Property<String> NEWLOANCODE = new Property<String>("NewLoanCode", String.class, false);
	
	public static final Property<Character> ROLE = new Property<Character>("Role", Character.class, false);
	
	public static final Property<Boolean> OUT_HASMANYSIMILAR = new Property<Boolean>("Out_HasManySimilar", Boolean.class, false);
	
	public static final Property<String> OUT_SIMILARLIST = new Property<String>("Out_SimilarList", String.class, false);
	
	public static final Property<Character> OUT_SOURCE = new Property<Character>("Out_Source", Character.class, false);
	
	public static final Property<Character> OUT_ROLE = new Property<Character>("Out_Role", Character.class, false);
	
	public static final Property<Integer> OUT_REQUESTIDLOANID = new Property<Integer>("Out_RequestIdLoanId", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
