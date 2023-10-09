Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
Public Module MHelpG
    Public Structure RegistroREC
        Dim Nombre As String
        Dim Valor As String
        Dim tipo As Integer
        Public Shared Function CreateInstance() As RegistroREC
            Dim result As New RegistroREC
            result.Nombre = String.Empty
            result.Valor = String.Empty
            Return result
        End Function
    End Structure

    Public Structure RegistroSIG
        Dim Nombre As String
        Dim Col As Integer
        Dim tipo As Integer
        Public Shared Function CreateInstance() As RegistroSIG
            Dim result As New RegistroSIG
            result.Nombre = String.Empty
            Return result
        End Function
    End Structure

    Public AGBuscar() As RegistroREC = Nothing
    Public AGSiguiente() As RegistroSIG = Nothing
    Public AGSiguiente2() As RegistroSIG = Nothing
    Public Temporales() As String
    Public VGPBuscar As Integer = 0
    Public VGPsiguiente As Integer = 0
    Public VGBaseDatos As String = ""

    Function FMValidaTipoDato(ByRef TipoDato As String, ByRef Valor As Integer) As Integer
        Dim result As Integer = 0
        result = Valor
        Select Case TipoDato
            Case "N"
                If (Valor <> 8) And (Valor <> 32) And ((Valor < 48) Or (Valor > 57)) Then
                    result = 0
                End If
            Case "A"
                If (Valor <> 8) And (Valor <> 32) And ((Valor < 65) Or (Valor > 90)) And ((Valor < 97) Or (Valor > 122)) And ((Valor < 48) Or (Valor > 57)) Then
                    result = 0
                Else
                    result = Strings.AscW(Strings.Chr(Valor).ToString().ToUpper())
                End If
            Case "U"
                result = Strings.AscW(Strings.Chr(Valor).ToString().ToUpper())
            Case "L"
                result = Strings.AscW(Strings.Chr(Valor).ToString().ToLower())
            Case "CU"
                If (Valor <> 8) And (Valor <> 32) And (Valor < 65 Or Valor > 90) And (Valor < 97 Or Valor > 122) Then
                    result = 0
                Else
                    result = Strings.AscW(Strings.Chr(Valor).ToString().ToUpper())
                End If
            Case "CL"
                If (Valor <> 8) And (Valor <> 32) And (Valor < 65 Or Valor > 90) And (Valor < 97 Or Valor > 122) Then
                    result = 0
                Else
                    result = Strings.AscW(Strings.Chr(Valor).ToString().ToLower())
                End If
            Case "M"
                If (Valor <> 8) And (Valor <> 32) And (Valor <> 46) And ((Valor < 48) Or (Valor > 57)) Then
                    result = 0
                End If
            Case "D"
                If (Valor <> 8) And (Valor <> 32) And (Valor <> 47) And ((Valor < 48) Or (Valor > 57)) Then
                    result = 0
                End If
        End Select
        Return result
    End Function

    Sub PMBuscarG(ByRef posicion As Integer, ByRef Nombre As String, ByRef Valor As String, ByRef tipo As Integer)
        AGBuscar(posicion).Nombre = Nombre
        AGBuscar(posicion).Valor = Valor
        AGBuscar(posicion).tipo = tipo
    End Sub

    'Sub PMHelpG(ByRef base_datos As String, ByRef stored_procedure As String, ByRef par_buscar As Integer, ByRef par_sig As Integer)
    '    grid_valores.dl_sp.Text = stored_procedure
    '    VGPBuscar = par_buscar
    '    VGPsiguiente = par_sig
    '    VGBaseDatos = base_datos
    '    ReDim AGBuscar(VGPBuscar)
    '    ReDim AGSiguiente(VGPsiguiente)
    'End Sub

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

    'Sub PMProcesG()
    '    grid_valores.TSBSiguiente.Enabled = grid_valores.gr_SQL.Rows >= VGMaximoRows And (grid_valores.gr_SQL.Rows Mod 20) = 0
    'End Sub

    Sub PMSigteG(ByRef posicion As Integer, ByRef Nombre As String, ByRef Col As Integer, ByRef tipo As Integer)
        AGSiguiente(posicion).Nombre = Nombre
        AGSiguiente(posicion).Col = Col
        AGSiguiente(posicion).tipo = tipo
    End Sub
End Module


