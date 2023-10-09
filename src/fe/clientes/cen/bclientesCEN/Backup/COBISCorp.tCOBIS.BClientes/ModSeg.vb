Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
public Module ModSeg
    Public VGTransacciones(,) As String
    Public VGNumTran As Integer = 0

    Sub PMObjetoSeguridad(ByRef parObjeto As Button)
        Dim VTMedio As Integer = 0
        Dim  VTMin As Integer = 0
        Dim  VTMax As Integer = 0
        Dim VTDato As String = ""
        parObjeto.Enabled = False
        Dim VTPosicion As Integer = 1
        While VTPosicion <= Strings.Len(Convert.ToString(parObjeto.Tag))
            VTDato = ""
            While (Strings.Mid(Convert.ToString(parObjeto.Tag), VTPosicion, 1) <> ";") And (VTPosicion <= Strings.Len(Convert.ToString(parObjeto.Tag)))
                VTDato = VTDato & Strings.Mid(Convert.ToString(parObjeto.Tag), VTPosicion, 1)
                VTPosicion += 1
            End While
            VTMedio = VGNumTran \ 2
            VTMax = VGNumTran
            VTMin = 0
            While (VTMedio > 1) And (VTMedio > VTMin) And (VTMedio < VTMax)
                If Conversion.Val(VGTransacciones(0, VTMedio)) = Conversion.Val(VTDato) Then
                    parObjeto.Enabled = True
                    Exit Sub
                Else
                    If Conversion.Val(VGTransacciones(0, VTMedio)) < Conversion.Val(VTDato) Then
                        VTMin = VTMedio
                        VTMedio += ((VTMax - VTMedio) \ 2)
                    Else
                        VTMax = VTMedio
                        VTMedio = VTMin + ((VTMedio - VTMin) \ 2)
                    End If
                End If
            End While
            VTPosicion += 1
        End While
    End Sub

    Sub PMMenuSeguridad(ByVal parMenu As Control)
        Dim VTPosicion As Integer = 0
        Dim VTMedio As Integer = 0
        Dim VTMin As Integer = 0
        Dim VTMax As Integer = 0
        Dim VTDato As String = string.Empty
        parMenu.Enabled = False
        VTPosicion% = 1
        While VTPosicion% <= Len(parMenu.Tag)
            VTDato$ = ""
            While (Mid$(parMenu.Tag, VTPosicion%, 1) <> ";") And (VTPosicion% <= Len(parMenu.Tag))
                VTDato$ = VTDato$ & Mid$(parMenu.Tag, VTPosicion%, 1)
                VTPosicion% = VTPosicion% + 1
            End While
            VTMedio% = VGNumTran% \ 2
            VTMax% = VGNumTran%
            VTMin% = 0
            While (VTMedio% >= 1) And (VTMedio% > VTMin%) And (VTMedio% < VTMax%)
                If Val(VGTransacciones(0, VTMedio%)) = Val(VTDato$) Then
                    parMenu.Enabled = True
                    Exit Sub
                Else
                    If Val(VGTransacciones(0, VTMedio%)) < Val(VTDato$) Then
                        VTMin% = VTMedio%
                        VTMedio% = VTMedio% + ((VTMax% - VTMedio%) \ 2)
                    Else
                        VTMax% = VTMedio%
                        VTMedio% = VTMin% + ((VTMedio% - VTMin%) \ 2)
                    End If
                End If
            End While
            VTPosicion% = VTPosicion% + 1
        End While
    End Sub
End Module

