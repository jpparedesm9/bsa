package com.cobiscorp.cobis.assets.reports.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cobiscorp.ecobis.assets.cloud.dto.AccountAmortizacion;
import cobiscorp.ecobis.assets.cloud.dto.AccountStatusRequest;
import cobiscorp.ecobis.assets.cloud.dto.DetailMovementsResponse;
import cobiscorp.ecobis.assets.cloud.dto.HeaderStateAccountResponse;
import cobiscorp.ecobis.assets.cloud.dto.LoanInformationResponse;
import cobiscorp.ecobis.assets.cloud.dto.TotalMovementsResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.assets.reports.commons.Util;
import com.cobiscorp.cobis.assets.reports.dto.AccountStatusAmortizationTableDTO;
import com.cobiscorp.cobis.assets.reports.dto.AccountStatusMovementDTO;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

/* 			ESTA CLASE QUEDA INACTIVA DEBIDO A QUE YA NO EXISTE LA PANTALLA
 *          DE LLAMADO LOS FUENTES DEL JASPER FUERON MOVIDOS AL NOTIFICADOR 
 *          QUE ES DONDE SE ESTAN USANDO ACTUALMENTE */


/**
 * Clase utilizada llamar a los servicios generados por SG
 * 
 * @author CobisCorp
 * 
 */
public class AccountStatusService extends BaseService {
	private static final ILogger logger = LogFactory.getLogger(AccountStatusService.class);
	Util util = new Util();

	/***
	 * Informacion para tabla de amortizacion
	 * 
	 * @param
	 * @param
	 * @param
	 * @return List AccountStatusAmortizationTableDTO
	 */
	public List<AccountStatusAmortizationTableDTO> getListAmortizationTable(AccountStatusRequest accountStatusRequest, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("----->>>Inicio AccountStatusService -- getListAmortizationTable:");
		List<AccountStatusAmortizationTableDTO> dataBeanList = new ArrayList<AccountStatusAmortizationTableDTO>();

		AccountAmortizacion[] sDetailAmortizacion = searchDetailAmortizacion(accountStatusRequest, serviceIntegration);

		if (sDetailAmortizacion != null) {
			for (AccountAmortizacion sDAmortizacion : sDetailAmortizacion) {
				AccountStatusAmortizationTableDTO aSAmortizationTableDTO = new AccountStatusAmortizationTableDTO();
				aSAmortizationTableDTO.setTaNumPago(sDAmortizacion.getNumero());
				aSAmortizationTableDTO.setTaFechaLimitePago(sDAmortizacion.getFecha());
				if (sDAmortizacion.getCapital() != null)
					aSAmortizationTableDTO.setTaAbonoPrincipal(sDAmortizacion.getCapital().doubleValue());
				if (sDAmortizacion.getInteres() != null)
					aSAmortizationTableDTO.setTaInteresOrdinarios(sDAmortizacion.getInteres().doubleValue());
				if (sDAmortizacion.getIvaInt() != null)
					aSAmortizationTableDTO.setTaIvaInteresOrdinarios(sDAmortizacion.getIvaInt().doubleValue());
				if (sDAmortizacion.getComision() != null)
					aSAmortizationTableDTO.setTaComisionGastCobranza(sDAmortizacion.getComision().doubleValue());
				if (sDAmortizacion.getComision() != null)
					aSAmortizationTableDTO.setTaIvaGastosCobranza(sDAmortizacion.getIvaCom().doubleValue());
				if (sDAmortizacion.getMontoPago() != null)
					aSAmortizationTableDTO.setTaMontoPago(sDAmortizacion.getMontoPago().doubleValue());
				if (sDAmortizacion.getSaldo() != null)
					aSAmortizationTableDTO.setTaSaldoInsolutoCap(sDAmortizacion.getSaldo().doubleValue());
				dataBeanList.add(aSAmortizationTableDTO);
			}
		} else {
			AccountStatusAmortizationTableDTO aSAmortizationTableDTO = new AccountStatusAmortizationTableDTO();
			aSAmortizationTableDTO.setTaNumPago(0);
			aSAmortizationTableDTO.setTaFechaLimitePago("-");
			aSAmortizationTableDTO.setTaAbonoPrincipal(0.0);
			aSAmortizationTableDTO.setTaInteresOrdinarios(0.0);
			aSAmortizationTableDTO.setTaIvaInteresOrdinarios(0.0);
			aSAmortizationTableDTO.setTaComisionGastCobranza(0.0);
			aSAmortizationTableDTO.setTaIvaGastosCobranza(0.0);
			aSAmortizationTableDTO.setTaMontoPago(0.0);
			aSAmortizationTableDTO.setTaSaldoInsolutoCap(0.0);
			dataBeanList.add(aSAmortizationTableDTO);
		}
		return dataBeanList;
	}

