/**
 * Archivo: public interface IBuroCustomerUtil 
 * Autor..: Team Evac
 *
 * Esta aplicacion es parte de los paquetes bancarios propiedad de COBISCORP.
 * Su uso no autorizado queda expresamente prohibido asi como cualquier
 * alteracion o agregado hecho por alguno de sus usuarios sin el debido
 * consentimiento por escrito de COBISCORP.
 * Este programa esta protegido por la ley de derechos de autor y por las
 * convenciones internacionales de propiedad intelectual. Su uso no
 * autorizado dara derecho a COBISCORP para obtener ordenes de secuestro
 * o retencion y para perseguir penalmente a los autores de cualquier infraccion.
 */

package com.cobiscorp.ecobis.cobiscloudburo.bsl.serv.bsl;

import java.math.BigDecimal;
import java.util.Map;

public interface IBuroCustomerUtil {
	Integer createBuroAccount(com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Cuenta aData, Integer aEnte);

	Integer createBuroResume(com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ResumenReporte aData, Integer aEnte);

	Integer createBuroScore(com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ScoreBC aData, Integer aEnte);

	Integer createBuroJob(com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Empleo aData, Integer aEnte);

	Integer createMadeQuerys(com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.ConsultaEfectuada aData, Integer aEnte);

	Integer createBuroAddress(com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Domicilio aData, Integer aEnte);

	Integer createBuroHeader(com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Encabezado aData, Integer aEnte);

	Integer deleteBuroAccounts(Integer aClientId);

	Integer deleteBuroRemuseReports(Integer aClientId);

	Integer deleteBuroScore(Integer aClientId);

	Integer deleteBuroJob(Integer aClientId);

	Integer deleteMadeQuerys(Integer aClientId);

	Integer deleteBuroAddress(Integer aClientId);

	com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Header generateHeader();
	
	com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.Header generateHeader(String aRequiredProduct);

	String getBlackList(Integer aClientId);

	Integer getBlackListCustomer(Integer aClientId);

	String getDelayPercentage(Integer aClientId);

	String isPartner(Integer aClientId);

	String riesgoIndExt(Integer aClientId, Integer validityBureauDays, String typeRatingCustomerEval, String evaluateRule);
	
	Double digCustomerCreditAmount(Integer aClientId);
	
	String digCustomerQualification(Integer aClientId);
	
	String riesgoIndividual(Integer aClientId);
	
	String generateMatrix(Integer aClientId);
	
	com.cobiscorp.ecobis.cobiscloudburo.util.dto.BuroResponse simulateBuroExecution(com.cobiscorp.ecobis.cobiscloudburo.util.dto.BuroRequest aRequest);
	
	Map<?, ?> newCustomeRulesEvaluation(Map<String, Object> parameterMap);
	
	Map<?, ?> riesgoIndExtMap(Map<String, Object> parameterMap);

	Double customerAmountApproved(Integer aClientId);

}
