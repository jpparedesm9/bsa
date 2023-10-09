package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.List;

import com.cobiscorp.ecobis.bpl.dao.workflow.MappingVariableProcessDao;
import com.cobiscorp.ecobis.bpl.service.workflow.MappingVariableProcessService;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.MappingVariableProcess;

/**
 * @author acarrillo
 * 
 */
public class MappingVariableProcessServiceImpl implements MappingVariableProcessService {

	private MappingVariableProcessDao mappingVariableProcessDao;

	/**
	 * @return the mappingVariableProcessDao
	 */
	public MappingVariableProcessDao getMappingVariableProcessDao() {
		return mappingVariableProcessDao;
	}

	/**
	 * @param mappingVariableProcessDao
	 *            the mappingVariableProcessDao to set
	 */
	public void setMappingVariableProcessDao(MappingVariableProcessDao mappingVariableProcessDao) {
		this.mappingVariableProcessDao = mappingVariableProcessDao;
	}

	public List<MappingVariableProcess> findMappingVariableProcessByProcessVersion(Integer idProcess, Short versionProcess) {
		return mappingVariableProcessDao.findMappingVariableProcessByProcessVersion(idProcess, versionProcess);
	}

}
