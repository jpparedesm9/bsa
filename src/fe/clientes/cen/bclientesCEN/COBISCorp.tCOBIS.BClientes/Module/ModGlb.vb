Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
public Module ModGlb
    Public fMain As Form
    Public VGDatosCliente() As String
    Public VGBusqueda() As String
    Public VGCodigoCliente As String = ""
    Public VGNombreCliente As String = ""
    Public VGOrigenCliente As String = ""
    Public VGDireccionesCliente(,) As String
    Public VGTelefonosCliente(,) As String
    Public VGOtrosDatosCliente(,) As String
    Public VGFormato As String = ""
    Public VGvalor2 As Boolean = false
    Public Const VGMaximoRows As Integer = 20
    Public VGAyuda() As String
    Public VGOperacion As String = ""
    Public DatabaseName As String = ""
    Public VGLogin As String = ""
    Public VGFormatoFecha As String = ""
    Public VGPathResouces As String = ""
    Public VGTIMERMAIL As Integer = 0
    Public VGLogTransacciones As String = ""
    Public VGProducto As String = ""
    Public VGTipoCli As String = ""
    Public VGProductos() As String
    Public VGCorreo As String = ""
    Public VGTeclaAyuda As Integer = 0
    Public VGFormatoFechaInt As Integer
    Public formato_fecha(,) As String
    Public VGFecha_SP As String = ""
    Public VGSucursalSig As Integer = 0
    Public PathUnico As String = ""
    Public Password As String = ""
    Public VGUsuario As String = ""
    Public VGUsuarioNombre As String = ""
    Public VGFechaProceso As String
    Public VGIndice As Integer = 0
    Public VGListindex As Integer = 0
    Public VGFormatoFechaStr As String = ""
    Public Const CGFormatoBase As String = "mm/dd/yyyy"
    Public VGPath As String = ""

    Public VGProductoLlamado As String = ""

    Dim i As Integer = 0
    Dim j As Integer = 0



    Sub PMLimpiag(ByRef GridControl As COBISCorp.Framework.UI.Components.COBISGrid)
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

    Sub PMAnchoColGrid(ByRef lista1 As COBISCorp.Framework.UI.Components.COBISGrid, ByRef Col As Integer)
        lista1.Col = Col
        Dim VTColMax As Integer = 5
        For i As Integer = 0 To lista1.Rows - 1
            lista1.Row = i
            If lista1.CtlText.TrimEnd().Length > VTColMax Then
                VTColMax = Strings.Len(lista1.CtlText)
            End If
        Next i
        VTColMax *= 110
        If VTColMax > 6500 Then
            lista1.ColWidth(CShort(Col)) = 6500
        Else
            lista1.ColWidth(CShort(Col)) = VTColMax
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

    Sub PMCopyClip(ByRef Grid As COBISCorp.Framework.UI.Components.COBISGrid)
        Dim NR As String = Strings.Chr(13).ToString()
        Dim NC As String = Strings.Chr(9).ToString()
        Dim Col1 As Integer = Grid.SelStartCol
        Dim Col2 As Integer = Grid.SelEndCol
        Dim Row1 As Integer = Grid.SelStartRow
        Dim Row2 As Integer = Grid.SelEndRow
        Grid.SelStartCol = 1
        Grid.SelEndCol = Grid.Cols - 1
        Grid.SelStartRow = 1
        Grid.SelEndRow = Grid.Rows - 1
        Dim ClipText As String = Grid.Clip
        Dim CopyText As String = ""
        CopyText = CopyText & NC
        For Count As Integer = 1 To ClipText.Length
            If Strings.Mid(ClipText, Count, 1) <> Strings.Chr(13).ToString() Then
                CopyText = CopyText & Strings.Mid(ClipText, Count, 1)
            Else
                CopyText = CopyText & NR & NC
            End If
        Next Count
        My.Computer.Clipboard.SetText(CopyText)
        Grid.SelStartCol = Col1
        Grid.SelEndCol = Col2
        Grid.SelStartRow = Row1
        Grid.SelEndRow = Row2
    End Sub

End Module

