Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran407Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLVez As Integer = 0
    Dim VLPaso As Boolean = False
    Dim VLProcesar As Boolean = False
    Dim VLFila As Integer = 0
    Dim VLSalir As Boolean = False
    Dim VLStatus As String = ""
    Dim VLRef As String = ""
    Dim VLEstado As String = ""
    Dim VLDatosCheque() As String

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_6.Click, _cmdBoton_5.Click, _cmdBoton_4.Click, _cmdBoton_3.Click, _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_0.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        TSBotones.Focus()
        Select Case Index
            Case 0
                PLConfirmaCheques()
            Case 1
                PLDevuelveCheques()
            Case 2
                PLConfirmaCarta()
            Case 3
                PLPostergar()
            Case 4
                Me.Close()
            Case 5
                PLReversar()
            Case 6
                PLLimpiar()
        End Select
    End Sub

    Private Function FLMarcados(ByRef modo As Integer) As Integer
        Dim result As Integer = 0
        Dim VTVistos As Integer = 0
        Dim VTPendientes As Integer = 0
        For i As Integer = 1 To grdRegistros.Rows - 1
            grdRegistros.Col = 0
            grdRegistros.Row = i
            If grdRegistros.Picture Is Nothing Then
                VTVistos += 1
            End If
            If modo = 1 Then
                grdRegistros.Col = 6
                If grdRegistros.CtlText = FMLoadResString(509344) Then
                    VTPendientes += 1
                End If
            End If
        Next i
        Select Case modo
            Case 0
                If VTVistos > 0 Then
                    result = 1
                Else
                    result = 0
                End If
            Case 1
                If VTPendientes = grdRegistros.Rows - 1 Then
                    result = 1
                Else
                    result = 0
                End If
        End Select
        Return result
    End Function


    Private Sub FTran407_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBConfChq.Enabled = _cmdBoton_0.Enabled
        TSBConfChq.Visible = _cmdBoton_0.Visible
        TSBDevolver.Enabled = _cmdBoton_1.Enabled
        TSBDevolver.Visible = _cmdBoton_1.Visible
        TSBReversar.Enabled = _cmdBoton_5.Enabled
        TSBReversar.Visible = _cmdBoton_5.Visible
        TSBConfCart.Enabled = _cmdBoton_2.Enabled
        TSBConfCart.Visible = _cmdBoton_2.Visible
        TSBPostergar.Enabled = _cmdBoton_3.Enabled
        TSBPostergar.Visible = _cmdBoton_3.Visible
        TSBLimpiar.Enabled = _cmdBoton_6.Enabled
        TSBLimpiar.Visible = _cmdBoton_6.Visible
        TSBSalir.Enabled = _cmdBoton_4.Enabled
        TSBSalir.Visible = _cmdBoton_4.Visible
    End Sub

    Private Sub TSBConfChq_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBConfChq.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBDevolver_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBDevolver.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBReversar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBReversar.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBConfCart_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBConfCart.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBPostergar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBPostergar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Public Sub PLInicializar()

        cmdBoton(0).Enabled = False
        cmdBoton(1).Enabled = False
        cmdBoton(2).Enabled = False
        cmdBoton(3).Enabled = False
        cmdBoton(5).Enabled = False
    End Sub

    Private Sub FTran407_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdRegistros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.Click
        grdRegistros.Col = 0
        grdRegistros.SelStartCol = 1
        grdRegistros.SelEndCol = grdRegistros.Cols - 1
        If grdRegistros.Row = 0 Then
            grdRegistros.SelStartRow = 1
            grdRegistros.SelEndRow = 1
        Else
            grdRegistros.SelStartRow = grdRegistros.Row
            grdRegistros.SelEndRow = grdRegistros.Row
        End If
    End Sub

    Private Sub grdRegistros_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdRegistros.DblClick
        VLFila = 0
        PLMarcarRegistro()
    End Sub

    Private Sub PLConfirmaCarta()
        VLProcesar = True
        While VLProcesar
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "403")
            PMPasoValores(sqlconn, "@i_propie", 0, SQLVARCHAR, lblDescripcion(2).Text)
            PMPasoValores(sqlconn, "@i_corres", 0, SQLVARCHAR, lblDescripcion(0).Text)
            PMPasoValores(sqlconn, "@i_secuen", 0, SQLINT4, txtCarta.Text)
            PMPasoValores(sqlconn, "@i_fecha", 0, SQLDATETIME, lblDescripcion(11).Text)
            PMPasoValores(sqlconn, "@i_hablt", 0, SQLVARCHAR, "C")
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_confcarman", True, FMLoadResString(508818)) Then
                ReDim VLDatosCheque(3)
                PMMapeaGrid(sqlconn, grdRegistros, False)
                FMMapeaArreglo(sqlconn, VLDatosCheque)
                PMMapeaVariable(sqlconn, CStr(VLSalir))
                VLProcesar = VLSalir
                PMChequea(sqlconn)
                lblDescripcion(8).Text = VLDatosCheque(1)
                lblDescripcion(9).Text = VLDatosCheque(2)
                PLProducto()
                cmdBoton(5).Enabled = True
                PLTSEstado()
                PLObtenerDatos()
            Else
                PMChequea(sqlconn)
                Exit Sub
            End If
        End While
    End Sub

    Private Sub PLConfirmaCheques()
        Dim VTValor As String = String.Empty
        Dim VTReferencia As String = String.Empty
        Dim VTRemesas As String = String.Empty
        If FLMarcados(0) Then
            For i As Integer = 1 To grdRegistros.Rows - 1
                grdRegistros.Col = 0
                grdRegistros.Row = i
                If grdRegistros.Picture Is Nothing Then
                    grdRegistros.Col = 5
                    VTValor = grdRegistros.CtlText
                    grdRegistros.Col = 7
                    VTReferencia = grdRegistros.CtlText
                    grdRegistros.Col = 10
                    VTRemesas = grdRegistros.CtlText
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "404")
                    PMPasoValores(sqlconn, "@i_propie", 0, SQLVARCHAR, lblDescripcion(2).Text)
                    PMPasoValores(sqlconn, "@i_emisor", 0, SQLVARCHAR, lblDescripcion(4).Text)
                    PMPasoValores(sqlconn, "@i_corres", 0, SQLVARCHAR, lblDescripcion(0).Text)
                    PMPasoValores(sqlconn, "@i_secuen", 0, SQLINT4, txtCarta.Text)
                    PMPasoValores(sqlconn, "@i_fecha", 0, SQLDATETIME, lblDescripcion(11).Text)
                    PMPasoValores(sqlconn, "@i_chq", 0, SQLINT4, VTReferencia)
                    PMPasoValores(sqlconn, "@i_val", 0, SQLMONEY, VTValor)
                    PMPasoValores(sqlconn, "@i_hablt", 0, SQLVARCHAR, "C")
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_tipo_rem", 0, SQLVARCHAR, VTRemesas)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_confcheque", True, FMLoadResString(508820)) Then
                        ReDim VLDatosCheque(4)
                        FMMapeaArreglo(sqlconn, VLDatosCheque)
                        PMChequea(sqlconn)
                        PLRefrescar()
                    Else
                        PMChequea(sqlconn)
                        grdRegistros.Col = 0
                        grdRegistros.Picture = picVisto(1).Image
                    End If
                End If
            Next i
        Else
            COBISMessageBox.Show(FMLoadResString(500313), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
    End Sub

    Private Sub PLDevuelveCheques()
        Dim VTCausaDev As String = ""
        Dim VTValor As String = String.Empty
        Dim VTReferencia As String = String.Empty
        Dim VTCtadep As String = String.Empty
        Dim VTAplicacion As String = String.Empty
        Dim VTRemesas As String = String.Empty
        Dim VTCheque As String = String.Empty
        If FLMarcados(0) Then
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cc_causa_prot")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(508805)) Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.ShowPopup(Me)
                VTCausaDev = VGACatalogo.Codigo
            Else
                PMChequea(sqlconn)
            End If
            If VTCausaDev = "" Then
                COBISMessageBox.Show(FMLoadResString(500314), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
            grdRegistros.Row = VLFila
            grdRegistros.Col = 5
            VTValor = grdRegistros.CtlText
            grdRegistros.Col = 7
            VTReferencia = grdRegistros.CtlText
            grdRegistros.Col = 4
            VTCheque = grdRegistros.CtlText
            grdRegistros.Col = 2
            VTCtadep = grdRegistros.CtlText
            grdRegistros.Col = 3
            VTAplicacion = grdRegistros.CtlText
            grdRegistros.Col = 10
            VTRemesas = grdRegistros.CtlText
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "402")
            PMPasoValores(sqlconn, "@i_propie", 0, SQLVARCHAR, lblDescripcion(2).Text)
            PMPasoValores(sqlconn, "@i_emisor", 0, SQLVARCHAR, lblDescripcion(4).Text)
            PMPasoValores(sqlconn, "@i_corres", 0, SQLVARCHAR, lblDescripcion(0).Text)
            PMPasoValores(sqlconn, "@i_secuen", 0, SQLINT4, txtCarta.Text)
            PMPasoValores(sqlconn, "@i_fecha", 0, SQLDATETIME, lblDescripcion(11).Text)
            PMPasoValores(sqlconn, "@i_chq", 0, SQLINT4, VTReferencia)
            PMPasoValores(sqlconn, "@i_nchq", 0, SQLINT4, VTCheque)
            PMPasoValores(sqlconn, "@i_val", 0, SQLMONEY, VTValor)
            PMPasoValores(sqlconn, "@i_hablt", 0, SQLVARCHAR, "C")
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
            PMPasoValores(sqlconn, "@i_ctadep", 0, SQLVARCHAR, VTCtadep)
            PMPasoValores(sqlconn, "@i_prddep", 0, SQLVARCHAR, VTAplicacion)
            PMPasoValores(sqlconn, "@i_causadev", 0, SQLVARCHAR, VTCausaDev)
            PMPasoValores(sqlconn, "@i_tipo_rem", 0, SQLVARCHAR, VTRemesas)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_chequedev", True, FMLoadResString(508846)) Then
                ReDim VLDatosCheque(4)
                FMMapeaArreglo(sqlconn, VLDatosCheque)
                PMChequea(sqlconn)
                PLRefrescar()
                PLObtenerDatos()
            Else
                PMChequea(sqlconn)
                grdRegistros.Col = 0
                grdRegistros.Picture = picVisto(0).Image
            End If
        Else
            COBISMessageBox.Show(FMLoadResString(500315), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
    End Sub

    Private Sub PLHabilitaBotones()
        If grdRegistros.Rows <= 2 Then
            grdRegistros.Row = 1
            grdRegistros.Col = 1
            If grdRegistros.CtlText = "" Then
                Exit Sub
            End If
        End If
        cmdBoton(0).Enabled = True
        cmdBoton(1).Enabled = True
        cmdBoton(5).Enabled = True
        cmdBoton(2).Enabled = True
        cmdBoton(3).Enabled = True
        PLTSEstado()
        cmdBoton(0).Focus()
    End Sub

    Private Sub PLLimpiar()
        txtCarta.Enabled = True
        txtCarta.Text = ""
        lblDescripcion(0).Text = ""
        lblDescripcion(1).Text = ""
        lblDescripcion(2).Text = ""
        lblDescripcion(3).Text = ""
        lblDescripcion(4).Text = ""
        lblDescripcion(5).Text = ""
        lblDescripcion(6).Text = ""
        lblDescripcion(7).Text = ""
        lblDescripcion(8).Text = ""
        lblDescripcion(9).Text = ""
        lblDescripcion(11).Text = ""
        PMLimpiaGrid(grdRegistros)
        txtCarta.Focus()
        If grdRegistros.Rows <= 2 Then
            grdRegistros.Row = 1
            grdRegistros.Col = 1
            If grdRegistros.CtlText = "" Then
                grdRegistros.Col = 0
                grdRegistros.Picture = picVisto(1).Image
            End If
        End If
        cmdBoton(0).Enabled = False
        cmdBoton(1).Enabled = False
        cmdBoton(2).Enabled = False
        cmdBoton(3).Enabled = False
        cmdBoton(5).Enabled = False
        PLTSEstado()
    End Sub

    Private Sub PLMarcarRegistro()
        VLFila = grdRegistros.Row
        grdRegistros.Col = 0
        For i As Integer = 0 To grdRegistros.Rows - 1
            grdRegistros.Row = i
            If grdRegistros.Picture Is Nothing Then
                grdRegistros.CtlText = Conversion.Str(grdRegistros.Row)
                grdRegistros.Picture = picVisto(1).Image
            End If
        Next i
        grdRegistros.Col = 0
        grdRegistros.Row = VLFila
        grdRegistros.Picture = picVisto(0).Image
    End Sub

    Private Sub PLObtenerDatos()
        Dim VTArreglo(20) As String
        VLVez = 1
        VLSalir = False
        VLStatus = " "
        VLRef = "0"
        While Not VLSalir
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "407")
            PMPasoValores(sqlconn, "@i_secuen", 0, SQLINT4, txtCarta.Text)
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
            PMPasoValores(sqlconn, "@i_consulta", 0, SQLVARCHAR, "N")
            PMPasoValores(sqlconn, "@i_status", 0, SQLVARCHAR, VLStatus)
            PMPasoValores(sqlconn, "@i_ref", 0, SQLINT4, VLRef)
            PMPasoValores(sqlconn, "@i_vez", 0, SQLINT1, Conversion.Str(VLVez))
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, VGTipoOper)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_consulcar", True, FMLoadResString(508809)) Then
                If VLVez = 1 Then
                    FMMapeaArreglo(sqlconn, VTArreglo)
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                Else
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                End If
                PMChequea(sqlconn)
                VLVez += 1
                If CDbl(Convert.ToString(grdRegistros.Tag)) < 40 Then VLSalir = True
                grdRegistros.ColAlignment(5) = 1
                lblDescripcion(0).Text = VTArreglo(1)
                lblDescripcion(1).Text = VTArreglo(2)
                lblDescripcion(2).Text = VTArreglo(3)
                lblDescripcion(3).Text = VTArreglo(4)
                lblDescripcion(4).Text = VTArreglo(5)
                lblDescripcion(5).Text = VTArreglo(6)
                lblDescripcion(6).Text = VTArreglo(7)
                lblDescripcion(7).Text = VTArreglo(8)
                lblDescripcion(8).Text = VTArreglo(9)
                lblDescripcion(9).Text = VTArreglo(10)
                lblDescripcion(11).Text = VTArreglo(12)
                txtCarta.Enabled = False
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 6
                VLStatus = grdRegistros.CtlText
                grdRegistros.Col = 7
                VLRef = grdRegistros.CtlText
            Else
                PMChequea(sqlconn)
                PLLimpiar()
                Exit Sub
            End If
        End While
        PLHabilitaBotones()
        PLProducto()
    End Sub

    Private Sub PLPostergar()
        Dim VTDias As String = ""
        If FLMarcados(0) Then
            VTDias = Interaction.InputBox(FMLoadResString(502452), FMLoadResString(508990))
            If VTDias <> "" Then
                If (Conversion.Val(VTDias) > 0) And (Conversion.Val(VTDias) <= 900) Then
                    For i As Integer = 1 To grdRegistros.Rows - 1
                        grdRegistros.Row = i
                        grdRegistros.Col = 0
                        If grdRegistros.Picture Is Nothing Then
                            grdRegistros.Col = 6
                            If grdRegistros.CtlText.Trim() <> FMLoadResString(509344) Then
                                COBISMessageBox.Show(FMLoadResString(508719), My.Application.Info.ProductName)
                                grdRegistros.Col = 0
                                grdRegistros.Picture = picVisto(1).Image
                                Exit Sub
                            End If
                            grdRegistros.Col = 12
                            If grdRegistros.CtlText.Trim() <> "" Then
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "405")
                                PMPasoValores(sqlconn, "@i_secuen", 0, SQLINT4, txtCarta.Text)
                                PMPasoValores(sqlconn, "@i_fecha", 0, SQLDATETIME, lblDescripcion(11).Text)
                                PMPasoValores(sqlconn, "@i_dias_pos", 0, SQLINT4, VTDias)
                                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                                grdRegistros.Col = 7
                                PMPasoValores(sqlconn, "@i_sec_chq", 0, SQLINT4, grdRegistros.CtlText)
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_postfecha", True, FMLoadResString(508852)) Then
                                    PMChequea(sqlconn)
                                Else
                                    PMChequea(sqlconn)
                                End If
                            Else
                                COBISMessageBox.Show(FMLoadResString(508453), My.Application.Info.ProductName)
                                grdRegistros.Col = 0
                                grdRegistros.Picture = picVisto(1).Image
                                Exit Sub
                            End If
                        End If
                    Next i
                    PLObtenerDatos()
                Else
                    COBISMessageBox.Show(FMLoadResString(508629), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    Exit Sub
                End If
            Else
                COBISMessageBox.Show(FMLoadResString(508629), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        Else
            COBISMessageBox.Show(FMLoadResString(508519), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
    End Sub

    Private Sub PLProducto()
        If grdRegistros.Rows <= 2 Then
            grdRegistros.Col = 1
            grdRegistros.Row = 1
            If grdRegistros.CtlText = "" Then
                Exit Sub
            End If
        End If
        For i As Integer = 1 To grdRegistros.Rows - 1
            grdRegistros.Col = 3
            grdRegistros.Row = i
            Select Case grdRegistros.CtlText
                Case "3"
                    grdRegistros.CtlText = FMLoadResString(509348)
                Case "4"
                    grdRegistros.CtlText = FMLoadResString(509349)
            End Select
        Next i
    End Sub

    Private Sub PLRefrescar()
        grdRegistros.Col = 7
        For i As Integer = 1 To grdRegistros.Rows - 1
            grdRegistros.Row = i
            If grdRegistros.CtlText = VLDatosCheque(1) Then
                grdRegistros.Col = 0
                grdRegistros.Picture = picVisto(1).Image
                grdRegistros.Col = 6
                grdRegistros.CtlText = VLDatosCheque(2)
                lblDescripcion(8).Text = VLDatosCheque(3)
                lblDescripcion(9).Text = VLDatosCheque(4)
                grdRegistros.Col = 9
                grdRegistros.CtlText = ""
                Exit For
            End If
        Next i
    End Sub

    Private Sub PLReversar()
        Dim VTValor As String = String.Empty
        Dim VTReferencia As String = String.Empty
        Dim VTCtadep As String = String.Empty
        Dim VTAplicacion As String = String.Empty
        Dim VTRemesas As String = String.Empty
        Dim VTNChq As String = String.Empty
        Dim VTCausaDev As String = String.Empty
        If FLMarcados(0) Then
            grdRegistros.Row = VLFila
            grdRegistros.Col = 6
            If grdRegistros.CtlText = FMLoadResString(509345) Or grdRegistros.CtlText = FMLoadResString(509346) Then
                grdRegistros.Col = 5
                VTValor = grdRegistros.CtlText
                grdRegistros.Col = 7
                VTReferencia = grdRegistros.CtlText
                grdRegistros.Col = 2
                VTCtadep = grdRegistros.CtlText
                grdRegistros.Col = 3
                VTAplicacion = grdRegistros.CtlText
                grdRegistros.Col = 10
                VTRemesas = grdRegistros.CtlText
                grdRegistros.Col = 4
                VTNChq = grdRegistros.CtlText
                PMPasoValores(sqlconn, "@t_corr", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_propie", 0, SQLVARCHAR, lblDescripcion(2).Text)
                PMPasoValores(sqlconn, "@i_emisor", 0, SQLVARCHAR, lblDescripcion(4).Text)
                PMPasoValores(sqlconn, "@i_corres", 0, SQLVARCHAR, lblDescripcion(0).Text)
                PMPasoValores(sqlconn, "@i_secuen", 0, SQLINT4, txtCarta.Text)
                PMPasoValores(sqlconn, "@i_fecha", 0, SQLDATETIME, lblDescripcion(11).Text)
                PMPasoValores(sqlconn, "@i_chq", 0, SQLINT4, VTReferencia)
                PMPasoValores(sqlconn, "@i_val", 0, SQLMONEY, VTValor)
                PMPasoValores(sqlconn, "@i_hablt", 0, SQLVARCHAR, "C")
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                PMPasoValores(sqlconn, "@i_nchq", 0, SQLINT4, VTNChq)
                grdRegistros.Col = 6
                Select Case grdRegistros.CtlText
                    Case FMLoadResString(509345)
                        PMPasoValores(sqlconn, "@i_tipo_rem", 0, SQLVARCHAR, VTRemesas)
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "404")
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_confcheque", True, FMLoadResString(508842)) Then
                            ReDim VLDatosCheque(4)
                            FMMapeaArreglo(sqlconn, VLDatosCheque)
                            PMChequea(sqlconn)
                            PLRefrescar()
                        Else
                            PMChequea(sqlconn)
                            grdRegistros.Col = 0
                            grdRegistros.Picture = picVisto(0).Image
                        End If
                    Case FMLoadResString(509346)
                        VTCausaDev = "0"
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "402")
                        PMPasoValores(sqlconn, "@i_ctadep", 0, SQLVARCHAR, VTCtadep)
                        PMPasoValores(sqlconn, "@i_prddep", 0, SQLVARCHAR, VTAplicacion)
                        PMPasoValores(sqlconn, "@i_causadev", 0, SQLVARCHAR, VTCausaDev)
                        PMPasoValores(sqlconn, "@i_tipo_rem", 0, SQLVARCHAR, VTRemesas)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_chequedev", True, FMLoadResString(508846)) Then
                            ReDim VLDatosCheque(4)
                            FMMapeaArreglo(sqlconn, VLDatosCheque)
                            PMChequea(sqlconn)
                            PLRefrescar()
                        Else
                            PMChequea(sqlconn)
                            grdRegistros.Col = 0
                            grdRegistros.Picture = picVisto(0).Image
                        End If
                End Select
            Else
                Select Case grdRegistros.CtlText
                    Case FMLoadResString(509347)
                        VLEstado = FMLoadResString(509347)
                    Case FMLoadResString(509344)
                        VLEstado = FMLoadResString(509344)
                End Select
                COBISMessageBox.Show(FMLoadResString(501183) & " " & VLEstado & FMLoadResString(508645), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                grdRegistros.Row = VLFila
                grdRegistros.Col = 0
                If grdRegistros.Picture Is Nothing Then
                    grdRegistros.Picture = picVisto(1).Image
                End If
                Exit Sub
            End If
        Else
            COBISMessageBox.Show(FMLoadResString(500322), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCarta_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCarta.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub txtCarta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCarta.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508665))
        txtCarta.SelectionStart = 0
        txtCarta.SelectionLength = Strings.Len(txtCarta.Text)
    End Sub

    Private Sub txtCarta_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtCarta.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode = VGTeclaAyuda Then
            For i As Integer = 1 To 2
                VLPaso = True
                VGOperacion = "sp_rem_ayuda"
                txtCarta.Text = ""
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "447")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "N")
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, "0")
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGMoneda)
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, VGTipoOper)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_ayuda", True, FMLoadResString(508822)) Then
                    PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                    PMChequea(sqlconn)
                    If i = 2 Then
                        FRegistros.ShowPopup(Me)
                    End If
                    FRegistros.cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(FRegistros.grdRegistros.Tag)) = VGMaxRows
                    txtCarta.Text = VGACatalogo.Codigo
                    If txtCarta.Text <> "" Then
                        If i = 2 Then
                            PLObtenerDatos()
                        End If
                    End If
                Else
                    PMChequea(sqlconn)
                    Exit Sub
                End If
            Next i
        End If
    End Sub

    Private Sub txtCarta_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtCarta.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCarta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCarta.Leave
        If Not VLPaso And txtCarta.Text <> "" Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
            PLObtenerDatos()
        End If
    End Sub

    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        VGHelpRem = "N"
        VGTipoOper = "C"
    End Sub

End Class


