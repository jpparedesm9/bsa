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
 Public  Partial  Class FTrprobaenClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Dim VLPaso As Integer = 0
	Dim VLEnte As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_4.Click, _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_3.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTEstado As String = ""
        Dim VTFilas As Integer = 0
        Dim VTCodigo As String = String.Empty
        TSBotones.Focus()
        Select Case Index
            Case 0
                If optBoton(0).Checked Then
                    VTEstado = "V"
                Else
                    VTEstado = "N"
                End If
                If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1294), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1268), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4004")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
                PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, VTEstado)
                PMPasoValores(sqlconn, "@i_cod_prod", 0, SQLINT2, txtCampo(1).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mercado", True, FMLoadResString(1122)) Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(3))
                    cmdBoton(0).Enabled = False
                    PMChequea(sqlconn)
                    cmdBoton_Click(cmdBoton(3), New EventArgs())
                Else
                    PMChequea(sqlconn)
                End If
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
                txtCampo(0).Text = ""
                txtCampo(1).Text = ""
                lblDescripcion(0).Text = ""
                lblDescripcion(1).Text = ""
                lblDescripcion(2).Text = ""
                lblDescripcion(3).Text = ""
                optBoton(0).Checked = True
                cmdBoton(0).Enabled = True
                If Not txtCampo(0).Enabled Then
                    txtCampo(0).Enabled = True
                End If
                If Not txtCampo(1).Enabled Then
                    txtCampo(1).Enabled = True
                End If
                PMObjetoSeguridad(cmdBoton(0))
                PMObjetoSeguridad(cmdBoton(4))
                cmdBoton(4).Enabled = False
                txtCampo(0).Enabled = True
                txtCampo(0).Focus()
                PMLimpiaGrid(grdProductos)
            Case 2
                Me.Close()
            Case 3
                If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1294), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                VTFilas = VGMaxRows
                VTCodigo = "0"
                While VTFilas = VGMaxRows
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4006")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_mercado", 0, SQLINT2, VTCodigo)
                    PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, txtCampo(0).Text)
                    PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFormatoFechaInt)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mercado", True, FMLoadResString(1553)) Then
                        If VTCodigo = "0" Then
                            PMMapeaGrid(sqlconn, grdProductos, False)
                        Else
                            PMMapeaGrid(sqlconn, grdProductos, True)
                        End If
                        PMMapeaTextoGrid(grdProductos)
                        PMChequea(sqlconn)
                        VTFilas = Conversion.Val(Convert.ToString(grdProductos.Tag))
                        grdProductos.Col = 1
                        grdProductos.Row = grdProductos.Rows - 1
                        VTCodigo = grdProductos.CtlText
                        If Conversion.Val(Convert.ToString(grdProductos.Tag)) > 0 Then
                            grdProductos.ColAlignment(4) = 2
                            grdProductos.ColAlignment(5) = 2
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
                End While
                PMAnchoColumnasGrid(grdProductos)
                txtCampo(0).Enabled = False
                grdProductos.Row = 1
            Case 4
                If optBoton(0).Checked Then
                    VTEstado = "V"
                ElseIf optBoton(1).Checked Then
                    VTEstado = "N"
                End If
                If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1294), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1268), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4005")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
                PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, VTEstado)
                PMPasoValores(sqlconn, "@i_cod_prod", 0, SQLINT2, txtCampo(1).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mercado", True, FMLoadResString(1011)) Then
                    PMChequea(sqlconn)
                    cmdBoton(4).Enabled = False
                    cmdBoton_Click(cmdBoton(3), New EventArgs())
                Else
                    PMChequea(sqlconn)
                End If
        End Select
        PLTSEstado()
    End Sub

	Private Sub FTrprobaen_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
		PMBotonSeguridad(Me, 4)
		PMObjetoSeguridad(cmdBoton(3))
		PMObjetoSeguridad(cmdBoton(0))
        PMObjetoSeguridad(cmdBoton(4))
        cmdBoton(4).Enabled = False
        PLTSEstado()
	End Sub

	Private Sub FTrprobaen_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

    Private Sub grdProductos_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdProductos.ClickEvent
        grdProductos.Col = 0
        grdProductos.SelStartCol = 1
        grdProductos.SelEndCol = grdProductos.Cols - 1
        If grdProductos.Row = 0 Then
            grdProductos.SelStartRow = 1
            grdProductos.SelEndRow = 1
        Else
            grdProductos.SelStartRow = grdProductos.Row
            grdProductos.SelEndRow = grdProductos.Row
        End If
    End Sub

	Private Sub grdProductos_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdProductos.DblClick
        Dim VTRow As Integer = grdProductos.Row
        grdProductos.Row = VTRow '1
        grdProductos.Col = 1
        If _txtCampo_0.Text <> "" Then
            If grdProductos.CtlText <> "" Then
                grdProductos.Row = VTRow
                PMMarcarRegistro()
                txtCampo(1).Enabled = False
                txtCampo(0).Enabled = False
            End If
        End If
	
	End Sub

	Private Sub grdProductos_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdProductos.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1391))
	End Sub

	Private Sub grdProductos_KeyUp(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles grdProductos.KeyUp

        grdProductos.Col = 0
        grdProductos.SelStartCol = 1
        grdProductos.SelEndCol = grdProductos.Cols - 1
        If grdProductos.Row = 0 Then
            grdProductos.SelStartRow = 1
            grdProductos.SelEndRow = 1
        Else
            grdProductos.SelStartRow = grdProductos.Row
            grdProductos.SelEndRow = grdProductos.Row
        End If


	End Sub

	Private Sub optBoton_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optBoton_1.Enter, _optBoton_0.Enter
		Dim Index As Integer = Array.IndexOf(optBoton, eventSender)
		Select Case Index
			Case 0, 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1341) & " [" & optBoton(Index).Text & "]")
		End Select
	End Sub

	Private Sub PMMarcarRegistro()
		PMObjetoSeguridad(cmdBoton(4))
		cmdBoton(0).Enabled = False
        'PLTSEstado()
		grdProductos.Col = 1
		lblDescripcion(3).Text = grdProductos.CtlText
		grdProductos.Col = 2
		txtCampo(1).Text = grdProductos.CtlText
		grdProductos.Col = 3
		lblDescripcion(2).Text = grdProductos.CtlText
		grdProductos.Col = 4
		lblDescripcion(1).Text = grdProductos.CtlText
		grdProductos.Col = 5
		If grdProductos.CtlText = "V" Then
			optBoton(0).Checked = True
			optBoton(0).Focus()
		Else
			optBoton(1).Checked = True
			optBoton(1).Focus()
        End If
        PLTSEstado()
	End Sub

	Private isInitializingComponent As Boolean = false

	Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.TextChanged, _txtCampo_1.TextChanged
		If isInitializingComponent Then
			Exit Sub
		End If
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0, 1
				VLPaso = False
		End Select
	End Sub

	Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Enter, _txtCampo_1.Enter
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1776))
			Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1659))
		End Select
		txtCampo(Index).SelectionStart = 0
		txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
	End Sub

	Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_0.KeyDown, _txtCampo_1.KeyDown
		Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		If KeyCode = VGTeclaAyuda Then
			VLPaso = True
			Select Case Index
                Case 0
                    PMCatalogo("A", "cc_tipo_banca", txtCampo(0), lblDescripcion(0), FRegistros)
                    VLPaso = True
				Case 1
					VGOperacion = "sp_prod_bancario"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4002")
					PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
					PMPasoValores(sqlconn, "@i_modo", 0, SQLINT4, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prod_bancario", True, FMLoadResString(1918)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        txtCampo(1).Text = VGACatalogo.Codigo
                        lblDescripcion(2).Text = VGACatalogo.Descripcion
                        FRegistros.Dispose() '18/05/2016 migracion
                        VLPaso = True
                    Else
                        PMChequea(sqlconn)
                        VGOperacion = ""
                    End If
			End Select
		End If
	End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_0.KeyPress, _txtCampo_1.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 97) Or (KeyAscii > 122)) Then
                    KeyAscii = 0
                End If
                KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
            Case 1
                If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                    KeyAscii = 0
                End If
            Case 0, 2
                KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        End Select
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Leave, _txtCampo_1.Leave
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0
                If Not VLPaso Then
                    If txtCampo(0).Text = "" Then
                        lblDescripcion(0).Text = ""
                        Exit Sub
                    End If
                    PMCatalogo("V", "cc_tipo_banca", txtCampo(0), lblDescripcion(0), Nothing)
                End If
			Case 1
				If Not VLPaso Then
					If txtCampo(1).Text <> "" Then
						PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4003")
						PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
						PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(1).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prod_bancario", True, FMLoadResString(1918)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(2))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(1).Text = ""
                            lblDescripcion(2).Text = ""
                            txtCampo(1).Focus()
                        End If
					Else
						lblDescripcion(2).Text = ""
					End If
				End If
		End Select
	End Sub

	Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_0.MouseDown, _txtCampo_1.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0, 1
				My.Computer.Clipboard.Clear()
                'My.Computer.Clipboard.SetText("")
		End Select
    End Sub

    Private Sub PLTSEstado()
        TSBCrear.Enabled = _cmdBoton_0.Enabled
        TSBCrear.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBActualizar.Enabled = _cmdBoton_4.Enabled
        TSBActualizar.Visible = _cmdBoton_4.Visible
        TSBBuscar.Enabled = _cmdBoton_3.Enabled
        TSBBuscar.Visible = _cmdBoton_3.Visible
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
End Class


