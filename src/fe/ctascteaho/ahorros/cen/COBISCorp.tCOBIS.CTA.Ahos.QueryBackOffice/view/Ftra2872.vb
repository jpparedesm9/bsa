Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary

Partial Public Class Ftran2872Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLPaso As Integer = 0

    Private Sub Ftran2872_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = System.String.Empty
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Public Sub PLInicializar()
        txtCampo(0).Text = ""
        lblDescripcion(0).Text = ""
        cmdBoton(1).Enabled = False
        cmdBoton_Click(cmdBoton(5), New EventArgs())
    End Sub

    Private Sub Ftran2872_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(System.String.Empty)
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                VLPaso = False
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500454)) 'Código de Funcionario [F5 Ayuda]
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_0.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    FGFuncionarios.ShowPopup(Me)
                    If VGBusqueda(1) <> System.String.Empty Then
                        txtCampo(Index).Text = VGBusqueda(1)
                        lblDescripcion(0).Text = VGBusqueda(2)
                        cmdBoton(0).Enabled = True
                        PLTSEstado()
                        VLPaso = True
                    End If
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_5.Click, _cmdBoton_2.Click, _cmdBoton_0.Click, _cmdBoton_1.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                PLTransmitir()
            Case 1
                PLEliminar()
            Case 4
                PLLimpiar()
            Case 2
                Me.Close()
            Case 5
                PLBuscar()
        End Select
    End Sub

    Private Sub PLTransmitir()
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502198), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "412")
        PMPasoValores(sqlconn, "@i_autorizante", 0, SQLINT2, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_ejecutor", 0, SQLINT2, "0")
        PMPasoValores(sqlconn, "@i_tipo_f", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_mant_fun_aut", True, FMLoadResString(508843)) Then
            PMChequea(sqlconn)
            PLLimpiar()
            PLBuscar()
        Else
            PMChequea(sqlconn)
            PLLimpiar()
            PLBuscar()
        End If
    End Sub

    Private Sub PLLimpiar()
        txtCampo(0).Enabled = True
        txtCampo(0).Text = ""
        lblDescripcion(0).Text = ""
        PMLimpiaGrid(grdAutorizantes)
        cmdBoton(1).Enabled = False
        cmdBoton(0).Enabled = False
        VLPaso = True
        If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).Focus()
        PLBuscar()
        PLTSEstado()
    End Sub

    Private Sub PLBuscar()
        Dim VTRegistros As Integer = 0
        Dim VTFlag As Integer = 0
        Dim VTSecuencial As Integer = 0
        PMLimpiaGrid(grdAutorizantes)
        If txtCampo(0).Text = "" Then
            VTRegistros = 20
            VTFlag = False
            VTSecuencial = -1
            While VTRegistros = 20
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "411")
                PMPasoValores(sqlconn, "@i_autorizante", 0, SQLINT2, CStr(VTSecuencial))
                PMPasoValores(sqlconn, "@i_ejecutor", 0, SQLINT2, "0")
                PMPasoValores(sqlconn, "@i_tipo_f", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_mant_fun_aut", True, FMLoadResString(508837)) Then
                    PMMapeaGrid(sqlconn, grdAutorizantes, VTFlag)
                    PMChequea(sqlconn)
                    VTFlag = True
                    VTRegistros = Conversion.Val(Convert.ToString(grdAutorizantes.Tag))
                    If grdAutorizantes.Tag <> 0 Then
                        grdAutorizantes.Row = grdAutorizantes.Rows - 1
                        grdAutorizantes.Col = 1
                        VTSecuencial = CInt(grdAutorizantes.CtlText)
                    End If
                Else
                    PMChequea(sqlconn)
                    VTRegistros = 0
                End If
            End While
            If grdAutorizantes.Rows <= 2 Then
                grdAutorizantes.Row = 1
                grdAutorizantes.Col = 1
                If grdAutorizantes.CtlText.Trim() = "" Then
                    cmdBoton(1).Enabled = False
                    cmdBoton(0).Enabled = True
                Else
                    grdAutorizantes.ColWidth(1) = 1000
                    grdAutorizantes.ColWidth(2) = 4500
                    cmdBoton(0).Enabled = False
                End If
            End If
        Else
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "411")
            PMPasoValores(sqlconn, "@i_autorizante", 0, SQLINT2, txtCampo(0).Text)
            PMPasoValores(sqlconn, "@i_ejecutor", 0, SQLINT2, "0")
            PMPasoValores(sqlconn, "@i_tipo_f", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
            cmdBoton(0).Enabled = False
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_mant_fun_aut", True, FMLoadResString(508836)) Then
                PMMapeaGrid(sqlconn, grdAutorizantes, False)
                PMChequea(sqlconn)
                If grdAutorizantes.Rows <= 2 Then
                    grdAutorizantes.Row = 1
                    grdAutorizantes.Col = 1
                    If grdAutorizantes.CtlText.Trim() = "" Then
                        cmdBoton(1).Enabled = False
                    End If
                End If
            Else
                PMChequea(sqlconn)
                cmdBoton(1).Enabled = False
            End If
            If lblDescripcion(0).Text <> "" Then
                cmdBoton(0).Enabled = True
            End If
        End If
        PLTSEstado()
    End Sub

    Private Sub PLEliminar()
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502198), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "413")
        PMPasoValores(sqlconn, "@i_autorizante", 0, SQLINT2, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_ejecutor", 0, SQLINT2, "0")
        PMPasoValores(sqlconn, "@i_tipo_f", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_mant_fun_aut", True, FMLoadResString(508848)) Then
            PMChequea(sqlconn)
            PLLimpiar()
            PLBuscar()
        Else
            PMChequea(sqlconn)
            PLLimpiar()
            PLBuscar()
        End If
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If Not VLPaso And txtCampo(Index).Text <> System.String.Empty Then
                    txtCampo(Index).Text = txtCampo(Index).Text.Trim()
                    If Conversion.Val(txtCampo(Index).Text) > 32000 Then
                        COBISMessageBox.Show(FMLoadResString(500460), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        lblDescripcion(Index).Text = ""
                        txtCampo(Index).Focus()
                        Exit Sub
                    End If
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                    PMPasoValores(sqlconn, "@i_funcionario", 0, SQLINT4, txtCampo(Index).Text)
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1577")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_funcionario", True, FMLoadResString(508810)) Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(Index))
                        cmdBoton(0).Enabled = True
                        PMChequea(sqlconn)
                        VLPaso = True
                    Else
                        txtCampo(Index).Text = System.String.Empty
                        lblDescripcion(Index).Text = System.String.Empty
                        If txtCampo(Index).Enabled And txtCampo(Index).Visible Then txtCampo(Index).Focus()
                        cmdBoton(0).Enabled = False
                        VLPaso = True
                        PMChequea(sqlconn)
                        PLBuscar()
                    End If
                End If
        End Select
        PLTSEstado()
    End Sub

    Private Sub grdAutorizantes_ClickEvent(sender As Object, e As EventArgs) Handles grdAutorizantes.ClickEvent
        PMMarcaFilaCobisGrid(grdAutorizantes, grdAutorizantes.Row)
    End Sub

    Private Sub grdAutorizantes_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdAutorizantes.DblClick
        PMMarcaFilaCobisGrid(grdAutorizantes, grdAutorizantes.Row)
        If grdAutorizantes.Rows <= 2 Then
            grdAutorizantes.Row = 1
            grdAutorizantes.Col = 1
            If grdAutorizantes.CtlText.Trim() = System.String.Empty Then
                COBISMessageBox.Show(FMLoadResString(502199), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        End If
        grdAutorizantes.Col = 1
        txtCampo(0).Text = grdAutorizantes.CtlText
        grdAutorizantes.Col = 2
        lblDescripcion(0).Text = grdAutorizantes.CtlText
        cmdBoton(0).Enabled = False
        cmdBoton(1).Enabled = True
        txtCampo(0).Enabled = False
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_5.Enabled
        TSBBuscar.Visible = _cmdBoton_5.Visible
        TSBEliminar.Enabled = _cmdBoton_1.Enabled
        TSBEliminar.Visible = _cmdBoton_1.Visible
        TSBLimpiar.Enabled = _cmdBoton_4.Enabled
        TSBLimpiar.Visible = _cmdBoton_4.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub grdAutorizantes_Enter(sender As Object, e As EventArgs) Handles grdAutorizantes.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5220))
    End Sub

    Private Sub grdAutorizantes_Leave(sender As Object, e As EventArgs) Handles grdAutorizantes.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

End Class


