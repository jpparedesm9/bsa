Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Text
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox

Public Module ModSeg
    Public VGTransacciones() As String
    Public VGNumTran As Integer = 0

	    Sub PMBotonSeguridad(ByRef Forma As Object, ByRef Indice As Integer)
        Dim VTArrayTran() As String
        Dim VTPosicion As Integer = 0
        Dim VTTransacciones As Integer = 0
        Dim VTDato As New StringBuilder
        Dim VTProcesadas As Integer = 0
        Dim j As Integer = 0
        Dim VTFlag As Integer = 0
        Dim VTMedio As Integer = 0
        Dim VTMax As Integer = 0
        Dim VTMin As Integer = 0
        For i As Integer = 0 To Indice
            VTPosicion = 1
            VTTransacciones = 0
            While VTPosicion < Strings.Len(Forma.cmdBoton(i).Tag)
                VTDato = New StringBuilder("")
                While (Strings.Mid(Forma.cmdBoton(i).Tag, VTPosicion, 1) <> ";") And (VTPosicion <= Strings.Len(Forma.cmdBoton(i).Tag))
                    VTDato.Append(Strings.Mid(Forma.cmdBoton(i).Tag, VTPosicion, 1))
                    VTPosicion += 1
                End While
                VTTransacciones += 1
                ReDim Preserve VTArrayTran(VTTransacciones)
                VTArrayTran(VTTransacciones) = VTDato.ToString()
                VTPosicion += 1
            End While
            VTProcesadas = 1
            j = 1
            VTFlag = True
            While (VTTransacciones >= VTProcesadas) And VTFlag
                VTFlag = False
                VTMedio = VGTransacciones.Length \ 2 ' VGNumTran \ 2
                VTMax = VGTransacciones.Length  'VGNumTran
                VTMin = 0
                While (VTMedio >= 1) And (VTMedio > VTMin) And (VTMedio < VTMax)
                    If Conversion.Val(VGTransacciones(VTMedio)) = Conversion.Val(VTArrayTran(VTProcesadas)) Then
                        Forma.cmdBoton(i).Enabled = True
                        Forma.cmdBoton(i).Visible = True
                        VTMedio = 0
                    Else
                        If Conversion.Val(VGTransacciones(VTMedio)) < Conversion.Val(VTArrayTran(VTProcesadas)) Then
                            VTMin = VTMedio
                            VTMedio += ((VTMax - VTMedio) \ 2)
                        Else
                            VTMax = VTMedio
                            VTMedio = VTMin + ((VTMedio - VTMin) \ 2)
                        End If
                    End If
                End While
                VTProcesadas += 1
            End While
        Next i
    End Sub

	Function FMSeguridad() As Integer
        Dim result As Integer = 0
        Dim VTR1 As Integer = 0
        result = False
        VGTransacciones = Array.CreateInstance(GetType(String), New Integer() {2, 3001}, New Integer() {0, 0})
        PMPasoValores(sqlconn, "@i_rol", 0, SQLINT1, VGRol)
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "rp_tr_autorizada", True, " Cargando transacciones autorizadas...") Then
            VGNumTran = FMMapeaMatriz(sqlconn, VGTransacciones)
            PMChequea(sqlconn)
            result = True
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("Transacciones Autorizadas...[" & Conversion.Str(VTR1) & "]")
        Else
            VGTransacciones = Array.CreateInstance(GetType(String), New Integer() {1, 1}, New Integer() {0, 0})
            Return False
        End If
        Return result
    End Function

	
    Sub PMMenuSeguridad(ByRef Menu As Object)
        Dim VTMin As Integer = 0
        Dim VTMax As Integer = 0
        Dim VTMedio As Integer = 0
        Dim VTDato As String = ""
        Dim VTPosicion As Integer = 0
        Menu.Enabled = False
        VTPosicion = 1
        While VTPosicion <= Strings.Len(Convert.ToString(Menu.Tag))
            VTDato = ""
            While (Strings.Mid(Convert.ToString(Menu.Tag), VTPosicion, 1) <> ";") And (VTPosicion <= Strings.Len(Convert.ToString(Menu.Tag)))
                VTDato = VTDato & Strings.Mid(Convert.ToString(Menu.Tag), VTPosicion, 1)
                VTPosicion += 1
            End While
            VTMedio = VGNumTran \ 2
            VTMax = VGNumTran
            VTMin = 0
            While (VTMedio >= 1) And (VTMedio > VTMin) And (VTMedio < VTMax)
                If Conversion.Val(VGTransacciones.GetValue(0, VTMedio)) = Conversion.Val(VTDato) Then
                    Menu.Enabled = True
                    Exit Sub
                Else
                    If Conversion.Val(VGTransacciones.GetValue(0, VTMedio)) < Conversion.Val(VTDato) Then
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
   
    Sub PMObjetoSeguridad(ByRef parObjeto As Button)
        Dim VTMedio As Integer = 0
        Dim VTMin As Integer = 0
        Dim VTMax As Integer = 0
        Dim VTDato As String = ""
        parObjeto.Enabled = False
        Dim VTPosicion As Integer = 1
        While VTPosicion <= Strings.Len(Convert.ToString(parObjeto.Tag))
            VTDato = ""
            While (Strings.Mid(Convert.ToString(parObjeto.Tag), VTPosicion, 1) <> ";") And (VTPosicion <= Strings.Len(Convert.ToString(parObjeto.Tag)))
                VTDato = VTDato & Strings.Mid(Convert.ToString(parObjeto.Tag), VTPosicion, 1)
                VTPosicion += 1
            End While
            VTMedio = VGTransacciones.Length \ 2
            VTMax = VGTransacciones.Length
            VTMin = 0
            While (VTMedio >= 0) And (VTMedio > VTMin) And (VTMedio < VTMax) 'se cambio para considerar las primeras posiciones del arreglo
                If Conversion.Val(VGTransacciones(VTMedio)) = Conversion.Val(VTDato) Then
                    parObjeto.Enabled = True
                    Exit Sub
                Else
                    If Conversion.Val(VGTransacciones(VTMedio)) < Conversion.Val(VTDato) Then
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
 
End Module

