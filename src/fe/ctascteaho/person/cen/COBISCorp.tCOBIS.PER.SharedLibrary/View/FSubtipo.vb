Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
 public  Partial  Class FSubtipoClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Private Sub cmbTipo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbTipo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1662) & cmbTipo.Text)
	End Sub

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_4.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Dim VTFilas As Integer = 0
		Dim VTCodigo As String = string.Empty
        Dim VLProd As String = String.Empty
        TSBotones.Focus()
		Select Case Index
			Case 0
				VTFilas = VGMaxRows
				VTCodigo = "0"
				While VTFilas = VGMaxRows
					PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4158")
					PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
					VLProd = Strings.Mid(cmbTipo.Text, 1, 1)
					PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, VLProd)
					PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, txtCampo(0).Text)
					PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "0")
					PMPasoValores(sqlconn, "@i_siguiente", 0, SQLINT2, VTCodigo)
					If txtCampo(1).Text <> "" Then
						PMPasoValores(sqlconn, "@i_subtipo", 0, SQLVARCHAR, txtCampo(1).Text)
						PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "1")
					End If
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenimiento_std", True, FMLoadResString(2516)) Then
                        If VTCodigo = "0" Then
                            PMMapeaGrid(sqlconn, grdSubtipo, False)
                        Else
                            PMMapeaGrid(sqlconn, grdSubtipo, True)
                        End If
                        PMMapeaTextoGrid(grdSubtipo)
                        PMAnchoColumnasGrid(grdSubtipo)
                        PMChequea(sqlconn)
                        If txtCampo(1).Text = "" Then
                            VTFilas = Conversion.Val(Convert.ToString(grdSubtipo.Tag))
                            grdSubtipo.Col = 6
                            grdSubtipo.Row = grdSubtipo.Rows - 1
                            VTCodigo = grdSubtipo.CtlText
                            PMAnchoColumnasGrid(grdSubtipo)
                            If Conversion.Val(Convert.ToString(grdSubtipo.Tag)) > 0 Then
                                grdSubtipo.ColIsVisible(6) = False

                            End If

                        End If
                        txtCampo(1).Focus()
                        If Conversion.Val(Convert.ToString(grdSubtipo.Tag)) < VGMaxRows Then
                            Exit Sub
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
				End While
			Case 1
				If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1413), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(1).Focus()
					Exit Sub
				End If
				If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1415), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(2).Focus()
					Exit Sub
				End If
				If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1414), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(3).Focus()
					Exit Sub
				End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4158")
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
				VLProd = Strings.Mid(cmbTipo.Text, 1, 1)
				PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, VLProd)
				PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, txtCampo(0).Text)
				PMPasoValores(sqlconn, "@i_subtipo", 0, SQLVARCHAR, txtCampo(1).Text)
				PMPasoValores(sqlconn, "@i_desc_subtipo", 0, SQLVARCHAR, txtCampo(2).Text)
				PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, txtCampo(3).Text)
				PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "0")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenimiento_std", True, FMLoadResString(2517)) Then
                    PMChequea(sqlconn)
                    cmdBoton_Click(cmdBoton(3), New EventArgs())
                    cmdBoton_Click(cmdBoton(0), New EventArgs())
                Else
                    PMChequea(sqlconn)
                End If
			Case 2
				If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1413), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(1).Focus()
					Exit Sub
				End If
				If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1415), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(2).Focus()
					Exit Sub
				End If
				If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1414), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(3).Focus()
					Exit Sub
				End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4158")
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
				VLProd = Strings.Mid(cmbTipo.Text, 1, 1)
				PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, VLProd)
				PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, txtCampo(0).Text)
				PMPasoValores(sqlconn, "@i_subtipo", 0, SQLVARCHAR, txtCampo(1).Text)
				PMPasoValores(sqlconn, "@i_desc_subtipo", 0, SQLVARCHAR, txtCampo(2).Text)
				PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, txtCampo(3).Text)
				PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "0")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenimiento_std", True, FMLoadResString(2518)) Then
                    PMChequea(sqlconn)
                    cmdBoton_Click(cmdBoton(3), New EventArgs())
                    cmdBoton_Click(cmdBoton(0), New EventArgs())
                    cmdBoton(1).Enabled = True
                    cmdBoton(2).Enabled = False
                Else
                    PMChequea(sqlconn)
                End If
			Case 3
				txtCampo(1).Text = ""
				txtCampo(2).Text = ""
				txtCampo(3).Text = ""
				lblDescripcion(1).Text = ""
				cmbTipo.SelectedIndex = 1
				txtCampo(1).Enabled = True
				txtCampo(1).Focus()
				cmdBoton(1).Enabled = True
                cmdBoton(2).Enabled = False
                PMLimpiaGrid(grdSubtipo)
                cmdBoton_Click(cmdBoton(0), New EventArgs())
                txtCampo(1).Focus()
			Case 4
                Me.Close()
        End Select
        PLTSEstado()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

	Private Sub FSubtipo_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        cmbTipo.Items.Insert(0, "3 - CUENTA CORRIENTE")
        cmbTipo.Items.Insert(1, "4 - CUENTA DE AHORRO")
        cmbTipo.SelectedIndex = 1
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        MyAppGlobals.AppActiveForm = ""
		PMObjetoSeguridad(cmdBoton(0))
		PMObjetoSeguridad(cmdBoton(1))
		PMObjetoSeguridad(cmdBoton(2))
		cmdBoton(2).Enabled = False
        cmdBoton_Click(cmdBoton(0), New EventArgs())
        PLTSEstado()
    End Sub

    Private Sub grdSubtipo_ClickEvent(sender As Object, e As EventArgs) Handles grdSubtipo.ClickEvent
        grdSubtipo.Col = 0
        grdSubtipo.SelStartCol = 1
        grdSubtipo.SelEndCol = grdSubtipo.Cols - 1
        If grdSubtipo.Row = 0 Then
            grdSubtipo.SelStartRow = 1
            grdSubtipo.SelEndRow = 1
        Else
            grdSubtipo.SelStartRow = grdSubtipo.Row
            grdSubtipo.SelEndRow = grdSubtipo.Row
        End If
    End Sub

	Private Sub grdSubtipo_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdSubtipo.DblClick
		Dim VTRow As Integer = grdSubtipo.Row
		grdSubtipo.Row = 1
		grdSubtipo.Col = 1
		If grdSubtipo.CtlText <> "" Then
			grdSubtipo.Row = VTRow
			grdSubtipo.Col = 1
			txtCampo(0).Enabled = True
			txtCampo(0).Text = grdSubtipo.CtlText
			txtCampo(0).Enabled = False
			txtCampo_Leave(txtCampo(0), New EventArgs())
			grdSubtipo.Col = 3
			txtCampo(1).Text = grdSubtipo.CtlText
			txtCampo(1).Enabled = False
			grdSubtipo.Col = 4
			txtCampo(2).Text = grdSubtipo.CtlText
			grdSubtipo.Col = 5
			txtCampo(3).Text = grdSubtipo.CtlText
			txtCampo_Leave(txtCampo(3), New EventArgs())
			PMObjetoSeguridad(cmdBoton(2))
            cmdBoton(1).Enabled = False
            cmdBoton(2).Enabled = True
			txtCampo(2).Focus()
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
            Case 0, 1
            Case 2, 3
        End Select
    End Sub

	Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.Enter, _txtCampo_2.Enter, _txtCampo_1.Enter, _txtCampo_0.Enter
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1662))
			Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1732))
			Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1209))
			Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1334))
		End Select
	End Sub

	Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_3.KeyDown, _txtCampo_2.KeyDown, _txtCampo_1.KeyDown, _txtCampo_0.KeyDown
		Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 3
				If KeyCode = VGTeclaAyuda Then
					PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
					PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "cl_estado_ser")
					PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
					PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(2515)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(Index).Text = VGACatalogo.Codigo
                        lblDescripcion(1).Text = VGACatalogo.Descripcion
                        FCatalogo.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                        txtCampo(Index).Text = ""
                        lblDescripcion(1).Text = ""
                        txtCampo(Index).Focus()
                    End If
				End If
		End Select
	End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_3.KeyPress, _txtCampo_2.KeyPress, _txtCampo_1.KeyPress, _txtCampo_0.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0, 1
				If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
					KeyAscii = 0
				End If
			Case 2
                If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 96) Or (KeyAscii > 123)) Then
                    KeyAscii = 0
                Else
                    KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                End If
			Case 3
				If (KeyAscii <> 8) And (KeyAscii <> 32) And (KeyAscii < 65 Or KeyAscii > 90) And (KeyAscii < 97 Or KeyAscii > 122) Then
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
        Select Case Index
            Case 0
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4003")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(0).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prod_bancario", False, FMLoadResString(1918)) Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(0))
                    PMChequea(sqlconn)
                    txtCampo(Index).Enabled = False
                Else
                    PMChequea(sqlconn)
                End If
            Case 3
                If txtCampo(Index).Text <> "" Then
                    lblDescripcion(1).Text = ""
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_estado_ser")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtCampo(Index).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(2515) & "[" & txtCampo(Index).Text & "]") Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(1))
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        txtCampo(Index).Text = ""
                        lblDescripcion(1).Text = ""
                        txtCampo(Index).Focus()
                    End If
                Else
                    lblDescripcion(1).Text = ""
                End If
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_3.Enabled
        TSBLimpiar.Visible = _cmdBoton_3.Visible
        TSBSalir.Enabled = _cmdBoton_4.Enabled
        TSBCrear.Enabled = _cmdBoton_1.Enabled
        TSBCrear.Visible = _cmdBoton_1.Visible
        TSBActualizar.Enabled = _cmdBoton_2.Enabled
        TSBActualizar.Visible = _cmdBoton_2.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        txtCampo(0).Focus()
        txtCampo(1).Focus()
    End Sub

    Private Sub grdSubtipo_Enter(sender As Object, e As EventArgs) Handles grdSubtipo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1391))
    End Sub

    Private Sub grdSubtipo_Leave(sender As Object, e As EventArgs) Handles grdSubtipo.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub cmbTipo_Leave(sender As Object, e As EventArgs) Handles cmbTipo.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub cmbTipo_SelectionChangeCommitted(sender As Object, e As EventArgs) Handles cmbTipo.SelectionChangeCommitted
        txtCampo(1).Text = ""
        txtCampo(2).Text = ""
        txtCampo(3).Text = ""
        lblDescripcion(1).Text = ""
        txtCampo(1).Enabled = True
        txtCampo(1).Focus()
        cmdBoton(1).Enabled = True
        cmdBoton(2).Enabled = False
        PMLimpiaGrid(grdSubtipo)
        cmdBoton_Click(cmdBoton(0), New EventArgs())
    End Sub
End Class


