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
 Public  Partial  Class FParExtClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Dim VLPaso As Integer = 0
    Dim VLProducto As String = System.String.Empty

    Private Sub cmbTipo_Enter(sender As Object, e As EventArgs) Handles cmbTipo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1756))
    End Sub

	Private Sub cmbTipo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbTipo.Leave
        txtCampo(1).Text = System.String.Empty
        lblDescripcion(1).Text = System.String.Empty
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
	End Sub

	Private Sub FParExt_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = System.String.Empty '17/05/2016 migracion
        cmbTipo.Items.Insert(0, FMLoadResString(1912))
        cmbTipo.Items.Insert(1, FMLoadResString(1911))
		cmbTipo.SelectedIndex = 1
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLModoInsertar(True)
		PMBotonSeguridad(Me, 5)
		PMObjetoSeguridad(cmdBoton(0))
		PMObjetoSeguridad(cmdBoton(1))
		PMObjetoSeguridad(cmdBoton(3))
        PMObjetoSeguridad(cmdBoton(4))
        cmdBoton(1).Enabled = False
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = False
        PLTSEstado()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(System.String.Empty)
	End Sub

	Private Sub FParExt_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(System.String.Empty)
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
        Dim VTRow As Integer = grdCategorias.Row
        grdCategorias.Row = 1
        grdCategorias.Col = 1
        If grdCategorias.CtlText.Trim() <> "" Then
            grdCategorias.Row = VTRow
            PMMarcarRegistro()
            PLModoInsertar(False)
        End If
    End Sub

    Private Sub grdCategorias_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdCategorias.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1391))
    End Sub

	Private Sub PLModoInsertar(ByRef Modo As Integer)
		If Modo Then
			cmdBoton(1).Enabled = Not Modo
			cmdBoton(3).Enabled = Not Modo
            cmdBoton(4).Enabled = Not Modo
            cmdBoton(2).Enabled = Modo
		Else
			cmdBoton(1).Enabled = Modo
            cmdBoton(3).Enabled = Not Modo
			cmdBoton(4).Enabled = Not Modo
            PMObjetoSeguridad(cmdBoton(2))
            cmdBoton(2).Enabled = Modo
		End If
          PLTSEstado()
	End Sub

	Private Sub PMMarcarRegistro()
		grdCategorias.Col = 1
		lblDescripcion(0).Text = grdCategorias.CtlText
		grdCategorias.Col = 2
		VLProducto = grdCategorias.CtlText
		If VLProducto = "4" Then
            cmbTipo.Text = FMLoadResString(1911)
		ElseIf VLProducto = "3" Then 
            cmbTipo.Text = FMLoadResString(1912)
		End If
		grdCategorias.Col = 4
		txtCampo(1).Text = grdCategorias.CtlText
		grdCategorias.Col = 5
		lblDescripcion(1).Text = grdCategorias.CtlText
		grdCategorias.Col = 6
		txtCampo(2).Text = grdCategorias.CtlText
		grdCategorias.Col = 7
        txtCampo(0).Text = grdCategorias.CtlText

        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4140")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "V1")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VLProducto)
        PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
        PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, CStr(2))
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_parametro_extracto", True, FMLoadResString(1554)) Then
            PMMapeaObjeto(sqlconn, lblDescripcion(2))
            PMChequea(sqlconn)
            cmbTipo.Enabled = False
            txtCampo(0).Enabled = False
            txtCampo(1).Enabled = False
        Else
            PMChequea(sqlconn)
            txtCampo(0).Text = ""
            lblDescripcion(2).Text = ""
        End If

	End Sub

	Private isInitializingComponent As Boolean = false

	Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.TextChanged, _txtCampo_1.TextChanged, _txtCampo_2.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0, 1, 2
				VLPaso = False
		End Select
	End Sub

	Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Enter, _txtCampo_1.Enter, _txtCampo_2.Enter
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		VLPaso = True
		Select Case Index
			Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1153))
			Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1666))
			Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1821))
		End Select
		txtCampo(Index).SelectionStart = 0
		txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
	End Sub

	Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_0.KeyDown, _txtCampo_1.KeyDown, _txtCampo_2.KeyDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If cmbTipo.Text = FMLoadResString(1911) Then
            VLProducto = "4"
        ElseIf cmbTipo.Text = FMLoadResString(1911) Then
            VLProducto = "3"
        End If
        If eventArgs.KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    If txtCampo(1).Text.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(1269), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(1).Focus()
                        Exit Sub
                    End If
                    VLPaso = True
                    VGOperacion = "sp_parametro_extracto"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4140")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "V1")
                    PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT1, txtCampo(1).Text)
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, CStr(1))
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_parametro_extracto", True, FMLoadResString(1545)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(0).Text = VGACatalogo.Codigo
                        lblDescripcion(2).Text = VGACatalogo.Descripcion
                        If txtCampo(0).Text.Trim() = System.String.Empty Then
                            txtCampo(0).Text = System.String.Empty
                            lblDescripcion(2).Text = System.String.Empty
                            txtCampo(2).Text = System.String.Empty
                            txtCampo(0).Focus()
                        End If
                        FCatalogo.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                    End If
                Case 1
                    VLPaso = True
                    VGOperacion = "sp_parametro_extracto"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4140")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VLProducto)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_parametro_extracto", True, FMLoadResString(1102)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(1).Text = VGACatalogo.Codigo
                        lblDescripcion(1).Text = VGACatalogo.Descripcion
                        If txtCampo(1).Text.Trim() = System.String.Empty Then
                            txtCampo(1).Text = System.String.Empty
                            lblDescripcion(1).Text = System.String.Empty
                            txtCampo(0).Text = System.String.Empty
                            lblDescripcion(2).Text = System.String.Empty
                            txtCampo(2).Text = System.String.Empty
                            txtCampo(1).Focus()
                        Else
                            txtCampo(0).Text = System.String.Empty
                            lblDescripcion(2).Text = System.String.Empty
                            txtCampo(2).Text = System.String.Empty
                            txtCampo(1).Focus()
                        End If
                        FCatalogo.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                    End If
            End Select
        End If
	End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_0.KeyPress, _txtCampo_1.KeyPress, _txtCampo_2.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 1, 2
				If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
					KeyAscii = 0
				End If
            Case 0
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

	Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Leave, _txtCampo_1.Leave, _txtCampo_2.Leave
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		If VLPaso Then
			Exit Sub
		End If
		Select Case Index
			Case 0
                If txtCampo(0).Text.Trim() = "" Then
                    lblDescripcion(2).Text = ""
                    Exit Sub
                End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4140")
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "V1")
				PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VLProducto)
				PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
				PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(0).Text)
				PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, CStr(2))
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_parametro_extracto", True, FMLoadResString(1545) & "[" & txtCampo(Index).Text & "]") Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(2))
                    PMChequea(sqlconn)
                    txtCampo(2).Text = ""
                    txtCampo(2).Focus()
                Else
                    PMChequea(sqlconn)
                    txtCampo(0).Text = ""
                    lblDescripcion(2).Text = ""
                    txtCampo(0).Focus()
                End If
            Case 1
                If txtCampo(1).Text.Trim() = "" Then
                    lblDescripcion(1).Text = ""
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4140")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VLProducto)
                PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_parametro_extracto", True, FMLoadResString(1102) & "[" & txtCampo(Index).Text & "]") Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(1))
                    PMChequea(sqlconn)
                    txtCampo(0).Text = ""
                    lblDescripcion(2).Text = ""
                    txtCampo(2).Text = ""
                Else
                    PMChequea(sqlconn)
                    txtCampo(1).Text = ""
                    lblDescripcion(1).Text = ""
                    txtCampo(0).Text = ""
                    lblDescripcion(2).Text = ""
                    txtCampo(2).Text = ""
                    txtCampo(1).Focus()
                End If
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
	End Sub

	Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_0.MouseDown, _txtCampo_1.MouseDown, _txtCampo_2.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0, 1, 2
				My.Computer.Clipboard.Clear()
        End Select
	End Sub

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_4.Click, _cmdBoton_6.Click, _cmdBoton_5.Click, _cmdBoton_1.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        If cmbTipo.Text = FMLoadResString(1912) Then
            VLProducto = "3"
        ElseIf cmbTipo.Text = FMLoadResString(1911) Then
            VLProducto = "4"
        End If
        TSBotones.Focus()
		Select Case Index
			Case 0
				PLBuscar()
			Case 1
				PLSiguientes()
			Case 2
				PLTransmitir()
			Case 3
				PLActualizar()
			Case 4
				PLEliminar()
			Case 5
				PLLimpiar()
			Case 6
                Me.Close()
        End Select
	End Sub

	Private Sub PLBuscar()
		PMLimpiaGrid(grdCategorias)
		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4138")
		PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S2")
		PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VLProducto)
		PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT1, txtCampo(1).Text)
		PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(0).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_parametro_extracto", True, FMLoadResString(1554)) Then
            PMMapeaGrid(sqlconn, grdCategorias, False)
            PMMapeaTextoGrid(grdCategorias)
            PMChequea(sqlconn)
            PMAnchoColumnasGrid(grdCategorias)
            cmdBoton(1).Enabled = CDbl(Convert.ToString(grdCategorias.Tag)) >= 20
        Else
            PMChequea(sqlconn)
            PLModoInsertar(True)
            txtCampo(1).Focus()
        End If
        PLTSEstado()
	End Sub

	Private Sub PLSiguientes()
		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4138")
		PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S3")
		PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VLProducto)
		grdCategorias.Col = 1
		grdCategorias.Row = grdCategorias.Rows - 1
		PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, grdCategorias.CtlText)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_parametro_extracto", True, FMLoadResString(1554)) Then
            PMMapeaGrid(sqlconn, grdCategorias, True)
            PMMapeaTextoGrid(grdCategorias)
            PMAnchoColumnasGrid(grdCategorias)
            PMChequea(sqlconn)
            cmdBoton(1).Enabled = CDbl(Convert.ToString(grdCategorias.Tag)) >= 20
        Else
            PMChequea(sqlconn)
            PLModoInsertar(True)
            txtCampo(1).Focus()
        End If
        PLTSEstado()
	End Sub

	Private Sub PLTransmitir()
		If txtCampo(1).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(1269), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtCampo(1).Focus()
			Exit Sub
		End If
		If txtCampo(0).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(1421), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtCampo(0).Focus()
			Exit Sub
		End If
		If txtCampo(2).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(1233), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtCampo(2).Focus()
			Exit Sub
		End If
		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4136")
		PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
		PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VLProducto)
		PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
		PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(0).Text)
		PMPasoValores(sqlconn, "@i_valor", 0, SQLINT2, txtCampo(2).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_parametro_extracto", True, FMLoadResString(1919)) Then
            PMMapeaGrid(sqlconn, grdCategorias, False)
            PMMapeaTextoGrid(grdCategorias)
            PMAnchoColumnasGrid(grdCategorias)
            PMChequea(sqlconn)
            PLBuscar()
            txtCampo(1).Focus()
        Else
            PMChequea(sqlconn)
            txtCampo(1).Focus()
        End If
	End Sub

	Private Sub PLEliminar()
		Const MB_YESNO As Integer = 4
		Const MB_ICONQUESTION As Integer = 32
		Const MB_DEBUTTON1 As Integer = 0
		Const IDYES As Integer = 6
		Dim DgDef As COBISMsgBox.COBISButtons = MB_YESNO + MB_ICONQUESTION + MB_DEBUTTON1
        Dim Response As String = CStr(COBISMsgBox.MsgBox(FMLoadResString(1866), DgDef, FMLoadResString(1472)))
		If StringsHelper.ToDoubleSafe(Response) = IDYES Then
			PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4139")
			PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
			PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VLProducto)
			PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
			PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(0).Text)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_parametro_extracto", True, FMLoadResString(1581)) Then
                PMChequea(sqlconn)
                PMLimpiaGrid(grdCategorias)
                PLLimpiar()
            Else
                PMChequea(sqlconn)
            End If
		Else
			Exit Sub
		End If
	End Sub

	Private Sub PLActualizar()
		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4137")
		PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
		PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
		PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VLProducto)
		PMPasoValores(sqlconn, "@i_valor", 0, SQLINT1, txtCampo(2).Text)
		PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(0).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_parametro_extracto", True, FMLoadResString(1536)) Then
            PMChequea(sqlconn)
            cmdBoton_Click(cmdBoton(0), New EventArgs())
        Else
            PMChequea(sqlconn)
        End If
	End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBSiguiente.Enabled = _cmdBoton_1.Enabled
        TSBSiguiente.Visible = _cmdBoton_1.Visible
        TSBCrear.Enabled = _cmdBoton_2.Enabled
        TSBCrear.Visible = _cmdBoton_2.Visible
        TSBActualizar.Enabled = _cmdBoton_3.Enabled
        TSBActualizar.Visible = _cmdBoton_3.Visible
        TSBEliminar.Enabled = _cmdBoton_4.Enabled
        TSBEliminar.Visible = _cmdBoton_4.Visible
        TSBLimpiar.Enabled = _cmdBoton_5.Enabled
        TSBLimpiar.Visible = _cmdBoton_5.Visible
        TSBSalir.Enabled = _cmdBoton_6.Enabled
        TSBSalir.Visible = _cmdBoton_6.Visible
    End Sub


	Private Sub PLLimpiar()
		PMLimpiaGrid(grdCategorias)
		lblDescripcion(0).Text = ""
		lblDescripcion(1).Text = ""
		lblDescripcion(2).Text = ""
		txtCampo(0).Text = ""
		txtCampo(1).Text = ""
        txtCampo(2).Text = ""
        cmbTipo.Enabled = True
        txtCampo(0).Enabled = True
        txtCampo(1).Enabled = True
        cmbTipo.SelectedIndex = 1
		txtCampo(1).Focus()
		PLModoInsertar(True)
	End Sub

    'Private Sub PLGrilla()
    '	grdCategorias.ColWidth(1) = 700
    '	grdCategorias.ColWidth(2) = 1000
    '	grdCategorias.ColWidth(3) = 2200
    '	grdCategorias.ColWidth(4) = 1800
    '	grdCategorias.ColWidth(5) = 4200
    'End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
		
    End Sub

    Private Sub grdCategorias_Leave(sender As Object, e As EventArgs) Handles grdCategorias.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private Sub cmbTipo_SelectedValueChanged(sender As Object, e As EventArgs) Handles cmbTipo.SelectedValueChanged
        If cmbTipo.Text = FMLoadResString(1912) Then
            VLProducto = "3"
        ElseIf cmbTipo.Text = FMLoadResString(1911) Then
            VLProducto = "4"
        End If
    End Sub
End Class


