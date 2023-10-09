Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTRAN707Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


    Dim VLPaso As Boolean = False

    Private Sub FTRAN707_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
        cmbTipo.Focus()
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_6.Enabled
        TSBBuscar.Visible = _cmdBoton_6.Visible
        TSBSiguientes.Enabled = _cmdBoton_5.Enabled
        TSBSiguientes.Visible = _cmdBoton_5.Visible
        TSBCrear.Enabled = _cmdBoton_4.Enabled
        TSBCrear.Visible = _cmdBoton_4.Visible
        TSBActualizar.Enabled = _cmdBoton_3.Enabled
        TSBActualizar.Visible = _cmdBoton_3.Visible
        TSBEliminar.Enabled = _cmdBoton_2.Enabled
        TSBEliminar.Visible = _cmdBoton_2.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_0.Enabled
        TSBSalir.Visible = _cmdBoton_0.Visible
    End Sub
    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Public Sub PLInicializar()
        cmbTipo.Items.Insert(0, FMLoadResString(502766))
        cmbTipo.Items.Insert(1, FMLoadResString(502767))
        cmbTipo.SelectedIndex = 1
        cmbimpresion.Items.Add("S")
        cmbimpresion.Items.Add("N")
        cmbimpresion.SelectedIndex = 1
        cmbafecta.Items.Add("S")
        cmbafecta.Items.Add("N")
        cmbafecta.SelectedIndex = 0
        cmbCamara.Items.Add("S")
        cmbCamara.Items.Add("N")
        cmbCamara.SelectedIndex = 1
        cmdBoton(5).Enabled = False
        cmdBoton(2).Enabled = False
        cmdBoton(3).Enabled = False
        Me.Text = FMLoadResString(3077)
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.TextChanged, _txtCampo_1.TextChanged, _txtCampo_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2
                VLPaso = False
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.Enter, _txtCampo_1.Enter, _txtCampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500676))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500677))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502768))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_2.KeyDown, _txtCampo_1.KeyDown, _txtCampo_0.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Keycode = VGTeclaAyuda Then
            VLPaso = True
            txtCampo(Index).Text = ""
            lblDescripcion(Index).Text = ""
            Select Case Index
                Case 0
                    PMCatalogo("A", "re_signo_ndc", txtCampo(Index), lblDescripcion(Index))
                Case 1
                    If txtCampo(0).Text = "" Then
                        txtCampo(Index).Text = ""
                        lblDescripcion(Index).Text = ""
                        Exit Sub
                    End If
                    If cmbTipo.Text = FMLoadResString(502766) Then
                        If txtCampo(0).Text = "C" Then
                            PMCatalogo("A", "cc_causa_nc", txtCampo(Index), lblDescripcion(Index))
                        Else
                            PMCatalogo("A", "cc_causa_nd", txtCampo(Index), lblDescripcion(Index))
                        End If
                    Else
                        If txtCampo(0).Text = "C" Then
                            PMCatalogo("A", "ah_causa_nc", txtCampo(Index), lblDescripcion(Index))
                        Else
                            PMCatalogo("A", "ah_causa_nd", txtCampo(Index), lblDescripcion(Index))
                        End If
                    End If
                Case 2
                    If txtCampo(0).Text = "" Then
                        txtCampo(Index).Text = ""
                        lblDescripcion(Index).Text = ""
                        Exit Sub
                    End If
                    If cmbTipo.Text = FMLoadResString(502766) Then
                        If txtCampo(0).Text = "C" Then
                            PMCatalogo("A", "cc_causa_nd", txtCampo(Index), lblDescripcion(Index))
                        Else
                            PMCatalogo("A", "cc_causa_nc", txtCampo(Index), lblDescripcion(Index))
                        End If
                    Else
                        If txtCampo(0).Text = "C" Then
                            PMCatalogo("A", "ah_causa_nd", txtCampo(Index), lblDescripcion(Index))
                        Else
                            PMCatalogo("A", "ah_causa_nc", txtCampo(Index), lblDescripcion(Index))
                        End If
                    End If
            End Select
            If txtCampo(Index).Text = "" Then
                txtCampo(Index).Text = ""
                lblDescripcion(Index).Text = ""
            End If
        End If
        PLTSEstado()
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_2.KeyPress, _txtCampo_1.KeyPress, _txtCampo_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                KeyAscii = FMVAlidaTipoDato("A", KeyAscii)
            Case 1, 2
                KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.Leave, _txtCampo_1.Leave, _txtCampo_0.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If Not VLPaso And txtCampo(Index).Text <> "" Then
                    PMCatalogo("V", "re_signo_ndc", txtCampo(Index), lblDescripcion(0))
                End If
            Case 1
                If txtCampo(0).Text = "" Then
                    txtCampo(Index).Text = ""
                    lblDescripcion(Index).Text = ""
                    Exit Sub
                End If
                If Not VLPaso And txtCampo(Index).Text <> "" Then
                    If cmbTipo.Text = FMLoadResString(502766) Then
                        If txtCampo(0).Text = "C" Then
                            PMCatalogo("V", "cc_causa_nc", txtCampo(Index), lblDescripcion(Index))
                        Else
                            PMCatalogo("V", "cc_causa_nd", txtCampo(Index), lblDescripcion(Index))
                        End If
                    Else
                        If txtCampo(0).Text = "C" Then
                            PMCatalogo("V", "ah_causa_nc", txtCampo(Index), lblDescripcion(Index))
                        Else
                            PMCatalogo("V", "ah_causa_nd", txtCampo(Index), lblDescripcion(Index))
                        End If
                    End If
                End If
            Case 2
                If txtCampo(0).Text = "" Then
                    txtCampo(Index).Text = ""
                    lblDescripcion(Index).Text = ""
                    Exit Sub
                End If
                If Not VLPaso And txtCampo(Index).Text <> "" Then
                    If cmbTipo.Text = FMLoadResString(502766) Then
                        If txtCampo(0).Text = "C" Then
                            PMCatalogo("V", "cc_causa_nd", txtCampo(Index), lblDescripcion(Index))
                        Else
                            PMCatalogo("V", "cc_causa_nc", txtCampo(Index), lblDescripcion(Index))
                        End If
                    Else
                        If txtCampo(0).Text = "C" Then
                            PMCatalogo("V", "ah_causa_nd", txtCampo(Index), lblDescripcion(Index))
                        Else
                            PMCatalogo("V", "ah_causa_nc", txtCampo(Index), lblDescripcion(Index))
                        End If
                    End If
                End If
        End Select
        If txtCampo(Index).Text = "" Then
            lblDescripcion(Index).Text = ""
        End If
        PLTSEstado()
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_4.Click, _cmdBoton_5.Click, _cmdBoton_6.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        TSBotones.Focus()
        Select Case Index
            Case 0
                Me.Close()
            Case 1
                PLLimpiar()
            Case 2
                PLEliminar()
            Case 3
                PLActualizar()
            Case 4
                PLCrear()
            Case 5
                PLSiguientes()
            Case 6
                PLBuscar()
        End Select
        PLTSEstado()
    End Sub

    Private Sub PLLimpiar()
        txtCampo(0).Enabled = True
        txtCampo(1).Enabled = True
        txtCampo(2).Enabled = True
        txtCampo(0).Text = ""
        txtCampo(1).Text = ""
        txtCampo(2).Text = ""
        lblDescripcion(0).Text = ""
        lblDescripcion(1).Text = ""
        lblDescripcion(2).Text = ""
        cmbTipo.Enabled = True
        cmbTipo.SelectedIndex = 1
        cmbimpresion.Enabled = True
        cmbimpresion.SelectedIndex = 1
        cmbafecta.Enabled = True
        cmbafecta.SelectedIndex = 0
        cmbCamara.Enabled = True
        cmbCamara.SelectedIndex = 1
        txtCampo(0).Focus()
        cmdBoton(3).Enabled = False
        cmdBoton(2).Enabled = False
        cmdBoton(4).Enabled = True
        grdRegistros.Rows = 2
        grdRegistros.Cols = 2
        grdRegistros.Row = 0
        grdRegistros.Col = 1
        grdRegistros.CtlText = ""
        grdRegistros.Row = 1
        grdRegistros.Col = 0
        grdRegistros.CtlText = ""
        grdRegistros.Row = 1
        grdRegistros.Col = 1
        grdRegistros.CtlText = ""
        PLTSEstado()
    End Sub

    Private Sub PLCrear()
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500678), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500679), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(1).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "707")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
        If cmbTipo.Text = FMLoadResString(502766) Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "3")
        Else
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
        End If
        PMPasoValores(sqlconn, "@i_signo", 0, SQLCHAR, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_causa", 0, SQLVARCHAR, txtCampo(1).Text)
        PMPasoValores(sqlconn, "@i_imprime", 0, SQLCHAR, cmbimpresion.Text)
        PMPasoValores(sqlconn, "@i_act_fecha", 0, SQLCHAR, cmbafecta.Text)
        PMPasoValores(sqlconn, "@i_camara", 0, SQLCHAR, cmbCamara.Text)
        PMPasoValores(sqlconn, "@i_cau_aju", 0, SQLVARCHAR, txtCampo(2).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_personaliza_ndc", True, FMLoadResString(502769)) Then
            PMChequea(sqlconn)
            PLBuscar()
            cmdBoton(2).Enabled = True
            cmdBoton(3).Enabled = True
            cmdBoton(4).Enabled = False
        Else
            PMChequea(sqlconn)
            PLLimpiar()
        End If
    End Sub

    Private Sub PLBuscar()
        Dim VTTabla As String = ""
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500680), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "707")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        If cmbTipo.Text = FMLoadResString(502766) Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "3")
        Else
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
        End If
        PMPasoValores(sqlconn, "@i_signo", 0, SQLCHAR, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_causa", 0, SQLVARCHAR, "0")
        If cmbTipo.Text = FMLoadResString(502766) Then
            If txtCampo(0).Text = "C" Then
                VTTabla = "cc_causa_nc"
            Else
                VTTabla = "cc_causa_nd"
            End If
        Else
            If txtCampo(0).Text = "C" Then
                VTTabla = "ah_causa_nc"
            Else
                VTTabla = "ah_causa_nd"
            End If
        End If
        PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, VTTabla)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_personaliza_ndc", True, FMLoadResString(502769)) Then
            PMMapeaGrid(sqlconn, grdRegistros, False)
            PMMapeaTextoGrid(grdRegistros)
            PMAnchoColumnasGrid(grdRegistros)
            PMChequea(sqlconn)
            cmbTipo.Enabled = False
            txtCampo(0).Enabled = False
            If txtCampo(1).Enabled Then
                txtCampo(1).Focus()
            End If
            cmdBoton(5).Enabled = CDbl(Convert.ToString(grdRegistros.Tag)) >= 20
        Else
            PMChequea(sqlconn)
            PLLimpiar()
            PMLimpiaGrid(grdRegistros)
            cmdBoton(5).Enabled = False
        End If
    End Sub

    Private Sub PLSiguientes()
        Dim VTTabla As String = ""
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "707")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        If cmbTipo.Text = FMLoadResString(502766) Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "3")
        Else
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
        End If
        PMPasoValores(sqlconn, "@i_signo", 0, SQLCHAR, txtCampo(0).Text)
        grdRegistros.Col = 3
        grdRegistros.Row = grdRegistros.Rows - 1
        PMPasoValores(sqlconn, "@i_causa", 0, SQLVARCHAR, grdRegistros.CtlText)
        If cmbTipo.Text = FMLoadResString(502766) Then
            If txtCampo(0).Text = "C" Then
                VTTabla = "cc_causa_nc"
            Else
                VTTabla = "cc_causa_nd"
            End If
        Else
            If txtCampo(0).Text = "C" Then
                VTTabla = "ah_causa_nc"
            Else
                VTTabla = "ah_causa_nd"
            End If
        End If
        PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, VTTabla)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_personaliza_ndc", True, FMLoadResString(503117)) Then
            PMMapeaGrid(sqlconn, grdRegistros, True)
            PMMapeaTextoGrid(grdRegistros)
            PMAnchoColumnasGrid(grdRegistros)
            PMChequea(sqlconn)
            If txtCampo(1).Enabled Then
                txtCampo(1).Focus()
            End If
            cmdBoton(5).Enabled = CDbl(Convert.ToString(grdRegistros.Tag)) >= 20
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub PLEliminar()
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500678), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500679), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(1).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "707")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
        If cmbTipo.Text = FMLoadResString(502766) Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "3")
        Else
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
        End If
        PMPasoValores(sqlconn, "@i_signo", 0, SQLCHAR, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_causa", 0, SQLVARCHAR, txtCampo(1).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_personaliza_ndc", True, FMLoadResString(502769)) Then
            PMChequea(sqlconn)
            PLBuscar()
            cmdBoton(2).Enabled = False
            cmdBoton(3).Enabled = False
            cmdBoton(4).Enabled = True
        Else
            PMChequea(sqlconn)
            PLLimpiar()
        End If
        txtCampo(1).Enabled = True
        txtCampo(1).Text = ""
        lblDescripcion(1).Text = ""
    End Sub

    Private Sub PLActualizar()
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500678), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500679), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(1).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "707")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
        If cmbTipo.Text = FMLoadResString(502766) Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "3")
        Else
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
        End If
        PMPasoValores(sqlconn, "@i_signo", 0, SQLCHAR, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_causa", 0, SQLVARCHAR, txtCampo(1).Text)
        PMPasoValores(sqlconn, "@i_imprime", 0, SQLCHAR, cmbimpresion.Text)
        PMPasoValores(sqlconn, "@i_act_fecha", 0, SQLCHAR, cmbafecta.Text)
        PMPasoValores(sqlconn, "@i_camara", 0, SQLCHAR, cmbCamara.Text)
        PMPasoValores(sqlconn, "@i_cau_aju", 0, SQLVARCHAR, txtCampo(2).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_personaliza_ndc", True, FMLoadResString(503117)) Then
            PMChequea(sqlconn)
            PLBuscar()
            cmdBoton(2).Enabled = True
            cmdBoton(3).Enabled = True
            cmdBoton(4).Enabled = False
        Else
            PMChequea(sqlconn)
            PLLimpiar()
        End If
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
    End Sub

    Private Sub grdRegistros_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdRegistros.DblClick
        If grdRegistros.Rows <= 2 Then
            grdRegistros.Row = 1
            grdRegistros.Col = 1
            If grdRegistros.CtlText.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(500681), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        End If
        grdRegistros.Col = 3
        txtCampo(1).Text = grdRegistros.CtlText
        txtCampo(1).Enabled = False
        grdRegistros.Col = 4
        lblDescripcion(1).Text = grdRegistros.CtlText
        grdRegistros.Col = 5
        cmbimpresion.Text = grdRegistros.CtlText
        grdRegistros.Col = 6
        cmbafecta.Text = grdRegistros.CtlText
        grdRegistros.Col = 7
        cmbCamara.Text = grdRegistros.CtlText
        grdRegistros.Col = 8
        txtCampo(2).Text = grdRegistros.CtlText
        txtCampo_Leave(txtCampo(2), New EventArgs())
        cmdBoton(3).Enabled = True
        cmdBoton(4).Enabled = False
        cmdBoton(2).Enabled = True
        PLTSEstado()
    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
        PMLineaG(grdRegistros)
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub cmbafecta_Enter(sender As Object, e As EventArgs) Handles cmbafecta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(20014))
    End Sub

    Private Sub cmbCamara_Enter(sender As Object, e As EventArgs) Handles cmbCamara.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(20013))
    End Sub

    Private Sub cmbimpresion_Enter(sender As Object, e As EventArgs) Handles cmbimpresion.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(20012))
    End Sub

    Private Sub cmbTipo_Enter(sender As Object, e As EventArgs) Handles cmbTipo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(20011))
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(20010))
    End Sub
End Class


