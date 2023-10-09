Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Drawing
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary

Partial Public Class FTran217Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLPaso As Integer = 0
    Dim CodAnte As String = ""
    Private Sub FTran217_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Public Sub PLInicializar()
        lblDescripcion(0).Text = VLClienteb
        mskCuenta.Mask = VGMascaraCtaAho
        mskCuentacte.Mask = VGMascaraCtaAho
        mskValor.Text = VGDecimales
        mskValor.Text = StringsHelper.Format(0, VGDecimales)
        txtCampo(2).MaxLength = 48
        txtCampo(1).Enabled = False
        txtCampo(3).Enabled = False
        txtCampo(4).Enabled = False
        mskCuentacte.Enabled = False
        lblEtiqueta(5).ForeColor = Color.Gray
        lblEtiqueta(8).ForeColor = Color.Gray
        lblEtiqueta(9).ForeColor = Color.Gray
        lblEtiqueta(10).ForeColor = Color.Gray
        lblEtiqueta(9).Visible = False
        lblEtiqueta(10).Visible = False
        lblDescripcion(3).Visible = False
        mskCuentacte.Visible = False
        txtCampo(4).Visible = False
        Me.Text = FMLoadResString(3841)
    End Sub

    Private Sub FTran217_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_4.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VBloquea As String = "N"
        Select Case Index
            Case 0
                If mskCuenta.ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(501337), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                    Exit Sub
                End If
                If txtCampo(0).Text.Trim() = "" Then
                    If VGCodPais = "CO" Then
                        COBISMessageBox.Show(FMLoadResString(2555), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    Else
                        COBISMessageBox.Show(FMLoadResString(501800), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    End If
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If Conversion.Val(mskValor.Text) <= 0 Then
                    If VGCodPais = "CO" Then
                        COBISMessageBox.Show(FMLoadResString(2556), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    Else
                        COBISMessageBox.Show(FMLoadResString(502027), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    End If
                    mskValor.Focus()
                    Exit Sub
                End If
                If Conversion.Val(txtCampo(1).Text) <= 0 And txtCampo(1).Enabled Then
                    COBISMessageBox.Show(FMLoadResString(501802), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    If txtCampo(1).Enabled Then txtCampo(1).Focus()
                    Exit Sub
                End If
                If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(501803), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                If txtObservacion.Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(502028), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtObservacion.Focus()
                    Exit Sub
                End If
                If txtCampo(0).Text = "10" Or txtCampo(0).Text = "11" Or txtCampo(0).Text = "8" Or txtCampo(0).Text = "5" Then
                    If txtCampo(0).Text = "5" Then
                        If mskCuentacte.ClipText = "" Or mskCuentacte.ClipText = FMMascara("", VGMascaraCtaCte) Then
                            COBISMessageBox.Show(FMLoadResString(500018), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            mskCuentacte.Enabled = True
                            lblEtiqueta(10).ForeColor = Color.Navy
                            mskCuentacte.Focus()
                            Exit Sub
                        End If
                    Else
                        If txtCampo(3).Text = "" Then
                            COBISMessageBox.Show(FMLoadResString(502030), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(3).Enabled = True
                            lblEtiqueta(8).ForeColor = Color.Navy
                            txtCampo(3).Focus()
                            Exit Sub
                        End If
                    End If
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "217")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                PMPasoValores(sqlconn, "@i_accion", 0, SQLCHAR, "B")
                PMPasoValores(sqlconn, "@i_causa", 0, SQLCHAR, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_valor", 0, SQLMONEY, mskValor.Text)
                PMPasoValores(sqlconn, "@i_aut", 0, SQLVARCHAR, VGLogin)
                PMPasoValores(sqlconn, "@i_solicit", 0, SQLVARCHAR, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_plazo", 0, SQLINT2, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@o_fecha_ven", 1, SQLDATETIME, "01/01/1960")
                PMPasoValores(sqlconn, "@i_observacion", 0, SQLVARCHAR, txtObservacion.Text)
                PMPasoValores(sqlconn, "@i_ngarantia", 0, SQLCHAR, txtCampo(3).Text)
                PMPasoValores(sqlconn, "@i_nlinea_sob", 0, SQLVARCHAR, txtCampo(4).Text)
                PMPasoValores(sqlconn, "@i_numcte", 0, SQLVARCHAR, mskCuentacte.ClipText)
                PMPasoValores(sqlconn, "@o_no_bloq", 1, SQLCHAR, "N")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_bloq_val_ah", True, FMLoadResString(2557)) Then
                    PMChequea(sqlconn)
                    If FMRetParam(sqlconn, 2) = "S" Then
                        cmdBoton(0).Enabled = False
                        cmdBoton(4).Enabled = False
                        PLTSEstado()
                        Exit Sub
                    End If

                    lblDescripcion(2).Text = StringsHelper.Format(Strings.Left(FMRetParam(sqlconn, 2), 11), "Medium Date")
                    cmdBoton(0).Enabled = False
                    cmdBoton(4).Enabled = True
                    COBISMessageBox.Show(FMLoadResString(502031), FMLoadResString(501547), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                    PLTSEstado()
                Else
                    PMChequea(sqlconn) 'JSA
                    cmdBoton(0).Enabled = False
                    cmdBoton(4).Enabled = False
                    PLTSEstado()

                    '   COBISMessageBox.Show(FMLoadResString(502031), FMLoadResString(501547), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                End If
            Case 1
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                mskCuentacte.Text = FMMascara("", VGMascaraCtaAho)
                For i As Integer = 0 To 3
                    lblDescripcion(i).Text = ""
                Next i
                For i As Integer = 0 To 4 ' JCA 4
                    txtCampo(i).Text = ""
                Next i
                txtObservacion.Text = ""
                mskValor.Text = VGDecimales
                mskValor.Text = StringsHelper.Format(0, VGDecimales)
                PMLimpiaGrid(grdPropietarios)
                cmdBoton(3).Enabled = False
                cmdBoton(0).Enabled = True
                cmdBoton(4).Enabled = False
                mskCuenta.Focus()
                txtCampo(1).Enabled = False
                txtCampo(3).Enabled = False
                '  txtCampo(4).Enabled = False
                ' mskCuentacte.Enabled = False
                lblEtiqueta(5).ForeColor = Color.Gray
                lblEtiqueta(8).ForeColor = Color.Gray
                ' lblEtiqueta(9).ForeColor = Color.Gray
                ' lblEtiqueta(10).ForeColor = Color.Gray
                PLTSEstado()
            Case 2
                Me.Close()
            Case 3
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "298")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_clientes_ah", True, FMLoadResString(2543)) Then
                    PMMapeaGrid(sqlconn, grdPropietarios, False)
                    PMMapeaTextoGrid(grdPropietarios)
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
        If mskCuenta.ClipText <> "" Then
            If FMChequeaCtaAho(mskCuenta.ClipText) Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                PMPasoValores(sqlconn, "@i_val_inac", 0, SQLVARCHAR, "N")
                PMPasoValores(sqlconn, "@o_estado", 1, SQLVARCHAR, "")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2544) & " " & "[" & mskCuenta.Text & "]") Then
                    PMChequea(sqlconn)
                    If FMRetParam(sqlconn, 1) = "G" Then
                        cmdBoton(0).Enabled = False
                        cmdBoton(4).Enabled = False
                        cmdBoton(3).Enabled = False
                        COBISMessageBox.Show(FMLoadResString(600024), FMLoadResString(501547), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                        PLTSEstado()
                        Exit Sub
                    End If
                    PMMapeaObjeto(sqlconn, lblDescripcion(0))
                    cmdBoton(3).Enabled = True
                    PMLimpiaGrid(grdPropietarios)
                    PLTSEstado()
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
        PLTSEstado()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub mskCuentacte_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuentacte.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500194))
        mskCuentacte.SelectionStart = 0
        mskCuentacte.SelectionLength = Strings.Len(mskCuenta.Text)
    End Sub

    Private Sub mskCuentacte_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuentacte.Leave
        Try
            If mskCuentacte.ClipText <> "" Then
                If FMChequeaCtaCte(mskCuentacte.ClipText) Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "16")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuentacte.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, FMLoadResString(2544) & " " & "[" & mskCuenta.Text & "]") Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(3))
                        PMChequea(sqlconn)
                    Else
                        mskCuentacte.Text = FMMascara("", VGMascaraCtaCte)
                        lblDescripcion(3).Text = ""
                        PMChequea(sqlconn) 'JSA
                        mskCuentacte.Focus()
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(500020), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuentacte.Text = FMMascara("", VGMascaraCtaCte)
                    lblDescripcion(3).Text = ""
                    mskCuentacte.Focus()
                    Exit Sub
                End If
            End If
        Catch exc As System.Exception
            'NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
            COBISMessageBox.Show(exc.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End Try
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub mskValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskValor.Enter
        If VGCodPais = "CO" Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2233))
        Else
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501806))
        End If
        mskValor.Text = CDec(mskValor.Text) 'JSA
        mskValor.SelectionStart = 0
        mskValor.SelectionLength = Strings.Len(mskValor.Text)
    End Sub

    Private Sub mskValor_Leave(sender As Object, e As EventArgs) Handles mskValor.Leave
        mskValor.Text = StringsHelper.Format(CDec(mskValor.Text), VGDecimales) 'JSA
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub mskValor_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskValor.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If Val(mskValor.Text) > 100000000000 Then
            'Valor excede el máximo permitido
            If KeyAscii <> 8 Then
                COBISMessageBox.Show(FMLoadResString(501098), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                KeyAscii = 0
            End If
        End If
        If VGDecimales = "#,##0" Then
            If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                KeyAscii = 0
            End If
        Else
            If (KeyAscii <> 8) And (KeyAscii <> 46) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                KeyAscii = 0
            End If
        End If
        If KeyAscii = 46 Then
            If mskValor.Text = String.Empty Then
                KeyAscii = 0
            Else
                If InStr(1, mskValor.Text, ".") > 1 Then
                    KeyAscii = 0
                End If
            End If
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_4.TextChanged, _txtCampo_2.TextChanged, _txtCampo_1.TextChanged, _txtCampo_0.TextChanged, _txtCampo_3.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False

    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_4.Enter, _txtCampo_2.Enter, _txtCampo_1.Enter, _txtCampo_0.Enter, _txtCampo_3.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = True
        Select Case Index
            Case 0
                If VGCodPais = "CO" Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501821))
                Else
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501807))
                End If
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500997))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502032))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502033))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502034))
        End Select
        ' txtCampo(Index).SelectionStart = Index
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_4.KeyDown, _txtCampo_2.KeyDown, _txtCampo_1.KeyDown, _txtCampo_0.KeyDown, _txtCampo_3.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)

        ' txtCampo(1).Enabled = False
        ' txtCampo(3).Enabled = False
        ' txtCampo(4).Enabled = False
        ' mskCuentacte.Enabled = False
        'lblEtiqueta(5).ForeColor = Color.Gray
        'lblEtiqueta(8).ForeColor = Color.Gray
        ' lblEtiqueta(9).ForeColor = Color.Gray
        ' lblEtiqueta(10).ForeColor = Color.Gray
        CodAnte = txtCampo(0).Text
        If txtCampo(0).Text = "18" Then
            txtCampo(3).Enabled = True
            ' lblEtiqueta(8).ForeColor = Color.Navy
        End If

        If Keycode = VGTeclaAyuda And Index = 0 Then
            VLPaso = True
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "ah_causa_bloqueo_val")
            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(2554)) Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.ShowPopup(Me)
                txtCampo(0).Text = VGACatalogo.Codigo
                lblDescripcion(1).Text = VGACatalogo.Descripcion
                If txtCampo(0).Text <> "" Then
                    mskValor.Focus()
                End If
                If txtCampo(0).Text <> CodAnte Then
                    txtCampo(3).Text = ""
                    CodAnte = txtCampo(0).Text
                End If
                If txtCampo(0).Text = "10" Or txtCampo(0).Text = "11" Or txtCampo(0).Text = "8" Or txtCampo(0).Text = "5" Then
                    txtCampo(1).Enabled = True
                    txtCampo(3).Enabled = True
                    ' txtCampo(4).Enabled = True
                    mskCuentacte.Enabled = True
                    ' lblEtiqueta(5).ForeColor = Color.Navy
                    ' lblEtiqueta(8).ForeColor = Color.Navy
                    ' lblEtiqueta(9).ForeColor = Color.Navy
                    ' lblEtiqueta(10).ForeColor = Color.Navy
                End If
                If txtCampo(0).Text = "18" Then
                    txtCampo(3).Enabled = True
                    ' lblEtiqueta(8).ForeColor = Color.Navy
                    lblEtiqueta(8).Enabled = True
                End If
            Else
                PMChequea(sqlconn) 'JSA
                txtCampo(0).Text = ""
                lblDescripcion(1).Text = ""
                txtCampo(2).Text = ""
                txtObservacion.Text = ""
                mskValor.Text = StringsHelper.Format(0, VGDecimales)
                If txtCampo(0).Text <> CodAnte Then
                    txtCampo(3).Text = ""
                    CodAnte = txtCampo(0).Text
                End If
                txtCampo(0).Focus()
            End If
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_4.KeyPress, _txtCampo_2.KeyPress, _txtCampo_1.KeyPress, _txtCampo_0.KeyPress, _txtCampo_3.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 4
                If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                    KeyAscii = 0
                End If
            Case 2
                KeyAscii = FMVAlidaTipoDato("A", KeyAscii)
            Case 3
                If txtCampo(0).Text = "18" Then
                    If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                        KeyAscii = 0
                    End If
                Else
                    KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
                End If

        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.Leave, _txtCampo_2.Leave, _txtCampo_1.Leave, _txtCampo_0.Leave, _txtCampo_4.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        txtCampo(1).Enabled = False
        txtCampo(3).Enabled = False
        ' txtCampo(4).Enabled = False
        ' mskCuentacte.Enabled = False
        ' lblEtiqueta(5).ForeColor = Color.Gray
        'lblEtiqueta(8).ForeColor = Color.Gray
        'lblEtiqueta(9).ForeColor = Color.Gray
        ' lblEtiqueta(10).ForeColor = Color.Gray
        If txtCampo(0).Text = "18" Then
            txtCampo(3).Enabled = True
            txtCampo(3).Visible = True
            lblEtiqueta(8).Enabled = True
        End If

        If Not VLPaso Then
            Select Case Index
                Case 0
                    If txtCampo(0).Text <> "" Then
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "ah_causa_bloqueo_val")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCampo(0).Text)
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(2551) & " " & "[" & txtCampo(0).Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(1))
                            PMChequea(sqlconn)
                            If txtCampo(0).Text = "10" Or txtCampo(0).Text = "11" Or txtCampo(0).Text = "8" Or txtCampo(0).Text = "5" Then
                                txtCampo(1).Enabled = True
                                txtCampo(3).Enabled = True
                                ' txtCampo(4).Enabled = True
                                mskCuentacte.Enabled = True
                                '  lblEtiqueta(5).ForeColor = Color.Navy
                                ' lblEtiqueta(8).ForeColor = Color.Navy
                                ' lblEtiqueta(9).ForeColor = Color.Navy
                                ' lblEtiqueta(10).ForeColor = Color.Navy
                            End If
                            If txtCampo(0).Text = "18" Then
                                txtCampo(3).Enabled = True
                                ' lblEtiqueta(8).ForeColor = Color.Navy
                                lblEtiqueta(9).Enabled = True
                            End If
                            If txtCampo(0).Text <> CodAnte Then
                                txtCampo(3).Text = ""
                                CodAnte = txtCampo(0).Text
                            End If

                        Else
                            PMChequea(sqlconn) 'JSA
                            VLPaso = True
                            txtCampo(0).Text = ""
                            lblDescripcion(1).Text = ""
                            txtCampo(2).Text = ""
                            txtObservacion.Text = ""
                            mskValor.Text = StringsHelper.Format(0, VGDecimales)
                            If txtCampo(0).Text <> CodAnte Then
                                txtCampo(3).Text = ""
                                CodAnte = txtCampo(0).Text
                            End If
                            txtCampo(0).Focus()
                        End If
                    Else
                        lblDescripcion(1).Text = ""
                    End If
            End Select
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub txtObservacion_Enter(sender As Object, e As EventArgs) Handles txtObservacion.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2227))
    End Sub

    Private Sub txtObservacion_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtObservacion.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("A", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtObservacion_Leave(sender As Object, e As EventArgs) Handles txtObservacion.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)

        If txtCampo(0).Text = "18" Then
            txtCampo(3).Focus()
           
        End If
    End Sub


    Private Sub PLImprimir()
        Dim VTMsg As String = ""
        Dim VLFormatoFechaRep As String = ""

        Dim banderaContinuar As Boolean = True
        If VGCodPais = "CO" Then
            VTMsg = FMLoadResString(2558)
        Else
            VTMsg = FMLoadResString(501810)
        End If

        VLFormatoFechaRep = "dd/MM/yyyy"

        If COBISMessageBox.Show(VTMsg, FMLoadResString(500092), COBISMessageBox.COBISButtons.OKCancel, COBISMessageBox.COBISIcon.Question) = System.Windows.Forms.DialogResult.Cancel Then
            banderaContinuar = False
        End If
        If banderaContinuar Then
            Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
            FMCabeceraReporte(VGBanco, CDate(VGFecha).ToString(VLFormatoFechaRep), "BLOQUEO DE VALORES EN CUENTAS DE AHORROS", DateTimeHelper.ToString(DateTimeHelper.Time), Me.Text, VGFecha, CStr(1))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 8
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Número de Cuenta           :", FileSystem.TAB(32), mskCuenta.Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Nombre de la Cuenta        :", FileSystem.TAB(32), lblDescripcion(0).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            If VGCodPais = "CO" Then
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Causa del Bloqueo          :", FileSystem.TAB(32), txtCampo(0).Text, "  ", lblDescripcion(1).Text)
            Else
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Causa de la Pignoración    :", FileSystem.TAB(32), txtCampo(0).Text, "  ", lblDescripcion(1).Text)
            End If
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            If VGCodPais = "CO" Then
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Valor del Bloqueo          :", FileSystem.TAB(32), StringsHelper.Format(mskValor.Text, "#,##0.00"))
            Else
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Valor de la Pignoración    :", FileSystem.TAB(32), StringsHelper.Format(mskValor.Text, "#,##0.00"))
            End If
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Plazo en Días              :", FileSystem.TAB(32), txtCampo(1).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Solicitado por             :", FileSystem.TAB(32), txtCampo(2).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Fecha de Vencimiento       :", FileSystem.TAB(32), lblDescripcion(2).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Observaciones              :", FileSystem.TAB(32), txtObservacion.Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(" Número de Obligación         :", FileSystem.TAB(32), txtCampo(3).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            'COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Número línea de sobregiro  :", FileSystem.TAB(32), txtCampo(4).Text)
            'COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            ' COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  Número cuenta corriente    :", FileSystem.TAB(32), mskCuentacte.Text)
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

   
End Class


