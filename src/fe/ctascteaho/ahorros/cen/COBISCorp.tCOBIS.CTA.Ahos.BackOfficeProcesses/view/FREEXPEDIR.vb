Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FREEXPEDIRClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


    Private Sub cmdOk_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdOk.Click
        If txtTarjetaDebito.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(508721), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtTarjetaDebito.Text = ""
            txtTarjetaDebito.Focus()
        Else
            If txtTarjetaDebito.Text.Trim() <> txtConfirmaTarjDeb.Text.Trim() Then
                COBISMessageBox.Show(FMLoadResString(508466), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtConfirmaTarjDeb.Text = ""
                txtConfirmaTarjDeb.Focus()
            Else
                Me.Dispose()
                FRelCtaCanal.TxtNuevaTarjeta.Text = txtTarjetaDebito.Text
                FRelCtaCanal.Show(Me)
            End If
        End If
    End Sub

    Private Sub cmdSalir_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSalir.Click
        Me.Dispose()
        Exit Sub
    End Sub

    Private Sub FREEXPEDIR_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
    End Sub

    Public Sub PLInicializar()
        txtTarjetaDebito.Text = ""
        txtConfirmaTarjDeb.Text = ""
        PLTSEstado()
    End Sub

    Private Sub txtConfirmaTarjDeb_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtConfirmaTarjDeb.Enter
        My.Computer.Clipboard.Clear()
        My.Computer.Clipboard.SetText("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2221))
    End Sub

    Private Sub txtConfirmaTarjDeb_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtConfirmaTarjDeb.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Shift As Integer = eventArgs.KeyData \ &H10000
        BorrarClipboard(KeyCode, Shift, 0, False)
    End Sub

    Private Sub txtConfirmaTarjDeb_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtConfirmaTarjDeb.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtConfirmaTarjDeb_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtConfirmaTarjDeb.Leave
        If txtConfirmaTarjDeb.Text <> "" Then
            If txtTarjetaDebito.Text.Trim() <> txtConfirmaTarjDeb.Text.Trim() Then
                COBISMessageBox.Show(FMLoadResString(508466), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtConfirmaTarjDeb.Text = ""
                txtConfirmaTarjDeb.Focus()
            End If
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub txtConfirmaTarjDeb_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles txtConfirmaTarjDeb.MouseDown
        Dim Button As Integer = CInt(eventArgs.Button)        
        BorrarClipboard(0, 0, Button, True)
    End Sub

    Private Sub txtTarjetaDebito_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtTarjetaDebito.Enter
        My.Computer.Clipboard.Clear()
        My.Computer.Clipboard.SetText("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2222))
    End Sub

    Private Sub txtTarjetaDebito_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtTarjetaDebito.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Shift As Integer = eventArgs.KeyData \ &H10000
        BorrarClipboard(KeyCode, Shift, 0, False)
    End Sub

    Private Sub txtTarjetaDebito_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtTarjetaDebito.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtTarjetaDebito_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtTarjetaDebito.Leave
        If txtTarjetaDebito.Text <> "" And txtTarjetaDebito.Text <> "" Then
            If Strings.Len(txtTarjetaDebito.Text) < 16 Or Strings.Len(txtTarjetaDebito.Text) > 19 Then
                COBISMessageBox.Show(FMLoadResString(508628), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtTarjetaDebito.Text = ""
                txtConfirmaTarjDeb.Text = ""
                txtTarjetaDebito.Focus()
            End If
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub txtTarjetaDebito_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles txtTarjetaDebito.MouseDown
        Dim Button As Integer = CInt(eventArgs.Button)        
        BorrarClipboard(0, 0, Button, True)
    End Sub

    Sub BorrarClipboard(ByRef CodTecla As COBISCorp.Framework.UI.Components.COBISTools.KeyCodeConstants, ByRef CtrlAltShift As Integer, ByRef BotonMouse As Integer, ByRef ClickMouse As Boolean)
        If Not ClickMouse Then
            If CodTecla = Keys.Insert And CtrlAltShift = 1 Then
                My.Computer.Clipboard.Clear()
            ElseIf CodTecla = Keys.V And CtrlAltShift = 2 Then
                My.Computer.Clipboard.Clear()
            End If
        Else
            If BotonMouse = 2 Then My.Computer.Clipboard.Clear()
        End If
    End Sub
    Private Sub PLTSEstado()
        TSBOk.Enabled = cmdOk.Enabled
        TSBOk.Visible = cmdOk.Visible
        TSBSalir.Visible = cmdSalir.Visible
        TSBSalir.Enabled = cmdSalir.Enabled
    End Sub

    Private Sub TSBOk_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBOk.Click
        If cmdOk.Enabled Then cmdOk_Click(cmdOk, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If cmdSalir.Enabled Then cmdSalir_Click(cmdSalir, e)
    End Sub

End Class


