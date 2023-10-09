Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Imports COBISCorp.tCOBIS.CTA.Ahos.AccountsAdmCatalogs

Partial Public Class FTran235Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLBeneficiarios As Boolean = False
    Dim VLProdbanc As Integer = 0
    Dim VLTipoEnte As String = ""
    Dim VLTarjeta As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_5.Click, _cmdBoton_4.Click, _cmdBoton_6.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTPersonalizada As String = ""
        Dim VTEmbargada As String = ""
        Dim VTContractual As String = ""
        Dim VTalianza As String = ""
        Dim VTdesalianza As String = ""
        Select Case Index
            Case 0
                If mskCuenta.ClipText <> "" Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "235")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                    PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_cons_gral_ah", True, FMLoadResString(2248) & mskCuenta.Text & "]") Then
                        Dim VTArreglo(20) As String
                        FMMapeaArreglo(sqlconn, VTArreglo)
                        For i As Integer = 1 To 11
                            lblDescripcion(i).Text = VTArreglo(i)
                        Next i
                        lblDescripcion(11).Text = VTArreglo(12)
                        lblDescripcion(10).Text = VTArreglo(13)
                        lblDescripcion(33).Text = VTArreglo(14)
                        lblDescripcion(34).Text = VTArreglo(15)
                        VLProdbanc = CInt(VTArreglo(16))
                        VLTipoEnte = VTArreglo(17)
                        PMMapeaObjetoAB(sqlconn, lblDescripcion(12), lblDescripcion(13))
                        PMMapeaObjetoAB(sqlconn, lblDescripcion(14), lblDescripcion(15))
                        PMMapeaObjetoAB(sqlconn, lblDescripcion(16), lblDescripcion(17))
                        ReDim VTArreglo(20)
                        FMMapeaArreglo(sqlconn, VTArreglo)
                        lblDescripcion(18).Text = VTArreglo(1)
                        lblDescripcion(19).Text = VTArreglo(2)
                        lblDescripcion(20).Text = VTArreglo(3)
                        lblDescripcion(21).Text = VTArreglo(4)
                        PMMapeaObjetoAB(sqlconn, lblDescripcion(22), lblDescripcion(23))
                        PMMapeaObjetoAB(sqlconn, lblDescripcion(24), lblDescripcion(25))
                        PMMapeaObjetoAB(sqlconn, lblDescripcion(26), lblDescripcion(27))
                        PMMapeaObjetoAB(sqlconn, lblDescripcion(28), lblDescripcion(29))
                        PMMapeaObjeto(sqlconn, lblDescripcion(31))
                        PMMapeaGrid(sqlconn, grdBloqueos, False)
                        PMMapeaTextoGrid(grdBloqueos)
                        PMAnchoColumnasGrid(grdBloqueos)
                        PMMapeaObjeto(sqlconn, lblDescripcion(30))
                        PMMapeaVariable(sqlconn, VTPersonalizada)
                        PMMapeaVariable(sqlconn, VTEmbargada)
                        PMMapeaVariable(sqlconn, VTContractual)
                        PMMapeaVariable(sqlconn, VTalianza)
                        PMMapeaVariable(sqlconn, VTdesalianza)
                        PMChequea(sqlconn)
                        If lblDescripcion(22).Text.Trim() = "1" Then
                            lblDescripcion(23).Text = FMLoadResString(502413)
                        End If
                        If lblDescripcion(20).Text.Trim() = "0" Then
                            lblDescripcion(20).Text = ""
                        End If
                        lblDescripcion(32).Text = VTPersonalizada
                        If VTEmbargada <> "N" Then
                            lblDescripcion(57).Visible = True
                            lblDescripcion(57).Text = FMLoadResString(502412)
                        Else
                            lblDescripcion(57).Visible = False
                            lblDescripcion(57).Text = ""
                        End If
                        If VTContractual = "S" Then
                            cmdBoton(6).Enabled = True
                        End If
                        Lblalianza.Text = VTalianza
                        lbldesalianza.Text = VTdesalianza
                        cmdBoton(0).Enabled = False
                    Else
                        PMChequea(sqlconn)
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(501337), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    If mskCuenta.Enabled And mskCuenta.Visible Then mskCuenta.Focus()
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "747")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "Q")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_relacion_cta_canal", True, FMLoadResString(5261)) Then
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
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                lblDescripcion(0).Text = ""
                cmdBoton(3).Enabled = False
                For i As Integer = 1 To 29
                    lblDescripcion(i).Text = ""
                Next i
                lblDescripcion(31).Text = ""
                PMLimpiaGrid(grdPropietarios)
                grdBloqueos.Rows = 2
                grdBloqueos.Cols = 2
                For i As Integer = 0 To 1
                    grdBloqueos.Col = i
                    For j As Integer = 0 To 1
                        grdBloqueos.Row = j
                        grdBloqueos.CtlText = ""
                    Next j
                Next i
                cmdBoton(5).Enabled = False
                cmdBoton(6).Enabled = False
                cmdBoton(0).Enabled = True
                lblDescripcion(57).Visible = False
                lblDescripcion(57).Text = ""
                lblDescripcion(30).Text = ""
                lblDescripcion(32).Text = ""
                lblDescripcion(33).Text = ""
                lblDescripcion(34).Text = ""
                If mskCuenta.Enabled And mskCuenta.Visible Then mskCuenta.Focus()
                cmdBoton(4).Enabled = False
                Lblalianza.Text = ""
                lbldesalianza.Text = ""
            Case 2
                Me.Close()
            Case 3
                PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "298")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                PMPasoValores(sqlconn, "@i_cerrada", 0, SQLCHAR, "C")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_clientes_ah", True, FMLoadResString(2250)) Then
                    PMMapeaGrid(sqlconn, grdPropietarios, False)
                    PMMapeaTextoGrid(grdPropietarios)
                    PMAnchoColumnasGrid(grdPropietarios)
                    PMChequea(sqlconn)
                    grdPropietarios.Col = 5
                    If grdPropietarios.CtlText = "T" Then
                        grdPropietarios.Col = 6
                        If grdPropietarios.CtlText = "P" Then
                            VLBeneficiarios = True
                        End If
                    End If
                    If VLBeneficiarios Then
                        VLBeneficiarios = False
                        cmdBoton(5).Enabled = True
                    End If
                Else
                    PMChequea(sqlconn)
                    PMLimpiaGrid(grdPropietarios)
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
                    If mskCuenta.Enabled And mskCuenta.Visible Then mskCuenta.Focus()
                End If
            Case 6
                PLBuscar_marca()
        End Select
        PLTSEstado()
    End Sub

    Private Sub FTran235_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
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
        If VGCodPais = "CO" Then
            lblEtiqueta(29).Visible = False
            lblDescripcion(34).Visible = False
            lblEtiqueta(27).Visible = False
            lblDescripcion(30).Visible = False
        End If
        CargaParametros("1579", "Q", "3", "AHO", "OCUCOL", 3)
        If VGOcucol = "S" Then
            lblEtiqueta(5).Visible = False
            lblDescripcion(5).Visible = False
            UltraGroupBox4.Visible = False
        End If
        mskCuenta.Mask = VGMascaraCtaAho
        Dim eventSender As Object = Nothing
        Dim eventArgs As EventArgs = Nothing
        mskCuenta_Leave(eventSender, eventArgs)
        Me.Text = FMLoadResString(3866)
    End Sub

    Private Sub FTran235_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501853))
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
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2237) & mskCuenta.Text & "]") Then
                        PMMapeaObjeto(sqlconn, _lblDescripcion_0)
                        PMChequea(sqlconn)
                        cmdBoton(3).Enabled = True
                        PMLimpiaGrid(grdPropietarios)
                        cmdBoton(5).Enabled = False
                        cmdBoton(4).Enabled = True
                    Else
                        PMChequea(sqlconn)
                        cmdBoton(4).Enabled = False
                        cmdBoton_Click(cmdBoton(1), New EventArgs())
                        Exit Sub
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    cmdBoton(4).Enabled = False
                    cmdBoton_Click(cmdBoton(1), New EventArgs())
                    Exit Sub
                End If
            End If
        Catch exc As System.Exception
            COBISMessageBox.Show(exc.ToString, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End Try
        PLTSEstado()
    End Sub

    Private Sub PLBuscar_marca()
        Dim VLParametro(15, 2) As String
        Dim VTCambiaCategoria As String = ""
        Dim VLMarca As String = ""
        Dim VLProdfinal As String = ""
        Dim VLParametriza As String = ""

        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "PAHCT")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, "AHO")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(2244)) Then
            FMMapeaMatriz(sqlconn, VLParametro)
            PMChequea(sqlconn)
            If StringsHelper.ToDoubleSafe(VLParametro(6, 1)) = VLProdbanc Then
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
            If StringsHelper.ToDoubleSafe(VLParametro(6, 1)) = VLProdbanc Then
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
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(2244)) Then
            FMMapeaMatriz(sqlconn, VLParametro)
            PMChequea(sqlconn)
            If VLParametro(3, 1) = lblDescripcion(14).Text Then
                VTCambiaCategoria = "S"
            Else
                VTCambiaCategoria = "N"
            End If
        Else
            PMChequea(sqlconn)
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(734))
        PMPasoValores(sqlconn, "@i_categoria", 0, SQLVARCHAR, lblDescripcion(14).Text)
        PMPasoValores(sqlconn, "@i_prodban", 0, SQLVARCHAR, CStr(VLProdbanc))
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
        PMPasoValores(sqlconn, "@i_tipoente", 0, SQLCHAR, VLTipoEnte)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mto_aho_contractual", True, FMLoadResString(2245)) Then
            PMMapeaVariable(sqlconn, VLMarca)
            PMMapeaVariable(sqlconn, VLProdfinal)
            PMMapeaVariable(sqlconn, VLParametriza)
            PMChequea(sqlconn)
            If VLMarca = "S" Then
                If StringsHelper.ToDoubleSafe(VLParametriza) <> 0 Or VTCambiaCategoria = "S" Then
                    VGcategoria = lblDescripcion(14).Text
                    VGprofinal = VLProdfinal
                    VGCuenta = mskCuenta.ClipText
                    VGOrigen = "1"
                    Ftran434.ShowPopup(Me)
                    Ftran434.Dispose()
                Else
                    COBISMessageBox.Show(FMLoadResString(2246) & " " & VLProdfinal & FMLoadResString(2247) & " " & lblDescripcion(14).Text & " ", FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                End If
            Else
                VGCancelar = "N"
            End If
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBBeneficiarios.Enabled = _cmdBoton_5.Enabled
        TSBBeneficiarios.Visible = _cmdBoton_5.Visible
        TSBPropietario.Enabled = _cmdBoton_3.Enabled
        TSBPropietario.Visible = _cmdBoton_3.Visible
        TSBFirmas.Enabled = _cmdBoton_4.Enabled
        TSBFirmas.Visible = False '_cmdBoton_4.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBSiguientes.Enabled = _cmdBoton_6.Enabled
        TSBSiguientes.Visible = _cmdBoton_6.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
    End Sub

    Private Sub TSBBeneficiarios_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBeneficiarios.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBPropietario_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBPropietario.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBFirmas_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBFirmas.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
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

    Private Sub grdPropietarios_DblClick(sender As Object, e As EventArgs) Handles grdPropietarios.DblClick
        PMMarcaFilaCobisGrid(grdPropietarios, grdPropietarios.Row)
    End Sub

    Private Sub grdPropietarios_Enter(sender As Object, e As EventArgs) Handles grdPropietarios.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2425))
    End Sub

    Private Sub grdPropietarios_Leave(sender As Object, e As EventArgs) Handles grdPropietarios.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
    Private Sub optTarjetaDebito_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optTarjetaDebito_0.Enter, _optTarjetaDebito_1.Enter

        Dim Index As Integer = Array.IndexOf(optTarjetaDebito, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5118))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5119))
        End Select
    End Sub

    Private Sub _optTarjetaDebito_0_Leave(sender As Object, e As EventArgs) Handles _optTarjetaDebito_0.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub _optTarjetaDebito_1_Leave(sender As Object, e As EventArgs) Handles _optTarjetaDebito_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub grdBloqueos_Enter(sender As Object, e As EventArgs) Handles grdBloqueos.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500849))
    End Sub

    Private Sub grdBloqueos_Leave(sender As Object, e As EventArgs) Handles grdBloqueos.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub grdPropietarios_ClickEvent(sender As Object, e As EventArgs) Handles grdPropietarios.ClickEvent
        PMLineaG(grdPropietarios)
        PMMarcaFilaCobisGrid(grdPropietarios, grdPropietarios.Row)
    End Sub

End Class


