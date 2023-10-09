Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Drawing
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
Imports COBISCorp.tCOBIS.PER.Query
Partial Public Class FPersoCuentaClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim FBuscarCliente As COBISCorp.tCOBIS.BClientes.FBuscarClienteClass

    Dim VLPaso As Integer = 0
    Dim VLEnte As String = ""
    Dim VLClienAnt As String = ""
    Dim VLClienAct As String = ""
    Private isInitializingComponent As Boolean = False

    Private Sub cmbEnte_SelectedValueChanged(sender As Object, e As EventArgs) Handles cmbEnte.SelectedValueChanged

        txtCampo(2).Text = "1"
        lblDescripcion(2).Text = "PROPIETARIO"
        txtCampo(2).Enabled = False
        txtCampo(1).Enabled = True
        txtCampo(1).Text = ""
        lblDescripcion(1).Text = ""
        PMLimpiaGrid(grdCuentas(0))
        PMLimpiaGrid(grdCuentas(1))
        cmdBoton(0).Enabled = False
        txtCampo(1).Focus()
        PLTSEstado()
        VLPaso = False

    End Sub

    Private Sub cmbEnte_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbEnte.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        If cmbEnte.Text <> "" Then
            Select Case cmbEnte.Text
                Case "CUENTA"
                    VLEnte = "C"
                    txtCampo(2).Text = "1"
                    lblDescripcion(2).Text = "PROPIETARIO"
                    txtCampo(2).Enabled = False
                    txtCampo(1).Focus()
                    'Case "PERSONA"
                    '    VLEnte = "P"
                    '    txtCampo(2).Text = "1"
                    '    lblDescripcion(2).Text = "PROPIETARIO"
                    '    txtCampo(2).Enabled = False
                    '    txtCampo(1).Focus()
                    '    'Case "EMPRESARIAL"
                    '    txtCampo(0).Enabled = True
                    '    lblDescripcion(0).Visible = True
                    '    VLEnte = "E"
                    '    txtCampo(0).Focus()
                    'Case "GRUPO ECONOMICO"
                    '    txtCampo(0).Enabled = True
                    '    lblDescripcion(0).Visible = True
                    '    txtCampo(0).Enabled = True
                    '    lblDescripcion(0).Visible = True
                    '    VLEnte = "G"
                    '    txtCampo(3).Focus()
                    'Case "DEFAULT"
                    '    VLEnte = "D"
                    '    txtCampo(2).Text = "1"
                    '    lblDescripcion(2).Text = "PROPIETARIO"
                    '    txtCampo(2).Enabled = False
                    '    txtCampo(1).Focus()
            End Select
        End If
    End Sub

    Private Sub cmbEnte_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbEnte.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1754))
    End Sub

    Private Sub cmbEnte_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbEnte.Leave
        If cmbEnte.Text <> "" Then
            Select Case cmbEnte.Text
                Case "CUENTA"
                    VLEnte = "C"
                    txtCampo(2).Text = "1"
                    lblDescripcion(2).Text = "PROPIETARIO"
                    txtCampo(2).Enabled = False
                    txtCampo(0).Enabled = False
                    txtCampo(3).Enabled = False
                    lblEtiqueta(2).ForeColor = System.Drawing.Color.Gray
                    lblEtiqueta(4).ForeColor = System.Drawing.Color.Gray
                    txtCampo(3).Text = ""
                    lblDescripcion(3).Text = ""
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Text = ""
                    txtCampo(0).Focus()
                Case "PERSONAL"
                    VLEnte = "P"
                    txtCampo(2).Text = "1"
                    lblDescripcion(2).Text = "PROPIETARIO"
                    txtCampo(2).Enabled = False
                    txtCampo(0).Enabled = False
                    txtCampo(3).Enabled = False
                    lblEtiqueta(2).ForeColor = System.Drawing.Color.Gray
                    lblEtiqueta(4).ForeColor = System.Drawing.Color.Gray
                    txtCampo(3).Text = ""
                    lblDescripcion(3).Text = ""
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Text = ""
                    txtCampo(1).Focus()
                Case "EMPRESARIAL"
                    txtCampo(0).Enabled = True
                    txtCampo(2).Text = ""
                    txtCampo(2).Enabled = False
                    lblDescripcion(2).Text = ""
                    txtCampo(3).Enabled = False
                    lblEtiqueta(4).ForeColor = System.Drawing.Color.Gray
                    txtCampo(1).Text = ""
                    lblDescripcion(1).Text = ""
                    VLEnte = "E"
                    txtCampo(0).Focus()
                    txtCampo(3).Text = ""
                    lblDescripcion(3).Text = ""
                    txtCampo(0).Focus()
                Case "GRUPO ECONOMICO"
                    txtCampo(3).Enabled = True
                    txtCampo(0).Enabled = True
                    txtCampo(2).Text = ""
                    lblDescripcion(2).Text = ""
                    txtCampo(2).Enabled = False
                    txtCampo(1).Text = ""
                    lblDescripcion(1).Text = ""
                    txtCampo(0).Text = ""
                    lblDescripcion(1).Text = ""
                    VLEnte = "G"
                    txtCampo(3).Focus()
                Case "DEFAULT"
                    VLEnte = "D"
                    txtCampo(2).Text = "1"
                    lblDescripcion(2).Text = "PROPIETARIO"
                    txtCampo(2).Enabled = False
                    txtCampo(0).Enabled = False
                    txtCampo(3).Enabled = False
                    lblEtiqueta(2).ForeColor = System.Drawing.Color.Gray
                    lblEtiqueta(4).ForeColor = System.Drawing.Color.Gray
                    txtCampo(3).Text = ""
                    lblDescripcion(3).Text = ""
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Text = ""
                    txtCampo(1).Focus()
            End Select
        End If
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_3.Click, _cmdBoton_2.Click, _cmdBoton_1.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTMarca As Integer = 0
        Dim VTFilas1 As Integer = 0
        Dim VTCuentas1 As String = ""
        Dim VTFilas2 As Integer = 0
        Dim VTCuentas2 As String = ""
        TSBotones.Focus()
        Select Case Index
            Case 0
                If cmbEnte.Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1772), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    cmbEnte.Focus()
                    Exit Sub
                End If
                If VLEnte = "G" Then
                    If txtCampo(3).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1249), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(3).Focus()
                        Exit Sub
                    End If
                End If
                If VLEnte = "E" Or VLEnte = "G" Then
                    If txtCampo(0).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1248), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(0).Focus()
                        Exit Sub
                    End If
                End If
                If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1258), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    PMLimpiaGrid(grdCuentas(0))
                    PMLimpiaGrid(grdCuentas(1))
                    cmdBoton(0).Enabled = False
                    txtCampo(1).Focus()
                    PLTSEstado()
                    Exit Sub
                End If
                If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1270), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                For j As Integer = 0 To 1
                    For i As Integer = 0 To grdCuentas(j).Rows - 1
                        grdCuentas(j).Col = 0
                        If grdCuentas(j).CtlText = "X" Then
                            VTMarca = 0
                        End If
                    Next i
                Next j
                If VTMarca = 1 Then
                    COBISMessageBox.Show(FMLoadResString(1252), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    grdCuentas(0).Focus()
                    Exit Sub
                End If
                For j As Integer = 0 To 1
                    For i As Integer = 1 To grdCuentas(j).Rows - 1 Step 1
                        grdCuentas(j).Row = i
                        grdCuentas(j).Col = 0
                        If grdCuentas(j).CtlText = "X" Then
                            grdCuentas(j).Row = i
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4071")
                            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
                            If VLEnte = "G" Then
                                PMPasoValores(sqlconn, "@i_cod_emp", 0, SQLINT4, txtCampo(3).Text)
                            Else
                                PMPasoValores(sqlconn, "@i_cod_emp", 0, SQLINT4, txtCampo(0).Text)
                            End If
                            PMPasoValores(sqlconn, "@i_cod_persona", 0, SQLINT4, txtCampo(1).Text)
                            PMPasoValores(sqlconn, "@i_rol", 0, SQLCHAR, txtCampo(2).Text)
                            PMPasoValores(sqlconn, "@i_tipo_default", 0, SQLCHAR, VLEnte)
                            grdCuentas(j).Col = 1
                            PMPasoValores(sqlconn, "@i_cuenta", 0, SQLINT4, grdCuentas(j).CtlText)
                            grdCuentas(j).Col = 7
                            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, grdCuentas(j).CtlText)
                            grdCuentas(j).Col = 8
                            PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, grdCuentas(j).CtlText)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_personaliza_cuenta", True, FMLoadResString(1936) & "[" & grdCuentas(j).CtlText & "]") Then
                                PMChequea(sqlconn)
                                grdCuentas(j).Col = 0
                                grdCuentas(j).CtlText = ""
                            Else
                                PMChequea(sqlconn)
                                grdCuentas(j).Col = 2
                                COBISMessageBox.Show(FMLoadResString(1350) & grdCuentas(j).CtlText, FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            End If
                        End If
                    Next i
                Next j
                cmdBoton_Click(cmdBoton(3), New EventArgs())
            Case 1
                cmbEnte.Items.Clear()
                cmbEnte.Items.Insert(0, "CUENTA")
                ' cmbEnte.Items.Insert(1, "PERSONAL")
                ' cmbEnte.Items.Insert(3, "EMPRESARIAL")
                ' cmbEnte.Items.Insert(4, "GRUPO ECONOMICO")
                ' cmbEnte.Items.Insert(2, "DEFAULT")
                cmbEnte.SelectedIndex = 0
                For i As Integer = 0 To 3
                    txtCampo(i).Text = ""
                Next i
                For i As Integer = 0 To 3
                    lblDescripcion(i).Text = ""
                Next i
                txtCampo(2).Text = "1"
                lblDescripcion(2).Text = "PROPIETARIO"
                txtCampo(2).Enabled = False
                txtCampo(1).Enabled = True
                txtCampo(0).Enabled = False
                txtCampo(3).Enabled = False
                lblEtiqueta(2).ForeColor = System.Drawing.Color.Gray
                lblEtiqueta(4).ForeColor = System.Drawing.Color.Gray
                VGPersonaliza = False
                For i As Integer = 0 To 1
                    For j As Integer = 1 To grdCuentas(i).Rows - 1
                        grdCuentas(i).Col = 0
                        If grdCuentas(i).CtlText = "X" Then
                            grdCuentas(i).CtlText = Conversion.Str(grdCuentas(i).Row)
                            grdCuentas(i).Picture = picVisto(1).Image
                        End If
                    Next j
                    PMLimpiaGrid(grdCuentas(i))
                Next i
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
                cmdBoton(0).Enabled = False 'tramsmitir
                cmbEnte.Focus()
                PLTSEstado()
            Case 2
                Me.Close()
                'FConsultaCta.Close() '19/05/2016 migracion
                FConsultaCta.Dispose()
                'FBuscarGrupo.Close() '19/05/2016 migracion
                FBuscarGrupo.Dispose()
                'FBuscarCliente.Close() '19/05/2016 migracion
                ' FBuscarCliente.Dispose()
                If Not FBuscarCliente Is Nothing Then 'JSA
                    FBuscarCliente = Nothing
                End If

            Case 3
                If cmbEnte.Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1292), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    cmbEnte.Focus()
                    Exit Sub
                End If
                Select Case VLEnte
                    Case "P", "C", "D"
                        If txtCampo(1).Text = "" Then
                            COBISMessageBox.Show(FMLoadResString(1258), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            PMLimpiaGrid(grdCuentas(0))
                            PMLimpiaGrid(grdCuentas(1))
                            cmdBoton(0).Enabled = 0
                            txtCampo(1).Focus()
                            PLTSEstado()
                            Exit Sub
                        End If
                    Case "E"
                        If txtCampo(0).Text = "" Then
                            COBISMessageBox.Show(FMLoadResString(1248), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(0).Focus()
                            Exit Sub
                        End If
                        If txtCampo(1).Text = "" Then
                            COBISMessageBox.Show(FMLoadResString(1258), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(1).Focus()
                            Exit Sub
                        End If
                    Case "G"
                        If txtCampo(3).Text = "" Then
                            COBISMessageBox.Show(FMLoadResString(1249), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(3).Focus()
                            Exit Sub
                        End If
                        If txtCampo(0).Text = "" Then
                            COBISMessageBox.Show(FMLoadResString(1248), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(0).Focus()
                            Exit Sub
                        End If
                        If txtCampo(1).Text = "" Then
                            COBISMessageBox.Show(FMLoadResString(1258), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(1).Focus()
                            Exit Sub
                        End If
                End Select
                VTFilas1 = VGMaxRows
                VTCuentas1 = "0"
                While VTFilas1 = VGMaxRows
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4072")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "C")
                    PMPasoValores(sqlconn, "@i_cod_persona", 0, SQLINT4, txtCampo(1).Text)
                    PMPasoValores(sqlconn, "@i_cod_emp", 0, SQLINT4, txtCampo(0).Text)
                    PMPasoValores(sqlconn, "@i_rol", 0, SQLCHAR, txtCampo(2).Text)
                    PMPasoValores(sqlconn, "@i_tipo_default", 0, SQLCHAR, VLEnte)
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_cuenta", 0, SQLINT4, VTCuentas1)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_personaliza_cuenta", True, FMLoadResString(1550)) Then
                        If VTCuentas1 = "0" Then
                            PMMapeaGrid(sqlconn, grdCuentas(0), False)
                        Else
                            PMMapeaGrid(sqlconn, grdCuentas(0), True)
                        End If
                        PMMapeaTextoGrid(grdCuentas(0))
                        PMAnchoColumnasGrid(grdCuentas(0))
                        PMChequea(sqlconn)
                        grdCuentas(0).Col = 1
                        grdCuentas(0).Row = grdCuentas(0).Rows - 1
                        VTCuentas1 = grdCuentas(0).CtlText
                    Else
                        PMChequea(sqlconn)
                    End If
                    VTFilas1 = Conversion.Val(Convert.ToString(grdCuentas(0).Tag))
                    grdCuentas(0).Col = 1
                    grdCuentas(0).Col = grdCuentas(0).Rows - 1
                    If grdCuentas(0).CtlText <> "" Then
                        cmdBoton(0).Enabled = True
                        PLTSEstado()
                    End If
                End While
                grdCuentas(0).Row = 1
                VTFilas2 = VGMaxRows
                VTCuentas2 = "0"
                While VTFilas2 = VGMaxRows
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4072")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_cod_persona", 0, SQLINT4, txtCampo(1).Text)
                    PMPasoValores(sqlconn, "@i_cod_emp", 0, SQLINT4, txtCampo(0).Text)
                    PMPasoValores(sqlconn, "@i_rol", 0, SQLCHAR, txtCampo(2).Text)
                    PMPasoValores(sqlconn, "@i_tipo_default", 0, SQLCHAR, VLEnte)
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_cuenta", 0, SQLINT4, VTCuentas2)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_personaliza_cuenta", True, FMLoadResString(1550)) Then
                        If VTCuentas2 = "0" Then
                            PMMapeaGrid(sqlconn, grdCuentas(1), False)
                        Else
                            PMMapeaGrid(sqlconn, grdCuentas(1), True)
                        End If
                        PMMapeaTextoGrid(grdCuentas(1))
                        PMAnchoColumnasGrid(grdCuentas(1))
                        PMChequea(sqlconn)
                        grdCuentas(1).Col = 1
                        grdCuentas(1).Row = grdCuentas(1).Rows - 1
                        VTCuentas2 = grdCuentas(1).CtlText
                    Else
                        PMChequea(sqlconn)
                    End If
                    VTFilas2 = Conversion.Val(Convert.ToString(grdCuentas(1).Tag))
                    grdCuentas(1).Col = 1
                    grdCuentas(1).Col = grdCuentas(1).Rows - 1
                    If grdCuentas(1).CtlText <> "" Then
                        cmdBoton(0).Enabled = True
                        PLTSEstado()
                    End If
                End While
                grdCuentas(1).Row = 1
        End Select
        PLTSEstado()
    End Sub

    Private Sub FPersoCuenta_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        cmbEnte.Items.Clear()
        cmbEnte.Items.Insert(0, "CUENTA")
        'cmbEnte.Items.Insert(1, "PERSONAL")
        ' cmbEnte.Items.Insert(2, "EMPRESARIAL")
        '  cmbEnte.Items.Insert(3, "GRUPO ECONOMICO")
        'cmbEnte.Items.Insert(2, "DEFAULT")
        cmbEnte.SelectedIndex = 0
        txtCampo(2).Text = "1"
        lblDescripcion(2).Text = "PROPIETARIO"
        txtCampo(2).Enabled = False
        cmdBoton(0).Enabled = False  'Transmitir
        txtCampo(0).Enabled = False
        VGPersonaliza = False
        PMObjetoSeguridad(cmdBoton(3))
        'PMObjetoSeguridad(cmdBoton(0))
        PLTSEstado()
    End Sub

    Private Sub FPersoCuenta_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub
    Private Sub grdCuentas_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _grdCuentas_1.ClickEvent, _grdCuentas_0.ClickEvent
        Dim Index As Integer = Array.IndexOf(grdCuentas, eventSender)
        Select Case Index
            Case 0, 1
                grdCuentas(Index).Col = 0
                grdCuentas(Index).SelStartCol = 1
                grdCuentas(Index).SelEndCol = grdCuentas(Index).Cols - 1
                If grdCuentas(Index).Row = 0 Then
                    grdCuentas(Index).SelStartRow = 1
                    grdCuentas(Index).SelEndRow = 1
                Else
                    grdCuentas(Index).SelStartRow = grdCuentas(Index).Row
                    grdCuentas(Index).SelEndRow = grdCuentas(Index).Row
                End If
        End Select
    End Sub
    Private Sub grdCuentas_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles _grdCuentas_1.DblClick, _grdCuentas_0.DblClick
        Dim Index As Integer = Array.IndexOf(grdCuentas, eventSender)
        Dim j As Integer = 0
        Dim VTRow As Integer = grdCuentas(Index).Row
        grdCuentas(Index).Row = 1
        grdCuentas(Index).Col = 1
        If grdCuentas(Index).CtlText <> "" Then
            grdCuentas(Index).Row = VTRow
            Select Case VLEnte
                Case "C"
                    cmdBoton(0).Enabled = False   'Transmitir
                    PMMarcarRegistro(Index)
                    grdCuentas(Index).Col = 1
                    VGCuenta = grdCuentas(Index).CtlText
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4072")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                    grdCuentas(Index).Col = 10
                    PMPasoValores(sqlconn, "@i_pro_bancario", 0, SQLINT2, grdCuentas(Index).CtlText)
                    grdCuentas(Index).Col = 7
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, grdCuentas(Index).CtlText)
                    grdCuentas(Index).Col = 8
                    PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, grdCuentas(Index).CtlText)
                    PMPasoValores(sqlconn, "@i_cuenta", 0, SQLINT4, VGCuenta)
                    Dim Valores(4) As String
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_personaliza_cuenta", True, FMLoadResString(1550) & "[" & grdCuentas(j).CtlText & "]") Then
                        FMMapeaArreglo(sqlconn, Valores)
                        PMChequea(sqlconn)
                        If Valores(1) <> "" Then
                            FConsultaCta.txtCampo(0).Text = Valores(1)
                            FConsultaCta.txtCampo(0).Enabled = False
                            FConsultaCta.lblDescripcion(0).Text = Valores(2)
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
                    grdCuentas(Index).Col = 7
                    FConsultaCta.lblDescripcion(4).Text = grdCuentas(Index).CtlText
                    grdCuentas(Index).Col = 2
                    FConsultaCta.lblDescripcion(5).Text = grdCuentas(Index).CtlText
                    grdCuentas(Index).Col = 8
                    FConsultaCta.lblDescripcion(1).Text = grdCuentas(Index).CtlText
                    grdCuentas(Index).Col = 6
                    FConsultaCta.txtCampo(2).Text = grdCuentas(Index).CtlText
                    grdCuentas(Index).Col = 9
                    FConsultaCta.lblDescripcion(2).Text = grdCuentas(Index).CtlText
                    If txtCampo(2).Text <> "" Then
                        PMCatalogo("V", "pe_categoria", FConsultaCta.txtCampo(2), FConsultaCta.lblDescripcion(3), Nothing)
                    Else
                        lblDescripcion(3).Text = ""
                    End If
                    VGPersonaliza = False
                    FConsultaCta.ShowPopup(Me)
                    If VGPersonaliza Then
                        cmdBoton_Click(cmdBoton(0), New EventArgs())
                    Else
                        cmdBoton_Click(cmdBoton(3), New EventArgs())
                    End If
                    FConsultaCta.Dispose() '18/05/2016 migracion
                Case Else
                    Select Case Index
                        Case 0, 1
                            If Conversion.Val(Convert.ToString(grdCuentas(Index).Tag)) > 0 Then
                                cmdBoton(0).Enabled = True  'transmitir
                                PMMarcarRegistro(Index)
                            End If
                    End Select
            End Select
            PLTSEstado()
        End If
    End Sub

    Private Sub grdCuentas_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _grdCuentas_0.Enter, _grdCuentas_1.Enter
        Dim Index As Integer = Array.IndexOf(grdCuentas, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1873))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1874))
        End Select
    End Sub

    Private Sub grdCuentas_KeyUpEvent(ByVal eventSender As Object, ByVal eventArgs As COBISCorp.Framework.UI.Components.GridEvents_KeyUpEvent) Handles _grdCuentas_1.KeyUpEvent, _grdCuentas_0.KeyUpEvent
        Dim Index As Integer = Array.IndexOf(grdCuentas, eventSender)
        Select Case Index
            Case 0, 1
                grdCuentas(Index).Col = 0
                grdCuentas(Index).SelStartCol = 1
                grdCuentas(Index).SelEndCol = grdCuentas(Index).Cols - 1
                If grdCuentas(Index).Row = 0 Then
                    grdCuentas(Index).SelStartRow = 1
                    grdCuentas(Index).SelEndRow = 1
                Else
                    grdCuentas(Index).SelStartRow = grdCuentas(Index).Row
                    grdCuentas(Index).SelEndRow = grdCuentas(Index).Row
                End If
        End Select
    End Sub

    Private Sub PMMarcarRegistro(ByRef Index As Integer)
        grdCuentas(Index).Col = 0
        If grdCuentas(Index).CtlText <> "X" Then
            grdCuentas(Index).CtlText = "X"
            grdCuentas(Index).Picture = picVisto(0).Image
        Else
            If grdCuentas(Index).CtlText = "X" Then
                grdCuentas(Index).CtlText = Conversion.Str(grdCuentas(Index).Row)
                grdCuentas(Index).Picture = picVisto(1).Image
            End If
        End If
    End Sub

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.TextChanged, _txtCampo_1.TextChanged, _txtCampo_2.TextChanged, _txtCampo_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 2, 3
                VLPaso = False
            Case 1
                '  If VLEnte = "P" Then
                txtCampo(2).Text = "1"
                lblDescripcion(2).Text = "PROPIETARIO"
                txtCampo(2).Enabled = False
                'txtCampo(0).Enabled = False
                'txtCampo(3).Enabled = False
                lblEtiqueta(2).ForeColor = System.Drawing.Color.Gray
                lblEtiqueta(4).ForeColor = System.Drawing.Color.Gray
                'txtCampo(3).Text = ""
                ''lblDescripcion(3).Text = ""
                'txtCampo(0).Text = ""
                'lblDescripcion(0).Text = ""
                ' PMLimpiaGrid(grdCuentas(0))
                ' PMLimpiaGrid(grdCuentas(1))
                txtCampo(1).Focus()
                VLPaso = False
                '  End If

        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.Enter, _txtCampo_1.Enter, _txtCampo_2.Enter, _txtCampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = True
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1138))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1146))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1686))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1140))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_3.KeyDown, _txtCampo_1.KeyDown, _txtCampo_2.KeyDown, _txtCampo_0.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    Select Case VLEnte
                        Case "E"
                            Dim FBuscarCliente = New COBISCorp.tCOBIS.BClientes.FBuscarClienteClass()
                            Dim FDatoCliente As COBISCorp.tCOBIS.BClientes.BuscarClientes
                            FDatoCliente = New COBISCorp.tCOBIS.BClientes.BuscarClientes()
                            VGProducto = "PERSON"
                            FDatoCliente.FMObtenerProducto(VGProducto, VLEnte)

                            FBuscarCliente.optCliente(0).Enabled = False
                            FBuscarCliente.optCliente(0).Checked = False
                            FBuscarCliente.optCliente(1).Enabled = True
                            FBuscarCliente.optCliente(1).Checked = True
                            FBuscarCliente.optCliente(1).Enabled = VLEnte = "E"
                            FBuscarCliente.ShowPopup(Me)
                            FBuscarCliente.optCliente(0).Enabled = True

                            VGBusqueda = FDatoCliente.PMRetornaCliente()


                        Case "G"
                            If txtCampo(3).Text = "" Then
                                COBISMessageBox.Show(FMLoadResString(1249), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                txtCampo(3).Focus()
                                Exit Sub
                            End If
                            FBuscarLabor.optCriterio(1).Enabled = False
                            FBuscarLabor.optCriterio(2).Enabled = False
                            FBuscarLabor.optCriterio(0).Checked = True
                            FBuscarLabor.txtValor.Text = txtCampo(3).Text
                            FBuscarLabor.txtValor.Enabled = False
                            FBuscarLabor.lblnombre.Text = lblDescripcion(3).Text
                            FBuscarLabor.ShowPopup(Me)
                            FBuscarLabor.optCriterio(1).Enabled = True
                            FBuscarLabor.optCriterio(2).Enabled = True
                            FBuscarLabor.txtValor.Text = ""
                            FBuscarLabor.lblnombre.Text = ""
                            FBuscarLabor.txtValor.Enabled = True
                    End Select
                    If VGBusqueda(0) = "C" Then
                        txtCampo(0).Text = VGBusqueda(1)
                        lblDescripcion(0).Text = VGBusqueda(2)
                        VLPaso = True
                    Else
                        COBISMessageBox.Show(FMLoadResString(1144), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(0).Text = ""
                        txtCampo(0).Focus()
                    End If
                    If Not FBuscarCliente Is Nothing Then
                        FBuscarCliente = Nothing
                    End If

                    '18/05/2016 migracion
                    If VLEnte = "E" Then
                        FBuscarCliente.Dispose()
                    ElseIf VLEnte = "G" Then
                        FBuscarLabor.Dispose()
                    End If

                Case 1
                    Select Case VLEnte
                        Case "P", "C", "D"

                            Dim FBuscarCliente = New COBISCorp.tCOBIS.BClientes.FBuscarClienteClass()
                            Dim FDatoCliente As COBISCorp.tCOBIS.BClientes.BuscarClientes
                            FDatoCliente = New COBISCorp.tCOBIS.BClientes.BuscarClientes()
                            VGProducto = "PERSON"
                            FDatoCliente.FMObtenerProducto(VGProducto, VLEnte)

                            FBuscarCliente.optCliente(1).Enabled = VLEnte = "C"
                            FBuscarCliente.optCliente(0).Checked = True
                            FBuscarCliente.ShowPopup(Me)
                            FBuscarCliente.optCliente(1).Enabled = True
                            VGBusqueda = FDatoCliente.PMRetornaCliente()
                            If VGBusqueda(1) <> "" Then
                                txtCampo(1).Text = VGBusqueda(1)
                                VLClienAct = txtCampo(1).Text
                                lblDescripcion(1).Text = VGBusqueda(2) & " " & VGBusqueda(3) & " " & VGBusqueda(4)
                                VLPaso = True
                                If VLClienAnt <> VLClienAct Then
                                    PMLimpiaGrid(grdCuentas(0))
                                    PMLimpiaGrid(grdCuentas(1))
                                Else
                                    VLClienAnt = txtCampo(1).Text
                                End If
                                VLClienAnt = txtCampo(1).Text
                            End If

                        Case "E", "G"
                            If txtCampo(0).Text = "" Then
                                COBISMessageBox.Show(FMLoadResString(1248), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                txtCampo(0).Focus()
                                Exit Sub
                            End If
                            FBuscarLabor.optCriterio(0).Enabled = False
                            FBuscarLabor.optCriterio(2).Enabled = False
                            FBuscarLabor.optCriterio(1).Checked = True
                            FBuscarLabor.txtValor.Text = txtCampo(0).Text
                            FBuscarLabor.lblnombre.Text = lblDescripcion(0).Text
                            FBuscarLabor.txtValor.Enabled = False
                            FBuscarLabor.ShowPopup(Me)
                            FBuscarLabor.optCriterio(0).Enabled = True
                            FBuscarLabor.optCriterio(2).Enabled = True
                            FBuscarLabor.txtValor.Enabled = True
                            FBuscarLabor.Dispose() '18/05/2016 migracion
                            If VGBusqueda(1) <> "" Then
                                txtCampo(1).Text = VGBusqueda(1)
                                lblDescripcion(1).Text = VGBusqueda(2) & " " & VGBusqueda(3) & " " & VGBusqueda(4)
                                txtCampo(2).Text = VGBusqueda(5)
                                lblDescripcion(2).Text = VGBusqueda(6)
                                VLPaso = True
                            End If
                    End Select

                    '18/05/2016 migracion
                    If VLEnte = "P" Or VLEnte = "C" Or VLEnte = "D" Then
                        FBuscarCliente.Dispose() 'JCA
                        ' FBuscarCliente.Close() 'JCA

                    ElseIf VLEnte = "E" Or VLEnte = "G" Then
                        FBuscarLabor.Dispose()
                    End If
                Case 2
                    PMCatalogo("A", "cl_rol_empresa", txtCampo(2), lblDescripcion(2), FRegistros)
                    VLPaso = True
                Case 3
                    FBuscarGrupo.ShowPopup(Me)
                    If VGBusqueda(1) <> "" Then
                        txtCampo(3).Text = VGBusqueda(1)
                        lblDescripcion(3).Text = VGBusqueda(2)
                        VLPaso = True
                        txtCampo(3).Enabled = False
                    End If
                    FBuscarGrupo.Dispose() '18/05/2016 migracion
            End Select

            If Not FBuscarCliente Is Nothing Then
                FBuscarCliente = Nothing
            End If

        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_3.KeyPress, _txtCampo_1.KeyPress, _txtCampo_2.KeyPress, _txtCampo_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 3
                If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                    KeyAscii = 0
                End If
            Case 2
                KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.Leave, _txtCampo_1.Leave, _txtCampo_2.Leave, _txtCampo_0.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTArreglo() As String
        Select Case Index
            Case 0
                If Not VLPaso Then
                    If txtCampo(0).Text <> "" Then
                        If CDbl(txtCampo(0).Text) > 2147483647 Then
                            COBISMessageBox.Show(FMLoadResString(1944), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(0).Text = ""
                            txtCampo(0).Focus()
                            Exit Sub
                        End If
                        ReDim VTArreglo(7)
                        Select Case VLEnte
                            Case "E"
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1190")
                                PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, txtCampo(0).Text)
                                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_qrente", True, FMLoadResString(1934)) Then
                                    FMMapeaArreglo(sqlconn, VTArreglo)
                                    PMChequea(sqlconn)
                                    If VTArreglo(2) = "C" Then
                                        lblDescripcion(0).Text = VTArreglo(1)
                                        txtCampo(0).Enabled = False
                                    Else
                                        COBISMessageBox.Show(FMLoadResString(1144), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                        txtCampo(0).Text = ""
                                        txtCampo(0).Focus()
                                    End If
                                Else
                                    PMChequea(sqlconn)
                                    lblDescripcion(0).Text = ""
                                    txtCampo(0).Text = ""
                                    txtCampo(0).Focus()
                                End If
                            Case "G"
                                If txtCampo(3).Text = "" Then
                                    COBISMessageBox.Show(FMLoadResString(1249), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                    txtCampo(0).Text = ""
                                    txtCampo(3).Focus()
                                    Exit Sub
                                End If
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1253")
                                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "EXG")
                                PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, txtCampo(0).Text)
                                PMPasoValores(sqlconn, "@i_grupo", 0, SQLINT4, txtCampo(3).Text)
                                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_laboral", True, FMLoadResString(1934)) Then
                                    PMMapeaObjeto(sqlconn, lblDescripcion(0))
                                    PMChequea(sqlconn)
                                    txtCampo(0).Enabled = False
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(0).Text = ""
                                    txtCampo(0).Focus()
                                End If
                        End Select
                    Else
                        lblDescripcion(0).Text = ""
                    End If
                End If
            Case 1
                VLClienAct = txtCampo(1).Text
                If Not VLPaso Then
                    If txtCampo(1).Text <> "" Then
                        If CDbl(txtCampo(1).Text) > 2147483647 Then
                            COBISMessageBox.Show(FMLoadResString(1944), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(1).Text = ""
                            txtCampo(1).Focus()
                            Exit Sub
                        End If
                        ReDim VTArreglo(7)
                        Select Case VLEnte
                            Case "C", "D", "P"
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1190")
                                PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, txtCampo(1).Text)
                                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_qrente", False, FMLoadResString(1933)) Then
                                    FMMapeaArreglo(sqlconn, VTArreglo)
                                    PMChequea(sqlconn)
                                    If VTArreglo(2) = "P" Then
                                        lblDescripcion(1).Text = VTArreglo(1)
                                    Else
                                        If VLEnte <> "C" Then
                                            COBISMessageBox.Show(FMLoadResString(1145), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                            txtCampo(1).Text = ""
                                            txtCampo(1).Focus()
                                        Else
                                            lblDescripcion(1).Text = VTArreglo(1)
                                        End If
                                    End If
                                    If VLClienAnt <> VLClienAct Then
                                        PMLimpiaGrid(grdCuentas(0))
                                        PMLimpiaGrid(grdCuentas(1))
                                    Else
                                        VLClienAnt = txtCampo(1).Text
                                    End If
                                    VLClienAnt = txtCampo(1).Text
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(1).Text = ""
                                    lblDescripcion(1).Text = ""
                                    txtCampo(1).Focus()
                                    PMLimpiaGrid(grdCuentas(0))
                                    PMLimpiaGrid(grdCuentas(1))
                                End If
                            Case "E", "G"
                                If txtCampo(0).Text = "" Then
                                    COBISMessageBox.Show(FMLoadResString(1248), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                    txtCampo(0).Text = ""
                                    txtCampo(1).Text = ""
                                    txtCampo(0).Focus()
                                    Exit Sub
                                End If
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1255")
                                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "PXE")
                                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT4, txtCampo(0).Text)
                                PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, txtCampo(1).Text)
                                Dim VTValores(5) As String
                                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_laboral", False, FMLoadResString(1934)) Then
                                    FMMapeaArreglo(sqlconn, VTValores)
                                    PMChequea(sqlconn)
                                    If VTValores(1) <> "" Then
                                        lblDescripcion(1).Text = VTValores(1)
                                        txtCampo(2).Text = VTValores(2)
                                        lblDescripcion(2).Text = VTValores(3)
                                        txtCampo(1).Enabled = False
                                    Else
                                        COBISMessageBox.Show(FMLoadResString(1145), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                        txtCampo(1).Text = ""
                                        txtCampo(1).Focus()
                                    End If
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(1).Text = ""
                                    lblDescripcion(1).Text = ""
                                End If
                        End Select
                    Else
                        If VLEnte = "E" Or VLEnte = "G" Then
                            txtCampo(2).Text = ""
                            lblDescripcion(2).Text = ""
                        End If
                        lblDescripcion(1).Text = ""
                    End If
                End If
            Case 2
                If Not VLPaso Then
                    If txtCampo(2).Text <> "" Then
                        PMCatalogo("V", "cl_rol_empresa", txtCampo(2), lblDescripcion(2), Nothing)
                    Else
                        txtCampo(2).Text = ""
                        lblDescripcion(2).Text = ""
                    End If
                End If
            Case 3
                If Not VLPaso Then
                    If txtCampo(3).Text <> "" Then
                        If CDbl(txtCampo(3).Text) > 2147483647 Then
                            COBISMessageBox.Show(FMLoadResString(1944), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(3).Text = ""
                            txtCampo(3).Focus()
                            Exit Sub
                        End If
                        ReDim VTArreglo(7)
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1184")
                        PMPasoValores(sqlconn, "@i_grupo", 0, SQLINT4, txtCampo(3).Text)
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_grupo", False, FMLoadResString(1935)) Then
                            FMMapeaArreglo(sqlconn, VTArreglo)
                            PMChequea(sqlconn)
                            lblDescripcion(3).Text = VTArreglo(2)
                            txtCampo(3).Enabled = False
                        Else
                            PMChequea(sqlconn)
                            txtCampo(3).Text = ""
                            lblDescripcion(3).Text = ""
                            txtCampo(3).Focus()
                        End If
                    Else
                        lblDescripcion(3).Text = ""
                    End If
                End If
        End Select
    End Sub

    Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_3.MouseDown, _txtCampo_1.MouseDown, _txtCampo_2.MouseDown, _txtCampo_0.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3
                My.Computer.Clipboard.Clear()
        End Select
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_3.Enabled
        TSBBuscar.Visible = _cmdBoton_3.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
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
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

    Private Sub grdCuentas_Leave(eventSender As Object, eventArgs As EventArgs) Handles _grdCuentas_0.Leave, _grdCuentas_1.Leave
        Dim Index As Integer = Array.IndexOf(grdCuentas, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        End Select
    End Sub

End Class


