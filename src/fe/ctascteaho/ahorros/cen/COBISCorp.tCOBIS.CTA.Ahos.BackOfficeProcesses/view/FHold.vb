Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FHoldClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim HayRegistro As Boolean = False
    Dim VTNuevaFila As Integer = 0
    Dim VTCiudad As String = ""
    Dim VTFechaDepo As String = ""
    Dim VTFechaEfe As String = ""
    Dim i As Integer = 0

    Private Sub cmbTipo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbTipo.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500016))
    End Sub

    Private Sub cmbTipo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbTipo.Leave
        If Not VLPaso Then
            If cmbTipo.Text = "CUENTA CORRIENTE" Then
                mskCuenta.Mask = VGMascaraCtaCte
                mskCuenta.Text = ""
                lblDescripcion(0).Text = ""
            Else
                mskCuenta.Mask = VGMascaraCtaAho
                mskCuenta.Text = ""
                lblDescripcion(0).Text = ""
            End If
            VLPaso = True
        End If
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_3.Click, _cmdBoton_0.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTProd As Integer = 0
        TSBotones.Focus()
        Select Case Index
            Case 0
                If mskCuenta.ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500660), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                    Exit Sub
                End If
                If cmbTipo.SelectedIndex = 0 Then
                    VTProd = 3
                Else
                    VTProd = 4
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "723")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "S")
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, CStr(VTProd))
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_addhold_locales", True, FMLoadResString(502529) & mskCuenta.Text & " ]") Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMMapeaTextoGrid(grdRegistros)
                    PMChequea(sqlconn)
                    For i As Integer = 1 To grdRegistros.Rows - 1
                        grdRegistros.Row = i
                        grdRegistros.Col = 0
                        grdRegistros.Picture = picVisto(1).Image
                    Next i
                    lblDescripcion(1).Text = ""
                    mskDias.Visible = False
                    mskDias.Text = ""
                    lblEtiqueta(1).Visible = False
                    cmdBoton(3).Enabled = False
                Else
                    PMChequea(sqlconn)
                    PMLimpiaGrid(grdRegistros)
                End If
            Case 1
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                lblDescripcion(0).Text = ""
                lblDescripcion(1).Text = ""
                mskDias.Visible = False
                mskDias.Text = ""
                lblEtiqueta(1).Visible = False
                PMLimpiaGrid(grdRegistros)
                grdRegistros.Col = 0
                grdRegistros.Row = 1
                grdRegistros.Picture = Nothing
                mskCuenta.Focus()
                cmdBoton(3).Enabled = False
                cmbTipo.SelectedIndex = 0
            Case 2
                Me.Dispose()
            Case 3
                If mskCuenta.ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500660), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                    Exit Sub
                End If
                If CDbl(mskDias.Text) <= 0 Then
                    COBISMessageBox.Show(FMLoadResString(500487), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskDias.Focus()
                    Exit Sub
                End If
                If cmbTipo.SelectedIndex = 0 Then
                    VTProd = 3
                Else
                    VTProd = 4
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "723")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "A")
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                PMPasoValores(sqlconn, "@i_dias_add", 0, SQLMONEY, CStr(CDbl(mskDias.Text)))
                PMPasoValores(sqlconn, "@i_ciudad", 0, SQLINT4, VTCiudad)
                Dim TempDate As Date = DateTime.Now
                PMPasoValores(sqlconn, "@i_fecha_depo", 0, SQLDATETIME, IIf(DateTime.TryParse(VTFechaDepo, TempDate), TempDate.ToString("MM/dd/yyyy"), VTFechaDepo))
                Dim TempDate2 As Date = DateTime.Now
                PMPasoValores(sqlconn, "@i_fecha_efe", 0, SQLDATETIME, IIf(DateTime.TryParse(VTFechaEfe, TempDate2), TempDate2.ToString("MM/dd/yyyy"), VTFechaEfe))
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, CStr(VTProd))
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_addhold_locales", True, FMLoadResString(508854) & "[ " & mskCuenta.Text & " ]") Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMMapeaTextoGrid(grdRegistros)
                    PMChequea(sqlconn)
                    cmdBoton_Click(cmdBoton(0), New EventArgs())
                    lblDescripcion(1).Text = ""
                    mskDias.Text = ""
                    mskDias.Visible = False
                    lblEtiqueta(1).Visible = False
                Else
                    PMChequea(sqlconn)
                End If
        End Select
    End Sub

    Private Sub FHold_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Public Sub PLInicializar()
        mskCuenta.Mask = VGMascaraCtaCte
        mskDias.Text = VGDecimales
        HayRegistro = False
        cmdBoton(3).Enabled = False
        cmbTipo.Items.Insert(0, "CUENTA DE AHORRO")
        cmbTipo.Items.Insert(1, "CUENTA CORRIENTE")
        cmbTipo.SelectedIndex = 0
    End Sub

    Private Sub FHold_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdRegistros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.Click, grdRegistros.ClickEvent
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
            grdRegistros.Col = 2
            lblDescripcion(1).Text = grdRegistros.CtlText
            mskDias.Text = "0"
            grdRegistros.Col = 1
            VTFechaDepo = grdRegistros.CtlText
            grdRegistros.Col = 3
            VTFechaEfe = grdRegistros.CtlText
            grdRegistros.Col = 4
            VTCiudad = grdRegistros.CtlText
            mskDias.Visible = True
            lblEtiqueta(1).Visible = True
            cmdBoton(3).Enabled = True
            mskDias.Focus()
        Else
            VTNuevaFila = grdRegistros.Row
            'JSA If HayRegistro And grdRegistros.Picture.Equals(picVisto(0).Image) Then
            If HayRegistro And grdRegistros.Picture Is Nothing Then
                PMMarcarRegistro(False)
                HayRegistro = False
                lblDescripcion(1).Text = ""
                mskDias.Text = "0"
                mskDias.Visible = False
                lblEtiqueta(1).Visible = False
                cmdBoton(3).Enabled = False
            End If
            'JSA If HayRegistro And Not grdRegistros.Picture.Equals(picVisto(0).Image) Then
            If HayRegistro And Not grdRegistros.Picture Is Nothing Then
                For i As Integer = 1 To grdRegistros.Rows - 1
                    grdRegistros.Row = i
                    grdRegistros.Picture = picVisto(1).Image
                Next i
                grdRegistros.Row = VTNuevaFila
                grdRegistros.Col = 2
                lblDescripcion(1).Text = grdRegistros.CtlText
                mskDias.Text = "0"
                grdRegistros.Col = 1
                VTFechaDepo = grdRegistros.CtlText
                grdRegistros.Col = 3
                VTFechaEfe = grdRegistros.CtlText
                grdRegistros.Col = 4
                VTCiudad = grdRegistros.CtlText
                PMMarcarRegistro(True)
                HayRegistro = True
                mskDias.Visible = True
                lblEtiqueta(1).Visible = True
                cmdBoton(3).Enabled = True
                mskDias.Focus()
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
            Dim VLBaseD As String = String.Empty
            Dim VLSP As String = String.Empty
            If mskCuenta.ClipText <> "" Then
                If FMChequeaCtaCte(mskCuenta.ClipText) Then
                    If cmbTipo.SelectedIndex = 1 Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "16")
                        VLBaseD = "cob_cuentas"
                        VLSP = "sp_tr_query_nom_ctacte"
                    Else
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
                        VLBaseD = "cob_ahorros"
                        VLSP = "sp_tr_query_nom_ctahorro"
                    End If
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_cerrada", 0, SQLCHAR, "C")
                    If FMTransmitirRPC(sqlconn, ServerName, VLBaseD, VLSP, True, FMLoadResString(2274) & mskCuenta.Text & "]") Then
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

    Private Sub mskDias_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskDias.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500489))
        mskDias.SelectionStart = 0
        mskDias.SelectionLength = Strings.Len(mskDias.Text)
    End Sub

    Private Sub mskDias_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskDias.KeyPress
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
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBTransmitir.Enabled = _cmdBoton_3.Enabled
        TSBTransmitir.Visible = _cmdBoton_3.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub cmbTipo_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cmbTipo.SelectedIndexChanged
        VLPaso = False
    End Sub
End Class


