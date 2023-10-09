package com.cobiscorp.cobis.notifier.dispatcher.sms.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbcp.BasicDataSource;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.notifier.dispatcher.sms.SpDespachoData;
import com.cobiscorp.cobis.notifier.dispatcher.sms.SpDespachoTemplate;
import com.cobiscorp.cobis.notifier.dispatcher.sms.dto.DataSms;
import com.cobiscorp.cobis.notifier.dispatcher.sms.dto.SmsResponse;
import com.cobiscorp.cobis.notifier.dispatcher.sms.dto.TemplateSms;
import com.cobiscorp.notification.client.utils.ConfigManager;

public class SmsSendImpl {

	private static final ILogger logger = LogFactory.getLogger(SmsSendImpl.class);

	public SmsResponse getDataSmsResponse(int bloque, String idPlantilla, String idClient, String validaBuc) throws Exception {

		// Get the information from the properties file
		ConfigManager configManager = ConfigManager.getInstance();

		BasicDataSource basicDataSource = getDataSource(configManager);
		SmsResponse smsResponse = new SmsResponse();

		try {
			// Get the template data for the header
			TemplateSms templateSms = getSmsTemplate(idPlantilla, "P", basicDataSource, idClient, validaBuc, bloque);
			smsResponse.setTemplateSms(templateSms);

			// You get the data from the alerts for the body
			List<DataSms> dataSms = getSmsData(idPlantilla, "Q", basicDataSource, idClient, bloque);
			smsResponse.setDataSms(dataSms);
		} catch (Exception e) {
			logger.logDebug("Error getting information from the database", e);
			throw new Exception("Error getting information from the database");
		}

		return smsResponse;
	}

	public TemplateSms getSmsTemplate(String idPlantilla, String operacion, BasicDataSource dataSource, String idClient, String validaBuc, int bloque) throws Exception {

		logger.logDebug("Start method getDataSms ");
		TemplateSms tmpSms = new TemplateSms();

		try {

			SpDespachoTemplate sp = new SpDespachoTemplate(dataSource, "sp_despacho_sms_ins");
			Map<String, Object> inputParam = new HashMap<>();
			inputParam.put("@i_id_plantilla", idPlantilla);
			inputParam.put("@i_operacion", operacion);
			inputParam.put("@i_cliente", idClient);
			inputParam.put("@i_bloque", bloque);
			inputParam.put("@i_valid_buc", validaBuc);

			Map<String, Object> result = sp.execute(inputParam);
			@SuppressWarnings("unchecked")
			List<TemplateSms> respuesta = (List<TemplateSms>) result.get("Notifications");
			tmpSms = respuesta.get(0);

		} catch (Exception e) {
			logger.logError("Failed to get template", e);
			throw new Exception("Failed to get template");

		}

		logger.logDebug("Finish method getDataSms ");

		return tmpSms;

	}

	public List<DataSms> getSmsData(String idPlantilla, String operacion, BasicDataSource dataSource, String idClient, int bloque) throws Exception {

		logger.logDebug("Start method getSmsData ");
		List<DataSms> dataSmsList = new ArrayList<>();

		try {

			SpDespachoData sp = new SpDespachoData(dataSource, "sp_despacho_sms_ins");
			Map<String, Object> inputParam = new HashMap<>();
			inputParam.put("@i_operacion", operacion);
			inputParam.put("@i_id_plantilla", idPlantilla);
			inputParam.put("@i_cliente", idClient);
			inputParam.put("@i_bloque", bloque);

			Map<String, Object> result = sp.execute(inputParam);
			@SuppressWarnings("unchecked")
			List<DataSms> respuesta = (List<DataSms>) result.get("Notifications");
			dataSmsList = respuesta;

		} catch (Exception e) {
			logger.logError("Failed to get alerts", e);
			throw new Exception("Failed to get alerts");
		}

		logger.logDebug("Finish method getSmsData ");

		return dataSmsList;

	}

	public BasicDataSource getDataSource(ConfigManager configManager) {

		BasicDataSource dataSource = new BasicDataSource();
		dataSource.setDriverClassName(configManager.getJdbDriver());
		dataSource.setUrl(configManager.getUrl());
		dataSource.setUsername(configManager.getUsername());
		dataSource.setPassword(configManager.getPasswod());
		dataSource.setTestOnBorrow(true);
		dataSource.setTestOnReturn(true);
		dataSource.setTestWhileIdle(true);

		return dataSource;

	}

}