Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
 Public  Partial  Class FTrprobanClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLProducto As Integer = 0

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_3.Click, _cmdBoton_2.Click, _cmdBoton_5.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTEstado As String = System.String.Empty
        Dim VTFilas As Integer = 0
        Dim VTCodigo As String = System.String.Empty
        TSBotones.Focus()
		Select Case Index
			Case 0
                If txtCampo(1).Text = System.String.Empty Then
                    COBISMessageBox.Show(FMLoadResString(1425), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
				If optBoton(0).Checked Then
					VTEstado = "V"
				Else
					VTEstado = "N"
				End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4000")
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
				PMPasoValores(sqlconn, "@i_descripcion", 0, SQLCHAR, txtCampo(1).Text)
				PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, VTEstado)
				PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prod_bancario", True, FMLoadResString(1920)) Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(0))
                    PMChequea(sqlconn)
                    cmdBoton(0).Enabled = False
                    cmdBoton_Click(cmdBoton(3), New EventArgs())
                Else
                    PMChequea(sqlconn)
                End If
			Case 1
                txtCampo(1).Text = System.String.Empty
                lblDescripcion(0).Text = System.String.Empty
                lblDescripcion(1).Text = System.String.Empty
				optBoton(0).Checked = True
                PMLimpiaGrid(grdProductos)
                cmdBoton(0).Enabled = True
                cmdBoton(4).Enabled = False
				cmdBoton_Click(cmdBoton(3), New EventArgs())
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(System.String.Empty)
                txtCampo(1).Focus()
                VLProducto = 0
			Case 2
                Me.Close()
            Case 3
                VTFilas = VGMaxRows
                VTCodigo = "0"
                VLProducto = 0
                While VTFilas = VGMaxRows
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4002")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, VTCodigo)
                    PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT2, VGFormatoFechaInt)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prod_bancario", True, FMLoadResString(1918)) Then
                        If VTCodigo = "0" Then
                            PMMapeaGrid(sqlconn, grdProductos, False)
                        Else
                            PMMapeaGrid(sqlconn, grdProductos, True)
                        End If
                        PMMapeaTextoGrid(grdProductos)
                        PMAnchoColumnasGrid(grdProductos)
                        PMChequea(sqlconn)
                        VTFilas = Conversion.Val(Convert.ToString(grdProductos.Tag))
                        grdProductos.Col = 1
                        grdProductos.Row = grdProductos.Rows - 1
                        VTCodigo = grdProductos.CtlText
                        If Conversion.Val(Convert.ToString(grdProductos.Tag)) > 0 Then
                            grdProductos.ColAlignment(3) = 2
                            grdProductos.ColAlignment(4) = 2
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
                End While
                grdProductos.Row = 1
			Case 4
                If txtCampo(1).Text = System.String.Empty Then
                    COBISMessageBox.Show(FMLoadResString(1425), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
				If optBoton(0).Checked Then
					VTEstado = "V"
				Else
					VTEstado = "N"
				End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4001")
				PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, lblDescripcion(0).Text)
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
				PMPasoValores(sqlconn, "@i_descripcion", 0, SQLCHAR, txtCampo(1).Text)
				PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, VTEstado)
				PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prod_bancario", True, FMLoadResString(1922)) Then
                    PMChequea(sqlconn)
                    cmdBoton(4).Enabled = False
                    cmdBoton_Click(cmdBoton(3), New EventArgs())
                Else
                    PMChequea(sqlconn)
                End If
			Case 5
				If VLProducto > 0 Then
                    ReDim VGProductos(0)
					FSubtipo.txtCampo(0).Text = CStr(VLProducto)
					FSubtipo.txtCampo(0).Focus()
					FSubtipo.txtCampo(1).Focus()
                    FSubtipo.Show(Me)
                    Me.Close()
                Else
                    COBISMessageBox.Show(FMLoadResString(1641), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    Exit Sub
				End If
        End Select
        PLTSEstado()
	End Sub

	Private Sub FTrproban_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = System.String.Empty '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PMObjetoSeguridad(cmdBoton(3))
        PMObjetoSeguridad(cmdBoton(0))
        PMObjetoSeguridad(cmdBoton(4))
        PMObjetoSeguridad(cmdBoton(5))
        cmdBoton(4).Enabled = False
        cmdBoton_Click(cmdBoton(3), New EventArgs())
        PLTSEstado()
	End Sub

	Private Sub FTrproban_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(System.String.Empty)
	End Sub

    Private Sub grdProductos_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdProductos.ClickEvent
        grdProductos.Col = 1
        grdProductos.SelStartCol = 1
        grdProductos.SelEndCol = grdProductos.Cols - 1
        If grdProductos.Row = 0 Then
            grdProductos.SelStartRow = 1
            grdProductos.SelEndRow = 1
            cmdBoton(5).Enabled = False
        Else
            grdProductos.SelStartRow = grdProductos.Row
            grdProductos.SelEndRow = grdProductos.Row
            VLProducto = CInt(grdProductos.CtlText)
            grdProductos.Col = grdProductos.Cols - 1
            If grdProductos.CtlText <> "V" Then
                cmdBoton(5).Enabled = False
            Else
                cmdBoton(5).Enabled = True
            End If
        End If
        PLTSEstado()
    End Sub

	Private Sub grdProductos_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdProductos.DblClick
		Dim VTRow As Integer = grdProductos.Row
		grdProductos.Row = 1
		grdProductos.Col = 1
        If grdProductos.CtlText <> System.String.Empty Then
            grdProductos.Row = VTRow
            PMMarcarRegistro()
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

	Private Sub PMMarcarRegistro()
		grdProductos.Col = 1
		lblDescripcion(0).Text = grdProductos.CtlText
		grdProductos.Col = 2
		txtCampo(1).Text = grdProductos.CtlText
		grdProductos.Col = 3
		lblDescripcion(1).Text = grdProductos.CtlText
		grdProductos.Col = 4
		If grdProductos.CtlText = "V" Then
			optBoton(0).Checked = True
		Else
			optBoton(1).Checked = True
		End If
        PMObjetoSeguridad(cmdBoton(4))
		cmdBoton(0).Enabled = False
        txtCampo(1).Focus()
        PLTSEstado()
	End Sub

	Private Sub optBoton_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optBoton_0.Enter, _optBoton_1.Enter
		Dim Index As Integer = Array.IndexOf(optBoton, eventSender)
		Select Case Index
			Case 0, 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1336) & " [" & optBoton(Index).Text & "]")
		End Select
	End Sub

	Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Enter
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1206))
		End Select
		txtCampo(Index).SelectionStart = 0
		txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
	End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_1.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 1
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

    Private Sub PLTSEstado()
       
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBActualizar.Enabled = _cmdBoton_4.Enabled
        TSBActualizar.Visible = _cmdBoton_4.Visible
        TSBCrear.Enabled = _cmdBoton_0.Enabled
        TSBCrear.Visible = _cmdBoton_0.Visible
        TSBBuscar.Enabled = _cmdBoton_3.Enabled
        TSBBuscar.Visible = _cmdBoton_3.Visible
        TSBSubtipos.Enabled = _cmdBoton_5.Enabled
        TSBSubtipos.Visible = _cmdBoton_5.Visible
    End Sub


    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBSubtipos_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSubtipos.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
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

    Private Sub grdProductos_Leave(sender As Object, e As EventArgs) Handles grdProductos.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private Sub optBoton_Leave(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles _optBoton_0.Leave, _optBoton_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

End Class


