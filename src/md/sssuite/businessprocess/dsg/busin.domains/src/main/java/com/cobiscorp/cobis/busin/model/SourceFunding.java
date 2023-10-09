package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class SourceFunding {

	public static final String EN_OURCFUNDN956 = "EN_OURCFUNDN956";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "SourceFunding";
	
	
	public static final Property<String> FUNDINGSOURCE = new Property<String>("FundingSource", String.class, false);
	
	public static final Property<String> SECTORACTIVITY = new Property<String>("SectorActivity", String.class, false);
	
	public static final Property<String> OBJECTCREDIT = new Property<String>("ObjectCredit", String.class, false);
	
	public static final Property<String> CURRENCY = new Property<String>("Currency", String.class, false);
	
	public static final Property<BigDecimal> MINIMUNAMOUT = new Property<BigDecimal>("MinimunAmout", BigDecimal.class, false);
	
	public static final Property<BigDecimal> MAXIMUNAMOUNT = new Property<BigDecimal>("MaximunAmount", BigDecimal.class, false);
	
	public static final Property<String> PAYMENTFRECUENCY = new Property<String>("PaymentFrecuency", String.class, false);
	
	public static final Property<Integer> MAXIMUNTERM = new Property<Integer>("MaximunTerm", Integer.class, false);
	
	public static final Property<Integer> MINIMUNRATE = new Property<Integer>("MinimunRate", Integer.class, false);
	
	public static final Property<Integer> MAXIMUNRATE = new Property<Integer>("MaximunRate", Integer.class, false);
	
	public static final Property<Integer> CODESOURCE = new Property<Integer>("CodeSource", Integer.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
