package com.cobiscorp.cobis.assets.reports.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

import cobiscorp.ecobis.assets.cloud.dto.QueryPaymentTableDetail;
import cobiscorp.ecobis.assets.cloud.dto.QueryPaymentTableDetailObj;
import cobiscorp.ecobis.assets.cloud.dto.QueryPaymentTableHead;
import cobiscorp.ecobis.assets.cloud.dto.QueryPaymentTableRequest;
import cobiscorp.ecobis.assets.cloud.dto.ReportOfficeRequest;
import cobiscorp.ecobis.assets.cloud.dto.ReportOfficeResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/**
 * Clase utilizada llamar a los servicios generados por SG
 * 
 * @author CobisCorp
 *
 */
public class PaymentTableService extends BaseService {
	private static final ILogger logger = LogFactory.getLogger(PaymentTableService.class);
	public static final Integer FORMAT_DATE = 101;

	/**
	 * Obtine la informacion para el reporte de tabla de amortizacion
	 * 
	 * @param queryPaymentTableRequest
	 * @param serviceIntegration
	 * @return
	 */
	public QueryPaymentTableHead queryPaymentTable(QueryPaymentTableRequest queryPaymentTableRequest,
			ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug(" *****START queryPaymentTable \nbank " + queryPaymentTableRequest.getBank());
		}
		QueryPaymentTableHead queryPaymentTableHead = queryPaymentTableHead(ConstantValue.SERVICE_PAYMENT_TABLE_HEAD,
				queryPaymentTableRequest, serviceIntegration);

		setDatails(queryPaymentTableHead, queryPaymentTableRequest, serviceIntegration,
				ConstantValue.SERVICE_PAYMENT_TABLE_DETAIL);

