package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.dao.workflow.ProcessVariableDao;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Programa;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;
import com.cobiscorp.ecobis.bpl.service.workflow.ProcessVariableService;
import com.cobiscorp.ecobis.bpl.service.workflow.ProgramService;
import com.cobiscorp.ecobis.bpl.service.workflow.VariableService;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.IdProcessVariable;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVariable;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;

/**
 * @author acarrillo
 * 
 */
public class ProcessVariableServiceImpl implements ProcessVariableService {

	private ProcessVariableDao processVariableDao;
	private ProgramService programService;
	private VariableService variableService;
	static Logger log = Logger.getLogger(ProcessVariableServiceImpl.class);

	/**
	 * @return the processVariableDao
	 */
	public ProcessVariableDao getProcessVariableDao() {
		return processVariableDao;
	}

	/**
	 * @param processVariableDao
	 *            the processVariableDao to set
	 */
	public void setProcessVariableDao(ProcessVariableDao processVariableDao) {
		this.processVariableDao = processVariableDao;
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

	/**
	 * @return the variableService
	 */
	public VariableService getVariableService() {
		return variableService;
	}

	/**
	 * @param variableService
	 *            the variableService to set
	 */
	public void setVariableService(VariableService variableService) {
		this.variableService = variableService;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.bpl.service.workflow.ProcessVariableService#findProcessVariableByProcessVersion(java.lang.Integer, java.lang.Short)
	 */
	public List<ProcessVariable> findProcessVariableByProcessVersion(Integer idProcess, Short versionProcess) {
		return processVariableDao.findProcessVariableByProcessVersion(idProcess, versionProcess);
	}

	public void buildProcessVariable(ProcessVersion processVersionOrigin, ProcessVersion processVersioDestination, DriverManagerDataSource dataSource)
			throws Exception {

		try {

			log.debug("processVariable---------------------------------------------1");

			for (ProcessVariable processVariable : processVersionOrigin.getProcessVariableList()) {

				log.debug("processVariable---------------------------------------------2");

				ProcessVariable processVariableNew = new ProcessVariable();
				processVariableNew.setIdProcess(processVersioDestination.getProcess().getIdProcess());
				processVariableNew.setVersionProcess(processVersioDestination.getVersionProcess());
				processVariableNew.setInitialValue(processVariable.getInitialValue());
				processVariableNew.setSaveLog(processVariable.getSaveLog());
				processVariableNew.setProcessVersion(processVersioDestination);

				log.debug("processVariable---------------------------------------------3");

				if (processVariable.getProgram() != null) {
					log.debug("processVariable---------------------------------------------4");
					Programa program = programService.findAndSaveProgram(processVariable.getProgram(), dataSource);
					log.debug("processVariable---------------------------------------------5");
					processVariableNew.setProgram(null);
					processVariableNew.setIdPrograma(program.getIdPrograma());
					log.debug("processVariable---------------------------------------------6");
				}
				if (processVariable.getVariable() != null) {
					log.debug("processVariable---------------------------------------------7");
					Variable variable = variableService.findAndSaveVariable(processVariable.getVariable(), dataSource);
					log.debug("processVariable---------------------------------------------8");
					processVariableNew.setVariable(null);
					processVariableNew.setIdVariable(variable.getCodigoVariable());
					log.debug("processVariable---------------------------------------------9");
					processVariableNew.setIdProcessVariable(new IdProcessVariable(variable.getCodigoVariable(), processVariableNew.getIdProcess(),
							processVariableNew.getVersionProcess()));
					log.debug("processVariable---------------------------------------------10");
				}
				log.debug("processVariable---------------------------------------------11");
				processVersioDestination.getProcessVariableList().add(processVariableNew);
			}

		} catch (Exception e) {
			log.error("Error al ejecutar el metodo buildProcessVariable", e);
			throw new Exception(e);
		}

	}

	public Programa findAndSaveProgram(Programa program, DriverManagerDataSource dataSource) {

		// Declaro la clase para ejecutar el seqnos
		SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);

		// El hasmap debe estar al inicio conmo campo de la clase

		Programa programSearch = hmProgram.get(program.getNombreBdd() + "-" + program.getNombrePrograma());

		log.debug("Programa---------------------------------------------------->1" + programSearch);

		if (programSearch == null) {

			log.debug("Programa---------------------------------------------------->2" + programSearch);

			if (program.getNombreBdd() != null) {
				programSearch = programService.findByNombreBddAndNombrePrograma(program.getNombreBdd(), program.getNombrePrograma());
				log.debug("Programa---------------------------------------------------->3" + programSearch);
			} else {
				programSearch = programService.findByNombrePrograma(program.getNombrePrograma());
				log.debug("Programa---------------------------------------------------->4" + programSearch);
			}

			log.debug("Variable---------------------------------------------------->5" + programSearch);
			if (programSearch == null) {
				log.debug("Programa---------------------------------------------------->6" + programSearch);
				programSearch = new Programa();
				programSearch.setIdPrograma(seqnos.execute("wf_info_programa"));
				programSearch.setDescPrograma(program.getDescPrograma());
				programSearch.setNombreBdd(program.getNombreBdd());
				programSearch.setNombrePrograma(program.getNombrePrograma());
				programSearch.setTipoPrograma(program.getTipoPrograma());
				programSearch.setUbicacionPrograma(program.getUbicacionPrograma());
				programSearch.setNombreServidor(program.getNombreServidor());
				programSearch.setIdServicio(program.getIdServicio());
				log.debug("-------------------------->" + programSearch.getNombreBdd());
				log.debug("-------------------------->" + programSearch.getNombrePrograma());
				log.debug("Programa---------------------------------------------------->7" + programSearch);
				programService.saveAndFlush(programSearch);
				programSearch.getIdPrograma();
			}
			log.debug("Programa---------------------------------------------------->8" + programSearch);
			if (program.getNombreBdd() != null) {
				log.debug("Programa---------------------------------------------------->9" + programSearch);
				hmProgram.put(program.getNombreBdd() + "-" + program.getNombrePrograma(), programSearch);

			} else {
				log.debug("Programa---------------------------------------------------->10" + programSearch);
				hmProgram.put(program.getNombrePrograma(), programSearch);
			}
		}
		return programSearch;
	}

	public Variable findAndSaveVariable(Variable variable, DriverManagerDataSource dataSource) {

		Variable variableSerach = hmVariable.get(variable.getAbreviaturaVariable());

		log.debug("Variable---------------------------------------------------->1" + variableSerach);
		if (variableSerach == null) {
			log.debug("Variable---------------------------------------------------->2" + variableSerach);
			variableSerach = variableService.findByAbreviaturaVariable(variable.getAbreviaturaVariable());
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
					Programa programa = findAndSaveProgram(variable.getPrograma(), dataSource);
					log.debug("Variable---------------------------------------------------->7" + variableSerach);
					variableSerach.setPrograma(null);
					variableSerach.setIdPrograma(programa.getIdPrograma());
					log.debug("Variable---------------------------------------------------->8" + variableSerach);
				}
				if (variable.getSeudoCatalogo() != null) {
					log.debug("Variable---------------------------------------------------->9" + variableSerach);
					Programa programa = findAndSaveProgram(variable.getSeudoCatalogo(), dataSource);
					log.debug("Variable---------------------------------------------------->10" + variableSerach);
					variableSerach.setSeudoCatalogo(null);
					variableSerach.setIdSeudoCatalogo(programa.getIdPrograma());
				}
				log.debug("Variable---------------------------------------------------->11" + variableSerach.getCodigoVariable());
				log.debug("Variable---------------------------------------------------->11" + variableSerach.getPrograma().getIdPrograma());
				variableService.saveAndFlush(variableSerach);
				log.debug("Variable---------------------------------------------------->12" + variableSerach);
			}
			hmVariable.put(variable.getAbreviaturaVariable(), variableSerach);
		}
		return variableSerach;
	}

}
