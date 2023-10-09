Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Artinsoft.VB6.Utils
Imports Microsoft.Office.Interop.Excel
Imports Microsoft.VisualBasic
Imports System
Imports System.Diagnostics
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FConRedCBClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


    Dim VLValida As Boolean = False
    Dim i As Integer = 0
    Dim VLPaso As Integer = 0
    Dim svArchivo As String = ""
    Dim Fil As Integer = 0
    Dim col As Integer = 0
    Dim VLEstado As String = ""
    Dim fila As Integer = 0
    Dim columna As Integer = 0
    Dim valor As String = ""

    Private Sub cmdBuscar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdBuscar.Click
        PLBuscar()
    End Sub

    Private Sub cmdExcel_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdExcel_1.Click
        PLExcel()
    End Sub

    Private Sub cmdLimpiar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdLimpiar_2.Click
        PLLimpiar()
    End Sub

    Private Sub cmdSalir_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdSalir_3.Click
        Me.Close()
    End Sub

    Private Sub cmdSiguientes_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSiguientes.Click
        PLSiguiente()
    End Sub

    Private Sub PLInicializar()
        PLLimpiar()
        Dim VLFormatoFecha As String
        VLFormatoFecha = Get_Preferencia("FORMATO-FECHA")
        For i As Integer = 0 To 1
            mskFecha(i).DateType = PLFormatoFecha()
            mskFecha(i).Connection = VGMap
            mskFecha(i).Mask = FMMascaraFecha(VGFormatoFecha)
            mskFecha(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        Next i
        mskFecha(0).Text = ""
        mskFecha(1).Text = ""
        cmdSiguientes.Enabled = False
        _cmdExcel_1.Enabled = False
        PLTSEstado()
    End Sub

    Private Sub FConRedCB_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
    End Sub

    Private Sub grdRegistros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.Click
        PMLineaG(grdRegistros)
    End Sub

    Private Sub mskFecha_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskFecha_1.Enter, _mskFecha_0.Enter
        Dim Index As Integer = Array.IndexOf(mskFecha, eventSender)
        If Index = 0 Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509156) & " (" & VGFormatoFecha & ")")
        Else
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509157) & " (" & VGFormatoFecha & ")")
        End If
        mskFecha(Index).SelectionStart = 0
        mskFecha(Index).SelectionLength = Strings.Len(mskFecha(Index).Text)
    End Sub

    Private Sub mskFecha_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskFecha_1.Leave, _mskFecha_0.Leave
        Dim Index As Integer = Array.IndexOf(mskFecha, eventSender)
        Dim VTValido As Integer = 0
        Dim VTDias As Integer = 0
        Dim VTFecha1 As String
        Dim VTFecha2 As String
        VTFecha1 = mskFecha(0).Text
        VTFecha2 = mskFecha(1).Text
        Try
            Select Case Index
                Case 0, 1
                    If mskFecha(Index).ClipText <> "" Then
                        VTValido = FMVerFormato(mskFecha(Index).Text, VGFormatoFecha)
                        If Not VTValido Then
                            COBISMessageBox.Show(FMLoadResString(500360), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                            mskFecha(Index).Mask = ""
                            mskFecha(Index).Text = ""
                            mskFecha(Index).Mask = FMMascaraFecha(VGFormatoFecha)
                            mskFecha(Index).Focus()

                            Exit Sub
                        End If
                    Else
                        For i As Integer = 0 To 1
                            mskFecha(i).Mask = FMMascaraFecha(VGFormatoFecha)
                        Next i
                    End If
                    'Verficar que fecha de consulta sea menor que la fecha del sistema
                    If FMDateDiff("d", VTFecha1, VGFechaProceso, VGFormatoFecha) <= 0 Then
                        mskFecha(0).Text = VGFechaProceso
                    End If

                    If FMDateDiff("d", VTFecha2, VGFechaProceso, VGFormatoFecha) < 0 Then
                        mskFecha(1).Text = VGFechaProceso
                    End If

                    If mskFecha(0).ClipText <> "" And mskFecha(1).ClipText <> "" Then
                        VTDias = FMDateDiff("d", mskFecha(0).Text, mskFecha(1).Text, VGFormatoFecha)
                        If VTDias < 0 Then
                            COBISMessageBox.Show(FMLoadResString(500356), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                            For i As Integer = 0 To 1
                                mskFecha(1).Mask = FMMascaraFecha(VGFormatoFecha)
                                mskFecha(1).Mask = ""
                                mskFecha(1).Text = ""
                                mskFecha(1).Mask = FMMascaraFecha(VGFormatoFecha)
                                mskFecha(1).Focus()
                            Next i
                            Exit Sub
                        End If
                        If VTDias > 30 Then
                            COBISMessageBox.Show(FMLoadResString(508539), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                            Exit Sub
                        End If


                       
                    End If


            End Select
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
        End Try
    End Sub

    Private Sub optEstado_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optEstado_2.Enter, _optEstado_1.Enter, _optEstado_0.Enter
        Dim Index As Integer = Array.IndexOf(optEstado, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508742)) '"Transacciones Exitosas"
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508741)) '"Transacciones Declinadas"
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508735)) '"Todas las Transacciones"
        End Select
    End Sub

    Private Sub txtCB_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCB.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508510)) '" Código del Corresponsal  [F5] Ayuda")
        txtCB.SelectionStart = 0
        txtCB.SelectionLength = Strings.Len(txtCB.Text)
    End Sub

    Private Sub txtCB_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtCB.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Shift As Integer = eventArgs.KeyData \ &H10000
        If Keycode = VGTeclaAyuda Then
            txtCB.Enabled = True
            VLPaso = True
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1051")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S1")
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "2")
            PMPasoValores(sqlconn, "@i_siguiente", 0, SQLINT2, "0")
            PMHelpG("cobis", "sp_clasoser", 3, 1)
            PMBuscarG(1, "@t_trn", "1051", SQLINT2)
            PMBuscarG(2, "@i_operacion", "S1", SQLCHAR)
            PMBuscarG(3, "@i_modo", "2", SQLINT1)
            PMSigteG(1, "@i_siguiente", 1, SQLINT4)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_clasoser", True, FMLoadResString(508802)) Then
                PMMapeaGrid(sqlconn, grid_valores.gr_SQL, False)
                PMChequea(sqlconn)
                PMProcesG()
                grid_valores.ShowPopup(Me)
                If Temporales(1) <> "" Then
                    txtCB.Text = Temporales(1)
                    lblCB.Text = Temporales(2)
                    VLPaso = True
                    SendKeys.Send("{TAB}")
                Else
                    VLPaso = False
                    txtCB.Focus()
                End If
                grid_valores.Dispose()
            End If
        End If
    End Sub

    Private Sub txtCB_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtCB.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCB_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCB.Leave
        Dim VTArreglo(3) As String
        Dim VTR As Integer = 0

        If txtCB.Text.Trim() <> "" Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1051")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q2")
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtCB.Text)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_clasoser", True, FMLoadResString(508803)) Then
                FMMapeaArreglo(sqlconn, VTArreglo)
                PMChequea(sqlconn)
                lblCB.Text = VTArreglo(1)
                lblCuentaCB.Text = VTArreglo(3)
            Else
                txtCB.Text = ""
                lblCB.Text = ""
                lblCuentaCB.Text = ""
                txtCB.Focus()
            End If

        End If
    End Sub

    Sub PLLimpiar()
        txtCB.Text = ""
        lblCB.Text = ""
        lblCuentaCB.Text = ""
        optEstado(0).Checked = True
        Dim VLFormatoFecha As String
        For i As Integer = 0 To 1
            mskFecha(i).Mask = ""
            mskFecha(i).Text = ""
            mskFecha(i).Mask = FMMascaraFecha(VGFormatoFecha)
            mskFecha(i).DateType = PLFormatoFecha()
            mskFecha(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
            mskFecha(i).Connection = VGMap
        Next i
        PMLimpiaG(grdRegistros)
        _cmdExcel_1.Enabled = False
        cmdSiguientes.Enabled = False
        txtCB.Focus()
        PLTSEstado()
    End Sub

    Sub PLBuscar()
        Dim VTFecha As String = ""
        PLValidarCampos()
        If VLValida Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "706")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_codigo_red", 0, SQLINT2, txtCB.Text)
            VTFecha = FMConvFecha(mskFecha(0).Text, VGFormatoFecha, CGFormatoBase)
            PMPasoValores(sqlconn, "@i_fecha_desde", 0, SQLDATETIME, VTFecha)
            VTFecha = FMConvFecha(mskFecha(1).Text, VGFormatoFecha, CGFormatoBase)
            PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, VTFecha)
            If optEstado(0).Checked Then
                PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "A")
            End If
            If optEstado(1).Checked Then
                PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "X")
            End If
            If optEstado(2).Checked Then
                PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "R")
            End If
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_consolida_trn_cb", True, FMLoadResString(508803)) Then
                PMMapeaGrid(sqlconn, grdRegistros, False)
                PMChequea(sqlconn)
                PMAnchoColumnasGrid(grdRegistros)
                cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = 20
                _cmdExcel_1.Enabled = True

            Else
                PMChequea(sqlconn)
            End If
            PLTSEstado()
        End If
    End Sub

    Sub PLSiguiente()
        Dim VTFecha As String = ""
        PLValidarCampos()
        If VLValida Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "706")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, CStr(1))
            PMPasoValores(sqlconn, "@i_codigo_red", 0, SQLVARCHAR, txtCB.Text)
            VTFecha = FMConvFecha(mskFecha(0).Text, VGFormatoFecha, CGFormatoBase)
            PMPasoValores(sqlconn, "@i_fecha_desde", 0, SQLDATETIME, VTFecha)
            VTFecha = FMConvFecha(mskFecha(1).Text, VGFormatoFecha, CGFormatoBase)
            PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, VTFecha)
            grdRegistros.Col = grdRegistros.Cols - 1
            grdRegistros.Row = grdRegistros.Rows - 1
            PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, grdRegistros.CtlText)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_consolida_trn_cb", True, FMLoadResString(508803)) Then
                PMMapeaGrid(sqlconn, grdRegistros, True)
                PMChequea(sqlconn)
                PMAnchoColumnasGrid(grdRegistros)
                cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = 20
                PLTSEstado()
            Else
                PMChequea(sqlconn)
            End If
        End If
    End Sub

    Sub FormatoGrid()
        grdRegistros.ColAlignment(1) = 1
        grdRegistros.ColAlignment(2) = 1
        grdRegistros.ColAlignment(3) = 1
        grdRegistros.ColAlignment(4) = 1
        grdRegistros.ColAlignment(5) = 1
        grdRegistros.ColAlignment(6) = 1
        grdRegistros.ColAlignment(7) = 1
        grdRegistros.ColAlignment(8) = 1
        grdRegistros.ColAlignment(9) = 1
        grdRegistros.ColWidth(1) = 885
        grdRegistros.ColWidth(2) = 1350
        grdRegistros.ColWidth(3) = 2000
        grdRegistros.ColWidth(4) = 1500
        grdRegistros.ColWidth(5) = 1500
        grdRegistros.ColWidth(6) = 1500
        grdRegistros.ColWidth(7) = 1500
        grdRegistros.ColWidth(8) = 1500
        grdRegistros.ColWidth(9) = 1500
        grdRegistros.ColWidth(10) = 1500
        grdRegistros.ColWidth(11) = 1
        grdRegistros.ColWidth(12) = 1
    End Sub

    Sub PLValidarCampos()
        VLValida = False
        If txtCB.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(508610), FMLoadResString(508550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            txtCB.Focus()
            Exit Sub
        End If
        If mskFecha(0).ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(508607), FMLoadResString(508550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            mskFecha(0).Focus()
            Exit Sub
        End If
        If mskFecha(1).ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(508608), FMLoadResString(508550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            mskFecha(1).Focus()
            Exit Sub
        End If
        Dim VTDias As EventLogEntryType = FMDateDiff("d", mskFecha(0).Text, mskFecha(1).Text, VGFormatoFecha)
        If VTDias < 0 Then
            COBISMessageBox.Show(FMLoadResString(500356), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            For i As Integer = 0 To 1
                mskFecha(i).Mask = FMMascaraFecha(VGFormatoFecha)
            Next i
            Exit Sub
        End If
        If VTDias > 30 Then
            COBISMessageBox.Show(FMLoadResString(508539), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            Exit Sub
        End If
        If Not optEstado(0).Checked And Not optEstado(1).Checked And Not optEstado(2).Checked Then
            COBISMessageBox.Show(FMLoadResString(508521), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            Exit Sub
        End If
        VLValida = True
    End Sub

    Private Sub PLExcel()
        grdRegistros.Row = 1
        grdRegistros.Col = 1
        If grdRegistros.CtlText <> "" Then
            GeneraDatos_Excel()
        Else
            COBISMessageBox.Show(FMLoadResString(502290), FMLoadResString(15000), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End If
    End Sub

    Sub GeneraDatos_Excel()
        Dim VLFormatoFecha As String
        VLFormatoFecha = Get_Preferencia("FORMATO-FECHA")
        Try
            Dim XlsApl As Excel.Application
            Dim xlsLibro As Excel.Workbook
            Dim xlhoja As Excel.Worksheet
            Dim nlTimer As Integer = 0
            nlTimer = CInt(DateTime.Now.TimeOfDay.TotalSeconds)
            XlsApl = New Excel.Application()
            XlsApl.Caption = FMLoadResString(508874)
            XlsApl.WindowState = Excel.XlWindowState.xlMinimized
            XlsApl.Workbooks.Add()
            xlsLibro = XlsApl.ActiveWorkbook
            xlhoja = xlsLibro.Worksheets.Add()
            xlhoja.Name = "CONSO_REDES_POS"
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508564) & " [" & svArchivo & "] ...")
            Fil = 1
            col = 4
            xlsLibro.Worksheets("CONSO_REDES_POS").Cells(Fil, col).Value2 = FMLoadResString(509158)
            Fil = 3
            col = 4
            xlsLibro.Worksheets("CONSO_REDES_POS").Cells(Fil, col).Value2 = FMLoadResString(508793)
            col = 5
            xlsLibro.Worksheets("CONSO_REDES_POS").Cells(Fil, col).Value2 = "'" & mskFecha(0).Text
            col = 6
            xlsLibro.Worksheets("CONSO_REDES_POS").Cells(Fil, col).Value2 = FMLoadResString(509159)
            col = 7
            xlsLibro.Worksheets("CONSO_REDES_POS").Cells(Fil, col).Value2 = "'" & mskFecha(1).Text
            Fil = 4
            col = 4
            xlsLibro.Worksheets("CONSO_REDES_POS").Cells(Fil, col).Value2 = FMLoadResString(9019)
            If optEstado(0).Checked Then
                VLEstado = FMLoadResString(509160)
            End If
            If optEstado(1).Checked Then
                VLEstado = FMLoadResString(509161)
            End If
            If optEstado(2).Checked Then
                VLEstado = FMLoadResString(509162)
            End If
            col = 5
            xlsLibro.Worksheets("CONSO_REDES_POS").Cells(Fil, col).Value2 = VLEstado
            col = 1
            For fila As Integer = 0 To grdRegistros.Rows - 1
                Fil += 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500274) & fila & FMLoadResString(500275) & CStr(grdRegistros.Rows - 1) & " ...")
                grdRegistros.Row = fila
                col = 0
                For columna As Integer = 1 To grdRegistros.Cols - 3
                    col += 1
                    grdRegistros.Col = columna
                    valor = grdRegistros.CtlText
                    If col = 1 Then
                        If FMConvFecha(mskFecha(0).Text, VGFormatoFecha, CGFormatoBase) <> "" Then
                            xlsLibro.Worksheets("CONSO_REDES_POS").Cells(Fil + 1, col).Value2 = "'" & grdRegistros.CtlText
                        Else
                            xlsLibro.Worksheets("CONSO_REDES_POS").Cells(Fil + 1, col).Value2 = grdRegistros.CtlText
                        End If
                    Else
                        xlsLibro.Worksheets("CONSO_REDES_POS").Cells(Fil + 1, col).Value2 = grdRegistros.CtlText
                    End If
                Next
            Next
            XlsApl.Visible = True
            XlsApl.WindowState = Excel.XlWindowState.xlMaximized
            XlsApl.Selection.Borders(Excel.XlBordersIndex.xlInsideVertical).LineStyle = Excel.Constants.xlNone
            XlsApl.Cells.Select()
            XlsApl.Range("E1").Activate()
            XlsApl.Cells.EntireColumn.AutoFit()
        Catch excep As System.Exception
            COBISMessageBox.Show(CStr(Information.Err().Number) & " - " & excep.Message, My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            Exit Sub
        End Try
    End Sub

    Private Sub TSBBUSCAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBuscar.Enabled Then cmdBuscar_Click(_cmdBuscar, e)
    End Sub

    Private Sub TSBSIGUIENTE_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If _cmdSiguientes.Enabled Then cmdSiguientes_Click(_cmdSiguientes, e)
    End Sub

    Private Sub TSBEXCEL_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBExcel.Click
        If _cmdExcel_1.Enabled Then cmdExcel_Click(_cmdExcel_1, e)
    End Sub

    Private Sub TSBLIMPIAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdLimpiar_2.Enabled Then cmdLimpiar_Click(_cmdLimpiar_2, e)
    End Sub

    Private Sub TSBSALIR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdSalir_3.Enabled Then cmdSalir_Click(_cmdSalir_3, e)
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBuscar.Enabled
        TSBBuscar.Visible = _cmdBuscar.Visible()
        TSBSiguiente.Enabled = _cmdSiguientes.Enabled
        TSBSiguiente.Visible = _cmdSiguientes.Visible()
        TSBExcel.Enabled = _cmdExcel_1.Enabled
        TSBExcel.Visible = _cmdExcel_1.Visible()
        TSBLimpiar.Enabled = _cmdLimpiar_2.Enabled
        TSBLimpiar.Visible = _cmdLimpiar_2.Visible()
        TSBSalir.Enabled = _cmdSalir_3.Enabled
        TSBSalir.Visible = _cmdSalir_3.Visible()


    End Sub

    Private Sub PFormas_Click(sender As Object, e As EventArgs) Handles PFormas.Click

    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_DblClick(sender As Object, e As EventArgs) Handles grdRegistros.DblClick
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509163))
    End Sub

    


    Private Sub _mskFecha_0_MaskInputRejected(sender As Object, e As MaskInputRejectedEventArgs) Handles _mskFecha_0.MaskInputRejected

    End Sub

    Private Sub txtCB_TextChanged(sender As Object, e As EventArgs) Handles txtCB.TextChanged

    End Sub

    Private Sub _mskFecha_1_MaskInputRejected(sender As Object, e As MaskInputRejectedEventArgs) Handles _mskFecha_1.MaskInputRejected

    End Sub
End Class


