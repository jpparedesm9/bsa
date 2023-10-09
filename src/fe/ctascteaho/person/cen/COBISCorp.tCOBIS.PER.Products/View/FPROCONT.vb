Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Globalization
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
Imports COBISCorp.tCOBIS.PER.Cost
 Public  Partial  Class FProContClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Dim VLPaso As Integer = 0

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_5.Click, _cmdBoton_2.Click, _cmdBoton_4.Click, _cmdBoton_3.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Const MB_YESNO As Integer = 4
        Const MB_ICONQUESTION As Integer = 32
        Const MB_DEBUTTON1 As Integer = 0
        Const IDYES As Integer = 6
        Dim Response As String = String.Empty
        Dim VTCuota As String = String.Empty
        Dim VTPlazo As String = String.Empty
        Dim VTPlan As String = String.Empty
        Dim VTEstado As String = String.Empty
        Dim DgDef As COBISMsgBox.COBISButtons = MB_YESNO + MB_ICONQUESTION + MB_DEBUTTON1
        TSBotones.Focus()
        Select Case Index
            Case 0
                If txtCampo(0).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(1).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(1269), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4123")
                PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT2, VGFormatoFechaInt)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_producto_contractual", True, FMLoadResString(1555)) Then
                    PMMapeaGrid(sqlconn, grdProdContractual, False)
                    PMMapeaTextoGrid(grdProdContractual)
                    PMAnchoColumnasGrid(grdProdContractual)
                    PMAgregarDecimal(grdProdContractual, 14) 'Columna 14 - PUNTOS ADICIONALES - Se da formato para que presente 2 decimales
                    PMChequea(sqlconn)
                    grdProdContractual.ColWidth(1) = 1000
                    grdProdContractual.ColWidth(2) = 5750
                    grdProdContractual.ColWidth(3) = 1000
                    mskCosto(0).Text = "0.00"
                    mskCosto(1).Text = "0.00"
                    PLModoInsertar(True)
                    PLLimpiar("=", 3)
                    PLLimpiar("=", 4)
                    PLLimpiar("=", 5)
                    PLLimpiar("=", 6)
                Else
                    PMLimpiaGrid(grdProdContractual)
                    PMChequea(sqlconn)
                End If
                txtCampo(0).Focus()
            Case 1
                If txtCampo(0).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(1).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(1269), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If Not (txtCampo(2).Text <> "") Then
                    COBISMessageBox.Show(FMLoadResString(1250), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                If Not (txtCampo(4).Text > "000") Then
                    COBISMessageBox.Show(FMLoadResString(1282), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(4).Focus()
                    Exit Sub
                End If
                If Math.Floor(CDbl(txtCampo(4).Text)) > StringsHelper.ToDoubleSafe("250") Then
                    COBISMessageBox.Show(FMLoadResString(1283), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(4).Focus()
                    Exit Sub
                End If
                If Not (mskCosto(0).Text > "0.00") Then
                    COBISMessageBox.Show(FMLoadResString(1232), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCosto(0).Focus()
                    Exit Sub
                End If
                If Not (txtCampo(3).Text <> "") Then
                    COBISMessageBox.Show(FMLoadResString(1433), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                If Not (mskCosto(2).Text >= "0.00") Then
                    COBISMessageBox.Show(FMLoadResString(1236), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCosto(2).Focus()
                    Exit Sub
                End If
                If optCuota(0).Checked Then
                    VTCuota = "S"
                ElseIf optCuota(1).Checked Then
                    VTCuota = "N"
                End If
                If optPlazo(0).Checked Then
                    VTPlazo = "S"
                ElseIf optPlazo(1).Checked Then
                    VTPlazo = "N"
                End If
                If optContrac(0).Checked Then
                    VTPlan = "S"
                ElseIf optContrac(1).Checked Then
                    VTPlan = "N"
                End If
                If optEstado(0).Checked Then
                    VTEstado = "V"
                ElseIf optEstado(1).Checked Then
                    VTEstado = "C"
                End If
                mskCosto_Leave(mskCosto(0), New EventArgs())
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4125")
                PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "I")
                PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_plazo", 0, SQLINT2, txtCampo(4).Text)
                PMPasoValores(sqlconn, "@i_cuota", 0, SQLMONEY, mskCosto(0).Text)
                PMPasoValores(sqlconn, "@i_monto_final", 0, SQLMONEY, mskCosto(1).Text)
                PMPasoValores(sqlconn, "@i_periodicidad", 0, SQLCHAR, txtCampo(3).Text)
                PMPasoValores(sqlconn, "@i_ptos_premio", 0, SQLFLT8, mskCosto(2).Text)
                PMPasoValores(sqlconn, "@i_plazo_neg", 0, SQLCHAR, VTPlazo)
                PMPasoValores(sqlconn, "@i_cuota_neg", 0, SQLCHAR, VTCuota)
                PMPasoValores(sqlconn, "@i_plan_pago", 0, SQLCHAR, VTPlan)
                PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, VTEstado)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_producto_contractual", True, FMLoadResString(1575)) Then
                    PMChequea(sqlconn)
                    cmdBoton_Click(cmdBoton(0), New EventArgs())
                Else
                    PMChequea(sqlconn)
                End If
                txtCampo(0).Focus()
            Case 2
                Response = CStr(COBISMsgBox.MsgBox(FMLoadResString(1861), DgDef, FMLoadResString(1867)))
                If StringsHelper.ToDoubleSafe(Response) = IDYES Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4126")
                    PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "D")
                    PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
                    PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_producto_contractual", True, FMLoadResString(1584)) Then
                        PMChequea(sqlconn)
                        cmdBoton_Click(cmdBoton(0), New EventArgs())
                    Else
                        PMChequea(sqlconn)
                    End If
                Else
                    Exit Sub
                End If
            Case 3
                PLLimpiar(">", 0)
                PLModoInsertar(True)
                mskCosto(2).Text = "0.00"
                txtCampo(0).Focus()
            Case 4
                Me.Close()
            Case 5
                If txtCampo(0).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(1).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(1269), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If Not (txtCampo(2).Text <> "") Then
                    COBISMessageBox.Show(FMLoadResString(1250), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                If Not (txtCampo(4).Text > "000") Then
                    COBISMessageBox.Show(FMLoadResString(1282), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(4).Focus()
                    Exit Sub
                End If
                If Math.Floor(CDbl(txtCampo(4).Text)) > StringsHelper.ToDoubleSafe("250") Then
                    COBISMessageBox.Show(FMLoadResString(1283), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(4).Focus()
                    Exit Sub
                End If
                If Not (mskCosto(0).Text > "0.00") Then
                    COBISMessageBox.Show(FMLoadResString(1232), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCosto(0).Focus()
                    Exit Sub
                End If
                If Not (txtCampo(3).Text <> "") Then
                    COBISMessageBox.Show(FMLoadResString(1433), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                If Not (mskCosto(2).Text >= "0.00") Then
                    COBISMessageBox.Show(FMLoadResString(1236), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCosto(2).Focus()
                    Exit Sub
                End If
                If optCuota(0).Checked Then
                    VTCuota = "S"
                ElseIf optCuota(1).Checked Then
                    VTCuota = "N"
                End If
                If optPlazo(0).Checked Then
                    VTPlazo = "S"
                ElseIf optPlazo(1).Checked Then
                    VTPlazo = "N"
                End If
                If optContrac(0).Checked Then
                    VTPlan = "S"
                ElseIf optContrac(1).Checked Then
                    VTPlan = "N"
                End If
                If optEstado(0).Checked Then
                    VTEstado = "V"
                ElseIf optEstado(1).Checked Then
                    VTEstado = "C"
                End If
                If VTEstado = "C" Then
                    Response = CStr(COBISMsgBox.MsgBox(FMLoadResString(1855), DgDef, FMLoadResString(1474)))
                    If StringsHelper.ToDoubleSafe(Response) = IDYES Then
                        COBISMessageBox.Show(FMLoadResString(1699), FMLoadResString(1474), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                    Else
                        COBISMessageBox.Show(FMLoadResString(1701), FMLoadResString(1474), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                        optEstado(0).Checked = True
                        Exit Sub
                    End If
                End If
                mskCosto_Leave(mskCosto(0), New EventArgs())
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4124")
                PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "U")
                PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_plazo", 0, SQLINT2, txtCampo(4).Text)
                PMPasoValores(sqlconn, "@i_cuota", 0, SQLMONEY, mskCosto(0).Text)
                PMPasoValores(sqlconn, "@i_monto_final", 0, SQLMONEY, mskCosto(1).Text)
                PMPasoValores(sqlconn, "@i_periodicidad", 0, SQLCHAR, txtCampo(3).Text)
                PMPasoValores(sqlconn, "@i_ptos_premio", 0, SQLFLT8, mskCosto(2).Text)
                PMPasoValores(sqlconn, "@i_plazo_neg", 0, SQLCHAR, VTPlazo)
                PMPasoValores(sqlconn, "@i_cuota_neg", 0, SQLCHAR, VTCuota)
                PMPasoValores(sqlconn, "@i_plan_pago", 0, SQLCHAR, VTPlan)
                PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, VTEstado)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_producto_contractual", True, FMLoadResString(1543)) Then
                    PMChequea(sqlconn)
                    cmdBoton_Click(cmdBoton(0), New EventArgs())
                Else
                    PMChequea(sqlconn)
                End If
                txtCampo(0).Focus()
        End Select
    End Sub

    Private Sub FProCont_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLModoInsertar(True)
        PMBotonSeguridad(Me, 5)
        PMObjetoSeguridad(cmdBoton(0))
        PMObjetoSeguridad(cmdBoton(5))
        PMObjetoSeguridad(cmdBoton(1))
        cmdBoton(2).Enabled = False
        cmdBoton(2).Visible = False
        cmdBoton(5).Enabled = False
        PLTSEstado()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1151))

        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "pe_periodicidad")
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
        PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCampo(3).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502060)) Then
            PMMapeaObjeto(sqlconn, lblDescripcion(3))
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub FProCont_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdProdContractual_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdProdContractual.ClickEvent
        grdProdContractual.Col = 0
        grdProdContractual.SelStartCol = 1
        grdProdContractual.SelEndCol = grdProdContractual.Cols - 1
        If grdProdContractual.Row = 0 Then
            grdProdContractual.SelStartRow = 1
            grdProdContractual.SelEndRow = 1
        Else
            grdProdContractual.SelStartRow = grdProdContractual.Row
            grdProdContractual.SelEndRow = grdProdContractual.Row
        End If
    End Sub

    Private Sub grdProdContractual_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdProdContractual.DblClick
        Dim VTRow As Integer = grdProdContractual.Row
        grdProdContractual.Row = 1
        grdProdContractual.Col = 1
        If grdProdContractual.CtlText.Trim() <> "" Then
            grdProdContractual.Row = VTRow
            PMMarcarRegistro()
            PLModoInsertar(False)
        End If
    End Sub

    Private Sub grdProdContractual_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdProdContractual.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1391))
    End Sub

    Private Sub mskCosto_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskCosto_0.Enter, _mskCosto_1.Enter, _mskCosto_2.Enter
        Dim Index As Integer = Array.IndexOf(mskCosto, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1822))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1695))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1677))
        End Select
        mskCosto(Index).SelStart = 0
        mskCosto(Index).SelLength = Strings.Len(mskCosto(Index).Text)
    End Sub

    Private Sub mskCosto_KeyPressEvent(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _mskCosto_0.KeyPress, _mskCosto_1.KeyPress, _mskCosto_2.KeyPress
        Dim Index As Integer = Array.IndexOf(mskCosto, eventSender)
        Select Case Index
            Case 0, 1, 2
                If (Asc(eventArgs.KeyChar) < 48 Or Asc(eventArgs.KeyChar) > 57) And (Asc(eventArgs.KeyChar) <> 8) And (Asc(eventArgs.KeyChar) <> 46) Then
                    eventArgs.KeyChar = Chr(0)
                End If
                eventArgs.KeyChar = ChrW(FMValidarNumero(mskCosto(Index).Text, 16, Asc(eventArgs.KeyChar), "105"))
        End Select
    End Sub

    Private Sub mskCosto_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskCosto_0.Leave, _mskCosto_1.Leave, _mskCosto_2.Leave
        Dim Index As Integer = Array.IndexOf(mskCosto, eventSender)
        Select Case Index
            Case 0
                If mskCosto(0).Text <> "0.00" Then
                    Dim dbNumericTemp As Double = 0
                    If Not Double.TryParse(mskCosto(0).Text, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp) Then
                        mskCosto(0).Text = "0.00"
                        mskCosto(0).Focus()
                        Exit Sub
                    End If
                Else
                    mskCosto(1).Text = "0.00"
                End If
                If mskCosto(0).Text > "0.00" And txtCampo(4).Text > "0" Then
                    If Not ((CDbl(mskCosto(0).Text) * CDbl(txtCampo(4).Text)) > StringsHelper.ToDoubleSafe("9999999999")) Then
                        mskCosto(1).Text = (CDbl(mskCosto(0).Text) * CDbl(txtCampo(4).Text))
                    Else
                        COBISMessageBox.Show(FMLoadResString(1823), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        mskCosto(0).Text = "0.00"
                        mskCosto(0).Focus()
                    End If
                End If
            Case 1
                If mskCosto(1).Text <> "" Then
                    Dim dbNumericTemp2 As Double = 0
                    If Not Double.TryParse(mskCosto(0).Text, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp2) Then
                        mskCosto(1).Text = ""
                        mskCosto(1).Focus()
                        Exit Sub
                    End If
                    If mskCosto(0).Text <> "0.00" Then
                        If Conversion.Val(mskCosto(1).Text.ToString()) < Conversion.Val(mskCosto(0).Text.ToString()) Then
                            COBISMessageBox.Show(FMLoadResString(1300), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            mskCosto(1).Text = ""
                            mskCosto(1).Focus()
                            Exit Sub
                        End If
                    End If
                End If
            Case 2
                If mskCosto(0).Text <> "0.00" And txtCampo(4).Text > "0" Then
                    mskCosto(1).Text = (CDbl(mskCosto(0).Text) * CDbl(txtCampo(4).Text))
                End If
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub PLLimpiar(ByRef tipo As String, ByRef Numero As Integer)
        Select Case tipo
            Case "="
                If Numero <= 7 Then
                    If Numero <> StringsHelper.ToDoubleSafe("4") Then
                        txtCampo(Numero - 1).Text = ""
                    End If
                    If Numero - 1 < 3 Then
                        lblDescripcion(Numero - 1).Text = ""
                    End If
                    If Numero = 2 Then
                        optPlazo(1).Enabled = True
                        optPlazo(0).Enabled = True
                        optPlazo(0).Checked = True
                        optCuota(1).Enabled = True
                        optCuota(0).Enabled = True
                        optCuota(0).Checked = True
                        optContrac(1).Enabled = True
                        optContrac(0).Enabled = True
                        optContrac(0).Checked = True
                        optEstado(1).Enabled = True
                        optEstado(0).Enabled = True
                        optEstado(0).Checked = True
                        mskCosto(0).Text = "0.00"
                        mskCosto(1).Text = "0.00"
                        PMLimpiaGrid(grdProdContractual)
                    End If
                ElseIf Numero = 8 Then
                    PMLimpiaGrid(grdProdContractual)
                End If
            Case ">"
                For i As Integer = Numero To 5
                    PLLimpiar("=", i + 1)
                Next i
            Case "<"
                For i As Integer = Numero To 2 Step -1
                    PLLimpiar("=", i - 1)
                Next i
        End Select
    End Sub

    Private Sub PLModoInsertar(ByRef Modo As Integer)
        txtCampo(0).Enabled = Modo
        txtCampo(1).Enabled = Modo
        txtCampo(2).Enabled = Modo
        If Modo Then
            PMObjetoSeguridad(cmdBoton(1))
            cmdBoton(5).Enabled = Not Modo
        Else
            cmdBoton(1).Enabled = Modo
            PMObjetoSeguridad(cmdBoton(5))
        End If
        PLTSEstado()
    End Sub

    Private Sub PMMarcarRegistro()
        grdProdContractual.Col = 1
        txtCampo(1).Text = grdProdContractual.CtlText
        grdProdContractual.Col = 2
        lblDescripcion(1).Text = grdProdContractual.CtlText
        grdProdContractual.Col = 3
        txtCampo(2).Text = grdProdContractual.CtlText
        grdProdContractual.Col = 4
        lblDescripcion(2).Text = grdProdContractual.CtlText
        grdProdContractual.Col = 5
        txtCampo(4).Text = grdProdContractual.CtlText
        grdProdContractual.Col = 6
        If grdProdContractual.CtlText = "S" Then
            optPlazo(0).Checked = True
        Else
            optPlazo(1).Checked = True
        End If
        grdProdContractual.Col = 7
        mskCosto(0).Text = grdProdContractual.CtlText
        grdProdContractual.Col = 8
        If grdProdContractual.CtlText = "S" Then
            optCuota(0).Checked = True
        Else
            optCuota(1).Checked = True
        End If
        grdProdContractual.Col = 9
        txtCampo(3).Text = grdProdContractual.CtlText
        grdProdContractual.Col = 10
        lblDescripcion(3).Text = grdProdContractual.CtlText
        grdProdContractual.Col = 11
        mskCosto(1).Text = grdProdContractual.CtlText
        grdProdContractual.Col = 12
        If grdProdContractual.CtlText = "V" Then
            optEstado(0).Checked = True
        Else
            optEstado(1).Checked = True
        End If
        grdProdContractual.Col = 14
        mskCosto(2).Text = grdProdContractual.CtlText
        grdProdContractual.Col = 17
        txtCampo(0).Text = grdProdContractual.CtlText
        grdProdContractual.Col = 18
        If grdProdContractual.CtlText = "S" Then
            optContrac(0).Checked = True
        Else
            optContrac(1).Checked = True
        End If
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.TextChanged, _txtCampo_7.TextChanged, _txtCampo_6.TextChanged, _txtCampo_2.TextChanged, _txtCampo_1.TextChanged, _txtCampo_0.TextChanged, _txtCampo_4.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3, 4, 6, 7, 8, 9
                VLPaso = False
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.Enter, _txtCampo_7.Enter, _txtCampo_6.Enter, _txtCampo_2.Enter, _txtCampo_1.Enter, _txtCampo_0.Enter, _txtCampo_4.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1151))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1163))
                txtCampo(2).Text = ""
                lblDescripcion(2).Text = ""
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1153))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1626))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1637))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_3.KeyDown, _txtCampo_7.KeyDown, _txtCampo_6.KeyDown, _txtCampo_2.KeyDown, _txtCampo_1.KeyDown, _txtCampo_0.KeyDown, _txtCampo_4.KeyDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTFilas As Integer = 0
        Dim VTProFinal As String = ""
        If eventArgs.KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    PLLimpiar("=", 2)
                    VGOperacion = "sp_hp_sucursal"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4079")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", True, FMLoadResString(1913)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMAnchoColumnasGrid(FRegistros.grdRegistros)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        VLPaso = True
                        FRegistros.ShowPopup(Me)
                        If VGValores(1) <> "" Then
                            txtCampo(0).Text = VGValores(1)
                            lblDescripcion(0).Text = VGValores(2)
                            VLPaso = True
                        Else
                            VGOperacion = ""
                            PLLimpiar("=", 1)
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                        PLLimpiar("=", 1)
                        VGOperacion = ""
                    End If
                Case 1
                    If txtCampo(0).Text.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        PLLimpiar("<", 3)
                        VLPaso = True
                        txtCampo(0).Focus()
                        Exit Sub
                    End If
                    VTFilas = VGMaxRows
                    VTProFinal = "0"
                    VGOperacion = "sp_prodfin3"
                    While VTFilas = VGMaxRows
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4011")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text)
                        PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, VTProFinal)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1556)) Then
                            If VTProFinal = "0" Then
                                PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                            Else
                                PMMapeaGrid(sqlconn, FRegistros.grdRegistros, True)
                            End If
                            PMMapeaTextoGrid(FRegistros.grdRegistros)
                            PMAnchoColumnasGrid(FRegistros.grdRegistros)
                            PMChequea(sqlconn)
                            VTFilas = Conversion.Val(Convert.ToString(FRegistros.grdRegistros.Tag))
                            FRegistros.grdRegistros.Col = 1
                            FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                            VTProFinal = FRegistros.grdRegistros.CtlText
                        Else
                            PMChequea(sqlconn)
                            txtCampo(1).Text = ""
                            lblDescripcion(1).Text = ""
                            VGOperacion = ""
                        End If
                    End While
                    FRegistros.grdRegistros.Row = 1
                    FRegistros.ShowPopup(Me)
                    If VGValores(1) <> "" Then
                        txtCampo(1).Text = VGValores(1)
                        lblDescripcion(1).Text = VGValores(2)
                        PMBusca_Datos()
                        VLPaso = True
                    Else
                        txtCampo(1).Text = ""
                        lblDescripcion(1).Text = ""
                        VGOperacion = ""
                    End If
                    FRegistros.Dispose() '18/05/2016 migracion
                Case 2
                    If txtCampo(6).Text <> "" Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4101")
                        PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "H")
                        PMPasoValores(sqlconn, "@i_cons_profinal", 0, SQLCHAR, "N")
                        PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT1, txtCampo(1).Text)
                        PMPasoValores(sqlconn, "@i_pro_bancario", 0, SQLINT2, txtCampo(7).Text)
                        PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, txtCampo(6).Text)
                        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGMoneda)
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_categoria_profinal", True, FMLoadResString(1545)) Then
                            PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                            PMChequea(sqlconn)
                            FCatalogo.ShowPopup(Me)
                            txtCampo(2).Text = VGACatalogo.Codigo
                            lblDescripcion(2).Text = VGACatalogo.Descripcion
                            If txtCampo(2).Text.Trim() <> "" Then
                                VLPaso = True
                            End If
                            FCatalogo.Dispose() '18/05/2016 migracion
                        Else
                            PMChequea(sqlconn)
                        End If
                    End If
                Case 3
                    PMCatalogo("A", "pe_periodicidad", txtCampo(3), lblDescripcion(3), FRegistros)
                    VLPaso = True
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_3.KeyPress, _txtCampo_7.KeyPress, _txtCampo_6.KeyPress, _txtCampo_2.KeyPress, _txtCampo_1.KeyPress, _txtCampo_0.KeyPress, _txtCampo_4.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 4
                KeyAscii = FMValidaTipoDato("N", KeyAscii)
            Case 2, 3
                KeyAscii = FMValidaTipoDato("A", KeyAscii)
            Case 7
                If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or KeyAscii > 57) And (KeyAscii <> 46) Then
                    KeyAscii = 0
                End If
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.Leave, _txtCampo_7.Leave, _txtCampo_6.Leave, _txtCampo_2.Leave, _txtCampo_1.Leave, _txtCampo_0.Leave, _txtCampo_4.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Not VLPaso Then
            Select Case Index
                Case 0
                    txtCampo(1).Text = ""
                    lblDescripcion(1).Text = ""
                    If txtCampo(0).Text.Trim() = "" Then
                        lblDescripcion(0).Text = ""
                        Exit Sub
                    End If
                    If CDbl(txtCampo(0).Text) >= 32000 Then
                        COBISMessageBox.Show(FMLoadResString(1418), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(0).Focus()
                        Exit Sub
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4078")
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(0).Text)
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", True, FMLoadResString(1913)) Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(0))
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        PLLimpiar("=", 1)
                        txtCampo(0).Focus()
                        VLPaso = True
                    End If
                Case 1
                    If txtCampo(1).Text.Trim() = "" Then
                        PLLimpiar("=", 2)
                        Exit Sub
                    End If
                    If txtCampo(0).Text.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        PLLimpiar("<", 3)
                        txtCampo(0).Focus()
                        Exit Sub
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4077")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text)
                    PMPasoValores(sqlconn, "@i_pro_final", 0, SQLINT2, txtCampo(1).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prodfin", True, FMLoadResString(1556)) Then
                        Dim VTArreglo(3) As String
                        FMMapeaArreglo(sqlconn, VTArreglo)
                        PMChequea(sqlconn)
                        lblDescripcion(1).Text = VTArreglo(1)
                        PMBusca_Datos()
                    Else
                        PMChequea(sqlconn)
                        PLLimpiar("=", 2)
                        txtCampo(1).Focus()
                        VLPaso = True
                    End If
                Case 2
                    If txtCampo(2).Text.Trim() = "" Then
                        lblDescripcion(2).Text = ""
                        Exit Sub
                    End If
                    If Not VLPaso Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4101")
                        PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_cons_profinal", 0, SQLCHAR, "N")
                        PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT1, txtCampo(1).Text)
                        PMPasoValores(sqlconn, "@i_pro_bancario", 0, SQLINT2, txtCampo(7).Text)
                        PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, txtCampo(6).Text)
                        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGMoneda)
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                        PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_categoria_profinal", True, FMLoadResString(1545)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(2))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(2).Text = ""
                            lblDescripcion(2).Text = ""
                            If txtCampo(2).Enabled Then txtCampo(2).Focus()
                        End If
                        VLPaso = True
                    End If
                Case 3
                    If Not VLPaso Then
                        If txtCampo(3).Text <> "" Then
                            PMCatalogo("V", "pe_periodicidad", txtCampo(3), lblDescripcion(3), Nothing)
                            If lblDescripcion(3).Text = String.Empty Then
                                lblDescripcion(3).Text = String.Empty
                                txtCampo(3).Clear()
                                txtCampo(3).Focus()
                            End If
                            VLPaso = True
                        Else
                            lblDescripcion(3).Text = String.Empty
                            'txtCampo(3).Clear()
                        End If
                    End If
                Case 4
                    If IsNumeric(txtCampo(4).Text) Then
                        If Not ((CDbl(mskCosto(0).Text) * CDbl(txtCampo(4).Text)) > StringsHelper.ToDoubleSafe("9999999999")) Then
                            mskCosto(1).Text = (CDbl(mskCosto(0).Text) * CDbl(txtCampo(4).Text))
                            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(FMLoadResString(1107))
                        Else
                            COBISMessageBox.Show(FMLoadResString(1823), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(4).Focus()
                        End If
                    Else
                        mskCosto(1).Text = "0.00"
                    End If
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(String.Empty)
            End Select
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)

        End Sub
    Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_3.MouseDown, _txtCampo_7.MouseDown, _txtCampo_6.MouseDown, _txtCampo_2.MouseDown, _txtCampo_1.MouseDown, _txtCampo_0.MouseDown, _txtCampo_4.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2
                My.Computer.Clipboard.Clear()
        End Select
    End Sub

    Function FMValidaTipoDato(ByRef TipoDato As String, ByRef valor As Integer) As Integer
        Dim result As Integer = 0
        result = valor
        Select Case TipoDato
            Case "N"
                If (valor <> 8) And ((valor < 48) Or (valor > 57)) Then
                    result = 0
                End If
            Case "A"
                If (valor <> 8) And ((valor < 65) Or (valor > 90)) And (valor <> 241) And (valor <> 209) And ((valor < 97) Or (valor > 122)) And (valor <> 32) Then
                    result = 0
                Else
                    result = Strings.AscW(Strings.Chr(valor).ToString().ToUpper())
                End If
            Case "S"
                If valor = 32 Then
                    result = 0
                Else
                    result = Strings.AscW(Strings.Chr(valor).ToString().ToUpper())
                End If
            Case "B"
                result = Strings.AscW(Strings.Chr(valor).ToString().ToUpper())
            Case "M"
                If (valor <> 8) And (valor <> 46) And ((valor < 48) Or (valor > 57)) Then
                    result = 0
                End If
            Case "U"
                If (valor <> 8) And (valor <> 32) And (valor <> 241) And ((valor < 48) Or (valor > 57)) And ((valor < 96) Or (valor > 123)) And ((valor < 65) Or (valor > 90)) And (valor <> 209) Then
                    result = 0
                Else
                    result = Strings.AscW(Strings.Chr(valor).ToString().ToUpper())
                End If
        End Select
        Return result
    End Function

    Private Sub PMBusca_Datos()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4123")
        PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "H")
        PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_producto_contractual", False, FMLoadResString(1545)) Then
            PMMapeaObjetoAB(sqlconn, txtCampo(6), txtCampo(7))
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
    End Sub


    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBCrear.Enabled = _cmdBoton_1.Enabled
        TSBCrear.Visible = _cmdBoton_1.Visible
        TSBActualizar2.Enabled = _cmdBoton_2.Enabled
        TSBActualizar2.Visible = _cmdBoton_2.Visible
        TSBActualizar.Enabled = _cmdBoton_5.Enabled
        TSBActualizar.Visible = _cmdBoton_5.Visible
        TSBLimpiar.Enabled = _cmdBoton_3.Enabled
        TSBLimpiar.Visible = _cmdBoton_3.Visible
        TSBSalir.Enabled = _cmdBoton_4.Enabled
        TSBSalir.Visible = _cmdBoton_4.Visible
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBActualizar2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar2.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

    Private Sub optContrac_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optContrac_0.Enter, _optContrac_1.Enter
        Dim Index As Integer = Array.IndexOf(optContrac, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502070))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502072))
        End Select
    End Sub

    Private Sub optContrac_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optContrac_0.Leave, _optContrac_1.Leave
        Dim Index As Integer = Array.IndexOf(optContrac, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        End Select
    End Sub

    Private Sub optCuota_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optCuota_0.Enter, _optCuota_1.Enter
        Dim Index As Integer = Array.IndexOf(optCuota, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502066))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502068))
        End Select
    End Sub

    Private Sub optCuota_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optCuota_0.Leave, _optCuota_1.Leave
        Dim Index As Integer = Array.IndexOf(optCuota, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        End Select
    End Sub

    Private Sub optPlazo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optPlazo_0.Enter, _optPlazo_1.Enter
        Dim Index As Integer = Array.IndexOf(optPlazo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502062))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502064))
        End Select
    End Sub

    Private Sub optPlazo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optPlazo_0.Leave, _optPlazo_1.Leave
        Dim Index As Integer = Array.IndexOf(optPlazo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        End Select
    End Sub

    Private Sub optEstado_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optEstado_0.Enter, _optEstado_1.Enter
        Dim Index As Integer = Array.IndexOf(optEstado, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502074))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502076))
        End Select
    End Sub

    Private Sub optEstado_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optEstado_0.Leave, _optEstado_1.Leave
        Dim Index As Integer = Array.IndexOf(optEstado, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        End Select
    End Sub

    Private Sub grdProdContractual_Leave(sender As Object, e As EventArgs) Handles grdProdContractual.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub


End Class


