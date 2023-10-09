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
 Public  Partial  Class FTipRangoClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Dim VLPaso As Integer = 0

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_0.Click, _cmdBoton_3.Click, _cmdBoton_2.Click, _cmdBoton_1.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Dim VTEstado As String = ""
		Dim VTFilas As Integer = 0
        Dim VTTipoRango As String = ""
        TSBotones.Focus()
		Select Case Index
			Case 0
				If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1290), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(0).Focus()
					Exit Sub
				End If
				If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1257), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(1).Focus()
					Exit Sub
				End If
				If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1428), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(2).Focus()
					Exit Sub
				End If
				If optEstado(0).Checked Then
					VTEstado = "V"
				ElseIf optEstado(1).Checked Then 
					VTEstado = "N"
				End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4032")
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
				PMPasoValores(sqlconn, "@i_descripcion", 0, SQLCHAR, txtCampo(2).Text)
				PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, VTEstado)
				PMPasoValores(sqlconn, "@i_atributo", 0, SQLCHAR, txtCampo(0).Text)
				PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, txtCampo(1).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tip_rng_pe", True, FMLoadResString(1579)) Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(1))
                    PMChequea(sqlconn)
                    cmdBoton(0).Enabled = False
                    PMLimpiaG(grdRangos)
                    cmdBoton_Click(cmdBoton(3), New EventArgs())
                Else
                    PMChequea(sqlconn)
                End If
			Case 1
				txtCampo(2).Text = ""
				txtCampo(1).Text = ""
				txtCampo(1).Enabled = True
				txtCampo(0).Text = ""
				txtCampo(0).Enabled = True
				lblDescripcion(0).Text = ""
				lblDescripcion(1).Text = ""
				lblDescripcion(2).Text = ""
				optEstado(0).Checked = True
				PMObjetoSeguridad(cmdBoton(0))
				PMObjetoSeguridad(cmdBoton(4))
                cmdBoton_Click(cmdBoton(3), New EventArgs())
                cmdBoton(4).Enabled = False
                cmdBoton(0).Enabled = True
                'COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
                txtCampo(0).Focus()
			Case 2
                Me.Close()
            Case 3
                VTFilas = VGMaxRows
                VTTipoRango = "0"
                While VTFilas = VGMaxRows
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4034")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT2, VTTipoRango)
                    If txtCampo(0).Text <> "" Then
                        PMPasoValores(sqlconn, "@i_atributo", 0, SQLCHAR, txtCampo(0).Text)
                    End If
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tip_rng_pe", True, FMLoadResString(1562)) Then
                        If VTTipoRango = "0" Then
                            PMMapeaGrid(sqlconn, grdRangos, False)
                        Else
                            PMMapeaGrid(sqlconn, grdRangos, True)
                        End If
                        PMMapeaTextoGrid(grdRangos)
                        PMAnchoColumnasGrid(grdRangos)
                        PMChequea(sqlconn)
                        If Conversion.Val(Convert.ToString(grdRangos.Tag)) > 0 Then
                            grdRangos.ColAlignment(7) = 2
                        End If
                        VTFilas = Conversion.Val(Convert.ToString(grdRangos.Tag))
                        grdRangos.Col = 1
                        grdRangos.Row = grdRangos.Rows - 1
                        VTTipoRango = grdRangos.CtlText
                    Else
                        PMChequea(sqlconn)
                    End If
                End While
                grdRangos.Row = 1
			Case 4
				If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1290), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(0).Focus()
					Exit Sub
				End If
				If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1257), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(1).Focus()
					Exit Sub
				End If
				If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1428), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(2).Focus()
					Exit Sub
				End If
				If optEstado(0).Checked Then
					VTEstado = "V"
				ElseIf optEstado(1).Checked Then 
					VTEstado = "N"
				End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4033")
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
				PMPasoValores(sqlconn, "@i_descripcion", 0, SQLCHAR, txtCampo(2).Text)
				PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, VTEstado)
				PMPasoValores(sqlconn, "@i_atributo", 0, SQLCHAR, txtCampo(0).Text)
				PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT2, lblDescripcion(1).Text)
				PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, txtCampo(1).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tip_rng_pe", True, FMLoadResString(1541)) Then
                    PMChequea(sqlconn)
                    cmdBoton(4).Enabled = False
                    PMLimpiaG(grdRangos)
                    'cmdBoton_Click(cmdBoton(1), New EventArgs())
                    cmdBoton_Click(cmdBoton(3), New EventArgs())
                Else
                    PMChequea(sqlconn)
                End If
        End Select
        PLTSEstado()
	End Sub

	Private Sub FTipRango_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
		PMObjetoSeguridad(cmdBoton(3))
		PMObjetoSeguridad(cmdBoton(0))
        PMObjetoSeguridad(cmdBoton(4))
        cmdBoton(4).Enabled = False
        cmdBoton_Click(cmdBoton(3), New EventArgs())
        PLTSEstado()
	End Sub

	Private Sub FTipRango_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

    Private Sub grdRangos_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRangos.ClickEvent
        grdRangos.Col = 0
        grdRangos.SelStartCol = 1
        grdRangos.SelEndCol = grdRangos.Cols - 1
        If grdRangos.Row = 0 Then
            grdRangos.SelStartRow = 1
            grdRangos.SelEndRow = 1
        Else
            grdRangos.SelStartRow = grdRangos.Row
            grdRangos.SelEndRow = grdRangos.Row
        End If
    End Sub

	Private Sub grdRangos_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdRangos.DblClick
		Dim VTRow As Integer = grdRangos.Row
		grdRangos.Row = 1
		grdRangos.Col = 1
		If grdRangos.CtlText <> "" Then
			grdRangos.Row = VTRow
			PMMarcarRegistro()
			txtCampo(0).Enabled = False
			txtCampo(1).Enabled = False
		End If
	End Sub

	Private Sub grdRangos_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRangos.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1391))
	End Sub

	Private Sub grdRangos_KeyUp(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles grdRangos.KeyUp
        grdRangos.Col = 0
		grdRangos.SelStartCol = 1
		grdRangos.SelEndCol = grdRangos.Cols - 1
		If grdRangos.Row = 0 Then
			grdRangos.SelStartRow = 1
			grdRangos.SelEndRow = 1
		Else
			grdRangos.SelStartRow = grdRangos.Row
			grdRangos.SelEndRow = grdRangos.Row
		End If
	End Sub

	Private Sub optEstado_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optEstado_1.Enter, _optEstado_0.Enter
		Dim Index As Integer = Array.IndexOf(optEstado, eventSender)
		Select Case Index
			Case 0, 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1338))
		End Select
	End Sub

	Private Sub PMMarcarRegistro()
		PMObjetoSeguridad(cmdBoton(4))
		cmdBoton(0).Enabled = False
		grdRangos.Col = 1
		lblDescripcion(1).Text = grdRangos.CtlText
		grdRangos.Col = 2
		txtCampo(2).Text = grdRangos.CtlText
		grdRangos.Col = 3
		txtCampo(0).Text = grdRangos.CtlText
		grdRangos.Col = 4
		lblDescripcion(0).Text = grdRangos.CtlText
		grdRangos.Col = 5
		txtCampo(1).Text = grdRangos.CtlText
		grdRangos.Col = 6
		lblDescripcion(2).Text = grdRangos.CtlText
		grdRangos.Col = 7
		If grdRangos.CtlText = "V" Then
			optEstado(0).Checked = True
		Else
			optEstado(1).Checked = True
        End If
        PLTSEstado()
	End Sub

	Private isInitializingComponent As Boolean = false

	Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.TextChanged, _txtCampo_0.TextChanged, _txtCampo_2.TextChanged
		If isInitializingComponent Then
			Exit Sub
		End If
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0, 1
				VLPaso = False
		End Select
	End Sub

	Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Enter, _txtCampo_0.Enter, _txtCampo_2.Enter
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		VLPaso = True
		Select Case Index
			Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1762))
			Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1482))
			Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1210))
		End Select
		txtCampo(Index).SelectionStart = 0
		txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
	End Sub

	Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_1.KeyDown, _txtCampo_0.KeyDown, _txtCampo_2.KeyDown
		Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		If KeyCode = VGTeclaAyuda Then
			VLPaso = True
			Select Case Index
                Case 0
                    PMCatalogo("A", "pe_tipo_atributo", txtCampo(0), lblDescripcion(0), FRegistros)
                    If txtCampo(0).Text = "" Then
                        txtCampo(0).Focus()
                    End If
                    VLPaso = True
				Case 1
					VGOperacion = "sp_moneda"
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_moneda")
					PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(1110)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMAnchoColumnasGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        If VGACatalogo.Codigo <> "" Then
                            txtCampo(1).Text = VGACatalogo.Codigo
                            lblDescripcion(2).Text = VGACatalogo.Descripcion
                            VLPaso = True
                        Else
                            txtCampo(1).Text = ""
                            lblDescripcion(2).Text = ""
                            txtCampo(1).Focus()
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                        VGOperacion = ""
                    End If
			End Select
		End If
	End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_1.KeyPress, _txtCampo_0.KeyPress, _txtCampo_2.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
            Case 0
                If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 96) Or (KeyAscii > 122)) Then
                    KeyAscii = 0
                Else
                    KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                End If
			Case 1
				If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
					KeyAscii = 0
				Else
					KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                End If
            Case 2
                If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 96) Or (KeyAscii > 122)) Then
                    KeyAscii = 0
                Else
                    KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                End If
        End Select
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Leave, _txtCampo_0.Leave, _txtCampo_2.Leave
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0
				If Not VLPaso Then
					If txtCampo(0).Text <> "" Then
                        PMCatalogo("V", "pe_tipo_atributo", txtCampo(0), lblDescripcion(0), Nothing)
                        If txtCampo(0).Text = "" Then
                            txtCampo(0).Focus()
                            VLPaso = True
                        End If
                    End If
                End If
			Case 1
				If Not VLPaso Then
					If txtCampo(1).Text <> "" Then
						PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_moneda")
						PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
						PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtCampo(1).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(1108) & "[" & txtCampo(Index).Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(2))
                            PMChequea(sqlconn)
                        Else
                            VLPaso = True
                            txtCampo(1).Text = ""
                            lblDescripcion(2).Text = ""
                            txtCampo(1).Focus()
                            PMChequea(sqlconn)
                        End If
					Else
						lblDescripcion(2).Text = ""
					End If
				End If
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
	End Sub

	Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_1.MouseDown, _txtCampo_0.MouseDown, _txtCampo_2.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0, 1
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

    Private Sub _optEstado_0_Leave(sender As Object, e As EventArgs) Handles _optEstado_0.Leave, _optEstado_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
    End Sub

End Class


