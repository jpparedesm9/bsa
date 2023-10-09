Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran245Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


    Private Sub FTran245_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub
    Private Sub PLInicializar()

        Dim eventSender As Object = Nothing
        Dim eventArgs As EventArgs = Nothing
        mskCuenta_Leave(eventSender, eventArgs)
        mskCuenta.Mask = VGMascaraCtaAho
        For i As Integer = 0 To 1
            mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
            mskValor(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        Next i
        Me.Text = FMLoadResString(3113)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508573))
    End Sub

    Private Sub FTran245_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_2.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTFDesde As String = String.Empty
        Dim VTFHasta As String = String.Empty
        Dim VTValido As Integer = 0
        Select Case Index
            Case 0
                VTValido = FMVerFormato(mskValor(0).Text, VGFormatoFecha)
                If Not VTValido Then
                    COBISMessageBox.Show(FMLoadResString(500063), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                    mskValor(0).Focus()
                    Exit Sub
                End If
                VTValido = FMVerFormato(mskValor(1).Text, VGFormatoFecha)
                If Not VTValido Then
                    COBISMessageBox.Show(FMLoadResString(500063), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                    mskValor(1).Focus()
                    Exit Sub
                End If
                VTFDesde = FMConvFecha(mskValor(0).Text, VGFormatoFecha, CGFormatoBase)
                VTFHasta = FMConvFecha(mskValor(1).Text, VGFormatoFecha, CGFormatoBase)
                If VTFDesde > VTFHasta Then
                    COBISMessageBox.Show(FMLoadResString(500356), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                    mskValor(0).Focus()
                    Exit Sub
                End If
                If FMDateDiff("d", mskValor(1).Text, VGFechaProceso, VGFormatoFecha) <= 0 Then
                    mskValor(1).Text = VGFechaProceso
                End If
                If mskCuenta.ClipText = "" Then
                    COBISMessageBox.Show(FMLoadResString(501854), FMLoadResString(9914), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "245")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                'VTFDesde = FMConvFecha(mskValor(0).Text, VGFormatoFecha, CGFormatoBase)
                PMPasoValores(sqlconn, "@i_fdesde", 0, SQLDATETIME, VTFDesde)
                ' VTFHasta = FMConvFecha(mskValor(1).Text, VGFormatoFecha, CGFormatoBase)
                PMPasoValores(sqlconn, "@i_fhasta", 0, SQLDATETIME, VTFHasta)
                If optVigentes(0).Checked Then
                    PMPasoValores(sqlconn, "@i_est", 0, SQLCHAR, "C")
                ElseIf optVigentes(1).Checked Then
                    PMPasoValores(sqlconn, "@i_est", 0, SQLCHAR, "L")
                ElseIf optVigentes(2).Checked Then
                    PMPasoValores(sqlconn, "@i_est", 0, SQLCHAR, "V")
                End If
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_consulta_mov_ah", True, FMLoadResString(509089)) Then
                    PMMapeaGrid(sqlconn, grdValores, False)
                    PMChequea(sqlconn)
                    grdValores.ColAlignment(3) = 2
                    mskValor(0).Enabled = False
                    mskValor(1).Enabled = False
                    cmdBoton(4).Enabled = CDbl(Convert.ToString(grdValores.Tag)) = VGMaxRows
                Else
                    PMChequea(sqlconn)
                End If
            Case 1
                PMLimpiaGrid(grdValores)
                mskValor(0).Enabled = True
                mskValor(1).Enabled = True
                For i As Integer = 0 To 1
                    mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
                    mskValor(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
                Next i
                optVigentes(2).Checked = True
            Case 2
                Me.Close()
            Case 4
                If mskCuenta.ClipText = "" Then
                    COBISMessageBox.Show(FMLoadResString(501337), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "245")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "1")
                VTFDesde = FMConvFecha(mskValor(0).Text, VGFormatoFecha, CGFormatoBase)
                PMPasoValores(sqlconn, "@i_fdesde", 0, SQLDATETIME, VTFDesde)
                VTFHasta = FMConvFecha(mskValor(1).Text, VGFormatoFecha, CGFormatoBase)
                PMPasoValores(sqlconn, "@i_fhasta", 0, SQLDATETIME, VTFHasta)
                If optVigentes(0).Checked Then
                    PMPasoValores(sqlconn, "@i_est", 0, SQLCHAR, "C")
                ElseIf optVigentes(1).Checked Then
                    PMPasoValores(sqlconn, "@i_est", 0, SQLCHAR, "L")
                ElseIf optVigentes(2).Checked Then
                    PMPasoValores(sqlconn, "@i_est", 0, SQLCHAR, "V")
                End If
                grdValores.Col = 6
                grdValores.Row = grdValores.Rows - 1
                PMPasoValores(sqlconn, "@i_sec", 0, SQLINT2, grdValores.CtlText)
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_consulta_mov_ah", True, FMLoadResString(509089)) Then
                    PMMapeaGrid(sqlconn, grdValores, True)
                    PMChequea(sqlconn)
                    cmdBoton(4).Enabled = CDbl(Convert.ToString(grdValores.Tag)) = VGMaxRows
                Else
                    PMChequea(sqlconn)
                End If
        End Select
    End Sub

    Private Sub grdValores_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdValores.Click
        grdValores.Col = 0
        grdValores.SelStartCol = 1
        grdValores.SelEndCol = grdValores.Cols - 1
        If grdValores.Row = 0 Then
            grdValores.SelStartRow = 1
            grdValores.SelEndRow = 1
        Else
            grdValores.SelStartRow = grdValores.Row
            grdValores.SelEndRow = grdValores.Row
        End If
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
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2330) & mskCuenta.Text & "]") Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(0))
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        cmdBoton_Click(cmdBoton(1), New EventArgs())
                        Exit Sub
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    cmdBoton_Click(cmdBoton(1), New EventArgs())
                    Exit Sub
                End If
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
        End Try
    End Sub

    Private Sub mskValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskValor_1.Enter, _mskValor_0.Enter
        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
        Select Case Index
            Case 0

                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508573))

            Case 1

                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508570))

        End Select
        mskValor(Index).SelectionStart = 0
        mskValor(Index).SelectionLength = Strings.Len(mskValor(Index).Text)
    End Sub

    Private Sub mskValor_KeyPressEvent(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _mskValor_1.KeyPress, _mskValor_0.KeyPress
        If (Asc(eventArgs.KeyChar) <> 8) And ((Asc(eventArgs.KeyChar) < 48) Or (Asc(eventArgs.KeyChar) > 57)) Then
            eventArgs.KeyChar = Chr(0)
        End If
    End Sub

    Private Sub _mskValor_1_Layout(sender As Object, e As LayoutEventArgs) Handles _mskValor_1.Layout

    End Sub

    Private Sub mskValor_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskValor_1.Leave, _mskValor_0.Leave

        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
        Dim VTValido As Integer = 0
        Dim VTDias As Integer = 0
        Dim VTFecha1 As String
        Dim VTFecha2 As String
        VTFecha1 = mskValor(0).Text
        VTFecha2 = mskValor(1).Text

        Try
            Select Case Index
                Case 0, 1
                    If mskValor(Index).ClipText <> "" Then
                        VTValido = FMVerFormato(mskValor(Index).Text, VGFormatoFecha)
                        If Not VTValido Then
                            COBISMessageBox.Show(FMLoadResString(500360), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                            'mskValor(0).Text = VGFechaProceso
                            mskValor(Index).Focus()
                            Exit Sub
                        End If
                    Else
                        For i As Integer = 0 To 1
                            mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
                            mskValor(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
                        Next i
                    End If
                    'Verficar que fecha de consulta sea menor que la fecha del sistema
                    If FMDateDiff("d", VTFecha1, VGFechaProceso, VGFormatoFecha) <= 0 Then
                        mskValor(0).Text = VGFechaProceso
                    End If
                    If FMDateDiff("d", VTFecha2, VGFechaProceso, VGFormatoFecha) <= 0 Then
                        mskValor(1).Text = VGFechaProceso
                    End If


                    If mskValor(0).ClipText <> "" And mskValor(1).ClipText <> "" Then
                        VTDias = FMDateDiff("d", mskValor(0).Text, mskValor(1).Text, VGFormatoFecha)
                        If VTDias < 0 Then
                            COBISMessageBox.Show(FMLoadResString(500356), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                            For i As Integer = 0 To 1
                                mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
                                mskValor(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
                            Next i
                            mskValor(0).Focus()
                            Exit Sub
                        End If
                    End If
            End Select
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
        End Try
    End Sub

    Private Sub PLTSEstado()
        TSBSiguientes.Enabled = _cmdBoton_4.Enabled
        TSBSiguientes.Visible = _cmdBoton_4.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
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

    End Sub

    Private Sub optVigentes_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optVigentes_2.Enter, _optVigentes_1.Enter

        Dim Index As Integer = Array.IndexOf(optVigentes, eventSender)
        Select Case Index
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501750))
            Case 1

                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5143))

        End Select
    End Sub





    Private Sub _optVigentes_2_Leave(sender As Object, e As EventArgs) Handles _optVigentes_2.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub





    Private Sub _optVigentes_1_Leave(sender As Object, e As EventArgs) Handles _optVigentes_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub grdValores_ClickEvent(sender As Object, e As EventArgs) Handles grdValores.ClickEvent
        PMMarcaFilaCobisGrid(grdValores, grdValores.Row)
    End Sub

    Private Sub grdValores_DblClick(sender As Object, e As EventArgs) Handles grdValores.DblClick
        PMMarcaFilaCobisGrid(grdValores, grdValores.Row)
    End Sub



    Private Sub grdValores_Enter(sender As Object, e As EventArgs) Handles grdValores.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501752))
    End Sub

    Private Sub grdValores_Leave(sender As Object, e As EventArgs) Handles grdValores.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub frmCriterio_Click(sender As Object, e As EventArgs) Handles frmCriterio.Click

    End Sub

    Private Sub frmCriterio_Enter(sender As Object, e As EventArgs) Handles frmCriterio.Enter

    End Sub

    Private Sub _optVigentes_2_CheckedChanged(sender As Object, e As EventArgs) Handles _optVigentes_2.CheckedChanged

    End Sub

    Private Sub _lblDescripcion_0_Click(sender As Object, e As EventArgs) Handles _lblDescripcion_0.Click

    End Sub

    Private Sub _mskValor_0_LostFocus(sender As Object, e As EventArgs) Handles _mskValor_0.LostFocus

    End Sub

    Private Sub _mskValor_0_MaskInputRejected(sender As Object, e As MaskInputRejectedEventArgs) Handles _mskValor_0.MaskInputRejected

    End Sub

    Private Sub _mskValor_1_MaskInputRejected(sender As Object, e As MaskInputRejectedEventArgs) Handles _mskValor_1.MaskInputRejected

    End Sub
End Class


