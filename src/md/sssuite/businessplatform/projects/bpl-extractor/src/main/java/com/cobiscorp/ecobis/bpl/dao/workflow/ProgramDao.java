package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.HashMap;

import com.cobiscorp.ecobis.bpl.rules.engine.model.Programa;

public interface ProgramDao {

	HashMap<String, Programa> hmProgram = new HashMap<String, Programa>();

	Programa findByNombreBddAndNombrePrograma(String nombreBdd, String nombrePrograma);

	Programa findByNombrePrograma(String nombrePrograma);

	Programa saveAndFlush(Programa programa);

}
