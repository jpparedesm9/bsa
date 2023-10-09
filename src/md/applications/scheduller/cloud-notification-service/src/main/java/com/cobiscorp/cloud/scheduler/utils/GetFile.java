package com.cobiscorp.cloud.scheduler.utils;

import com.cobiscorp.cloud.configuration.ConfigManager;
import com.cobiscorp.cloud.notificationservice.factory.NotificationServiceFactory;
import com.cobiscorp.cloud.notificationservice.service.IServiceBaseFile;
import com.cobiscorp.cloud.util.jdbc.ConnectionManager;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.*;


public class GetFile {

    private static final Logger logger = Logger.getLogger(GetFile.class);

    private static final String EXTENSION_PDF = ".pdf";
    private static final String COLUMN_CODE = "codigo";
    private static final String COLUMN_VALUE = "valor";
    private static HashMap<String, GenerateReportProperties> properties = new HashMap<String, GenerateReportProperties>();
    private static final String EXTENSION_XML = ".xml";

	public static List<?> getFileXML(String parameter, File[] xmlFiles) {
        if (logger.isDebugEnabled()) {
            logger.debug("Ingresa getFileXML");
        }
        Object objectList;
        List<Object> objectList1 = new ArrayList<Object>();
        try {

            IServiceBaseFile notificationImpl;

            notificationImpl = NotificationServiceFactory.getGenericFileClass(parameter);

            if (xmlFiles == null) {
                logger.error("No existen Archivos en el directorio.");
                return null;
            }

            if (notificationImpl == null) {
                logger.error("FALTAN PARAMETROS INICIALES PARA REALIZAR LA EJECUCION DEL PROCESO.");
                return null;
            }

            for (int i = 0; i < xmlFiles.length; i++) {
                logger.debug("Nombre del archivo.." + xmlFiles[i].getName());
                objectList = notificationImpl.xmlToDTO(xmlFiles[i]);
                objectList1.add(objectList);
            }
            logger.debug("Numero de Archivos " + objectList1.size());

        } catch (Exception ex) {
            logger.error("ERROR en getFileXML-->", ex);
        }
        return objectList1;
    }

    public static File replaceFileString(Map<String, String> toReplace, File f) {
        File tempFile = null;
        try {

            String content = FileUtils.readFileToString(f, "UTF-8");
            Iterator it = toReplace.entrySet().iterator();
            while (it.hasNext()) {
                Map.Entry e = (Map.Entry) it.next();
                content = content.replaceAll(e.getKey().toString(), e.getValue().toString());
                logger.debug(e.getKey() + " " + e.getValue());
            }
            tempFile = f;
            FileUtils.writeStringToFile(tempFile, content, "UTF-8");

        } catch (Exception e) {
            //Simple exception handling, replace with what's necessary for your use case!
            logger.debug("Error al Remplazar valores en archivo xml.." + f.getName());
            logger.debug("Error al Remplazar valores en archivo xml..", e);
        }
        return tempFile;
    }

    public static void moveFileToHistoricalFolder(File f, String destinationDirectory) {
        logger.debug("Ingresa moveFileToHistoricalFolder");
        //File dirSrc = new File(filesPath);
        File dirTrgt = createHistoricalFolder(destinationDirectory);

        if (f.exists()) {
            if (validateAllowedFileExtension(f)) {
                if (dirTrgt.isDirectory()) {
                    File fileTrgt = new File(dirTrgt, f.getName());
                    if (fileTrgt.exists()) {
                        fileTrgt.delete();
                    }
                    boolean success = f.renameTo(new File(dirTrgt,
                            f.getName()));
                    if (!success) {

                        if (logger.isDebugEnabled()) {
                            logger.debug("EnvioArchivo.copyFileToHistoricalFolder() - Error al pasar archivo a historico");
                            logger.debug("EnvioArchivo.copyFileToHistoricalFolder() - Archivo = "
                                    + f.getName());
                        }
                    }
                } else {
                    if (logger.isDebugEnabled()) {
                        logger.debug("EnvioArchivo.moveFileToHistoricalFolder() - Error - no existe carpeta => "
                                + dirTrgt);
                    }
                }
            } else {
                if (logger.isDebugEnabled()) {
                    logger.debug("EnvioArchivo.moveFileToHistoricalFolder() - Extension de Archivo No permitida => "
                            + f.getName());
                }
            }

        }

    }

