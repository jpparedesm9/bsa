package com.cobiscorp.cobis.assts.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class ServerParameter {

	public static final String EN_SERVERPRA_884 = "EN_SERVERPRA_884";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "ServerParameter";
	
	
	public static final Property<String> LOANBANKID = new Property<String>("loanBankID", String.class, false);
	
	public static final Property<Integer> SELECTEDROW = new Property<Integer>("selectedRow", Integer.class, false);
	
	public static final Property<BigDecimal> AMOUNT = new Property<BigDecimal>("amount", BigDecimal.class, false);
	
	public static final Property<BigDecimal> CONDONATIONPERCENTAGE = new Property<BigDecimal>("condonationPercentage", BigDecimal.class, false);
	
	public static final Property<Boolean> FLAG = new Property<Boolean>("flag", Boolean.class, false);
	
	public static final Property<Boolean> REFRESGRIDFLAG = new Property<Boolean>("refresGridFlag", Boolean.class, false);
	
	public static final Property<Boolean> REFRESGRID2FLAG = new Property<Boolean>("refresGrid2Flag", Boolean.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
