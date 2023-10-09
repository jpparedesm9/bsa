Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Partial Public Class ftran496Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_2.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                If mskCuenta.ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500332), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                    Exit Sub
                End If
                If txtCampo(0).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(501349), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(1).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(501350), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@s_ssn_branch", 0, SQLINT4, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@s_sesn", 0, SQLINT4, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@s_lsrv", 0, SQLVARCHAR, ServerNameLocal)
                PMPasoValores(sqlconn, "@s_srv", 0, SQLVARCHAR, ServerNameLocal)
                PMPasoValores(sqlconn, "@s_user", 0, SQLVARCHAR, "dvasquezl")
                PMPasoValores(sqlconn, "@s_term", 0, SQLVARCHAR, "consola")
                PMPasoValores(sqlconn, "@s_date", 0, SQLDATETIME, "08/06/2002")
                PMPasoValores(sqlconn, "@s_ofi", 0, SQLINT2, "1")
                PMPasoValores(sqlconn, "@s_rol", 0, SQLINT2, "1")
                PMPasoValores(sqlconn, "@s_org", 0, SQLCHAR, "U")
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "40")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_val", 0, SQLMONEY, mskValor.Text)
                PMPasoValores(sqlconn, "@i_prop", 0, SQLMONEY, Maskpropios.Text)
                PMPasoValores(sqlconn, "@i_loc", 0, SQLMONEY, MaskObancos.Text)
                PMPasoValores(sqlconn, "@i_plaz", 0, SQLMONEY, MaskExt.Text)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                PMPasoValores(sqlconn, "@i_sp", 0, SQLVARCHAR, "sp_deposito")
                PMPasoValores(sqlconn, "@i_ActTot", 0, SQLCHAR, "N")
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, "1")
                PMPasoValores(sqlconn, "@i_consumo", 0, SQLMONEY, "0.00")
                PMPasoValores(sqlconn, "@i_planilla", 0, SQLVARCHAR, txtCampo(0).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_deposito", True, FMLoadResString(509252)) Then
                    PMChequea(sqlconn)
                    cmdBoton(0).Enabled = False
                Else
                    PMChequea(sqlconn)
                End If
            Case 1
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                lblDescripcion(0).Text = ""
                lblDescripcion(1).Text = ""
                txtCampo(0).Text = ""
                txtCampo(1).Text = ""
                mskValor.Text = ""
                PMLimpiaGrid(grdPropietarios)
                cmdBoton(3).Enabled = False
                mskValor.Text = VGDecimales
                mskValor.Text = StringsHelper.Format(0, VGDecimales)
                cmdBoton(0).Enabled = True
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
                mskCuenta.Focus()
            Case 2
                Me.Close()
            Case 3
                PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "17")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_query_clientes", True, FMLoadResString(509253)) Then
                    PMMapeaGrid(sqlconn, grdPropietarios, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
        End Select
    End Sub

    Private Sub ftran496_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBPropietarios.Enabled = _cmdBoton_3.Enabled
        TSBPropietarios.Visible = _cmdBoton_3.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
    End Sub

    Private Sub TSBPropietarios_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBPropietarios.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
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

    Public Sub PLInicializar()
        Me.Left = 0
        Me.Top = 0
        mskValor.MaxLength = 14
        mskCuenta.Mask = VGMascaraCtaCte
        mskValor.Mask = VGDecimales 'mskValor.Text = VGDecimales
        mskValor.Text = StringsHelper.Format(0, VGDecimales)
        Maskpropios.Text = VGDecimales
        Maskpropios.Text = StringsHelper.Format(0, VGDecimales)
        MaskObancos.Text = VGDecimales
        MaskObancos.Text = StringsHelper.Format(0, VGDecimales)
        MaskExt.Text = VGDecimales
        MaskExt.Text = StringsHelper.Format(0, VGDecimales)
    End Sub

    Private Sub ftran496_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdPropietarios_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdPropietarios.Click
        grdPropietarios.Col = 0
        grdPropietarios.SelStartCol = 1
        grdPropietarios.SelEndCol = grdPropietarios.Cols - 1
        If grdPropietarios.Row = 0 Then
            grdPropietarios.SelStartRow = 1
            grdPropietarios.SelEndRow = 1
        Else
            grdPropietarios.SelStartRow = grdPropietarios.Row
            grdPropietarios.SelEndRow = grdPropietarios.Row
        End If
    End Sub

    Private Sub grdPropietarios_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdPropietarios.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500934))
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500194))
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
    End Sub

    Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        Try
            If mskCuenta.ClipText <> "" Then
                If FMChequeaCtaCte(mskCuenta.ClipText) Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "16")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, FMLoadResString(2237) & mskCuenta.Text & "]") Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(0))
                        PMChequea(sqlconn)
                        cmdBoton(3).Enabled = True
                        PMLimpiaGrid(grdPropietarios)
                    Else
                        PMChequea(sqlconn)
                        mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                        lblDescripcion(0).Text = ""
                        cmdBoton(3).Enabled = False
                        PMLimpiaGrid(grdPropietarios)
                        mskCuenta.Focus()
                        Exit Sub
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(500020), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                    lblDescripcion(0).Text = ""
                    PMLimpiaGrid(grdPropietarios)
                    cmdBoton(3).Enabled = False
                    mskCuenta.Focus()
                    Exit Sub
                End If
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
        End Try
    End Sub

    Private Sub mskValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskValor.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501351))
        mskValor.MaxLength = 14
        mskValor.SelectionStart = 0
        mskValor.SelectionLength = Strings.Len(mskValor.Text)
    End Sub

    Private Sub mskValor_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskValor.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If VGDecimales = "#,##0" Then
            If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                KeyAscii = 0
            End If
        Else
            If (KeyAscii <> 8) And (KeyAscii <> 46) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                KeyAscii = 0
            End If
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub Maskpropios_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles Maskpropios.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501352))
        Maskpropios.MaxLength = 14
        Maskpropios.SelectionStart = 0
        Maskpropios.SelectionLength = Strings.Len(Maskpropios.Text)
    End Sub

    Private Sub Maskpropios_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles Maskpropios.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If VGDecimales = "#,##0" Then
            If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                KeyAscii = 0
            End If
        Else
            If (KeyAscii <> 8) And (KeyAscii <> 46) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                KeyAscii = 0
            End If
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub MaskObancos_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MaskObancos.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501353))
        MaskObancos.MaxLength = 14
        MaskObancos.SelectionStart = 0
        MaskObancos.SelectionLength = Strings.Len(MaskObancos.Text)
    End Sub

    Private Sub MaskObancos_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles MaskObancos.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If VGDecimales = "#,##0" Then
            If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                KeyAscii = 0
            End If
        Else
            If (KeyAscii <> 8) And (KeyAscii <> 46) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                KeyAscii = 0
            End If
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub MaskExt_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MaskExt.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501354))
        MaskExt.MaxLength = 14
        MaskExt.SelectionStart = 0
        MaskExt.SelectionLength = Strings.Len(MaskExt.Text)
    End Sub

    Private Sub MaskExt_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles MaskExt.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If VGDecimales = "#,##0" Then
            If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                KeyAscii = 0
            End If
        Else
            If (KeyAscii <> 8) And (KeyAscii <> 46) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                KeyAscii = 0
            End If
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Enter, _txtCampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                txtCampo(0).MaxLength = 8
            Case 1
                txtCampo(1).MaxLength = 25
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_1.KeyPress, _txtCampo_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                    KeyAscii = 0
                End If
            Case 1
                KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
    End Sub
End Class


