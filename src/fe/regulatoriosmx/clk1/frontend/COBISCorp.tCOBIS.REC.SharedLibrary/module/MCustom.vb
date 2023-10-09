Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System.Globalization
Public Module MCustom

    Public Sub PMMapeaTextoGrid(ByRef parcontrol As COBISCorp.Framework.UI.Components.COBISGrid)
        Dim VTCabecera As String = ""
        Dim VTsCtlType As String = parcontrol.GetType().Name
        If VTsCtlType = "COBISGrid" Then
            For VTColumn As Integer = 0 To parcontrol.Cols - 1
                parcontrol.Row = 0
                parcontrol.Col = CShort(VTColumn)
                Dim dbNumericTemp As Double = 0
                If parcontrol.CtlText <> "" And Double.TryParse(parcontrol.CtlText, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp) Then
                    VTCabecera = PMReemplazaTildes(UCase(FMLoadResString(CInt(parcontrol.CtlText))))
                    parcontrol.CtlText = VTCabecera
                    'parcontrol.ColumnWidth = Len(VTCabecera) * 10
                End If
            Next VTColumn
            Exit Sub
        End If
        If VTsCtlType = "fpSpread" Then
            parcontrol.Row = 0
            For VTColumn As Integer = 1 To parcontrol.Cols
                parcontrol.Col = CShort(VTColumn)
                Dim dbNumericTemp2 As Double = 0
                If parcontrol.CtlText <> "" And Double.TryParse(parcontrol.CtlText, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp2) Then
                    VTCabecera = PMReemplazaTildes(UCase(FMLoadResString(CInt(parcontrol.CtlText))))
                    parcontrol.CtlText = VTCabecera
                End If
            Next VTColumn
            Exit Sub
        End If
        If VTsCtlType = "vaSpread" Then
            For VTColumn As Integer = 1 To parcontrol.Cols
                parcontrol.Row = 1
                parcontrol.Col = CShort(VTColumn)
                VTCabecera = PMReemplazaTildes(UCase(FMLoadResString(CInt(parcontrol.CtlText))))
                parcontrol.CtlText = VTCabecera
            Next VTColumn
        End If
    End Sub

    Public Function PMReemplazaTildes(parTexto As String) As String
        Return Replace(Replace(Replace(Replace(Replace(parTexto, "Á", "A"), "É", "E"), "Í", "I"), "Ó", "O"), "Ú", "U")
    End Function

    Public Sub PMMapeaTextoSGrid(ByRef parcontrol As COBISCorp.Framework.UI.Components.COBISSpread)
        Dim VTCabecera As String = ""
        Dim VTsCtlType As String = parcontrol.GetType().Name
        If VTsCtlType = "COBISGrid" Then
            For VTColumn As Integer = 0 To parcontrol.Col - 1
                parcontrol.Row = 0
                parcontrol.Col = CShort(VTColumn)
                Dim dbNumericTemp As Double = 0
                If parcontrol.Text <> "" And Double.TryParse(parcontrol.Text, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp) Then
                    VTCabecera = UCase(FMLoadResString(CInt(parcontrol.Text)))
                    parcontrol.Text = VTCabecera
                End If
            Next VTColumn
            Exit Sub
        End If
        If VTsCtlType = "fpSpread" Or VTsCtlType = "COBISSpread" Then
            parcontrol.Row = 0
            For VTColumn As Integer = 1 To parcontrol.Col
                parcontrol.Col = CShort(VTColumn)
                Dim dbNumericTemp2 As Double = 0
                If parcontrol.Text <> "" And Double.TryParse(parcontrol.Text, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp2) Then
                    VTCabecera = FMLoadResString(CInt(parcontrol.Text))
                    parcontrol.Text = VTCabecera
                    parcontrol.ColWidth.Set(VTColumn, Len(VTCabecera) * 1.5)
                End If
            Next VTColumn
            Exit Sub
        End If
        If VTsCtlType = "vaSpread" Then
            For VTColumn As Integer = 1 To parcontrol.Col
                parcontrol.Row = 1
                parcontrol.Col = CShort(VTColumn)
                VTCabecera = FMLoadResString(CInt(parcontrol.Text))
                parcontrol.Text = VTCabecera
            Next VTColumn
        End If
    End Sub

End Module



