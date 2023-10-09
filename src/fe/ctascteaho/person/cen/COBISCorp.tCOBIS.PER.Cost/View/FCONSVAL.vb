Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
 Public  Partial  Class FConsValClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Dim VLPaso As Integer = 0
    Dim VLBoton As Boolean = False
    Dim VLAux As String = ""
    Dim VLLongitud As Integer
    Dim VLPosDeci As Integer

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_1.Click, _cmdBoton_0.Click, _cmdBoton_2.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Dim VTFilas As Integer = 0
        Dim VTSecuencial As String = ""
        PMLimpiaGrid(grdRegistros)
        TSBotones.Focus()
		Select Case Index
            Case 0
                If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1274), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                VTFilas = VGMaxRows
                VTSecuencial = "0"
                While VTFilas = VGMaxRows
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4059")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "CVV")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text)
                    PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, VTSecuencial)
                    PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFormatoFechaInt)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help2_costos", True, FMLoadResString(1594)) Then
                        If VTSecuencial = "0" Then
                            PMMapeaGrid(sqlconn, grdRegistros, False)
                        Else
                            PMMapeaGrid(sqlconn, grdRegistros, True)
                        End If
                        PMMapeaTextoGrid(grdRegistros)
                        PMAnchoColumnasGrid(grdRegistros)
                        PMChequea(sqlconn)
                        If Conversion.Val(Convert.ToString(grdRegistros.Tag)) > 0 Then
                            grdRegistros.ColAlignment(6) = 1
                            grdRegistros.ColAlignment(7) = 1
                            grdRegistros.ColAlignment(8) = 1
                            grdRegistros.ColAlignment(9) = 1
                            grdRegistros.ColAlignment(10) = 1
                            grdRegistros.ColAlignment(11) = 1
                            grdRegistros.ColAlignment(1) = 2
                            grdRegistros.ColAlignment(2) = 2
                            grdRegistros.ColAlignment(3) = 2
                            grdRegistros.ColAlignment(4) = 2

                        End If
                        grdRegistros.Col = 12
                        grdRegistros.Row = grdRegistros.Rows - 1
                        VTSecuencial = grdRegistros.CtlText
                    Else
                        PMChequea(sqlconn)
                    End If
                    VTFilas = Conversion.Val(Convert.ToString(grdRegistros.Tag))
                End While
                If grdRegistros.Cols >= 13 Then
                    grdRegistros.ColIsVisible(12) = False
                    If grdRegistros.ColWidth(1) <= 1800 Then grdRegistros.ColWidth(1) = 1800
                    If grdRegistros.ColWidth(2) <= 1800 Then grdRegistros.ColWidth(2) = 1665
                    If grdRegistros.ColWidth(3) <= 1800 Then grdRegistros.ColWidth(3) = 1335
                    If grdRegistros.ColWidth(4) <= 1800 Then grdRegistros.ColWidth(4) = 1425
                    If grdRegistros.ColWidth(5) <= 1800 Then grdRegistros.ColWidth(5) = 1710
                    If grdRegistros.ColWidth(6) <= 1800 Then grdRegistros.ColWidth(6) = 1050
                    If grdRegistros.ColWidth(7) <= 1800 Then grdRegistros.ColWidth(7) = 1110
                    If grdRegistros.ColWidth(8) <= 1800 Then grdRegistros.ColWidth(8) = 1110
                    If grdRegistros.ColWidth(9) <= 1800 Then grdRegistros.ColWidth(9) = 1110
                    If grdRegistros.ColWidth(10) <= 1800 Then grdRegistros.ColWidth(10) = 1110
                    If grdRegistros.ColWidth(11) <= 1800 Then grdRegistros.ColWidth(11) = 1110
                End If

                grdRegistros.Row = 1
                For VTi As Integer = 1 To grdRegistros.Rows - 1
                    grdRegistros.Row = VTi
                    For VTColumn As Integer = 9 To 11
                        grdRegistros.Col = VTColumn
                        VLLongitud = 0
                        If grdRegistros.CtlText <> "" And IsNumeric(grdRegistros.CtlText) Then
                            VLLongitud = Len(grdRegistros.CtlText)
                            If VLLongitud <> 1 Then
                                If InStr(grdRegistros.CtlText, ".") Then
                                    VLPosDeci = InStr(grdRegistros.CtlText, ".")
                                End If
                                If InStr(grdRegistros.CtlText, ",") Then
                                    VLPosDeci = InStr(grdRegistros.Text, ",")
                                End If
                                If VLPosDeci = VLLongitud - 1 Then
                                    grdRegistros.CtlText = grdRegistros.CtlText + "0"
                                    VLPosDeci = 0
                                End If

                            End If
                        End If
                    Next VTColumn
                Next VTi
                grdRegistros.Col = 1
                VLLongitud = 0
                VLPosDeci = 0
            Case 1
                txtCampo(0).Text = ""
                lblDescripcion(6).Text = ""
                txtCampo(0).Focus()
                PMLimpiaGrid(grdRegistros)
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
            Case 2
                Me.Close()
        End Select
	End Sub

	Private Sub FConsVal_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PMObjetoSeguridad(cmdBoton(0))
        PLTSEstado()
	End Sub

	Private Sub FConsVal_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
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
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502047))
	End Sub

	Private isInitializingComponent As Boolean = false

	Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.TextChanged

        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        ' VLAux = txtCampo(0).Text
		Select Case Index
            Case 0
                If VLAux <> txtCampo(0).Text Then
                    VLAux = txtCampo(0).Text
                    PMLimpiaGrid(grdRegistros)
                End If
                VLPaso = False
        End Select
	End Sub

	Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Enter
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		VLPaso = True
		Select Case Index
			Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1151))
		End Select
		txtCampo(Index).SelectionStart = 0
		txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
	End Sub

	Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_0.KeyDown
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
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", True, FMLoadResString(1913)) Then
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
			End Select
		End If
	End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_0.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0
				If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
					KeyAscii = 0
				End If
		End Select
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Leave
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0
				If Not VLPaso Then
					If txtCampo(0).Text <> "" Then
						If CDbl(txtCampo(0).Text) > 32000 Then
                            COBISMessageBox.Show(FMLoadResString(1263), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(0).Text = ""
                            lblDescripcion(6).Text = ""
                            txtCampo(0).Focus()
                            VLBoton = True
							Exit Sub
                        End If
                        VLBoton = False
						PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4078")
						PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(0).Text)
						PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
						PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", True, FMLoadResString(1913)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(6))
                            PMLimpiaGrid(grdRegistros)
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            lblDescripcion(6).Text = ""
                            txtCampo(0).Text = ""
                            txtCampo(0).Focus()
                            VLPaso = True
                        End If
					Else
						lblDescripcion(6).Text = ""
					End If
				End If
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
	End Sub

	Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_0.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0
				My.Computer.Clipboard.Clear()
        End Select
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

    Private Sub PLTSEstado()
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBBuscar.Visible = _cmdBoton_0.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Enabled
        TSBSalir.Visible = _cmdBoton_2.Enabled
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

    Private Sub grdRegistros_Leave(sender As Object, e As EventArgs) Handles grdRegistros.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
End Class