	/***
	 * Informacion para tabla de movimientos
	 * 
	 * @param
	 * @param
	 * @param
	 * @return List AccountStatusMovementDTO
	 */

	public List<AccountStatusMovementDTO> getListMovement(AccountStatusRequest accountStatusRequest, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("----->>>Inicio AccountStatusService -- getListMovement:");
		List<AccountStatusMovementDTO> dataBeanList = new ArrayList<AccountStatusMovementDTO>();

		DetailMovementsResponse[] sDetailMovements = searchDetailMovements(accountStatusRequest, serviceIntegration);

		if (sDetailMovements != null) {
			for (DetailMovementsResponse sDMovements : sDetailMovements) {

				AccountStatusMovementDTO aSMovementDTO = new AccountStatusMovementDTO();

				aSMovementDTO.setNumero(sDMovements.getNumero());
				aSMovementDTO.setFechaOperacion(sDMovements.getFechaOperacion());
				aSMovementDTO.setFechaPactada(sDMovements.getFechaPactada());
				aSMovementDTO.setNumPago(sDMovements.getNumeroPago());
				aSMovementDTO.setDiasAtraso(sDMovements.getDiasAtraso());
				aSMovementDTO.setDetalleMovimiento(sDMovements.getMovimiento());
				if (sDMovements.getTotal() != null)
					aSMovementDTO.setTotal(sDMovements.getTotal().doubleValue());
				if (sDMovements.getCapital() != null)
					aSMovementDTO.setCapital(sDMovements.getCapital().doubleValue());
				if (sDMovements.getInteresOrd() != null)
					aSMovementDTO.setInteresOrdinario(sDMovements.getInteresOrd().doubleValue());
				if (sDMovements.getComision() != null)
					aSMovementDTO.setComisionGastoCobranza(sDMovements.getComision().doubleValue());
				if (sDMovements.getIvaInt() != null)
					aSMovementDTO.setIvaInt(sDMovements.getIvaInt().doubleValue());
				if (sDMovements.getIvaConMora() != null)
					aSMovementDTO.setIvaMora(sDMovements.getIvaConMora().doubleValue());
				if (sDMovements.getOtros() != null)
					aSMovementDTO.setOtros(sDMovements.getOtros().doubleValue());
				if (sDMovements.getSaldoCapital() != null)
					aSMovementDTO.setSaldoInsoluto(sDMovements.getSaldoCapital().doubleValue());
				dataBeanList.add(aSMovementDTO);
			}
		} else {
			AccountStatusMovementDTO aSMovementDTO = new AccountStatusMovementDTO();
			aSMovementDTO.setNumero(0);
			aSMovementDTO.setFechaOperacion("-");
			aSMovementDTO.setFechaPactada("-");
			aSMovementDTO.setNumPago(0);
			aSMovementDTO.setDiasAtraso(0);
			aSMovementDTO.setDetalleMovimiento("-");
			aSMovementDTO.setTotal(0.0);
			aSMovementDTO.setCapital(0.0);
			aSMovementDTO.setInteresOrdinario(0.0);
			aSMovementDTO.setComisionGastoCobranza(0.0);
			aSMovementDTO.setIvaInt(0.0);
			aSMovementDTO.setIvaMora(0.0);
			aSMovementDTO.setOtros(0.0);
			aSMovementDTO.setSaldoInsoluto(0.0);
			dataBeanList.add(aSMovementDTO);
		}
		return dataBeanList;
	}

