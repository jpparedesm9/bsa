Option Strict Off
Option Explicit On
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
    Public Const vbCentimeters As Short = 7 'JSA

    Private Function FLToken_Parameter(ByRef parCad As String, ByRef parToken As String) As Integer
        Dim VTchar As String = ""
        Dim VTIndice As String = ""
        Dim VTcont As Integer = 0
        Dim VTpos As Integer = (parCad.IndexOf(parToken) + 1)
        If VTpos > 0 Then
            VTchar = Strings.Mid(parCad, VTpos + parToken.Length, 1)
            VTcont = 1
            VTIndice = ""
            Dim dbNumericTemp As Double = 0
            Do While Double.TryParse(VTchar, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp)
                VTIndice = VTIndice & VTchar
                VTchar = Strings.Mid(parCad, VTpos + parToken.Length + VTcont, 1)
                VTcont += 1
            Loop
            Dim dbNumericTemp2 As Double = 0
            If Double.TryParse(VTIndice, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp2) Then
                parCad = (Strings.Left(parCad, VTpos - 1) & Strings.Mid(parCad, VTpos + parToken.Length + VTcont - 1)).TrimStart()
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
        Dim VTpos As Integer = 0
        Dim vti As Integer = 0
        Dim VTpasada As Integer = 0
        Dim VTLon As Integer = 0
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = CInt(parY)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = parFBold
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontUnderline = parFUnderline
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = parFSize
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.DrawWidth = 10
        'JSA Dim VTAncho As Single = Printer.ScaleWidth - 1 - 2 * parHBorder
        Dim VTAncho As Single = 0
        'JSA Dim VTAlto As Single = Printer.ScaleHeight - 1 - 2 * parVBorder
        Dim VTAlto As Single = 0
        Dim VTLon_Aux As Integer = 0
        Dim VTPIntermedio As Integer = 0
        Dim VTNLineas As Integer = 0
        If parX > parHBorder Then
            vti = 1
            Do While COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.TextWidth(New String(Strings.Chr(32), vti)) <= (parHBorder + VTAncho - parX)
                vti += 1
            Loop
            VTPIntermedio = 1
            VTLon_Aux = vti - 1
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = CInt(parX)
        Else
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = CInt(parHBorder)
        End If
        vti = 1
        Do While COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.TextWidth(New String(Strings.Chr(32), vti)) <= VTAncho
            vti += 1
        Loop
        If VTPIntermedio = 0 Then
            VTLon = vti - 1
        Else
            VTLon = VTLon_Aux
            VTLon_Aux = vti - 1
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
                vti = 1
                VTpasada = 1
                Do While VTVeces > 0
                    VTpos = Strings.InStr(vti, VTAux, " ")
                    If VTpos > 0 Then
                        VTAux = Strings.Left(VTAux, VTpos - 1) & New String(" "c, VTpasada + 1) & Strings.Mid(VTAux, VTpos + VTpasada)
                        vti = VTpos + VTpasada + 1
                        VTVeces -= 1
                    Else
                        If VTpasada = 1 And VTVeces = (VTLon - (VTSitio - 1)) Then
                            VTSitio = VTLon
                            VTAux = Strings.Left(parCad, VTSitio)
                            VTVeces = 0
                        Else
                            vti = 1
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

    Public Sub PMImprimirReporte(ByRef parGrid As COBISCorp.Framework.UI.Components.COBISSpread, ByRef parNColumnas As Integer, ByRef parColumnas() As Integer, ByRef parSepColumnas() As Integer, ByRef parTitulo As Integer, ByRef parCaptionSubTitulos() As Integer, ByRef parValuesSubTitulos() As String, ByRef parAlineacion() As Integer, Optional ByRef parOrientacion As Integer = CG_PORTRAIT)
        Dim VTUnidad As Integer = COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.ScaleMode
        If parGrid.MaxRows = 0 Then
            FMMsgBox(15155, COBISMsgBox.COBISButtons.Exclamation, 15001, "", "")
            Exit Sub
        End If
        Dim VTReport As New PrinterDll.Report
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.ScaleMode = vbCentimeters
        VTReport.FMSetTitleAlign(CShort(CG_CENTER_ALIGN))
        VTReport.FMSetTitleFont("Courier")
        VTReport.FMSetTitleFontBold(True)
        VTReport.FMSetTitleCaption(COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(parTitulo)))
        VTReport.FMSetTitleInEachPage(True)
        VTReport.FMSetHeaderPageNumbers(True)
        VTReport.FMSetHeaderAlign(CShort(CG_LEFT_ALIGN))
        VTReport.FMSetHeaderFontBold(False)
        VTReport.FMSetHeaderInEachPage(True)
        VTReport.FMSetHeaderShowDate(True)
        VTReport.FMSetHeaderNSubTitles(CShort(parCaptionSubTitulos.GetUpperBound(0) + 1))
        For vti As Integer = 0 To parCaptionSubTitulos.GetUpperBound(0)
            VTReport.FMPutHeaderSubtitle(CShort(vti), COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(Conversion.Val(CStr(parCaptionSubTitulos(vti))))), parValuesSubTitulos(vti))
        Next vti
        VTReport.FMSetDetailSize(7)
        VTReport.FMSetReportNColumns(CShort(parNColumnas))
        VTReport.PMLoad_Parameters(parGrid)
        If parAlineacion.GetUpperBound(0) = 0 Then
            For vti As Integer = 0 To parNColumnas - 1
                VTReport.PMPutColumn(CShort(vti), Convert.ToInt16(Conversion.Val(CStr(parColumnas(vti)))), Convert.ToInt16(Conversion.Val(CStr(parSepColumnas(vti)))), CShort(CG_LEFT_ALIGN))
            Next vti
        Else
            For vti As Integer = 0 To parNColumnas - 1
                VTReport.PMPutColumn(CShort(vti), Convert.ToInt16(Conversion.Val(CStr(parColumnas(vti)))), Convert.ToInt16(Conversion.Val(CStr(parSepColumnas(vti)))), Convert.ToInt16(Conversion.Val(CStr(parAlineacion(vti)))))
            Next vti
        End If
        VTReport.PMPrintReport(CShort(parOrientacion))
        VTReport = Nothing
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.ScaleMode = VTUnidad
    End Sub

    Public Sub PMImprimirReporte1(ByRef parGrid As COBISCorp.Framework.UI.Components.COBISSpread, ByRef parNColumnas As Integer, ByRef parColumnas() As Integer, ByRef parSepColumnas() As Integer, ByRef parTitulo As Integer, ByRef parCaptionSubTitulos() As Integer, ByRef parValuesSubTitulos() As String, ByRef parAlineacion() As Integer, Optional ByRef parOrientacion As Integer = CG_PORTRAIT)
        Dim VTUnidad As Integer = COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.ScaleMode
        If parGrid.MaxRows = 0 Then
            FMMsgBox(15155, COBISMsgBox.COBISButtons.Exclamation, 15001, "", "")
            Exit Sub
        End If
        Dim VTReport As New PrinterDll.Report
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.ScaleMode = vbCentimeters
        VTReport.FMSetTitleAlign(CShort(CG_CENTER_ALIGN))
        VTReport.FMSetTitleFont("Courier")
        VTReport.FMSetTitleFontBold(True)
        VTReport.FMSetTitleCaption(COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(parTitulo)))
        VTReport.FMSetTitleInEachPage(True)
        VTReport.FMSetHeaderPageNumbers(True)
        VTReport.FMSetHeaderAlign(CShort(CG_LEFT_ALIGN))
        VTReport.FMSetHeaderFontBold(False)
        VTReport.FMSetHeaderInEachPage(True)
        VTReport.FMSetHeaderShowDate(True)
        VTReport.FMSetHeaderNSubTitles(CShort(parCaptionSubTitulos.GetUpperBound(0) + 1))
        For vti As Integer = 0 To parCaptionSubTitulos.GetUpperBound(0)
            VTReport.FMPutHeaderSubtitle(CShort(vti), COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str" + CStr(Conversion.Val(CStr(parCaptionSubTitulos(vti))))), parValuesSubTitulos(vti))
        Next vti
        VTReport.FMSetDetailSize(7)
        VTReport.FMSetReportNColumns(CShort(parNColumnas))
        VTReport.PMLoad_Parameters(parGrid)
        If parAlineacion.GetUpperBound(0) = 0 Then
            For vti As Integer = 0 To parNColumnas - 1
                VTReport.PMPutColumn(CShort(vti), Convert.ToInt16(Conversion.Val(CStr(parColumnas(vti)))), Convert.ToInt16(Conversion.Val(CStr(parSepColumnas(vti)))), CShort(CG_LEFT_ALIGN))
            Next vti
        Else
            For vti As Integer = 0 To parNColumnas - 1
                VTReport.PMPutColumn(CShort(vti), Convert.ToInt16(Conversion.Val(CStr(parColumnas(vti)))), Convert.ToInt16(Conversion.Val(CStr(parSepColumnas(vti)))), Convert.ToInt16(Conversion.Val(CStr(parAlineacion(vti)))))
            Next vti
        End If
        VTReport.PMPrintReport(CShort(parOrientacion))
        VTReport = Nothing
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.ScaleMode = VTUnidad
    End Sub
End Module


