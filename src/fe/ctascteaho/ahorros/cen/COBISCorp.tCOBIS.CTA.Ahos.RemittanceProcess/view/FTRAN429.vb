Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran429Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


    Dim VLTipoR As String = ""
    Dim VLTotal As String = ""
    Dim VLPaso As Boolean = False
    Dim VLFormatoFecha As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_4.Click, _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_0.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTDias As Integer = 0
        Dim VTModo As Boolean = False
        Dim VTFDesde As String = String.Empty
        Dim VTFHasta As String = String.Empty
        Select Case Index
            Case 0
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
                If mskValor(0).ClipText <> "" And mskValor(1).ClipText <> "" Then
                    VTDias = FMDateDiff("d", StringsHelper.Format(VGFecha, VLFormatoFecha), mskValor(1).Text, VLFormatoFecha)
                    If VTDias > 0 Then
                        COBISMessageBox.Show(FMLoadResString(500355), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                        mskValor(1).Mask = ""
                        mskValor(1).Text = ""
                        mskValor(1).Mask = FMMascaraFecha(VLFormatoFecha)
                        mskValor(1).DateType = PLFormatoFecha()
                        mskValor(1).Connection = VGMap
                        mskValor(1).Focus()
                        Exit Sub
                    End If
                End If
                If mskValor(0).ClipText <> "" And mskValor(1).ClipText <> "" Then
                    VTDias = FMDateDiff("d", mskValor(0).Text, mskValor(1).Text, VLFormatoFecha)
                    If VTDias < 0 Then
                        COBISMessageBox.Show(FMLoadResString(500356), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                        mskValor(0).Mask = ""
                        mskValor(0).Text = ""
                        mskValor(0).Mask = FMMascaraFecha(VLFormatoFecha)
                        mskValor(0).DateType = PLFormatoFecha()
                        mskValor(0).Connection = VGMap
                        mskValor(0).Focus()
                        Exit Sub
                    End If
                End If
                VTModo = False
                If optTipoR(0).Checked Then
                    optTipoR_ClickHelper(0, True)
                ElseIf optTipoR(1).Checked Then
                    optTipoR_ClickHelper(1, True)
                ElseIf optTipoR(2).Checked Then
                    optTipoR_ClickHelper(2, True)
                ElseIf optTipoR(3).Checked Then
                    optTipoR_ClickHelper(3, True)
                Else
                    COBISMessageBox.Show(FMLoadResString(508725), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "429")
                PMPasoValores(sqlconn, "@i_tiporem", 0, SQLCHAR, VLTipoR)
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, VGMoneda)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtOficina.Text)
                VTFDesde = FMConvFecha(mskValor(0).Text, VLFormatoFecha, "mm/dd/yyyy")
                PMPasoValores(sqlconn, "@i_fecha_desde", 0, SQLDATETIME, VTFDesde)
                VTFHasta = FMConvFecha(mskValor(1).Text, VLFormatoFecha, "mm/dd/yyyy")
                PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, VTFHasta)
                PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT2, "0")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_chequexofi", True, FMLoadResString(508834)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, VTModo)
                    PMMapeaVariable(sqlconn, VLTotal)
                    lblTotal(0).Text = VLTotal
                    PMChequea(sqlconn)
                    If grdRegistros.Rows <= 2 Then
                        grdRegistros.Row = 1
                        grdRegistros.Col = 1
                        If grdRegistros.CtlText = "" Then
                            Exit Sub
                        End If
                    End If
                    cmdBoton(3).Enabled = True
                    txtOficina.Enabled = False
                    FrameTipoR.Enabled = True
                    If Conversion.Val(Convert.ToString(grdRegistros.Tag)) >= 20 Then
                        cmdBoton(4).Enabled = True
                    Else
                        cmdBoton(4).Enabled = False
                        If Conversion.Val(Convert.ToString(grdRegistros.Tag)) > 0 Then
                            lblTotal(0).Text = VLTotal
                        End If
                    End If
                Else
                    PMChequea(sqlconn)
                    PLLimpiar()
                End If
            Case 1
                PLLimpiar()
            Case 2
                Me.Close()
            Case 3
                PLImprimir()
            Case 4
                VTModo = True
                grdRegistros.Col = 12
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "429")
                PMPasoValores(sqlconn, "@i_tiporem", 0, SQLCHAR, VLTipoR)
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, VGMoneda)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtOficina.Text)
                VTFDesde = FMConvFecha(mskValor(0).Text, VLFormatoFecha, "mm/dd/yyyy")
                PMPasoValores(sqlconn, "@i_fecha_desde", 0, SQLDATETIME, VTFDesde)
                VTFHasta = FMConvFecha(mskValor(1).Text, VLFormatoFecha, "mm/dd/yyyy")
                PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, VTFHasta)
                PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, grdRegistros.CtlText)
                grdRegistros.Col = 14
                PMPasoValores(sqlconn, "@i_carta", 0, SQLINT4, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_chequexofi", True, FMLoadResString(508834)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, VTModo)
                    PMChequea(sqlconn)
                    If Conversion.Val(Convert.ToString(grdRegistros.Tag)) >= 20 Then
                        cmdBoton(4).Enabled = True
                    Else
                        cmdBoton(4).Enabled = False
                        VTModo = False
                    End If
                Else
                    PMChequea(sqlconn)
                    PLLimpiar()
                End If
        End Select
        PLTSEstado()
    End Sub

    Private Sub FTran429_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBImprimir.Enabled = _cmdBoton_3.Enabled
        TSBImprimir.Visible = _cmdBoton_3.Visible
        TSBSiguiente.Enabled = _cmdBoton_4.Enabled
        TSBSiguiente.Visible = _cmdBoton_4.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
    End Sub
    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
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

    Public Sub PLInicializar()
        VLFormatoFecha = VGFormatoFecha
        For i As Integer = 0 To 1
            mskValor(i).Mask = FMMascaraFecha(VLFormatoFecha)
            mskValor(i).DateType = PLFormatoFecha()
            mskValor(i).Connection = VGMap
            mskValor(i).Text = StringsHelper.Format(VGFecha, VLFormatoFecha)
        Next i
    End Sub

    Private Sub FTran429_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdRegistros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.Click
        grdRegistros.Col = 0
        grdRegistros.SelStartCol = 1
        grdRegistros.SelEndCol = grdRegistros.Cols - 1
        If grdRegistros.Row = 0 Then
            grdRegistros.SelStartRow = 1
            grdRegistros.SelEndRow = 1
        Else
            grdRegistros.SelStartRow = grdRegistros.Row
            grdRegistros.SelEndRow = grdRegistros.Row
        End If
    End Sub

    Private Sub mskValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskValor_1.Enter, _mskValor_0.Enter
        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508581))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2325))
        End Select
        mskValor(Index).SelectionStart = 0
        mskValor(Index).SelectionLength = Strings.Len(mskValor(Index).Text)
    End Sub

    Private Sub mskValor_KeyPressEvent(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _mskValor_1.KeyPress, _mskValor_0.KeyPress
        'eventArgs.KeyAscii = FMVAlidaTipoDato("N", Asc(eventArgs.KeyChar))
        eventArgs.KeyChar = ChrW(FMVAlidaTipoDato("N", Asc(eventArgs.KeyChar)))
    End Sub

    Private Sub mskValor_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskValor_1.Leave, _mskValor_0.Leave
        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
        Dim VTValido As Boolean = False
        Dim VTDias As Integer = 0
        Select Case Index
            Case 0, 1
                If mskValor(Index).ClipText <> "" Then
                    VTValido = FMVerFormato(mskValor(Index).Text, VLFormatoFecha)
                    If Not VTValido Then
                        COBISMessageBox.Show(FMLoadResString(500063), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                        mskValor(Index).Mask = ""
                        mskValor(Index).Text = ""
                        mskValor(Index).Mask = FMMascaraFecha(VLFormatoFecha)
                        mskValor(Index).DateType = PLFormatoFecha()
                        mskValor(Index).Connection = VGMap
                        mskValor(Index).Focus()
                        Exit Sub
                    End If
                End If
                If mskValor(0).ClipText <> "" And mskValor(1).ClipText <> "" Then
                    VTDias = FMDateDiff("d", mskValor(0).Text, mskValor(1).Text, VLFormatoFecha)
                    If VTDias < 0 Then
                        COBISMessageBox.Show(FMLoadResString(500356), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                        For i As Integer = 0 To 1
                            mskValor(i).Mask = FMMascaraFecha(VLFormatoFecha)
                            mskValor(i).DateType = PLFormatoFecha()
                            mskValor(i).Connection = VGMap
                            mskValor(i).Text = StringsHelper.Format(VGFecha, VLFormatoFecha)
                        Next i
                        mskValor(0).Focus()
                        Exit Sub
                    End If
                End If
        End Select
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub optTipoR_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optTipoR_3.CheckedChanged, _optTipoR_2.CheckedChanged, _optTipoR_1.CheckedChanged, _optTipoR_0.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Index As Integer = Array.IndexOf(optTipoR, eventSender)
            Dim Value As Integer = optTipoR(Index).Checked
            optTipoR_ClickHelper(Index, Value)
        End If
    End Sub

    Private Sub optTipoR_ClickHelper(ByRef Index As Integer, ByRef Value As Integer)
        Select Case Index
            Case 0
                VLTipoR = "T"
                optTipoR(1).Checked = False
                optTipoR(2).Checked = False
                optTipoR(3).Checked = False
            Case 1
                VLTipoR = "P"
                optTipoR(0).Checked = False
                optTipoR(2).Checked = False
                optTipoR(3).Checked = False
            Case 2
                VLTipoR = "C"
                optTipoR(0).Checked = False
                optTipoR(1).Checked = False
                optTipoR(3).Checked = False
            Case 3
                VLTipoR = "D"
                optTipoR(0).Checked = False
                optTipoR(1).Checked = False
                optTipoR(2).Checked = False
        End Select
    End Sub

    Private Sub PLImprimir()
        Try
            'Const IDYES As DialogResult = System.Windows.Forms.DialogResult.Yes
            Dim VTR As DialogResult
            Dim archivos As String = String.Empty
            Dim reportes As String = String.Empty
            Dim VTTipo As String = String.Empty
            Dim VTMsg As String = String.Empty
            If CDbl(Convert.ToString(grdRegistros.Tag)) > 1 Then
                PMOrdenarGrid(grdRegistros, 2)
            End If
            Dim BaseDatos As DAO.Database
            Dim tablas1, tablas2 As DAO.Recordset
            If grdRegistros.Rows > 1 Then
                Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
                archivos = VGPath & "\REMESAS.MDB"
                BaseDatos = DAO_DBEngine_definst.OpenDatabase(archivos)
                tablas1 = BaseDatos.OpenRecordset("re_encabezado")
                tablas2 = BaseDatos.OpenRecordset("re_detalle")
                BaseDatos.Execute("delete from re_detalle")
                BaseDatos.Execute("delete from re_encabezado")
                tablas1.AddNew()
                tablas1.Fields("en_oficina").Value = CInt(VGOficina)
                tablas1.Fields("en_desc_oficina").Value = txtOficina.Text & "  " & lblTotal(1).Text
                If optTipoR(0).Checked Then
                    VTTipo = optTipoR(0).Text
                ElseIf optTipoR(1).Checked Then
                    VTTipo = optTipoR(1).Text
                ElseIf optTipoR(2).Checked Then
                    VTTipo = optTipoR(2).Text
                Else
                    VTTipo = optTipoR(3).Text
                End If
                tablas1.Fields("en_tipo_remesa").Value = VTTipo.ToUpper()
                tablas1.Update()
                tablas1.Close()
                For i As Integer = 1 To (grdRegistros.Rows - 1)
                    grdRegistros.Row = i
                    tablas2.AddNew()
                    tablas2.Fields("de_oficina").Value = CInt(VGOficina)
                    grdRegistros.Col = 1
                    tablas2.Fields("de_fecha").Value = grdRegistros.CtlText
                    grdRegistros.Col = 2
                    tablas2.Fields("de_num_bco_girado").Value = grdRegistros.CtlText
                    grdRegistros.Col = 4
                    tablas2.Fields("de_num_carta").Value = grdRegistros.CtlText
                    grdRegistros.Col = 6
                    tablas2.Fields("de_cta_deposito").Value = grdRegistros.CtlText
                    grdRegistros.Col = 7
                    tablas2.Fields("de_cheque").Value = grdRegistros.CtlText
                    grdRegistros.Col = 11
                    tablas2.Fields("de_valor").Value = grdRegistros.CtlText
                    tablas2.Update()
                Next i
                tablas2.Close()
                VTMsg = FMLoadResString(508435)
                VTR = COBISMsgBox.MsgBox(VTMsg, 36, FMLoadResString(500425))
                If VTR = System.Windows.Forms.DialogResult.Yes Then
                    reportes = VGPath & "\cons_rem_ofi.rpt"
                    rptReporte.ReportFileName = reportes
                    rptReporte.CopiesToPrinter = 1
                    rptReporte.DataFiles(0) = archivos
                    rptReporte.Destination = COBISCorp.Framework.UI.Components.DestinationConstants.crptToPrinter
                    rptReporte.Action = 1
                End If
                Me.Cursor = System.Windows.Forms.Cursors.Default
                BaseDatos.Close()
            Else
                COBISMessageBox.Show(FMLoadResString(500426), FMLoadResString(500427), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                Me.Cursor = System.Windows.Forms.Cursors.Default
            End If
        Catch excep As System.Exception
            COBISMessageBox.Show(FMLoadResString(500428) & excep.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Me.Cursor = System.Windows.Forms.Cursors.Default
            Exit Sub
        End Try
    End Sub

    Private Sub PLLimpiar()
        PMLimpiaGrid(grdRegistros)
        lblTotal(0).Text = ""
        lblTotal(1).Text = ""
        txtOficina.Enabled = True
        txtOficina.Text = ""
        mskValor(0).Mask = ""
        mskValor(0).Text = ""
        mskValor(0).Mask = FMMascaraFecha(VLFormatoFecha)
        mskValor(0).DateType = PLFormatoFecha()
        mskValor(0).Connection = VGMap
        mskValor(1).Mask = ""
        mskValor(1).Text = ""
        mskValor(1).Mask = FMMascaraFecha(VLFormatoFecha)
        mskValor(1).DateType = PLFormatoFecha()
        mskValor(1).Connection = VGMap
        txtOficina.Focus()
        If cmdBoton(4).Enabled Then
            cmdBoton(4).Enabled = False
        End If
        cmdBoton(3).Enabled = False
        VLFormatoFecha = VGFormatoFecha
        For i As Integer = 0 To 1
            mskValor(i).Mask = FMMascaraFecha(VLFormatoFecha)
            mskValor(i).DateType = PLFormatoFecha()
            mskValor(i).Connection = VGMap
            mskValor(i).Text = StringsHelper.Format(VGFecha, VLFormatoFecha)
        Next i
        PLTSEstado()
    End Sub

    Private Sub txtOficina_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtOficina.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub txtOficina_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtOficina.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508502))
        txtOficina.SelectionStart = 0
        txtOficina.SelectionLength = Strings.Len(txtOficina.Text)
    End Sub

    Private Sub txtOficina_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtOficina.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        If KeyCode = VGTeclaAyuda Then
            VGOperacion = "sp_oficina"
            VLPaso = True
            txtOficina.Text = ""
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502504) & txtOficina.Text & "]") Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.ShowPopup(Me)
                txtOficina.Text = VGACatalogo.Codigo
                lblTotal(1).Text = VGACatalogo.Descripcion
                If txtOficina.Text <> "" Then
                    VLPaso = True
                    mskValor(0).Focus()
                End If
            Else
                PMChequea(sqlconn)
            End If
        End If
    End Sub

    Private Sub txtOficina_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtOficina.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtOficina_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtOficina.Leave
        If Not VLPaso And txtOficina.Text <> "" Then
            If txtOficina.Text <> "" Then
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtOficina.Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502504) & txtOficina.Text & "]") Then
                    PMMapeaObjeto(sqlconn, lblTotal(1))
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtOficina.Text = ""
                    lblTotal(1).Text = ""
                    txtOficina.Focus()
                End If
            Else
                lblTotal(1).Text = ""
            End If
        End If
    End Sub

    Private Sub txtOficina_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles txtOficina.MouseDown

    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
    End Sub
End Class


