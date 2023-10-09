Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Artinsoft.VB6.VB
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CON.MXN.SharedLibrary
<COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISToolBar(GetType(ToolBar.ToolBar))> _
Partial Public Class FSolRepRegClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Private isInitializingComponent As Boolean = False
    Dim VLPaso As Integer = 0
    Dim VLLineas As Integer = 0
    Dim VLExistePedido As Boolean = False
    Dim VLProvisionGenerada As Boolean = False
    Dim VLParamProvision As String = String.Empty
    Dim VLTrnConsultar As Integer = 6640
    Dim VLTrnVerificar As Integer = 6641
    Dim VLTrnIngresar As Integer = 6642
    Dim VLParamRepFinPer As String = String.Empty

    Private Sub grdRegistros_ClickEvent(ByVal sender As Object, ByVal e As COBISCorp.Framework.UI.Components._DSpreadEvents_ClickEvent) Handles grdRegistros.ClickEvent
        If e.Row > 0 Then
            PMMarcaRow(grdRegistros, e.Row)
        End If
    End Sub

    Private Sub PLBuscar()
        Dim VTMes As String = String.Empty
        Dim VTAnio As String = String.Empty

        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, VLTrnConsultar)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
        PMPasoValores(sqlconn, "@i_fecha_proc", 0, SQLDATETIME, FMConvFecha(VGFechaProceso, VGFecha_Pref, CGFORMATOFECHA))

        PMPasoValores(sqlconn, "@o_mes", 1, SQLINT1, "0")
        PMPasoValores(sqlconn, "@o_anio", 1, SQLINT2, "0")
        'PMPasoValores(sqlconn, "@o_provision", 1, SQLCHAR, "N")

        If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_solicitud_reportes_reg", True, FMLoadResString(3129)) Then
            PMMapeaGrid(sqlconn, grdRegistros, False)

            VTMes = FMRetParam(sqlconn, 1)
            VTAnio = FMRetParam(sqlconn, 2)
            'VLProvisionGenerada = IIf(FMRetParam(sqlconn, 3).Equals("S"), True, False)
            PMChequea(sqlconn)
        Else
            PMBorrarGrid(grdRegistros)
        End If

        If (Not String.IsNullOrEmpty(VTMes) And Not VTMes.Equals("0")) Then
            Me.cmbMes.SelectedValue = VTMes
            VLExistePedido = True
        Else
            VLExistePedido = False
        End If
        If (Not String.IsNullOrEmpty(VTAnio) And Not VTAnio.Equals("0")) Then
            Me._txtAnio.Text = VTAnio
            VLExistePedido = True
        Else
            VLExistePedido = False
        End If

        PMBloqueaGridLimite(grdRegistros, 2)
        PMMarcaRow(grdRegistros, grdRegistros.Row)
        PMAjustaColsGrid(grdRegistros)
        PMCabeceraColGrid(grdRegistros, grdRegistros.Row)

        Me.grdRegistros.Col = Me.grdRegistros.MaxCols
        Me.grdRegistros.ColHidden = True
    End Sub

    Private Function PLValidar() As Boolean
        Dim VTFecha As Date = Convert.ToDateTime(VGFechaProceso)
        Dim VTFechaTmp As Date

        If (Me.cmbMes.SelectedIndex < 0) Then
            COBISMessageBox.Show(FMLoadResString(3121), FMLoadResString(3120), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Return False
        End If

        If (String.IsNullOrEmpty(Me._txtAnio.Text.Trim())) Then
            COBISMessageBox.Show(FMLoadResString(3122), FMLoadResString(3120), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Return False
        End If

        VTFechaTmp = Convert.ToDateTime(Me._txtAnio.Text + "/" + Me.cmbMes.SelectedValue + "/01")

        If (DateDiff(DateInterval.Month, VTFecha, VTFechaTmp) >= 0) Then
            COBISMessageBox.Show(FMLoadResString(3123), FMLoadResString(3120), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Return False
        End If

        If (DateDiff(DateInterval.Month, DateAdd(DateInterval.Month, -1, VTFecha), VTFechaTmp) < 0) Then
            If (COBISMessageBox.Show(FMLoadResString(3134), FMLoadResString(3135), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question) = DialogResult.No) Then
                Return False
            End If
        End If

        Return True
    End Function

    Private Function PLValidarRegistros() As Boolean
        Dim VTCantidad As Integer = 0
        Dim VTExisteProvision As Boolean = False
        Dim VTNecesitaProvision As Boolean = False

        If (Me.grdRegistros.MaxRows <= 1) Then
            COBISMessageBox.Show(FMLoadResString(3134), FMLoadResString(3120), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Return False
        End If

        For VTContador As Integer = 1 To Me.grdRegistros.MaxRows
            Me.grdRegistros.Col = 3
            Me.grdRegistros.Row = VTContador

            If (Me.grdRegistros.Value.Equals("1")) Then
                Me.grdRegistros.Col = 4

                If (Me.grdRegistros.Value.Equals("S")) Then
                    VTNecesitaProvision = True
                End If

                Me.grdRegistros.Col = 1
                If (Me.grdRegistros.Value.Equals(VLParamProvision)) Then
                    VTExisteProvision = True
                End If

                VTCantidad = VTCantidad + 1
            End If
        Next

        If (VTExisteProvision And VLProvisionGenerada) Then
            If (COBISMessageBox.Show(FMLoadResString(3139), FMLoadResString(3135), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question) = DialogResult.No) Then
                Return False
            End If
        End If

        If (VTNecesitaProvision And (Not VTExisteProvision And Not VLProvisionGenerada)) Then
            COBISMessageBox.Show(FMLoadResString(3138), FMLoadResString(3120), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Return False
        End If

        'No se debe controlar que exista al menos 1 reporte seleccionado
        'If (VTCantidad <= 0) Then
        '    COBISMessageBox.Show(FMLoadResString(3124), FMLoadResString(3120), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        '    Return False
        'End If

        If (VLExistePedido) Then
            If (COBISMessageBox.Show(FMLoadResString(3136), FMLoadResString(3135), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question) = DialogResult.No) Then
                Return False
            End If
        End If

        For VTContador2 As Integer = 1 To Me.grdRegistros.MaxRows
            grdRegistros.Row = VTContador2
            grdRegistros.Col = 3
            If (Me.grdRegistros.Value.Equals("1")) Then
                grdRegistros.Col = 1
                If grdRegistros.Text.Equals(VLParamRepFinPer) Then
                    If COBISMessageBox.Show(FMLoadResString(5014), FMLoadResString(5015), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question) = DialogResult.No Then
                        Return False
                    End If

                    If (VGEmpresa.Codigo = String.Empty) Then
                        COBISMessageBox.Show(FMLoadResString(5019), FMLoadResString(3135), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        Return False
                    End If
                    If Not (FLValidaFinPeriodo()) Then
                        Return False
                    End If

                End If
            End If
        Next
        Return True
    End Function

    Private Sub PLIngresar()
        Dim VTReporte As String
        Dim VTCantidad As Integer = 0

        If (Not Me.PLValidar()) Then
            Exit Sub
        End If

        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, VLTrnVerificar)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "P")
        PMPasoValores(sqlconn, "@i_mes", 0, SQLINT1, Me.cmbMes.SelectedValue.ToString())
        PMPasoValores(sqlconn, "@i_anio", 0, SQLINT2, Me._txtAnio.Text)
        PMPasoValores(sqlconn, "@o_provision", 1, SQLCHAR, "N")

        If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_solicitud_reportes_reg", True, FMLoadResString(3128)) Then
            VLProvisionGenerada = IIf(FMRetParam(sqlconn, 1).Equals("S"), True, False)
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
            COBISMessageBox.Show(FMLoadResString(3125), FMLoadResString(3120), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If

        If (Not Me.PLValidarRegistros()) Then
            Exit Sub
        End If

        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, VLTrnVerificar)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "V")
        PMPasoValores(sqlconn, "@i_fecha_proc", 0, SQLDATETIME, FMConvFecha(VGFechaProceso, VGFecha_Pref, CGFORMATOFECHA))
        PMPasoValores(sqlconn, "@i_mes", 0, SQLINT1, Me.cmbMes.SelectedValue.ToString())
        PMPasoValores(sqlconn, "@i_anio", 0, SQLINT2, Me._txtAnio.Text)

        If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_solicitud_reportes_reg", True, FMLoadResString(3128)) Then
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
            COBISMessageBox.Show(FMLoadResString(3125), FMLoadResString(3120), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If

        For VTContador As Integer = 1 To Me.grdRegistros.MaxRows
            Me.grdRegistros.Row = VTContador
            Me.grdRegistros.Col = 1
            VTReporte = Me.grdRegistros.Text

            Me.grdRegistros.Col = 3

            If (Me.grdRegistros.Value.Equals("1")) Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, VLTrnIngresar)
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
                PMPasoValores(sqlconn, "@i_reporte", 0, SQLVARCHAR, VTReporte)
                PMPasoValores(sqlconn, "@i_fecha_proc", 0, SQLDATETIME, FMConvFecha(VGFechaProceso, VGFecha_Pref, CGFORMATOFECHA))
                PMPasoValores(sqlconn, "@i_mes", 0, SQLINT1, Me.cmbMes.SelectedValue.ToString())
                PMPasoValores(sqlconn, "@i_anio", 0, SQLINT2, Me._txtAnio.Text)

                If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_solicitud_reportes_reg", True, FMLoadResString(3127)) Then
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    COBISMessageBox.Show(FMLoadResString(3125), FMLoadResString(3120), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    Exit Sub
                End If

                VTCantidad = VTCantidad + 1
            End If
        Next

        COBISMessageBox.Show(FMLoadResString(3126), FMLoadResString(3135), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)

        PLLimpiar()
        PLBuscar()
    End Sub

    Private Sub PLLimpiar()
        Me.PLLenarCombo()
        Me.PLParamProvision()
        Me.PLParRepFinPeriodo()

        Me.cmbMes.SelectedValue = DateAdd(DateInterval.Month, -1, Convert.ToDateTime(VGFechaProceso)).Month.ToString()
        Me._txtAnio.Text = DateAdd(DateInterval.Month, -1, Convert.ToDateTime(VGFechaProceso)).Year.ToString()
        Me.grdRegistros.MaxRows = 0
        Me.chkMarcarTodos.Checked = False

        TSBIngresar.Enabled = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        Me.cmbMes.Focus()
    End Sub

    Private Sub PLParamProvision()
        Dim VTArrDatos(5) As String
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_criterio", 0, SQLINT1, 1)
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "4")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, "CON")
        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "PGPROV")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(3137)) Then
            FMMapeaArreglo(sqlconn, VTArrDatos)
            VLParamProvision = IIf(String.IsNullOrEmpty(VTArrDatos(3)), 0, VTArrDatos(3))
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub PLLenarCombo()
        'Me.cmbMes.Items.Clear()

        Dim VTContador As Integer = 0
        Dim VTRecurso As Integer = 3107

        Dim VTValoresCombo As New Dictionary(Of String, String)()

        While VTContador <= 11
            VTValoresCombo.Add((VTContador + 1).ToString(), FMLoadResString(VTRecurso))

            VTContador = VTContador + 1
            VTRecurso = VTRecurso + 1
        End While

        Me.cmbMes.DataSource = Nothing
        Me.cmbMes.Refresh()
        Me.cmbMes.DataSource = New BindingSource(VTValoresCombo, Nothing)
        Me.cmbMes.DisplayMember = "Value"
        Me.cmbMes.ValueMember = "Key"
    End Sub

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtAnio.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub TSBIngresar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBIngresar.Click
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(3130))
        PLIngresar()
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(3131))
        PLLimpiar()
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(3132))
        PLBuscar()
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(3133))
        Me.Close()
    End Sub

    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        Me.Top = Compatibility.VB6.TwipsToPixelsY(20)
        Me.Left = Compatibility.VB6.TwipsToPixelsX(20)
        Me.Height = Compatibility.VB6.TwipsToPixelsY(5700)
        Me.Width = Compatibility.VB6.TwipsToPixelsX(9390)
        PLLimpiar()
        PLBuscar()
        VLPaso = 0
    End Sub

    Private Sub FSolRepReg_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
    End Sub

    Private Sub FSolRepReg_Closed(sender As Object, e As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub cmbMes_Enter(sender As Object, e As EventArgs) Handles cmbMes.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(3105))
    End Sub

    Private Sub _txtAnio_Enter(sender As Object, e As EventArgs) Handles _txtAnio.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(3106))
    End Sub

    Private Sub _txtAnio_KeyPress(sender As Object, eventSender As KeyPressEventArgs) Handles _txtAnio.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventSender.KeyChar)

        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If

        If KeyAscii = 0 Then
            eventSender.Handled = True
        End If
        eventSender.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub grdRegistros_Enter_1(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(3062))
    End Sub

    Private Sub chkMarcarTodos_Enter(sender As Object, e As EventArgs) Handles chkMarcarTodos.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(3141))
    End Sub

    Private Sub chkMarcarTodos_CheckStateChanged(sender As Object, e As EventArgs) Handles chkMarcarTodos.CheckStateChanged
        For VTContador As Integer = 1 To Me.grdRegistros.MaxRows
            Me.grdRegistros.Col = 3
            Me.grdRegistros.Row = VTContador

            Me.grdRegistros.Value = IIf(Me.chkMarcarTodos.Checked, 1, 0)
            Me.grdRegistros.Text = IIf(Me.chkMarcarTodos.Checked, 1, 0)
        Next
        Me.grdRegistros.Refresh()
    End Sub
    Private Sub PLParRepFinPeriodo()
        Dim VTArrDatos(5) As String
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_criterio", 0, SQLINT1, 1)
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "4")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, "CON")
        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "CRFINP")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(3137)) Then
            FMMapeaArreglo(sqlconn, VTArrDatos)
            VLParamRepFinPer = IIf(String.IsNullOrEmpty(VTArrDatos(3)), 0, VTArrDatos(3))
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
    End Sub
    Private Function FLValidaFinPeriodo() As Boolean
        Dim VTFlag As Boolean
        Dim VTNumMensaje As Integer
        Dim VTMensaje As String
        VTFlag = True

        'Validacion Fecha Proceso VTMensaje = "601315"
        VTMensaje = FLValidacionCierre(1)
        If VTMensaje <> "" Then
            If (VTMensaje <> "") And (VTMensaje <> "0") And Not (String.IsNullOrEmpty(VTMensaje)) Then
                VTNumMensaje = 5020
                If COBISMessageBox.Show(FMLoadResString(VTNumMensaje), FMLoadResString(5015), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question) = DialogResult.No Then
                    VTFlag = False
                End If
            End If
        End If

        'Validacion Parametro MESFPE 1 o 2 VTMensaje = "601316"
        If VTFlag Then
            VTMensaje = ""
            VTMensaje = FLValidacionCierre(2)
            If (VTMensaje <> "") And (VTMensaje <> "0") And Not (String.IsNullOrEmpty(VTMensaje)) Then
                VTNumMensaje = 5016
                COBISMessageBox.Show(FMLoadResString(VTNumMensaje), FMLoadResString(3120), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                VTFlag = False
            End If
        End If

        'El corte de la fecha de ingreso del comprobante de fin de periodo está cerrado VTMensaje = "601317"
        If VTFlag Then
            VTMensaje = ""
            VTMensaje = FLValidacionCierre(3)
            If (VTMensaje <> "") And (VTMensaje <> "0") And Not (String.IsNullOrEmpty(VTMensaje)) Then
                VTNumMensaje = 5017
                COBISMessageBox.Show(FMLoadResString(VTNumMensaje), FMLoadResString(3120), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                VTFlag = False
            End If
        End If

        'El corte de la fecha de fin de año está abierto VTMensaje = "601318"
        If VTFlag Then
            VTMensaje = ""
            VTMensaje = FLValidacionCierre(4)
            If (VTMensaje <> "") And (VTMensaje <> "0") And Not (String.IsNullOrEmpty(VTMensaje)) Then
                VTNumMensaje = 5018
                COBISMessageBox.Show(FMLoadResString(VTNumMensaje), FMLoadResString(3120), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                VTFlag = False
            End If
        End If

        'Error provisiones. 
        If VTFlag Then
            VTMensaje = ""
            VTMensaje = FLValidacionCierre(5)
            If (VTMensaje <> "") And (VTMensaje <> "0") And Not (String.IsNullOrEmpty(VTMensaje)) Then
                If VTMensaje = "601319" Then  'Erro al obtener el día habil  VTMensaje = "601319". 
                    VTNumMensaje = 5022
                    COBISMessageBox.Show(FMLoadResString(VTNumMensaje), FMLoadResString(3120), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    VTFlag = False
                Else
                    If VTMensaje = "601320" Then 'Erro al validar provisiones  VTMensaje = "601320".
                        VTNumMensaje = 5018
                        COBISMessageBox.Show(FMLoadResString(VTNumMensaje), FMLoadResString(3120), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        VTFlag = False
                    End If
                End If
            End If
        End If

        FLValidaFinPeriodo = VTFlag
    End Function

    Private Function FLValidacionCierre(parOpcion As Integer) As String
        Dim VTArrDatos(3) As String
        Dim VLMensaje As String
        VLMensaje = ""
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, VLTrnVerificar)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "F")
        PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGEmpresa.Codigo)
        PMPasoValores(sqlconn, "@i_opcion", 0, SQLINT1, parOpcion)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_solicitud_reportes_reg", True, FMLoadResString(3128)) Then
            FMMapeaArreglo(sqlconn, VTArrDatos)
            PMChequea(sqlconn)
            If (VTArrDatos(1) <> "") And (VTArrDatos(1) <> "0") And Not (String.IsNullOrEmpty(VTArrDatos(1))) Then
                VLMensaje = VTArrDatos(1)
            End If
        Else
            PMChequea(sqlconn)
        End If

        FLValidacionCierre = VLMensaje
    End Function
End Class