    public static void moveFileToHistoricalFolderError(File f, String destinationDirectory, String sourceError) {
        logger.debug("Ingresa moveFileToHistoricalFolderError");
        File dirTrgt = createHistoricalFolderError(destinationDirectory, sourceError);

        if (f.exists()) {
            if (validateAllowedFileExtension(f)) {
                if (dirTrgt.isDirectory()) {
                    File fileTrgt = new File(dirTrgt, f.getName());
                    if (fileTrgt.exists()) {
                        fileTrgt.delete();
                    }
                    boolean success = f.renameTo(new File(dirTrgt,
                            f.getName()));
                    if (!success) {

                        if (logger.isDebugEnabled()) {
                            logger.debug("EnvioArchivo.moveFileToHistoricalFolderError() - Error al pasar archivo a historico");
                            logger.debug("EnvioArchivo.moveFileToHistoricalFolderError() - Archivo = "
                                    + f.getName());
                        }
                    }
                } else {
                    if (logger.isDebugEnabled()) {
                        logger.debug("EnvioArchivo.moveFileToHistoricalFolderError() - Error - no existe carpeta => "
                                + dirTrgt);
                    }
                }
            } else {
                if (logger.isDebugEnabled()) {
                    logger.debug("EnvioArchivo.moveFileToHistoricalFolderError() - Extension de Archivo No permitida => "
                            + f.getName());
                }
            }

        }

    }

    public static void moveFileToHistoricalFolderAll(String sourceDirectory, String destinationDirectory) {
        logger.debug(" Ingreso a moveFileToHistoricalFolder");
        File dirSrc = new File(sourceDirectory);
        File dirTrgt = createHistoricalFolder(destinationDirectory);

        if (dirSrc.isDirectory()) {
            File[] content = dirSrc.listFiles();
            for (int i = 0; i < content.length; i++) {
                if (validateAllowedFileExtension(content[i])) {
                    if (dirTrgt.isDirectory()) {
                        File fileTrgt = new File(dirTrgt, content[i].getName());
                        if (fileTrgt.exists()) {
                            fileTrgt.delete();
                        }
                        boolean success = content[i].renameTo(new File(dirTrgt,
                                content[i].getName()));
                        if (!success) {
                            logger.debug("content[i].getName()" + content[i].getName());
                            if (logger.isDebugEnabled()) {
                                logger.debug("EnvioArchivo.moveFileToHistoricalFolderAll() - Error al pasar archivo a historico");
                                logger.debug("EnvioArchivo.moveFileToHistoricalFolderAll() - Archivo = "
                                        + content[i].getName());
                            }
                        }
                    } else {
                        if (logger.isDebugEnabled()) {
                            logger.debug("EnvioArchivo.moveFileToHistoricalFolderAll() - Error - no existe carpeta => "
                                    + dirTrgt);
                        }
                    }
                } else {
                    if (logger.isDebugEnabled()) {
                        logger.debug("EnvioArchivo.moveFileToHistoricalFolderAll() - Extension de Archivo No permitida => "
                                + content[i].getName());
                    }
                }
            }
        }
    }

    private static boolean validateAllowedFileExtension(File file) {
        if (EXTENSION_PDF.replace(".", "").equals(getFileExtension(file))
                || EXTENSION_XML.replace(".", "")
                .equals(getFileExtension(file))) {
            return true;
        }
        return false;
    }

    private static String getFileExtension(File file) {
        String fileName = file.getName();
        if (fileName.lastIndexOf(".") != -1 && fileName.lastIndexOf(".") != 0) {
            return fileName.substring(fileName.lastIndexOf(".") + 1);
        }
        return "";
    }

