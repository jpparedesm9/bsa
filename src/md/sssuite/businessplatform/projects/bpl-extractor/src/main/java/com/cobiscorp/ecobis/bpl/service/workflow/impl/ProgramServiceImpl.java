package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import org.apache.log4j.Logger;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.dao.workflow.ProgramDao;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Programa;
import com.cobiscorp.ecobis.bpl.service.workflow.ProgramService;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;

public class ProgramServiceImpl implements ProgramService {

	static Logger log = Logger.getLogger(ProgramServiceImpl.class);

	private ProgramDao programDao;

	/**
	 * @return the programDao
	 */
	public ProgramDao getProgramDao() {
		return programDao;
	}

	/**
	 * @param programDao
	 *            the programDao to set
	 */
	public void setProgramDao(ProgramDao programDao) {
		this.programDao = programDao;
	}

	public Programa findAndSaveProgram(Programa program, DriverManagerDataSource dataSource) {

		// Declaro la clase para ejecutar el seqnos
		SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);

		// El hasmap debe estar al inicio conmo campo de la clase

		Programa programSearch = hmProgram.get(program.getNombreBdd() + "-" + program.getNombrePrograma());

		log.debug("Programa---------------------------------------------------->1" + programSearch);

		if (programSearch == null) {

			log.debug("Programa---------------------------------------------------->2" + programSearch);

			// if (program.getNombreBdd() != null) {
			// log.debug("Programa---------------------------------------------------->3.1" + program.getNombreBdd()+"-"+program.getNombrePrograma());
			// programSearch = programDao.findByNombreBddAndNombrePrograma(program.getNombreBdd(), program.getNombrePrograma());
			// log.debug("Programa---------------------------------------------------->3.2" + program.getNombreBdd()+"-"+program.getNombrePrograma());
			// } else {
			log.debug("Programa---------------------------------------------------->3" + program.getNombrePrograma());
			programSearch = findByNombrePrograma(program.getNombrePrograma());
			log.debug("Programa---------------------------------------------------->4" + program.getNombrePrograma());
			// }

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
				programDao.saveAndFlush(programSearch);
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

	public Programa findByNombreBddAndNombrePrograma(String nombreBdd, String nombrePrograma) {
		return programDao.findByNombreBddAndNombrePrograma(nombreBdd, nombrePrograma);
	}

	public Programa findByNombrePrograma(String nombrePrograma) {
		return programDao.findByNombrePrograma(nombrePrograma);
	}

	public Programa saveAndFlush(Programa programa) {
		return programDao.saveAndFlush(programa);
	}
}
