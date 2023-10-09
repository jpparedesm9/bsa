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
Partial Public Class FMantenimientoClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


    Dim VLPaso As Integer = 0
    Dim VLDato As String = ""
    Dim VLFecha As String = ""
    Dim VLMoneda As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_2.Click, _cmdBoton_1.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTFilas As Integer = 0
        Dim VTServicio As String = String.Empty
        Dim VTCategoria As String = String.Empty
        Dim VTTipoRango As String = String.Empty
        Dim VTRango As String = String.Empty
        TSBotones.Focus()
        Select Case Index
            Case 0
                If mskFecha.ClipText = "" Then
                    COBISMessageBox.Show(FMLoadResString(1430), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskFecha.Focus()
                    Exit Sub
                End If
                If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1264), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1423), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                If txtCampo(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1285), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(1).Focus()
                    Exit Sub
                End If
                If mskCosto(1).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1307), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCosto(1).Focus()
                    Exit Sub
                End If
                If mskCosto(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1304), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCosto(2).Focus()
                    Exit Sub
                End If
                If mskCosto(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1296), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCosto(0).Focus()
                    Exit Sub
                End If
                Dim valormin, valormax, valorbase As Double
                If mskCosto(1).Text <> "" Then
                    valormin = Conversion.Val(Replace(mskCosto(1).Text, ",", ""))
                    valormax = Conversion.Val(Replace(mskCosto(2).Text, ",", ""))
                    valorbase = Conversion.Val(Replace(mskCosto(0).Text, ",", ""))
                    If valormin > valormax Then
                        COBISMessageBox.Show(FMLoadResString(1305), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        mskCosto(2).Text = ""
                        mskCosto(2).Focus()
                        Exit Sub
                    End If
                End If
                If mskCosto(2).Text <> "" Then
                    If valorbase > valormax Then
                        COBISMessageBox.Show(FMLoadResString(1297), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        mskCosto(0).Text = ""
                        mskCosto(0).Focus()
                        Exit Sub
                    End If
                End If
                If mskCosto(1).Text <> "" Then
                    If valorbase < valormin Then
                        COBISMessageBox.Show(FMLoadResString(1297), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        mskCosto(0).Text = ""
                        mskCosto(0).Focus()
                        Exit Sub
                    End If
                End If



                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4049")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
                PMPasoValores(sqlconn, "@i_servicio_per", 0, SQLINT2, txtCampo(3).Text)
                PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT2, lblDescripcion(2).Text)
                PMPasoValores(sqlconn, "@i_rango", 0, SQLINT1, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_medio", 0, SQLMONEY, mskCosto(0).Text)
                PMPasoValores(sqlconn, "@i_minimo", 0, SQLMONEY, mskCosto(1).Text)
                PMPasoValores(sqlconn, "@i_maximo", 0, SQLMONEY, mskCosto(2).Text)
                PMPasoValores(sqlconn, "@i_fecha_vigencia", 0, SQLVARCHAR, FMConvFecha(mskFecha.Text, VGFormatoFecha, CGFormatoBase))
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_reg_cambios_costos", True, FMLoadResString(1606)) Then
                    PMChequea(sqlconn)
                    cmdBoton(0).Enabled = False
                    cmdBoton_Click(cmdBoton(3), New EventArgs())
                Else
                    PMChequea(sqlconn)
                End If
            Case 1
                For i As Integer = 0 To 2
                    mskCosto(i).Text = ""
                Next i
                For i As Integer = 0 To 10
                    lblDescripcion(i).Text = ""
                Next i
                For i As Integer = 0 To 3
                    txtCampo(i).Text = ""
                    txtCampo(i).Enabled = True
                Next i
                txtCampo(0).Focus()
                PMLimpiaGrid(grdServicios)
                PMCargarFechaIni()
                'mskFecha.Text = FMConvFecha(VGFecha, CGFormatoBase, VGFormatoFecha)
                PMObjetoSeguridad(cmdBoton(0))
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
                PLTSEstado()
                _txtCampo_0.Focus()

            Case 2
                Me.Close() '19/05/2016 migracion
            Case 3
                If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1254), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                VTFilas = VGMaxRows
                VTServicio = "0"
                VTCategoria = "0"
                VTTipoRango = "0"
                VTRango = "0"
                While VTFilas = VGMaxRows
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4059")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text)
                    PMPasoValores(sqlconn, "@i_servicio", 0, SQLINT2, VTServicio)
                    PMPasoValores(sqlconn, "@i_rango", 0, SQLINT2, VTRango)
                    PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT2, VTTipoRango)
                    PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, VTCategoria)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help2_costos", True, FMLoadResString(1105)) Then
                        If VTServicio = "0" Then
                            PMMapeaGrid(sqlconn, grdServicios, False)
                        Else
                            PMMapeaGrid(sqlconn, grdServicios, True)
                        End If
                        PMMapeaTextoGrid(grdServicios)
                        PMAnchoColumnasGrid(grdServicios)
                        PMAgregarDecimal(grdServicios, 11)
                        PMAgregarDecimal(grdServicios, 12)
                        PMAgregarDecimal(grdServicios, 13)
                        PMChequea(sqlconn)
                        grdServicios.Col = 1
                        grdServicios.Row = grdServicios.Rows - 1
                        VTServicio = grdServicios.CtlText
                        grdServicios.Col = 3
                        grdServicios.Row = grdServicios.Rows - 1
                        VTTipoRango = grdServicios.CtlText
                        grdServicios.Col = 7
                        grdServicios.Row = grdServicios.Rows - 1
                        VTCategoria = grdServicios.CtlText
                        grdServicios.Col = 10
                        grdServicios.Row = grdServicios.Rows - 1
                        VTRango = grdServicios.CtlText
                        If Conversion.Val(Convert.ToString(grdServicios.Tag)) > 0 Then
                            grdServicios.ColAlignment(11) = 1
                            grdServicios.ColAlignment(12) = 1
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
                    VTFilas = Conversion.Val(Convert.ToString(grdServicios.Tag))
                End While
                grdServicios.Cols = 14
                grdServicios.Col = 1
        End Select
        PLTSEstado()
    End Sub

    Private Sub FMantenimiento_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PMCargarFechaIni()
        PMObjetoSeguridad(cmdBoton(0))
        PMObjetoSeguridad(cmdBoton(3))
        _txtCampo_0.Focus()
        PLTSEstado()
    End Sub

    Private Sub FMantenimiento_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdServicios_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdServicios.ClickEvent
        grdServicios.Col = 0
        grdServicios.SelStartCol = 1
        grdServicios.SelEndCol = grdServicios.Cols - 1
        If grdServicios.Row = 0 Then
            grdServicios.SelStartRow = 1
            grdServicios.SelEndRow = 1
        Else
            grdServicios.SelStartRow = grdServicios.Row
            grdServicios.SelEndRow = grdServicios.Row
        End If
    End Sub

    Private Sub grdServicios_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdServicios.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1451))
    End Sub

    Private Sub grdServicios_KeyUp(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles grdServicios.KeyUp
        grdServicios.Col = 0
        grdServicios.SelStartCol = 1
        grdServicios.SelEndCol = grdServicios.Cols - 1
        If grdServicios.Row = 0 Then
            grdServicios.SelStartRow = 1
            grdServicios.SelEndRow = 1
        Else
            grdServicios.SelStartRow = grdServicios.Row
            grdServicios.SelEndRow = grdServicios.Row
        End If
    End Sub

    Private Sub mskCosto_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskCosto_1.Enter, _mskCosto_0.Enter, _mskCosto_2.Enter
        Dim Index As Integer = Array.IndexOf(mskCosto, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1117))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1810))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1937))
        End Select
        mskCosto(Index).SelStart = 0
        mskCosto(Index).SelLength = Strings.Len(mskCosto(Index).Text)
    End Sub

    Private Sub mskCosto_KeyPressEvent(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _mskCosto_1.KeyPress, _mskCosto_0.KeyPress, _mskCosto_2.KeyPress
        Dim Index As Integer = Array.IndexOf(mskCosto, eventSender)
        Select Case Index
            Case 0, 1, 2
                If (Asc(eventArgs.KeyChar) < 48 Or Asc(eventArgs.KeyChar) > 57) And (Asc(eventArgs.KeyChar) <> 8) And (Asc(eventArgs.KeyChar) <> 46) Then
                    eventArgs.KeyChar = Chr(0)
                End If
                eventArgs.KeyChar = ChrW(FMValidarNumero(mskCosto(Index).Text, 16, Asc(eventArgs.KeyChar), "105"))
        End Select
    End Sub

    Private Sub mskCosto_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskCosto_1.Leave, _mskCosto_0.Leave, _mskCosto_2.Leave
        Dim Index As Integer = Array.IndexOf(mskCosto, eventSender)
        If mskCosto(Index).Text <> "0.00" Then
            If txtCampo(3).Text = "" Then
                COBISMessageBox.Show(FMLoadResString(1264), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskCosto(0).Text = ""
                txtCampo(3).Focus()
                Exit Sub
            End If
        End If
        Select Case Index
            Case 0
                If mskCosto(0).Text <> "0.00" Then
                    Dim dbNumericTemp As Double = 0
                    If Not Double.TryParse(mskCosto(0).Text, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp) Then
                        mskCosto(0).Text = ""
                        mskCosto(0).Focus()
                        Exit Sub
                    End If
                    If VLDato = "P" Then
                        If Conversion.Val(mskCosto(0).Text.ToString()) > 100 Then
                            COBISMessageBox.Show(FMLoadResString(1298), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            mskCosto(0).Text = ""
                            mskCosto(0).Focus()
                            Exit Sub
                        End If
                    End If
                End If
            Case 1
                If mskCosto(1).Text <> "0.00" Then
                    Dim dbNumericTemp2 As Double = 0
                    If Not Double.TryParse(mskCosto(1).Text, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp2) Then
                        mskCosto(1).Text = ""
                        mskCosto(1).Focus()
                        Exit Sub
                    End If
                    If VLDato = "P" Then
                        If Conversion.Val(mskCosto(1).Text.ToString()) > 100 Then
                            COBISMessageBox.Show(FMLoadResString(1306), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            mskCosto(1).Text = ""
                            mskCosto(1).Focus()
                            Exit Sub
                        End If
                    End If
                End If
            Case 2
                If mskCosto(2).Text <> "0.00" Then
                    Dim dbNumericTemp3 As Double = 0
                    If Not Double.TryParse(mskCosto(2).Text, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp3) Then
                        mskCosto(2).Text = ""
                        mskCosto(2).Focus()
                        Exit Sub
                    End If
                    If VLDato = "P" Then
                        If Conversion.Val(mskCosto(2).Text.ToString()) > 100 Then
                            COBISMessageBox.Show(FMLoadResString(1303), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            mskCosto(2).Text = ""
                            mskCosto(2).Focus()
                            Exit Sub
                        End If
                    End If
                End If
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub mskCosto_MouseDownEvent(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles _mskCosto_1.MouseDown, _mskCosto_0.MouseDown, _mskCosto_2.MouseDown
        Dim Index As Integer = Array.IndexOf(mskCosto, eventSender)
        Select Case Index
            Case 0, 1, 2
                My.Computer.Clipboard.Clear()
        End Select
    End Sub

    Private Sub mskFecha_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFecha.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1369))
    End Sub

    Private Sub mskFecha_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFecha.Leave
        Dim VTValido As Integer = 0
        If mskFecha.ClipText <> "" Then
            VTValido = FMVerFormato(mskFecha.Text, VGFormatoFecha)
            If Not VTValido Then
                COBISMessageBox.Show(FMLoadResString(1378), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                mskFecha.Mask = ""
                mskFecha.Text = ""
                mskFecha.Mask = FMMascaraFecha(VGFormatoFecha)
                mskFecha.DateType = PLFormatoFecha()
                mskFecha.Connection = VGMap
                mskFecha.Focus()
                Exit Sub
            End If
        End If
        If mskFecha.Text <> StringsHelper.Format(VLFecha, VGFormatoFecha) Then
            If FMDateDiff("d", StringsHelper.Format(VLFecha, VGFormatoFecha), mskFecha.Text, VGFormatoFecha) < 0 Then
                COBISMessageBox.Show(FMLoadResString(1368), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskFecha.Mask = ""
                mskFecha.Text = ""
                mskFecha.Mask = FMMascaraFecha(VGFormatoFecha)
                mskFecha.DateType = PLFormatoFecha()
                mskFecha.Connection = VGMap
                mskFecha.Focus()
                Exit Sub
            End If
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub PlLimpiar()
        For i As Integer = 0 To 2
            mskCosto(i).Text = ""
        Next i
        For i As Integer = 0 To 9
            lblDescripcion(i).Text = ""
        Next i
        For i As Integer = 1 To 3
            txtCampo(i).Text = ""
            'txtCampo(i).Enabled = True
        Next i
        PMLimpiaGrid(grdServicios)
    End Sub

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.TextChanged, _txtCampo_3.TextChanged, _txtCampo_1.TextChanged, _txtCampo_2.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 2
                VLPaso = False
            Case 1
                lblDescripcion(4).Text = System.String.Empty
                lblDescripcion(5).Text = System.String.Empty
                VLPaso = False
            Case 3
                lblDescripcion(0).Text = System.String.Empty
                lblDescripcion(1).Text = System.String.Empty
                lblDescripcion(2).Text = System.String.Empty
                lblDescripcion(6).Text = System.String.Empty
                lblDescripcion(7).Text = System.String.Empty
                lblDescripcion(8).Text = System.String.Empty
                lblDescripcion(9).Text = System.String.Empty
                VLPaso = False
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Enter, _txtCampo_3.Enter, _txtCampo_1.Enter, _txtCampo_2.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = True
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1151))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1680))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1068))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1166))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_0.KeyDown, _txtCampo_3.KeyDown, _txtCampo_1.KeyDown, _txtCampo_2.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    VGOperacion = "sp_hp_sucursal"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4079")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", True, FMLoadResString(1913)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMAnchoColumnasGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        If VGValores(1) <> "" Then
                            txtCampo(0).Text = VGValores(1)
                            lblDescripcion(10).Text = VGValores(2)
                            PlLimpiar()
                        Else
                            PlLimpiar()
                            txtCampo(0).Text = ""
                            lblDescripcion(10).Text = ""
                            VGOperacion = ""
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                        VLPaso = True
                    Else
                        PMChequea(sqlconn)
                        txtCampo(0).Text = ""
                        lblDescripcion(10).Text = ""
                        VGOperacion = ""
                    End If
                Case 1
                    If txtCampo(3).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1264), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(3).Focus()
                        Exit Sub
                    End If
                    VGOperacion = "sp_corango_pe"
                    VServicioP = txtCampo(3).Text
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4048")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_servicio_per", 0, SQLINT2, txtCampo(3).Text)
                    PMPasoValores(sqlconn, "@i_rango", 0, SQLINT1, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_corango_pe", True, FMLoadResString(1595)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        If VGValores(1) <> "" Then
                            txtCampo(1).Text = VGValores(1)
                            lblDescripcion(4).Text = VGValores(2)
                            lblDescripcion(5).Text = VGValores(3)
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                        VGOperacion = ""
                    End If
                    VLPaso = True
                Case 2
                    If txtCampo(3).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1264), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(3).Focus()
                        Exit Sub
                    End If
                    PMCatalogo("A", "pe_categoria", txtCampo(2), lblDescripcion(3), FRegistros)
                    VLPaso = True
                Case 3
                    VGOperacion = "sp_help_rubros"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4046")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT1, "0")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text)
                    VGSucursalSig = CInt(txtCampo(0).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rubros", True, FMLoadResString(1560)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        VGOperacion = ""
                        If VGValores(1) = "" Then
                            Exit Sub
                        End If
                        txtCampo(3).Text = VGValores(1)
                        lblDescripcion(0).Text = VGValores(2)
                        lblDescripcion(2).Text = VGValores(3)
                        lblDescripcion(9).Text = VGValores(4)
                        lblDescripcion(8).Text = VGValores(5)
                        VLDato = VGValores(6)
                        If lblDescripcion(2).Text <> "" Then
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4038")
                            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                            PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT1, lblDescripcion(2).Text)
                            PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "T")
                            Dim Valores(10) As String
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rango_pe", False, FMLoadResString(1595)) Then
                                FMMapeaArreglo(sqlconn, Valores)
                                PMChequea(sqlconn)
                                lblDescripcion(1).Text = Valores(1)
                                lblDescripcion(6).Text = Valores(2)
                                lblDescripcion(7).Text = Valores(3)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4044")
                                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
                                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, lblDescripcion(6).Text)
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_promon", False, FMLoadResString(1562)) Then
                                    PMMapeaVariable(sqlconn, VLMoneda)
                                    PMChequea(sqlconn)
                                Else
                                    PMChequea(sqlconn)
                                End If
                            Else
                                PMChequea(sqlconn)
                                txtCampo(3).Text = ""
                                lblDescripcion(0).Text = ""
                                lblDescripcion(2).Text = ""
                                VLDato = ""
                            End If
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                        VGOperacion = ""
                    End If
                    VLPaso = True
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_0.KeyPress, _txtCampo_3.KeyPress, _txtCampo_1.KeyPress, _txtCampo_2.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 2
                KeyAscii = FMValidaTipoDato("A", KeyAscii)
                KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
            Case 0, 1, 3
                If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                    KeyAscii = 0
                End If
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Leave, _txtCampo_3.Leave, _txtCampo_1.Leave, _txtCampo_2.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim Valores() As String
        Select Case Index
            Case 0
                If Not VLPaso Then
                    If txtCampo(0).Text <> "" Then
                        If CDbl(txtCampo(0).Text) > 32000 Then
                            COBISMessageBox.Show(FMLoadResString(1263), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(0).Text = ""
                            txtCampo(0).Focus()
                            Exit Sub
                        End If
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4078")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(0).Text)
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", True, FMLoadResString(1913)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(10))
                            PMChequea(sqlconn)
                            PlLimpiar()
                        Else
                            PMChequea(sqlconn)
                            PlLimpiar()
                            lblDescripcion(10).Text = ""
                            txtCampo(0).Text = ""
                            txtCampo(0).Focus()
                            VLPaso = True
                        End If
                    Else
                        lblDescripcion(10).Text = ""
                    End If
                End If
            Case 1
                If Not VLPaso Then
                    If txtCampo(1).Text = "" Then
                        Exit Sub
                    End If
                    If lblDescripcion(2).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1264), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(1).Text = ""
                        txtCampo(1).Focus()
                        Exit Sub
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4047")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                    PMPasoValores(sqlconn, "@i_servicio_per", 0, SQLINT2, txtCampo(3).Text)
                    PMPasoValores(sqlconn, "@i_rango", 0, SQLINT1, txtCampo(1).Text)
                    ReDim Valores(5)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_corango_pe", True, FMLoadResString(1595)) Then
                        FMMapeaArreglo(sqlconn, Valores)
                        PMChequea(sqlconn)
                        lblDescripcion(4).Text = Valores(1)
                        lblDescripcion(5).Text = Valores(2)
                    Else
                        PMChequea(sqlconn)
                        lblDescripcion(4).Text = ""
                        lblDescripcion(5).Text = ""
                        txtCampo(1).Text = ""
                        txtCampo(1).Focus()
                    End If
                End If
            Case 2
                If Not VLPaso Then
                    If txtCampo(2).Text = "" Then
                        lblDescripcion(3).Text = ""
                        Exit Sub
                    End If
                    If txtCampo(3).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1264), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(2).Text = ""
                        txtCampo(2).Focus()
                        Exit Sub
                    End If
                    If txtCampo(2).Text = "" Then
                        lblDescripcion(3).Text = ""
                        txtCampo(2).Focus()
                        Exit Sub
                    End If
                    PMCatalogo("V", "pe_categoria", txtCampo(2), lblDescripcion(3), Nothing)
                    If txtCampo(2).Text = "" Then txtCampo(2).Focus()
                End If
            Case 3
                If Not VLPaso Then
                    If txtCampo(3).Text = "" Then
                        Exit Sub
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4046")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, txtCampo(3).Text)
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text)
                    ReDim Valores(7)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rubros", True, FMLoadResString(1560)) Then
                        FMMapeaArreglo(sqlconn, Valores)
                        PMChequea(sqlconn)
                        lblDescripcion(0).Text = Valores(1)
                        lblDescripcion(2).Text = Valores(2)
                        lblDescripcion(9).Text = Valores(3)
                        lblDescripcion(8).Text = Valores(4)
                        VLDato = Valores(5)
                        If lblDescripcion(2).Text <> "" Then
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4038")
                            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                            PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT1, lblDescripcion(2).Text)
                            PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "T")
                            ReDim Valores(10)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rango_pe", False, FMLoadResString(1595)) Then
                                FMMapeaArreglo(sqlconn, Valores)
                                PMChequea(sqlconn)
                                lblDescripcion(1).Text = Valores(1)
                                lblDescripcion(6).Text = Valores(2)
                                lblDescripcion(7).Text = Valores(3)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4044")
                                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
                                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, lblDescripcion(6).Text)
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_promon", False, FMLoadResString(1562)) Then
                                    PMMapeaVariable(sqlconn, VLMoneda)
                                    PMChequea(sqlconn)
                                Else
                                    PMChequea(sqlconn)
                                End If
                            Else
                                PMChequea(sqlconn)
                                txtCampo(3).Text = ""
                                lblDescripcion(0).Text = ""
                                lblDescripcion(2).Text = ""
                                VLDato = ""
                            End If
                        End If
                    Else
                        PMChequea(sqlconn)
                        txtCampo(3).Text = ""
                        lblDescripcion(0).Text = ""
                        lblDescripcion(1).Text = ""
                        lblDescripcion(2).Text = ""
                        lblDescripcion(6).Text = ""
                        lblDescripcion(7).Text = ""
                        txtCampo(3).Focus()
                    End If
                End If
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_0.MouseDown, _txtCampo_3.MouseDown, _txtCampo_1.MouseDown, _txtCampo_2.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3
                My.Computer.Clipboard.Clear()
        End Select
    End Sub

    Public Sub PMCargarFechaIni()
        Dim VLFechaini As String
        Dim VLFormatoFecha As String = VGFormatoFecha
        mskFecha.Mask = FMMascaraFecha(VLFormatoFecha)
        mskFecha.DateType = PLFormatoFecha()
        mskFecha.Connection = VGMap
        VLFechaini = VGFechaProceso
        VLFecha = FMDateAdd(VLFechaini, "d", 1, VGFormatoFecha)
        mskFecha.Text = FMConvFecha(VLFecha, VLFormatoFecha, VLFormatoFecha)
    End Sub


    Private Sub PLTSEstado()
        TSBIngresar.Enabled = _cmdBoton_0.Enabled
        TSBIngresar.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBBuscar.Enabled = _cmdBoton_3.Enabled
        TSBBuscar.Visible = _cmdBoton_3.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBIngresar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBIngresar.Click
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

    Private Sub grdServicios_Leave(sender As Object, e As EventArgs) Handles grdServicios.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

End Class