    private static File createHistoricalFolder(String directory) {
        File wDirTrgt = null;
        if (getProcessDate() != null) {
            if (logger.isDebugEnabled()) {
                logger.debug("createHistoricalFolder..."
                        + getProcessDate());
            }
            wDirTrgt = new File(directory + getProcessDate());
            wDirTrgt.mkdirs();

        }
        return wDirTrgt;
    }

    public static File createHistoricalFolderError(String directory, String sourceError) {
        File wDirTrgt = null;
        if (getProcessDate() != null) {
            if (logger.isDebugEnabled()) {
                logger.debug("createHistoricalFolderError..."
                        + getProcessDate());
            }
            wDirTrgt = new File(directory + "/" + getProcessDate() + "/" + sourceError);
            wDirTrgt.mkdirs();

        }
        return wDirTrgt;
    }

    public static String getProcessDate() {
        Date myDate = new Date();
        SimpleDateFormat wDmyFormat = new SimpleDateFormat("yyyyMMdd");
        String wDmyDate = wDmyFormat.format(myDate);
        return wDmyDate;
    }

    private static GenerateReportProperties getProperties(String parameter) {
        if (!properties.containsKey(parameter)) {
            properties.put(parameter, new GenerateReportProperties());
        }
        return properties.get(parameter);
    }


    public static void returnParamGeneric(String parameter) {
        if (logger.isDebugEnabled()) {
            logger.debug("Ingresa returnParamGeneric");
        }

        try {
            String query = "{ call cob_cartera..sp_parametros_notificacion(?) }";

            Connection cn = ConnectionManager.openConnection();

            CallableStatement executeSP = cn.prepareCall(query);

            executeSP.setString(1, parameter);
            executeSP.execute();

            ResultSet result = executeSP.getResultSet();

            if (result != null) {
                while (result.next()) {
                    evalueResulset(result, parameter);
                }
            }

            ConnectionManager.closeConnection();

            pathArchives(parameter);
            returnFooterPage(parameter);
            returnNameCompany(parameter);
        } catch (Exception ex) {
            logger.error("ERROR returnParamGeneric:", ex);
        }
    }

    public static File[] returnFile(String parameter, String sourceDirectory) {
        if (logger.isDebugEnabled()) {
            logger.debug("Ingresa returnFile");
        }
        logger.debug("ruta..." + sourceDirectory);
        File f = new File(sourceDirectory);
        File[] ficheros = null;

        String[] nom_ficheros = null;
        if (f.exists()) {
            logger.debug("f.exists()");
            ficheros = f.listFiles();
            if (ficheros.length > 0) {
                logger.debug("ficheros.length: " + ficheros.length);
                nom_ficheros = new String[ficheros.length];

                try {
                    for (int x = 0; x < ficheros.length; x++) {
                        logger.debug("nombre Archivo.. " + ficheros[x].getName());
                        nom_ficheros[x] = stripExtension(ficheros[x].getName());
                        logger.debug("nombre Archivo sin extension.. " + nom_ficheros[x]);
                    }

                } catch (Exception e) {
                    logger.error("ERROR returnFile -->", e);

                }


            } else {
                logger.error("No existe archivos en el directorio");
                return null;

            }
        } else {
            logger.error("No existe Directorio");
            return null;
        }

        return ficheros;
    }

    static String stripExtension(String str) {
        if (str == null)
            return null;
        int pos = str.lastIndexOf(".");
        if (pos == -1)
            return str;
        return str.substring(0, pos);
    }

    private static String returnNameJasper(String parameter) {
        if (logger.isDebugEnabled()) {
            logger.debug("Ingresa returnNameJasper");
        }
        return getProperties(parameter).getPathJasper().concat(getProperties(parameter).getNameJasper());
    }

    private static String returnNameExportJasper(String iteracion, String extension, boolean onlyName, String parameter) {
        if (logger.isDebugEnabled()) {
            logger.debug("Ingresa returnNameJasper");
        }
        return (onlyName ? "" : getProperties(parameter).getPathPdf()).concat(getProperties(parameter).getNamePdf()).concat(iteracion).concat(extension);
    }


