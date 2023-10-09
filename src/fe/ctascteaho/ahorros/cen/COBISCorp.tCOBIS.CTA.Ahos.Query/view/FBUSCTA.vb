Option Strict Off
Option Explicit On
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
 Public  Partial  Class FBusCtaClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_0.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                PLEscoger()
            Case 1
                PLSiguientes()
            Case 2
                PLBuscar()
            Case 3
                Me.Close()
            Case 4
                PLLimpiar()
        End Select
    End Sub


    Private Sub PLInicializar()
        cmdBoton(2).Enabled = True
    End Sub
	Private Sub FBusCta_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        MyAppGlobals.AppActiveForm = ""
        PLInicializar()
    End Sub

	Private Sub grdCuentas_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdCuentas.Click
		grdCuentas.Col = 0
		grdCuentas.SelStartCol = 1
		grdCuentas.SelEndCol = grdCuentas.Cols - 1
		If grdCuentas.Row = 0 Then
			grdCuentas.SelStartRow = 1
			grdCuentas.SelEndRow = 1
		Else
			grdCuentas.SelStartRow = grdCuentas.Row
			grdCuentas.SelEndRow = grdCuentas.Row
		End If
	End Sub

	Private Sub grdCuentas_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdCuentas.DblClick
		PLEscoger()
	End Sub

	Private Sub PLLimpiar()
		PMLimpiaGrid(grdCuentas)
		grdCuentas.ColWidth(1) = 650
		cmdBoton(0).Enabled = False
		cmdBoton(1).Enabled = False
	End Sub

	Private Sub PLSiguientes()
		If txtcampo.Text.Trim() = "" Then
			COBISMessageBox.Show("El nombre es mandatorio", "Mensaje de Error", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			txtcampo.Focus()
			Exit Sub
		End If
		grdCuentas.Row = grdCuentas.Rows - 1
		grdCuentas.Col = 1
		grdCuentas.Col = 2
		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "340")
		PMPasoValores(sqlconn, "@i_nombre", 0, SQLCHAR, "")
		PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
		PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "2")
		PMPasoValores(sqlconn, "@i_cliente", 0, SQLINT1, txtcampo.Text)
		grdCuentas.Row = grdCuentas.Rows - 1
		grdCuentas.Col = 1
		PMPasoValores(sqlconn, "@i_cuenta", 0, SQLCHAR, Me.grdCuentas.CtlText)
		PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, txtProducto.Text)
		If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_helpcta_ah", True, " Ok... Consulta de Cuentas") Then
			PMMapeaGrid(sqlconn, grdCuentas, True)
			PMChequea(sqlconn)
			cmdBoton(1).Enabled = CDbl(Convert.ToString(grdCuentas.Tag)) = 20
        Else
            PMChequea(sqlconn)
        End If
    End Sub

	Private Sub PLBuscar()
		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "340")
		PMPasoValores(sqlconn, "@i_nombre", 0, SQLCHAR, "")
		PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
		PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "2")
		PMPasoValores(sqlconn, "@i_cliente", 0, SQLINT4, txtcampo.Text)
		PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, txtProducto.Text)
		If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_helpcta_ah", True, " Ok... Consulta de Cuentas") Then
			PMMapeaGrid(sqlconn, grdCuentas, False)
			PMChequea(sqlconn)
			cmdBoton(0).Enabled = True
			cmdBoton(1).Enabled = CDbl(Convert.ToString(grdCuentas.Tag)) = 20
        Else
            PMChequea(sqlconn)
        End If
    End Sub

	Private Sub PLEscoger()
		grdCuentas.Col = 1
		If grdCuentas.CtlText.Trim() <> "" Then
			VGADatosO(0) = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
		End If
		Me.Close()
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_2.Enabled
        TSBBuscar.Visible = _cmdBoton_2.Visible
        TSBSigtes.Enabled = _cmdBoton_1.Enabled
        TSBSigtes.Visible = _cmdBoton_1.Visible
        TSBEscoger.Enabled = _cmdBoton_0.Enabled
        TSBEscoger.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_4.Enabled
        TSBLimpiar.Visible = _cmdBoton_4.Visible
        TSBSalir.Enabled = _cmdBoton_3.Enabled
        TSBSalir.Visible = _cmdBoton_3.Visible

    End Sub


    Private Sub TSBBUSCAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBSIGTES_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSigtes.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBESCOGER_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEscoger.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBLIMPIAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBSALIR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
		
			PLBuscar()

    End Sub

    Private Sub txtcampo_Enter(sender As Object, e As EventArgs) Handles txtcampo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500163))
    End Sub

    Private Sub txtcampo_Leave(sender As Object, e As EventArgs) Handles txtcampo.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub txtcampo_TextChanged(sender As Object, e As EventArgs) Handles txtcampo.TextChanged

    End Sub

    Private Sub grdCuentas_Load(sender As Object, e As EventArgs) Handles grdCuentas.Load

    End Sub

    Private Sub grdCuentas_Enter(sender As Object, e As EventArgs) Handles grdCuentas.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2220))
    End Sub

    Private Sub grdCuentas_Leave(sender As Object, e As EventArgs) Handles grdCuentas.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
End Class


