Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FMantenimientoCupoCBClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


    Dim VTFecha As String = ""
    Dim VLFecha As String = ""
    Dim VLCuenta As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Click, _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_3.Click, _cmdBoton_4.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                PLBuscar()
            Case 1
                PLSiguientes()
            Case 2
                PLTransmitir()
            Case 3
                PLLimpiar()
            Case 4
                Me.Close()
        End Select
    End Sub

    Sub PLSiguientes()
        If mskCuenta.ClipText = "" And VLCuenta = "" Then
            COBISMessageBox.Show(FMLoadResString(508446), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "398")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        If mskCuenta.ClipText <> "" Then
            PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, mskCuenta.ClipText)
        Else
            PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, VLCuenta)
        End If
        grdRegistros.Col = 8
        grdRegistros.Row = grdRegistros.Rows - 1
        PMPasoValores(sqlconn, "@i_hora", 0, SQLVARCHAR, grdRegistros.CtlText)
        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenimiento_cupo_cb", True, "") Then
            PMMapeaGrid(sqlconn, grdRegistros, True)
            cmdBoton(1).Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = 20
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Sub PLLimpiar()
        mskCuenta.Mask = ""
        mskFecha.Mask = ""
        mskCuenta.Text = ""
        mskFecha.Text = ""
        mskCuenta.Mask = VGMascaraCtaAho
        PMCargarFechaIni()
        lblCorresponsal.Text = ""
        txtDiasVig.Text = CStr(0)
        mskCupo.Text = ""
        mskCuenta.Focus()
    End Sub

    Sub PLBuscar()
        If mskCuenta.ClipText = "" And VLCuenta = "" Then
            COBISMessageBox.Show(FMLoadResString(508603), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            mskCuenta.Focus()
            Exit Sub
        End If
        VLCuenta = mskCuenta.ClipText
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "398")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, mskCuenta.ClipText)
        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenimiento_cupo_cb", True, "") Then
            PMMapeaGrid(sqlconn, grdRegistros, False)
            If Conversion.Val(Convert.ToString(grdRegistros.Tag)) = 20 Then
                cmdBoton(1).Enabled = True
            Else
                cmdBoton(1).Enabled = False
                VLCuenta = ""
            End If
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Sub PLTransmitir()
        If mskCuenta.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(508603), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            mskCuenta.Focus()
            Exit Sub
        End If
        If mskCupo.Text = "0.00" And optTipoMov(0).Checked Then
            COBISMessageBox.Show(FMLoadResString(508533), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            mskCupo.Focus()
            Exit Sub
        End If
        If txtDiasVig.Text = "0" And optTipoMov(0).Checked Then
            COBISMessageBox.Show(FMLoadResString(508621), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            txtDiasVig.Focus()
            Exit Sub
        End If
        If mskFecha.Text = VGFecha Then
            COBISMessageBox.Show(FMLoadResString(508617), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            mskFecha.Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "398")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
        PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, mskCuenta.ClipText)
        PMPasoValores(sqlconn, "@i_cod_cb", 0, SQLINT2, "0")
        PMPasoValores(sqlconn, "@i_valor_cupo", 0, SQLMONEY, mskCupo.ClipText)
        PMPasoValores(sqlconn, "@i_dias_vigencia", 0, SQLINT2, txtDiasVig.Text)
        VTFecha = FMConvFecha(mskFecha.Text, VGFormatoFecha, CGFormatoBase)
        PMPasoValores(sqlconn, "@i_fecha_vencimiento", 0, SQLDATETIME, VTFecha)
        PMPasoValores(sqlconn, "@i_cod_cb", 0, SQLINT2, "0")
        If optTipoMov(0).Checked Then
            PMPasoValores(sqlconn, "@i_tipo_mov", 0, SQLCHAR, "R")
        Else
            If optTipoMov(1).Checked Then
                PMPasoValores(sqlconn, "@i_tipo_mov", 0, SQLCHAR, "D")
            Else
                If optTipoMov(2).Checked Then
                    PMPasoValores(sqlconn, "@i_tipo_mov", 0, SQLCHAR, "I")
                Else
                    If optTipoMov(3).Checked Then
                        PMPasoValores(sqlconn, "@i_tipo_mov", 0, SQLCHAR, "V")
                    End If
                End If
            End If
        End If
        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenimiento_cupo_cb", True, "") Then
            PMChequea(sqlconn)
            PLBuscar()
            PLLimpiar()
            COBISMessageBox.Show(FMLoadResString(503145), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            cmdBoton(1).Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = 20
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub PLInicializar()
        mskCuenta.Mask = VGMascaraCtaAho
        optTipoMov(0).Checked = True
        txtDiasVig.Text = "0"
        PMCargarFechaIni()
    End Sub


    Public Sub PMCargarFechaIni()
        Dim VLFechaini As String
        Dim VLFormatoFecha As String = VGFormatoFecha
        mskFecha.Mask = FMMascaraFecha(VLFormatoFecha)
        mskFecha.DateType = PLFormatoFecha()

        VLFechaini = StringsHelper.Format(VGFecha, VGFormatoFecha)
        mskFecha.Text = FMConvFecha(VLFechaini, VLFormatoFecha, VLFormatoFecha)
    End Sub


    Private Sub FMantenimientoCupoCB_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508918))
    End Sub

    Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        If mskCuenta.ClipText <> "" Then
            If FMChequeaCtaAho(mskCuenta.ClipText) Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                PMPasoValores(sqlconn, "@i_corresponsal", 0, SQLCHAR, "S")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(502622) & mskCuenta.Text & FMLoadResString(508943)) Then
                    PMMapeaObjeto(sqlconn, lblCorresponsal.Text)
                    PMChequea(sqlconn)
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_corresponsal", 0, SQLCHAR, "S")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(502622) & mskCuenta.Text & FMLoadResString(508943)) Then
                        Dim VTArreglo(20) As String
                        FMMapeaArreglo(sqlconn, VTArreglo)
                        PMChequea(sqlconn)
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "398")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, mskCuenta.ClipText)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenimiento_cupo_cb", True, "") Then
                            Dim VTArreglo1(4) As String
                            FMMapeaArreglo(sqlconn, VTArreglo1)
                            PMChequea(sqlconn)
                            If VTArreglo1(1) = "" Then
                                VTArreglo1(1) = CStr(0)
                            End If
                            If VTArreglo1(2) = "" Then
                                VTFecha = FMConvFecha(VGFecha, VGFormatoFecha, VGFormatoFecha)
                                VTArreglo1(2) = VTFecha
                            End If
                            txtDiasVig.Text = VTArreglo1(1)
                            mskFecha.Mask = ""
                            VTFecha = FMConvFecha(VTArreglo1(2), VGFormatoFecha, VGFormatoFecha)
                            mskFecha.Text = VTFecha
                        Else
                            PMChequea(sqlconn)
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
                    cmdBoton(0).Enabled = True
                Else
                    PMChequea(sqlconn)
                    mskCuenta.Mask = ""
                    mskCuenta.Text = ""
                    mskCuenta.Mask = VGMascaraCtaAho
                    mskCuenta.Focus()
                    Exit Sub
                End If
            Else
                COBISMessageBox.Show(FMLoadResString(508917), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                cmdBoton_Click(cmdBoton(3), New EventArgs())
                Exit Sub
            End If
        End If
    End Sub

    Private Sub mskCupo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCupo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508748))
    End Sub

    Private Sub mskCupo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskCupo.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub mskFecha_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFecha.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508945) & VGFormatoFecha & FMLoadResString(508944))
    End Sub

    Private Sub mskFecha_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskFecha.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub mskFecha_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFecha.Leave
        Dim VTValido As Integer = 0
        Dim VLFecha As String
        If mskFecha.ClipText <> "" Then
            VTValido = FMVerFormato(mskFecha.Text, VGFormatoFecha)
            If Not VTValido Then
                COBISMessageBox.Show(FMLoadResString(500360), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                mskFecha.Mask = FMMascaraFecha(VGFormatoFecha)
                mskFecha.Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
                mskFecha.Focus()
                Exit Sub
            Else
                If CDate(mskFecha.Text) < CDate(VGFecha) Then
                    COBISMessageBox.Show(FMLoadResString(508576), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                    mskFecha.Text = VGFecha
                    txtDiasVig.Text = CStr(0)
                    mskFecha.Focus()
                    Exit Sub
                Else
                    If FMDateDiff("d", VGFecha, mskFecha.Text, VGFormatoFecha) > 9999 Then
                        VLFecha = DateTimeHelper.ToString(CDate(VGFecha).AddDays(9999))
                        COBISMessageBox.Show(FMLoadResString(508946) & VLFecha, My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                        txtDiasVig.Text = ""
                        mskFecha.Mask = FMMascaraFecha(VGFormatoFecha)
                        mskFecha.Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
                        txtDiasVig.Focus()
                        Exit Sub
                    Else
                        txtDiasVig.Text = CStr(FMDateDiff("d", VGFecha, mskFecha.Text, VGFormatoFecha))
                    End If
                End If
            End If
        Else
            If mskFecha.Text = "" And txtDiasVig.Text <> "" Then
                mskFecha.Text = CDate(VGFecha).AddDays(CDbl(txtDiasVig.Text))
            Else
                mskFecha.Mask = FMMascaraFecha(VGFormatoFecha)
                mskFecha.Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
            End If
        End If
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub optTipoMov_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optTipoMov_3.CheckedChanged, _optTipoMov_0.CheckedChanged, _optTipoMov_1.CheckedChanged, _optTipoMov_2.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Index As Integer = Array.IndexOf(optTipoMov, eventSender)
            Select Case Index
                Case 0
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508730))
                    If Not mskCupo.Enabled Then
                        mskCupo.Enabled = True
                    End If
                Case 1
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508728))
                    If Not mskCupo.Enabled Then
                        mskCupo.Enabled = True
                    End If
                Case 2
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508729))
                    If Not mskCupo.Enabled Then
                        mskCupo.Enabled = True
                    End If
                Case 3
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508731))
                    If mskCupo.Enabled Then
                        mskCupo.Enabled = False
                    End If
            End Select
        End If
    End Sub

    Private Sub txtDiasVig_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtDiasVig.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        If txtDiasVig.Text <> "" Then
            mskFecha.Text = CDate(VGFecha).AddDays(CDbl(txtDiasVig.Text))
        End If
    End Sub

    Private Sub txtDiasVig_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtDiasVig.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508525))
    End Sub

    Private Sub txtDiasVig_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtDiasVig.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtDiasVig_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtDiasVig.Leave
        If txtDiasVig.Text.Trim() <> "0" Then
            If optTipoMov(0).Checked Then
                If CDbl(txtDiasVig.Text) > 0 Then
                    mskFecha.Text = CDate(VGFecha).AddDays(CDbl(txtDiasVig.Text))
                Else
                    COBISMessageBox.Show(FMLoadResString(508620), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                    txtDiasVig.Focus()
                    Exit Sub
                End If
            End If
        Else
            txtDiasVig.Text = "0"
        End If
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible()
        TSBSiguiente.Enabled = _cmdBoton_1.Enabled
        TSBSiguiente.Visible = _cmdBoton_1.Visible()
        TSBTransmitir.Enabled = _cmdBoton_2.Enabled
        TSBTransmitir.Visible = _cmdBoton_2.Visible()
        TSBLimpiar.Enabled = _cmdBoton_3.Enabled
        TSBLimpiar.Visible = _cmdBoton_3.Visible()
        TSBSalir.Enabled = _cmdBoton_4.Enabled
        TSBSalir.Visible = _cmdBoton_4.Visible()
    End Sub

    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

End Class


