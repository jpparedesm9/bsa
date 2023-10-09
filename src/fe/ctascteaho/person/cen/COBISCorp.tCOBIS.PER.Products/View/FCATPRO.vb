Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
Imports COBISCorp.tCOBIS.PER.Cost
 Public  Partial  Class FCatProFinalClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

	Dim VLPaso As Integer = 0
    Dim VLProducto As String = ""
    Public Prod_AporteSocial_Adic As String
    Public Prod_Bancario As String

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_5.Click, _cmdBoton_2.Click, _cmdBoton_4.Click, _cmdBoton_3.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Const MB_YESNO As Integer = 4
        Const MB_ICONQUESTION As Integer = 32
        Const MB_DEBUTTON1 As Integer = 0
        Const IDYES As Integer = 6
        Dim Response As String = string.Empty
        Dim  VTPosteo As String = string.Empty
        Dim VTContrac As String = String.Empty
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
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4101")
                PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_categoria_profinal", True, FMLoadResString(1546)) Then
                    PMMapeaGrid(sqlconn, grdCategorias, False)
                    PMMapeaTextoGrid(grdCategorias)
                    PMAnchoColumnasGrid(grdCategorias)
                    PMChequea(sqlconn)
                    'grdCategorias.ColWidth(1) = 1000
                    'grdCategorias.ColWidth(2) = 5750
                    'grdCategorias.ColWidth(3) = 1000
                    PLModoInsertar(True)
                    PLLimpiar("=", 3)
                    PLLimpiar("=", 4)
                Else
                    PMChequea(sqlconn)
                End If
            Case 1 'Crear
                If txtCampo(1).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(1269), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If txtCampo(2).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(1250), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                If optPosteo(0).Checked Then
                    VTPosteo = "S"
                ElseIf optPosteo(1).Checked Then
                    VTPosteo = "N"
                End If
                If optContrac(2).Checked Then
                    VTContrac = "S"
                ElseIf optContrac(3).Checked Then
                    VTContrac = "N"
                End If
                If Prod_Bancario = Prod_AporteSocial_Adic And Val(txtCampo(3).Text) = 0 Then
                    COBISMessageBox.Show(FMLoadResString(9112), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4101")
                PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "I")
                PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_dias_plazo", 0, SQLINT2, txtCampo(3).Text)
                PMPasoValores(sqlconn, "@i_posteo", 0, SQLCHAR, VTPosteo)
                PMPasoValores(sqlconn, "@i_contractual", 0, SQLCHAR, VTContrac)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_categoria_profinal", True, FMLoadResString(1575)) Then
                    PMChequea(sqlconn)
                    cmdBoton_Click(cmdBoton(0), New EventArgs())
                Else
                    PMChequea(sqlconn)
                End If
            Case 2
                Response = CStr(COBISMsgBox.MsgBox(FMLoadResString(1862), DgDef, FMLoadResString(1867)))
                If StringsHelper.ToDoubleSafe(Response) = IDYES Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4101")
                    PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "D")
                    PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
                    PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_categoria_profinal", True, FMLoadResString(1584)) Then
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
                txtCampo(0).Focus()
            Case 4
                Me.Close()
            Case 5 ' Actualizar
                If optPosteo(0).Checked Then
                    VTPosteo = "S"
                ElseIf optPosteo(1).Checked Then
                    VTPosteo = "N"
                End If
                If optContrac(2).Checked Then
                    VTContrac = "S"
                ElseIf optContrac(3).Checked Then
                    VTContrac = "N"
                End If
                If Prod_Bancario = Prod_AporteSocial_Adic And Val(txtCampo(3).Text) = 0 Then
                    COBISMessageBox.Show(FMLoadResString(9112), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4101")
                PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "U")
                PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_dias_plazo", 0, SQLINT2, txtCampo(3).Text)
                PMPasoValores(sqlconn, "@i_posteo", 0, SQLCHAR, VTPosteo)
                PMPasoValores(sqlconn, "@i_contractual", 0, SQLCHAR, VTContrac)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_categoria_profinal", True, FMLoadResString(1537)) Then
                    PMChequea(sqlconn)
                    cmdBoton_Click(cmdBoton(0), New EventArgs())
                Else
                    PMChequea(sqlconn)
                End If
        End Select
    End Sub

	Private Sub FCatProFinal_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLModoInsertar(True)
		PMBotonSeguridad(Me, 5)
		PMObjetoSeguridad(cmdBoton(0))
		PMObjetoSeguridad(cmdBoton(5))
		PMObjetoSeguridad(cmdBoton(1))
        PMObjetoSeguridad(cmdBoton(2))
        cmdBoton(2).Enabled = False
        cmdBoton(5).Enabled = False
        PLTSEstado()

        'Se obtiene el Parametro del Producto Aporte Social Adicional para que
        'al traer producto final se compruebe si coincide y en ese caso activar Dias PLAZO
        Prod_AporteSocial_Adic = ""
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "PCAASA")
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLVARCHAR, "F")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(9111)) Then
            PMMapeaVariable(sqlconn, Prod_AporteSocial_Adic)
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If

        txtCampo(3).Enabled = False
    End Sub

	Private Sub FCatProFinal_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(System.String.Empty)
	End Sub

    Private Sub grdCategorias_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdCategorias.ClickEvent
        grdCategorias.Col = 0
        grdCategorias.SelStartCol = 1
        grdCategorias.SelEndCol = grdCategorias.Cols - 1
        If grdCategorias.Row = 0 Then
            grdCategorias.SelStartRow = 1
            grdCategorias.SelEndRow = 1
        Else
            grdCategorias.SelStartRow = grdCategorias.Row
            grdCategorias.SelEndRow = grdCategorias.Row
        End If
    End Sub

	Private Sub grdCategorias_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdCategorias.DblClick
		Dim VTRow As Integer = grdCategorias.Row
		grdCategorias.Row = 1
		grdCategorias.Col = 1
		If grdCategorias.CtlText.Trim() <> "" Then
			grdCategorias.Row = VTRow
			PMMarcarRegistro()
			PLModoInsertar(False)
		End If
	End Sub

	Private Sub grdCategorias_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdCategorias.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1393))
	End Sub

	Private Sub optPosteo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optPosteo_0.Enter, _optPosteo_1.Enter
		Dim Index As Integer = Array.IndexOf(optPosteo, eventSender)
		Select Case Index
			Case 0, 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1335))
		End Select
	End Sub

	Private Sub PLLimpiar(ByRef tipo As String, ByRef Numero As Integer)
		Select Case tipo
			Case "="
				If Numero <= 3 Then
					txtCampo(Numero - 1).Text = ""
					lblDescripcion(Numero - 1).Text = ""
					If Numero = 2 Then
						optPosteo(0).Checked = True
						optPosteo(0).Enabled = True
						optPosteo(1).Enabled = True
						optContrac(3).Checked = True
					End If
				ElseIf Numero = 5 Then 
					PMLimpiaGrid(grdCategorias)
				End If
			Case ">"
				For i As Integer = Numero To 4
					PLLimpiar("=", i + 1)
				Next i
			Case "<"
				For i As Integer = Numero To 2 Step -1
					PLLimpiar("=", i - 1)
				Next i
        End Select
        txtCampo(3).Text = ""
        txtCampo(3).Enabled = False
        Prod_Bancario = ""
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

	Private Sub PLModoInsertar(ByRef Modo As Integer)
		txtCampo(0).Enabled = Modo
		txtCampo(1).Enabled = Modo
        txtCampo(2).Enabled = Modo
		If Modo Then
			PMObjetoSeguridad(cmdBoton(1))
			cmdBoton(2).Enabled = Not Modo
			cmdBoton(5).Enabled = Not Modo
		Else
			cmdBoton(1).Enabled = Modo
			PMObjetoSeguridad(cmdBoton(2))
			PMObjetoSeguridad(cmdBoton(5))
        End If
        PLTSEstado()
	End Sub

	Private Sub PMMarcarRegistro()
		grdCategorias.Col = 1
		txtCampo(2).Text = grdCategorias.CtlText
		grdCategorias.Col = 2
		lblDescripcion(2).Text = grdCategorias.CtlText
        grdCategorias.Col = 3
        If grdCategorias.CtlText = "S" Then
            optPosteo(0).Checked = True
        Else
            optPosteo(1).Checked = True
        End If
        grdCategorias.Col = 4
        If grdCategorias.CtlText = "S" Then
            optContrac(2).Checked = True
        Else
            optContrac(3).Checked = True
        End If
        grdCategorias.Col = 5
        If Val(grdCategorias.CtlText) > 0 Then
            Prod_Bancario = Prod_AporteSocial_Adic
            txtCampo(3).Enabled = True
            txtCampo(3).Text = grdCategorias.CtlText
        Else
            txtCampo(3).Enabled = False
            txtCampo(3).Text = ""
        End If
	End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.TextChanged, _txtCampo_2.TextChanged, _txtCampo_1.TextChanged, _txtCampo_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3
                VLPaso = False
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.Enter, _txtCampo_1.Enter, _txtCampo_0.Enter, _txtCampo_3.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = True
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1151))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1163))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1153))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(9109))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_3.KeyDown, _txtCampo_2.KeyDown, _txtCampo_1.KeyDown, _txtCampo_0.KeyDown
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
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", False, FMLoadResString(1913)) Then
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
                            txtCampo(3).Text = ""
                            txtCampo(3).Enabled = False
                            VGOperacion = ""
                        End If
                    End While
                    FRegistros.grdRegistros.Row = 1
                    FRegistros.ShowPopup(Me)
                    If VGValores(1) <> "" Then
                        txtCampo(1).Text = VGValores(1)
                        lblDescripcion(1).Text = VGValores(2)
                        VLProducto = VGValores(5)
                        If VLProducto = "3" Then
                            optPosteo(1).Checked = True
                            optPosteo(0).Enabled = False
                            optPosteo(1).Enabled = False
                        Else
                            optPosteo(0).Checked = True
                            optPosteo(0).Enabled = True
                            optPosteo(1).Enabled = True
                        End If
                        VLPaso = True
                    Else
                        txtCampo(1).Text = ""
                        lblDescripcion(1).Text = ""
                        optPosteo(0).Checked = True
                        optPosteo(0).Enabled = True
                        optPosteo(1).Enabled = True
                        VGOperacion = ""
                        VLProducto = ""
                    End If
                    FRegistros.Dispose() '18/05/2016 migracion
                Case 2
                    PMCatalogo("A", "pe_categoria", txtCampo(2), lblDescripcion(2), FRegistros)
                    VLPaso = True
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_2.KeyPress, _txtCampo_1.KeyPress, _txtCampo_0.KeyPress, _txtCampo_3.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 3
                If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                    KeyAscii = 0
                End If
            Case 2
                If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 97) Or (KeyAscii > 122)) Then
                    KeyAscii = 0
                Else
                    KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                End If
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub _txtCampo_1_LostFocus(sender As Object, e As EventArgs) Handles _txtCampo_1.LostFocus
        If _txtCampo_1.Text <> "" Then
            PLComprobar_ProdFinal()
        End If
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_3.Leave, _txtCampo_2.Leave, _txtCampo_1.Leave, _txtCampo_0.Leave
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
                    If txtCampo(0).Text <> "" Then
                        If CDbl(txtCampo(0).Text) >= 32000 Then
                            COBISMessageBox.Show(FMLoadResString(1418), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            lblDescripcion(0).Text = ""
                            txtCampo(0).Text = ""
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
                    PLComprobar_ProdFinal()
                Case 2
                    If txtCampo(2).Text.Trim() = "" Then
                        lblDescripcion(2).Text = ""
                        Exit Sub
                    End If
                    PMCatalogo("V", "pe_categoria", txtCampo(2), lblDescripcion(2), Nothing)
                    If txtCampo(2).Text.Trim() = "" And lblDescripcion(2).Text.Trim() = "" Then
                        txtCampo(2).Focus()
                    End If
            End Select
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
        End If
    End Sub

    Sub PLComprobar_ProdFinal()
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
            VLProducto = VTArreglo(3)
            If VLProducto = "3" Then
                optPosteo(1).Checked = True
                optPosteo(0).Enabled = False
                optPosteo(1).Enabled = False
            Else
                optPosteo(0).Checked = True
                optPosteo(0).Enabled = True
                optPosteo(1).Enabled = True
            End If
            Prod_Bancario = VTArreglo(4)
            If Prod_Bancario = Prod_AporteSocial_Adic Then 'Producto Final es de PRoducto BAncario Aporte Social Adicional - PCAASA
                txtCampo(3).Enabled = True
            Else
                txtCampo(3).Text = ""
                txtCampo(3).Enabled = False
            End If
        Else
            PMChequea(sqlconn)
            PLLimpiar("=", 2)
            Prod_Bancario = ""
            txtCampo(3).Text = ""
            txtCampo(3).Enabled = False
            txtCampo(2).Focus()
            VLPaso = True
        End If
    End Sub

    Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_2.MouseDown, _txtCampo_1.MouseDown, _txtCampo_0.MouseDown, _txtCampo_3.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3
                My.Computer.Clipboard.Clear()
        End Select
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBCrear.Enabled = _cmdBoton_1.Enabled
        TSBCrear.Visible = _cmdBoton_1.Visible
        TSBActualizar.Enabled = _cmdBoton_5.Enabled
        TSBActualizar.Visible = _cmdBoton_5.Visible
        TSBEliminar.Enabled = _cmdBoton_2.Enabled
        TSBEliminar.Visible = _cmdBoton_2.Visible
        TSBLimpiar.Enabled = _cmdBoton_3.Enabled
        TSBLimpiar.Visible = _cmdBoton_3.Visible
        TSBSalir.Enabled = _cmdBoton_4.Enabled
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub optPosteo_Leave(sender As Object, e As EventArgs) Handles _optPosteo_0.Leave, _optPosteo_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private Sub optContrac_Enter(sender As Object, e As EventArgs) Handles _optContrac_3.Enter, _optContrac_2.Enter
        Dim Index As Integer = Array.IndexOf(optContrac, sender)
        Select Case Index
            Case 2, 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1058))
        End Select
    End Sub

    Private Sub optContrac_Leave(sender As Object, e As EventArgs) Handles _optContrac_2.Leave, _optContrac_3.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

End Class


