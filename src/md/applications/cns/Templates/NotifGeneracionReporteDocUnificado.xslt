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
          Procesamiento del Archivo <xsl:value-of select="file_name" /> Fallido
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
              <div id="content" class="content">
                <div id="transaction-content" class="transaction-zone">
                  <p><i>Estimado Cliente:</i></p>
				  <br></br>				  
                  <p><i>Es un gusto informarte que la formalización de tu  
    				<span>
                      <xsl:value-of select="tproductoDesc" />
                    </span>
					ha concluido con éxito con el número de contrato 				  
    				<span>
                      <xsl:value-of select="numBanco" />
                    </span>
                    .</i>
				  </p>
				  <br></br>
				  <p><i>Derivado de lo anterior, por este medio te compartimos la carátula, contrato, tabla de amortización y los anexos relacionados a la contratación de tu Crédito.</i></p>
				  <br></br>
                  <p><i>Para cualquier duda estamos a tus órdenes en el siguiente número telefónico: 5551694363</i></p>
				  <br></br>
                </div>	     
              </div>
			</td>		
          </tr>
		  <tr>
            <td>
              <div id="notes" class="notes">
                <p>Santander Inclusión Financiera, S.A. de C.V., SOFOM, E. R., Grupo Financiero Santander México.</p>
                <p>Es importante que no compartas tu tarjeta, contraseñas,  acceso a tus cuentas o entrega de efectivo  a ningún empleado de Tuiio.</p>
              </div>
            </td>
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>