Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTipoCanjeClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_1.Click, _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_2.Click, _cmdBoton_4.Click, _cmdBoton_5.Click, _cmdBoton_6.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        TSBBotones.Focus()
        Select Case Index
            Case 0
                PLBuscar()
            Case 1
                PLIngresar()
            Case 2
                PLEliminar()
            Case 3
                PLLimpiar()
            Case 4
                Me.Close()
            Case 5
                PLSiguientes()
            Case 6
                PLModificar()
        End Select
    End Sub

    Private Sub FTipoCanje_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Public Sub PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub FTipoCanje_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502697))
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
        cmdBoton(5).Enabled = False
    End Sub

    Private Sub grdRegistros_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdRegistros.DblClick
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502697))
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
        grdRegistros.Col = 1
        txtCampo(0).Text = grdRegistros.CtlText
        grdRegistros.Col = 3
        If grdRegistros.CtlText = "D" Then
            Optcanje(0).Checked = True
        End If
        If grdRegistros.CtlText = "E" Then
            Optcanje(1).Checked = True
        End If
        If grdRegistros.CtlText = "C" Then
            Optcanje(2).Checked = True
        End If
        If grdRegistros.CtlText = "N" Then
            Optcanje(3).Checked = True
        End If
        If grdRegistros.CtlText = "S" Then
            Optcanje(4).Checked = True
        End If
        grdRegistros.Col = 6
        If grdRegistros.CtlText = "N" Then
            Optcomp(0).Checked = True
        ElseIf grdRegistros.CtlText = "S" Then
            Optcomp(1).Checked = True
        Else
            Optcomp(2).Checked = True
        End If
        txtCampo_Leave(txtCampo(0), New EventArgs())
        cmdBoton(1).Enabled = True
        cmdBoton(2).Enabled = True
        cmdBoton(5).Enabled = False
        cmdBoton(6).Enabled = True
        PLTSEstado()
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502500))
        End Select
    End Sub

    Private Sub _Optcanje_GotFocus(sender As Object, e As EventArgs) Handles _Optcanje_0.GotFocus, _Optcanje_1.GotFocus, _Optcanje_2.GotFocus, _Optcanje_3.GotFocus, _Optcanje_4.GotFocus
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502695))
    End Sub

    Private Sub _Optcomp_GotFocus(sender As Object, e As EventArgs) Handles _Optcomp_2.GotFocus, _Optcomp_0.GotFocus, _Optcomp_1.GotFocus
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502696))
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502697))
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_0.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Keycode <> VGTeclaAyuda Then
            Exit Sub
        End If
        Select Case Index
            Case 0
                VGOperacion = "sp_oficina"
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502503)) Then ' Consulta de la oficina 
                    PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                    PMChequea(sqlconn)
                    FCatalogo.ShowPopup(Me)
                    txtCampo(Index).Text = VGACatalogo.Codigo
                    lblDescripcion(Index).Text = VGACatalogo.Descripcion
                Else
                    PMChequea(sqlconn)
                    txtCampo(Index).Text = ""
                    txtCampo(Index).Focus()
                    lblDescripcion(Index).Text = ""
                End If
        End Select
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If KeyAscii <> 8 And ((KeyAscii < 47) Or (KeyAscii > 57)) Then
                    KeyAscii = 0
                End If
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If txtCampo(Index).Text <> "" Then
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtCampo(Index).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502503) & "[" & txtCampo(Index).Text & "]") Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(Index))
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        txtCampo(Index).Text = ""
                        txtCampo(Index).Focus()
                        lblDescripcion(Index).Text = ""
                    End If
                End If
        End Select
    End Sub

    Public Sub PLBuscar()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "672")
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, "1") ' tenia 0 y mandaba error 101016
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "S")
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "0")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_oficina_tipo_canje", True, FMLoadResString(502658)) Then 'Consulta tipo de canje
            PMMapeaGrid(sqlconn, grdRegistros, False)
            PMMapeaTextoGrid(grdRegistros)
            PMAnchoColumnasGrid(grdRegistros)
            PMChequea(sqlconn)
            cmdBoton(5).Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) >= 20
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
    End Sub

    Public Sub PLIngresar()
        If txtCampo(0).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(502659), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "672")
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "I")
        If Optcanje(0).Checked Then
            PMPasoValores(sqlconn, "@i_tipo_canje", 0, SQLVARCHAR, "D")
            PMPasoValores(sqlconn, "@i_descripcion", 0, SQLVARCHAR, Optcanje(0).Text)
        End If
        If Optcanje(1).Checked Then
            PMPasoValores(sqlconn, "@i_tipo_canje", 0, SQLVARCHAR, "E")
            PMPasoValores(sqlconn, "@i_descripcion", 0, SQLVARCHAR, Optcanje(1).Text)
        End If
        If Optcanje(2).Checked Then
            PMPasoValores(sqlconn, "@i_tipo_canje", 0, SQLVARCHAR, "C")
            PMPasoValores(sqlconn, "@i_descripcion", 0, SQLVARCHAR, Optcanje(2).Text)
        End If
        If Optcanje(3).Checked Then
            PMPasoValores(sqlconn, "@i_tipo_canje", 0, SQLVARCHAR, "N")
            PMPasoValores(sqlconn, "@i_descripcion", 0, SQLVARCHAR, Optcanje(3).Text)
        End If
        If Optcanje(4).Checked Then
            PMPasoValores(sqlconn, "@i_tipo_canje", 0, SQLVARCHAR, "S")
            PMPasoValores(sqlconn, "@i_descripcion", 0, SQLVARCHAR, Optcanje(4).Text)
        End If
        If Optcomp(0).Checked Then
            PMPasoValores(sqlconn, "@i_competencia", 0, SQLCHAR, "N")
        ElseIf Optcomp(1).Checked Then
            PMPasoValores(sqlconn, "@i_competencia", 0, SQLCHAR, "S")
        Else
            PMPasoValores(sqlconn, "@i_competencia", 0, SQLCHAR, "B")
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_oficina_tipo_canje", True, FMLoadResString(503008)) Then
            PMChequea(sqlconn)
            PLLimpiar()
        Else
            PMChequea(sqlconn)
            txtCampo(0).Focus()
        End If
        PLBuscar()
    End Sub

    Public Sub PLEliminar()
        If txtCampo(0).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(503009), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "672")
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, "1") 'tenia txtCampo(0).Text y emite error 101016
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "D")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_oficina_tipo_canje", True, FMLoadResString(503008)) Then
            PMChequea(sqlconn)
            PLLimpiar()
        Else
            PMChequea(sqlconn)
            txtCampo(0).Focus()
        End If
        PLBuscar()
    End Sub

    Public Sub PLLimpiar()
        txtCampo(0).Text = ""
        lblDescripcion(0).Text = ""
        grdRegistros.Rows = 2
        For i As Integer = 0 To grdRegistros.Cols - 1
            grdRegistros.Col = i
            For j As Integer = 0 To 1
                grdRegistros.Row = j
                grdRegistros.CtlText = ""
            Next j
        Next i
        PMLimpiaG(grdRegistros)
        cmdBoton(1).Enabled = True
        cmdBoton(2).Enabled = False
        cmdBoton(5).Enabled = False
        cmdBoton(6).Enabled = False
        Optcanje(0).Checked = True
        Optcanje(1).Checked = False
        Optcanje(2).Checked = False
        Optcanje(3).Checked = False
        Optcanje(4).Checked = False
        PLTSEstado()
    End Sub

    Public Sub PLSiguientes()
        grdRegistros.Row = grdRegistros.Rows - 1
        grdRegistros.Col -= 5
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "672")
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, grdRegistros.CtlText)
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "1")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "S")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_oficina_tipo_canje", True, FMLoadResString(503008)) Then
            PMMapeaGrid(sqlconn, grdRegistros, True)
            PMMapeaTextoGrid(grdRegistros)
            PMAnchoColumnasGrid(grdRegistros)
            PMChequea(sqlconn)
            cmdBoton(5).Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) >= 20
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
    End Sub

    Public Sub PLModificar()
        If txtCampo(0).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(503009), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "672")
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtCampo(0).Text)
        If Optcanje(0).Checked Then
            PMPasoValores(sqlconn, "@i_tipo_canje", 0, SQLVARCHAR, "D")
            PMPasoValores(sqlconn, "@i_descripcion", 0, SQLVARCHAR, Optcanje(0).Text)
        End If
        If Optcanje(1).Checked Then
            PMPasoValores(sqlconn, "@i_tipo_canje", 0, SQLVARCHAR, "E")
            PMPasoValores(sqlconn, "@i_descripcion", 0, SQLVARCHAR, Optcanje(1).Text)
        End If
        If Optcanje(2).Checked Then
            PMPasoValores(sqlconn, "@i_tipo_canje", 0, SQLVARCHAR, "C")
            PMPasoValores(sqlconn, "@i_descripcion", 0, SQLVARCHAR, Optcanje(2).Text)
        End If
        If Optcanje(3).Checked Then
            PMPasoValores(sqlconn, "@i_tipo_canje", 0, SQLVARCHAR, "N")
            PMPasoValores(sqlconn, "@i_descripcion", 0, SQLVARCHAR, Optcanje(3).Text)
        End If
        If Optcanje(4).Checked Then
            PMPasoValores(sqlconn, "@i_tipo_canje", 0, SQLVARCHAR, "S")
            PMPasoValores(sqlconn, "@i_descripcion", 0, SQLVARCHAR, Optcanje(4).Text)
        End If
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "U")
        If Optcomp(0).Checked Then
            PMPasoValores(sqlconn, "@i_competencia", 0, SQLCHAR, "N")
        ElseIf Optcomp(1).Checked Then
            PMPasoValores(sqlconn, "@i_competencia", 0, SQLCHAR, "S")
        Else
            PMPasoValores(sqlconn, "@i_competencia", 0, SQLCHAR, "B")
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_oficina_tipo_canje", True, FMLoadResString(502658)) Then
            PMChequea(sqlconn)
            PLLimpiar()
        Else
            PMChequea(sqlconn)
            txtCampo(0).Focus()
        End If
        PLBuscar()
    End Sub
    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBSiguientes.Enabled = _cmdBoton_5.Enabled
        TSBSiguientes.Visible = _cmdBoton_5.Visible
        TSBIngresar.Enabled = _cmdBoton_1.Enabled
        TSBIngresar.Enabled = _cmdBoton_1.Enabled
        TSBEliminar.Enabled = _cmdBoton_2.Enabled
        TSBEliminar.Enabled = _cmdBoton_2.Enabled
        TSBModificar.Enabled = _cmdBoton_6.Enabled
        TSBModificar.Enabled = _cmdBoton_6.Enabled
        TSBLimpiar.Visible = _cmdBoton_3.Visible
        TSBLimpiar.Enabled = _cmdBoton_3.Enabled
        TSBSalir.Visible = _cmdBoton_4.Visible
        TSBSalir.Enabled = _cmdBoton_4.Enabled
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBIngresar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBIngresar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBModificar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBModificar.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

End Class


