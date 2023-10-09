Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Imports COBISCorp.tCOBIS.CTA.Ahos.AccountsAdmCatalogs
Imports COBISCorp.tCOBIS.CTA.Ahos.Query
Partial Public Class Ftran220Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLTipoEnte As String = ""
    Dim VLTarjeta As String = ""
    Dim VLProdfinal As String = ""
    Dim VLParametriza As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_3.Click, _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_0.Click, _cmdBoton_6.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTR As Integer = 0
        Dim VLContractual As String = ""
        Dim VTPromedio As Integer = 0
        Dim VTEmbargada As String = ""

        Select Case Index
            Case 0

                If mskCuenta.ClipText <> "" Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "220")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                    If VGCodPais = "CO" Then
                        VTR = COBISMessageBox.Show(FMLoadResString(2257), FMLoadResString(500092), COBISMessageBox.COBISButtons.YesNo)

                        If VTR = System.Windows.Forms.DialogResult.Yes Then
                            PMPasoValores(sqlconn, "@i_escliente", 0, SQLCHAR, "S")
                        Else
                            PMPasoValores(sqlconn, "@i_escliente", 0, SQLCHAR, "N")
                        End If
                    End If
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_con_ahr_mon", True, FMLoadResString(502522) & " " & "[" & mskCuenta.Text & "]") Then
                        PMMapeaObjetoAB(sqlconn, lblDescripcion(1), lblDescripcion(2))
                        PMMapeaObjetoAB(sqlconn, lblDescripcion(3), lblDescripcion(4))
                        PMMapeaObjetoAB(sqlconn, lblDescripcion(5), lblDescripcion(6))
                        PMMapeaObjetoAB(sqlconn, lblDescripcion(7), lblDescripcion(8))
                        PMMapeaObjetoAB(sqlconn, lblDescripcion(9), lblDescripcion(10))
                        PMMapeaObjetoAB(sqlconn, lblDescripcion(11), lblDescripcion(12))
                        PMMapeaObjetoAB(sqlconn, lblDescripcion(38), lblDescripcion(37))
                        PMMapeaVariable(sqlconn, VLContractual)
                        PMMapeaVariable(sqlconn, VLTipoEnte)
                        If VGCodPais <> "CO" Then
                            PMMapeaObjetoAB(sqlconn, lblDescripcion(57), lblDescripcion(58))
                        End If
                        Dim VTArreglo(46) As String
                        FMMapeaArreglo(sqlconn, VTArreglo)
                        PMChequea(sqlconn)
                        For i As Integer = 1 To 16
                            lblDescripcion(i + 14).Text = VTArreglo(i)
                        Next i
                        VTPromedio = 0
                        For i As Integer = 23 To 28
                            VTPromedio += CDec(lblDescripcion(i).Text)
                        Next i
                        lblDescripcion(13).Text = VTArreglo(22)
                        lblDescripcion(14).Text = VTArreglo(28)
                        lblDescripcion(40).Text = StringsHelper.Format(VTPromedio / 6, "#,##0.00")
                        lblDescripcion(31).Text = VTArreglo(17)
                        lblDescripcion(32).Text = VTArreglo(18)
                        lblDescripcion(33).Text = VTArreglo(19)
                        lblDescripcion(34).Text = VTArreglo(20)
                        lblDescripcion(35).Text = VTArreglo(21)
                        lblDescripcion(36).Text = VTArreglo(25)
                        lblDescripcion(39).Text = VTArreglo(26)
                        lblDescripcion(41).Text = VTArreglo(8)
                        lblDescripcion(43).Text = VTArreglo(28)
                        lblDescripcion(59).Text = VTArreglo(30)
                        lblDescripcion(60).Text = VTArreglo(42)
                        lblDescripcion(61).Text = VTArreglo(43)
                        Lblalianza.Text = VTArreglo(44)
                        lbldesalianza.Text = VTArreglo(45)
                        VTEmbargada = VTArreglo(29)
                        lblDescripcion(44).Text = VTArreglo(21)
                        For i As Integer = 30 To 34
                            lblDescripcion(i + 15).Text = VTArreglo(i)
                        Next i
                        lblDescripcion(50).Text = VTArreglo(19)
                        For i As Integer = 35 To 39
                            lblDescripcion(i + 16).Text = VTArreglo(i)
                        Next i
                        lblDescripcion(56).Text = VTArreglo(40)
                        cmdBoton(3).Enabled = True
                        mskCuenta.Enabled = False
                        If VTEmbargada <> "N" Then
                            lblDescripcion(42).Visible = True
                            lblDescripcion(42).Text = FMLoadResString(502412) '"CTA. CON EMBARGO"
                        Else
                            lblDescripcion(42).Visible = False
                            lblDescripcion(42).Text = ""
                        End If
                        If VLContractual = "S" Then
                            cmdBoton(6).Enabled = True
                        End If
                        cmdBoton(0).Enabled = False
                        cmdBoton(7).Enabled = True
                    Else
                        PMChequea(sqlconn) 'JSA
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(501337), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "747")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "Q")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_relacion_cta_canal", True, FMLoadResString(2249)) Then
                    PMMapeaVariable(sqlconn, VLTarjeta)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn) 'JSA
                    Exit Sub
                End If
                If VLTarjeta = "S" Then
                    optTarjetaDebito(0).Checked = True
                Else
                    optTarjetaDebito(1).Checked = True
                End If
            Case 1
                PLLimpiar()
            Case 2
                Me.Close()
            Case 3
                PLImprimir()
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
            Case 6
                PLBuscar_marca()
            Case 7
                GeneraDatosExcel()
        End Select
        PLTSEstado()
    End Sub

    Private Sub PLLimpiar()
        For i As Integer = 1 To 61
            lblDescripcion(i).Text = ""
        Next i
        lblDescripcion(42).Visible = False
        cmdBoton(0).Enabled = True
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = False
        cmdBoton(7).Enabled = False
        frmhistcredeb.Visible = False 'JSA
        frmhistdeb.Visible = False
        frmhistcre.Visible = False
        Lblalianza.Text = ""
        lbldesalianza.Text = ""
    End Sub
    Private Sub GeneraDatosExcel()
        Dim XlsApl As Excel.Application
        Dim xlsLibro As Excel.Workbook
        Dim xlhoja As Excel.Worksheet
        Dim ind As Int16 = 0
        XlsApl = New Excel.Application()
        XlsApl.Visible = True
        XlsApl.Caption = FMLoadResString(509517)
        XlsApl.Workbooks.Add()
        xlsLibro = XlsApl.ActiveWorkbook
        xlhoja = xlsLibro.Worksheets.Add()
        xlhoja.Name = FMLoadResString(1107)

        'CABECERAS
        xlsLibro = GenerarCabecerasExcel(xlsLibro)
        xlsLibro.Worksheets(FMLoadResString(1107)).Rows("1:1", Type.Missing).Select()
        XlsApl.Selection.Interior.ColorIndex = 37
        XlsApl.Selection.Interior.Pattern = Excel.Constants.xlSolid
        XlsApl.Selection.Font.Bold = True
        XlsApl.Selection.Borders(Excel.XlBordersIndex.xlInsideVertical).LineStyle = Excel.Constants.xlNone
        XlsApl.Cells.Select()
        XlsApl.Range("E1").Activate()
        XlsApl.Cells.EntireColumn.AutoFit()
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 7).NumberFormat = "MM/dd/yyyy;@"

        'Contenido
        'GENERAL
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 1).Value2 = mskCuenta.Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 2).Value2 = lblDescripcion(0).Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 3).Value2 = lblDescripcion(8).Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 4).Value2 = lblDescripcion(2).Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 5).Value2 = lblDescripcion(6).Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 6).Value2 = lblDescripcion(12).Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 7).Value2 = lblDescripcion(37).Text

        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 8).Value2 = lblDescripcion(30).Text

        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 9).Value2 = lblDescripcion(4).Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 10).Value2 = lblDescripcion(10).Text
        If optTarjetaDebito(0).Checked Then
            xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 11).Value2 = "SI"
        Else
            xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 11).Value2 = "NO"
        End If
        'RESERVAS
        If VGOcucol <> "S" Then
            xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 12).Value2 = lblDescripcion(15).Text
            xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 13).Value2 = lblDescripcion(16).Text
        Else
            ind = 2
        End If
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 14 - ind).Value2 = lblDescripcion(17).Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 15 - ind).Value2 = lblDescripcion(18).Text
        'SALDOS
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 16 - ind).Value2 = lblDescripcion(23).Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 17 - ind).Value2 = lblDescripcion(24).Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 18 - ind).Value2 = lblDescripcion(25).Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 19 - ind).Value2 = lblDescripcion(26).Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 20 - ind).Value2 = lblDescripcion(27).Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 21 - ind).Value2 = lblDescripcion(28).Text
        'DEBITOS
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 22 - ind).Value2 = lblDescripcion(34).Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 23 - ind).Value2 = lblDescripcion(13).Text
        'CREDITOS
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 24 - ind).Value2 = lblDescripcion(32).Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 25 - ind).Value2 = lblDescripcion(33).Text
        'PROMEDIOS
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 26 - ind).Value2 = lblDescripcion(50).Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 27 - ind).Value2 = lblDescripcion(51).Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 28 - ind).Value2 = lblDescripcion(52).Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 29 - ind).Value2 = lblDescripcion(53).Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 30 - ind).Value2 = lblDescripcion(54).Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 31 - ind).Value2 = lblDescripcion(55).Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 32 - ind).Value2 = lblDescripcion(40).Text
        'MONTOS
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 33 - ind).Value2 = lblDescripcion(29).Text
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(2, 34 - ind).Value2 = If(lblDescripcion(14).Text = "", "0", lblDescripcion(14).Text)

        XlsApl.Selection.Borders(Excel.XlBordersIndex.xlInsideVertical).LineStyle = Excel.Constants.xlNone
        XlsApl.Cells.Select()
        XlsApl.Range("E1").Activate()
        XlsApl.Cells.EntireColumn.AutoFit()
    End Sub

    Private Function GenerarCabecerasExcel(ByRef xlsLibro As Excel.Workbook) As Excel.Workbook
        Dim ind As Int16 = 0
        'Cabeceras
        'GENERAL
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 1).Value2 = FMLoadResString(1108).ToString 'No. de cuenta ahorro
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 2).Value2 = FMLoadResString(501217).ToString 'Nombre de la cuenta
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 3).Value2 = FMLoadResString(1109).ToString 'Oficial cta.
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 4).Value2 = FMLoadResString(509037).ToString 'Moneda
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 5).Value2 = FMLoadResString(509277).ToString 'Categoría
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 6).Value2 = FMLoadResString(1110).ToString 'Capitalización
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 7).Value2 = FMLoadResString(1111).ToString 'Prod. Banc.
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 8).Value2 = FMLoadResString(1112).ToString 'Último mov.
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 9).Value2 = FMLoadResString(502399).ToString 'Estado
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 10).Value2 = FMLoadResString(500778).ToString 'T. Prom.
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 11).Value2 = FMLoadResString(1113).ToString 'Tarj. Deb.
        'RESERVAS
        If VGOcucol <> "S" Then
            xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 12).Value2 = FMLoadResString(1114).ToString 'Chq. Exterior
            xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 13).Value2 = FMLoadResString(1115).ToString 'Chq. Exterior hoy
        Else
            ind = 2
        End If
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 14 - ind).Value2 = FMLoadResString(1116).ToString 'Libera prox. Día
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 15 - ind).Value2 = FMLoadResString(1117).ToString 'A liberar hoy
        'SALDOS
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 16 - ind).Value2 = FMLoadResString(1118).ToString 'Disponible
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 17 - ind).Value2 = FMLoadResString(1119).ToString 'Prom. Disp.
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 18 - ind).Value2 = FMLoadResString(1120).ToString 'Sld. Contable
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 19 - ind).Value2 = FMLoadResString(1121).ToString 'Disp. A girar
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 20 - ind).Value2 = FMLoadResString(1122).ToString 'Interés mes
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 21 - ind).Value2 = FMLoadResString(1123).ToString 'Mant. Valor
        'DEBITOS
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 22 - ind).Value2 = FMLoadResString(1124).ToString 'Deb. Hoy
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 23 - ind).Value2 = FMLoadResString(1125).ToString 'Deb. Mes
        'CREDITOS
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 24 - ind).Value2 = FMLoadResString(1126).ToString 'Cred. Hoy
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 25 - ind).Value2 = FMLoadResString(1127).ToString 'Cred. Mes
        'PROMEDIOS
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 26 - ind).Value2 = FMLoadResString(1128).ToString 'Prom. 1
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 27 - ind).Value2 = FMLoadResString(1129).ToString 'Prom. 2
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 28 - ind).Value2 = FMLoadResString(1131).ToString 'Prom. 3
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 29 - ind).Value2 = FMLoadResString(1132).ToString 'Prom. 4
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 30 - ind).Value2 = FMLoadResString(1133).ToString 'Prom. 5
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 31 - ind).Value2 = FMLoadResString(1134).ToString 'Prom. 6
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 32 - ind).Value2 = FMLoadResString(1135).ToString 'Prom. P
        'MONTOS
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 33 - ind).Value2 = FMLoadResString(1136).ToString 'Montos bloqueados
        xlsLibro.Worksheets(FMLoadResString(1107)).Cells(1, 34 - ind).Value2 = FMLoadResString(1130).ToString 'Monto embargado

        GenerarCabecerasExcel = xlsLibro
    End Function

    Private Sub Ftran220_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        Me.Left = 0
        Me.Top = 0
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub PLInicializar()
        MyAppGlobals.AppActiveForm = ""
        mskCuenta.Mask = VGMascaraCtaAho
        Dim eventSender As Object = Nothing
        Dim eventArgs As EventArgs = Nothing
        mskCuenta_Leave(eventSender, eventArgs)
        cmdBoton(7).Enabled = False
        CargaParametros("1579", "Q", "3", "AHO", "OCUCOL", 3)
        If VGOcucol = "S" Then
            Label5.Visible = False
            Lblalianza.Visible = False
            lbldesalianza.Visible = False
            lblEtiqueta(5).Visible = False
            lblDescripcion(16).Visible = False
            lblEtiqueta(8).Visible = False
            lblDescripcion(15).Visible = False
        End If
        If VGCodPais = "CO" Then
            lblEtiqueta(55).Visible = False
            lblDescripcion(57).Visible = False
            lblDescripcion(58).Visible = False
            lblEtiqueta(57).Visible = False
            lblDescripcion(61).Visible = False
            lblEtiqueta(71).Visible = False
            lblDescripcion(60).Visible = False
        End If
        Me.Text = FMLoadResString(509517)
    End Sub
    Private Sub Ftran220_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub frmhistcre_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles frmhistcre.Click
        frmhistcredeb.Visible = False 'JSA
        frmhistcre.Visible = False
    End Sub

    Private Sub frmhistdeb_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles frmhistdeb.Click
        frmhistcredeb.Visible = False 'JSA
        frmhistdeb.Visible = False
    End Sub

    Private Sub lblEtiqueta_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _lblEtiqueta_52.Click, _lblEtiqueta_51.Click, _lblEtiqueta_50.Click, _lblEtiqueta_49.Click, _lblEtiqueta_48.Click, _lblEtiqueta_47.Click, _lblEtiqueta_46.Click, _lblEtiqueta_45.Click, _lblEtiqueta_44.Click, _lblEtiqueta_43.Click, _lblEtiqueta_42.Click, _lblEtiqueta_41.Click, _lblEtiqueta_57.Click, _lblEtiqueta_71.Click, _lblEtiqueta_37.Click, _lblEtiqueta_56.Click, _lblEtiqueta_55.Click, _lblEtiqueta_54.Click, _lblEtiqueta_40.Click, _lblEtiqueta_39.Click, _lblEtiqueta_36.Click, _lblEtiqueta_35.Click, _lblEtiqueta_53.Click, _lblEtiqueta_33.Click, _lblEtiqueta_22.Click, _lblEtiqueta_26.Click, _lblEtiqueta_29.Click, _lblEtiqueta_30.Click, _lblEtiqueta_38.Click, _lblEtiqueta_20.Click, _lblEtiqueta_19.Click, _lblEtiqueta_25.Click, _lblEtiqueta_28.Click, _lblEtiqueta_27.Click, _lblEtiqueta_9.Click, _lblEtiqueta_7.Click, _lblEtiqueta_5.Click, _lblEtiqueta_24.Click, _lblEtiqueta_23.Click, _lblEtiqueta_18.Click, _lblEtiqueta_17.Click, _lblEtiqueta_16.Click, _lblEtiqueta_15.Click, _lblEtiqueta_14.Click, _lblEtiqueta_13.Click, _lblEtiqueta_12.Click, _lblEtiqueta_11.Click, _lblEtiqueta_10.Click, _lblEtiqueta_8.Click, _lblEtiqueta_4.Click, _lblEtiqueta_3.Click, _lblEtiqueta_2.Click, _lblEtiqueta_1.Click, _lblEtiqueta_31.Click, _lblEtiqueta_32.Click, _lblEtiqueta_34.Click, _lblEtiqueta_0.Click, _lblEtiqueta_6.Click, _lblEtiqueta_21.Click
        Dim Index As Integer = Array.IndexOf(lblEtiqueta, eventSender)
        Select Case Index
            Case 22
                If frmhistdeb.Visible Then
                    frmhistdeb.Visible = False
                End If
                frmhistcredeb.Visible = True 'JSA
                frmhistcre.Visible = True
            Case 38
                If frmhistcre.Visible Then
                    frmhistcre.Visible = False
                End If
                frmhistcredeb.Visible = True 'JSA
                frmhistdeb.Visible = True
        End Select
    End Sub

    Private Sub lblEtiqueta_MouseMove(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _lblEtiqueta_52.MouseMove, _lblEtiqueta_51.MouseMove, _lblEtiqueta_50.MouseMove, _lblEtiqueta_49.MouseMove, _lblEtiqueta_48.MouseMove, _lblEtiqueta_47.MouseMove, _lblEtiqueta_46.MouseMove, _lblEtiqueta_45.MouseMove, _lblEtiqueta_44.MouseMove, _lblEtiqueta_43.MouseMove, _lblEtiqueta_42.MouseMove, _lblEtiqueta_41.MouseMove, _lblEtiqueta_57.MouseMove, _lblEtiqueta_71.MouseMove, _lblEtiqueta_37.MouseMove, _lblEtiqueta_56.MouseMove, _lblEtiqueta_55.MouseMove, _lblEtiqueta_54.MouseMove, _lblEtiqueta_40.MouseMove, _lblEtiqueta_39.MouseMove, _lblEtiqueta_36.MouseMove, _lblEtiqueta_35.MouseMove, _lblEtiqueta_53.MouseMove, _lblEtiqueta_33.MouseMove, _lblEtiqueta_22.MouseMove, _lblEtiqueta_26.MouseMove, _lblEtiqueta_29.MouseMove, _lblEtiqueta_30.MouseMove, _lblEtiqueta_38.MouseMove, _lblEtiqueta_20.MouseMove, _lblEtiqueta_19.MouseMove, _lblEtiqueta_25.MouseMove, _lblEtiqueta_28.MouseMove, _lblEtiqueta_27.MouseMove, _lblEtiqueta_9.MouseMove, _lblEtiqueta_7.MouseMove, _lblEtiqueta_5.MouseMove, _lblEtiqueta_24.MouseMove, _lblEtiqueta_23.MouseMove, _lblEtiqueta_18.MouseMove, _lblEtiqueta_17.MouseMove, _lblEtiqueta_16.MouseMove, _lblEtiqueta_15.MouseMove, _lblEtiqueta_14.MouseMove, _lblEtiqueta_13.MouseMove, _lblEtiqueta_12.MouseMove, _lblEtiqueta_11.MouseMove, _lblEtiqueta_10.MouseMove, _lblEtiqueta_8.MouseMove, _lblEtiqueta_4.MouseMove, _lblEtiqueta_3.MouseMove, _lblEtiqueta_2.MouseMove, _lblEtiqueta_1.MouseMove, _lblEtiqueta_31.MouseMove, _lblEtiqueta_32.MouseMove, _lblEtiqueta_34.MouseMove, _lblEtiqueta_0.MouseMove, _lblEtiqueta_6.MouseMove, _lblEtiqueta_21.MouseMove
        Dim Index As Integer = Array.IndexOf(lblEtiqueta, eventSender)
        Select Case Index
            Case 22
                ToolTip1.SetToolTip(lblEtiqueta(22), FMLoadResString(502394))
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500794))
            Case 38
                ToolTip1.SetToolTip(lblEtiqueta(38), FMLoadResString(502393))
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500795))
        End Select
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2316))
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
    End Sub

    Private Sub mskCuenta_KeyDown(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles mskCuenta.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode = VGTeclaAyuda Then
            ReDim VGADatosO(1)
            FHelpCta.ShowPopup(Me)
            If VGADatosO(0).Trim() <> "" Then
                mskCuenta.Text = VGADatosO(0)
            End If
            FHelpCta.Dispose()
        End If
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
                        cmdBoton_Click(cmdBoton(1), New EventArgs())
                        Exit Sub
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    cmdBoton_Click(cmdBoton(1), New EventArgs())
                    Exit Sub
                End If
            End If
            PLTSEstado()
        Catch exc As System.Exception
            COBISMessageBox.Show(exc.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)

        End Try
    End Sub

    Private Sub PLImprimir()
        Dim VLDiferido As Decimal = 0
        Dim VLProdbanc As String = ""
        If COBISMessageBox.Show(FMLoadResString(500796), FMLoadResString(500092), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question) = System.Windows.Forms.DialogResult.Yes Then
            Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
            FMCabeceraReporte(VGBanco, DateTimeHelper.ToString(DateTime.Today), FMLoadResString(509350), DateTimeHelper.ToString(DateTimeHelper.Time), Me.Text, VGFecha, CStr(1))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 8
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509261), mskCuenta.Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509351), VGFecha)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509352), lblDescripcion(0).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            VLProdbanc = lblDescripcion(38).Text & " - " & lblDescripcion(37).Text
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509263), VLProdbanc)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509265), lblDescripcion(19).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509266), lblDescripcion(20).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509354), lblDescripcion(21).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            VLDiferido = CDec(lblDescripcion(18).Text) + CDec(lblDescripcion(17).Text) + CDec(lblDescripcion(15).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509355), StringsHelper.Format(VLDiferido, "#,##0.00"))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509270), StringsHelper.Format(lblDescripcion(29).Text, "#,##0.00"))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509356), StringsHelper.Format(lblDescripcion(14).Text, "#,##0.00"))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            If VGCodPais <> "CO" Then
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509357), lblDescripcion(60).Text)
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), FMLoadResString(509358), lblDescripcion(61).Text)
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            End If
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(New String("_", 124))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), VGLogin)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509271))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509272))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.EndDoc()
            Me.Cursor = System.Windows.Forms.Cursors.Default
        End If
    End Sub

    Private Sub PLBuscar_marca()
        Dim VLParametro(15, 2) As String
        Dim VTCambiaCategoria As String = ""
        Dim VTContractual As String = ""

        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "PAHCT")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, "AHO")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(2244)) Then
            FMMapeaMatriz(sqlconn, VLParametro)
            PMChequea(sqlconn)
            If VLParametro(6, 1) = lblDescripcion(38).Text Then
                VGContractual = "S"
            Else
                VGContractual = "N"
            End If
        Else
            PMChequea(sqlconn)
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "PAHPR")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, "AHO")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(2244)) Then
            FMMapeaMatriz(sqlconn, VLParametro)
            PMChequea(sqlconn)
            If VLParametro(6, 1) = lblDescripcion(38).Text Then
                VGProgresivo = "S"
            Else
                VGProgresivo = "N"
            End If
        Else
            PMChequea(sqlconn)
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "CAMCAT")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, "AHO")
        FMLoadResString(2547)
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(2244)) Then
            FMMapeaMatriz(sqlconn, VLParametro)
            PMChequea(sqlconn)
            If VLParametro(3, 1) = lblDescripcion(5).Text Then
                VTCambiaCategoria = "S"
            Else
                VTCambiaCategoria = "N"
            End If
        Else
            PMChequea(sqlconn)
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(734))
        PMPasoValores(sqlconn, "@i_categoria", 0, SQLVARCHAR, lblDescripcion(5).Text)
        PMPasoValores(sqlconn, "@i_prodban", 0, SQLVARCHAR, lblDescripcion(38).Text)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
        PMPasoValores(sqlconn, "@i_tipoente", 0, SQLCHAR, VLTipoEnte)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mto_aho_contractual", True, FMLoadResString(2245)) Then
            PMMapeaVariable(sqlconn, VTContractual)
            PMMapeaVariable(sqlconn, VLProdfinal)
            PMMapeaVariable(sqlconn, VLParametriza)
            PMChequea(sqlconn)
            If VGContractual = "S" Or VGProgresivo = "S" Then
                If StringsHelper.ToDoubleSafe(VLParametriza) <> 0 Or VTCambiaCategoria = "S" Then
                    VGcategoria = lblDescripcion(14).Text
                    VGprofinal = VLProdfinal
                    VGCuenta = mskCuenta.ClipText
                    VGOrigen = "1"
                    Ftran434.ShowPopup(Me)
                Else
                    FMLoadResString(2547)
                    COBISMessageBox.Show(FMLoadResString(2246) & " " & VLProdfinal & " " & FMLoadResString(2246) & " " & lblDescripcion(14).Text & " ", "Mensaje de Error", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                End If
                Ftran434.Dispose()
            Else
                VGCancelar = "N"
            End If
        Else
            PMChequea(sqlconn) 'JSA
        End If
    End Sub

    Private Sub PLTSEstado()
        TSBImprimir.Enabled = _cmdBoton_3.Enabled
        TSBImprimir.Visible = _cmdBoton_3.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBSiguientes.Enabled = _cmdBoton_6.Enabled
        TSBSiguientes.Visible = _cmdBoton_6.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBExcel.Enabled = _cmdBoton_7.Enabled
        TSBExcel.Visible = _cmdBoton_7.Visible
    End Sub

    Private Sub TSBFirmas_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBFirmas.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBExcel_Click(sender As Object, e As EventArgs) Handles TSBExcel.Click
        If _cmdBoton_7.Enabled Then cmdBoton_Click(_cmdBoton_7, e)
    End Sub
End Class


