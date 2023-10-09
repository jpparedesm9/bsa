Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran436Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLTipoR As String = ""
    Dim VLTotal As String = ""
    Dim VLFormatoFecha As String = ""
    Dim VLFlag As Boolean = False
    Dim VLProdbanc As String = ""
    Dim VLNumdias As String = ""
    Dim VLreg As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_1.Click, _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_2.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        If txtOficina.Text <> String.Empty And lblOficina(1).Text = String.Empty Then
            TSBotones.Focus()
            If lblOficina(1).Text = String.Empty Then Exit Sub
        End If
        Select Case Index
            Case 0
                PLBuscar()
            Case 1
                PLImprimir()
            Case 2
                PLLimpiar()
            Case 3
                Me.Cursor = System.Windows.Forms.Cursors.Default
                Me.Close()
        End Select
    End Sub

    Private Sub PLBuscar()
        Dim VTProdBanc As Integer = 0
        Dim VTDias As Integer = 0
        Dim i As Integer = 0
        Dim SecGrid As Integer = 0
        PMLimpiaGrid(grdRegistros)
        If txtOficina.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502565), FMLoadResString(500018),
                                 COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtOficina.Focus()
            Exit Sub
        End If
        If optTipoR(0).Checked Then
            VLTipoR = "P"
        Else
            VLTipoR = "D"
        End If
        If cmbprodb.Text = FMLoadResString(509303) Then
            VTProdBanc = 4
        Else
            VTProdBanc = 3
        End If
        If mskValor(0).ClipText <> "" And mskValor(1).ClipText <> "" Then
            VTDias = FMDateDiff("d", mskValor(0).Text, mskValor(1).Text, VGFormatoFecha)
            If VTDias < 0 Then
                COBISMessageBox.Show(FMLoadResString(500356), FMLoadResString(500018),
                                     COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                For i = 0 To 1
                    mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
                    mskValor(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
                Next i
                mskValor(i).Focus()
                Exit Sub
            Else
                If VTDias > StringsHelper.ToDoubleSafe(VLNumdias) Then
                    COBISMessageBox.Show(FMLoadResString(508541) & " [" & VLNumdias & "] " & FMLoadResString(9945), FMLoadResString(500018),
                                         COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                    Exit Sub
                End If
            End If
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(395))
        PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, VLTipoR)
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtOficina.Text)
        Dim VTFDesde As String = FMConvFecha(mskValor(0).Text, VGFormatoFecha, CGFormatoBase)
        PMPasoValores(sqlconn, "@i_fecha_desde", 0, SQLDATETIME, VTFDesde)
        Dim VTFHasta As String = FMConvFecha(mskValor(1).Text, VGFormatoFecha, CGFormatoBase)
        PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, VTFHasta)
        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, CStr(VTProdBanc))
        PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT2, CStr(0))
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_reporte_ahorro_plan", True, FMLoadResString(508853)) Then
            PMMapeaGrid(sqlconn, grdRegistros, VLFlag)
            PMAnchoColumnasGrid(grdRegistros)
            If VLTipoR = "P" Then
                PMMapeaObjeto(sqlconn, mskValor(0))
                PMMapeaObjeto(sqlconn, mskValor(1))
                PMMapeaVariable(sqlconn, VLTotal)
            Else
                PMChequea(sqlconn)
                PMMapeaVariable(sqlconn, VLTotal)
            End If
            grdRegistros.ColWidth(1) = CInt("1")
            grdRegistros.ColWidth(12) = CInt("1")
            grdRegistros.Row = 1
            grdRegistros.Col = 12
            VLProdbanc = grdRegistros.CtlText
            PMChequea(sqlconn)
            grdRegistros.Row = grdRegistros.Rows - 1
            grdRegistros.Col = 0
            VLreg = grdRegistros.CtlText
            grdRegistros.Row = grdRegistros.Rows - 1
            grdRegistros.Col = 1
            SecGrid = CInt(grdRegistros.CtlText)
            Do While (VLTotal > VLreg)
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                SecGrid = CInt(grdRegistros.CtlText)
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(395))
                PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, VLTipoR)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtOficina.Text)
                VTFDesde = FMConvFecha(mskValor(0).Text, VGFormatoFecha, CGFormatoBase)
                PMPasoValores(sqlconn, "@i_fecha_desde", 0, SQLDATETIME, VTFDesde)
                VTFHasta = FMConvFecha(mskValor(1).Text, VGFormatoFecha, CGFormatoBase)
                PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, VTFHasta)
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, CStr(VTProdBanc))
                PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT2, CStr(SecGrid))
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_reporte_ahorro_plan", True, FMLoadResString(508853)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMAnchoColumnasGrid(grdRegistros)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 0
                VLreg = grdRegistros.CtlText
            Loop
        End If
    End Sub

    Private Sub FTran436_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBImprimir.Enabled = _cmdBoton_1.Enabled
        TSBImprimir.Visible = _cmdBoton_1.Visible
        TSBLimpiar.Enabled = _cmdBoton_2.Enabled
        TSBLimpiar.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_3.Enabled
        TSBSalir.Visible = _cmdBoton_3.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Public Sub PLInicializar()
        cmbprodb.Items.Insert(0, FMLoadResString(509303))
        cmbprodb.Items.Insert(1, FMLoadResString(509304))
        cmbprodb.SelectedIndex = 0
        PLBuscar_parametro()
        VLFormatoFecha = Get_Preferencia(FMLoadResString(509187))
        For i As Integer = 0 To 1
            mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
            mskValor(i).DateType = PLFormatoFecha()
            mskValor(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        Next i
    End Sub

    Private Sub cmbprodb_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbprodb.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500016))
    End Sub

    Private Sub FTran436_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
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
                COBISCorp.eCOBIS.COBISExplorer.Container.
                    COBISContainer.ShowHelpLine(FMLoadResString(508581))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.
                    COBISContainer.ShowHelpLine(FMLoadResString(2325))
        End Select
        mskValor(Index).SelectionStart = 0
        mskValor(Index).SelectionLength = Strings.Len(mskValor(Index).Text)
    End Sub

    Private Sub mskValor_KeyPressEvent(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _mskValor_1.KeyPress, _mskValor_0.KeyPress
        eventArgs.KeyChar = ChrW(FMVAlidaTipoDato("N", Asc(eventArgs.KeyChar)))
    End Sub

    Private Sub mskValor_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskValor_1.Leave, _mskValor_0.Leave
        Dim VTDias As Integer = 0
        Dim i As Integer = 0
        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)

        If PMComprobarFecha(mskValor(Index).Text) = False Then
            mskValor(Index).Select()
            Exit Sub
        End If

        If mskValor(0).ClipText <> "" And mskValor(1).ClipText <> "" Then
            VTDias = FMDateDiff("d", mskValor(0).Text, mskValor(1).Text, VGFormatoFecha)
            If VTDias < 0 Then
                COBISMessageBox.Show(FMLoadResString(500356), FMLoadResString(500018),
                                     COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                For i = 0 To 1
                    mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
                    mskValor(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
                Next i
                mskValor(i).Focus()
                Exit Sub
            Else
                If VTDias > StringsHelper.ToDoubleSafe(VLNumdias) Then
                    COBISMessageBox.Show(FMLoadResString(508541) & " [" & VLNumdias & "] " & FMLoadResString(9945), FMLoadResString(500018),
                                         COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                    Exit Sub
                End If
            End If
        End If
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub optTipoR_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optTipoR_1.CheckedChanged, _optTipoR_0.CheckedChanged
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
                VLTipoR = "P"
                optTipoR(1).Checked = False
                mskValor(0).Enabled = False
                mskValor(1).Enabled = False
            Case 1
                VLTipoR = "D"
                optTipoR(0).Checked = False
                mskValor(0).Enabled = True
                mskValor(1).Enabled = True
        End Select
    End Sub

    Private Sub PLImprimir()
        Dim archivos As String = String.Empty
        Dim reportes As String = String.Empty
        Dim VTR As DialogResult
        Try
            grdRegistros.Row = 1
            grdRegistros.Col = 1
            Dim BaseDatos As DAO.Database
            Dim tablas1, tablas2 As DAO.Recordset
            If grdRegistros.CtlText <> "" Then
                Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
                archivos = VGPath & "\REPORTE.MDB"
                BaseDatos = DAO_DBEngine_definst.OpenDatabase(archivos)
                tablas1 = BaseDatos.OpenRecordset(FMLoadResString(509305))
                tablas2 = BaseDatos.OpenRecordset(FMLoadResString(509306))
                BaseDatos.Execute(FMLoadResString(509307))
                BaseDatos.Execute(FMLoadResString(509308))
                tablas1.AddNew()
                tablas1.Fields(FMLoadResString(509309)).Value = mskValor(0).Text
                tablas1.Fields(FMLoadResString(509310)).Value = mskValor(1).Text
                tablas1.Fields(FMLoadResString(509311)).Value = VGLogin
                tablas1.Fields(FMLoadResString(509312)).Value = txtOficina.Text
                tablas1.Fields(FMLoadResString(509313)).Value = "  " & lblOficina(1).Text
                tablas1.Fields(FMLoadResString(509314)).Value = VLProdbanc
                tablas1.Update()
                tablas1.Close()
                For i As Integer = 1 To (grdRegistros.Rows - 1)
                    grdRegistros.Row = i
                    tablas2.AddNew()
                    tablas2.Fields(FMLoadResString(509315)).Value = txtOficina.Text
                    grdRegistros.Col = 2
                    tablas2.Fields(FMLoadResString(509316)).Value = grdRegistros.CtlText
                    grdRegistros.Col = 3
                    tablas2.Fields(FMLoadResString(509317)).Value = grdRegistros.CtlText
                    grdRegistros.Col = 4
                    tablas2.Fields(FMLoadResString(509318)).Value = grdRegistros.CtlText
                    grdRegistros.Col = 5
                    tablas2.Fields(FMLoadResString(509319)).Value = grdRegistros.CtlText
                    grdRegistros.Col = 6
                    tablas2.Fields(FMLoadResString(509320)).Value = grdRegistros.CtlText
                    grdRegistros.Col = 7
                    tablas2.Fields(FMLoadResString(509321)).Value = grdRegistros.CtlText
                    grdRegistros.Col = 8
                    tablas2.Fields(FMLoadResString(509322)).Value = grdRegistros.CtlText
                    grdRegistros.Col = 9
                    tablas2.Fields(FMLoadResString(509323)).Value = grdRegistros.CtlText
                    grdRegistros.Col = 10
                    tablas2.Fields(FMLoadResString(509324)).Value = grdRegistros.CtlText
                    grdRegistros.Col = 11
                    tablas2.Fields(FMLoadResString(509325)).Value = grdRegistros.CtlText
                    tablas2.Update()
                Next i
                tablas2.Close()
                REM VTMsg = "Asegúrese de que la Impresora se encuentre lista. Desea continuar con la impresión?."
                VTR = COBISMsgBox.MsgBox(FMLoadResString(508435), 36, FMLoadResString(508775))
                If VTR = System.Windows.Forms.DialogResult.Yes Then
                    reportes = VGPath & "\REPSEGUIPRO.RPT"
                    rptReporte.ReportFileName = reportes
                    rptReporte.DataFiles(0) = archivos
                    rptReporte.Destination = COBISCorp.Framework.UI.Components.DestinationConstants.crptToWindow
                    rptReporte.Action = 0
                End If
                Me.Cursor = System.Windows.Forms.Cursors.Default
                BaseDatos.Close()
            Else
                COBISMessageBox.Show(FMLoadResString(500426), FMLoadResString(500427),
                                     COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                Me.Cursor = System.Windows.Forms.Cursors.Default
            End If
        Catch excep As System.Exception
            COBISMessageBox.Show(FMLoadResString(500428) & excep.Message, FMLoadResString(500018),
                                 COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Me.Cursor = System.Windows.Forms.Cursors.Default
            Exit Sub
        End Try
    End Sub

    Private Sub PLLimpiar()
        PMLimpiaGrid(grdRegistros)
        cmbprodb.SelectedIndex = 0
        txtOficina.Enabled = True
        txtOficina.Text = ""
        lblOficina(1).Text = ""
        VLFormatoFecha = Get_Preferencia(FMLoadResString(509187))
        For i As Integer = 0 To 1
            mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
            mskValor(i).DateType = PLFormatoFecha()
            mskValor(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        Next i
        txtOficina.Focus()
    End Sub

    Private Sub txtOficina_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtOficina.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
    End Sub

    Private Sub txtOficina_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtOficina.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.
            COBISContainer.ShowHelpLine(FMLoadResString(508502))
        txtOficina.SelectionStart = 0
        txtOficina.SelectionLength = Strings.Len(txtOficina.Text)
    End Sub

    Private Sub txtOficina_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtOficina.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        If KeyCode = VGTeclaAyuda Then
            VGOperacion = "sp_oficina"
            txtOficina.Text = ""
            lblOficina(1).Text = ""
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502504) & txtOficina.Text & "]") Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.ShowPopup(Me)
                txtOficina.Text = VGACatalogo.Codigo
                lblOficina(1).Text = VGACatalogo.Descripcion
                If txtOficina.Text <> "" Then
                    txtOficina.Focus()
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
        If txtOficina.Text <> "" Then
            lblOficina(1).Text = ""
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtOficina.Text)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502854) & txtOficina.Text & "]") Then
                PMMapeaObjeto(sqlconn, lblOficina(1))
                PMChequea(sqlconn)
            Else
                PMChequea(sqlconn)
                txtOficina.Text = ""
                lblOficina(1).Text = ""
                txtOficina.Focus()
            End If
        Else
            lblOficina(1).Text = ""
        End If
    End Sub

    Private Sub PLBuscar_parametro()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(395))
        PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "S")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_reporte_ahorro_plan", True, FMLoadResString(508853)) Then
            PMMapeaVariable(sqlconn, VLNumdias)
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
            VLNumdias = CStr(0)
        End If
    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502816))
    End Sub
End Class


