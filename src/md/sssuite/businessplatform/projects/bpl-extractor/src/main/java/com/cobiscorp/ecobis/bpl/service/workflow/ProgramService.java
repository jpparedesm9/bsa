package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.HashMap;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.rules.engine.model.Programa;

public interface ProgramService {

	HashMap<String, Programa> hmProgram = new HashMap<String, Programa>();

	Programa findAndSaveProgram(Programa program, DriverManagerDataSource dataSource);

	Programa findByNombreBddAndNombrePrograma(String nombreBdd, String nombrePrograma);

	Programa findByNombrePrograma(String nombrePrograma);

	Programa saveAndFlush(Programa programa);

}
