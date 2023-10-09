Attribute VB_Name = "MODIMG"
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          MODIMG.BAS
' NOMBRE LOGICO:    MODIMG
' PRODUCTO:         Terminal Administrativa
'*************************************************************
'                       IMPORTANTE
' Esta aplicacion es parte de los paquetes bancarios propiedad
' de MACOSA S.A.
' Su uso no  autorizado queda  expresamente prohibido asi como
' cualquier  alteracion o  agregado  hecho por  alguno  de sus
' usuarios sin el debido consentimiento por escrito de MACOSA.
' Este programa esta protegido por la ley de derechos de autor
' y por las  convenciones  internacionales de  propiedad inte-
' lectual.  Su uso no  autorizado dara  derecho a  MACOSA para
' obtener ordenes  de secuestro o  retencion y para  perseguir
' penalmente a los autores de cualquier infraccion.
'*************************************************************
'                         PROPOSITO
' Módulo de manejo de firmas candidatas y condiciones de
' las cuentas
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
option explicit

'FIXIT: Declare 'VGBitmap32' with an early-bound data type                                 FixIT90210ae-R1672-R1B8ZE
Global VGBitmap32 As Object
Global VGGrafo() As String           'Arreglo con el código y la firma



'FIXIT: Declare 'Picture' with an early-bound data type                                    FixIT90210ae-R1672-R1B8ZE
Public Sub BitMap(Picture As Variant, ByVal lpBits As String, ByVal Col As Integer, ByVal Row As Integer)
  VGBitmap32.Bitmap32 Picture, lpBits, Col, Row
End Sub






