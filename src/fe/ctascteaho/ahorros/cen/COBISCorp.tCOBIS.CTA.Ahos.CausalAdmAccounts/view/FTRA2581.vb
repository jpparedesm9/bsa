Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran2581Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


    Dim VLPaso As Integer = 0
    Dim VTProducto As String = ""

    Private Sub cmbTipo_SelectedIndexChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbTipo.SelectedIndexChanged
        txtCampo(0).Text = ""
        lblDescripcion.Text = ""
        optVigente(0).Checked = True
        optVigente(2).Enabled = cmbTipo.Text = FMLoadResString(502555)
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

    End Sub

    Private Sub cmbTipo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbTipo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500016))
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(FMLoadResString(502513))
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_6.Click, _cmdBoton_5.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_4.Click, _cmdBoton_1.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                Me.Close()
            Case 1
                PLLimpiar()
            Case 2
                PLEliminar()
            Case 3
                PLCrear()
            Case 4
                PLActualizar()
            Case 5
                PLSiguientes()
            Case 6
                PLBuscar()
        End Select
    End Sub

    Private Sub FTran2581_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
    End Sub

    Public Sub PLInicializar()
        cmbTipo.Items.Insert(0, FMLoadResString(502554))
        cmbTipo.Items.Insert(1, FMLoadResString(502555))
        cmbTipo.SelectedIndex = 1
        cmdBoton(5).Enabled = False
        optsaldo(1).Checked = True
        CargaParametros("1579", "Q", "3", "AHO", "OCUCOL", 3)
        If VGOcucol = "S" Then
            Frame2.Visible = False
        End If
        PLTSEstado()
    End Sub

    Private Sub FTran2581_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdRegistros_ClickEvent(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.ClickEvent
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
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
        If grdRegistros.Rows <= 2 Then
            grdRegistros.Row = 1
            grdRegistros.Col = 1
            If grdRegistros.CtlText.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(500681), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        End If
        grdRegistros.Col = 2
        txtCampo(0).Text = grdRegistros.CtlText
        txtCampo(0).Enabled = False
        grdRegistros.Col = 3
        lblDescripcion.Text = grdRegistros.CtlText
        grdRegistros.Col = 4
        If grdRegistros.CtlText = "V" Then
            optVigente(0).Checked = True
        End If
        If grdRegistros.CtlText = "E" Then
            optVigente(1).Checked = True
        End If
        If grdRegistros.CtlText = "S" Then
            optVigente(2).Checked = True
        End If
        grdRegistros.Col = 5
        If grdRegistros.CtlText = "S" Then
            optcom(1).Checked = True
        Else
            optcom(0).Checked = True
        End If
        grdRegistros.Col = 6
        If grdRegistros.CtlText = "S" Then
            optimp(1).Checked = True
        Else
            optimp(0).Checked = True
        End If
        grdRegistros.Col = 1
        If grdRegistros.CtlText = "3" Then
            cmbTipo.SelectedIndex = 0
            cmbTipo.Enabled = False
        Else
            cmbTipo.SelectedIndex = 1
            cmbTipo.Enabled = False
        End If
        grdRegistros.Col = 7
        If grdRegistros.CtlText = "S" Then
            optsaldo(1).Checked = True
        Else
            optsaldo(0).Checked = True
        End If
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = True
        cmdBoton(2).Enabled = True
        PLTSEstado()
    End Sub

    Private Sub PLActualizar()
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502067), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "699")
        If cmbTipo.Text = FMLoadResString(502554) Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "3")
        Else
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
        End If
        PMPasoValores(sqlconn, "@i_causal", 0, SQLVARCHAR, txtCampo(0).Text)
        If optVigente(0).Checked Then
            PMPasoValores(sqlconn, "@i_accion", 0, SQLCHAR, "V")
        ElseIf optVigente(1).Checked Then
            PMPasoValores(sqlconn, "@i_accion", 0, SQLCHAR, "E")
        ElseIf optVigente(2).Checked Then
            PMPasoValores(sqlconn, "@i_accion", 0, SQLCHAR, "S")
        Else
            COBISMessageBox.Show(FMLoadResString(502068), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If optcom(0).Checked Then
            PMPasoValores(sqlconn, "@i_comision", 0, SQLCHAR, "N")
        ElseIf optcom(1).Checked Then
            PMPasoValores(sqlconn, "@i_comision", 0, SQLCHAR, "S")
        End If
        If optimp(0).Checked And VGOcucol = "N" Then
            PMPasoValores(sqlconn, "@i_impuesto", 0, SQLCHAR, "N")
        ElseIf optimp(1).Checked And VGOcucol = "N" Then
            PMPasoValores(sqlconn, "@i_impuesto", 0, SQLCHAR, "S")
        End If
        If optsaldo(0).Checked Then
            PMPasoValores(sqlconn, "@i_saldomin", 0, SQLCHAR, "N")
        ElseIf optsaldo(1).Checked Then
            PMPasoValores(sqlconn, "@i_saldomin", 0, SQLCHAR, "S")
        End If
        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_crea_acciond", True, FMLoadResString(502607)) Then
            PMChequea(sqlconn)
            PLBuscar()
        Else
            PMChequea(sqlconn)
            PLLimpiar()
        End If
    End Sub

    Private Sub PLBuscar()
        If cmbTipo.Text = FMLoadResString(502554) Then
            VTProducto = "3"
        Else
            VTProducto = "4"
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "700")
        PMPasoValores(sqlconn, "@i_causal", 0, SQLVARCHAR, "0")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VTProducto)
        If optcom(0).Checked Then
            PMPasoValores(sqlconn, "@i_comision", 0, SQLCHAR, "N")
        ElseIf optcom(1).Checked Then
            PMPasoValores(sqlconn, "@i_comision", 0, SQLCHAR, "S")
        End If
        If optimp(0).Checked And VGOcucol = "N" Then
            PMPasoValores(sqlconn, "@i_impuesto", 0, SQLCHAR, "N")
        ElseIf optimp(1).Checked And VGOcucol = "N" Then
            PMPasoValores(sqlconn, "@i_impuesto", 0, SQLCHAR, "S")
        End If
        If optsaldo(0).Checked Then
            PMPasoValores(sqlconn, "@i_saldomin", 0, SQLCHAR, "N")
        ElseIf optsaldo(1).Checked Then
            PMPasoValores(sqlconn, "@i_saldomin", 0, SQLCHAR, "S")
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_crea_acciond", True, FMLoadResString(502607)) Then
            PMMapeaGrid(sqlconn, grdRegistros, False)
            PMAnchoColumnasGrid(grdRegistros)
            PMChequea(sqlconn)
            cmbTipo.Enabled = False
            If txtCampo(0).Enabled Then
                txtCampo(0).Focus()
            End If
            If VGOcucol = "S" Then
                grdRegistros.ColIsVisible(6) = False
            End If
            cmdBoton(5).Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) >= 20
        Else
            PMChequea(sqlconn)
            PLLimpiar()
            PMLimpiaG(grdRegistros)
            cmdBoton(5).Enabled = False
        End If
        
        PLTSEstado()
    End Sub

    Private Sub PLCrear()
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502069), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "698")
        If cmbTipo.Text = FMLoadResString(502554) Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "3")
        Else
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
        End If
        PMPasoValores(sqlconn, "@i_causal", 0, SQLVARCHAR, txtCampo(0).Text)
        If optVigente(0).Checked Then
            PMPasoValores(sqlconn, "@i_accion", 0, SQLCHAR, "V")
        ElseIf optVigente(1).Checked Then
            PMPasoValores(sqlconn, "@i_accion", 0, SQLCHAR, "E")
        ElseIf optVigente(2).Checked Then
            PMPasoValores(sqlconn, "@i_accion", 0, SQLCHAR, "S")
        Else
            COBISMessageBox.Show(FMLoadResString(502068), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If optcom(0).Checked Then
            PMPasoValores(sqlconn, "@i_comision", 0, SQLCHAR, "N")
        ElseIf optcom(1).Checked Then
            PMPasoValores(sqlconn, "@i_comision", 0, SQLCHAR, "S")
        End If
        If optimp(0).Checked And VGOcucol = "N" Then
            PMPasoValores(sqlconn, "@i_impuesto", 0, SQLCHAR, "N")
        ElseIf optimp(1).Checked And VGOcucol = "N" Then
            PMPasoValores(sqlconn, "@i_impuesto", 0, SQLCHAR, "S")
        End If
        If optsaldo(0).Checked Then
            PMPasoValores(sqlconn, "@i_saldomin", 0, SQLCHAR, "N")
        ElseIf optsaldo(1).Checked Then
            PMPasoValores(sqlconn, "@i_saldomin", 0, SQLCHAR, "S")
        End If
        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_crea_acciond", True, "Ok... Consulta de Acción de Notas de Débito") Then
            PMChequea(sqlconn)
            PLBuscar()
        Else
            PMChequea(sqlconn)
            PLLimpiar()
        End If
    End Sub

    Private Sub PLEliminar()
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502069), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "701")
        If cmbTipo.Text = FMLoadResString(502554) Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "3")
        Else
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
        End If
        PMPasoValores(sqlconn, "@i_causal", 0, SQLVARCHAR, txtCampo(0).Text)
        If optVigente(0).Checked Then
            PMPasoValores(sqlconn, "@i_accion", 0, SQLCHAR, "V")
        ElseIf optVigente(1).Checked Then
            PMPasoValores(sqlconn, "@i_accion", 0, SQLCHAR, "E")
        ElseIf optVigente(2).Checked Then
            PMPasoValores(sqlconn, "@i_accion", 0, SQLCHAR, "S")
        Else
            COBISMessageBox.Show(FMLoadResString(502068), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If optcom(0).Checked Then
            PMPasoValores(sqlconn, "@i_comision", 0, SQLCHAR, "N")
        ElseIf optcom(1).Checked Then
            PMPasoValores(sqlconn, "@i_comision", 0, SQLCHAR, "S")
        End If
        If optimp(0).Checked And VGOcucol = "N" Then
            PMPasoValores(sqlconn, "@i_impuesto", 0, SQLCHAR, "N")
        ElseIf optimp(1).Checked And VGOcucol = "N" Then
            PMPasoValores(sqlconn, "@i_impuesto", 0, SQLCHAR, "S")
        End If
        If optsaldo(0).Checked Then
            PMPasoValores(sqlconn, "@i_saldomin", 0, SQLCHAR, "N")
        ElseIf optsaldo(1).Checked Then
            PMPasoValores(sqlconn, "@i_saldomin", 0, SQLCHAR, "S")
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_crea_acciond", True, FMLoadResString(502607)) Then
            PMChequea(sqlconn)
            PLBuscar()
        Else
            PMChequea(sqlconn)
            PLLimpiar()
        End If
        txtCampo(0).Enabled = True
        txtCampo(0).Text = ""
        lblDescripcion.Text = ""
    End Sub

    Private Sub PLLimpiar()
        txtCampo(0).Enabled = True
        txtCampo(0).Text = ""
        txtCampo(0).Focus()
        lblDescripcion.Text = ""
        cmdBoton(3).Enabled = True
        cmdBoton(2).Enabled = False
        cmdBoton(4).Enabled = False
        cmdBoton(5).Enabled = False
        If Not cmbTipo.Enabled Then
            cmbTipo.Enabled = True
        End If
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
        optVigente(0).Checked = True
        optimp(0).Enabled = True
        optcom(0).Checked = True
        optsaldo(1).Checked = True
        PLTSEstado()
    End Sub

    Private Sub PLSiguientes()
        If cmbTipo.Text = "CUENTA CORRIENTE" Then
            VTProducto = "3"
        Else
            VTProducto = "4"
        End If
        grdRegistros.Col = 2
        grdRegistros.Row = grdRegistros.Rows - 1
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "700")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VTProducto)
        PMPasoValores(sqlconn, "@i_causal", 0, SQLVARCHAR, grdRegistros.CtlText)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_crea_acciond", True, FMLoadResString(502607)) Then
            PMMapeaGrid(sqlconn, grdRegistros, True)
            PMAnchoColumnasGrid(grdRegistros)
            PMChequea(sqlconn)
            If txtCampo(0).Enabled Then
                txtCampo(0).Focus()
            End If
            If VGOcucol = "S" Then
                grdRegistros.ColIsVisible(6) = False
            End If
            cmdBoton(5).Enabled = CDbl(Convert.ToString(grdRegistros.Tag)) >= 20
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
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
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502070))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_0.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Keycode = VGTeclaAyuda Then
            VLPaso = True
            txtCampo(Index).Text = ""
            Select Case Index
                Case 0
                    If cmbTipo.Text = FMLoadResString(502554) Then
                        PMCatalogo("A", "cc_causa_nd", txtCampo(Index), lblDescripcion)
                    Else
                        PMCatalogo("A", "ah_causa_nd", txtCampo(Index), lblDescripcion)
                    End If
                    If txtCampo(Index).Text = "" Then
                        txtCampo(Index).Text = ""
                        lblDescripcion.Text = ""
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

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If Not VLPaso And txtCampo(Index).Text <> "" Then
                    If cmbTipo.Text = FMLoadResString(502554) Then
                        PMCatalogo("V", "cc_causa_nd", txtCampo(Index), lblDescripcion)
                        optVigente(2).Enabled = True
                    Else
                        PMCatalogo("V", "ah_causa_nd", txtCampo(Index), lblDescripcion)
                        VLPaso = True
                        optVigente(2).Enabled = False
                    End If
                    If txtCampo(Index).Text = "" Then
                        lblDescripcion.Text = ""
                    End If
                End If
        End Select
    End Sub
    Private Sub PLTSEstado()
        TSBBuscar.Visible = _cmdBoton_6.Visible
        TSBBuscar.Enabled = _cmdBoton_6.Enabled
        TSBSiguientes.Visible = _cmdBoton_5.Visible
        TSBSiguientes.Enabled = _cmdBoton_5.Enabled
        TSBCrear.Visible = _cmdBoton_3.Visible
        TSBCrear.Enabled = _cmdBoton_3.Enabled
        TSBActualizar.Visible = _cmdBoton_4.Visible
        TSBActualizar.Enabled = _cmdBoton_4.Enabled
        TSBEliminar.Visible = _cmdBoton_2.Visible
        TSBEliminar.Enabled = _cmdBoton_2.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBSalir.Visible = _cmdBoton_0.Visible
        TSBSalir.Enabled = _cmdBoton_0.Enabled
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
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

    Private Sub frmEstado_Enter(sender As Object, e As EventArgs) Handles frmEstado.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503376))
    End Sub

    Private Sub Frame1_Enter(sender As Object, e As EventArgs) Handles Frame1.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503375))
    End Sub

    Private Sub Frame2_Enter(sender As Object, e As EventArgs) Handles Frame2.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503378))
    End Sub

    Private Sub Frame3_Enter(sender As Object, e As EventArgs) Handles Frame3.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502620))
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503377))
    End Sub

End Class


