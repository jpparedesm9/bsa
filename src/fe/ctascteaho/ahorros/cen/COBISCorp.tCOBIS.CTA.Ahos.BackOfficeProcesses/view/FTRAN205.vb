Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Imports COBISCorp.tCOBIS.CTA.Ahos.AccountsAdmCatalogs

Partial Public Class FTran205Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


    Dim VLNumero As Integer = 0
    Dim VLPaso As Integer = 0
    Dim VLNumLib As String = ""
    Dim VLEnte As Integer = 0
    Dim VLCedula1 As String = ""
    Dim VLCotitular As String = ""
    Dim VLTraslado As String = ""
    Dim VLBeneficiarios As Boolean = False

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_4.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTNumLib As Integer = 0
        Dim VLCausa As String = ""
        If txtCampo(4).Text = "" Then
            VTNumLib = 0
        Else
            VTNumLib = CInt(txtCampo(4).Text)
        End If
        Select Case Index
            Case 0
                If mskCuenta.ClipText = "" Then
                    COBISMessageBox.Show(FMLoadResString(501625), My.Application.Info.ProductName)
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                    mskCuenta.Focus()
                    Exit Sub
                End If
                If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(501202), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    If txtCampo(1).Visible Then
                        txtCampo(1).Focus()
                    Else
                        txtCampo(13).Focus()
                    End If
                    Exit Sub
                End If
                If txtCampo(13).Text = "" Then
                    txtCampo(13).Text = txtCampo(3).Text
                    txtCampo(13).Tag = Convert.ToString(txtCampo(3).Tag)
                    For i As Integer = 0 To 3
                        If optDireccion(i).Checked Then
                            optDirecciondv(i).Checked = True
                        End If
                    Next i
                End If
                If optcausa(0).Checked Or optcausa(1).Checked Or (VLNumLib <> txtCampo(4).Text) Then
                    If txtCampo(4).Text = "" Or VTNumLib = 0 Then
                        COBISMessageBox.Show(FMLoadResString(501954), My.Application.Info.ProductName)
                        txtCampo(4).Focus()
                        Exit Sub
                    ElseIf VLNumLib = txtCampo(4).Text And optcausa(1).Checked Then
                        COBISMessageBox.Show(FMLoadResString(501955), My.Application.Info.ProductName)
                        txtCampo(4).Focus()
                        Exit Sub
                    ElseIf VLNumLib <> txtCampo(4).Text And optcausa(0).Checked Then
                        COBISMessageBox.Show(FMLoadResString(501956), My.Application.Info.ProductName)
                        txtCampo(4).Focus()
                        Exit Sub
                    ElseIf Not optcausa(0).Checked And Not optcausa(1).Checked Then
                        COBISMessageBox.Show(FMLoadResString(501957), My.Application.Info.ProductName)
                        txtCampo(4).Focus()
                        Exit Sub
                    ElseIf optcausa(1).Checked And txtCampo(5).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(501958), My.Application.Info.ProductName)
                        If Not txtCampo(5).Enabled Then
                            txtCampo(5).Enabled = True
                            PLTSEstado()
                        End If
                        txtCampo(5).Focus()
                        Exit Sub
                    ElseIf optcausa(0).Checked Then
                        VLCausa = "A"
                    Else
                        VLCausa = "C"
                    End If
                Else
                    VLCausa = ""
                End If
                If mskCuenta.ClipText <> "" Then
                    If txtCampo(0).Text <> "" Then
                        If txtCampo(1).Text <> "" Then
                            If txtCampo(2).Text <> "" Then
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "205")
                                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                                PMPasoValores(sqlconn, "@i_nombre", 0, SQLVARCHAR, txtCampo(0).Text)
                                PMPasoValores(sqlconn, "@i_cli1", 0, SQLINT4, VLCotitular)
                                PMPasoValores(sqlconn, "@i_nombre1", 0, SQLVARCHAR, " ")
                                If VLCedula1 <> "" Then
                                    PMPasoValores(sqlconn, "@i_cedruc1", 0, SQLVARCHAR, VLCedula1)
                                Else
                                    VLCedula1 = " "
                                    PMPasoValores(sqlconn, "@i_cedruc1", 0, SQLVARCHAR, VLCedula1)
                                End If
                                If optDireccion(0).Checked Then
                                    PMPasoValores(sqlconn, "@i_direc", 0, SQLINT1, txtCampo(1).Text)
                                    PMPasoValores(sqlconn, "@i_cli_ec", 0, SQLINT4, Convert.ToString(txtCampo(1).Tag))
                                    PMPasoValores(sqlconn, "@i_tipodir", 0, SQLCHAR, "D")
                                ElseIf optDireccion(1).Checked Then
                                    PMPasoValores(sqlconn, "@i_direc", 0, SQLINT1, txtCampo(1).Text)
                                    PMPasoValores(sqlconn, "@i_cli_ec", 0, SQLINT4, Convert.ToString(txtCampo(1).Tag))
                                    PMPasoValores(sqlconn, "@i_tipodir", 0, SQLCHAR, "C")
                                ElseIf optDireccion(3).Checked Then
                                    PMPasoValores(sqlconn, "@i_casillero", 0, SQLVARCHAR, txtCampo(1).Text)
                                    PMPasoValores(sqlconn, "@i_tipodir", 0, SQLCHAR, "S")
                                    PMPasoValores(sqlconn, "@i_direc", 0, SQLINT1, "0")
                                    PMPasoValores(sqlconn, "@i_cli_ec", 0, SQLINT4, "0")
                                ElseIf optDireccion(2).Checked Then
                                    PMPasoValores(sqlconn, "@i_agencia", 0, SQLINT2, txtCampo(1).Text)
                                    PMPasoValores(sqlconn, "@i_tipodir", 0, SQLCHAR, "R")
                                    PMPasoValores(sqlconn, "@i_direc", 0, SQLINT1, "0")
                                    PMPasoValores(sqlconn, "@i_cli_ec", 0, SQLINT4, "0")
                                End If
                                If optDirecciondv(0).Checked Then
                                    PMPasoValores(sqlconn, "@i_direc_dv", 0, SQLINT1, txtCampo(13).Text)
                                    PMPasoValores(sqlconn, "@i_cli_dv", 0, SQLINT4, Convert.ToString(txtCampo(13).Tag))
                                    PMPasoValores(sqlconn, "@i_tipodir_dv", 0, SQLCHAR, "D")
                                ElseIf optDirecciondv(1).Checked Then
                                    PMPasoValores(sqlconn, "@i_direc_dv", 0, SQLINT1, txtCampo(13).Text)
                                    PMPasoValores(sqlconn, "@i_cli_dv", 0, SQLINT4, Convert.ToString(txtCampo(13).Tag))
                                    PMPasoValores(sqlconn, "@i_tipodir_dv", 0, SQLCHAR, "C")
                                ElseIf optDirecciondv(3).Checked Then
                                    PMPasoValores(sqlconn, "@i_casillero_dv", 0, SQLVARCHAR, txtCampo(13).Text)
                                    PMPasoValores(sqlconn, "@i_tipodir_dv", 0, SQLCHAR, "S")
                                    PMPasoValores(sqlconn, "@i_direc_dv", 0, SQLINT1, "0")
                                    PMPasoValores(sqlconn, "@i_cli_dv", 0, SQLINT4, "0")
                                ElseIf optDirecciondv(2).Checked Then
                                    PMPasoValores(sqlconn, "@i_agencia_dv", 0, SQLINT2, txtCampo(13).Text)
                                    PMPasoValores(sqlconn, "@i_tipodir_dv", 0, SQLCHAR, "R")
                                    PMPasoValores(sqlconn, "@i_direc_dv", 0, SQLINT1, "0")
                                    PMPasoValores(sqlconn, "@i_cli_dv", 0, SQLINT4, "0")
                                End If
                                PMPasoValores(sqlconn, "@i_ciclo", 0, SQLCHAR, txtCampo(2).Text)
                                PMPasoValores(sqlconn, "@i_numlib", 0, SQLINT4, txtCampo(4).Text)
                                PMPasoValores(sqlconn, "@i_causa", 0, SQLCHAR, VLCausa)
                                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_up_gral_ctahorro", True, FMLoadResString(503281)) Then
                                    PMMapeaObjeto(sqlconn, lblDescripcion(3))
                                    PMChequea(sqlconn)
                                    cmdBoton(0).Enabled = False
                                    cmdBoton(3).Enabled = True
                                    PLTSEstado()
                                Else
                                    PMChequea(sqlconn)
                                    cmdBoton_Click(cmdBoton(1), New EventArgs())
                                End If
                            Else
                                COBISMessageBox.Show(FMLoadResString(501205), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                txtCampo(2).Focus()
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501202), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(1).Focus()
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(501932), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(0).Focus()
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(501337), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                End If
            Case 1
                txtCampo(3).Enabled = True
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                For i As Integer = 0 To 6
                    txtCampo(i).Text = ""
                Next i
                lblDescripcion(0).Text = ""
                For i As Integer = 1 To 4
                    lblDescripcion(i).Text = ""
                Next i
                PMLimpiaGrid(grdPropietarios)
                VLNumero = 0
                chkFuncionario.Checked = False
                optcausa(0).Checked = False
                optcausa(1).Checked = False
                cmdBoton(0).Enabled = True
                cmdBoton(3).Enabled = False
                cmdBoton(4).Enabled = False
                optDireccion(0).Checked = True
                optDirecciondv(0).Checked = True
                mskCuenta.Enabled = True
                VLEnte = True
                VLCotitular = "0"
                optdir(0).Enabled = False
                optdir(1).Checked = True
                Lblalianza.Text = ""
                lbldesalianza.Text = ""
                mskCuenta.Focus()
                PLTSEstado()
            Case 2
                Me.Close()
            Case 3
                PLImprimir()
            Case 4
                ReDim VGADatosI(3)
                VGADatosI(0) = mskCuenta.ClipText
                VGADatosI(1) = txtCampo(0).Text
                VGADatosI(2) = "4"
                VGADatosI(3) = "mantenimiento"
                FBenCta.ShowPopup(Me)
        End Select
    End Sub

    Private Sub FTran205_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
    End Sub

    Public Sub PLInicializar()
        VLNumero = 0
        mskCuenta.Mask = VGMascaraCtaAho
        optcausa(0).Checked = False
        optcausa(1).Checked = False
        VLEnte = True
        VLCedula1 = ""
        VLCotitular = "0"
        PLTSEstado()
    End Sub

    Private Sub FTran205_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdPropietarios_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdPropietarios.Click
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
        If Not Frame1dv.Visible Then
            If optDireccion(0).Checked Then
                txtCampo(1).Text = ""
                lblDescripcion(4).Text = ""
            End If
        Else
            If optDirecciondv(0).Checked Then
                txtCampo(13).Text = ""
                lblDescripcion(14).Text = ""
            End If
        End If
    End Sub

    Private Sub grdPropietarios_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdPropietarios.DblClick
    End Sub

    Private Sub grdPropietarios_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdPropietarios.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2223))
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500659))
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
    End Sub

    Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        Dim VTR As Integer = 0
        Dim VLCed As String = ""
        Dim VTR1 As Integer = 0
        If mskCuenta.ClipText <> "" Then
            If FMChequeaCtaAho(mskCuenta.ClipText) Then
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "297")
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_gral_up_ah", True, FMLoadResString(508838)) Then
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
                        If Valores(3, i) = "P" And Valores(5, i) = "T" Then
                            VLBeneficiarios = True
                        End If
                    Next i
                    If grdPropietarios.Rows > 2 Then
                        grdPropietarios.RemoveItem(1)
                    End If
                    grdPropietarios.ColWidth(0) = 1
                    grdPropietarios.ColWidth(1) = 960
                    grdPropietarios.ColWidth(2) = 1440
                    grdPropietarios.ColWidth(3) = 300
                    grdPropietarios.ColWidth(4) = 3915
                    grdPropietarios.ColWidth(5) = 375
                    grdPropietarios.ColWidth(6) = 1230
                    grdPropietarios.ColWidth(7) = 1
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
                    grdPropietarios.CtlText = FMLoadResString(9941)
                    grdPropietarios.Col = 6
                    grdPropietarios.CtlText = FMLoadResString(9942)
                    Dim VTArreglo(20) As String
                    VTR1 = FMMapeaArreglo(sqlconn, VTArreglo)
                    If VTR1 <= 0 Then
                        Exit Sub
                    End If
                    PMMapeaObjetoAB(sqlconn, txtCampo(2), lblDescripcion(1))
                    PMMapeaObjetoAB(sqlconn, txtCampo(3), lblDescripcion(2))
                    PMMapeaObjeto(sqlconn, txtCampo(4))
                    PMMapeaVariable(sqlconn, VLCotitular)
                    PMMapeaVariable(sqlconn, VLTraslado)
                    VLNumLib = txtCampo(4).Text
                    PMChequea(sqlconn)
                    lblDescripcion(3).Text = VTArreglo(8)
                    VLNumero = grdPropietarios.Rows - 1
                    If VLTraslado = "S" Then
                        optdir(0).Enabled = True
                        optdir(0).Checked = True
                    Else
                        optdir(0).Enabled = False
                        optdir(1).Checked = True
                    End If
                    For i As Integer = 1 To grdPropietarios.Rows - 1
                        grdPropietarios.Row = i
                        grdPropietarios.Col = 5
                    Next i
                    grdPropietarios.ColWidth(0) = 1
                    grdPropietarios.ColWidth(1) = 960
                    grdPropietarios.ColWidth(2) = 1440
                    grdPropietarios.ColWidth(3) = 300
                    grdPropietarios.ColWidth(4) = 3915
                    grdPropietarios.ColWidth(5) = 375
                    grdPropietarios.ColWidth(6) = 1230
                    txtCampo(0).Text = VTArreglo(1)
                    txtCampo(6).Text = VTArreglo(9)
                    VLCedula1 = VTArreglo(10)
                    Select Case VTArreglo(2)
                        Case "D"
                            optDireccion(0).Checked = True
                            txtCampo(1).Text = VTArreglo(3)
                            lblDescripcion(4).Text = VTArreglo(4)
                            txtCampo(1).Tag = VTArreglo(5)
                        Case "C"
                            optDireccion(1).Checked = True
                            txtCampo(1).Text = VTArreglo(3)
                            lblDescripcion(4).Text = VTArreglo(4)
                            txtCampo(1).Tag = VTArreglo(5)
                        Case "R"
                            optDireccion(2).Checked = True
                            txtCampo(1).Text = VTArreglo(6)
                            lblDescripcion(4).Text = VTArreglo(4)
                            txtCampo(1).Tag = VTArreglo(5)
                        Case "S"
                            optDireccion(3).Checked = True
                            txtCampo(1).Text = Strings.Mid(VTArreglo(4), 13, VTArreglo(4).Length)
                            txtCampo(1).Tag = VTArreglo(5)
                    End Select
                    Select Case VTArreglo(11)
                        Case "D"
                            optDirecciondv(0).Checked = True
                            txtCampo(13).Text = VTArreglo(12)
                            lblDescripcion(14).Text = VTArreglo(13)
                            txtCampo(13).Tag = VTArreglo(14)
                        Case "C"
                            optDirecciondv(1).Checked = True
                            txtCampo(13).Text = VTArreglo(12)
                            lblDescripcion(14).Text = VTArreglo(13)
                            txtCampo(13).Tag = VTArreglo(14)
                        Case "R"
                            optDirecciondv(2).Checked = True
                            txtCampo(13).Text = VTArreglo(15)
                            lblDescripcion(14).Text = VTArreglo(13)
                            txtCampo(13).Tag = VTArreglo(14)
                        Case "S"
                            optDirecciondv(3).Checked = True
                            txtCampo(13).Text = Strings.Mid(VTArreglo(13), 13, VTArreglo(13).Length)
                            txtCampo(13).Tag = VTArreglo(14)
                    End Select
                    optdir_CheckedChanged(optdir(0), New EventArgs())
                    If VTArreglo(7) = "S" Then
                        chkFuncionario.Checked = True
                        chkFuncionario.Enabled = False
                    Else
                        chkFuncionario.Checked = False
                        chkFuncionario.Enabled = False
                    End If
                    txtCampo(3).Enabled = False
                    If VLBeneficiarios Then
                        VLBeneficiarios = False
                        cmdBoton(4).Enabled = True
                        PLTSEstado()
                    End If
                Else
                    PMChequea(sqlconn)
                    cmdBoton_Click(cmdBoton(1), New EventArgs())
                    Exit Sub
                End If
            Else
                COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                cmdBoton_Click(cmdBoton(1), New EventArgs())
                Exit Sub
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
    End Sub

    Private Sub optcausa_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optcausa_1.Enter, _optcausa_0.Enter
        Dim Index As Integer = Array.IndexOf(optcausa, eventSender)
        If Index = 0 Then
            txtCampo(5).Text = ""
            lblDescripcion(0).Text = ""
            txtCampo(5).Enabled = False
        Else
            txtCampo(5).Enabled = True
        End If
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub optdir_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optdir_0.CheckedChanged, _optdir_1.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            If optdir(1).Checked Then
                Frame1dv.Visible = True
                lblDescripcion(14).Visible = True
                txtCampo(13).Visible = True
                lblEtiqueta(19).Visible = True
            Else
                Frame1dv.Visible = False
                lblDescripcion(14).Visible = False
                txtCampo(13).Visible = False
                lblEtiqueta(19).Visible = False
            End If
            frmDirecciones.Visible = Not Frame1dv.Visible
            lblDescripcion(4).Visible = (Not optDireccion(3).Checked) And optdir(0).Checked
            lblDescripcion(14).Visible = (Not optDirecciondv(3).Checked) And optdir(1).Checked
            txtCampo(1).Visible = Not txtCampo(13).Visible
            lblEtiqueta(12).Visible = Not lblEtiqueta(19).Visible
        End If
    End Sub

    Private Sub optDireccion_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optDireccion_0.CheckedChanged, _optDireccion_1.CheckedChanged, _optDireccion_2.CheckedChanged, _optDireccion_3.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Index As Integer = Array.IndexOf(optDireccion, eventSender)
            Dim Value As Integer = optDireccion(Index).Checked
            optDireccion_ClickHelper(Index, Value)
        End If
    End Sub

    Private Sub optDireccion_ClickHelper(ByRef Index As Integer, ByRef Value As Integer)
        Select Case Index
            Case 0
                If Value Then
                    lblDescripcion(4).Visible = True
                    lblEtiqueta(12).Text = FMLoadResString(501172)
                    txtCampo(1).Text = ""
                    lblDescripcion(4).Text = ""
                End If
            Case 1
                If Value Then
                    lblDescripcion(4).Visible = True
                    lblEtiqueta(12).Text = FMLoadResString(502405)
                    txtCampo(1).Text = ""
                    lblDescripcion(4).Text = ""
                End If
            Case 2
                If Value Then
                    lblDescripcion(4).Visible = True
                    lblEtiqueta(12).Text = FMLoadResString(509284)
                    txtCampo(1).Text = ""
                    lblDescripcion(4).Text = ""
                End If
            Case 3
                If Value Then
                    lblDescripcion(4).Visible = False
                    lblEtiqueta(12).Text = FMLoadResString(502407)
                    txtCampo(1).Text = ""
                End If
        End Select
    End Sub

    Private Sub PLImprimir()
        Dim VTTipo As String = ""
        If frmDirecciones.Visible Then
            If optDireccion(0).Checked Then
                VTTipo = lblDescripcion(4).Text
            ElseIf optDireccion(1).Checked Then
                VTTipo = "Casilla : " & lblDescripcion(4).Text
            ElseIf optDireccion(2).Checked Then
                VTTipo = "Agencia : " & lblDescripcion(4).Text
            ElseIf optDireccion(3).Checked Then
                VTTipo = "Casillero : " & txtCampo(1).Text
            End If
        End If
        If COBISMessageBox.Show(FMLoadResString(501288), FMLoadResString(500092), COBISMessageBox.COBISButtons.OK Or COBISMessageBox.COBISButtons.OKCancel, COBISMessageBox.COBISIcon.Question) = System.Windows.Forms.DialogResult.OK Then
            Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
            FMCabeceraReporte(VGBanco, DateTimeHelper.ToString(DateTime.Today), FMLoadResString(509285), DateTimeHelper.ToString(DateTimeHelper.Time), Me.Text, VGFecha, CStr(COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Page))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(New String("-", 85))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509286), FileSystem.TAB(30), mskCuenta.Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509287), FileSystem.TAB(30), txtCampo(0).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509288), FileSystem.TAB(30), lblDescripcion(2).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            If frmDirecciones.Visible Then
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509289), FileSystem.TAB(30), VTTipo & lblDescripcion(6).Text)
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            End If
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509290), FileSystem.TAB(30), lblDescripcion(1).Text)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            If optcausa(0).Checked Then
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509291), FMLoadResString(509292))
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            End If
            If optcausa(1).Checked Then
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509291), FMLoadResString(509293))
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509294), lblDescripcion(0).Text)
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            End If
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(New String(FMLoadResString(509297), 85))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), VGLogin)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509295))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509296))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(New String(FMLoadResString(509297), 18))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509298))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            If VGCodPais <> "CO" Then
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509299))
            End If
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.EndDoc()
            Me.Cursor = System.Windows.Forms.Cursors.Default
        End If
    End Sub

    Private Sub optDirecciondv_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optDirecciondv_3.CheckedChanged, _optDirecciondv_2.CheckedChanged, _optDirecciondv_1.CheckedChanged, _optDirecciondv_0.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Index As Integer = Array.IndexOf(optDirecciondv, eventSender)
            Dim Value As Integer = optDirecciondv(Index).Checked
            optDirecciondv_ClickHelper(Index, Value)
        End If
    End Sub

    Private Sub optDirecciondv_ClickHelper(ByRef Index As Integer, ByRef Value As Integer)
        Select Case Index
            Case 0
                If Value Then
                    lblDescripcion(14).Visible = True
                    lblEtiqueta(19).Text = FMLoadResString(501172)
                    txtCampo(13).Text = ""
                    lblDescripcion(14).Text = ""
                End If
            Case 1
                If Value Then
                    lblDescripcion(14).Visible = True
                    lblEtiqueta(19).Text = FMLoadResString(502405)
                    txtCampo(13).Text = ""
                    lblDescripcion(14).Text = ""
                End If
            Case 2
                If Value Then
                    lblDescripcion(14).Visible = True
                    lblEtiqueta(19).Text = FMLoadResString(509284)
                    txtCampo(13).Text = ""
                    lblDescripcion(14).Text = ""
                End If
            Case 3
                If Value Then
                    lblDescripcion(14).Visible = False
                    lblEtiqueta(19).Text = FMLoadResString(502407)
                    txtCampo(13).Text = ""
                End If
        End Select
    End Sub

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_13.TextChanged, _txtCampo_6.TextChanged, _txtCampo_5.TextChanged, _txtCampo_4.TextChanged, _txtCampo_3.TextChanged, _txtCampo_1.TextChanged, _txtCampo_0.TextChanged, _txtCampo_2.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 1, 2, 3, 5
                VLPaso = False
        End Select
    End Sub

    Private Sub txtCampo_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_13.Click, _txtCampo_6.Click, _txtCampo_5.Click, _txtCampo_4.Click, _txtCampo_3.Click, _txtCampo_1.Click, _txtCampo_0.Click, _txtCampo_2.Click
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case Index = 5
                If Not txtCampo(Index).Enabled Then
                    txtCampo(Index).Enabled = True
                End If
                txtCampo(Index).Focus()
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_13.Enter, _txtCampo_6.Enter, _txtCampo_5.Enter, _txtCampo_4.Enter, _txtCampo_3.Enter, _txtCampo_1.Enter, _txtCampo_0.Enter, _txtCampo_2.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501936))
            Case 1
                VLPaso = True
                If optDireccion(0).Checked Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508507))
                ElseIf optDireccion(1).Checked Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501219))
                ElseIf optDireccion(2).Checked Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501289))
                ElseIf optDireccion(3).Checked Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508679))
                End If
            Case 2
                VLPaso = True
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501224))
            Case 3
                VLPaso = True
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501967))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501968))
            Case 5
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508451))
            Case 13
                VLPaso = True
                If optDirecciondv(0).Checked Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508504))
                ElseIf optDirecciondv(1).Checked Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508506))
                ElseIf optDirecciondv(2).Checked Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501289))
                ElseIf optDirecciondv(3).Checked Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508679))
                End If
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_13.KeyDown, _txtCampo_6.KeyDown, _txtCampo_5.KeyDown, _txtCampo_4.KeyDown, _txtCampo_3.KeyDown, _txtCampo_1.KeyDown, _txtCampo_0.KeyDown, _txtCampo_2.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode        
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If KeyCode = VGTeclaAyuda Then
            Select Case Index
                Case 1
                    If VLNumero <> 0 Then
                        VLPaso = True
                        If optDireccion(0).Checked Then
                            If VLNumero <> 0 Then
                                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                                grdPropietarios.Col = 1
                                PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, grdPropietarios.CtlText)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1227")
                                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_direccion_cons", True, FMLoadResString(2279)) Then
                                    PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                                    PMChequea(sqlconn)
                                    FCatalogo.ShowPopup(Me)
                                    txtCampo(1).Text = VGACatalogo.Codigo
                                    lblDescripcion(4).Text = VGACatalogo.Descripcion
                                    grdPropietarios.Col = 1
                                    txtCampo(1).Tag = grdPropietarios.CtlText
                                    VLPaso = True
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(1).Tag = ""
                                End If
                            Else
                                COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                txtCampo(1).Focus()
                            End If
                        ElseIf optDireccion(1).Checked Then
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
                                    txtCampo(1).Text = VGACatalogo.Codigo
                                    lblDescripcion(4).Text = VGACatalogo.Descripcion
                                    grdPropietarios.Col = 1
                                    txtCampo(1).Tag = grdPropietarios.CtlText
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(1).Tag = ""
                                End If
                            Else
                                COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                txtCampo(0).Focus()
                            End If
                        ElseIf optDireccion(2).Checked Then
                            If VLNumero <> 0 Then
                                PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "O")
                                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "34")
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_agencia", True, FMLoadResString(502842)) Then
                                    PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                                    PMChequea(sqlconn)
                                    VLPaso = True
                                    FCatalogo.ShowPopup(Me)
                                    txtCampo(1).Text = VGACatalogo.Codigo
                                    lblDescripcion(4).Text = VGACatalogo.Descripcion
                                    grdPropietarios.Col = 1
                                    txtCampo(1).Tag = grdPropietarios.CtlText
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(1).Tag = ""
                                End If
                            Else
                                COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                txtCampo(0).Focus()
                            End If
                        End If
                    End If
                Case 2
                    VLPaso = True
                    PMCatalogo("A", "cc_ciclo", txtCampo(2), lblDescripcion(1))
                    If txtCampo(2).Text <> "" Then
                        txtCampo(4).Focus()
                    End If
                Case 5
                    VLPaso = True
                    PMCatalogo("A", "ah_causa_canje", txtCampo(5), lblDescripcion(0))
                Case 13
                    If VLNumero <> 0 Then
                        VLPaso = True
                        If optDirecciondv(0).Checked Then
                            If VLNumero <> 0 Then
                                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                                grdPropietarios.Col = 1
                                PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, grdPropietarios.CtlText)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1227")
                                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_direccion_cons", True, FMLoadResString(509300)) Then
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
                                txtCampo(13).Focus()
                            End If
                        ElseIf optDirecciondv(1).Checked Then
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
                                txtCampo(0).Focus()
                            End If
                        ElseIf optDirecciondv(2).Checked Then
                            If VLNumero <> 0 Then
                                PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "O")
                                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "34")
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_agencia", True, FMLoadResString(502842)) Then
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
                                txtCampo(0).Focus()
                            End If
                        End If
                    End If
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_13.KeyPress, _txtCampo_6.KeyPress, _txtCampo_5.KeyPress, _txtCampo_4.KeyPress, _txtCampo_3.KeyPress, _txtCampo_1.KeyPress, _txtCampo_0.KeyPress, _txtCampo_2.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 1, 2, 3, 4, 5
                KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
            Case 0
                KeyAscii = FMVAlidaTipoDato("B", KeyAscii)
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_13.Leave, _txtCampo_6.Leave, _txtCampo_5.Leave, _txtCampo_4.Leave, _txtCampo_3.Leave, _txtCampo_1.Leave, _txtCampo_0.Leave, _txtCampo_2.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 1
                If Not VLPaso Then
                    If optDireccion(0).Checked Then
                        If VLNumero <> 0 Then
                            If txtCampo(1).Text <> "" Then
                                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                                grdPropietarios.Col = 1
                                PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, grdPropietarios.CtlText)
                                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                                PMPasoValores(sqlconn, "@i_direccion", 0, SQLINT2, txtCampo(1).Text)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1229")
                                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_direccion_cons", True, FMLoadResString(508986) & txtCampo(Index).Text & "]") Then
                                    PMMapeaObjeto(sqlconn, lblDescripcion(4))
                                    PMChequea(sqlconn)
                                    grdPropietarios.Col = 1
                                    txtCampo(1).Tag = grdPropietarios.CtlText
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(1).Text = ""
                                    lblDescripcion(4).Text = ""
                                    txtCampo(1).Tag = ""
                                    txtCampo(1).Focus()
                                End If
                            Else
                                lblDescripcion(4).Text = ""
                                txtCampo(1).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(1).Tag = ""
                            txtCampo(1).Focus()
                        End If
                    ElseIf optDireccion(1).Checked Then
                        If VLNumero <> 0 Then
                            If txtCampo(1).Text <> "" Then
                                PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "V")
                                grdPropietarios.Col = 1
                                PMPasoValores(sqlconn, "@i_cli", 0, SQLINT4, grdPropietarios.CtlText)
                                PMPasoValores(sqlconn, "@i_casi", 0, SQLINT2, txtCampo(1).Text)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "92")
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_casilla", True, FMLoadResString(508987) & txtCampo(Index).Text & "]") Then
                                    PMMapeaObjeto(sqlconn, lblDescripcion(4))
                                    PMChequea(sqlconn)
                                    grdPropietarios.Col = 1
                                    txtCampo(1).Tag = grdPropietarios.CtlText
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(1).Text = ""
                                    lblDescripcion(4).Text = ""
                                    txtCampo(1).Tag = ""
                                    txtCampo(1).Focus()
                                End If
                            Else
                                lblDescripcion(1).Text = ""
                                txtCampo(1).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(1).Tag = ""
                            txtCampo(1).Focus()
                        End If
                    ElseIf optDireccion(2).Checked Then
                        If VLNumero <> 0 Then
                            If txtCampo(1).Text <> "" Then
                                PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "H")
                                PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, txtCampo(1).Text)
                                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "34")
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_agencia", True, FMLoadResString(502842)) Then
                                    PMMapeaObjeto(sqlconn, lblDescripcion(4))
                                    PMChequea(sqlconn)
                                    grdPropietarios.Col = 1
                                    txtCampo(1).Tag = grdPropietarios.CtlText
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(1).Text = ""
                                    lblDescripcion(4).Text = ""
                                    txtCampo(1).Tag = ""
                                    txtCampo(1).Focus()
                                End If
                            Else
                                lblDescripcion(4).Text = ""
                                txtCampo(1).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(1).Tag = ""
                            txtCampo(1).Focus()
                        End If
                    End If
                End If
            Case 2
                If Not VLPaso Then
                    If txtCampo(2).Text <> "" Then
                        PMCatalogo("V", "cc_ciclo", txtCampo(2), lblDescripcion(1))
                    Else
                        lblDescripcion(1).Text = ""
                    End If
                End If
            Case 5
                If Not VLPaso Then
                    If txtCampo(5).Text <> "" Then
                        PMCatalogo("V", "ah_causa_canje", txtCampo(5), lblDescripcion(0))
                    Else
                        lblDescripcion(0).Text = ""
                    End If
                End If
            Case 13
                If Not VLPaso Then
                    If optDirecciondv(0).Checked Then
                        If VLNumero <> 0 Then
                            If txtCampo(13).Text <> "" Then
                                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                                grdPropietarios.Col = 1
                                PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, grdPropietarios.CtlText)
                                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                                PMPasoValores(sqlconn, "@i_direccion", 0, SQLINT2, txtCampo(13).Text)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1229")
                                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_direccion_cons", True, FMLoadResString(509301) & "[" & txtCampo(Index).Text & "]") Then
                                    PMMapeaObjeto(sqlconn, lblDescripcion(4))
                                    PMChequea(sqlconn)
                                    grdPropietarios.Col = 1
                                    txtCampo(13).Tag = grdPropietarios.CtlText
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(13).Text = ""
                                    lblDescripcion(14).Text = ""
                                    txtCampo(13).Tag = ""
                                    txtCampo(13).Focus()
                                End If
                            Else
                                lblDescripcion(14).Text = ""
                                txtCampo(13).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(13).Tag = ""
                            txtCampo(13).Focus()
                        End If
                    ElseIf optDirecciondv(1).Checked Then
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
                                    txtCampo(13).Focus()
                                End If
                            Else
                                lblDescripcion(13).Text = ""
                                txtCampo(13).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(13).Tag = ""
                            txtCampo(13).Focus()
                        End If
                    ElseIf optDirecciondv(2).Checked Then
                        If VLNumero <> 0 Then
                            If txtCampo(13).Text <> "" Then
                                PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "H")
                                PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, txtCampo(13).Text)
                                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "34")
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_agencia", True, FMLoadResString(502842)) Then
                                    PMMapeaObjeto(sqlconn, lblDescripcion(14))
                                    PMChequea(sqlconn)
                                    grdPropietarios.Col = 1
                                    txtCampo(13).Tag = grdPropietarios.CtlText
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(13).Text = ""
                                    lblDescripcion(14).Text = FMLoadResString(501238)
                                    txtCampo(13).Tag = ""
                                    txtCampo(13).Focus()
                                End If
                            Else
                                lblDescripcion(14).Text = ""
                                txtCampo(13).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(13).Tag = ""
                            txtCampo(13).Focus()
                        End If
                    End If
                End If
        End Select
    End Sub
    Private Sub PLTSEstado()
        TSBBeneficiarios.Visible = _cmdBoton_4.Visible
        TSBBeneficiarios.Enabled = _cmdBoton_4.Enabled
        TSBImprimir.Visible = _cmdBoton_3.Visible
        TSBImprimir.Enabled = _cmdBoton_3.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
    End Sub

    Private Sub TSBBeneficiarios_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBeneficiarios.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
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
End Class


