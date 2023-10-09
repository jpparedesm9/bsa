Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary

Partial Public Class FCausaLevClass

    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLPaso As Integer = 0

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_1.Click, _cmdBoton_0.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(500169), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(500170), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                VGNControl = txtCampo(0).Text
                VGNSolicit = txtCampo(1).Text
                VGNCausa = lblDescripcion.Text
                Me.Close()
            Case 1
                VGNControl = "*"
                VGNSolicit = "*"
                Me.Close()
        End Select
    End Sub

    Private Sub PLInicializar()        
        txtCampo(1).MaxLength = 45
    End Sub

    Private Sub FCausaLev_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBCancelar.Enabled = _cmdBoton_1.Enabled
        TSBCancelar.Visible = _cmdBoton_1.Visible()
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.TextChanged, _txtCampo_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Enter, _txtCampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500171))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500172))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_1.KeyDown, _txtCampo_0.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTTabla As String = ""
        If Keycode = VGTeclaAyuda And Index = 0 Then
            If lblProducto.Text = "CTE" Then
                VTTabla = "cc_caulev_blqva"
            Else
                VTTabla = "ah_caulev_blqva"
            End If
            VLPaso = True
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VTTabla)
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            FMLoadResString(501337)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, " Consulta de la filial " & "[" & txtCampo(0).Text & "]") Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.ShowPopup()

                txtCampo(0).Text = VGACatalogo.Codigo
                lblDescripcion.Text = VGACatalogo.Descripcion
                txtCampo(1).Focus()
            Else
                PMChequea(sqlconn) 'JSA
            End If
            FCatalogo.Dispose()
        End If
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

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Leave, _txtCampo_0.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTTabla As String = ""
        If Not VLPaso And Index = 0 Then
            If txtCampo(0).Text <> "" Then
                If lblProducto.Text = "CTE" Then
                    VTTabla = "cc_caulev_blqva"
                Else
                    VTTabla = "ah_caulev_blqva"
                End If
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VTTabla)
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtCampo(0).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(2546) & " " & "[" & txtCampo(0).Text & "]") Then
                    PMMapeaObjeto(sqlconn, lblDescripcion)
                    PMChequea(sqlconn)
                Else
                    VLPaso = True
                    txtCampo(0).Text = ""
                    lblDescripcion.Text = ""
                    txtCampo(0).Focus()
                    PMChequea(sqlconn) 'JSA
                End If
            Else
                lblDescripcion.Text = ""
            End If
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2220))
    End Sub

    Private Sub TSBTRANSMITIR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBCANCELAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCancelar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        'If Not (Artinsoft.VB6.Gui.ActivateHelper.myActiveForm Is eventSender) Then
        '	Artinsoft.VB6.Gui.ActivateHelper.myActiveForm = eventSender
        'End If
    End Sub
End Class


