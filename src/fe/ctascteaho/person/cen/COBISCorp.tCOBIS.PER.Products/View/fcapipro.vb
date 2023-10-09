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
 Public  Partial  Class FCapProFinalClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Dim VLPaso As Integer = 0
    Dim VLTipoCapAnt As String = System.String.Empty

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_5.Click, _cmdBoton_2.Click, _cmdBoton_4.Click, _cmdBoton_3.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Const MB_YESNO As Integer = 4
		Const MB_ICONQUESTION As Integer = 32
		Const MB_DEBUTTON1 As Integer = 0
		Const IDYES As Integer = 6
        Dim Response As String = ""
        TSBotones.Focus()
        Dim DgDef As COBISMsgBox.COBISButtons = MB_YESNO + MB_ICONQUESTION + MB_DEBUTTON1
		Select Case Index
			Case 0
				If txtCampo(0).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(0).Focus()
					Exit Sub
				End If
				If txtCampo(1).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(1269), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(1).Focus()
					Exit Sub
				End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4093")
				PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "S")
				PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_capitalizacion_profinal", True, FMLoadResString(1561)) Then
                    PMMapeaGrid(sqlconn, grdCategorias, False)
                    PMMapeaTextoGrid(grdCategorias)
                    PMAnchoColumnasGrid(grdCategorias)
                    PMChequea(sqlconn)
                    grdCategorias.ColWidth(1) = 1000
                    grdCategorias.ColWidth(2) = 5750
                    PLModoInsertar(True)
                    PLLimpiar("=", 3)
                    PLLimpiar("=", 4)
                Else
                    PMChequea(sqlconn)
                End If
			Case 1
				If txtCampo(1).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(1269), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(1).Focus()
					Exit Sub
				End If
				If txtCampo(2).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(1275), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(2).Focus()
					Exit Sub
				End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4094")
				PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "I")
				PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
				PMPasoValores(sqlconn, "@i_tcapitalizacion", 0, SQLCHAR, txtCampo(2).Text)
				If optTipoRango(0).Checked Then
					PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT1, "1")
				Else
					If optTipoRango(1).Checked Then
						PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT1, "2")
					End If
				End If
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_capitalizacion_profinal", True, FMLoadResString(1578)) Then
                    PMChequea(sqlconn)
                    cmdBoton_Click(cmdBoton(0), New EventArgs())
                Else
                    PMChequea(sqlconn)
                End If
            Case 2
                If txtCampo(2).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(1275), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                Response = CStr(COBISMsgBox.MsgBox(FMLoadResString(1859), DgDef, FMLoadResString(1867)))
                If StringsHelper.ToDoubleSafe(Response) = IDYES Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4096")
                    PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "D")
                    PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
                    PMPasoValores(sqlconn, "@i_tcapitalizacion", 0, SQLCHAR, txtCampo(2).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_capitalizacion_profinal", True, FMLoadResString(1926)) Then
                        PMChequea(sqlconn)
                        cmdBoton_Click(cmdBoton(0), New EventArgs())
                    Else
                        PMChequea(sqlconn)
                    End If
                Else
                    Exit Sub
                End If
			Case 3
				PLLimpiar(">", 0)
				PLModoInsertar(True)
				txtCampo(0).Focus()
                optTipoRango(0).Checked = True
			Case 4
                Me.Close()
            Case 5
                If txtCampo(1).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(1269), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If txtCampo(2).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(1275), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4095")
                PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "U")
                PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_tcapitalizacion", 0, SQLCHAR, VLTipoCapAnt)
                PMPasoValores(sqlconn, "@i_nuevo_tcapitalizacion", 0, SQLCHAR, txtCampo(2).Text)
                If optTipoRango(0).Checked Then
                    PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT1, "1")
                Else
                    If optTipoRango(1).Checked Then
                        PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT1, "2")
                    End If
                End If
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_capitalizacion_profinal", True, FMLoadResString(1540)) Then
                    PMChequea(sqlconn)
                    cmdBoton_Click(cmdBoton(0), New EventArgs())
                Else
                    PMChequea(sqlconn)
                End If
        End Select
	End Sub

	Private Sub FCapProFinal_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLModoInsertar(True)
		PMBotonSeguridad(Me, 5)
		PMObjetoSeguridad(cmdBoton(0))
		PMObjetoSeguridad(cmdBoton(1))
		PMObjetoSeguridad(cmdBoton(5))
        PMObjetoSeguridad(cmdBoton(2))
        cmdBoton(5).Enabled = False
        cmdBoton(2).Enabled = False
        PLTSEstado()
	End Sub

	Private Sub FCapProFinal_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

    Private Sub grdCategorias_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdCategorias.ClickEvent
        grdCategorias.Col = 0
        grdCategorias.SelStartCol = 1
        grdCategorias.SelEndCol = grdCategorias.Cols - 1
        If grdCategorias.Row = 0 Then
            grdCategorias.SelStartRow = 1
            grdCategorias.SelEndRow = 1
        Else
            grdCategorias.SelStartRow = grdCategorias.Row
            grdCategorias.SelEndRow = grdCategorias.Row
        End If
    End Sub

	Private Sub grdCategorias_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdCategorias.DblClick
		Dim Modo As Boolean = false
		Dim VTRow As Integer = grdCategorias.Row
		grdCategorias.Row = 1
		grdCategorias.Col = 1
		If grdCategorias.CtlText.Trim() <> "" Then
			grdCategorias.Row = VTRow
			PMMarcarRegistro()
			PLModoInsertar(False)
			txtCampo(2).Enabled = Not Modo
		End If
	End Sub

	Private Sub grdCategorias_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdCategorias.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1396))
	End Sub

	Private Sub PLLimpiar(ByRef tipo As String, ByRef Numero As Integer)
		Select Case tipo
			Case "="
				If Numero <= 3 Then
					txtCampo(Numero - 1).Text = ""
					lblDescripcion(Numero - 1).Text = ""
				ElseIf Numero = 5 Then 
					PMLimpiaGrid(grdCategorias)
				End If
			Case ">"
				For i As Integer = Numero To 4
					PLLimpiar("=", i + 1)
				Next i
			Case "<"
				For i As Integer = Numero To 2 Step -1
					PLLimpiar("=", i - 1)
				Next i
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

	Private Sub PLModoInsertar(ByRef Modo As Integer)
		txtCampo(0).Enabled = Modo
		txtCampo(1).Enabled = Modo
		txtCampo(2).Enabled = Modo
		If Modo Then
			PMObjetoSeguridad(cmdBoton(1))
			cmdBoton(2).Enabled = Not Modo
			cmdBoton(5).Enabled = Not Modo
		Else
			cmdBoton(1).Enabled = Modo
			PMObjetoSeguridad(cmdBoton(2))
			PMObjetoSeguridad(cmdBoton(5))
        End If
        PLTSEstado()
	End Sub

	Private Sub PMMarcarRegistro()
		grdCategorias.Col = 1
		txtCampo(2).Text = grdCategorias.CtlText
		VLTipoCapAnt = txtCampo(2).Text
		grdCategorias.Col = 2
		lblDescripcion(2).Text = grdCategorias.CtlText
		grdCategorias.Col = 3
		If grdCategorias.CtlText = "1" Then
			optTipoRango(0).Checked = True
		Else
			If grdCategorias.CtlText = "2" Then
				optTipoRango(1).Checked = True
			End If
		End If
	End Sub

	Private isInitializingComponent As Boolean = false

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
		VLPaso = True
		Select Case Index
			Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1151))
			Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1163))
			Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1153))
		End Select
		txtCampo(Index).SelectionStart = 0
		txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
	End Sub

	Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_2.KeyDown, _txtCampo_1.KeyDown, _txtCampo_0.KeyDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Dim VTFilas As Integer = 0
		Dim VTProFinal As String = ""
        If eventArgs.KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    PLLimpiar("=", 2)
                    VGOperacion = "sp_hp_sucursal"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4079")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", False, FMLoadResString(1913)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        VLPaso = True
                        FRegistros.ShowPopup(Me)
                        If VGValores(1) <> "" Then
                            txtCampo(0).Text = VGValores(1)
                            lblDescripcion(0).Text = VGValores(2)
                            VLPaso = True
                            txtCampo(1).Focus()
                        Else
                            VGOperacion = ""
                            PLLimpiar("=", 1)
                            txtCampo(0).Focus()
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion

                    Else
                        PLLimpiar("=", 1)
                        VGOperacion = ""
                        PMChequea(sqlconn)
                    End If
                Case 1
                    If txtCampo(0).Text.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        PLLimpiar("<", 3)
                        VLPaso = True
                        txtCampo(0).Focus()
                        Exit Sub
                    End If
                    VTFilas = VGMaxRows
                    VTProFinal = "0"
                    VGOperacion = "sp_prodfin3"
                    While VTFilas = VGMaxRows
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4011")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text)
                        PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, VTProFinal)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1556)) Then
                            If VTProFinal = "0" Then
                                PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                            Else
                                PMMapeaGrid(sqlconn, FRegistros.grdRegistros, True)
                            End If
                            PMMapeaTextoGrid(FRegistros.grdRegistros)
                            PMChequea(sqlconn)
                            VTFilas = Conversion.Val(Convert.ToString(FRegistros.grdRegistros.Tag))
                            FRegistros.grdRegistros.Col = 1
                            FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                            VTProFinal = FRegistros.grdRegistros.CtlText
                        Else
                            txtCampo(1).Text = ""
                            lblDescripcion(1).Text = ""
                            VGOperacion = ""
                            PMChequea(sqlconn)
                        End If
                    End While
                    FRegistros.grdRegistros.Row = 1
                    FRegistros.ShowPopup(Me)
                    If VGValores(1) <> "" Then
                        txtCampo(1).Text = VGValores(1)
                        lblDescripcion(1).Text = VGValores(2)
                        VLPaso = True
                        txtCampo(2).Focus()
                    Else
                        txtCampo(1).Text = ""
                        lblDescripcion(1).Text = ""
                        VGOperacion = ""
                        txtCampo(1).Focus()
                    End If
                    FRegistros.Dispose() '18/05/2016 migracion

                Case 2
                    PMCatalogo("A", "pe_capitalizacion", txtCampo(2), lblDescripcion(2), FRegistros)
                    VLPaso = True                    
            End Select
        End If
	End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_2.KeyPress, _txtCampo_1.KeyPress, _txtCampo_0.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0, 1
				If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
					KeyAscii = 0
				End If
			Case 2
                If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 96) Or (KeyAscii > 122)) Then
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

	Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.Leave, _txtCampo_1.Leave, _txtCampo_0.Leave
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Not VLPaso Then
            Select Case Index
                Case 0
                    txtCampo(1).Text = ""
                    lblDescripcion(1).Text = ""
                    If txtCampo(0).Text.Trim() = "" Then
                        lblDescripcion(0).Text = ""
                        Exit Sub
                    End If
                    If CDbl(txtCampo(0).Text) >= 32000 Then
                        COBISMessageBox.Show(FMLoadResString(1418), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        lblDescripcion(0).Text = ""
                        txtCampo(0).Text = ""
                        txtCampo(0).Focus()
                        Exit Sub
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4078")
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(0).Text)
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", True, FMLoadResString(1111)) Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(0))
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        PLLimpiar("=", 1)
                        txtCampo(0).Focus()
                        VLPaso = True
                    End If
                Case 1
                    If txtCampo(1).Text.Trim() = "" Then
                        PLLimpiar("=", 2)
                        Exit Sub
                    End If
                    If txtCampo(0).Text.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        PLLimpiar("<", 3)
                        txtCampo(0).Focus()
                        Exit Sub
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4077")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text)
                    PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, txtCampo(1).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1556)) Then
                        Dim VTArreglo(3) As String
                        FMMapeaArreglo(sqlconn, VTArreglo)
                        PMChequea(sqlconn)
                        lblDescripcion(1).Text = VTArreglo(1)
                    Else
                        PMChequea(sqlconn)
                        PLLimpiar("=", 2)
                        txtCampo(1).Focus()
                        VLPaso = True
                    End If
                Case 2
                    If txtCampo(2).Text.Trim() = "" Then
                        lblDescripcion(2).Text = ""
                        Exit Sub
                    End If
                    PMCatalogo("V", "pe_capitalizacion", txtCampo(2), lblDescripcion(2), Nothing)
                    If txtCampo(2).Text.Trim() = "" And lblDescripcion(2).Text.Trim() = "" Then
                        txtCampo(2).Focus()
                    End If
            End Select
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
        End If
	End Sub

	Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_2.MouseDown, _txtCampo_1.MouseDown, _txtCampo_0.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0, 1, 2
				My.Computer.Clipboard.Clear()
                'My.Computer.Clipboard.SetText("")
		End Select
	End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
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

    Private Sub PLTSEstado()
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBCrear.Visible = _cmdBoton_1.Visible
        TSBActualizar.Visible = _cmdBoton_5.Visible
        TSBEliminar.Visible = _cmdBoton_2.Visible
        TSBLimpiar.Visible = _cmdBoton_3.Visible
        TSBSalir.Visible = _cmdBoton_4.Visible
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBCrear.Enabled = _cmdBoton_1.Enabled
        TSBActualizar.Enabled = _cmdBoton_5.Enabled
        TSBEliminar.Enabled = _cmdBoton_2.Enabled
        TSBLimpiar.Enabled = _cmdBoton_3.Enabled
        TSBSalir.Enabled = _cmdBoton_4.Enabled
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
		
    End Sub

    Private Sub _optTipoRango_0_Enter(sender As Object, e As EventArgs) Handles _optTipoRango_0.Enter, _optTipoRango_1.Enter
        Dim Index As Integer = Array.IndexOf(optTipoRango, sender)
        Select Case Index
            Case 0, 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1759))
        End Select
    End Sub

    Private Sub _optTipoRango_Leave(sender As Object, e As EventArgs) Handles _optTipoRango_0.Leave, _optTipoRango_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private Sub grdCategorias_Leave(sender As Object, e As EventArgs) Handles grdCategorias.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

End Class


