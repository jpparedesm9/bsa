Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class Ftran2797Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim FBuscarCliente As COBISCorp.tCOBIS.BClientes.FBuscarClienteClass
    Dim FDatoCliente As COBISCorp.tCOBIS.BClientes.BuscarClientes
    Dim VLPaso As Integer = 0
    Dim VLFormatoFecha As String = ""
    Dim VTProducto As String = ""
    Dim VLProducto As String = ""
    Dim VGCliente As Double = 0
    Dim VLTced As String = ""
    Dim VLPApe As String = ""
    Dim VLSApe As String = ""
    Dim VLNomb As String = ""
    Dim VTFecha1 As String = ""
    Dim VTFecha2 As String = ""

    Private Sub PLBuscar(ByRef Index As Integer)
        Dim VLregistros As Integer = grdChequeras.Rows - 1
        PMChequea(sqlconn)
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2796")
        If Index = 1 Then
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT4, "1")
        Else
            grdChequeras.Row = grdChequeras.Rows - 1
            grdChequeras.Col = 31
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT4, "0")
            PMPasoValores(sqlconn, "@i_consecutivo", 0, SQLINT4, grdChequeras.CtlText)
            grdChequeras.Col = 0
            PMPasoValores(sqlconn, "@i_pivote", 0, SQLINT4, grdChequeras.CtlText)
        End If
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT4, txtOficRecep.Text)
        PMPasoValores(sqlconn, "@i_fecha_fin", 0, SQLDATETIME, FMConvFecha(mskFechaFin.Text, VLFormatoFecha, "mm/dd/yyyy"))
        PMPasoValores(sqlconn, "@i_fecha_ini", 0, SQLDATETIME, FMConvFecha(mskFechaIni.Text, VLFormatoFecha, "mm/dd/yyyy"))
        PMPasoValores(sqlconn, "@i_valor_inicial", 0, SQLMONEY, MhRealValor(0).Text)
        PMPasoValores(sqlconn, "@i_valor_final", 0, SQLMONEY, MhRealValor(1).Text)
        If Option1(0).Checked Then
            PMPasoValores(sqlconn, "@i_accion", 0, SQLINT4, "0")
            PMPasoValores(sqlconn, "@i_tipo_doc_e", 0, SQLVARCHAR, cmbide(0).Text)
            PMPasoValores(sqlconn, "@i_cedula_e", 0, SQLVARCHAR, Maskpers_ced_nit(0).ClipText)
        ElseIf Option1(1).Checked Then
            PMPasoValores(sqlconn, "@i_accion", 0, SQLINT4, "1")
            PMPasoValores(sqlconn, "@i_tipo_doc_t", 0, SQLVARCHAR, cmbide(1).Text)
            PMPasoValores(sqlconn, "@i_cedula_t", 0, SQLVARCHAR, Maskpers_ced_nit(1).ClipText)
        ElseIf Option1(2).Checked Then
            PMPasoValores(sqlconn, "@i_accion", 0, SQLINT4, "2")
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, cmbTipo(1).Text)
            PMPasoValores(sqlconn, "@i_iden", 0, SQLVARCHAR, Ide.Text)
            PMPasoValores(sqlconn, "@i_numcta", 0, SQLVARCHAR, mskCuenta.ClipText)
        ElseIf Option1(3).Checked Then
            PMPasoValores(sqlconn, "@i_accion", 0, SQLINT4, "3")
            PMPasoValores(sqlconn, "@i_num_doc_benef", 0, SQLVARCHAR, Maskpers_ced_nit(3).ClipText)
            PMPasoValores(sqlconn, "@i_tipo_doc_benef", 0, SQLVARCHAR, cmbide(3).Text)
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_control_efectivo", True, FMLoadResString(508844)) Then
            If Index = 0 Then
                PMMapeaGrid(sqlconn, grdChequeras, True)
            Else
                PMMapeaGrid(sqlconn, grdChequeras, False)
                cmdBoton(0).Enabled = True
            End If
            PMChequea(sqlconn)
            If VLregistros = grdChequeras.Rows - 1 Then
                COBISMessageBox.Show(FMLoadResString(508566), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtOficRecep.Enabled = True
                mskFechaIni.Enabled = True
                mskFechaFin.Enabled = True
                MhRealValor(0).Enabled = True
                MhRealValor(1).Enabled = True
                PLLimpiar()
                PLTSEstado()
                Exit Sub
            End If
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub ChkFiltros_CheckStateChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles ChkFiltros.CheckStateChanged
        If ChkFiltros.CheckState = CheckState.Checked Then
            ChkFiltros.Text = FMLoadResString(509279)
            PLHabilitarFiltros(True)
        Else
            ChkFiltros.Text = FMLoadResString(509280)
            PLHabilitarFiltros(False)
        End If
    End Sub

    Private Sub ChkFiltros_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles ChkFiltros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508431))
    End Sub

    Private Sub cmbide_SelectedIndexChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmbide_1.SelectedIndexChanged, _cmbide_0.SelectedIndexChanged, _cmbide_3.SelectedIndexChanged
        Dim Index As Integer = Array.IndexOf(cmbide, eventSender)
        Select Case cmbide(Index).Text
            Case "CC"
                Maskpers_ced_nit(Index).Mask = "##-###-###"
                Maskpers_ced_nit(Index).MaxLength = 8
            Case "TI"
                Maskpers_ced_nit(Index).Mask = "######-#####"
                Maskpers_ced_nit(Index).MaxLength = 11
            Case "CE"
                Maskpers_ced_nit(Index).Mask = "###-###"
                Maskpers_ced_nit(Index).MaxLength = 6
            Case "NI"
                Maskpers_ced_nit(Index).Mask = "###-###-###-#"
                Maskpers_ced_nit(Index).MaxLength = 10
            Case "PA"
                Maskpers_ced_nit(Index).Text = ""
                Maskpers_ced_nit(Index).Mask = ""
                Maskpers_ced_nit(Index).Text = ""
                Maskpers_ced_nit(Index).MaxLength = 14
            Case Else
                Maskpers_ced_nit(Index).Text = ""
                Maskpers_ced_nit(Index).Mask = ""
                Maskpers_ced_nit(Index).Text = ""
                Maskpers_ced_nit(Index).MaxLength = 14
        End Select
        Maskpers_ced_nit(Index).Focus()
    End Sub

    Private Sub cmbide_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmbide_1.Enter, _cmbide_0.Enter, _cmbide_3.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508726))
    End Sub

    Private Sub cmbide_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _cmbide_1.KeyPress, _cmbide_0.KeyPress, _cmbide_3.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(cmbide, eventSender)
        Select Case Index
            Case 0, 1
                If KeyAscii = Strings.AscW("+") Then
                    KeyAscii = 0
                    If KeyAscii = 0 Then
                        eventArgs.Handled = True
                    End If
                    Exit Sub
                End If
                If KeyAscii = Strings.AscW("-") Then
                    KeyAscii = 0
                    If KeyAscii = 0 Then
                        eventArgs.Handled = True
                    End If
                    Exit Sub
                End If
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub cmbTipo_SelectedIndexChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmbTipo_1.SelectedIndexChanged, _cmbTipo_2.SelectedIndexChanged, _cmbTipo_0.SelectedIndexChanged
        Dim Index As Integer = Array.IndexOf(cmbTipo, eventSender)
        Select Case Index
            Case 0
                mskCuenta.Mask = ""
                mskCuenta.Text = ""
                txtNomCta.Text = ""
                VGCliente = 0
                Ide.Text = ""
                If cmbTipo(0).Text <> FMLoadResString(502554) And cmbTipo(0).Text <> FMLoadResString(502556) Then
                    txtNomCta.ReadOnly = False
                    Ide.ReadOnly = False
                Else
                    If cmbTipo(0).Text = FMLoadResString(502554) Then
                        mskCuenta.Mask = VGMascaraCtaCte
                    ElseIf cmbTipo(0).Text = FMLoadResString(502556) Then
                        mskCuenta.Mask = VGMascaraCtaAho
                    End If
                    txtNomCta.ReadOnly = True
                    Ide.ReadOnly = True
                End If
                VLPaso = True
                If cmbTipo(0).Text = FMLoadResString(502554) Or cmbTipo(0).Text = FMLoadResString(502556) Or cmbTipo(0).Text = FMLoadResString(509281) Then
                    lblEtiqueta(14).Text = FMLoadResString(509282)
                Else
                    lblEtiqueta(14).Text = FMLoadResString(509283)
                End If
                cmbTipo(1).SelectedIndex = cmbTipo(0).SelectedIndex
                VTProducto = cmbTipo(1).Text
                cmbTipo(2).SelectedIndex = cmbTipo(0).SelectedIndex
                VLProducto = cmbTipo(2).Text
        End Select
    End Sub

    Private Sub cmbTipo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmbTipo_1.Enter, _cmbTipo_2.Enter, _cmbTipo_0.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503339))
    End Sub

    Private Sub cmbTipo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _cmbTipo_1.KeyPress, _cmbTipo_2.KeyPress, _cmbTipo_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(cmbTipo, eventSender)
        Select Case Index
            Case 0, 1
                If KeyAscii = Strings.AscW("+") Then
                    KeyAscii = 0
                    If KeyAscii = 0 Then
                        eventArgs.Handled = True
                    End If
                    Exit Sub
                End If
                If KeyAscii = Strings.AscW("-") Then
                    KeyAscii = 0
                    If KeyAscii = 0 Then
                        eventArgs.Handled = True
                    End If
                    Exit Sub
                End If
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_0.Click, _cmdBoton_4.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        TSBBotones.Focus()
        Select Case Index
            Case 0
                If PLValida_Campos() Then
                    PLBuscar(Index)
                End If
            Case 1
                If PLValida_Campos() Then
                    PLBuscar(Index)
                    grdChequeras.Focus()
                End If
            Case 2
                PLLimpiar()
            Case 3
                PLSalir()
            Case 4
                PLExcel()
        End Select
    End Sub

    Private Sub Ftran2797_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()

        'LimpiarFechas()

    End Sub

    Public Sub PLInicializar()
        Dim VTModo As Integer = False
        Dim VLModo As Integer = 0
        VLProducto = CStr(0)
        Do While 1 = 1
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "15029")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, CStr(VLModo))
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VLProducto)
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "R")
            PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_producto", True, FMLoadResString(508824)) Then
                PMMapeaGrid(sqlconn, grdProductos, VTModo)
                PMChequea(sqlconn)
                If Conversion.Val(Convert.ToString(grdProductos.Tag)) >= VGMaximoRows - 1 Then
                    grdProductos.Col = 1
                    grdProductos.Row = grdProductos.Rows - 1
                    VLProducto = grdProductos.CtlText
                    VTModo = True
                    VLModo = 1
                Else
                    Exit Do
                End If
            Else
                PMChequea(sqlconn)
                Exit Do
            End If
        Loop
        grdProductos.Row = 0
        Dim VLAbrv As String = ""
        Dim j As Integer = 0
        If Conversion.Val(Convert.ToString(grdProductos.Tag)) > 0 Then
            cmbTipo(0).Items.Clear()
            cmbTipo(1).Items.Clear()
            cmbTipo(2).Items.Clear()
            For i As Integer = 1 To grdProductos.Rows - 1
                grdProductos.Row = i
                grdProductos.Col = 4
                VLAbrv = grdProductos.CtlText
                If VLAbrv = "CTE" Or VLAbrv = "AHO" Or VLAbrv = "CCA" Or VLAbrv = "CEX" Or VLAbrv = "TES" Or VLAbrv = "ATX" Or VLAbrv = "PFI" Or VLAbrv = "GAR" Or VLAbrv = "CRE" Or VLAbrv = "SBA" Or VLAbrv = "SAC" Or VLAbrv = "BON" Or VLAbrv = "ACH" Then
                    grdProductos.Col = 3
                    cmbTipo(0).Items.Add(grdProductos.CtlText)
                    grdProductos.Col = 1
                    cmbTipo(1).Items.Add(grdProductos.CtlText)
                    grdProductos.Col = 4
                    cmbTipo(2).Items.Add(grdProductos.CtlText)
                    j += 1
                End If
            Next i
        Else
            Exit Sub
        End If
        cmbTipo(0).SelectedIndex = 1
        cmbide(0).Items.Insert(0, "CC")
        cmbide(0).Items.Insert(1, "TI")
        cmbide(0).Items.Insert(2, "CE")
        cmbide(0).Items.Insert(3, "NI")
        cmbide(0).Items.Insert(4, "PA")
        cmbide(0).Items.Insert(5, "N")
        cmbide(0).Items.Insert(6, "S")
        cmbide(1).Items.Insert(0, "CC")
        cmbide(1).Items.Insert(1, "TI")
        cmbide(1).Items.Insert(2, "CE")
        cmbide(1).Items.Insert(3, "NI")
        cmbide(1).Items.Insert(4, "PA")
        cmbide(1).Items.Insert(5, "N")
        cmbide(1).Items.Insert(6, "S")
        cmbide(3).Items.Insert(0, "CC")
        cmbide(3).Items.Insert(1, "TI")
        cmbide(3).Items.Insert(2, "CE")
        cmbide(3).Items.Insert(3, "NI")
        cmbide(3).Items.Insert(4, "PA")
        cmbide(3).Items.Insert(5, "N")
        cmbide(3).Items.Insert(6, "S")
        cmbide(0).SelectedIndex = 0
        cmbide(1).SelectedIndex = 0
        cmbide(3).SelectedIndex = 0
        VLFormatoFecha = VGFormatoFecha
        mskFechaIni.Mask = FMMascaraFecha(VLFormatoFecha)
        mskFechaIni.Text = FMDateAdd(VGFechaProceso, "d", 0, VGFormatoFecha)
        mskFechaFin.Mask = FMMascaraFecha(VLFormatoFecha)
        mskFechaFin.Text = FMDateAdd(VGFechaProceso, "d", 1, VGFormatoFecha)
        mskCuenta.Mask = VGMascaraCtaCte
        mskFechaIni.MaxLength = 14
        mskFechaFin.MaxLength = 14
        txtOficRecep.Text = VGOficina
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, CStr(1572))
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT4, txtOficRecep.Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_oficina", True, FMLoadResString(502504) & txtOficRecep.Text & "]") Then
            Dim VLDatosOficina(20) As String
            FMMapeaArreglo(sqlconn, VLDatosOficina)
            lblOfiRecep.Text = VLDatosOficina(5)
            PMChequea(sqlconn)
        End If
        PLHabilitarFiltros(False)
        PLTSEstado()
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub Ide_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles Ide.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub Ide_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles Ide.Enter
        If Not Ide.ReadOnly Then
            If VGCliente <> 0 Then Ide.Text = CStr(VGCliente)
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508514))
            Label7(2).Text = "Cliente:"
            Ide.SelectionStart = 0
            Ide.SelectionLength = Strings.Len(Ide.Text)
        End If
    End Sub

    Private Sub Ide_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles Ide.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Ideuno As String = String.Empty
        If Keycode = VGTeclaAyuda Then
            Ide.Text = ""
            VGCliente = 0
            VLPaso = True
            'FBuscarCliente.ShowPopup(Me)
            'DLL CLIENTES KAMILO
            FBuscarCliente = New COBISCorp.tCOBIS.BClientes.FBuscarClienteClass()
            FDatoCliente = New COBISCorp.tCOBIS.BClientes.BuscarClientes()
            FBuscarCliente.optCliente(1).Enabled = True
            FBuscarCliente.optCliente(0).Checked = True
            FBuscarCliente.ShowPopup(Me)
            FBuscarCliente.optCliente(1).Enabled = True
            VGBusqueda = FDatoCliente.PMRetornaCliente()
            If VGBusqueda(1) <> "" Then
                VGCliente = CDbl(VGBusqueda(1))
                If VGBusqueda(0) = "P" Then
                    Ideuno = VGBusqueda(5)
                    VLPApe = VGBusqueda(2).Trim()
                    VLSApe = VGBusqueda(3).Trim()
                    VLNomb = VGBusqueda(4).Trim()
                    VLTced = VGBusqueda(6).Trim()
                Else
                    Ideuno = VGBusqueda(3)
                End If
                If Ideuno.Length = 8 Then
                    Ide.Text = Strings.Mid(Ideuno, 1, 2) & "-" & Strings.Mid(Ideuno, 3, 3) & "-" & Strings.Mid(Ideuno, 6, 3)
                    txtNomCta.Text = VLNomb & " " & VLPApe & " " & VLSApe
                ElseIf Ideuno.Length = 11 Then
                    Ide.Text = Strings.Mid(Ideuno, 1, 6) & "-" & Strings.Mid(Ideuno, 7, 5)
                    txtNomCta.Text = VLNomb & " " & VLPApe & " " & VLSApe
                ElseIf Ideuno.Length = 6 Then
                    Ide.Text = Strings.Mid(Ideuno, 1, 3) & "-" & Strings.Mid(Ideuno, 4, 3)
                    txtNomCta.Text = VLNomb & " " & VLPApe & " " & VLSApe
                ElseIf Ideuno.Length = 10 Then
                    Ide.Text = Strings.Mid(Ideuno, 1, 3) & "-" & Strings.Mid(Ideuno, 4, 3) & "-" & Strings.Mid(Ideuno, 7, 3) & "-" & Strings.Mid(Ideuno, 10, 1)
                    txtNomCta.Text = VLNomb & " " & VLPApe & " " & VLSApe
                Else
                    Ide.Text = Ideuno
                    txtNomCta.Text = VLNomb & " " & VLPApe & " " & VLSApe
                    VLTced = "NA"
                End If
                VLPaso = True
                If Ide.Text <> VGBusqueda(3) Then
                    PLLimpiaObjOption(1)
                    PLLimpiaObjOption(2)
                End If
                Label7(2).Text = FMLoadResString(501112)
                Ide.Text = Ideuno
                txtNomCta.Text = VLNomb & " " & VLPApe & " " & VLSApe
            Else
                Ide.Text = ""
                txtNomCta.Text = ""
                Label7(2).Text = FMLoadResString(500163)
                VLPaso = True
            End If
        End If
    End Sub

    Private Sub Ide_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles Ide.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub Ide_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles Ide.Leave
        Dim LenIdeuno As String = String.Empty
        Dim Ideuno As String = String.Empty
        If Not VLPaso And Not Ide.ReadOnly Then
            VGCliente = 0
            If Ide.Text <> "" Then
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                PMPasoValores(sqlconn, "@i_cliente", 0, SQLINT4, Ide.Text)
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2543")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_desc_cliente_cc", True, FMLoadResString(2239) & Ide.Text & "]") Then
                    Dim VTValores(10) As String
                    FMMapeaArreglo(sqlconn, VTValores)
                    PMChequea(sqlconn)
                    VGCliente = CDbl(Ide.Text)
                    VLTced = VTValores(5).Trim()
                    If VLTced = "CC" Then
                        VLNomb = VTValores(6).Trim()
                        VLPApe = VTValores(7).Trim()
                        VLSApe = VTValores(8).Trim()
                    Else
                        VLNomb = VTValores(2).Trim()
                        VLPApe = ""
                        VLSApe = ""
                    End If
                    Select Case VLTced
                        Case "CC"
                            LenIdeuno = CStr(8)
                        Case "TI"
                            LenIdeuno = CStr(11)
                        Case "CE"
                            LenIdeuno = CStr(6)
                        Case "NI"
                            LenIdeuno = CStr(10)
                        Case "PA"
                            LenIdeuno = CStr(14)
                        Case Else
                            LenIdeuno = CStr(14)
                    End Select
                    Ideuno = New String(" ", Math.Abs(CDbl(LenIdeuno) - VTValores(1).Trim().Length)) & VTValores(1).Trim()
                    If StringsHelper.ToDoubleSafe(LenIdeuno) = 8 Then
                        Ide.Text = Strings.Mid(Ideuno, 1, 2) & "-" & Strings.Mid(Ideuno, 3, 3) & "-" & Strings.Mid(Ideuno, 6, 3)
                    ElseIf StringsHelper.ToDoubleSafe(LenIdeuno) = 11 Then
                        Ide.Text = Strings.Mid(Ideuno, 1, 6) & "-" & Strings.Mid(Ideuno, 7, 5)
                    ElseIf StringsHelper.ToDoubleSafe(LenIdeuno) = 6 Then
                        Ide.Text = Strings.Mid(Ideuno, 1, 3) & "-" & Strings.Mid(Ideuno, 4, 3)
                    ElseIf StringsHelper.ToDoubleSafe(LenIdeuno) = 10 Then
                        Ide.Text = Strings.Mid(Ideuno, 1, 3) & "-" & Strings.Mid(Ideuno, 4, 3) & "-" & Strings.Mid(Ideuno, 7, 3) & "-" & Strings.Mid(Ideuno, 10, 1)
                    ElseIf StringsHelper.ToDoubleSafe(LenIdeuno) = 14 Then
                        Ide.Text = Strings.Mid(Ideuno, 1, 14)
                    Else
                        Ide.Text = Ideuno
                        VLTced = "NA"
                    End If
                    Ide.Text = Ide.Text.Trim()
                    Label7(2).Text = FMLoadResString(501112)
                Else
                    PMChequea(sqlconn)
                    Ide.Text = ""
                    Ide.Focus()
                    Label7(2).Text = FMLoadResString(500163)
                End If
                VLPaso = True
            End If
        End If
    End Sub

    Private Sub Maskpers_ced_nit_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _Maskpers_ced_nit_1.Enter, _Maskpers_ced_nit_0.Enter, _Maskpers_ced_nit_3.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501539))
    End Sub

    Private Sub MhRealValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _MhRealValor_1.Enter, _MhRealValor_0.Enter
        Dim Index As Integer = Array.IndexOf(MhRealValor, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508714))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508713))
        End Select
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500194))
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
    End Sub

    Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        Dim VLExcSipla As String = ""
        Dim leedir As Integer = 0
        Try
            If cmbTipo(0).Text <> FMLoadResString(502554) And cmbTipo(0).Text <> FMLoadResString(502556) Then
                txtNomCta.ReadOnly = False
                Ide.ReadOnly = False
            Else
                txtNomCta.ReadOnly = True
                Ide.ReadOnly = True
                If mskCuenta.ClipText <> "" Then
                    If cmbTipo(0).Text = FMLoadResString(502554) Then
                        VLProducto = "CTE"
                        If Not VLPaso Then
                            If FMChequeaCtaCte(mskCuenta.ClipText) Then
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "16")
                                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                                PMPasoValores(sqlconn, "@i_cerrada", 0, SQLCHAR, "C")
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, FMLoadResString(2237) & mskCuenta.Text & "]") Then
                                    PMMapeaObjeto(sqlconn, txtNomCta)
                                    PMChequea(sqlconn)
                                    leedir = 1
                                Else
                                    PMChequea(sqlconn)
                                    mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                                    txtNomCta.Text = ""
                                    Ide.Text = ""
                                    leedir = 0
                                    VLPaso = True
                                    Exit Sub
                                End If
                            Else
                                COBISMessageBox.Show(FMLoadResString(500020), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                                txtNomCta.Text = ""
                                Ide.Text = ""
                                VLPaso = True
                                mskCuenta.Focus()
                                Exit Sub
                            End If
                        End If
                    Else
                        If cmbTipo(0).Text = FMLoadResString(502556) Then
                            VLProducto = "AHO"
                            If Not VLPaso Then
                                If FMChequeaCtaAho(mskCuenta.ClipText) Then
                                    PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(502622) & mskCuenta.Text & "]") Then
                                        PMMapeaObjeto(sqlconn, txtNomCta)
                                        PMChequea(sqlconn)
                                        leedir = 1
                                    Else
                                        PMChequea(sqlconn)
                                        Ide.Text = ""
                                        txtNomCta.Text = ""
                                        mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                                        leedir = 0
                                        VLPaso = True
                                        mskCuenta.Focus()
                                        Exit Sub
                                    End If
                                Else
                                    COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                    VLPaso = True
                                    txtNomCta.Text = ""
                                    Ide.Text = ""
                                    mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                                    mskCuenta.Focus()
                                    Exit Sub
                                End If
                            End If
                        End If
                    End If
                End If
                VLExcSipla = "N"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "2733")
                PMPasoValores(sqlconn, "@i_producto", 0, SQLCHAR, VLProducto)
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_query_excep_sipla", True, FMLoadResString(2237) & mskCuenta.Text & "]") Then
                    PMMapeaVariable(sqlconn, VLExcSipla)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
                If VLExcSipla = "S" Then
                    COBISMessageBox.Show(FMLoadResString(508460), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    PLLimpiar()
                    Exit Sub
                End If
                If leedir = 1 Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2669")
                    PMPasoValores(sqlconn, "@i_tipo_con", 0, SQLINT1, CStr(1))
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VTProducto)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_control_efectivo", True, FMLoadResString(2330) & mskCuenta.Text & "]") Then
                        PMMapeaObjeto(sqlconn, Ide)
                        PMChequea(sqlconn)
                        leedir = 0
                    Else
                        PMChequea(sqlconn)
                    End If
                Else
                    PLLimpiaObjOption(1)
                    PLLimpiaObjOption(2)
                End If
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
        End Try
    End Sub

    Private Sub mskFechaFin_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFechaFin.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508570))
    End Sub

    Private Sub mskFechaFin_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFechaFin.Leave
        Dim VTValido As Integer = 0
        If mskFechaFin.ClipText <> "" Then
            VTValido = FMVerFormato(mskFechaFin.Text, VLFormatoFecha)
            If Not VTValido Then
                COBISMessageBox.Show(FMLoadResString(500063), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                mskFechaFin.Focus()
                Exit Sub
            Else
                If CDate(mskFechaFin.Text) < CDate(VGFechaProceso) Then
                    COBISMessageBox.Show(FMLoadResString(502381), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskFechaFin.Mask = ""
                    mskFechaFin.Text = ""
                    mskFechaFin.Mask = FMMascaraFecha(VGFormatoFecha)
                    mskFechaFin.DateType = PLFormatoFecha()
                    mskFechaFin.Connection = VGMap
                    mskFechaFin.Text = FMDateAdd(VGFechaProceso, "d", 1, VGFormatoFecha)
                    mskFechaFin.Focus()
                    Exit Sub
                End If
                VTFecha1 = StringsHelper.Format(mskFechaFin.Text, VGFormatoFecha)
                VTFecha2 = StringsHelper.Format(mskFechaIni.Text, VGFormatoFecha)
                If FMDateDiff("d", VTFecha2, VTFecha1, VGFormatoFecha) < 0 Then
                    COBISMessageBox.Show(FMLoadResString(500066), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskFechaFin.Mask = ""
                    mskFechaFin.Text = ""
                    mskFechaFin.Mask = FMMascaraFecha(VGFormatoFecha)
                    mskFechaFin.DateType = PLFormatoFecha()
                    mskFechaFin.Connection = VGMap
                    mskFechaFin.Text = FMDateAdd(VGFechaProceso, "d", 1, VGFormatoFecha)
                    mskFechaFin.Focus()
                    If mskFechaFin.Enabled And mskFechaFin.Visible Then mskFechaFin.Focus()
                    Exit Sub
                End If
            End If
        End If
    End Sub

    Private Sub mskFechaIni_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFechaIni.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508573))
    End Sub

    Private Sub mskFechaIni_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFechaIni.Leave
        Dim VTValido As Integer = 0
        If mskFechaIni.ClipText <> "" Then
            VTValido = FMVerFormato(mskFechaIni.Text, VLFormatoFecha)
            If Not VTValido Then
                COBISMessageBox.Show(FMLoadResString(500063), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                mskFechaIni.Focus()
                Exit Sub
            End If
            If CDate(mskFechaIni.Text) > CDate(VGFechaProceso) Then
                COBISMessageBox.Show(FMLoadResString(5254), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskFechaIni.Mask = ""
                mskFechaIni.Text = ""
                mskFechaIni.Mask = FMMascaraFecha(VGFormatoFecha)
                mskFechaIni.DateType = PLFormatoFecha()
                mskFechaIni.Connection = VGMap
                mskFechaIni.Text = FMDateAdd(VGFechaProceso, "d", 0, VGFormatoFecha)
                mskFechaIni.Focus()
                Exit Sub
            End If
        End If
    End Sub

    Private Sub Option1_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _Option1_3.CheckedChanged, _Option1_2.CheckedChanged, _Option1_1.CheckedChanged, _Option1_0.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Index As Integer = Array.IndexOf(Option1, eventSender)
            PLLimpiaObjOption(Index)
        End If
    End Sub

    Private Sub Option1_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _Option1_3.Enter, _Option1_2.Enter, _Option1_1.Enter, _Option1_0.Enter
        Dim Index As Integer = Array.IndexOf(Option1, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508686))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508684))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508733))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500123))
        End Select
    End Sub

    Private Sub txtOficRecep_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtOficRecep.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub txtOficRecep_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtOficRecep.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508501))
        txtOficRecep.SelectionStart = 0
        txtOficRecep.SelectionLength = Strings.Len(txtOficRecep.Text)
    End Sub

    Private Sub txtOficRecep_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtOficRecep.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode = VGTeclaAyuda Then
            VLPaso = True
            VGOperacion = "sp_oficina"
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502504) & txtOficRecep.Text & "]") Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.ShowPopup(Me)
                txtOficRecep.Text = VGACatalogo.Codigo
                lblOfiRecep.Text = VGACatalogo.Descripcion
            Else
                PMChequea(sqlconn)
            End If
            If txtOficRecep.Text.Trim() = "" Then
                txtOficRecep.Focus()
            End If
            VLPaso = True
        End If
    End Sub

    Private Sub txtOficRecep_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtOficRecep.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtOficRecep_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtOficRecep.Leave
        If txtOficRecep.Text <> "" Then
            If CInt(txtOficRecep.Text) > 32760 Then
                COBISMessageBox.Show(FMLoadResString(501098), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtOficRecep.Text = ""
                txtOficRecep.Focus()
            End If
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtOficRecep.Text)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502504) & txtOficRecep.Text & "]") Then
                PMMapeaObjeto(sqlconn, lblOfiRecep)
                PMChequea(sqlconn)
            Else
                PMChequea(sqlconn)
                VLPaso = True
                txtOficRecep.Text = ""
                lblOfiRecep.Text = ""
                If txtOficRecep.Enabled Then
                    txtOficRecep.Focus()
                End If
                lblOfiRecep.Text = ""
            End If
        Else
            lblOfiRecep.Text = ""
        End If
    End Sub

    Public Sub PLSalir()
        Me.Close()
    End Sub

    Function PLValida_Campos() As Boolean
        Dim result As Boolean = False
        If txtOficRecep.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(508556), FMLoadResString(508468), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            txtOficRecep.Focus()
            Return result
        End If
        If mskFechaIni.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(508555), FMLoadResString(508468), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            mskFechaIni.Focus()
            Return result
        End If
        If mskFechaFin.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(508554), FMLoadResString(508468), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            mskFechaFin.Focus()
            Return result
        End If
        If Conversion.Val(CStr(MhRealValor(1).Text)) <= 0 Then
            COBISMessageBox.Show(FMLoadResString(508553), FMLoadResString(508468), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            MhRealValor(1).Focus()
            Return result
        End If
        If Option1(0).Checked Then
            If cmbide(0).Text = "" Then
                COBISMessageBox.Show(FMLoadResString(508558) & ChrW(13) & FMLoadResString(508686), FMLoadResString(508468), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                cmbide(0).Focus()
                Return result
            End If
            If Maskpers_ced_nit(0).ClipText = "" Then
                COBISMessageBox.Show(FMLoadResString(508557) & ChrW(13) & FMLoadResString(508685), FMLoadResString(508468), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                Maskpers_ced_nit(0).Focus()
                Return result
            End If
        ElseIf Option1(1).Checked Then
            If cmbide(1).Text = "" Then
                COBISMessageBox.Show(FMLoadResString(508558) & ChrW(13) & FMLoadResString(508686), FMLoadResString(508468), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                cmbide(1).Focus()
                Return result
            End If
            If Maskpers_ced_nit(1).ClipText = "" Then
                COBISMessageBox.Show(FMLoadResString(508557) & ChrW(13) & FMLoadResString(508684), FMLoadResString(508468), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                Maskpers_ced_nit(1).Focus()
                Return result
            End If
        ElseIf Option1(2).Checked Then
            If Ide.Text = "" Then
                COBISMessageBox.Show(FMLoadResString(508557) & ChrW(13) & FMLoadResString(508733), FMLoadResString(508468), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                Ide.Focus()
                Return result
            End If
        ElseIf Option1(3).Checked Then
            If cmbide(3).Text = "" Then
                COBISMessageBox.Show(FMLoadResString(508558) & ChrW(13) & FMLoadResString(500123), FMLoadResString(508468), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                cmbide(3).Focus()
                Return result
            End If
            If Maskpers_ced_nit(3).ClipText = "" Then
                COBISMessageBox.Show(FMLoadResString(508557) & ChrW(13) & FMLoadResString(500123), FMLoadResString(508468), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                Maskpers_ced_nit(3).Focus()
                Return result
            End If
        End If
        Return True
    End Function

    Public Sub PLLimpiaObjOption(ByRef Index As Integer)
        For i As Integer = 0 To 3
            If i <> Index Then
                Select Case i
                    Case 0
                        cmbide(i).Text = ""
                        Maskpers_ced_nit(i).Mask = ""
                        Maskpers_ced_nit(i).Text = ""
                        Frame2(i).Enabled = False
                        Label6(i).Enabled = False
                        Label7(i).Enabled = False
                    Case 1, 3
                        cmbide(i).Text = ""
                        Maskpers_ced_nit(i).Mask = ""
                        Maskpers_ced_nit(i).Text = ""
                        cmbide(i).Enabled = False
                        Maskpers_ced_nit(i).Enabled = False
                        Frame2(i).Enabled = False
                        Label6(i).Enabled = False
                        Label7(i).Enabled = False
                    Case 2
                        mskCuenta.Mask = ""
                        mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                        mskCuenta.Enabled = False
                        Ide.Text = ""
                        txtNomCta.Text = ""
                        Ide.Enabled = False
                        cmbTipo(0).Enabled = False
                        Frame2(i).Enabled = False
                        Label6(i).Enabled = False
                        Label7(i).Enabled = False
                        lblEtiqueta(14).Enabled = False
                End Select
            Else
                Select Case i
                    Case 0, 1
                        Frame2(i).Enabled = True
                        cmbide(i).Enabled = True
                        Maskpers_ced_nit(i).Enabled = True
                        Label6(i).Enabled = True
                        Label7(i).Enabled = True
                    Case 2
                        Frame2(i).Enabled = True
                        Ide.Enabled = True
                        Label6(i).Enabled = True
                        Label7(i).Enabled = True
                        lblEtiqueta(14).Enabled = True
                        cmbTipo(0).Enabled = True
                        mskCuenta.Enabled = True
                        mskCuenta.Mask = VGMascaraCtaCte
                    Case 3
                        Frame2(i).Enabled = True
                        cmbide(i).Enabled = True
                        Maskpers_ced_nit(i).Enabled = True
                        Label6(i).Enabled = True
                        Label7(i).Enabled = True
                End Select
            End If
        Next i
    End Sub

    Public Sub PLLimpiar()
        txtOficRecep.Text = ""
        mskFechaIni.Mask = FMMascaraFecha(VLFormatoFecha)
        mskFechaIni.Text = VGFecha
        mskFechaFin.Mask = FMMascaraFecha(VLFormatoFecha)
        mskFechaFin.Text = VGFecha
        mskFechaIni.MaxLength = 14
        mskFechaFin.MaxLength = 14
        MhRealValor(0).Text = 0
        MhRealValor(1).Text = 0
        cmdBoton(1).Enabled = True
        cmdBoton(0).Enabled = False
        txtOficRecep.Enabled = True
        mskFechaIni.Enabled = True
        mskFechaFin.Enabled = True
        MhRealValor(0).Enabled = True
        MhRealValor(1).Enabled = True
        PLHabilitarFiltros(False)
        ChkFiltros.Enabled = True
        ChkFiltros.Checked = 0
        lblOfiRecep.Text = ""
        txtOficRecep.Text = VGOficina
        txtOficRecep.Text = VGOficina
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, CStr(1572))
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT4, txtOficRecep.Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_oficina", True, FMLoadResString(502504) & txtOficRecep.Text & "]") Then
            Dim VLDatosOficina(20) As String
            FMMapeaArreglo(sqlconn, VLDatosOficina)
            lblOfiRecep.Text = VLDatosOficina(5)
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
        Label7(2).Text = "Cliente:"
        PMLimpiaGrid(grdChequeras)
        PLTSEstado()
    End Sub

    Public Sub PLHabilitarFiltros(ByRef valor As Boolean)
        cmbide(0).Text = ""
        Maskpers_ced_nit(0).Mask = ""
        Maskpers_ced_nit(0).Text = ""
        cmbide(1).Text = ""
        Maskpers_ced_nit(1).Mask = ""
        Maskpers_ced_nit(1).Text = ""
        txtNomCta.Text = ""
        Ide.Text = ""
        mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
        mskCuenta.Enabled = False
        cmbide(3).Text = ""
        Maskpers_ced_nit(3).Mask = ""
        Maskpers_ced_nit(3).Text = ""
        If valor Then
            Option1(0).Checked = True
            PLLimpiaObjOption(0)
            Option1(0).Enabled = True
            Option1(0).Checked = False
            Option1(1).Enabled = True
            Option1(1).Checked = False
            Option1(2).Enabled = True
            Option1(2).Checked = False
            Option1(3).Enabled = True
            Option1(3).Checked = False
        Else
            Option1(0).Checked = True
            PLLimpiaObjOption(0)
            Option1(0).Checked = False
            Option1(0).Enabled = False
            Option1(1).Checked = False
            Option1(1).Enabled = False
            Option1(2).Checked = False
            Option1(2).Enabled = False
            Option1(3).Checked = False
            Option1(3).Enabled = False
        End If
        cmbide(0).Enabled = False
        Maskpers_ced_nit(0).Enabled = False
        Label6(0).Enabled = False
        Label7(0).Enabled = False
        cmbide(0).SelectedIndex = 0
        cmbide(1).SelectedIndex = 0
        cmbide(3).SelectedIndex = 0
        cmbTipo(0).SelectedIndex = 1
    End Sub

    Private Sub PLExcel()
        If txtOficRecep.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(508517), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtOficRecep.Focus()
            Exit Sub
        End If
        Dim Nombre_hoja As String = FMLoadResString(508916) & txtOficRecep.Text
        If Me.grdChequeras.Cols > 2 Then
            GeneraDatosGrid_Excel(Me.grdChequeras, Nombre_hoja)
        Else
            COBISMessageBox.Show(FMLoadResString(502290), FMLoadResString(15000), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End If
    End Sub

    Sub GeneraDatosGrid_Excel(ByRef grilla As COBISCorp.Framework.UI.Components.COBISGrid, ByRef svTitulo As String)
        Try
            Dim XlsApl As Excel.Application
            Dim xlsLibro As Excel.Workbook
            Dim xlhoja As Excel.Worksheet
            XlsApl = New Excel.Application()
            XlsApl.Visible = True
            XlsApl.Caption = svTitulo
            XlsApl.Workbooks.Add()
            xlsLibro = XlsApl.ActiveWorkbook
            xlhoja = xlsLibro.Worksheets.Add()
            xlhoja.Name = svTitulo
            xlsLibro.Worksheets(svTitulo).Activate(Me)
            For Fil As Integer = 0 To grilla.Rows - 1
                grilla.Row = Fil
                For Col As Integer = 1 To grilla.Cols - 1
                    grilla.Col = Col
                    xlsLibro.Worksheets(svTitulo).Cells(Fil + 1, Col).Value2 = grilla.CtlText.ToUpper()
                Next
                If Fil = 0 Then
                    xlsLibro.Worksheets(svTitulo).Rows("1:1", Type.Missing).Select()
                    XlsApl.Selection.Interior.ColorIndex = 37
                    XlsApl.Selection.Interior.Pattern = Excel.Constants.xlSolid
                    XlsApl.Selection.Font.Bold = True
                    XlsApl.Selection.Borders(Excel.XlBordersIndex.xlInsideVertical).LineStyle = Excel.Constants.xlNone
                    XlsApl.Cells.Select()
                    XlsApl.Range("E1").Activate()
                    XlsApl.Cells.EntireColumn.AutoFit()
                End If
            Next
            XlsApl.Selection.Borders(Excel.XlBordersIndex.xlInsideVertical).LineStyle = Excel.Constants.xlNone
            XlsApl.Cells.Select()
            XlsApl.Range("E1").Activate()
            XlsApl.Cells.EntireColumn.AutoFit()
        Catch excep As System.Exception
            COBISMessageBox.Show(CStr(Information.Err().Number) & " - " & excep.Message, My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
        End Try
    End Sub
    Private Sub PLTSEstado()
        TSBBuscar.Visible = _cmdBoton_1.Visible
        TSBBuscar.Enabled = _cmdBoton_1.Enabled
        TSBSiguientes.Visible = _cmdBoton_0.Visible
        TSBSiguientes.Enabled = _cmdBoton_0.Enabled
        TSBExcel.Visible = _cmdBoton_4.Visible
        TSBExcel.Enabled = _cmdBoton_4.Enabled
        TSBLimpiar.Visible = _cmdBoton_2.Visible
        TSBLimpiar.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_3.Visible
        TSBSalir.Enabled = _cmdBoton_3.Enabled
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBExcel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBExcel.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub LimpiarFechas()
        mskFechaIni.Mask = FMMascaraFecha(VGFormatoFecha)
        mskFechaIni.DateType = PLFormatoFecha()
        mskFechaIni.Connection = VGMap

        mskFechaFin.Mask = FMMascaraFecha(VGFormatoFecha)
        mskFechaFin.DateType = PLFormatoFecha()
        mskFechaFin.Connection = VGMap
    End Sub

    Private Sub Maskpers_ced_nit_KeyPress(sender As Object, EventArgs As KeyPressEventArgs) Handles _Maskpers_ced_nit_0.KeyPress, _Maskpers_ced_nit_1.KeyPress, _Maskpers_ced_nit_3.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(EventArgs.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            EventArgs.Handled = True
        End If
        EventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub Option1_Leave(eventSender As Object, e As EventArgs) Handles _Option1_0.Leave, _Option1_1.Leave, _Option1_3.Leave
        Dim Index As Integer = Array.IndexOf(Option1, eventSender)
        Select Case Index
            Case 0
                cmbide(0).Focus()
            Case 1
                cmbide(1).Focus()
            Case 3
                cmbide(3).Focus()
        End Select
    End Sub

    Private Sub cmbide_Leave(eventSender As Object, e As EventArgs) Handles _cmbide_0.Leave, _cmbide_1.Leave, _cmbide_3.Leave
        Dim Index As Integer = Array.IndexOf(cmbide, eventSender)
        Select Case cmbide(Index).Text
            Case "CC"
                Maskpers_ced_nit(Index).Mask = "##-###-###"
                Maskpers_ced_nit(Index).MaxLength = 8
            Case "TI"
                Maskpers_ced_nit(Index).Mask = "######-#####"
                Maskpers_ced_nit(Index).MaxLength = 11
            Case "CE"
                Maskpers_ced_nit(Index).Mask = "###-###"
                Maskpers_ced_nit(Index).MaxLength = 6
            Case "NI"
                Maskpers_ced_nit(Index).Mask = "###-###-###-#"
                Maskpers_ced_nit(Index).MaxLength = 10
            Case "PA"
                Maskpers_ced_nit(Index).Text = ""
                Maskpers_ced_nit(Index).Mask = ""
                Maskpers_ced_nit(Index).Text = ""
                Maskpers_ced_nit(Index).MaxLength = 14
            Case Else
                Maskpers_ced_nit(Index).Text = ""
                Maskpers_ced_nit(Index).Mask = ""
                Maskpers_ced_nit(Index).Text = ""
                Maskpers_ced_nit(Index).MaxLength = 14
        End Select
        Maskpers_ced_nit(Index).Focus()
    End Sub

    Private Sub mskCuenta_TextChanged(sender As Object, e As EventArgs) Handles mskCuenta.TextChanged
        VLPaso = False
    End Sub
End Class


