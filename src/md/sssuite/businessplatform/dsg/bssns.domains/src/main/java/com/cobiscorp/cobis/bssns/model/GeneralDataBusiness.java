package com.cobiscorp.cobis.bssns.model;

import java.util.ArrayList;
import java.util.List;
import com.cobiscorp.designer.api.Property;

public class GeneralDataBusiness {

	public static final String EN_GENERALBT_583 = "EN_GENERALBT_583";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "GeneralDataBusiness";
	
	
	public static final Property<String> Q1 = new Property<String>("q1", String.class, false);
	
	public static final Property<String> FREQUENCYOFPAYMENT = new Property<String>("frequencyOfPayment", String.class, false);
	
	public static final Property<String> DAYSWEEKOPENS = new Property<String>("daysWeekOpens", String.class, false);
	
	public static final Property<String> CARSYEARSUSE = new Property<String>("carsYearsUse", String.class, false);
	
	public static final Property<String> HOURSDAYSOPENS = new Property<String>("hoursDaysOpens", String.class, false);
	
	public static final Property<String> PROPERTYLOCALBUSINESS = new Property<String>("propertyLocalBusiness", String.class, false);
	
	public static final Property<String> REGISTRYENTRYEXPENSES = new Property<String>("registryEntryExpenses", String.class, false);
	
	public static final Property<String> TIMELIKEREQUEST = new Property<String>("timeLikeRequest", String.class, false);
	
	public static final Property<String> NUMBEREMPLOYEESBUSINESS = new Property<String>("numberEmployeesBusiness", String.class, false);
	
	public static final Property<String> AMOUNTREQUEST = new Property<String>("amountRequest", String.class, false);
	
	public static final Property<String> DESTINATIONCREDITGRANTED = new Property<String>("destinationCreditGranted", String.class, false);
	
	public static final Property<String> ACCOUNTRFC = new Property<String>("accountRFC", String.class, false);
	
	public static final Property<String> DAYSCREDITSUPPLIERS = new Property<String>("daysCreditSuppliers", String.class, false);
	
	public static final Property<String> ANTIQUEBUSINESS = new Property<String>("antiqueBusiness", String.class, false);
	
	public static final Property<String> NUMBERPARTNERSBUSINESS = new Property<String>("numberPartnersBusiness", String.class, false);
	
	public static final Property<String> NUMBERSUPPLIERS = new Property<String>("numberSuppliers", String.class, false);
	
	public static final Property<String> TYPELOCALBUSINESS = new Property<String>("typeLocalBusiness", String.class, false);
	
	public static final Property<String> CREDITSINFORCE = new Property<String>("creditsInForce", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
