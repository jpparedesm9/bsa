Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary

Partial Public Class FTran211Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLPaso As Integer = 0

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_0.Click, _cmdBoton_3.Click, _cmdBoton_4.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                If mskCuenta.ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(2547), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                    Exit Sub
                End If
                If txtCampo(1).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(501824), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If txtCampo(1).Text = "9" Then
                    COBISMessageBox.Show(FMLoadResString(501825), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If txtCampo(0).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(501818), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(501803), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "211")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                PMPasoValores(sqlconn, "@i_tbloq", 0, SQLCHAR, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_causa", 0, SQLCHAR, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_solicit", 0, SQLVARCHAR, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_aut", 0, SQLVARCHAR, VGLogin)
                PMPasoValores(sqlconn, "@i_observacion", 0, SQLVARCHAR, txtObservacion.Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_bloqueo_mov_ah", True, FMLoadResString(2548)) Then
                    PMChequea(sqlconn)
                    cmdBoton(0).Enabled = False
                    cmdBoton(4).Enabled = True
                    COBISMessageBox.Show(FMLoadResString(502018), FMLoadResString(501547), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                Else
                    PMChequea(sqlconn) 'JSA
                End If
            Case 1
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                For i As Integer = 0 To 2
                    lblDescripcion(i).Text = ""
                Next i
                For i As Integer = 0 To 2
                    txtCampo(i).Text = ""
                Next i
                txtObservacion.Text = ""
                PMLimpiaGrid(grdPropietarios)
                cmdBoton(3).Enabled = False
                cmdBoton(0).Enabled = True
                cmdBoton(4).Enabled = False
                mskCuenta.Focus()
            Case 2
                Me.Close()
            Case 3
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "298")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_clientes_ah", True, FMLoadResString(2543)) Then
                    PMMapeaGrid(sqlconn, grdPropietarios, False)
                    PMMapeaTextoGrid(grdPropietarios) 'JSA
                    PMAnchoColumnasGrid(grdPropietarios) 'JSA
                    PMChequea(sqlconn)
                Else
                    PMLimpiaGrid(grdPropietarios)
                    PMChequea(sqlconn) 'JSA
                End If
            Case 4
                PLImprimir()
        End Select
        PLTSEstado()
    End Sub

    Private Sub FTran211_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Public Sub PLInicializar()
        PMCatalogo("D", "cc_tbloqueo", txtCampo(0), lblDescripcion(1))
        mskCuenta.Mask = VGMascaraCtaAho
        txtCampo(2).MaxLength = 50
        Me.Text = FMLoadResString(5257)
    End Sub

    Private Sub FTran211_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdPropietarios_ClickEvent(sender As Object, e As EventArgs) Handles grdPropietarios.ClickEvent
        PMMarcaFilaCobisGrid(grdPropietarios, grdPropietarios.Row)
    End Sub

    Private Sub grdPropietarios_DblClick(sender As Object, e As EventArgs) Handles grdPropietarios.DblClick
        PMMarcaFilaCobisGrid(grdPropietarios, grdPropietarios.Row)
    End Sub

    Private Sub grdPropietarios_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdPropietarios.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2223))
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500659))
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
    End Sub

    Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        Try
            If mskCuenta.ClipText <> "" Then
                If FMChequeaCtaAho(mskCuenta.ClipText) Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_val_inac", 0, SQLVARCHAR, "N")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2544) & " " & "[" & mskCuenta.Text & "]") Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(0))
                        PMChequea(sqlconn)
                        cmdBoton(3).Enabled = True
                        PMLimpiaGrid(grdPropietarios)
                    Else
                        cmdBoton_Click(cmdBoton(1), New EventArgs())
                        PMChequea(sqlconn) 'JSA
                        Exit Sub
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    cmdBoton_Click(cmdBoton(1), New EventArgs())
                    Exit Sub
                End If
            End If
        Catch exc As System.Exception
            'NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
            COBISMessageBox.Show(exc.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'JSA
        End Try
        PLTSEstado()
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.TextChanged, _txtCampo_0.TextChanged, _txtCampo_1.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.Enter, _txtCampo_0.Enter, _txtCampo_1.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = True
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501820))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501821))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501808))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_2.KeyDown, _txtCampo_0.KeyDown, _txtCampo_1.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If Keycode = VGTeclaAyuda Then
                    VLPaso = True
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "ah_tbloqueo")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(2549)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(0).Text = VGACatalogo.Codigo
                        lblDescripcion(1).Text = VGACatalogo.Descripcion
                        If txtCampo(0).Text <> "" Then
                            txtCampo(2).Focus()
                        End If
                    Else
                        PMChequea(sqlconn) 'JSA
                        txtCampo(0).Text = ""
                        lblDescripcion(1).Text = ""
                        txtCampo(0).Focus()
                    End If
                End If
            Case 1
                If Keycode = VGTeclaAyuda Then
                    VLPaso = True
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "ah_causa_bloqueo_mov")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(2550)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(1).Text = VGACatalogo.Codigo
                        lblDescripcion(2).Text = VGACatalogo.Descripcion
                        If txtCampo(1).Text = "9" Then
                            COBISMessageBox.Show(FMLoadResString(501825), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(1).Text = ""
                            txtCampo(1).Focus()
                            lblDescripcion(2).Text = ""
                            Exit Sub
                        End If
                        If txtCampo(1).Text <> "" Then
                            txtCampo(0).Focus()
                        End If
                    Else
                        PMChequea(sqlconn) 'JSA
                        txtCampo(1).Text = ""
                        lblDescripcion(2).Text = ""
                        txtCampo(1).Focus()
                    End If
                End If
        End Select
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_2.KeyPress, _txtCampo_0.KeyPress, _txtCampo_1.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1
                KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
            Case 2
                KeyAscii = FMVAlidaTipoDato("A", KeyAscii)
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.Leave, _txtCampo_0.Leave, _txtCampo_1.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Not VLPaso Then
            Select Case Index
                Case 0
                    If txtCampo(0).Text <> "" Then
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "ah_tbloqueo")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCampo(0).Text)
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(2551) & " " & "[" & txtCampo(0).Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(1))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn) 'JSA
                            VLPaso = True
                            txtCampo(0).Text = ""
                            lblDescripcion(1).Text = ""
                            txtCampo(0).Focus()
                        End If
                    Else
                        lblDescripcion(1).Text = ""
                    End If
                Case 1
                    If txtCampo(1).Text <> "" Then
                        If txtCampo(1).Text = "9" Then
                            COBISMessageBox.Show(FMLoadResString(501825), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(1).Text = ""
                            txtCampo(1).Focus()
                            lblDescripcion(2).Text = ""
                            Exit Sub
                        End If
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "ah_causa_bloqueo_mov")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCampo(1).Text)
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(2551) & " " & "[" & txtCampo(0).Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(2))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn) 'JSA
                            VLPaso = True
                            txtCampo(1).Text = ""
                            lblDescripcion(2).Text = ""
                            txtCampo(1).Focus()
                        End If
                    Else
                        lblDescripcion(2).Text = ""
                    End If
            End Select
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_2.MouseDown, _txtCampo_0.MouseDown, _txtCampo_1.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1
                My.Computer.Clipboard.Clear()
                My.Computer.Clipboard.SetText("")
        End Select
    End Sub

    Private Sub txtObservacion_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtObservacion.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2227))
        txtObservacion.SelectionStart = 0
        txtObservacion.SelectionLength = Strings.Len(txtObservacion.Text)
    End Sub

    Private Sub txtObservacion_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtObservacion.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("A", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub PLImprimir()
        Dim banderaContinuar As Boolean = True
        If COBISMessageBox.Show(FMLoadResString(501822), FMLoadResString(500092), COBISMessageBox.COBISButtons.OKCancel, COBISMessageBox.COBISIcon.Question) = System.Windows.Forms.DialogResult.Cancel Then
            banderaContinuar = False
        End If
            If banderaContinuar Then
                Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
                FMCabeceraReporte(VGBanco, DateTimeHelper.ToString(DateTime.Today), "BLOQUEO DE MOVIMIENTOS EN CUENTA DE AHORROS", DateTimeHelper.ToString(DateTimeHelper.Time), Me.Text, VGFecha, CStr(1))
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 8
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Número de Cuenta           :", FileSystem.TAB(32), mskCuenta.Text)
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Nombre de la Cuenta        :", FileSystem.TAB(32), lblDescripcion(0).Text)
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Causa del Bloqueo          :", FileSystem.TAB(32), txtCampo(1).Text, "  ", lblDescripcion(2).Text)
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Tipo de   Bloqueo          :", FileSystem.TAB(32), txtCampo(0).Text, "  ", lblDescripcion(1).Text)
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Solicitado por             :", FileSystem.TAB(32), txtCampo(2).Text)
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Observaciones              :", FileSystem.TAB(32), txtObservacion.Text)
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), VGLogin)
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("_________________                                                 _________________")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  PROCESADO POR                                                     AUTORIZADO POR ")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.EndDoc()
                Me.Cursor = System.Windows.Forms.Cursors.Default
            Else
                Exit Sub
            End If
    End Sub

    Private Sub PLTSEstado()
        TSBPropietario.Enabled = _cmdBoton_3.Enabled
        TSBPropietario.Visible = _cmdBoton_3.Visible
        TSBImprimir.Enabled = _cmdBoton_4.Enabled
        TSBImprimir.Visible = _cmdBoton_4.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
    End Sub

    Private Sub TSBPropietario_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBPropietario.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        'If Not (Artinsoft.VB6.Gui.ActivateHelper.myActiveForm Is eventSender) Then
        '	Artinsoft.VB6.Gui.ActivateHelper.myActiveForm = eventSender
        'End If
    End Sub

    Private Sub txtObservacion_Leave(sender As Object, e As EventArgs) Handles txtObservacion.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub grdPropietarios_Leave(sender As Object, e As EventArgs) Handles grdPropietarios.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
End Class


