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

Partial Public Class FTopesOfiClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLPaso As Boolean
    Dim MhTListaLimitesCurrentTab As Integer = 0
    Dim VLNumTranValido As Boolean = True
    'Dim VLInicio As Boolean = False

    Private Sub FTopesOfi_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PMBotonSeguridad(Me, 5)
        cmbTipo.Items.Insert(0, FMLoadResString(1911))
        cmbTipo.Items.Insert(1, FMLoadResString(1912))
        cmbTipo.SelectedIndex = 0
        MhTListaLimitesCurrentTab = 2
        SSTabHelper.SetSelectedIndex(MhTListaLimites, 2)
        SSTabHelper.SetTabEnabled(MhTListaLimites, MhTListaLimitesCurrentTab, False)
        MhTListaLimitesCurrentTab = 0
        SSTabHelper.SetSelectedIndex(MhTListaLimites, 0)
        'VLInicio = True
        BtnEliminarCau.Enabled = False
        BtnEliminarLim.Enabled = False
        TextValid.Focus()
        PLTSEstado()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(System.String.Empty)
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_5.Click, _cmdBoton_2.Click, _cmdBoton_4.Click, _cmdBoton_3.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)

        Select Case Index
            Case 0
                TSBotones.Focus()
                PLBuscar()
            Case 1
                TSBotones.Focus()
                PLTransmitir()
            Case 2
                TSBotones.Focus()
                PLEliminar()
            Case 3
                PLLimpiar(0) 'Tab activo 1
            Case 4
                Me.Close()
            Case 5
                TSBotones.Focus()
                PLActualizar()
        End Select
    End Sub

    Private Sub Check1_CheckStateChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles Check1.CheckStateChanged
        If Not Check1.Checked Then
            mskMonto(1).Text = "0"
            mskMonto(1).Enabled = False
        Else
            mskMonto(1).Enabled = True
        End If
    End Sub

    Private Sub Check2_CheckStateChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles Check2.CheckStateChanged
        If Not Check2.Checked Then
            mskMonto(2).Text = "0"
            mskMonto(2).Enabled = False
        Else
            mskMonto(2).Enabled = True
        End If
    End Sub

    Private Sub Check3_CheckStateChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles Check3.CheckStateChanged
        If Not Check3.Checked Then
            mskMonto(3).Text = "0"
            mskMonto(3).Enabled = False
        Else
            mskMonto(3).Enabled = True
        End If
    End Sub

    Private Sub Check4_CheckStateChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles Check4.CheckStateChanged
        If Not Check4.Checked Then
            mskMonto(4).Text = "0"
            mskMonto(4).Enabled = False
        Else
            mskMonto(4).Enabled = True
        End If
    End Sub


    Private Sub PLLimpiar(tabActivo As Integer)
        'Tab 0
        PMLimpiarTab0(0)
        'Tab 1
        MhTListaLimitesCurrentTab = 1
        SSTabHelper.SetTabEnabled(MhTListaLimites, MhTListaLimitesCurrentTab, True)
        PMLimpiaGrid(grdLimites)
        mskNumTx.Text = "0"
        mskMontoRetiro.Text = "0.00"
        txtOrigen.Text = ""
        lblOrigen.Text = ""
        TextEspecie.Text = ""
        lblEspecie.Text = ""
        mskNumTx.Text = ""
        mskMontoRetiro.Text = ""
        'Tab 2
        TextCausal.Text = ""
        lblCausal.Text = ""
        PMLimpiaGrid(grdCausales)

        MhTListaLimitesCurrentTab = 2
        SSTabHelper.SetTabEnabled(MhTListaLimites, MhTListaLimitesCurrentTab, False)
        MhTListaLimitesCurrentTab = 1
        SSTabHelper.SetTabEnabled(MhTListaLimites, MhTListaLimitesCurrentTab, True)
        MhTListaLimitesCurrentTab = 0
        SSTabHelper.SetTabEnabled(MhTListaLimites, MhTListaLimitesCurrentTab, True)
        SSTabHelper.SetSelectedIndex(MhTListaLimites, tabActivo)

        BtnEliminarCau.Enabled = False
        BtnEliminarLim.Enabled = False
        'Validación para que cuando el tab sea 0 el foco quede en el campo Número de transacciones
        If tabActivo = 0 Then
            TextValid.Focus()
        ElseIf tabActivo = 1 Then
            txtOrigen.Focus()

        End If

        PLTSEstado()
    End Sub

    Private Sub grdLimites_ClickEvent(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdLimites.ClickEvent
        grdLimites.Col = 0
        grdLimites.SelStartCol = 1
        grdLimites.SelEndCol = grdLimites.Cols - 1
        If grdLimites.Row = 0 Then
            grdLimites.SelStartRow = 1
            grdLimites.SelEndRow = 1
        Else
            grdLimites.SelStartRow = grdLimites.Row
            grdLimites.SelEndRow = grdLimites.Row
        End If
    End Sub

    Private Sub grdLimites_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdLimites.DblClick
        grdLimites.Col = 1
        If grdLimites.CtlText = "" Then
            COBISMessageBox.Show(FMLoadResString(1505), FMLoadResString(1474), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            txtOrigen.Focus()
            Exit Sub
        End If
        txtOrigen.Text = grdLimites.CtlText
        grdLimites.Col = 2
        lblOrigen.Text = grdLimites.CtlText
        grdLimites.Col = 3
        TextEspecie.Text = grdLimites.CtlText
        grdLimites.Col = 4
        lblEspecie.Text = grdLimites.CtlText
        grdLimites.Col = 5
        mskNumTx.Text = grdLimites.CtlText
        grdLimites.Col = 6
        mskMontoRetiro.Text = grdLimites.CtlText
        MhTListaLimitesCurrentTab = 1
        'SSTabHelper.SetSelectedIndex(MhTListaLimites, 1)
        SSTabHelper.SetTabEnabled(MhTListaLimites, MhTListaLimitesCurrentTab, True)
        PMBuscarCausal()
        Dim VLOrigen As String = txtOrigen.Text
        Dim VLEspecie As String = TextEspecie.Text
        Dim VLDescOrigen As String = lblOrigen.Text
        Dim VLDescEspecie As String = lblEspecie.Text
        
        Frame1.Enabled = True
        TextCausal.Enabled = True
        TextCausal.Focus()
        LblOrigen22.Text = VLOrigen
        LblEspecie22.Text = VLEspecie
        LblOrigen2.Text = VLDescOrigen
        LblEspecie2.Text = VLDescEspecie
        BtnBuscarCau_Click(BtnBuscarCau, New EventArgs())
        TextCausal.Focus()
        BtnEliminarLim.Enabled = True
        BtnEliminarCau.Enabled = False
        PLTSEstado()
        grdLimites_ClickEvent(grdLimites, New EventArgs())
    End Sub

    Private Sub PLBuscar()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(4129))
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        If cmbTipo.SelectedIndex = 0 Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "4")
        ElseIf cmbTipo.SelectedIndex = 1 Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "3")
        End If
        PMPasoValores(sqlconn, "@i_cantidad", 0, SQLINT4, TextValid.Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_topes_oficina", True, FMLoadResString(1563)) Then
            PMMapeaGrid(sqlconn, grdVariables, False)
            'PMMapeaTextoGrid(grdVariables)
            PMChequea(sqlconn)
            grdVariables.Col = 1
            lblDescripcion(0).Text = grdVariables.CtlText
            cmdBoton(2).Enabled = True
            cmdBoton(5).Enabled = True
            grdVariables.Col = 3
            TextValid.Text = grdVariables.CtlText
            cmdBoton(1).Enabled = False
            grdVariables.Col = 6
            If CDbl(grdVariables.CtlText) > 0 Then
                mskMonto(1).Text = grdVariables.CtlText
                Check1.Checked = 1
            Else
                mskMonto(1).Enabled = False
            End If
            grdVariables.Col = 7
            If CDbl(grdVariables.CtlText) > 0 Then
                mskMonto(2).Text = grdVariables.CtlText
                Check2.Checked = 1
            Else
                mskMonto(2).Enabled = False
            End If
            grdVariables.Col = 12
            If CDbl(grdVariables.CtlText) > 0 Then
                mskMonto(3).Text = grdVariables.CtlText
                Check3.Checked = 1
            Else
                mskMonto(3).Enabled = False
            End If
            grdVariables.Col = 13
            If CDbl(grdVariables.CtlText) > 0 Then
                mskMonto(4).Text = grdVariables.CtlText
                Check4.Checked = 1
            Else
                mskMonto(4).Enabled = False
            End If
            cmdBoton(5).Enabled = True
            cmdBoton(2).Enabled = True
            PMAnchoColumnasGrid(grdVariables)
        Else
            PMChequea(sqlconn)
            cmdBoton(1).Enabled = True
            PMLimpiarTab0(cmbTipo.SelectedIndex)
        End If
        SSTabHelper.SetSelectedIndex(MhTListaLimites, 0)
        MhTListaLimitesCurrentTab = 0
        TextValid.Focus()
        MhTListaLimitesCurrentTab = 1
        If grdLimites.CtlText = "" Then
            SSTabHelper.SetSelectedIndex(MhTListaLimites, 2)
            MhTListaLimitesCurrentTab = 2
            SSTabHelper.SetTabEnabled(MhTListaLimites, MhTListaLimitesCurrentTab, False)
        End If
        PLTSEstado()
    End Sub

    Private Sub PLTransmitir()
        SSTabHelper.SetSelectedIndex(MhTListaLimites, 0)
        If Not VLNumTranValido Then
            Exit Sub
        End If
        If TextValid.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1237), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            TextValid.Focus()
            Exit Sub
        End If
        If Check1.Checked = True And Math.Floor(CDbl(mskMonto(1).Text)) = StringsHelper.ToDoubleSafe("0") Then
            COBISMessageBox.Show(FMLoadResString(1235) + " --> " + Frame2(0).Text, FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskMonto(1).Focus()
            Exit Sub
        End If
        If Math.Floor(CDbl(mskMonto(1).Text)) > StringsHelper.ToDoubleSafe("0.00") And Check1.Checked = CheckState.Unchecked Then
            Check1.Checked = 1
        End If
        If Check2.Checked = True And Math.Floor(CDbl(mskMonto(2).Text)) = StringsHelper.ToDoubleSafe("0.00") Then
            COBISMessageBox.Show(FMLoadResString(1234) + " --> " + Frame2(0).Text, FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskMonto(2).Focus()
            Exit Sub
        End If
        If Math.Floor(CDbl(mskMonto(2).Text)) > StringsHelper.ToDoubleSafe("0.00") And Check2.Checked = CheckState.Unchecked Then
            Check2.Checked = 1
        End If
        If Math.Floor(CDbl(mskMonto(1).Text)) = StringsHelper.ToDoubleSafe("0.00") And Check1.Checked = CheckState.Unchecked And Math.Floor(CDbl(mskMonto(2).Text)) = StringsHelper.ToDoubleSafe("0.00") And Check2.Checked = CheckState.Unchecked Then
            COBISMessageBox.Show(FMLoadResString(1639), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            TextValid.Focus()
            Exit Sub
        End If
        If Check3.Checked = True And Math.Floor(CDbl(mskMonto(3).Text)) = StringsHelper.ToDoubleSafe("0") Then
            COBISMessageBox.Show(FMLoadResString(1235) + " --> " + Frame3(1).Text, FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskMonto(3).Focus()
            Exit Sub
        End If
        If Math.Floor(CDbl(mskMonto(3).Text)) > StringsHelper.ToDoubleSafe("0.00") And Check3.Checked = CheckState.Unchecked Then
            Check3.Checked = 1
        End If
        If Check4.Checked = True And Math.Floor(CDbl(mskMonto(4).Text)) = StringsHelper.ToDoubleSafe("0.00") Then
            COBISMessageBox.Show(FMLoadResString(1234) + " --> " + Frame3(1).Text, FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskMonto(4).Focus()
            Exit Sub
        End If
        If Math.Floor(CDbl(mskMonto(4).Text)) > StringsHelper.ToDoubleSafe("0.00") And Check4.Checked = CheckState.Unchecked Then
            Check4.Checked = 1
        End If
        If Math.Floor(CDbl(mskMonto(3).Text)) = StringsHelper.ToDoubleSafe("0.00") And Check3.Checked = CheckState.Unchecked And Math.Floor(CDbl(mskMonto(4).Text)) = StringsHelper.ToDoubleSafe("0.00") And Check4.Checked = CheckState.Unchecked Then
            COBISMessageBox.Show(FMLoadResString(1640), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            TextValid.Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(4128))
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
        If cmbTipo.SelectedIndex = 0 Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "4")
        ElseIf cmbTipo.SelectedIndex = 1 Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "3")
        End If
        PMPasoValores(sqlconn, "@i_cantidad", 0, SQLINT1, TextValid.Text)
        If Check1.Checked = True Then
            PMPasoValores(sqlconn, "@i_efectivo", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_valor_efe", 0, SQLMONEY, mskMonto(1).Text)
        End If
        If Check2.Checked = True Then
            PMPasoValores(sqlconn, "@i_chq_ger", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_valor_chq", 0, SQLMONEY, mskMonto(2).Text)
        End If
        If Check3.Checked = True Then
            PMPasoValores(sqlconn, "@i_efectivo_otra", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_valor_efe_otra", 0, SQLMONEY, mskMonto(3).Text)
        End If
        If Check4.Checked = True Then
            PMPasoValores(sqlconn, "@i_chq_ger_otra", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_valor_chq_otra", 0, SQLMONEY, mskMonto(4).Text)
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_topes_oficina", True, FMLoadResString(1580)) Then
            PMMapeaGrid(sqlconn, grdVariables, False)
            'PMMapeaTextoGrid(grdVariables)
            PMChequea(sqlconn)
            PMAnchoColumnasGrid(grdVariables)
            grdVariables.Col = 1
            lblDescripcion(0).Text = grdVariables.CtlText
            cmdBoton(1).Enabled = False
            cmdBoton(2).Enabled = True
            cmdBoton(5).Enabled = True
            PLTSEstado()
            COBISMessageBox.Show(FMLoadResString(1682), FMLoadResString(1474), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub grdCausales_ClickEvent(sender As Object, e As EventArgs) Handles grdCausales.ClickEvent
        grdCausales.Col = 0
        grdCausales.SelStartCol = 1
        grdCausales.SelEndCol = grdCausales.Cols - 1
        If grdCausales.Row = 0 Then
            grdCausales.SelStartRow = 1
            grdCausales.SelEndRow = 1
        Else
            grdCausales.SelStartRow = grdCausales.Row
            grdCausales.SelEndRow = grdCausales.Row
        End If
    End Sub

    Private Sub grdCausales_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdCausales.DblClick
        If grdCausales.CtlText = "" Then
            COBISMessageBox.Show(FMLoadResString(1505), FMLoadResString(1474), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            TextCausal.Focus()
            Exit Sub
        End If
        grdCausales.Col = 1
        TextCausal.Text = grdCausales.CtlText
        grdCausales.Col = 2
        lblCausal.Text = grdCausales.CtlText
        BtnEliminarCau.Enabled = True
        PLTSEstado()
        grdCausales_ClickEvent(grdCausales, New EventArgs())
    End Sub

    Private Sub MhTListaLimites_TabChangedHelper(ByRef NewFolder As Integer, ByRef OldFolder As Integer)
        Dim VLOrigen As String = String.Empty
        Dim VLEspecie As String = String.Empty
        Dim VLDescOrigen As String = String.Empty
        Dim VLDescEspecie As String = String.Empty
        If NewFolder = 0 Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502043))
            SSTabHelper.SetSelectedIndex(MhTListaLimites, 0)
            MhTListaLimitesCurrentTab = 0
            MhTListaLimites.Enabled = True
            cmdBoton(0).Enabled = True
            Check1_CheckStateChanged(Check1, New EventArgs())
            Check2_CheckStateChanged(Check2, New EventArgs())
            Check3_CheckStateChanged(Check3, New EventArgs())
            Check4_CheckStateChanged(Check4, New EventArgs())
            cmdBoton(3).Enabled = True
            If lblDescripcion(0).Text = "" Then
                cmdBoton(1).Enabled = True
                cmdBoton(2).Enabled = False
                cmdBoton(5).Enabled = False
            Else
                cmdBoton(1).Enabled = False
                cmdBoton(2).Enabled = True
                cmdBoton(5).Enabled = True
            End If

        Else
            cmdBoton(0).Enabled = False
            cmdBoton(1).Enabled = False
            cmdBoton(2).Enabled = False
            cmdBoton(5).Enabled = False
            If NewFolder = 1 Then
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502042))
                SSTabHelper.SetSelectedIndex(MhTListaLimites, 1)
                MhTListaLimitesCurrentTab = 1
                MhTListaLimites.Enabled = True
                SSTabHelper.SetTabEnabled(MhTListaLimites, MhTListaLimitesCurrentTab, True)
                VLOrigen = txtOrigen.Text
                VLEspecie = TextEspecie.Text
                VLDescOrigen = lblOrigen.Text
                VLDescEspecie = lblEspecie.Text
            Else
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502044))
                MhTListaLimitesCurrentTab = 1
                VLOrigen = txtOrigen.Text
                VLEspecie = TextEspecie.Text
                VLDescOrigen = lblOrigen.Text
                VLDescEspecie = lblEspecie.Text
                SSTabHelper.SetSelectedIndex(MhTListaLimites, 2)
                MhTListaLimitesCurrentTab = 2
                SSTabHelper.SetTabEnabled(MhTListaLimites, MhTListaLimitesCurrentTab, True)
                TextCausal.Enabled = True
                TextCausal.Text = System.String.Empty
                lblCausal.Text = System.String.Empty
                LblOrigen2.Text = System.String.Empty
                LblOrigen22.Text = System.String.Empty
                LblEspecie2.Text = System.String.Empty
                LblEspecie22.Text = System.String.Empty
                LblOrigen22.Text = VLOrigen
                LblEspecie22.Text = VLEspecie
                LblOrigen2.Text = VLDescOrigen
                LblEspecie2.Text = VLDescEspecie
                'PMBuscarCausal()
            End If
        End If
        PLTSEstado()
    End Sub

    Private Sub mskMonto_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskMonto_3.Enter, _mskMonto_4.Enter, _mskMonto_1.Enter, _mskMonto_2.Enter
        Dim Index As Integer = Array.IndexOf(mskMonto, eventSender)
        Select Case Index
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1816))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1814))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1817))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1815))
        End Select
        mskMonto(Index).SelStart = 0
        mskMonto(Index).SelLength = Strings.Len(mskMonto(Index).Text)
    End Sub

    Private Sub mskMonto_KeyPressEvent(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _mskMonto_3.KeyPress, _mskMonto_4.KeyPress, _mskMonto_1.KeyPress, _mskMonto_2.KeyPress
        Dim Index As Integer = Array.IndexOf(mskMonto, eventSender)
        Select Case Index
            Case 1, 2, 3, 4
                If (Asc(eventArgs.KeyChar) < 48 Or Asc(eventArgs.KeyChar) > 57) And (Asc(eventArgs.KeyChar) <> 8) And (Asc(eventArgs.KeyChar) <> 46) Then
                    eventArgs.KeyChar = Chr(0)
                End If
                eventArgs.KeyChar = ChrW(FMValidarNumero(mskMonto(Index).Text, 16, Asc(eventArgs.KeyChar), "105"))
        End Select
    End Sub

    Function FMValidarNumero(ByRef parValor As String, ByRef parLongitud As Integer, ByRef parcaracter As Integer, ByRef parNemonico As String) As Integer
        Dim CGTeclaMenos As Integer = 0
        Dim VTSeparadorDecimal As String = "."
        Dim VTDecimal As Integer = 2
        If parcaracter = CGTeclaMenos Then
            Return 0
        End If
        If VTDecimal > 0 Then
            If (parValor.IndexOf(VTSeparadorDecimal) + 1) >= (parLongitud + (VTDecimal) + 1) Then
                Return 0
            Else
                Return parcaracter
            End If
        Else
            If parValor.Length >= parLongitud Then
                Return 0
            Else
                Return parcaracter
            End If
        End If
    End Function

    Private Sub PLActualizar()
        SSTabHelper.SetSelectedIndex(MhTListaLimites, 0)
        If Not VLNumTranValido Then
            Exit Sub
        End If
        If TextValid.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1237), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If Check1.Checked = True And Math.Floor(CDbl(mskMonto(1).Text)) = StringsHelper.ToDoubleSafe("0.00") Then
            COBISMessageBox.Show(FMLoadResString(1235) + " --> " + Frame2(0).Text, FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskMonto(1).Focus()
            Exit Sub
        End If
        If Check2.Checked = True And Math.Floor(CDbl(mskMonto(2).Text)) = StringsHelper.ToDoubleSafe("0.00") Then
            COBISMessageBox.Show(FMLoadResString(1234) + " --> " + Frame2(0).Text, FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskMonto(2).Focus()
            Exit Sub
        End If
        If Check3.Checked = True And Math.Floor(CDbl(mskMonto(3).Text)) = StringsHelper.ToDoubleSafe("0.00") Then
            COBISMessageBox.Show(FMLoadResString(1235) + " -->" + Frame3(1).Text, FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskMonto(3).Focus()
            Exit Sub
        End If
        If Check4.Checked = True And Math.Floor(CDbl(mskMonto(4).Text)) = StringsHelper.ToDoubleSafe("0.00") Then
            COBISMessageBox.Show(FMLoadResString(1234) + " --> " + Frame3(1).Text, FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskMonto(4).Focus()
            Exit Sub
        End If
        If Math.Floor(CDbl(mskMonto(1).Text)) > StringsHelper.ToDoubleSafe("0.00") And Check1.Checked = CheckState.Unchecked Then
            Check1.Checked = 1
            Exit Sub
        End If
        If Math.Floor(CDbl(mskMonto(2).Text)) > StringsHelper.ToDoubleSafe("0.00") And Check2.Checked = CheckState.Unchecked Then
            Check2.Checked = 1
            Exit Sub
        End If
        If Math.Floor(CDbl(mskMonto(3).Text)) > StringsHelper.ToDoubleSafe("0.00") And Check3.Checked = CheckState.Unchecked Then
            Check3.Checked = 1
            Exit Sub
        End If
        If Math.Floor(CDbl(mskMonto(4).Text)) > StringsHelper.ToDoubleSafe("0.00") And Check4.Checked = CheckState.Unchecked Then
            Check4.Checked = 1
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(4128))
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
        If cmbTipo.SelectedIndex = 0 Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "4")
        ElseIf cmbTipo.SelectedIndex = 1 Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "3")
        End If
        PMPasoValores(sqlconn, "@i_cantidad", 0, SQLINT1, TextValid.Text)
        If Check1.Checked = True Then
            PMPasoValores(sqlconn, "@i_efectivo", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_valor_efe", 0, SQLMONEY, mskMonto(1).Text)
        End If
        If Check2.Checked = True Then
            PMPasoValores(sqlconn, "@i_chq_ger", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_valor_chq", 0, SQLMONEY, mskMonto(2).Text)
        End If
        If Math.Floor(CDbl(mskMonto(1).Text)) = StringsHelper.ToDoubleSafe("0.00") And Check1.Checked = CheckState.Unchecked And Math.Floor(CDbl(mskMonto(2).Text)) = StringsHelper.ToDoubleSafe("0.00") And Check2.Checked = CheckState.Unchecked Then
            COBISMessageBox.Show(FMLoadResString(1639), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Check1.Focus()
            Exit Sub
        End If
        If Check3.Checked = True Then
            PMPasoValores(sqlconn, "@i_efectivo_otra", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_valor_efe_otra", 0, SQLMONEY, mskMonto(3).Text)
        End If
        If Check2.Checked = True Then
            PMPasoValores(sqlconn, "@i_chq_ger_otra", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_valor_chq_otra", 0, SQLMONEY, mskMonto(4).Text)
        End If
        If Math.Floor(CDbl(mskMonto(3).Text)) = StringsHelper.ToDoubleSafe("0.00") And Check1.Checked = True And Math.Floor(CDbl(mskMonto(4).Text)) = StringsHelper.ToDoubleSafe("0.00") And Check4.Checked = True Then
            COBISMessageBox.Show(FMLoadResString(1639), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskMonto(3).Focus()
            Exit Sub
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_topes_oficina", True, FMLoadResString(1929)) Then
            PMMapeaGrid(sqlconn, grdVariables, False)
            'PMMapeaTextoGrid(grdVariables)
            PMAnchoColumnasGrid(grdVariables)
            PMChequea(sqlconn)
            grdVariables.Col = 1
            lblDescripcion(0).Text = grdVariables.CtlText
            'cmdBoton(2).Enabled = True
            'cmdBoton(5).Enabled = True
            'cmdBoton(1).Enabled = False
            'PLLimpiar(0)
            PLTSEstado()
            COBISMessageBox.Show(FMLoadResString(1681), FMLoadResString(1474), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
        Else
            PMChequea(sqlconn)
            PLLimpiar(0)
        End If
    End Sub

    Private Sub PLEliminar()
        Dim VLRespuesta As Integer = 0
        SSTabHelper.SetSelectedIndex(MhTListaLimites, 0)
        If grdVariables.Row > 0 Then
            VLRespuesta = COBISMessageBox.Show(FMLoadResString(1331), FMLoadResString(1867), COBISMessageBox.COBISButtons.OKCancel, COBISMessageBox.COBISIcon.Question, COBISMessageBox.COBISDefaultButton.Button2)
            If VLRespuesta = 2 Then
                Exit Sub
            End If
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(4128))
        If cmbTipo.SelectedIndex = 0 Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "4")
        ElseIf cmbTipo.SelectedIndex = 1 Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "3")
        End If
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_topes_oficina", True, FMLoadResString(1582)) Then
            PMChequea(sqlconn)
            PLLimpiar(0)
            COBISMessageBox.Show(FMLoadResString(1316), FMLoadResString(1474), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            TextValid.Focus()
        Else
            PLLimpiar(0)
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub BtnBuscarLim_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles BtnBuscarLim.Click
        PLBuscarLimites()
        If grdLimites.CtlText = "" Then
            COBISMessageBox.Show(FMLoadResString(1509), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
    End Sub

    Private Sub BtnAgregarLim_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles BtnAgregarLim.Click
        If txtOrigen.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1242), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If TextEspecie.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1239), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If CStr(mskNumTx.Text) = "" Then
            COBISMessageBox.Show(FMLoadResString(1241), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If CStr(mskMontoRetiro.Text) = "" Then
            COBISMessageBox.Show(FMLoadResString(1240), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(4156))
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "IO")
        PMPasoValores(sqlconn, "@i_lr_origen", 0, SQLINT2, txtOrigen.Text)
        PMPasoValores(sqlconn, "@i_lr_especie", 0, SQLINT2, TextEspecie.Text)
        PMPasoValores(sqlconn, "@i_lr_nro_transacciones", 0, SQLINT2, Replace(Replace(mskNumTx.Text, ",", ""), ".", ""))
        PMPasoValores(sqlconn, "@i_lr_monto_transacciones", 0, SQLMONEY, mskMontoRetiro.Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_topes_oficina", True, FMLoadResString(2530)) Then
            PMMapeaGrid(sqlconn, grdLimites, False)
            PMMapeaTextoGrid(grdLimites)
            PMAnchoColumnasGrid(grdLimites)
            PMChequea(sqlconn)
            grdLimites.Col = 1
            cmdBoton(1).Enabled = False
            cmdBoton(2).Enabled = True
            cmdBoton(5).Enabled = True
            BtnEliminarLim.Enabled = True
            PLTSEstado()
            COBISMessageBox.Show(FMLoadResString(1286), FMLoadResString(1474), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
        Else
            PMChequea(sqlconn)
        End If
        BtnBuscarLim_Click(BtnBuscarLim, New EventArgs())
    End Sub

    Private Sub BtnEliminarLim_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles BtnEliminarLim.Click
        Dim VLRespuesta As Integer = 0
        Dim VLPrimerCampo As String = ""

        If txtOrigen.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1242), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If

        If TextEspecie.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1239), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If

        If grdLimites.CtlText = "" Or grdLimites.Row = 0 Then
            COBISMessageBox.Show(FMLoadResString(1510), FMLoadResString(1474), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If grdLimites.Row > 0 Then
            VLRespuesta = COBISMessageBox.Show(FMLoadResString(1331), FMLoadResString(1867), COBISMessageBox.COBISButtons.OKCancel, COBISMessageBox.COBISIcon.Question, COBISMessageBox.COBISDefaultButton.Button2)
            If VLRespuesta = 2 Then
                Exit Sub
            End If
        End If
        MhTListaLimitesCurrentTab = 2
        PMBuscarCausal()
        grdCausales.Col = 1

        If grdCausales.Rows = 2 Then grdCausales.Row = 1

        If grdCausales.Cols > 2 Then grdCausales.Col = 1

        VLPrimerCampo = grdCausales.CtlText

        If grdCausales.Rows = 2 And VLPrimerCampo = "" Then
            MhTListaLimitesCurrentTab = 1
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(4156))
            PMPasoValores(sqlconn, "@i_lr_origen", 0, SQLINT2, txtOrigen.Text)
            PMPasoValores(sqlconn, "@i_lr_especie", 0, SQLINT1, TextEspecie.Text)
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "DO")
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_topes_oficina", True, FMLoadResString(2531)) Then
                PMChequea(sqlconn)
                MhTListaLimitesCurrentTab = 1
                PMLimpiaGrid(grdLimites)
                mskNumTx.Text = "0"
                mskMontoRetiro.Text = "0.00"
                COBISMessageBox.Show(FMLoadResString(1287), FMLoadResString(1474), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                PLLimpiar(1)
            Else
                PMChequea(sqlconn)
            End If
        Else
            COBISMessageBox.Show(FMLoadResString(1174), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            MhTListaLimitesCurrentTab = 2
            SSTabHelper.SetTabEnabled(MhTListaLimites, MhTListaLimitesCurrentTab, True)
            SSTabHelper.SetSelectedIndex(MhTListaLimites, 2)
        End If
        PLBuscarLimites()
    End Sub

    Private Sub BtnBuscarCau_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles BtnBuscarCau.Click
        MhTListaLimitesCurrentTab = 2
        SSTabHelper.SetTabEnabled(MhTListaLimites, MhTListaLimitesCurrentTab, True)
        SSTabHelper.SetSelectedIndex(MhTListaLimites, 2)

        If LblOrigen22.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1242), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If LblEspecie22.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1239), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If

        PMBuscarCausal()
    End Sub

    Private Sub BtnAgregarCau_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles BtnAgregarCau.Click
        If TextCausal.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1238), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If

        If LblOrigen22.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1242), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If LblEspecie22.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1239), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If

        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(4157))
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "IE")
        MhTListaLimitesCurrentTab = 1
        PMPasoValores(sqlconn, "@i_cr_origen", 0, SQLINT2, txtOrigen.Text)
        PMPasoValores(sqlconn, "@i_cr_especie", 0, SQLINT1, TextEspecie.Text)
        MhTListaLimitesCurrentTab = 2
        PMPasoValores(sqlconn, "@i_cr_causal", 0, SQLINT1, TextCausal.Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_topes_oficina", True, FMLoadResString(1931)) Then
            PMMapeaGrid(sqlconn, grdCausales, False)
            PMMapeaTextoGrid(grdCausales)
            PMAnchoColumnasGrid(grdCausales)
            PMChequea(sqlconn)
            grdCausales.Col = 1
            PLTSEstado()
            BtnEliminarCau.Enabled = True
            COBISMessageBox.Show(FMLoadResString(1286), FMLoadResString(1474), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
        Else
            PMChequea(sqlconn)
        End If
        PMBuscarCausal()
    End Sub

    Private Sub BtnEliminarCau_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles BtnEliminarCau.Click
        Dim VLRespuesta As Integer = 0

        If TextCausal.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1238), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            TextCausal.Focus()
            Exit Sub
        End If

        If LblOrigen22.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1242), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If LblEspecie22.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(1239), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If

        If grdCausales.CtlText = "" Or grdCausales.Row = 0 Then
            COBISMessageBox.Show(FMLoadResString(1510), FMLoadResString(1474), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If grdCausales.Row > 0 Then
            VLRespuesta = COBISMessageBox.Show(FMLoadResString(1331), FMLoadResString(1867), COBISMessageBox.COBISButtons.OKCancel, COBISMessageBox.COBISIcon.Question, COBISMessageBox.COBISDefaultButton.Button2)
            If VLRespuesta = 2 Then
                Exit Sub
            End If
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(4157))
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "DE")
        MhTListaLimitesCurrentTab = 1
        PMPasoValores(sqlconn, "@i_cr_origen", 0, SQLINT2, txtOrigen.Text)
        PMPasoValores(sqlconn, "@i_cr_especie", 0, SQLINT1, TextEspecie.Text)
        MhTListaLimitesCurrentTab = 2
        PMPasoValores(sqlconn, "@i_cr_causal", 0, SQLINT1, TextCausal.Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_topes_oficina", True, FMLoadResString(1932)) Then
            PMChequea(sqlconn)
            COBISMessageBox.Show(FMLoadResString(1287), FMLoadResString(1474), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            TextCausal.Text = ""
            lblCausal.Text = ""
            BtnEliminarCau.Enabled = False
        Else
            PMChequea(sqlconn)
        End If
        PMBuscarCausal()
    End Sub

    Private Sub mskNumTx_Enter(sender As Object, e As EventArgs) Handles mskNumTx.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1927))
    End Sub

    Private Sub mskNumTx_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskNumTx.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub mskNumTx_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskNumTx.Leave
        If Conversion.Val(mskNumTx.Text) < 0 Or Conversion.Val(mskNumTx.Text) > 999.0# Then
            mskNumTx.Text = "0"
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private Sub mskMontoRetiro_Enter(sender As Object, e As EventArgs) Handles mskMontoRetiro.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1928))
    End Sub

    Private Sub mskMontoRetiro_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs)
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If CDbl(mskMontoRetiro.Text) >= 9999999999.0# Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub mskMontoRetiro_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskMontoRetiro.Leave
        If Conversion.Val(mskMontoRetiro.Text) < 0 Or Conversion.Val(mskMontoRetiro.Text) > 9999999999.0# Then
            mskMontoRetiro.Text = "0.00"
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub TextValid_Enter(sender As Object, e As EventArgs) Handles TextValid.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1053))
    End Sub

    Private Sub TextValid_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles TextValid.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(EventArgs.KeyChar)
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub TextValid_Leave(sender As Object, e As EventArgs) Handles TextValid.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
        Dim VLValid As Integer
        If Not VLPaso Then
            If TextValid.Text = "" Then
                VLValid = 0
            Else
                VLValid = CInt(TextValid.Text)
            End If
            If VLValid > 255 Then
                COBISMessageBox.Show(FMLoadResString(1422), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                VLNumTranValido = False
                TextValid.Text = ""
                TextValid.Focus()
                Exit Sub
            Else
                VLNumTranValido = True
            End If
        End If

        VLPaso = True



    End Sub

    Private Sub TextValid_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles TextValid.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
        '  VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1530))
        'If TextValid.Text <> "" Then
        '    mskMonto(1).Enabled = False
        '    mskMonto(2).Enabled = False
        '    mskMonto(3).Enabled = False
        '    mskMonto(4).Enabled = False
        '    Check1.Checked = "0"
        '    Check2.Checked = "0"
        '    Check3.Checked = "0"
        '    Check4.Checked = "0"
        'End If
    End Sub

    Private Sub MhTListaLimites_SelectedIndexChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MhTListaLimites.SelectedIndexChanged
        Dim NewFolder As Integer = SSTabHelper.GetSelectedIndex(MhTListaLimites)
        Dim OldFolder As Integer = MhTListaLimitesPreviousTab
        MhTListaLimites_TabChangedHelper(NewFolder, OldFolder)
        MhTListaLimitesPreviousTab = MhTListaLimites.SelectedIndex
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_3.Enabled
        TSBLimpiar.Visible = _cmdBoton_3.Visible
        TSBSalir.Enabled = _cmdBoton_4.Enabled
        TSBCrear.Enabled = _cmdBoton_1.Enabled
        TSBCrear.Visible = _cmdBoton_1.Visible
        TSBEliminar.Enabled = _cmdBoton_2.Enabled
        TSBEliminar.Visible = _cmdBoton_2.Visible
        TSBActualizar.Enabled = _cmdBoton_5.Enabled
        TSBActualizar.Visible = _cmdBoton_5.Visible
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

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        SSTabHelper.SetSelectedIndex(MhTListaLimites, 0)
        MhTListaLimitesCurrentTab = 0
        mskMonto(1).Enabled = False
        mskMonto(2).Enabled = False
        mskMonto(3).Enabled = False
        mskMonto(4).Enabled = False
        cmdBoton(5).Enabled = False
        cmdBoton(2).Enabled = False
        If SSTabHelper.GetSelectedIndex(MhTListaLimites) = 1 Then
            If grdLimites.CtlText = "" Or grdLimites.Row = 0 Then
                MhTListaLimitesCurrentTab = 2
                SSTabHelper.SetSelectedIndex(MhTListaLimites, 2)
                SSTabHelper.SetTabEnabled(MhTListaLimites, MhTListaLimitesCurrentTab, False)
                MhTListaLimitesCurrentTab = 1
                SSTabHelper.SetSelectedIndex(MhTListaLimites, 1)
            End If
        End If
        If SSTabHelper.GetSelectedIndex(MhTListaLimites) = 0 Then
            cmdBoton(0).Enabled = True
            mskMonto(1).Enabled = False
            mskMonto(2).Enabled = False
            mskMonto(3).Enabled = False
            mskMonto(4).Enabled = False
            MhTListaLimitesCurrentTab = 0
            SSTabHelper.SetSelectedIndex(MhTListaLimites, 0)
        Else
            cmdBoton(0).Enabled = False
        End If
        PLTSEstado()
        cmbTipo.Focus()
    End Sub

    Private Sub mskMonto_Leave(sender As Object, e As EventArgs) Handles _mskMonto_1.Leave, _mskMonto_4.Leave, _mskMonto_3.Leave, _mskMonto_2.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private Sub Check1_Enter(sender As Object, e As EventArgs) Handles Check1.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1221))
    End Sub

    Private Sub Check2_Enter(sender As Object, e As EventArgs) Handles Check2.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1079))
    End Sub

    Private Sub Check1_Leave(sender As Object, e As EventArgs) Handles Check1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private Sub Check2_Leave(sender As Object, e As EventArgs) Handles Check2.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private Sub Check3_Enter(sender As Object, e As EventArgs) Handles Check3.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1221))
    End Sub

    Private Sub Check3_Leave(sender As Object, e As EventArgs) Handles Check3.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private Sub Check4_Enter(sender As Object, e As EventArgs) Handles Check4.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1079))
    End Sub

    Private Sub Check4_Leave(sender As Object, e As EventArgs) Handles Check4.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private Sub cmbTipo_Enter(sender As Object, e As EventArgs) Handles cmbTipo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1653))
    End Sub

    Private Sub cmbTipo_Leave(sender As Object, e As EventArgs) Handles cmbTipo.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private Sub grdCausales_Enter(sender As Object, e As EventArgs) Handles grdCausales.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1393))
    End Sub

    Private Sub grdCausales_Leave(sender As Object, e As EventArgs) Handles grdCausales.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private Sub grdLimites_Enter(sender As Object, e As EventArgs) Handles grdLimites.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1393))
    End Sub

    Private Sub grdLimites_Leave(sender As Object, e As EventArgs) Handles grdLimites.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private Sub txtOrigen_Enter(sender As Object, e As EventArgs) Handles txtOrigen.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1617))
    End Sub

    Private Sub txtOrigen_KeyDown(sender As Object, eventArgs As KeyEventArgs) Handles txtOrigen.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        If KeyCode = VGTeclaAyuda Then
            PMCatalogo("A", "pe_lt_origen", txtOrigen, lblOrigen, FRegistros)
            VLPaso = True
        End If
    End Sub

    Private Sub txtOrigen_KeyPress(sender As Object, eventArgs As KeyPressEventArgs) Handles txtOrigen.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtOrigen_Leave(sender As Object, eventArgs As EventArgs) Handles txtOrigen.Leave
        If Not VLPaso Then
            If txtOrigen.Text = "" Then
                lblOrigen.Text = ""
            Else
                PMCatalogo("V", "pe_lt_origen", txtOrigen, lblOrigen, Nothing)
                If txtOrigen.Text = "" Or lblOrigen.Text = "" Then
                    txtOrigen.Focus()
                Else
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(FMLoadResString(1573))
                End If

            End If
            BtnEliminarLim.Enabled = False

            MhTListaLimitesCurrentTab = 2
            'SSTabHelper.SetSelectedIndex(MhTListaLimites, 2)
            SSTabHelper.SetTabEnabled(MhTListaLimites, MhTListaLimitesCurrentTab, False)
        End If

        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub txtOrigen_StyleChanged(sender As Object, e As EventArgs) Handles txtOrigen.StyleChanged

    End Sub

    Private Sub txtOrigen_TextChanged(sender As Object, eventArgs As EventArgs) Handles txtOrigen.TextChanged
        VLPaso = False



    End Sub

    Private Sub TextCausal_Enter(sender As Object, eventArgs As EventArgs) Handles TextCausal.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1074))
    End Sub

    Private Sub TextEspecie_Enter(sender As Object, eventArgs As EventArgs) Handles TextEspecie.Enter
        VLPaso = True
        ' COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1329))
    End Sub

    Private Sub TextEspecie_KeyDown(sender As Object, eventArgs As KeyEventArgs) Handles TextEspecie.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        If KeyCode = VGTeclaAyuda Then
            PMCatalogo("A", "pe_lt_especie", TextEspecie, lblEspecie, FRegistros)
            VLPaso = True
        End If
    End Sub

    Private Sub TextEspecie_KeyPress(sender As Object, eventArgs As KeyPressEventArgs) Handles TextEspecie.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub TextEspecie_Leave(sender As Object, eventArgs As EventArgs) Handles TextEspecie.Leave
        If Not VLPaso Then
            If TextEspecie.Text = "" Then
                lblEspecie.Text = ""
            Else
                PMCatalogo("V", "pe_lt_especie", TextEspecie, lblEspecie, Nothing)
                If TextEspecie.Text = "" Or lblEspecie.Text = "" Then
                    TextEspecie.Focus()
                Else
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(FMLoadResString(1573))
                End If
            End If
            BtnEliminarLim.Enabled = False

            MhTListaLimitesCurrentTab = 2
            SSTabHelper.SetTabEnabled(MhTListaLimites, MhTListaLimitesCurrentTab, False)
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub


    Private Sub TextEspecie_TextChanged(sender As Object, eventArgs As EventArgs) Handles TextEspecie.TextChanged
        VLPaso = False
    End Sub


    Private Sub TextCausal_KeyDown(sender As Object, eventArgs As KeyEventArgs) Handles TextCausal.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        If KeyCode = VGTeclaAyuda Then
            PMCatalogo("A", "ah_causa_nd", TextCausal, lblCausal, FRegistros)
            VLPaso = True
            BtnEliminarCau.Enabled = False
        End If
    End Sub

    Private Sub TextCausal_KeyPress(sender As Object, eventArgs As KeyPressEventArgs) Handles TextCausal.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub TextCausal_Leave(sender As Object, eventArgs As EventArgs) Handles TextCausal.Leave
        VLPaso = False
        If Not VLPaso Then
            If TextCausal.Text = "" Then
                lblCausal.Text = ""
                BtnEliminarCau.Enabled = False
            Else
                PMCatalogo("V", "ah_causa_nd", TextCausal, lblCausal, Nothing)
                If TextCausal.Text = "" Or lblCausal.Text = "" Then
                    TextCausal.Focus()
                End If
            End If
        Else
            BtnEliminarCau.Enabled = False
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private Sub PLBuscarLimites()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(4129))
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "SO")
        PMPasoValores(sqlconn, "@i_lr_origen", 0, SQLINT2, txtOrigen.Text)
        PMPasoValores(sqlconn, "@i_lr_especie", 0, SQLINT1, TextEspecie.Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_topes_oficina", True, FMLoadResString(2529)) Then
            PMMapeaGrid(sqlconn, grdLimites, False)
            PMMapeaTextoGrid(grdLimites)
            PMAnchoColumnasGrid(grdLimites)
            PMChequea(sqlconn)
            grdLimites.Col = 1
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub PMBuscarCausal()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(4129))
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "SE")
        PMPasoValores(sqlconn, "@i_cr_origen", 0, SQLINT2, LblOrigen22.Text)
        PMPasoValores(sqlconn, "@i_cr_especie", 0, SQLINT1, LblEspecie22.Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_topes_oficina", True, FMLoadResString(1930)) Then
            PMMapeaGrid(sqlconn, grdCausales, False)
            PMMapeaTextoGrid(grdCausales)
            PMAnchoColumnasGrid(grdCausales)
            PMChequea(sqlconn)
            grdCausales.Col = 1
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub PMLimpiarTab0(productoSeleccionado As Integer)
        MhTListaLimitesCurrentTab = 0
        PMLimpiaGrid(grdVariables)
        TextValid.Text = ""
        cmbTipo.SelectedIndex = productoSeleccionado
        mskMonto(1).Text = "0.00"
        mskMonto(2).Text = "0.00"
        mskMonto(3).Text = "0.00"
        mskMonto(4).Text = "0.00"
        Check1.Checked = "0"
        Check2.Checked = "0"
        Check3.Checked = "0"
        Check4.Checked = "0"
        lblDescripcion(0).Text = ""
        cmbTipo.Enabled = True

        cmdBoton(2).Enabled = False
        cmdBoton(5).Enabled = False
        cmdBoton(1).Enabled = True

        PLTSEstado()
        TextValid.Focus()

    End Sub

    Private Sub cmbTipo_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cmbTipo.SelectedIndexChanged
        PMLimpiarTab0(cmbTipo.SelectedIndex)
    End Sub

    Private Sub MhTListaLimites_Enter(sender As Object, e As EventArgs) Handles MhTListaLimites.Enter
        If MhTListaLimitesCurrentTab = 0 Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502043))
        Else
            If MhTListaLimitesCurrentTab = 1 Then
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502042))
            Else
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502044))
            End If
        End If
        

    End Sub

    Private Sub BtnBuscarLim_Enter(sender As Object, e As EventArgs) Handles BtnBuscarLim.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2532))
    End Sub

    Private Sub BtnAgregarLim_Enter(sender As Object, e As EventArgs) Handles BtnAgregarLim.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2533))
    End Sub

    Private Sub BtnEliminarLim_Enter(sender As Object, e As EventArgs) Handles BtnEliminarLim.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2534))
    End Sub

    Private Sub BtnBuscarLim_Leave(sender As Object, e As EventArgs) Handles BtnBuscarLim.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private Sub BtnAgregarLim_Leave(sender As Object, e As EventArgs) Handles BtnAgregarLim.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private Sub BtnEliminarLim_Leave(sender As Object, e As EventArgs) Handles BtnEliminarLim.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private Sub BtnBuscarCau_Enter(sender As Object, e As EventArgs) Handles BtnBuscarCau.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2535))
    End Sub

    Private Sub BtnBuscarCau_Leave(sender As Object, e As EventArgs) Handles BtnBuscarCau.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private Sub BtnAgregarCau_Enter(sender As Object, e As EventArgs) Handles BtnAgregarCau.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2536))
    End Sub

    Private Sub BtnAgregarCau_Leave(sender As Object, e As EventArgs) Handles BtnAgregarCau.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub

    Private Sub BtnEliminarCau_Enter(sender As Object, e As EventArgs) Handles BtnEliminarCau.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2537))
    End Sub

    Private Sub BtnEliminarCau_Leave(sender As Object, e As EventArgs) Handles BtnEliminarCau.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
    End Sub
End Class


