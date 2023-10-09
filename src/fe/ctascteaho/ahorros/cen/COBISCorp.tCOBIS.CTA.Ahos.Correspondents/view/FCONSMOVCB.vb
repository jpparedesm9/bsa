Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FConsMovCBClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLTranDiario As Integer = 0
    Dim VLSecuencial As String = ""

    Private Sub cmdLimpiar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdLimpiar.Click
        lblNombre.Text = ""
        lblDisponible.Text = ""
        lblEstado.Text = ""
        lblFechaUltMov.Text = ""
        lblMoneda.Text = ""
        lblOficial.Text = ""
        cmdSiguientes.Enabled = False
        For i As Integer = 0 To 1
            mskFecha(i).Mask = FMMascaraFecha(VGFormatoFecha)
            mskFecha(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        Next i
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
        mskCuenta.Enabled = True
        mskCuenta.Focus()
        PMLimpiaGrid(grdMovimientos)
        mskFecha(0).Enabled = True
        mskFecha(1).Enabled = True
        PLTSEstado()
    End Sub

    Private Sub cmdLimpiar_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdLimpiar.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508457))
    End Sub

    Private Sub cmdSalir_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSalir.Click
        Me.Close()
    End Sub

    Private Sub cmdSalir_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSalir.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508458))
    End Sub

    Private Sub cmdSiguientes_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSiguientes.Click
        If mskCuenta.ClipText.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(501854), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskCuenta.Focus()
            Exit Sub
        End If
        If mskFecha(0).ClipText.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(500353), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskFecha(0).Focus()
            Exit Sub
        End If
        If mskFecha(1).ClipText.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(500354), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskFecha(1).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "399")
        PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, mskCuenta.ClipText)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        Dim VTFDesde As String = FMConvFecha(mskFecha(0).Text, VGFormatoFecha, CGFormatoBase)
        PMPasoValores(sqlconn, "@i_fchdsde", 0, SQLDATETIME, VTFDesde)
        Dim VTFHasta As String = FMConvFecha(mskFecha(1).Text, VGFormatoFecha, CGFormatoBase)
        PMPasoValores(sqlconn, "@i_fchhsta", 0, SQLDATETIME, VTFHasta)
        grdMovimientos.Row = grdMovimientos.Rows - 1
        grdMovimientos.Col = grdMovimientos.Cols - 1
        VLSecuencial = grdMovimientos.CtlText
        PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, VLSecuencial)
        PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, CStr(0))
        PMPasoValores(sqlconn, "@i_diario", 0, SQLINT1, Conversion.Str(VLTranDiario))
        PMPasoValores(sqlconn, "@i_sec_alt", 0, SQLINT4, "-1")
        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
        PMPasoValores(sqlconn, "@o_hist", 1, SQLINT1, "0")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_cons_mov_cb", True, FMLoadResString(503217)) Then
            PMMapeaGrid(sqlconn, grdMovimientos, True)
            PMChequea(sqlconn)
            VLTranDiario = Conversion.Val(FMRetParam(sqlconn, 1))
            cmdSiguientes.Enabled = Not (VLTranDiario = 0)
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
    End Sub

    Private Sub cmdSiguientes_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSiguientes.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508456))
    End Sub

    Private Sub cmdTransmitir_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdTransmitir.Click
        Dim VTFono As String = ""
        If mskCuenta.ClipText.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(501854), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskCuenta.Focus()
            Exit Sub
        End If
        If mskFecha(0).ClipText.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(500387), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskFecha(0).Focus()
            Exit Sub
        End If
        If mskFecha(1).ClipText.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(500388), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskFecha(1).Focus()
            Exit Sub
        End If
        Dim VTMatriz(210, 210) As String
        Dim VTArregloCab(50) As String
        VLTranDiario = 0
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "399")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
        PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, mskCuenta.ClipText)
        Dim VTFDesde As String = FMConvFecha(mskFecha(0).Text, VGFormatoFecha, CGFormatoBase)
        PMPasoValores(sqlconn, "@i_fchdsde", 0, SQLDATETIME, VTFDesde)
        Dim VTFHasta As String = FMConvFecha(mskFecha(1).Text, VGFormatoFecha, CGFormatoBase)
        PMPasoValores(sqlconn, "@i_fchhsta", 0, SQLDATETIME, VTFHasta)
        PMPasoValores(sqlconn, "@i_sec", 0, SQLINT2, "0")
        PMPasoValores(sqlconn, "@i_sec_alt", 0, SQLINT4, "-1")
        PMPasoValores(sqlconn, "@i_hora", 0, SQLDATETIME, "01/01/1900 12:00AM")
        PMPasoValores(sqlconn, "@i_diario", 0, SQLINT1, "0")
        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
        PMPasoValores(sqlconn, "@o_hist", 1, SQLINT1, "0")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_cons_mov_cb", True, FMLoadResString(503217)) Then
            FMMapeaArreglo(sqlconn, VTArregloCab)
            PMMapeaVariable(sqlconn, VTFono)
            PMMapeaGrid(sqlconn, grdMovimientos, False)
            FMMapeaMatriz(sqlconn, VTMatriz)
            PMChequea(sqlconn)
            VLTranDiario = Conversion.Val(FMRetParam(sqlconn, 1))
            lblFechaUltMov.Text = VTArregloCab(1)
            lblMoneda.Text = VTArregloCab(3)
            lblDisponible.Text = VTArregloCab(8)
            lblOficial.Text = VTArregloCab(9)
            lblEstado.Text = VTArregloCab(11)
            cmdSiguientes.Enabled = IIf(VLTranDiario = 0, False, True)
            mskCuenta.Enabled = False
            mskFecha(0).Enabled = False
            mskFecha(1).Enabled = False
            PLTSEstado()
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub cmdTransmitir_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdTransmitir.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508459))
    End Sub

    Private Sub PLInicializar()
        For i As Integer = 0 To 1
            mskFecha(i).Mask = FMMascaraFecha(VGFormatoFecha)
            mskFecha(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        Next i
        mskCuenta.Mask = VGMascaraCtaAho
    End Sub

    Private Sub FConsMovCB_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBSiguientes.Enabled = _cmdSiguientes.Enabled
        TSBSiguientes.Visible = _cmdSiguientes.Visible()
        TSBTransmitir.Enabled = _cmdTransmitir.Enabled
        TSBTransmitir.Visible = _cmdTransmitir.Visible()
        TSBLimpiar.Enabled = _cmdLimpiar.Enabled
        TSBLimpiar.Visible = _cmdLimpiar.Visible()
        TSBSalir.Enabled = _cmdSalir.Enabled
        TSBSalir.Visible = _cmdSalir.Visible()
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
                    PMPasoValores(sqlconn, "@i_cerrada", 0, SQLCHAR, "N")
                    PMPasoValores(sqlconn, "@i_corresponsal", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2237) & mskCuenta.Text & "]") Then
                        PMMapeaObjeto(sqlconn, lblNombre)
                        PMChequea(sqlconn)
                        PMLimpiaGrid(grdMovimientos)
                    Else
                        PMChequea(sqlconn)
                        cmdLimpiar_Click(cmdLimpiar, New EventArgs())
                        Exit Sub
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    cmdLimpiar_Click(cmdLimpiar, New EventArgs())
                    Exit Sub
                End If
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
        End Try
    End Sub

    Private Sub mskFecha_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskFecha_1.Enter, _mskFecha_0.Enter
        Dim Index As Integer = Array.IndexOf(mskFecha, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500410) & VGFormatoFecha & "]")
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500359) & VGFormatoFecha & "]")
        End Select
        mskFecha(Index).SelectionStart = 0
        mskFecha(Index).SelectionLength = Strings.Len(mskFecha(Index).Text)
    End Sub

    Private Sub mskFecha_KeyPressEvent(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _mskFecha_1.KeyPress, _mskFecha_0.KeyPress
        If (Asc(eventArgs.KeyChar) <> 8) And ((Asc(eventArgs.KeyChar) < 48) Or (Asc(eventArgs.KeyChar) > 57)) Then
            eventArgs.KeyChar = Chr(0)
        End If
    End Sub

    Private Sub mskFecha_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskFecha_1.Leave, _mskFecha_0.Leave
        Dim Index As Integer = Array.IndexOf(mskFecha, eventSender)
        Try
            Dim VTValido As Integer = 0
            Dim VTDias As Integer = 0
            Select Case Index
                Case 0, 1
                    If mskFecha(Index).ClipText <> "" Then
                        VTValido = FMVerFormato(mskFecha(Index).Text, VGFormatoFecha)
                        If Not VTValido Then
                            COBISMessageBox.Show(FMLoadResString(500063), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                            mskFecha(Index).Focus()
                            Exit Sub
                        End If
                    Else
                        For i As Integer = 0 To 1
                            mskFecha(i).Mask = FMMascaraFecha(VGFormatoFecha)
                        Next i
                    End If
                    If mskFecha(0).ClipText <> "" And mskFecha(1).ClipText <> "" Then
                        VTDias = FMDateDiff("d", mskFecha(0).Text, mskFecha(1).Text, VGFormatoFecha)
                        If VTDias < 0 Then
                            COBISMessageBox.Show(FMLoadResString(500356), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                            For i As Integer = 0 To 1
                                mskFecha(i).Mask = FMMascaraFecha(VGFormatoFecha)
                                mskFecha(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
                            Next i
                            mskFecha(Index).Focus()
                            Exit Sub
                        End If
                    End If
            End Select
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
        End Try
    End Sub

    Private Sub TSBSIGUIENTES_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdSiguientes.Enabled Then cmdSiguientes_Click(_cmdSiguientes, e)
    End Sub

    Private Sub TSBTRANSMITIR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdTransmitir.Enabled Then cmdTransmitir_Click(_cmdTransmitir, e)
    End Sub

    Private Sub TSBLIMPIAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdLimpiar.Enabled Then cmdLimpiar_Click(_cmdLimpiar, e)
    End Sub

    Private Sub TSBSALIR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdSalir.Enabled Then cmdSalir_Click(_cmdSalir, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub


    Private Sub grdMovimientos_ClickEvent(sender As Object, e As EventArgs) Handles grdMovimientos.ClickEvent
        PMMarcaFilaCobisGrid(grdMovimientos, grdMovimientos.Row)
    End Sub
End Class


