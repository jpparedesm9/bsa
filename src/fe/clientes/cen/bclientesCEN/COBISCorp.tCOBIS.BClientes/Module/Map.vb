Option Strict Off
Option Explicit On
Imports System
Imports System.Drawing
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Public Module Map
    Public VGMap As MAPN.MAP32
    'Public VGMap As Object = DBNull.Value
    Public VGFilial As String = ""
    Public VGOficina As String = ""
    Public VGrol As String = ""
    Public SqlConn As Integer = 0
    Public ServerName As String = ""
    Public ServerNameLocal As String = ""
    Public Const SQLVARCHAR As Integer = &H27S
    Public Const SQLCHAR As Integer = &H2FS
    Public Const SQLINT1 As Integer = &H30S
    Public Const SQLINT2 As Integer = &H34S
    Public Const SQLINT4 As Integer = &H38S
    Public Const SQLMONEY As Integer = &H3CS
    Public Const SQLDATETIME As Integer = &H3DS
    Public Const SQLFLT8 As Integer = &H3ES

    Public Function FMMapeaArreglo(ByRef parSqlConn As Integer, ByRef parArreglo() As String) As Integer
        Return VGMap.FMMapeaArreglo32(parSqlConn, parArreglo)
    End Function


    Public Function FMMapeaMatriz(ByRef parSqlConn As Integer, ByRef parMatriz As Array) As Integer
        Return VGMap.FMMapeaMatriz32(parSqlConn, parMatriz)
    End Function


    Public Function FMTransmitirRPC(ByRef parSqlConn As Integer, ByRef parServer As String, ByRef parDataBase As String, ByRef parSP As String, ByRef parMoveFocos As Boolean, ByRef parMessage As String) As Boolean
        Return VGMap.FMTransmitirRPC32(parSqlConn, parServer, parDataBase, parSP, parMoveFocos, parMessage)
    End Function


    Public Sub PMChequea(ByVal parSqlConn As Integer)
        VGMap.PMChequea32(parSqlConn)
    End Sub

    'Public Sub PMMapeaGrid(ByVal parSqlConn As Integer, ByVal parGrid As COBISCorp.Framework.UI.Components.COBISGrid, ByVal parCleanGrid As Boolean)
    '    VGMap.PMMapeaGrid32(parSqlConn, parGrid, parCleanGrid)
    'End Sub

    Public Sub PMMapeaGrid(ByVal parSqlConn As Integer, ByVal parGrid As Object, ByVal parCleanGrid As Boolean)
        VGMap.PMMapeaGrid32(parSqlConn, parGrid, parCleanGrid)
    End Sub


    Public Sub PMMapeaObjeto(ByVal parSqlConn As Integer, ByVal parObjeto As Object)
        VGMap.PMMapeaObjeto32(parSqlConn, parObjeto)
    End Sub

    Public Sub PMMapeaVariable(ByVal parSqlConn As Integer, ByRef parVariable As String)
        VGMap.PMMapeaVariable32(parSqlConn, parVariable)
    End Sub

    Public Sub PMPasoValores(ByVal parSqlConn As Integer, ByVal parName As String, ByVal parType As Integer, ByVal parDataType As Integer, ByVal parValue As String)
        VGMap.PMPasoValores32(parSqlConn, parName, CShort(parType), parDataType, parValue)
    End Sub
End Module

