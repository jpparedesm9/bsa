Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
Imports COBISCorp.tCOBIS.PER.Cost
 Public  Partial  Class FVarServClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Dim VLPaso As Integer = 0

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_0.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_1.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Dim VTEstado As String = ""
		Dim VTFilas As Integer = 0
        Dim VTRubro As String = ""
        TSBotones.Focus()
		Select Case Index
			Case 0
				If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1260), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(3).Focus()
					Exit Sub
				End If
				If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1271), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(2).Focus()
					Exit Sub
				End If
				If txtCampo(4).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1291), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(4).Focus()
					Exit Sub
				End If
				If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1427), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(1).Focus()
					Exit Sub
				End If
				If optEstado(0).Checked Then
					VTEstado = "V"
				ElseIf optEstado(1).Checked Then 
					VTEstado = "N"
				End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4025")
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
				PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(3).Text)
				PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, txtCampo(2).Text)
				PMPasoValores(sqlconn, "@i_tipo_dato", 0, SQLCHAR, txtCampo(4).Text)
				PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, VTEstado)
				PMPasoValores(sqlconn, "@i_descripcion", 0, SQLCHAR, txtCampo(1).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_det_serv_pe", True, FMLoadResString(1605)) Then
                    PMChequea(sqlconn)
                    cmdBoton(0).Enabled = False
                    PLTSEstado()
                Else
                    PMChequea(sqlconn)
                End If
				cmdBoton_Click(cmdBoton(3), New EventArgs())
			Case 1
				If txtCampo(2).Text <> "" Then
					txtCampo(1).Text = ""
					txtCampo(2).Text = ""
					txtCampo(4).Text = ""
					lblDescripcion(0).Text = ""
					lblDescripcion(2).Text = ""
					optEstado(0).Checked = True
					txtCampo(1).Enabled = True
					txtCampo(2).Enabled = True
					txtCampo(4).Enabled = True
					COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
                    cmdBoton(4).Enabled = False
                    PMObjetoSeguridad(cmdBoton(0))
                    PLTSEstado()
					txtCampo(2).Focus()
				Else
					For i As Integer = 1 To 4
						txtCampo(i).Text = ""
					Next i
					For i As Integer = 0 To 2
						lblDescripcion(i).Text = ""
					Next i
					optEstado(0).Checked = True
					txtCampo(2).Enabled = True
					txtCampo(3).Enabled = True
					txtCampo(4).Enabled = True
					COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
					COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
					PMLimpiaGrid(grdProductos)
					txtCampo(3).Focus()
				End If
				PMObjetoSeguridad(cmdBoton(0))
				PMObjetoSeguridad(cmdBoton(4))
			Case 2
                Me.Close()
            Case 3
                If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1260), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                VTFilas = VGMaxRows
                VTRubro = "0"
                While VTFilas = VGMaxRows
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4017")
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(3).Text)
                    PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, VTRubro)
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cosub", True, FMLoadResString(1551)) Then
                        If VTRubro = "0" Then
                            PMMapeaGrid(sqlconn, grdProductos, False)
                        Else
                            PMMapeaGrid(sqlconn, grdProductos, True)
                        End If
                        PMMapeaTextoGrid(grdProductos)
                        PMChequea(sqlconn)
                        grdProductos.Col = 1
                        grdProductos.Row = grdProductos.Rows - 1
                        VTRubro = grdProductos.CtlText
                    Else
                        PMChequea(sqlconn)
                    End If
                    VTFilas = Conversion.Val(Convert.ToString(grdProductos.Tag))
                End While
                grdProductos.Row = 1
                PMAnchoColumnasGrid(grdProductos)
			Case 4
				If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1260), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(3).Focus()
					Exit Sub
				End If
				If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1271), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(2).Focus()
					Exit Sub
				End If
				If txtCampo(4).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1291), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(4).Focus()
					Exit Sub
                End If
                If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1427), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
				If optEstado(0).Checked Then
					VTEstado = "V"
				ElseIf optEstado(1).Checked Then 
					VTEstado = "N"
				End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4026")
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
				PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(3).Text)
				PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, txtCampo(2).Text)
				PMPasoValores(sqlconn, "@i_tipo_dato", 0, SQLCHAR, txtCampo(4).Text)
				PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, VTEstado)
				PMPasoValores(sqlconn, "@i_descripcion", 0, SQLCHAR, txtCampo(1).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_det_serv_pe", True, FMLoadResString(1588)) Then
                    PMChequea(sqlconn)
                    cmdBoton(4).Enabled = False
                    PLTSEstado()
                Else
                    PMChequea(sqlconn)
                End If
				cmdBoton_Click(cmdBoton(3), New EventArgs())
		End Select
	End Sub

	Private Sub FVarServ_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
		PMObjetoSeguridad(cmdBoton(3))
		PMObjetoSeguridad(cmdBoton(0))
        PMObjetoSeguridad(cmdBoton(4))
        cmdBoton(4).Enabled = False
        PLTSEstado()
	End Sub

	Private Sub FVarServ_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

    Private Sub grdProductos_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdProductos.ClickEvent
        grdProductos.Col = 0
        grdProductos.SelStartCol = 1
        grdProductos.SelEndCol = grdProductos.Cols - 1
        If grdProductos.Row = 0 Then
            grdProductos.SelStartRow = 1
            grdProductos.SelEndRow = 1
        Else
            grdProductos.SelStartRow = grdProductos.Row
            grdProductos.SelEndRow = grdProductos.Row
        End If
    End Sub

	Private Sub grdProductos_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdProductos.DblClick
		Dim VTRow As Integer = grdProductos.Row
        If txtCampo(3).Text <> "" Then
            grdProductos.Row = 1
            grdProductos.Col = 1
            If grdProductos.CtlText <> "" Then
                grdProductos.Row = VTRow
                PMMarcarRegistro()
                txtCampo(4).Enabled = False
                txtCampo(2).Enabled = False
                txtCampo(3).Enabled = False
            End If
        End If
    End Sub

	Private Sub grdProductos_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdProductos.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1391))
	End Sub

	Private Sub grdProductos_KeyUp(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles grdProductos.KeyUp
        grdProductos.Col = 0
		grdProductos.SelStartCol = 1
		grdProductos.SelEndCol = grdProductos.Cols - 1
		If grdProductos.Row = 0 Then
			grdProductos.SelStartRow = 1
			grdProductos.SelEndRow = 1
		Else
			grdProductos.SelStartRow = grdProductos.Row
			grdProductos.SelEndRow = grdProductos.Row
		End If
	End Sub

	Private Sub optEstado_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optEstado_0.Enter, _optEstado_1.Enter
		Dim Index As Integer = Array.IndexOf(optEstado, eventSender)
		Select Case Index
			Case 0, 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1337))
		End Select
	End Sub

	Private Sub PMMarcarRegistro()
		cmdBoton(0).Enabled = False
		PMObjetoSeguridad(cmdBoton(4))
		grdProductos.Col = 1
		txtCampo(2).Text = grdProductos.CtlText
		grdProductos.Col = 2
		lblDescripcion(0).Text = grdProductos.CtlText
		grdProductos.Col = 3
		If grdProductos.CtlText = "P" Then
			lblDescripcion(2).Text = "PORCENTAJE"
		Else
			lblDescripcion(2).Text = "MONTO"
		End If
		txtCampo(4).Text = grdProductos.CtlText
		grdProductos.Col = 4
		If grdProductos.CtlText = "V" Then
			optEstado(0).Checked = True
		Else
			optEstado(1).Checked = True
		End If
		grdProductos.Col = 5
        txtCampo(1).Text = grdProductos.CtlText
        PLTSEstado()
	End Sub

	Private isInitializingComponent As Boolean = false

	Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_4.TextChanged, _txtCampo_3.TextChanged, _txtCampo_1.TextChanged, _txtCampo_2.TextChanged
		If isInitializingComponent Then
			Exit Sub
		End If
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 2, 3, 4
				VLPaso = False
		End Select
	End Sub

	Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_4.Enter, _txtCampo_3.Enter, _txtCampo_1.Enter, _txtCampo_2.Enter
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		VLPaso = True
		Select Case Index
			Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1211))
			Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1690))
			Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1165))
			Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1778))
		End Select
		txtCampo(Index).SelectionStart = 0
		txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
	End Sub

	Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_4.KeyDown, _txtCampo_3.KeyDown, _txtCampo_1.KeyDown, _txtCampo_2.KeyDown
		Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		If KeyCode = VGTeclaAyuda Then
			VLPaso = True
			Select Case Index
                Case 2
                    PMCatalogo("A", "pe_rubro", txtCampo(2), lblDescripcion(0), FRegistros)
                    txtCampo(4).Focus()
                    VLPaso = True
				Case 3
					VLPaso = True
					VGOperacion = "sp_help_serv_pe"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4031")
					PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
					PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_serv_pe", True, FMLoadResString(1558)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        txtCampo(3).Text = VGACatalogo.Codigo
                        lblDescripcion(1).Text = VGACatalogo.Descripcion
                        txtCampo(2).Focus()
                        'If txtCampo(3).Text <> "" Then
                        '    cmdBoton_Click(cmdBoton(3), New EventArgs())
                        'End If
                        FRegistros.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                        VGOperacion = ""
                    End If
					VLPaso = True
                Case 4
                    PMCatalogo("A", "pe_tipo_dato", txtCampo(4), lblDescripcion(2), FRegistros)
                    txtCampo(1).Focus()
                    VLPaso = True
            End Select
		End If
	End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_4.KeyPress, _txtCampo_3.KeyPress, _txtCampo_1.KeyPress, _txtCampo_2.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 2, 1, 4
                If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 97) Or (KeyAscii > 122)) Then
                    KeyAscii = 0
                Else
                    KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                End If
			Case 3
				If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
					KeyAscii = 0
				End If
				KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
		End Select
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_4.Leave, _txtCampo_3.Leave, _txtCampo_1.Leave, _txtCampo_2.Leave
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 2
				If Not VLPaso Then
					If txtCampo(2).Text <> "" Then
                        PMCatalogo("V", "pe_rubro", txtCampo(2), lblDescripcion(0), Nothing)
                        If lblDescripcion(0).Text = "" Then
                            txtCampo(2).Text = ""
                            lblDescripcion(0).Text = ""
                            txtCampo(2).Focus()
                        Else
                            txtCampo(4).Focus()
                        End If
                    Else
                        txtCampo(2).Text = ""
                        lblDescripcion(0).Text = ""
                        txtCampo(2).Focus()
                    End If
                End If
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
			Case 3
				If Not VLPaso Then
					If txtCampo(3).Text <> "" Then
						PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4031")
						PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
						PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(3).Text)
						PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_serv_pe", True, FMLoadResString(1558)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(1))
                            PMChequea(sqlconn)
                            txtCampo(2).Focus()
                            'cmdBoton_Click(cmdBoton(3), New EventArgs())
                        Else
                            PMChequea(sqlconn)
                            txtCampo(3).Text = ""
                            lblDescripcion(1).Text = ""
                            txtCampo(3).Focus()
                        End If
					Else
						VLPaso = True
						lblDescripcion(1).Text = ""
					End If
                End If
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
			Case 4
				If Not VLPaso Then
					If txtCampo(4).Text <> "" Then
                        PMCatalogo("V", "pe_tipo_dato", txtCampo(4), lblDescripcion(2), Nothing)
                        txtCampo(1).Focus()
                        If lblDescripcion(2).Text = "" Then
                            txtCampo(4).Text = ""
                            lblDescripcion(2).Text = ""
                            txtCampo(4).Focus()
                        End If
					Else
						txtCampo(4).Text = ""
                        lblDescripcion(2).Text = ""
                        txtCampo(4).Focus()
					End If
                End If
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		End Select
	End Sub

	Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_4.MouseDown, _txtCampo_3.MouseDown, _txtCampo_1.MouseDown, _txtCampo_2.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 2, 3, 4
				My.Computer.Clipboard.Clear()
        End Select
	End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_3.Enabled
        TSBBuscar.Visible = _cmdBoton_3.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBCrear.Enabled = _cmdBoton_0.Enabled
        TSBCrear.Visible = _cmdBoton_0.Visible
        TSBActualizar.Enabled = _cmdBoton_4.Enabled
        TSBActualizar.Visible = _cmdBoton_4.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

    Private Sub _optEstado_0_Leave(sender As Object, e As EventArgs) Handles _optEstado_0.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
    End Sub

    Private Sub _optEstado_1_Leave(sender As Object, e As EventArgs) Handles _optEstado_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
    End Sub

    Private Sub grdProductos_Leave(sender As Object, e As EventArgs) Handles grdProductos.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
    End Sub
End Class


