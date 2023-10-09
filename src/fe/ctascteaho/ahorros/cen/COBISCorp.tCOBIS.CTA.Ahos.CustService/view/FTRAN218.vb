Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran218Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Private Sub FTran218_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        Me.Left = 0
        Me.Top = 0
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub PLInicializar()
        MyAppGlobals.AppActiveForm = ""
        mskCuenta.Mask = VGMascaraCtaAho
        'picVisto(0).Image = My.Resources.bmp31001
        picVisto(0).Image = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetImage(VGResourceManager, "bmp31001") 'JSA
        picVisto(1).Image = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetImage(VGResourceManager, "bmp31002") 'JSA
    End Sub

    Private Sub FTran218_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_2.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                If mskCuenta.ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(501337), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                    Exit Sub
                End If
                For i As Integer = 1 To grdListaValores.Rows - 1
                    grdListaValores.Row = i
                    grdListaValores.Col = 0
                    If grdListaValores.Picture.Equals(picVisto(0).Image) Then
                        FCausaLev.lblProducto.Text = "AHO"
                        FCausaLev.ShowPopup(Me)
                        If VGNControl <> "*" Then
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "218")
                            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                            PMPasoValores(sqlconn, "@i_accion", 0, SQLCHAR, "L")
                            grdListaValores.Col = 4
                            PMPasoValores(sqlconn, "@i_valor", 0, SQLMONEY, grdListaValores.CtlText)
                            PMPasoValores(sqlconn, "@i_causa", 0, SQLCHAR, VGNControl)
                            PMPasoValores(sqlconn, "@i_aut", 0, SQLVARCHAR, VGLogin)
                            grdListaValores.Col = 12
                            PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, grdListaValores.CtlText)
                            PMPasoValores(sqlconn, "@i_solicit", 0, SQLVARCHAR, VGNSolicit)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_bloq_val_ah", True, FMLoadResString(2542)) Then
                                PMChequea(sqlconn)
                                COBISMessageBox.Show(FMLoadResString(502036), FMLoadResString(501547), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                                PLImprimir(i)
                            Else
                                PMChequea(sqlconn) 'JSA
                            End If
                        End If
                        FCausaLev.Dispose()
                    End If
                Next i
                PLBuscar()
            Case 1
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                PMLimpiaGrid(grdPropietarios)
                PMLimpiaGrid(grdListaValores)
                lblDescripcion(0).Text = ""
                cmdBoton(3).Enabled = False
                mskCuenta.Focus()
            Case 2
                Me.Close()
            Case 3
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "298")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_clientes_ah", True, FMLoadResString(2543)) Then
                    PMMapeaGrid(sqlconn, grdPropietarios, False)
                    PMMapeaTextoGrid(grdPropietarios) 'JSA
                    PMAnchoColumnasGrid(grdPropietarios) 'JSA
                    PMChequea(sqlconn)
                Else
                    PMLimpiaGrid(grdPropietarios)
                    PMChequea(sqlconn) 'JSA
                End If
        End Select
        PLTSEstado()
    End Sub

    Private Sub grdListaValores_ClickEvent(sender As Object, e As EventArgs) Handles grdListaValores.ClickEvent
        PMMarcaFilaCobisGrid(grdListaValores, grdListaValores.Row)
    End Sub

    Private Sub grdListaValores_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdListaValores.DblClick
        PMMarcaFilaCobisGrid(grdListaValores, grdListaValores.Row)
        If grdListaValores.Rows <= 2 Then
            grdListaValores.Row = 1
            grdListaValores.Col = 1
            If grdListaValores.CtlText.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(502037), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        End If
        PMMarcarRegistro()
    End Sub

    Private Sub grdListaValores_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdListaValores.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501811))
    End Sub

    Private Sub grdPropietarios_ClickEvent(sender As Object, e As EventArgs) Handles grdPropietarios.ClickEvent
        PMMarcaFilaCobisGrid(grdPropietarios, grdPropietarios.Row)
    End Sub

    Private Sub grdPropietarios_DblClick(sender As Object, e As EventArgs) Handles grdPropietarios.DblClick
        PMMarcaFilaCobisGrid(grdPropietarios, grdPropietarios.Row)
    End Sub

    Private Sub grdPropietarios_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdPropietarios.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2223))
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500659))
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
    End Sub

    Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        Try
            If mskCuenta.ClipText <> "" Then
                If FMChequeaCtaAho(mskCuenta.ClipText) Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_val_inac", 0, SQLVARCHAR, "N")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2544) & " " & "[" & mskCuenta.Text & "]") Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(0))
                        PMChequea(sqlconn)
                        cmdBoton(3).Enabled = True
                        PMLimpiaGrid(grdPropietarios)
                        PLBuscar()
                    Else
                        cmdBoton_Click(cmdBoton(1), New EventArgs())
                        PMChequea(sqlconn) 'JSA
                        Exit Sub
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    cmdBoton_Click(cmdBoton(1), New EventArgs())
                    Exit Sub
                End If
            End If
        Catch exc As System.Exception
            'NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
            COBISMessageBox.Show(exc.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'JSA
        End Try
        PLTSEstado()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub PLBuscar()
        Dim VTFechaHa As String = ""
        Dim VTModo As String = "0"
        Dim VTRows As Integer = VGMaxRows
        Dim VTSec As String = "0"
        Dim VTBorrar As Boolean = False
        While VTRows = VGMaxRows
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "216")
            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, VTModo)
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "B")
            PMPasoValores(sqlconn, "@i_fdesde", 0, SQLDATETIME, "01/01/1960")
            If VGFormatoFecha <> CGFormatoBase Then 'JSA
                VTFechaHa = FMConvFecha(VGFecha, VGFormatoFecha, CGFormatoBase)
            Else
                VTFechaHa = VGFecha
            End If
            PMPasoValores(sqlconn, "@i_fhasta", 0, SQLDATETIME, VTFechaHa)
            PMPasoValores(sqlconn, "@i_ope", 0, SQLVARCHAR, "NO")
            PMPasoValores(sqlconn, "@i_sec", 0, SQLINT2, VTSec)
            PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_cons_bloq_ah", True, FMLoadResString(2545)) Then
                PMMapeaGrid(sqlconn, grdListaValores, VTBorrar)
                PMMapeaTextoGrid(grdListaValores)
                PMChequea(sqlconn)
                If VTModo = "0" Then
                    grdListaValores.ColWidth(0) = 750 'JSA
                    grdListaValores.ColAlignment(1) = 2
                    grdListaValores.ColAlignment(3) = 1
                    grdListaValores.ColAlignment(4) = 1
                    grdListaValores.ColAlignment(5) = 1
                End If
                VTModo = "1"
                VTRows = Conversion.Val(Convert.ToString(grdListaValores.Tag))
                VTBorrar = True
                grdListaValores.Col = 12
                grdListaValores.Row = grdListaValores.Rows - 1
                VTSec = grdListaValores.CtlText
            Else
                PMLimpiaGrid(grdListaValores)
                PMChequea(sqlconn) 'JSA
                VTRows = 0
            End If
        End While
        PMAnchoColumnasGrid(grdListaValores)
        grdListaValores.Col = 0
        For i As Integer = 1 To grdListaValores.Rows - 1
            grdListaValores.Row = i
            grdListaValores.Picture = picVisto(1).Image
        Next i
    End Sub

    'Private Sub PMMarcarRegistro()
    '    grdListaValores.Col = 0
    '    If Not grdListaValores.Picture Is Nothing Then
    '        grdListaValores.Picture = picVisto(0).Image
    '    Else
    '        grdListaValores.Picture = picVisto(1).Image
    '    End If
    'End Sub

    Private Sub PMMarcarRegistro()
        grdListaValores.Col = 0
        If Not grdListaValores.Picture.Equals(picVisto(0).Image) Then
            grdListaValores.Picture = picVisto(0).Image
        Else
            grdListaValores.Picture = picVisto(1).Image
        End If
    End Sub

    Private Sub PLImprimir(Optional ByRef VTFila As Integer = 0)
        grdListaValores.Col = 0
        Dim VLFormatoFechaRep As String = ""
        VLFormatoFechaRep = "dd/MM/yyyy"
        If COBISMessageBox.Show(FMLoadResString(501814) & " " & grdListaValores.CtlText, FMLoadResString(500092), COBISMessageBox.COBISButtons.YesNo) = System.Windows.Forms.DialogResult.Yes Then
            For i As Integer = 1 To grdListaValores.Rows - 1
                If i = VTFila Or VTFila = 0 Then
                    grdListaValores.Row = i
                    grdListaValores.Col = 0
                    If grdListaValores.Picture.Equals(picVisto(0).Image) Then
                        Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
                        FMCabeceraReporte(VGBanco, CDate(VGFecha).ToString(VLFormatoFechaRep), FMLoadResString(509327), DateTimeHelper.ToString(DateTimeHelper.Time), Me.Text, VGFecha, CStr(1))
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 8
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontName = "Courier New"
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 10
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(5), FMLoadResString(509328), FileSystem.TAB(33), mskCuenta.Text)
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(5), FMLoadResString(509329), FileSystem.TAB(33), lblDescripcion(0).Text)
                        grdListaValores.Col = 1
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(5), FMLoadResString(509330), FileSystem.TAB(33), StringsHelper.Format(grdListaValores.CtlText, VGFormatoFecha))
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        grdListaValores.Col = 2
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(5), FMLoadResString(509331), FileSystem.TAB(33), grdListaValores.CtlText)
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        grdListaValores.Col = 11
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(5), FMLoadResString(509332), FileSystem.TAB(33), grdListaValores.CtlText)
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        grdListaValores.Col = 8
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(5), FMLoadResString(509333), FileSystem.TAB(33), grdListaValores.CtlText)
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(5), FMLoadResString(509334), FileSystem.TAB(33), StringsHelper.Format(VGFecha, VGFormatoFecha))
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(5), FMLoadResString(509335), FileSystem.TAB(33), FormatDateTime(Now.TimeOfDay.ToString))
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        grdListaValores.Col = 4
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(5), FMLoadResString(509336), FileSystem.TAB(33), grdListaValores.CtlText)
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        grdListaValores.Col = 7
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(5), FMLoadResString(509337), FileSystem.TAB(33), StringsHelper.Format(grdListaValores.CtlText, VGFormatoFecha))
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(5), FMLoadResString(509338), FileSystem.TAB(33), VGOficina)
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(5), FMLoadResString(509339), FileSystem.TAB(33), VGLogin)
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        grdListaValores.Col = 9
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(5), FMLoadResString(509340), FileSystem.TAB(33), VGNSolicit)
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        grdListaValores.Col = 10
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(5), FMLoadResString(509341), FileSystem.TAB(33), VGNCausa)
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(3), New String("_", 120))
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), VGLogin)
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509342))
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509343))
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                        If VGCodPais <> "CO" Then
                            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(5088743))
                        End If
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.EndDoc()
                        Me.Cursor = System.Windows.Forms.Cursors.Default
                    End If

                End If
            Next i
        End If
    End Sub

    Private Sub PLTSEstado()
        TSBPropietario.Enabled = _cmdBoton_3.Enabled
        TSBPropietario.Visible = _cmdBoton_3.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
    End Sub

    Private Sub TSBPropietario_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBPropietario.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub grdPropietarios_Leave(sender As Object, e As EventArgs) Handles grdPropietarios.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub grdListaValores_Leave(sender As Object, e As EventArgs) Handles grdListaValores.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
End Class


