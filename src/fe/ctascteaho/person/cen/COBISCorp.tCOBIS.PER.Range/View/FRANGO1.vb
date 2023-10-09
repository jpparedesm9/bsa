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
 Public  Partial  Class FRangoClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Dim VLPaso As Integer = 0
    Dim VLMoneda As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_0.Click, _cmdBoton_3.Click, _cmdBoton_2.Click, _cmdBoton_1.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Const MB_YESNO As Integer = 4
        Const MB_ICONQUESTION As Integer = 32
        Const MB_DEBUTTON1 As Integer = 0
        Const IDYES As Integer = 6
        Dim Response As String = ""
        Dim VTFilas As Integer = 0
        Dim VTTipoRango As String = string.Empty
        Dim  VTGrupoRango As String = string.Empty
        Dim  VTRango As String = string.Empty
        Dim  VLEstado As String = string.Empty
        Dim DgDef As COBISMsgBox.COBISButtons = MB_YESNO + MB_ICONQUESTION + MB_DEBUTTON1
        TSBotones.Focus()
        Select Case Index
            Case 0
                If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1293), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1280), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                VTFilas = VGMaxRows
                VTTipoRango = txtCampo(3).Text
                VTGrupoRango = txtCampo(0).Text
                VTRango = "0"
                While VTFilas = VGMaxRows
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4037")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT2, VTTipoRango)
                    PMPasoValores(sqlconn, "@i_grupo_rango", 0, SQLINT2, VTGrupoRango)
                    PMPasoValores(sqlconn, "@i_rango", 0, SQLINT1, VTRango)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rango_pe", True, FMLoadResString(1595)) Then
                        If VTRango = "0" Then
                            PMMapeaGrid(sqlconn, grdRangos, False)
                        Else
                            PMMapeaGrid(sqlconn, grdRangos, True)
                        End If
                        PMMapeaTextoGrid(grdRangos)
                        PMChequea(sqlconn)
                        If Conversion.Val(Convert.ToString(grdRangos.Tag)) > 0 Then
                            grdRangos.ColAlignment(2) = 1
                            grdRangos.ColAlignment(3) = 1
                            grdRangos.ColAlignment(4) = 2
                        End If
                        VTFilas = Conversion.Val(Convert.ToString(grdRangos.Tag))
                        grdRangos.Col = 1
                        grdRangos.Row = grdRangos.Rows - 1
                        VTRango = grdRangos.CtlText
                        PMAnchoColumnasGrid(grdRangos)
                    Else
                        PMChequea(sqlconn)
                    End If
                End While
                grdRangos.Row = 1
            Case 1
                If mskCosto(0).Text <> "0.00" Or mskCosto(2).Text <> "0.00" Then
                    mskCosto(0).Text = ""
                    mskCosto(2).Text = ""
                    mskCosto(0).Focus()
                Else

                    If txtCampo(0).Text <> "" Then
                        txtCampo(0).Text = ""
                        txtCampo(0).Enabled = True
                        txtCampo(0).Focus()
                        PMLimpiaGrid(grdRangos)
                    Else
                        txtCampo(3).Text = ""
                        txtCampo(3).Enabled = True
                        lblDescripcion(0).Text = ""
                        lblDescripcion(1).Text = ""
                        lblDescripcion(3).Text = ""
                        VLMoneda = ""
                        txtCampo(3).Focus()
                    End If
                End If
                lblDescripcion(2).Text = ""
                VLPaso = True
                PMObjetoSeguridad(cmdBoton(0))
                PMObjetoSeguridad(cmdBoton(3))
                PMObjetoSeguridad(cmdBoton(4))
                cmdBoton(0).Enabled = True
                cmdBoton(3).Enabled = True
                cmdBoton(4).Enabled = False
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
            Case 2
                Me.Close()
            Case 3
                If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1293), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1280), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                VLEstado = "V"
                If mskCosto(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1301), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCosto(0).Focus()
                    Exit Sub
                End If
                If mskCosto(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1299), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCosto(2).Focus()
                    Exit Sub
                End If
                If mskCosto(2).Text <> "" Then
                    If mskCosto(0).ValueDouble > mskCosto(2).ValueDouble Then
                        COBISMessageBox.Show(FMLoadResString(1302), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        mskCosto(0).Text = ""
                        mskCosto(0).Focus()
                        Exit Sub
                    End If
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4035")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
                PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT2, txtCampo(3).Text)
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, lblDescripcion(1).Text)
                PMPasoValores(sqlconn, "@i_grupo_rango", 0, SQLINT2, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_desde", 0, SQLMONEY, mskCosto(0).Text)
                PMPasoValores(sqlconn, "@i_hasta", 0, SQLMONEY, mskCosto(2).Text)
                PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, VLEstado)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rango_pe", True, FMLoadResString(1607)) Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(2))
                    PMChequea(sqlconn)
                    cmdBoton(3).Enabled = False
                    cmdBoton_Click(cmdBoton(0), New EventArgs())
                Else
                    PMChequea(sqlconn)
                End If
            Case 4
                If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1293), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1280), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                PMMarcarRegistro()
                Response = CStr(COBISMsgBox.MsgBox(FMLoadResString(1860), DgDef, FMLoadResString(1867)))
                If StringsHelper.ToDoubleSafe(Response) = IDYES Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4036")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
                    PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT2, txtCampo(3).Text)
                    PMPasoValores(sqlconn, "@i_rango", 0, SQLINT1, lblDescripcion(2).Text)
                    PMPasoValores(sqlconn, "@i_grupo_rango", 0, SQLINT2, txtCampo(0).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rango_pe", True, FMLoadResString(1538)) Then
                        PMChequea(sqlconn)
                        cmdBoton(4).Enabled = False
                        cmdBoton_Click(cmdBoton(0), New EventArgs())
                        cmdBoton(3).Enabled = True
                        cmdBoton(0).Enabled = True
                        mskCosto(0).Text = ""
                        mskCosto(2).Text = ""
                        lblDescripcion(2).Text = ""
                        mskCosto(0).Focus()
                    Else
                        PMChequea(sqlconn)
                    End If

                Else
                    Exit Sub
                End If
        End Select
        PLTSEstado()
    End Sub

	Private Sub FRango_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
		PMObjetoSeguridad(cmdBoton(0))
		PMObjetoSeguridad(cmdBoton(3))
        PMObjetoSeguridad(cmdBoton(4))
        cmdBoton(4).Enabled = False
        PLTSEstado()

	End Sub

	Private Sub FRango_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

    Private Sub grdRangos_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRangos.ClickEvent
        grdRangos.Col = 0
        grdRangos.SelStartCol = 1
        grdRangos.SelEndCol = grdRangos.Cols - 1
        If grdRangos.Row = 0 Then
            grdRangos.SelStartRow = 1
            grdRangos.SelEndRow = 1
        Else
            grdRangos.SelStartRow = grdRangos.Row
            grdRangos.SelEndRow = grdRangos.Row
        End If
    End Sub

    Private Sub grdRangos_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdRangos.DblClick
        grdRangos.Col = 0
        grdRangos.SelStartCol = 1
        grdRangos.SelEndCol = grdRangos.Cols - 1
        If grdRangos.Row = 0 Then
            grdRangos.SelStartRow = 1
            grdRangos.SelEndRow = 1
            PMMarcarRegistro()
            cmdBoton(4).Enabled = True
            cmdBoton(3).Enabled = False
        Else
            grdRangos.SelStartRow = grdRangos.Row
            grdRangos.SelEndRow = grdRangos.Row
            cmdBoton(4).Enabled = True
            cmdBoton(3).Enabled = False
        End If
        PLTSEstado()
    End Sub

    Private Sub grdRangos_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRangos.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1397))
    End Sub

    Private Sub grdRangos_KeyUpEvent(ByVal eventSender As Object, ByVal eventArgs As COBISCorp.Framework.UI.Components.GridEvents_KeyUpEvent) Handles grdRangos.KeyUpEvent
        grdRangos.Col = 0
        grdRangos.SelStartCol = 1
        grdRangos.SelEndCol = grdRangos.Cols - 1
        If grdRangos.Row = 0 Then
            grdRangos.SelStartRow = 1
            grdRangos.SelEndRow = 1
        Else
            grdRangos.SelStartRow = grdRangos.Row
            grdRangos.SelEndRow = grdRangos.Row
        End If
    End Sub
  
    Private Sub mskCosto_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskCosto_0.Enter, _mskCosto_2.Enter
        Dim Index As Integer = Array.IndexOf(mskCosto, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1805))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1803))
        End Select
        mskCosto(Index).SelStart = 0
        mskCosto(Index).SelLength = Strings.Len(mskCosto(Index).Text)
    End Sub

    Private Sub mskCosto_KeyPressEvent(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _mskCosto_2.KeyPress, _mskCosto_0.KeyPress
        Dim Index As Integer = Array.IndexOf(mskCosto, eventSender)
        Select Case Index
            Case 0, 2
                If (Asc(eventArgs.KeyChar) < 48 Or Asc(eventArgs.KeyChar) > 57) And (Asc(eventArgs.KeyChar) <> 8) And (Asc(eventArgs.KeyChar) <> 46) Then
                    eventArgs.KeyChar = Chr(0)
                End If
                eventArgs.KeyChar = ChrW(FMValidarNumero(mskCosto(Index).Text, 16, Asc(eventArgs.KeyChar), "105"))
        End Select
    End Sub

    Private Sub mskCosto_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskCosto_0.Leave, _mskCosto_2.Leave
        Dim Index As Integer = Array.IndexOf(mskCosto, eventSender)
        Select Case Index
            Case 0
                If mskCosto(0).Text <> "" Then
                    Dim dbNumericTemp As Double = 0
                    If Not Double.TryParse(mskCosto(0).Text, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp) Then
                        mskCosto(0).Text = ""
                        mskCosto(0).Focus()
                        Exit Sub
                    End If
                End If
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
            Case 2
                If mskCosto(2).Text <> "" Then
                    Dim dbNumericTemp2 As Double = 0
                    If Not Double.TryParse(mskCosto(0).Text, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp2) Then
                        mskCosto(0).Text = ""
                        mskCosto(0).Focus()
                        Exit Sub
                    End If
                    If mskCosto(0).Text <> "" Then
                        If mskCosto(2).ValueDouble < mskCosto(0).ValueDouble Then
                            COBISMessageBox.Show(FMLoadResString(1300), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            mskCosto(2).Text = ""
                            mskCosto(2).Focus()
                            Exit Sub
                        End If
                    End If
                End If
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        End Select
    End Sub

    Private Sub PMMarcarRegistro()
        Dim VTRow As Integer = grdRangos.Row
        grdRangos.Row = VTRow
        grdRangos.Col = 1

        Dim Index As Integer = 0
        cmdBoton(0).Enabled = False
        If VLMoneda = "S" Then
            mskCosto(Index).Text = StringsHelper.Format(mskCosto(Index).Text, "#,##0.00")
        ElseIf VLMoneda = "N" Then
            mskCosto(Index).Text = StringsHelper.Format(0, "#,##0")
        End If
        grdRangos.Row = grdRangos.Rows - 1
        grdRangos.Col = 1
        lblDescripcion(2).Text = grdRangos.CtlText
        grdRangos.Col = 2
        mskCosto(0).Text = grdRangos.CtlText
        grdRangos.Col = 3
        mskCosto(2).Text = grdRangos.CtlText
        grdRangos.Col = 4
        PLTSEstado()
    End Sub

    Private Sub mskCosto_MouseDownEvent(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles _mskCosto_2.MouseDown, _mskCosto_0.MouseDown
        Dim Index As Integer = Array.IndexOf(mskCosto, eventSender)
        Select Case Index
            Case 0, 2
                My.Computer.Clipboard.Clear()
        End Select
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.TextChanged, _txtCampo_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 3
                VLPaso = False
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.Enter, _txtCampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = True
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1382))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1774))
        End Select
        cmdBoton(3).Visible = True
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_3.KeyDown, _txtCampo_0.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTFilas As Integer = 0
        Dim VTCodigo As String = ""
        If KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 3
                    VLPaso = True
                    VGOperacion = "sp_help_rango_pe"
                    VGConsulta = True
                    VGTipo = "T"
                    VTFilas = VGMaxRows
                    VTCodigo = "0"
                    While VTFilas = VGMaxRows
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4038")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "T")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, VTCodigo)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rango_pe", True, FMLoadResString(1595)) Then
                            If VTCodigo = "0" Then
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
                            VTCodigo = FRegistros.grdRegistros.CtlText
                        Else
                            PMChequea(sqlconn)
                            VGOperacion = ""
                            VGTipo = ""
                        End If
                    End While
                    FRegistros.grdRegistros.Row = 1
                    FRegistros.ShowPopup(Me)
                    If VGValores(1) <> "" Then
                        txtCampo(3).Text = VGValores(1)
                        lblDescripcion(0).Text = VGValores(2)
                        lblDescripcion(1).Text = VGValores(3)
                        lblDescripcion(3).Text = VGValores(4)
                        VLPaso = True
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4044")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
                        PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, lblDescripcion(1).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_promon", False, "") Then
                            PMMapeaVariable(sqlconn, VLMoneda)
                            PMChequea(sqlconn)
                        End If
                    End If
                    FRegistros.Dispose() '18/05/2016 migracion
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_3.KeyPress, _txtCampo_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 3
                If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                    KeyAscii = 0
                End If
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.Leave, _txtCampo_0.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
            Case 3
                If Not VLPaso Then
                    If txtCampo(3).Text <> "" Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4038")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT1, txtCampo(3).Text)
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "T")
                        Dim Valores(10) As String
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rango_pe", True, FMLoadResString(1595)) Then
                            FMMapeaArreglo(sqlconn, Valores)
                            PMChequea(sqlconn)
                            lblDescripcion(0).Text = Valores(1)
                            lblDescripcion(1).Text = Valores(2)
                            lblDescripcion(3).Text = Valores(3)
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4044")
                            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
                            PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, lblDescripcion(1).Text)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_promon", False, "") Then
                                PMMapeaVariable(sqlconn, VLMoneda)
                                PMChequea(sqlconn)
                            Else
                                PMChequea(sqlconn)
                            End If
                        Else
                            PMChequea(sqlconn)
                            txtCampo(3).Text = ""
                            lblDescripcion(0).Text = ""
                            lblDescripcion(1).Text = ""
                            lblDescripcion(3).Text = ""
                            VLPaso = True
                        End If
                    Else
                        lblDescripcion(0).Text = ""
                        lblDescripcion(1).Text = ""
                        lblDescripcion(3).Text = ""
                    End If
                End If
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        End Select
    End Sub

    Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_3.MouseDown, _txtCampo_0.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 3
                My.Computer.Clipboard.Clear()
        End Select
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBCrear.Enabled = _cmdBoton_3.Enabled
        TSBCrear.Visible = _cmdBoton_3.Visible
        TSBEliminar.Enabled = _cmdBoton_4.Enabled
        TSBEliminar.Visible = _cmdBoton_4.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

    Private Sub grdRangos_Leave(sender As Object, e As EventArgs) Handles grdRangos.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
    End Sub

End Class


