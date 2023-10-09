Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Imports COBISCorp.tCOBIS.CTA.Ahos.AccountsAdmCatalogs
Partial Public Class FTran234Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLEjecuta As Integer = 0
    Dim VTarreglo2(10) As String
    Dim VLPaso As Integer = 0
    Const IDNO As DialogResult = System.Windows.Forms.DialogResult.No

    Private Sub FTran234_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
        mskCuenta_Leave(mskCuenta, Nothing)
        mskCuenta.Enabled = False
        VLPaso = True
    End Sub

    Private Sub PLInicializar()
        MyAppGlobals.AppActiveForm = ""
        For i As Integer = 0 To 1
            mskValor(i).Mask = ""
            mskValor(i).Text = VGFecha
            mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
        Next i
        mskCuenta.Mask = VGMascaraCtaCte
        rptCristal.DataFiles(0) = VGPathResouces & "\soctaaho.mdb"
        rptCristal_co.DataFiles(0) = VGPathResouces & "\soctaaho.mdb"
        rptCristal.ReportFileName = VGPathResouces & "\esctaaho.rpt"
        rptCristal_co.ReportFileName = VGPathResouces & "\esctaaho_co.rpt"
        VLEjecuta = True
        OptGeneracion(0).Checked = True
        OptGeneracion(1).Checked = False
        txtCampo(3).Enabled = False
        lblDescripcion(4).Enabled = False
        mskCuenta.Mask = VGMascaraCtaAho
        Dim eventSender As Object = Nothing
        Dim eventArgs As EventArgs = Nothing
        mskCuenta_Leave(eventSender, eventArgs)
        Me.Text = FMLoadResString(1047)
        CargaParametros("1579", "Q", "3", "AHO", "OCUCOL", 3)
        If VGOcucol = "S" Then
            Label5.Visible = False
            Lblalianza.Visible = False
            lbldesalianza.Visible = False
        End If
    End Sub

    Private Sub FTran234_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_3.Click
        Dim Error1 As Boolean = False
        Dim error2 As Boolean = False
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim Response As DialogResult
        Dim VTTotalFilas As Integer = 0
        Dim VTSaldoContableIni As Decimal = 0
        Dim VTBanderaSCI As Boolean = False
        Dim VTCliente As String = ""
        Dim VTExtMail As Boolean = False
        Dim VTFDesde As String = String.Empty
        Dim VTFHasta As String = String.Empty
        Dim VTFHoy As String = String.Empty
        Dim VTR As Integer = 0
        Dim VTNumDep As String = ""
        Dim VTDepositos As Decimal = 0
        Dim VTNumNC As Integer = 0
        Dim VTNotasCredito As Decimal = 0
        Dim VTNumND As Integer = 0
        Dim VTNotasDebito As Decimal = 0
        Dim VTTranDiario As Integer = 0
        Dim VTSalir As Boolean = False
        Dim VTPrimera As String = ""
        Dim VTTotInt As Integer = 0
        Dim VTError As Boolean = False
        Dim VTSaldo As Integer = 0
        Dim VTSecuencial As String = ""
        Dim VTSecAlterno As String = ""
        Dim VTHora As String = ""
        Dim VTFono As String = ""
        Dim VTResult As Integer = 0
        Dim VTIva As Integer = 0
        Try
            error2 = True
            Error1 = False
            Dim DB As DAO.Database = Nothing
            Dim T As DAO.Recordset = Nothing
            Dim L As DAO.Recordset = Nothing
            Dim M As DAO.Recordset = Nothing
            Dim DBA As DAO.Database = Nothing
            Dim Tabla As DAO.Recordset
            Dim qDeleteh, qDeleted, qDeletef As DAO.QueryDef
            TSBotones.Focus()
            Select Case Index
                Case 0
                    cmdBoton_Click(cmdBoton(3), New EventArgs())
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4141")
                    PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "Q")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_control_manejo_extracto", True, FMLoadResString(2251)) Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(3))
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                    End If
                    If txtCampo(1).Text.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(2252), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(1).Focus()
                        Exit Sub
                    End If
                    If txtCampo(2).Text.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(2253), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(2).Focus()
                        Exit Sub
                    End If                  
                    VTFDesde = (txtCampo(1).Text + "/01/" + txtCampo(2).Text)
                    VTFDesde = FMConvFecha((VTFDesde), VGFormatoFecha, CGFormatoBase)
                    VTFHasta = DateAdd("m", 1, VTFDesde)
                    VTFHoy = DateAdd("d", (-1) * (DateAndTime.Day(VTFDesde)), VTFHasta) 'dd/mm/yyyy
                    If FMDateDiff("d", VTFHoy, VGFecha, VGFormatoFecha) <= 0 Then
                        COBISMessageBox.Show(FMLoadResString(2254), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(1).Focus()
                        Exit Sub
                    End If
                    If FMDateDiff("m", VTFDesde, VGFecha, VGFormatoFecha) > CDbl(lblDescripcion(3).Text) Then
                        COBISMessageBox.Show(FMLoadResString(2255) & lblDescripcion(3).Text & "] " & FMLoadResString(2256), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                        txtCampo(1).Focus()
                        Exit Sub
                    End If
                    If VGCodPais = "CO" Then
                        VTR = COBISMessageBox.Show(FMLoadResString(2257), FMLoadResString(500092), COBISMessageBox.COBISButtons.YesNo)
                        If VTR = System.Windows.Forms.DialogResult.Yes Then
                            VTCliente = "S"
                        Else
                            VTCliente = "N"
                        End If
                    End If
                    lblDescripcion(2).Text = ""
                    lblDescripcion(3).Text = ""
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4141")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mes", 0, SQLINT2, txtCampo(1).Text)
                    PMPasoValores(sqlconn, "@i_ano", 0, SQLINT2, txtCampo(2).Text)
                    PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_frontend", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_escliente", 0, SQLCHAR, VTCliente)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_control_manejo_extracto", True, FMLoadResString(2258)) Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(2))
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                    End If
                    If Not VLEjecuta Then
                        COBISMessageBox.Show(FMLoadResString(500710), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        cmdBoton(3).Focus()
                        Exit Sub
                    End If
                    If mskCuenta.ClipText.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(501854), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        mskCuenta.Focus()
                        Exit Sub
                    End If
                    If txtCampo(1).Text.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(2252), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(1).Focus()
                        Exit Sub
                    End If
                    If txtCampo(2).Text.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(2253), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(2).Focus()
                        Exit Sub
                    End If
                    If txtCampo(0).Text.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(2259), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(0).Focus()
                        Exit Sub
                    End If
                    If OptGeneracion(1).Checked Then
                        VTExtMail = True
                        If lblDescripcion(4).Text.Trim() = "" Then
                            COBISMessageBox.Show(FMLoadResString(2260), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(3).Focus()
                            Exit Sub
                        End If
                        If COBISMessageBox.Show(FMLoadResString(2261), FMLoadResString(500092), COBISMessageBox.COBISButtons.YesNo) = System.Windows.Forms.DialogResult.No Then
                            Exit Sub
                        End If
                    End If
                    If lblDescripcion(2).Text = "S" Then
                        Response = COBISMessageBox.Show(FMLoadResString(500791), FMLoadResString(15001), COBISMessageBox.COBISButtons.YesNo)
                        If Response = System.Windows.Forms.DialogResult.No Then
                            Exit Sub
                        End If
                    End If
                    If COBISMessageBox.Show(FMLoadResString(500423) & Strings.Chr(13).ToString() & FMLoadResString(500424), FMLoadResString(500092), COBISMessageBox.COBISButtons.OKCancel, COBISMessageBox.COBISIcon.Question) <> System.Windows.Forms.DialogResult.OK Then
                        Exit Sub
                    End If
                    Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
                    VTNumDep = CStr(0)
                    VTDepositos = 0
                    VTNumNC = 0
                    VTNotasCredito = 0
                    VTNumND = 0
                    VTNotasDebito = 0
                    VTTranDiario = 0
                    VTSalir = True
                    VTPrimera = "S"
                    VTTotInt = 0
                    VTError = False
                    VTSaldo = 0
                    Dim VTArregloCab(30) As String
                    Dim VTArregloPie(15) As String
                    Dim VTMatriz(21, 30) As String
                    VTTotalFilas = 0
                    VTSaldoContableIni = 0
                    VTBanderaSCI = False
                    VTSaldo = 0
                    If Not VTExtMail Then
                        While VTSalir
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "236")
                            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                            If VTPrimera = "S" Then
                                VTFDesde = (txtCampo(1).Text & "/01/" & txtCampo(2).Text)
                                VTFDesde = FMConvFecha(VTFDesde, VGFormatoFecha, CGFormatoBase)
                            Else
                                VTFDesde = (txtCampo(1).Text & "/01/" & txtCampo(2).Text)
                                VTFDesde = FMConvFecha(VTFDesde, VGFormatoFecha, CGFormatoBase)
                            End If
                            VTFHasta = DateAdd("m", 1, VTFDesde)
                            VTFHasta = DateAdd("d", (-1) * (DateAndTime.Day(VTFDesde)), VTFHasta)
                            VTFDesde = FMConvFecha((VTFDesde), VGFormatoFecha, CGFormatoBase)
                            VTFHasta = FMConvFecha((VTFHasta), VGFormatoFecha, CGFormatoBase)
                            PMPasoValores(sqlconn, "@i_fchdsde", 0, SQLDATETIME, VTFDesde)
                            PMPasoValores(sqlconn, "@i_fchhsta", 0, SQLDATETIME, VTFHasta)
                            If VTPrimera = "S" Then
                                PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, "0")
                                PMPasoValores(sqlconn, "@i_sec_alt", 0, SQLINT4, "0")
                                PMPasoValores(sqlconn, "@i_hora", 0, SQLDATETIME, "01/01/1900 12:00AM")
                            Else
                                PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, VTSecuencial)
                                PMPasoValores(sqlconn, "@i_sec_alt", 0, SQLINT4, VTSecAlterno)
                                PMPasoValores(sqlconn, "@i_hora", 0, SQLDATETIME, VTHora)
                            End If
                            PMPasoValores(sqlconn, "@i_diario", 0, SQLINT1, Conversion.Str(VTTranDiario).Trim())
                            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                            PMPasoValores(sqlconn, "@i_frontn", 0, SQLCHAR, "S")
                            PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                            PMPasoValores(sqlconn, "@i_escliente", 0, SQLCHAR, VTCliente)
                            PMPasoValores(sqlconn, "@o_hist", 1, SQLINT1, "0")
                            PMPasoValores(sqlconn, "@i_concepto", 0, SQLCHAR, txtCampo(0).Text)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_ahsoestcta", True, FMLoadResString(2262)) Then
                                If VTPrimera = "S" Then
                                    FMMapeaArreglo(sqlconn, VTArregloCab)
                                    PMMapeaVariable(sqlconn, VTFono)
                                    FMMapeaArreglo(sqlconn, VTArregloPie)
                                    DB = DAO_DBEngine_definst.OpenDatabase(VGPathResouces & "\soctaaho.mdb")
                                    T = DB.OpenRecordset("Header")
                                    L = DB.OpenRecordset("Footer")
                                    M = DB.OpenRecordset("Details")
                                    T.AddNew()
                                    T.Fields("Cuenta").Value = mskCuenta.Text
                                    T.Fields("Nombre").Value = VTArregloCab(1)
                                    T.Fields("Moneda").Value = VTArregloCab(4)
                                    If VTArregloCab(20) = "C" Then
                                        T.Fields("Direccion").Value = FMLoadResString(2263) & " " & VTArregloCab(5)
                                    Else
                                        T.Fields("Direccion").Value = VTArregloCab(5)
                                    End If
                                    T.Fields("Zona").Value = Conversion.Val(VTArregloCab(8))
                                    T.Fields("SubZona").Value = Conversion.Val(VTArregloCab(9))
                                    T.Fields("Telefono").Value = VTFono
                                    T.Fields("FechaMesAnterior").Value = VTArregloCab(24)
                                    T.Fields("FechaCierre").Value = VTFHasta
                                    If VTArregloCab(10) = "" Then
                                        VTArregloCab(10) = "0"
                                    End If
                                    If VGCodPais = "CO" Then
                                        T.Fields("FechaImpresion").Value = VTArregloPie(10)
                                        T.Fields("Saldo").Value = IIf(VTArregloPie(9) = "", 0, CDec(VTArregloPie(9)))
                                        VTSaldo = IIf(VTArregloPie(9) = "", 0, CDec(VTArregloPie(9)))
                                    Else
                                        T.Fields("FechaImpresion").Value = VGFecha
                                        T.Fields("Saldo").Value = IIf(VTArregloCab(10) = "", 0, CDec(VTArregloCab(10)))
                                        VTSaldo = IIf(VTArregloCab(10) = "", 0, CDec(VTArregloCab(10)))
                                    End If
                                    T.Fields("NombreOficial").Value = VTArregloCab(11)
                                    T.Fields("fideicomiso").Value = VTArregloCab(19)
                                    T.Fields("tdireccion").Value = VTArregloCab(20)
                                    T.Fields("producto").Value = VTArregloCab(21)
                                    T.Fields("filial").Value = Conversion.Val(VGLOGO)
                                    T.Fields("TelefonoOficial").Value = VTArregloCab(22)
                                    T.Fields("Oficina").Value = VTArregloCab(23)
                                    T.Update()
                                End If
                                VTResult = FMMapeaMatriz(sqlconn, VTMatriz)
                                PMChequea(sqlconn)
                                VTTranDiario = Conversion.Val(FMRetParam(sqlconn, 1))
                                VTTotalFilas += VTResult
                                For i As Integer = 1 To VTResult
                                    VTFDesde = VTMatriz(0, i)
                                    M.AddNew()
                                    M.Fields("Cuenta").Value = mskCuenta.Text
                                    M.Fields("Fecha").Value = VTMatriz(0, i)
                                    M.Fields("Lugar").Value = VTMatriz(2, i)
                                    If VTMatriz(15, i).Length < 3 Then
                                        If VTMatriz(15, i).Length = 1 Then
                                            VTMatriz(15, i) = "00" & VTMatriz(15, i)
                                        Else
                                            VTMatriz(15, i) = "0" & VTMatriz(15, i)
                                        End If
                                    End If
                                    M.Fields("Referencia").Value = VTMatriz(10, i)
                                    M.Fields("Descripcion").Value = VTMatriz(4, i)
                                    M.Fields("Oficina").Value = VTMatriz(1, i)
                                    If VTMatriz(3, i) = "S" Then
                                        M.Fields("Descripcion").Value = M.Fields("Descripcion").Value & " " & FMLoadResString(2264)
                                    End If
                                    If VTMatriz(5, i) = "*" Then
                                        M.Fields("Descripcion").Value = M.Fields("Descripcion").Value & " " & FMLoadResString(2265)
                                    End If
                                    If VTMatriz(6, i) = "" Then
                                        VTMatriz(6, i) = "0"
                                    End If
                                    M.Fields("Valor").Value = CDec(VTMatriz(6, i))
                                    If VTMatriz(5, i) = "C" Or VTMatriz(5, i) = "*" Then
                                        M.Fields("Signo").Value = "+"
                                        M.Fields("Credito").Value = CDec(VTMatriz(6, i))
                                        If VTMatriz(5, i) = "C" Then
                                            VTSaldo += CDec(VTMatriz(6, i))
                                        End If
                                    Else
                                        If VTMatriz(5, i) = "D" Then
                                            M.Fields("Signo").Value = "-"
                                            M.Fields("Debito").Value = CDec(VTMatriz(6, i))
                                            VTSaldo -= CDec(VTMatriz(6, i))
                                        Else
                                            M.Fields("Signo").Value = ""
                                        End If
                                    End If
                                    If VTMatriz(7, i) = "" Then
                                        VTMatriz(7, i) = "0"
                                    End If
                                    If Not VTBanderaSCI Then
                                        VTSaldoContableIni = CDec(VTMatriz(7, i))
                                        If VTMatriz(5, i) = "C" Then
                                            VTSaldoContableIni -= CDec(VTMatriz(6, i))
                                        Else
                                            VTSaldoContableIni += CDec(VTMatriz(6, i))
                                        End If
                                        VTBanderaSCI = True
                                    End If
                                    If VGCodPais = "CO" Then
                                        If VTMatriz(8, i) = "" Then
                                            VTMatriz(8, i) = "0"
                                        End If
                                        If VTPrimera = "S" Then
                                            If VTMatriz(19, i) <> "" Then
                                                VTIva = CInt(VTMatriz(19, i))
                                            Else
                                                VTIva = 0
                                            End If
                                        Else
                                            If VTMatriz(19, i) <> "" Then
                                                VTIva = CInt(VTMatriz(19, i))
                                            Else
                                                VTIva = 0
                                            End If
                                        End If
                                        If VTIva = StringsHelper.ToDoubleSafe("") Then
                                            VTIva = 0
                                        End If
                                        M.Fields("SaldoContable").Value = VTSaldo
                                    Else
                                        M.Fields("SaldoContable").Value = CDec(VTMatriz(7, i))
                                    End If
                                    M.Fields("Interes").Value = VTMatriz(9, i)
                                    VTSecuencial = VTMatriz(10, i)
                                    VTSecAlterno = VTMatriz(11, i)
                                    VTHora = VTMatriz(18, i)
                                    M.Fields("TranCode").Value = VTMatriz(12, i)
                                    Select Case VTMatriz(12, i)
                                        Case "207", "246", "248", "251", "252", "254"
                                            If VTMatriz(5, i) <> "*" Then
                                                VTNumDep = CStr(CDbl(VTNumDep) + 1)
                                                VTDepositos += CDec(VTMatriz(6, i))
                                            End If
                                        Case "229", "253", "255", "257", "2503", "221", "294", "300", "304", "315"
                                            VTNumNC += 1
                                            VTNotasCredito += CDec(VTMatriz(6, i))
                                        Case "228", "240", "262", "264", "266", "2502", "237", "239", "263", "371", "213", "308", "309", "316", "392", "380"
                                            VTNumND += 1
                                            VTNotasDebito += CDec(VTMatriz(6, i))
                                    End Select
                                    Select Case VTMatriz(12, i)
                                        Case "221"
                                            VTTotInt += CDec(VTMatriz(6, i))
                                    End Select
                                    M.Fields("filial").Value = Conversion.Val(VGLOGO)
                                    M.Update()
                                    If VGCodPais = "CO" Then
                                        If VTMatriz(8, i) = "" Then
                                            VTMatriz(8, i) = "0"
                                        End If
                                        If VTPrimera = "S" Then
                                            If VTMatriz(19, i) <> "" Then
                                                VTIva = CInt(VTMatriz(19, i))
                                            Else
                                                VTIva = 0
                                            End If
                                        Else
                                            If VTMatriz(19, i) <> "" Then
                                                VTIva = CInt(VTMatriz(19, i))
                                            Else
                                                VTIva = 0
                                            End If
                                        End If
                                        If VTIva = StringsHelper.ToDoubleSafe("") Then
                                            VTIva = 0
                                        End If
                                        If VTIva > 0 Then
                                            M.AddNew()
                                            M.Fields("Cuenta").Value = mskCuenta.Text
                                            M.Fields("Fecha").Value = VTMatriz(0, i)
                                            M.Fields("Lugar").Value = VTMatriz(2, i)
                                            M.Fields("Referencia").Value = VTMatriz(10, i)
                                            M.Fields("Oficina").Value = VTMatriz(1, i)
                                            If VTMatriz(3, i) = "S" Then
                                                M.Fields("Descripcion").Value = M.Fields("Descripcion").Value & FMLoadResString(2266)
                                                M.Fields("Signo").Value = "+"
                                                M.Fields("Credito").Value = VTIva
                                                VTNotasDebito -= VTIva
                                                VTSaldo += VTIva
                                            Else
                                                M.Fields("Descripcion").Value = M.Fields("Descripcion").Value & FMLoadResString(2267)
                                                M.Fields("Signo").Value = "-"
                                                M.Fields("Debito").Value = VTIva
                                                VTNotasDebito += VTIva
                                                VTSaldo -= VTIva
                                            End If
                                            M.Fields("SaldoContable").Value = CDec(VTMatriz(7, i)) + CDec(VTMatriz(8, i))
                                            M.Fields("filial").Value = Conversion.Val(VGLOGO)
                                            M.Update()
                                        End If
                                        If StringsHelper.ToDoubleSafe(VTMatriz(8, i)) > 0 Then
                                            M.AddNew()
                                            M.Fields("Cuenta").Value = mskCuenta.Text
                                            M.Fields("Fecha").Value = VTMatriz(0, i)
                                            M.Fields("Lugar").Value = VTMatriz(2, i)
                                            M.Fields("Referencia").Value = VTMatriz(10, i)
                                            M.Fields("Oficina").Value = VTMatriz(1, i)
                                            If VTMatriz(3, i) = "S" Then
                                                M.Fields("Descripcion").Value = M.Fields("Descripcion").Value & FMLoadResString(2268)
                                                M.Fields("Signo").Value = "+"
                                                M.Fields("Credito").Value = CDec(VTMatriz(8, i))
                                                VTNotasDebito -= CDec(VTMatriz(8, i))
                                                VTSaldo += CDec(VTMatriz(8, i))
                                            Else
                                                M.Fields("Descripcion").Value = M.Fields("Descripcion").Value & FMLoadResString(2269)
                                                M.Fields("Signo").Value = "-"
                                                M.Fields("Debito").Value = CDec(VTMatriz(8, i))
                                                VTNotasDebito += CDec(VTMatriz(8, i))
                                                VTSaldo -= CDec(VTMatriz(8, i))
                                            End If
                                            M.Fields("SaldoContable").Value = VTSaldo
                                            M.Fields("filial").Value = Conversion.Val(VGLOGO)
                                            M.Update()
                                        End If
                                    End If
                                Next i
                                VTPrimera = "N"
                                If VTTranDiario = 1 Then
                                    VTSecuencial = "0"
                                    VTSecAlterno = "0"
                                    VTHora = "01/01/1900 12:00AM"
                                End If
                                If VTTranDiario = 3 Then
                                    VTSalir = False
                                End If
                            Else
                                PMChequea(sqlconn)
                                VTSalir = False
                                VTError = True
                            End If
                        End While
                    End If
                    If Not VTError Then
                        Me.Cursor = System.Windows.Forms.Cursors.Default
                        If Not VTExtMail Then
                            If VTTotalFilas = 0 Then
                                M.AddNew()
                                M.Fields("filial").Value = Conversion.Val(VGLOGO)
                                M.Update()
                            End If
                            L.AddNew()
                            If VTArregloPie(5) = "" Then
                                VTArregloPie(5) = "0"
                            End If
                            If VTArregloPie(9) = "" Then
                                VTArregloPie(9) = "0"
                            End If
                            If VGCodPais = "CO" Then
                                L.Fields("SaldoPromedio").Value = IIf(VTArregloPie(9) = "", 0, CDec(VTArregloPie(9)))
                            Else
                                L.Fields("SaldoPromedio").Value = IIf(VTArregloPie(5) = "", 0, CDec(VTArregloPie(5)))
                            End If
                            If VTArregloPie(2) = "" Then
                                VTArregloPie(2) = "0"
                            End If
                            L.Fields("RetBancosLoc").Value = CDec(VTArregloPie(2))
                            If VTArregloPie(3) = "" Then
                                VTArregloPie(3) = "0"
                            End If
                            L.Fields("RetOtrasPlazas").Value = CDec(VTArregloPie(3))
                            If VTArregloPie(4) = "" Then
                                VTArregloPie(4) = "0"
                            End If
                            L.Fields("SaldoContable").Value = CDec(VTArregloPie(4))
                            If VTArregloPie(5) = "" Then
                                VTArregloPie(5) = "0"
                            End If
                            L.Fields("SaldoDisponible").Value = CDec(VTArregloPie(5))
                            If VTArregloPie(6) = "" Then
                                VTArregloPie(6) = "0"
                            End If
                            L.Fields("SaldoPromConfirma").Value = CDec(VTArregloPie(6))
                            If VTArregloPie(7) = "" Then
                                VTArregloPie(7) = "0"
                            End If
                            L.Fields("SaldoPromContable").Value = CDec(VTArregloPie(7))
                            If VGCodPais = "CO" Then
                                If VTArregloPie(8) = "" Then
                                    VTArregloPie(8) = "0"
                                End If
                                L.Fields("NumDep").Value = VTArregloPie(8)
                                L.Fields("Depositos").Value = VTTotInt
                                VTNumNC += CDbl(VTNumDep)
                                VTNotasCredito += VTDepositos
                            Else
                                L.Fields("NumDep").Value = VTNumDep
                                L.Fields("Depositos").Value = VTDepositos
                            End If
                            L.Fields("NumNC").Value = VTNumNC
                            L.Fields("NC").Value = VTNotasCredito
                            L.Fields("NumND").Value = VTNumND
                            L.Fields("ND").Value = VTNotasDebito
                            L.Fields("Cuenta").Value = mskCuenta.Text
                            L.Fields("filial").Value = Conversion.Val(VGLOGO)
                            If VTBanderaSCI Then
                                L.Fields("SaldoContableInicial").Value = VTSaldoContableIni
                            Else
                                L.Fields("SaldoContableInicial").Value = CDec(VTArregloPie(4))
                            End If
                            L.Update()
                            T.Close()
                            L.Close()
                            M.Close()
                            DB.Close()
                        End If
                        VLEjecuta = False
                        Error1 = True
                        error2 = False
                        If lblDescripcion(2).Text = "S" Then
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "234")
                            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                            VTFDesde = FMConvFecha(mskValor(0).Text, VGFormatoFecha, CGFormatoBase)
                            PMPasoValores(sqlconn, "@i_fecha_ini", 0, SQLDATETIME, VTFDesde)
                            VTFHasta = FMConvFecha(mskValor(0).Text, VGFormatoFecha, CGFormatoBase)
                            PMPasoValores(sqlconn, "@i_fecha_fin", 0, SQLDATETIME, VTFHasta)
                            PMPasoValores(sqlconn, "@i_escliente", 0, SQLCHAR, VTCliente)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_solicita_ec_ah", True, FMLoadResString(2258)) Then
                                PMChequea(sqlconn)
                            Else
                                PMChequea(sqlconn)
                                COBISMessageBox.Show(FMLoadResString(2270), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                Exit Sub
                            End If
                        End If
                        If VTExtMail Then
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "236")
                            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                            If VTPrimera = "S" Then
                                VTFDesde = (txtCampo(1).Text & "/01/" & txtCampo(2).Text)
                                VTFDesde = FMConvFecha(VTFDesde, VGFormatoFecha, CGFormatoBase)
                            Else
                                VTFDesde = (txtCampo(1).Text & "/01/" & txtCampo(2).Text)
                                VTFDesde = FMConvFecha(VTFDesde, VGFormatoFecha, CGFormatoBase)
                            End If
                            VTFHasta = DateTimeHelper.ToString(CDate(VTFDesde).AddMonths(1))
                            VTFHasta = DateTimeHelper.ToString(CDate(VTFHasta).AddDays((-1) * (DateAndTime.Day(CDate(VTFDesde)))))
                            VTFDesde = FMConvFecha(VTFDesde, VGFormatoFecha, CGFormatoBase)
                            VTFHasta = FMConvFecha(VTFHasta, VGFormatoFecha, CGFormatoBase)
                            PMPasoValores(sqlconn, "@i_fchdsde", 0, SQLDATETIME, VTFDesde)
                            PMPasoValores(sqlconn, "@i_fchhsta", 0, SQLDATETIME, VTFHasta)
                            PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, "0")
                            PMPasoValores(sqlconn, "@i_sec_alt", 0, SQLINT4, "0")
                            PMPasoValores(sqlconn, "@i_hora", 0, SQLDATETIME, "01/01/1900 12:00AM")
                            If VGCodPais = "CO" Then
                                VTR = COBISMessageBox.Show(FMLoadResString(2257), FMLoadResString(500092), COBISMessageBox.COBISButtons.YesNo)
                                If VTR = System.Windows.Forms.DialogResult.Yes Then
                                    VTCliente = "S"
                                Else
                                    VTCliente = "N"
                                End If
                            End If
                            PMPasoValores(sqlconn, "@i_diario", 0, SQLINT1, Conversion.Str(VTTranDiario).Trim())
                            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                            PMPasoValores(sqlconn, "@i_frontn", 0, SQLCHAR, "S")
                            PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                            PMPasoValores(sqlconn, "@i_escliente", 0, SQLCHAR, VTCliente)
                            PMPasoValores(sqlconn, "@i_envio_mail", 0, SQLCHAR, "S")
                            PMPasoValores(sqlconn, "@i_email", 0, SQLCHAR, lblDescripcion(4).Text)
                            PMPasoValores(sqlconn, "@i_concepto", 0, SQLCHAR, txtCampo(0).Text)
                            PMPasoValores(sqlconn, "@o_hist", 1, SQLINT1, "0")
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_ahsoestcta", True, FMLoadResString(2262)) Then
                                PMChequea(sqlconn)
                                COBISMessageBox.Show(FMLoadResString(2271), FMLoadResString(2272), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                            Else
                                PMChequea(sqlconn)
                                COBISMessageBox.Show(FMLoadResString(2273), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                Exit Sub
                            End If
                        Else
                            If VGCodPais = "CO" Then
                                rptCristal_co.DataFiles(0) = VGPathResouces & "\soctaaho.mdb"
                                rptCristal_co.DataFiles(1) = VGPathResouces & "\soctaaho.mdb"
                                rptCristal_co.DataFiles(2) = VGPathResouces & "\soctaaho.mdb"
                                rptCristal_co.DataFiles(3) = VGPathResouces & "\logo.mdb"
                                rptCristal_co.Destination = COBISCorp.Framework.UI.Components.DestinationConstants.crptToWindow
                                rptCristal_co.Action = 1
                            Else
                                rptCristal.DataFiles(0) = VGPathResouces & "\soctaaho.mdb"
                                rptCristal.DataFiles(1) = VGPathResouces & "\soctaaho.mdb"
                                rptCristal.DataFiles(2) = VGPathResouces & "\soctaaho.mdb"
                                rptCristal.DataFiles(3) = VGPathResouces & "\logo.mdb"
                                rptCristal.Destination = COBISCorp.Framework.UI.Components.DestinationConstants.crptToWindow
                                rptCristal.Action = 1
                            End If
                        End If
                    End If
                    Me.Cursor = System.Windows.Forms.Cursors.Default
                Case 1
                    txtCampo(1).Text = ""
                    txtCampo(2).Text = ""
                    txtCampo(3).Text = ""
                    txtCampo(0).Text = ""
                    'lblDescripcion(0).Text = ""
                    lblDescripcion(1).Text = ""
                    lblDescripcion(2).Text = ""
                    lblDescripcion(4).Text = ""
                    cmdBoton(4).Enabled = False
                Case 2
                    cmdBoton_Click(cmdBoton(3), New EventArgs())
                    If VLEjecuta Then
                        Me.Close()
                    Else
                        COBISMessageBox.Show(FMLoadResString(500710), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        cmdBoton(3).Focus()
                    End If
                Case 3
                    Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
                    DBA = DAO_DBEngine_definst.OpenDatabase(VGPathResouces & "\soctaaho.mdb")
                    Tabla = DBA.OpenRecordset("Header")
                    If Not Tabla.EOF Then
                        'VTTabla = "Header"
                        'SQL = "DELETE FROM " & VTTabla & ";"
                        qDeleteh = DBA.CreateQueryDef("", "delete * from Header")
                        qDeleteh.Execute()
                        qDeleteh = Nothing
                    End If
                    Tabla = DBA.OpenRecordset("Details")
                    If Not Tabla.EOF Then
                        'VTTabla = "Details"
                        'SQL = "DELETE FROM " & VTTabla & ";"
                        qDeleted = DBA.CreateQueryDef("", "delete * from Details")
                        qDeleted.Execute()
                        qDeleteh = Nothing
                    End If
                    Tabla = DBA.OpenRecordset("Footer")
                    If Not Tabla.EOF Then
                        'VTTabla = "Footer"
                        'SQL = "DELETE FROM " & VTTabla & ";"
                        qDeletef = DBA.CreateQueryDef("", "delete * from Footer")
                        qDeletef.Execute()
                        qDeleteh = Nothing
                    End If
                    Tabla.Close()
                    DBA.Close()
                    VLEjecuta = True
                    Me.Cursor = System.Windows.Forms.Cursors.Default
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
                    End If
            End Select
        Catch excep As System.InvalidCastException
            COBISMessageBox.Show(FMLoadResString(20021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        Catch excep As System.Exception
            If Not Error1 And Not error2 Then
                COBISMessageBox.Show(FMLoadResString(509326), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            End If
            If Error1 Then
                COBISMessageBox.Show(FMLoadResString(500428) & " " & excep.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Me.Cursor = System.Windows.Forms.Cursors.Default
                Exit Sub
            End If
            If error2 Or Error1 Then
                COBISMessageBox.Show(FMLoadResString(500869) & " " & Conversion.ErrorToString(), My.Application.Info.ProductName)
                Me.Cursor = System.Windows.Forms.Cursors.Default
                Exit Sub
            End If
        End Try
        PLTSEstado()
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
                    PMPasoValores(sqlconn, "@i_codcliente", 0, SQLINT4, Lblcli.Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2274) & mskCuenta.Text & "]") Then
                        FMMapeaArreglo(sqlconn, VTarreglo2)
                        lblDescripcion(0).Text = VTarreglo2(1)
                        Lblalianza.Text = VTarreglo2(7)
                        lbldesalianza.Text = VTarreglo2(8)
                        PMChequea(sqlconn)
                        cmdBoton(4).Enabled = True
                        _txtCampo_1.Focus()

                    Else
                        PMChequea(sqlconn)
                        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                        lblDescripcion(0).Text = ""
                        lblDescripcion(0).Text = ""
                        Lblalianza.Text = ""
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
            COBISMessageBox.Show(exc.ToString, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End Try
        PLTSEstado()
    End Sub

    Private Sub mskValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskValor_0.Enter, _mskValor_1.Enter
        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2275) & VGFormatoFecha & "]")
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2276) & VGFormatoFecha & "]")
        End Select
        mskValor(Index).SelectionStart = 0
        mskValor(Index).SelectionLength = Strings.Len(mskValor(Index).Text)
    End Sub

    Private Sub mskValor_KeyPressEvent(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _mskValor_0.KeyPress, _mskValor_1.KeyPress
        If (Asc(eventArgs.KeyChar) <> 8) And ((Asc(eventArgs.KeyChar) < 48) Or (Asc(eventArgs.KeyChar) > 57)) Then
            eventArgs.KeyChar = Chr(0)
        End If
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub OptGeneracion_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _OptGeneracion_1.CheckedChanged, _OptGeneracion_0.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Index As Integer = Array.IndexOf(OptGeneracion, eventSender)
            Select Case Index
                Case 0
                    txtCampo(3).Enabled = False
                    lblDescripcion(4).Enabled = False
                    txtCampo(3).Text = ""
                    lblDescripcion(4).Text = ""
                Case 1
                    txtCampo(3).Enabled = True
                    lblDescripcion(4).Enabled = True
            End Select
        End If
        PLTSEstado()
    End Sub

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.TextChanged, _txtCampo_0.TextChanged, _txtCampo_2.TextChanged, _txtCampo_1.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 3
                VLPaso = False
            Case 1
                VLPaso = False
        End Select

        PLTSEstado()
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.Enter, _txtCampo_0.Enter, _txtCampo_2.Enter, _txtCampo_1.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(20002))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2320))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2321))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2322))
        End Select
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_3.KeyDown, _txtCampo_0.KeyDown, _txtCampo_2.KeyDown, _txtCampo_1.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTListCount As Integer = 0
        If Keycode = VGTeclaAyuda Then
            VLPaso = False
            Select Case Index
                Case 1
                    VLPaso = True
                    VGOperacion = "sp_parametro_extracto"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4140")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "X")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLINT2, CStr(1))
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_parametro_extracto", True, FMLoadResString(2277)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(1).Text = VGACatalogo.Codigo
                        lblDescripcion(1).Text = VGACatalogo.Descripcion
                        If txtCampo(1).Text.Trim() = "" Then
                            txtCampo(1).Text = ""
                            lblDescripcion(1).Text = ""
                            txtCampo(1).Focus()
                        End If
                        FCatalogo.Dispose()
                    Else
                        PMChequea(sqlconn)
                    End If
                Case 2
                    VLPaso = True
                    VGOperacion = "sp_parametro_extracto"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4140")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_parametro_extracto", True, FMLoadResString(2277)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(2).Text = VGACatalogo.Codigo
                        FCatalogo.Dispose()
                    Else
                        PMChequea(sqlconn)
                    End If
                Case 3
                    VLPaso = True
                    If mskCuenta.ClipText = "" Then
                        COBISMessageBox.Show(FMLoadResString(2278), My.Application.Info.ProductName)
                        mskCuenta.Focus()
                        mskCuenta.Text = ""
                        Exit Sub
                    End If
                    VGOperacion = "sp_direccion_cons"
                    PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "E")
                    PMPasoValores(sqlconn, "@i_cta_ah", 0, SQLCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1227")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_direccion_cons", True, FMLoadResString(2279)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        VTListCount = FCatalogo.lstCatalogo.Items.Count
                        If VTListCount = 0 Then
                            COBISMessageBox.Show(FMLoadResString(2280), FMLoadResString(2281), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                            Exit Sub
                        End If
                        FCatalogo.ShowPopup(Me)
                        txtCampo(3).Text = VGACatalogo.Codigo
                        lblDescripcion(4).Text = VGACatalogo.Descripcion
                        If txtCampo(3).Text <> "" Then
                            VLPaso = True
                        End If
                        FCatalogo.Dispose()
                    Else
                        PMChequea(sqlconn)
                        txtCampo(3).Tag = ""
                    End If
            End Select
        End If
        PLTSEstado()
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_3.KeyPress, _txtCampo_0.KeyPress, _txtCampo_2.KeyPress, _txtCampo_1.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 1, 2, 3
                If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                    KeyAscii = 0
                End If
            Case 0
                If (KeyAscii > 47 And KeyAscii < 58) Or (KeyAscii > 64 And KeyAscii < 91) Or (KeyAscii > 96 And KeyAscii < 123) Or (KeyAscii = 32 Or KeyAscii = 8) Then
                    KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                Else
                    KeyAscii = 0
                End If
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)      
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.Leave, _txtCampo_0.Leave, _txtCampo_2.Leave, _txtCampo_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim VTMeses() As String = {"01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"}
        Dim VTMeses0() As String = {"1", "2", "3", "4", "5", "6", "7", "8", "9"}
        Dim VTEjecucion As Boolean = False
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 1
                If Not VLPaso Then                   
                    For i = 0 To VTMeses.Length - 1
                        If txtCampo(1).Text = VTMeses(i) Then VTEjecucion = True
                    Next
                    For i = 0 To VTMeses0.Length - 1
                        If txtCampo(1).Text = VTMeses0(i) Then
                            txtCampo(1).Text = "0" + txtCampo(1).Text
                            VTEjecucion = True
                        End If
                    Next
                    If VTEjecucion Then
                        VLPaso = True
                        VGOperacion = "sp_parametro_extracto"
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4140")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "X")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLINT2, CStr(2))
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(1).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_parametro_extracto", True, FMLoadResString(2277)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(1))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                        End If
                    Else
                        VLPaso = True
                        COBISMessageBox.Show(FMLoadResString(20015), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        _lblDescripcion_1.Text = ""
                        _txtCampo_1.Text = ""
                        _txtCampo_1.Focus()
                    End If
                End If
            Case 2
                If txtCampo(2).TextLength <> 4 Then
                    COBISMessageBox.Show(FMLoadResString(20020), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
            Case 3
                If Not VLPaso Then
                    If mskCuenta.ClipText = "" Then
                        COBISMessageBox.Show(FMLoadResString(2278), My.Application.Info.ProductName)
                        mskCuenta.Focus()
                        mskCuenta.Text = ""
                        Exit Sub
                    End If
                    If txtCampo(3).Text.Trim() <> "" Then
                        VGOperacion = "sp_direccion_cons"
                        PMPasoValores(sqlconn, "@i_opcion", 0, SQLCHAR, "D")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "E")
                        PMPasoValores(sqlconn, "@i_cta_ah", 0, SQLCHAR, mskCuenta.ClipText)
                        PMPasoValores(sqlconn, "@i_direccion", 0, SQLINT2, txtCampo(3).Text)
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1227")
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_direccion_cons", True, FMLoadResString(2279)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(4))
                            PMChequea(sqlconn)
                            VLPaso = True
                        Else
                            PMChequea(sqlconn)
                            lblDescripcion(4).Text = ""
                            txtCampo(3).Focus()
                        End If
                    End If
                End If
        End Select
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBFirmas.Enabled = _cmdBoton_4.Enabled
        TSBFirmas.Visible = False '_cmdBoton_4.Visible
        TSBBorrar.Enabled = _cmdBoton_3.Enabled
        TSBBorrar.Visible = _cmdBoton_3.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
    End Sub

    Private Sub TSBFirmas_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBFirmas.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBBorrar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBorrar.Click
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
        cmdBoton_Click(cmdBoton(3), New EventArgs())
    End Sub

    Private Sub FraOpcGen_Enter(sender As Object, e As EventArgs) Handles FraOpcGen.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2310))
    End Sub

    Private Sub FraOpcGen_Leave(sender As Object, e As EventArgs) Handles FraOpcGen.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

End Class


