package com.cobiscorp.ecobis.fpm.administration.service.impl;

import java.util.List;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cobiscorp.cobisv.commons.context.CobisContext;
import com.cobiscorp.cobisv.commons.context.CobisSession;
import com.cobiscorp.cobisv.commons.context.ContextRepository;
import com.cobiscorp.cobisv.commons.context.Server;
import com.cobiscorp.ecobis.fpm.administration.service.IDictionaryManager;
import com.cobiscorp.ecobis.fpm.model.DicCompanyProductType;
import com.cobiscorp.ecobis.fpm.model.DicCompanyProductTypeId;
import com.cobiscorp.ecobis.fpm.model.DicFunctionalityGroup;
import com.cobiscorp.ecobis.fpm.model.DictionaryField;
import com.cobiscorp.ecobis.fpm.model.FieldValidator;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;

@Ignore
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/META-INF/spring/cts-context.xml",
		"/META-INF/spring/test-cts-persistence-context.xml",
		"/META-INF/spring/test-cts-tx-context.xml" })
public class DictionaryManagerTest {

	@Autowired
	private IDictionaryManager service;
		
	@Before
	public void init() throws Exception {

		String id = "1";
		CobisContext context = new CobisContext(new CobisSession(id, "b1",
				"c1", "ci1", "o1", id, "1", "t1", "s1", "1"), new Server("1",
				"s1", ""));
		ContextRepository.setContext(context);
	}

	@Test
	public void testManageFieldValidators() {
		FieldValidator validator = new FieldValidator();
		validator.setType("Rif");
		validator.setValue("30");
		// validator.setDictionaryField(new DictionaryField());
		// validator.getDictionaryField().setId(3800);
		validator.setField(3800);
		validator.setTypeParam("PG");
		validator.setFieldsId(3800);
		long validatorId = service.manageFieldValidators(
				Constants.INSERT_OPERATION, validator);
		Assert.assertNotSame(0l, validatorId);
	}

	@Test
	public void testManageFields() {
		DictionaryField field = new DictionaryField();
		field.setDicFunctionalityGroup(new DicFunctionalityGroup());
		field.getDicFunctionalityGroup().setId(4000);
		field.setName("New field");
		field.setDescription("Description");
		field.setRequired("S");
		field.setValueType("Integer");
		long id = service.manageDictionaryFields(Constants.INSERT_OPERATION, field);		
		Assert.assertNotSame(0l, id);
	}
	
	@Ignore
	public void testGetAllValidatorsByField() {
		List<FieldValidator> validators = service.getAllValidatorsByField(3800l," ");
		Assert.assertNotNull(validators);
		Assert.assertNotSame(validators.isEmpty(), true);
	}
	
	@Test
	public void testDeleteCompany() {
		service.insertDictionary(new DicCompanyProductType(6136, 3100, "R", "Test Dictionary","Test Dictionary",null));
		service.deleteDictionary(new DicCompanyProductTypeId(6136, 3100, "R", "Test Dictionary"));
	}
	
	@Test
	public void testDeleteDicFunctionalityGroup() {		
		service.insertDictionary(new DicCompanyProductType(6136, 3100, "R", "Test Dictionary","Test Dictionary",null));
		DicFunctionalityGroup dfg = new DicFunctionalityGroup();
		dfg.setDicCompanyProductType(new DicCompanyProductType(6136, 3100, "R", "Test Dictionary","Test Dictionary",null));
		dfg.setName("Test Functional Group");
		dfg.setDescription("Test Functional Group");
		dfg.setEnabled("S");
		service.mangeFunctionalityGroups(Constants.INSERT_OPERATION, dfg);
		service.mangeFunctionalityGroups(Constants.DELETE_OPERATION, dfg);
	
//		dfg = service.getFunctionalityGroupBasicInformationById(4002L);
//		service.mangeFunctionalityGroups(Constants.DELETE_OPERATION, dfg);		
	}
	
	@Test
	public void testDeleteDictionaryFields() {		
//		DictionaryField field = new DictionaryField();
//		field.setDicFunctionalityGroup(new DicFunctionalityGroup());
//		field.getDicFunctionalityGroup().setId(4000);
//		field.setId(3800);		
//		service.manageDictionaryFields(Constants.DELETE_OPERATION, field);			
	}
}
