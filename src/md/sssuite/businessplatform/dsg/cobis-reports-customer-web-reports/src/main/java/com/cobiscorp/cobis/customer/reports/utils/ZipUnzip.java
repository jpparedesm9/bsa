package com.cobiscorp.cobis.customer.reports.utils;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;

public class ZipUnzip {
	private static ILogger logger = LogFactory.getLogger(ZipUnzip.class);

	/**
	 * Serializes the ServiceRequestTO in order to save in database The serialized object is compressed
	 * 
	 * @param toSerialized
	 *            String to serialize
	 * @return Bytes array that represent a ServiceRequestTO serialized and compressed
	 */
	public static byte[] serializeObject(String toSerialized) {
		ByteArrayOutputStream wArrayOutputStream;
		ZipOutputStream gz;
		try {
			wArrayOutputStream = new ByteArrayOutputStream();
			gz = new ZipOutputStream(wArrayOutputStream);
			ZipEntry ze = new ZipEntry("ZipEntry");
			gz.putNextEntry(ze);
			ObjectOutputStream oos = new ObjectOutputStream(gz);
			oos.writeObject(toSerialized);
			gz.closeEntry();
			oos.flush();
			oos.close();
			wArrayOutputStream.close();
			return wArrayOutputStream.toByteArray();
		} catch (IOException e) {
			logger.logError("IOException Problems serializing object:", e);
			throw new BusinessException(-20, e.getMessage(), "IOException Problems serializing object");
		}
	}

	/**
	 * Uncompress and deserialize data to obtain a ServiceRequestTO
	 * 
	 * @param aObject
	 *            bytes array to deserialize
	 * @return String uncompressed and deserialized
	 */
	public static String deserializeObject(byte[] aObject) {
		try {
			ByteArrayInputStream wArrayOutputStream = new ByteArrayInputStream(aObject);
			ZipInputStream gs;
			gs = new ZipInputStream(wArrayOutputStream);
			while ((gs.getNextEntry()) != null) {
				ObjectInputStream ois = new ObjectInputStream(gs);
				String outTmp = ois.readObject().toString();
				wArrayOutputStream.close();
				gs.closeEntry();
				ois.close();
				return outTmp;
			}
		} catch (IOException e) {
			logger.logError("IOException problems deserializing object:", e);
			throw new BusinessException(-21, e.getMessage(), "IOException problems deserializing object");
		} catch (ClassNotFoundException e) {
			logger.logError("ClassNotFoundException problems deserializing object:", e);
			throw new BusinessException(-22, e.getMessage(), "ClassNotFoundException problems deserializing object");
		}
		logger.logError("No zip entry found in transaction data, please verify if serialized and compressed data of se_data column in re_service table for this transaction is correct");
		return null;
	}
}
