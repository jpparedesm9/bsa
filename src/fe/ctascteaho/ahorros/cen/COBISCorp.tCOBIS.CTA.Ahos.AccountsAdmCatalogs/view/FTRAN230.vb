Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran230Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_3.Click, _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_0.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTR As Integer = 0
        Dim VTPromedio As Integer = 0
        Select Case Index
            Case 0
                If mskCuenta.ClipText <> "" Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "230")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                    If VGCodPais = "CO" Then
                        VTR = COBISMessageBox.Show(FMLoadResString(2257), FMLoadResString(500092), COBISMessageBox.COBISButtons.YesNo)
                        If VTR = System.Windows.Forms.DialogResult.Yes Then
                            PMPasoValores(sqlconn, "@i_escliente", 0, SQLCHAR, "S")
                        Else
                            PMPasoValores(sqlconn, "@i_escliente", 0, SQLCHAR, "N")
                        End If
                    End If
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_cons_ah", True, FMLoadResString(2274) & mskCuenta.Text & "]") Then
                        PMMapeaObjetoAB(sqlconn, lblDescripcion(1).Text, lblDescripcion(2).Text)
                        PMMapeaObjetoAB(sqlconn, lblDescripcion(3).Text, lblDescripcion(4).Text)
                        PMMapeaObjetoAB(sqlconn, lblDescripcion(5).Text, lblDescripcion(6).Text)
                        PMMapeaObjetoAB(sqlconn, lblDescripcion(7).Text, lblDescripcion(8).Text)
                        PMMapeaObjetoAB(sqlconn, lblDescripcion(9).Text, lblDescripcion(10).Text)
                        PMMapeaObjetoAB(sqlconn, lblDescripcion(11).Text, lblDescripcion(12).Text)
                        PMMapeaObjetoAB(sqlconn, lblDescripcion(42).Text, lblDescripcion(41).Text)
                        Dim VTArreglo(42) As String
                        FMMapeaArreglo(sqlconn, VTArreglo)
                        PMChequea(sqlconn)
                        For i As Integer = 1 To 18
                            lblDescripcion(i + 14).Text = VTArreglo(i)
                        Next i
                        VTPromedio = 0
                        For i As Integer = 25 To 30
                            VTPromedio += CDec(lblDescripcion(i).Text)
                        Next i
                        lblDescripcion(40).Text = StringsHelper.Format(VTPromedio / 6, "#,##0.00")
                        lblDescripcion(33).Text = VTArreglo(19)
                        lblDescripcion(34).Text = VTArreglo(20)
                        lblDescripcion(35).Text = VTArreglo(21)
                        lblDescripcion(36).Text = VTArreglo(22)
                        lblDescripcion(37).Text = VTArreglo(23)
                        lblDescripcion(39).Text = VTArreglo(24)
                        lblDescripcion(13).Text = VTArreglo(25)
                        lblDescripcion(14).Text = VTArreglo(26)
                        lblDescripcion(24).Text = VTArreglo(27)
                        lblDescripcion(44).Text = VTArreglo(23)
                        For i As Integer = 28 To 32
                            lblDescripcion(i + 17).Text = VTArreglo(i)
                        Next i
                        lblDescripcion(50).Text = VTArreglo(21)
                        For i As Integer = 33 To 37
                            lblDescripcion(i + 18).Text = VTArreglo(i)
                        Next i
                        If CDbl(lblDescripcion(14).Text) > 0 Then
                            lblDescripcion(43).Visible = True
                            lblDescripcion(43).Text = FMLoadResString(502412)
                        Else
                            lblDescripcion(43).Visible = False
                            lblDescripcion(43).Text = ""
                        End If
                        cmdBoton(3).Enabled = True
                        mskCuenta.Enabled = False
                    Else
                        PMChequea(sqlconn)
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(501337), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                End If
            Case 1
                For i As Integer = 1 To 54
                    lblDescripcion(i).Text = ""
                Next i
                lblDescripcion(39).Text = ""
                lblDescripcion(40).Text = ""
                lblDescripcion(43).Visible = False
                cmdBoton(3).Enabled = False
                cmdBoton(4).Enabled = False
                frmhistdeb.Visible = False
                frmhistcre.Visible = False
            Case 2
                Me.Close()
            Case 3
                PLImprimir()
            Case 4
                If mskCuenta.ClipText <> "" Then
                    ReDim VGADatosI(3)
                    VGADatosI(1) = mskCuenta.ClipText
                    VGADatosI(2) = "AHO"
                    VGADatosI(3) = "0"
                    FImagenes.ShowPopup(Me)
                    FImagenes.Dispose()
                Else
                    COBISMessageBox.Show(FMLoadResString(500792), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                End If
        End Select
    End Sub

    Private Sub FTran230_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub
    Private Sub PLInicializar()
        MyAppGlobals.AppActiveForm = ""
        mskCuenta.Mask = VGMascaraCtaCte
        If VGLineaPend = "N" Then
            lblDescripcion(39).Visible = False
            lblEtiqueta(36).Visible = False
            lblDescripcion(15).Visible = False
            lblEtiqueta(33).Visible = False
            lblEtiqueta(21).Visible = False
            lblDescripcion(23).Visible = False
        End If
    End Sub
    Private Sub FTran230_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub frmhistcre_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles frmhistcre.Click
        frmhistcre.Visible = False
    End Sub

    Private Sub frmhistdeb_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles frmhistdeb.Click
        frmhistdeb.Visible = False
    End Sub

    Private Sub lblEtiqueta_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _lblEtiqueta_47.Click, _lblEtiqueta_48.Click, _lblEtiqueta_49.Click, _lblEtiqueta_50.Click, _lblEtiqueta_51.Click, _lblEtiqueta_52.Click, _lblEtiqueta_46.Click, _lblEtiqueta_45.Click, _lblEtiqueta_44.Click, _lblEtiqueta_43.Click, _lblEtiqueta_42.Click, _lblEtiqueta_41.Click, _lblEtiqueta_40.Click, _lblEtiqueta_53.Click, _lblEtiqueta_39.Click, _lblEtiqueta_35.Click, _lblEtiqueta_38.Click, _lblEtiqueta_37.Click, _lblEtiqueta_30.Click, _lblEtiqueta_29.Click, _lblEtiqueta_26.Click, _lblEtiqueta_22.Click, _lblEtiqueta_20.Click, _lblEtiqueta_19.Click, _lblEtiqueta_36.Click, _lblEtiqueta_33.Click, _lblEtiqueta_25.Click, _lblEtiqueta_28.Click, _lblEtiqueta_27.Click, _lblEtiqueta_9.Click, _lblEtiqueta_7.Click, _lblEtiqueta_5.Click, _lblEtiqueta_24.Click, _lblEtiqueta_23.Click, _lblEtiqueta_21.Click, _lblEtiqueta_18.Click, _lblEtiqueta_17.Click, _lblEtiqueta_16.Click, _lblEtiqueta_15.Click, _lblEtiqueta_14.Click, _lblEtiqueta_13.Click, _lblEtiqueta_12.Click, _lblEtiqueta_11.Click, _lblEtiqueta_10.Click, _lblEtiqueta_8.Click, _lblEtiqueta_4.Click, _lblEtiqueta_3.Click, _lblEtiqueta_2.Click, _lblEtiqueta_1.Click, _lblEtiqueta_31.Click, _lblEtiqueta_32.Click, _lblEtiqueta_34.Click, _lblEtiqueta_0.Click, _lblEtiqueta_6.Click
        Dim Index As Integer = Array.IndexOf(lblEtiqueta, eventSender)
        Select Case Index
            Case 22
                If frmhistdeb.Visible Then
                    frmhistdeb.Visible = False
                End If
                frmhistcre.Visible = True
            Case 38
                If frmhistcre.Visible Then
                    frmhistcre.Visible = False
                End If
                frmhistdeb.Visible = True
        End Select
    End Sub

    Private Sub lblEtiqueta_MouseMove(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _lblEtiqueta_47.MouseMove, _lblEtiqueta_48.MouseMove, _lblEtiqueta_49.MouseMove, _lblEtiqueta_50.MouseMove, _lblEtiqueta_51.MouseMove, _lblEtiqueta_52.MouseMove, _lblEtiqueta_46.MouseMove, _lblEtiqueta_45.MouseMove, _lblEtiqueta_44.MouseMove, _lblEtiqueta_43.MouseMove, _lblEtiqueta_42.MouseMove, _lblEtiqueta_41.MouseMove, _lblEtiqueta_40.MouseMove, _lblEtiqueta_53.MouseMove, _lblEtiqueta_39.MouseMove, _lblEtiqueta_35.MouseMove, _lblEtiqueta_38.MouseMove, _lblEtiqueta_37.MouseMove, _lblEtiqueta_30.MouseMove, _lblEtiqueta_29.MouseMove, _lblEtiqueta_26.MouseMove, _lblEtiqueta_22.MouseMove, _lblEtiqueta_20.MouseMove, _lblEtiqueta_19.MouseMove, _lblEtiqueta_36.MouseMove, _lblEtiqueta_33.MouseMove, _lblEtiqueta_25.MouseMove, _lblEtiqueta_28.MouseMove, _lblEtiqueta_27.MouseMove, _lblEtiqueta_9.MouseMove, _lblEtiqueta_7.MouseMove, _lblEtiqueta_5.MouseMove, _lblEtiqueta_24.MouseMove, _lblEtiqueta_23.MouseMove, _lblEtiqueta_21.MouseMove, _lblEtiqueta_18.MouseMove, _lblEtiqueta_17.MouseMove, _lblEtiqueta_16.MouseMove, _lblEtiqueta_15.MouseMove, _lblEtiqueta_14.MouseMove, _lblEtiqueta_13.MouseMove, _lblEtiqueta_12.MouseMove, _lblEtiqueta_11.MouseMove, _lblEtiqueta_10.MouseMove, _lblEtiqueta_8.MouseMove, _lblEtiqueta_4.MouseMove, _lblEtiqueta_3.MouseMove, _lblEtiqueta_2.MouseMove, _lblEtiqueta_1.MouseMove, _lblEtiqueta_31.MouseMove, _lblEtiqueta_32.MouseMove, _lblEtiqueta_34.MouseMove, _lblEtiqueta_0.MouseMove, _lblEtiqueta_6.MouseMove
        Dim Index As Integer = Array.IndexOf(lblEtiqueta, eventSender)
        Select Case Index
            Case 38
                ToolTip1.SetToolTip(lblEtiqueta(38), FMLoadResString(500794))
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500794))
            Case 22
                ToolTip1.SetToolTip(lblEtiqueta(22), FMLoadResString(509259))
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500795))
        End Select
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500659))
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
    End Sub

    Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Try
            If mskCuenta.ClipText <> "" Then
                If FMChequeaCtaAho(mskCuenta.ClipText) Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_cerrada", 0, SQLCHAR, "C")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(502522) & "[" & mskCuenta.Text & "]") Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(0).Text)
                        PMChequea(sqlconn)
                        cmdBoton(4).Enabled = True
                    Else
                        PMChequea(sqlconn)
                        cmdBoton_Click(cmdBoton(1), New EventArgs())
                        Exit Sub
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(508917), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    cmdBoton_Click(cmdBoton(1), New EventArgs())
                    Exit Sub
                End If
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
        End Try
    End Sub

    Private Sub PLImprimir()
        Dim VLDiferido As Decimal = 0
        Dim VLProdbanc As String = ""
        If COBISMessageBox.Show(FMLoadResString(500796), FMLoadResString(500092), COBISMessageBox.COBISButtons.OK Or COBISMessageBox.COBISButtons.OKCancel, COBISMessageBox.COBISIcon.Question) = System.Windows.Forms.DialogResult.OK Then
            Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            FMCabeceraReporte(VGBanco, DateTimeHelper.ToString(DateTime.Today), FMLoadResString(509260), DateTimeHelper.ToString(DateTimeHelper.Time), Me.Text, VGFecha, CStr(1))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 8
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509261), mskCuenta.Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509262), lblDescripcion(0).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            VLProdbanc = lblDescripcion(42).Text & " - " & lblDescripcion(41).Text
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509263), VLProdbanc)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            If VGLineaPend = "S" Then
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509264), lblDescripcion(15).Text)
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            End If
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509265), lblDescripcion(20).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509266), lblDescripcion(21).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509267), lblDescripcion(22).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            If VGLineaPend = "S" Then
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509268), lblDescripcion(23).Text)
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            End If
            VLDiferido = CDec(lblDescripcion(19).Text) + CDec(lblDescripcion(18).Text) + CDec(lblDescripcion(16).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509269), StringsHelper.Format(VLDiferido, "#,##0.00"))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509270), StringsHelper.Format(lblDescripcion(31).Text, "#,##0.00"))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(New String("_", 124))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), VGLogin)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509271))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509272))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.EndDoc()
            Me.Cursor = System.Windows.Forms.Cursors.Default
        End If
    End Sub

    Private Sub PLTSEstado()
        TSBFirmas.Enabled = _cmdBoton_4.Enabled
        TSBFirmas.Visible = _cmdBoton_4.Visible
        TSBImprimir.Enabled = _cmdBoton_3.Enabled
        TSBImprimir.Visible = _cmdBoton_3.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
    End Sub

    Private Sub TSBFirmas_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBFirmas.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
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

    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        If Not (Artinsoft.VB6.Gui.ActivateHelper.myActiveForm Is eventSender) Then
            Artinsoft.VB6.Gui.ActivateHelper.myActiveForm = eventSender
        End If
    End Sub

    Private Sub mskCuenta_MaskInputRejected(sender As Object, e As MaskInputRejectedEventArgs) Handles mskCuenta.MaskInputRejected

    End Sub
End Class


