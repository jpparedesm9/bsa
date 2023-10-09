Attribute VB_Name = "Map"
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          Map.bas
' NOMBRE LOGICO:    Map
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
' Se hace la declaracion de variables globales para conexion,
' constantes globales para conexion, tipos de datos usados en
' la BD y Funciones externas
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

'Declaración de Variables Globales para Conexión
'FIXIT: Declare 'VGMap' with an early-bound data type                                      FixIT90210ae-R1672-R1B8ZE
Global VGMap As Object

'Global SqlConn&                     'Manejador de la conexión al SQL Server
'Global ServerName$                  'Nombre del Servidor SQL Remoto
'Global ServerNameLocal$             'Nombre del Servidor SQL Local
'Global Password$                    'Password

Global VGEjecProc As Integer        'Determina si esta en ejecución un stored procedure 'OUS


'Declaración de Constantes globales para Conexión


'Declaración de los tipos de datos usados en la BD
Global Const SQLVARCHAR& = &H27
Global Const SQLCHAR& = &H2F
Global Const SQLINT1& = &H30
Global Const SQLINT2& = &H34
Global Const SQLINT4& = &H38
Global Const SQLMONEY& = &H3C
Global Const SQLDATETIME& = &H3D
Global Const SQLFLT8& = &H3E
Global svArchivo As String
Global fil As Integer
Global col As Integer
Global i As Integer
Global VGTitularidad As String
Global j As Integer
Global fila As Integer
Global columna As Integer
Global VGCliente As String
Global CGFORMATOFECHA As String
Global VGTerminal As String
Global VLPaso As Integer








'Declaración de Funciones externas

'FIXIT: Declare 'FMMapeaGrafo' and 'parMatrizGrafo' with an early-bound data type          FixIT90210ae-R1672-R1B8ZE
Public Function FMMapeaGrafo(parSqlConn As Long, parMatrizGrafo, parClear As Boolean)
    FMMapeaGrafo = VGMap.FMMapeaGrafo32(parSqlConn, parMatrizGrafo, parClear)
End Function


Public Function FMRetStatus(parSqlConn As Long) As Integer
    FMRetStatus = VGMap.FMRetStatus32(parSqlConn&)
End Function

Public Function FMInitMap(parHelpLine As Control, parTrnLine As Control, parFocoL As Control, parFocoT As Control, parFocoR As Control, parFocoP As Control, parLogFile As String) As Integer
'FIXIT: Declare 'VTHelpLine' with an early-bound data type                                 FixIT90210ae-R1672-R1B8ZE
Dim VTHelpLine As Object
Set VTHelpLine = parHelpLine
'FIXIT: Declare 'VTTrnLine' with an early-bound data type                                  FixIT90210ae-R1672-R1B8ZE
Dim VTTrnLine As Object
Set VTTrnLine = parTrnLine
'FIXIT: Declare 'VTFocoL' with an early-bound data type                                    FixIT90210ae-R1672-R1B8ZE
Dim VTFocoL As Object
Set VTFocoL = parFocoL
'FIXIT: Declare 'VTFocoT' with an early-bound data type                                    FixIT90210ae-R1672-R1B8ZE
Dim VTFocoT As Object
Set VTFocoT = parFocoT
'FIXIT: Declare 'VTFocoR' with an early-bound data type                                    FixIT90210ae-R1672-R1B8ZE
Dim VTFocoR As Object
Set VTFocoR = parFocoR
'FIXIT: Declare 'VTFocoP' with an early-bound data type                                    FixIT90210ae-R1672-R1B8ZE
Dim VTFocoP As Object
Set VTFocoP = parFocoP

    FMInitMap = VGMap.FMInitMap32(VTHelpLine, VTTrnLine, VTFocoL, VTFocoT, VTFocoR, VTFocoP, parLogFile)
End Function

'FIXIT: Declare 'parArreglo' with an early-bound data type                                 FixIT90210ae-R1672-R1B8ZE
Public Function FMMapeaArreglo(parSqlConn As Long, parArreglo As Variant) As Integer
    FMMapeaArreglo = VGMap.FMMapeaArreglo32(parSqlConn, parArreglo)
End Function

