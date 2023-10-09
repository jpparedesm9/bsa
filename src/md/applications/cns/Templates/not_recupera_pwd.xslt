<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="ISO-8859-1" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

  <xsl:template match="/data">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title>COBIS - Notificación Electrónica</title>
        <style type="text/css">
          body {margin:0; padding:0; width:100%;
          font-family:"Segoe UI", Tahoma, Geneva, Verdana;}		  
          #main, #disclaimer {width:820px; margin:10px auto;}
          #main {border:1px #7e99aa solid;padding:10px}
          #main #header {background: #ffffff no-repeat right; height:87px; }          
          #main #header .logo { width:800px; height:90px; padding:0px;}
          #main #header #service {float:right; text-align:right; font-size:1.75em; color:#FFFFFF; font-style:oblique; padding:23px; line-height:40px; height:40px;}
          #main #title {background:#2279b1; padding:5px 10px; color:white; font-weight:bold; text-transform:uppercase;width:800px;}
          #main #content {background:#FFFFFF; padding: 10px; color:black; font-size:0.8em; width:800px;}
          #main #content p {margin:0; margin-bottom:5px}
          #main #content p strong {font-weight:bold;font-size: 12pt;}
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
              Estimado Colaborador,
            </p>
            <br/>
            <br/>
            <p>
             Se está realizando una operación para recuperar contraseña, dentro del correo encontrarás una clave temporal que te ayudará a concluir tu proceso de actualización y con ello tengas acceso a tus herramientas de trabajo.
            </p>
            <br/>
            <p>
              <strong>
                <xsl:value-of select="otp"/>
              </strong>
            </p>
            <br/>
            <p>Atentamente.</p>
            <p>Equipo Tuiio.</p>
            <p>Correo enviado de forma automática, favor de no responderlo. </p>
          </div>
          <div id="footer">
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>