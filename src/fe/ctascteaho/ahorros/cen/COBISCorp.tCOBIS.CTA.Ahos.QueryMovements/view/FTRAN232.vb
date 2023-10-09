Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Imports COBISCorp.tCOBIS.CTA.Ahos.AccountsAdmCatalogs
Partial Public Class FTran232Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLTranDiario As Integer = 0
    Dim VLSecuencial As String = ""
    Dim VLSecAlterno As String = ""
    Dim VLhora As String = ""
    Dim VLImpresion() As MODGLB.VGLineaImp = Nothing
    Dim VLColumnas As Integer = 0
    Dim VLOrdenColImp(17) As Integer
    Dim VLLin As Integer = 0
    Dim Flag As Boolean = False
    Dim VLTarjeta As String = ""
    Dim VLPaso As Boolean = False
    Dim VLPaso2 As Boolean = False

    Private Sub PLDetalleMovimiento()
        Dim VTArreglo() As String
        Dim archivos As String = ""
        Dim reporte As String = ""
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "232")
        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
        grdEstado.Col = 1
        Dim VTFDesde As String = FMConvFecha(grdEstado.CtlText, VGFormatoFecha, CGFormatoBase)
        PMPasoValores(sqlconn, "@i_fchdsde", 0, SQLDATETIME, VTFDesde)
        PMPasoValores(sqlconn, "@i_fchhsta", 0, SQLDATETIME, VTFDesde)
        grdEstado.Col = 13
        PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, grdEstado.CtlText.Trim())
        grdEstado.Col = 17
        PMPasoValores(sqlconn, "@i_sec_alt", 0, SQLINT2, grdEstado.CtlText)
        PMPasoValores(sqlconn, "@i_diario", 0, SQLINT1, "0")
        PMPasoValores(sqlconn, "@i_frontn", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "M")
        PMPasoValores(sqlconn, "@o_hist", 1, SQLINT1, "0")
        Dim baseDatoss As DAO.Database
        Dim tablas1 As DAO.Recordset
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_ahcoestcta", True, FMLoadResString(503188)) Then
            ReDim VTArreglo(10)
            FMMapeaArreglo(sqlconn, VTArreglo)
            PMChequea(sqlconn)
            Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
            archivos = VGPath & "\solicitu.mdb"
            baseDatoss = DAO_DBEngine_definst.OpenDatabase(archivos)
            tablas1 = baseDatoss.OpenRecordset("detmovimiento")
            baseDatoss.Execute("delete from detmovimiento")
            tablas1.AddNew()
            tablas1.Fields("titulo").Value = FMLoadResString(503189)
            grdEstado.Col = 2
            tablas1.Fields("subtitulo").Value = grdEstado.CtlText
            tablas1.Fields("cuenta").Value = mskCuenta.Text
            grdEstado.Col = 1
            tablas1.Fields("fecha").Value = grdEstado.CtlText
            tablas1.Fields("efectivo").Value = VTArreglo(1)
            tablas1.Fields("chqpropios").Value = VTArreglo(2)
            tablas1.Fields("chqlocales").Value = VTArreglo(3)
            tablas1.Fields("chqexterior").Value = VTArreglo(4)
            grdEstado.Col = 3
            If grdEstado.CtlText.Trim() <> "" Then
                tablas1.Fields("monto").Value = grdEstado.CtlText
            Else
                grdEstado.Col = 4
                tablas1.Fields("total").Value = grdEstado.CtlText
            End If
            tablas1.Fields("cliente").Value = lblDescripcion(0).Text
            tablas1.Update()
            reporte = VGPath & "\DETMOVIMIENTO.rpt"
            rptReporte.ReportFileName = reporte
            rptReporte.DataFiles(0) = archivos
            rptReporte.Destination = COBISCorp.Framework.UI.Components.DestinationConstants.crptToWindow
            rptReporte.Action = 1
            tablas1.Close()
            baseDatoss.Close()
            Me.Cursor = System.Windows.Forms.Cursors.Default
        Else
            PMChequea(sqlconn)
            Exit Sub
        End If
    End Sub


    Private Sub FTran232_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        Me.Left = 0
        Me.Top = 0
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub PLInicializar()
        MyAppGlobals.AppActiveForm = ""
        Me.Text = FMLoadResString(3075)
        For i As Integer = 0 To 1
            mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
            mskValor(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)            
            mskValor(i).DateType = PLFormatoFecha()
            mskValor(i).Connection = VGMap
        Next i
        CargaParametros("1579", "Q", "3", "AHO", "OCUCOL", 3)
        mskCuenta.Mask = VGMascaraCtaAho
        Dim eventSender As Object = Nothing
        Dim eventArgs As EventArgs = Nothing
        mskCuenta_Leave(eventSender, eventArgs)

    End Sub

    Private Sub FTran232_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_5.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTTipo As String = String.Empty
        Dim VTFDesde As String = String.Empty
        Dim VTFHasta As String = String.Empty
        Dim VTR As DialogResult
        Dim VTFono As String = ""
        Dim VTalianza As String = ""
        Dim VTdesalianza As String = ""
        Dim VTResult As String = ""
        Dim VTRecepGrid As String = ""
        Dim j As Integer = 0
        Dim VLTotalDebitos As Decimal = 0
        Dim VLTotalCreditos As Decimal = 0
        Dim VTMatriz(,) As String

        Select Case Index
            Case 0
                TSBotones.Focus()
                If VLPaso = True Then Exit Sub

                If mskCuenta.ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(501854), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                    Exit Sub
                End If
                If mskValor(0).ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500387), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskValor(0).Focus()
                    Exit Sub
                End If
                If mskValor(1).ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500388), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskValor(1).Focus()
                    Exit Sub
                End If
                PMLimpiaGrid(grdEstado)
                grdEstado.FixedCols = 1
                grdEstado.FixedRows = 1
                grdEstado.Cols = 18
                grdEstado.Row = 0
                grdEstado.ColWidth(1) = 750
                grdEstado.ColWidth(2) = 2000
                grdEstado.ColWidth(3) = 1200
                grdEstado.ColWidth(4) = 1200
                If VGCodPais <> "CO" Then
                    grdEstado.ColWidth(5) = 1200
                    grdEstado.ColWidth(6) = 1200
                    grdEstado.ColWidth(7) = 1000
                    grdEstado.ColWidth(8) = 1200
                    grdEstado.ColWidth(9) = 800
                    grdEstado.ColWidth(10) = 1200
                    grdEstado.ColWidth(11) = 1200
                    grdEstado.ColWidth(12) = 1600
                    grdEstado.ColWidth(13) = 1600
                    grdEstado.ColWidth(15) = 1
                Else
                    If VGOcucol = "S" Then
                        grdEstado.ColIsVisible(5) = False
                    End If
                    grdEstado.ColWidth(5) = 800
                    grdEstado.ColWidth(6) = 800
                    grdEstado.ColWidth(7) = 1200
                    grdEstado.ColWidth(8) = 1200
                    grdEstado.ColWidth(9) = 1000
                    grdEstado.ColWidth(10) = 1200
                    grdEstado.ColWidth(11) = 800
                    grdEstado.ColWidth(12) = 1200
                    grdEstado.ColWidth(13) = 1000
                    grdEstado.ColWidth(14) = 1200
                    grdEstado.ColWidth(15) = 1600
                    grdEstado.ColWidth(16) = 1600
                    grdEstado.ColWidth(17) = 1
                End If
                grdEstado.ColAlignment(2) = 0
                grdEstado.ColAlignment(3) = 1
                grdEstado.ColAlignment(4) = 1
                grdEstado.ColAlignment(5) = 1
                grdEstado.ColAlignment(6) = 1
                grdEstado.ColAlignment(7) = 1
                grdEstado.ColAlignment(8) = 1
                grdEstado.ColAlignment(9) = 1
                grdEstado.ColAlignment(10) = 1
                grdEstado.ColAlignment(11) = 1
                grdEstado.Col = 1
                grdEstado.CtlText = FMLoadResString(9002)
                grdEstado.Col = 2
                grdEstado.CtlText = FMLoadResString(503196)
                grdEstado.Col = 3
                grdEstado.CtlText = FMLoadResString(502653)
                grdEstado.Col = 4
                grdEstado.CtlText = FMLoadResString(502652)
                If VGCodPais <> "CO" Then
                    grdEstado.Col = 5
                    grdEstado.CtlText = FMLoadResString(503199)
                    grdEstado.Col = 6
                    grdEstado.CtlText = FMLoadResString(503200)
                    grdEstado.Col = 7
                    grdEstado.CtlText = FMLoadResString(503201) & " "
                    grdEstado.Col = 8
                    grdEstado.CtlText = FMLoadResString(503202)
                    grdEstado.Col = 9
                    grdEstado.CtlText = FMLoadResString(503203)
                    grdEstado.Col = 10
                    grdEstado.CtlText = FMLoadResString(5032034)
                    grdEstado.Col = 11
                    grdEstado.CtlText = FMLoadResString(9025)
                    grdEstado.Col = 12
                    grdEstado.CtlText = FMLoadResString(503205)
                    grdEstado.Col = 13
                    grdEstado.CtlText = FMLoadResString(9003) & " "
                    grdEstado.Col = 14
                    grdEstado.CtlText = FMLoadResString(9932)
                    grdEstado.Col = 15
                    grdEstado.CtlText = FMLoadResString(503206)
                Else
                    grdEstado.Col = 5
                    grdEstado.CtlText = FMLoadResString(503207)
                    grdEstado.Col = 6
                    grdEstado.CtlText = FMLoadResString(503208)
                    grdEstado.Col = 7
                    grdEstado.CtlText = FMLoadResString(503209)
                    grdEstado.Col = 8
                    grdEstado.CtlText = FMLoadResString(503210)
                    grdEstado.Col = 9
                    grdEstado.CtlText = FMLoadResString(503211) & " "
                    grdEstado.Col = 10
                    grdEstado.CtlText = FMLoadResString(503212)
                    grdEstado.Col = 11
                    grdEstado.CtlText = FMLoadResString(503203)
                    grdEstado.Col = 12
                    grdEstado.CtlText = FMLoadResString(503204)
                    grdEstado.Col = 13
                    grdEstado.CtlText = FMLoadResString(9025)
                    grdEstado.Col = 14
                    grdEstado.CtlText = FMLoadResString(503205)
                    grdEstado.Col = 15
                    grdEstado.CtlText = FMLoadResString(9003) & " "
                    grdEstado.Col = 16
                    grdEstado.CtlText = FMLoadResString(9932)
                    grdEstado.Col = 17
                    grdEstado.CtlText = FMLoadResString(503206)
                End If
                ReDim VTMatriz(210, 210)
                Dim VTArregloCab(50) As String
                VLTranDiario = 0
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "232")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                VTFDesde = FMConvFecha(mskValor(0).Text, VGFormatoFecha, CGFormatoBase)
                PMPasoValores(sqlconn, "@i_fchdsde", 0, SQLDATETIME, VTFDesde)
                VTFHasta = FMConvFecha(mskValor(1).Text, VGFormatoFecha, CGFormatoBase)
                PMPasoValores(sqlconn, "@i_fchhsta", 0, SQLDATETIME, VTFHasta)
                PMPasoValores(sqlconn, "@i_sec", 0, SQLINT2, "0")
                PMPasoValores(sqlconn, "@i_sec_alt", 0, SQLINT4, "-1")
                PMPasoValores(sqlconn, "@i_hora", 0, SQLDATETIME, "01/01/1900 12:00AM")
                PMPasoValores(sqlconn, "@i_diario", 0, SQLINT1, Conversion.Str(VLTranDiario))
                PMPasoValores(sqlconn, "@i_frontn", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                If VGCodPais = "CO" Then
                    VTR = COBISMessageBox.Show(FMLoadResString(2257), FMLoadResString(500092), COBISMessageBox.COBISButtons.YesNo)
                    If VTR = System.Windows.Forms.DialogResult.Yes Then
                        PMPasoValores(sqlconn, "@i_escliente", 0, SQLCHAR, "S")
                        Flag = True
                    Else
                        PMPasoValores(sqlconn, "@i_escliente", 0, SQLCHAR, "N")
                        Flag = False
                    End If
                End If
                PMPasoValores(sqlconn, "@o_hist", 1, SQLINT1, "0")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_ahcoestcta", True, FMLoadResString(503217)) Then
                    FMMapeaArreglo(sqlconn, VTArregloCab)
                    PMMapeaVariable(sqlconn, VTFono)
                    PMMapeaVariable(sqlconn, VTalianza)
                    PMMapeaVariable(sqlconn, VTdesalianza)
                    VTResult = CStr(FMMapeaMatriz(sqlconn, VTMatriz))
                    PMChequea(sqlconn)
                    VLTranDiario = Conversion.Val(FMRetParam(sqlconn, 1))
                    For i As Integer = 1 To CInt(VTResult)
                        VTRecepGrid = ""
                        grdEstado.Row = grdEstado.Rows - 1
                        grdEstado.Col = 0
                        VTRecepGrid = Conversion.Str(Conversion.Val(grdEstado.CtlText) + 1) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(0, i) & Strings.Chr(9).ToString()
                        If VTMatriz(3, i) = "S" Then
                            VTRecepGrid = VTRecepGrid & "Corr-" & VTMatriz(4, i) & Strings.Chr(9).ToString()
                        Else
                            VTRecepGrid = VTRecepGrid & VTMatriz(4, i) & Strings.Chr(9).ToString()
                        End If
                        If VTMatriz(5, i) = "D" Then
                            VTRecepGrid = VTRecepGrid & VTMatriz(6, i) & Strings.Chr(9).ToString() & " " & Strings.Chr(9).ToString()
                        Else
                            VTRecepGrid = VTRecepGrid & " " & Strings.Chr(9).ToString() & VTMatriz(6, i) & Strings.Chr(9).ToString()
                        End If
                        VLSecuencial = VTMatriz(18, i)
                        VLSecAlterno = VTMatriz(12, i)
                        VLhora = VTMatriz(16, i)
                        VTRecepGrid = VTRecepGrid & VTMatriz(20, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(19, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(8, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(9, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(7, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(11, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(2, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(10, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(18, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(15, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(16, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(17, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(12, i)
                        grdEstado.AddItem(VTRecepGrid)
                    Next i
                    lblDescripcion(1).Text = VTArregloCab(1)
                    lblDescripcion(2).Text = VTArregloCab(2)
                    lblDescripcion(4).Text = VTArregloCab(3)
                    lblDescripcion(5).Text = VTArregloCab(4)
                    lblDescripcion(3).Text = VTArregloCab(5)
                    lblDescripcion(6).Text = VTArregloCab(6)
                    lblDescripcion(7).Text = VTArregloCab(7)
                    lblDescripcion(8).Text = VTArregloCab(9)
                    lblDescripcion(9).Text = VTArregloCab(8)
                    lblDescripcion(10).Text = VTFono
                    Lblalianza.Text = VTalianza
                    lbldesalianza.Text = VTdesalianza
                    lblDescripcion(11).Text = VTArregloCab(10)
                    lblDescripcion(12).Text = VTArregloCab(11)
                    If VLTranDiario = 1 Then
                        VLSecuencial = "0"
                        VLSecAlterno = "0"
                        VLhora = "01/01/1900 12:00AM"
                        cmdBoton_Click(cmdBoton(3), New EventArgs())
                    End If
                    cmdBoton(3).Enabled = Not (VLTranDiario = 3)
                    mskCuenta.Enabled = False
                    mskValor(0).Enabled = False
                    mskValor(1).Enabled = False
                    cmdBoton(5).Enabled = True 'Imprimir
                    cmdBoton(7).Enabled = True 'Excel
                    If grdEstado.Rows > 2 Then
                        grdEstado.RemoveItem(1)
                    End If
                Else
                    PMChequea(sqlconn)
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "747")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "Q")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_relacion_cta_canal", True, FMLoadResString(509057)) Then
                    PMMapeaVariable(sqlconn, VLTarjeta)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    Exit Sub
                End If
                If VLTarjeta = "S" Then
                    optTarjetaDebito(0).Checked = True
                Else
                    optTarjetaDebito(1).Checked = True
                End If
            Case 1
                mskValor(0).Enabled = True
                mskValor(1).Enabled = True
                For i As Integer = 0 To 1
                    mskValor(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
                    mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
                Next i
                For i As Integer = 1 To 12
                    lblDescripcion(i).Text = ""
                Next i
                PMLimpiaGrid(grdEstado)
                cmdBoton(4).Enabled = False
                cmdBoton(3).Enabled = False
                cmdBoton(5).Enabled = False 'Imprimir
                cmdBoton(7).Enabled = False 'Excel
                Lblalianza.Text = ""
                lbldesalianza.Text = ""
                mskValor(0).Focus()
            Case 2
                VLPaso2 = True
                Me.Close()
            Case 3
                If mskCuenta.ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(501854), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                    Exit Sub
                End If
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
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "232")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                VTFDesde = FMConvFecha(mskValor(0).Text, VGFormatoFecha, CGFormatoBase)
                PMPasoValores(sqlconn, "@i_fchdsde", 0, SQLDATETIME, VTFDesde)
                VTFHasta = FMConvFecha(mskValor(1).Text, VGFormatoFecha, CGFormatoBase)
                PMPasoValores(sqlconn, "@i_fchhsta", 0, SQLDATETIME, VTFHasta)
                PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, VLSecuencial)
                PMPasoValores(sqlconn, "@i_sec_alt", 0, SQLINT4, VLSecAlterno)
                PMPasoValores(sqlconn, "@i_hora", 0, SQLDATETIME, VLhora)
                PMPasoValores(sqlconn, "@i_diario", 0, SQLINT1, Conversion.Str(VLTranDiario))
                PMPasoValores(sqlconn, "@i_frontn", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                PMPasoValores(sqlconn, "@o_hist", 1, SQLINT1, "0")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_ahcoestcta", True, FMLoadResString(503220)) Then
                    ReDim VTMatriz(210, 210)
                    VTResult = CStr(FMMapeaMatriz(sqlconn, VTMatriz))
                    PMChequea(sqlconn)
                    VLTranDiario = Conversion.Val(FMRetParam(sqlconn, 1))
                    For i As Integer = 1 To CInt(VTResult)
                        VTRecepGrid = ""
                        grdEstado.Row = grdEstado.Rows - 1
                        grdEstado.Col = 0
                        VTRecepGrid = Conversion.Str(Conversion.Val(grdEstado.CtlText) + 1) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(0, i) & Strings.Chr(9).ToString()
                        If VTMatriz(3, i) = "S" Then
                            VTRecepGrid = VTRecepGrid & "Corr-" & VTMatriz(4, i) & Strings.Chr(9).ToString()
                        Else
                            VTRecepGrid = VTRecepGrid & VTMatriz(4, i) & Strings.Chr(9).ToString()
                        End If
                        If VTMatriz(5, i) = "D" Then
                            VTRecepGrid = VTRecepGrid & VTMatriz(6, i) & Strings.Chr(9).ToString() & " " & Strings.Chr(9).ToString()
                        Else
                            VTRecepGrid = VTRecepGrid & " " & Strings.Chr(9).ToString() & VTMatriz(6, i) & Strings.Chr(9).ToString()
                        End If
                        VLSecuencial = VTMatriz(18, i)
                        VLSecAlterno = VTMatriz(12, i)
                        VLhora = VTMatriz(16, i)
                        VTRecepGrid = VTRecepGrid & VTMatriz(20, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(19, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(8, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(9, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(7, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(11, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(2, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(10, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(18, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(15, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(16, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(17, i) & Strings.Chr(9).ToString()
                        VTRecepGrid = VTRecepGrid & VTMatriz(12, i)
                        grdEstado.AddItem(VTRecepGrid)
                    Next i
                    mskValor(0).Enabled = False
                    mskValor(1).Enabled = False
                    VLTotalDebitos = 0
                    VLTotalCreditos = 0
                    If VLTranDiario = 1 Then
                        VLSecuencial = "0"
                        VLSecAlterno = "0"
                        VLhora = "01/01/1900 12:00AM"
                    End If
                    If VLTranDiario = 3 Then
                        For i As Integer = 1 To grdEstado.Rows - 1
                            VTTipo = "D"
                            j = 3
                            grdEstado.Row = i
                            grdEstado.Col = j
                            If grdEstado.CtlText <> "" And grdEstado.CtlText <> " " Then
                                VLTotalDebitos += Conversion.Val(CStr(CDec(grdEstado.CtlText)))
                            Else
                                VLTotalDebitos = VLTotalDebitos
                            End If
                            j = 4
                            grdEstado.Row = i
                            grdEstado.Col = j
                            If grdEstado.CtlText <> "" And grdEstado.CtlText <> " " Then
                                VTTipo = "C"
                                VLTotalCreditos += Conversion.Val(CStr(CDec(grdEstado.CtlText)))
                            Else
                                VLTotalCreditos = VLTotalCreditos
                            End If
                            If VGCodPais = "CO" Then
                                j = 5
                                grdEstado.Row = i
                                grdEstado.Col = j
                                If grdEstado.CtlText <> "" And grdEstado.CtlText <> " " Then
                                    If VTTipo = "D" Then VLTotalDebitos += Conversion.Val(CStr(CDec(grdEstado.CtlText)))
                                    If VTTipo = "C" Then VLTotalCreditos += Conversion.Val(CStr(CDec(grdEstado.CtlText)))
                                Else
                                    VLTotalDebitos = VLTotalDebitos
                                End If
                                j = 6
                                grdEstado.Row = i
                                grdEstado.Col = j
                                If grdEstado.CtlText <> "" And grdEstado.CtlText <> " " Then
                                    If VTTipo = "D" Then VLTotalDebitos += Conversion.Val(CStr(CDec(grdEstado.CtlText)))
                                    If VTTipo = "C" Then VLTotalCreditos += Conversion.Val(CStr(CDec(grdEstado.CtlText)))
                                Else
                                    VLTotalDebitos = VLTotalDebitos
                                End If
                            End If
                        Next i
                        grdEstado.Rows += 2
                        grdEstado.Row = grdEstado.Rows - 1
                        grdEstado.Col = 1
                        grdEstado.CtlText = FMLoadResString(503221)
                        grdEstado.Col = 3
                        grdEstado.CtlText = StringsHelper.Format(VLTotalDebitos, "#,##0.00")
                        grdEstado.Col = 4
                        grdEstado.CtlText = StringsHelper.Format(VLTotalCreditos, "#,##0.00")
                        cmdBoton(3).Enabled = False
                    End If
                Else
                    PMChequea(sqlconn)
                End If
            Case 4
                If mskCuenta.ClipText <> "" Then
                    ReDim VGADatosI(3)
                    VGADatosI(1) = mskCuenta.ClipText
                    VGADatosI(2) = "AHO"
                    VGADatosI(3) = "0"
                    FImagenes.Text = FMLoadResString(502403) & mskCuenta.Text & "]"
                    FImagenes.ShowPopup(Me)
                    FImagenes.Dispose()
                Else
                    COBISMessageBox.Show(FMLoadResString(500792), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                End If
            Case 5
                PLImprimir()
            Case 7
                PLGeneraDatosExcel(grdEstado)
        End Select
        PMAnchoColumnasGrid(grdEstado)
        PLTSEstado()
    End Sub

    Private Sub PLGeneraDatosExcel(ByRef grilla As COBISCorp.Framework.UI.Components.COBISGrid)
        Dim XlsApl As Excel.Application
        Dim xlsLibro As Excel.Workbook
        Dim xlhoja As Excel.Worksheet
        Dim colOcucol As Integer = -1
        Dim bandOcucol As Integer = 0

        grdEstado.Row = 1
        grdEstado.Col = 1
        If grdEstado.CtlText <> "" Then
            XlsApl = New Excel.Application()
            XlsApl.Visible = True
            XlsApl.Caption = FMLoadResString(3075)
            XlsApl.Workbooks.Add()
            xlsLibro = XlsApl.ActiveWorkbook
            xlhoja = xlsLibro.Worksheets.Add()
            xlhoja.Name = FMLoadResString(1104)

            For Fil As Integer = 0 To grilla.Rows - 1
                grilla.Row = Fil
                For Col As Integer = 1 To grilla.Cols - 1
                    grilla.Col = Col
                    If grilla.CtlText.ToUpper().ToString().Trim = FMLoadResString(503207).ToUpper().ToString().Trim And
                        VGOcucol = "S" Then
                        colOcucol = Col
                    End If
                    If colOcucol <> Col Or VGOcucol <> "S" Then
                        xlsLibro.Worksheets(FMLoadResString(1104)).Cells(Fil + 1, Col - bandOcucol).NumberFormat = "@"
                        xlsLibro.Worksheets(FMLoadResString(1104)).Cells(Fil + 1, Col - bandOcucol).Value2 =
                            grilla.CtlText.ToUpper().ToString()
                    Else
                        bandOcucol = bandOcucol + 1
                    End If
                Next
                bandOcucol = 0
                If Fil = 0 Then
                    xlsLibro.Worksheets(FMLoadResString(1104)).Rows("1:1", Type.Missing).Select()
                    XlsApl.Selection.Interior.ColorIndex = 37
                    XlsApl.Selection.Interior.Pattern = Excel.Constants.xlSolid
                    XlsApl.Selection.Font.Bold = True
                    XlsApl.Selection.Borders(Excel.XlBordersIndex.xlInsideVertical).LineStyle = Excel.Constants.xlNone
                    XlsApl.Cells.Select()
                    XlsApl.Range("E1").Activate()
                    XlsApl.Cells.EntireColumn.AutoFit()
                End If
            Next
            XlsApl.Selection.Borders(Excel.XlBordersIndex.xlInsideVertical).LineStyle = Excel.Constants.xlNone
            XlsApl.Cells.Select()
            XlsApl.Range("E1").Activate()
            XlsApl.Cells.EntireColumn.AutoFit()
        Else
            COBISMessageBox.Show(FMLoadResString(500879), FMLoadResString(500880), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            Me.Cursor = System.Windows.Forms.Cursors.Default
            Exit Sub
        End If
    End Sub

    Private Sub grdEstado_ClickEvent(sender As Object, e As EventArgs) Handles grdEstado.ClickEvent
        PMMarcaFilaCobisGrid(grdEstado, grdEstado.Row)
    End Sub

    Private Sub grdEstado_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdEstado.DblClick
        PMMarcaFilaCobisGrid(grdEstado, grdEstado.Row)
        If grdEstado.Rows > 1 And grdEstado.CtlText <> "" Then
            PLDetalle()
        End If
    End Sub

    Public Sub PLDetalle()
        Dim subtitulo As String = ""
        Dim nota As String = ""
        Dim monto As String = ""
        grdEstado.Col = 2
        Dim ndc As String = Strings.Mid(grdEstado.CtlText, 1, 3)
        Select Case ndc
            Case "N/D"
                nota = FMLoadResString(503224)
                subtitulo = FMLoadResString(502446)
                grdEstado.Col = 3
                monto = grdEstado.CtlText
            Case "N/C"
                nota = FMLoadResString(503225)
                subtitulo = FMLoadResString(502447)
                grdEstado.Col = 4
                monto = grdEstado.CtlText
            Case "DEP"
                PLDetalleMovimiento()
                Exit Sub
            Case Else
                Exit Sub
        End Select
        Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
        Dim archivos As String = VGPath & "\solicitu.mdb"
        Dim baseDatoss As DAO.Database = DAO_DBEngine_definst.OpenDatabase(archivos)
        Dim tablas1 As DAO.Recordset = baseDatoss.OpenRecordset("detndnc")
        baseDatoss.Execute("delete from detndnc")
        tablas1.AddNew()
        tablas1.Fields("titulo").Value = nota
        tablas1.Fields("subtitulo").Value = subtitulo
        tablas1.Fields("cuenta").Value = mskCuenta.Text
        grdEstado.Col = 1
        tablas1.Fields("fecha").Value = grdEstado.CtlText
        tablas1.Fields("monto").Value = monto
        grdEstado.Col = 2
        tablas1.Fields("descripcion").Value = grdEstado.CtlText
        tablas1.Fields("cliente").Value = lblDescripcion(0).Text
        tablas1.Fields("retener").Value = lblDescripcion(5).Text
        tablas1.Update()
        Dim reporte As String = VGPath & "\DETNDNC.rpt"
        rptReporte.ReportFileName = reporte
        rptReporte.DataFiles(0) = archivos
        'WTO rptReporte.PageZoom(75)
        rptReporte.Destination = COBISCorp.Framework.UI.Components.DestinationConstants.crptToWindow
        rptReporte.Action = 1
        tablas1.Close()
        baseDatoss.Close()
        Me.Cursor = System.Windows.Forms.Cursors.Default
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500659))
        ' COBISCorp.eCOBIS.COBISExplorer.Cntainer.COBISContainer.ShowHelpLine(" Número de la cuenta de ahorros")
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
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(502522) & " " & "[" & mskCuenta.Text & "]") Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(0))
                        PMChequea(sqlconn)
                        cmdBoton(4).Enabled = True
                    Else
                        PMChequea(sqlconn) 'JSA
                        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                        lblDescripcion(0).Text = ""
                        mskCuenta.Focus()
                        Exit Sub
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                    lblDescripcion(0).Text = ""
                    mskCuenta.Focus()
                    Exit Sub
                End If
            End If
        Catch exc As System.Exception
            'NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
            COBISMessageBox.Show(exc.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End Try
        PLTSEstado()
    End Sub

    Private Sub mskValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskValor_1.Enter, _mskValor_0.Enter
        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500410) & VGFormatoFecha & "]")
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500359) & VGFormatoFecha & "]")
        End Select
        mskValor(Index).SelectionStart = 0
        mskValor(Index).SelectionLength = Strings.Len(mskValor(Index).Text)
    End Sub

    Private Sub mskValor_KeyPressEvent(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _mskValor_1.KeyPress, _mskValor_0.KeyPress
        If (Asc(eventArgs.KeyChar) <> 8) And ((Asc(eventArgs.KeyChar) < 48) Or (Asc(eventArgs.KeyChar) > 57)) Then
            eventArgs.KeyChar = Chr(0)
        End If
    End Sub

    Private Sub mskValor_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskValor_1.Leave, _mskValor_0.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
        Try
            Dim VTValido As Integer = 0
            Dim VTDias As Integer = 0

            If VLPaso2 = True Then Exit Sub

            Select Case Index
                Case 0, 1
                    If mskValor(Index).ClipText <> "" Then
                        VTValido = FMVerFormato(mskValor(Index).Text, VGFormatoFecha)
                        If Not VTValido Then
                            COBISMessageBox.Show(FMLoadResString(500360), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                            mskValor(Index).Focus()
                            VLPaso = True
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
                            VLPaso = True
                            Exit Sub
                        End If
                        If FMDateDiff("d", mskValor(1).Text, VGFechaProceso, VGFormatoFecha) < 0 Then
                            COBISMessageBox.Show(FMLoadResString(500711), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                            mskValor(Index).Focus()
                            VLPaso = True
                            Exit Sub
                        End If
                    End If
            End Select
            VLPaso = False
        Catch exc As System.Exception
            'NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
            COBISMessageBox.Show(exc.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
        End Try
    End Sub

    Private Sub PLImprimir()
        Try
            Dim VTTotalTrn As Integer = 0
            Dim VTRow As Integer = 0
            Dim VTTotal As Integer = 0
            Dim VTOffset As Integer = 0
            Dim VTDatos As String = ""
            grdEstado.Row = 1
            grdEstado.Col = 1
            VTTotalTrn = 0
            If grdEstado.CtlText <> "" Then
                If Not FMSeleccionarPrinter() Then Exit Sub
                Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
                PLOrdenColImp()
                PLCabecera()
                For i As Integer = 1 To grdEstado.Rows - 1
                    grdEstado.Row = i
                    VTRow = grdEstado.Row
                    If VLLin > 86 Then
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print()
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(14), FMLoadResString(503231) & " ", FileSystem.TAB(35), Conversion.Str(VTTotal))
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print()
                        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.NewPage()
                        PLCabecera()
                    End If
                    VTOffset = 6
                    grdEstado.Row = VTRow
                    For j As Integer = 1 To VLColumnas
                        grdEstado.Col = VLImpresion(j).col
                        VTDatos = Strings.Left(grdEstado.CtlText, VLImpresion(j).length)
                        VTOffset += VLImpresion(j).length
                        If j = 1 Then
                            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(6), Strings.Left(VTDatos, VLImpresion(j).length - 1), FileSystem.TAB(VTOffset))
                        Else
                            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(Strings.Left(VTDatos, VLImpresion(j).length - 1), FileSystem.TAB(VTOffset))
                        End If
                    Next j
                    COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print()
                    grdEstado.Col = 0
                    If grdEstado.CtlText.Trim() <> "" Then
                        VTTotalTrn += 1
                    End If
                    VLLin += 1
                Next i
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print()
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 8
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(10), FMLoadResString(503232), Conversion.Str(VTTotalTrn))
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = False
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.EndDoc()
                Me.Cursor = System.Windows.Forms.Cursors.Default
            Else
                COBISMessageBox.Show(FMLoadResString(500879), FMLoadResString(500880), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                Me.Cursor = System.Windows.Forms.Cursors.Default
                Exit Sub
            End If
        Catch excep As System.Exception
            COBISMessageBox.Show(excep.Message, FMLoadResString(500881), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Me.Cursor = System.Windows.Forms.Cursors.Default
        End Try
    End Sub

    Private Sub PLOrdenColImp()
        VLOrdenColImp(0) = 0
        VLOrdenColImp(1) = 1
        VLOrdenColImp(2) = 2
        VLOrdenColImp(3) = 3
        VLOrdenColImp(4) = 4
        If VGOcucol = "N" Then
            VLOrdenColImp(5) = 5
        End If
        VLOrdenColImp(6) = 6
        VLOrdenColImp(7) = 7
        VLOrdenColImp(8) = 8
        VLOrdenColImp(9) = 10
        VLOrdenColImp(10) = 11
        VLOrdenColImp(11) = 12
        VLOrdenColImp(12) = 13
        VLOrdenColImp(13) = 13
        VLOrdenColImp(14) = 14
        If VGCodPais = "CO" Then
            VLOrdenColImp(15) = 15
            VLOrdenColImp(16) = 16
            VLColumnas = 10
        Else
            VLColumnas = 14
        End If
    End Sub

    Private Sub PLCabecera()
        Dim VTLen As Integer = 0
        Dim VTTemp As Integer = 2
        ReDim VLImpresion(grdEstado.Cols - 1)
        grdEstado.Row = 0
        Dim j As Integer = 1
        For j = 1 To VLColumnas
            grdEstado.Col = VLOrdenColImp(j)
            VLImpresion(j).Texto = grdEstado.CtlText
            Select Case grdEstado.CtlText.Trim()
                Case FMLoadResString(503196)
                    VTLen = Strings.Len(grdEstado.CtlText) + 22
                Case FMLoadResString(9002)
                    VTLen = Strings.Len(grdEstado.CtlText) + 8
                Case FMLoadResString(9003)
                    VTLen = Strings.Len(grdEstado.CtlText) + 18
                Case FMLoadResString(502653)
                    VTLen = Strings.Len(grdEstado.CtlText) + 9
                Case FMLoadResString(502652)
                    VTLen = Strings.Len(grdEstado.CtlText) + 10
                Case FMLoadResString(503199), FMLoadResString(503200)
                    VTLen = Strings.Len(grdEstado.CtlText) + 5
                Case FMLoadResString(503208)
                    VTLen = Strings.Len(grdEstado.CtlText) + 6
                Case FMLoadResString(503207)
                    If VGOcucol = "N" Then
                        VTLen = Strings.Len(grdEstado.CtlText) + 3
                    End If
                Case FMLoadResString(503212)
                    VTLen = Strings.Len(grdEstado.CtlText) + 5
                    FMLoadResString(2257)
                Case Else
                    VTLen = Strings.Len(grdEstado.CtlText) + VTTemp
            End Select
            VLImpresion(j).length = VTLen
            VLImpresion(j).col = VLOrdenColImp(j)
        Next j
        VLColumnas = j - 1
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Orientation = VGImpOrientacion
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontName = "Times New Roman"
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 10
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 0
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 0
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print()
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print()
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print()
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print()
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print()
        If Flag Then
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(6), VGNombreFilial)
        End If
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontName = "Verdana"
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 9
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 0
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = CInt(COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY + 1)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = False
        Dim VTTitulo As String = Me.Text
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(6), VTTitulo)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(6), FMLoadResString(502287) & " ", FileSystem.TAB(20), mskCuenta.Text)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(6), FMLoadResString(5067) & " ", FileSystem.TAB(20), lblDescripcion(12).Text)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(6), FMLoadResString(5007) & " ", FileSystem.TAB(20), lblDescripcion(0).Text)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(6), FMLoadResString(5172) & " ", FileSystem.TAB(20), mskValor(0).Text)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(6), FMLoadResString(5173) & " ", FileSystem.TAB(20), mskValor(1).Text)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print()
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 7
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontName = "Verdana"
        Dim VTOffset As Integer = 6
        For i As Integer = 1 To VLColumnas
            VTOffset += VLImpresion(i).length
            If i = 1 Then
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(6), VLImpresion(i).Texto, FileSystem.TAB(VTOffset))
            Else
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(VLImpresion(i).Texto, FileSystem.TAB(VTOffset))
            End If
        Next i
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print()
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(6), New String("-", 200))
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = False
        VLLin = 8
    End Sub

    Private Sub PLTSEstado()
        TSBImprimir.Enabled = _cmdBoton_5.Enabled
        TSBImprimir.Visible = _cmdBoton_5.Visible
        TSBSiguientes.Enabled = _cmdBoton_3.Enabled
        TSBSiguientes.Visible = _cmdBoton_3.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBExcel.Enabled = _cmdBoton_7.Enabled
        TSBExcel.Visible = _cmdBoton_7.Visible
    End Sub

    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBFirma_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBFirma.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
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

    Private Sub grdEstado_Enter(sender As Object, e As EventArgs) Handles grdEstado.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502008))
    End Sub

    Private Sub grdEstado_Leave(sender As Object, e As EventArgs) Handles grdEstado.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub TSBExcel_Click(sender As Object, e As EventArgs) Handles TSBExcel.Click
        If _cmdBoton_7.Enabled Then cmdBoton_Click(_cmdBoton_7, e)
    End Sub
End Class


