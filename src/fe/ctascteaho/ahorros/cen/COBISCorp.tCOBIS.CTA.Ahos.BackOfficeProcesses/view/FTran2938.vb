Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran2938Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


    Dim VLPaso As Integer = 0

    Private Sub FTran2938_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub
    Private Sub PLInicializar()
        MyAppGlobals.AppActiveForm = ""
        For i As Integer = 0 To 1
            mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
            mskValor(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        Next i
        mskCuenta.Mask = VGMascaraCtaCte
        PLCargarTipo()
    End Sub

    Private Sub PLCargarTipo()
        cmbTipo.Items.Insert(0, FMLoadResString(502554))
        cmbTipo.Items.Insert(1, FMLoadResString(502555))
        cmbTipo.SelectedIndex = 0
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_0.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                PLImprimir()
            Case 1
                PLLimpiar()
            Case 2
                Me.Close()
        End Select
    End Sub

    Private Sub PLImprimir()
        Try
            Dim VTFDesde As String = String.Empty
            Dim VTFHasta As String = String.Empty
            Dim archivo As String = String.Empty
            Dim VTMsg As String = String.Empty
            Dim VTR As Integer = 0
            Dim reportes As String = ""
            Const IDYES As Integer = 6
            If mskValor(0).ClipText.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(500353), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskValor(0).Focus()
                Exit Sub
            End If
            If mskValor(1).ClipText.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(500354), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskValor(1).Focus()
                Exit Sub
            End If
            If mskCuenta.ClipText.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(500660), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskCuenta.Focus()
                Exit Sub
            End If
            If COBISMessageBox.Show(FMLoadResString(500423) & Strings.Chr(13).ToString() & FMLoadResString(500424), FMLoadResString(500092), COBISMessageBox.COBISButtons.OK Or COBISMessageBox.COBISButtons.OKCancel, COBISMessageBox.COBISIcon.Question) <> System.Windows.Forms.DialogResult.OK Then
                Exit Sub
            End If
            Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
            Dim VTArreglo(5) As String
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "2938")
            VTFDesde = FMConvFecha(mskValor(0).Text, VGFormatoFecha, CGFormatoBase)
            PMPasoValores(sqlconn, "@i_fecha_ini", 0, SQLDATETIME, VTFDesde)
            VTFHasta = FMConvFecha(mskValor(1).Text, VGFormatoFecha, CGFormatoBase)
            PMPasoValores(sqlconn, "@i_fecha_fin", 0, SQLDATETIME, VTFHasta)
            If txtCampo(1).Text.Trim() <> "" Then
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT4, txtCampo(1).Text)
            End If
            PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, mskCuenta.ClipText)
            PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
            If cmbTipo.Text = FMLoadResString(502554) Then
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "CM")
            End If
            If cmbTipo.Text = FMLoadResString(502555) Then
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "AM")
            End If
            Dim BaseDatos As DAO.Database
            Dim Tabla1 As DAO.Recordset
            If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_mov_volefectivo", True, FMLoadResString(508849)) Then
                FMMapeaArreglo(sqlconn, VTArreglo)
                PMChequea(sqlconn)
                If VTArreglo.GetUpperBound(0) > 0 Then
                    archivo = VGPath & "\contefec.mdb"
                    BaseDatos = DAO_DBEngine_definst.OpenDatabase(archivo)
                    Tabla1 = BaseDatos.OpenRecordset("volumen_efectivo")
                    BaseDatos.Execute("delete from volumen_efectivo")
                    Tabla1.AddNew()
                    Tabla1.Fields("ve_fecha_inicio").Value = mskValor(0).Text
                    Tabla1.Fields("ve_fecha_fin").Value = mskValor(1).Text
                    Tabla1.Fields("ve_oficina").Value = txtCampo(1).Text
                    Tabla1.Fields("ve_descoficina").Value = lblDescripcion(0).Text
                    Tabla1.Fields("ve_tipocta").Value = cmbTipo.Text
                    Tabla1.Fields("ve_cta_banco").Value = mskCuenta.Text
                    Tabla1.Fields("ve_desctitular").Value = lblDescripcion(1).Text
                    Tabla1.Fields("ve_nro_transacciones").Value = IIf(VTArreglo(1) <> "", VTArreglo(1), 0)
                    Tabla1.Fields("ve_efec_recib").Value = IIf(VTArreglo(2) <> "", VTArreglo(2), 0)
                    Tabla1.Fields("ve_efec_pag").Value = IIf(VTArreglo(3) <> "", VTArreglo(3), 0)
                    Tabla1.Fields("filial").Value = Conversion.Val(VGLOGO)
                    Tabla1.Update()
                    Tabla1.Close()
                    VTMsg = FMLoadResString(508435)
                    VTR = COBISMsgBox.MsgBox(VTMsg, 36, FMLoadResString(500425))
                    If VTR = IDYES Then
                        reportes = VGPath & "\volumenefec.rpt"
                        rptReporte.ReportFileName = reportes
                        rptReporte.DataFiles(0) = archivo
                        rptReporte.Destination = COBISCorp.Framework.UI.Components.DestinationConstants.crptToWindow
                        rptReporte.Action = 0
                    End If
                    BaseDatos.Close()
                Else
                    COBISMessageBox.Show(FMLoadResString(500426), FMLoadResString(500427), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                    Me.Cursor = System.Windows.Forms.Cursors.Default
                End If
            Else
                PMChequea(sqlconn)
            End If
            Me.Cursor = System.Windows.Forms.Cursors.Default
        Catch excep As System.Exception
            COBISMessageBox.Show(FMLoadResString(500428) & excep.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Me.Cursor = System.Windows.Forms.Cursors.Default
            Exit Sub
        End Try
    End Sub

    Private Sub PLLimpiar()
        mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
        mskValor(0).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        mskValor(1).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        txtCampo(1).Text = ""
        lblDescripcion(0).Text = ""
        lblDescripcion(1).Text = ""
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Index = 1 Then
            VLPaso = False
        End If
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 1
                VLPaso = True
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500376))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_1.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode        
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Keycode = VGTeclaAyuda Then
            If Index = 1 Then
                VGOperacion = "sp_oficina"
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502502) & txtCampo(1).Text & "]") Then
                    PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                    PMChequea(sqlconn)
                    FCatalogo.ShowPopup(Me)
                    txtCampo(1).Text = VGACatalogo.Codigo
                    lblDescripcion(0).Text = VGACatalogo.Descripcion
                    FCatalogo.Dispose()
                Else
                    PMChequea(sqlconn)
                End If
                VLPaso = True
            End If
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_1.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToLower())
            Case 1, 2
                If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                    KeyAscii = 0
                End If
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Index = 1 Then
            If Not VLPaso Then
                If txtCampo(1).Text <> "" Then
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtCampo(1).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502852) & txtCampo(1).Text & "]") Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(0).Text)
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        VLPaso = True
                        txtCampo(1).Text = ""
                        lblDescripcion(0).Text = ""
                        txtCampo(1).Focus()
                        PLLimpiar()
                    End If
                Else
                    lblDescripcion(0).Text = ""
                End If
            End If
        End If
    End Sub

    Private Sub cmbTipo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbTipo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500429))
    End Sub

    Private Sub cmbTipo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbTipo.Leave
        If cmbTipo.SelectedIndex = 0 Then
            mskCuenta.Mask = VGMascaraCtaCte
        ElseIf cmbTipo.SelectedIndex = 1 Then
            mskCuenta.Mask = VGMascaraCtaAho
        End If
        mskCuenta_Leave(mskCuenta, New EventArgs())
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508672))
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
    End Sub

    Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        Try
            If mskCuenta.ClipText <> "" Then
                If cmbTipo.SelectedIndex = 0 Then
                    If FMChequeaCtaCte(mskCuenta.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "16")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, FMLoadResString(509302) & "[" & mskCuenta.Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(1).Text)
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                            lblDescripcion(1).Text = ""
                            mskCuenta.Focus()
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(500020), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                        lblDescripcion(1).Text = ""
                        mskCuenta.Focus()
                        Exit Sub
                    End If
                ElseIf cmbTipo.SelectedIndex = 1 Then
                    If FMChequeaCtaAho(mskCuenta.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2274) & mskCuenta.Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(1).Text)
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                            lblDescripcion(1).Text = ""
                            mskCuenta.Focus()
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                        lblDescripcion(1).Text = ""
                        mskCuenta.Focus()
                        Exit Sub
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(500430), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                    If cmbTipo.Enabled Then cmbTipo.Focus()
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
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500358) & VGFormatoFecha & "]")
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500359) & VGFormatoFecha & "]")
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
        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
        Try
            Dim VTValido As Integer = 0
            Dim VTDias As Integer = 0
            Select Case Index
                Case 0, 1
                    If mskValor(Index).ClipText <> "" Then
                        VTValido = FMVerFormato(mskValor(Index).Text, VGFormatoFecha)
                        If Not VTValido Then
                            COBISMessageBox.Show(FMLoadResString(500360), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
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
                            For i As Integer = 0 To 1
                                mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
                                mskValor(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
                            Next i
                            mskValor(Index).Focus()
                            Exit Sub
                        End If
                    End If
            End Select
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
        End Try
    End Sub

    Private Sub PLTSEstado()
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
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

End Class


