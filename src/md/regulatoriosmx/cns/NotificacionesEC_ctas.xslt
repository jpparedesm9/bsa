<?xml version='1.0'?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="ISO-8859-1"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title>CAPITAL BANK - Notificación Electrónica</title>
        <style type="text/css">
          body {margin:0; padding:0; width:100%;
          font-family:"Segoe UI", Tahoma, Geneva, Verdana;}
          #main, #disclaimer {width:600px; margin:10px auto;}
          #main {border:1px #7e99aa solid;}
          <!-- #main #header {background:url(email_header_bg.png) #355A91 no-repeat right; height:87px;} -->
          #main #header {background: #ffffff no-repeat right; height:87px; }
          #main #header .logo { width:590; height:80px; padding:0px;}
          #main #header #service {float:right; text-align:right; font-size:1.75em; color:#FFFFFF; font-style:oblique; padding:23px; line-height:40px; height:40px;}
          #main #title {background:#2279b1; padding:5px 10px; color:white; font-weight:bold; text-transform:uppercase;}
          #main #content {background:#f0f7f9; padding: 10px; color:black; font-size:0.8em;}
          #main #content p {margin:0; margin-bottom:5px;}
          #main #content #transaction-zone {background:white; padding: 10px; margin:20px 0 10px 0; border:1px #7e99aa solid;}
          #main #content #transaction-zone p { margin-bottom:10px; margin-left:3px;}
          #main #content #transaction-zone span.label { font-weight:bold; font-style:italic; margin-bottom:2px;}
          #main #footer {background:#2279b1; padding: 5px 10px; color:white; font-size: 0.7em; text-align:center;}
          #main #footer p {margin:0;}
          #disclaimer {font-size:11px; color:#666666;}
        </style>
      </head>
      <body>
        <div id="main">
          <div id="header">
            <table>
              <tr>
                 <td> 
                <img alt="COBIS Notification Server" src="Cobiscorp.jpg" class="logo"  />
                 </td> 
              </tr>
            </table>
            <!-- <span id="service">.</span> -->
          </div>
          <div id="title">
            Notificación Automática
          </div>
          <div id="content">                                    
            <!--<p>A continuación se encuentra el detalle de la notificación.</p>-->            
            <p>
              Estimado Cliente:
            </p>
            <br/>
            <p>
              Por este medio le hacemos llegar la notificación de referencias:
            </p>
			<div>
    <table border="1">
      <tr bgcolor="#9acd32">
        <th>Codigo</th>
        <th>Nombre</th>
		<th>Causa</th>
      </tr>
      <xsl:for-each select="data/referencia">
      <tr>
        <td><xsl:value-of select="codigo" /></td>
        <td><xsl:value-of select="nombre" /></td>
		<td><xsl:value-of select="causa" /></td>
      </tr>
      </xsl:for-each>
    </table> 

			</div>
            <p>
              Saludos Cordiales,
              <br/>
              <strong>
                <xsl:value-of select="data/nombreBanco"/>
              </strong>
            </p>                        
          </div>
          <div id="footer">
            
          </div>
        </div>
        <div id="disclaimer">
          <!--Corporación Financiera Nacional Nota de descargo: La información transmitida en este correo electrónico es confidencial, provisional y referencial; sólo puede ser utilizada por la persona a quien está dirigida. Esta prohibida la reproducción, distribución, copia parcial o total sin la expresa autorización de Corporación Financiera Nacional. La CFN no se responsabiliza por información, opiniones o criterios emitidos en el presente correo electrónico.-->
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>