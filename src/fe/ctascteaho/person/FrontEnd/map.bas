Attribute VB_Name = "Map"
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
'Declaración de Variables Globales para Conexión
'FIXIT: Declare 'VGMap' with an early-bound data type                                      FixIT90210ae-R1672-R1B8ZE
Global VGMap As Object
'! removed Global VGMensajeRPC As Integer
'Indicador del mensaje de error producido por el rpc
'! removed Global dblib_version$
'Versión de la librería W3dblib.dll
'! removed Global LoginTimeout%
'Tiempo de espera para el login
'! removed Global QueryTimeout%
'Tiempo de espera para consultas

'Declaración de Constantes globales para Conexión
'! removed Global Const PARAM_INPUT = 0

'! removed Global Const PARAM_OUTPUT = 1


'Declaración de los tipos de datos usados en la BD
Global Const SQLVARCHAR& = &H27
Global Const SQLCHAR& = &H2F
Global Const SQLINT1& = &H30
Global Const SQLINT2& = &H34
Global Const SQLINT4& = &H38
Global Const SQLMONEY& = &H3C
Global Const SQLDATETIME& = &H3D
Global Const SQLFLT8& = &H3E

' GBB29mAY98001 II:
' Se aumentan las varibles existentes en el antiguo map.bas

'! removed Global Const SQLTEXT% = &H23

'! removed Global Const SQLARRAY% = &H24

'! removed Global Const SQLVARBINARY% = &H25

'! removed Global Const SQLINTN% = &H26

'! removed Global Const SQLBINARY% = &H2D

'! removed Global Const SQLIMAGE% = &H22

'! removed Global Const SQLBIT% = &H32


'! removed Global Const SQLFLTN% = &H6D

'! removed Global Const SQLFLT4& = &H3B

'! removed Global Const SQLMONEYN% = &H6E

'! removed Global Const SQLDATETIMN% = &H6F

'! removed Global Const SQLAOPCNT% = &H4B

'! removed Global Const SQLAOPSUM% = &H4D

'! removed Global Const SQLAOPAVG% = &H4F

'! removed Global Const SQLAOPMIN% = &H51

'! removed Global Const SQLAOPMAX% = &H52

'! removed Global Const SQLAOPANY% = &H53

'! removed Global Const SQLAOPNOOP% = &H56

'! removed Global Const SQLMONEY4% = &H7A

'! removed Global Const SQLDATETIM4% = &H3A


'Variables Globales

'! removed Global Const GFSR_SYSTEMRESOURCES = &H0


'! Declare Sub PMIndicadores Lib "map.dll" (ByVal valor As Integer, ByVal Estado As Integer)
'! Declare Sub PMMapeaHoja Lib "map.dll" (ByVal Conexion As Integer, Grid As Control, ByVal Modo As Integer)
'! Declare Sub PMMapeaHoja3 Lib "map.dll" (ByVal Conexion As Integer, Grid As Control, ByVal Modo As Integer)
'! Declare Sub BorraGrid Lib "map.dll" (Grid As Control)
'! Declare Sub PMMapeaTexto Lib "map.dll" (ByVal Conexion As Integer, Objeto As Control)
'! Declare Function FMUseExistConn Lib "map.dll" (Grid As Control) As Integer

'GBB29mAY98001 IF:

'---
'GBB29mAY98001 DI:
'Se eliminan las funciones GetPrivateProfileInt,GetPrivateProfileString
    'Declare Function GetPrivateProfileInt Lib "Kernel" (ByVal lpApplicationName As String, ByVal lpKeyName As String, ByVal nDefault As Integer, ByVal lpFileName As String) As Integer
    'Declare Function GetPrivateProfileString Lib "Kernel" (ByVal lpApplicationName As String, ByVal lpKeyName As String, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nsize As Integer, ByVal lpFileName As String) As Integer
'GBB29mAY98002 IF:
'! Declare Function WritePrivateProfileString Lib "Kernel" (ByVal lpApplicationName As String, ByVal lpKeyName As String, ByVal lpString As String, ByVal lplFileName As String) As Integer
'! Declare Function WriteProfileString Lib "Kernel" (ByVal lpApplicationName As String, ByVal lpKeyName As String, ByVal lpString As String) As Integer

