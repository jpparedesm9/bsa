package com.cobiscorp.mobile.util;

import java.util.Random;

import com.cobiscorp.b2c.jwt.CobisJwt;
import com.cobiscorp.b2c.jwt.InvalidTokenException;
//import com.cobiscorp.b2c.jwt.ShakeJwtKeyGenerator;
import com.cobiscorp.b2c.jwt.TokenExpiredException;
import com.cobiscorp.mobile.model.BankGeolocation;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public class BankGeolocationUtil {

	private static final ILogger logger = LogFactory.getLogger(BankGeolocationUtil.class);

	private static final String JWT_TOKEN_PHONE_NUMBER_KEY = "phoneNumber";
	public static final String NOPOSITION = "0";
	private static final String CHANNEL = "TUIIODIGITAL";

	public static final String POST_TYPE = "POST";
	public static final String PUT_TYPE = "PUT";
	public static final String GET_TYPE = "GET";
	private static String latitudePos = null;
	private static String longitudePos = null;
	private static String channel = null; // REVISION DE CANAL NEMONICO

	private BankGeolocationUtil() {
	}

	public static BankGeolocation getBankGeolocDto(CobisJwt cobisJwt, String trxType, String servType) throws TokenExpiredException, InvalidTokenException {

		if (logger.isDebugEnabled()) {
			logger.logDebug("getBankGeolocDto - INI -> " + trxType + " : " + servType);
		}
		String login = cobisJwt.getAttribute(JWT_TOKEN_PHONE_NUMBER_KEY);
		if (logger.isDebugEnabled()) {
			logger.logDebug("getBankGeolocDto - login=" + login);
		}
		try {
			latitudePos = cobisJwt.getAttribute("latitudePos");
			longitudePos = cobisJwt.getAttribute("longitudePos");
		} catch (InvalidTokenException e) {
			logger.logDebug("getBankGeolocDto - lat and long are invalid");
		} finally {
			logger.logDebug("getBankGeolocDto - finally exc");
			latitudePos = NOPOSITION;
			longitudePos = NOPOSITION;
		}

		BankGeolocation aBankGeoloc = new BankGeolocation();
		aBankGeoloc.setLogin(login);
		aBankGeoloc.setTrxType(trxType);
		aBankGeoloc.setServiceType(servType); // POST, PUT, GET
		aBankGeoloc.setLatitudePos(latitudePos == null ? null : new String(latitudePos));
		aBankGeoloc.setLongitudePos(latitudePos == null ? null : new String(longitudePos));
		return aBankGeoloc;
	}

	public static BankGeolocation getBankGeolocDto(CobisJwt cobisJwt, String trxType, String servType, String ente) throws TokenExpiredException, InvalidTokenException {

		if (logger.isDebugEnabled()) {
			logger.logDebug("getBankGeolocDto - 2INI -> " + trxType + " : " + servType);
		}
		try {
			latitudePos = cobisJwt.getAttribute("latitudePos");
			longitudePos = cobisJwt.getAttribute("longitudePos");
			channel = cobisJwt.getAttribute("channel");
			logger.logError("latitudePos: " + latitudePos);
			logger.logError("longitudePos: " + longitudePos);
			logger.logError("channel: " + channel);
		} catch (InvalidTokenException e) {
			logger.logDebug("getBankGeolocDto - lat and long are invalid");
		}
//		} finally {
//			logger.logDebug("getBankGeolocDto - finally exc");
//			latitudePos = NOPOSITION;
//			longitudePos = NOPOSITION;
//			channel = CHANNEL;
//		}
//		 /* ALL ELIMINAR DESDE AQUI */
//		 int lat = 0;
//		
//		 if (latitudePos.equals("0") || longitudePos.equals("0")) {
//		
//		 Random rnd = new Random();
//		 for (int i = 1; i <= 5; i++) {
//		 lat = rnd.nextInt();
//		 }
//		 latitudePos = String.valueOf(lat);
//		 longitudePos = String.valueOf(lat);
//		 }
//		 /* ALL HASTA AQUI */
		BankGeolocation aBankGeoloc = new BankGeolocation();
		aBankGeoloc.setLogin(ente);
		aBankGeoloc.setTrxType(trxType);
		aBankGeoloc.setServiceType(servType); // POST,
												// PUT,
												// GET
		aBankGeoloc.setLatitudePos(latitudePos == null ? null : new String(latitudePos));
		aBankGeoloc.setLongitudePos(latitudePos == null ? null : new String(longitudePos));
		aBankGeoloc.setChannel(channel == null ? null : new String(channel));
		return aBankGeoloc;
	}

}