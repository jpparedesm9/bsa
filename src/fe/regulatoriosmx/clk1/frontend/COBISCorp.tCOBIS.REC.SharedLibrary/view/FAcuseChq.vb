Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Partial Public Class FAcuseChqClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLPas As Boolean = False

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_1.Click, _cmdBoton_0.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        TSBotones.Focus()
        Select Case Index
            Case 0
                PLTransmitir()
            Case 1
                Me.Close()
        End Select
    End Sub

    Private Sub cmdBoton_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_1.Enter, _cmdBoton_0.Enter
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500047))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500253))
        End Select
    End Sub

    Sub PLTransmitir()
        If FLChequea() Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "601")
            PMPasoValores(sqlconn, "@i_secuen", 0, SQLINT4, txtCarta.Text)
            PMPasoValores(sqlconn, "@i_ctadep", 0, SQLVARCHAR, mskCuenta.ClipText)
            PMPasoValores(sqlconn, "@i_ctagir", 0, SQLVARCHAR, txtCtaGirada.Text)
            PMPasoValores(sqlconn, "@i_bloq", 0, SQLVARCHAR, "A")
            PMPasoValores(sqlconn, "@i_chq", 0, SQLINT4, txtCheque.Text)
            PMPasoValores(sqlconn, "@i_chq_sec", 0, SQLINT4, txtRemesa.Text)
            PMPasoValores(sqlconn, "@i_val", 0, SQLMONEY, mskValor.Text)
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_novedad_remesas", True, FMLoadResString(509020)) Then
                PMChequea(sqlconn)
                PLLimpiar()
            Else
                PMChequea(sqlconn)
            End If
        End If
    End Sub

    Function FLChequea() As Integer
        Dim result As Integer = 0
        result = False
        If txtCarta.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(509021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCarta.Focus()
            Return result
        End If
        If txtRemesa.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(509022), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtRemesa.Focus()
            Return result
        End If
        If mskCuenta.ClipText.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(509024), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskCuenta.Focus()
            Return result
        End If
        If txtCtaGirada.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(509025), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCtaGirada.Focus()
            Return result
        End If
        If txtCheque.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(509023), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCheque.Focus()
            Return result
        End If
        If mskValor.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(509026), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskValor.Focus()
            Return result
        End If
        Return True
    End Function

    Sub PLLimpiar()
        txtCarta.Text = ""
        txtRemesa.Text = ""
        mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
        txtCtaGirada.Text = ""
        txtCheque.Text = ""
        mskValor.Text = VGDecimales
        mskValor.Text = StringsHelper.Format(0, VGDecimales)
        txtCarta.Focus()
    End Sub
    Private Sub PLInicializar()
        mskCuenta.Mask = VGMascaraCtaCte
        mskValor.Text = VGDecimales
        mskValor.Text = StringsHelper.Format(0, VGDecimales)
    End Sub

    Private Sub PLTSEstado()
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBCancelar.Enabled = _cmdBoton_1.Enabled
        TSBCancelar.Visible = _cmdBoton_1.Visible
    End Sub

    Private Sub FAcuseChq_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        MyAppGlobals.AppActiveForm = MyBase.Name
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2515))
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
    End Sub

    Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        If mskCuenta.ClipText.Trim() <> "" Then
            If Not FMChequeaCtaCte(mskCuenta.ClipText) Then
                COBISMessageBox.Show(FMLoadResString(500020), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                mskCuenta.Focus()
            End If
        End If
    End Sub

    Private Sub mskValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskValor.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501051))
        mskValor.SelectionStart = 0
        mskValor.SelectionLength = Strings.Len(mskValor.Text)
    End Sub

    Private Sub txtCarta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCarta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2514))
        txtCarta.SelectionStart = 0
        txtCarta.SelectionLength = Strings.Len(txtCarta.Text)
    End Sub

    Private Sub txtCarta_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtCarta.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(EventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            EventArgs.Handled = True
        End If
        EventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCarta_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles txtCarta.MouseDown

    End Sub

    Private Sub txtCheque_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtCheque.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCheque_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles txtCheque.MouseDown

    End Sub

    Private Sub txtCtaGirada_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCtaGirada.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2517))
        txtCtaGirada.SelectionStart = 0
        txtCtaGirada.SelectionLength = Strings.Len(txtCtaGirada.Text)
    End Sub

    Private Sub txtCheque_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCheque.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501434))
        txtCheque.SelectionStart = 0
        txtCheque.SelectionLength = Strings.Len(txtCheque.Text)
    End Sub

    Private Sub txtCtaGirada_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtCtaGirada.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub


    Private Sub txtCtaGirada_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles txtCtaGirada.MouseDown
    End Sub

    Private Sub txtRemesa_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtRemesa.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2515))
        txtRemesa.SelectionStart = 0
        txtRemesa.SelectionLength = Strings.Len(txtRemesa.Text)
    End Sub

    Private Sub txtRemesa_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtRemesa.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtRemesa_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles txtRemesa.MouseDown

    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBCancelar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCancelar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
    End Sub
End Class


