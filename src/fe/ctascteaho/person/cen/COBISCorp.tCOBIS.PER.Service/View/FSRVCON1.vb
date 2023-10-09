Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
Imports COBISCorp.tCOBIS.PER.Cost
 Public  Partial  Class FsrvconClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

	Dim VLPaso As Integer = 0
	Dim VLTipo As Integer = 0

	Private Sub cmbCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1779))
	End Sub

	Private Sub cmbCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbCuenta.Leave
		If cmbCuenta.Text <> "" Then
			If cmbCuenta.Text = "CTA CORRIENTE" Then
				mskCuenta.Mask = VGMascaraCtaCte
			Else
				mskCuenta.Mask = VGMascaraCtaAho
			End If
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
	End Sub

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_4.Click, _cmdBoton_1.Click, _cmdBoton_3.Click, _cmdBoton_2.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Dim VTEstado As String = ""
		Dim VTFilas As Integer = 0
		Dim VTServicio As String = ""
		Select Case Index
			Case 0
				If mskCuenta.ClipText = "" Then
                    COBISMessageBox.Show(FMLoadResString(1251), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					mskCuenta.Focus()
					Exit Sub
				End If
				If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1260), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(1).Focus()
					Exit Sub
				End If
				If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1243), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(2).Focus()
					Exit Sub
				End If
				If optEstado(0).Checked Then
					VTEstado = "V"
				ElseIf optEstado(1).Checked Then 
					VTEstado = "N"
				End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4019")
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
				PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, mskCuenta.ClipText)
				PMPasoValores(sqlconn, "@i_ciclo", 0, SQLCHAR, txtCampo(2).Text)
				PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, VTEstado)
				PMPasoValores(sqlconn, "@i_servicio_dis", 0, SQLINT2, txtCampo(1).Text)
				If cmbCuenta.Text = "CTA AHORROS" Then
					PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, "4")
				Else
					PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, "3")
				End If
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_serv_contratado", True, FMLoadResString(1603)) Then
                    PMChequea(sqlconn)
                    cmdBoton(0).Enabled = False
                    PLTSEstado()
                Else
                    PMChequea(sqlconn)
                End If
				cmdBoton_Click(cmdBoton(3), New EventArgs())
			Case 1
				PMLimpiaGrid(grdServicios)
				cmbCuenta.Items.Clear()
				For i As Integer = 1 To 2
					txtCampo(i).Text = ""
				Next i
				txtCampo(1).Enabled = True
				For i As Integer = 0 To 3
					lblDescripcion(i).Text = ""
				Next i
				optEstado(0).Checked = True
				COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
				COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
				cmbCuenta.Items.Insert(0, "CTA AHORROS")
				cmbCuenta.Items.Insert(1, "CTA CORRIENTE")
				cmbCuenta.SelectedIndex = 0
				cmdBoton(0).Enabled = True
                cmdBoton(4).Enabled = False
                PLTSEstado()
				If VLTipo Then
					mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
				Else
					mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
				End If
			Case 2
                Me.Close()
            Case 3
                If mskCuenta.ClipText = "" Then
                    COBISMessageBox.Show(FMLoadResString(1251), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                    Exit Sub
                End If
                VTFilas = VGMaxRows
                VTServicio = "0"
                While VTFilas = VGMaxRows
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4021")
                    If cmbCuenta.Text = "CTA AHORROS" Then
                        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
                    Else
                        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "3")
                    End If
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_servicio_dis", 0, SQLINT2, VTServicio)
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_serv_contratado", True, FMLoadResString(1559)) Then
                        If VTServicio = "0" Then
                            PMMapeaGrid(sqlconn, grdServicios, False)
                        Else
                            PMMapeaGrid(sqlconn, grdServicios, True)
                        End If
                        PMMapeaTextoGrid(grdServicios)
                        PMChequea(sqlconn)
                        If Conversion.Val(Convert.ToString(grdServicios.Tag)) > 0 Then
                            grdServicios.ColAlignment(5) = 2
                        End If
                        grdServicios.Row = grdServicios.Rows - 1
                        grdServicios.Col = 1
                        VTServicio = grdServicios.CtlText
                    Else
                        PMChequea(sqlconn)
                    End If
                    VTFilas = Conversion.Val(Convert.ToString(grdServicios.Tag))
                End While
                grdServicios.Row = 1
			Case 4
				If mskCuenta.ClipText = "" Then
                    COBISMessageBox.Show(FMLoadResString(1251), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					mskCuenta.Focus()
					Exit Sub
				End If
				If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1260), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(1).Focus()
					Exit Sub
				End If
				If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1243), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(2).Focus()
					Exit Sub
				End If
				If optEstado(0).Checked Then
					VTEstado = "V"
				ElseIf optEstado(1).Checked Then 
					VTEstado = "N"
				End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4020")
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
				PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, mskCuenta.ClipText)
				PMPasoValores(sqlconn, "@i_ciclo", 0, SQLCHAR, txtCampo(2).Text)
				PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, VTEstado)
				PMPasoValores(sqlconn, "@i_servicio_dis", 0, SQLINT2, txtCampo(1).Text)
				If cmbCuenta.Text = "CTA AHORROS" Then
					PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, "4")
				Else
					PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, "3")
				End If
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_serv_contratado", True, FMLoadResString(1586)) Then
                    PMChequea(sqlconn)
                    cmdBoton(4).Enabled = False
                Else
                    PMChequea(sqlconn)
                End If
                PLTSEstado()
		End Select
	End Sub

	Private Sub Fsrvcon_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
		cmbCuenta.Items.Clear()
		cmbCuenta.Items.Insert(0, "CTA AHORROS")
		cmbCuenta.Items.Insert(1, "CTA CORRIENTE")
		cmbCuenta.SelectedIndex = 0
		mskCuenta.Mask = VGMascaraCtaAho
		PMObjetoSeguridad(cmdBoton(3))
		PMObjetoSeguridad(cmdBoton(0))
        PMObjetoSeguridad(cmdBoton(4))
        PLTSEstado()
	End Sub

	Private Sub Fsrvcon_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
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
		grdServicios.Row = 1
		grdServicios.Col = 1
		If grdServicios.CtlText <> "" Then
			grdServicios.Row = VTRow
			PMMarcarRegistro()
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

	Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
		If cmbCuenta.Text <> "" Then
			If cmbCuenta.Text = "CTA CORRIENTE" Then
				mskCuenta.Mask = VGMascaraCtaCte
			Else
				mskCuenta.Mask = VGMascaraCtaAho
			End If
		End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1529))
		mskCuenta.SelectionStart = 0
		mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
	End Sub

	Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
		Try 
			If cmbCuenta.Text = "" Then
                COBISMessageBox.Show(FMLoadResString(1289), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
				cmbCuenta.Focus()
				Exit Sub
			End If
			If mskCuenta.ClipText <> "" Then
				If cmbCuenta.Text = "CTA CORRIENTE" Then
					If FMChequeaCtaCte(mskCuenta.ClipText) Then
						VLTipo = True
						PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "16")
						PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
						PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, FMLoadResString(1574) & "[" & mskCuenta.Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(0))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                            lblDescripcion(0).Text = ""
                            mskCuenta.Focus()
                        End If
					Else
                        COBISMessageBox.Show(FMLoadResString(1278), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
						lblDescripcion(0).Text = ""
						mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
						mskCuenta.Focus()
						VLPaso = True
						Exit Sub
					End If
				Else
					If FMChequeaCtaAho(mskCuenta.ClipText) Then
						VLTipo = False
						PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
						PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
						PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(1574) & "[" & mskCuenta.Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(0))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                            lblDescripcion(0).Text = ""
                            mskCuenta.Focus()
                        End If
					Else
                        COBISMessageBox.Show(FMLoadResString(1279), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
						lblDescripcion(0).Text = ""
						mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
						mskCuenta.Focus()
						VLPaso = True
						Exit Sub
					End If
				End If
			Else
				lblDescripcion(0).Text = ""
            End If
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		Catch exc As System.Exception
			NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
		End Try
	End Sub

	Private Sub PMMarcarRegistro()
		cmdBoton(4).Enabled = True
		cmdBoton(0).Enabled = False
		grdServicios.Col = 1
		txtCampo(1).Text = grdServicios.CtlText
		txtCampo(1).Enabled = False
		grdServicios.Col = 2
		lblDescripcion(2).Text = grdServicios.CtlText
		grdServicios.Col = 3
		txtCampo(2).Text = grdServicios.CtlText
		grdServicios.Col = 4
		lblDescripcion(3).Text = grdServicios.CtlText
		grdServicios.Col = 5
		lblDescripcion(1).Text = grdServicios.CtlText
		grdServicios.Col = 6
		If grdServicios.CtlText = "V" Then
			optEstado(0).Checked = True
		Else
			optEstado(1).Checked = True
        End If
        PLTSEstado()
	End Sub

	Private isInitializingComponent As Boolean = false

	Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.TextChanged, _txtCampo_1.TextChanged
		If isInitializingComponent Then
			Exit Sub
		End If
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 1, 2
				VLPaso = False
		End Select
	End Sub

	Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.Enter, _txtCampo_1.Enter
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1164))
			Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1081))
		End Select
		txtCampo(Index).SelectionStart = 0
		txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
	End Sub

	Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_2.KeyDown, _txtCampo_1.KeyDown

		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If eventArgs.KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 1
                    VGOperacion = "sp_help_serv_pe"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4031")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_serv_pe", False, FMLoadResString(1596)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        If VGACatalogo.Codigo <> "" Then
                            txtCampo(1).Text = VGACatalogo.Codigo
                            lblDescripcion(2).Text = VGACatalogo.Descripcion
                            VLPaso = True
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                        VGOperacion = ""
                    End If
                    txtCampo(1).Text = VGACatalogo.Codigo
                    lblDescripcion(2).Text = VGACatalogo.Descripcion
                Case 2
                    PMCatalogo("A", "pe_ciclo", txtCampo(2), lblDescripcion(3), FRegistros)
            End Select
        End If
	End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_2.KeyPress, _txtCampo_1.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0, 2
				If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 65) Or (KeyAscii > 123)) Then
					KeyAscii = 0
				Else
					KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
				End If
			Case 1, 3
				If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
					KeyAscii = 0
				End If
		End Select
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.Leave, _txtCampo_1.Leave
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 1
				If Not VLPaso Then
					If txtCampo(1).Text <> "" Then
						PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4031")
						PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
						PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(1).Text)
						If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_serv_pe", False, "") Then
							PMMapeaObjeto(sqlconn, lblDescripcion(2))
							PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            lblDescripcion(2).Text = ""
                            txtCampo(1).Text = ""
                            VLPaso = True
						End If
					Else
						lblDescripcion(2).Text = ""
					End If
                End If
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
			Case 2
				If Not VLPaso Then
					If txtCampo(2).Text <> "" Then
                        PMCatalogo("V", "pe_ciclo", txtCampo(2), lblDescripcion(3), Nothing)
					Else
						lblDescripcion(3).Text = ""
					End If
                End If
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
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

    Private Sub _optEstado_0_Enter(sender As Object, e As EventArgs) Handles _optEstado_0.Enter, _optEstado_1.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1337))
    End Sub

    Private Sub _optEstado_0_Leave(sender As Object, e As EventArgs) Handles _optEstado_0.Leave, _optEstado_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(""))
    End Sub

    Private Sub grdServicios_Leave(sender As Object, e As EventArgs) Handles grdServicios.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
    End Sub
End Class


