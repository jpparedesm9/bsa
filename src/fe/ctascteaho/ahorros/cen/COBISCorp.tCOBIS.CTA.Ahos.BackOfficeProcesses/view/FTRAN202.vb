Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Text
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Imports System.IO

Partial Public Class FTran202Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLNumero As Integer = 0
    Dim VLTitular As Integer = 0
    Public VLPaso As Integer = 0
    Dim VLEnte As Integer = 0
    Dim VLCedula1 As String = ""
    Dim VLCotitular As String = ""
    Dim VLTraslado As String = ""
    Dim VLTipoEnteTitular As String = ""
    Dim VLCodTitular As Integer = 0
    Dim VLNumLib As String = ""
    Dim VTNumLib As Integer = 0
    Dim VLCuenta0 As String = ""
    Dim VTMatrizprop(,) As String
    Dim VLContadorprop As Integer = 0
    Dim VLTipoDireccion(2, 2) As String
    Dim Roles(,) As String
    Dim XT As Integer = 0
    Dim VLHabilitaClientesEsp As String = "S"
    Dim iEscogidos As Integer
    Public VLCuentaV As String
    Public VTR1 As Integer = 0
    Dim VGMatriz(10, 20) As String
    Dim VLTutor As Boolean = False
    Dim VLFormatoFecha As String = "MM/dd/yyyy"
    Const CLLargoNomCta As Integer = 60

    Dim VLImprSolicContr As Boolean = True
    Private Sub cmbenvioec_SelectedIndexChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbenvioec.SelectedIndexChanged
        optdir(0).Enabled = Not (cmbenvioec.Text = "N")
        If cmbenvioec.Text = "N" Then
            optdir(1).Checked = True
        Else
            optdir(0).Checked = True
        End If
    End Sub

    Private Sub cmbsaldocero_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbsaldocero.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501258))
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_5.Click, _cmdBoton_1.Click, _cmdBoton_0.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_4.Click, _cmdBoton_6.Click, _cmdBoton_7.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        TSBBotones.Focus()
        If txtCampo(11).Text = "" Then
            VTNumLib = 0
        Else
            VTNumLib = CInt(txtCampo(11).Text)
        End If
        Select Case Index
            Case 0
                PLAniadir()
            Case 1
                PLEliminar()
            Case 2
                PLTransmitir()
            Case 3
                PLLimpiar()
            Case 4
                Me.Close()
            Case 5
                PLImprimir()
            Case 6
                If VGCodPais = "PA" Then
                    If VGPerfilCta <> "S" And VGPerfilCta <> "" Then
                        COBISMessageBox.Show(FMLoadResString(501187), FMLoadResString(500092), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        Exit Sub
                    End If
                End If
                PLContrato()
            Case 7
                VGProducto = "AHO"
                Fdatadi.Show(Me)
                Fdatadi.mskCuenta.Mask = VGMascaraCtaAho
                Fdatadi.mskCuenta.Text = mskCuenta.Text
        End Select
    End Sub

    Private Sub plAlianza()
        Dim VLDesAlianza As String = ""
        Dim VLAlianza As String = ""
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_cliente", 0, SQLINT4, CStr(VLCodTitular))
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1181")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_desc_cliente", True, FMLoadResString(2239) & txtCampo(0).Text & "]") Then
            Dim VTValores(15) As String
            FMMapeaArreglo(sqlconn, VTValores)
            PMMapeaVariable(sqlconn, VLAlianza)
            PMMapeaVariable(sqlconn, VLDesAlianza)
            PMChequea(sqlconn)
            Lblalianza.Text = VLAlianza
            lbldesalianza.Text = VLDesAlianza
        Else
            PMChequea(sqlconn)
            Lblalianza.Text = ""
            lbldesalianza.Text = ""
        End If
    End Sub

    Private Sub FTran202_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
    End Sub

    Public Sub PLInicializar()
        mskCuenta2.Mask = VGMascaraCtaAho
        mskCuenta2.Text = ""
        VLNumero = 0
        VLTitular = 0
        mskCuenta.Mask = VGMascaraCtaAho
        Mskvalor.MaxLength = 14
        cmdBoton(2).Enabled = False
        VLEnte = True
        VLCedula1 = ""
        VLCotitular = "0"
        txtTipoCta.Connection = VGMap
        txtTipoCta.AsociatedLabel = lblDescripcion(15)
        txtTipoCta.TableName = "cc_tipocta_super"
        optcausa(0).Checked = False
        optcausa(1).Checked = False
        cmbenvioec.Items.Clear()
        cmbenvioec.Items.Add("S")
        cmbenvioec.Items.Add("N")
        cmbenvioec.SelectedIndex = 1
        txtCampo(14).Enabled = False
        cmbsaldocero.Items.Insert(0, "N")
        cmbsaldocero.Items.Insert(1, "S")
        cmbsaldocero.SelectedIndex = 0
        For n As Integer = 0 To VLTipoDireccion.GetUpperBound(0) - 1
            For C As Integer = 0 To VLTipoDireccion.GetUpperBound(1) - 1
                VLTipoDireccion(n, C) = ""
            Next C
        Next n
        optdir(1).Checked = True
        optdir_CheckedChanged(optdir(1), New EventArgs())
        txtCampo(21).Text = ""
        lblDescripcion(22).Text = ""
        PMObjetoSeguridad(txtCampo(4))
        PMObjetoSeguridad(txtCampo(18))
        PMObjetoSeguridad(cmdBoton(0))
        PMObjetoSeguridad(cmdBoton(1))
        If VGCodPais = "PA" Then
            lblEtiqueta(16).Visible = True
            lblEtiqueta(17).Visible = True
            txtCampo(15).Visible = True
            txtCampo(16).Visible = True
            chkApTasa.Visible = True
            lblEtiqueta(27).Visible = True
            cmbsaldocero.Visible = True
            cmdBoton(7).Visible = True
        End If

        mskCuenta_Enter(mskCuenta, New EventArgs())
        mskCuenta_Leave(mskCuenta, New EventArgs())
        mskCuenta.Enabled = False
        Me.Text = FMLoadResString(20025)
        PLTSEstado()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        CargaParametros("1579", "Q", "3", "AHO", "OCUCOL", 3)
        If VGOcucol = "S" Then
            Label5.Visible = False
            Lblalianza.Visible = False
            lbldesalianza.Visible = False
        End If
    End Sub

    Private Sub FTran202_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdPropietarios_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdPropietarios.Click
        Dim VTTitular As String = ""
        grdPropietarios.Col = 0
        grdPropietarios.SelStartCol = 1
        grdPropietarios.SelEndCol = grdPropietarios.Cols - 1
        If grdPropietarios.Row = 0 Then
            grdPropietarios.SelStartRow = 1
            grdPropietarios.SelEndRow = 1
        Else
            grdPropietarios.SelStartRow = grdPropietarios.Row
            grdPropietarios.SelEndRow = grdPropietarios.Row
        End If
        grdPropietarios.Col = 5
        VTTitular = grdPropietarios.CtlText
        If VTTitular = "T" Then
            If Not optdir(1).Checked Then
                If VLTipoDireccion(0, 0) = "D" Then
                    txtCampo(3).Text = ""
                    lblDescripcion(6).Text = ""
                End If
            Else
                If VLTipoDireccion(1, 0) = "D" Then
                    txtCampo(13).Text = ""
                    lblDescripcion(14).Text = ""
                End If
            End If
        End If
    End Sub

    Private Sub grdPropietarios_ClickEvent(sender As Object, e As EventArgs) Handles grdPropietarios.ClickEvent
        PMMarcaFilaCobisGrid(grdPropietarios, grdPropietarios.Row)
    End Sub

    Private Sub grdPropietarios_DblClick(sender As Object, e As EventArgs) Handles grdPropietarios.DblClick
        PMMarcaFilaCobisGrid(grdPropietarios, grdPropietarios.Row)
    End Sub

    Private Sub grdPropietarios_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdPropietarios.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2223))
    End Sub

    Private Sub cmbenvioec_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbenvioec.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501927))
    End Sub

    Public Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508674))
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
        VLPaso = False
    End Sub

    Public Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        Dim VTNoDatos As Integer = 0
        Dim VTPatente As String = ""
        Dim VTPermiteSldCero As String = ""
        Dim VTEnvioEC As String = ""
        Dim VLDepIni As String = ""
        Dim VLValor As String = ""
        Dim VLCed As String = ""
        Dim VTR As Integer = 0
        Dim VTAplicaTasa As String = ""
        Try
            Dim objTxt As TextBox
            Dim objLbl As Label
            If Not VLPaso Then
                If mskCuenta.ClipText <> "" Then
                    If FMChequeaCtaAho(mskCuenta.ClipText) Then
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "299")
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_up_ah", True, FMLoadResString(508838)) Then
                            Dim Valores(8, 40) As String
                            VTR = FMMapeaMatriz(sqlconn, Valores)
                            PMLimpiaGrid(grdPropietarios)
                            grdPropietarios.Cols = 8
                            For i As Integer = 1 To VTR
                                If Valores(1, i) <> "" Then
                                    VLCed = Valores(1, i)
                                Else
                                    VLCed = Valores(2, i)
                                End If
                                grdPropietarios.AddItem(Conversion.Str(i) & ChrW(9) & Valores(0, i) & ChrW(9) & VLCed & ChrW(9) & Valores(3, i) & ChrW(9) & Valores(4, i) & ChrW(9) & Valores(5, i) & ChrW(9) & Valores(6, i) & ChrW(9) & Valores(7, i))
                            Next i
                            If grdPropietarios.Rows > 2 Then
                                grdPropietarios.RemoveItem(1)
                            End If
                            grdPropietarios.ColIsVisible(0) = False
                            grdPropietarios.ColWidth(1) = 960
                            grdPropietarios.ColWidth(2) = 1440
                            grdPropietarios.ColWidth(3) = 300
                            grdPropietarios.ColWidth(4) = 3915
                            grdPropietarios.ColWidth(5) = 375
                            grdPropietarios.ColWidth(6) = 1230
                            grdPropietarios.ColIsVisible(7) = False
                            grdPropietarios.Row = 0
                            grdPropietarios.Col = 1
                            grdPropietarios.CtlText = FMLoadResString(9919)
                            grdPropietarios.Col = 2
                            grdPropietarios.CtlText = FMLoadResString(9938)
                            grdPropietarios.Col = 3
                            grdPropietarios.CtlText = FMLoadResString(508988)
                            grdPropietarios.Col = 4
                            grdPropietarios.CtlText = FMLoadResString(9940)
                            grdPropietarios.Col = 5
                            grdPropietarios.CtlText = FMLoadResString(508989)
                            grdPropietarios.Col = 6
                            grdPropietarios.CtlText = FMLoadResString(9095)
                            Dim VTArreglo(40) As String
                            fMMapeaArreglo(sqlconn, VTArreglo)
                            PMMapeaObjetoAB(sqlconn, txtCampo(4), lblDescripcion(7))
                            PMMapeaObjetoAB(sqlconn, txtCampo(5), lblDescripcion(8))
                            PMMapeaObjetoAB(sqlconn, txtCampo(6), lblDescripcion(9))
                            PMMapeaObjetoAB(sqlconn, txtCampo(7), lblDescripcion(10))
                            txtCampo(7).Enabled = False
                            PMMapeaObjetoAB(sqlconn, txtCampo(10), lblDescripcion(0))
                            txtCampo(10).Enabled = False
                            PMMapeaObjetoAB(sqlconn, txtCampo(8), lblDescripcion(11))
                            PMMapeaObjetoAB(sqlconn, txtCampo(9), lblDescripcion(12))
                            PMMapeaObjetoAB(sqlconn, txtCampo(18), lblDescripcion(20))
                            PMMapeaObjeto(sqlconn, txtCampo(11))
                            PMMapeaVariable(sqlconn, VLValor)
                            PMMapeaVariable(sqlconn, VLDepIni)
                            PMMapeaVariable(sqlconn, VLCotitular)
                            PMMapeaVariable(sqlconn, VLTraslado)
                            PMMapeaVariable(sqlconn, VTAplicaTasa)
                            PMMapeaVariable(sqlconn, VTEnvioEC)
                            PMMapeaObjeto(sqlconn, txtTipoCta)
                            PMMapeaVariable(sqlconn, VTEnvioEC)
                            PMMapeaVariable(sqlconn, VTPermiteSldCero)
                            PMMapeaObjetoAB(sqlconn, txtCampo(19), lblDescripcion(13))
                            PMMapeaVariable(sqlconn, VTPatente)
                            PMMapeaVariable(sqlconn, mskCuenta2.Text)
                            If txtTipoCta.Enabled Then txtTipoCta.Focus()
                            txtCampo(0).Focus()
                            Mskvalor.Text = VLValor
                            PMChequea(sqlconn)
                            VLNumLib = txtCampo(11).Text
                            grdPropietarios.Row = 1
                            grdPropietarios.Col = 1
                            VLCodTitular = CInt(grdPropietarios.CtlText)
                            plAlianza()
                            If VTEnvioEC = "N" Then
                                cmbenvioec.SelectedIndex = 1
                            Else
                                cmbenvioec.SelectedIndex = 0
                            End If
                            If VTPermiteSldCero = "S" Then
                                cmbsaldocero.SelectedIndex = 1
                            Else
                                cmbsaldocero.SelectedIndex = 0
                            End If
                            chkApTasa.Checked = VTAplicaTasa = "S"
                            Mskvalor.Enabled = Not (VLDepIni = "0")
                            cmdBoton(2).Enabled = True
                            cmdBoton(3).Enabled = True
                            lblDescripcion(1).Text = VTArreglo(8)
                            txtCampo(5).Enabled = False
                            txtCampo(8).Enabled = False

                            'Si Producto Bancario es Aporte Social Adicional Activa el campo Cta RElacionada
                            Dim VLPAR As Integer
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
                            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                            PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "PCAASA")
                            PMPasoValores(sqlconn, "@i_tipo", 0, SQLVARCHAR, "F")
                            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(99835)) Then
                                PMMapeaVariable(sqlconn, VLPAR)
                                If Val(txtCampo(8).Text) = VLPAR Then
                                    mskCuenta2.Enabled = True
                                    'JTA
                                Else
                                    mskCuenta2.Text = FMMascara("", VGMascaraCtaAho)
                                    mskCuenta2.Enabled = False
                                End If
                                PMChequea(sqlconn)
                            Else
                                mskCuenta2.Text = FMMascara("", VGMascaraCtaAho)
                                mskCuenta2.Enabled = False
                                PMChequea(sqlconn)
                            End If

                            VLNumero = grdPropietarios.Rows - 1
                            grdPropietarios.Row = 1
                            grdPropietarios.Col = 5
                            For i As Integer = 1 To grdPropietarios.Rows - 1
                                grdPropietarios.Row = i
                                If grdPropietarios.CtlText = "T" Then
                                    VLTitular = grdPropietarios.Row
                                    grdPropietarios.Col = 1
                                    VLCodTitular = CInt(grdPropietarios.CtlText)
                                    grdPropietarios.Col = 3
                                    VLTipoEnteTitular = grdPropietarios.CtlText
                                    VTNoDatos = 0
                                    Exit For
                                Else
                                    VTNoDatos = 1
                                End If
                            Next i
                            If VTNoDatos = 1 Then
                                PLLimpiar()
                                Exit Sub
                            End If
                            grdPropietarios.ColWidth(0) = 1
                            grdPropietarios.ColWidth(1) = 960
                            grdPropietarios.ColWidth(2) = 1440
                            grdPropietarios.ColWidth(3) = 300
                            grdPropietarios.ColWidth(4) = 3915
                            grdPropietarios.ColWidth(5) = 375
                            grdPropietarios.ColWidth(6) = 1230
                            txtCampo(2).Text = VTArreglo(1)
                            txtCampo(2).Enabled = False
                            txtCampo(12).Text = VTArreglo(9)
                            VLCedula1 = VTArreglo(10)
                            optdir(0).Checked = True
                            PLlblEtiqueta(VTArreglo(2))
                            optdir(1).Checked = True
                            PLlblEtiqueta(VTArreglo(11))
                            objTxt = txtCampo(21)
                            objLbl = lblDescripcion(22)
                            If VTArreglo(2) <> "" Then
                                VLTipoDireccion(0, 0) = VTArreglo(2)
                                If VTArreglo(2) <> "N" And VTArreglo(2) <> "L" Then
                                    objTxt.Text = VTArreglo(2)
                                    PMCatalogo("V", "cl_direccion_ec", objTxt, objLbl)
                                    VLTipoDireccion(0, 1) = objLbl.Text
                                Else
                                    VLTipoDireccion(0, 1) = VTArreglo(4)
                                End If
                            End If
                            If VTArreglo(11) <> "" Then
                                VLTipoDireccion(1, 0) = VTArreglo(11)
                                objTxt.Text = VTArreglo(11)
                                PMCatalogo("V", "cl_direccion_ec", objTxt, objLbl)
                                VLTipoDireccion(1, 1) = objLbl.Text
                            End If
                            objTxt = Nothing
                            objLbl = Nothing
                            Select Case VTArreglo(2)
                                Case "D", "C"
                                    txtCampo(3).Text = VTArreglo(3)
                                    lblDescripcion(6).Text = VTArreglo(4)
                                    txtCampo(3).Tag = VTArreglo(5)
                                Case "R"
                                    txtCampo(3).Text = VTArreglo(6)
                                    lblDescripcion(6).Text = VTArreglo(4)
                                    txtCampo(3).Tag = VTArreglo(5)
                                Case "S"
                                    txtCampo(3).Text = Strings.Mid(VTArreglo(4), 13, VTArreglo(4).Length)
                                    txtCampo(3).Tag = VTArreglo(5)
                                Case Else
                                    txtCampo(3).Text = VTArreglo(3)
                                    lblDescripcion(6).Text = VTArreglo(4)
                                    txtCampo(3).Tag = VTArreglo(5)
                            End Select
                            Select Case VTArreglo(11)
                                Case "D", "C"
                                    txtCampo(13).Text = VTArreglo(12)
                                    lblDescripcion(14).Text = VTArreglo(13)
                                    txtCampo(13).Tag = VTArreglo(14)
                                Case "R"
                                    txtCampo(13).Text = VTArreglo(15)
                                    lblDescripcion(14).Text = VTArreglo(13)
                                    txtCampo(13).Tag = VTArreglo(14)
                                Case "S"
                                    txtCampo(13).Text = Strings.Mid(VTArreglo(13), 13, VTArreglo(13).Length)
                                    txtCampo(13).Tag = VTArreglo(14)
                            End Select
                            If VTArreglo(2) <> "" And VTEnvioEC = "S" Then
                                optdir_Enter(optdir(0), New EventArgs())
                                optdir_CheckedChanged(optdir(0), New EventArgs())
                            ElseIf VTArreglo(11) <> "" Then
                                optdir_Enter(optdir(1), New EventArgs())
                                optdir_CheckedChanged(optdir(1), New EventArgs())
                            Else
                                optdir(0).Checked = False
                                optdir(1).Checked = False
                            End If
                            chkFuncionario.Checked = VTArreglo(7) = "S"
                            If txtCampo(4).Text = "" Then
                                COBISMessageBox.Show(FMLoadResString(501260), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                lblDescripcion(7).Text = ""
                            End If
                            txtTipoCta.Enabled = False
                            cmdBoton(7).Enabled = True
                            If VTArreglo(16) = "P" Then
                                txtCampo(19).Enabled = False
                            End If
                            If VGCodPais = "PA" Then
                                txtCampo(15).Text = VTPatente
                                txtCampo(16).Text = VTArreglo(17)
                            Else
                                VTPatente = " "
                            End If
                            PLTSEstado()
                        Else
                            PMChequea(sqlconn)
                            If VLCuentaV = "AC" Then
                                Me.Dispose()

                            End If
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        PLLimpiar()
                        Exit Sub
                    End If
                Else
                    txtCampo(7).Text = ""
                    lblDescripcion(10).Text = ""
                End If
                If VLEnte Then
                    grdPropietarios.Col = 3
                    For i As Integer = 1 To (grdPropietarios.Rows - 1)
                        grdPropietarios.Row = i
                        If (grdPropietarios.CtlText) = "C" Then
                            grdPropietarios.Col = 5
                            If grdPropietarios.CtlText.Trim() = "T" Then
                                Exit For
                            End If
                        End If
                    Next i
                    VLEnte = False
                End If
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
        End Try
    End Sub

    Private Sub Mskvalor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles Mskvalor.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501261))
        Mskvalor.Text = Mskvalor.Text.ToString()
        Mskvalor.SelectionStart = 0
        Mskvalor.SelectionLength = Strings.Len(Mskvalor.Text)
        Mskvalor.MaxLength = 14
    End Sub

    Private Sub Mskvalor_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles Mskvalor.KeyPress
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
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub optcausa_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optcausa_1.Enter, _optcausa_0.Enter
        Dim Index As Integer = Array.IndexOf(optcausa, eventSender)
        If Index = 0 Then
            txtCampo(14).Text = ""
            lblDescripcion(16).Text = ""
            txtCampo(14).Enabled = False
        Else
            txtCampo(14).Enabled = True
        End If
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub optdir_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optdir_1.CheckedChanged, _optdir_0.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Index As Integer = Array.IndexOf(optdir, eventSender)
            If Index = 0 Then
                txtCampo(3).Visible = True
                txtCampo(13).Visible = Not txtCampo(3).Visible
                lblDescripcion(6).Visible = True
                lblDescripcion(14).Visible = Not lblDescripcion(6).Visible
                lblEtiqueta(12).Visible = True
                lblEtiqueta(19).Visible = Not lblEtiqueta(12).Visible
                txtCampo(21).Text = VLTipoDireccion(Index, 0)
                lblDescripcion(22).Text = VLTipoDireccion(Index, 1)
            Else
                txtCampo(13).Visible = True
                txtCampo(3).Visible = Not txtCampo(13).Visible
                lblDescripcion(14).Visible = True
                lblDescripcion(6).Visible = Not lblDescripcion(14).Visible
                lblEtiqueta(19).Visible = True
                lblEtiqueta(12).Visible = Not lblEtiqueta(19).Visible
                txtCampo(21).Text = VLTipoDireccion(Index, 0)
                lblDescripcion(22).Text = VLTipoDireccion(Index, 1)
            End If
        End If
    End Sub

    Private Sub optdir_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optdir_1.Enter, _optdir_0.Enter
        Dim Index As Integer = Array.IndexOf(optdir, eventSender)
        optdir(Index).Checked = True
    End Sub

    Private Sub PLAniadir()
        Dim VTResult As Integer = 0
        Dim VTCadena As String = ""
        Dim vti As Integer = 1
        Dim VTValores(15) As String
        Dim VTArreglo(10) As String
        If grdPropietarios.Rows - 1 >= 20 Then
            COBISMessageBox.Show(FMLoadResString(501191), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            Exit Sub
        End If
        If mskCuenta.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(501337), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If mskCuenta.Enabled Then mskCuenta.Focus()
            Exit Sub
        End If
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500728), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(0).Enabled Then txtCampo(0).Focus()
            Exit Sub
        End If
        If lblDescripcion(4).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501139), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If lblDescripcion(3).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501138), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501137), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(1).Focus()
            Exit Sub
        End If
        If txtCampo(18).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501200), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(18).Visible And txtCampo(18).Enabled Then txtCampo(18).Focus()
            Exit Sub
        End If
        If txtCampo(1).Text = "T" Then
            COBISMessageBox.Show(FMLoadResString(501929), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Text = ""
            txtCampo(1).Text = ""
            lblDescripcion(2).Text = ""
            lblDescripcion(3).Text = ""
            lblDescripcion(4).Text = ""
            lblDescripcion(5).Text = ""
            txtCampo(0).Focus()
            Exit Sub
        End If
        If txtCampo(1).Text = "U" Then
            COBISMessageBox.Show(FMLoadResString(508964), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            txtCampo(0).Text = ""
            txtCampo(1).Text = ""
            lblDescripcion(2).Text = ""
            lblDescripcion(3).Text = ""
            lblDescripcion(4).Text = ""
            lblDescripcion(5).Text = ""
            txtCampo(0).Focus()
            Exit Sub
        End If
        Dim VLTiEnteTitular As String = ""
        For i As Integer = 1 To grdPropietarios.Rows
            grdPropietarios.Row = i
            grdPropietarios.Col = 5
            If grdPropietarios.CtlText = "T" Then
                grdPropietarios.Col = 3
                VLTiEnteTitular = grdPropietarios.CtlText
                grdPropietarios.Col = 5
                Exit For
            End If
        Next i
        If VLTiEnteTitular = "C" Then
            If txtCampo(1).Text.Trim() = "C" Then
                COBISMessageBox.Show(FMLoadResString(501134), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(1).Enabled And txtCampo(1).Visible Then txtCampo(1).Focus()
                Exit Sub
            End If
            If lblDescripcion(3).Text = "C" And txtCampo(1).Text.Trim() = "F" Then
                COBISMessageBox.Show(FMLoadResString(501928), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(1).Enabled And txtCampo(1).Visible Then txtCampo(1).Focus()
                Exit Sub
            End If
        End If
        If Not FLValidarPropietarios(1) Then
            Exit Sub
        End If
        '17/Ago/2016
        VLTutor = False
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "350")
        PMPasoValores(sqlconn, "@i_retorna", 0, SQLINT1, "1")
        VTCadena = ""
        VTCadena = VTCadena & (txtCampo(0).Text) & "@"
        VTCadena = VTCadena & (txtCampo(1).Text) & "@"
        VTCadena = VTCadena & (lblDescripcion(4).Text) & "@"
        PMPasoValores(sqlconn, "@i_param" & vti, 0, SQLCHAR, VTCadena)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_valida_menor", True, FMLoadResString(2528)) Then
            VTR1 = FMMapeaArreglo(sqlconn, VTValores)
            PMChequea(sqlconn)
            If VTR1 > 0 Then
                VLTutor = True
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "cl_rol")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, "U")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", False, "") Then
                    VTR1 = FMMapeaArreglo(sqlconn, VTArreglo)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
            End If
        Else
            PMChequea(sqlconn)
            txtCampo(0).Text = ""
            txtCampo(0).Focus()
            lblDescripcion(2).Text = ""
            lblDescripcion(3).Text = ""
            lblDescripcion(4).Text = ""
            txtCampo(1).Text = ""
            lblDescripcion(5).Text = ""
            Exit Sub
        End If
        '
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "208")
        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
        PMPasoValores(sqlconn, "@o_det_prod", 1, SQLINT4, "1")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_propietarios_ctahorro", False, "") Then
            PMChequea(sqlconn)
            VTResult = CInt(FMRetParam(sqlconn, 1))
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "296")
            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
            PMPasoValores(sqlconn, "@i_dprod", 0, SQLINT4, Conversion.Str(VTResult))
            PMPasoValores(sqlconn, "@i_cli", 0, SQLINT4, txtCampo(0).Text)
            PMPasoValores(sqlconn, "@i_rolcli", 0, SQLCHAR, txtCampo(1).Text)
            PMPasoValores(sqlconn, "@i_cedruc", 0, SQLVARCHAR, lblDescripcion(2).Text)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_propietarios_ctahorro", True, FMLoadResString(508984) & txtCampo(0).Text & "]") Then
                PMChequea(sqlconn)
                grdPropietarios.AddItem(Conversion.Str(VLNumero + 1) & Strings.Chr(9).ToString() & txtCampo(0).Text & Strings.Chr(9).ToString() & lblDescripcion(2).Text & Strings.Chr(9).ToString() & lblDescripcion(3).Text & Strings.Chr(9).ToString() & lblDescripcion(4).Text & Strings.Chr(9).ToString() & txtCampo(1).Text & Strings.Chr(9).ToString() & lblDescripcion(5).Text, VLNumero + 1)
                txtCampo(0).Focus()
                VLNumero += 1
                txtCampo(0).Text = ""
                txtCampo(1).Text = ""
                lblDescripcion(2).Text = ""
                lblDescripcion(3).Text = ""
                lblDescripcion(4).Text = ""
                lblDescripcion(5).Text = ""
                PMCatalogo("D", "cl_rol", txtCampo(1), lblDescripcion(5))
            Else
                PMChequea(sqlconn)
                txtCampo(0).Focus()
                txtCampo(0).Text = ""
                lblDescripcion(2).Text = ""
                lblDescripcion(3).Text = ""
                lblDescripcion(4).Text = ""
                txtCampo(1).Text = ""
                lblDescripcion(5).Text = ""
            End If
        End If
    End Sub

    Private Sub PLEliminar()
        Dim VTResult As Integer = 0
        grdPropietarios.Col = 5
        If grdPropietarios.CtlText = "" And grdPropietarios.Rows = 2 Then
            grdPropietarios.Row = 1
        End If

        If mskCuenta.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(501337), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If mskCuenta.Enabled And mskCuenta.Visible Then mskCuenta.Focus()
            Exit Sub
        End If
        If grdPropietarios.CtlText = "T" Then
            COBISMessageBox.Show(FMLoadResString(501951), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).Focus()
            Exit Sub
        End If
        If grdPropietarios.CtlText = "U" And VGCodPais = "CO" Then
            COBISMessageBox.Show(FMLoadResString(508965), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).Focus()
            Exit Sub
        End If
        Dim VTFila As Integer = grdPropietarios.Row
        If Not FLVerificarMenor(grdPropietarios.Row) Then
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "208")
        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
        PMPasoValores(sqlconn, "@o_det_prod", 1, SQLINT4, "1")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_propietarios_ctahorro", False, "") Then
            PMChequea(sqlconn)
            VTResult = CInt(Conversion.Val(FMRetParam(sqlconn, 1)))
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "295")
            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
            PMPasoValores(sqlconn, "@i_dprod", 0, SQLINT4, Conversion.Str(VTResult))
            grdPropietarios.Col = 1
            grdPropietarios.Row = VTFila
            PMPasoValores(sqlconn, "@i_cli", 0, SQLINT4, grdPropietarios.CtlText)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_propietarios_ctahorro", True, FMLoadResString(508985) & grdPropietarios.CtlText & "]") Then
                PMChequea(sqlconn)
                grdPropietarios.Col = 1
                If grdPropietarios.CtlText = VLCotitular Then
                    txtCampo(12).Text = ""
                    VLCotitular = "0"
                    PLTransmitir()
                End If
                txtCampo(0).Focus()
                VLNumero -= 1
                grdPropietarios.RemoveItem(CShort(grdPropietarios.Row))
                grdPropietarios.SelStartRow = grdPropietarios.Row
                grdPropietarios.SelEndRow = grdPropietarios.Row
            Else
                PMChequea(sqlconn)
            End If
        Else
            txtCampo(0).Focus()
            txtCampo(0).Text = ""
            lblDescripcion(2).Text = ""
            lblDescripcion(3).Text = ""
            lblDescripcion(4).Text = ""
            txtCampo(1).Text = ""
            lblDescripcion(5).Text = ""
        End If
    End Sub

    Private Sub PLImprimir()
        Dim VTTipo As String = ""
        Dim VLFechaEmi As String = ""
        If frmDirecciones.Visible Then
            If VLTipoDireccion(0, 0) = "D" Then
                VTTipo = lblDescripcion(6).Text
            ElseIf VLTipoDireccion(0, 0) = "C" Then
                VTTipo = "Casilla : " & lblDescripcion(6).Text
            ElseIf VLTipoDireccion(0, 0) = "R" Then
                VTTipo = "Sucursal : " & lblDescripcion(6).Text
            ElseIf VLTipoDireccion(0, 0) = "S" Then
                VTTipo = "Casillero : " & txtCampo(3).Text
            End If
        End If
        If COBISMessageBox.Show(FMLoadResString(501264), FMLoadResString(500092), COBISMessageBox.COBISButtons.OKCancel, COBISMessageBox.COBISIcon.Question) = System.Windows.Forms.DialogResult.OK Then
            Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
            VLFechaEmi = FMConvFecha(DateTime.Today.ToString(VLFormatoFecha), CGFormatoBase, VGFormatoFecha)

            FMCabeceraReporte(VGBanco, VLFechaEmi, FMLoadResString(508966), DateTimeHelper.ToString(DateTimeHelper.Time), Me.Text, VGFecha, CStr(1))
            'COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Font = Compatibility.VB6.FontChangeName(COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Font, "Courier")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontName = "Courier"
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 8
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("      " + FMLoadResString(500333) + " :", FileSystem.TAB(35), mskCuenta.Text) 'Número de Cuenta
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("      " + FMLoadResString(501038) + " :", FileSystem.TAB(35), txtCampo(2).Text) 'Nombre de la Cuenta
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("      " + FMLoadResString(503093) + " :", FileSystem.TAB(35), lblDescripcion(11).Text) 'Producto bancario
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("      " + FMLoadResString(508970) + " :", FileSystem.TAB(35), lblDescripcion(12).Text) 'Origen de la cuenta
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            If frmDirecciones.Visible Then
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("      " + FMLoadResString(508971) + " :", FileSystem.TAB(35), VTTipo & lblDescripcion(6).Text) 'Dirección estado de cuenta
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            End If
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("      " + FMLoadResString(508972) + " :", FileSystem.TAB(35), lblDescripcion(7).Text) 'Oficial de cuenta
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("      " + FMLoadResString(508973) + " :", FileSystem.TAB(35), lblDescripcion(8).Text) 'Tipo de promedio
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("      " + FMLoadResString(508974) + " :", FileSystem.TAB(35), lblDescripcion(9).Text) 'Ciclo de la cuenta
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("      " + FMLoadResString(508975) + " :", FileSystem.TAB(35), lblDescripcion(0).Text) 'Tipo de capitalización
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("      " + FMLoadResString(508976) + " :", FileSystem.TAB(35), lblDescripcion(10).Text) 'Categoría de la cuenta
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("      " + FMLoadResString(508977) + " :", FileSystem.TAB(35), lblDescripcion(20).Text) 'Titularidad
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("      " + FMLoadResString(508978) + " :", FileSystem.TAB(35), cmbenvioec.Text) 'Enviar Estado de Cuenta
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            If VGCodPais = "PA" Then
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("      " + FMLoadResString(508979) + "                        :", FileSystem.TAB(35), txtCampo(15).Text) 'Patente
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("      " + FMLoadResString(508980) + "                    :", FileSystem.TAB(35), txtCampo(16).Text) 'Fideicomiso
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            End If
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(New String("_", 125))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), VGLogin)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("      _________________                                                  _________________")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("        " + FMLoadResString(508981) + "                                                     " + FMLoadResString(508982) + " ") 'PROCESADO POR - VERIFICADO POR
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.EndDoc()
            Me.Cursor = System.Windows.Forms.Cursors.Default
        End If
    End Sub

    Private Sub PLProcesarPropietarios(ByVal ParTipoPropietario As String, ByVal ParPrincipal As Integer)
        Dim bandera As Integer = 0
        If ParPrincipal = 1 Then
            XT += 1
            Roles(XT, 1) = ParTipoPropietario
        End If
        For i As Integer = 1 To grdPropietarios.Rows - 1
            grdPropietarios.Col = 5
            grdPropietarios.Row = i
            bandera = 0
            For YT As Integer = 1 To XT
                If grdPropietarios.CtlText = Roles(YT, 1) Then
                    bandera = 1
                End If
            Next YT
            If grdPropietarios.CtlText = ParTipoPropietario Or (ParTipoPropietario = "OTROS" And bandera <> 1) Then
                VLContadorprop += 1
                ReDim Preserve VTMatrizprop(grdPropietarios.Cols - 1, VLContadorprop)
                For j As Integer = 1 To grdPropietarios.Cols - 1
                    grdPropietarios.Col = j
                    grdPropietarios.Row = i
                    VTMatrizprop(j - 1, VLContadorprop) = grdPropietarios.CtlText
                Next j
            End If
        Next i
    End Sub

    Private Sub PLLimpiar()
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
        For i As Integer = 0 To 13
            txtCampo(i).Text = ""
        Next i
        If Not Mskvalor.Enabled Then
            Mskvalor.Enabled = True
        End If
        Mskvalor.Text = ""
        txtCampo(3).Tag = ""
        For i As Integer = 0 To 15
            lblDescripcion(i).Text = ""
        Next i
        txtCampo(18).Text = ""
        lblDescripcion(20).Text = ""
        txtTipoCta.Text = ""
        grdPropietarios.Rows = 2
        grdPropietarios.Row = 1
        For i As Integer = 0 To grdPropietarios.Cols - 1
            grdPropietarios.Col = i
            grdPropietarios.CtlText = ""
        Next i
        grdPropietarios.Tag = ""
        VLNumero = 0
        VLTitular = 0
        txtCampo(7).Enabled = False
        PMCatalogo("D", "cl_rol", txtCampo(1), lblDescripcion(5))
        chkFuncionario.Checked = False
        cmdBoton(2).Enabled = True
        cmdBoton(5).Enabled = False
        txtCampo(5).Enabled = True
        txtCampo(10).Enabled = True
        txtCampo(2).Enabled = True
        PMObjetoSeguridad(txtCampo(4))
        txtCampo(6).Enabled = True
        txtCampo(9).Enabled = True
        txtCampo(11).Enabled = True
        txtCampo(8).Enabled = True
        PMObjetoSeguridad(txtCampo(18))
        PMObjetoSeguridad(cmdBoton(0))
        PMObjetoSeguridad(cmdBoton(1))
        mskCuenta.Enabled = True
        cmdBoton(2).Enabled = False
        VLCotitular = "0"
        VLEnte = True
        mskCuenta.Focus()
        optcausa(0).Checked = False
        optcausa(1).Checked = False
        txtCampo(14).Text = ""
        lblDescripcion(16).Text = ""
        cmbenvioec.SelectedIndex = 1
        txtCampo(14).Enabled = False
        cmbsaldocero.SelectedIndex = 0
        txtCampo(19).Text = ""
        lblDescripcion(13).Text = ""
        cmdBoton(7).Enabled = False
        txtCampo(19).Enabled = True
        If VGCodPais = "PA" Then
            txtCampo(15).Enabled = True
            txtCampo(15).Text = ""
            txtCampo(16).Enabled = True
            txtCampo(16).Text = ""
        End If
        optdir(1).Checked = True
        optdir_CheckedChanged(optdir(1), New EventArgs())
        txtCampo(21).Text = ""
        lblDescripcion(22).Text = ""
        For n As Integer = 0 To VLTipoDireccion.GetUpperBound(0) - 1
            For C As Integer = 0 To VLTipoDireccion.GetUpperBound(1) - 1
                VLTipoDireccion(n, C) = ""
            Next C
        Next n
        Lblalianza.Text = ""
        lbldesalianza.Text = ""

        mskCuenta2.Mask = VGMascaraCtaAho
        mskCuenta2.Text = FMMascara("", VGMascaraCtaAho)
        mskCuenta2.Enabled = False

        PLTSEstado()
    End Sub

    Private Sub PLTransmitir()
        Dim VLDepoIni As String = String.Empty
        Dim VTPatente As String = String.Empty
        Dim VLCausa As String = String.Empty
        If mskCuenta.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(501337), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskCuenta.Focus()
            Exit Sub
        End If
        If VLTitular <= 0 Then
            COBISMessageBox.Show(FMLoadResString(501931), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If txtCampo(9).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(5285), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(9).Focus()
            Exit Sub
        End If
        If txtCampo(2).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501932), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(2).Focus()
            Exit Sub
        End If
        If txtCampo(6).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501205), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(6).Focus()
            Exit Sub
        End If
        If (txtCampo(3).Text = "" Or VLTipoDireccion(0, 0) = "N" Or VLTipoDireccion(0, 0) = "L") And cmbenvioec.Text = "S" Then
            COBISMessageBox.Show(FMLoadResString(501202), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(21).Focus()
            Exit Sub
        End If
        If txtCampo(13).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501203), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If lblDescripcion(6).Text = "" And cmbenvioec.Text = "S" Then
            COBISMessageBox.Show(FMLoadResString(501934), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(21).Focus()
            Exit Sub
        End If
        If lblDescripcion(14).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501935), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(21).Focus()
            Exit Sub
        End If
        If txtCampo(4).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501199), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(4).Focus()
            Exit Sub
        End If
        If txtCampo(5).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501204), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(5).Focus()
            Exit Sub
        End If

        If txtCampo(10).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501212), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(10).Focus()
            Exit Sub
        End If
        If txtCampo(7).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501207), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(7).Enabled Then txtCampo(7).Focus()
            Exit Sub
        End If
        If txtCampo(8).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501953), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(8).Enabled Then
                txtCampo(8).Focus()
            End If
            Exit Sub
        End If
        If txtCampo(19).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501268), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(19).Visible And txtCampo(19).Enabled Then txtCampo(19).Focus()
            Exit Sub
        End If
        If mskCuenta2.Enabled = True And mskCuenta2.ClipText = "" Then
            ' si eligio Producto de Aporte Social Adicional se activa campo Cta Relacionada
            'ERROR: Debe registrar Cuenta Relacionada para provisión de Intereses
            COBISMessageBox.Show(FMLoadResString(99834), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskCuenta2.Focus()
            Exit Sub
        End If
        If Not FLVerificarMenor(-1) Then
            Exit Sub
        End If
        If txtCampo(18).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501200), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(18).Visible And txtCampo(18).Enabled Then txtCampo(18).Focus()
            Exit Sub
        End If
        If VLNumero = 1 And txtCampo(18).Text <> "I" Then
            COBISMessageBox.Show(FMLoadResString(2609), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(18).Visible And txtCampo(18).Enabled Then txtCampo(18).Focus()
            Exit Sub
        End If
        If mskCuenta.Enabled = True And mskCuenta.ClipText = "" Then
            ' si eligio Producto de Aporte Social Adicional se activa campo Cta Relacionada
            'ERROR: Debe registrar Cuenta Relacionada para provisión de Intereses
            COBISMessageBox.Show(FMLoadResString(99834), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskCuenta.Focus()
            Exit Sub
        End If
        If mskCuenta.Enabled = True And mskCuenta.ClipText <> "" Then
            If FMChequeaCtaAho(mskCuenta.ClipText) Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                PMPasoValores(sqlconn, "@i_relacionada", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_consulta", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_codcliente", 0, SQLVARCHAR, VLCodTitular)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(502622) & " [" & mskCuenta.Text & "]") Then
                    PMChequea(sqlconn)
                Else
                    mskCuenta.Mask = VGMascaraCtaAho
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                    mskCuenta.Focus()
                    PMChequea(sqlconn)
                    Exit Sub
                End If
            Else
                COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskCuenta.Mask = VGMascaraCtaAho
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                mskCuenta.Focus()
                Exit Sub
            End If
        End If
        If Not FLValidarPropietarios(0) Then
            Exit Sub
        End If
        txtCampo(11).Text = VLNumLib
        If optcausa(0).Checked Or optcausa(1).Checked Or (VLNumLib <> txtCampo(11).Text) Then
            If txtCampo(11).Text = "" Or VTNumLib = 0 Then
                COBISMessageBox.Show(FMLoadResString(501954), My.Application.Info.ProductName)
                txtCampo(11).Focus()
                Exit Sub
            ElseIf VLNumLib = txtCampo(11).Text And optcausa(1).Checked Then
                COBISMessageBox.Show(FMLoadResString(501955), My.Application.Info.ProductName)
                txtCampo(11).Focus()
                Exit Sub
            ElseIf VLNumLib <> txtCampo(11).Text And optcausa(0).Checked Then
                COBISMessageBox.Show(FMLoadResString(501956), My.Application.Info.ProductName)
                txtCampo(11).Focus()
                Exit Sub
            ElseIf Not optcausa(0).Checked And Not optcausa(1).Checked Then
                COBISMessageBox.Show(FMLoadResString(501957), My.Application.Info.ProductName)
                txtCampo(11).Focus()
                Exit Sub
            ElseIf optcausa(1).Checked And txtCampo(14).Text = "" Then
                COBISMessageBox.Show(FMLoadResString(501958), My.Application.Info.ProductName)
                If Not txtCampo(14).Enabled Then
                    txtCampo(14).Enabled = True
                End If
                txtCampo(14).Focus()
                Exit Sub
            ElseIf optcausa(0).Checked Then
                VLCausa = "A"
            Else
                VLCausa = "C"
            End If
        Else
            VLCausa = ""
        End If
        VTPatente = " "
        If VGCodPais = "PA" Then
            If txtCampo(15).Text = "" Then
                VTPatente = " "
            Else
                VTPatente = txtCampo(15).Text
            End If
        End If
        '03/Oct/2016 Validacion si el nombre del Cliente es diferente de vacio luego de armar la cuenta
        If Not FLArmadoNomCta() Then
            Exit Sub
        End If

        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "202")
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
        PMPasoValores(sqlconn, "@i_nombre", 0, SQLVARCHAR, txtCampo(2).Text)
        PMPasoValores(sqlconn, "@i_cli1", 0, SQLINT4, VLCotitular)
        PMPasoValores(sqlconn, "@i_tipocta_super", 0, SQLVARCHAR, txtTipoCta.Text)
        If txtCampo(12).Text <> "" Then
            txtCampo(12).Text = " "
            VLCedula1 = " "
            PMPasoValores(sqlconn, "@i_nombre1", 0, SQLVARCHAR, txtCampo(12).Text)
            PMPasoValores(sqlconn, "@i_cedruc1", 0, SQLVARCHAR, VLCedula1)
        Else
            txtCampo(12).Text = " "
            VLCedula1 = " "
            PMPasoValores(sqlconn, "@i_nombre1", 0, SQLVARCHAR, txtCampo(12).Text)
            PMPasoValores(sqlconn, "@i_cedruc1", 0, SQLVARCHAR, VLCedula1)
        End If
        If cmbenvioec.Text = "N" Then
            PMPasoValores(sqlconn, "@i_agencia", 0, SQLINT2, "0")
            PMPasoValores(sqlconn, "@i_direc", 0, SQLINT1, "0")
            PMPasoValores(sqlconn, "@i_cli_ec", 0, SQLINT4, "0")
            PMPasoValores(sqlconn, "@i_tipodir", 0, SQLCHAR, "N")
        ElseIf VLTipoDireccion(0, 0) = "D" Then
            PMPasoValores(sqlconn, "@i_direc", 0, SQLINT1, txtCampo(3).Text)
            PMPasoValores(sqlconn, "@i_cli_ec", 0, SQLINT4, Convert.ToString(txtCampo(3).Tag))
            PMPasoValores(sqlconn, "@i_tipodir", 0, SQLCHAR, "D")
        ElseIf VLTipoDireccion(0, 0) = "C" Then
            PMPasoValores(sqlconn, "@i_direc", 0, SQLINT1, txtCampo(3).Text)
            PMPasoValores(sqlconn, "@i_cli_ec", 0, SQLINT4, Convert.ToString(txtCampo(3).Tag))
            PMPasoValores(sqlconn, "@i_tipodir", 0, SQLCHAR, "C")
        ElseIf VLTipoDireccion(0, 0) = "S" Then
            PMPasoValores(sqlconn, "@i_casillero", 0, SQLVARCHAR, txtCampo(3).Text)
            PMPasoValores(sqlconn, "@i_tipodir", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_direc", 0, SQLINT1, "0")
            PMPasoValores(sqlconn, "@i_cli_ec", 0, SQLINT4, "0")
        ElseIf VLTipoDireccion(0, 0) = "R" Then
            PMPasoValores(sqlconn, "@i_agencia", 0, SQLINT2, txtCampo(3).Text)
            PMPasoValores(sqlconn, "@i_tipodir", 0, SQLCHAR, "R")
            PMPasoValores(sqlconn, "@i_direc", 0, SQLINT1, "0")
            PMPasoValores(sqlconn, "@i_cli_ec", 0, SQLINT4, "0")
        End If
        If VLTipoDireccion(1, 0) = "D" Then
            PMPasoValores(sqlconn, "@i_direc_dv", 0, SQLINT1, txtCampo(13).Text)
            PMPasoValores(sqlconn, "@i_cli_dv", 0, SQLINT4, Convert.ToString(txtCampo(13).Tag))
            PMPasoValores(sqlconn, "@i_tipodir_dv", 0, SQLCHAR, "D")
        ElseIf VLTipoDireccion(1, 0) = "C" Then
            PMPasoValores(sqlconn, "@i_direc_dv", 0, SQLINT1, txtCampo(13).Text)
            PMPasoValores(sqlconn, "@i_cli_dv", 0, SQLINT4, Convert.ToString(txtCampo(13).Tag))
            PMPasoValores(sqlconn, "@i_tipodir_dv", 0, SQLCHAR, "C")
        ElseIf VLTipoDireccion(1, 0) = "S" Then
            PMPasoValores(sqlconn, "@i_casillero_dv", 0, SQLVARCHAR, txtCampo(13).Text)
            PMPasoValores(sqlconn, "@i_tipodir_dv", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_direc_dv", 0, SQLINT1, "0")
            PMPasoValores(sqlconn, "@i_cli_dv", 0, SQLINT4, "0")
        ElseIf VLTipoDireccion(1, 0) = "R" Then
            PMPasoValores(sqlconn, "@i_agencia_dv", 0, SQLINT2, txtCampo(13).Text)
            PMPasoValores(sqlconn, "@i_tipodir_dv", 0, SQLCHAR, "R")
            PMPasoValores(sqlconn, "@i_direc_dv", 0, SQLINT1, "0")
            PMPasoValores(sqlconn, "@i_cli_dv", 0, SQLINT4, "0")
        End If
        If Mskvalor.Text <> "" Then
            VLDepoIni = Conversion.Str(CDec(Mskvalor.Text))
        Else
            VLDepoIni = "0"
        End If
        PMPasoValores(sqlconn, "@i_ofl", 0, SQLINT2, txtCampo(4).Text)
        PMPasoValores(sqlconn, "@i_tprom", 0, SQLCHAR, txtCampo(5).Text)
        PMPasoValores(sqlconn, "@i_ciclo", 0, SQLCHAR, txtCampo(6).Text)
        PMPasoValores(sqlconn, "@i_categ", 0, SQLCHAR, txtCampo(7).Text)
        PMPasoValores(sqlconn, "@i_capit", 0, SQLCHAR, txtCampo(10).Text)
        PMPasoValores(sqlconn, "@i_origen", 0, SQLVARCHAR, txtCampo(9).Text)
        PMPasoValores(sqlconn, "@i_numlib", 0, SQLINT4, txtCampo(11).Text)
        PMPasoValores(sqlconn, "@i_valor", 0, SQLMONEY, VLDepoIni)
        PMPasoValores(sqlconn, "@i_depini", 0, SQLINT1, "0")
        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
        PMPasoValores(sqlconn, "@i_prodbanc", 0, SQLINT2, txtCampo(8).Text)
        If VGCodPais = "PA" Then
            If txtCampo(16).Text.Trim() <> "" Then
                PMPasoValores(sqlconn, "@i_fideicomiso", 0, SQLCHAR, txtCampo(16).Text)
            End If
        End If
        PMPasoValores(sqlconn, "@i_causa", 0, SQLCHAR, VLCausa)
        PMPasoValores(sqlconn, "@i_estado_cuenta", 0, SQLCHAR, cmbenvioec.Text)
        PMPasoValores(sqlconn, "@i_tipocta_super", 0, SQLVARCHAR, txtCampo(19).Text)
        PMPasoValores(sqlconn, "@i_permite_sldcero", 0, SQLCHAR, cmbsaldocero.Text)
        PMPasoValores(sqlconn, "@i_titularidad", 0, SQLCHAR, txtCampo(18).Text)
        PMPasoValores(sqlconn, "@i_patente", 0, SQLVARCHAR, VTPatente)
        If mskCuenta2.Enabled = True And mskCuenta2.ClipText <> "" Then
            PMPasoValores(sqlconn, "@i_cta_banco_rel", 0, SQLVARCHAR, mskCuenta2.ClipText)
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_up_ctahorro", True, FMLoadResString(503281)) Then
            PMMapeaObjeto(sqlconn, lblDescripcion(1))
            PMChequea(sqlconn)
            cmdBoton(0).Enabled = False
            cmdBoton(1).Enabled = False
            cmdBoton(2).Enabled = False
            cmdBoton(5).Enabled = True
            cmdBoton(6).Enabled = True
            txtCampo(2).Enabled = False
            txtCampo(4).Enabled = False
            txtCampo(6).Enabled = False
            txtCampo(7).Enabled = False
            txtCampo(8).Enabled = False
            txtCampo(9).Enabled = False
            txtCampo(10).Enabled = False
            txtCampo(11).Enabled = False
            txtCampo(12).Enabled = False
            txtCampo(18).Enabled = False
            txtCampo(19).Enabled = False
            If VGCodPais = "PA" Then txtCampo(15).Enabled = False
            mskCuenta.Enabled = False
        Else
            PMChequea(sqlconn)
            cmdBoton(3).Focus()
        End If
        cmdBoton(0).Enabled = False
        cmdBoton(1).Enabled = False
        PLTSEstado()
    End Sub

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_21.TextChanged, _txtCampo_3.TextChanged, _txtCampo_13.TextChanged, _txtCampo_16.TextChanged, _txtCampo_15.TextChanged, _txtCampo_18.TextChanged, _txtCampo_19.TextChanged, _txtCampo_7.TextChanged, _txtCampo_14.TextChanged, _txtCampo_12.TextChanged, _txtCampo_11.TextChanged, _txtCampo_9.TextChanged, _txtCampo_8.TextChanged, _txtCampo_10.TextChanged, _txtCampo_6.TextChanged, _txtCampo_0.TextChanged, _txtCampo_1.TextChanged, _txtCampo_2.TextChanged, _txtCampo_4.TextChanged, _txtCampo_5.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 18, 19, 15, 21
                VLPaso = False
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_21.Enter, _txtCampo_3.Enter, _txtCampo_13.Enter, _txtCampo_16.Enter, _txtCampo_15.Enter, _txtCampo_18.Enter, _txtCampo_19.Enter, _txtCampo_7.Enter, _txtCampo_14.Enter, _txtCampo_12.Enter, _txtCampo_11.Enter, _txtCampo_9.Enter, _txtCampo_8.Enter, _txtCampo_10.Enter, _txtCampo_6.Enter, _txtCampo_0.Enter, _txtCampo_1.Enter, _txtCampo_2.Enter, _txtCampo_4.Enter, _txtCampo_5.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508514))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501145))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501936))
            Case 3
                If VLTipoDireccion(0, 0) = "D" Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508507))
                ElseIf VLTipoDireccion(0, 0) = "C" Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501219))
                ElseIf VLTipoDireccion(0, 0) = "R" Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501220))
                ElseIf VLTipoDireccion(0, 0) = "S" Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501221))
                End If
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501222))
            Case 5
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501223))
            Case 6
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501224))
            Case 7
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501225))
            Case 8
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501226))
            Case 9
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501227))
            Case 10
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501961))
            Case 11
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501962))
            Case 13
                If VLTipoDireccion(1, 0) = "D" Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508504))
                    txtCampo(13).MaxLength = 2
                ElseIf VLTipoDireccion(1, 0) = "C" Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508506))
                    txtCampo(13).MaxLength = 2
                ElseIf VLTipoDireccion(1, 0) = "R" Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501220))
                    txtCampo(13).MaxLength = 4
                ElseIf VLTipoDireccion(1, 0) = "S" Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501221))
                End If
            Case 14
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501963))
            Case 18
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501234))
            Case 19
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501236))
            Case 15
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5163))
            Case 21
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500802))
        End Select
        VLPaso = True
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_21.KeyDown, _txtCampo_3.KeyDown, _txtCampo_13.KeyDown, _txtCampo_16.KeyDown, _txtCampo_15.KeyDown, _txtCampo_18.KeyDown, _txtCampo_19.KeyDown, _txtCampo_7.KeyDown, _txtCampo_14.KeyDown, _txtCampo_12.KeyDown, _txtCampo_11.KeyDown, _txtCampo_9.KeyDown, _txtCampo_8.KeyDown, _txtCampo_10.KeyDown, _txtCampo_6.KeyDown, _txtCampo_0.KeyDown, _txtCampo_1.KeyDown, _txtCampo_2.KeyDown, _txtCampo_4.KeyDown, _txtCampo_5.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim n As Integer = 0
        Dim VTCliente As String = String.Empty
        If Keycode = VGTeclaAyuda Then
            Select Case Index
                Case 0
                    txtCampo(0).Text = ""
                    VLPaso = True
                    'FMain = FPrincipal
                    If VGFBusCliente Is Nothing Then
                        VGFBusCliente = New BClientes.BuscarClientes()
                    End If
                    'MODO KAMILO
                    VGFBusCliente = New COBISCorp.tCOBIS.BClientes.BuscarClientes()
                    Dim FBuscarCliente = New COBISCorp.tCOBIS.BClientes.FBuscarClienteClass()
                    VGFBusCliente = New COBISCorp.tCOBIS.BClientes.BuscarClientes()
                    FBuscarCliente.optCliente(1).Enabled = True
                    FBuscarCliente.optCliente(0).Checked = True
                    FBuscarCliente.ShowPopup(Me)
                    FBuscarCliente.optCliente(1).Enabled = True
                    VGBusqueda = VGFBusCliente.PMRetornaCliente()
                    If VGBusqueda(1) <> "" Then
                        txtCampo(0).Text = VGBusqueda(1)
                        lblDescripcion(3).Text = VGBusqueda(0)
                        If VGBusqueda(0) = "P" Then
                            lblDescripcion(2).Text = VGBusqueda(5)
                            VTCliente = VGBusqueda(2) & " " & VGBusqueda(3) & " " & VGBusqueda(4)
                            lblDescripcion(4).Text = VTCliente
                        Else
                            lblDescripcion(2).Text = VGBusqueda(3)
                            lblDescripcion(4).Text = VGBusqueda(2)
                        End If
                        txtCampo(1).Focus()
                    End If
                Case 1
                    VLPaso = True
                    PMCatalogo("A", "cl_rol", txtCampo(1), lblDescripcion(5))
                    If txtCampo(1).Text <> "" Then
                        If cmdBoton(0).Enabled Then cmdBoton(0).Focus()
                    End If
                Case 3
                    If VLTipoDireccion(0, 0) = "" And cmbenvioec.Text = "S" Then
                        COBISMessageBox.Show(FMLoadResString(501942), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        VLPaso = True
                        txtCampo(3).Text = ""
                        If txtCampo(21).Enabled Then txtCampo(21).Focus()
                        Exit Sub
                    End If
                    If VLTipoDireccion(0, 0) = "D" Then
                        If VLNumero <> 0 Then
                            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                            grdPropietarios.Col = 1
                            PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, grdPropietarios.CtlText)
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1227")
                            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_direccion_cons", True, FMLoadResString(2279)) Then
                                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                                PMChequea(sqlconn)
                                FCatalogo.ShowPopup(Me)
                                txtCampo(3).Text = VGACatalogo.Codigo
                                lblDescripcion(6).Text = VGACatalogo.Descripcion
                                grdPropietarios.Col = 1
                                txtCampo(3).Tag = grdPropietarios.CtlText
                                VLPaso = True
                            Else
                                PMChequea(sqlconn)
                                txtCampo(3).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            If txtCampo(0).Enabled Then txtCampo(0).Focus()
                        End If
                    ElseIf VLTipoDireccion(0, 0) = "C" Then
                        If VLNumero <> 0 Then
                            PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
                            grdPropietarios.Col = 1
                            PMPasoValores(sqlconn, "@i_cli", 0, SQLINT4, grdPropietarios.CtlText)
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "92")
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_casilla", True, FMLoadResString(2617)) Then
                                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, True)
                                PMChequea(sqlconn)
                                VLPaso = True
                                FCatalogo.ShowPopup(Me)
                                txtCampo(3).Text = VGACatalogo.Codigo
                                lblDescripcion(6).Text = VGACatalogo.Descripcion
                                grdPropietarios.Col = 1
                                txtCampo(3).Tag = grdPropietarios.CtlText
                            Else
                                PMChequea(sqlconn)
                                txtCampo(3).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            If txtCampo(0).Enabled Then txtCampo(0).Focus()
                        End If
                    ElseIf VLTipoDireccion(0, 0) = "R" Then
                        If VLNumero <> 0 Then
                            VGOperacion = "sp_agencia"
                            PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "O")
                            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "34")
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_agencia", True, FMLoadResString(2618)) Then
                                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                                PMChequea(sqlconn)
                                VLPaso = True
                                FCatalogo.ShowPopup(Me)
                                txtCampo(3).Text = VGACatalogo.Codigo
                                lblDescripcion(6).Text = VGACatalogo.Descripcion
                                grdPropietarios.Col = 1
                                txtCampo(3).Tag = grdPropietarios.CtlText
                            Else
                                PMChequea(sqlconn)
                                txtCampo(3).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            If txtCampo(0).Enabled Then txtCampo(0).Focus()
                        End If
                    End If
                Case 4
                    txtCampo(4).Text = ""
                    FHelpOficial.ShowPopup(Me)
                    If VGBusqueda(0) <> Nothing Then
                        If VGBusqueda(0) <> "*" Then
                            txtCampo(4).Text = VGBusqueda(0)
                            lblDescripcion(7).Text = VGBusqueda(1)
                            VLPaso = True
                        Else
                            txtCampo(4).Text = ""
                            lblDescripcion(7).Text = ""
                        End If
                    End If
                    If txtCampo(4).Text <> "" Then
                        VLPaso = True
                    End If
                Case 5
                    VLPaso = True
                    PMCatalogo("A", "cc_tpromedio", txtCampo(5), lblDescripcion(8))
                Case 6
                    'txtCampo(6).Text = CStr(0)
                    VLPaso = True
                    PMCatalogo("A", "ah_ciclo", txtCampo(6), lblDescripcion(9))
                    If txtCampo(6).Text <> "" Then
                        If txtCampo(7).Enabled Then txtCampo(7).Focus()
                        VLPaso = True
                    Else
                        lblDescripcion(9).Text = ""
                    End If
                Case 7
                    If mskCuenta.ClipText.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(501337), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(7).Text = ""
                        lblDescripcion(10).Text = ""
                        If mskCuenta.Enabled Then
                            If mskCuenta.Enabled Then mskCuenta.Focus()
                        End If
                        Exit Sub
                    End If
                    If VLTitular <= 0 Then
                        COBISMessageBox.Show(FMLoadResString(501931), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(7).Text = ""
                        lblDescripcion(10).Text = ""
                        If txtCampo(0).Enabled Then txtCampo(0).Focus()
                        Exit Sub
                    Else
                        grdPropietarios.Row = VLTitular
                        grdPropietarios.Col = 3
                    End If
                    If txtCampo(8).Text.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(501933), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(7).Text = ""
                        lblDescripcion(10).Text = ""
                        Exit Sub
                    End If
                    VLPaso = True
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4101")
                    PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_cons_cta", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_cons_profinal", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_cuenta", 0, SQLCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_tipo_cta", 0, SQLCHAR, "AHO")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_categoria_profinal", True, FMLoadResString(2468)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(7).Text = VGACatalogo.Codigo
                        lblDescripcion(10).Text = VGACatalogo.Descripcion
                    Else
                        PMChequea(sqlconn)
                    End If
                    If txtCampo(7).Text <> "" And txtCampo(11).Enabled Then
                        If txtCampo(11).Enabled Then txtCampo(11).Focus()
                        VLPaso = True
                    End If
                Case 8
                    If VLTitular <= 0 Then
                        COBISMessageBox.Show(FMLoadResString(501096), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(8).Text = ""
                        lblDescripcion(11).Text = ""
                        If txtCampo(8).Enabled Then
                            If txtCampo(8).Enabled Then txtCampo(8).Focus()
                        End If
                        Exit Sub
                    Else
                        grdPropietarios.Row = VLTitular
                        grdPropietarios.Col = 3
                    End If
                    txtCampo(8).Text = ""
                    mskCuenta2.Mask = VGMascaraCtaAho
                    mskCuenta2.Text = ""
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "424")
                    PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "4")
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                    PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.CtlText)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_productoban", True, FMLoadResString(2533)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(8).Text = VGACatalogo.Codigo
                        mskCuenta2.Mask = VGMascaraCtaAho
                        mskCuenta2.Text = ""
                        lblDescripcion(11).Text = VGACatalogo.Descripcion
                        txtCampo(7).Text = ""
                        lblDescripcion(10).Text = ""
                    Else
                        PMChequea(sqlconn)
                    End If
                    If txtCampo(8).Text <> "" Then
                        If txtCampo(9).Enabled Then txtCampo(9).Focus()
                        VLPaso = True
                    End If
                    'Si Producto Bancario es Aporte Social Adicional Activa el campo Cta RElacionada
                    If txtCampo(8).Text <> "" Then
                        Dim VLPAR As Integer
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "PCAASA")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLVARCHAR, "F")
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(2344)) Then
                            PMMapeaVariable(sqlconn, VLPAR)
                            If Val(txtCampo(8).Text) = VLPAR Then
                                mskCuenta.Enabled = True
                            Else
                                mskCuenta2.Text = FMMascara("", VGMascaraCtaAho)
                                mskCuenta2.Enabled = False
                            End If
                            PMChequea(sqlconn)
                        Else
                            mskCuenta2.Text = FMMascara("", VGMascaraCtaAho)
                            mskCuenta2.Enabled = False
                            PMChequea(sqlconn)
                        End If
                    End If
                Case 9
                    'txtCampo(9).Text = ""
                    PMCatalogo("A", "ah_tipocta", txtCampo(9), lblDescripcion(12))
                    VLPaso = True
                    If txtCampo(9).Text <> "" And Mskvalor.Enabled Then
                        VLPaso = True
                    End If
                    If txtCampo(9).Text = "" Then
                        lblDescripcion(12).Text = ""
                    End If
                Case 10
                    VLPaso = True
                    PMCatalogo("A", "pe_capitalizacion", txtCampo(10), lblDescripcion(0))
                Case 13
                    If VLTipoDireccion(1, 0) = "" Then
                        COBISMessageBox.Show(FMLoadResString(501244), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        VLPaso = True
                        txtCampo(13).Text = ""
                        If txtCampo(21).Enabled Then txtCampo(21).Focus()
                        Exit Sub
                    End If
                    If VLTipoDireccion(1, 0) = "D" Then
                        If VLNumero <> 0 Then
                            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                            grdPropietarios.Col = 1
                            PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, grdPropietarios.CtlText)
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1227")
                            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_direccion_cons", True, FMLoadResString(2616)) Then
                                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                                PMChequea(sqlconn)
                                FCatalogo.ShowPopup(Me)
                                txtCampo(13).Text = VGACatalogo.Codigo
                                lblDescripcion(14).Text = VGACatalogo.Descripcion
                                grdPropietarios.Col = 1
                                txtCampo(13).Tag = grdPropietarios.CtlText
                                VLPaso = True
                            Else
                                PMChequea(sqlconn)
                                txtCampo(13).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            If txtCampo(0).Enabled Then txtCampo(0).Focus()
                        End If
                    ElseIf VLTipoDireccion(1, 0) = "C" Then
                        If VLNumero <> 0 Then
                            PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
                            grdPropietarios.Col = 1
                            PMPasoValores(sqlconn, "@i_cli", 0, SQLINT4, grdPropietarios.CtlText)
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "92")
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_casilla", True, FMLoadResString(2617)) Then
                                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, True)
                                PMChequea(sqlconn)
                                VLPaso = True
                                FCatalogo.ShowPopup(Me)
                                txtCampo(13).Text = VGACatalogo.Codigo
                                lblDescripcion(14).Text = VGACatalogo.Descripcion
                                grdPropietarios.Col = 1
                                txtCampo(13).Tag = grdPropietarios.CtlText
                            Else
                                PMChequea(sqlconn)
                                txtCampo(13).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            If txtCampo(0).Enabled Then txtCampo(0).Focus()
                        End If
                    ElseIf VLTipoDireccion(1, 0) = "R" Then
                        If VLNumero <> 0 Then
                            PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "O")
                            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "34")
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_agencia", True, FMLoadResString(2618)) Then
                                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                                PMChequea(sqlconn)
                                VLPaso = True
                                FCatalogo.ShowPopup(Me)
                                txtCampo(13).Text = VGACatalogo.Codigo
                                lblDescripcion(14).Text = VGACatalogo.Descripcion
                                grdPropietarios.Col = 1
                                txtCampo(13).Tag = grdPropietarios.CtlText
                            Else
                                PMChequea(sqlconn)
                                txtCampo(13).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            If txtCampo(0).Enabled Then txtCampo(0).Focus()
                        End If
                    End If
                Case 14
                    VLPaso = True
                    PMCatalogo("A", "ah_causa_canje", txtCampo(14), lblDescripcion(16))
                Case 18
                    PMCatalogo("A", "re_titularidad", txtCampo(18), lblDescripcion(20))
                    If txtCampo(18).Text = "" Then
                        lblDescripcion(20).Text = ""
                    End If
                    VLPaso = True
                Case 19
                    PMCatalogo("A", "ah_cla_cliente", txtCampo(19), lblDescripcion(13))
                    VLPaso = True
                    If txtCampo(19).Text <> "" Then
                        If VGCodPais = "PA" Then
                            If txtCampo(15).Visible And txtCampo(15).Enabled Then txtCampo(15).Focus()
                        End If
                    End If
                Case 21
                    VLPaso = True
                    PMCatalogo("A", "cl_direccion_ec", txtCampo(21), lblDescripcion(22))
                    If txtCampo(21).Text <> "" Then
                        n = IIf(optdir(0).Checked, 0, 1)
                        VLTipoDireccion(n, 0) = txtCampo(21).Text
                        VLTipoDireccion(n, 1) = lblDescripcion(22).Text
                        PLlblEtiqueta(txtCampo(21).Text)
                    Else
                        lblDescripcion(22).Text = ""
                    End If
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_21.KeyPress, _txtCampo_3.KeyPress, _txtCampo_13.KeyPress, _txtCampo_16.KeyPress, _txtCampo_15.KeyPress, _txtCampo_18.KeyPress, _txtCampo_19.KeyPress, _txtCampo_7.KeyPress, _txtCampo_14.KeyPress, _txtCampo_12.KeyPress, _txtCampo_11.KeyPress, _txtCampo_9.KeyPress, _txtCampo_8.KeyPress, _txtCampo_10.KeyPress, _txtCampo_6.KeyPress, _txtCampo_0.KeyPress, _txtCampo_1.KeyPress, _txtCampo_2.KeyPress, _txtCampo_4.KeyPress, _txtCampo_5.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 3, 6, 4, 8, 9, 11, 13, 14, 19
                KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
            Case 1, 5, 9, 10, 18
                KeyAscii = FMVAlidaTipoDato("A", KeyAscii)
            Case 2, 12
                KeyAscii = FMVAlidaTipoDato("B", KeyAscii)
            Case 15, 21
                KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
            Case 7, 15, 16
                KeyAscii = FMVAlidaTipoDato("U", KeyAscii)
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_21.Leave, _txtCampo_3.Leave, _txtCampo_13.Leave, _txtCampo_16.Leave, _txtCampo_15.Leave, _txtCampo_18.Leave, _txtCampo_19.Leave, _txtCampo_7.Leave, _txtCampo_14.Leave, _txtCampo_12.Leave, _txtCampo_11.Leave, _txtCampo_9.Leave, _txtCampo_8.Leave, _txtCampo_10.Leave, _txtCampo_6.Leave, _txtCampo_0.Leave, _txtCampo_1.Leave, _txtCampo_2.Leave, _txtCampo_4.Leave, _txtCampo_5.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim n As Integer = 0
        Dim VLLista As String = ""
        Dim VLMalaref As String = ""
        Dim VLBloqueado As String = ""
        Dim VLMensajeBlq As String = String.Empty
        Dim VLDesAlianza As String = ""
        Dim VLAlianza As String = ""
        Dim VTCliente As String = String.Empty
        Dim VTSubtipo As String = String.Empty
        Select Case Index
            Case 0
                If Not VLPaso Then
                    If txtCampo(0).Text <> "" Then
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_cliente", 0, SQLINT4, txtCampo(0).Text)
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1181")
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_desc_cliente", True, FMLoadResString(2239) & txtCampo(0).Text & "]") Then
                            Dim VTValores(15) As String
                            FMMapeaArreglo(sqlconn, VTValores)
                            PMMapeaVariable(sqlconn, VLAlianza)
                            PMMapeaVariable(sqlconn, VLDesAlianza)
                            PMChequea(sqlconn)
                            VTSubtipo = VTValores(3)
                            lblDescripcion(2).Text = VTValores(1)
                            lblDescripcion(3).Text = VTSubtipo
                            If VTSubtipo = "P" Then
                                VTCliente = VTValores(2)
                                lblDescripcion(4).Text = VTCliente
                            Else
                                lblDescripcion(4).Text = VTValores(2)
                            End If
                            Lblalianza.Text = VLAlianza
                            lbldesalianza.Text = VLDesAlianza
                            If txtCampo(1).Text = "" Then
                                If txtCampo(1).Enabled Then txtCampo(1).Focus()
                            Else
                                If cmdBoton(0).Enabled Then cmdBoton(0).Focus()
                            End If
                        Else
                            PMChequea(sqlconn)
                            txtCampo(0).Text = ""
                            lblDescripcion(2).Text = ""
                            lblDescripcion(4).Text = ""
                            lblDescripcion(3).Text = ""
                            If txtCampo(0).Enabled Then txtCampo(0).Focus()
                        End If
                    Else
                        lblDescripcion(2).Text = ""
                        lblDescripcion(4).Text = ""
                        lblDescripcion(3).Text = ""
                    End If
                End If
                If txtCampo(0).Text <> "" Then
                    VLMensajeBlq = ""
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "175")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "B")
                    PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, txtCampo(0).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_ente_bloqueado", True, FMLoadResString(2240)) Then
                        PMMapeaVariable(sqlconn, VLBloqueado)
                        PMMapeaVariable(sqlconn, VLMalaref)
                        PMMapeaVariable(sqlconn, VLLista)
                        PMMapeaVariable(sqlconn, VLMensajeBlq)
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        lblDescripcion(2).Text = ""
                        lblDescripcion(3).Text = ""
                        lblDescripcion(4).Text = ""
                        txtCampo(0).Text = ""
                        If txtCampo(0).Enabled Then txtCampo(0).Focus()
                    End If
                    If VLBloqueado = "S" And VLMalaref = "N" Then
                        COBISMessageBox.Show(FMLoadResString(2538), FMLoadResString(2539), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                        lblDescripcion(2).Text = ""
                        lblDescripcion(3).Text = ""
                        lblDescripcion(4).Text = ""
                        txtCampo(0).Text = ""
                        If txtCampo(0).Enabled Then txtCampo(0).Focus()
                        Exit Sub
                    End If
                    If VLMalaref = "S" Then
                        COBISMessageBox.Show(VLMensajeBlq, FMLoadResString(2243), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                        lblDescripcion(2).Text = ""
                        lblDescripcion(3).Text = ""
                        lblDescripcion(4).Text = ""
                        txtCampo(0).Text = ""
                        If txtCampo(0).Enabled Then txtCampo(0).Focus()
                        Exit Sub
                    End If
                    If VLMalaref = "N" And VLMensajeBlq <> "" Then
                        COBISMessageBox.Show(VLMensajeBlq, FMLoadResString(2243), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                    End If
                End If
            Case 1
                If Not VLPaso Then
                    If txtCampo(1).Text <> "" Then
                        PMCatalogo("V", "cl_rol", txtCampo(1), lblDescripcion(5))
                    Else
                        lblDescripcion(5).Text = ""
                    End If
                End If
            Case 3
                If Not VLPaso Then
                    If VLTipoDireccion(0, 0) = "" And cmbenvioec.Text = "S" Then
                        COBISMessageBox.Show(FMLoadResString(501942), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        VLPaso = True
                        txtCampo(3).Text = ""
                        If txtCampo(21).Enabled Then txtCampo(21).Focus()
                        Exit Sub
                    End If
                    If txtCampo(3).Text > 255 Then
                        COBISMessageBox.Show(FMLoadResString(502477), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(3).Text = ""
                        lblDescripcion(6).Text = ""
                        txtCampo(3).Tag = ""
                        If txtCampo(3).Enabled Then txtCampo(3).Focus()
                        Exit Sub
                    End If
                    If VLTipoDireccion(0, 0) = "D" Then
                        If VLNumero <> 0 Then
                            If txtCampo(3).Text <> "" Then
                                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                                grdPropietarios.Col = 1
                                PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, grdPropietarios.CtlText)
                                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                                PMPasoValores(sqlconn, "@i_direccion", 0, SQLINT2, txtCampo(3).Text)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1229")
                                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_direccion_cons", True, FMLoadResString(508986) & txtCampo(Index).Text & "]") Then
                                    PMMapeaObjeto(sqlconn, lblDescripcion(6))
                                    PMChequea(sqlconn)
                                    grdPropietarios.Col = 1
                                    txtCampo(3).Tag = grdPropietarios.CtlText
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(3).Text = ""
                                    lblDescripcion(6).Text = ""
                                    txtCampo(3).Tag = ""
                                    If txtCampo(3).Enabled Then txtCampo(3).Focus()
                                End If
                            Else
                                lblDescripcion(6).Text = ""
                                txtCampo(3).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(3).Tag = ""
                            If txtCampo(0).Enabled Then txtCampo(0).Focus()
                        End If
                    ElseIf VLTipoDireccion(0, 0) = "C" Then
                        If VLNumero <> 0 Then
                            If txtCampo(3).Text <> "" Then
                                PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "V")
                                grdPropietarios.Col = 1
                                PMPasoValores(sqlconn, "@i_cli", 0, SQLINT4, grdPropietarios.CtlText)
                                PMPasoValores(sqlconn, "@i_casi", 0, SQLINT2, txtCampo(3).Text)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "92")
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_casilla", True, FMLoadResString(508987) & txtCampo(Index).Text & "]") Then
                                    PMMapeaObjeto(sqlconn, lblDescripcion(6))
                                    PMChequea(sqlconn)
                                    grdPropietarios.Col = 1
                                    txtCampo(3).Tag = grdPropietarios.CtlText
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(3).Text = ""
                                    lblDescripcion(6).Text = ""
                                    txtCampo(3).Tag = ""
                                    If txtCampo(3).Enabled Then txtCampo(3).Focus()
                                End If
                            Else
                                lblDescripcion(6).Text = ""
                                txtCampo(3).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(3).Tag = ""
                            If txtCampo(0).Enabled Then txtCampo(0).Focus()
                        End If
                    ElseIf VLTipoDireccion(0, 0) = "R" Then
                        If VLNumero <> 0 Then
                            If txtCampo(3).Text <> "" Then
                                PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "H")
                                PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, txtCampo(3).Text)
                                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "34")
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_agencia", True, FMLoadResString(2618)) Then
                                    PMMapeaObjeto(sqlconn, lblDescripcion(6))
                                    PMChequea(sqlconn)
                                    grdPropietarios.Col = 1
                                    txtCampo(3).Tag = grdPropietarios.CtlText
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(3).Text = ""
                                    lblDescripcion(6).Text = ""
                                    txtCampo(3).Tag = ""
                                    If txtCampo(3).Enabled Then txtCampo(3).Focus()
                                End If
                            Else
                                lblDescripcion(6).Text = ""
                                txtCampo(3).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(3).Tag = ""
                            If txtCampo(0).Enabled Then txtCampo(0).Focus()
                        End If
                    End If
                End If
            Case 4
                If Not VLPaso Then
                    If txtCampo(4).Text <> "" Then
                        If CDbl(txtCampo(4).Text) >= 32000 Then
                            COBISMessageBox.Show(FMLoadResString(2621), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            If txtCampo(4).Enabled Then txtCampo(4).Focus()
                            Exit Sub
                        End If
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "15153")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_oficial", 0, SQLINT2, txtCampo(4).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_tr_cons_oficiales", True, FMLoadResString(2622)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(7))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(4).Text = ""
                            lblDescripcion(7).Text = ""
                            If txtCampo(4).Enabled Then txtCampo(4).Focus()
                        End If
                    Else
                        lblDescripcion(7).Text = ""
                    End If
                End If
            Case 5
                If Not VLPaso Then
                    If txtCampo(5).Text <> "" Then
                        PMCatalogo("V", "cc_tpromedio", txtCampo(5), lblDescripcion(8))
                    Else
                        lblDescripcion(8).Text = ""
                    End If
                End If
            Case 6
                If Not VLPaso Then
                    If txtCampo(6).Text <> "" Then
                        PMCatalogo("V", "ah_ciclo", txtCampo(6), lblDescripcion(9))
                    Else
                        lblDescripcion(9).Text = ""
                    End If
                End If
            Case 7
                If Not VLPaso Then
                    If txtCampo(7).Text <> "" Then
                        If mskCuenta.ClipText.Trim() = "" Then
                            COBISMessageBox.Show(FMLoadResString(501337), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(7).Text = ""
                            lblDescripcion(10).Text = ""
                            If mskCuenta.Enabled Then
                                If mskCuenta.Enabled Then mskCuenta.Focus()
                            End If
                            Exit Sub
                        End If
                        If txtCampo(8).Text.Trim() = "" Then
                            COBISMessageBox.Show(FMLoadResString(501933), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(7).Text = ""
                            lblDescripcion(10).Text = ""
                            Exit Sub
                        End If
                        If VLTitular <= 0 Then
                            COBISMessageBox.Show(FMLoadResString(501931), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(7).Text = ""
                            lblDescripcion(10).Text = ""
                            If txtCampo(0).Enabled Then txtCampo(0).Focus()
                            Exit Sub
                        Else
                            grdPropietarios.Row = VLTitular
                            grdPropietarios.Col = 3
                        End If
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4101")
                        PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_cons_profinal", 0, SQLCHAR, "S")
                        PMPasoValores(sqlconn, "@i_pro_bancario", 0, SQLINT2, txtCampo(8).Text)
                        PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.CtlText)
                        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGMoneda)
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                        PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(7).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_categoria_profinal", True, FMLoadResString(2468)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(10))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(7).Text = ""
                            lblDescripcion(10).Text = ""
                            If txtCampo(7).Enabled Then txtCampo(7).Focus()
                        End If
                        VLPaso = True
                    Else
                        lblDescripcion(10).Text = ""
                    End If
                End If
            Case 8
                If Not VLPaso Then
                    If txtCampo(8).Text <> "" Then
                        If VLTitular <= 0 Then
                            COBISMessageBox.Show(FMLoadResString(501096), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(8).Text = ""
                            mskCuenta2.Mask = VGMascaraCtaAho
                            mskCuenta2.Text = ""
                            lblDescripcion(11).Text = ""
                            If txtCampo(8).Enabled Then
                                txtCampo(8).Focus()
                            End If
                            Exit Sub
                        Else
                            grdPropietarios.Row = VLTitular
                            grdPropietarios.Col = 3
                        End If
                        txtCampo(7).Text = ""
                        lblDescripcion(10).Text = ""
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "424")
                        PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_prodfin", 0, SQLINT2, txtCampo(8).Text)
                        PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "4")
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                        PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.CtlText)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_productoban", True, FMLoadResString(2466)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(11))
                            PMChequea(sqlconn)
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4088")
                            PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "H")
                            PMPasoValores(sqlconn, "@i_cons_profinal", 0, SQLCHAR, "S")
                            PMPasoValores(sqlconn, "@i_pro_bancario", 0, SQLINT2, txtCampo(8).Text)
                            PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, VLTipoEnteTitular)
                            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "4")
                            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                            PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, VGMoneda)
                            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_capitalizacion_profinal", True, FMLoadResString(2619)) Then
                                PMMapeaObjetoAB(sqlconn, txtCampo(10), lblDescripcion(0))
                                PMChequea(sqlconn)
                            Else
                                PMChequea(sqlconn)
                            End If
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4087")
                            PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "H")
                            PMPasoValores(sqlconn, "@i_cons_profinal", 0, SQLCHAR, "S")
                            PMPasoValores(sqlconn, "@i_pro_bancario", 0, SQLINT2, txtCampo(8).Text)
                            PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, VLTipoEnteTitular)
                            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "4")
                            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                            PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, VGMoneda)
                            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_ciclo_profinal", True, FMLoadResString(2620)) Then
                                PMMapeaObjetoAB(sqlconn, txtCampo(6), lblDescripcion(9))
                                PMChequea(sqlconn)
                            Else
                                PMChequea(sqlconn)
                            End If
                            VLPaso = True
                        Else
                            PMChequea(sqlconn)
                            txtCampo(8).Text = ""
                            mskCuenta2.Mask = VGMascaraCtaAho
                            mskCuenta2.Text = ""
                            lblDescripcion(11).Text = ""
                            If txtCampo(8).Enabled Then
                                txtCampo(8).Focus()
                            End If
                        End If
                    Else
                        lblDescripcion(11).Text = ""
                        txtCampo(7).Text = ""
                        lblDescripcion(10).Text = ""
                    End If
                    'Si Producto Bancario es Aporte Social Adicional Activa el campo Cta RElacionada
                    Dim VLPAR As Integer
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                    PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "PCAASA")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLVARCHAR, "F")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(99835)) Then
                        PMMapeaVariable(sqlconn, VLPAR)
                        If Val(txtCampo(8).Text) = VLPAR Then
                            mskCuenta2.Enabled = True
                        Else
                            mskCuenta2.Text = FMMascara("", VGMascaraCtaAho)
                            mskCuenta2.Enabled = False
                        End If
                        PMChequea(sqlconn)
                    Else
                        mskCuenta2.Text = FMMascara("", VGMascaraCtaAho)
                        mskCuenta2.Enabled = False
                        PMChequea(sqlconn)
                    End If
                End If
            Case 9
                If Not VLPaso Then
                    If txtCampo(9).Text <> "" Then
                        PMCatalogo("V", "ah_tipocta", txtCampo(9), lblDescripcion(12))
                    Else
                        lblDescripcion(12).Text = ""
                    End If
                End If
            Case 10
                If Not VLPaso Then
                    If txtCampo(10).Text <> "" Then
                        PMCatalogo("V", "pe_capitalizacion", txtCampo(10), lblDescripcion(0))
                    Else
                        lblDescripcion(0).Text = ""
                    End If
                End If
            Case 13
                If Not VLPaso Then
                    If VLTipoDireccion(1, 0) = "" Then
                        COBISMessageBox.Show(FMLoadResString(501244), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        VLPaso = True
                        txtCampo(13).Text = ""
                        If txtCampo(21).Enabled Then txtCampo(21).Focus()
                        Exit Sub
                    End If
                    If VLTipoDireccion(1, 0) = "D" Then
                        If VLNumero <> 0 Then
                            If txtCampo(13).Text <> "" Then
                                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                                grdPropietarios.Col = 1
                                PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, grdPropietarios.CtlText)
                                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                                PMPasoValores(sqlconn, "@i_direccion", 0, SQLINT2, txtCampo(13).Text)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1229")
                                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_direccion_cons", True, FMLoadResString(508986) & txtCampo(Index).Text & "]") Then
                                    PMMapeaObjeto(sqlconn, lblDescripcion(14))
                                    PMChequea(sqlconn)
                                    grdPropietarios.Col = 1
                                    txtCampo(13).Tag = grdPropietarios.CtlText
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(13).Text = ""
                                    lblDescripcion(14).Text = ""
                                    txtCampo(13).Tag = ""
                                    If txtCampo(13).Enabled Then txtCampo(13).Focus()
                                End If
                            Else
                                lblDescripcion(14).Text = ""
                                txtCampo(13).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(13).Tag = ""
                            If txtCampo(0).Enabled Then txtCampo(0).Focus()
                        End If
                    ElseIf VLTipoDireccion(0, 0) = "C" Then
                        If VLNumero <> 0 Then
                            If txtCampo(13).Text <> "" Then
                                PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "V")
                                grdPropietarios.Col = 1
                                PMPasoValores(sqlconn, "@i_cli", 0, SQLINT4, grdPropietarios.CtlText)
                                PMPasoValores(sqlconn, "@i_casi", 0, SQLINT2, txtCampo(13).Text)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "92")
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_casilla", True, FMLoadResString(508987) & txtCampo(Index).Text & "]") Then
                                    PMMapeaObjeto(sqlconn, lblDescripcion(14))
                                    PMChequea(sqlconn)
                                    grdPropietarios.Col = 1
                                    txtCampo(13).Tag = grdPropietarios.CtlText
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(13).Text = ""
                                    lblDescripcion(14).Text = ""
                                    txtCampo(13).Tag = ""
                                    If txtCampo(13).Enabled Then txtCampo(13).Focus()
                                End If
                            Else
                                lblDescripcion(14).Text = ""
                                txtCampo(13).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(13).Tag = ""
                            If txtCampo(0).Enabled Then txtCampo(0).Focus()
                        End If
                    ElseIf VLTipoDireccion(1, 0) = "R" Then
                        If VLNumero <> 0 Then
                            If txtCampo(13).Text <> "" Then
                                PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "H")
                                PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, txtCampo(13).Text)
                                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "34")
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_agencia", True, FMLoadResString(2618)) Then
                                    PMMapeaObjeto(sqlconn, lblDescripcion(14))
                                    PMChequea(sqlconn)
                                    grdPropietarios.Col = 1
                                    txtCampo(13).Tag = grdPropietarios.CtlText
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(13).Text = ""
                                    lblDescripcion(14).Text = ""
                                    txtCampo(13).Tag = ""
                                    If txtCampo(13).Enabled Then txtCampo(13).Focus()
                                End If
                            Else
                                lblDescripcion(14).Text = ""
                                txtCampo(13).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(13).Tag = ""
                            If txtCampo(0).Enabled Then txtCampo(0).Focus()
                        End If
                    End If
                End If
            Case 14
                If Not VLPaso Then
                    If txtCampo(14).Text <> "" Then
                        PMCatalogo("V", "ah_causa_canje", txtCampo(14), lblDescripcion(16))
                    Else
                        lblDescripcion(16).Text = ""
                    End If
                End If
            Case 18
                If Not VLPaso Then
                    If txtCampo(18).Text <> "" Then
                        PMCatalogo("V", "re_titularidad", txtCampo(18), lblDescripcion(20))
                    Else
                        lblDescripcion(20).Text = ""
                    End If
                End If
            Case 19
                If Not VLPaso Then
                    If txtCampo(19).Text <> "" Then
                        PMCatalogo("V", "ah_cla_cliente", txtCampo(19), lblDescripcion(13))
                    Else
                        lblDescripcion(13).Text = ""
                    End If
                End If
            Case 21
                If Not VLPaso Then
                    If txtCampo(21).Text <> "" Then
                        PMCatalogo("V", "cl_direccion_ec", txtCampo(21), lblDescripcion(22))
                        n = IIf(optdir(0).Checked, 0, 1)
                        VLTipoDireccion(n, 0) = txtCampo(21).Text
                        VLTipoDireccion(n, 1) = lblDescripcion(22).Text
                        PLlblEtiqueta(txtCampo(21).Text)
                    Else
                        lblDescripcion(22).Text = ""
                    End If

                End If
        End Select
    End Sub

    Private Function FLVerificarMenor(ByRef parfila As Integer) As Boolean
        Dim result As Boolean = False
        Dim VTCadena As String = ""
        Dim vti As Integer = 0
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "350")
        For j As Integer = 1 To grdPropietarios.Rows - 1
            If parfila <> j Then
                grdPropietarios.Row = j
                grdPropietarios.Col = 4
                VTCadena = ""
                vti += 1
                grdPropietarios.Col = 1
                VTCadena = VTCadena & (grdPropietarios.CtlText) & "@"
                grdPropietarios.Col = 5
                VTCadena = VTCadena & (grdPropietarios.CtlText) & "@"
                grdPropietarios.Col = 4
                VTCadena = VTCadena & (grdPropietarios.CtlText) & "@"
                PMPasoValores(sqlconn, "@i_param" & vti, 0, SQLCHAR, VTCadena)
            End If
        Next j
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_valida_menor", True, FMLoadResString(2469)) Then
            PMChequea(sqlconn)
            vti = FMRetStatus(sqlconn)
            If vti <> 0 Then
                result = False
            Else
                result = True
            End If
        Else
            PMChequea(sqlconn)
            result = False
        End If
        Return result
    End Function

    Private Function FLArmadoNomCta() As Boolean
        Dim VTcontador As Integer = 0
        Dim VTString As String = String.Empty
        Dim VTTemp1 As String = ""
        Dim VTNombreCta As New StringBuilder
        Dim VLApendNombre As String = ""
        Dim VLDifNomCta As Integer
        Dim VLRetorno As Integer = True
        Try
            VTTemp1 = txtCampo(2).Text
            VTNombreCta = New StringBuilder("")
            VTString = ""
            'If txtCampo(18).Text.ToUpper() <> "M" And txtCampo(18).Text.ToUpper() <> "S" Then
            '    txtCampo(2).Text = VTTemp1
            '    Exit Sub
            'End If
            ReDim VTMatrizprop(grdPropietarios.Cols - 1, 0)
            VLContadorprop = -1
            ReDim Roles(50, 1)
            XT = 0
            PLProcesarPropietarios("T", 1)
            PLProcesarPropietarios("C", 1)
            PLProcesarPropietarios("F", 1)
            PLProcesarPropietarios("OTROS", 0)
            Select Case txtCampo(18).Text.ToUpper()
                Case "M"
                    VTString = " (Y) "
                Case "S"
                    VTString = " (O) "
            End Select
            VTcontador = 0
            For j As Integer = 0 To VTMatrizprop.GetUpperBound(1)
                For i As Integer = 0 To VTMatrizprop.GetUpperBound(0) - 1
                    If i = 2 Then
                        If VTMatrizprop(i, j).ToUpper() = "P" Then
                            'Si el largo del nombre de la cuenta es mayor a la constante que guarda el tamaño del campo, sale del ciclo
                            If VTNombreCta.Length >= CLLargoNomCta Then
                                Exit For
                            End If
                            If VTMatrizprop(4, j).ToUpper() = "T" Or VTMatrizprop(4, j).ToUpper() = "C" Then
                                VTcontador += 1
                                If VTMatrizprop(3, j).ToUpper() = "" Then
                                    txtCampo(2).Text = VTTemp1
                                    COBISMessageBox.Show(FMLoadResString(501139), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                    VLRetorno = False
                                    Return VLRetorno
                                End If
                                If VTcontador = 1 Then
                                    VTNombreCta = New StringBuilder(VTMatrizprop(3, j).ToUpper())
                                Else
                                    VLApendNombre = VTString & VTMatrizprop(3, j).ToUpper()
                                    'Si el largo del nombre de la cuenta + el largo de lo que se va a concatenar es mayor a la constante del tamaño del campo, trunca el largo de lo que se concatena
                                    If VTNombreCta.Length + VLApendNombre.Length > CLLargoNomCta Then
                                        VLDifNomCta = CLLargoNomCta - VTNombreCta.Length
                                        VLApendNombre = VLApendNombre.Substring(1, VLDifNomCta)
                                    End If
                                    VTNombreCta.Append(VLApendNombre)
                                End If
                            End If
                        Else
                            txtCampo(2).Text = VTTemp1
                            Return VLRetorno
                        End If
                    End If
                Next i
            Next j
            If VTcontador >= 1 Then
                txtCampo(2).Text = VTNombreCta.ToString()
                VLRetorno = True
                Return VLRetorno
            End If
        Catch
            txtCampo(2).Text = VTTemp1
            Return VLRetorno
        End Try
        Return VLRetorno
    End Function

    Private Sub PLlblEtiqueta(ByRef Etiqueta As String)
        If optdir(0).Checked Then
            lblDescripcion(6).Visible = True
            txtCampo(3).Text = ""
            lblDescripcion(6).Text = ""
            Select Case Etiqueta
                Case "D"
                    lblEtiqueta(12).Text = FMLoadResString(501172) '"Código de dirección:"
                Case "C"
                    lblEtiqueta(12).Text = FMLoadResString(502405) '"Código de casilla:"
                Case "R"
                    lblEtiqueta(12).Text = FMLoadResString(502406) '"Código de sucursal:"
                Case "S"
                    lblEtiqueta(12).Text = FMLoadResString(502407) '"No. de casillero:"
            End Select
        ElseIf optdir(1).Checked Then
            lblDescripcion(14).Visible = True
            txtCampo(13).Text = ""
            lblDescripcion(14).Text = ""
            Select Case Etiqueta
                Case "D"
                    lblEtiqueta(19).Text = FMLoadResString(501172) '"Código de dirección:"
                Case "C"
                    lblEtiqueta(19).Text = FMLoadResString(502405) '"Código de casilla:"
                Case "R"
                    lblEtiqueta(19).Text = FMLoadResString(502406) '"Código de sucursal:"
                Case "S"
                    lblEtiqueta(19).Text = FMLoadResString(502407) '"No. de casillero:"
            End Select
        End If
    End Sub

    Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_21.MouseDown, _txtCampo_3.MouseDown, _txtCampo_13.MouseDown, _txtCampo_16.MouseDown, _txtCampo_15.MouseDown, _txtCampo_18.MouseDown, _txtCampo_19.MouseDown, _txtCampo_7.MouseDown, _txtCampo_14.MouseDown, _txtCampo_12.MouseDown, _txtCampo_11.MouseDown, _txtCampo_9.MouseDown, _txtCampo_8.MouseDown, _txtCampo_10.MouseDown, _txtCampo_6.MouseDown, _txtCampo_0.MouseDown, _txtCampo_1.MouseDown, _txtCampo_2.MouseDown, _txtCampo_4.MouseDown, _txtCampo_5.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1
                My.Computer.Clipboard.Clear()
        End Select
    End Sub
    Private Sub PLTSEstado()
        TSBAnadir.Visible = _cmdBoton_0.Visible
        TSBAnadir.Enabled = _cmdBoton_0.Enabled
        TSBEliminar.Visible = _cmdBoton_1.Visible
        TSBEliminar.Enabled = _cmdBoton_1.Enabled
        TSBPerfil.Visible = _cmdBoton_7.Visible
        TSBPerfil.Enabled = _cmdBoton_7.Enabled
        TSBContrato.Visible = _cmdBoton_6.Visible
        TSBContrato.Enabled = _cmdBoton_6.Enabled
        TSBImprimir.Visible = _cmdBoton_5.Visible
        TSBImprimir.Enabled = _cmdBoton_5.Enabled
        TSBTransmitir.Visible = _cmdBoton_2.Visible
        TSBTransmitir.Enabled = _cmdBoton_2.Enabled
        TSBLimpiar.Visible = _cmdBoton_3.Visible
        TSBLimpiar.Enabled = _cmdBoton_3.Enabled
        TSBSalir.Visible = _cmdBoton_4.Visible
        TSBSalir.Enabled = _cmdBoton_4.Enabled
    End Sub

    Private Sub TSBAnadir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBAnadir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBPerfil_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBPerfil.Click
        If _cmdBoton_7.Enabled Then cmdBoton_Click(_cmdBoton_7, e)
    End Sub

    Private Sub TSBContrato_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBContrato.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub

    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub PLContrato()
        Dim VTTipoPersona As String = ""
        If txtCampo(19).Text = "1" Then
            VTTipoPersona = "P"
        ElseIf txtCampo(19).Text = "2" Then
            VTTipoPersona = "C"
        End If

        If String.IsNullOrEmpty(VTTipoPersona) Then
            grdPropietarios.Row = 1
            grdPropietarios.Col = 3
            VTTipoPersona = grdPropietarios.CtlText
        End If

        VLHabilitaClientesEsp = "S"

        If VTTipoPersona = "C" Then
            VLHabilitaClientesEsp = "N"
        End If

        'PLCallHelpContratos()

        'If Not VLHelpContrOK Then
        '    Exit Sub
        'End If

        'Dim f As FDataContClass
        'f = New FDataContClass

        'f.cctProCobis.Table = "cl_producto"
        'f.cctProCobis.TitleCatalog = "Catalogo de Producto Cobis"
        'f.cctProCobis.Id = 4

        'f.txtProBancario.Text = txtCampo(8).Text
        'f.txtProBancario_Leave(sender, e)

        'f.txtTipoPersona.Text = VTTipoPersona
        'f.txtTipoPersona_Leave(sender, e)

        ''If VTTipoPersona = "P" Then
        'f.txtTitularidad.Text = txtCampo(18).Text
        'f.txtTitularidad_Leave(sender, e)
        ''End If

        'If VLHabilitaClientesEsp = "S" Then
        '    f.chkEspecial.Checked = True
        'Else
        '    f.chkEspecial.Checked = False
        'End If

        'f.txtTipoPersona.Enabled = False
        'f.txtTitularidad.Enabled = False
        'f.chkEspecial.Enabled = False

        'f.cctProCobis.Enabled = False
        'f.txtProBancario.Enabled = False
        ''f.txtProBancario_Leave()
        'f.VLEspecial_ = VLHabilitaClientesEsp

        'f.ShowPopup(Me)
        'iEscogidos = f.VGEscogidos

        'If iEscogidos > 0 Then
        '    VGMatriz = f.VGMatriz
        '    datoContrato()

        Dim respuesta As DialogResult
        respuesta = COBISMessageBox.Show(FMLoadResString(501194), FMLoadResString(2615), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question)
        If respuesta = System.Windows.Forms.DialogResult.No Then
            Exit Sub
        Else
            datoContrato()
            PLImprimirContrato2()
        End If
        'End If


        'If VLImprSolicContr Then
        '    PLImprSolicitudContr(VTTipoPersona)
        'End If


    End Sub


    Public Sub PLImprimirContrato2()
        Try
            Dim Reporte1 As String = ""
            Dim archivo As String = ""
            Dim archivo_logo As String = ""
            Dim VTContratos(10) As String
            Dim VTR5 As Integer = 0
            Dim VTMatriz(10, 20) As String
            'Dim VTMatriz(10, 20) As String
            Dim VTTipoPersona As String = ""
            Dim VTEspecial As String = ""


            archivo = VGPath & "APERTURA.MDB"
            archivo_logo = VGPath & "logo.mdb"

            ''VGMatriz
            ''If FMTransmitirRPC(SqlConn, ServerName, "cob_cuentas", "sp_contrato_producto", False, "") Then

            'VTR1 = iEscogidos 'FMMapeaMatriz(SqlConn, VTMatriz)
            ''PMChequea(SqlConn)

            'For i = 1 To VTR1
            '    VTContratos(i) = VGPath & VGMatriz(1, i) 'asigno en un arreglo los contratos a imprimir para este producto
            '    Reporte1 = VTContratos(i)
            '    rptReporte.Reset()
            '    rptReporte.Refresh()
            '    rptReporte.ReportFileName = Reporte1
            '    rptReporte.CopiesToPrinter = 1
            '    rptReporte.set_DataFiles(0, archivo)
            '    rptReporte.Destination = COBISCorp.Framework.UI.Components.DestinationConstants.crptToWindow
            '    rptReporte.Action = 1
            'Next i

            ''End If

            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2946")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "P")
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
            PMPasoValores(sqlconn, "@i_prod_banc", 0, SQLINT2, txtCampo(8).Text)
            PMPasoValores(sqlconn, "@i_tipo_persona", 0, SQLCHAR, VTTipoPersona)
            PMPasoValores(sqlconn, "@i_titularidad", 0, SQLCHAR, txtCampo(18).Text)
            PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
            If Not String.IsNullOrEmpty(VTEspecial) Then
                PMPasoValores(sqlconn, "@i_es_especial", 0, SQLCHAR, VTEspecial)
            End If


            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_contrato_producto", False, "") Then
                VTR5 = FMMapeaMatriz(sqlconn, VTMatriz)
                PMChequea(sqlconn)

                If VTR5 = 0 Then
                    COBISMessageBox.Show(FMLoadResString(5263), FMLoadResString(500018))
                End If

                For i As Integer = 1 To VTR5
                    'en un arreglo los contratos a imprimir para este producto
                    VTContratos(i) = VGPath & VTMatriz(3, i)

                    VTContratos(i) = VGPath & VTMatriz(3, i)

                    If Not File.Exists(VTContratos(i)) Then
                        COBISMessageBox.Show(VTMatriz(3, i) & " - " & FMLoadResString(5262), FMLoadResString(500018))
                    Else

                        Reporte1 = VTContratos(i)
                        rptReporte.Reset()
                        rptReporte.DiscardSavedData = True
                        rptReporte.Refresh()
                        rptReporte.ReportFileName = Reporte1
                        rptReporte.CopiesToPrinter = 1
                        rptReporte.set_DataFiles(0, archivo)
                        rptReporte.DataFiles(0) = archivo
                        rptReporte.DataFiles(1) = archivo
                        rptReporte.DataFiles(2) = archivo
                        rptReporte.DataFiles(3) = archivo
                        rptReporte.DataFiles(4) = archivo_logo
                        rptReporte.Destination = COBISCorp.Framework.UI.Components.DestinationConstants.crptToWindow

                        rptReporte.Formulas(0) = "usuario=""" & VGLogin & " - " & VGFecha & " """
                        rptReporte.Formulas(1) = "fecha=""" & VGFecha & """"
                        rptReporte.Action = 1
                    End If

                Next i

            End If


        Catch
            COBISMessageBox.Show(FMLoadResString(501195) & Conversion.ErrorToString(), My.Application.Info.ProductName)
            Exit Sub
        End Try

    End Sub

    Private Sub datoContrato()
        Dim archivo As String = ""
        Dim archivo_logo As String = ""
        Dim VTR5 As Integer = 0

        Dim BaseDatos As DAO.Database
        Dim VTTelefonoCli(,) As String
        Dim Tabla1, tabla2, tabla4, tabla5 As DAO.Recordset
        Dim VTArray() As String
        Dim VTFechaAux As DateTime

        archivo = VGPath & "APERTURA.MDB"
        archivo_logo = VGPath & "logo.mdb"
        BaseDatos = DAO_DBEngine_definst.OpenDatabase(archivo)
        Tabla1 = BaseDatos.OpenRecordset("cuenta")
        tabla2 = BaseDatos.OpenRecordset("propietarios")
        tabla4 = BaseDatos.OpenRecordset("referencias")
        tabla5 = BaseDatos.OpenRecordset("datosadic")
        BaseDatos.Execute("delete from cuenta")
        BaseDatos.Execute("delete from propietarios")
        BaseDatos.Execute("delete from referencias")
        BaseDatos.Execute("delete from datosadic")
        Tabla1.AddNew()
        Tabla1.Fields("oficina").Value = VGOficina
        Tabla1.Fields("fecha").Value = DateTime.Today.ToString("MM-dd-yyyy")
        Tabla1.Fields("deposito").Value = StringsHelper.Format(Mskvalor.Text, "#,##0.00")
        Tabla1.Fields("numero").Value = StringsHelper.Format(mskCuenta.Text, VGMascaraCtaCte)
        'Tabla1.Fields("moneda").Value = Strings.Left(FPrincipal.cmbMoneda.Text, 30)
        Tabla1.Fields("nombre").Value = Strings.Left(txtCampo(2).Text, 64)
        Tabla1.Fields("producto").Value = Strings.Left(lblDescripcion(11).Text, 30)
        Tabla1.Fields("origen").Value = Strings.Left(lblDescripcion(12).Text, 30)
        Tabla1.Fields("oficial").Value = Strings.Left(lblDescripcion(7).Text, 30)
        Tabla1.Fields("promedio").Value = Strings.Left(lblDescripcion(8).Text, 30)
        Tabla1.Fields("categoria").Value = Strings.Left(lblDescripcion(10).Text, 30)
        Tabla1.Fields("ciclo").Value = Strings.Left(lblDescripcion(9).Text, 30)
        Tabla1.Fields("fecha_corte").Value = Strings.Left(lblDescripcion(1).Text, 30)
        If cmbenvioec.Text = "S" Then
            If VLTipoDireccion(0, 0) = "D" Then
                Tabla1.Fields("direccion").Value = Strings.Left(lblDescripcion(15).Text, 30)
            Else
                Tabla1.Fields("agencia_ec").Value = Strings.Left(lblDescripcion(6).Text, 30)
            End If
        End If
        Tabla1.Fields("tipo").Value = "Ahorro"
        Tabla1.Fields("firma").Value = Strings.Left(lblDescripcion(20).Text, 30)
        If VGCodPais = "PA" Then Tabla1.Fields("patente").Value = txtCampo(12).Text
        If VGCodPais = "PA" Then Tabla1.Fields("fideicomiso").Value = txtCampo(15).Text
        ReDim VTMatrizprop(grdPropietarios.Cols - 1, 0)
        VLContadorprop = -1
        ReDim Roles(50, 1)
        PLProcesarPropietarios("T", 1)
        PLProcesarPropietarios("C", 1)
        PLProcesarPropietarios("F", 1)
        PLProcesarPropietarios("OTROS", 0)
        For i As Integer = 1 To grdPropietarios.Rows - 1
            For j As Integer = 1 To grdPropietarios.Cols - 1
                grdPropietarios.Row = i
                grdPropietarios.Col = j
                grdPropietarios.CtlText = VTMatrizprop(j - 1, i - 1)
            Next j
        Next i
        grdPropietarios.Row = 1
        grdPropietarios.Col = 1
        Dim VTclientepro As String = ""
        VTclientepro = grdPropietarios.CtlText
        Tabla1.Fields("solicitu").Value = VTclientepro
        Tabla1.Fields("secuencial").Value = 1
        If VLTipoDireccion(0, 0) = "C" And txtCampo(3).Text <> "" Then
            VTArray = lblDescripcion(6).Text.Trim().Split("|"c)
            If VTArray.GetLowerBound(0) >= 0 Then
                For i As Integer = VTArray.GetLowerBound(0) To VTArray.GetUpperBound(0)
                    Select Case i
                        Case 0
                            Tabla1.Fields("di_codpostal").Value = VTArray(0).Trim()
                        Case 1
                            Tabla1.Fields("di_ciudad").Value = VTArray(2).Trim()
                        Case 2
                            Tabla1.Fields("di_zona").Value = VTArray(1).Trim()
                        Case 3
                            Tabla1.Fields("di_pais").Value = VTArray(3).Trim()
                    End Select
                Next i
            End If
        End If
        Dim VLSecuencial As Integer = 0
        VLSecuencial = 1
        Dim VTTitular As String = String.Empty
        Dim VLCondicion As String = String.Empty
        Dim VTR1 As Integer = 0
        Dim VTR3 As Integer = 0
        Dim VTR4 As Integer = 0

        Dim tiempoemp As Integer = 0
        Dim VTSec As Integer = 0
        Dim Index As Integer = 0
        Dim VTTelef As String = String.Empty
        Dim VTCelular As String = String.Empty
        Dim VTFax As String = String.Empty
        Dim VTTelex As String = String.Empty
        Dim VTR2 As Integer = 0
        For k As Integer = 1 To grdPropietarios.Rows - 1
            grdPropietarios.Col = 1
            grdPropietarios.Row = k
            VLCodTitular = CInt(grdPropietarios.CtlText)
            grdPropietarios.Col = 5
            VTTitular = grdPropietarios.CtlText
            grdPropietarios.Col = 6
            VLCondicion = grdPropietarios.CtlText
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "R")
            PMPasoValores(sqlconn, "@i_cliente", 0, SQLINT4, CStr(VLCodTitular))
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2543")
            PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_desc_cliente_cc", True, " Ok... Consulta del cliente " & "[" & txtCampo(0).Text & "]") Then
                Dim VTDatosCli(40) As String
                VTR1 = FMMapeaArreglo(sqlconn, VTDatosCli)
                Dim VTRefCom(10, 100) As String
                VTR3 = FMMapeaMatriz(sqlconn, VTRefCom)
                Dim VTRefBan(4) As String
                FMMapeaArreglo(sqlconn, VTRefBan)
                Dim VTRefPerso(10, 100) As String
                VTR5 = FMMapeaMatriz(sqlconn, VTRefPerso)
                PMChequea(sqlconn)
                tabla2.AddNew()
                tabla2.Fields("cliente").Value = VLCodTitular
                tabla2.Fields("secuencial").Value = VLSecuencial
                tabla2.Fields("numero").Value = mskCuenta.Text
                tabla2.Fields("firma").Value = Strings.Left(lblDescripcion(20).Text, 30)
                tabla2.Fields("condicion").Value = VLCondicion
                tabla2.Fields("titular").Value = VTTitular
                VLSecuencial += 1
                If VTDatosCli(7) = "P" Then
                    tabla2.Fields("cedula").Value = Strings.Left(VTDatosCli(1), 30)
                    tabla2.Fields("nombre").Value = VTDatosCli(37).Trim()
                    If VTDatosCli(2) = "" Then
                        tabla2.Fields("primer_nombre").Value = " "
                    Else
                        tabla2.Fields("primer_nombre").Value = Strings.Left(VTDatosCli(2), 30)
                    End If
                    If VTDatosCli(3) = "" Then
                        tabla2.Fields("segundo_nombre").Value = " "
                    Else
                        tabla2.Fields("segundo_nombre").Value = Strings.Left(VTDatosCli(3), 30)
                    End If
                    If VTDatosCli(4) = "" Then
                        tabla2.Fields("primer_apellido").Value = " "
                    Else
                        tabla2.Fields("primer_apellido").Value = Strings.Left(VTDatosCli(4), 30)
                    End If
                    If VTDatosCli(5) = "" Then
                        tabla2.Fields("segundo_apellido").Value = " "
                    Else
                        tabla2.Fields("segundo_apellido").Value = Strings.Left(VTDatosCli(5), 30)
                    End If
                    tabla2.Fields("apellido_casada").Value = Strings.Left(VTDatosCli(6), 30)
                    tabla2.Fields("tipo_cliente").Value = Strings.Left(VTDatosCli(7), 30)
                    tabla2.Fields("pais").Value = Strings.Left(VTDatosCli(9), 30)
                    tabla2.Fields("sexo").Value = Strings.Left(VTDatosCli(10), 30)
                    tabla2.Fields("estado_civil").Value = Strings.Left(VTDatosCli(11), 30)
                    tabla2.Fields("nit").Value = Strings.Left(VTDatosCli(12), 30)
                    If VTDatosCli(13) <> "" Then
                        tabla2.Fields("fecha_nacimiento").Value = Strings.Left(VTDatosCli(13), 30)
                    End If
                    tabla2.Fields("num_hijos").Value = Conversion.Val(VTDatosCli(14))
                    tabla2.Fields("num_cargas").Value = Conversion.Val(VTDatosCli(15))
                    tabla2.Fields("desc_ciudad_nac").Value = Strings.Left(VTDatosCli(16), 30)
                    tabla2.Fields("desc_lugar_doc").Value = Strings.Left(VTDatosCli(17), 30)
                    tabla2.Fields("desc_dep_doc").Value = Strings.Left(VTDatosCli(18), 30)
                    tabla2.Fields("desc_profesion").Value = Strings.Left(VTDatosCli(19), 30)
                    tabla2.Fields("emp_cargo").Value = VTDatosCli(20)
                    tabla2.Fields("empresa").Value = Strings.Left(VTDatosCli(21), 64)
                    tabla2.Fields("razon_social").Value = Strings.Left(VTDatosCli(22), 30)
                    tabla2.Fields("emp_telefono").Value = Strings.Left(VTDatosCli(23), 30)
                    tabla2.Fields("desc_dep_nac").Value = VTDatosCli(24)
                    tabla2.Fields("desc_pais_nac").Value = VTDatosCli(25)
                    If VTDatosCli(26) <> "" And VTDatosCli(27) <> "" Then
                        tabla2.Fields("emp_tiempo").Value = DateAndTime.DateDiff("yyyy", CDate(VTDatosCli(26)), CDate(VTDatosCli(27)), FirstDayOfWeek.Sunday, FirstWeekOfYear.Jan1)
                    ElseIf VTDatosCli(26) <> "" And VTDatosCli(27) = "" Then
                        tabla2.Fields("emp_tiempo").Value = DateAndTime.DateDiff("yyyy", CDate(VTDatosCli(26)), DateTime.Now, FirstDayOfWeek.Sunday, FirstWeekOfYear.Jan1)
                    End If
                    Dim TempDate As Date = DateTime.Now
                    tabla2.Fields("rl_fecha_ing").Value = IIf(DateTime.TryParse(VTDatosCli(26), TempDate), TempDate.ToString("dd/MM/yyyy"), VTDatosCli(26))
                    tabla2.Fields("nacionalidad").Value = VTDatosCli(28)
                    tabla2.Fields("tipo_vivienda").Value = VTDatosCli(29)
                    tabla2.Fields("tipo_ced").Value = VTDatosCli(30)
                    tabla2.Fields("emp_ingresos").Value = VTDatosCli(31)
                    tabla2.Fields("emp_act_economica").Value = VTDatosCli(32)
                    tabla2.Fields("emp_desc_actividad").Value = Strings.Mid(VTDatosCli(33), 1, 50)
                    tabla2.Fields("emp_direccion").Value = VTDatosCli(34)
                    tabla2.Fields("email").Value = VTDatosCli(35)
                    tabla2.Fields("digito").Value = VTDatosCli(36)
                    'reporte = VGPath & "\APCTACTE1.RPT"
                Else
                    tabla2.Fields("pais").Value = Strings.Left(VTDatosCli(5), 30)
                    tabla2.Fields("razon_social").Value = VTDatosCli(3)
                    tabla2.Fields("nombre").Value = VTDatosCli(1)
                    tabla2.Fields("emp_act_economica").Value = VTDatosCli(2)
                    tabla2.Fields("rep_legal").Value = VTDatosCli(4)
                    tabla2.Fields("rl_telefono").Value = VTDatosCli(8)
                    tabla2.Fields("rl_fax").Value = VTDatosCli(9)
                    tabla2.Fields("rl_email").Value = VTDatosCli(11)
                    tabla2.Fields("emp_cargo").Value = VTDatosCli(10)
                    tabla2.Fields("rl_fecha_ing").Value = VTDatosCli(12)
                    tabla2.Fields("cedula").Value = VTDatosCli(21)
                    tabla2.Fields("tipo_ced").Value = VTDatosCli(22)
                    tabla2.Fields("digito").Value = VTDatosCli(23)
                    tabla2.Fields("num_patenteC").Value = VTDatosCli(14)
                    tabla2.Fields("num_RegM").Value = VTDatosCli(15)
                    tabla2.Fields("num_folioRegM").Value = VTDatosCli(16)
                    tabla2.Fields("num_libroRegM").Value = VTDatosCli(17)
                    If VTDatosCli(18) <> "" Then
                        tiempoemp = VTDatosCli(18).Length
                        If tiempoemp > 2 Then
                            VTDatosCli(18) = Strings.Mid(VTDatosCli(18), 1, 2)
                            tabla2.Fields("emp_tiempo").Value = VTDatosCli(18)
                        End If
                    End If
                    tabla2.Fields("fecha_constitucion").Value = VTDatosCli(19)
                    tabla2.Fields("objeto_social").Value = VTDatosCli(20)
                    tabla2.Fields("nit").Value = VTDatosCli(21)
                    'reporte = VGPath & "\APCTACTE1.RPT"
                End If
                tabla2.Fields("refcom1").Value = Strings.Left(VTRefCom(0, 1), 64)
                tabla2.Fields("di_refcom1").Value = Strings.Left(VTRefCom(1, 1), 64)
                tabla2.Fields("tel_refcom1").Value = Strings.Left(VTRefCom(2, 1), 16)
                tabla2.Fields("refcom2").Value = Strings.Left(VTRefCom(0, 2), 64)
                tabla2.Fields("di_refcom2").Value = Strings.Left(VTRefCom(1, 2), 64)
                tabla2.Fields("tel_refcom2").Value = Strings.Left(VTRefCom(2, 2), 16)
                tabla2.Fields("refcom3").Value = Strings.Left(VTRefCom(0, 3), 64)
                tabla2.Fields("di_refcom3").Value = Strings.Left(VTRefCom(1, 3), 64)
                tabla2.Fields("tel_refcom3").Value = Strings.Left(VTRefCom(2, 3), 16)
                tabla2.Fields("refban1").Value = Strings.Left(VTRefBan(1), 64)
                tabla2.Fields("refban2").Value = Strings.Left(VTRefBan(2), 64)
                tabla2.Fields("refban3").Value = Strings.Left(VTRefBan(3), 64)
                VTSec = 1
                For n As Integer = 1 To VTR3
                    If Strings.Left(VTRefCom(0, n), 50) <> "" Then
                        tabla4.AddNew()
                        tabla4.Fields("numero").Value = mskCuenta.Text 'lblDescripcion(0).Text
                        tabla4.Fields("entidad").Value = Strings.Left(VTRefCom(0, n), 50)
                        tabla4.Fields("anios").Value = VTRefCom(1, n)
                        tabla4.Fields("contacto").Value = Strings.Left(VTRefCom(2, n), 50)
                        tabla4.Fields("tipo_cta").Value = Strings.Left(VTRefCom(3, n), 30)
                        tabla4.Fields("telefono").Value = Strings.Left(VTRefCom(4, n), 38)
                        tabla4.Fields("secuencial").Value = VTSec
                        tabla4.Fields("sec_beneficiario").Value = tabla2.Fields("secuencial").Value
                        VTSec += 1
                        tabla4.Fields("filial").Value = Conversion.Val(VGLOGO)
                        tabla4.Update()
                    End If
                Next n
                For n As Integer = 1 To VTR5
                    tabla4.AddNew()
                    tabla4.Fields("numero").Value = mskCuenta.Text 'lblDescripcion(0).Text
                    tabla4.Fields("entidad").Value = Strings.Left(VTRefPerso(0, n), 50)
                    tabla4.Fields("anios").Value = VTRefPerso(1, n)
                    tabla4.Fields("contacto").Value = Strings.Left(VTRefPerso(2, n), 50)
                    tabla4.Fields("tipo_cta").Value = Strings.Left(VTRefPerso(3, n), 30)
                    tabla4.Fields("telefono").Value = Strings.Left(VTRefPerso(4, n), 38)
                    tabla4.Fields("secuencial").Value = VTSec
                    tabla4.Fields("sec_beneficiario").Value = tabla2.Fields("secuencial").Value
                    VTSec += 1
                    tabla4.Fields("filial").Value = Conversion.Val(VGLOGO)
                    tabla4.Update()
                Next n
                If VTR3 = 0 And VTR5 = 0 Then
                    tabla4.AddNew()
                    tabla4.Fields("numero").Value = mskCuenta.Text
                    tabla4.Fields("sec_beneficiario").Value = tabla2.Fields("secuencial").Value
                    tabla4.Fields("secuencial").Value = VTSec
                    tabla4.Update()
                End If
            Else
                Tabla1.Close()
                tabla2.Close()
                tabla4.Close()
                BaseDatos.Close()
                PMChequea(sqlconn)
                Exit Sub
            End If
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, CStr(VLCodTitular))
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1227")
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_direccion_cons", True, FMLoadResString(2600) & " [" & txtCampo(Index).Text & "]") Then
                Dim VTDireccionCli(25, 10) As String
                VTR1 = FMMapeaMatriz(sqlconn, VTDireccionCli)
                PMChequea(sqlconn)
                For i As Integer = 1 To VTR1
                    If VTDireccionCli(11, i) = "S" Then
                        tabla2.Fields("direccion_ente").Value = Strings.Left((VTDireccionCli(15, i).Trim() & " " & VTDireccionCli(16, i).Trim() & " " & VTDireccionCli(17, i).Trim() & " " & VTDireccionCli(18, i).Trim()).Trim(), 255)
                        tabla2.Fields("di_ciudad").Value = Strings.Left(VTDireccionCli(5, i), 30)
                        tabla2.Fields("di_provincia").Value = Strings.Left(VTDireccionCli(3, i), 30)
                        tabla2.Fields("di_codpostal").Value = Strings.Left(VTDireccionCli(8, i), 30)
                        VTTelef = ""
                        VTCelular = ""
                        VTFax = ""
                        VTTelex = ""
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, CStr(VLCodTitular))
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1345")
                        PMPasoValores(sqlconn, "@i_direccion", 0, SQLINT4, VTDireccionCli(0, i))
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_direccion_cons", True, FMLoadResString(2600) & " [" & txtCampo(Index).Text & "]") Then
                            ReDim VTTelefonoCli(4, 10)
                            VTR2 = FMMapeaMatriz(sqlconn, VTTelefonoCli)
                            PMChequea(sqlconn)
                            For j As Integer = 1 To VTR2
                                If VTTelefonoCli(2, j) = "RE" Then
                                    VTTelef = VTTelefonoCli(1, j)
                                End If
                                If VTTelefonoCli(2, j) = "CE" Then
                                    VTCelular = VTTelefonoCli(1, j)
                                End If
                                If VTTelefonoCli(2, j) = "FA" Then
                                    VTFax = VTTelefonoCli(1, j)
                                End If
                                If VTTelefonoCli(2, j) = "OT" Then
                                    VTTelex = VTTelefonoCli(1, j)
                                End If
                            Next j
                        Else
                            PMChequea(sqlconn)
                        End If
                        tabla2.Fields("telefono").Value = VTTelef
                        tabla2.Fields("num_fax").Value = VTFax
                        tabla2.Fields("celular").Value = VTCelular
                        tabla2.Fields("telex").Value = VTTelex
                    End If
                    VTTelef = ""
                    VTFax = ""
                    If VLTipoDireccion(0, 0) = "C" And Conversion.Val(VTDireccionCli(0, i)) = Conversion.Val(txtCampo(3).Text) And txtCampo(3).Text <> "" Then
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, CStr(VLCodTitular))
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1345")
                        PMPasoValores(sqlconn, "@i_direccion", 0, SQLINT4, txtCampo(3).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_direccion_cons", True, FMLoadResString(2600) & " [" & txtCampo(3).Text & "]") Then
                            ReDim VTTelefonoCli(4, 10)
                            VTR2 = FMMapeaMatriz(sqlconn, VTTelefonoCli)
                            PMChequea(sqlconn)
                            For j As Integer = 1 To VTR2
                                If VTTelefonoCli(2, j) = "RE" Then
                                    VTTelef = VTTelefonoCli(1, j)
                                Else
                                    VTFax = VTTelefonoCli(1, j)
                                End If
                            Next j
                        Else
                            PMChequea(sqlconn)
                        End If
                        Tabla1.Fields("di_telefono").Value = Strings.Left(VTTelef, 16)
                        Tabla1.Fields("di_fax").Value = Strings.Left(VTFax, 16)
                    End If
                    If VTDireccionCli(9, i) = "E-MAIL" Then
                        tabla2.Fields("email").Value = VTDireccionCli(1, i)
                    End If
                Next i
            Else
                PMChequea(sqlconn)
            End If
            tabla2.Fields("filial").Value = Conversion.Val(VGLOGO)
            tabla2.Update()
        Next k
        REM If VGCodPais = "PA" Then
        VLCuenta0 = mskCuenta.ClipText
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "348")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, VLCuenta0)
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, CInt(VGMoneda))
        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
        Dim VTArreglo(30) As String
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_datos_adic_aho", True, FMLoadResString(2601) & " [" & mskCuenta.Text & "]") Then
            VTR1 = FMMapeaArreglo(sqlconn, VTArreglo)
            PMChequea(sqlconn)
            If VTR1 > 0 Then
                tabla5.AddNew()
                tabla5.Fields("numero").Value = mskCuenta.Text
                tabla5.Fields("dep_inicial").Value = VTArreglo(2)
                tabla5.Fields("forma_dep_inicial").Value = VTArreglo(3)
                tabla5.Fields("proposito_cuenta").Value = VTArreglo(4)
                tabla5.Fields("origen_fondos").Value = VTArreglo(5)
                tabla5.Fields("prod_cobis1").Value = VTArreglo(6)
                tabla5.Fields("prod_cobis2").Value = VTArreglo(7)
                tabla5.Fields("monto_ext").Value = VTArreglo(8)
                tabla5.Fields("trx_ext").Value = Conversion.Val(VTArreglo(9))
                tabla5.Fields("frecuencia_ext").Value = VTArreglo(10)
                tabla5.Fields("monto_efec").Value = VTArreglo(11)
                tabla5.Fields("trx_efec").Value = Conversion.Val(VTArreglo(12))
                tabla5.Fields("frecuencia_efec").Value = VTArreglo(13)
                tabla5.Fields("monto_refec").Value = VTArreglo(14)
                tabla5.Fields("trx_refec").Value = Conversion.Val(VTArreglo(15))
                tabla5.Fields("frecuencia_refec").Value = VTArreglo(16)
                tabla5.Fields("monto_giro").Value = VTArreglo(17)
                tabla5.Fields("trx_giro").Value = Conversion.Val(VTArreglo(18))
                tabla5.Fields("frecuencia_giro").Value = VTArreglo(19)
                tabla5.Fields("monto_gerencia").Value = VTArreglo(20)
                tabla5.Fields("trx_gerencia").Value = Conversion.Val(VTArreglo(21))
                tabla5.Fields("frecuencia_gerencia").Value = VTArreglo(22)
                tabla5.Fields("monto_transfer").Value = VTArreglo(23)
                tabla5.Fields("trx_transfer").Value = Conversion.Val(VTArreglo(24))
                tabla5.Fields("frecuencia_transfer").Value = VTArreglo(25)
                tabla5.Fields("monto_recib").Value = VTArreglo(26)
                tabla5.Fields("trx_recib").Value = Conversion.Val(VTArreglo(27))
                tabla5.Fields("frecuencia_recib").Value = VTArreglo(28)
                tabla5.Fields("filial").Value = Conversion.Val(VGLOGO)
                tabla5.Fields("aporte_social").Value = VTArreglo(29)

                Dim VTEntero As Long
                Dim VTFraccion As Decimal
                Dim VTValor As Decimal
                Dim VTPartedecimal As Integer
                Dim VTValorEnLetras As String

                VTValorEnLetras = ""
                If IsNumeric(VTArreglo(29)) Then
                    VTValor = CDbl(VTArreglo(29))
                    VTEntero = Fix(VTValor)
                    VTFraccion = VTValor - VTEntero
                    VTPartedecimal = VTFraccion * 100
                    VTValorEnLetras = UCase(Num2Text(VTEntero)) & " CON " & IIf(VTPartedecimal < 10, "0", "") & CStr(VTPartedecimal) & "/100"
                End If
                tabla5.Fields("valorletra").Value = VTValorEnLetras

                tabla5.Update()
            End If
        Else
            PMChequea(sqlconn)
        End If
        REM End If
        Tabla1.Fields("filial").Value = Conversion.Val(VGLOGO)

        REM ===================
        VLCuenta0 = mskCuenta.ClipText
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "538")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, VLCuenta0)
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, CInt(VGMoneda))
        Dim VTArreglo2(130) As String
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_cons_datos_cuenta", True, FMLoadResString(2601) & " [" & mskCuenta.Text & "]") Then
            VTR1 = FMMapeaArreglo(sqlconn, VTArreglo2)
            PMChequea(sqlconn)
            If VTR1 > 0 Then
                Tabla1.Fields("ah_cuenta").Value = VTArreglo2(1)
                Tabla1.Fields("ah_cta_banco").Value = VTArreglo2(2)
                Tabla1.Fields("ah_estado").Value = VTArreglo2(3)
                Tabla1.Fields("ah_control").Value = VTArreglo2(4)
                Tabla1.Fields("ah_filial").Value = VTArreglo2(5)
                Tabla1.Fields("ah_producto").Value = VTArreglo2(7)
                Tabla1.Fields("ah_tipo").Value = VTArreglo2(8)
                Tabla1.Fields("ah_moneda").Value = VTArreglo2(9)
                VTFechaAux = DateSerial(CInt(Mid(VTArreglo2(10), 7, 4)), CInt(Mid(VTArreglo2(10), 1, 2)), CInt(Mid(VTArreglo2(10), 4, 2)))
                Tabla1.Fields("ah_fecha_aper").Value = VTFechaAux
                Tabla1.Fields("ah_oficial").Value = VTArreglo2(11)
                Tabla1.Fields("ah_cliente").Value = VTArreglo2(12)
                Tabla1.Fields("ah_ced_ruc").Value = VTArreglo2(13)
                Tabla1.Fields("ah_nombre").Value = VTArreglo2(14)
                Tabla1.Fields("ah_categoria").Value = VTArreglo2(15)
                Tabla1.Fields("ah_tipo_promedio").Value = VTArreglo2(16)
                Tabla1.Fields("ah_capitalizacion").Value = VTArreglo2(17)
                Tabla1.Fields("ah_ciclo").Value = VTArreglo2(18)
                Tabla1.Fields("ah_suspensos").Value = VTArreglo2(19)
                Tabla1.Fields("ah_bloqueos").Value = VTArreglo2(20)
                Tabla1.Fields("ah_condiciones").Value = VTArreglo2(21)
                Tabla1.Fields("ah_monto_bloq").Value = VTArreglo2(22)
                Tabla1.Fields("ah_num_blqmonto").Value = VTArreglo2(23)
                Tabla1.Fields("ah_cred_24").Value = VTArreglo2(24)
                Tabla1.Fields("ah_cred_rem").Value = VTArreglo2(25)
                Tabla1.Fields("ah_tipo_def").Value = VTArreglo2(26)
                Tabla1.Fields("ah_default").Value = VTArreglo2(27)
                Tabla1.Fields("ah_rol_ente").Value = VTArreglo2(28)
                Tabla1.Fields("ah_disponible").Value = VTArreglo2(29)
                Tabla1.Fields("ah_12h").Value = VTArreglo2(30)
                Tabla1.Fields("ah_12h_dif").Value = VTArreglo2(31)

                Tabla1.Fields("ah_24h").Value = VTArreglo2(32)
                Tabla1.Fields("ah_48h").Value = VTArreglo2(33)
                Tabla1.Fields("ah_remesas").Value = VTArreglo2(34)
                Tabla1.Fields("ah_rem_hoy").Value = VTArreglo2(35)
                Tabla1.Fields("ah_interes").Value = VTArreglo2(36)
                Tabla1.Fields("ah_interes_ganado").Value = VTArreglo2(37)
                Tabla1.Fields("ah_saldo_libreta").Value = VTArreglo2(38)
                Tabla1.Fields("ah_saldo_interes").Value = VTArreglo2(39)
                Tabla1.Fields("ah_saldo_anterior").Value = VTArreglo2(40)
                Tabla1.Fields("ah_saldo_ult_corte").Value = VTArreglo2(41)
                Tabla1.Fields("ah_saldo_ayer").Value = VTArreglo2(42)
                Tabla1.Fields("ah_creditos").Value = VTArreglo2(43)
                Tabla1.Fields("ah_debitos").Value = VTArreglo2(44)
                Tabla1.Fields("ah_creditos_hoy").Value = VTArreglo2(45)
                Tabla1.Fields("ah_debitos_hoy").Value = VTArreglo2(46)
                VTFechaAux = DateSerial(CInt(Mid(VTArreglo2(47), 7, 4)), CInt(Mid(VTArreglo2(47), 1, 2)), CInt(Mid(VTArreglo2(47), 4, 2)))
                Tabla1.Fields("ah_fecha_ult_mov").Value = VTFechaAux
                VTFechaAux = DateSerial(CInt(Mid(VTArreglo2(48), 7, 4)), CInt(Mid(VTArreglo2(48), 1, 2)), CInt(Mid(VTArreglo2(48), 4, 2)))
                Tabla1.Fields("ah_fecha_ult_mov_int").Value = VTFechaAux
                VTFechaAux = DateSerial(CInt(Mid(VTArreglo2(49), 7, 4)), CInt(Mid(VTArreglo2(49), 1, 2)), CInt(Mid(VTArreglo2(49), 4, 2)))
                Tabla1.Fields("ah_fecha_ult_upd").Value = VTFechaAux
                VTFechaAux = DateSerial(CInt(Mid(VTArreglo2(50), 7, 4)), CInt(Mid(VTArreglo2(50), 1, 2)), CInt(Mid(VTArreglo2(50), 4, 2)))
                Tabla1.Fields("ah_fecha_prx_corte").Value = VTFechaAux
                VTFechaAux = DateSerial(CInt(Mid(VTArreglo2(51), 7, 4)), CInt(Mid(VTArreglo2(51), 1, 2)), CInt(Mid(VTArreglo2(51), 4, 2)))
                Tabla1.Fields("ah_fecha_ult_corte").Value = VTFechaAux
                VTFechaAux = DateSerial(CInt(Mid(VTArreglo2(52), 7, 4)), CInt(Mid(VTArreglo2(52), 1, 2)), CInt(Mid(VTArreglo2(52), 4, 2)))
                Tabla1.Fields("ah_fecha_ult_capi").Value = VTFechaAux
                VTFechaAux = DateSerial(CInt(Mid(VTArreglo2(53), 7, 4)), CInt(Mid(VTArreglo2(53), 1, 2)), CInt(Mid(VTArreglo2(53), 4, 2)))
                Tabla1.Fields("ah_fecha_prx_capita").Value = VTFechaAux
                Tabla1.Fields("ah_linea").Value = VTArreglo2(54)
                Tabla1.Fields("ah_ult_linea").Value = VTArreglo2(55)
                Tabla1.Fields("ah_cliente_ec").Value = VTArreglo2(56)
                Tabla1.Fields("ah_direccion_ec").Value = VTArreglo2(57)
                Tabla1.Fields("ah_descripcion_ec").Value = VTArreglo2(58)
                Tabla1.Fields("ah_tipo_dir").Value = VTArreglo2(59)
                Tabla1.Fields("ah_agen_ec").Value = VTArreglo2(60)
                Tabla1.Fields("ah_parroquia").Value = VTArreglo2(61)

                Tabla1.Fields("ah_zona").Value = VTArreglo2(62)
                Tabla1.Fields("ah_prom_disponible").Value = VTArreglo2(63)
                Tabla1.Fields("ah_promedio1").Value = VTArreglo2(64)
                Tabla1.Fields("ah_promedio2").Value = VTArreglo2(65)
                Tabla1.Fields("ah_promedio3").Value = VTArreglo2(66)
                Tabla1.Fields("ah_promedio4").Value = VTArreglo2(67)
                Tabla1.Fields("ah_promedio5").Value = VTArreglo2(68)
                Tabla1.Fields("ah_promedio6").Value = VTArreglo2(69)
                Tabla1.Fields("ah_personalizada").Value = VTArreglo2(70)
                Tabla1.Fields("ah_contador_trx").Value = VTArreglo2(71)
                Tabla1.Fields("ah_cta_funcionario").Value = VTArreglo2(72)
                Tabla1.Fields("ah_tipocta").Value = VTArreglo2(73)
                Tabla1.Fields("ah_prod_banc").Value = VTArreglo2(74)
                Tabla1.Fields("ah_origen").Value = VTArreglo2(75)
                Tabla1.Fields("ah_numlib").Value = VTArreglo2(76)
                Tabla1.Fields("ah_contador_firma").Value = VTArreglo2(78)
                Tabla1.Fields("ah_telefono").Value = VTArreglo2(79)
                Tabla1.Fields("ah_int_hoy").Value = VTArreglo2(80)
                Tabla1.Fields("ah_tasa_hoy").Value = VTArreglo2(81)
                Tabla1.Fields("ah_min_dispmes").Value = VTArreglo2(82)
                VTFechaAux = DateSerial(CInt(Mid(VTArreglo2(83), 7, 4)), CInt(Mid(VTArreglo2(83), 1, 2)), CInt(Mid(VTArreglo2(83), 4, 2)))
                Tabla1.Fields("ah_fecha_ult_ret").Value = VTFechaAux
                Tabla1.Fields("ah_cliente1").Value = VTArreglo2(84)
                Tabla1.Fields("ah_nombre1").Value = VTArreglo2(85)
                Tabla1.Fields("ah_cedruc1").Value = VTArreglo2(86)
                Tabla1.Fields("ah_sector").Value = VTArreglo2(87)
                Tabla1.Fields("ah_monto_imp").Value = VTArreglo2(88)
                Tabla1.Fields("ah_monto_consumos").Value = VTArreglo2(89)
                Tabla1.Fields("ah_ctitularidad").Value = VTArreglo2(90)
                Tabla1.Fields("ah_promotor").Value = VTArreglo2(91)
                Tabla1.Fields("ah_int_mes").Value = VTArreglo2(92)

                Tabla1.Fields("ah_tipocta_super").Value = VTArreglo2(93)
                Tabla1.Fields("ah_direccion_dv").Value = VTArreglo2(94)
                Tabla1.Fields("ah_descripcion_dv").Value = VTArreglo2(85)
                Tabla1.Fields("ah_tipodir_dv").Value = VTArreglo2(96)
                Tabla1.Fields("ah_parroquia_dv").Value = VTArreglo2(97)
                Tabla1.Fields("ah_zona_dv").Value = VTArreglo2(98)
                Tabla1.Fields("ah_agen_dv").Value = VTArreglo2(99)
                Tabla1.Fields("ah_cliente_dv").Value = VTArreglo2(100)
                Tabla1.Fields("ah_traslado").Value = VTArreglo2(101)
                Tabla1.Fields("ah_aplica_tasacorp").Value = VTArreglo2(102)
                Tabla1.Fields("ah_monto_emb").Value = VTArreglo2(103)
                Tabla1.Fields("ah_monto_ult_capi").Value = VTArreglo2(104)
                Tabla1.Fields("ah_saldo_mantval").Value = VTArreglo2(105)
                Tabla1.Fields("ah_cuota").Value = VTArreglo2(106)
                Tabla1.Fields("ah_creditos2").Value = VTArreglo2(107)
                Tabla1.Fields("ah_creditos3").Value = VTArreglo2(108)
                Tabla1.Fields("ah_creditos4").Value = VTArreglo2(109)
                Tabla1.Fields("ah_creditos5").Value = VTArreglo2(110)
                Tabla1.Fields("ah_creditos6").Value = VTArreglo2(111)
                Tabla1.Fields("ah_debitos2").Value = VTArreglo2(112)
                Tabla1.Fields("ah_debitos3").Value = VTArreglo2(113)
                Tabla1.Fields("ah_debitos4").Value = VTArreglo2(114)
                Tabla1.Fields("ah_debitos5").Value = VTArreglo2(115)
                Tabla1.Fields("ah_debitos6").Value = VTArreglo2(116)
                Tabla1.Fields("ah_tasa_ayer").Value = VTArreglo2(117)
                Tabla1.Fields("ah_estado_cuenta").Value = VTArreglo2(118)
                Tabla1.Fields("ah_permite_sldcero").Value = VTArreglo2(119)
                Tabla1.Fields("ah_rem_ayer").Value = VTArreglo2(120)
                Tabla1.Fields("ah_numsol").Value = VTArreglo2(121)
                If VTArreglo2(124) <> "" Then Tabla1.Fields("ah_nxmil").Value = VTArreglo2(124)

                If VTArreglo2(125) <> "" Then Tabla1.Fields("ah_clase_clte").Value = VTArreglo2(125)
                If VTArreglo2(126) <> "" Then Tabla1.Fields("ah_deb_mes_ant").Value = Val(VTArreglo2(126))
                If VTArreglo2(127) <> "" Then Tabla1.Fields("ah_cred_mes_ant").Value = Val(VTArreglo2(127))
                If VTArreglo2(128) <> "" Then Tabla1.Fields("ah_num_deb_mes").Value = Val(VTArreglo2(128))
                If VTArreglo2(129) <> "" Then Tabla1.Fields("ah_num_cred_mes").Value = Val(VTArreglo2(129))
                If VTArreglo2(130) <> "" Then Tabla1.Fields("ah_num_con_mes").Value = Val(VTArreglo2(130))
                If VTArreglo2(131) <> "" Then Tabla1.Fields("ah_num_deb_mes_ant").Value = Val(VTArreglo2(131))
                If VTArreglo2(132) <> "" Then Tabla1.Fields("ah_num_cred_mes_ant").Value = Val(VTArreglo2(132))
                If VTArreglo2(133) <> "" Then Tabla1.Fields("ah_num_con_mes_ant").Value = Val(VTArreglo2(133))
                If VTArreglo2(134) <> "" Then
                    VTFechaAux = DateSerial(CInt(Mid(VTArreglo2(134), 7, 4)), CInt(Mid(VTArreglo2(134), 1, 2)), CInt(Mid(VTArreglo2(134), 4, 2)))
                    Tabla1.Fields("ah_fecha_ult_proceso").Value = VTFechaAux
                End If
                If VTArreglo2(135) <> "" Then Tabla1.Fields("cod_ciudad_oficina").Value = Val(VTArreglo2(135))
                If VTArreglo2(136) <> "" Then Tabla1.Fields("ciudad_oficina").Value = VTArreglo2(136)
            End If
        Else
            PMChequea(sqlconn)
        End If

        'Consultar y guardar datos del banco
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "640")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_ah_datos_bco", True, FMLoadResString(2601) & " [" & mskCuenta.Text & "]") Then
            VTR1 = FMMapeaArreglo(sqlconn, VTArreglo2)
            PMChequea(sqlconn)
            If VTR1 > 0 Then
                Tabla1.Fields("nombre_corto_bco").Value = VTArreglo2(1)
                Tabla1.Fields("nombre_banco").Value = VTArreglo2(2)
                Tabla1.Fields("direccion_banco").Value = VTArreglo2(3)
                Tabla1.Fields("tfno1_banco").Value = VTArreglo2(4)
                Tabla1.Fields("tfno2_banco").Value = VTArreglo2(5)
                Tabla1.Fields("mail1_banco").Value = VTArreglo2(6)
                Tabla1.Fields("mail2_banco").Value = VTArreglo2(7)
            End If
        Else
            PMChequea(sqlconn)
        End If
        REM ===================

        Tabla1.Update()
        Tabla1.Close()
        tabla2.Close()
        tabla4.Close()
        tabla5.Close()
        BaseDatos.Close()
    End Sub
    Public Function Num2Text(ByVal value As Double) As String
        Select Case value
            Case 0 : Num2Text = "CERO"
            Case 1 : Num2Text = "UN"
            Case 2 : Num2Text = "DOS"
            Case 3 : Num2Text = "TRES"
            Case 4 : Num2Text = "CUATRO"
            Case 5 : Num2Text = "CINCO"
            Case 6 : Num2Text = "SEIS"
            Case 7 : Num2Text = "SIETE"
            Case 8 : Num2Text = "OCHO"
            Case 9 : Num2Text = "NUEVE"
            Case 10 : Num2Text = "DIEZ"
            Case 11 : Num2Text = "ONCE"
            Case 12 : Num2Text = "DOCE"
            Case 13 : Num2Text = "TRECE"
            Case 14 : Num2Text = "CATORCE"
            Case 15 : Num2Text = "QUINCE"
            Case Is < 20 : Num2Text = "DIECI" & Num2Text(value - 10)
            Case 20 : Num2Text = "VEINTE"
            Case Is < 30 : Num2Text = "VEINTI" & Num2Text(value - 20)
            Case 30 : Num2Text = "TREINTA"
            Case 40 : Num2Text = "CUARENTA"
            Case 50 : Num2Text = "CINCUENTA"
            Case 60 : Num2Text = "SESENTA"
            Case 70 : Num2Text = "SETENTA"
            Case 80 : Num2Text = "OCHENTA"
            Case 90 : Num2Text = "NOVENTA"
            Case Is < 100 : Num2Text = Num2Text(Int(value \ 10) * 10) & " Y " & Num2Text(value Mod 10)
            Case 100 : Num2Text = "CIEN"
            Case Is < 200 : Num2Text = "CIENTO " & Num2Text(value - 100)
            Case 200, 300, 400, 600, 800 : Num2Text = Num2Text(Int(value \ 100)) & "CIENTOS"
            Case 500 : Num2Text = "QUINIENTOS"
            Case 700 : Num2Text = "SETECIENTOS"
            Case 900 : Num2Text = "NOVECIENTOS"
            Case Is < 1000 : Num2Text = Num2Text(Int(value \ 100) * 100) & " " & Num2Text(value Mod 100)
            Case 1000 : Num2Text = "MIL"
            Case Is < 2000 : Num2Text = "MIL " & Num2Text(value Mod 1000)
            Case Is < 1000000 : Num2Text = Num2Text(Int(value \ 1000)) & " MIL"
                If value Mod 1000 Then Num2Text = Num2Text & " " & Num2Text(value Mod 1000)
            Case 1000000 : Num2Text = "UN MILLON"
            Case Is < 2000000 : Num2Text = "UN MILLON " & Num2Text(value Mod 1000000)
            Case Is < 1000000000000.0# : Num2Text = Num2Text(Int(value / 1000000)) & " MILLONES "
                If (value - Int(value / 1000000) * 1000000) Then Num2Text = Num2Text & " " & Num2Text(value - Int(value / 1000000) * 1000000)
            Case 1000000000000.0# : Num2Text = "UN BILLON"
            Case Is < 2000000000000.0# : Num2Text = "UN BILLON " & Num2Text(value - Int(value / 1000000000000.0#) * 1000000000000.0#)
            Case Else : Num2Text = Num2Text(Int(value / 1000000000000.0#)) & " BILLONES"
                If (value - Int(value / 1000000000000.0#) * 1000000000000.0#) Then Num2Text = Num2Text & " " & Num2Text(value - Int(value / 1000000000000.0#) * 1000000000000.0#)
        End Select

    End Function
    Function FLValidarPropietarios(filaAgregada As Integer)
        '17/Ago/2016
        Dim VLFirmante As Integer = 0
        Dim VLFilas As Integer = 0
        For i As Integer = 1 To grdPropietarios.Rows - 1
            grdPropietarios.Col = 5
            grdPropietarios.Row = i
            If (grdPropietarios.CtlText = "F") Or (grdPropietarios.CtlText = "U") Then
                VLFirmante += 1
                VLTutor = True
            End If
        Next i
        VLFilas = grdPropietarios.Rows + filaAgregada
        If txtCampo(18).Text = "I" Then
            If VLTutor Then
                If VLFilas > 3 Then
                    COBISMessageBox.Show(FMLoadResString(2607), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(18).Focus()
                    Return False
                End If
            Else
                If VLFilas > 2 Then
                    COBISMessageBox.Show(FMLoadResString(2607), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(18).Focus()
                    Return False
                End If
            End If
        Else
            If VLTutor Then
                If (VLFilas - VLFirmante) <= 2 Then
                    COBISMessageBox.Show(FMLoadResString(2608), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(18).Focus()
                    Return False
                End If
            Else
                If VLFilas <= 2 Then
                    COBISMessageBox.Show(FMLoadResString(2608), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(18).Focus()
                    Return False
                End If
            End If
        End If
        '
        Return True
    End Function

    Private Sub mskCuenta2_Enter(sender As Object, e As EventArgs) Handles mskCuenta2.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(99833))
    End Sub

    Private Sub mskCuenta2_KeyDown(sender As Object, e As KeyEventArgs) Handles mskCuenta2.KeyDown
        Dim KeyCode As Integer = e.KeyData
        If KeyCode = VGTeclaAyuda Then
            If VLCodTitular = 0 Then
                COBISMessageBox.Show(FMLoadResString(501931), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskCuenta2.Mask = VGMascaraCtaAho
                mskCuenta2.Text = FMMascara("", VGMascaraCtaAho)
                txtCampo(0).Focus()
            Else
                VLPaso = True
                PMCatalogo("CTA", VLCodTitular, mskCuenta2, Nothing)
            End If
        End If
    End Sub

    Private Sub mskCuenta2_Leave(sender As Object, e As EventArgs) Handles mskCuenta2.Leave
        If Not VLPaso Then
            If mskCuenta.ClipText <> "" Then
                If FMChequeaCtaAho(mskCuenta2.ClipText) Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta2.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_relacionada", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_consulta", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_codcliente", 0, SQLVARCHAR, VLCodTitular)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(502622) & " [" & mskCuenta2.Text & "]") Then
                        'PMMapeaObjeto(sqlconn, lblDescripcion(0))
                        PMChequea(sqlconn)
                    Else
                        mskCuenta2.Mask = VGMascaraCtaAho
                        mskCuenta2.Text = FMMascara("", VGMascaraCtaAho)
                        mskCuenta2.Focus()
                        PMChequea(sqlconn)
                        Exit Sub
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta2.Mask = VGMascaraCtaAho
                    mskCuenta2.Text = FMMascara("", VGMascaraCtaAho)
                    mskCuenta2.Focus()
                    Exit Sub
                End If
            End If
        End If
        VLPaso = True
    End Sub

    Private Sub mskCuenta2_TextChanged(sender As Object, e As EventArgs) Handles mskCuenta2.TextChanged
        VLPaso = False
    End Sub
End Class


