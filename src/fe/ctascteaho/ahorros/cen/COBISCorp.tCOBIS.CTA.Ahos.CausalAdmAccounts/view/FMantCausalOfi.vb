Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Imports COBISCorp.tCOBIS.CTA.Ahos.QueryBackOffice
Partial Public Class FMantCausalOfiClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLPaso As Integer = 0
    Dim VLTablaCausal As String = ""

    Private Sub CmbProducto_Enter(sender As Object, e As EventArgs) Handles CmbProducto.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503093))
    End Sub

    Private Sub CmbProducto_SelectedIndexChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles CmbProducto.SelectedIndexChanged
        PMLimpiaGrid(grdRegistros)
        txtCampo(0).Text = ""
        txtCampo(1).Text = ""
        txtCampo(2).Text = ""
        lblDescripcion(1).Text = ""
        lblDescripcion(2).Text = ""
        lblDescripcion(3).Text = ""
        If CmbProducto.SelectedIndex = 0 Then
            VLTablaCausal = "ah_" & "tablas_causales_ndc"
        Else
            VLTablaCausal = "cc_" & "tablas_causales_ndc"
        End If
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Click, _cmdBoton_0.Click, _cmdBoton_3.Click, _cmdBoton_1.Click, _cmdBoton_4.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                PLBuscar()
            Case 1
                PLTransmitir()
            Case 2
                PLimpiar()
            Case 3
                Me.Cursor = System.Windows.Forms.Cursors.Default
                Me.Close()
            Case 4
                PLEliminar()
        End Select
    End Sub

    Private Sub PLEliminar()
        If txtCampo(2).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502557), FMLoadResString(502614), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(2).Enabled Then txtCampo(2).Focus()
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502559), FMLoadResString(502614), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(1).Enabled Then txtCampo(1).Focus()
            Exit Sub
        End If
        If txtCampo(0).Text = "" And optOpcion(1).Checked Then
            COBISMessageBox.Show(FMLoadResString(502566), FMLoadResString(502614), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(0).Enabled Then txtCampo(0).Focus()
            Exit Sub
        End If
        Dim VTResp As DialogResult = COBISMessageBox.Show(FMLoadResString(502578) & txtCampo(1).Text & FMLoadResString(508944) & lblDescripcion(3).Text & " ?", FMLoadResString(502543), COBISMessageBox.COBISButtons.OKCancel)
        If VTResp = System.Windows.Forms.DialogResult.Cancel Then Exit Sub
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(740))
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
        If optOpcion(1).Checked Then
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT4, txtCampo(0).Text)
        End If
        PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, lblDescripcion(1).Text)
        PMPasoValores(sqlconn, "@i_cod_tabla", 0, SQLVARCHAR, txtCampo(2).Text)
        PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCampo(1).Text)
        If optOpcion(0).Checked Then
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "T")
        Else
            If optOpcion(1).Checked Then
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "O")
            Else
                COBISMessageBox.Show(FMLoadResString(502615), FMLoadResString(9974), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_causal_ndc_oficina", True, FMLoadResString(502610)) Then
            PMChequea(sqlconn)
            If grdRegistros.Rows <= 0 Then cmdBoton(4).Enabled = True
            txtCampo(1).Text = ""
            lblDescripcion(3).Text = ""
            If optOpcion(0).Checked Then
                txtCampo(0).Text = ""
                lblDescripcion(2).Text = ""
            End If
            PMLimpiaGrid(grdRegistros)
            PLBuscar()
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub cmdSiguiente_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSiguiente.Click
        Dim VTSig As String = ""
        If optOpcion(0).Checked Then
            grdRegistros.Col = 1
            grdRegistros.Row = grdRegistros.Rows - 1
            VTSig = grdRegistros.CtlText
            PLBuscar(VTSig)
        Else
            If optOpcion(1).Checked Then
                grdRegistros.Col = 2
                grdRegistros.Row = grdRegistros.Rows - 1
                VTSig = grdRegistros.CtlText
                PLBuscar(VTSig)
            End If
        End If
    End Sub

    Private Sub FMantCausalOfi_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Public Sub PLInicializar()
        CmbProducto.Items.Insert(0, FMLoadResString(502556))
        CmbProducto.Items.Insert(1, FMLoadResString(502554))
        CmbProducto.SelectedIndex = 0
        CmbProducto.Focus()
        optOpcion(0).Checked = True
        VLPaso = True
    End Sub

    Private Sub grdRegistros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.Click
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
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdRegistros.DblClick
        If grdRegistros.Rows > 1 Then
            If grdRegistros.Cols - 1 > 2 Then
                grdRegistros.Col = 1
                txtCampo(0).Text = grdRegistros.CtlText
                If txtCampo(0).Text <> "" Then txtCampo_Leave(txtCampo(0), New EventArgs())
                grdRegistros.Col = 2
                txtCampo(1).Text = grdRegistros.CtlText
                If txtCampo(1).Text <> "" Then txtCampo_Leave(txtCampo(1), New EventArgs())
            Else
                grdRegistros.Col = 1
                txtCampo(1).Text = grdRegistros.CtlText
                If txtCampo(1).Text <> "" Then txtCampo_Leave(txtCampo(1), New EventArgs())
            End If
        End If
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub optOpcion_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optOpcion_1.CheckedChanged, _optOpcion_0.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Index As Integer = Array.IndexOf(optOpcion, eventSender)
            Select Case Index
                Case 0
                    txtCampo(0).Text = ""
                    txtCampo(0).Enabled = False
                    lblDescripcion(2).Text = ""
                Case 1
                    txtCampo(0).Enabled = True
                    lblDescripcion(2).Text = ""
            End Select
        End If
    End Sub

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.TextChanged, _txtCampo_1.TextChanged, _txtCampo_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = False
        Select Case Index
            Case 2
                PMLimpiaGrid(grdRegistros)
                txtCampo(1).Text = ""
                lblDescripcion(3).Text = ""
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.Enter, _txtCampo_1.Enter, _txtCampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = True
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502546))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502548))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502547))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_2.KeyPress, _txtCampo_1.KeyPress, _txtCampo_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If KeyAscii <> 8 And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_2.KeyDown, _txtCampo_1.KeyDown, _txtCampo_0.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Keycode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    txtCampo(Index).Text = ""
                    PMCatalogo("A", "cl_oficina", txtCampo(Index), lblDescripcion(2))
                Case 1
                    If lblDescripcion(1).Text <> "" Then
                        txtCampo(Index).Text = ""
                        VGCatCausal = lblDescripcion(1).Text
                        FBusCausal.cmdBoton(2).Visible = True
                        FBusCausal.cmdBoton(3).Visible = False
                        FBusCausal.ShowPopup(Me)
                        txtCampo(Index).Text = VGCausal
                        txtCampo_Leave(txtCampo(Index), New EventArgs())
                    End If
                Case 2
                    If Keycode = VGTeclaAyuda Then
                        txtCampo(2).Text = ""
                        PMCatalogo("A", VLTablaCausal, txtCampo(Index), lblDescripcion(1))
                    End If
            End Select
        End If
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.Leave, _txtCampo_1.Leave, _txtCampo_0.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Not VLPaso Then
            Select Case Index
                Case 0
                    If txtCampo(Index).Text <> "" Then
                        PMCatalogo("V", "cl_oficina", txtCampo(Index), lblDescripcion(2))
                    Else
                        lblDescripcion(2).Text = ""
                    End If
                Case 1
                    If lblDescripcion(1).Text = "" And txtCampo(2).Text <> "" Then
                        COBISMessageBox.Show(FMLoadResString(502557), FMLoadResString(502614), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        If txtCampo(2).Enabled Then txtCampo(2).Focus()
                        txtCampo(Index).Text = ""
                        Exit Sub
                    End If
                    If txtCampo(Index).Text <> "" Then
                        PMCatalogo("V", lblDescripcion(1).Text, txtCampo(Index), lblDescripcion(3))
                    Else
                        lblDescripcion(3).Text = ""
                    End If
                Case 2
                    If txtCampo(Index).Text <> "" Then
                        VLPaso = True
                        PMCatalogo("V", VLTablaCausal, txtCampo(Index), lblDescripcion(1))
                        If txtCampo(2).Text = "" Then PLimpiar()
                    Else
                        txtCampo(Index).Text = ""
                        txtCampo(1).Text = ""
                        lblDescripcion(1).Text = ""
                        lblDescripcion(3).Text = ""
                    End If
            End Select
        End If
    End Sub

    Private Sub PLTransmitir()
        If txtCampo(2).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502557), FMLoadResString(502614), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(2).Enabled Then txtCampo(2).Focus()
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502559), FMLoadResString(502614), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(1).Enabled Then txtCampo(1).Focus()
            Exit Sub
        End If
        If txtCampo(0).Text = "" And optOpcion(1).Checked Then
            COBISMessageBox.Show(FMLoadResString(502566), FMLoadResString(502614), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(0).Enabled Then txtCampo(0).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(739))
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
        If optOpcion(1).Checked Then
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT4, txtCampo(0).Text)
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "O")
        Else
            If optOpcion(0).Checked Then
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "T")
            End If
        End If
        PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, lblDescripcion(1).Text)
        PMPasoValores(sqlconn, "@i_cod_tabla", 0, SQLVARCHAR, txtCampo(2).Text)
        PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCampo(1).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_causal_ndc_oficina", True, FMLoadResString(502611)) Then
            PMMapeaGrid(sqlconn, grdRegistros, False)
            PMChequea(sqlconn)
            PLBuscar()
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub PLBuscar(Optional ByRef PLCodigo As String = "")
        If txtCampo(2).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502558), FMLoadResString(502614), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(2).Focus()
            Exit Sub
        Else
            PMCatalogo("V", VLTablaCausal, txtCampo(2), lblDescripcion(1))
            If lblDescripcion(1).Text = "" Then
                Exit Sub
            End If
        End If
        If optOpcion(0).Checked Then
            If txtCampo(1).Text <> "" Then
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "1")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCampo(1).Text)
            Else
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "0")
                If PLCodigo <> "" Then
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, PLCodigo)
                End If
            End If
        Else
            If optOpcion(1).Checked Then
                If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(502566), FMLoadResString(502614), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT4, txtCampo(0).Text)
                If txtCampo(1).Text <> "" Then
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "3")
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCampo(1).Text)
                Else
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "2")
                    If PLCodigo <> "" Then
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, PLCodigo)
                    End If
                End If
            End If
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(738))
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, lblDescripcion(1).Text)
        PMPasoValores(sqlconn, "@i_cod_tabla", 0, SQLVARCHAR, txtCampo(2).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_causal_ndc_oficina", True, FMLoadResString(502604)) Then
            If cmdBoton(0).Enabled Then
                PMMapeaGrid(sqlconn, grdRegistros, False)
            Else
                PMMapeaGrid(sqlconn, grdRegistros, True)
            End If
            PMChequea(sqlconn)
            If grdRegistros.Rows > 0 Then cmdBoton(4).Enabled = True
            If CDbl(Convert.ToString(grdRegistros.Tag)) > 0 Then
                If CDbl(Convert.ToString(grdRegistros.Tag)) < 20 Then
                    cmdSiguiente.Enabled = False
                    cmdBoton(0).Enabled = True
                Else
                    cmdSiguiente.Enabled = True
                    cmdBoton(0).Enabled = False
                End If
            Else
                cmdSiguiente.Enabled = False
                cmdBoton(0).Enabled = True
            End If
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
    End Sub

    Public Sub PLimpiar()
        PMLimpiaGrid(grdRegistros)
        txtCampo(0).Text = ""
        txtCampo(1).Text = ""
        txtCampo(2).Text = ""
        lblDescripcion(1).Text = ""
        lblDescripcion(2).Text = ""
        lblDescripcion(3).Text = ""
        CmbProducto.SelectedIndex = 0
        cmdSiguiente.Enabled = False
        cmdBoton(0).Enabled = True
        cmdBoton(4).Enabled = False
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBTransmitir.Enabled = _cmdBoton_1.Enabled
        TSBTransmitir.Visible = _cmdBoton_1.Visible
        TSBLimpiar.Enabled = _cmdBoton_2.Enabled
        TSBLimpiar.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_3.Enabled
        TSBSalir.Visible = _cmdBoton_3.Visible
        TSBEliminar.Enabled = _cmdBoton_4.Enabled
        TSBEliminar.Visible = _cmdBoton_4.Visible
        TSBSiguiente.Enabled = cmdSiguiente.Enabled
        TSBSiguiente.Visible = cmdSiguiente.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If cmdSiguiente.Enabled Then cmdSiguiente_Click(sender, e)
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(9975))
    End Sub

    Private Sub _optOpcion_1_Enter(sender As Object, e As EventArgs) Handles _optOpcion_1.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502603))
    End Sub

    Private Sub _optOpcion_0_Enter(sender As Object, e As EventArgs) Handles _optOpcion_0.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502582))
    End Sub
End Class


