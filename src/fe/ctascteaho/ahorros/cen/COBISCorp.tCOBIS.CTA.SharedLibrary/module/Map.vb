Option Strict Off
Option Explicit On
Imports System
Imports System.Windows.Forms
Public Module Map
    Public VGMap As MAPN.MAP32
    Public VGEjecProc As Integer = 0
    Public Const SQLVARCHAR As Integer = &H27S
    Public Const SQLCHAR As Integer = &H2FS
    Public Const SQLINT1 As Integer = &H30S
    Public Const SQLINT2 As Integer = &H34S
    Public Const SQLINT4 As Integer = &H38S
    Public Const SQLMONEY As Integer = &H3CS
    Public Const SQLDATETIME As Integer = &H3DS
    Public Const SQLFLT8 As Integer = &H3ES
    Public svArchivo As String = ""
    Public Fil As Integer = 0
    Public col As Integer = 0
    Public i As Integer = 0
    Public VGTitularidad As String = ""
    Public j As Integer = 0
    Public fila As Integer = 0
    Public columna As Integer = 0
    Public VGCliente As String = ""
    Public CGFORMATOFECHA As String = ""
    Public VGTerminal As String = ""
    Public VLPaso As Integer = 0

    Public Function FMMapeaGrafo(ByRef parSqlConn As Integer, ByRef parMatrizGrafo() As String, ByRef parClear As Boolean) As Integer
        Return CInt(VGMap.FMMapeaGrafo32(parSqlConn, parMatrizGrafo, parClear))
    End Function

    Public Function FMRetStatus(ByRef parSqlConn As Integer) As Integer
        Return VGMap.FMRetStatus32(parSqlConn)
    End Function

    Public Function FMInitMap(ByRef parHelpLine As COBISCorp.Framework.UI.Components.COBISPanel, ByRef parTrnLine As COBISCorp.Framework.UI.Components.COBISPanel, ByRef parFocoL As COBISCorp.Framework.UI.Components.COBISPanel, ByRef parFocoT As COBISCorp.Framework.UI.Components.COBISPanel, ByRef parFocoR As COBISCorp.Framework.UI.Components.COBISPanel, ByRef parFocoP As COBISCorp.Framework.UI.Components.COBISPanel, ByRef parLogFile As String) As Integer
        Dim VTHelpLine As COBISCorp.Framework.UI.Components.COBISPanel = parHelpLine
        Dim VTTrnLine As COBISCorp.Framework.UI.Components.COBISPanel = parTrnLine
        Dim VTFocoL As COBISCorp.Framework.UI.Components.COBISPanel = parFocoL
        Dim VTFocoT As COBISCorp.Framework.UI.Components.COBISPanel = parFocoT
        Dim VTFocoR As COBISCorp.Framework.UI.Components.COBISPanel = parFocoR
        Dim VTFocoP As COBISCorp.Framework.UI.Components.COBISPanel = parFocoP
        Return VGMap.FMInitMap32(VTHelpLine, VTTrnLine, VTFocoL, VTFocoT, VTFocoR, VTFocoP, parLogFile)
    End Function

    Public Function FMMapeaArreglo(ByRef parSqlConn As Integer, ByRef parArreglo() As String) As Integer
        Return VGMap.FMMapeaArreglo32(parSqlConn, parArreglo)
    End Function

    Public Function FMMapeaMatriz(ByRef parSqlConn As Integer, ByRef parMatriz As Array) As Integer
        Return VGMap.FMMapeaMatriz32(parSqlConn, parMatriz)
    End Function

    Public Function FMTransmitirRPC(ByRef parSqlConn As Integer, ByRef parServer As String, ByRef parDataBase As String, ByRef parSP As String, ByRef parMoveFocos As Boolean, ByRef parMessage As String) As Boolean
        Return VGMap.FMTransmitirRPC32(parSqlConn, parServer, parDataBase, parSP, parMoveFocos, parMessage)
    End Function

    Public Function FMRetParam(ByRef parSqlConn As Integer, ByRef parNumParamOut As Integer) As String
        Return VGMap.FMRetParam32(parSqlConn, parNumParamOut)
    End Function

    Public Sub PMChequea(ByVal parSqlConn As Integer)
        VGMap.PMChequea32(parSqlConn)
    End Sub

    Public Sub PMDebug(ByRef parSqlCon As Integer, ByRef parStatus As Boolean)
        VGMap.PMDebug32(parStatus)
    End Sub

    Public Sub PMMapeaGrid(ByVal parSqlConn As Integer, ByVal parGrid As Object, ByVal parCleanGrid As Boolean)
        parGrid.col = parGrid.col
        VGMap.PMMapeaGrid32(parSqlConn, parGrid, parCleanGrid)
    End Sub

    Public Sub PMMapeaObjeto(ByVal parSqlConn As Integer, ByVal parObjeto As Object)
        VGMap.PMMapeaObjeto32(parSqlConn, parObjeto)
    End Sub

    Public Sub PMMapeaObjetoAB(ByVal parSqlConn As Integer, ByVal parObjetoA As Object, ByVal parObjetoB As Object)
        VGMap.PMMapeaObjetoAB32(parSqlConn, parObjetoA, parObjetoB)
    End Sub

    Public Sub PMMapeaListaH(ByVal parSqlConn As Integer, ByVal parLista As ListBox, ByVal parCleanList As Boolean)
        VGMap.PMMapeaListaH32(parSqlConn, parLista, parCleanList)
    End Sub

    Public Sub PMMapeaVariable(ByVal parSqlConn As Integer, ByRef parVariable As String)
        VGMap.PMMapeaVariable32(parSqlConn, parVariable)
    End Sub

    Public Sub PMPasoValores(ByVal parSqlConn As Integer, ByVal parName As String, ByVal parType As Integer, ByVal parDataType As Integer, ByVal parValue As String)
        VGMap.PMPasoValores32(parSqlConn, parName, CShort(parType), parDataType, parValue)
    End Sub

    Public Sub SqlExit()
        VGMap.SqlExit32()
    End Sub

    Public Sub SqlWinExit()
        VGMap.SqlWinExit32()
    End Sub

    Public Sub SqlClose(ByRef parSqlConn As Integer)
        VGMap.SqlClose32(parSqlConn)
    End Sub

    Public Function SqlInit() As String
        Return VGMap.SQLInit32()
    End Function

    Public Sub PMCambioPassword(ByVal parSqlConn As Integer, ByVal Server As String, ByVal ServerLocal As String, ByVal Login As String, ByVal Filial As Integer, ByVal Oficina As Integer)
        VGMap.PMCabioPassword32(parSqlConn, Server, ServerLocal, Login, CShort(Filial), CShort(Oficina))
    End Sub

    Public Function SqlOpenLogin(ByRef parServer As String, ByRef parLogin As String, ByVal parApplication As String, ByVal parHost As String) As Integer
        Return VGMap.SQLOpenLogin32(parServer, parLogin, parApplication, parHost)
    End Function

    Public Function FmMapeaNumMensaje() As String
        Return VGMap.FMMapeaNumMensaje()
    End Function
End Module


