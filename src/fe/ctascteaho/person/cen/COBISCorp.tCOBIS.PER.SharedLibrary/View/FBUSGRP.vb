Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
 public  Partial  Class FBuscarGrupoClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Dim VLcriterio As Integer = 0

	Private Sub cmdBuscar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBuscar_1.Click, _cmdBuscar_0.Click
		Dim Index As Integer = Array.IndexOf(cmdBuscar, eventSender)
		Dim KeyAscii As Integer = 0
		KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
		Dim VTCriterio As String = ""
		Dim VTModo As Integer = 0
		If optCriterio(0).Checked Then
			PMPasoValores(sqlconn, "@i_tipo", 0, SQLINT1, "2")
			VTCriterio = "A"
		Else
			PMPasoValores(sqlconn, "@i_tipo", 0, SQLINT1, "1")
			VTCriterio = "C"
		End If
		Select Case Index
			Case 0
				VTModo = False
				If (txtValor.Text.IndexOf("%"c) + 1) = 0 Then
					PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "2")
				Else
					PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
					PMPasoValores(sqlconn, "@i_valor", 0, SQLVARCHAR, txtValor.Text)
				End If
			Case 1
				VTModo = True
				PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
				PMPasoValores(sqlconn, "@i_valor", 0, SQLVARCHAR, txtValor.Text)
				Select Case VTCriterio
					Case "A"
						grdResultados.Row = grdResultados.Rows - 1
						grdResultados.Col = 2
						PMPasoValores(sqlconn, "@i_nombre", 0, SQLVARCHAR, grdResultados.CtlText)
					Case "C"
						grdResultados.Row = grdResultados.Rows - 1
						grdResultados.Col = 1
						PMPasoValores(sqlconn, "@i_grupo", 0, SQLINT4, grdResultados.CtlText)
				End Select
		End Select
		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "150")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_qr_grupo", True, FMLoadResString(1036)) Then
            PMMapeaGrid(sqlconn, grdResultados, VTModo)
            PMChequea(sqlconn)
            cmdBuscar(1).Enabled = Conversion.Val(Convert.ToString(grdResultados.Tag)) >= VGMaximoRows - 1
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
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
		If grdResultados.Rows >= 2 And grdResultados.CtlText <> "" Then
			grdResultados.Row = VTRow
			VTCols = grdResultados.Cols - 1
			ReDim VGBusqueda(VTCols)
			VGBusqueda(0) = "G"
			For i As Integer = 1 To grdResultados.Cols - 1
				grdResultados.Col = i
				VGBusqueda(i) = grdResultados.CtlText
			Next i
			COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
			COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
            'Me.Hide()'19/05/2016 migracion
            Me.Close()
		End If
	End Sub

	Private Sub cmdEscoger_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdEscoger.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1327))
	End Sub

	Private Sub cmdSalir_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSalir.Click
		ReDim VGBusqueda(1)
        'Me.Hide() '18/05/2016 migracion
        Me.Close()
	End Sub

	Private Sub cmdSalir_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSalir.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1698))
	End Sub

    Private Sub FBuscarGrupo_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        VLcriterio = 0
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLTSEstado()
    End Sub

	Private Sub FBuscarGrupo_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

	Private Sub grdResultados_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdResultados.Click
		PMLineaG(grdResultados)
	End Sub

	Private Sub grdResultados_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdResultados.DblClick
		cmdEscoger_Click(cmdEscoger, New EventArgs())
	End Sub

	Private Sub grdResultados_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdResultados.Enter
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1219))
	End Sub

	Private isInitializingComponent As Boolean = false

	Private Sub optCriterio_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optCriterio_0.CheckedChanged, _optCriterio_1.CheckedChanged
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
		Select Case Index
			Case 0
				If Value Then
					If VLcriterio <> 0 Then
						VLcriterio = 0
						txtValor.Text = "%"
						cmdBuscar(1).Enabled = False
					End If
				End If
			Case 1
				If Value Then
					If VLcriterio <> 1 Then
						VLcriterio = 1
						txtValor.Text = "%"
						cmdBuscar(1).Enabled = False
					End If
				End If
		End Select
	End Sub

	Private Sub optCriterio_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optCriterio_0.Enter, _optCriterio_1.Enter
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1704))
	End Sub

	Private Sub txtValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtValor.Enter
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1169))
	End Sub

	Private Sub txtValor_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtValor.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub txtValor_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtValor.Leave
        txtValor.Text = txtValor.Text.Trim().ToUpper()
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

    Private Sub optCriterio_Leave(sender As Object, e As EventArgs) Handles _optCriterio_0.Leave, _optCriterio_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
End Class