'Declaración de Funciones externas
'! Declare Function Crypt Lib "excript.dll" (ByVal inData As String, ByVal accion As Integer) As Integer

'! Public Function FMMapeaGrafo(parSqlConn As Long, parMatrizGrafo, parClear As Boolean)
'!     FMMapeaGrafo = VGMap.FMMapeaGrafo32(parSqlConn, parMatrizGrafo, parClear)
'! End Function
'!
'! Public Sub PMEscribeTexto(parSqlConn As Long, parBase As String, parTable As String, parCol As String, parWhere As String, parText As String)
'!     VGMap.PMEscribeTexto32 parSqlConn&, parBase, parTable, parCol, parWhere, parText
'! End Sub
'!
'! Public Sub PMPasoValoresLen(parSqlConn As Long, parName As String, parType As Integer, parDataType As Long, parValue As String, parLen As Integer)
'!     VGMap.PMPasoValoresLen32 parSqlConn&, parName$, parType%, parDataType&, parValue$, CLng(parLen%)
'! End Sub
'!
Public Function FMRetStatus(parSqlConn As Long) As Integer
    FMRetStatus = VGMap.FMRetStatus32(parSqlConn&)
End Function

'! Public Sub PMMapeaListaJ(parSqlConn As Long, parOutLine As Variant, parClear As Boolean)
'!     VGMap.PMMapeaListaJ32 parSqlConn&, parOutLine, parClear
'! End Sub
'!
Public Function FMInitMap(parHelpLine As Object, parTrnLine As Object, parFocoL As Object, parFocoT As Object, parFocoR As Object, parFocoP As Object, parLogFile As String) As Integer
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

'! Public Sub PMMapeaHoja2(parSqlConn As Long, parGrid As Variant, parCleanGrid As Boolean, parNumColumnas As Long)
'!     VGMap.PMMapeaHoja232 parSqlConn, parGrid, parCleanGrid, parNumColumnas
'! End Sub
'!
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

'! Public Function FMRetParamName(parSqlConn As Long, parNumParamOut As Long) As String
'!     FMRetParamName = VGMap.FMRetParamName32(parSqlConn&, parNumParamOut)
'! End Function
'!
Public Sub PMChequea(ByVal parSqlConn As Long)
    VGMap.PMChequea32 parSqlConn&
End Sub

Public Sub PMDebug(parSqlCon As Long, parStatus As Boolean)
    VGMap.PMDebug32 parStatus
End Sub

Public Sub PMMapeaGrid(ByVal parSqlConn&, ByVal parGrid As Control, ByVal parCleanGrid As Boolean)
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

'! Public Sub PMMapeaListaV(ByVal parSqlConn&, ByVal parLista As Control)
'!     VGMap.PMMapeaListaV32 parSqlConn&, parLista
'! End Sub
'!
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

'! Public Function SqlOpen(ByVal parServer As String, ByVal parLogin As String, ByVal parPassword As String, ByVal parApplication As String, ByVal parHost As String) As Long
'!     SqlOpen& = VGMap.SQLOpen32(parServer, parLogin, parPassword, parApplication, parHost)
'! End Function
'II - E.Pulido 09/21/2001 Código para NCS
'FIXIT: Declare 'Server' with an early-bound data type                                     FixIT90210ae-R1672-R1B8ZE
Public Sub PMCambioPassword(ByVal parSqlConn As Long, ByVal Server As Integer, ByVal ServerLocal As String, ByVal Login As String, ByVal Filial As Integer, ByVal Oficina As Integer)
         VGMap.PMCabioPassword32 parSqlConn, Server, ServerLocal, Login, Filial, Oficina
End Sub
Public Function SqlOpenLogin(ByRef parServer As String, ByRef parLogin As String, ByVal parApplication As String, ByVal parHost As String) As Long
         SqlOpenLogin& = VGMap.SQLOpenLogin32(parServer, parLogin, parApplication, parHost)
End Function
'FI - E.Pulido 09/21/2001 Código para NCS



