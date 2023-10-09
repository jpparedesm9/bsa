<?xml version='1.0'?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="ISO-8859-1" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

  <xsl:template match="/data">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title>TUIIO - Notificación Electrónica</title>
        <style type="text/css">
          body {margin:0; padding:0; width:100%;
          font-family:"Segoe UI", Tahoma, Geneva, Verdana;}
          #main, #disclaimer {width:820px; margin:10px auto;}
          #main {border:1px #7e99aa solid;}
          #main #header .logo { width:800px; height:90px; padding:0px;}
          #main #header #service {float:right; text-align:right; font-size:1.75em; color:#FFFFFF; font-style:oblique; padding:23px; line-height:40px; height:40px;}
          #main #title {background:#2279b1; padding:5px 10px; color:white; font-weight:bold; text-transform:uppercase;width:800px;}
          #main #content {background:#f0f7f9; padding: 10px; color:black; font-size:1em; width:800px;}
          #main #content p {margin:0; margin-bottom:5px;}
          #main #content #transaction-zone {background:white; padding: 10px; margin:20px 0 10px 0; border:1px #7e99aa solid;}
          #main #content #transaction-zone p { margin-bottom:10px; margin-left:3px;}
          #main #content #transaction-zone span.label { font-weight:bold; font-style:italic; margin-bottom:2px;}
          #main #footer {background:#2279b1; padding: 5px 10px; color:white; font-size: 0.7em; text-align:center;}
          #main #footer p {margin:0; width:820px;}
          #disclaimer {font-size:11px; color:#666666;}
        </style>
      </head>
      <body>
        <div id="main">
          <div id="header">

          </div>
          <div id="title">
            Notificación Electrónica
          </div>
          <div id="content">
          <p><xsl:value-of select="fechaDoc" /></p>
            <p>
              Hola
              <xsl:value-of select="nombreC" />
              <br/>
            </p>
            <br/>
            <p>
             <xsl:value-of select="parrafoDoc" />
            </p>
            <br/>
            <p><xsl:value-of select="parrafoDoc2" /></p>
            <br/>
            <p>
              Si usted no reconoce esta operación favor de llamar al 55 51694363 desde la CDMX o en el interior de la República y con gusto te atenderemos. 
            </p>
            <br/>
            <br/>
            <p>
              Atentamente.
            </p>
            <br/>
            <table>
              <tr>
                <td>
                  <img alt="Tuiio Santander" src="logo2.png" class="logo2"/>
                </td>
              </tr>
            </table>
          </div>
          <div id="footer">
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>