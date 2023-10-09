package com.cobiscorp.ecobis.customer.bl.impl;

import java.text.SimpleDateFormat;
import java.util.Iterator;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICTSTypes;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetBlock;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetData;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetRow;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.dtos.ProcedureResponseAS;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.cobisv.commons.context.CobisSession;
import com.cobiscorp.cobisv.commons.context.Context;
import com.cobiscorp.cobisv.commons.context.ContextManager;
import com.cobiscorp.ecobis.customer.bl.CreationCustomerManager;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.util.Utils;

public class CreationCustomerManagerImpl implements CreationCustomerManager {

	private static ILogger logger = LogFactory.getLogger(CreationCustomerManagerImpl.class);
	private SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
	private ISPOrchestrator spOrchestrator;

	/**
	 * @return the spOrchestrator
	 */
	public ISPOrchestrator getSpOrchestrator() {
		return spOrchestrator;
	}

	/**
	 * @param spOrchestrator
	 *            the spOrchestrator to set
	 */
	public void setSpOrchestrator(ISPOrchestrator spOrchestrator) {
		this.spOrchestrator = spOrchestrator;
	}

	@Override
	public CustomerDataRequest normalCreationCustomer(CustomerDataResponse request) {
		CustomerDataRequest customer = null;

		logger.logDebug("Recupero datos del CobisSession");
		

		logger.logDebug("Declaro el IProcedureRequest");
		IProcedureRequest preq = new ProcedureRequestAS();

		preq = Utils.setHeaderParams(preq);

		if (preq == null) {
			logger.logDebug("ERROR: Se produjo un error al obtener el Contexto de CTS.");
		} else {

			preq.setSpName("cobis..sp_persona_ins");

			preq.addInputParam("@t_trn", ICTSTypes.SQLINT4, "103");// 103
			preq.addInputParam("@i_operacion", ICTSTypes.SQLCHAR, "I");
			preq.addInputParam("@i_nombre", ICTSTypes.SQLVARCHAR, request.getCustomerFirstName());
			preq.addInputParam("@i_p_apellido", ICTSTypes.SQLVARCHAR, request.getCustomerLastName());
			preq.addInputParam("@i_s_apellido", ICTSTypes.SQLVARCHAR, request.getCustomerSecondLastName());
			preq.addInputParam("@i_sexo", ICTSTypes.SQLVARCHAR, request.getCustomerSex());
			preq.addInputParam("@i_fecha_nac", ICTSTypes.SQLDATETIME, request.getBirthDate() == null ? "" : sdf.format(request.getBirthDate()));// request.getCustomerBirthDate().toString());//request.getCustomerBirthDate()==null?"":sdf.format(request.getCustomerBirthDate()));//fecha
			preq.addInputParam("@i_tipo_ced", ICTSTypes.SQLVARCHAR, request.getCustomerTypeDocumentId());// tipo
																											// de
																											// documento
			preq.addInputParam("@i_cedula", ICTSTypes.SQLVARCHAR, request.getCustomerIdentification());// numero
																										// de
																										// identificacion
			preq.addInputParam("@getCustomerNationality", ICTSTypes.SQLINT4, request.getCustomerNationality().toString());// nacionalidad
			preq.addInputParam("@i_categoria", ICTSTypes.SQLVARCHAR, request.getCustomerCategory());// categoria
																									// del
																									// ente
			preq.addInputParam("@i_nivel_estudio", ICTSTypes.SQLVARCHAR, request.getCustomerStudyLevel());
			preq.addInputParam("@i_tipo_vivienda", ICTSTypes.SQLVARCHAR, request.getCustomerHouseType());// tipo
																											// de
																											// vivienda
			preq.addInputParam("@i_profesion", ICTSTypes.SQLVARCHAR, request.getCustomerProfession().toString());// profesion
			preq.addInputParam("@i_estado_civil", ICTSTypes.SQLVARCHAR, request.getCustomerMaritalStatus());// estado
																											// civil
			preq.addInputParam("@i_num_cargas", ICTSTypes.SQLINT4, request.getCustomerChildrenNumber().toString());// dependientes
			preq.addInputParam("@i_nivel_ing", ICTSTypes.SQLINT4, request.getMonthlyIncome());// ingresos
																								// mensuales
			Context wContext = ContextManager.getContext();
			CobisSession wSession = (CobisSession) wContext.getSession();
			preq.addInputParam("@i_filial", ICTSTypes.SQLINT4, wSession.getOffice());// filial
			preq.addInputParam("@i_oficina", ICTSTypes.SQLINT4, wSession.getOffice());// oficina
			
			preq.addInputParam("@i_tipo", ICTSTypes.SQLVARCHAR, request.getCustomerTypePersonId());// tipo
																									// de
																									// persona
			preq.addInputParam("@i_oficial", ICTSTypes.SQLINT4, request.getCustomerOfficial().toString());// oficial
																											// principal
			preq.addInputParam("@i_oficial_sup", ICTSTypes.SQLINT4, request.getCustomerOfficialSubstitute().toString());// oficial
																														// suplente
			preq.addInputParam("@i_retencion", ICTSTypes.SQLVARCHAR, request.getCustomerRetention());// retencion
			preq.addInputParam("@i_pasaporte", ICTSTypes.SQLVARCHAR, request.getCustomerPassport());// pasaporte
			preq.addInputParam("@i_ea_estado", ICTSTypes.SQLVARCHAR, request.getCustomerStatus());// estado
																									// del
																									// cliente
			preq.addInputParam("@i_exc_sipla", ICTSTypes.SQLVARCHAR, request.getCustomerExceptionCic());// S
			preq.addInputParam("@i_ea_suc_gestion", ICTSTypes.SQLINT4, request.getCustomerManagementBranch().toString());// sucursal
																															// de
																															// gestion
			preq.addInputParam("@i_ea_menor_edad", ICTSTypes.SQLVARCHAR, request.getCustomerUnderAge()); // menos
																											// de
																											// edad
			preq.addInputParam("@i_fecha_expira", ICTSTypes.SQLDATETIME, request.getExpirationDate() == null ? "" : sdf.format(request.getExpirationDate())); // fecha
																																								// de
																																								// expiracion
			preq.addInputParam("@i_segnombre", ICTSTypes.SQLVARCHAR, request.getCustomerMiddleName());// segundo
																										// nombre
			preq.addInputParam("@i_c_apellido", ICTSTypes.SQLVARCHAR, request.getCustomerAdditionalLastName());// apellido
																												// de
																												// casada
			preq.addInputParam("@i_pais", ICTSTypes.SQLINT4, request.getCustomerCountry().toString());// pais
			preq.addInputParam("@i_ea_cliente_planilla", ICTSTypes.SQLVARCHAR, request.getCustomerPayroll());// planilla
			preq.addInputParam("@i_ea_cod_risk", ICTSTypes.SQLVARCHAR, request.getCustomerCodRisk());// codigo
																										// risk
			preq.addInputParam("@i_ea_val_id_check", ICTSTypes.SQLVARCHAR, request.getCustomerIdCheck());// validacion
																											// id
																											// check
			preq.addInputParam("@i_preferen", ICTSTypes.SQLVARCHAR, request.getCustomerPreferen());// cliente
																									// preferencial
			preq.addInputParam("@i_referido", ICTSTypes.SQLINT4, request.getCustomerReference().toString());// referido
																											// por
			preq.addInputParam("@i_comentario", ICTSTypes.SQLVARCHAR, request.getCustomerObservationEntailment());// comentarios
			preq.addInputParam("@i_actividad", ICTSTypes.SQLVARCHAR, request.getCustomerActivity());// codigo
																									// actividad
																									// del
																									// ente
			preq.addInputParam("@i_ea_empadronado", ICTSTypes.SQLVARCHAR, request.getCustomerRegistrant());// empadronado*/
			preq.addInputParam("@i_ea_act_comp_kyc", ICTSTypes.SQLVARCHAR, request.getCustomerActCompKYC());// actualizacion
																											// completa
																											// KYC
			preq.addInputParam("@i_ea_fecha_act_kyc", ICTSTypes.SQLDATETIME, request.getActKYCDate() == null ? "" : sdf.format(request.getActKYCDate()));// fecha
			preq.addInputParam("@i_ea_no_req_kyc_comp", ICTSTypes.SQLVARCHAR, request.getCustomerReqKYCNumber()); // requiere
																													// KYC
			preq.addInputParam("@i_ea_act_perfiltran", ICTSTypes.SQLVARCHAR, request.getCustomerActProfile());// actualizacion
																												// perfil
																												// transaccional
			preq.addInputParam("@i_ea_fecha_act_perfiltran", ICTSTypes.SQLDATETIME, request.getActProfileDate() == null ? "" : sdf.format(request.getActProfileDate()));// FECHA
																																										// ACTUALIZACION
																																										// PERFIL
																																										// TRANSACCIONAL
			preq.addInputParam("@i_ea_con_salario", ICTSTypes.SQLVARCHAR, request.getCustomerSalary()); // con
																										// salario
			preq.addInputParam("@i_ea_fecha_consal", ICTSTypes.SQLDATETIME, request.getInSalaryDate() == null ? "" : sdf.format(request.getInSalaryDate()));// fecha
																																							// con
																																							// salario
			preq.addInputParam("@i_ea_fecha_sinsal", ICTSTypes.SQLDATETIME, request.getOutSalaryDate() == null ? "" : sdf.format(request.getOutSalaryDate()));// fecha
																																								// sin
																																								// salario
			preq.addInputParam("@i_ea_lin_neg", ICTSTypes.SQLVARCHAR, request.getCustomerBusinessLine());// linea
																											// de
																											// negocio
			preq.addInputParam("@i_ea_seg_neg", ICTSTypes.SQLVARCHAR, request.getCustomerBusinessSeg());// segmento
																										// de
																										// negocio
			preq.addInputParam("@i_ea_actualizacion_cic", ICTSTypes.SQLVARCHAR, request.getCustomerUpdateCic());// actualizacion
																												// CIC

			ProcedureResponseAS wProcedureResponseAS = (ProcedureResponseAS) spOrchestrator.execute(preq, null, null);
			wProcedureResponseAS = (ProcedureResponseAS) wProcedureResponseAS.parseMessageData();

			Iterator it = wProcedureResponseAS.getResultSets().iterator();
			Iterator itMessage = wProcedureResponseAS.getMessages().iterator();

			while (it.hasNext()) {
				IResultSetBlock resulSetBlock = (IResultSetBlock) it.next();
				IResultSetData resultSetData = resulSetBlock.getData();
				for (int i = 1; i <= resultSetData.getRowsNumber(); ++i) {
					customer = new CustomerDataRequest();
					IResultSetRow row = resultSetData.getRow(i);
					if (row.getRowData(1).getValue() != null) {
						customer.setCustomerId(Integer.parseInt(row.getRowData(1).getValue()));
					}
				}
			}
		}

		return customer;
	}
}
