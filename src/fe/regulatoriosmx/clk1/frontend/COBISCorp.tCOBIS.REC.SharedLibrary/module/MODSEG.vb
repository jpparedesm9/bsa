Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Text
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Public Module MODSEG
    Public VGTransacciones(0, 0) As String
    Public VGNumTran As Integer = 0

    Function FMSeguridad() As Integer
        Dim result As Integer = 0
        Dim VTR1 As Integer = 0
        result = False
        'VGTransacciones = Array.CreateInstance(GetType(String), New Integer() {2, 3001}, New Integer() {0, 0})
        ReDim VGTransacciones(1, 10000)
        PMPasoValores(sqlconn, "@i_rol", 0, SQLINT1, VGRol)
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "rp_tr_autorizada", True, FMLoadResString(509200)) Then
            VGNumTran = FMMapeaMatriz(sqlconn, VGTransacciones)
            PMChequea(sqlconn)
            result = True
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(FMLoadResString(509201) & Conversion.Str(VTR1) & "]")
        Else
            PMChequea(sqlconn)
            ReDim VGTransacciones(0, 0)
            Return False
        End If
        Return result
    End Function

    Sub PMBotonSeguridad(ByRef Forma As Object, ByRef Indice As Integer)
        Dim VTArrayTran() As String = Nothing
        Dim VTDato As New StringBuilder
        Dim VTPosicion As Integer = 0
        Dim vttransacciones As Integer = 0
        Dim VTProcesadas As Integer = 0
        Dim VTFlag As Integer = 0
        Dim VTMedio As Integer = 0
        Dim VTMax As Integer = 0
        Dim VTMin As Integer = 0
        For i As Integer = 0 To Indice
            VTPosicion = 1
            vttransacciones = 0
            While VTPosicion < Strings.Len(Forma.cmdBoton(i).Tag)
                VTDato = New StringBuilder("")
                While (Strings.Mid(Forma.cmdBoton(i).Tag, VTPosicion, 1) <> ";") And (VTPosicion <= Strings.Len(Forma.cmdBoton(i).Tag))
                    VTDato.Append(Strings.Mid(Forma.cmdBoton(i).Tag, VTPosicion, 1))
                    VTPosicion += 1
                End While
                vttransacciones += 1
                ReDim Preserve VTArrayTran(vttransacciones)
                VTArrayTran(vttransacciones) = VTDato.ToString()
                VTPosicion += 1
            End While
            VTProcesadas = 1
            VTFlag = True
            While (vttransacciones >= VTProcesadas) And VTFlag
                VTFlag = False
                VTMedio = VGNumTran \ 2
                VTMax = VGNumTran
                VTMin = 0
                While (VTMedio >= 1) And (VTMedio > VTMin) And (VTMedio < VTMax)
                    If Conversion.Val(VGTransacciones.GetValue(0, VTMedio)) = Conversion.Val(VTArrayTran(VTProcesadas)) Then
                        Forma.cmdBoton(i).Enabled = True
                        Forma.cmdBoton(i).Visible = True
                        VTMedio = 0
                    Else
                        If Conversion.Val(VGTransacciones.GetValue(0, VTMedio)) < Conversion.Val(VTArrayTran(VTProcesadas)) Then
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

    Sub PMMenuSeguridad(ByRef Menu As ToolStripMenuItem)
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

    Sub PMObjetoSeguridad(ByRef Objeto As Object)
        Dim VTMin As Integer = 0
        Dim VTMax As Integer = 0
        Dim VTMedio As Integer = 0
        Dim VTFlag As Integer = 0
        Dim VTProcesadas As Integer = 0
        Dim VTDato As New StringBuilder
        Dim vttransacciones As Integer = 0
        Dim VTPosicion As Integer = 0
        Dim VTArrayTran() As String = Nothing
        objeto.Enabled = False
        VTPosicion = 1
        vttransacciones = 0
        While VTPosicion < Strings.Len(Convert.ToString(objeto.Tag))
            VTDato = New StringBuilder("")
            While (Strings.Mid(Convert.ToString(objeto.Tag), VTPosicion, 1) <> ";") And (VTPosicion <= Strings.Len(Convert.ToString(objeto.Tag)))
                VTDato.Append(Strings.Mid(Convert.ToString(objeto.Tag), VTPosicion, 1))
                VTPosicion += 1
            End While
            vttransacciones += 1
            ReDim Preserve VTArrayTran(vttransacciones)
            VTArrayTran(vttransacciones) = VTDato.ToString()
            VTPosicion += 1
        End While
        VTProcesadas = 1
        VTFlag = True
        While (vttransacciones >= VTProcesadas) And VTFlag
            VTFlag = False
            VTMedio = VGNumTran \ 2
            VTMax = VGNumTran
            VTMin = 0
            While (VTMedio >= 1) And (VTMedio > VTMin) And (VTMedio < VTMax)
                If Conversion.Val(VGTransacciones.GetValue(0, VTMedio)) = Conversion.Val(VTArrayTran(VTProcesadas)) Then
                    objeto.Enabled = True
                    objeto.Visible = True
                    VTMedio = 0
                Else
                    If Conversion.Val(VGTransacciones.GetValue(0, VTMedio)) < Conversion.Val(VTArrayTran(VTProcesadas)) Then
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
    End Sub

    Dim VTArrayTran() As String
    Public VGValidaHuella As Boolean = False
    Public VGRegistraHuellaAValidar As Boolean = False
    Public VGTipoDoc As String = ""
    Public VGTipoDocValidado As String = ""
    Public VGNumDocValidado As String = ""
    Public VGFechaFormato As String = ""
    Public VGFila As Integer = 0

    Sub FMRegistraHuellaAValidar(ByRef TipoDoc As String, ByRef NumDoc As String, ByRef Titularidad As String, ByRef NumCuenta As String, ByRef TipoTran As String)
        If TipoDoc = "" Or NumDoc = "" Or Titularidad = "" Or NumCuenta = "" Or TipoTran = "" Then
            COBISMessageBox.Show(FMLoadResString(509203), "FMRegistraHuella", COBISMessageBox.COBISButtons.OK)
            VGValidaHuella = False
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@i_tipo_ced", 0, SQLVARCHAR, TipoDoc)
        PMPasoValores(sqlconn, "@i_ced_ruc", 0, SQLVARCHAR, NumDoc)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
        PMPasoValores(sqlconn, "@i_user", 0, SQLVARCHAR, VGLogin)
        PMPasoValores(sqlconn, "@i_id_caja", 0, SQLINT4, "0")
        PMPasoValores(sqlconn, "@i_ref", 0, SQLVARCHAR, NumCuenta)
        PMPasoValores(sqlconn, "@i_titularidad", 0, SQLCHAR, Titularidad)
        PMPasoValores(sqlconn, "@i_trn", 0, SQLCHAR, TipoTran)
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "1610")
        If Not FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_tr_consulta_homini", True, FMLoadResString(509204)) Then
            PMChequea(sqlconn)
            VGValidaHuella = False
            COBISMessageBox.Show(FMLoadResString(509205) & NumDoc & FMLoadResString(500120) & NumCuenta, FMLoadResString(502537), COBISMessageBox.COBISButtons.OK)
            Exit Sub
        Else
            PMChequea(sqlconn)
            VGValidaHuella = True
        End If
        PMChequea(sqlconn)
    End Sub

    Sub FMVerificaHuella(ByRef NumCuenta As String, ByRef TipoTran As String)
        If NumCuenta = "" Or TipoTran = "" Then
            COBISMessageBox.Show(FMLoadResString(509203), "FMValidaHuella", COBISMessageBox.COBISButtons.OK)
            VGValidaHuella = False
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "V")
        PMPasoValores(sqlconn, "@i_user", 0, SQLVARCHAR, VGLogin)
        PMPasoValores(sqlconn, "@i_id_caja", 0, SQLINT4, "0")
        PMPasoValores(sqlconn, "@i_ref", 0, SQLVARCHAR, NumCuenta)
        PMPasoValores(sqlconn, "@i_trn", 0, SQLCHAR, TipoTran)
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "1610")
        PMPasoValores(sqlconn, "@o_tipo_ced", 1, SQLVARCHAR, New String(" "c, 3))
        PMPasoValores(sqlconn, "@o_ced_ruc", 1, SQLVARCHAR, New String(" "c, 13))
        If Not FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_tr_consulta_homini", True, FMLoadResString(509204)) Then
            VGRegistraHuellaAValidar = False
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
            VGTipoDocValidado = FMRetParam(sqlconn, 1)
            VGNumDocValidado = FMRetParam(sqlconn, 2)
            VGRegistraHuellaAValidar = True
        End If
    End Sub
End Module


