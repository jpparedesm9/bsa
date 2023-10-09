Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Class FTran2913Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLPaso As Integer = 0
    Dim VLTabla As String = ""
    Dim VLTOpera As String = ""
    Dim VLTEfect As String = ""
    Dim VLTCHL As String = ""
    Dim VLTCHP As String = ""
    Dim VLTIva As String = ""
    Dim VLTGasto As String = ""
    Dim VLNDNC_AH As String = ""
    Dim VLNDNC_CC As String = ""
    Dim VLTCont As Integer = 0

    Private Sub Limpia_Caundnc()
        chk_ndncaho.Checked = False
        chk_ndncc.Checked = False
        txtCauaho(0).Text = ""
        txtCauaho(1).Text = ""
        Lblcauho(0).Text = ""
        Lblcauho(1).Text = ""
        txtCaucc(0).Text = ""
        txtCaucc(1).Text = ""
        Lblcaucc(0).Text = ""
        Lblcaucc(1).Text = ""
    End Sub

    Private Function Error_causales_ndnc() As Boolean
        If Optndnc.Checked Then
            If Not chk_ndncaho.Checked And Not chk_ndncc.Checked Then
                'Se debe seleccionar nd/nc de ahorros o corrientes
                COBISMessageBox.Show(FMLoadResString(502671), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Return True
            End If
            If chk_ndncaho.Checked Then
                If txtCauaho(0).Text = "" Or txtCauaho(1).Text = "" Then
                    'Debe ingresar las causales CREA y REV de nd/nc de ahorro
                    COBISMessageBox.Show(FMLoadResString(502672), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    Return True
                End If
            End If
            If chk_ndncc.Checked Then
                If txtCaucc(0).Text = "" Or txtCaucc(1).Text = "" Then
                    'Debe ingresar las causales CREA y REV de corrientes
                    COBISMessageBox.Show(FMLoadResString(502673), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    Return True
                End If
            End If
        End If
        Return False
    End Function

    Private Sub Habilita_Caundnc(ByRef Indicador As String)
        If Indicador = "S" Then
            Frame4(2).Enabled = True
            chk_ndncaho.Enabled = True
            chk_ndncc.Enabled = True
        End If
        If Indicador = "N" Then
            Frame4(2).Enabled = False
            chk_ndncaho.Enabled = False
            chk_ndncc.Enabled = False
        End If
    End Sub

    Private Sub chk_ndncaho_CheckStateChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles chk_ndncaho.CheckedChanged
        Dim Value As Integer = chk_ndncaho.Checked
        chk_ndncaho_ClickHelper(Value)
    End Sub

    Private Sub chk_ndncaho_ClickHelper(ByRef Value As Integer)
        If Not Value Then
            txtCauaho(0).Text = ""
            txtCauaho(1).Text = ""
            Lblcauho(0).Text = ""
            Lblcauho(1).Text = ""
        End If
    End Sub

    Private Sub chk_ndncc_CheckStateChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles chk_ndncc.CheckedChanged
        Dim Value As Integer = chk_ndncc.Checked
        chk_ndncc_ClickHelper(Value)
    End Sub

    Private Sub chk_ndncc_ClickHelper(ByRef Value As Integer)
        If Not Value Then
            txtCaucc(0).Text = ""
            txtCaucc(1).Text = ""
            Lblcaucc(0).Text = ""
            Lblcaucc(1).Text = ""
        End If
    End Sub

    Private Sub CmbPrograma_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles CmbPrograma.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502674)) 'Programa Interfaz
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_6.Click, _cmdBoton_5.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_4.Click, _cmdBoton_1.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                Me.Close()
            Case 1
                PLLimpiar()
            Case 2
                PLEliminar()
            Case 3
                PLCrear()
            Case 4
                PLActualizar()
            Case 5
                PLSiguientes()
            Case 6
                PLBuscar()
        End Select
        PLTSEstado()
    End Sub

    Private Sub FTran2913_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PLInicializar()
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLTSEstado()
    End Sub

    Private Sub PLInicializar()
        cmdBoton(5).Enabled = False
        txtCampo(0).Text = ""
        lblDescripcion.Text = ""
        mskValor.Text = VGDecimales
        mskValor.Text = StringsHelper.Format(0, VGDecimales)
        Habilita_Caundnc("N")
        VLTabla = "cc_interfaz_IE"
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VLTabla)
        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502977)) Then 'Ok... Consulta de parámetros
            PMMapeaGrid(sqlconn, grdInterfaz, False)
            PMChequea(sqlconn)
            grdInterfaz.Col = 2
            CmbPrograma.Items.Insert(0, "")
            For i As Integer = 0 To grdInterfaz.Rows - 2
                grdInterfaz.Row = i + 1
                CmbPrograma.Items.Insert(i + 1, grdInterfaz.CtlText)
            Next i
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub FTran2913_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdRegistros.DblClick
        If grdRegistros.Rows <= 2 Then
            grdRegistros.Row = 1
            grdRegistros.Col = 1
            If grdRegistros.CtlText.Trim() = "" Then
                'No existen causales otros Ingresos/Egresos
                COBISMessageBox.Show(FMLoadResString(503025), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        End If
        grdRegistros.Col = 1
        txtCampo(0).Text = grdRegistros.CtlText
        txtCampo(0).Enabled = False
        grdRegistros.Col = 2
        lblDescripcion.Text = grdRegistros.CtlText
        grdRegistros.Col = 3
        chkIva.Checked = grdRegistros.CtlText = "S"
        grdRegistros.Col = 4
        mskValor.Text = grdRegistros.CtlText
        mskValor.Enabled = False
        grdRegistros.Col = 5
        chkGastoB.Checked = grdRegistros.CtlText = "S"
        grdRegistros.Col = 6
        ChkEfectivo.Checked = grdRegistros.CtlText = "S"
        grdRegistros.Col = 7
        ChkChequeP.Checked = grdRegistros.CtlText = "S"
        grdRegistros.Col = 8
        ChkChequeL.Checked = grdRegistros.CtlText = "S"
        grdRegistros.Col = 9
        chk_ndncaho.Checked = grdRegistros.CtlText = "S"
        grdRegistros.Col = 10
        txtCauaho(0).Text = grdRegistros.CtlText
        txtCauaho_Leave(txtCauaho(0), New EventArgs())
        grdRegistros.Col = 11
        txtCauaho(1).Text = grdRegistros.CtlText
        txtCauaho_Leave(txtCauaho(1), New EventArgs())
        grdRegistros.Col = 12
        chk_ndncc.Checked = grdRegistros.CtlText = "S"
        grdRegistros.Col = 13
        txtCaucc(0).Text = grdRegistros.CtlText
        txtCaucc_Leave(txtCaucc(0), New EventArgs())
        grdRegistros.Col = 14
        txtCaucc(1).Text = grdRegistros.CtlText
        txtCaucc_Leave(txtCaucc(1), New EventArgs())
        Optndnc.Checked = chk_ndncaho.Checked Or chk_ndncc.Checked
        grdRegistros.Col = 15
        If grdRegistros.CtlText <> "" Then
            CmbPrograma.Text = grdRegistros.CtlText.Trim()
        Else
            CmbPrograma.SelectedIndex = 0
        End If
        grdRegistros.Col = 16
        txtVigencia.Text = grdRegistros.CtlText.Trim()
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = True
        cmdBoton(2).Enabled = True
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
        PLTSEstado()
    End Sub

    Private Sub PLActualizar()
        PLOperacion()
        If txtCampo(0).Text = "" Then
            'La Causal de Ingreso / Egreso es madatoria
            COBISMessageBox.Show(FMLoadResString(503026), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If Conversion.Val(mskValor.Text) < 0 Then
            'El costo asociado debe ser mayor o igual a cero
            COBISMessageBox.Show(FMLoadResString(503027), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If VLTCont = 0 Then
            'Se requiere mínimo un medio de pago
            COBISMessageBox.Show(FMLoadResString(503028), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            ChkEfectivo.Focus()
            Exit Sub
        End If
        If Error_causales_ndnc() Then
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2914")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, VLTOpera)
        PMPasoValores(sqlconn, "@i_causal", 0, SQLVARCHAR, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_cobro_iva", 0, SQLCHAR, VLTIva)
        PMPasoValores(sqlconn, "@i_costo", 0, SQLMONEY, mskValor.Text)
        PMPasoValores(sqlconn, "@i_gasto_banco", 0, SQLCHAR, VLTGasto)
        PMPasoValores(sqlconn, "@i_efectivo", 0, SQLCHAR, VLTEfect)
        PMPasoValores(sqlconn, "@i_chq_propio", 0, SQLCHAR, VLTCHP)
        PMPasoValores(sqlconn, "@i_chq_local", 0, SQLCHAR, VLTCHL)
        PMPasoValores(sqlconn, "@i_ndnc_cte", 0, SQLCHAR, VLNDNC_CC)
        PMPasoValores(sqlconn, "@i_ndnc_aho", 0, SQLCHAR, VLNDNC_AH)
        PMPasoValores(sqlconn, "@i_causa_cte", 0, SQLCHAR, txtCaucc(0).Text)
        PMPasoValores(sqlconn, "@i_caurev_cte", 0, SQLCHAR, txtCaucc(1).Text)
        PMPasoValores(sqlconn, "@i_causa_aho", 0, SQLCHAR, txtCauaho(0).Text)
        PMPasoValores(sqlconn, "@i_caurev_aho", 0, SQLCHAR, txtCauaho(1).Text)
        PMPasoValores(sqlconn, "@i_programa", 0, SQLVARCHAR, CmbPrograma.Text)
        PMPasoValores(sqlconn, "@i_vigencia", 0, SQLINT2, txtVigencia.Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_causa_ingegr", True, FMLoadResString(503029)) Then 'Ok... Creación Parametrizac. Causales Otros IE
            PMChequea(sqlconn)
            PLLimpiar()
            PLBuscar()
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub PLBuscar()
        PLOperacion()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2916")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, VLTOpera)
        PMPasoValores(sqlconn, "@i_causal", 0, SQLVARCHAR, txtCampo(0).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_causa_ingegr", True, FMLoadResString(503030)) Then 'Ok... Consulta de Causales Ingresos-Egresos Varios
            PMMapeaGrid(sqlconn, grdRegistros, False)
            PMChequea(sqlconn)
            If txtCampo(0).Enabled Then
                txtCampo(0).Focus()
            End If
            If grdRegistros.Rows > 21 Then
				cmdBoton(5).Enabled = True
				PLTSEstado()
            End If
        Else
            PMChequea(sqlconn)
            PMLimpiaG(grdRegistros)
            cmdBoton(5).Enabled = False
        End If
    End Sub

    Private Sub PLOperacion()
        VLTCont = 0
        If optOper(2).Checked Then
            VLTOpera = "I"
            VLTabla = "cc_causa_oioe"
        End If
        If optOper(3).Checked Then
            VLTOpera = "E"
            VLTabla = "cc_causa_oe"
        End If
        If chkIva.Checked Then
            VLTIva = "S"
        Else
            VLTIva = "N"
        End If
        If chkGastoB.Checked Then
            VLTGasto = "S"
        Else
            VLTGasto = "N"
        End If
        If ChkEfectivo.Checked Then
            VLTEfect = "S"
            VLTCont += 1
        Else
            VLTEfect = "N"
        End If
        If ChkChequeL.Checked Then
            VLTCHL = "S"
            VLTCont += 1
        Else
            VLTCHL = "N"
        End If
        If ChkChequeP.Checked Then
            VLTCHP = "S"
            VLTCont += 1
        Else
            VLTCHP = "N"
        End If
        If Optndnc.Checked Then
            VLTCont += 1
        End If
        If chk_ndncaho.Checked Then
            VLNDNC_AH = "S"
        Else
            VLNDNC_AH = "N"
        End If
        If chk_ndncc.Checked Then
            VLNDNC_CC = "S"
        Else
            VLNDNC_CC = "N"
        End If
    End Sub

    Private Sub PLCrear()
        PLOperacion()
        If txtCampo(0).Text = "" Then
            'La Causal de Ingreso / Egreso es madatoria
            COBISMessageBox.Show(FMLoadResString(503031), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If Val(mskValor.Text) < 0 Then
            'El costo asociado debe ser mayor o igual a cero
            COBISMessageBox.Show(FMLoadResString(502677), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskValor.Focus()
            Exit Sub
        End If
        If VLTCont = 0 Then
            'Se requiere mínimo un medio de pago
            COBISMessageBox.Show(FMLoadResString(502678), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            ChkEfectivo.Focus()
            Exit Sub
        End If
        If Error_causales_ndnc() Then
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2913")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, VLTOpera)
        PMPasoValores(sqlconn, "@i_causal", 0, SQLVARCHAR, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_cobro_iva", 0, SQLCHAR, VLTIva)
        PMPasoValores(sqlconn, "@i_costo", 0, SQLMONEY, mskValor.Text)
        PMPasoValores(sqlconn, "@i_gasto_banco", 0, SQLCHAR, VLTGasto)
        PMPasoValores(sqlconn, "@i_efectivo", 0, SQLCHAR, VLTEfect)
        PMPasoValores(sqlconn, "@i_chq_propio", 0, SQLCHAR, VLTCHP)
        PMPasoValores(sqlconn, "@i_chq_local", 0, SQLCHAR, VLTCHL)
        PMPasoValores(sqlconn, "@i_ndnc_cte", 0, SQLCHAR, VLNDNC_CC)
        PMPasoValores(sqlconn, "@i_ndnc_aho", 0, SQLCHAR, VLNDNC_AH)
        PMPasoValores(sqlconn, "@i_causa_cte", 0, SQLCHAR, txtCaucc(0).Text)
        PMPasoValores(sqlconn, "@i_caurev_cte", 0, SQLCHAR, txtCaucc(1).Text)
        PMPasoValores(sqlconn, "@i_causa_aho", 0, SQLCHAR, txtCauaho(0).Text)
        PMPasoValores(sqlconn, "@i_caurev_aho", 0, SQLCHAR, txtCauaho(1).Text)
        PMPasoValores(sqlconn, "@i_programa", 0, SQLVARCHAR, CmbPrograma.Text)
        PMPasoValores(sqlconn, "@i_vigencia", 0, SQLINT2, txtVigencia.Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_causa_ingegr", True, FMLoadResString(502679)) Then '"Ok... Creación Parametrizac. Causales Otros IE
            PMChequea(sqlconn)
            PLLimpiar()
            PLBuscar()
        Else
            PMChequea(sqlconn)
            txtCampo(0).Enabled = True
            txtCampo(0).Text = ""
            txtCampo(0).Focus()
            lblDescripcion.Text = ""
        End If
    End Sub

    Private Sub PLEliminar()
        PLOperacion()
        If txtCampo(0).Text = "" Then
            'La Causal de Ingreso / Egreso es madatoria
            COBISMessageBox.Show(FMLoadResString(502681), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2915")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, VLTOpera)
        PMPasoValores(sqlconn, "@i_causal", 0, SQLVARCHAR, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_cobro_iva", 0, SQLCHAR, VLTIva)
        'Ok... Eliminacion de Causales Ingresos-Egresos Varios
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_causa_ingegr", True, FMLoadResString(502682)) Then
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
            PLLimpiar()
        End If
        txtCampo(0).Enabled = True
        txtCampo(0).Text = ""
        lblDescripcion.Text = ""
        PLLimpiar()
        PLBuscar()
    End Sub

    Private Sub PLLimpiar()
        txtCampo(0).Enabled = True
        txtCampo(0).Text = ""
        txtCampo(0).Focus()
        lblDescripcion.Text = ""
        txtVigencia.Clear()
        CmbPrograma.SelectedIndex = 0
        cmdBoton(3).Enabled = True
        cmdBoton(2).Enabled = False
        cmdBoton(4).Enabled = False
        PMLimpiaGrid(grdRegistros)
        optOper(2).Enabled = True
        optOper(2).Checked = True
        mskValor.Text = VGDecimales
        mskValor.Text = StringsHelper.Format(0, VGDecimales)
        ChkEfectivo.Enabled = True
        ChkChequeL.Enabled = True
        ChkChequeP.Enabled = True
        chkGastoB.Enabled = False
        mskValor.Enabled = True
        chkIva.Checked = False
        ChkEfectivo.Checked = False
        ChkChequeL.Checked = False
        ChkChequeP.Checked = False
        chkGastoB.Checked = False
        Optndnc.Checked = False
    End Sub

    Private Sub PLSiguientes()
        grdRegistros.Col = 1
        grdRegistros.Row = grdRegistros.Rows - 1
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2916")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, VLTOpera)
        If CDbl(grdRegistros.CtlText) + 1 < 100 Then
            PMPasoValores(sqlconn, "@i_causal", 0, SQLVARCHAR, "0" & (CStr(CDbl(grdRegistros.CtlText) + 1)))
        Else
            PMPasoValores(sqlconn, "@i_causal", 0, SQLVARCHAR, CStr(CDbl(grdRegistros.CtlText) + 1))
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_causa_ingegr", True, FMLoadResString(502680)) Then
            'Ok... Consulta de Causales Ingresos-Egresos Varios
            PMMapeaGrid(sqlconn, grdRegistros, True)
            PMChequea(sqlconn)
            If txtCampo(0).Enabled Then
                txtCampo(0).Focus()
            End If
            cmdBoton(5).Enabled = CDbl(Convert.ToString(grdRegistros.Tag)) >= 15
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub mskValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskValor.Enter
        'Costo Asociado de Ingreso o Egreso [F5 Ayuda]
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502683))
    End Sub

    Private Sub mskValor_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskValor.KeyPress
        If Asc(eventArgs.KeyChar) <> 46 And Asc(eventArgs.KeyChar) <> 8 And (Asc(eventArgs.KeyChar) < 48 Or Asc(eventArgs.KeyChar) > 57) Then
            eventArgs.KeyChar = Chr(0)
        End If
        If eventArgs.KeyChar = Chr(46) Then
            If mskValor.Text.IndexOf("."c) + 1 Then
                eventArgs.KeyChar = Chr(0)
            End If
        End If
    End Sub

    Private Sub mskValor_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskValor.Leave
        'mskValor.Text = StringsHelper.Format(CDec(mskValor.Text), VGDecimales)
        If mskValor.ClipText = "" Then
            mskValor.Text = "0.00"
        End If
        mskValor.Text = StringsHelper.Format(mskValor.ClipText, VGDecimales)
    End Sub

    Private Sub Optndnc_CheckStateChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles Optndnc.CheckedChanged
        Dim Value As CheckState = Optndnc.Checked
        Optndnc_ClickHelper(Value)
    End Sub

    Private Sub Optndnc_ClickHelper(ByRef Value As CheckState)
        If Optndnc.Checked Then
            Habilita_Caundnc("S")
        Else
            Habilita_Caundnc("N")
            Limpia_Caundnc()
        End If
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub optOper_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optOper_2.CheckedChanged, _optOper_3.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Index As Integer = Array.IndexOf(optOper, eventSender)
            Dim Value As Integer = optOper(Index).Checked
            optOper_ClickHelper(Index, Value)
        End If
    End Sub

    Private Sub optOper_ClickHelper(ByRef Index As Integer, ByRef Value As Integer)
        lblDescripcion.Text = ""
        txtCampo(0).Text = ""
        txtCampo(0).Enabled = True
        chkIva.Checked = False
        ChkEfectivo.Checked = False
        ChkChequeL.Checked = False
        ChkChequeP.Checked = False
        chkGastoB.Checked = False
        PMLimpiaGrid(grdRegistros)
        If optOper(2).Checked Then
            ChkChequeL.Enabled = True
            ChkChequeL.Text = FMLoadResString(502684) 'Cheque Local
            ChkChequeP.Enabled = True
            ChkChequeP.Text = FMLoadResString(502685) 'Cheque Propio
            chkGastoB.Enabled = False
            mskValor.Enabled = True
            Optndnc.Text = FMLoadResString(502686) ' Nota Debito
            Frame4(2).Text = FMLoadResString(502686) ' Nota Debito
        End If
        If optOper(3).Checked Then
            ChkChequeL.Enabled = True
            ChkChequeL.Text = FMLoadResString(502687) 'Chq. Ot. Banco
            ChkChequeP.Enabled = True
            ChkChequeP.Text = FMLoadResString(2216) 'Cheque Gerencia
            chkGastoB.Enabled = True
            mskValor.Enabled = False
            Optndnc.Text = FMLoadResString(503367) 'Nota Crédito
            Frame4(2).Text = FMLoadResString(502689) 'Causal Nota Credito
        End If
        Optndnc.Checked = False
        Limpia_Caundnc()
    End Sub

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                VLPaso = False
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = True
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502690)) 'Causal de Ingreso o Egreso [F5 Ayuda]
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_0.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If KeyCode = VGTeclaAyuda Then
            VLPaso = True
            txtCampo(Index).Text = ""
            Select Case Index
                Case 0
                    If optOper(2).Checked Then
                        PMCatalogo("A", "cc_causa_oioe", txtCampo(Index), lblDescripcion)
                    Else
                        PMCatalogo("A", "cc_causa_oe", txtCampo(Index), lblDescripcion)
                    End If
                    If txtCampo(Index).Text = "" Then
                        txtCampo(Index).Text = ""
                        lblDescripcion.Text = ""
                    End If
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If Not VLPaso And txtCampo(Index).Text <> "" Then
                    If optOper(2).Checked Then
                        PMCatalogo("V", "cc_causa_oioe", txtCampo(Index), lblDescripcion)
                        optOper(2).Enabled = True
                    Else
                        PMCatalogo("V", "cc_causa_oe", txtCampo(Index), lblDescripcion)
                        VLPaso = True
                        optOper(2).Enabled = False
                    End If
                    If txtCampo(Index).Text = "" Then
                        lblDescripcion.Text = ""
                    End If
                End If
        End Select
    End Sub

    Private Sub txtCauaho_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCauaho_1.Enter, _txtCauaho_0.Enter
        Dim Index As Integer = Array.IndexOf(txtCauaho, eventSender)
        VLPaso = True
        Select Case Index
            Case 0, 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502691)) 'Causal de ND/NC [F5 Ayuda]
        End Select
        txtCauaho(Index).SelectionStart = 0
        txtCauaho(Index).SelectionLength = Strings.Len(txtCauaho(Index).Text)
    End Sub

    Private Sub txtCauaho_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCauaho_1.KeyPress, _txtCauaho_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCauaho, eventSender)
        Select Case Index
            Case 0, 1
                KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCauaho_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCauaho_1.Leave, _txtCauaho_0.Leave
        Dim Index As Integer = Array.IndexOf(txtCauaho, eventSender)
        Dim tablita As String = ""
        If txtCauaho(Index).Text <> "" Then
            If chk_ndncaho.Checked Then
                If optOper(2).Checked Then
                    Select Case Index
                        Case 0
                            tablita = "ah_causa_nd"
                        Case 1
                            tablita = "ah_causa_nc"
                    End Select
                Else
                    Select Case Index
                        Case 0
                            tablita = "ah_causa_nc"
                        Case 1
                            tablita = "ah_causa_nd"
                    End Select
                End If
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, tablita)
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCauaho(Index).Text)
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502692) & "[" & txtCauaho(Index).Text & "]") Then 'Ok... Consulta del parámetro
                    PMMapeaObjeto(sqlconn, Lblcauho(Index))
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    VLPaso = True
                    txtCauaho(Index).Text = ""
                    Lblcauho(Index).Text = ""
                End If
            Else
                txtCauaho(Index).Text = ""
                Lblcauho(Index).Text = ""
            End If
        Else
            txtCauaho(Index).Text = ""
            Lblcauho(Index).Text = ""
        End If
    End Sub

    Private Sub txtCauaho_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCauaho_1.TextChanged, _txtCauaho_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub txtCauaho_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCauaho_1.KeyDown, _txtCauaho_0.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCauaho, eventSender)
        Dim tablita As String = ""
        If KeyCode = VGTeclaAyuda Then
            VLPaso = True
            If chk_ndncaho.Checked Then
                If optOper(2).Checked Then
                    Select Case Index
                        Case 0
                            tablita = "ah_causa_nd"
                        Case 1
                            tablita = "ah_causa_nc"
                    End Select
                Else
                    Select Case Index
                        Case 0
                            tablita = "ah_causa_nc"
                        Case 1
                            tablita = "ah_causa_nd"
                    End Select
                End If
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, tablita)
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502693)) Then 'Ok... Consulta de causas
                    PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                    PMChequea(sqlconn)
                    FCatalogo.ShowPopup(Me)
                    txtCauaho(Index).Text = VGACatalogo.Codigo
                    Lblcauho(Index).Text = VGACatalogo.Descripcion
                    SendKeys.Send("{TAB}")
                    FCatalogo.Dispose()
                Else
                    PMChequea(sqlconn)
                    txtCauaho(Index).Text = ""
                    Lblcauho(Index).Text = ""
                    txtCauaho(Index).Focus()
                End If
            End If
        End If
    End Sub

    Private Sub txtCaucc_Enter(sender As Object, e As EventArgs) Handles _txtCaucc_0.Enter, _txtCaucc_1.Enter
        Dim Index As Integer = Array.IndexOf(txtCaucc, e)
        Select Case Index
            Case 0, 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502691)) 'Causal de ND/NC [F5 Ayuda]
        End Select
    End Sub
    Private Sub txtCaucc_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCaucc_1.TextChanged, _txtCaucc_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub txtCaucc_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCaucc_1.KeyDown, _txtCaucc_0.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCaucc, eventSender)
        Dim tablita As String = ""
        If KeyCode = VGTeclaAyuda Then
            VLPaso = True
            If chk_ndncc.Checked Then
                If optOper(2).Checked Then
                    Select Case Index
                        Case 0
                            tablita = "cc_causa_nd"
                        Case 1
                            tablita = "cc_causa_nc"
                    End Select
                Else
                    Select Case Index
                        Case 0
                            tablita = "cc_causa_nc"
                        Case 1
                            tablita = "cc_causa_nd"
                    End Select
                End If
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, tablita)
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502693)) Then 'Ok... Consulta de causas
                    PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                    PMChequea(sqlconn)
                    FCatalogo.ShowPopup(Me)
                    txtCaucc(Index).Text = VGACatalogo.Codigo
                    Lblcaucc(Index).Text = VGACatalogo.Descripcion
                    SendKeys.Send("{TAB}")
                    FCatalogo.Dispose()
                Else
                    PMChequea(sqlconn)
                    txtCaucc(Index).Text = ""
                    Lblcaucc(Index).Text = ""
                    txtCaucc(Index).Focus()
                End If
            End If
        End If
    End Sub

    Private Sub txtCaucc_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCaucc_1.KeyPress, _txtCaucc_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCaucc, eventSender)
        Select Case Index
            Case 0, 1
                KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCaucc_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCaucc_1.Leave, _txtCaucc_0.Leave
        Dim Index As Integer = Array.IndexOf(txtCaucc, eventSender)
        Dim tablita As String = ""
        If txtCaucc(Index).Text <> "" Then
            If chk_ndncc.Checked Then
                If optOper(2).Checked Then
                    Select Case Index
                        Case 0
                            tablita = "cc_causa_nd"
                        Case 1
                            tablita = "cc_causa_nc"
                    End Select
                Else
                    Select Case Index
                        Case 0
                            tablita = "cc_causa_nc"
                        Case 1
                            tablita = "cc_causa_nd"
                    End Select
                End If
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, tablita)
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCaucc(Index).Text)
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502692) & "[" & txtCaucc(Index).Text & "]") Then 'Ok... Consulta del parámetro
                    PMMapeaObjeto(sqlconn, Lblcaucc(Index))
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    VLPaso = True
                    txtCaucc(Index).Text = ""
                    Lblcaucc(Index).Text = ""
                    txtCaucc(Index).Focus()
                End If
            Else
                txtCaucc(Index).Text = ""
                Lblcaucc(Index).Text = ""
            End If
        Else
            txtCaucc(Index).Text = ""
            Lblcaucc(Index).Text = ""
        End If
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_6.Enabled
        TSBBuscar.Visible = _cmdBoton_6.Visible
        TSBSiguientes.Enabled = _cmdBoton_5.Enabled
        TSBSiguientes.Visible = _cmdBoton_5.Visible
        TSBCrear.Enabled = _cmdBoton_3.Enabled
        TSBCrear.Visible = _cmdBoton_3.Visible
        TSBActualizar.Enabled = _cmdBoton_4.Enabled
        TSBActualizar.Visible = _cmdBoton_4.Visible
        TSBEliminar.Enabled = _cmdBoton_2.Enabled
        TSBEliminar.Visible = _cmdBoton_2.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_0.Enabled
        TSBSalir.Visible = _cmdBoton_0.Visible
    End Sub
    Private Sub _Frame4_1_Enter(sender As Object, e As EventArgs) Handles _Frame4_1.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
    End Sub

    Private Sub txtVigencia_Enter(sender As Object, e As EventArgs) Handles txtVigencia.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509137))
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509138))
    End Sub

    Private Sub optOper_Enter(sender As Object, e As EventArgs) Handles _optOper_2.Enter, _optOper_3.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
    End Sub
End Class


