package com.cobiscorp.ecobis.cobiscloudburo.util;

import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.cobiscloudburo.util.dto.BuroRequest;
import com.cobiscorp.ecobis.cobiscloudburo.util.dto.BuroResponse;
import com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Error;
import com.cobiscorp.ecobis.cobiscloudburo.util.dto.xmlSchemaResponse.Respuesta;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
import org.xml.sax.SAXException;

import javax.xml.bind.JAXBException;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.util.Map;

/**
 * @author Farid Saud
 * @date 6/29/2017
 */
public class BuroServiceExecutor {
    private static ILogger logger = LogFactory.getLogger(BuroServiceExecutor.class);
    private static final String className = "[BuroServiceExecutor]";

    public static BuroResponse getBuroClient(BuroRequest buroRequest) {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[getBuroClient]");
        }

        if (logger.isTraceEnabled()) {
            logger.logTrace("buroRequest: " + buroRequest.toString());
        }

//        buroRequest.getResidence().setColony("Benjamin Mendez");
//        buroRequest.getResidence().setAddress1("COLONIA: Benjamin Mendez CALLE: DE LA ES");

        String xmlRequest;
        try {
            xmlRequest = BuroRequestXMLConverter.buildXML(buroRequest);
        } catch (JAXBException e) {
            throw new COBISInfrastructureRuntimeException("Problems converting to XML", e);
        } catch (SAXException e) {
            throw new COBISInfrastructureRuntimeException("Problems validating XML", e);
        }

//        String host = "localhost";
        String host = buroRequest.getServerAddress().getIp();
//        int port = 8888;
        int port = Integer.parseInt(buroRequest.getServerAddress().getPort());
        String xmlResponse = getReport(xmlRequest, host, port);

        Respuesta respuestaBC;
        try {
            respuestaBC = BuroResponseDTOConverter.buildDTO(xmlResponse);
        } catch (JAXBException e) {
            throw new COBISInfrastructureRuntimeException("Problems converting XML to DTO", e);
        } catch (UnsupportedEncodingException e) {
            throw new COBISInfrastructureRuntimeException("Problems recovering XML information", e);
        }

        Error error = respuestaBC.getPersonas().getPersona().getError();
        if (error != null) {
            throw new COBISInfrastructureRuntimeException("Error from Credit Bureau", new Exception(error.toString()));
        }

        XStream xStream = new XStream(new DomDriver());
        xStream.registerConverter(new BuroResponseMapConverter());
        xStream.alias("Respuesta", Map.class);

        Map<String, Object> mapResponseBC = (Map<String, Object>) xStream.fromXML(xmlResponse);
        if (logger.isTraceEnabled()) {
            logger.logTrace("mapResponseBC: " + mapResponseBC.toString());
        }

        BuroResponse buroResponse = new BuroResponse();
        buroResponse.setResponseXml(xmlResponse);
        buroResponse.setData(mapResponseBC);
        buroResponse.setRespuesta(respuestaBC);
        return buroResponse;
    }

    private static String getReport(String xmlRequest, String host, int port) {
        Socket socket = null;
        OutputStream outputStream = null;
        DataOutputStream dataOutputStream = null;
        InputStream inputStream = null;
        ByteArrayOutputStream byteArrayOutputStream = null;
        String xmlResponse = null;

        try {
            // Connecting to Credit Bureau
            socket = new Socket();
            socket.connect(new InetSocketAddress(host, port), 30000);
            socket.setSoTimeout(60000);
            socket.setTcpNoDelay(true);

            if (!socket.isConnected()) {
                throw new COBISInfrastructureRuntimeException("The system cannot connect to Credit Bureau");
            }

            if (logger.isDebugEnabled()) {
                logger.logDebug("Before sending information");
            }

            /************************/
            // Example of Request XML
/*
            String request;
            BufferedReader brRequest = new BufferedReader(new FileReader("c:\\temp\\Consulta.xml"));
            try {
                StringBuilder sb = new StringBuilder();
                String line = brRequest.readLine();

                while (line != null) {
                    sb.append(line);
                    line = brRequest.readLine();
                }
                request = sb.toString();
            } finally {
                brRequest.close();
            }
            xmlRequest = request;
*/
            /************************/

            if (logger.isTraceEnabled()) {
                logger.logTrace("xmlRequest: " + xmlRequest);
            }

            // Sending XML information to Credit Bureau
            outputStream = socket.getOutputStream();
            dataOutputStream = new DataOutputStream(outputStream);
            dataOutputStream.writeBytes(xmlRequest);
            dataOutputStream.write(0x13);
            dataOutputStream.flush();

            if (logger.isDebugEnabled()) {
                logger.logDebug("Before receiving information");
            }

            // Reading answer from Credit Bureau
            inputStream = socket.getInputStream();
            byteArrayOutputStream = new ByteArrayOutputStream();
            byte data;
            byte previousValue = Byte.MIN_VALUE;
            byte currentValue;
            while ((data = (byte) inputStream.read()) != -1) {
//                if (logger.isTraceEnabled()) {
//                    logger.logTrace("Data received: " + data);
//                }
                byteArrayOutputStream.write(data);
                currentValue = data;
                if (previousValue == 13 && currentValue == 10) {
                    break;
                }
                previousValue = currentValue;
            }

            if (logger.isDebugEnabled()) {
                logger.logDebug("Information received");
            }

            xmlResponse = byteArrayOutputStream.toString().trim();
            xmlResponse = xmlResponse.substring(xmlResponse.indexOf("<?xml"));

            /*************************/
            // Example of Response XML
/*
            String response;
            BufferedReader brResponse = new BufferedReader(new FileReader("c:\\temp\\Respuesta.xml"));
            try {
                StringBuilder sb = new StringBuilder();
                String line = brResponse.readLine();

                while (line != null) {
                    sb.append(line);
                    line = brResponse.readLine();
                }
                response = sb.toString();
            } finally {
                brResponse.close();
            }
            xmlResponse = response;
*/
            /*************************/

            if (logger.isTraceEnabled()) {
                logger.logTrace("xmlResponse: " + xmlResponse);
            }

            return xmlResponse;
        } catch (SocketException e) {
            throw new COBISInfrastructureRuntimeException("Exception in socket handling", e);
        } catch (UnknownHostException e) {
            throw new COBISInfrastructureRuntimeException("Unknown host for connection", e);
        } catch (IOException e) {
            throw new COBISInfrastructureRuntimeException("Input/Output error", e);
        } finally {
            if (xmlResponse == null) {
                if (byteArrayOutputStream != null) {
                    if (logger.isErrorEnabled()) {
                        logger.logDebug("RESPUESTA BURO DE CREDITO: " + byteArrayOutputStream.toString().trim());
                    }
                }
            }
            try {
                if (socket != null) socket.close();
                if (outputStream != null) outputStream.close();
                if (dataOutputStream != null) dataOutputStream.close();
                if (inputStream != null) inputStream.close();
                if (byteArrayOutputStream != null) byteArrayOutputStream.close();
            } catch (IOException e) {
                throw new COBISInfrastructureRuntimeException("Exception in socket handling", e);
            }
        }
    }
}
