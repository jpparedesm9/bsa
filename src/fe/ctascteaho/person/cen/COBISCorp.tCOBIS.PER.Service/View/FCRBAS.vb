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
 Public  Partial  Class FCreaBasClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Dim VLPaso As Integer = 0

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_6.Click, _cmdBoton_0.Click, _cmdBoton_4.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_1.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Dim VTEstado As String = ""
		Dim VTFilas As Integer = 0
		Dim VTMercado As String = string.Empty
		Dim  VTServicio As String = string.Empty
		Select Case Index
			Case 0
				If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1260), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(0).Focus()
                    Exit Sub
                Else
                    If Val(txtCampo(0).Text) > 32767 Then
                        COBISMessageBox.Show(FMLoadResString(1142), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(0).Focus()
                        Exit Sub
                    End If
                End If
				If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1266), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(1).Focus()
                    Exit Sub
                Else
                    If Val(txtCampo(1).Text) > 32767 Then
                        COBISMessageBox.Show(FMLoadResString(1142), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(0).Focus()
                        Exit Sub
                    End If
                End If
				If optEstado(0).Checked Then
					VTEstado = "V"
				Else
					VTEstado = "N"
				End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4040")
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
				PMPasoValores(sqlconn, "@i_mercado", 0, SQLINT2, txtCampo(1).Text)
				PMPasoValores(sqlconn, "@i_servicio", 0, SQLINT2, txtCampo(0).Text)
				PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, VTEstado)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_basico_pe", True, FMLoadResString(1604)) Then
                    PMChequea(sqlconn)
                    cmdBoton(0).Enabled = False
                    cmdBoton_Click(cmdBoton(3), New EventArgs())
                Else
                    PMChequea(sqlconn)
                End If
			Case 1
				If txtCampo(0).Text <> "" Then
					txtCampo(0).Text = ""
					lblDescripcion(1).Text = ""
					txtCampo(0).Enabled = True
					txtCampo(0).Focus()
				Else
					txtCampo(1).Text = ""
					lblDescripcion(0).Text = ""
					txtCampo(1).Enabled = True
					txtCampo(1).Focus()
				End If
				optEstado(0).Checked = True
				COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
				COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
				cmdBoton(0).Enabled = True
				cmdBoton(4).Enabled = False
				cmdBoton_Click(cmdBoton(3), New EventArgs())
			Case 2
                Me.Close()
            Case 3
                VTFilas = VGMaxRows
                VTMercado = "0"
                VTServicio = "0"
                While VTFilas = VGMaxRows
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4041")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_mercado", 0, SQLINT2, VTMercado)
                    PMPasoValores(sqlconn, "@i_servicio", 0, SQLINT2, VTServicio)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_basico_pe", True, FMLoadResString(1559)) Then
                        If VTMercado = "0" And VTServicio = "0" Then
                            PMMapeaGrid(sqlconn, grdServicios, False)
                        Else
                            PMMapeaGrid(sqlconn, grdServicios, True)
                        End If
                        PMMapeaTextoGrid(grdServicios)
                        PMChequea(sqlconn)
                        grdServicios.Col = 1
                        grdServicios.Row = grdServicios.Rows - 1
                        VTMercado = grdServicios.CtlText
                        grdServicios.Col = 3
                        grdServicios.Row = grdServicios.Rows - 1
                        VTServicio = grdServicios.CtlText
                        If Conversion.Val(Convert.ToString(grdServicios.Tag)) > 0 Then
                            grdServicios.ColAlignment(5) = 2
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
                    VTFilas = Conversion.Val(Convert.ToString(grdServicios.Tag))
                End While
                grdServicios.Col = 1
			Case 4
				If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1260), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(0).Focus()
					Exit Sub
				End If
				If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1266), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(1).Focus()
					Exit Sub
				End If
				If optEstado(0).Checked Then
					VTEstado = "V"
				Else
					VTEstado = "N"
				End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4042")
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
				PMPasoValores(sqlconn, "@i_mercado", 0, SQLINT2, txtCampo(1).Text)
				PMPasoValores(sqlconn, "@i_servicio", 0, SQLINT2, txtCampo(0).Text)
				PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, VTEstado)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_basico_pe", True, FMLoadResString(1587)) Then
                    PMChequea(sqlconn)
                    cmdBoton(4).Enabled = False
                    cmdBoton_Click(cmdBoton(3), New EventArgs())
                Else
                    PMChequea(sqlconn)
                End If
        End Select
        PLTSEstado()
	End Sub

	Private Sub FCreaBas_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
		PMObjetoSeguridad(cmdBoton(3))
		PMObjetoSeguridad(cmdBoton(6))
		PMObjetoSeguridad(cmdBoton(0))
		PMObjetoSeguridad(cmdBoton(4))
        cmdBoton_Click(cmdBoton(3), New EventArgs())
        PLTSEstado()
	End Sub

	Private Sub FCreaBas_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

    Private Sub grdServicios_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdServicios.ClickEvent
        grdServicios.Col = 0
        grdServicios.SelStartCol = 1
        grdServicios.SelEndCol = grdServicios.Cols - 1
        If grdServicios.Row = 0 Then
            grdServicios.SelStartRow = 1
            grdServicios.SelEndRow = 1
        Else
            grdServicios.SelStartRow = grdServicios.Row
            grdServicios.SelEndRow = grdServicios.Row
        End If
    End Sub

	Private Sub grdServicios_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdServicios.DblClick
		Dim VTRow As Integer = grdServicios.Row
		grdServicios.Col = 1
		grdServicios.Row = 1
		If grdServicios.CtlText <> "" Then
			grdServicios.Row = VTRow
			PMMarcarRegistro()
			cmdBoton(4).Enabled = True
			cmdBoton(0).Enabled = False
			txtCampo(0).Enabled = False
            txtCampo(1).Enabled = False
            PLTSEstado()
		End If
	End Sub

	Private Sub grdServicios_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdServicios.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1391))
	End Sub

	Private Sub grdServicios_KeyUp(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles grdServicios.KeyUp
        grdServicios.Col = 0
		grdServicios.SelStartCol = 1
		grdServicios.SelEndCol = grdServicios.Cols - 1
		If grdServicios.Row = 0 Then
			grdServicios.SelStartRow = 1
			grdServicios.SelEndRow = 1
		Else
			grdServicios.SelStartRow = grdServicios.Row
			grdServicios.SelEndRow = grdServicios.Row
		End If
	End Sub

	Private Sub optEstado_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optEstado_1.Enter, _optEstado_0.Enter
		Dim Index As Integer = Array.IndexOf(optEstado, eventSender)
		Select Case Index
			Case 0, 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1337))
		End Select
	End Sub

	Private Sub PMMarcarRegistro()
		grdServicios.Col = 1
		txtCampo(1).Text = grdServicios.CtlText
		grdServicios.Col = 2
		lblDescripcion(0).Text = grdServicios.CtlText
		grdServicios.Col = 3
		txtCampo(0).Text = grdServicios.CtlText
		grdServicios.Col = 4
		lblDescripcion(1).Text = grdServicios.CtlText
		grdServicios.Col = 5
		If grdServicios.CtlText = "V" Then
			optEstado(0).Checked = True
		Else
			optEstado(1).Checked = True
		End If
	End Sub

	Private isInitializingComponent As Boolean = false

	Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.TextChanged, _txtCampo_0.TextChanged
		If isInitializingComponent Then
			Exit Sub
		End If
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0, 1
				VLPaso = False
		End Select
	End Sub

	Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Enter, _txtCampo_0.Enter
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		VLPaso = True
		Select Case Index
			Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1165))
			Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1162))
		End Select
		txtCampo(Index).SelectionStart = 0
		txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
	End Sub

	Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_1.KeyDown, _txtCampo_0.KeyDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If eventArgs.KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    VGOperacion = "sp_help_serv_pe"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4031")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT4, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_serv_pe", False, FMLoadResString(1596)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        txtCampo(0).Text = VGACatalogo.Codigo
                        lblDescripcion(1).Text = VGACatalogo.Descripcion
                        FRegistros.Dispose() '18/05/2016 migracion
                        VLPaso = True
                    Else
                        PMChequea(sqlconn)
                        VGOperacion = ""
                    End If
                Case 1
                    VGOperacion = "sp_prodfin"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4012")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", False, "") Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        If VGValores(1) <> "" Then
                            txtCampo(1).Text = VGValores(1)
                            lblDescripcion(0).Text = VGValores(2) & " " & VGValores(3)
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                        VLPaso = True
                    Else
                        PMChequea(sqlconn)
                        VGOperacion = ""
                    End If
            End Select
        End If
	End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_1.KeyPress, _txtCampo_0.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0, 1
				If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
					KeyAscii = 0
				End If
		End Select
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Leave, _txtCampo_0.Leave
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0
				If Not VLPaso Then
					If txtCampo(0).Text <> "" Then
						PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4031")
						PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
						PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(0).Text)
						If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_serv_pe", False, "") Then
							PMMapeaObjeto(sqlconn, lblDescripcion(1))
							PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            lblDescripcion(1).Text = ""
                            txtCampo(0).Text = ""
                            txtCampo(0).Focus()
						End If
					Else
						lblDescripcion(1).Text = ""
					End If
				End If
			Case 1
				If Not VLPaso Then
					If txtCampo(1).Text <> "" Then
						PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4045")
						PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
						PMPasoValores(sqlconn, "@i_cod_merc", 0, SQLINT2, txtCampo(1).Text)
						If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, "") Then
							PMMapeaObjeto(sqlconn, lblDescripcion(0))
							PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            lblDescripcion(0).Text = ""
                            txtCampo(1).Text = ""
                            txtCampo(1).Focus()
						End If
					Else
						lblDescripcion(0).Text = ""
					End If
				End If
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
	End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
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
    Private Sub PLTSEstado()
        TSBBuscar.Visible = _cmdBoton_3.Visible
        TSBSiguientes.Visible = _cmdBoton_6.Visible
        TSBCrear.Visible = _cmdBoton_0.Visible
        TSBActualizar.Visible = _cmdBoton_4.Visible
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBBuscar.Visible = _cmdBoton_3.Enabled
        TSBSiguientes.Visible = _cmdBoton_6.Enabled
        TSBCrear.Visible = _cmdBoton_0.Enabled
        TSBActualizar.Visible = _cmdBoton_4.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Enabled
        TSBSalir.Visible = _cmdBoton_2.Enabled
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

    Private Sub _optEstado_0_Leave(sender As Object, e As EventArgs) Handles _optEstado_0.Leave, _optEstado_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
    End Sub

    Private Sub grdServicios_Leave(sender As Object, e As EventArgs) Handles grdServicios.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
    End Sub

End Class


