package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Guarantees {

	public static final String EN_WARRANTYF922 = "EN_WARRANTYF922";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Guarantees";
	
	
	public static final Property<Integer> IDGUARANTEE = new Property<Integer>("IdGuarantee", Integer.class, false);
	
	public static final Property<String> GUARANTEETYPE = new Property<String>("GuaranteeType", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("Description", String.class, false);
	
	public static final Property<String> STATUS = new Property<String>("Status", String.class, false);
	
	public static final Property<Date> ADMISSIONDATE = new Property<Date>("AdmissionDate", Date.class, false);
	
	public static final Property<String> CURRENCY = new Property<String>("Currency", String.class, false);
	
	public static final Property<BigDecimal> INITIALVALUE = new Property<BigDecimal>("InitialValue", BigDecimal.class, false);
	
	public static final Property<BigDecimal> CURRENTVALUE = new Property<BigDecimal>("CurrentValue", BigDecimal.class, false);
	
	public static final Property<BigDecimal> CURRENTVALUEMN = new Property<BigDecimal>("CurrentValueMn", BigDecimal.class, false);
	
	public static final Property<String> GUARANTEECODE = new Property<String>("GuaranteeCode", String.class, false);
	
	public static final Property<String> OFFICE = new Property<String>("Office", String.class, false);
	
	public static final Property<String> GUARANTORNAME = new Property<String>("GuarantorName", String.class, false);
	
	public static final Property<Integer> CUSTOMERID = new Property<Integer>("CustomerId", Integer.class, false);
	
	public static final Property<String> LOCATIONDOCUMENT = new Property<String>("LocationDocument", String.class, false);
	
	public static final Property<Date> DEPARTUREDATE = new Property<Date>("DepartureDate", Date.class, false);
	
	public static final Property<Date> REPAYMENTDATE = new Property<Date>("RepaymentDate", Date.class, false);
	
	public static final Property<String> DOCUMENTDESCRIPTION = new Property<String>("DocumentDescription", String.class, false);
	
	public static final Property<Integer> SUBSIDIARY = new Property<Integer>("Subsidiary", Integer.class, false);
	
	public static final Property<Integer> CUSTODY = new Property<Integer>("Custody", Integer.class, false);
	
	public static final Property<String> EXPIREDWARRANTY = new Property<String>("ExpiredWarranty", String.class, false);
	
	public static final Property<String> CLOSEOPEN = new Property<String>("CloseOpen", String.class, false);
	
	public static final Property<String> APPRAISEDVALUEDATE = new Property<String>("AppraisedValueDate", String.class, false);
	
	public static final Property<Integer> GUARANTORID = new Property<Integer>("GuarantorId", Integer.class, false);
	
	public static final Property<String> USERCREATION = new Property<String>("UserCreation", String.class, false);
	
	public static final Property<BigDecimal> VALUEAVAILABLE = new Property<BigDecimal>("ValueAvailable", BigDecimal.class, false);
	
	public static final Property<String> TYPE = new Property<String>("Type", String.class, false);
	
	public static final Property<String> OFFICENAME = new Property<String>("OfficeName", String.class, false);
	
	public static final Property<Double> RELATION = new Property<Double>("relation", Double.class, false);
	
	public static final Property<Character> ISPERSONAL = new Property<Character>("IsPersonal", Character.class, false);
	
	public static final Property<Character> ISHERITAGE = new Property<Character>("isHeritage", Character.class, false);
	
	public static final Property<String> CUSTOMERNAME = new Property<String>("customerName", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
