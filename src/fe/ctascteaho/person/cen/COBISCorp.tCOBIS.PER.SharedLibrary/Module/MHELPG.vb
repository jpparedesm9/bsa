Option Strict Off
Option Explicit On
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
Public Module MHELPG
    Public Structure RegistroREC
        Dim nombre As String
        Dim valor As String
        Dim tipo As Integer
        Public Shared Function CreateInstance() As RegistroREC
            Dim result As New RegistroREC
            result.nombre = String.Empty
            result.valor = String.Empty
            Return result
        End Function
    End Structure

    Public Structure RegistroSIG
        Dim nombre As String
        Dim Col As Integer
        Dim tipo As Integer
        Public Shared Function CreateInstance() As RegistroSIG
            Dim result As New RegistroSIG
            result.nombre = String.Empty
            Return result
        End Function
    End Structure

    Public AGBuscar() As RegistroREC = Nothing
    Public AGSiguiente() As RegistroSIG = Nothing
    Public Temporales() As String
    Public VGPBuscar As Integer = 0
    Public VGPSiguiente As Integer = 0
    Public VGBaseDatos As String = ""

    Sub PMBuscarG(ByRef posicion As Integer, ByRef nombre As String, ByRef valor As String, ByRef tipo As Integer)
        AGBuscar(posicion).nombre = nombre
        AGBuscar(posicion).valor = valor
        AGBuscar(posicion).tipo = tipo
    End Sub

    Sub PMHelpG(ByRef base_datos As String, ByRef stored_procedure As String, ByRef par_buscar As Integer, ByRef par_sig As Integer)
        grid_valores.dl_sp.Text = stored_procedure
        VGPBuscar = par_buscar
        VGPSiguiente = par_sig
        VGBaseDatos = base_datos
        ReDim AGBuscar(VGPBuscar)
        ReDim AGSiguiente(VGPSiguiente)
    End Sub

    Sub PMLimpiaG(ByRef GridControl As COBISCorp.Framework.UI.Components.COBISGrid)
        If TypeOf GridControl Is COBISCorp.Framework.UI.Components.COBISGrid Then
            GridControl.Tag = "0"
            GridControl.FixedRows = 1
            GridControl.FixedCols = 1
            GridControl.Cols = 2
            GridControl.Rows = 2
            For i As Integer = 0 To 1
                For j As Integer = 0 To 1
                    GridControl.Row = i
                    GridControl.Col = j
                    GridControl.CtlText = ""
                Next j
            Next i
        End If
    End Sub

    Sub PMLineaG(ByRef GridControl As COBISCorp.Framework.UI.Components.COBISGrid)
        If GridControl.Rows >= 2 Then
            If GridControl.Row > 0 Then
                GridControl.Col = 0
                GridControl.SelStartCol = 1
                GridControl.SelEndCol = GridControl.Cols - 1
                GridControl.SelStartRow = GridControl.Row
                GridControl.SelEndRow = GridControl.Row
            End If
        End If
    End Sub

    Sub PMProcesG()
        grid_valores.bb_siguiente.Enabled = grid_valores.gr_SQL.Rows >= VGMaximoRows
    End Sub

    Sub PMSigteG(ByRef posicion As Integer, ByRef nombre As String, ByRef Col As Integer, ByRef tipo As Integer)
        AGSiguiente(posicion).nombre = nombre
        AGSiguiente(posicion).Col = Col
        AGSiguiente(posicion).tipo = tipo
    End Sub

End Module