    private static void evalueResulset(ResultSet result, String parameter) {
        if (logger.isDebugEnabled()) {
            logger.debug("Ingresa evalueResulset");
            logger.debug("result-->" + result.toString());
        }

        String param;
        try {
            if (logger.isDebugEnabled()) {
                logger.debug("COLUMN_CODE-->" + result.getString(COLUMN_CODE));
                logger.debug("COLUMN_VALUE-->" + result.getString(COLUMN_VALUE));
            }

            param = parameter + "_NXML";
            if ((param).equals(result.getString(COLUMN_CODE))) {
                getProperties(parameter).setNameXml(result.getString(COLUMN_VALUE));
            }

            param = parameter + "_NJAS";
            if ((param).equals(result.getString(COLUMN_CODE))) {
                getProperties(parameter).setNameJasper(result.getString(COLUMN_VALUE));
            }

            param = parameter + "_NPDF";
            if ((param).equals(result.getString(COLUMN_CODE))) {
                getProperties(parameter).setNamePdf(result.getString(COLUMN_VALUE));
            }
        } catch (Exception ex) {
            logger.error("ERROR evalueResulset:", ex);
        }
    }

    private static void pathArchives(String parameter) {
        if (logger.isDebugEnabled()) {
            logger.debug("Ingresa pathArchives");
        }

        ConfigManager config = ConfigManager.getInstance();
        getProperties(parameter).setPathXml(config.getRXmlPath());
        getProperties(parameter).setPathJasper(config.getJasPath());
        getProperties(parameter).setPathPdf(config.getPDFPath());
    }

    private static boolean validationParamGeneric(String parameter) {
        if (logger.isDebugEnabled()) {
            logger.debug("Ingresa validationParamGeneric");
        }

        if (!(evalueParameter(parameter) && evalueXML(parameter) && evalueJasper(parameter) && evaluePDF(parameter))) {
            return false;
        }

        return true;
    }

    private static boolean evalueParameter(String parameter) {
        if (logger.isDebugEnabled()) {
            logger.debug("Ingresa evalueParameter");
            logger.debug("paramExec-->" + parameter);
        }

        String valueEmpty = "";
        if (parameter == null || valueEmpty.equals(parameter)) {
            return false;
        }

        return true;
    }

    private static boolean evalueXML(String parameter) {
        if (logger.isDebugEnabled()) {
            logger.debug("Ingresa evalueXML");

            logger.debug("pathXml-->" + getProperties(parameter).getPathXml());
            logger.debug("nameXml-->" + getProperties(parameter).getNameXml());
        }

        String valueEmpty = "";
        if (getProperties(parameter).getPathXml() == null || valueEmpty.equals(getProperties(parameter).getPathXml())) {
            return false;
        }

        if (getProperties(parameter).getNameXml() == null || valueEmpty.equals(getProperties(parameter).getNameXml())) {
            return false;
        }

        return true;
    }

    private static boolean evalueJasper(String parameter) {
        if (logger.isDebugEnabled()) {
            logger.debug("Ingresa evalueJasper");
            logger.debug("pathJasper-->" + getProperties(parameter).getPathJasper());
            logger.debug("nameJasper-->" + getProperties(parameter).getNameJasper());
        }

        String valueEmpty = "";
        if (getProperties(parameter).getPathJasper() == null || valueEmpty.equals(getProperties(parameter).getPathJasper())) {
            return false;
        }

        if (getProperties(parameter).getNameJasper() == null || valueEmpty.equals(getProperties(parameter).getNameJasper())) {
            return false;
        }

        return true;
    }

