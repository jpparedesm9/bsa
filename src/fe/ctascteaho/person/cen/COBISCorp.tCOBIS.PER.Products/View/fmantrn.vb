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
 Public  Partial  Class FMantTranAutorizadaClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Dim VLPaso As Integer = 0
    Const MB_YESNO As Integer = 4
	Const MB_ICONQUESTION As Integer = 32
	Const MB_DEBUTTON1 As Integer = 0
	Const IDYES As Integer = 6
	Dim DgDef As MsgBoxStyle

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_5.Click, _cmdBoton_2.Click, _cmdBoton_4.Click, _cmdBoton_3.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        TSBotones.Focus()
		Select Case Index
			Case 0
				PLBuscar()
			Case 1
				PLCrear()
			Case 2
				PLActualizar(True, "E")
			Case 3
				PLLimpiar()
				PLModoInsertar(True)
				txtCampo(0).Focus()
			Case 4
                Me.Close()
            Case 5
                PLActualizar(False, "V")
        End Select
	End Sub

	Private Sub PLActualizar(ByRef VLElimina As Boolean, ByRef VLEstado As String)
		Dim Response As String = ""
		DgDef = MB_YESNO + MB_ICONQUESTION + MB_DEBUTTON1
		If VLElimina Then
            Response = CStr(COBISMsgBox.MsgBox(FMLoadResString(1865), DgDef, FMLoadResString(1867)))
		Else
			Response = CStr(IDYES)
		End If
		If StringsHelper.ToDoubleSafe(Response) = IDYES Then
			If txtCampo(0).Text.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(1274), FMLoadResString(1020), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
				txtCampo(0).Focus()
				Exit Sub
			End If
			If txtCampo(1).Text.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(1269), FMLoadResString(1020), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
				txtCampo(0).Focus()
				Exit Sub
			End If
			If txtCampo(2).Text.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(1423), FMLoadResString(1020), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
				txtCampo(0).Focus()
				Exit Sub
			End If
			If txtCampo(3).Text.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(1255), FMLoadResString(1020), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
				txtCampo(0).Focus()
				Exit Sub
			End If
			If cmbAutoriza.Text = "" Then
                COBISMessageBox.Show(FMLoadResString(1179), FMLoadResString(1020), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
				txtCampo(3).Focus()
				Exit Sub
			End If
			PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "729")
			PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
			PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text)
			PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, txtCampo(1).Text)
			PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text)
			PMPasoValores(sqlconn, "@i_tran", 0, SQLINT4, txtCampo(3).Text)
			PMPasoValores(sqlconn, "@i_modulo", 0, SQLCHAR, cmbModulo.Text)
			Select Case cmbAutoriza.Text
				Case "SI"
					PMPasoValores(sqlconn, "@i_autorizada", 0, SQLCHAR, "S")
				Case "NO"
					PMPasoValores(sqlconn, "@i_autorizada", 0, SQLCHAR, "N")
			End Select
			PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, VLEstado)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_autoriza_trn_caja", True, FMLoadResString(1917)) Then
                PMChequea(sqlconn)
                PLLimpiar()
                cmdBoton_Click(cmdBoton(0), New EventArgs())
            Else
                PMChequea(sqlconn)
            End If
		Else
			Exit Sub
		End If
	End Sub

	Private Sub PLBuscar()
		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "730")
		PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
		If txtCampo(0).Text.Trim() <> "" Then
			PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text)
		End If
		If txtCampo(1).Text.Trim() <> "" Then
			PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, txtCampo(1).Text)
		End If
		If txtCampo(2).Text.Trim() <> "" Then
			PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text)
		End If
		If txtCampo(3).Text.Trim() <> "" Then
			PMPasoValores(sqlconn, "@i_tran", 0, SQLINT4, txtCampo(3).Text)
		End If
		If cmbModulo.Text.Trim() <> "" Then
			PMPasoValores(sqlconn, "@i_modulo", 0, SQLCHAR, cmbModulo.Text)
		End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_autoriza_trn_caja", True, FMLoadResString(1565)) Then
            PMMapeaGrid(sqlconn, grdTransacciones, False)
            PMMapeaTextoGrid(grdTransacciones)
            PMAnchoColumnasGrid(grdTransacciones)
            PMChequea(sqlconn)
            PLModoInsertar(True)
        Else
            PMChequea(sqlconn)
        End If
	End Sub

	Private Sub PLCrear()
		If txtCampo(0).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(1274), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtCampo(0).Focus()
			Exit Sub
		End If
		If txtCampo(1).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(1269), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtCampo(1).Focus()
			Exit Sub
		End If
		If txtCampo(2).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(1423), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtCampo(2).Focus()
			Exit Sub
		End If
		If txtCampo(3).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(1255), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtCampo(3).Focus()
			Exit Sub
		End If
		If cmbModulo.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1180), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtCampo(3).Focus()
			Exit Sub
		End If
		If cmbAutoriza.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1179), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtCampo(3).Focus()
			Exit Sub
		End If
		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "728")
		PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
		PMPasoValores(sqlconn, "@i_modulo", 0, SQLCHAR, cmbModulo.Text)
		PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT4, txtCampo(0).Text)
		PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, txtCampo(1).Text)
		PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text)
		PMPasoValores(sqlconn, "@i_tran", 0, SQLINT4, txtCampo(3).Text)
		Select Case cmbAutoriza.Text
			Case "SI"
				PMPasoValores(sqlconn, "@i_autorizada", 0, SQLCHAR, "S")
			Case "NO"
				PMPasoValores(sqlconn, "@i_autorizada", 0, SQLCHAR, "N")
		End Select
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_autoriza_trn_caja", True, FMLoadResString(1916)) Then
            PMChequea(sqlconn)
            PLLimpiar()
            cmdBoton_Click(cmdBoton(0), New EventArgs())
        Else
            PMChequea(sqlconn)
        End If
	End Sub

	Private Sub FMantTranAutorizada_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLModoInsertar(True)
		PMBotonSeguridad(Me, 5)
		PMObjetoSeguridad(cmdBoton(0))
		PMObjetoSeguridad(cmdBoton(5))
        PMObjetoSeguridad(cmdBoton(1))
		PMObjetoSeguridad(cmdBoton(2))
		cmbAutoriza.Items.Clear()
		cmbAutoriza.Items.Insert(0, "SI")
		cmbAutoriza.Items.Insert(1, "NO")
		cmbAutoriza.SelectedIndex = 0
		cmbModulo.Items.Clear()
		cmbModulo.Items.Insert(0, "AHO")
		cmbModulo.Items.Insert(1, "CTE")
        cmbModulo.SelectedIndex = 0
        cmdBoton(5).Enabled = False
        cmdBoton(2).Enabled = False
        PLTSEstado()
    End Sub

	Private Sub FMantTranAutorizada_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(System.String.Empty)
	End Sub

    Private Sub grdTransacciones_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdTransacciones.ClickEvent
        grdTransacciones.Col = 0
        grdTransacciones.SelStartCol = 1
        grdTransacciones.SelEndCol = grdTransacciones.Cols - 1
        If grdTransacciones.Row = 0 Then
            grdTransacciones.SelStartRow = 1
            grdTransacciones.SelEndRow = 1
        Else
            grdTransacciones.SelStartRow = grdTransacciones.Row
            grdTransacciones.SelEndRow = grdTransacciones.Row
        End If
    End Sub

	Private Sub grdTransacciones_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdTransacciones.DblClick
		Dim VTRow As Integer = grdTransacciones.Row
		grdTransacciones.Row = 1
		grdTransacciones.Col = 1
		If grdTransacciones.CtlText.Trim() <> "" Then
			grdTransacciones.Row = VTRow
			PMMarcarRegistro()
			PLModoInsertar(False)
			cmbModulo.Enabled = False
		End If
	End Sub

	Private Sub grdTransacciones_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdTransacciones.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1391))
	End Sub

	Private Sub PLLimpiar()
		For i As Integer = 0 To 3
			lblDescripcion(i).Text = ""
		Next i
		For i As Integer = 0 To 3
			txtCampo(i).Text = ""
			txtCampo(i).Enabled = True
		Next i
		cmbModulo.Enabled = True
		cmbModulo.SelectedIndex = 0
		cmbAutoriza.SelectedIndex = 0
        PMLimpiaGrid(grdTransacciones)
        txtCampo(0).Focus()
	End Sub

	Private Sub PLModoInsertar(ByRef Modo As Integer)
		txtCampo(0).Enabled = Modo
		txtCampo(1).Enabled = Modo
		txtCampo(2).Enabled = Modo
		txtCampo(3).Enabled = Modo
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
		grdTransacciones.Col = 1
		Select Case grdTransacciones.CtlText
			Case "AHO"
				cmbModulo.SelectedIndex = 0
			Case "CTE"
				cmbModulo.SelectedIndex = 1
		End Select
		grdTransacciones.Col = 2
		txtCampo(3).Text = grdTransacciones.CtlText
		txtCampo_Leave(txtCampo(3), New EventArgs())
		grdTransacciones.Col = 3
		txtCampo(0).Text = grdTransacciones.CtlText
		txtCampo_Leave(txtCampo(0), New EventArgs())
		grdTransacciones.Col = 4
		txtCampo(1).Text = grdTransacciones.CtlText
		txtCampo_Leave(txtCampo(1), New EventArgs())
		grdTransacciones.Col = 5
		txtCampo(2).Text = grdTransacciones.CtlText
		txtCampo_Leave(txtCampo(2), New EventArgs())
		grdTransacciones.Col = 6
		Select Case grdTransacciones.CtlText
			Case "S"
				cmbAutoriza.SelectedIndex = 0
			Case "N"
				cmbAutoriza.SelectedIndex = 1
		End Select
	End Sub

	Private isInitializingComponent As Boolean = false

	Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.TextChanged, _txtCampo_2.TextChanged, _txtCampo_1.TextChanged, _txtCampo_0.TextChanged
		If isInitializingComponent Then
			Exit Sub
		End If
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0, 1, 2, 3
				VLPaso = False
		End Select
	End Sub

	Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.Enter, _txtCampo_2.Enter, _txtCampo_1.Enter, _txtCampo_0.Enter
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		VLPaso = True
		Select Case Index
			Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1151))
			Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1163))
			Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1153))
			Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1158))
		End Select
		txtCampo(Index).SelectionStart = 0
		txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
	End Sub

	Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_3.KeyDown, _txtCampo_2.KeyDown, _txtCampo_1.KeyDown, _txtCampo_0.KeyDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Dim VTFilas As Integer = 0
		Dim VTProFinal As String = ""
        If eventArgs.KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    VGOperacion = "sp_hp_sucursal"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4079")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", True, FMLoadResString(1913)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        VLPaso = True
                        FRegistros.ShowPopup(Me)
                        If VGValores(1) <> "" Then
                            txtCampo(0).Text = VGValores(1)
                            lblDescripcion(0).Text = VGValores(2)
                            VLPaso = True
                        Else
                            VGOperacion = ""
                            txtCampo(0).Text = ""
                            lblDescripcion(0).Text = ""
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                        txtCampo(0).Text = ""
                        lblDescripcion(0).Text = ""
                        VGOperacion = ""
                    End If
                Case 1
                    If txtCampo(0).Text.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(1).Text = ""
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
                            PMChequea(sqlconn)
                            txtCampo(1).Text = ""
                            lblDescripcion(1).Text = ""
                            VGOperacion = ""
                        End If
                    End While
                    FRegistros.grdRegistros.Row = 1
                    FRegistros.ShowPopup(Me)
                    If VGValores(1) <> "" Then
                        txtCampo(1).Text = VGValores(1)
                        lblDescripcion(1).Text = VGValores(2)
                        VLPaso = True
                    Else
                        txtCampo(1).Text = ""
                        lblDescripcion(1).Text = ""
                        VGOperacion = ""
                    End If
                    FRegistros.Dispose() '18/05/2016 migracion
                Case 2
                    PMCatalogo("A", "pe_categoria", txtCampo(2), lblDescripcion(2), FRegistros)
                    VLPaso = True
                Case 3
                    PMCatalogo("A", "pe_aut_trn_caja", txtCampo(3), lblDescripcion(3), FRegistros)
                    VLPaso = True
                    'VTFilas = VGMaxRows
                    'VTProFinal = "0"
                    'VGOperacion = "sp_autoriza_trn_caja"
                    'While VTFilas = VGMaxRows
                    '    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "731")
                    '    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "N")
                    '    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                    '    PMPasoValores(sqlconn, "@i_tran", 0, SQLINT4, VTProFinal)
                    '    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_autoriza_trn_caja", True, FMLoadResString(1564)) Then
                    '        If VTProFinal = "0" Then
                    '            PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                    '        Else
                    '            PMMapeaGrid(sqlconn, FRegistros.grdRegistros, True)
                    '        End If
                    '        PMMapeaTextoGrid(FRegistros.grdRegistros)
                    '        PMChequea(sqlconn)
                    '        VTFilas = Conversion.Val(Convert.ToString(FRegistros.grdRegistros.Tag))
                    '        FRegistros.grdRegistros.Col = 1
                    '        FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                    '        VTProFinal = FRegistros.grdRegistros.CtlText
                    '    Else
                    '        PMChequea(sqlconn)
                    '        txtCampo(1).Text = ""
                    '        lblDescripcion(1).Text = ""
                    '        VGOperacion = ""
                    '    End If
                    'End While
                    'FRegistros.grdRegistros.Row = 1
                    'FRegistros.ShowPopup(Me)
                    'If VGValores(1) <> "" Then
                    '    txtCampo(3).Text = VGValores(1)
                    '    lblDescripcion(3).Text = VGValores(2)
                    '    VLPaso = True
                    'Else
                    '    txtCampo(3).Text = ""
                    '    lblDescripcion(3).Text = ""
                    '    VGOperacion = ""
                    'End If
                    'FRegistros.Dispose() '18/05/2016 migracion
            End Select
        End If
	End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_3.KeyPress, _txtCampo_2.KeyPress, _txtCampo_1.KeyPress, _txtCampo_0.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0, 1, 3
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

	Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.Leave, _txtCampo_2.Leave, _txtCampo_1.Leave, _txtCampo_0.Leave
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)

        Dim VTArreglo() As String
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
                        txtCampo(0).Text = ""
                        lblDescripcion(0).Text = ""
						txtCampo(0).Focus()
						Exit Sub
					End If
					PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4078")
					PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(0).Text)
					PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
					PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", True, FMLoadResString(1913)) Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(0))
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        lblDescripcion(0).Text = ""
                        txtCampo(0).Text = ""
                        txtCampo(0).Focus()
                        VLPaso = True
                    End If
				Case 1
					If txtCampo(1).Text.Trim() = "" Then
						txtCampo(1).Text = ""
						lblDescripcion(1).Text = ""
						Exit Sub
					End If
					If txtCampo(0).Text.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
						txtCampo(1).Text = ""
						lblDescripcion(1).Text = ""
						txtCampo(0).Focus()
						Exit Sub
					End If
					PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4077")
					PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
					PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
					PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text)
					PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, txtCampo(1).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1556)) Then
                        ReDim VTArreglo(3)
                        FMMapeaArreglo(sqlconn, VTArreglo)
                        PMChequea(sqlconn)
                        lblDescripcion(1).Text = VTArreglo(1)
                    Else
                        PMChequea(sqlconn)
                        lblDescripcion(1).Text = ""
                        txtCampo(1).Text = ""
                        txtCampo(1).Focus()
                        VLPaso = True
                    End If
				Case 2
					If txtCampo(2).Text.Trim() = "" Then
						lblDescripcion(2).Text = ""
						Exit Sub
					End If
                    PMCatalogo("V", "pe_categoria", txtCampo(2), lblDescripcion(2), Nothing)
					If txtCampo(2).Text.Trim() = "" And lblDescripcion(2).Text.Trim() = "" Then
						txtCampo(2).Focus()
					End If
                Case 3
                    PMCatalogo("V", "pe_aut_trn_caja", txtCampo(3), lblDescripcion(3), Nothing)
                    If txtCampo(3).Text.Trim() = "" And lblDescripcion(3).Text.Trim() = "" Then
                        txtCampo(3).Focus()
                    End If
                    'PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "731")
                    'PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "N")
                    'PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                    'PMPasoValores(sqlconn, "@i_tran", 0, SQLINT4, txtCampo(3).Text)
                    'If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_autoriza_trn_caja", True, FMLoadResString(1104)) Then
                    '    ReDim VTArreglo(3)
                    '    FMMapeaArreglo(sqlconn, VTArreglo)
                    '    PMChequea(sqlconn)
                    '    lblDescripcion(3).Text = VTArreglo(2)
                    'Else
                    '    PMChequea(sqlconn)
                    '    lblDescripcion(3).Text = ""
                    '    txtCampo(3).Text = ""
                    '    txtCampo(3).Focus()
                    '    VLPaso = True
                    'End If
            End Select
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
		End If
	End Sub

	Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_3.MouseDown, _txtCampo_2.MouseDown, _txtCampo_1.MouseDown, _txtCampo_0.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0, 1, 2
				My.Computer.Clipboard.Clear()
        End Select
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBCrear.Enabled = _cmdBoton_1.Enabled
        TSBCrear.Visible = _cmdBoton_1.Visible
        TSBActualizar.Enabled = _cmdBoton_5.Enabled
        TSBActualizar.Visible = _cmdBoton_5.Visible
        TSBEliminar.Enabled = _cmdBoton_2.Enabled
        TSBEliminar.Visible = _cmdBoton_2.Visible
        TSBLimpiar.Enabled = _cmdBoton_3.Enabled
        TSBLimpiar.Visible = _cmdBoton_3.Visible
        TSBSalir.Enabled = _cmdBoton_4.Enabled
        TSBSalir.Visible = _cmdBoton_4.Visible
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
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
		
    End Sub

    Private Sub cmbModulo_Enter(sender As Object, e As EventArgs) Handles cmbModulo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1878))
    End Sub

    Private Sub cmbAutoriza_Enter(sender As Object, e As EventArgs) Handles cmbAutoriza.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1879))
    End Sub

    Private Sub cmbModulo_Leave(sender As Object, e As EventArgs) Handles cmbModulo.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private Sub cmbAutoriza_Leave(sender As Object, e As EventArgs) Handles cmbAutoriza.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private Sub grdTransacciones_Leave(sender As Object, e As EventArgs) Handles grdTransacciones.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

End Class


