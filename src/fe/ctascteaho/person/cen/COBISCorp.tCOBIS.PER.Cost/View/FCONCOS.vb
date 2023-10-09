Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
 Public  Partial  Class FConCostosClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Dim VLPaso As Integer = 0

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_2.Click, _cmdBoton_1.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Dim VTFilas As Integer = 0
		Dim VTRango As String = string.Empty
		Dim  VTCategoria As String = string.Empty
		Select Case Index
			Case 0
				If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1274), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(0).Focus()
					Exit Sub
				End If
				If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1273), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(3).Focus()
					Exit Sub
				End If
				If txtCampo(2).Text = "" Then
					VTFilas = VGMaxRows
					VTRango = "0"
					VTCategoria = "0"
					While VTFilas = VGMaxRows
						PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4052")
						PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
						PMPasoValores(sqlconn, "@i_servicio_per", 0, SQLINT2, txtCampo(3).Text)
						PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, VTCategoria)
						PMPasoValores(sqlconn, "@i_rango", 0, SQLINT1, VTRango)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_consulta_costos", True, FMLoadResString(1592)) Then
                            If VTRango = "0" Then
                                PMMapeaGrid(sqlconn, grdRegistros, False)
                            Else
                                PMMapeaGrid(sqlconn, grdRegistros, True)
                            End If
                            PMMapeaTextoGrid(grdRegistros)
                            PMChequea(sqlconn)
                            If Conversion.Val(Convert.ToString(grdRegistros.Tag)) > 0 Then
                                grdRegistros.ColAlignment(5) = 1
                                grdRegistros.ColAlignment(6) = 1
                                grdRegistros.ColAlignment(7) = 1
                                grdRegistros.ColAlignment(8) = 1
                                grdRegistros.ColAlignment(9) = 1
                                grdRegistros.ColAlignment(10) = 2
                            End If
                            grdRegistros.Col = 1
                            grdRegistros.Row = grdRegistros.Rows - 1
                            VTCategoria = grdRegistros.CtlText
                            grdRegistros.Col = 4
                            grdRegistros.Row = grdRegistros.Rows - 1
                            VTRango = grdRegistros.CtlText
                        Else
                            PMChequea(sqlconn)
                        End If
						VTFilas = Conversion.Val(Convert.ToString(grdRegistros.Tag))
					End While
					grdRegistros.Col = 1
					Exit Sub
				End If
				VTFilas = VGMaxRows
				VTRango = "0"
				While VTFilas = VGMaxRows
					PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4052")
					PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "I")
					PMPasoValores(sqlconn, "@i_servicio_per", 0, SQLINT2, txtCampo(3).Text)
					PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text)
					PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT2, lblDescripcion(2).Text)
					PMPasoValores(sqlconn, "@i_rango", 0, SQLINT1, VTRango)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_consulta_costos", True, FMLoadResString(1592)) Then
                        If VTRango = "0" Then
                            PMMapeaGrid(sqlconn, grdRegistros, False)
                        Else
                            PMMapeaGrid(sqlconn, grdRegistros, True)
                        End If
                        PMMapeaTextoGrid(grdRegistros)
                        PMChequea(sqlconn)
                        If Conversion.Val(Convert.ToString(grdRegistros.Tag)) > 0 Then
                            grdRegistros.ColAlignment(3) = 1
                            grdRegistros.ColAlignment(4) = 1
                            grdRegistros.ColAlignment(5) = 1
                            grdRegistros.ColAlignment(6) = 1
                            grdRegistros.ColAlignment(7) = 1
                            grdRegistros.ColAlignment(8) = 2
                        End If
                        grdRegistros.Col = 2
                        grdRegistros.Row = grdRegistros.Rows - 1
                        VTRango = grdRegistros.CtlText
                    Else
                        PMChequea(sqlconn)
                    End If
					VTFilas = Conversion.Val(Convert.ToString(grdRegistros.Tag))
				End While
				grdRegistros.Col = 1
			Case 1
				If txtCampo(2).Text <> "" Then
					txtCampo(2).Text = ""
					lblDescripcion(3).Text = ""
					txtCampo(2).Focus()
				Else
					If txtCampo(3).Text <> "" Then
						txtCampo(3).Text = ""
						lblDescripcion(0).Text = ""
						lblDescripcion(1).Text = ""
						lblDescripcion(2).Text = ""
						lblDescripcion(4).Text = ""
						lblDescripcion(5).Text = ""
						PMLimpiaGrid(grdRegistros)
						txtCampo(3).Focus()
					Else
						txtCampo(0).Text = ""
						lblDescripcion(6).Text = ""
						txtCampo(0).Focus()
					End If
				End If
				COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
				COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
			Case 2
                Me.Close()
        End Select
	End Sub

	Private Sub FConCostos_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLTSEstado()
	End Sub

	Private Sub FConCostos_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
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

	Private Sub grdRegistros_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1436))
	End Sub

	Private isInitializingComponent As Boolean = false

	Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.TextChanged, _txtCampo_2.TextChanged, _txtCampo_3.TextChanged
		If isInitializingComponent Then
			Exit Sub
		End If
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0, 2, 3
				VLPaso = False
		End Select
	End Sub

	Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Enter, _txtCampo_2.Enter, _txtCampo_3.Enter
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		VLPaso = True
		Select Case Index
			Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1151))
			Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1068))
			Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1166))
		End Select
		txtCampo(Index).SelectionStart = 0
		txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
	End Sub

	Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_0.KeyDown, _txtCampo_2.KeyDown, _txtCampo_3.KeyDown
		Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    VGOperacion = "sp_hp_sucursal"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4079")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", False, FMLoadResString(1913)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        If VGValores(1) <> "" Then
                            txtCampo(0).Text = VGValores(1)
                            lblDescripcion(6).Text = VGValores(2)
                        Else
                            txtCampo(0).Text = ""
                            lblDescripcion(6).Text = ""
                            VGOperacion = ""
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                        VLPaso = True
                    Else
                        PMChequea(sqlconn)
                        txtCampo(0).Text = ""
                        lblDescripcion(6).Text = ""
                        VGOperacion = ""
                    End If
                Case 2
                    VGOperacion = "sp_help_costos"
                    VGTipo = "C"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4058")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "C")
                    PMPasoValores(sqlconn, "@i_servicio", 0, SQLINT2, txtCampo(3).Text)
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_costos", False, FMLoadResString(1566)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        If VGACatalogo.Codigo <> "" Then
                            txtCampo(2).Text = VGACatalogo.Codigo
                            lblDescripcion(3).Text = VGACatalogo.Descripcion
                            VLPaso = True
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                    End If
                Case 3
                    VGOperacion = "sp_help_costos"
                    VGTipo = "S"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4058")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_costos", False, FMLoadResString(1559)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        If VGValores(1) <> "" Then
                            txtCampo(3).Text = VGValores(1)
                            lblDescripcion(0).Text = VGValores(2)
                            lblDescripcion(2).Text = VGValores(3)
                            lblDescripcion(4).Text = VGValores(4)
                            lblDescripcion(5).Text = VGValores(5)
                            If lblDescripcion(2).Text = "" Then
                                Exit Sub
                            End If
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4038")
                            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                            PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "T")
                            PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, lblDescripcion(2).Text)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rango_pe", False, FMLoadResString(1595)) Then
                                PMMapeaObjeto(sqlconn, lblDescripcion(1))
                                PMChequea(sqlconn)
                            Else
                                PMChequea(sqlconn)
                            End If
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                        VGOperacion = ""
                        VGTipo = ""
                    End If
                    VLPaso = True
            End Select
        End If
	End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_0.KeyPress, _txtCampo_2.KeyPress, _txtCampo_3.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 2
				If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 96) Or (KeyAscii > 123)) Then
					KeyAscii = 0
				Else
					KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
				End If
			Case 0, 1, 3
				If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
					KeyAscii = 0
				End If
		End Select
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Leave, _txtCampo_2.Leave, _txtCampo_3.Leave
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0
				If Not VLPaso Then
					If txtCampo(0).Text <> "" Then
						If CDbl(txtCampo(0).Text) > 32000 Then
                            COBISMessageBox.Show(FMLoadResString(1263), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
							txtCampo(0).Text = ""
							txtCampo(0).Focus()
							Exit Sub
						End If
						PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4078")
						PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(0).Text)
						PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
						PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", True, FMLoadResString(1112)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(6))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            lblDescripcion(6).Text = ""
                            txtCampo(0).Text = ""
                            VLPaso = True
                        End If
					Else
						lblDescripcion(6).Text = ""
					End If
				End If
			Case 2
				If Not VLPaso Then
					If txtCampo(2).Text <> "" Then
						PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4058")
						PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
						PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "C")
						PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text)
						PMPasoValores(sqlconn, "@i_servicio", 0, SQLINT2, txtCampo(3).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_costos", False, FMLoadResString(1559)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(3))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(2).Text = ""
                            lblDescripcion(3).Text = ""
                            txtCampo(2).Focus()
                        End If
					Else
						lblDescripcion(3).Text = ""
					End If
				End If
			Case 3
				If Not VLPaso Then
					If txtCampo(3).Text <> "" Then
						PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4058")
						PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
						PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "S")
						PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
						PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text)
						PMPasoValores(sqlconn, "@i_servicio", 0, SQLINT2, txtCampo(3).Text)
						Dim Valores(10) As String
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_costos", False, FMLoadResString(1559)) Then
                            FMMapeaArreglo(sqlconn, Valores)
                            PMChequea(sqlconn)
                            lblDescripcion(0).Text = Valores(1)
                            lblDescripcion(2).Text = Valores(2)
                            lblDescripcion(4).Text = Valores(3)
                            lblDescripcion(5).Text = Valores(4)
                            If lblDescripcion(2).Text = "" Then
                                Exit Sub
                            End If
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4038")
                            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                            PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "T")
                            PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, lblDescripcion(2).Text)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rango_pe", False, FMLoadResString(1595)) Then
                                PMMapeaObjeto(sqlconn, lblDescripcion(1))
                                PMChequea(sqlconn)
                            Else
                                PMChequea(sqlconn)
                                txtCampo(3).Text = ""
                                lblDescripcion(0).Text = ""
                                lblDescripcion(1).Text = ""
                                lblDescripcion(2).Text = ""
                                lblDescripcion(4).Text = ""
                                lblDescripcion(5).Text = ""
                            End If
                        Else
                            PMChequea(sqlconn)
                            txtCampo(3).Text = ""
                            lblDescripcion(1).Text = ""
                            lblDescripcion(2).Text = ""
                            lblDescripcion(0).Text = ""
                            lblDescripcion(4).Text = ""
                            lblDescripcion(5).Text = ""
                        End If
					End If
				End If
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

    Private Sub grdRegistros_Leave(sender As Object, e As EventArgs) Handles grdRegistros.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
End Class


