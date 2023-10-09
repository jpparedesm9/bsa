Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran2593Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLPaso As Integer = 0

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_6.Click, _cmdBoton_5.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_4.Click, _cmdBoton_1.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        TSBBotones.Focus()
        Select Case Index
            Case 0
                Me.Close()
            Case 1
                PLLimpiar()
                PMLimpiaGrid(grdRegistros)
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

    Private Sub FTran2593_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
    End Sub

    Public Sub PLInicializar()
        UltraGroupBox1.Focus()
        cmdBoton(4).Enabled = False
        cmdBoton(5).Enabled = False
        PLTSEstado()
        txtCampo(1).Focus()
    End Sub

    Private Sub FTran2593_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
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

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdRegistros.DblClick
        If grdRegistros.Rows <= 2 Then
            grdRegistros.Row = 1
            grdRegistros.Col = 1
            If grdRegistros.CtlText.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(502123), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        End If
        grdRegistros.Col = 1
        txtCampo(1).Text = grdRegistros.CtlText
        txtCampo(1).Enabled = False
        grdRegistros.Col = 2
        txtCampo(0).Text = grdRegistros.CtlText
        grdRegistros.Col = 3
        txtCampo(2).Text = grdRegistros.CtlText
        txtCampo(2).Enabled = False
        grdRegistros.Col = 4
        lblDescripcion.Text = grdRegistros.CtlText
        grdRegistros.Col = 5
        If grdRegistros.CtlText = "V" Then
            optVigente(0).Checked = True
        Else
            optVigente(1).Checked = True
        End If
        grdRegistros.Col = 6
        txtCampo(3).Text = grdRegistros.CtlText
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = True
        cmdBoton(2).Enabled = True
        PLTSEstado()
    End Sub

    Private Sub PLActualizar()
        If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502124), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(1).Focus()
            Exit Sub
        End If
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502125), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If txtCampo(2).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502126), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(2).Focus()
            Exit Sub
        End If
        If txtCampo(3).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(508902), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(3).Focus()
            Exit Sub
        End If
        If Not FMValidaNit(txtCampo(3).Text) Then
            COBISMessageBox.Show(FMLoadResString(20019), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(3).Focus()
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2594")
        PMPasoValores(sqlconn, "@i_banco", 0, SQLINT2, txtCampo(1).Text)
        PMPasoValores(sqlconn, "@i_desc", 0, SQLVARCHAR, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, txtCampo(2).Text)
        PMPasoValores(sqlconn, "@i_nit", 0, SQLVARCHAR, txtCampo(3).Text)
        If optVigente(0).Checked Then
            PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "V")
        Else
            PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "C")
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_crea_banco", True, FMLoadResString(508903)) Then
            PMChequea(sqlconn)
            PLLimpiar()
            PLBuscar()
            cmdBoton(4).Enabled = False
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub PLBuscar()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2595")
        PMPasoValores(sqlconn, "@i_tran", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_banco", 0, SQLINT2, "-1")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_crea_banco", True, FMLoadResString(508903)) Then
            PMMapeaGrid(sqlconn, grdRegistros, False)
            PMMapeaTextoGrid(grdRegistros)
            PMAnchoColumnasGrid(grdRegistros)
            PMChequea(sqlconn)
            If grdRegistros.Rows <= 2 Then
                grdRegistros.Col = 1
                grdRegistros.Row = 1
                If grdRegistros.CtlText = "" Then
                    PLLimpiar()
                    Exit Sub
                End If
            End If
            If Not txtCampo(1).Enabled Then
                txtCampo(1).Enabled = True
            End If
            txtCampo(1).Focus()
            cmdBoton(5).Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) >= 20
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
    End Sub

    Private Sub PintaGrid()
        grdRegistros.ColAlignment(1) = 2
        grdRegistros.ColWidth(1) = 600
        grdRegistros.ColWidth(2) = 3100
        grdRegistros.ColAlignment(3) = 2
        grdRegistros.ColWidth(3) = 500
        grdRegistros.ColWidth(4) = 1400
        grdRegistros.ColAlignment(5) = 2
        grdRegistros.ColWidth(5) = 700
        grdRegistros.ColWidth(6) = 1100
    End Sub

    Private Sub PLCrear()
        If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502124), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(1).Focus()
            Exit Sub
        End If
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502125), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If txtCampo(2).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502126), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(2).Focus()
            Exit Sub
        End If
        If txtCampo(3).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(508902), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(3).Focus()
            Exit Sub
        End If        
        If Not FMValidaNit(txtCampo(3).Text) Then
            COBISMessageBox.Show(FMLoadResString(20019), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(3).Focus()
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2593")
        PMPasoValores(sqlconn, "@i_banco", 0, SQLINT2, txtCampo(1).Text)
        PMPasoValores(sqlconn, "@i_desc", 0, SQLVARCHAR, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, txtCampo(2).Text)
        PMPasoValores(sqlconn, "@i_nit", 0, SQLVARCHAR, txtCampo(3).Text)
        If optVigente(0).Checked Then
            PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "V")
        Else
            PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "C")
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_crea_banco", True, FMLoadResString(508903)) Then
            PMChequea(sqlconn)
            PLBuscar()
        Else
            PMChequea(sqlconn)
        End If
        PLLimpiar()
    End Sub

    Private Sub PLEliminar()
        If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502124), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(1).Focus()
            Exit Sub
        End If
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502125), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If txtCampo(2).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502126), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(2).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2596")
        PMPasoValores(sqlconn, "@i_banco", 0, SQLINT2, txtCampo(1).Text)
        PMPasoValores(sqlconn, "@i_desc", 0, SQLVARCHAR, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, txtCampo(2).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_crea_banco", True, FMLoadResString(508903)) Then
            PMChequea(sqlconn)
            PLBuscar()
            cmdBoton(3).Enabled = True
            cmdBoton(2).Enabled = False
            cmdBoton(4).Enabled = False
        Else
            PMChequea(sqlconn)
        End If
        PLLimpiar()
    End Sub

    Private Sub PLLimpiar()
        txtCampo(0).Text = ""
        txtCampo(1).Text = ""
        txtCampo(2).Text = ""
        txtCampo(3).Text = ""
        lblDescripcion.Text = ""
        If Not txtCampo(1).Enabled Then
            txtCampo(1).Enabled = True
        End If
        txtCampo(1).Focus()
        If Not txtCampo(2).Enabled Then
            txtCampo(2).Enabled = True
        End If
        cmdBoton(3).Enabled = True
        cmdBoton(2).Enabled = False
        cmdBoton(4).Enabled = False
        cmdBoton(5).Enabled = False
        PLTSEstado() 'JSA
    End Sub

    Private Sub PLSiguientes()
        grdRegistros.Col = 1
        grdRegistros.Row = grdRegistros.Rows - 1
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2595")
        PMPasoValores(sqlconn, "@i_tran", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_banco", 0, SQLINT2, grdRegistros.CtlText)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_crea_banco", True, FMLoadResString(508903)) Then
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

    Private isInitializingComponent As Boolean = False


    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.TextChanged, _txtCampo_2.TextChanged, _txtCampo_1.TextChanged, _txtCampo_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 2
                VLPaso = False
            Case 3
                If Not IsNumeric(txtCampo(3).Text) Then
                    txtCampo(3).Text = ""
                End If
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.Enter, _txtCampo_2.Enter, _txtCampo_1.Enter, _txtCampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502128))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502111))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502129))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508870))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_3.KeyDown, _txtCampo_2.KeyDown, _txtCampo_1.KeyDown, _txtCampo_0.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If KeyCode = VGTeclaAyuda Then
            Select Case Index
                Case 2
                    PMCatalogo("A", "cl_filial", txtCampo(Index), lblDescripcion)
                    VLPaso = True
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_3.KeyPress, _txtCampo_2.KeyPress, _txtCampo_1.KeyPress, _txtCampo_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If (KeyAscii > 47 And KeyAscii < 58) Or (KeyAscii > 64 And KeyAscii < 91) Or (KeyAscii > 96 And KeyAscii < 123) Or (KeyAscii = 32 Or KeyAscii = 8) Then
                    KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                Else
                    KeyAscii = 0
                End If
            Case 1, 2, 3
                KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.Leave, _txtCampo_2.Leave, _txtCampo_1.Leave, _txtCampo_0.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 2
                If Not VLPaso Then
                    If txtCampo(Index).Text <> "" Then
                        PMCatalogo("V", "cl_filial", txtCampo(Index), lblDescripcion)
                        VLPaso = True
                    Else
                        lblDescripcion.Text = ""
                    End If
                End If
            Case 3
                If txtCampo(3).Text <> "" Then
                    If Not FMValidaNit(txtCampo(3).Text) Then
                        COBISMessageBox.Show(FMLoadResString(20019), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(3).Focus()
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

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509101))
    End Sub

    Private Sub optVigente_Enter(sender As Object, e As EventArgs) Handles _optVigente_0.Enter, _optVigente_1.Enter
        Dim Index As Integer = Array.IndexOf(optVigente, sender)
        If Index = 0 Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501406))
        Else
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502119))
        End If
    End Sub
End Class


