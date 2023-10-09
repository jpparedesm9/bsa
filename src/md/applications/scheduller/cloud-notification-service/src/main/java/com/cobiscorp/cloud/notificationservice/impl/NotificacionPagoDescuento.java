package com.cobiscorp.cloud.notificationservice.impl;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.cobiscorp.cloud.notificationservice.model.DiscountDetail;
import com.cobiscorp.cloud.notificationservice.model.NotificaDescuento;
import com.cobiscorp.cloud.scheduler.utils.GenerateReport;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;

public class NotificacionPagoDescuento extends NotificationGeneric implements Job {
	private static final Logger LOGGER = Logger.getLogger(NotificacionPagoDescuento.class);

	@Override
	public List<?> xmlToDTO(File inputData) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> setParameterToJasper(Object inputDto) {
		Map<String, Object> parameters = new HashMap<String, Object>();
		return parameters;
	}

	@Override
	public List<?> setCollection(Object inputDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("NotificacionPagoDescuento INICIA setCollection");
		}
		NotificaDescuento notif = (NotificaDescuento) inputDto;
		List<NotificaDescuento> listNotif = new ArrayList<NotificaDescuento>();
		listNotif.add(notif);

		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Lista para reporte: " + listNotif);
		}
		return listNotif;
	}

	@Override
	public Map<String, Object> setParameterToSendMail(Object inputDto) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("NotificacionPagoDescuento INICIA setParameterToSendMail");
			LOGGER.debug("Para notif.getMailTo()");
		}
		Map<String, Object> parameters = new HashMap<String, Object>();
		NotificaDescuento notif = (NotificaDescuento) inputDto;
		parameters.put("ID_GRUPO", notif.getParentOper());
		parameters.put("NOMBRE_GRUPO", notif.getGroupName());
		parameters.put("MENSAJE", "");
		parameters.put("EMAIL_TO", notif.getMailTo());
		parameters.put("EMAIL_CC", "");
		parameters.put("EMAIL_BCC", "");
		parameters.put("SUBJECT", "");
		return parameters;
	}

	@Override
	public void execute(JobExecutionContext context) throws JobExecutionException {
		// TODO Auto-generated method stub
		try {
			LOGGER.debug("JobName: " + context.getJobDetail().getName());
			executeNotifDescuento(context);
		} catch (Exception ex) {
			LOGGER.error("Exception: " + ex);
		}
	}

	private void executeNotifDescuento(JobExecutionContext context) {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa executeNotifDescuento");
		}
		Connection cn = null;
		CallableStatement executeSP = null;
		try {
			cn = ConnectionManager.newConnection();
			ResultSet result = getDataToSend(cn, executeSP);
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("RESULT: " + result.getFetchSize());
			}
			CallableStatement executeSPDetail = null;

			while (result.next()) {
				List<NotificaDescuento> notificationList = new ArrayList<NotificaDescuento>();
				NotificaDescuento notifyData = mappingNotificacionData(result);
				String queryDetail = "{ call cob_cartera..sp_qr_ns_notif_descuento(?,?) }";
				executeSPDetail = cn.prepareCall(queryDetail);
				executeSPDetail.setString(1, "S");
				if (LOGGER.isDebugEnabled()) {
					LOGGER.debug("Operacion Padre " + notifyData.getParentOper());
				}
				executeSPDetail.setInt(2, notifyData.getParentOper());

				ResultSet resultQuery = executeSPDetail.executeQuery();
				while (resultQuery.next()) {
					mappDetailNotificationData(resultQuery, notifyData.getDiscountDetailList());
				}
				notificationList.add(notifyData);
				LOGGER.debug("result1.." + resultQuery);
				GenerateReport.generateReport(context.getJobDetail().getName(), notifyData.getParentOper().toString(),
						notificationList);
				updateNotificatioDiscount(cn, executeSP, notificationList);
			}

		} catch (Exception e) {
			LOGGER.error("ERROR executeNotifDescuento -->", e);
		} finally {
			try {
				ConnectionManager.saveConnection(cn);
			} catch (Exception e) {
				LOGGER.error("Error al cerrar la conexión: ", e);
			}
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza executeNotifDescuento");
			}
		}

	}

	private void updateNotificatioDiscount(Connection cn, CallableStatement executeSP,
			List<NotificaDescuento> notificationList) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa updateNotificatioDiscount");
		}
		String query = "{ call cob_cartera..sp_qr_ns_notif_descuento(?,?) }";

		try {
			for (NotificaDescuento notificaDescuento : notificationList) {
				executeSP = cn.prepareCall(query);
				executeSP.setString(1, "U");
				executeSP.setInt(2, notificaDescuento.getParentOper());
				executeSP.execute();
			}

		} catch (Exception ex) {
			LOGGER.error("ERROR updateNotificatioDiscount -->", ex);
			throw ex;
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza updateNotificatioDiscount");
			}
		}
	}

	private void mappDetailNotificationData(ResultSet result, List<DiscountDetail> discountDetailList)
			throws Exception {
		DiscountDetail discountDetail = new DiscountDetail();
		discountDetail.setCustomerName(result.getString(1) + " " + result.getString(2));
		discountDetail.setAmount(result.getBigDecimal(3));
		discountDetailList.add(discountDetail);

	}

	private NotificaDescuento mappingNotificacionData(ResultSet result) throws Exception {
		NotificaDescuento notificaDescuento = new NotificaDescuento();
		notificaDescuento.setParentOper(result.getInt(1));
		notificaDescuento.setGroupName(result.getString(2));
		notificaDescuento.setMailTo(result.getString(3));		
		notificaDescuento.setDiscountDetailList(new ArrayList<DiscountDetail>());
		return notificaDescuento;
	}

	private ResultSet getDataToSend(Connection cn, CallableStatement executeSP) throws Exception {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.debug("Ingresa getDataToSend");
		}
		String query = "{ call cob_cartera..sp_qr_ns_notif_descuento(?,?) }";
		try {
			executeSP = cn.prepareCall(query);
			executeSP.setString(1, "Q");

			executeSP.setInt(2, 0);
			executeSP.execute();
			return executeSP.getResultSet();
		} catch (Exception ex) {
			LOGGER.error("ERROR getDataToSend -->", ex);
			throw ex;
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.debug("Finaliza getDataToSend");
			}
		}
	}

}
