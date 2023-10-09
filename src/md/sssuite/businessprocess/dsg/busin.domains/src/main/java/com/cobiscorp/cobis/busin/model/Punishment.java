package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Punishment {

	public static final String EN_PUNISMENT293 = "EN_PUNISMENT293";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Punishment";
	
	
	public static final Property<Date> COURTDATE = new Property<Date>("CourtDate", Date.class, false);
	
	public static final Property<Integer> OPERATION = new Property<Integer>("Operation", Integer.class, false);
	
	public static final Property<String> BANK = new Property<String>("Bank", String.class, false);
	
	public static final Property<String> OPERATIONSTATUS = new Property<String>("OperationStatus", String.class, false);
	
	public static final Property<BigDecimal> CAPITALBALANCE = new Property<BigDecimal>("CapitalBalance", BigDecimal.class, false);
	
	public static final Property<BigDecimal> INTERESTBALANCE = new Property<BigDecimal>("InterestBalance", BigDecimal.class, false);
	
	public static final Property<BigDecimal> MORABALANCE = new Property<BigDecimal>("MoraBalance", BigDecimal.class, false);
	
	public static final Property<BigDecimal> OTHERBALANCE = new Property<BigDecimal>("OtherBalance", BigDecimal.class, false);
	
	public static final Property<Integer> MORADAY = new Property<Integer>("MoraDay", Integer.class, false);
	
	public static final Property<String> OFICIAL = new Property<String>("Oficial", String.class, false);
	
	public static final Property<String> DESCRIPTIONOFICIAL = new Property<String>("DescriptionOficial", String.class, false);
	
	public static final Property<Integer> IDCLIENT = new Property<Integer>("IdClient", Integer.class, false);
	
	public static final Property<String> DESCRIPTIONCLIENT = new Property<String>("DescriptionClient", String.class, false);
	
	public static final Property<String> LASTPAYMENTDATE = new Property<String>("LastPaymentDate", String.class, false);
	
	public static final Property<Integer> CURRENCY = new Property<Integer>("Currency", Integer.class, false);
	
	public static final Property<String> OBSERVATION = new Property<String>("Observation", String.class, false);
	
	public static final Property<Boolean> RECOMMENDED = new Property<Boolean>("Recommended", Boolean.class, false);
	
	public static final Property<BigDecimal> CAPITALBALANCETODATE = new Property<BigDecimal>("CapitalBalanceToDate", BigDecimal.class, false);
	
	public static final Property<BigDecimal> INTERESTBALANCETODATE = new Property<BigDecimal>("InterestBalanceToDate", BigDecimal.class, false);
	
	public static final Property<Integer> OFFICE = new Property<Integer>("Office", Integer.class, false);
	
	public static final Property<BigDecimal> AMOUNT = new Property<BigDecimal>("Amount", BigDecimal.class, false);
	
	public static final Property<String> STATUS = new Property<String>("Status", String.class, false);
	
	public static final Property<String> BANKCLIENT = new Property<String>("bankclient", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
