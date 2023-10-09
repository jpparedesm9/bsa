Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Runtime.InteropServices
Imports COBISCorp.eCOBIS.Commons.MessageBox
public Module ModSys
    Private Declare Function RegOpenKeyEx Lib "advapi32" Alias "RegOpenKeyExA" (ByVal hKey As Integer, ByVal lpSubKey As String, ByVal ulOptions As Integer, ByVal samDesired As Integer, ByRef phkResult As Integer) As Integer
    Private Declare Function RegQueryValueEx Lib "advapi32" Alias "RegQueryValueExA" (ByVal hKey As Integer, ByVal lpValueName As String, ByVal lpReserved As Integer, ByRef lpType As Integer, ByVal lpData As String, ByRef lpcbData As Integer) As Integer
    Private Declare Function RegSetValueEx Lib "advapi32.dll" Alias "RegSetValueExA" (ByVal hKey As Integer, ByVal lpValueName As String, ByVal Reserved As Integer, ByVal dwType As Integer, ByVal lpData As Integer, ByVal cbData As Integer) As Integer
    Private Declare Function RegCloseKey Lib "advapi32" (ByVal hKey As Integer) As Integer
    Private Declare Function GetSystemDirectory Lib "Kernel32" Alias "GetSystemDirectoryA" (ByVal parDirectory As String, ByVal parSize As Integer) As Integer
    Private Declare Function SystemParametersInfo Lib "user32" Alias "SystemParametersInfoA" (ByVal uAction As Short, ByVal uParam As Short, ByVal lpvParam As String, ByVal fuWinIni As Short) As Short
    Private Const CL_HKEY_LOCAL_MACHINE As Integer = &H80000002
    Private Const CL_HKEY_CURRENT_USER As Integer = &H80000001
    Private Const CL_SUCCESS As Integer = 0
    Private Const CL_REG_SZ As Integer = 1
    Private Const CL_REG_DWORD As Integer = 4
    Private Const CL_KEY_QUERY_VALUE As Integer = &H1S
    Private Const CL_KEY_SET_VALUE As Integer = &H2S
    Private Const CL_SEPARADOR_MILES As String = ","
    Private Const CL_SEPARADOR_DECIMALES As String = "."

    Public Function FMSetKeyValue(ByRef parKeyRoot As Integer, ByRef parKeyName As String, ByRef parSubKeyRef As String, ByVal parKeyVal As String, ByVal parKeyLen As Integer, ByVal parKeyType As Integer) As Boolean
        Dim result As Boolean = False
        Dim VThKey As Integer = 0
        Dim VTResult As Integer = RegOpenKeyEx(parKeyRoot, parKeyName, 0, CL_KEY_SET_VALUE, VThKey)
        If VTResult <> CL_SUCCESS Then
            GoTo BuscarClaveError
        End If
        Dim tmpPtr As IntPtr = Marshal.StringToHGlobalAnsi(parKeyVal)
        Try
            VTResult = RegSetValueEx(VThKey, parSubKeyRef, 0, parKeyType, tmpPtr, parKeyLen)
            parKeyVal = Marshal.PtrToStringAnsi(tmpPtr)
        Finally
            Marshal.FreeHGlobal(tmpPtr)
        End Try
        If VTResult <> CL_SUCCESS Then
            GoTo BuscarClaveError
        End If
        result = True
        VTResult = RegCloseKey(VThKey)
        Return result
BuscarClaveError:
        result = False
        VTResult = RegCloseKey(VThKey)
        Return result
    End Function

    Public Function FMGetKeyValue(ByRef parKeyRoot As Integer, ByRef parKeyName As String, ByRef parSubKeyRef As String, ByRef parKeyVal As String) As Boolean
        Dim result As Boolean = False
        Dim VThKey As Integer = 0
        Dim VTKeyValType As Integer = 0
        Dim VTtmpVal As String = ""
        Dim VTKeyValSize As Integer = 0
        Dim VTrc As Integer = RegOpenKeyEx(parKeyRoot, parKeyName, 0, CL_KEY_QUERY_VALUE, VThKey)
        If VTrc <> CL_SUCCESS Then
            GoTo BuscarClaveError
        End If
        VTtmpVal = New String(Strings.Chr(0), 1024)
        VTKeyValSize = 1024
        VTrc = RegQueryValueEx(VThKey, parSubKeyRef, 0, VTKeyValType, VTtmpVal, VTKeyValSize)
        If VTrc <> CL_SUCCESS Then
            GoTo BuscarClaveError
        End If
        If Strings.AscW(Strings.Mid(VTtmpVal, VTKeyValSize, 1)) = 0 Then
            VTtmpVal = Strings.Left(VTtmpVal, VTKeyValSize - 1)
        Else
            VTtmpVal = Strings.Left(VTtmpVal, VTKeyValSize)
        End If
        Select Case VTKeyValType
            Case CL_REG_SZ
                parKeyVal = VTtmpVal
            Case CL_REG_DWORD
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
End Module

