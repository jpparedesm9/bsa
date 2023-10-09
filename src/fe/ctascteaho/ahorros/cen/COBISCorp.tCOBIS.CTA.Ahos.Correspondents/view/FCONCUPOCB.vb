Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FConsultaCupoCBClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLCuentaCupo As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_3.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        TSBotones.Focus()
        Select Case Index
            Case 0
                PLBuscar()
            Case 1
                PLSiguientes()
            Case 2
                PLLimpiar()
            Case 3
                Me.Close()
        End Select
    End Sub

    Sub PLSiguientes()

    End Sub

    Sub PLBuscar()
        If mskCuenta.ClipText <> "" Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "398")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
            PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, mskCuenta.ClipText)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenimiento_cupo_cb", True, "") Then
                PMMapeaGrid(sqlconn, grdRegistros, False)
                cmdBoton(1).Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) = 20
                PMChequea(sqlconn)
            Else
                PMChequea(sqlconn)
                PLLimpiar()
            End If
        End If
    End Sub

    Private Sub PLInicializar()
        mskCuenta.Mask = VGMascaraCtaAho
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "398")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
        PMPasoValores(sqlconn, "@i_cod_cb", 0, SQLVARCHAR, "0")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenimiento_cupo_cb", True, "") Then
            PMMapeaGrid(sqlconn, grdRegistros, False)
            PMChequea(sqlconn)
            Do While CDbl(Convert.ToString(grdRegistros.Tag)) = 20
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "398")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
                grdRegistros.Col = 1
                grdRegistros.Row = grdRegistros.Rows - 1
                PMPasoValores(sqlconn, "@i_cod_cb", 0, SQLVARCHAR, grdRegistros.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenimiento_cupo_cb", True, "") Then
                    PMMapeaGrid(sqlconn, grdRegistros, True)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            Loop
        Else
            PMChequea(sqlconn)
        End If
    End Sub
    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible()

        TSBSiguiente.Enabled = _cmdBoton_1.Enabled
        TSBSiguiente.Visible = _cmdBoton_1.Visible()

        TSBSiguiente.Enabled = _cmdBoton_1.Enabled
        TSBSiguiente.Visible = _cmdBoton_1.Visible()

        TSBLimpiar.Enabled = _cmdBoton_2.Enabled
        TSBLimpiar.Visible = _cmdBoton_2.Visible()

        TSBSalir.Enabled = _cmdBoton_3.Enabled
        TSBSalir.Visible = _cmdBoton_3.Visible()
    End Sub

    Private Sub FConsultaCupoCB_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
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
        grdRegistros.Col = 3
        VLCuentaCupo = grdRegistros.CtlText
        mskCuenta.Text = FMMascara(VLCuentaCupo, VGMascaraCtaAho)
        mskCuenta_Leave(mskCuenta, New EventArgs())
    End Sub

    Sub PLLimpiar()
        mskCuenta.Mask = ""
        mskCuenta.Text = ""
        mskCuenta.Mask = VGMascaraCtaAho
        lblNombre.Text = ""
        lblCupo.Text = ""
        lblCupoUtil.Text = ""
        lblSaldo2.Text = ""
        lblTotDebitos.Text = ""
        lblDiasVig.Text = ""
        lblCupoDis.Text = ""
        lblSaldo1.Text = ""
        lblTotCreditos.Text = ""
        lblFechaVen.Text = ""
        PMLimpiaGrid(grdRegistros)
        ' PLBuscar()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508918))
    End Sub

    Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        Dim VTFecha As String = String.Empty
        If mskCuenta.ClipText <> "" Then
            If FMChequeaCtaAho(mskCuenta.ClipText) Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                PMPasoValores(sqlconn, "@i_cerrada", 0, SQLCHAR, "N")
                PMPasoValores(sqlconn, "@i_corresponsal", 0, SQLCHAR, "S")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(502622) & mskCuenta.Text & "]") Then
                    PMMapeaObjeto(sqlconn, lblNombre.Text)
                    PMChequea(sqlconn)
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "398")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, mskCuenta.ClipText)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenimiento_cupo_cb", True, FMLoadResString(508845) & mskCuenta.Text & "]") Then
                        Dim VTArreglo(20) As String
                        FMMapeaArreglo(sqlconn, VTArreglo)
                        PMChequea(sqlconn)
                        lblNombre.Text = VTArreglo(2)
                        lblCupo.Text = VTArreglo(6)
                        lblCupoUtil.Text = VTArreglo(7)
                        lblCupoDis.Text = VTArreglo(8)
                        lblSaldo2.Text = VTArreglo(9)
                        lblSaldo1.Text = VTArreglo(10)
                        lblTotDebitos.Text = VTArreglo(11)
                        lblTotCreditos.Text = VTArreglo(12)
                        lblDiasVig.Text = VTArreglo(4)
                        VTFecha = FMConvFecha(VTArreglo(5), VGFormatoFecha, VGFormatoFecha)
                        lblFechaVen.Text = VTFecha
                    Else
                        PMChequea(sqlconn)
                    End If
                Else
                    PMChequea(sqlconn)
                    PLLimpiar()
                    mskCuenta.Mask = ""
                    mskCuenta.Text = ""
                    mskCuenta.Mask = VGMascaraCtaAho
                    mskCuenta.Focus()
                    Exit Sub
                End If
            Else
                COBISMessageBox.Show(FMLoadResString(508917), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
                Exit Sub
            End If
        End If
    End Sub


    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508701))
    End Sub

    Private Sub grdRegistros_Leave(sender As Object, e As EventArgs) Handles grdRegistros.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub


    Private Sub TSBBUSCAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBSIGUIENTE_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBLIMPIAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBSALIR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub
End Class


