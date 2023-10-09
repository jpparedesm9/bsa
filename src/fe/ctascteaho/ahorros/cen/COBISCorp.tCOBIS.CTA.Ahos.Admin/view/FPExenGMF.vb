Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FPExenGMFClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VTRow As Integer = 0
    Dim VLPaso As Integer = 0
    Dim VTRespuesta As Integer = 0
    Dim VLTope As String = ""
    Dim VLVrTope As Decimal = 0
    Dim VLTasa As Double = 0
    Dim VLTitular As String = ""
    Dim VLUCta As String = ""
    Dim VLProd As String = ""
    Dim VLTipoP As String = ""

    Private Sub CmbPers_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles CmbPers.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2405))
    End Sub

    Private Sub cmbTipo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbTipo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500016))
    End Sub

    Private Sub FPExenGMF_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Public Sub PLInicializar()
        cmbTipo.Items.Insert(0, FMLoadResString(502766))
        cmbTipo.Items.Insert(1, FMLoadResString(502767))
        cmbTipo.Items.Insert(2, FMLoadResString(502821))
        cmbTipo.SelectedIndex = 0
        CmbPers.Items.Insert(0, FMLoadResString(502822))
        CmbPers.Items.Insert(1, FMLoadResString(502823))
        CmbPers.Items.Insert(2, FMLoadResString(502824))
        CmbPers.SelectedIndex = 0
        PLLimpiar()
        Me.Text = FMLoadResString(9957)
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_5.Click, _cmdBoton_6.Click, _cmdBoton_0.Click, _cmdBoton_4.Click, _cmdBoton_3.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        TSBotones.Focus()
        Select Case Index
            Case 0
                PLBuscar()
            Case 1
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 1
                If grdRegistros.CtlText <> "" Then PLSgtes()
            Case 2
                PLIngresar()
            Case 3
                PLActualizar()
            Case 4
                VTRespuesta = COBISMessageBox.Show(FMLoadResString(502825), FMLoadResString(502826), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Error)
                If VTRespuesta = 6 Then
                    PLEliminar()
                End If
            Case 5
                PLLimpiar()
            Case 6
                PLSalir()
        End Select
    End Sub

    Private Sub PLBuscar()
        PMLimpiaG(grdRegistros)
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4108")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
        PMPasoValores(sqlconn, "@i_concepto", 0, SQLINT4, "0")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_conc_ext_gmf", True, FMLoadResString(502827)) Then
            PMMapeaGrid(sqlconn, grdRegistros, False)
            PMMapeaTextoGrid(grdRegistros)
            PMAnchoColumnasGrid(grdRegistros)
            PMChequea(sqlconn)
            PLFormatear()
            cmdBoton(1).Enabled = CDbl(Convert.ToString(grdRegistros.Tag)) = 20
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
    End Sub

    Private Sub PLSgtes()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4108")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
        grdRegistros.Row = grdRegistros.Rows - 1
        grdRegistros.Col = 1
        PMPasoValores(sqlconn, "@i_concepto", 0, SQLINT4, CStr(CInt(grdRegistros.CtlText)))
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_conc_ext_gmf", True, FMLoadResString(502828)) Then
            PMMapeaGrid(sqlconn, grdRegistros, True)
            PMMapeaTextoGrid(grdRegistros)
            PMAnchoColumnasGrid(grdRegistros)
            PMChequea(sqlconn)
            PLFormatear()
            cmdBoton(1).Enabled = CDbl(Convert.ToString(grdRegistros.Tag)) = 20
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
    End Sub

    Private Sub PLFormatear()
        grdRegistros.ColWidth(1) = 800
        grdRegistros.ColWidth(2) = 5000
        grdRegistros.ColWidth(3) = 1000
        grdRegistros.ColWidth(4) = 800
        grdRegistros.ColWidth(5) = 1000
        grdRegistros.ColWidth(6) = 1000
        grdRegistros.ColWidth(7) = 1000
        grdRegistros.ColWidth(8) = 1000
        grdRegistros.ColWidth(9) = 1000
        grdRegistros.ColWidth(10) = 1000
        grdRegistros.ColWidth(11) = 800
    End Sub

    Private Sub PLIngresar()
        If Not FMValidaEntradas() Then Exit Sub
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4102")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
        PMPasoValores(sqlconn, "@i_descripc", 0, SQLVARCHAR, txtdescripcion.Text)
        PMPasoValores(sqlconn, "@i_tope", 0, SQLCHAR, VLTope)
        If mskValor.Text = "" Then
            mskValor.Text = StringsHelper.Format(0, VGDecimales)
        End If
        PMPasoValores(sqlconn, "@i_vlr_tope", 0, SQLMONEY, mskValor.Text)
        If Msktasa.Text = "" Then
            Msktasa.Text = StringsHelper.Format(0, VGDecimales)
        End If
        PMPasoValores(sqlconn, "@i_tasa", 0, SQLFLT8, Msktasa.Text)
        If cmbTipo.Text = "CUENTA CORRIENTE" Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "3")
        ElseIf cmbTipo.Text = "CUENTA DE AHORRO" Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
        Else
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "9")
        End If
        If CmbPers.Text = "NATURAL" Then
            PMPasoValores(sqlconn, "@i_tipo_per", 0, SQLCHAR, "P")
        ElseIf CmbPers.Text = "JURIDICA" Then
            PMPasoValores(sqlconn, "@i_tipo_per", 0, SQLCHAR, "C")
        Else
            PMPasoValores(sqlconn, "@i_tipo_per", 0, SQLCHAR, "Y")
        End If
        PMPasoValores(sqlconn, "@i_titular", 0, SQLCHAR, VLTitular)
        PMPasoValores(sqlconn, "@i_otra_exen", 0, SQLCHAR, VLUCta)
        PMPasoValores(sqlconn, "@i_desc_nemo", 0, SQLVARCHAR, txtnemo.Text)
        PMPasoValores(sqlconn, "@i_otro_conc", 0, SQLINT2, txtcampo(12).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_conc_ext_gmf", True, FMLoadResString(502829)) Then
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
        cmdBoton(2).Enabled = False
        PLBuscar()
        PLTSEstado()
    End Sub

    Private Sub PLActualizar()
        If Not FMValidaEntradas() Then Exit Sub
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4103")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
        PMPasoValores(sqlconn, "@i_concepto", 0, SQLINT4, lblConcepto.Text)
        PMPasoValores(sqlconn, "@i_descripc", 0, SQLVARCHAR, txtdescripcion.Text)
        If mskValor.Text = "" Then
            mskValor.Text = StringsHelper.Format(0, VGDecimales)
        End If
        PMPasoValores(sqlconn, "@i_vlr_tope", 0, SQLMONEY, mskValor.Text)
        PMPasoValores(sqlconn, "@i_tope", 0, SQLCHAR, VLTope)
        If Msktasa.Text = "" Then
            Msktasa.Text = StringsHelper.Format(0, VGDecimales)
        End If
        PMPasoValores(sqlconn, "@i_tasa", 0, SQLFLT8, Msktasa.Text)
        If cmbTipo.Text = "CUENTA CORRIENTE" Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "3")
        ElseIf cmbTipo.Text = "CUENTA DE AHORRO" Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
        Else
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "9")
        End If
        If CmbPers.Text = "NATURAL" Then
            PMPasoValores(sqlconn, "@i_tipo_per", 0, SQLCHAR, "P")
        ElseIf CmbPers.Text = "JURIDICA" Then
            PMPasoValores(sqlconn, "@i_tipo_per", 0, SQLCHAR, "C")
        Else
            PMPasoValores(sqlconn, "@i_tipo_per", 0, SQLCHAR, "Y")
        End If
        PMPasoValores(sqlconn, "@i_titular", 0, SQLCHAR, VLTitular)
        PMPasoValores(sqlconn, "@i_otra_exen", 0, SQLCHAR, VLUCta)
        PMPasoValores(sqlconn, "@i_desc_nemo", 0, SQLVARCHAR, txtnemo.Text)
        PMPasoValores(sqlconn, "@i_otro_conc", 0, SQLINT2, txtcampo(12).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_conc_ext_gmf", True, FMLoadResString(502830)) Then
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
        PLBuscar()
    End Sub

    Private Sub PLEliminar()
        If Not FMValidaEntradas() Then Exit Sub
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4104")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
        PMPasoValores(sqlconn, "@i_concepto", 0, SQLINT4, lblConcepto.Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_conc_ext_gmf", True, FMLoadResString(503174)) Then
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
        cmdBoton(4).Enabled = False
        cmdBoton(3).Enabled = False
        cmdBoton(2).Enabled = True
        lblConcepto.Text = ""
        txtdescripcion.Text = ""
        Txtdescripcionc.Text = ""
        mskValor.Text = "0"
        Msktasa.Text = "0"
        txtnemo.Text = ""
        txtcampo(12).Text = ""
        cmbTipo.SelectedIndex = 0
        CmbPers.SelectedIndex = 0
        opttope(1).Checked = True
        opttitular(0).Checked = True
        optucta(1).Checked = True
        PLBuscar()
        PLTSEstado()
    End Sub

    Function FMValidarNumero(ByRef parValor As String, ByRef parLongitud As Integer, ByRef parcaracter As Integer, ByRef parNemonico As String) As Integer
        Const CGTeclaMenos As Integer = 109
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

    Function FMValidaEntradas() As Boolean
        Dim result As Boolean = False
        Dim Index As Integer = 0
        VLVrTope = CDec(mskValor.Text)
        VLTasa = CDbl(Msktasa.Text)
        If Index > 2 Then
            If lblConcepto.Text = "" Then
                COBISMessageBox.Show(FMLoadResString(502831), FMLoadResString(502550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                Return result
            End If
        End If
        If txtdescripcion.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502913), FMLoadResString(502550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            txtdescripcion.Focus()
            Return result
        End If
        If txtnemo.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503176), FMLoadResString(20009), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            txtnemo.Focus()
            Return result
        End If
        If VLVrTope < 0 Then
            COBISMessageBox.Show(FMLoadResString(503177), FMLoadResString(502550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            mskValor.Focus()
            Return result
        End If
        If VLTasa < 0 Then
            COBISMessageBox.Show(FMLoadResString(503178), FMLoadResString(502550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            Msktasa.Focus()
            Return result
        End If
        If VLTasa > 100 Then
            COBISMessageBox.Show(FMLoadResString(503179), FMLoadResString(502550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            Msktasa.Focus()
            Return result
        End If
        If opttope(0).Checked Then
            VLTope = "S"
        Else
            VLTope = "N"
        End If
        If optucta(0).Checked Then
            VLUCta = "S"
        Else
            VLUCta = "N"
        End If
        If opttitular(0).Checked Then
            VLTitular = "S"
        Else
            VLTitular = "N"
        End If
        Return True
    End Function

    Private Sub PLLimpiar()
        lblConcepto.Text = ""
        txtdescripcion.Text = ""
        VLTope = ""
        VLVrTope = 0
        mskValor.Text = "0"
        VLTasa = 0
        Msktasa.Text = "0"
        VLTitular = ""
        VLUCta = ""
        VLProd = ""
        VLTipoP = ""
        txtnemo.Text = ""
        cmbTipo.SelectedIndex = 0
        CmbPers.SelectedIndex = 0
        opttope(0).Checked = False
        opttope(1).Checked = True
        opttitular(0).Checked = True
        opttitular(1).Checked = False
        optucta(1).Checked = True
        txtcampo(12).Text = ""
        Txtdescripcionc.Text = ""
        txtcampo(12).Enabled = False
        PMLimpiaG(grdRegistros)
        cmdBoton(1).Enabled = False
        cmdBoton(2).Enabled = True
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = False
        For i As Integer = 0 To 4
            PMObjetoSeguridad(cmdBoton(i))
        Next i
        cmdBoton(1).Enabled = False
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = False
        PLTSEstado()
    End Sub

    Private Sub grdRegistros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.Click
        VTRow = grdRegistros.Row
        If VTRow > 0 And grdRegistros.CtlText <> "" Then
            cmdBoton(2).Enabled = False
            PMObjetoSeguridad(cmdBoton(3))
            PMObjetoSeguridad(cmdBoton(4))
            PMLineaG(grdRegistros)
            grdRegistros.Row = VTRow
            grdRegistros.Col = 1
            lblConcepto.Text = grdRegistros.CtlText
            grdRegistros.Col = 2
            txtdescripcion.Text = grdRegistros.CtlText
            grdRegistros.Col = 3
            VLTope = grdRegistros.CtlText
            opttope(0).Checked = grdRegistros.CtlText = "S"
            opttope(1).Checked = grdRegistros.CtlText = "N"
            grdRegistros.Col = 4
            VLVrTope = CDec(grdRegistros.CtlText)
            mskValor.ValueDouble = VLVrTope
            grdRegistros.Col = 5
            VLTasa = CDbl(grdRegistros.CtlText)
            Msktasa.ValueDouble = VLTasa
            grdRegistros.Col = 6
            VLProd = grdRegistros.CtlText
            Select Case VLProd
                Case "3"
                    cmbTipo.SelectedIndex = 0
                Case "4"
                    cmbTipo.SelectedIndex = 1
                Case "9"
                    cmbTipo.SelectedIndex = 2
            End Select
            grdRegistros.Col = 7
            VLTipoP = grdRegistros.CtlText
            Select Case VLTipoP
                Case "N"
                    CmbPers.SelectedIndex = 0
                Case "C"
                    CmbPers.SelectedIndex = 1
                Case "Y"
                    CmbPers.SelectedIndex = 2
            End Select
            grdRegistros.Col = 8
            VLTitular = grdRegistros.CtlText
            opttitular(0).Checked = grdRegistros.CtlText = "S"
            opttitular(1).Checked = grdRegistros.CtlText = "N"
            grdRegistros.Col = 9
            VLUCta = grdRegistros.CtlText
            optucta(0).Checked = grdRegistros.CtlText = "S"
            optucta(1).Checked = grdRegistros.CtlText = "N"
            grdRegistros.Col = 10
            txtnemo.Text = grdRegistros.CtlText
            grdRegistros.Col = 11
            txtcampo(12).Text = grdRegistros.CtlText
            txtcampo_Leave(txtcampo(12), New EventArgs())
        End If
        PLTSEstado()
    End Sub

    Private Sub PLSalir()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        Me.Dispose()
        Me.Close()
    End Sub

    Function FMVAlidaTipoDato(ByRef TipoDato As String, ByRef valor As Integer) As Integer
        Dim result As Integer = 0
        result = valor
        Select Case TipoDato
            Case "N"
                If (valor <> 8) And ((valor < 48) Or (valor > 57)) Then
                    result = 0
                End If
            Case "A"
                If (valor <> 8) And ((valor < 65) Or (valor > 90)) And ((valor < 97) Or (valor > 122)) Then
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
        End Select
        Return result
    End Function

    Private Sub Msktasa_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles Msktasa.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503180))
        Msktasa.SelStart = 0
        Msktasa.SelLength = Strings.Len(mskValor.Text)
    End Sub

    Private Sub Msktasa_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles Msktasa.KeyPress
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
        KeyAscii = FMValidarNumero(Msktasa.Text, 3, KeyAscii, "105")
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub mskValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskValor.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503181))
        mskValor.SelStart = 0
        mskValor.SelLength = Strings.Len(mskValor.Text)
    End Sub

    Private Sub mskValor_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskValor.KeyPress
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
        KeyAscii = FMValidarNumero(mskValor.Text, 13, KeyAscii, "105")
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub opttitular_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _opttitular_0.Enter, _opttitular_1.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503158))
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub opttope_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _opttope_0.CheckedChanged, _opttope_1.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Index As Integer = Array.IndexOf(opttope, eventSender)
            Dim Value As Integer = opttope(Index).Checked
            opttope_ClickHelper(Index, Value)
        End If
    End Sub

    Private Sub opttope_ClickHelper(ByRef Index As Integer, ByRef Value As Integer)
        Select Case Index
            Case 0
                mskValor.Enabled = True
            Case 1
                mskValor.Text = ""
                mskValor.Enabled = False
        End Select
    End Sub

    Private Sub opttope_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _opttope_0.Enter, _opttope_1.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502840))
    End Sub

    Private Sub optucta_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optucta_0.CheckedChanged, _optucta_1.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Index As Integer = Array.IndexOf(optucta, eventSender)
            Dim Value As Integer = optucta(Index).Checked
            optucta_ClickHelper(Index, Value)
        End If
    End Sub

    Private Sub optucta_ClickHelper(ByRef Index As Integer, ByRef Value As Integer)
        If optucta(1).Checked Then
            txtcampo(12).Enabled = False
            txtcampo(12).Text = ""
            Txtdescripcionc.Text = ""
        Else
            txtcampo(12).Enabled = True
        End If
    End Sub

    Private Sub optucta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optucta_0.Enter, _optucta_1.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503184))
    End Sub

    Private Sub txtcampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtcampo_12.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtcampo, eventSender)
        Select Case Index
            Case 12
                VLPaso = False
        End Select
    End Sub

    Private Sub txtcampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtcampo_12.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtcampo, eventSender)
        If KeyCode = VGTeclaAyuda Then
            Select Case Index
                Case 12
                    VGOperacion = ""
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "F")
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4105")
                    PMPasoValores(sqlconn, "@i_cuenta", 0, SQLINT2, "0")
                    If cmbTipo.Text = "CUENTA CORRIENTE" Then
                        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "3")
                    ElseIf cmbTipo.Text = "CUENTA DE AHORRO" Then
                        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
                    Else
                        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "9")
                    End If
                    VGOperacion = "sp_exencion"
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_calcula_gmf", True, FMLoadResString(502842)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, True)
                        PMChequea(sqlconn)
                        VLPaso = True
                        FCatalogo.ShowPopup(Me)
                        txtcampo(12).Text = VGACatalogo.Codigo
                        Txtdescripcionc.Text = VGACatalogo.Descripcion
                    Else
                        PMChequea(sqlconn)
                    End If
            End Select
        End If
        PLTSEstado()
    End Sub

    Private Sub txtcampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtcampo_12.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtcampo, eventSender)
        Select Case Index
            Case 12
                KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtcampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtcampo_12.Leave
        Dim Index As Integer = Array.IndexOf(txtcampo, eventSender)
        Select Case Index
            Case 12
                If Not VLPaso Then
                    If txtcampo(12).Text <> "" Then
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "B")
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4105")
                        PMPasoValores(sqlconn, "@i_cuenta", 0, SQLINT2, txtcampo(12).Text)
                        If cmbTipo.Text = "CUENTA CORRIENTE" Then
                            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "3")
                        ElseIf cmbTipo.Text = "CUENTA DE AHORRO" Then
                            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
                        Else
                            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "9")
                        End If
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_calcula_gmf", True, FMLoadResString(503295)) Then
                            Dim VTArreglo(5) As String
                            FMMapeaArreglo(sqlconn, VTArreglo)
                            PMChequea(sqlconn)
                            Txtdescripcionc.Text = VTArreglo(1)
                        Else
                            PMChequea(sqlconn)
                            Txtdescripcionc.Text = ""
                            txtcampo(12).Text = ""
                        End If
                    Else
                        Txtdescripcionc.Text = ""
                    End If
                End If
        End Select
        PLTSEstado()
    End Sub

    Private Sub txtdescripcion_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtdescripcion.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503186))
    End Sub

    Private Sub txtdescripcion_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtdescripcion.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 96) Or (KeyAscii > 123)) Then
            KeyAscii = 0
        Else
            KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtnemo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtnemo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502844))
    End Sub

    Private Sub txtnemo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtnemo.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBSiguiente.Enabled = _cmdBoton_1.Enabled
        TSBSiguiente.Visible = _cmdBoton_1.Visible
        TSBCrear.Enabled = _cmdBoton_2.Enabled
        TSBCrear.Visible = _cmdBoton_2.Visible
        TSBActualizar.Enabled = _cmdBoton_3.Enabled
        TSBActualizar.Visible = _cmdBoton_3.Visible
        TSBEliminar.Enabled = _cmdBoton_4.Enabled
        TSBEliminar.Visible = _cmdBoton_4.Visible
        TSBLimpiar.Enabled = _cmdBoton_5.Enabled
        TSBLimpiar.Visible = _cmdBoton_5.Visible
        TSBSalir.Enabled = _cmdBoton_6.Enabled
        TSBSalir.Visible = _cmdBoton_6.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub

    Private Sub grdRegistros_DblClick(sender As Object, e As EventArgs) Handles grdRegistros.DblClick
        VTRow = grdRegistros.Row
        If VTRow > 0 And grdRegistros.CtlText <> "" Then
            cmdBoton(2).Enabled = False     'desactivar el ingreso
            PMObjetoSeguridad(cmdBoton(3))   'Activar Boton Actualizar
            PMObjetoSeguridad(cmdBoton(4))   'Activar Boton Eliminar
            '        cmdBoton(3).Enabled = True      'Activar Boton Actualizar
            '        cmdBoton(4).Enabled = True      'Activar Boton Eliminar

            PMLineaG(grdRegistros)           'Resalta la linea

            grdRegistros.Row = VTRow

            grdRegistros.Col = 1
            lblConcepto.Text = grdRegistros.CtlText

            grdRegistros.Col = 2
            txtdescripcion.Text = grdRegistros.CtlText

            grdRegistros.Col = 3
            VLTope = grdRegistros.Text
            opttope(0).Checked = IIf(grdRegistros.CtlText = "S", True, False)
            opttope(1).Checked = IIf(grdRegistros.CtlText = "N", True, False)

            grdRegistros.Col = 4
            VLVrTope = CDec(grdRegistros.CtlText)
            mskValor.Text = VLVrTope

            grdRegistros.Col = 5
            VLTasa = CDbl(grdRegistros.CtlText)
            Msktasa.Text = VLTasa

            grdRegistros.Col = 6  'PRODUCTO
            VLProd = grdRegistros.CtlText
            Select Case VLProd
                Case "3" 'ccb corrientes
                    cmbTipo.SelectedIndex = 0
                Case "4" 'ahorros
                    cmbTipo.SelectedIndex = 1
                Case "9" 'ambas
                    cmbTipo.SelectedIndex = 2
            End Select

            grdRegistros.Col = 7  'TIPO PERSONA
            VLTipoP = grdRegistros.CtlText
            Select Case VLTipoP$
                Case "N"  'ccb natural
                    CmbPers.SelectedIndex = 0
                Case "C" 'ccb compañia
                    CmbPers.SelectedIndex = 1
                Case "Y" 'ccb ambas
                    CmbPers.SelectedIndex = 2
            End Select

            grdRegistros.Col = 8
            VLTitular = grdRegistros.CtlText
            opttitular(0).Checked = IIf(grdRegistros.CtlText = "S", True, False)
            opttitular(1).Checked = IIf(grdRegistros.CtlText = "N", True, False)

            grdRegistros.Col = 9
            VLUCta = grdRegistros.CtlText
            optucta(0).Checked = IIf(grdRegistros.CtlText = "S", True, False)
            optucta(1).Checked = IIf(grdRegistros.CtlText = "N", True, False)

            grdRegistros.Col = 10 'ccb nemonico
            txtnemo.Text = grdRegistros.CtlText

            grdRegistros.Col = 11 'ccb codigo otro concepto
            txtcampo(12).Text = grdRegistros.CtlText
            txtcampo_Leave(_txtcampo_12, Nothing)
        End If
    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
        PMLineaG(grdRegistros)
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(20007))
    End Sub
    Private Sub _txtcampo_12_Enter(sender As Object, e As EventArgs) Handles _txtcampo_12.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(20008))
    End Sub

End Class


