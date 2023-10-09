package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class PaymentCapacity {

	public static final String EN_AENTAPAIT625 = "EN_AENTAPAIT625";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "PaymentCapacity";
	
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("CustomerID", Integer.class, false);
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("CustomerName", String.class, false);
	
	public static final Property<BigDecimal> BALANCE1 = new Property<BigDecimal>("Balance1", BigDecimal.class, false);
	
	public static final Property<BigDecimal> BALANCE2 = new Property<BigDecimal>("Balance2", BigDecimal.class, false);
	
	public static final Property<BigDecimal> BALANCE3 = new Property<BigDecimal>("Balance3", BigDecimal.class, false);
	
	public static final Property<BigDecimal> BALANCE4 = new Property<BigDecimal>("Balance4", BigDecimal.class, false);
	
	public static final Property<BigDecimal> BALANCE5 = new Property<BigDecimal>("Balance5", BigDecimal.class, false);
	
	public static final Property<BigDecimal> BALANCE6 = new Property<BigDecimal>("Balance6", BigDecimal.class, false);
	
	public static final Property<BigDecimal> BALANCE7 = new Property<BigDecimal>("Balance7", BigDecimal.class, false);
	
	public static final Property<BigDecimal> BALANCE8 = new Property<BigDecimal>("Balance8", BigDecimal.class, false);
	
	public static final Property<BigDecimal> BALANCE9 = new Property<BigDecimal>("Balance9", BigDecimal.class, false);
	
	public static final Property<BigDecimal> BALANCE10 = new Property<BigDecimal>("Balance10", BigDecimal.class, false);
	
	public static final Property<BigDecimal> BALANCE11 = new Property<BigDecimal>("Balance11", BigDecimal.class, false);
	
	public static final Property<BigDecimal> BALANCE12 = new Property<BigDecimal>("Balance12", BigDecimal.class, false);
	
	public static final Property<BigDecimal> MONTHAVERAGE = new Property<BigDecimal>("MonthAverage", BigDecimal.class, false);
	
	public static final Property<BigDecimal> TOTALANNUAL = new Property<BigDecimal>("TotalAnnual", BigDecimal.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