    private static boolean evaluePDF(String parameter) {
        if (logger.isDebugEnabled()) {
            logger.debug("Ingresa evalueXML");
            logger.debug("pathPdf-->" + getProperties(parameter).getPathPdf());
            logger.debug("namePdf-->" + getProperties(parameter).getNamePdf());
        }

        String valueEmpty = "";
        if (getProperties(parameter).getPathPdf() == null || valueEmpty.equals(getProperties(parameter).getPathPdf())) {
            return false;
        }

        if (getProperties(parameter).getNamePdf() == null || valueEmpty.equals(getProperties(parameter).getNamePdf())) {
            return false;
        }

        return true;
    }

    private static void returnFooterPage(String parameter) {
        if (logger.isDebugEnabled()) {
            logger.debug("Ingresa returnFooterPage");
        }

        try {
            String query = "{ call cob_cartera..sp_pie_pagina_notificacion(?) }";

            Connection cn = ConnectionManager.openConnection();

            CallableStatement executeSP = cn.prepareCall(query);

            executeSP.setString(1, parameter);
            executeSP.execute();

            ResultSet result = executeSP.getResultSet();

            if (result != null) {
                while (result.next()) {
                    getProperties(parameter).setPiePagina(result.getString(COLUMN_VALUE));
                }
            }

            ConnectionManager.closeConnection();

            pathArchives(parameter);
        } catch (Exception ex) {
            logger.error("ERROR returnFooterPage:", ex);
        }
    }

    private static void returnNameCompany(String parameter) {
        if (logger.isDebugEnabled()) {
            logger.debug("Ingresa returnNameCompany");
        }

        try {
            String query = "{ call cob_cartera..sp_consulta_nombre_empresa(?) }";

            Connection cn = ConnectionManager.openConnection();

            CallableStatement executeSP = cn.prepareCall(query);

            executeSP.setString(1, parameter);
            executeSP.execute();

            ResultSet result = executeSP.getResultSet();

            if (result != null) {
                while (result.next()) {
                    getProperties(parameter).setNameCompany(result.getString(COLUMN_VALUE));
                }
            }

            ConnectionManager.closeConnection();

            pathArchives(parameter);
        } catch (Exception ex) {
            logger.error("ERROR returnFooterPage:", ex);
        }
    }

    static class GenerateReportProperties {

        private String pathXml = "";
        private String pathJasper = "";
        private String pathPdf = "";
        private String nameXml = "";
        private String nameJasper = "";
        private String namePdf = "";
        private String piePagina = "";
        private String nameCompany = "";
        private String InFacFeliPath = "";
        private String InFacFeliHisPath = "";

        public String getPathXml() {
            return this.pathXml;
        }

        public void setPathXml(String pathXml) {
            this.pathXml = pathXml;
        }

        public String getPathJasper() {
            return this.pathJasper;
        }

        public void setPathJasper(String pathJasper) {
            this.pathJasper = pathJasper;
        }

        public String getPathPdf() {
            return this.pathPdf;
        }

        public void setPathPdf(String pathPdf) {
            this.pathPdf = pathPdf;
        }

        public String getNameXml() {
            return this.nameXml;
        }

        public void setNameXml(String nameXml) {
            this.nameXml = nameXml;
        }

        public String getNameJasper() {
            return this.nameJasper;
        }

        public void setNameJasper(String nameJasper) {
            this.nameJasper = nameJasper;
        }

        public String getNamePdf() {
            return this.namePdf;
        }

        public void setNamePdf(String namePdf) {
            this.namePdf = namePdf;
        }

        public String getPiePagina() {
            return this.piePagina;
        }

        public void setPiePagina(String piePagina) {
            this.piePagina = piePagina;
        }

        public String getNameCompany() {
            return this.nameCompany;
        }

        public void setNameCompany(String nameCompany) {
            this.nameCompany = nameCompany;
        }

        public String getInFacFeliPath() {
            return InFacFeliPath;
        }

        public void setInFacFeliPath(String inFacFeliPath) {
            InFacFeliPath = inFacFeliPath;
        }

        public String getInFacFeliHisPath() {
            return InFacFeliHisPath;
        }

        public void setInFacFeliHisPath(String inFacFeliHisPath) {
            InFacFeliHisPath = inFacFeliHisPath;
        }


    }

}
