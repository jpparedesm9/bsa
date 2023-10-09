package com.cobiscorp.cloud.scheduler.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import org.castor.util.concurrent.ConcurrentHashMap;
import com.cobiscorp.cloud.scheduler.utils.dto.DataArchivo;

public class ReportarArchivos {
	
	private static final Object object = new Object();
	private static volatile ReportarArchivos reportarArchivos = null;
	private static Map<String, List<DataArchivo>> archivos;
		
	private ReportarArchivos() {
	}
	
	public static ReportarArchivos getInstance() {
		if (reportarArchivos != null) {
			return reportarArchivos;
		}
		synchronized (object) {
			if (reportarArchivos == null) {
				reportarArchivos = new ReportarArchivos();
			}
			return reportarArchivos;
		}
	}
	
	public String reportByFile(DataArchivo archivo, String mensaje) {
		if (mensaje == null || mensaje.isEmpty()) {
			mensaje = "Buenos días,\n\nPor medio del presente se informa que se ha ejecutado el proceso que genera y entrega el siguiente reporte en el repositorio FileShare:\n\nCarpeta Destino\t\t\tNombre Reporte\t\tHora de Entrega\t\tTamaño\n<FilesData>\n\nSaludos cordiales.";
		}
		StringBuilder data = new StringBuilder();
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
		data.append(archivo.getDestino());
		data.append("\t\t");
		data.append(archivo.getArchivo());
		data.append("\t\t");
		data.append(sdf.format(new Date()) + " Horas");
		data.append("\t\t");
		data.append((archivo.getTamano()/1024) + " KB/MB\n");
		mensaje = mensaje.replaceAll("<FilesData>", data.toString());
		return mensaje;
	}
	
	public String reportAllFile(List<DataArchivo> archivos, String mensaje) {
		if (mensaje == null || mensaje.isEmpty()) {
			mensaje = "Buenos días,\n\nPor medio del presente se informa que se ha ejecutado el proceso que genera y entrega el siguiente reporte en el repositorio FileShare:\n\nCarpeta Destino\t\t\tNombre Reporte\t\tHora de Entrega\t\tTamaño\n<FilesData>\n\nSaludos cordiales.";
		}
		StringBuilder data = new StringBuilder();
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
		for (DataArchivo archivo : archivos) {
			data.append(archivo.getDestino());
			data.append("\t\t");
			data.append(archivo.getArchivo());
			data.append("\t\t");
			data.append(sdf.format(archivo.getFecha()) + " Horas");
			data.append("\t\t");
			data.append((archivo.getTamano()/1024) + " KB/MB\n");
		}
		mensaje = mensaje.replaceAll("<FilesData>", data.toString());
		return mensaje;
	}

	@SuppressWarnings("unchecked")
	public void limpiarArchivos(String process) {
		if (archivos == null) archivos = new ConcurrentHashMap();
		archivos.put(process, new Vector<DataArchivo>());		
	}

	@SuppressWarnings("unchecked")
	public void addArchivo(String process, DataArchivo archivo) {
		if (archivo != null) {
			if (archivos == null) archivos = new ConcurrentHashMap();
			archivos.get(process).add(archivo);
		}
	}
	
	public List<DataArchivo> listaArchivos(String process) {
		return archivos.get(process);
	}

}
