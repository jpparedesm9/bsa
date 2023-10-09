package com.cobiscorp.cloud.process.file;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import org.apache.log4j.Logger;

public class TextFileFormatter {
	private static final Logger logger = Logger
			.getLogger(TextFileFormatter.class);
	private static String SEPARATOR = "|";

	public static void main(String[] args) {
		String wSrcFileName = "";
		String wNewString = "";
		String wOldString = "";

		File myFile;
		ArrayList<String> RegistrosLista = new ArrayList<String>();
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
		
		logger.info(wSrcFileName);
		
		if (wSrcFileName != null) {
			
			myFile = new File(wSrcFileName);
			long size = myFile.length();
			
			if (size > 0) {
				// LECTURA
				FileReader wFileReader = null;
				FileWriter wFileWriter = null;
				PrintWriter wPrintwriter = null;
				try {
					wFileReader = new FileReader(wSrcFileName);
					BufferedReader wBufferReader = new BufferedReader(wFileReader);
					while ((wNewString = wBufferReader.readLine()) != null) {
						wOldString = wNewString;
						//logger.info(wOldString);
						RegistrosLista.add(wOldString);
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
					BufferedWriter bw = new BufferedWriter(wFileWriter);				
					
					for (int i = 0; i < RegistrosLista.size(); i++) {
						bw.write(RegistrosLista.get(i));	
						if (i<RegistrosLista.size()-1) {
							bw.newLine();
						}
					}
					bw.close();
					
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
								
			}else {
				logger.error("ERROR TextFileFormatter: Archivo Vacio");
			}				
		} else {
			logger.error("ERROR TextFileFormatter: Falta parametro Archivo");
		}
	}
}
