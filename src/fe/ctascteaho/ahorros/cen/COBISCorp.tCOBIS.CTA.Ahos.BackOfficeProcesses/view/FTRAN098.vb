Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran098Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim HayRegistro As Boolean = False
    Dim VTNuevaFila As Integer = 0
    Dim VTCiudad As String = ""
    Dim VTFechaDepo As String = ""
    Dim VTFechaEfe As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_3.Click, _cmdBoton_0.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                If mskCuenta.ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500332), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "331")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "R")
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_reten_locales_ah", True, FMLoadResString(502529) & mskCuenta.Text & FMLoadResString(508943)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMMapeaGrid(sqlconn, grdCheques, False)
                    PMChequea(sqlconn)
                    For i As Integer = 1 To grdRegistros.Rows - 1
                        grdRegistros.Row = i
                        grdRegistros.Col = 0
                        grdRegistros.Picture = picVisto(1).Image
                    Next i
                    lblDescripcion(1).Text = ""
                    mskMonto.Visible = False
                    mskMonto.Text = ""
                    lblEtiqueta(1).Visible = False
                    cmdBoton(3).Enabled = False
                    PLTSEstado()
                Else
                    PMChequea(sqlconn)
                    PMLimpiaGrid(grdRegistros)
                    PMLimpiaGrid(grdCheques)
                End If
            Case 1
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                lblDescripcion(0).Text = ""
                lblDescripcion(1).Text = ""
                mskMonto.Visible = False
                mskMonto.Text = ""
                lblEtiqueta(1).Visible = False
                PMLimpiaGrid(grdRegistros)
                PMLimpiaGrid(grdCheques)
                grdRegistros.Col = 0
                grdRegistros.Row = 1
                grdRegistros.Picture = Nothing
                mskCuenta.Focus()
                cmdBoton(3).Enabled = False
                PLTSEstado()
            Case 2
                Me.Close()
            Case 3
                If mskCuenta.ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500332), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                    Exit Sub
                End If
                If CDbl(mskMonto.Text) < 0 Or CDbl(lblDescripcion(1).Text) < CDbl(mskMonto.Text) Then
                    COBISMessageBox.Show(FMLoadResString(501332), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "332")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "L")
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                PMPasoValores(sqlconn, "@i_monto", 0, SQLMONEY, CStr(CDbl(mskMonto.Text)))
                PMPasoValores(sqlconn, "@i_ciudad", 0, SQLINT4, VTCiudad)
                PMPasoValores(sqlconn, "@i_fecha_depo", 0, SQLDATETIME, FMConvFecha(VTFechaDepo, VGFormatoFecha, "mm/dd/yyyy"))
                PMPasoValores(sqlconn, "@i_fecha_efe", 0, SQLDATETIME, FMConvFecha(VTFechaEfe, VGFormatoFecha, "mm/dd/yyyy"))
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_reten_locales_ah", True, FMLoadResString(508854) & mskCuenta.Text & FMLoadResString(508943)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMChequea(sqlconn)
                    cmdBoton_Click(cmdBoton(0), New EventArgs())
                    lblDescripcion(1).Text = ""
                    mskMonto.Text = ""
                    mskMonto.Visible = False
                    lblEtiqueta(1).Visible = False
                Else
                    PMChequea(sqlconn)
                End If
        End Select
    End Sub

    Private Sub FTran098_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
    End Sub

    Public Sub PLInicializar()
        Me.Left = 0
        Me.Top = 0
        'mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
        mskCuenta.Mask = VGMascaraCtaAho

        If mskCuenta.ClipText <> "" Then
            If FMChequeaCtaAho(mskCuenta.ClipText) Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                PMPasoValores(sqlconn, "@i_cerrada", 0, SQLCHAR, "C")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2274) & mskCuenta.Text & FMLoadResString(508943)) Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(0))
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    cmdBoton_Click(cmdBoton(1), New EventArgs())
                    Exit Sub
                End If
            Else
                COBISMessageBox.Show(FMLoadResString(500020), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                cmdBoton_Click(cmdBoton(1), New EventArgs())
                Exit Sub
            End If
            'Else
            '    lblDescripcion(0).Text = ""
            '    PMLimpiaGrid(grdRegistros)
            '    PMLimpiaGrid(grdCheques)
        End If

        mskMonto.Text = VGDecimales
        HayRegistro = False
        cmdBoton(3).Enabled = False
        PLTSEstado()

    End Sub

    Private Sub FTran098_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
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

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
        PMLineaG(grdRegistros)
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdRegistros.DblClick
        If grdRegistros.Rows <= 2 Then
            grdRegistros.Row = 1
            grdRegistros.Col = 1
            If grdRegistros.CtlText.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(500488), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        End If
        grdRegistros.Col = 0
        If Not HayRegistro Then
            VTNuevaFila = grdRegistros.Row
            PMMarcarRegistro(True)
            HayRegistro = True
            grdRegistros.Col = 3
            lblDescripcion(1).Text = grdRegistros.CtlText
            mskMonto.Text = grdRegistros.CtlText
            grdRegistros.Col = 1
            VTFechaDepo = grdRegistros.CtlText
            grdRegistros.Col = 4
            VTFechaEfe = grdRegistros.CtlText
            grdRegistros.Col = 5
            VTCiudad = grdRegistros.CtlText
            mskMonto.Visible = True
            lblEtiqueta(1).Visible = True
            cmdBoton(3).Enabled = True
        Else
            VTNuevaFila = grdRegistros.Row
            If HayRegistro And grdRegistros.Picture Is Nothing Then
                PMMarcarRegistro(False)
                HayRegistro = False
                lblDescripcion(1).Text = ""
                mskMonto.Text = ""
                mskMonto.Visible = False
                lblEtiqueta(1).Visible = False
                cmdBoton(3).Enabled = False
            End If
            If HayRegistro And Not grdRegistros.Picture Is Nothing Then
                For i As Integer = 1 To grdRegistros.Rows - 1
                    grdRegistros.Row = i
                    grdRegistros.Picture = picVisto(1).Image
                Next i
                grdRegistros.Row = VTNuevaFila
                grdRegistros.Col = 3
                lblDescripcion(1).Text = grdRegistros.CtlText
                mskMonto.Text = grdRegistros.CtlText
                grdRegistros.Col = 1
                VTFechaDepo = grdRegistros.CtlText
                grdRegistros.Col = 4
                VTFechaEfe = grdRegistros.CtlText
                grdRegistros.Col = 5
                VTCiudad = grdRegistros.CtlText
                PMMarcarRegistro(True)
                HayRegistro = True
                mskMonto.Visible = True
                lblEtiqueta(1).Visible = True
                cmdBoton(3).Enabled = True
            End If
        End If
        PLTSEstado()
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508672))
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
    End Sub

    Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        Try
            If mskCuenta.ClipText <> "" Then
                If FMChequeaCtaAho(mskCuenta.ClipText) Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_cerrada", 0, SQLCHAR, "C")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2274) & mskCuenta.Text & FMLoadResString(508943)) Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(0))
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        cmdBoton_Click(cmdBoton(1), New EventArgs())
                        Exit Sub
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(500020), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    cmdBoton_Click(cmdBoton(1), New EventArgs())
                    Exit Sub
                End If
            Else
                lblDescripcion(0).Text = ""
                PMLimpiaGrid(grdRegistros)
                PMLimpiaGrid(grdCheques)
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
        End Try
    End Sub

    Private Sub PMMarcarRegistro(ByRef Opcion As Boolean)
        grdRegistros.Col = 0
        If Opcion Then
            grdRegistros.Picture = picVisto(0).Image
        Else
            grdRegistros.Picture = picVisto(1).Image
        End If
    End Sub

    Private Sub mskMonto_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskMonto.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500489))
        mskMonto.SelectionStart = 0
        mskMonto.SelectionLength = Strings.Len(mskMonto.Text)
    End Sub

    Private Sub mskMonto_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskMonto.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If KeyAscii = Strings.AscW("+") Then
            SendKeys.Send("{TAB}")
            KeyAscii = 0
            If KeyAscii = 0 Then
                eventArgs.Handled = True
            End If
            Exit Sub
        End If
        If KeyAscii = Strings.AscW("-") Then
            SendKeys.Send("+{TAB}")
            KeyAscii = 0
            If KeyAscii = 0 Then
                eventArgs.Handled = True
            End If
            Exit Sub
        End If
        If VGDecimales = "#,##0" Then
            If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                KeyAscii = 0
            End If
        Else
            If (KeyAscii <> 8) And (KeyAscii <> 46) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                KeyAscii = 0
            End If
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub
    Private Sub PLTSEstado()
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_3.Visible
        TSBTransmitir.Enabled = _cmdBoton_3.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub grdCheques_ClickEvent(sender As Object, e As EventArgs) Handles grdCheques.ClickEvent
        PMLineaG(grdCheques)
        PMMarcaFilaCobisGrid(grdCheques, grdCheques.Row)
    End Sub
End Class


