Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class Ftran434Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Const IDYES As DialogResult = System.Windows.Forms.DialogResult.Yes
    Dim CGTeclaMenos As Integer = 0
    Dim VLcuotaMin As String = ""
    Dim VLPlazo As String = ""
    Dim VTPlanPago As String = ""
    Dim VLEstado As String = ""
    Dim VLEstado_Cta As String = ""
    Dim VLCuotas As Integer = 0
    Dim SecGrid As Integer = 0
    Dim VLImprimir As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_4.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                PLTransmitir()
            Case 1
                PLCancelar()
            Case 2
                Me.Close()
            Case 3
                PLBuscar()
            Case 4
                PLImprimir()
        End Select
    End Sub

    Private Sub Ftran434_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_3.Enabled
        TSBBuscar.Visible = _cmdBoton_3.Visible
        TSBAceptar.Enabled = _cmdBoton_0.Enabled
        TSBAceptar.Visible = _cmdBoton_0.Visible
        TSBCancelar.Enabled = _cmdBoton_1.Enabled
        TSBCancelar.Visible = _cmdBoton_1.Visible
        TSBImprimir.Enabled = _cmdBoton_4.Enabled
        TSBImprimir.Visible = _cmdBoton_4.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBAceptar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBAceptar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBCancelar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCancelar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Public Sub PLInicializar()
        txtPlazo.Enabled = False
        mskMonto.Enabled = False
        If VGOrigen = "0" Then
            PFormas.Height = 254
            Ftran434.Height = 298 - 200
            PFormas.Width = 539
            Ftran434.Width = 558
            lbldiasmora(4).Visible = False
            lblDescripcion(3).Visible = False
            lblplazoacum(9).Visible = False
            lblDescripcion(3).Visible = False
            lblDescripcion(4).Visible = False
            lblDescripcion(5).Text = VGNombreCuenta
            mskCuenta.Enabled = True
            VGCuenta = ""
            Me.mskCuenta.Mask = VGMascaraCtaAho
            Me.mskCuenta.Text = FMMascara(VGCuenta, VGMascaraCtaAho)
            mskCuenta_Leave(mskCuenta, New EventArgs())
            mskCuenta.Enabled = False
            GroupBox1.Visible = False
            ' grdRegistros.Visible = False
            cmdBoton(2).Visible = False
            cmdBoton(3).Visible = False
            cmdBoton(4).Visible = False
            VGCancelar = "N"
            PLBuscar_parametro()
        End If
        If VGOrigen = "1" Then
            If VGContractual = "S" Then
                PFormas.Height = 254
                Ftran434.Height = 298 - 200
                PFormas.Width = 539
                Ftran434.Width = 558
                lbldiasmora(4).Visible = True
                lblDescripcion(3).Visible = True
                lblplazoacum(9).Visible = True
                lblDescripcion(4).Visible = True
                lblDescripcion(5).Text = VGNombreCuenta
                mskCuenta.Enabled = True
                Me.mskCuenta.Mask = VGMascaraCtaAho
                Me.mskCuenta.Text = FMMascara(VGCuenta, VGMascaraCtaAho)
                mskCuenta_Leave(mskCuenta, New EventArgs())
                mskCuenta.Enabled = False
                GroupBox1.Visible = False
                'lblEtiqueta(0).Visible = False
                '   grdRegistros.Visible = False
                cmdBoton(0).Visible = False
                cmdBoton(1).Visible = False
                cmdBoton(3).Visible = False
                cmdBoton(4).Visible = False
                cmdBoton(2).Visible = True
                cmdBoton(2).Enabled = True
                cmdBoton(2).Refresh()
                If VGCuenta = "" Then
                    PLBuscar_parametro()
                Else
                    PLBuscar_Cuenta()
                End If
            Else
                If VGProgresivo = "S" Then
                    PFormas.Height = 415
                    Ftran434.Height = 463
                    PFormas.Width = 539
                    Ftran434.Width = 558
                    GroupBox1.Visible = True
                    'lblEtiqueta(0).Visible = true
                    ' grdRegistros.Visible = True
                    cmdBoton(0).Visible = False 'True
                    cmdBoton(1).Visible = False 'True
                    cmdBoton(2).Visible = True
                    cmdBoton(2).Enabled = True
                    cmdBoton(3).Enabled = True
                    txtPlazo.Enabled = False
                    mskMonto.Enabled = False
                    Me.mskCuenta.Mask = VGMascaraCtaAho
                    Me.mskCuenta.Text = FMMascara(VGCuenta, VGMascaraCtaAho)
                    mskCuenta_Leave(mskCuenta, New EventArgs())
                    'mskCuenta_Leave(mskCuenta, New EventArgs())
                    PLBuscar_Cuenta()
                End If
            End If
        End If
        PLTSEstado()
    End Sub

    Private Sub Ftran434_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub PLTransmitir()
        If Conversion.Val(VLPlazo) > Conversion.Val(txtPlazo.Text) Then
            COBISMessageBox.Show(FMLoadResString(508757), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) ' Meses Pactados Inferiores Plazo Mínimo del Producto
            txtPlazo.Focus()
            Exit Sub
        End If
        If Int(VLcuotaMin) > Int(mskMonto.Text) Then
            COBISMessageBox.Show(FMLoadResString(508758), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Cuota Pactada Inferior al Monto Mínimo
            mskMonto.Focus()
            Exit Sub
        End If
        VGPlazo = txtPlazo.Text
        VGDeposito = mskMonto.Text
        VGPuntos = txtCampo(3).Text
        VGPeriodicidad = txtCampo(4).Text
        VGMontoFinal = MskValor(1).Text
        VGEstado = "A"
        VGCuenta = ""
        Me.Close()
    End Sub

    Private Sub PLBuscar_parametro()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(4123))
        PMPasoValores(sqlconn, "@i_categoria", 0, SQLVARCHAR, VGcategoria)
        PMPasoValores(sqlconn, "@i_profinal", 0, SQLVARCHAR, VGprofinal)
        PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "S")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_producto_contractual", True, FMLoadResString(508759)) Then 'FMLoadResString(508759)) '  "Ok... Consulta de Servicios Marcados"
            Dim VTArreglo(20) As String
            FMMapeaArreglo(sqlconn, VTArreglo)
            PMChequea(sqlconn)
            txtCampo(0).Text = VTArreglo(19)
            lblDescripcion(0).Text = VTArreglo(20)
            txtCampo(1).Text = VTArreglo(3)
            lblDescripcion(1).Text = VTArreglo(4)
            txtPlazo.Text = VTArreglo(5)
            lblEtiqueta(3).Text = VTArreglo(6)
            mskMonto.Text = VTArreglo(7)
            lblEtiqueta(4).Text = VTArreglo(8)
            txtCampo(4).Text = VTArreglo(9)
            lblDescripcion(2).Text = VTArreglo(10)
            MskValor(1).Text = VTArreglo(11)
            txtCampo(3).Text = VTArreglo(14)
            VLEstado = VTArreglo(12)
            If VLEstado = "V" Then
                VGProdFinal = VTArreglo(1)
                VLcuotaMin = VTArreglo(7)
                VLPlazo = VTArreglo(5)
                If lblEtiqueta(4).Text = "S" Then
                    mskMonto.Enabled = True
                End If
                If lblEtiqueta(3).Text = "S" Then
                    txtPlazo.Enabled = True
                End If
            Else
                COBISMessageBox.Show(FMLoadResString(508758), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) ' Cuota Pactada Inferior al Monto Mínimo
                Exit Sub
            End If
        Else
            Me.Close()
        End If
    End Sub

    Private Sub PLBuscar_Cuenta()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(734))
        PMPasoValores(sqlconn, "@i_categoria", 0, SQLVARCHAR, VGcategoria)
        PMPasoValores(sqlconn, "@i_profinal", 0, SQLVARCHAR, VGprofinal)
        PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, VGCuenta)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mto_aho_contractual", True, FMLoadResString(508759)) Then ' ' FMLoadResString(508759))' Ok... Consulta de Servicios Marcados
            Dim VTArreglo(20) As String
            FMMapeaArreglo(sqlconn, VTArreglo)
            PMChequea(sqlconn)
            txtCampo(0).Text = VTArreglo(1)
            lblDescripcion(0).Text = VTArreglo(2)
            txtCampo(1).Text = VTArreglo(3)
            lblDescripcion(1).Text = VTArreglo(4)
            txtPlazo.Text = VTArreglo(5)
            mskMonto.Text = VTArreglo(6)
            txtCampo(4).Text = VTArreglo(7)
            lblDescripcion(2).Text = VTArreglo(8)
            MskValor(1).Text = VTArreglo(9)
            txtCampo(3).Text = VTArreglo(10)
            lblDescripcion(3).Text = VTArreglo(11)
            lblDescripcion(4).Text = VTArreglo(12)
            VLImprimir = VTArreglo(13)
            If VLImprimir = "S" Then
                cmdBoton(4).Visible = True
            End If
            VLcuotaMin = VTArreglo(7)
            VLPlazo = VTArreglo(5)
            If lblEtiqueta(4).Text = "S" Then
                mskMonto.Enabled = True
            End If
            If lblEtiqueta(3).Text = "S" Then
                txtPlazo.Enabled = True
            End If
        Else
            Me.Close()
        End If
    End Sub

    Private Sub PLCancelar()
        VGCancelar = "S"
        Me.Close()
    End Sub

    Private Sub mskMonto_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskMonto.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2455)) 'Valor del Tope
        mskMonto.SelStart = 0
        mskMonto.SelLength = Strings.Len(mskMonto.Text)
    End Sub

    Private Sub mskMonto_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskMonto.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If VGDecimales = "#,##0" Then
            If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                KeyAscii = 0
            End If
        Else
            If (KeyAscii <> 8) And (KeyAscii <> 46) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                KeyAscii = 0
            End If
        End If
        KeyAscii = FMValidarNumero(mskMonto.Text, 13, KeyAscii, "105")
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub mskMonto_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskMonto.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        If Conversion.Val(mskMonto.Text) <> StringsHelper.ToDoubleSafe(VLcuotaMin) Or txtPlazo.Text <> VLPlazo Then
            MskValor(1).Text = CDec(mskMonto.Text) * CDbl(txtPlazo.Text)
        End If
    End Sub

    Function FMValidarNumero(ByRef parValor As String, ByRef parLongitud As Integer, ByRef parcaracter As Integer, ByRef parNemonico As String) As Integer
        Dim VTSeparadorDecimal As String = "."
        Dim VTDecimal As Integer = 2
        If parcaracter = CGTeclaMenos Then
            Return 0
        End If
        If VTDecimal > 0 Then
            If (parValor.IndexOf(VTSeparadorDecimal) + 1) >= (parLongitud + (VTDecimal) + 1) Then
                Return 0
            Else
                Return parcaracter
            End If
        Else
            If parValor.Length >= parLongitud Then
                Return 0
            Else
                Return parcaracter
            End If
        End If
    End Function

    Private Sub PLBuscar()
        Dim VTPlanPago As String = ""
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "393")
        PMPasoValores(sqlconn, "@i_sec", 0, SQLINT2, "0")
        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, VGCuenta)
        PMPasoValores(sqlconn, "@i_frontn", 0, SQLCHAR, "S")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_imprime_plan_pago", True, FMLoadResString(508761)) Then '"Ok... Imprime Plan de Pagos"
            PMMapeaGrid(sqlconn, grdCabecera, False)
            PMAnchoColumnasGrid(grdCabecera)
            PMMapeaVariable(sqlconn, VTPlanPago)
            grdCabecera.Col = 6
            VLEstado_Cta = grdCabecera.CtlText
            If VLEstado_Cta <> "A" Then
                COBISMessageBox.Show(FMLoadResString(508760), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Estado de Cuenta NO Activo; No permite Impresion 
            Else
                PMMapeaGrid(sqlconn, grdRegistros, False)
                PMAnchoColumnasGrid(grdRegistros)
                PMChequea(sqlconn)
                VLCuotas = Int(txtPlazo.Text)
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                SecGrid = CInt(grdRegistros.CtlText)
                Do While (VLCuotas > SecGrid)
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "393")
                    PMPasoValores(sqlconn, "@i_sec", 0, SQLINT2, CStr(SecGrid))
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, VGCuenta)
                    PMPasoValores(sqlconn, "@i_frontn", 0, SQLCHAR, "S")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_imprime_plan_pago", True, FMLoadResString(508761)) Then '"Ok... Imprime Plan de Pagos"
                        PMMapeaGrid(sqlconn, grdRegistros, True)
                        PMAnchoColumnasGrid(grdRegistros)
                        PMChequea(sqlconn)
                    End If
                    grdRegistros.Row = grdRegistros.Rows - 1
                    grdRegistros.Col = 1
                    SecGrid = CInt(grdRegistros.CtlText)
                Loop
            End If
            If VLImprimir = "S" And VLEstado_Cta = "A" Then
                cmdBoton(4).Visible = True
                cmdBoton(4).Enabled = True

            End If
        End If
        PLTSEstado()
    End Sub

    Private Sub mskCuenta_Enter(sender As Object, e As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501874))
    End Sub

    Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Try
            If mskCuenta.ClipText <> "" Then
                If FMChequeaCtaAho(mskCuenta.ClipText) Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, VGCuenta)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_cerrada", 0, SQLCHAR, "C")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2237) & mskCuenta.Text & "]") Then 'Ok... Consulta la cuenta [
                        PMMapeaObjeto(sqlconn, lblDescripcion(5))
                        PMChequea(sqlconn)
                        cmdBoton(3).Enabled = True
                    Else
                        cmdBoton_Click(cmdBoton(1), New EventArgs())
                        Exit Sub
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'El dígito verificador de la cuenta de ahorros está incorrecto
                    cmdBoton_Click(cmdBoton(1), New EventArgs())
                    Exit Sub
                End If
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
        End Try
    End Sub

    Private Sub PLImprimir()
        Dim archivos As String = String.Empty
        Dim VTMsg As String = String.Empty
        Dim VTR As DialogResult
        Dim reportes As String = ""
        Dim tablas3 As DAO.Recordset
        Dim BaseDatos As DAO.Database
        Dim tablas1, tablas2 As DAO.Recordset
        If COBISMessageBox.Show(FMLoadResString(500440), FMLoadResString(500092), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question) = System.Windows.Forms.DialogResult.Yes Then '"Esta seguro de imprimir la consulta?"
            Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
            archivos = VGPath & "\SOCTAAHO.MDB"
            BaseDatos = DAO_DBEngine_definst.OpenDatabase(archivos)
            tablas1 = BaseDatos.OpenRecordset("ctacontractual")
            tablas2 = BaseDatos.OpenRecordset("datoscta")
            tablas3 = BaseDatos.OpenRecordset("cuotas")
            BaseDatos.Execute("delete from ctacontractual")
            BaseDatos.Execute("delete from datoscta")
            BaseDatos.Execute("delete from cuotas")
            tablas1.AddNew()
            tablas1.Fields("Cuenta").Value = VGCuenta
            tablas1.Fields("Categoria").Value = txtCampo(1).Text & "  " & lblDescripcion(1).Text
            tablas1.Fields("Plazo").Value = txtPlazo.Text
            tablas1.Fields("cuota").Value = mskMonto
            tablas1.Fields("fecha_rep").Value = VGFecha
            grdCabecera.Col = 4
            tablas1.Fields("Producto").Value = grdCabecera.CtlText
            grdCabecera.Col = 5
            tablas1.Fields("fecha_aper").Value = grdCabecera.CtlText
            tablas1.Update()
            tablas1.Close()
            For i As Integer = 1 To (grdCabecera.Rows - 1)
                grdCabecera.Row = i
                tablas2.AddNew()
                tablas2.Fields("Cuenta").Value = VGCuenta
                grdCabecera.Col = 1
                tablas2.Fields("nombres").Value = grdCabecera.CtlText
                grdCabecera.Col = 2
                tablas2.Fields("Cedula").Value = grdCabecera.CtlText
                grdCabecera.Col = 3
                tablas2.Fields("rol").Value = grdCabecera.CtlText
                tablas2.Update()
            Next i
            tablas2.Close()
            For i As Integer = 1 To (grdRegistros.Rows - 1)
                grdRegistros.Row = i
                tablas3.AddNew()
                tablas3.Fields("cuenta").Value = VGCuenta
                grdRegistros.Col = 1
                tablas3.Fields("cuota_num").Value = grdRegistros.CtlText
                grdRegistros.Col = 2
                tablas3.Fields("mes_ahorro").Value = grdRegistros.CtlText
                grdRegistros.Col = 3
                tablas3.Fields("monto").Value = grdRegistros.CtlText
                grdRegistros.Col = 4
                tablas3.Fields("saldo_esp").Value = grdRegistros.CtlText
                grdRegistros.Col = 5
                tablas3.Fields("saldo_mes").Value = grdRegistros.CtlText
                grdRegistros.Col = 6
                tablas3.Fields("diferencia").Value = grdRegistros.CtlText
                grdRegistros.Col = 7
                tablas3.Fields("estado").Value = grdRegistros.CtlText
                tablas3.Update()
            Next i
            tablas3.Close()
            BaseDatos.Close()
            VTMsg = FMLoadResString(508435) ' "Asegúrese de que la Impresora se encuentre lista. Desea continuar con la impresión?."
            VTR = COBISMsgBox.MsgBox(VTMsg, 36, FMLoadResString(508775)) 'Control de impresión de Datos
            If VTR = System.Windows.Forms.DialogResult.Yes Then
                If VTPlanPago = "S" Then
                    reportes = VGPath & "\PLANPAGAHO.RPT"
                Else
                    reportes = VGPath & "\EXTAHOCONT.RPT"
                End If
                rptReporte.ReportFileName = reportes
                rptReporte.DataFiles(0) = archivos
                rptReporte.Destination = COBISCorp.Framework.UI.Components.DestinationConstants.crptToWindow
                rptReporte.Action = 1
            End If
            Me.Cursor = System.Windows.Forms.Cursors.Default

        Else
            COBISMessageBox.Show(FMLoadResString(508776), FMLoadResString(500427), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information) 'No se genera impresion
            Me.Cursor = System.Windows.Forms.Cursors.Default
        End If
        Exit Sub
        COBISMessageBox.Show(FMLoadResString(508777) & Information.Err().Description, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Error en la Impresión del Reporte
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Exit Sub
    End Sub

    Private Sub txtPlazo_Enter(sender As Object, e As EventArgs) Handles txtPlazo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2435))
    End Sub

    Private Sub txtPlazo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtPlazo.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        If Conversion.Val(mskMonto.Text) <> StringsHelper.ToDoubleSafe("0.00") Then
            MskValor(1).Text = CDec(mskMonto.Text) * CDbl(txtPlazo.Text)
        End If
    End Sub

    Private Sub _txtCampo_0_Enter(sender As Object, e As EventArgs) Handles _txtCampo_0.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5048))
    End Sub

    Private Sub _txtCampo_0_Leave(sender As Object, e As EventArgs) Handles _txtCampo_0.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub _txtCampo_1_Enter(sender As Object, e As EventArgs) Handles _txtCampo_1.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501177))
    End Sub

    Private Sub _txtCampo_1_Leave(sender As Object, e As EventArgs) Handles _txtCampo_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub _txtCampo_4_Enter(sender As Object, e As EventArgs) Handles _txtCampo_4.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5088))
    End Sub

    Private Sub _txtCampo_4_Leave(sender As Object, e As EventArgs) Handles _txtCampo_4.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub _txtCampo_3_Enter(sender As Object, e As EventArgs) Handles _txtCampo_3.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2431))
    End Sub

    Private Sub _txtCampo_3_Leave(sender As Object, e As EventArgs) Handles _txtCampo_3.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub _MskValor_1_Enter(sender As Object, e As EventArgs) Handles _MskValor_1.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2433))
    End Sub

    Private Sub _MskValor_1_Leave(sender As Object, e As EventArgs) Handles _MskValor_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_DblClick(sender As Object, e As EventArgs) Handles grdRegistros.DblClick
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2437))
    End Sub

    Private Sub grdRegistros_Leave(sender As Object, e As EventArgs) Handles grdRegistros.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

End Class


