Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran2564Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


    Dim VLPaso As Integer = 0

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_1.Click, _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_2.Click, _cmdBoton_4.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
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
        End Select
    End Sub

    Private Sub FTran2564_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load

        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub
    Private Sub PLInicializar()
        MyAppGlobals.AppActiveForm = ""
        txtCampo(0).Focus()

    End Sub

    Private Sub grdRegistros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.ClickEvent
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
        grdRegistros.Col = 1
        txtCampo(0).Text = grdRegistros.CtlText
        grdRegistros.Col = 2
        lblDescripcion(0).Text = grdRegistros.CtlText
        grdRegistros.Col = 3
        txtCampo(1).Text = grdRegistros.CtlText
        grdRegistros.Col = 4
        lblDescripcion(1).Text = grdRegistros.CtlText
        txtCampo(0).Focus()
        'habilita boton eliminar
        If grdRegistros.Row > 0 Then
            cmdBoton(0).Enabled = True
        End If
        PLTSEstado()
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.TextChanged, _txtCampo_1.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = False
        lblDescripcion(Index).Text = ""
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Enter, _txtCampo_1.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509164))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509165))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_0.KeyDown, _txtCampo_1.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Shift As Integer = eventArgs.KeyData \ &H10000
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Keycode <> VGTeclaAyuda Then
            Exit Sub
        End If
        Select Case Index
            Case 0
                VLPaso = True
                VGOperacion = ""
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "cc_plazas_bco_rep")
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de Plazas Banco República") Then
                    PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                    PMChequea(sqlconn)
                    FCatalogo.ShowPopup(Me)
                    txtCampo(0).Text = VGACatalogo.Codigo
                    lblDescripcion(0).Text = VGACatalogo.Descripcion
                    FCatalogo.Dispose()
                Else
                    PMChequea(sqlconn)
                    txtCampo(Index).Text = ""
                    txtCampo(Index).Focus()
                    lblDescripcion(Index).Text = ""
                End If
            Case 1
                VGOperacion = "sp_oficina"
                VLPaso = True
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina ") Then
                    PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                    PMChequea(sqlconn)
                    FCatalogo.ShowPopup(Me)
                    txtCampo(Index).Text = VGACatalogo.Codigo
                    lblDescripcion(Index).Text = VGACatalogo.Descripcion
                    FCatalogo.Dispose()
                Else
                    PMChequea(sqlconn)
                    txtCampo(Index).Text = ""
                    txtCampo(Index).Focus()
                    lblDescripcion(Index).Text = ""
                End If
        End Select
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_0.KeyPress, _txtCampo_1.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Leave, _txtCampo_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If VLPaso Or txtCampo(Index).Text = "" Then
            Exit Sub
        End If
        Select Case Index
            Case 0
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cc_plazas_bco_rep")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCampo(Index).Text)
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, " Ok... Consulta del parámetro " & "[" & txtCampo(Index).Text & "]") Then
                    VLPaso = True
                    PMMapeaObjeto(sqlconn, lblDescripcion(Index))
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtCampo(Index).Text = ""
                    txtCampo(Index).Focus()
                    lblDescripcion(Index).Text = ""
                End If
            Case 1
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtCampo(Index).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(Index).Text & "]") Then
                    VLPaso = True
                    PMMapeaObjeto(sqlconn, lblDescripcion(Index))
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtCampo(Index).Text = ""
                    txtCampo(Index).Focus()
                    lblDescripcion(Index).Text = ""
                End If
        End Select
    End Sub

    Public Sub PLIngresar()
        If txtCampo(0).Text.Trim() = "" Then
            COBISMessageBox.Show("El campo Plaza es mandatorio.", My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If txtCampo(1).Text.Trim() = "" Then
            COBISMessageBox.Show("El campo Oficina es mandatorio.", My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(1).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2564")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "I")
        PMPasoValores(sqlconn, "@i_plaza", 0, SQLINT2, txtCampo(0).Text.Trim())
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtCampo(1).Text.Trim())
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_plazas_bco_rep", True, " Ok... Ingreso Relación Plaza-Oficina") Then
            PMChequea(sqlconn)
            PLLimpiar()
            PLBuscar()
        Else
            PMChequea(sqlconn)
            txtCampo(0).Focus()
        End If
    End Sub

    Public Sub PLLimpiar()
        txtCampo(0).Text = ""
        txtCampo(1).Text = ""
        lblDescripcion(0).Text = ""
        lblDescripcion(1).Text = ""
        cmdBoton(2).Enabled = False
        TSBEliminar.Enabled = False
        PMLimpiaG(grdRegistros)
        txtCampo(0).Focus()
    End Sub

    Public Sub PLBuscar()
        Dim VTFilas As Integer = 56
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2564")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "S")
        If txtCampo(0).Text = "" Then
            PMPasoValores(sqlconn, "@i_plaza", 0, SQLINT2, "0")
        Else
            PMPasoValores(sqlconn, "@i_plaza", 0, SQLINT2, txtCampo(0).Text.Trim())
        End If
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, "0")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_plazas_bco_rep", True, " Ok... Consulta Plazas Bco. República") Then
            PMMapeaGrid(sqlconn, grdRegistros, False)
            PMChequea(sqlconn)
            If Conversion.Val(Convert.ToString(grdRegistros.Tag)) > 0 Then
                cmdBoton(2).Enabled = True
            End If
            While Conversion.Val(Convert.ToString(grdRegistros.Tag)) > 0 And (Conversion.Val(Convert.ToString(grdRegistros.Tag)) Mod VTFilas) = 0
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2564")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "S")
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                PMPasoValores(sqlconn, "@i_plaza", 0, SQLINT2, grdRegistros.CtlText.Trim())
                grdRegistros.Col = 3
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, grdRegistros.CtlText.Trim())
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_plazas_bco_rep", True, " Ok... Consulta Plazas Bco. República") Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    Exit Sub
                End If
            End While
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Public Sub PLEliminar()
        If txtCampo(0).Text.Trim() = "" Or lblDescripcion(0).Text.Trim() = "" Then
            COBISMessageBox.Show("El campo Plaza es mandatorio.", My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If txtCampo(1).Text.Trim() = "" Or lblDescripcion(1).Text.Trim() = "" Then
            COBISMessageBox.Show("El campo Oficina es mandatorio.", My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(1).Focus()
            Exit Sub
        End If
        Dim i As Integer = COBISMessageBox.Show("Está seguro de eliminar la relación Plaza-Oficina?", My.Application.Info.ProductName, COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question)
        If i = System.Windows.Forms.DialogResult.No Then
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2564")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "D")
        PMPasoValores(sqlconn, "@i_plaza", 0, SQLINT2, txtCampo(0).Text.Trim())
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtCampo(1).Text.Trim())
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_plazas_bco_rep", True, " Ok... Eliminar Relación Plaza-Oficina") Then
            PMChequea(sqlconn)
            PLLimpiar()
            PLBuscar()
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBIngresar.Enabled = _cmdBoton_1.Enabled
        TSBIngresar.Visible = _cmdBoton_1.Visible
        TSBEliminar.Enabled = _cmdBoton_2.Enabled
        TSBEliminar.Visible = _cmdBoton_2.Visible
        TSBLimpiar.Enabled = _cmdBoton_3.Enabled
        TSBLimpiar.Visible = _cmdBoton_3.Visible
        TSBSalir.Enabled = _cmdBoton_4.Enabled
        TSBSalir.Visible = _cmdBoton_4.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBIngresar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBIngresar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508873))
    End Sub

    Private Sub grdRegistros_Leave(sender As Object, e As EventArgs) Handles grdRegistros.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub grdRegistros_Load(sender As Object, e As EventArgs) Handles grdRegistros.Load

    End Sub
End Class


