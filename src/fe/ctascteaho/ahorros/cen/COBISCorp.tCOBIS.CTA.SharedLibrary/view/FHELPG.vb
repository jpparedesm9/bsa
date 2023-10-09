Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Partial Public Class grid_valoresClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Private Sub bb_buscar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles bb_buscar.Click
        PMPasoValores(sqlconn, AGBuscar(1).nombre, 0, AGBuscar(1).Tipo, AGBuscar(1).valor)
        PMPasoValores(sqlconn, AGBuscar(2).nombre, 0, AGBuscar(2).Tipo, AGBuscar(2).valor)
        PMPasoValores(sqlconn, AGBuscar(3).nombre, 0, AGBuscar(3).Tipo, AGBuscar(3).valor)
        For i As Integer = 4 To VGPBuscar
            PMPasoValores(sqlconn, AGBuscar(i).nombre, 0, AGBuscar(i).Tipo, AGBuscar(i).valor)
        Next i
        If FMTransmitirRPC(sqlconn, ServerName, VGBaseDatos, dl_sp.Text, True, "Help") Then
            PMMapeaGrid(sqlconn, gr_SQL, False)
            PMMapeaTextoGrid(gr_SQL)
            PMAnchoColumnasGrid(gr_SQL)
            PMChequea(sqlconn)
            If (dl_sp.Text) <> "sp_hp_catalogo" Then
                bb_siguiente.Enabled = gr_SQL.Rows >= VGMaximoRows
            Else
                bb_siguiente.Enabled = False
            End If
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
    End Sub

    Private Sub bb_cancelar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles bb_cancelar.Click
        ReDim Temporales(10)
        PMLimpiaG(gr_SQL)
        Me.Dispose()
        Me.Close()
        Me.Hide()
    End Sub

    Private Sub bb_escoger_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles bb_escoger.Click
        gr_SQL_DoubleClick(gr_SQL, New EventArgs())
    End Sub

    Private Sub bb_siguiente_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles bb_siguiente.Click
        If gr_SQL.Rows >= VGMaximoRows Then
            PMPasoValores(sqlconn, AGBuscar(1).nombre, 0, AGBuscar(1).Tipo, AGBuscar(1).valor)
            PMPasoValores(sqlconn, AGBuscar(2).nombre, 0, AGBuscar(2).Tipo, AGBuscar(2).valor)
            PMPasoValores(sqlconn, AGBuscar(3).nombre, 0, AGBuscar(3).Tipo, Conversion.Str(Conversion.Val(AGBuscar(3).valor) + 1))
            For i As Integer = 4 To VGPBuscar
                PMPasoValores(sqlconn, AGBuscar(i).nombre, 0, AGBuscar(i).Tipo, AGBuscar(i).valor)
            Next i
            gr_SQL.Row = gr_SQL.Rows - 1
            For i As Integer = 1 To VGPSiguiente
                gr_SQL.Col = AGSiguiente(i).col
                PMPasoValores(sqlconn, AGSiguiente(i).nombre, 0, AGSiguiente(i).Tipo, gr_SQL.CtlText)
            Next i
            If FMTransmitirRPC(sqlconn, ServerName, VGBaseDatos, dl_sp.Text, True, "Help - Siguiente") Then
                PMMapeaGrid(sqlconn, gr_SQL, True)
                PMMapeaTextoGrid(gr_SQL)
                PMAnchoColumnasGrid(gr_SQL)
                PMChequea(sqlconn)
                bb_siguiente.Enabled = CDbl(Convert.ToString(gr_SQL.Tag)) >= VGMaximoRows - 1
                If gr_SQL.Rows >= (VGMaximoRows) Then
                    gr_SQL.TopRow = gr_SQL.Rows - VGMaximoRows
                End If
            Else
                PMChequea(sqlconn)
            End If
        End If
        PLTSEstado()
    End Sub

    Private Sub grid_valores_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        ReDim Temporales(10)
        PLTSEstado()
    End Sub

    Private Sub gr_SQL_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles gr_SQL.Click
        PMLineaG(gr_SQL)
    End Sub

    Private Sub gr_SQL_ClickEvent(sender As Object, e As EventArgs) Handles gr_SQL.ClickEvent
        PMLineaG(gr_SQL)
        PMMarcaFilaCobisGrid(gr_SQL, gr_SQL.Row)
    End Sub

    Private Sub gr_SQL_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles gr_SQL.DblClick
        If Conversion.Val(Convert.ToString(gr_SQL.Tag)) > 0 Then
            ReDim Temporales(gr_SQL.Cols - 1)
            For C As Integer = 1 To gr_SQL.Cols - 1
                gr_SQL.Col = C
                Temporales(C) = gr_SQL.CtlText
            Next C
            PMLimpiaG(gr_SQL)
        Else
            ReDim Temporales(10)
        End If
        Me.Hide()
    End Sub

    Private Sub gr_SQL_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles gr_SQL.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim KEY_ESCAPE As Integer = 0
        If KeyAscii = KEY_ESCAPE Then
            ReDim Temporales(10)
            PMLimpiaG(gr_SQL)
            Me.Hide()
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = bb_buscar.Enabled
        TSBBuscar.Visible = bb_buscar.Visible
        TSBCancelar.Enabled = bb_cancelar.Enabled
        TSBCancelar.Visible = bb_cancelar.Visible
        TSBEscoger.Enabled = bb_escoger.Enabled
        TSBEscoger.Visible = bb_escoger.Visible
        TSBSiguiente.Enabled = bb_siguiente.Enabled
        TSBSiguiente.Visible = bb_siguiente.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If bb_buscar.Enabled Then bb_buscar_Click(sender, e)
    End Sub

    Private Sub TSBCancelar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCancelar.Click
        If bb_cancelar.Enabled Then bb_cancelar_Click(sender, e)
    End Sub

    Private Sub TSBEscoger_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEscoger.Click
        If bb_escoger.Enabled Then bb_escoger_Click(sender, e)
    End Sub

    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If bb_siguiente.Enabled Then bb_siguiente_Click(sender, e)
    End Sub

    Private Sub bb_buscar_Enter(sender As Object, e As EventArgs) Handles bb_buscar.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500011))
    End Sub

    Private Sub bb_cancelar_Enter(sender As Object, e As EventArgs) Handles bb_cancelar.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500253))
    End Sub

    Private Sub bb_siguiente_Enter(sender As Object, e As EventArgs) Handles bb_siguiente.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500012))
    End Sub

    Private Sub bb_escoger_Enter(sender As Object, e As EventArgs) Handles bb_escoger.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500121))
    End Sub

    Private Sub gr_SQL_Enter(sender As Object, e As EventArgs) Handles gr_SQL.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2518))
    End Sub
End Class


