package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class InfocredItem {

	public static final String EN_INFOREDIT251 = "EN_INFOREDIT251";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "InfocredItem";
	
	
	public static final Property<Integer> CODE = new Property<Integer>("Code", Integer.class, false);
	
	public static final Property<Integer> CUSTOMERCODE = new Property<Integer>("CustomerCode", Integer.class, false);
	
	public static final Property<String> DATE = new Property<String>("Date", String.class, false);
	
	public static final Property<String> OFFICIAL = new Property<String>("Official", String.class, false);
	
	public static final Property<String> EXPIRATIONDATE = new Property<String>("ExpirationDate", String.class, false);
	
	public static final Property<String> LOANORREQUEST = new Property<String>("LoanOrRequest", String.class, false);
	
	public static final Property<String> WORKSTATION = new Property<String>("Workstation", String.class, false);
	
	public static final Property<String> ROLE = new Property<String>("Role", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
