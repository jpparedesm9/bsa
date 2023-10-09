Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
 public  Partial  Class grid_valoresClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

	Private Sub bb_buscar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles bb_buscar.Click
		Dim Verdadero As Integer = 0
		Dim  Falso As Integer = 0
		PMPasoValores(sqlconn, AGBuscar(1).nombre, 0, AGBuscar(1).tipo, AGBuscar(1).valor)
		PMPasoValores(sqlconn, AGBuscar(2).nombre, 0, AGBuscar(2).tipo, AGBuscar(2).valor)
		PMPasoValores(sqlconn, AGBuscar(3).nombre, 0, AGBuscar(3).tipo, AGBuscar(3).valor)
		For i As Integer = 4 To VGPBuscar
			PMPasoValores(sqlconn, AGBuscar(i).nombre, 0, AGBuscar(i).tipo, AGBuscar(i).valor)
		Next i
        If FMTransmitirRPC(sqlconn, ServerName, VGBaseDatos, dl_sp.Text, True, FMLoadResString(1400)) Then
            PMMapeaGrid(sqlconn, gr_SQL, False)
            PMMapeaTextoGrid(gr_SQL)
            PMChequea(sqlconn)
            If gr_SQL.Rows >= VGMaximoRows Then
                bb_siguiente.Enabled = Verdadero
            Else
                bb_siguiente.Enabled = Falso
            End If
        Else
            PMChequea(sqlconn)
        End If
	End Sub

	Private Sub bb_cancelar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles bb_cancelar.Click
		ReDim Temporales(10)
		PMLimpiaG(gr_SQL)
        'Me.Hide() '18/05/2016
        Me.Close()
	End Sub

	Private Sub bb_escoger_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles bb_escoger.Click
		gr_SQL_DoubleClick(gr_SQL, New EventArgs())
	End Sub

	Private Sub bb_siguiente_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles bb_siguiente.Click
		If gr_SQL.Rows >= VGMaximoRows Then
			PMPasoValores(sqlconn, AGBuscar(1).nombre, 0, AGBuscar(1).tipo, AGBuscar(1).valor)
			PMPasoValores(sqlconn, AGBuscar(2).nombre, 0, AGBuscar(2).tipo, AGBuscar(2).valor)
			PMPasoValores(sqlconn, AGBuscar(3).nombre, 0, AGBuscar(3).tipo, Conversion.Str(Conversion.Val(AGBuscar(3).valor) + 1))
			For i As Integer = 4 To VGPBuscar
				PMPasoValores(sqlconn, AGBuscar(i).nombre, 0, AGBuscar(i).tipo, AGBuscar(i).valor)
			Next i
			gr_SQL.Row = gr_SQL.Rows - 1
			For i As Integer = 1 To VGPSiguiente
				gr_SQL.Col = AGSiguiente(i).Col
				PMPasoValores(sqlconn, AGSiguiente(i).nombre, 0, AGSiguiente(i).tipo, gr_SQL.CtlText)
			Next i
            If FMTransmitirRPC(sqlconn, ServerName, VGBaseDatos, dl_sp.Text, True, FMLoadResString(1401)) Then
                PMMapeaGrid(sqlconn, gr_SQL, False)
                PMMapeaTextoGrid(gr_SQL)
                PMChequea(sqlconn)
                bb_siguiente.Enabled = gr_SQL.Rows >= VGMaximoRows
            Else
                PMChequea(sqlconn)
            End If
		End If
	End Sub

	Private Sub gr_SQL_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles gr_SQL.Click
		PMLineaG(gr_SQL)
	End Sub

	Private Sub gr_SQL_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles gr_SQL.DblClick
		ReDim Temporales(gr_SQL.Cols - 1)
		For c As Integer = 1 To gr_SQL.Cols - 1
			gr_SQL.Col = c
			Temporales(c) = gr_SQL.CtlText
		Next c
        PMLimpiaG(gr_SQL)
        'Me.Hide() '18/05/2016 migracion
        Me.Close()
        End Sub

	Private Sub gr_SQL_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles gr_SQL.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		Dim KEY_ESCAPE As Integer = 0
		If KeyAscii = 13 Then
			ReDim Temporales(gr_SQL.Cols)
			For c As Integer = 1 To gr_SQL.Cols - 1
				gr_SQL.Col = c
				Temporales(c) = gr_SQL.CtlText
			Next c
			PMLimpiaG(gr_SQL)
            Me.Close()
        Else
            If KeyAscii = KEY_ESCAPE Then
                ReDim Temporales(10)
                PMLimpiaG(gr_SQL)
                Me.Close()
            End If
		End If
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub
    Private Sub PLTSEstado()
        TSBBuscar.Enabled = bb_buscar.Enabled
        TSBBuscar.Visible = bb_buscar.Visible
        TSBSiguiente.Enabled = bb_siguiente.Enabled
        TSBSiguiente.Visible = bb_siguiente.Visible
        TSBEscoger.Enabled = bb_escoger.Enabled
        TSBEscoger.Visible = bb_escoger.Visible
        TSBCancelar.Enabled = bb_cancelar.Enabled
        TSBCancelar.Visible = bb_cancelar.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If bb_buscar.Enabled Then bb_buscar_Click(bb_buscar, e)
    End Sub

    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If bb_siguiente.Enabled Then bb_siguiente_Click(bb_siguiente, e)
    End Sub

    Private Sub TSBEscoger_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEscoger.Click
        If bb_escoger.Enabled Then bb_escoger_Click(bb_escoger, e)
    End Sub

    Private Sub TSBCancelar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCancelar.Click
        If bb_cancelar.Enabled Then bb_cancelar_Click(bb_cancelar, e)
    End Sub


    Private Sub gr_SQL_Enter(sender As Object, e As EventArgs) Handles gr_SQL.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1456))
    End Sub

    Private Sub gr_SQL_Leave(sender As Object, e As EventArgs) Handles gr_SQL.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub grid_valoresClass_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLTSEstado()
    End Sub
End Class


