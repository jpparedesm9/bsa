Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
 public  Partial  Class FBuscarLaborClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
  
    Dim FBuscarCliente = New COBISCorp.tCOBIS.BClientes.FBuscarClienteClass()

	Dim VLcriterio As Integer = 0

	Private Sub cmdBuscar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBuscar_1.Click, _cmdBuscar_0.Click
		Dim Index As Integer = Array.IndexOf(cmdBuscar, eventSender)
		Dim VTlblsp As String = ""
		Dim VTModo As Integer = 0
		If txtValor.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1173), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			Exit Sub
		End If
		If VLcriterio = 0 Then
			VTlblsp = "busqueda de empresas de un grupo"
		End If
		If VLcriterio = 1 Then
			VTlblsp = "busqueda de personas de una empresa"
		End If
		If VLcriterio = 2 Then
			VTlblsp = "busqueda de empresas laboró una persona"
		End If
		Select Case Index
			Case 0
				VTModo = False
				If VLcriterio = 0 Then
					PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1253")
					PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "EXG")
					PMPasoValores(sqlconn, "@i_grupo", 0, SQLINT4, txtValor.Text)
				End If
				If VLcriterio = 1 Then
					PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1255")
					PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "PXE")
					PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT4, txtValor.Text)
				End If
				If VLcriterio = 2 Then
					PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1254")
					PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "EXP")
					PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT4, txtValor.Text)
				End If
			Case 1
				VTModo = True
				grdResultados.Row = grdResultados.Rows - 1
				grdResultados.Col = 1
				If VLcriterio = 0 Then
					PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1253")
					PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "EXG")
					PMPasoValores(sqlconn, "@i_grupo", 0, SQLINT4, txtValor.Text)
					PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, grdResultados.CtlText)
				End If
				If VLcriterio = 1 Then
					PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1255")
					PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "PXE")
					PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT4, txtValor.Text)
					PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, grdResultados.CtlText)
				End If
				If VLcriterio = 2 Then
					PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1254")
					PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "EXP")
					PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT4, txtValor.Text)
					PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, grdResultados.CtlText)
				End If
		End Select
		If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_laboral", True, VTlblsp) Then
            PMMapeaGrid(sqlconn, grdResultados, VTModo)
            PMChequea(sqlconn)
			If Conversion.Val(Convert.ToString(grdResultados.Tag)) >= VGMaxRows Then
				cmdBuscar(1).Enabled = True
				cmdEscoger.Enabled = True
			Else
				cmdBuscar(1).Enabled = False
			End If
			If grdResultados.Rows > 21 Then
				grdResultados.TopRow = grdResultados.Rows - VGMaximoRows + 1
            End If
        Else
            PMChequea(sqlconn)
        End If
	End Sub

	Private Sub cmdBuscar_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBuscar_1.Enter, _cmdBuscar_0.Enter
		Dim Index As Integer = Array.IndexOf(cmdBuscar, eventSender)
		Select Case Index
			Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1029))
			Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1031))
		End Select
	End Sub

	Private Sub cmdEscoger_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdEscoger.Click
		Dim VTCols As Integer = 0
		Dim VTRow As Integer = grdResultados.Row
		grdResultados.Col = 1
		grdResultados.Row = 1
		If grdResultados.CtlText <> "" Then
			grdResultados.Row = VTRow
			VTCols = grdResultados.Cols - 1
			ReDim VGBusqueda(VTCols)
			VGBusqueda(0) = txtValor.Text
			For i As Integer = 1 To grdResultados.Cols - 1
				grdResultados.Col = i
				VGBusqueda(i) = grdResultados.CtlText
			Next i
			COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
			COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
            Me.Close()
		End If
	End Sub

	Private Sub cmdEscoger_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdEscoger.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1327))
	End Sub

	Private Sub cmdSalir_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSalir.Click
		ReDim VGBusqueda(1)
		txtValor.Text = ""
		lblnombre.Text = ""
        Me.close()
	End Sub

	Private Sub cmdSalir_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSalir.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1698))
	End Sub

	Private Sub FBuscarLabor_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        lblEtiqueta(0).Visible = False
        lblEtiqueta(1).Visible = False
        lblEtiqueta(2).Visible = False
        cmdBuscar(1).Enabled = False
        cmdEscoger.Enabled = False
        PLTSEstado()
    End Sub

    Private Sub FBuscarLabor_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdResultados_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdResultados.DblClick
        cmdEscoger_Click(cmdEscoger, New EventArgs())
    End Sub

    Private Sub grdResultados_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdResultados.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1394))
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub optCriterio_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optCriterio_2.CheckedChanged, _optCriterio_0.CheckedChanged, _optCriterio_1.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Index As Integer = Array.IndexOf(optCriterio, eventSender)
            Dim Value As Integer = optCriterio(Index).Checked
            optCriterio_ClickHelper(Index, Value)
        End If
    End Sub

    Private Sub optCriterio_ClickHelper(ByRef Index As Integer, ByRef Value As Integer)
        lblEtiqueta(0).Visible = False
        lblEtiqueta(1).Visible = False
        lblEtiqueta(2).Visible = False
        Select Case Index
            Case 0
                If Value Then
                    If VLcriterio <> 0 Then
                        VLcriterio = 0
                        cmdBuscar(1).Enabled = False
                        lblEtiqueta(0).Visible = True
                        txtValor.Text = ""
                        lblnombre.Text = ""
                        PMLimpiaGrid(grdResultados)
                    End If
                End If
            Case 1
                If Value Then
                    If VLcriterio <> 1 Then
                        VLcriterio = 1
                        cmdBuscar(1).Enabled = False
                        lblEtiqueta(1).Visible = True
                        txtValor.Text = ""
                        lblnombre.Text = ""
                        PMLimpiaGrid(grdResultados)
                    End If
                End If
            Case 2
                If Value Then
                    If VLcriterio <> 2 Then
                        VLcriterio = 2
                        cmdBuscar(1).Enabled = False
                        lblEtiqueta(2).Visible = True
                        txtValor.Text = ""
                        lblnombre.Text = ""
                        PMLimpiaGrid(grdResultados)
                    End If
                End If
        End Select
        PLTSEstado()
    End Sub

    Private Sub optCriterio_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optCriterio_2.Enter, _optCriterio_0.Enter, _optCriterio_1.Enter
        Dim Index As Integer = Array.IndexOf(optCriterio, eventSender)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1704))
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1320))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1635))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1319))
        End Select
    End Sub

    Private Sub txtValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtValor.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        If optCriterio(0).Checked Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1161))
        End If
        If optCriterio(1).Checked Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1154))
        End If
        If optCriterio(2).Checked Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1157))
        End If
    End Sub

    Private Sub txtValor_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtValor.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        If KeyCode = VGTeclaAyuda Then
            If optCriterio(0).Checked Then
                FBuscarGrupo.ShowPopup(Me)
                If VGBusqueda(1) <> "" Then
                    txtValor.Text = VGBusqueda(1)
                    lblnombre.Text = VGBusqueda(2)
                End If
                FBuscarGrupo.Dispose() '18/05/2016 migracion
                Exit Sub
            End If
            If optCriterio(1).Checked Then
                FBuscarCliente.optCliente(0).Enabled = False
                FBuscarCliente.optCliente(1).Enabled = True
                FBuscarCliente.optCliente(1).Checked = True
                FBuscarCliente.ShowPopup(Me)
                If VGBusqueda(1) <> "" Then
                    txtValor.Text = VGBusqueda(1)
                    lblnombre.Text = VGBusqueda(2) & " " & VGBusqueda(3) & " " & VGBusqueda(4)
                End If
                FBuscarCliente.Dispose() '18/05/2016 migracion
                Exit Sub
            End If
            If optCriterio(2).Checked Then
                FBuscarCliente.optCliente(0).Enabled = True
                FBuscarCliente.optCliente(1).Enabled = False
                FBuscarCliente.optCliente(0).Checked = True
                FBuscarCliente.ShowPopup(Me)
                If VGBusqueda(1) <> "" Then
                    txtValor.Text = VGBusqueda(1)
                    lblnombre.Text = VGBusqueda(2)
                End If
                FBuscarCliente.Dispose() '18/05/2016 migracion
                Exit Sub
            End If
        End If
    End Sub

	Private Sub txtValor_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtValor.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
			KeyAscii = 0
		End If
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub txtValor_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtValor.Leave
        Dim VTlblsp As String = ""
        Dim VTsp As String = ""
        txtValor.Text = txtValor.Text.Trim()
		If Conversion.Val(txtValor.Text) > 999999 Then
            COBISMessageBox.Show(FMLoadResString(1308), FMLoadResString(1115), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
			txtValor.Focus()
		End If
		cmdBuscar(0).Enabled = Not (txtValor.Text = "")
		If VLcriterio = 0 Then
			VTlblsp = "busqueda de empresas de un grupo"
		End If
		If VLcriterio = 1 Then
			VTlblsp = "busqueda de personas de una empresa"
		End If
		If VLcriterio = 2 Then
			VTlblsp = "busqueda de empresas laboró una persona"
		End If
		If VLcriterio = 0 Then
			PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1184")
			PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
			PMPasoValores(sqlconn, "@i_grupo", 0, SQLINT4, txtValor.Text)
			VTsp = "sp_grupo"
			ReDim VGBusqueda(17)
		End If
		If VLcriterio = 1 Or VLcriterio = 2 Then
			PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1190")
			PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, txtValor.Text)
			VTsp = "sp_qrente"
			ReDim VGBusqueda(3)
		End If
		If FMTransmitirRPC(sqlconn, ServerName, "cobis", VTsp, True, VTlblsp) Then
            FMMapeaArreglo(sqlconn, VGBusqueda)
			PMChequea(sqlconn)
			If VLcriterio = 0 Then
				txtValor.Text = VGBusqueda(1)
				lblnombre.Text = VGBusqueda(2)
			End If
			If VLcriterio = 1 Or VLcriterio = 2 Then
				lblnombre.Text = VGBusqueda(1).Trim()
            End If
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBuscar_0.Enabled
        TSBBuscar.Visible = _cmdBuscar_0.Visible
        TSBSiguiente.Enabled = _cmdBuscar_1.Enabled
        TSBSiguiente.Visible = _cmdBuscar_1.Visible
        TSBEscoger.Enabled = cmdEscoger.Enabled
        TSBEscoger.Visible = cmdEscoger.Visible
        TSBSalir.Visible = cmdSalir.Enabled
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBuscar_0.Enabled Then cmdBuscar_Click(_cmdBuscar_0, e)
    End Sub

    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If _cmdBuscar_1.Enabled Then cmdBuscar_Click(_cmdBuscar_1, e)
    End Sub

    Private Sub TSBEscoger_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEscoger.Click
        If cmdEscoger.Enabled Then cmdEscoger_Click(cmdEscoger, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If cmdSalir.Enabled Then cmdSalir_Click(cmdSalir, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
		
    End Sub

    Private Sub grdResultados_Leave(sender As Object, e As EventArgs) Handles grdResultados.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub optCriterio_Leave(sender As Object, e As EventArgs) Handles _optCriterio_0.Leave, _optCriterio_2.Leave, _optCriterio_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
End Class


