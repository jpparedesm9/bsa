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
          
          <div id="content">
          
            <p>
              Estimado(a) Sr(a) <xsl:value-of select="nombres" /><br/>
			  Presidente del grupo: <xsl:value-of select="grupo" /><br/>
            </p><br/>
			<p>
				En Tuiio estamos muy contentos de informarte que gracias al compromiso de los integrantes de tu grupo, 
				y al cumplimiento puntual que hicieron de sus pagos en nuestros canales digitales (Getnet y Tuiio Móvil), 
				se les regresará el <xsl:value-of select="tasaDescuento" />%, 
				de la tasa de interés actual, que corresponde a la cantidad de: 
				<xsl:value-of select="descuento" />, como parte del programa Digitalízate y Gana.				
			</p><br/>
            <p>
				Esta cantidad será depositada en su tarjeta Santander en el transcurso de 3 días hábiles. El desglose de la devolución, lo encontrará en el archivo adjunto para que pueda distribuirlo entre los integrantes de su grupo.
			</p><br/>
			<p>
				Agradecemos tu confianza y la de tu grupo. Y deseamos que permanezcan mucho tiempo más con nosotros, y que juntos sigamos cumpliendo nuestras metas.
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