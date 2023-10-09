Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports Microsoft.VisualBasic.Compatibility.VB6
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
Public Module MODSYS
    Private Declare Function RegOpenKeyEx Lib "advapi32" Alias "RegOpenKeyExA" (ByVal hKey As Integer, ByVal lpSubKey As String, ByVal ulOptions As Integer, ByVal samDesired As Integer, ByRef phkResult As Integer) As Integer
    Private Declare Function RegQueryValueEx Lib "advapi32" Alias "RegQueryValueExA" (ByVal hKey As Integer, ByVal lpValueName As String, ByVal lpReserved As Integer, ByRef lpType As Integer, ByVal lpData As String, ByRef lpcbData As Integer) As Integer
    Private Declare Function RegCloseKey Lib "advapi32" (ByVal hKey As Integer) As Integer
    Private Declare Function GetSystemDirectory Lib "kernel32" Alias "GetSystemDirectoryA" (ByVal parDirectory As String, ByVal parSize As Short) As Short
    Private Declare Function SystemParametersInfo Lib "user32" Alias "SystemParametersInfoA" (ByVal uAction As Short, ByVal uParam As Short, ByVal lpvParam As String, ByVal fuWinIni As Short) As Short
    Declare Function GetLocaleInfo Lib "kernel32" Alias "GetLocaleInfoA" (ByVal Locale As Integer, ByVal LCType As Integer, ByVal lpLCData As String, ByVal cchData As Integer) As Integer
    Public Declare Function NombreCliente Lib "def2.dll" Alias "NombreClienteA" (ByVal Nombre1 As String, ByVal Nombre2 As String) As Boolean
    Public Const CG_HKEY_LOCAL_MACHINE As Integer = &H80000002

    Public Function FMGetComputerName() As String
        Dim VTComputerName As String = ""
        If FMGetKeyValue(CG_HKEY_LOCAL_MACHINE, "SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName", FMLoadResString(1938), VTComputerName) Then
            Return VTComputerName
        Else
            Return ""
        End If
    End Function

    Public Function FMGetSeparadorMiles() As String
        Dim VTSeparadorMiles As New System.Text.StringBuilder(256, 256)
        Dim VTRet As Integer = GetLocaleInfo(1024, 15, VTSeparadorMiles.Length, 2)
        If VTRet > 0 Then
            Return Strings.Mid(VTSeparadorMiles.Length, 1, 1)
        Else
            Return ""
        End If
    End Function

    Public Function FMGetSeparadorDecimales() As String
        Dim VTSeparadorDecimales As New System.Text.StringBuilder(256, 256)
        Dim VTRet As Integer = GetLocaleInfo(1024, 14, VTSeparadorDecimales.Length, 2)
        If VTRet > 0 Then
            Return Strings.Mid(VTSeparadorDecimales.Length, 1, 1)
        Else
            Return ""
        End If
    End Function

    Public Function FMGetFormatoFecha() As String
        Dim VTFormatoFecha As New System.Text.StringBuilder(256, 256)
        Dim VTRet As Integer = GetLocaleInfo(1024, 31, VTFormatoFecha.Length, 11)
        If VTRet > 0 Then
            Return Strings.Mid(VTFormatoFecha.Length, 1, VTRet - 1)
        Else
            Return ""
        End If
    End Function

    Public Function FMGetKeyValue(ByRef parKeyRoot As Integer, ByRef parKeyName As String, ByRef parSubKeyRef As String, ByRef parKeyVal As String) As Boolean
        Dim result As Boolean = False
        Const CT_SUCCESS As Integer = 0
        Const CT_REG_SZ As Integer = 1
        Const CT_REG_DWORD As Integer = 4
        Const CT_KEY_QUERY_VALUE As Integer = &H1S
        Dim VThKey As Integer = 0
        Dim VTKeyValType As Integer = 0
        Dim VTtmpVal As String = ""
        Dim VTKeyValSize As Integer = 0
        Dim VTrc As Integer = RegOpenKeyEx(parKeyRoot, parKeyName, 0, CT_KEY_QUERY_VALUE, VThKey)
        If VTrc <> CT_SUCCESS Then
            GoTo BuscarClaveError
        End If
        VTtmpVal = New String(Strings.Chr(0), 1024)
        VTKeyValSize = 1024
        VTrc = RegQueryValueEx(VThKey, parSubKeyRef, 0, VTKeyValType, VTtmpVal, VTKeyValSize)
        If VTrc <> CT_SUCCESS Then
            GoTo BuscarClaveError
        End If
        If Strings.AscW(Strings.Mid(VTtmpVal, VTKeyValSize, 1)) = 0 Then
            VTtmpVal = Strings.Left(VTtmpVal, VTKeyValSize - 1)
        Else
            VTtmpVal = Strings.Left(VTtmpVal, VTKeyValSize)
        End If
        Select Case VTKeyValType
            Case CT_REG_SZ
                parKeyVal = VTtmpVal
            Case CT_REG_DWORD
                For VTi As Integer = VTtmpVal.Length To 1 Step -1
                    parKeyVal = parKeyVal & Strings.AscW(Strings.Mid(VTtmpVal, VTi, 1)).ToString("X")
                Next
                parKeyVal = ("&h" & parKeyVal).ToString()
        End Select
        result = True
        VTrc = RegCloseKey(VThKey)
        Return result
BuscarClaveError:
        parKeyVal = ""
        result = False
        VTrc = RegCloseKey(VThKey)
        Return result
    End Function

    Public Function FMGetSystemDirectory() As String
        Dim VTSystemDirectory As New System.Text.StringBuilder(256, 256)
        Dim VTSize As Integer = 255
        VTSize = GetSystemDirectory(VTSystemDirectory.Length, CShort(VTSize))
        If VTSize > 0 Then
            Return Strings.Mid(VTSystemDirectory.Length, 1, VTSize)
        Else
            Return ""
        End If
    End Function
End Module