		if (logger.isDebugEnabled()) {
			logger.logDebug(" *****END queryPaymentTable");
		}
		return queryPaymentTableHead;
	}

	/**
	 * * Obtine la informacion para el reporte de tabla de amortizacion
	 * consultando en la base de datos cob_cartera_his
	 * 
	 * @param queryPaymentTableRequest
	 * @param serviceIntegration
	 * @return
	 */
	public QueryPaymentTableHead queryPaymentTableHist(QueryPaymentTableRequest queryPaymentTableRequest,
			ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug(" *****START queryPaymentTableHist \nbank " + queryPaymentTableRequest.getBank());
		}
		QueryPaymentTableHead queryPaymentTableHead = queryPaymentTableHead(
				ConstantValue.SERVICE_PAYMENT_TABLE_HEAD_HIS, queryPaymentTableRequest, serviceIntegration);

		setDatails(queryPaymentTableHead, queryPaymentTableRequest, serviceIntegration,
				ConstantValue.SERVICE_PAYMENT_TABLE_DETAILS_HIS);

		if (logger.isDebugEnabled()) {
			logger.logDebug(" *****END queryPaymentTableHist");
		}
		return queryPaymentTableHead;
	}

	/***
	 * Obtiene la informacion de la cabecera del reporte tabla de amortizacion
	 * 
	 * @param sessionId
	 * @param dueDate
	 * @param serviceIntegration
	 * @return
	 */
	public QueryPaymentTableHead queryPaymentTableHead(String nameService,
			QueryPaymentTableRequest queryPaymentTableRequest, ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug(" *****START queryPaymentTableHead bank " + queryPaymentTableRequest.getBank()
					+ " nameService " + nameService);
		}

		if (queryPaymentTableRequest.getBank() == null) {
			return null;
		}
		ServiceRequestTO serviceReportRequestTO = getHeaderRequest(nameService);
		// Setea el objeto(Request) utilizado para la consulta del sp
		queryPaymentTableRequest.setOperation("C");
		queryPaymentTableRequest.setDateFormat(FORMAT_DATE);

		// Setea el ServiceRequestTO con el Objecto Request
		serviceReportRequestTO.getData().put(ConstantValue.IN_PAYMENT_TABLE_REQUEST, queryPaymentTableRequest);
		// Obtiene la respuesta del servicio
		ServiceResponseTO serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);

		if (serviceResponseTo.isSuccess()) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(" *****SUCCESS SERVICE PAYMENT HEAD"
						+ (serviceResponseTo.getValue(ConstantValue.RETURN_PAYMENT_TABLE_HEAD)));
			}
			// Si es exitosa la ejecucion se obtinene el objeto Response
			QueryPaymentTableHead queryPaymentTableHead = (QueryPaymentTableHead) (serviceResponseTo
					.getValue(ConstantValue.RETURN_PAYMENT_TABLE_HEAD));

			setValueHeader(queryPaymentTableHead, queryPaymentTableRequest);
			setValueFooter(queryPaymentTableHead, serviceIntegration);

			return queryPaymentTableHead;
		} else {
			if (logger.isDebugEnabled())
				logger.logDebug(" *****-- FALL SERVICE PAYMENT HEAD");
			util.error(serviceResponseTo);
			return null;
		}
	}

	/***
	 * 
	 * @param reportOfficeRequest
	 * @param serviceIntegration
	 * @return
	 */
	private ReportOfficeResponse queryOfficeProcesDate(String nameService, ReportOfficeRequest reportOfficeRequest,
			ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug(" *****START queryOfficeProcesDate " + nameService);
		}
		if (ConstantValue.SERVICE_OFFICE.equals(nameService) && reportOfficeRequest.getBank() == null) {
			return null;
		}
		if (ConstantValue.SERVICE_PROCESSING_DATE.equals(nameService)) {
			reportOfficeRequest.setOperation("S");
			reportOfficeRequest.setDateFormat(FORMAT_DATE);

		}
		ServiceRequestTO serviceReportRequestTO = getHeaderRequest(nameService);

		// Setea el ServiceRequestTO con el Objecto Request
		serviceReportRequestTO.getData().put(ConstantValue.IN_REPORT_OFFICE_REQUEST, reportOfficeRequest);
		// Obtiene la respuesta del servicio
		ServiceResponseTO serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);

		if (serviceResponseTo.isSuccess()) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(" *****SUCCESS SERVICE PAYMENT TABLE queryOfficeProcesDate"
						+ (serviceResponseTo.getValue(ConstantValue.RETURN_REPORT_OFFICE_RESPONSE)));
			}
			// Si es exitosa la ejecucion se obtinene el objeto Response

			return (ReportOfficeResponse) (serviceResponseTo.getValue(ConstantValue.RETURN_REPORT_OFFICE_RESPONSE));

		} else {
			if (logger.isDebugEnabled())
				logger.logDebug(" *****-- FALL SERVICE PAYMENT TABLE OFFICE");
			util.error(serviceResponseTo);
			return null;
		}
	}

	/***
	 * Obtiene la informacion de la tabla de amortizacion
	 * 
	 * @param sessionId
	 * @param dueDate
	 * @param serviceIntegration
	 * @return
	 */
	public List<QueryPaymentTableDetailObj> queryPaymentTableDetail(String nameService,
			QueryPaymentTableRequest queryPaymentTableRequest, ICTSServiceIntegration serviceIntegration,
			QueryPaymentTableHead queryPaymentTableHead, Map<String, Object> params) {
		if (logger.isDebugEnabled()) {
			logger.logDebug(" *****START queryPaymentTableDetail bank " + queryPaymentTableRequest.getBank()
					+ " nameService " + nameService);
		}

		List<QueryPaymentTableDetailObj> queryPaymentTableDetailObjs = new ArrayList<QueryPaymentTableDetailObj>();

		if (queryPaymentTableRequest.getBank() == null) {
			return queryPaymentTableDetailObjs;
		}

		ServiceRequestTO serviceReportRequestTO = getHeaderRequest(nameService);
		// Setea el objeto(Request) utilizado para la consulta del sp
		queryPaymentTableRequest.setOperation("D");
		queryPaymentTableRequest.setDateFormat(FORMAT_DATE);

		// Setea el ServiceRequestTO con el Objecto Request
		serviceReportRequestTO.getData().put(ConstantValue.IN_PAYMENT_TABLE_REQUEST, queryPaymentTableRequest);
		// Obtiene la respuesta del servicio
		ServiceResponseTO serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
		if (serviceResponseTo.isSuccess()) {
			if (logger.isDebugEnabled()) {
				logger.logDebug(" *****SUCCESS SERVICE PAYMENT DETAIL");
			}
			// Si es exitosa la ejecucion se obtinene el objeto Response
			if (params != null) {
				params.put(ConstantValue.RETURN_PAY_TABLE_CAPITAL,
						serviceResponseTo.getValue(ConstantValue.RETURN_PAY_TABLE_CAPITAL));
				params.put(ConstantValue.RETURN_PAY_TABLE_INTERES,
						serviceResponseTo.getValue(ConstantValue.RETURN_PAY_TABLE_INTERES));
				params.put(ConstantValue.RETURN_PAY_TABLE_OTROS,
						serviceResponseTo.getValue(ConstantValue.RETURN_PAY_TABLE_OTROS));
				params.put(ConstantValue.RETURN_PAY_TABLE_ABONOS,
						serviceResponseTo.getValue(ConstantValue.RETURN_PAY_TABLE_ABONOS));
				params.put(ConstantValue.RETURN_PAY_TABLE_ESTADO,
						serviceResponseTo.getValue(ConstantValue.RETURN_PAY_TABLE_ESTADO));
				params.put(ConstantValue.RETURN_PAY_TABLE_MIPYMES,
						serviceResponseTo.getValue(ConstantValue.RETURN_PAY_TABLE_MIPYMES));
				params.put(ConstantValue.RETURN_PAY_TABLE_IVA_MIPYMES,
						serviceResponseTo.getValue(ConstantValue.RETURN_PAY_TABLE_IVA_MIPYMES));
				params.put(ConstantValue.RETURN_PAY_TABLE_COMISION,
						serviceResponseTo.getValue(ConstantValue.RETURN_PAY_TABLE_COMISION));
				params.put(ConstantValue.RETURN_PAY_TABLE_IVA_COMISION,
						serviceResponseTo.getValue(ConstantValue.RETURN_PAY_TABLE_IVA_COMISION));
				params.put(ConstantValue.RETURN_PAY_TABLE_SEGURO,
						serviceResponseTo.getValue(ConstantValue.RETURN_PAY_TABLE_SEGURO));
				params.put(ConstantValue.RETURN_PAY_TABLE_INTERES_MORA,
						serviceResponseTo.getValue(ConstantValue.RETURN_PAY_TABLE_INTERES_MORA));
				params.put(ConstantValue.RETURN_PAY_TABLE_INTERES_SEGUROS,
						serviceResponseTo.getValue(ConstantValue.RETURN_PAY_TABLE_INTERES_SEGUROS));
				params.put(ConstantValue.RETURN_PAY_TABLE_INTERES_CAPIT,
						serviceResponseTo.getValue(ConstantValue.RETURN_PAY_TABLE_INTERES_CAPIT));
				params.put(ConstantValue.RETURN_PAY_TABLE_DISPONIBLES,
						serviceResponseTo.getValue(ConstantValue.RETURN_PAY_TABLE_DISPONIBLES));

				setDetailPaymentTable(params, queryPaymentTableHead, queryPaymentTableDetailObjs);
			}
		} else {
			if (logger.isDebugEnabled())
				logger.logDebug(" *****-- FALL SERVICE PAYMENT DETAIL");
			util.error(serviceResponseTo);

		}
		return queryPaymentTableDetailObjs;
	}

	/***
	 * Crear la tabla de amortizacion
	 * 
	 * @param params
	 * @param queryPaymentTableHead
	 * @param queryPaymentTableDetailObjs
	 * @return
	 */
	private List<QueryPaymentTableDetailObj> setDetailPaymentTable(Map<String, Object> params,
			QueryPaymentTableHead queryPaymentTableHead, List<QueryPaymentTableDetailObj> queryPaymentTableDetailObjs) {

		if (params != null) {
			QueryPaymentTableDetail[] detailCapital = (QueryPaymentTableDetail[]) params
					.get(ConstantValue.RETURN_PAY_TABLE_CAPITAL);
			QueryPaymentTableDetail[] detailInteres = (QueryPaymentTableDetail[]) params
					.get(ConstantValue.RETURN_PAY_TABLE_INTERES);
			QueryPaymentTableDetail[] detailEstado = (QueryPaymentTableDetail[]) params
					.get(ConstantValue.RETURN_PAY_TABLE_ESTADO);
			QueryPaymentTableDetail[] detailInteCap = (QueryPaymentTableDetail[]) params
					.get(ConstantValue.RETURN_PAY_TABLE_INTERES_CAPIT);
			QueryPaymentTableDetail[] detailDisponibles = (QueryPaymentTableDetail[]) params
					.get(ConstantValue.RETURN_PAY_TABLE_DISPONIBLES);

			if (detailCapital == null || (detailCapital.length < 0)) {
				return queryPaymentTableDetailObjs;
			}

			for (int i = 0; i < detailCapital.length; i++) {
				QueryPaymentTableDetailObj queryPaymentTableDetailObj = new QueryPaymentTableDetailObj();

				queryPaymentTableDetailObj.setDividend(detailCapital[i].getQuotaNumber());
				params.put("dividendCap", queryPaymentTableDetailObj.getDividend());

				queryPaymentTableDetailObj.setCapital(detailCapital[i].getValue());
				params.put("capital", queryPaymentTableDetailObj.getCapital());

				// status
				setDescription(detailEstado, queryPaymentTableDetailObj, i);

				// values
				setValuesDetail(params, queryPaymentTableDetailObj, i);

				// cuota
				queryPaymentTableDetailObj.setShare(getQuotaDetail(params, detailInteres, detailEstado, i));

				// saldo capital
				queryPaymentTableDetailObj
						.setCapitalBalance(getCapitalBalance(params, queryPaymentTableHead, detailInteCap, i));

				// Para flexible
				setTableFlex(detailDisponibles, queryPaymentTableDetailObj, i);

				queryPaymentTableDetailObjs.add(queryPaymentTableDetailObj);
			}
		}
		return queryPaymentTableDetailObjs;
	}

	/**
	 * Set detail status
	 * 
	 * @param detailDisponibles
	 * @param queryPaymentTableDetailObj
	 * @param position
	 */
	private void setDescription(QueryPaymentTableDetail[] detailEstado,
			QueryPaymentTableDetailObj queryPaymentTableDetailObj, int position) {
		if (queryPaymentTableDetailObj != null && validateLength(detailEstado, position)) {
			queryPaymentTableDetailObj.setDatePag(detailEstado[position].getDate());
			queryPaymentTableDetailObj.setDaysQuota(detailEstado[position].getDays());
			queryPaymentTableDetailObj.setState(detailEstado[position].getDescription());
		}
	}

	/**
	 * 
	 * @param params
	 * @param queryPaymentTableDetailObj
	 * @param position
	 */
	private void setValuesDetail(Map<String, Object> params, QueryPaymentTableDetailObj queryPaymentTableDetailObj,
			int position) {
		if (params != null && queryPaymentTableDetailObj != null) {
			QueryPaymentTableDetail[] detailInteres = (QueryPaymentTableDetail[]) params
					.get(ConstantValue.RETURN_PAY_TABLE_INTERES);
			QueryPaymentTableDetail[] detailOtros = (QueryPaymentTableDetail[]) params
					.get(ConstantValue.RETURN_PAY_TABLE_OTROS);
			QueryPaymentTableDetail[] detailMipymes = (QueryPaymentTableDetail[]) params
					.get(ConstantValue.RETURN_PAY_TABLE_MIPYMES);
			QueryPaymentTableDetail[] detailIvaMipymes = (QueryPaymentTableDetail[]) params
					.get(ConstantValue.RETURN_PAY_TABLE_IVA_MIPYMES);
			QueryPaymentTableDetail[] detailComision = (QueryPaymentTableDetail[]) params
					.get(ConstantValue.RETURN_PAY_TABLE_COMISION);
			QueryPaymentTableDetail[] detailIvaComision = (QueryPaymentTableDetail[]) params
					.get(ConstantValue.RETURN_PAY_TABLE_IVA_COMISION);
			QueryPaymentTableDetail[] detailSeguro = (QueryPaymentTableDetail[]) params
					.get(ConstantValue.RETURN_PAY_TABLE_SEGURO);
			QueryPaymentTableDetail[] detailInteMora = (QueryPaymentTableDetail[]) params
					.get(ConstantValue.RETURN_PAY_TABLE_INTERES_MORA);
			QueryPaymentTableDetail[] detailInteSeguros = (QueryPaymentTableDetail[]) params
					.get(ConstantValue.RETURN_PAY_TABLE_INTERES_SEGUROS);

			int dividendCap = (Integer) params.get("dividendCap");

			queryPaymentTableDetailObj.setInterest(validateValue(detailInteres, position, dividendCap));
			params.put("interest", queryPaymentTableDetailObj.getInterest());

			queryPaymentTableDetailObj.setArrears(validateValue(detailInteMora, position, dividendCap));
			params.put("arrears", queryPaymentTableDetailObj.getArrears());

			queryPaymentTableDetailObj.setMyPymes(validateValue(detailMipymes, position, dividendCap));
			params.put("myPymes", queryPaymentTableDetailObj.getMyPymes());

			queryPaymentTableDetailObj.setIvaMyPymes(validateValue(detailIvaMipymes, position, dividendCap));
			params.put("ivaMyPymes", queryPaymentTableDetailObj.getIvaMyPymes());

			queryPaymentTableDetailObj.setColateral(validateValue(detailComision, position, dividendCap));
			params.put("colateral", queryPaymentTableDetailObj.getColateral());

			queryPaymentTableDetailObj.setIvaColateral(validateValue(detailIvaComision, position, dividendCap));
			params.put("ivaColateral", queryPaymentTableDetailObj.getIvaColateral());

			queryPaymentTableDetailObj.setInsurance(validateValue(detailSeguro, position, dividendCap));
			params.put("insurance", queryPaymentTableDetailObj.getInsurance());

			queryPaymentTableDetailObj.setInsurances(validateValue(detailInteSeguros, position, dividendCap));
			params.put("insurances", queryPaymentTableDetailObj.getInsurances());

			queryPaymentTableDetailObj.setIntSeg(validateValue(detailInteSeguros, position, dividendCap));
			params.put("intSeg", queryPaymentTableDetailObj.getIntSeg());

			queryPaymentTableDetailObj.setArrearsSeg(validateValue(detailInteSeguros, position, dividendCap));
			params.put("arrearsSeg", queryPaymentTableDetailObj.getArrearsSeg());

			queryPaymentTableDetailObj.setOthers(validateValue(detailOtros, position, dividendCap));
			params.put("others", queryPaymentTableDetailObj.getOthers());
		}
	}

	/**
	 * Saldo Capital
	 * 
	 * @param params
	 * @param queryPaymentTableHead
	 * @param detailInteCap
	 * @param position
	 * @return
	 */
	private double getCapitalBalance(Map<String, Object> params, QueryPaymentTableHead queryPaymentTableHead,
			QueryPaymentTableDetail[] detailInteCap, int position) {
		if (params != null && queryPaymentTableHead != null) {
			int dividendCap = (Integer) params.get("dividendCap");
			double capital = (Double) params.get("capital");
			double saldoCap = (Double) params.get("salCap");

			saldoCap = saldoCap + capital;
			// REQ 175: PEQUEÑA EMPRESA
			if ("C".equals(queryPaymentTableHead.getDistGrace())
					&& dividendCap <= queryPaymentTableHead.getGraceInt()) {
				double capitalizado = validateValue(detailInteCap, position, dividendCap);
				saldoCap = saldoCap - capitalizado;
			}
			params.put("salCap", saldoCap);

			return saldoCap;
		}
		return 0;
	}

	/***
	 * set Tabla Flex
	 * 
	 * @param detailDisponibles
	 * @param queryPaymentTableDetailObj
	 * @param position
	 */
	private void setTableFlex(QueryPaymentTableDetail[] detailDisponibles,
			QueryPaymentTableDetailObj queryPaymentTableDetailObj, int position) {
		if ((queryPaymentTableDetailObj != null) && (validateLength(detailDisponibles, position))) {
				queryPaymentTableDetailObj.setPaymentComp(detailDisponibles[position].getInterestValue() != null
						? detailDisponibles[position].getInterestValue().doubleValue() : 0);
				queryPaymentTableDetailObj.setInterestPend(detailDisponibles[position].getValue());
		}
	}

	/**
	 * get Quota
	 * 
	 * @param params
	 * @param detailInteres
	 * @param detailEstado
	 * @param position
	 * @return
	 */
	private double getQuotaDetail(Map<String, Object> params, QueryPaymentTableDetail[] detailInteres,
			QueryPaymentTableDetail[] detailEstado, int position) {
		if (params != null) {
			double capital = (Double) params.get("capital");
			double interest = (Double) params.get("interest");
			double arrears = (Double) params.get("arrears");
			double myPymes = (Double) params.get("myPymes");
			double ivaMyPymes = (Double) params.get("ivaMyPymes");
			double colateral = (Double) params.get("colateral");
			double ivaColateral = (Double) params.get("ivaColateral");
			double insurance = (Double) params.get("insurance");
			double others = (Double) params.get("others");

			// valor cuota
			double cuota = 0;
			if (validateLength(detailInteres, position) && validateLength(detailEstado, position)) {
				if ("INTANT".equals(detailInteres[position].getConcept())) {
					if (position == 1) {
						cuota = capital + others + myPymes + ivaMyPymes + colateral + ivaColateral + insurance
								+ arrears;
					} else {
						cuota = capital + interest + others + myPymes + ivaMyPymes + colateral + ivaColateral
								+ insurance + arrears;
					}
				} else {

					if ("CANCELADO".equals(detailEstado[position].getDescription())) {
						cuota = capital + interest + others + myPymes + ivaMyPymes + colateral + ivaColateral
								+ insurance + arrears;
					} else {
						cuota = capital + interest + others + myPymes + ivaMyPymes + colateral + ivaColateral
								+ insurance + arrears;
					}
				}
			}
			return cuota;
		}
		return 0;
	}

	/**
	 * Validate data header
	 * 
	 * @param queryPaymentTableHead
	 * @param queryPaymentTableRequest
	 */
	private void setValueHeader(QueryPaymentTableHead queryPaymentTableHead,
			QueryPaymentTableRequest queryPaymentTableRequest) {

		if (queryPaymentTableHead != null && queryPaymentTableRequest != null) {
			queryPaymentTableHead.setBank(queryPaymentTableRequest.getBank());
			queryPaymentTableHead
					.setBaseCalculation(setValue(queryPaymentTableHead.getBaseCalculation(), "E", "COMERCIAL"));
			queryPaymentTableHead.setBaseCalculation(setValue(queryPaymentTableHead.getBaseCalculation(), "R", "REAL"));

			queryPaymentTableHead.setModality(setValue(queryPaymentTableHead.getModality(), "A", "ANTICIPADA"));
			queryPaymentTableHead.setModality(setValue(queryPaymentTableHead.getModality(), "P", "VENCIDA"));

			queryPaymentTableHead.setRecalculateTerm(setValue(queryPaymentTableHead.getRecalculateTerm(), "S", "SI"));
			queryPaymentTableHead.setRecalculateTerm(setValue(queryPaymentTableHead.getRecalculateTerm(), "N", "NO"));

			queryPaymentTableHead.setRecalculateTerm(setValue(queryPaymentTableHead.getRecalculateTerm(), "S", "SI"));
			queryPaymentTableHead.setRecalculateTerm(setValue(queryPaymentTableHead.getRecalculateTerm(), "N", "NO"));

			queryPaymentTableHead.setAvoidHolidays(setValue(queryPaymentTableHead.getAvoidHolidays(), "S", "SI"));
			queryPaymentTableHead.setAvoidHolidays(setValue(queryPaymentTableHead.getAvoidHolidays(), "N", "NO"));

			queryPaymentTableHead.setLastDayEnable(setValue(queryPaymentTableHead.getLastDayEnable(), "S", "SI"));
			queryPaymentTableHead.setLastDayEnable(setValue(queryPaymentTableHead.getLastDayEnable(), "N", "NO"));

			queryPaymentTableHead.setEquivalentRate(setValue(queryPaymentTableHead.getEquivalentRate(), "S", "SI"));
			queryPaymentTableHead.setEquivalentRate(setValue(queryPaymentTableHead.getEquivalentRate(), "N", "NO"));

			queryPaymentTableHead.setPointsType(setValue(queryPaymentTableHead.getPointsType(), "B", "BASE"));
			queryPaymentTableHead.setPointsType(setValue(queryPaymentTableHead.getPointsType(), "N", "NOMINAL"));
			queryPaymentTableHead.setPointsType(setValue(queryPaymentTableHead.getPointsType(), "E", "EFECTIVA"));
		}
	}

	/**
	 * set info office and processingDate
	 * 
	 * @param queryPaymentTableHead
	 * @param serviceIntegration
	 */
	private void setValueFooter(QueryPaymentTableHead queryPaymentTableHead,
			ICTSServiceIntegration serviceIntegration) {

		if (queryPaymentTableHead != null && serviceIntegration != null) {
			ReportOfficeRequest reportOfficeRequest = new ReportOfficeRequest();
			reportOfficeRequest.setBank(queryPaymentTableHead.getBank());
			ReportOfficeResponse reportOfficeResponse = queryOfficeProcesDate(ConstantValue.SERVICE_OFFICE,
					reportOfficeRequest, serviceIntegration);
			if (reportOfficeResponse != null) {
				queryPaymentTableHead.setAddressOffice(reportOfficeResponse.getAddress());
				queryPaymentTableHead.setCityOffice(reportOfficeResponse.getCity());
				queryPaymentTableHead.setPhoneOffice(reportOfficeResponse.getPhone());
			}

			ReportOfficeResponse responseDate = queryOfficeProcesDate(ConstantValue.SERVICE_PROCESSING_DATE,
					reportOfficeRequest, serviceIntegration);
			if (responseDate != null) {
				queryPaymentTableHead.setProcessingDate(util.convertDate(responseDate.getProcessingDate()));

			}

		}
	}

	/**
	 * Set value
	 * 
	 * @param valueOriginal
	 * @param valueCompare
	 * @param valueFinal
	 * @return
	 */
	private String setValue(String valueOriginal, String valueCompare, String valueFinal) {
		if (valueCompare.equals(valueOriginal)) {
			return valueFinal;
		}
		return valueOriginal;
	}

	/**
	 * Setea los detalles a la cabecera
	 * 
	 * @param queryPaymentTableHead
	 * @param queryPaymentTableRequest
	 * @param serviceIntegration
	 * @param serviceNameDetails
	 */
	private void setDatails(QueryPaymentTableHead queryPaymentTableHead,
			QueryPaymentTableRequest queryPaymentTableRequest, ICTSServiceIntegration serviceIntegration,
			String serviceNameDetails) {
		if (queryPaymentTableHead != null) {
			Map<String, Object> params = new HashMap<String, Object>();
			queryPaymentTableHead.setDetails(new ArrayList<QueryPaymentTableDetailObj>());
			int dividend = 9999;
			params.put("salCap", new Double(0));
			do {
				logger.logDebug(" START setDatails saldoCap " + params.get("salCap"));
				queryPaymentTableRequest.setDividend(dividend);
				List<QueryPaymentTableDetailObj> details = queryPaymentTableDetail(serviceNameDetails,
						queryPaymentTableRequest, serviceIntegration, queryPaymentTableHead, params);

				for (QueryPaymentTableDetailObj detailObj : details) {
					queryPaymentTableHead.getDetails().add(detailObj);
					dividend = detailObj.getDividend();
				}
				if (details.isEmpty()) {
					dividend = -1;
				}
				logger.logDebug(" END setDatails saldoCap " + params.get("salCap"));
			} while (dividend != -1);
			Collections.reverse(queryPaymentTableHead.getDetails());
		}
	}

	private double validateValue(QueryPaymentTableDetail[] detail, int position, int dividendCap) {
		if (logger.isDebugEnabled())
			logger.logDebug(" START validateValue array " + detail + " tamanio "
					+ (detail != null ? detail.length : "no tiene"));

		if (detail != null && detail.length > 0 && position < detail.length
				&& dividendCap == detail[position].getQuotaNumber()) {
			return detail[position].getValue();
		}
		if (logger.isDebugEnabled())
			logger.logDebug(" END validateValue ");
		return 0;

	}

	private boolean validateLength(QueryPaymentTableDetail[] detail, int position) {
		if (logger.isDebugEnabled())
			logger.logDebug(" START validateLength array " + detail + " tamanio "
					+ (detail != null ? detail.length : "no tiene"));

		if (detail != null && detail.length > 0 && position < detail.length) {
			return true;
		}

		if (logger.isDebugEnabled())
			logger.logDebug(" END validateLength ");
		return false;
	}
}