	// "Loan.StateAccount.SearchDetailAmortizacion"
	public AccountAmortizacion[] searchDetailAmortizacion(AccountStatusRequest accountStatusRequest, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("----->>>Inicio AccountStatusService -- searchDetailAmortizacion");
		ServiceResponseTO serviceResponseTo = null;
		try {
			ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICE_SEARCH_DET_AMORTIZATION);
			serviceReportRequestTO.getData().put(ConstantValue.IN_ACCOUNT_STATUS, accountStatusRequest);

			serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo != null) {
				if (serviceResponseTo.isSuccess()) {
					AccountAmortizacion[] accountAmortizacion = (AccountAmortizacion[]) serviceResponseTo.getValue(ConstantValue.RETURN_ACCOUNT_AMORTIZACION);
					return accountAmortizacion;
				} else {
					if (logger.isDebugEnabled())
						logger.logDebug("Error ejecucion servicio searchDetailAmortizacion");
					util.error(serviceResponseTo);
				}
			}
		} catch (Exception ex) {
			if (logger.isDebugEnabled())
				logger.logError("Error en " + ConstantValue.SERVICE_SEARCH_DET_AMORTIZATION, ex);
			util.error(serviceResponseTo);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("Finaliza " + ConstantValue.SERVICE_SEARCH_DET_AMORTIZATION);
		}
		return null;
	}

	// "Loan.StateAccount.SearchDetailMovements"
	public DetailMovementsResponse[] searchDetailMovements(AccountStatusRequest accountStatusRequest, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("----->>>Inicio AccountStatusService -- searchDetailMovements");
		ServiceResponseTO serviceResponseTo = null;
		try {
			ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICE_SEARCH_DET_MOVEMENTS);
			serviceReportRequestTO.getData().put(ConstantValue.IN_ACCOUNT_STATUS, accountStatusRequest);

			serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo != null) {
				if (serviceResponseTo.isSuccess()) {
					DetailMovementsResponse[] detailMovementsResponse = (DetailMovementsResponse[]) serviceResponseTo.getValue(ConstantValue.RETURN_DETAIL_MOVEMENTS);
					return detailMovementsResponse;
				} else {
					if (logger.isDebugEnabled())
						logger.logDebug("Error ejecucion servicio searchDetailMovements");
					util.error(serviceResponseTo);
				}
			}
		} catch (Exception ex) {
			if (logger.isDebugEnabled())
				logger.logError("Error en " + ConstantValue.SERVICE_SEARCH_DET_MOVEMENTS, ex);
			util.error(serviceResponseTo);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("Finaliza " + ConstantValue.SERVICE_SEARCH_DET_MOVEMENTS);
		}
		return null;
	}

	// "Loan.StateAccount.SearchMovementsTotal"
	public TotalMovementsResponse searchTotalMovements(AccountStatusRequest accountStatusRequest, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("----->>>Inicio AccountStatusService -- searchTotalMovements");
		ServiceResponseTO serviceResponseTo = null;
		try {
			ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICE_SEARCH_TOTAL_MOVEMENTS);
			serviceReportRequestTO.getData().put(ConstantValue.IN_ACCOUNT_STATUS, accountStatusRequest);

			serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo != null) {
				if (serviceResponseTo.isSuccess()) {
					TotalMovementsResponse detailMovementsResponse = (TotalMovementsResponse) serviceResponseTo.getValue(ConstantValue.RETURN_TOTAL_MOVEMENTS);
					return detailMovementsResponse;
				} else {
					if (logger.isDebugEnabled())
						logger.logDebug("Error ejecucion servicio searchDetailMovements");
					util.error(serviceResponseTo);
				}
			}
		} catch (Exception ex) {
			if (logger.isDebugEnabled())
				logger.logError("Error en " + ConstantValue.SERVICE_SEARCH_TOTAL_MOVEMENTS, ex);
			util.error(serviceResponseTo);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("Finaliza " + ConstantValue.SERVICE_SEARCH_TOTAL_MOVEMENTS);
		}
		return null;
	}

	// "Loan.StateAccount.SearchLoanInformation"
	public LoanInformationResponse searchLoanInformation(AccountStatusRequest accountStatusRequest, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("----->>>Inicio AccountStatusService -- searchLoanInformation");
		ServiceResponseTO serviceResponseTo = null;
		try {
			ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICE_SEARCH_LOAN_INFORMATION);
			serviceReportRequestTO.getData().put(ConstantValue.IN_ACCOUNT_STATUS, accountStatusRequest);

			serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo != null) {
				if (serviceResponseTo.isSuccess()) {
					LoanInformationResponse loanInformationResponse = (LoanInformationResponse) serviceResponseTo.getValue(ConstantValue.RETURN_LOAN_INFORMATION);
					return loanInformationResponse;
				} else {
					if (logger.isDebugEnabled())
						logger.logDebug("Error ejecucion servicio " + ConstantValue.SERVICE_SEARCH_LOAN_INFORMATION);
					util.error(serviceResponseTo);
				}
			}
		} catch (Exception ex) {
			if (logger.isDebugEnabled())
				logger.logError("Error en " + ConstantValue.SERVICE_SEARCH_LOAN_INFORMATION, ex);
			util.error(serviceResponseTo);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("Finaliza " + ConstantValue.SERVICE_SEARCH_LOAN_INFORMATION);
		}
		return null;
	}

	// "Loan.StateAccount.SearchStateSccountHeadboard";
	public HeaderStateAccountResponse searchStateSccountHeadboard(AccountStatusRequest accountStatusRequest, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("----->>>Inicio AccountStatusService -- searchStateSccountHeadboard");
		ServiceResponseTO serviceResponseTo = null;

		try {
			ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICE_SEARCH_STATE_ACCOUNT_HEADER);
			serviceReportRequestTO.getData().put(ConstantValue.IN_ACCOUNT_STATUS, accountStatusRequest);

			serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo != null) {
				if (serviceResponseTo.isSuccess()) {
					HeaderStateAccountResponse headerStateAccountResponse = (HeaderStateAccountResponse) serviceResponseTo.getValue(ConstantValue.RETURN_HEADER_STATE_ACCOUNT);
					return headerStateAccountResponse;
				} else {
					if (logger.isDebugEnabled())
						logger.logDebug("Error ejecucion servicio " + ConstantValue.SERVICE_SEARCH_STATE_ACCOUNT_HEADER);
					util.error(serviceResponseTo);
				}
			}
		} catch (Exception ex) {
			if (logger.isDebugEnabled())
				logger.logError("Error en " + ConstantValue.SERVICE_SEARCH_STATE_ACCOUNT_HEADER, ex);
			util.error(serviceResponseTo);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("Finaliza " + ConstantValue.SERVICE_SEARCH_STATE_ACCOUNT_HEADER);
		}
		return null;
	}

	// "Loan.StateAccount.ExecutionOptions"
	public Integer executionOptions(AccountStatusRequest accountStatusRequest, ICTSServiceIntegration serviceIntegration) {
		logger.logDebug("----->>>Inicio AccountStatusService -- executionOptions - numeroBanco:" + accountStatusRequest.getBanco());
		ServiceResponseTO serviceResponseTo = null;
		Integer sequential = 0;
		try {
			ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICE_EXECUTE_OPTION);
			serviceReportRequestTO.getData().put(ConstantValue.IN_ACCOUNT_STATUS, accountStatusRequest);

			serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo != null) {
				if (serviceResponseTo.isSuccess()) {
					@SuppressWarnings("unchecked")
					Map<String, Object> accountStatusResponse = (Map<String, Object>) serviceResponseTo.getValue("com.cobiscorp.cobis.cts.service.response.output");
					if (accountStatusResponse.get("@o_secuencial") != null) {
						return sequential = Integer.parseInt(accountStatusResponse.get("@o_secuencial").toString());
					}
					logger.logDebug("----->>>AccountStatusService - executionOptions --sequential:" + sequential);
				} else {
					if (logger.isDebugEnabled()) {
						logger.logDebug("Error ejecucion servicio " + ConstantValue.SERVICE_EXECUTE_OPTION + "-NumeroBanco" + accountStatusRequest.getBanco());
						logger.logDebug("Error ejecucion servicio " + ConstantValue.SERVICE_EXECUTE_OPTION + "-NumeroBanco" + serviceResponseTo.getData());
					}
					throw new RuntimeException("ERROR AccountStatusServlet getDatasourceReport:" + serviceResponseTo.getMessages());
					// util.error(serviceResponseTo);
				}
			}
		} catch (Exception ex) {
			if (logger.isDebugEnabled())
				logger.logError("Error en " + ConstantValue.SERVICE_EXECUTE_OPTION + ":" + accountStatusRequest.getBanco(), ex);
			util.error(serviceResponseTo);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("Finaliza " + ConstantValue.SERVICE_EXECUTE_OPTION);
		}
		logger.logDebug("Fin metodo executionOptions, servicio:" + ConstantValue.SERVICE_EXECUTE_OPTION + " -- NumeroBanco:" + accountStatusRequest.getBanco() + " -- Numero Secuencial:" + sequential);
		return null;
	}
}
