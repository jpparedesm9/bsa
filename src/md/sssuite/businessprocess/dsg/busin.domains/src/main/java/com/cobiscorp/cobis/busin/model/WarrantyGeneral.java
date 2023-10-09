package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class WarrantyGeneral {

	public static final String EN_ARANYGENL527 = "EN_ARANYGENL527";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "WarrantyGeneral";
	
	
	public static final Property<String> ACCOUNTAHO = new Property<String>("accountAho", String.class, false);
	
	public static final Property<String> GUARANTORTYPE = new Property<String>("guarantortype", String.class, false);
	
	public static final Property<BigDecimal> BALANCEAVAILABLE = new Property<BigDecimal>("balanceAvailable", BigDecimal.class, false);
	
	public static final Property<String> SUITABILITY = new Property<String>("suitability", String.class, false);
	
	public static final Property<BigDecimal> APPRAISALVALUE = new Property<BigDecimal>("appraisalValue", BigDecimal.class, false);
	
	public static final Property<Integer> BRANCHOFFICE = new Property<Integer>("branchOffice", Integer.class, false);
	
	public static final Property<Integer> CODE = new Property<Integer>("code", Integer.class, false);
	
	public static final Property<String> COVERAGE = new Property<String>("coverage", String.class, false);
	
	public static final Property<Date> ADMISSIONDATE = new Property<Date>("admissionDate", Date.class, false);
	
	public static final Property<BigDecimal> FIXEDTERMAMOUNT = new Property<BigDecimal>("fixedTermAmount", BigDecimal.class, false);
	
	public static final Property<String> VALUESOURCE = new Property<String>("valueSource", String.class, false);
	
	public static final Property<String> EXTERNALCODE = new Property<String>("externalCode", String.class, false);
	
	public static final Property<Integer> OFFICE = new Property<Integer>("office", Integer.class, false);
	
	public static final Property<Integer> FILIAL = new Property<Integer>("filial", Integer.class, false);
	
	public static final Property<String> FIXEDTERM = new Property<String>("fixedTerm", String.class, false);
	
	public static final Property<BigDecimal> INITIALVALUE = new Property<BigDecimal>("initialValue", BigDecimal.class, false);
	
	public static final Property<String> INSTRUCTION = new Property<String>("instruction", String.class, false);
	
	public static final Property<Integer> CURRENCY = new Property<Integer>("currency", Integer.class, false);
	
	public static final Property<String> MANDATORYDOCUMENT = new Property<String>("mandatoryDocument", String.class, false);
	
	public static final Property<String> WARRANTYTYPE = new Property<String>("warrantyType", String.class, false);
	
	public static final Property<BigDecimal> CURRENTVALUE = new Property<BigDecimal>("currentValue", BigDecimal.class, false);
	
	public static final Property<String> DOCUMENTNUMBER = new Property<String>("documentNumber", String.class, false);
	
	public static final Property<Date> CONSTITUTIONDATE = new Property<Date>("constitutionDate", Date.class, false);
	
	public static final Property<Double> PERCENTAGECOVERAGE = new Property<Double>("percentageCoverage", Double.class, false);
	
	public static final Property<String> GUARANTOR = new Property<String>("guarantor", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("description", String.class, false);
	
	public static final Property<String> STATUS = new Property<String>("status", String.class, false);
	
	public static final Property<String> TRAMITNUMBER = new Property<String>("tramitNumber", String.class, false);
	
	public static final Property<Date> APPRAISALDATE = new Property<Date>("appraisalDate", Date.class, false);
	
	public static final Property<String> OWNER = new Property<String>("owner", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
