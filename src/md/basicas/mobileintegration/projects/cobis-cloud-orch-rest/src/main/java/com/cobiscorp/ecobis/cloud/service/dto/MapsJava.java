package com.cobiscorp.ecobis.cloud.service.dto;

import java.lang.reflect.Array;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

public abstract class MapsJava
{
  private final ILogger logger = LogFactory.getLogger(MapsJava.class);
  private static int connectTimeout = 300;
  private static String region = "es";
  private static String language = "es";
  private static Boolean sensor = Boolean.FALSE;
  private static String APIKey = "";
  private static String[][] stockRequest = new String[0][6];
  private static int numRequest = 0;
  
  protected abstract void onError(URL paramURL, String paramString, Exception paramException);
  
  protected abstract String getStatus(XPath paramXPath, Document paramDocument);
  
  protected abstract void storeInfoRequest(URL paramURL, String paramString1, String paramString2, Exception paramException);
  
  protected void storageRequest(String urlRequest, String info, String status, Exception exception)
  {
    Date date = new Date();
    numRequest += 1;
    stockRequest = (String[][])resizeArray(stockRequest, numRequest);
    if (stockRequest[(numRequest - 1)] == null) {
      stockRequest[(numRequest - 1)] = new String[6];
    }
    stockRequest[(numRequest - 1)][0] = String.valueOf(numRequest);
    stockRequest[(numRequest - 1)][1] = date.toString();
    stockRequest[(numRequest - 1)][2] = status;
    stockRequest[(numRequest - 1)][3] = urlRequest;
    stockRequest[(numRequest - 1)][4] = info;
    if (exception == null) {
      stockRequest[(numRequest - 1)][5] = "No exception";
    } else {
      stockRequest[(numRequest - 1)][5] = exception.toString();
      
    }
    logger.logDebug("NO STATUS-->"+stockRequest);
  }
  
  protected String getSelectPropertiesRequest()
  {
	  String key = "AIzaSyBRdzwaUFdmAGF8ExiNkTG3upBjWqIyP0c";
    return  "&sensor=true"+ "&key=" + key ;
  }
  
  protected ArrayList<String> getNodesString(NodeList node)
  {
    ArrayList<String> result = new ArrayList();
    int j = 0;
    for (int n = node.getLength(); j < n; j++)
    {
      String nodeString = node.item(j).getTextContent();
      result.add(nodeString);
    }
    return result;
  }
  
  protected ArrayList<Double> getNodesDouble(NodeList node)
  {
    ArrayList<Double> result = new ArrayList();
    int j = 0;
    for (int n = node.getLength(); j < n; j++)
    {
      String nodeString = node.item(j).getTextContent();
      result.add(Double.valueOf(nodeString));
    }
    return result;
  }
  
  protected ArrayList<Integer> getNodesInteger(NodeList node)
  {
    ArrayList<Integer> result = new ArrayList();
    int j = 0;
    for (int n = node.getLength(); j < n; j++)
    {
      String nodeString = node.item(j).getTextContent();
      result.add(Integer.valueOf(nodeString));
    }
    return result;
  }
  
  protected Object resizeArray(Object oldArray, int newSize)
  {
    int oldSize = Array.getLength(oldArray);
    Class elementType = oldArray.getClass().getComponentType();
    Object newArray = Array.newInstance(elementType, newSize);
    
    int preserveLength = Math.min(oldSize, newSize);
    if (preserveLength > 0) {
      System.arraycopy(oldArray, 0, newArray, 0, preserveLength);
    }
    return newArray;
  }
  
  public static String APIkeyCheck(String key)
  {
    try
    {
      URL url = new URL("https://maps.googleapis.com/maps/api/place/search/xml?location=0,0&radius=1000&sensor=false&key=" + key);
      
      DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
      DocumentBuilder builder = factory.newDocumentBuilder();
      Document document = builder.parse(url.openStream());
      XPathFactory xpathFactory = XPathFactory.newInstance();
      XPath xpath = xpathFactory.newXPath();
      
      NodeList nodeLatLng = (NodeList)xpath.evaluate("PlaceSearchResponse/status", document, XPathConstants.NODESET);
      
      return nodeLatLng.item(0).getTextContent();
    }
    catch (Exception e) {}
    return "NO STATUS";
  }
  
  public static int getConnectTimeout()
  {
    return connectTimeout;
  }
  
  public static void setConnectTimeout(int aConnectTimeout)
  {
    connectTimeout = aConnectTimeout;
  }
  
  public static String getRegion()
  {
    return region;
  }
  
  public static void setRegion(String aRegion)
  {
    region = aRegion;
  }
  
  public static String getLanguage()
  {
    return language;
  }
  
  public static void setLanguage(String aLanguage)
  {
    language = aLanguage;
  }
  
  public static Boolean getSensor()
  {
    return sensor;
  }
  
  public static void setSensor(Boolean aSensor)
  {
    sensor = aSensor;
  }
  
  public static String getKey()
  {
    return APIKey;
  }
  
  public static void setKey(String aKey)
  {
    APIKey = aKey;
  }
  
  public static String[][] getStockRequest()
  {
    return stockRequest;
  }
  
  public static String[] getLastRequestRequest()
  {
    String[] stockRequestTemp = new String[6];
    System.arraycopy(stockRequest[(stockRequest.length - 1)], 0, stockRequestTemp, 0, 6);
    return stockRequestTemp;
  }
  
  public static String getLastRequestStatus()
  {
    return stockRequest[(stockRequest.length - 1)][2];
  }
  
  public static String getLastRequestURL()
  {
    return stockRequest[(stockRequest.length - 1)][3];
  }
  
  public static String getLastRequestInfo()
  {
    return stockRequest[(stockRequest.length - 1)][4];
  }
  
  public static String getLastRequestException()
  {
    return stockRequest[(stockRequest.length - 1)][5];
  }
}

