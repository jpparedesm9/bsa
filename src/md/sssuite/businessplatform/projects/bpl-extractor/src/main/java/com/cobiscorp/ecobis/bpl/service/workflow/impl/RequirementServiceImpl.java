package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.List;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.dao.workflow.RequirementDao;
import com.cobiscorp.ecobis.bpl.service.workflow.RequirementService;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Requirement;

public class RequirementServiceImpl implements RequirementService {

	private RequirementDao requirementDao;

	public RequirementDao getRequirementDao() {
		return requirementDao;
	}

	public void setRequirementDao(RequirementDao requirementDao) {
		this.requirementDao = requirementDao;
	}

	public List<Requirement> findAllRequirements() throws Exception {
		return requirementDao.findAllRequirements();
	}

	public Requirement findRequirementByName(String name) throws Exception {
		return requirementDao.findRequirementByName(name);
	}

	public Requirement saveRequirement(Requirement requirement) throws Exception {
		return requirementDao.saveRequirement(requirement);
	}

	public Requirement findAndSave(Requirement requirement, DriverManagerDataSource dataSource) throws Exception {
		SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);

		Requirement searchRequirement = hmRequirement.get(requirement.getName());
		if (searchRequirement == null) {
			searchRequirement = findRequirementByName(requirement.getName());
			if (searchRequirement == null) {
				requirement.setIdRequirement(seqnos.execute("wf_tipo_documento"));
				requirement = saveRequirement(requirement);
				hmRequirement.put(requirement.getName(), requirement);
				return requirement;
			}else{
				hmRequirement.put(searchRequirement.getName(), searchRequirement);
				return searchRequirement;
			}
			
		}
		
		return searchRequirement;
	}

}
