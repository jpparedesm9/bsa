Option Strict Off
Option Explicit On
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
public Module ModRes
    Public Sub FMMsgTransaccion(ByRef parCodMsg As Integer, ByRef parTexto As String)
        Dim VTMsg As String = ""
        If parCodMsg = 0 Then
            VTMsg = parTexto
        Else
            VTMsg = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(parCodMsg))
        End If
    End Sub

    Public Sub FMMsgAyuda(ByRef parCodMsg As Integer, ByRef parTexto As String)
        Dim VTMsg As String = ""
        If parCodMsg = 0 Then
            VTMsg = parTexto
        Else
            VTMsg = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(parCodMsg))
        End If
    End Sub

    Public Sub PMBorrarMensajes()
        FMMsgTransaccion(0, "")
        FMMsgAyuda(0, "")
    End Sub
End Module

