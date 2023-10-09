Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Partial Public Class FHelpCtaClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLCtaBco As String = ""
    Dim VLNombre1 As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_0.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                PLEscoger()
            Case 1
                PLSiguientes()
            Case 2
                PLBuscar()
            Case 3
                Me.Close()
            Case 4
                PLLimpiar()
        End Select
    End Sub

    Private Sub PLInicializar()
      
        cmdBoton(2).Enabled = True
    End Sub

    Private Sub FHelpCta_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub grdCuentas_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdCuentas.Click
        grdCuentas.Col = 0
        grdCuentas.SelStartCol = 1
        grdCuentas.SelEndCol = grdCuentas.Cols - 1
        If grdCuentas.Row = 0 Then
            grdCuentas.SelStartRow = 1
            grdCuentas.SelEndRow = 1
        Else
            grdCuentas.SelStartRow = grdCuentas.Row
            grdCuentas.SelEndRow = grdCuentas.Row
        End If
    End Sub

    Private Sub grdCuentas_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdCuentas.DblClick
        PLEscoger()
    End Sub

    Private Sub PLLimpiar()
        PMLimpiaGrid(grdCuentas)
        grdCuentas.ColWidth(1) = 650
        cmdBoton(0).Enabled = False
        cmdBoton(1).Enabled = False
        txtcampo.Enabled = True
        txtcampo.Text = ""
        txtcampo.Focus()
        PLTSEstado()
    End Sub

    Private Sub PLSiguientes()
        If txtcampo.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(500164), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtcampo.Focus()
            Exit Sub
        End If
        grdCuentas.Row = grdCuentas.Rows - 1
        grdCuentas.Col = 1
        VLCtaBco = grdCuentas.CtlText
        grdCuentas.Col = 2
        VLNombre1 = grdCuentas.CtlText
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "340")
        PMPasoValores(sqlconn, "@i_nombre", 0, SQLCHAR, txtcampo.Text)
        PMPasoValores(sqlconn, "@i_nombre1", 0, SQLCHAR, VLNombre1)
        PMPasoValores(sqlconn, "@i_cta", 0, SQLCHAR, VLCtaBco)
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_helpcta_ah", True, FMLoadResString(509242)) Then
            PMMapeaGrid(sqlconn, grdCuentas, True)
            PMChequea(sqlconn)
            grdCuentas.ColAlignment(1) = 0
            grdCuentas.ColWidth(1) = 1200
            grdCuentas.ColAlignment(2) = 0
            grdCuentas.ColWidth(2) = 3400
            cmdBoton(1).Enabled = CDbl(Convert.ToString(grdCuentas.Tag)) = 20
        Else
            PMChequea(sqlconn) 'JSA
        End If
        PLTSEstado()
    End Sub

    Private Sub PLBuscar()
        If txtcampo.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(500164), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtcampo.Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "340")
        PMPasoValores(sqlconn, "@i_nombre", 0, SQLCHAR, txtcampo.Text)
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_helpcta_ah", True, FMLoadResString(509242)) Then
            PMMapeaGrid(sqlconn, grdCuentas, False)
            PMChequea(sqlconn)
            grdCuentas.ColAlignment(1) = 0
            grdCuentas.ColWidth(1) = 1200
            grdCuentas.ColAlignment(2) = 0
            grdCuentas.ColWidth(2) = 3400
            cmdBoton(0).Enabled = True
            cmdBoton(1).Enabled = CDbl(Convert.ToString(grdCuentas.Tag)) = 20
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtcampo_Leave(sender As Object, e As EventArgs) Handles txtcampo.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub txtcampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtcampo.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
    End Sub

    Private Sub txtcampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtcampo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501038))
        txtcampo.SelectionStart = 0
        txtcampo.SelectionLength = Strings.Len(txtcampo.Text)
        txtcampo.Text = txtcampo.Text.ToString()
    End Sub

    Private Sub txtcampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtcampo.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = Strings.AscW(Strings.ChrW(KeyAscii).ToString().ToUpper())
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub PLEscoger()
        grdCuentas.Col = 1
        If grdCuentas.CtlText.Trim() <> "" Then
            VGADatosO(0) = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
        End If
        Me.Close()
    End Sub

    Private Sub PLTSEstado()
        TSBEscoger.Enabled = _cmdBoton_0.Enabled
        TSBEscoger.Visible = _cmdBoton_0.Visible
        TSBSiguientes.Enabled = _cmdBoton_1.Enabled
        TSBSiguientes.Visible = _cmdBoton_1.Visible
        TSBBuscar.Enabled = _cmdBoton_2.Enabled
        TSBBuscar.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_3.Enabled
        TSBSalir.Visible = _cmdBoton_3.Visible
        TSBLimpiar.Enabled = _cmdBoton_4.Enabled
        TSBLimpiar.Visible = _cmdBoton_4.Visible
    End Sub

    Private Sub TSBEscoger_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEscoger.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub
End Class


