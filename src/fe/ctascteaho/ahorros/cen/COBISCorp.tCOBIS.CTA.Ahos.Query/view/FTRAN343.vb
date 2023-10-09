Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran343Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLIntTotal As Decimal = 0
    Dim VLPosGrid As Integer = 0
    Dim VLNumRegs As String = ""
    Public VLCtaNoMask As String = ""

    Private Sub FTran343_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
        VLCtaNoMask = mskCuenta.Text
        mskCuenta.Text = FMMascara(mskCuenta.Text, VGMascaraCtaAho)
        mskValor(0).Mask = FMMascaraFecha(VGFormatoFecha)
        mskValor(0).DateType = PLFormatoFecha()
        mskValor(0).Connection = VGMap
        mskValor(1).Mask = FMMascaraFecha(VGFormatoFecha)
        mskValor(1).DateType = PLFormatoFecha()
        mskValor(1).Connection = VGMap
        PLLimpiar()
    End Sub

    Public Sub PLInicializar()
        grdEstado.CursorStyle = COBISCorp.Framework.UI.Components.CursorStyleConstants.CursorStyleArrow
        For i As Integer = 0 To 1
            mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
            mskValor(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
            mskValor(i).DateType = PLFormatoFecha()
        Next i
        cmdBoton(4).Enabled = False
        grdEstado.ColWidth(1) = 12
        grdEstado.ColWidth(2) = 13
        grdEstado.ColWidth(3) = 13
        grdEstado.ColWidth(4) = 12
        grdEstado.ColWidth(5) = 12
        PLTSEstado()
        Me.Text = FMLoadResString(20018)
    End Sub

    Private Sub FTran343_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_0.Click, _cmdBoton_4.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTFDesde As String = String.Empty
        Dim VTFHasta As String = String.Empty
        Dim VTFecha As String = ""
        Dim VTFecha1 As String = String.Empty

        Select Case Index
            Case 0 ' TSBTransmitir
                If mskCuenta.ClipText <> "" Then
                    PMBorrarGrid(grdEstado)
                    grdEstado.MaxCols = 6
                    grdEstado.Row = 0
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "343")
                    PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, VLCtaNoMask) ' mskCuenta.ClipText
                    VTFDesde = FMConvFecha(mskValor(0).Text, VGFormatoFecha, CGFormatoBase)
                    PMPasoValores(sqlconn, "@i_fecha_desde", 0, SQLDATETIME, VTFDesde)
                    VTFHasta = FMConvFecha(mskValor(1).Text, VGFormatoFecha, CGFormatoBase)
                    PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, VTFHasta)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros_his", "sp_consdetint_ah", True, FMLoadResString(502623)) Then 'Ok... Consulta de detalle de intereses
                        PMMapeaGrid(sqlconn, grdEstado, False)
                        PMMapeaTextoSGrid(grdEstado)
                        PMMapeaVariable(sqlconn, VLNumRegs)
                        PMChequea(sqlconn)
                        If CDbl(Convert.ToString(grdEstado.Tag)) >= Conversion.Val(VLNumRegs) Then
                            cmdBoton(3).Enabled = True
                            cmdBoton(3).Focus()
                        Else
                            cmdBoton(0).Enabled = False
                            cmdBoton(3).Enabled = False
                            cmdBoton(4).Enabled = True
                            VLIntTotal = 0
                            For i As Integer = 1 To grdEstado.MaxRows
                                grdEstado.Row = i
                                grdEstado.Col = 6
                                VLIntTotal += CDec(grdEstado.Text)
                            Next i
                            lblEtiqueta(4).Text = CStr(VLIntTotal)
                        End If
                        mskCuenta.Enabled = False
                        mskValor(0).Enabled = False
                        mskValor(1).Enabled = False
                    Else
                        PMChequea(sqlconn)
                        grdEstado.MaxRows = 2
                    End If

                    For vti As Integer = 1 To grdEstado.MaxRows
                        grdEstado.RowHeight(vti) = 8.59
                    Next vti
                    grdEstado.Action = COBISCorp.Framework.UI.Components.ActionConstants.ActionActiveCell
                    PMMarcaFilaGrid(grdEstado, VLPosGrid)
                    PMBloqueaGrid(grdEstado)
                Else
                    COBISMessageBox.Show(FMLoadResString(500332), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'El número de Cuenta es mandatorio
                    If mskCuenta.Visible And mskCuenta.Enabled Then mskCuenta.Focus()
                End If
            Case 1 ' TSBLimpiar
                PLLimpiar()
            Case 2 ' TSBSalir
                Me.Close()
            Case 3 ' TSBSiguientes
                If grdEstado.MaxRows > 0 Then
                    grdEstado.Col = 1
                    grdEstado.Row = grdEstado.MaxRows
                    VTFecha = grdEstado.Text
                End If
                VTFecha1 = DateTimeHelper.ToString(CDate(VTFecha).AddDays(1))
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "343")
                PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, VLCtaNoMask) 'mskCuenta.ClipText
                VTFDesde = FMConvFecha(VTFecha1, VGFormatoFecha, CGFormatoBase)
                PMPasoValores(sqlconn, "@i_fecha_desde", 0, SQLDATETIME, VTFDesde)
                VTFHasta = FMConvFecha(mskValor(1).Text, VGFormatoFecha, CGFormatoBase)
                PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, VTFHasta)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros_his", "sp_consdetint_ah", True, FMLoadResString(502623)) Then 'Ok... Consulta de detalle de intereses
                    PMMapeaGrid(sqlconn, grdEstado, True)
                    PMMapeaVariable(sqlconn, VLNumRegs)
                    PMChequea(sqlconn)
                    If CDbl(Convert.ToString(grdEstado.Tag)) >= Conversion.Val(VLNumRegs) Then
                        cmdBoton(3).Enabled = True
                        cmdBoton(3).Focus()
                    Else
                        cmdBoton(0).Enabled = False
                        cmdBoton(3).Enabled = False
                        cmdBoton(4).Enabled = True
                        VLIntTotal = 0
                        For i As Integer = 1 To grdEstado.MaxRows
                            grdEstado.Row = i
                            grdEstado.Col = 5
                            VLIntTotal += CDec(grdEstado.Text)
                        Next i
                        lblEtiqueta(4).Text = CStr(VLIntTotal)
                    End If
                Else
                    PMChequea(sqlconn)
                    grdEstado.MaxRows = 2
                End If
                grdEstado.Action = COBISCorp.Framework.UI.Components.ActionConstants.ActionActiveCell
                PMMarcaFilaGrid(grdEstado, VLPosGrid)
                PMBloqueaGrid(grdEstado)
                cmdBoton(4).Focus()
            Case 4 ' TSBImprimir
                PLConfigurarImpresion()
        End Select
        PLTSEstado()
    End Sub

    Sub PLLimpiar()
        mskValor(0).Enabled = True
        mskValor(1).Enabled = True
        For i As Integer = 0 To 1
            mskValor(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        Next i
        lblEtiqueta(4).Text = ""
        PMBorrarGrid(grdEstado)
        cmdBoton(0).Enabled = True
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = False
        PLTSEstado()
    End Sub

    Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Try
            If mskCuenta.ClipText <> "" Then
                If FMChequeaCtaAho(mskCuenta.ClipText) Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, VLCtaNoMask) 'mskCuenta.ClipText
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_cerrada", 0, SQLCHAR, "C")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(502974) & "[" & mskCuenta.Text & "]") Then 'Ok... Cuenta
                        PMMapeaObjeto(sqlconn, lblDescripcion(0))
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                        lblDescripcion(0).Text = ""
                        mskCuenta.Focus()
                        Exit Sub
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'El dígito verificador de la cuenta de ahorros está incorrecto
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                    lblDescripcion(0).Text = ""
                    mskCuenta.Focus()
                    Exit Sub
                End If
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
        End Try
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500659)) 'Número de la cuenta de ahorros
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
    End Sub

    Private Sub mskValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskValor_1.Enter, _mskValor_0.Enter
        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508574) & " [ " & VGFormatoFecha & " ]") 'Fecha inicial de la consulta
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508586) & " [ " & VGFormatoFecha & " ]") 'Fecha final de la consulta
        End Select
        mskValor(Index).SelectionStart = 0
        mskValor(Index).SelectionLength = Strings.Len(mskValor(Index).Text)
    End Sub

    Private Sub mskValor_KeyPressEvent(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _mskValor_1.KeyPress, _mskValor_0.KeyPress
        If (Asc(eventArgs.KeyChar) <> 8) And ((Asc(eventArgs.KeyChar) < 48) Or (Asc(eventArgs.KeyChar) > 57)) Then
            eventArgs.KeyChar = Chr(0)
        End If
    End Sub

    Private Sub mskValor_Leave(ByVal eventSender As Object, e As EventArgs) Handles _mskValor_0.Leave, _mskValor_1.Leave
        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
        If mskValor(Index).Text > VGFechaProceso Then mskValor(Index).Text = VGFechaProceso
        If PMComprobarFecha(mskValor(Index).Text) = False Or PMComprobarFechasIF(CDate(mskValor(0).Text), CDate(mskValor(1).Text)) = False Then
            mskValor(Index).Focus()
        End If
    End Sub

    Private Sub grdEstado_Click(sender As Object, e As EventArgs) Handles grdEstado.Click
        PMMarcaFilaGrid(grdEstado, grdEstado.Row)
    End Sub

    Private Sub grdEstado_DblClick(sender As Object, e As Framework.UI.Components._DSpreadEvents_DblClickEvent) Handles grdEstado.DblClick
        PMMarcaFilaGrid(grdEstado, grdEstado.Row)
    End Sub

    Private Sub grdEstado_Enter(sender As Object, e As EventArgs) Handles grdEstado.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2323))
    End Sub

    Private Sub grdEstado_Leave(sender As Object, e As EventArgs) Handles grdEstado.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub grdEstado_LeaveCell(ByVal eventSender As Object, ByVal eventArgs As COBISCorp.Framework.UI.Components._DSpreadEvents_LeaveCellEvent) Handles grdEstado.LeaveCell
        If eventArgs.NewRow > -1 Then
            PMMarcaFilaGrid(grdEstado, eventArgs.NewRow)
            VLPosGrid = eventArgs.NewRow
        End If
    End Sub

    Sub PLConfigurarImpresion()
        Dim VTValSubtitulos(7) As String
        Dim VTNumColumnas As Integer = 8
        Dim VTColumnas() As Integer = New Integer() {1, 2, 3, 4, 5, 6, 7, 8}
        Dim VTSepColumnas() As Integer = New Integer() {10, 10, 15, 15, 15, 10, 10, 10}
        Dim VTAlineacion() As Integer = New Integer() {CG_LEFT_ALIGN, CG_RIGHT_ALIGN, CG_RIGHT_ALIGN, CG_RIGHT_ALIGN, CG_RIGHT_ALIGN, CG_RIGHT_ALIGN, CG_RIGHT_ALIGN, CG_RIGHT_ALIGN}
        Dim VTCapSubtitulos() As Integer = New Integer() {5122, 5123, 5016, 500585, 5065, 5066, 5178, 500348}
        VTValSubtitulos(0) = ""
        VTValSubtitulos(1) = ""
        VTValSubtitulos(2) = ""
        VTValSubtitulos(3) = ""
        VTValSubtitulos(4) = ""
        VTValSubtitulos(5) = ""
        VTValSubtitulos(6) = ""
        VTValSubtitulos(7) = ""
        VTValSubtitulos(0) = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetString(VGResourceManager, "str5121").ToString()
        VTValSubtitulos(1) = VGLogin
        VTValSubtitulos(2) = mskCuenta.Text
        VTValSubtitulos(3) = lblDescripcion(0).Text
        VTValSubtitulos(4) = mskValor(0).Text
        VTValSubtitulos(5) = mskValor(1).Text
        VTValSubtitulos(6) = lblEtiqueta(4).Text
        VTValSubtitulos(7) = StringsHelper.Format(DateTime.Today, VGFormatoFecha)
        PMImprimirReporte(grdEstado, VTNumColumnas, VTColumnas, VTSepColumnas, 3867, VTCapSubtitulos, VTValSubtitulos, VTAlineacion, CG_LANDSCAPE)
    End Sub

    Private Sub PLTSEstado()
        TSBImprimir.Enabled = _cmdBoton_4.Enabled
        TSBImprimir.Visible = _cmdBoton_4.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBSiguientes.Enabled = _cmdBoton_3.Enabled
        TSBSiguientes.Visible = _cmdBoton_3.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
    End Sub

    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub
End Class


