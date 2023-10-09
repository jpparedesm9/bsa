Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.VB
Imports Microsoft.VisualBasic
Imports System
Imports System.Globalization
Imports COBISCorp.eCOBIS.Commons.MessageBox
Public Module ModImprimir
    Public Const CG_RIGHT_ALIGN As Integer = 1
    Public Const CG_CENTER_ALIGN As Integer = 0
    Public Const CG_LEFT_ALIGN As Integer = -1
    Public Const CG_PORTRAIT As Integer = 1
    Public Const CG_LANDSCAPE As Integer = 2

    Private Function FLToken_Parameter(ByRef parCad As String, ByRef parToken As String) As Integer
        Dim VTchar As String = ""
        Dim VTIndice As String = ""
        Dim VTcont As Integer = 0
        Dim VTPos As Integer = (parCad.IndexOf(parToken) + 1)
        If VTPos > 0 Then
            VTchar = Strings.Mid(parCad, VTPos + parToken.Length, 1)
            VTcont = 1
            VTIndice = ""
            Dim dbNumericTemp As Double = 0
            Do While Double.TryParse(VTchar, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp)
                VTIndice = VTIndice & VTchar
                VTchar = Strings.Mid(parCad, VTPos + parToken.Length + VTcont, 1)
                VTcont += 1
            Loop
            Dim dbNumericTemp2 As Double = 0
            If Double.TryParse(VTIndice, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp2) Then
                parCad = (Strings.Left(parCad, VTPos - 1) & Strings.Mid(parCad, VTPos + parToken.Length + VTcont - 1)).TrimStart()
                Return CInt(VTIndice)
            End If
        End If
        Return -1
    End Function

    Private Sub PLPrint_String(ByRef parCad As String, ByRef parX As Single, ByRef parY As Single, ByRef parHBorder As Single, ByRef parVBorder As Single, ByRef parFBold As Integer, ByRef parFUnderline As Integer, ByRef parFSize As Integer)
        Dim VTAux As String = ""
        Dim VTcaracter As String = ""
        Dim VTSitio As Integer = 0
        Dim VTVeces As Integer = 0
        Dim VTPos As Integer = 0
        Dim VTi As Integer = 0
        Dim VTpasada As Integer = 0
        Dim VTLon As Integer = 0
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = CInt(parY)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = parFBold
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontUnderline = parFUnderline
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = parFSize
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.DrawWidth = 10
        Dim VTAncho As Single = COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.ScaleHeight - 1 - 2 * parHBorder
        Dim VTAlto As Single = COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.ScaleHeight - 1 - 2 * parVBorder
        Dim VTLon_Aux As Integer = 0
        Dim VTPIntermedio As Integer = 0
        Dim VTNLineas As Integer = 0
        If parX > parHBorder Then
            VTi = 1
            Do While COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.TextWidth(New String(Strings.Chr(32), VTi)) <= (parHBorder + VTAncho - parX)
                VTi += 1
            Loop
            VTPIntermedio = 1
            VTLon_Aux = VTi - 1
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = CInt(parX)
        Else
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = CInt(parHBorder)
        End If
        VTi = 1
        Do While COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.TextWidth(New String(Strings.Chr(32), VTi)) <= VTAncho
            VTi += 1
        Loop
        If VTPIntermedio = 0 Then
            VTLon = VTi - 1
        Else
            VTLon = VTLon_Aux
            VTLon_Aux = VTi - 1
        End If
        If parCad.Length > VTLon Then
            Do While parCad.Length > VTLon
                VTSitio = VTLon + 1
                VTcaracter = Strings.Mid(parCad, VTSitio, 1)
                Do While VTcaracter <> " "
                    If VTSitio > 1 Then
                        VTSitio -= 1
                        VTcaracter = Strings.Mid(parCad, VTSitio, 1)
                    End If
                    If VTcaracter = Strings.Chr(13).ToString() Then
                        VTcaracter = " "
                    End If
                Loop
                VTVeces = VTLon - (VTSitio - 1)
                VTAux = Strings.Left(parCad, VTSitio - 1)
                VTi = 1
                VTpasada = 1
                Do While VTVeces > 0
                    VTPos = Strings.InStr(VTi, VTAux, " ")
                    If VTPos > 0 Then
                        VTAux = Strings.Left(VTAux, VTPos - 1) & New String(" "c, VTpasada + 1) & Strings.Mid(VTAux, VTPos + VTpasada)
                        VTi = VTPos + VTpasada + 1
                        VTVeces -= 1
                    Else
                        If VTpasada = 1 And VTVeces = (VTLon - (VTSitio - 1)) Then
                            VTSitio = VTLon
                            VTAux = Strings.Left(parCad, VTSitio)
                            VTVeces = 0
                        Else
                            VTi = 1
                            VTpasada += 1
                        End If
                    End If
                Loop
                parCad = Strings.Mid(parCad, VTSitio + 1)
                If (COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY + COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.TextHeight(" ")) > (parVBorder + VTAlto) Then
                    COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.NewPage()
                    COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = CInt(parHBorder)
                    COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = CInt(parVBorder)
                End If
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(VTAux)
                VTNLineas += 1
                If VTPIntermedio <> 0 Then VTLon = VTLon_Aux
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = CInt(parHBorder)
            Loop
        End If
        If VTNLineas > 0 Then
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = CInt(parHBorder)
        Else
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = CInt(parX)
        End If
        If (COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY + COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.TextHeight(" ")) > (parVBorder + VTAlto) Then
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.NewPage()
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = CInt(parHBorder)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = CInt(parVBorder)
        End If
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(True, parCad)
        parY = COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY
        parX = COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX
    End Sub

    Public Sub PMImprimirReporte(ByRef parGrid As COBISCorp.Framework.UI.Components.COBISSpread, ByRef parNColumnas As Integer, ByRef parColumnas As Object, ByRef parSepColumnas As Object, ByRef parTitulo As Integer, ByRef parCaptionSubTitulos As Object, ByRef parValuesSubTitulos() As String, ByRef parAlineacion As Object, Optional ByRef parOrientacion As Integer = CG_PORTRAIT)
        Dim vbCentimeters As Integer = 0
        Dim VTUnidad As Integer = COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.ScaleMode
        If parGrid.MaxRows = 0 Then
            COBISMessageBox.Show(FMLoadResString(15155), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        Dim VTReport As New PrinterDll.Report
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.ScaleMode = vbCentimeters
        VTReport.FMSetTitleAlign(CShort(CG_CENTER_ALIGN))
        VTReport.FMSetTitleFont("Courier")
        VTReport.FMSetTitleFontBold(True)
        VTReport.FMSetTitleCaption(FMLoadResString(parTitulo))
        VTReport.FMSetTitleInEachPage(True)
        VTReport.FMSetHeaderPageNumbers(True)
        VTReport.FMSetHeaderAlign(CShort(CG_LEFT_ALIGN))
        VTReport.FMSetHeaderFontBold(False)
        VTReport.FMSetHeaderInEachPage(True)
        VTReport.FMSetHeaderShowDate(True)
        VTReport.FMSetHeaderNSubTitles(CShort(parCaptionSubTitulos.GetUpperBound(0) + 1))
        For VTi As Integer = 0 To parCaptionSubTitulos.GetUpperBound(0)
            VTReport.FMPutHeaderSubtitle(CShort(VTi), FMLoadResString(parCaptionSubTitulos.GetValue(VTi)), parValuesSubTitulos(VTi))
        Next VTi
        VTReport.FMSetDetailSize(7)
        VTReport.FMSetReportNColumns(CShort(parNColumnas))
        VTReport.PMLoad_Parameters(parGrid)
        If parAlineacion.GetUpperBound(0) = 0 Then
            For VTi As Integer = 0 To parNColumnas - 1
                VTReport.PMPutColumn(CShort(VTi), Convert.ToInt16(Conversion.Val(CStr(parColumnas.GetValue(VTi)))), Convert.ToInt16(Conversion.Val(CStr(parSepColumnas.GetValue(VTi)))), CShort(CG_LEFT_ALIGN))
            Next VTi
        Else
            For VTi As Integer = 0 To parNColumnas - 1
                VTReport.PMPutColumn(CShort(VTi), Convert.ToInt16(Conversion.Val(CStr(parColumnas.GetValue(VTi)))), Convert.ToInt16(Conversion.Val(CStr(parSepColumnas.GetValue(VTi)))), Convert.ToInt16(Conversion.Val(CStr(parAlineacion.GetValue(VTi)))))
            Next VTi
        End If
        VTReport.PMPrintReport(CShort(parOrientacion))
        VTReport = Nothing
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.ScaleMode = VTUnidad
    End Sub
End Module


