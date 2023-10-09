Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FCtranAutClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VTRegistros As Integer = 0
    Public VLFlag As Integer = 0

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_4.Click, _cmdBoton_5.Click, _cmdBoton_1.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                VLFlag = False
                PLBuscar()
            Case 1
                VLFlag = True
                PLBuscar()
            Case 4
                Me.Cursor = System.Windows.Forms.Cursors.Default
                Me.Close()
            Case 3
                PLLimpiar()
            Case 5 'Imprimir
        End Select
    End Sub

    Private Sub PLInicializar()
        'FPrincipal.Cursor = System.Windows.Forms.Cursors.WaitCursor
        cmbprodb.Items.Insert(0, "AHORROS")
        cmbprodb.Items.Insert(1, "CORRIENTE")
        cmbprodb.SelectedIndex = 0
        Mskcuentadb.Mask = VGMascaraCtaAho
        cmdBoton(5).Enabled = False
        cmdBoton(5).Visible = False
    End Sub

    Private Sub FCtranAut_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""

        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub cmbprodb_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbprodb.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2220))
        If Not VLPaso Then
            If cmbprodb.SelectedIndex = 1 Then
                Mskcuentadb.Mask = VGMascaraCtaCte
            Else
                Mskcuentadb.Mask = VGMascaraCtaAho
            End If
            PMLimpiaGrid(grdRegistros)
            cmdBoton(0).Enabled = True
            cmdBoton(1).Enabled = False
            Mskcuentadb_Leave(Mskcuentadb, New EventArgs())
            VLPaso = True
        End If
    End Sub

    Private Sub cmbprodb_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbprodb.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500016))

    End Sub

    Private Sub grdRegistros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.ClickEvent
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
                COBISMessageBox.Show("No existen registros de transferencias automáticas", FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        End If
        grdRegistros.Col = 1
        VGADatosO(0) = grdRegistros.CtlText
        Me.Close()
    End Sub

    Private Sub Mskcuentadb_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles Mskcuentadb.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500019))
        Mskcuentadb.SelectionStart = 0
        Mskcuentadb.SelectionLength = Strings.Len(Mskcuentadb.Text)
    End Sub

    Private Sub Mskcuentadb_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles Mskcuentadb.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Try
            If Mskcuentadb.ClipText <> "" Then
                If cmbprodb.SelectedIndex = 1 Then
                    If FMChequeaCtaCte(Mskcuentadb.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "16")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, Mskcuentadb.ClipText)
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Cuenta " & "[" & Mskcuentadb.Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(0))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            Mskcuentadb.Text = FMMascara("", VGMascaraCtaCte)
                            lblDescripcion(0).Text = ""
                            If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show("El dígito verificador de la cuenta está incorrecto", "Mensaje de Error", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        Mskcuentadb.Text = FMMascara("", VGMascaraCtaCte)
                        lblDescripcion(0).Text = ""
                        If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
                        Exit Sub
                    End If
                Else
                    If FMChequeaCtaAho(Mskcuentadb.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, Mskcuentadb.ClipText)
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & Mskcuentadb.Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(0))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            Mskcuentadb.Text = FMMascara("", VGMascaraCtaAho)
                            lblDescripcion(0).Text = ""
                            If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show("El dígito verificador de la cuenta de ahorros está incorrecto", "Mensaje de Error", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        Mskcuentadb.Text = FMMascara("", VGMascaraCtaAho)
                        lblDescripcion(0).Text = ""
                        If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
                        Exit Sub
                    End If
                End If
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
        End Try
    End Sub

    Sub PLBuscar()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "711")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "T")
        PMPasoValores(sqlconn, "@i_cta_banco_dst", 0, SQLVARCHAR, Mskcuentadb.ClipText)
        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT2, VGFormatoFechaInt)
        If optEstado(0).Checked Then
            PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "I")
        Else
            PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "C")
        End If
        If cmbprodb.SelectedIndex = 1 Then
            PMPasoValores(sqlconn, "@i_producto_dst", 0, SQLVARCHAR, "CTE")
        Else
            PMPasoValores(sqlconn, "@i_producto_dst", 0, SQLVARCHAR, "AHO")
        End If
        If Not VLFlag Then
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, "0")
        Else
            grdRegistros.Col = 1
            grdRegistros.Row = grdRegistros.Rows - 1
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, grdRegistros.CtlText)
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenca_transfer", True, "Ok... Consulta de Transferencias Automaticas") Then
            PMMapeaGrid(sqlconn, grdRegistros, VLFlag)
            PMChequea(sqlconn)
            VTRegistros = Conversion.Val(Convert.ToString(grdRegistros.Tag))
            If VTRegistros >= 20 Then
                cmdBoton(1).Enabled = True
                cmdBoton(0).Enabled = False
            Else
                cmdBoton(0).Enabled = False
                cmdBoton(1).Enabled = False
            End If
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub optEstado_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optEstado_1.CheckedChanged, _optEstado_0.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Index As Integer = Array.IndexOf(optEstado, eventSender)
            Dim Value As Integer = optEstado(Index).Checked
            optEstado_ClickHelper(Index, Value)
        End If
    End Sub

    Private Sub optEstado_ClickHelper(ByRef Index As Integer, ByRef Value As Integer)
        PMLimpiaGrid(grdRegistros)
        cmdBoton(0).Enabled = True
        cmdBoton(1).Enabled = False
    End Sub

    Sub PLLimpiar()
        cmbprodb.SelectedIndex = 0
        Mskcuentadb.Mask = FMMascara("", VGMascaraCtaAho)
        lblDescripcion(0).Text = ""
        optEstado(0).Checked = True
        PMLimpiaGrid(grdRegistros)
        cmdBoton(0).Enabled = True
        cmdBoton(1).Enabled = False
        Mskcuentadb_Leave(Mskcuentadb, New EventArgs())
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub
    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible()
        TSBSiguientes.Enabled = _cmdBoton_1.Enabled
        TSBSiguientes.Visible = _cmdBoton_1.Visible()
        TSBImprimir.Enabled = _cmdBoton_5.Enabled
        TSBImprimir.Visible = _cmdBoton_5.Visible()
        TSBLimpiar.Enabled = _cmdBoton_3.Enabled
        TSBLimpiar.Visible = _cmdBoton_3.Visible()
        TSBSalir.Enabled = _cmdBoton_4.Enabled
        TSBSalir.Visible = _cmdBoton_4.Visible()

    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
    End Sub

    Private Sub cmbprodb_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cmbprodb.SelectedIndexChanged
        VLPaso = False
    End Sub

    Private Sub _optEstado_0_Enter(sender As Object, e As EventArgs) Handles _optEstado_0.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500001))
    End Sub

    Private Sub _optEstado_0_Leave(sender As Object, e As EventArgs) Handles _optEstado_0.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub _optEstado_1_Enter(sender As Object, e As EventArgs) Handles _optEstado_1.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500000))
    End Sub

    Private Sub _optEstado_1_Leave(sender As Object, e As EventArgs) Handles _optEstado_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub grdRegistros_Leave(sender As Object, e As EventArgs) Handles grdRegistros.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500009))
    End Sub
End Class


