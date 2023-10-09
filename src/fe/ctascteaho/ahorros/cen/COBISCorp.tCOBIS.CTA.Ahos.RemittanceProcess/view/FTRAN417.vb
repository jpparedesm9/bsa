Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Drawing
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran417Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLFila As Integer = 0
    Dim VLFormatoFecha As String = ""
    Dim VLPaso As Boolean = False
    Dim VLNumeroCheq As Integer = 0
    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_0.Click, _cmdBoton_3.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                PLSiguiente()
            Case 1
                PMMarcarRegistro()
            Case 2
                PLImprimir()
            Case 3
                Me.Close()
        End Select
    End Sub

    Private Sub FTran417_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
    End Sub

    Private Sub PLTSEstado()
        TSBSiguiente.Enabled = _cmdBoton_0.Enabled
        TSBSiguiente.Visible = _cmdBoton_0.Visible
        TSBEscoger.Enabled = _cmdBoton_1.Enabled
        TSBEscoger.Visible = _cmdBoton_1.Visible
        TSBImprimir.Enabled = _cmdBoton_2.Enabled
        TSBImprimir.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_3.Enabled
        TSBSalir.Visible = _cmdBoton_3.Visible
    End Sub
    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBEscoger_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEscoger.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub
    Private Sub TSBImprimir_Click(sender As Object, e As EventArgs) Handles TSBImprimir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
        ' PLImprimir()
    End Sub
    Public Sub PLInicializar()
        VLFormatoFecha = Get_Preferencia("FORMATO-FECHA")
        picVisto(0).Image = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetImage(VGResourceManager, "bmp31004")
        picVisto(1).Image = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetImage(VGResourceManager, "bmp31003")
        txtCarta.Enabled = True
        txtCarta.Text = VGOficina
        txtCarta_Leave(txtCarta, New EventArgs())
        lblDescripcion(1).Text = StringsHelper.Format(VGFecha, VLFormatoFecha)
        PLBuscar()
        PLTSEstado()
        ' TSBImprimir.Enabled = True
    End Sub

    Private Sub FTran417_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdCarta_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdCarta.Click, grdCarta.ClickEvent
        grdCarta.Col = 0
        grdCarta.SelStartCol = 1
        grdCarta.SelEndCol = grdCarta.Cols - 1
        If grdCarta.Row = 0 Then
            grdCarta.SelStartRow = 1
            grdCarta.SelEndRow = 1
        Else
            grdCarta.SelStartRow = grdCarta.Row
            grdCarta.SelEndRow = grdCarta.Row
        End If
        VLFila = grdCarta.Row
        PMCheques(grdCheque)
    End Sub

    Private Sub grdCarta_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdCarta.DblClick
        If grdCarta.Rows <= 2 Then
            grdCarta.Row = 1
            grdCarta.Col = 1
            If grdCarta.CtlText.Trim() = "" Then
                COBISMessageBox.Show("No existen Cartas en esta oficina", "Mensaje de Error", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        End If
        VLFila = grdCarta.Row
        PMMarcarRegistro()
    End Sub

    Private Sub grdCarta_KeyUp(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles grdCarta.KeyUp
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Shift As Integer = eventArgs.KeyData \ &H10000
        grdCarta.Col = 0
        grdCarta.SelStartCol = 1
        grdCarta.SelEndCol = grdCarta.Cols - 1
        If grdCarta.Row = 0 Then
            grdCarta.SelStartRow = 1
            grdCarta.SelEndRow = 1
        Else
            grdCarta.SelStartRow = grdCarta.Row
            grdCarta.SelEndRow = grdCarta.Row
        End If
    End Sub

    Private Sub PLBuscar()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "602")
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "C")
        PMPasoValores(sqlconn, "@i_carta", 0, SQLINT2, "0")
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)

        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_carta_remesas", True, " Ok... Consulta de cartas remesas") Then
            PMMapeaGrid(sqlconn, grdCarta, False)
            PMChequea(sqlconn)
            grdCarta.ColWidth(0) = 800
            grdCarta.ColWidth(1) = 1100
            grdCarta.ColAlignment(1) = 2
            grdCarta.ColWidth(2) = 1500
            grdCarta.ColWidth(3) = 1800
            grdCarta.ColWidth(4) = 1800
            grdCarta.ColWidth(5) = 1800
            grdCarta.ColWidth(6) = 1200
            grdCarta.ColWidth(7) = 1200
            grdCarta.ColWidth(8) = 1300
            grdCarta.ColWidth(9) = 1300

            If CDbl(Convert.ToString(grdCarta.Tag)) = 0 Then
                grdCarta.Row = 1
                grdCarta.Col = 0
                grdCarta.Picture = picVisto(0).Image
            Else
                cmdBoton(0).Enabled = True
                cmdBoton(1).Enabled = True
            End If

            If grdCarta.Rows > 0 Then
                For i As Integer = 1 To grdCarta.Rows - 1
                    grdCarta.Row = i
                    grdCarta.Col = 1
                    If grdCarta.CtlText.Trim() <> "" Then
                        grdCarta.Col = 0
                        grdCarta.CtlText = CStr(grdCarta.Row)
                        grdCarta.Picture = picVisto(0).Image
                    End If
                Next i
            End If
            grdCarta.Col = 0

            If Conversion.Val(Convert.ToString(grdCarta.Tag)) >= 20 Then
                cmdBoton(0).Enabled = True
                VLFila = grdCarta.Rows
            Else
                cmdBoton(0).Enabled = False
            End If
            cmdBoton(1).Enabled = True
            cmdBoton(2).Enabled = True
            TSBImprimir.Enabled = True
            PLTSEstado()

            '  cmdBoton(0).Enabled = Conversion.Val(Convert.ToString(grdCarta.Tag)) >= 20
            '    cmdBoton(1).Enabled = True
            '    cmdBoton(2).Enabled = True
            '    TSBImprimir.Enabled = True
            '    PLTSEstado()
        Else
            PMChequea(sqlconn)
            cmdBoton(2).Enabled = False
            PLTSEstado()
        End If

    End Sub

    Private Sub PLImprimir()
        Try
            'Const IDYES As DialogResult = System.Windows.Forms.DialogResult.Yes
            Dim VTR As DialogResult
            Dim BaseDatos As DAO.Database
            Dim tablas1, tablas2 As DAO.Recordset
            Dim archivos As String = String.Empty
            Dim reportes As String = String.Empty
            Dim VTDesc As String = String.Empty
            Dim VTMsg As String = String.Empty
            If grdCarta.Rows > 1 Then
                grdCarta.Col = 1
                grdCarta.Row = 2
                If grdCarta.CtlText = "" Then
                    Exit Sub
                End If
                Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
                archivos = VGPathResouces & "REMESAS.MDB"
                BaseDatos = DAO_DBEngine_definst.OpenDatabase(archivos)
                tablas1 = BaseDatos.OpenRecordset("re_encabezado")
                tablas2 = BaseDatos.OpenRecordset("re_detalle")
                BaseDatos.Execute("delete from re_detalle")
                BaseDatos.Execute("delete from re_encabezado")
                For i As Integer = 1 To grdCarta.Rows - 1
                    grdCarta.Row = i
                    grdCarta.Col = 0
                    VLFila = i

                    If grdCarta.Picture.Equals(picVisto(0).Image) Then
                        '  If grdCarta.Picture Is Nothing Then
                        tablas1.AddNew()
                        tablas1.Fields("en_oficina").Value = CInt(VGOficina)
                        tablas1.Fields("en_desc_oficina").Value = lblDescripcion(0).Text & " (" & VGOficina & ")"
                        grdCarta.Col = 1
                        tablas1.Fields("en_num_carta").Value = CInt(grdCarta.CtlText)
                        tablas1.Fields("en_fecha").Value = lblDescripcion(1).Text
                        grdCarta.Col = 3
                        tablas1.Fields("en_corresponsal").Value = grdCarta.CtlText
                        grdCarta.Col = 4
                        tablas1.Fields("en_cod_corresponsal").Value = grdCarta.CtlText
                        grdCarta.Col = 8
                        tablas1.Fields("en_destino").Value = grdCarta.CtlText
                        grdCarta.Col = 9
                        If grdCarta.CtlText.Trim() = "N" Then
                            VTDesc = "NEGOCIADA"
                        ElseIf grdCarta.CtlText.Trim() = "C" Then
                            VTDesc = "AL COBRO"
                        Else
                            VTDesc = ""
                        End If
                        tablas1.Fields("en_tipo_remesa").Value = VTDesc

                        grdCarta.Col = 7
                        tablas1.Fields("en_num_cheques").Value = CInt(grdCarta.CtlText)
                        grdCarta.Col = 2
                        tablas1.Fields("en_valor").Value = CDec(grdCarta.CtlText)
                        tablas1.Update()
                        PMCheques(grdficticio)
                        If VLNumeroCheq = 0 Then
                            grdCarta.Row = i
                            grdCarta.Col = 1
                            COBISMessageBox.Show("No existe detalle de cheques: Carta No " & grdCarta.CtlText, "Control de Información", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                            Continue For
                        End If
                        For j As Integer = 1 To (grdficticio.Rows - 1)
                            grdficticio.Row = j
                            grdficticio.Col = 11
                            If grdficticio.CtlText <> "D" Then
                                tablas2.AddNew()
                                tablas2.Fields("de_oficina").Value = CInt(VGOficina)
                                grdficticio.Col = 5
                                tablas2.Fields("de_num_remesa").Value = CInt(grdficticio.CtlText)
                                grdficticio.Col = 2
                                tablas2.Fields("de_cta_deposito").Value = grdficticio.CtlText
                                grdficticio.Col = 1
                                tablas2.Fields("de_cta_girada").Value = grdficticio.CtlText
                                grdficticio.Col = 3
                                tablas2.Fields("de_num_chq_tmp").Value = CInt(grdficticio.CtlText)
                                grdficticio.Col = 4
                                tablas2.Fields("de_valor").Value = CDec(grdficticio.CtlText)
                                grdficticio.Col = 7
                                tablas2.Fields("de_desc_banco").Value = grdficticio.CtlText
                                grdficticio.Col = 8
                                tablas2.Fields("de_num_ciudad_girada").Value = CInt(grdficticio.CtlText)
                                grdficticio.Col = 9
                                tablas2.Fields("de_desc_ciudad_girada").Value = grdficticio.CtlText
                                grdficticio.Col = 10
                                tablas2.Fields("de_departamento").Value = grdficticio.CtlText
                                tablas2.Update()
                            End If
                        Next j
                        tablas2.Close()
                        ' End If
                    End If
                Next i
                tablas1.Close()
                VTMsg = "Asegúrese de que la Impresora se encuentre lista. Desea continuar con la impresión?."
                VTR = COBISMsgBox.MsgBox(VTMsg, 36, "Control de impresión de Datos.")
                If VTR = System.Windows.Forms.DialogResult.Yes Then
                    reportes = VGPathResouces & "\cons_carta_rem_ofi.rpt"
                    rptReporte.ReportFileName = reportes
                    rptReporte.CopiesToPrinter = 1
                    rptReporte.DataFiles(0) = archivos
                    rptReporte.Destination = COBISCorp.Framework.UI.Components.DestinationConstants.crptToPrinter
                    rptReporte.Action = 1
                End If
                Me.Cursor = System.Windows.Forms.Cursors.Default
                BaseDatos.Close()
            Else
                COBISMessageBox.Show("No existen datos para mostrar", "Control de Información", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                Me.Cursor = System.Windows.Forms.Cursors.Default
            End If
        Catch excep As System.Exception
            COBISMessageBox.Show("Error en la Impresión del Reporte " & excep.Message, "Mensaje de Error", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Me.Cursor = System.Windows.Forms.Cursors.Default
            Exit Sub
        End Try
    End Sub

    Private Sub PLSiguiente()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "602")
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "C")
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
        VLFila = grdCarta.Rows
        grdCarta.Row = VLFila
        grdCarta.Col = 1
        PMPasoValores(sqlconn, "@i_carta", 0, SQLVARCHAR, grdCarta.CtlText)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_carta_remesas", True, " Ok... Consulta de cartas remesas") Then
            PMMapeaGrid(sqlconn, grdCarta, True)
            PMChequea(sqlconn)
            grdCarta.ColWidth(0) = 800
            grdCarta.ColWidth(1) = 1100
            grdCarta.ColAlignment(1) = 2
            grdCarta.ColWidth(2) = 1500
            grdCarta.ColWidth(3) = 1800
            grdCarta.ColWidth(4) = 1800
            grdCarta.ColWidth(5) = 1800
            grdCarta.ColWidth(6) = 1200
            grdCarta.ColWidth(7) = 1200
            grdCarta.ColWidth(8) = 1300
            grdCarta.ColWidth(9) = 1300
            If CDbl(Convert.ToString(grdCarta.Tag)) = 0 Then
                grdCarta.Row = 1
                grdCarta.Col = 0
                grdCarta.Picture = picVisto(0).Image
            Else
                cmdBoton(0).Enabled = True
                cmdBoton(1).Enabled = True
            End If
            If grdCarta.Rows > 0 Then
                For i As Integer = 1 To grdCarta.Rows - 1
                    grdCarta.Row = i
                    grdCarta.Col = 1
                    If grdCarta.CtlText.Trim() <> "" Then
                        grdCarta.Col = 0
                        grdCarta.CtlText = CStr(grdCarta.Row)
                        grdCarta.Picture = picVisto(0).Image
                    End If
                Next i
            End If
            If Conversion.Val(Convert.ToString(grdCarta.Tag)) >= 20 Then
                cmdBoton(0).Enabled = True
            Else
                cmdBoton(0).Enabled = False
            End If
            cmdBoton(1).Enabled = True
            cmdBoton(2).Enabled = True
            TSBImprimir.Enabled = True
            PLTSEstado()

            '  cmdBoton(0).Enabled = Conversion.Val(Convert.ToString(grdCarta.Tag)) >= 20
        Else
            PMChequea(sqlconn)
            cmdBoton(2).Enabled = False
            PLTSEstado()

        End If

    End Sub

    Private Sub PMCheques(ByRef grdInterno As Object)
        Dim VTAcumulaGrid As Integer = 0
        Dim VTNumero As Integer = 20
        PMLimpiaGrid(grdInterno)
        While VTNumero >= 20
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "602")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "D")
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
            grdCarta.Row = VLFila
            grdCarta.Col = 1
            PMPasoValores(sqlconn, "@i_carta", 0, SQLINT2, grdCarta.CtlText)
            If grdInterno.Rows > 2 Then
                grdInterno.Col = 5
                If grdInterno.Text <> "" Then
                    PMPasoValores(sqlconn, "@i_nref", 0, SQLINT4, grdInterno.Text)
                    VTAcumulaGrid = True
                Else
                    PMPasoValores(sqlconn, "@i_nref", 0, SQLINT4, "0")
                    VTAcumulaGrid = False
                End If
            Else
                PMPasoValores(sqlconn, "@i_nref", 0, SQLINT4, "0")
            End If
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_carta_remesas", True, " Ok... Consulta de cartas remesas") Then
                PMMapeaGrid(sqlconn, grdInterno, VTAcumulaGrid)
                PMChequea(sqlconn)
                cmdBoton(2).Enabled = True
                VTNumero = Conversion.Val(Convert.ToString(grdInterno.Tag))
                grdInterno.row = 1
                grdInterno.col = 1
                If grdInterno.CtlText = "" Then
                    VLNumeroCheq = 0
                Else
                    VLNumeroCheq = VTNumero
                End If
            Else
                PMChequea(sqlconn)
                VTNumero = 0
                VLNumeroCheq = 0
                cmdBoton(2).Enabled = False
            End If
        End While

    End Sub

    Private Sub PMMarcarRegistro()
        grdCarta.Col = 0
        If Not grdCarta.Picture.Equals(picVisto(0).Image) Then
            grdCarta.CtlText = CStr(grdCarta.Row)
            grdCarta.Picture = picVisto(0).Image
        Else
            grdCarta.CtlText = CStr(grdCarta.Row)
            grdCarta.Picture = picVisto(1).Image
        End If

    End Sub

    Private Sub txtCarta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCarta.Leave
        If txtCarta.Text <> "" Then
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtCarta.Text)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCarta.Text & "]") Then
                PMMapeaObjeto(sqlconn, lblDescripcion(0))
                PMChequea(sqlconn)
                txtCarta.Enabled = False
            Else
                VLPaso = True
                txtCarta.Enabled = True
                PMChequea(sqlconn)
                txtCarta.Text = ""
                lblDescripcion(0).Text = ""
                COBISMessageBox.Show("El código de la Oficina no existe", "Mensaje de Error", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        Else
            lblDescripcion(0).Text = ""
        End If
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

End Class


