package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import org.apache.log4j.Logger;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.dao.workflow.VariableDao;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Programa;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.bpl.service.workflow.ProgramService;
import com.cobiscorp.ecobis.bpl.service.workflow.VariableService;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;

public class VariableServiceImpl implements VariableService {

	static Logger log = Logger.getLogger(VariableServiceImpl.class);

	private VariableDao variableDao;
	private ProgramService programService;

	/**
	 * @return the variableDao
	 */
	public VariableDao getVariableDao() {
		return variableDao;
	}

	/**
	 * @param variableDao
	 *            the variableDao to set
	 */
	public void setVariableDao(VariableDao variableDao) {
		this.variableDao = variableDao;
	}

	/**
	 * @return the programService
	 */
	public ProgramService getProgramService() {
		return programService;
	}

	/**
	 * @param programService
	 *            the programService to set
	 */
	public void setProgramService(ProgramService programService) {
		this.programService = programService;
	}

	public Variable findAndSaveVariable(Variable variable, DriverManagerDataSource dataSource) {

		Variable variableSerach = hmVariable.get(variable.getAbreviaturaVariable());

		log.debug("Variable---------------------------------------------------->1" + variableSerach);
		if (variableSerach == null) {
			log.debug("Variable---------------------------------------------------->2" + variableSerach);
			log.debug("Variable---------------------------------------------------->2.1" + variable);
			log.debug("Variable---------------------------------------------------->2.2" + variable.getAbreviaturaVariable());
			variableSerach = variableDao.findByAbreviaturaVariable(variable.getAbreviaturaVariable());
			log.debug("Variable---------------------------------------------------->3" + variableSerach);
			if (variableSerach == null) {

				SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);

				log.debug("Variable---------------------------------------------------->4" + variableSerach);
				Short codigoVariable = new Short("" + seqnos.execute("wf_variable"));
				variableSerach = new Variable();
				variableSerach.setCodigoVariable(codigoVariable);
				variableSerach.setAbreviaturaVariable(variable.getAbreviaturaVariable());
				variableSerach.setCatalogo(variable.getCatalogo());
				variableSerach.setDescVariable(variable.getDescVariable());
				variableSerach.setNombreVariable(variable.getNombreVariable());
				variableSerach.setSubTipoVariable(variable.getSubTipoVariable());
				variableSerach.setTipoDatos(variable.getTipoDatos());
				variableSerach.setTipoVariable(variable.getTipoVariable());
				variableSerach.setValueMax(variable.getValueMax());
				variableSerach.setValueMin(variable.getValueMin());
				variableSerach.setValueOperator(variable.getValueOperator());
				variableSerach.setValVariable(variable.getValVariable());
				log.debug("Variable---------------------------------------------------->5" + variableSerach);

				if (variable.getPrograma() != null) {
					log.debug("Variable---------------------------------------------------->6" + variableSerach);
					Programa programa = programService.findAndSaveProgram(variable.getPrograma(), dataSource);
					log.debug("Variable---------------------------------------------------->7" + variableSerach);
					variableSerach.setPrograma(null);
					variableSerach.setIdPrograma(programa.getIdPrograma());
					log.debug("Variable---------------------------------------------------->8" + variableSerach);
				}
				if (variable.getSeudoCatalogo() != null) {
					log.debug("Variable---------------------------------------------------->9" + variableSerach);
					Programa programa = programService.findAndSaveProgram(variable.getSeudoCatalogo(), dataSource);
					log.debug("Variable---------------------------------------------------->10" + variableSerach);
					variableSerach.setSeudoCatalogo(null);
					variableSerach.setIdSeudoCatalogo(programa.getIdPrograma());
				}
				log.debug("Variable---------------------------------------------------->11" + variableSerach.getCodigoVariable());
				variableDao.saveAndFlush(variableSerach);
				log.debug("Variable---------------------------------------------------->12" + variableSerach);
			}
			hmVariable.put(variable.getAbreviaturaVariable(), variableSerach);
		}
		return variableSerach;
	}

	public Variable findByAbreviaturaVariable(String abreviaturaVariable) {
		return variableDao.findByAbreviaturaVariable(abreviaturaVariable);
	}

	public Variable saveAndFlush(Variable variable) {
		return variableDao.saveAndFlush(variable);
	}

	public Variable findById(Short idVariable) {
		return variableDao.findById(idVariable);
	}
}
