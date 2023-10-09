package com.cobiscorp.ecobis.bpl.extractor.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cobiscorp.ecobis.bpl.rules.engine.model.Programa;

public interface ProgramaRepository extends JpaRepository<Programa, Short>{

	Programa findByNombreBddAndNombrePrograma(String nombreBdd, String nombrePrograma);
	
	Programa findByNombrePrograma(String nombrePrograma);
	
}