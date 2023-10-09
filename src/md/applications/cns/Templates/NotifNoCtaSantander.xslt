<?xml version='1.0' encoding='utf-8' ?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />
  <xsl:template match="/data">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>
          Solicitud Declinada
        </title>
        <style type="text/css">
          .main
          {
          border: 1px #efefef solid;
          background-color: #FFFFFF;
          width: 640px;
          height: 480px;
          font-family: Arial, Helvetica, sans-serif;
          font-size: 12px;
          }
          .header
          {
          width: 640px;
          background-color: #FFFFFF;
          }
          .title
          {
          color: #000000;
          font-size: 16px;
          font-weight: bold;
          text-align: center;
          background-color: #FFFFFF;
          font-family: Arial, Helvetica, sans-serif;
          }

          .subtitle
          {
          color: #000000;
          font-size: 12px;
          font-weight: bold;
          text-align: right;
          background-color: #FFFFFF;
          font-family: Arial, Helvetica, sans-serif;
          }
          .content
          {
          background-color: #FFFFFF;
          padding: 12px;
          color: black;
          font-family: Arial, Helvetica, sans-serif;
          text-align: left;
          margin: 10px 10px 10px 10px
          }
          .transaction-content
          {
          color: #000000;
          font-size: 12px;
          text-align: left;
          background-color: #FFFFFF;
          font-family: Arial, Helvetica, sans-serif;
          }
          .transaction-zone
          {
          background: #FFFFFF;
          padding: 10px;
          margin: 10px 0 10px 0;
          border: 1px #7e99aa solid;
          font-family: Arial, Helvetica, sans-serif;
          font-size: 12px;
          }

          .notes
          {
          width: 635px;
          height: 45px;
          font-size: 10px;
          color: Black;
          text-align: center;
          font-weight: bold;
          font-family: Arial, Helvetica, sans-serif;
          }
        </style>
      </head>
      <body>
        <table id="main" class="main" cellspacing="0" width="100%">
          <tr>
            <td>
              <div id="header" class="header">
                <img alt="Cobiscorp" src="logo2.png" />
              </div>
              <div id="title" class="title">
                <span>
                  Solicitud Declinada
                </span>
              </div>
              <div id="content" class="content">
                <div id="transacrion-content" class="transaction-zone">
                  <p>Estimado(a) Usuario(a)</p>				  
                  
                  <p>Debido a inconvenientes en la verificación de datos de la solicitud, no será posible otorgar o renovar la línea de crédito revolvente.</p>
                  <br></br>
                  <p>El Equipo de TUIIO</p>
                  <br></br>
                </div>
              </div>
            </td>
          </tr>
          
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c)1998-2004. Sonic Software Corporation. All rights reserved.
<metaInformation><scenarios ><scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="data.xml" htmlbaseurl="" outputurl="" processortype="internal" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""/></scenarios><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition></MapperMetaTag></metaInformation>
-->