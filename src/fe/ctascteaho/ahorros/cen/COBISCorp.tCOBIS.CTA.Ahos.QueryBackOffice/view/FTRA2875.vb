Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary

Partial Public Class Ftran2875Class
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

	Dim VLPaso As Integer = 0

	Private Sub Ftran2875_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
		PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLTSEstado()
	End Sub

	Private Sub Ftran2875_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
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
		Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502203)) 'Código de Funcionario Autorizante [F5 Ayuda]
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502204)) 'Código de Funcionario Ejecutor [F5 Ayuda]
        End Select
		txtCampo(Index).SelectionStart = 0
		txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
	End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_1.KeyPress, _txtCampo_0.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0, 1
				KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
		End Select
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_1.KeyDown, _txtCampo_0.KeyDown
		Dim KeyCode As Integer = eventArgs.KeyCode
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Dim VTMatriz(20, 200) As String
		Dim VTR As Integer = 0
        If KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "411")
                    PMPasoValores(sqlconn, "@i_autorizante", 0, SQLINT2, "-1")
                    PMPasoValores(sqlconn, "@i_ejecutor", 0, SQLINT2, "0")
                    PMPasoValores(sqlconn, "@i_tipo_f", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S1")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_mant_fun_aut", True, FMLoadResString(509040)) Then 'Ok... Consulta de funcionarios autorizantes
                        VTR = FMMapeaMatriz(sqlconn, VTMatriz)
                        PMChequea(sqlconn)
                        If VTR > 0 Then
                            For a As Integer = 1 To VTR
                                FCatalogo.lstCatalogo.Items.Add(VTMatriz(0, a) & (Strings.Chr(9).ToString()) & VTMatriz(1, a))
                            Next a
                        End If
                        FCatalogo.ShowPopup(Me)
                        txtCampo(0).Text = VGACatalogo.Codigo
                        lblDescripcion(0).Text = VGACatalogo.Descripcion
                        VLPaso = True
                        If txtCampo(1).Enabled And txtCampo(1).Visible Then txtCampo(1).Focus()
                    Else
                        PMChequea(sqlconn)
                    End If
                Case 1
                    FGFuncionarios.ShowPopup(Me)
                    If VGBusqueda(1) <> "" Then
                        txtCampo(Index).Text = VGBusqueda(1)
                        lblDescripcion(Index).Text = VGBusqueda(2)
                        VLPaso = True
                    End If
            End Select
        End If
        ComprobarCampos()
	End Sub

	Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Leave, _txtCampo_0.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If Not VLPaso And txtCampo(Index).Text <> "" Then
                    If Conversion.Val(txtCampo(Index).Text) > 32000 Then
                        COBISMessageBox.Show(FMLoadResString(500460), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Tipo de Dato inválido
                        If txtCampo(Index).Enabled And txtCampo(Index).Visible Then txtCampo(Index).Focus()
                        Exit Sub
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "411")
                    PMPasoValores(sqlconn, "@i_autorizante", 0, SQLINT2, txtCampo(Index).Text)
                    PMPasoValores(sqlconn, "@i_ejecutor", 0, SQLINT2, "0")
                    PMPasoValores(sqlconn, "@i_tipo_f", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q1")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_mant_fun_aut", True, FMLoadResString(508836)) Then 'Ok... Consulta de funcionario autorizante
                        PMMapeaObjeto(sqlconn, lblDescripcion(Index))
                        PMChequea(sqlconn)
                        VLPaso = True
                    Else
                        PMChequea(sqlconn)
                        lblDescripcion(Index).Text = ""
                        txtCampo(Index).Text = ""
                        If txtCampo(Index).Enabled And txtCampo(Index).Visible Then txtCampo(Index).Focus()
                    End If
                End If
            Case 1
                If Not VLPaso And txtCampo(Index).Text <> "" Then
                    txtCampo(Index).Text = txtCampo(Index).Text.Trim()
                    If Conversion.Val(txtCampo(Index).Text) > 32000 Then
                        COBISMessageBox.Show(FMLoadResString(500460), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Tipo de Dato inválido
                        lblDescripcion(Index).Text = ""
                        If txtCampo(Index).Enabled And txtCampo(Index).Visible Then txtCampo(Index).Focus()
                        Exit Sub
                    End If
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                    PMPasoValores(sqlconn, "@i_funcionario", 0, SQLINT4, txtCampo(Index).Text)
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1577")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_funcionario", True, "") Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(Index))
                        PMChequea(sqlconn)
                        VLPaso = True
                    Else
                        PMChequea(sqlconn)
                        txtCampo(Index).Text = ""
                        lblDescripcion(Index).Text = ""
                        If txtCampo(Index).Enabled And txtCampo(Index).Visible Then txtCampo(Index).Focus()
                        VLPaso = True
                    End If
                End If
                If txtCampo(Index).Text = "" Then
                    lblDescripcion(Index).Text = ""
                End If
        End Select
        ComprobarCampos()
	End Sub

    Sub ComprobarCampos()
        If lblDescripcion(0).Text <> "" And lblDescripcion(1).Text <> "" Then
            cmdBoton(0).Enabled = True
        Else
            cmdBoton(0).Enabled = False
        End If
        PLTSEstado()
    End Sub

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_2.Click, _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_5.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Select Case Index
			Case 0
				PLTransmitir()
			Case 1
				PLEliminar()
			Case 4
				PLLimpiar()
			Case 5
				PLBuscar()
			Case 2
				Me.Close()
		End Select
	End Sub

	Private Sub PLBuscar()
		If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502198), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'El código del funcionario autorizante es mandatorio
			If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).Focus()
			Exit Sub
		End If
		PMLimpiaGrid(grdAutorizantes)
		Dim VTRegistros As Integer = 20
		Dim VTFlag As Boolean = False
		Dim VTModo As String = "0"
		Dim VTSecuencial As String = ""
		If txtCampo(1).Text.Trim() <> "" Then
			VTSecuencial = txtCampo(1).Text
		End If
		While VTRegistros = 20
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "414")
			PMPasoValores(sqlconn, "@i_autorizante", 0, SQLINT2, txtCampo(0).Text)
			If VTSecuencial.Trim() <> "" Then
				PMPasoValores(sqlconn, "@i_ejecutor", 0, SQLINT2, VTSecuencial)
			End If
			PMPasoValores(sqlconn, "@i_tipo_f", 0, SQLCHAR, "D")
			PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
			PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, VTModo)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_mant_fun_aut", True, FMLoadResString(509041)) Then ' Ok... Consulta de funcionarios ejecutores
                PMMapeaGrid(sqlconn, grdAutorizantes, VTFlag)
                PMChequea(sqlconn)
                VTFlag = True
                VTModo = "1"
                VTRegistros = Conversion.Val(Convert.ToString(grdAutorizantes.Tag))
                grdAutorizantes.Row = grdAutorizantes.Rows - 1
                grdAutorizantes.Col = 3
                VTSecuencial = grdAutorizantes.CtlText
            Else
                PMChequea(sqlconn)
                VTRegistros = 0
            End If
		End While
		If grdAutorizantes.Rows <= 2 Then
			grdAutorizantes.Row = 1
			grdAutorizantes.Col = 1
            If grdAutorizantes.CtlText.Trim() = "" Then
                cmdBoton(1).Enabled = False
                cmdBoton(0).Enabled = True
            Else
                cmdBoton(0).Enabled = False
            End If
        Else
            cmdBoton(1).Enabled = False
            cmdBoton(0).Enabled = False
		End If
        PMAnchoColumnasGrid(grdAutorizantes)
        PLTSEstado()
    End Sub

	Private Sub PLLimpiar()
		txtCampo(0).Enabled = True
		txtCampo(0).Text = ""
		txtCampo(1).Enabled = True
		txtCampo(1).Text = ""
		lblDescripcion(0).Text = ""
		lblDescripcion(1).Text = ""
		PMLimpiaGrid(grdAutorizantes)
		cmdBoton(1).Enabled = False
		cmdBoton(0).Enabled = True
		VLPaso = True
        If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).Focus()
        PLTSEstado()
	End Sub

	Private Sub PLTransmitir()
		If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502198), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'El código del funcionario autorizante es mandatorio
			If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).Focus()
			Exit Sub
		End If
		If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502205), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'El código del funcionario ejecutor es mandatorio
			If txtCampo(1).Enabled And txtCampo(1).Visible Then txtCampo(1).Focus()
			Exit Sub
		End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "415")
		PMPasoValores(sqlconn, "@i_autorizante", 0, SQLINT2, txtCampo(0).Text)
		PMPasoValores(sqlconn, "@i_ejecutor", 0, SQLINT2, txtCampo(1).Text)
		PMPasoValores(sqlconn, "@i_tipo_f", 0, SQLCHAR, "D")
		PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_mant_fun_aut", True, FMLoadResString(509042)) Then 'Ok... Creación de funcionario ejecutor
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
            'PLLimpiar()
        End If
        txtCampo(1).Text = ""
        lblDescripcion(1).Text = ""
        txtCampo(1).Enabled = True
        PLBuscar()
        txtCampo(1).Focus()
	End Sub

	Private Sub PLEliminar()
		If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502198), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'El código del funcionario autorizante es mandatorio
			If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).Focus()
			Exit Sub
		End If
		If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502205), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'El código del funcionario ejecutor es mandatorio
			If txtCampo(1).Enabled And txtCampo(1).Visible Then txtCampo(1).Focus()
			Exit Sub
		End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "416")
		PMPasoValores(sqlconn, "@i_autorizante", 0, SQLINT2, txtCampo(0).Text)
		PMPasoValores(sqlconn, "@i_ejecutor", 0, SQLINT2, txtCampo(1).Text)
		PMPasoValores(sqlconn, "@i_tipo_f", 0, SQLCHAR, "D")
		PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_mant_fun_aut", True, FMLoadResString(509043)) Then
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
        txtCampo(1).Text = ""
        lblDescripcion(1).Text = ""
        txtCampo(1).Enabled = True
        PLBuscar()
        txtCampo(1).Focus()
	End Sub

    Private Sub grdAutorizantes_ClickEvent(sender As Object, e As EventArgs) Handles grdAutorizantes.ClickEvent
        PMMarcaFilaCobisGrid(grdAutorizantes, grdAutorizantes.Row)
    End Sub

	Private Sub grdAutorizantes_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdAutorizantes.DblClick
		If grdAutorizantes.Rows <= 2 Then
			grdAutorizantes.Row = 1
			grdAutorizantes.Col = 1
			If grdAutorizantes.CtlText.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(502206), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'No existen funcionarios ejecutores asociados al funcionario autorizante
				Exit Sub
			End If
		End If
		grdAutorizantes.Col = 1
		txtCampo(0).Text = grdAutorizantes.CtlText
		grdAutorizantes.Col = 2
		lblDescripcion(0).Text = grdAutorizantes.CtlText
		grdAutorizantes.Col = 3
		txtCampo(1).Text = grdAutorizantes.CtlText
		grdAutorizantes.Col = 4
		lblDescripcion(1).Text = grdAutorizantes.CtlText
		cmdBoton(0).Enabled = False
		cmdBoton(1).Enabled = True
		txtCampo(0).Enabled = False
        txtCampo(1).Enabled = False
        PLTSEstado()
        PMMarcaFilaCobisGrid(grdAutorizantes, grdAutorizantes.Row)
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Visible = _cmdBoton_5.Visible
        TSBBuscar.Enabled = _cmdBoton_5.Enabled
        TSBEliminar.Visible = _cmdBoton_1.Visible
        TSBEliminar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_4.Visible
        TSBLimpiar.Enabled = _cmdBoton_4.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub grdAutorizantes_Enter(sender As Object, e As EventArgs) Handles grdAutorizantes.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5223))
    End Sub

    Private Sub grdAutorizantes_Leave(sender As Object, e As EventArgs) Handles grdAutorizantes.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

End Class


