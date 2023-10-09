package com.cobiscorp.cloud.process.intf;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import org.apache.log4j.Logger;

public class TextFileFormatter {
	private static final Logger logger = Logger
			.getLogger(TextFileFormatter.class);
	private static String SEPARATOR = "|";

	public static void main(String[] args) {
		String wSrcFileName = "";
		String wNewString = "";
		String wOldString = "";
		try {
			wSrcFileName = args[0];
		} catch (ArrayIndexOutOfBoundsException e) {
			wSrcFileName = null;
		}
		
		try {
			SEPARATOR = args[1];
		} catch (ArrayIndexOutOfBoundsException e) {
			SEPARATOR = "|";
		}
		
		if (wSrcFileName != null) {
			// LECTURA
			FileReader wFileReader = null;
			FileWriter wFileWriter = null;
			PrintWriter wPrintwriter = null;
			try {
				wFileReader = new FileReader(wSrcFileName);
				BufferedReader wBufferReader = new BufferedReader(wFileReader);
				while ((wNewString = wBufferReader.readLine()) != null) {
					wOldString = wNewString.replace(SEPARATOR, "");
				}
				wBufferReader.close();
			} catch (FileNotFoundException e) {
				logger.error(
						"FileNotFoundException LECTURA TextFileFormatter -->",
						e);
			} catch (IOException e) {
				logger.error("IOException LECTURA TextFileFormatter -->", e);
			}
			// ESCRITURA
			try {
				wFileWriter = new FileWriter(wSrcFileName);
				wPrintwriter = new PrintWriter(wFileWriter);
				wPrintwriter.println(wOldString);
			} catch (Exception e) {
				logger.error("Exception ESCRITURA TextFileFormatter -->", e);
			} finally {
				try {
					if (null != wFileWriter)
						wFileWriter.close();
				} catch (Exception e2) {
					logger.error("Exception ESCRITURA TextFileFormatter -->",
							e2);
				}
			}
		} else {
			logger.error("ERROR TextFileFormatter: Falta parametro Archivo");
		}
	}
}
