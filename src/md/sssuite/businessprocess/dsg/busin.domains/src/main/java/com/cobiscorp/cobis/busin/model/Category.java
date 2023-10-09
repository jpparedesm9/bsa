package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class Category {

	public static final String EN_CATEGORYM957 = "EN_CATEGORYM957";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "Category";
	
	
	public static final Property<String> SECTOR = new Property<String>("sector", String.class, false);
	
	public static final Property<String> PRODUCTTYPE = new Property<String>("ProductType", String.class, false);
	
	public static final Property<BigDecimal> CURRENCY = new Property<BigDecimal>("Currency", BigDecimal.class, false);
	
	public static final Property<String> CONCEPT = new Property<String>("Concept", String.class, false);
	
	public static final Property<String> METHODOFPAYMENT = new Property<String>("MethodOfPayment", String.class, false);
	
	public static final Property<String> REFERENCE = new Property<String>("Reference", String.class, false);
	
	public static final Property<String> SIGN = new Property<String>("Sign", String.class, false);
	
	public static final Property<Double> SPREAD = new Property<Double>("Spread", Double.class, false);
	
	public static final Property<Double> VALUE = new Property<Double>("Value", Double.class, false);
	
	public static final Property<Double> PERCENTAGE = new Property<Double>("Percentage", Double.class, false);
	
	public static final Property<String> FUNDED = new Property<String>("Funded", String.class, false);
	
	public static final Property<String> CONCEPTTYPE = new Property<String>("ConceptType", String.class, false);
	
	public static final Property<Double> FACTOR = new Property<Double>("Factor", Double.class, false);
	
	public static final Property<String> ITEMDESC = new Property<String>("ItemDesc", String.class, false);
	
	public static final Property<String> AMOUNTTOAPPLYDESC = new Property<String>("AmountToApplyDesc", String.class, false);
	
	public static final Property<String> AMOUNTOAPPLY = new Property<String>("AmounToApply", String.class, false);
	
	public static final Property<Double> REFERENCEAMOUNT = new Property<Double>("ReferenceAmount", Double.class, false);
	
	public static final Property<Double> MINIMUM = new Property<Double>("Minimum", Double.class, false);
	
	public static final Property<Double> MAXIMUN = new Property<Double>("Maximun", Double.class, false);
	
	public static final Property<Double> MINRATE = new Property<Double>("MinRate", Double.class, false);
	
	public static final Property<Integer> PRIORITY = new Property<Integer>("Priority", Integer.class, false);
	
	public static final Property<Character> PAYMENTARREARS = new Property<Character>("PaymentArrears", Character.class, false);
	
	public static final Property<String> PROVISIONED = new Property<String>("Provisioned", String.class, false);
	
	public static final Property<Character> READJUSTMENTSIGN = new Property<Character>("ReadjustmentSign", Character.class, false);
	
	public static final Property<Double> READJUSTMENTFACTOR = new Property<Double>("ReadjustmentFactor", Double.class, false);
	
	public static final Property<String> REFERENTIALREADJUSTMENT = new Property<String>("ReferentialReadjustment", String.class, false);
	
	public static final Property<BigDecimal> GRACE = new Property<BigDecimal>("Grace", BigDecimal.class, false);
	
	public static final Property<String> CALCULATEDBASE = new Property<String>("CalculatedBase", String.class, false);
	
	public static final Property<String> ACCOUNTPAYMENT = new Property<String>("AccountPayment", String.class, false);
	
	public static final Property<String> CONCEPTASOC = new Property<String>("ConceptAsoc", String.class, false);
	
	public static final Property<Double> PERCENTAGEDAY = new Property<Double>("PercentageDay", Double.class, false);
	
	public static final Property<String> AFFECTATION = new Property<String>("Affectation", String.class, false);
	
	public static final Property<Character> DIFFER = new Property<Character>("Differ", Character.class, false);
	
	public static final Property<Integer> DIFFERDAYS = new Property<Integer>("DifferDays", Integer.class, false);
	
	public static final Property<String> DISCOUNTFORM = new Property<String>("DiscountForm", String.class, false);
	
	public static final Property<String> FORMTHIRDPAYMENT = new Property<String>("FormThirdPayment", String.class, false);
	
	public static final Property<String> ACCOUNTABONO = new Property<String>("AccountAbono", String.class, false);
	
	public static final Property<Double> ROTMINIMUNRATE = new Property<Double>("RotMinimunRate", Double.class, false);
	
	public static final Property<Character> ISHERITAGE = new Property<Character>("isHeritage", Character.class, false);
	
	public static final Property<String> SEGMENT = new Property<String>("segment", String.class, false);
	
	public static final Property<String> BANK = new Property<String>("bank", String.class, false);
	
	public static final Property<String> PAYMENTFORM = new Property<String>("PaymentForm", String.class, false);
	
	public static final Property<String> READJUSTMENT = new Property<String>("Readjustment", String.class, false);
	
	public static final Property<String> CONCEPTDESCRIPTION = new Property<String>("ConceptDescription", String.class, false);
	
	public static final Property<String> PAYMENTFORMDESCRIPTION = new Property<String>("PaymentFormDescription", String.class, false);
	
	public static final Property<String> CONCEPTTYPEDESCRIPTION = new Property<String>("ConceptTypeDescription", String.class, false);
	
	public static final Property<Double> MAXRATE = new Property<Double>("MaxRate", Double.class, false);
	
	public static final Property<String> REFERENCEDESCRIPTION = new Property<String>("ReferenceDescription", String.class, false);
	
	public static final Property<Boolean> ISNEW = new Property<Boolean>("isNew", Boolean.class, false);
	
	public static final Property<String> ITEMTYPE = new Property<String>("itemType", String.class, false);
	
	public static final Property<String> HASDECIMALS = new Property<String>("HasDecimals", String.class, false);
	
	public static final Property<String> MONEY = new Property<String>("Money", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
