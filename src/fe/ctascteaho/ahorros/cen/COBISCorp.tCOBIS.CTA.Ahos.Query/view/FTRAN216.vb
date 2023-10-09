Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran216Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Private Sub FTran216_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Public Sub PLInicializar()
        Dim eventSender As Object = Nothing
        Dim eventArgs As EventArgs = Nothing
        _mskValor_0.DateType = PLFormatoFecha()
        _mskValor_1.DateType = PLFormatoFecha()
        mskCuenta_Leave(eventSender, eventArgs)
        mskCuenta.Mask = VGMascaraCtaAho
        For i As Integer = 0 To 1
            mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
            mskValor(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        Next i
        Me.Text = FMLoadResString(20006)
    End Sub

    Private Sub FTran216_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
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
                If FMDateDiff("d", _mskValor_1.Text, VGFechaProceso, VGFormatoFecha) <= 0 Then
                    _mskValor_1.Text = VGFechaProceso
                End If
                If mskCuenta.ClipText <> "" Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "216")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                    'VTFDesde = FMConvFecha(mskValor(0).Text, VGFormatoFecha, CGFormatoBase)
                    PMPasoValores(sqlconn, "@i_fdesde", 0, SQLDATETIME, VTFDesde)
                    'VTFHasta = FMConvFecha(mskValor(1).Text, VGFormatoFecha, CGFormatoBase)
                    PMPasoValores(sqlconn, "@i_fhasta", 0, SQLDATETIME, VTFHasta)
                    If optVigentes(0).Checked Then
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "B")
                    Else
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "L")
                    End If
                    PMPasoValores(sqlconn, "@i_flag", 0, SQLCHAR, "1")
                    PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_cons_bloq_ah", True, FMLoadResString(9914)) Then

                        PMMapeaGrid(sqlconn, grdValores, False)
                        grdValores.ColAlignment(1) = 2
                        grdValores.ColAlignment(3) = 1
                        grdValores.ColAlignment(4) = 1
                        grdValores.ColAlignment(5) = 1
                        PMChequea(sqlconn)
                        mskValor(0).Enabled = False
                        mskValor(1).Enabled = False
                        cmdBoton(4).Enabled = (grdValores.Rows - 1) >= 20
                    Else
                        PMChequea(sqlconn)
                    End If
                Else

                    COBISMessageBox.Show(FMLoadResString(501337), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                End If
            Case 1

                PMLimpiaGrid(grdValores)
                mskValor(0).Enabled = True
                mskValor(1).Enabled = True
                For i As Integer = 0 To 1
                    mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
                    mskValor(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
                Next i
                optVigentes(0).Checked = True
            Case 2
                Me.Close()
            Case 4
                If mskCuenta.ClipText <> "" Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "216")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "1")
                    VTFDesde = FMConvFecha(mskValor(0).Text, VGFormatoFecha, CGFormatoBase)
                    PMPasoValores(sqlconn, "@i_fdesde", 0, SQLDATETIME, VTFDesde)
                    VTFHasta = FMConvFecha(mskValor(1).Text, VGFormatoFecha, CGFormatoBase)
                    PMPasoValores(sqlconn, "@i_fhasta", 0, SQLDATETIME, VTFHasta)
                    If optVigentes(0).Checked Then
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "B")
                    Else
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "L")
                    End If
                    grdValores.Col = 12
                    grdValores.Row = grdValores.Rows - 1
                    PMPasoValores(sqlconn, "@i_sec", 0, SQLINT2, grdValores.CtlText)
                    PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_cons_bloq_ah", True, FMLoadResString(9914)) Then
                        PMMapeaGrid(sqlconn, grdValores, True)
                        PMChequea(sqlconn)
                        cmdBoton(4).Enabled = (grdValores.Rows - 1) >= 20
                    Else
                        PMChequea(sqlconn)
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(501337), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                End If
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
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(502622) & mskCuenta.Text & "]") Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(0))
                        PMChequea(sqlconn)
                        PMLimpiaGrid(grdValores)
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

    Private Sub mskValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskValor_0.Enter, _mskValor_1.Enter
        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(20004) & "[" & VGFormatoFecha & "]")
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(20005) & "[" & VGFormatoFecha & "]")
        End Select
        mskValor(Index).SelectionStart = 0
        mskValor(Index).SelectionLength = Strings.Len(mskValor(Index).Text)
    End Sub

    Private Sub mskValor_KeyPressEvent(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _mskValor_0.KeyPress, _mskValor_1.KeyPress
        If (Asc(eventArgs.KeyChar) <> 8) And ((Asc(eventArgs.KeyChar) < 48) Or (Asc(eventArgs.KeyChar) > 57)) Then
            eventArgs.KeyChar = Chr(0)
        End If
    End Sub

    Private Sub mskValor_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskValor_0.Leave, _mskValor_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
        Dim VTValido As Integer = 0
        Dim VTDias As Integer = 0
        Dim VTFecha1 As String
        Dim VTFecha2 As String
        Select Case Index
            Case 0, 1
                If mskValor(Index).ClipText <> "" Then
                    VTValido = FMVerFormato(mskValor(Index).Text, VGFormatoFecha)
                    If Not VTValido Then
                        COBISMessageBox.Show(FMLoadResString(500063), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                        mskValor(Index).Focus()
                        Exit Sub
                    End If
                Else
                    For i As Integer = 0 To 1
                        mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
                    Next i
                End If
                If mskValor(0).ClipText <> "" And mskValor(1).ClipText <> "" Then
                    VTDias = FMDateDiff("d", mskValor(0).Text, mskValor(1).Text, VGFormatoFecha)
                    If VTDias < 0 Then
                        COBISMessageBox.Show(FMLoadResString(500356), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                        mskValor(0).Focus()
                        Exit Sub
                    End If
                End If
                VTFecha1 = _mskValor_0.Text
                VTFecha2 = _mskValor_1.Text
                If FMDateDiff("d", VTFecha1, VGFechaProceso, VGFormatoFecha) <= 0 Then
                    _mskValor_0.Text = VGFechaProceso
                End If
                If FMDateDiff("d", VTFecha2, VGFechaProceso, VGFormatoFecha) <= 0 Then
                    _mskValor_1.Text = VGFechaProceso
                End If
        End Select
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

    Private Sub optVigentes_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optVigentes_0.Enter, _optVigentes_1.Enter
        Dim Index As Integer = Array.IndexOf(optVigentes, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502022))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(20003))
        End Select
    End Sub

    Private Sub _optVigentes_0_Leave(sender As Object, e As EventArgs) Handles _optVigentes_0.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub _optVigentes_1_Leave(sender As Object, e As EventArgs) Handles _optVigentes_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub grdValores_ClickEvent(sender As Object, e As EventArgs) Handles grdValores.ClickEvent
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

    Private Sub grdValores_DblClick(sender As Object, e As EventArgs) Handles grdValores.DblClick
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

    Private Sub grdValores_Enter(sender As Object, e As EventArgs) Handles grdValores.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501811))
    End Sub

    Private Sub grdValores_Leave(sender As Object, e As EventArgs) Handles grdValores.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub


End Class