'FIXIT: Declare 'parMatriz' with an early-bound data type                                  FixIT90210ae-R1672-R1B8ZE
Public Function FMMapeaMatriz(parSqlConn As Long, parMatriz As Variant) As Integer
    FMMapeaMatriz = VGMap.FMMapeaMatriz32(parSqlConn, parMatriz)
End Function

Public Function FMTransmitirRPC(parSqlConn As Long, parServer As String, parDataBase As String, parSP As String, parMoveFocos As Boolean, parMessage As String) As Boolean
    FMTransmitirRPC = VGMap.FMTransmitirRPC32(parSqlConn&, parServer$, parDataBase$, parSP$, parMoveFocos, parMessage$)
End Function

Public Function FMRetParam(parSqlConn As Long, parNumParamOut As Long) As String
    FMRetParam = VGMap.FMRetParam32(parSqlConn&, parNumParamOut)
End Function

Public Sub PMChequea(ByVal parSqlConn As Long)
    VGMap.PMChequea32 parSqlConn&
End Sub

Public Sub PMDebug(parSqlCon As Long, parStatus As Boolean)
    VGMap.PMDebug32 parStatus
End Sub

Public Sub PMMapeaGrid(ByVal parSqlConn&, ByVal parGrid As Control, ByVal parCleanGrid As Boolean)
'**********************************************************************
'PROPOSITO: Mapea los datos al grid
'INPUT:
'OUTPUT:
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'12/Sep/01  T.Suárez            Actualización para NCS
'*********************************************************
    parGrid.col = parGrid.col   'Añadido por T.Suárez
    VGMap.PMMapeaGrid32 parSqlConn&, parGrid, parCleanGrid
    
End Sub

Public Sub PMMapeaObjeto(ByVal parSqlConn&, ByVal parObjeto As Control)
    VGMap.PMMapeaObjeto32 parSqlConn&, parObjeto
End Sub

Public Sub PMMapeaObjetoAB(ByVal parSqlConn&, ByVal parObjetoA As Control, ByVal parObjetoB As Control)
    VGMap.PMMapeaObjetoAB32 parSqlConn&, parObjetoA, parObjetoB
End Sub

Public Sub PMMapeaListaH(ByVal parSqlConn&, ByVal parLista As Control, ByVal parCleanList As Boolean)
    VGMap.PMMapeaListaH32 parSqlConn&, parLista, parCleanList
End Sub

Public Sub PMMapeaVariable(ByVal parSqlConn&, parVariable As String)
    VGMap.PMMapeaVariable32 parSqlConn&, parVariable$
End Sub

Public Sub PMPasoValores(ByVal parSqlConn As Long, ByVal parName As String, ByVal parType As Integer, ByVal parDataType As Long, ByVal parValue As String)
    VGMap.PMPasoValores32 parSqlConn&, parName$, parType%, parDataType&, parValue$
End Sub

Public Sub SqlExit()
    VGMap.SqlExit32
End Sub

Public Sub SqlWinExit()
    VGMap.SqlWinExit32
End Sub

Public Sub SqlClose(parSqlConn As Long)
    VGMap.SqlClose32 parSqlConn&
End Sub

Public Function SqlInit() As String
    SqlInit = VGMap.SQLInit32
End Function

'Añadido por T.Suárez
'FIXIT: Declare 'Server' with an early-bound data type                                     FixIT90210ae-R1672-R1B8ZE
Public Sub PMCambioPassword(ByVal parSqlConn As Long, ByVal Server, ByVal ServerLocal As String, ByVal Login As String, ByVal Filial As Integer, ByVal Oficina As Integer)
         VGMap.PMCabioPassword32 parSqlConn, Server, ServerLocal, Login, Filial, Oficina
End Sub
'Añadido por T.Suárez
Public Function SqlOpenLogin(ByRef parServer As String, ByRef parLogin As String, ByVal parApplication As String, ByVal parHost As String) As Long
         SqlOpenLogin& = VGMap.SQLOpenLogin32(parServer, parLogin, parApplication, parHost)
End Function

'OUS
Public Function FmMapeaNumMensaje() As String
    FmMapeaNumMensaje = VGMap.FmMapeaNumMensaje()
End Function

