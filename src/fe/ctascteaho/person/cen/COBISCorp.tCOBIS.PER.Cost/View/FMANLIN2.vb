Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Drawing
Imports System.Globalization
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
Partial Public Class FMantenLinea2Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLPaso As Integer = 0
    Dim VLDato As String = ""
    Dim VLFormatoFecha As String = ""
    Dim m As System.Drawing.Bitmap
    Public VLSumSucursal As Integer
    Public VLNumSecuencial As Integer
    Dim Sucursal(1000) As String
    Dim num_select As Integer = 0
    Dim fila As Integer

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_2.Click, _cmdBoton_1.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VLNumSuc As Integer = 0
        Dim VLMaxSuc As Integer = 0
        Dim VLContLoop As Integer = 0
        Dim VLSucBak As Integer = 0
        Dim VLPSuc As String = ""
        Dim VLSucEnv As Integer = 0
        Dim VLParam As String = ""
        TSBotones.Focus()
        Select Case Index
            Case 0
                If mskFecha.ClipText = "" Then
                    COBISMessageBox.Show(FMLoadResString(1430), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskFecha.Focus()
                    Exit Sub
                End If
                If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1284), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(3).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1266), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                If txtCampo(4).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1267), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(4).Focus()
                    Exit Sub
                End If
                If txtCampo(5).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1265), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(5).Focus()
                    Exit Sub
                End If
                If txtCampo(6).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1293), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(6).Focus()
                    Exit Sub
                End If
                If txtCampo(7).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1280), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(7).Focus()
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
                Dim Sucursal(1000) As String
                VLNumSuc = 0
                For i As Integer = 1 To grdSucurs.Rows - 1
                    grdSucurs.Row = i
                    grdSucurs.Col = 0
                    If grdSucurs.Picture Is picVisto(0).Image Then
                        grdSucurs.Col = 1
                        VLNumSuc += 1
                        Sucursal(VLNumSuc) = grdSucurs.CtlText
                    End If
                Next i
                If VLNumSuc = 0 Then
                    COBISMessageBox.Show(FMLoadResString(1177), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    Exit Sub
                End If
                VLMaxSuc = 40
                VLContLoop = 0
                Do
                    VLSucBak = (VLContLoop + 1) * VLMaxSuc
                    If VLSucBak > VLNumSuc Then VLSucBak = VLNumSuc
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4082")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
                    PMPasoValores(sqlconn, "@i_prod_cobis", 0, SQLINT1, txtCampo(4).Text)
                    PMPasoValores(sqlconn, "@i_prod_banc", 0, SQLINT2, txtCampo(0).Text)
                    PMPasoValores(sqlconn, "@i_sector", 0, SQLVARCHAR, txtCampo(3).Text)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, lblDescripcion(9).Text)
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    VLPSuc = "@i_suc"
                    VLSucEnv = 0
                    For i As Integer = VLContLoop * VLMaxSuc + 1 To VLSucBak
                        VLParam = VLPSuc & CStr(i)
                        VLSucEnv += 1
                        PMPasoValores(sqlconn, VLParam, 0, SQLINT2, Sucursal(i))
                    Next i
                    PMPasoValores(sqlconn, "@i_num_suc", 0, SQLINT2, CStr(VLSucEnv))
                    PMPasoValores(sqlconn, "@i_serv_dis", 0, SQLINT2, txtCampo(5).Text)
                    PMPasoValores(sqlconn, "@i_rubro", 0, SQLVARCHAR, lblDescripcion(2).Text)
                    PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT1, txtCampo(6).Text)
                    PMPasoValores(sqlconn, "@i_grupo_rango", 0, SQLINT2, txtCampo(7).Text)
                    PMPasoValores(sqlconn, "@i_categoria", 0, SQLVARCHAR, txtCampo(2).Text)
                    PMPasoValores(sqlconn, "@i_rango", 0, SQLINT1, txtCampo(1).Text)
                    PMPasoValores(sqlconn, "@i_val_med", 0, SQLMONEY, mskCosto(0).Text)
                    PMPasoValores(sqlconn, "@i_val_min", 0, SQLMONEY, mskCosto(1).Text)
                    PMPasoValores(sqlconn, "@i_val_max", 0, SQLMONEY, mskCosto(2).Text)
                    PMPasoValores(sqlconn, "@i_fecha_vigen", 0, SQLVARCHAR, FMConvFecha(mskFecha.Text, VGFormatoFecha, CGFormatoBase))
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_costos_total", True, FMLoadResString(1606)) Then
                        PMChequea(sqlconn)
                        cmdBoton(0).Enabled = False
                    Else
                        PMChequea(sqlconn)
                        Exit Sub
                    End If
                    VLContLoop += 1
                    If VLSucBak = VLNumSuc Then VLSucBak = 0
                Loop While VLSucBak = VLMaxSuc
            Case 1
                If txtCampo(1).Text <> "" Then
                    txtCampo(1).Text = ""
                    txtCampo(1).Enabled = True
                    For i As Integer = 0 To 2
                        mskCosto(i).Text = "0"
                    Next i
                    For i As Integer = 4 To 5
                        lblDescripcion(i).Text = ""
                    Next i
                    txtCampo(1).Focus()
                Else
                    If txtCampo(2).Text <> "" Then
                        txtCampo(2).Text = ""
                        txtCampo(2).Enabled = True
                        lblDescripcion(3).Text = ""
                        txtCampo(2).Focus()
                    Else
                        If txtCampo(6).Text <> "" Or txtCampo(7).Text <> "" Then
                            txtCampo(6).Text = ""
                            txtCampo(6).Enabled = True
                            txtCampo(7).Text = ""
                            txtCampo(7).Enabled = True
                            lblDescripcion(6).Text = ""
                            txtCampo(6).Focus()
                        Else
                            If txtCampo(5).Text <> "" Then
                                txtCampo(5).Text = ""
                                lblDescripcion(8).Text = ""
                                lblDescripcion(2).Text = ""
                                lblDescripcion(1).Text = ""
                                txtCampo(5).Enabled = True
                                txtCampo(5).Focus()
                            Else
                                If txtCampo(4).Text <> "" Then
                                    txtCampo(4).Text = ""
                                    txtCampo(4).Enabled = True
                                    For i As Integer = 7 To 11 Step 2
                                        lblDescripcion(i).Text = ""
                                    Next i
                                    txtCampo(4).Focus()
                                Else
                                    If txtCampo(3).Text <> "" Then
                                        txtCampo(3).Text = ""
                                        txtCampo(3).Enabled = True
                                        lblDescripcion(0).Text = ""
                                        txtCampo(3).Focus()
                                    Else
                                        If txtCampo(0).Text <> "" Then
                                            txtCampo(0).Text = ""
                                            txtCampo(0).Enabled = True
                                            lblDescripcion(10).Text = ""
                                            txtCampo(0).Focus()
                                            PMCargarSucursales()
                                            _txtCampo_0.Focus()
                                        End If
                                        PMCargarSucursales()
                                        ReDim Sucursal(1000)
                                        num_select = 0
                                    End If
                                End If
                            End If
                        End If
                    End If
                    PMCargarFechaIni()
                End If
                VLPaso = True
                cmdBoton(0).Enabled = True
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
            Case 2
                Me.Close()
        End Select
        PLTSEstado()
    End Sub

    Private Sub FMantenLinea2_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PMCargarFechaIni()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4079")
        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", True, FMLoadResString(1913)) Then
            PMMapeaGrid(sqlconn, grdSucurs, False)
            PMMapeaTextoGrid(grdSucurs)
            PMAnchoColumnasGrid(grdSucurs)
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
        PMObjetoSeguridad(cmdBoton(0))
    End Sub

    Private Sub FMantenLinea2_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdSucurs_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdSucurs.ClickEvent
        grdSucurs.Col = 0
        grdSucurs.ColorSelectedCells = Color.FromArgb(190, 235, 240)
        grdSucurs.SelStartCol = 1
        grdSucurs.SelEndCol = CShort(grdSucurs.Cols - 1)
        If grdSucurs.Row = 0 Then
            grdSucurs.SelStartRow = 1
            grdSucurs.SelEndRow = 1
        Else
            grdSucurs.SelStartRow = grdSucurs.Row
            grdSucurs.SelEndRow = grdSucurs.Row
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502048))

    End Sub

    Private Sub grdSucurs_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdSucurs.DblClick
        If grdSucurs.Rows <= 2 Then
            grdSucurs.Row = 1
            grdSucurs.Col = 1
            If grdSucurs.CtlText.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(1507), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        End If
        PMMarcarRegistro()
    End Sub

    Private Sub mskCosto_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskCosto_1.Enter, _mskCosto_0.Enter, _mskCosto_2.Enter
        Dim Index As Integer = Array.IndexOf(mskCosto, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1117))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1810))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1808))
        End Select
        mskCosto(Index).SelStart = 0
        mskCosto(Index).SelLength = Strings.Len(mskCosto(Index).Text)
    End Sub

    Private Sub mskCosto_KeyDownEvent(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles _mskCosto_1.KeyDown, _mskCosto_0.KeyDown, _mskCosto_2.KeyDown
        Dim Index As Integer = Array.IndexOf(mskCosto, eventSender)
        If eventArgs.KeyCode = 46 Then
            mskCosto(Index).Text = ""
        End If
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
                COBISMessageBox.Show(FMLoadResString(1266), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
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
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1394))
    End Sub

    Private Sub mskCosto_MouseDown(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.MouseEventArgs) Handles _mskCosto_1.MouseDown, _mskCosto_0.MouseDown, _mskCosto_2.MouseDown
        Dim Index As Integer = Array.IndexOf(mskCosto, eventSender)
        Select Case Index
            Case 0, 1, 2
                My.Computer.Clipboard.Clear()
                'My.Computer.Clipboard.SetText("")
        End Select
    End Sub

    Private Sub mskFecha_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFecha.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1367) & "[" & VGFormatoFecha & "]")
    End Sub

    Private Sub mskFecha_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFecha.Leave
        Dim VTValido As Integer = 0
        Dim VTValido1 As String = String.Empty
        Dim VTValido2 As String = String.Empty
        Dim VLFecha As String = ""
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
        VTValido1 = StringsHelper.Format(mskFecha.Text, VGFormatoFecha)
        VTValido2 = StringsHelper.Format(VGFecha, VGFormatoFecha)
        If mskFecha.Text <> StringsHelper.Format(VLFecha, VGFormatoFecha) Then
            If FMDateDiff("d", VTValido1, VTValido2, VGFormatoFecha) > 0 Then
                COBISMessageBox.Show(FMLoadResString(1373) & VGFechaProceso, My.Application.Info.ProductName)
                mskFecha.Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
                mskFecha.Focus()
                Exit Sub
            End If
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub



    Private Sub PMMarcarRegistro()
        grdSucurs.Col = 0
        If grdSucurs.Picture Is Nothing Or m Is picVisto(1).Image Then
            grdSucurs.CtlText = Conversion.Str(grdSucurs.Row)
            grdSucurs.Picture = picVisto(0).Image
            m = picVisto(0).Image
            grdSucurs.Col = 1
            fila = grdSucurs.Row
            Sucursal.SetValue(Trim(grdSucurs.CtlText), num_select)
            num_select = num_select + 1
        Else
            grdSucurs.CtlText = Conversion.Str(grdSucurs.Row)
            grdSucurs.Picture = picVisto(1).Image
            m = picVisto(1).Image
            fila = grdSucurs.Row
            grdSucurs.Col = 1
            For i As Integer = 0 To Sucursal.Length - 1
                If Sucursal(i) = grdSucurs.CtlText Then
                    Sucursal(i) = ""
                    Exit For
                End If
            Next i
            PMDesmarcarSelec(Sucursal)
        End If
        grdSucurs.Row = fila
        grdSucurs.AutoResizeColumns()
        grdSucurs.ColorSelectedCells = Color.FromArgb(190, 235, 240)
        grdSucurs.SelStartCol = 1
        grdSucurs.SelEndCol = CShort(grdSucurs.Cols - 1)
        If grdSucurs.Row = 0 Then
            grdSucurs.SelStartRow = 1
            grdSucurs.SelEndRow = 1
        Else
            grdSucurs.SelStartRow = grdSucurs.Row
            grdSucurs.SelEndRow = grdSucurs.Row
        End If
        fila = 0
        grdSucurs.AutoResizeColumns()
    End Sub

    Public Function CompareBitmaps(img1 As Bitmap, img2 As Bitmap) As Boolean

        If ((img1 Is Nothing) OrElse _
            (img2 Is Nothing)) Then Return False

        Try
            ' Compruebo si el tamaño de las imágenes son iguales.
            '
            Dim equal As Boolean = img1.Size.Equals(img2.Size)

            If (Not (equal)) Then Return False

            ' Los tamaños de las dos imágenes son iguales.
            '
            ' Recorremos los píxeles para verificar que
            ' sus colores son iguales en ambas imágenes.
            '
            For x As Integer = 0 To img1.Width - 1

                For y As Integer = 0 To img1.Height - 1

                    Dim color1 As Color = img1.GetPixel(x, y)
                    Dim color2 As Color = img2.GetPixel(x, y)

                    If (Not (color1.Equals(color2))) Then
                        equal = False
                        Exit For
                    End If

                Next

                If (Not (equal)) Then Exit For

            Next

            Return equal

        Catch ex As Exception
            ' Devolvemos la excepción al
            ' procedimiento llamador.
            Throw

        End Try

    End Function

    Private Sub PMSubserv()
        If VGDetalle(0) = "S" Then
            If txtCampo(5).Text = "" Then
                lblDescripcion(8).Text = VGDetalle(1)
                lblDescripcion(1).Text = VGDetalle(2)
                txtCampo(5).Text = VGDetalle(3)
                lblDescripcion(2).Text = VGDetalle(4)
            Else
                lblDescripcion(8).Text = VGDetalle(1)
                lblDescripcion(1).Text = VGDetalle(2)
                lblDescripcion(2).Text = VGDetalle(3)
            End If
        End If
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_7.TextChanged, _txtCampo_6.TextChanged, _txtCampo_4.TextChanged, _txtCampo_0.TextChanged, _txtCampo_3.TextChanged, _txtCampo_1.TextChanged, _txtCampo_2.TextChanged, _txtCampo_5.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3, 4, 5, 6, 7
                VLPaso = False
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_7.Enter, _txtCampo_6.Enter, _txtCampo_5.Enter, _txtCampo_4.Enter, _txtCampo_0.Enter, _txtCampo_3.Enter, _txtCampo_1.Enter, _txtCampo_2.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = True
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1659))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1680))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1068))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1776))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1661))
            Case 5
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1715))
            Case 6
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1781))
            Case 7
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1388))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_7.KeyDown, _txtCampo_6.KeyDown, _txtCampo_5.KeyDown, _txtCampo_4.KeyDown, _txtCampo_0.KeyDown, _txtCampo_3.KeyDown, _txtCampo_1.KeyDown, _txtCampo_2.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTFilas As Integer = 0
        Dim VTCodigo As String = String.Empty
        Dim VTMoneda As String = String.Empty
        Dim VTGrupo As String = String.Empty
        Dim VTRango As String = String.Empty
        If KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0
                    VGOperacion = "sp_prod_bancario"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4002")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT4, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prod_bancario", True, FMLoadResString(1918)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMAnchoColumnasGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        txtCampo(0).Text = VGACatalogo.Codigo
                        lblDescripcion(10).Text = VGACatalogo.Descripcion
                        FRegistros.Dispose() '18/05/2016 migracion
                        VLPaso = True
                    Else
                        PMChequea(sqlconn)
                        VGOperacion = ""
                    End If
                Case 1
                    If txtCampo(6).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1293), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        lblDescripcion(6).Text = ""
                        txtCampo(6).Focus()
                        Exit Sub
                    End If
                    If txtCampo(7).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1280), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(7).Focus()
                        Exit Sub
                    End If
                    VGOperacion = "sp_corango_ma"
                    VTipoRango = txtCampo(6).Text
                    VGrupoRango = txtCampo(7).Text
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4080")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT1, txtCampo(6).Text)
                    PMPasoValores(sqlconn, "@i_grupo_rango", 0, SQLINT2, txtCampo(7).Text)
                    PMPasoValores(sqlconn, "@i_rango", 0, SQLINT1, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_corango_ma", True, FMLoadResString(1595)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        If VGValores(1) <> "" Then
                            txtCampo(1).Text = VGValores(1)
                            lblDescripcion(4).Text = VGValores(2)
                            lblDescripcion(5).Text = VGValores(3)
                        Else
                            txtCampo(1).Text = ""
                            lblDescripcion(4).Text = ""
                            lblDescripcion(5).Text = ""
                            txtCampo(1).Focus()
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                        VGOperacion = ""
                    End If
                    VLPaso = True
                Case 2
                    If txtCampo(3).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1266), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(3).Focus()
                        Exit Sub
                    End If
                    PMCatalogo("A", "pe_categoria", txtCampo(2), lblDescripcion(3), FRegistros)
                    VLPaso = True
                Case 3
                    PMCatalogo("A", "cc_tipo_banca", txtCampo(3), lblDescripcion(0), FRegistros)
                    VLPaso = True
                    If txtCampo(3).Text = "" Then
                        txtCampo(2).Text = ""
                        lblDescripcion(3).Text = ""
                    End If
                Case 4
                    VGOperacion = "sp_promon"
                    VGTipo = "H"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4075")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_promon", True, FMLoadResString(1112)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        If VGValores(1) <> "" Then
                            txtCampo(4).Text = VGValores(1)
                            lblDescripcion(9).Text = VGValores(2)
                            lblDescripcion(7).Text = VGValores(3)
                            If lblDescripcion(9).Text = "0" Then
                                lblDescripcion(11).Text = "PESOS"
                            Else
                                lblDescripcion(11).Text = "DOLARES"
                            End If
                            For i As Integer = 1 To 10
                                VGValores(i) = ""
                            Next i
                        Else
                            txtCampo(4).Text = ""
                            lblDescripcion(9).Text = ""
                            lblDescripcion(7).Text = ""
                            lblDescripcion(11).Text = ""
                        End If
                        FRegistros.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                        VGOperacion = ""
                        VGTipo = ""
                    End If
                    VLPaso = True
                Case 5
                    VGForma = "FMantenLinea2"
                    FAyudaSubserv2.ShowPopup(Me)
                    If VGDetalle(1) <> "" Then
                        PMSubserv()
                        VLPaso = True
                    Else
                        lblDescripcion(8).Text = ""
                        lblDescripcion(2).Text = ""
                        lblDescripcion(1).Text = ""
                        txtCampo(5).Text = ""
                        txtCampo(5).Focus()
                    End If
                    FAyudaSubserv2.Dispose() '18/05/2016 migracion
                Case 6
                    VLPaso = True
                    VGOperacion = "sp_help_rango_pe"
                    VGTipo = "T"
                    VTFilas = VGMaxRows
                    VTCodigo = "0"
                    VTMoneda = lblDescripcion(9).Text
                    While VTFilas = VGMaxRows
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4038")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "T")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, VTCodigo)
                        PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VTMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rango_pe", True, FMLoadResString(502081)) Then
                            If VTCodigo = "0" Then
                                PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                            Else
                                PMMapeaGrid(sqlconn, FRegistros.grdRegistros, True)
                            End If
                            PMMapeaTextoGrid(FRegistros.grdRegistros)
                            PMChequea(sqlconn)
                            VTFilas = Conversion.Val(Convert.ToString(FRegistros.grdRegistros.Tag))
                            FRegistros.grdRegistros.Col = 1
                            FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                            VTCodigo = FRegistros.grdRegistros.CtlText
                            FRegistros.grdRegistros.Col = 3
                            FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                            VTMoneda = FRegistros.grdRegistros.CtlText
                        Else
                            PMChequea(sqlconn)
                            VGOperacion = ""
                            VGTipo = ""
                        End If
                    End While
                    FRegistros.grdRegistros.Row = 1
                    FRegistros.ShowPopup(Me)
                    If VGValores(1) <> "" Then
                        txtCampo(6).Text = VGValores(1)
                        lblDescripcion(6).Text = VGValores(2)
                        txtCampo(7).Text = ""
                        txtCampo(1).Text = ""
                        lblDescripcion(4).Text = ""
                        lblDescripcion(5).Text = ""
                        VLPaso = True
                    End If
                    FRegistros.Dispose() '18/05/2016 migracion
                Case 7
                    If txtCampo(6).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1293), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(6).Focus()
                        Exit Sub
                    End If
                    VGOperacion = "sp_help_rango_pe"
                    VGTipo = "G"
                    VTFilas = VGMaxRows
                    VTGrupo = "0"
                    VTRango = "0"
                    While VTFilas = VGMaxRows
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4038")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "G")
                        PMPasoValores(sqlconn, "@i_grupo", 0, SQLINT2, VTGrupo)
                        PMPasoValores(sqlconn, "@i_rango", 0, SQLINT2, VTRango)
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(6).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rango_pe", True, FMLoadResString(502089)) Then
                            If VTGrupo = "0" Then
                                PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                            Else
                                PMMapeaGrid(sqlconn, FRegistros.grdRegistros, True)
                            End If
                            PMMapeaTextoGrid(FRegistros.grdRegistros)
                            PMChequea(sqlconn)
                            VTFilas = Conversion.Val(Convert.ToString(FRegistros.grdRegistros.Tag))
                            If VTFilas > 0 Then
                                FRegistros.grdRegistros.Col = 1
                                FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                                VTGrupo = FRegistros.grdRegistros.CtlText
                                FRegistros.grdRegistros.Col = 2
                                FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                                VTRango = FRegistros.grdRegistros.CtlText
                            End If
                        Else
                            PMChequea(sqlconn)
                            VGOperacion = ""
                            VGTipo = ""
                        End If
                    End While
                    FRegistros.grdRegistros.Row = 1
                    FRegistros.ShowPopup(Me)
                    If VGACatalogo.Codigo <> "" Then
                        txtCampo(7).Text = VGACatalogo.Codigo
                        txtCampo(1).Text = ""
                        lblDescripcion(4).Text = ""
                        lblDescripcion(5).Text = ""
                        VLPaso = True
                    End If
                    FRegistros.Dispose() '18/05/2016 migracion
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_7.KeyPress, _txtCampo_6.KeyPress, _txtCampo_5.KeyPress, _txtCampo_4.KeyPress, _txtCampo_0.KeyPress, _txtCampo_3.KeyPress, _txtCampo_1.KeyPress, _txtCampo_2.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 2, 3
                KeyAscii = FMValidaTipoDato("A", KeyAscii)
                KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
            Case 0, 1, 4, 5, 6, 7
                If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                    KeyAscii = 0
                End If
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_7.Leave, _txtCampo_6.Leave, _txtCampo_5.Leave, _txtCampo_4.Leave, _txtCampo_0.Leave, _txtCampo_3.Leave, _txtCampo_1.Leave, _txtCampo_2.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If Not VLPaso Then
                    If txtCampo(0).Text <> "" Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4003")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(0).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_prod_bancario", True, FMLoadResString(1918)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(10))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(0).Text = ""
                            lblDescripcion(10).Text = ""
                            VLPaso = True
                            txtCampo(0).Focus()
                        End If
                    Else
                        lblDescripcion(10).Text = ""
                        txtCampo(0).Focus()
                    End If
                End If
            Case 1
                If Not VLPaso Then
                    If txtCampo(6).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1293), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        lblDescripcion(6).Text = ""
                        txtCampo(1).Text = ""
                        VLPaso = True
                        txtCampo(6).Focus()
                        Exit Sub
                    End If
                    If txtCampo(7).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1280), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(1).Text = ""
                        VLPaso = True
                        txtCampo(7).Focus()
                        Exit Sub
                    End If
                    If txtCampo(1).Text = "" Then
                        lblDescripcion(4).Text = ""
                        lblDescripcion(5).Text = ""
                        Exit Sub
                    End If
                    If lblDescripcion(2).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1273), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(1).Text = ""
                        VLPaso = True
                        txtCampo(5).Focus()
                        Exit Sub
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4081")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                    PMPasoValores(sqlconn, "@i_grupo_rango", 0, SQLINT2, txtCampo(7).Text)
                    PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT1, txtCampo(6).Text)
                    PMPasoValores(sqlconn, "@i_rango", 0, SQLINT1, txtCampo(1).Text)
                    Dim Valores(5) As String
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_corango_ma", True, FMLoadResString(1595)) Then
                        FMMapeaArreglo(sqlconn, Valores)
                        PMChequea(sqlconn)
                        lblDescripcion(4).Text = Valores(1)
                        lblDescripcion(5).Text = Valores(2)
                    Else
                        PMChequea(sqlconn)
                        lblDescripcion(4).Text = ""
                        lblDescripcion(5).Text = ""
                        txtCampo(1).Text = ""
                        VLPaso = True
                        txtCampo(1).Focus()
                    End If
                End If
            Case 2
                If Not VLPaso Then
                    If txtCampo(3).Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(1266), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(2).Text = ""
                        VLPaso = True
                        txtCampo(3).Focus()
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
                        lblDescripcion(0).Text = ""
                        txtCampo(2).Text = ""
                        lblDescripcion(3).Text = ""
                        txtCampo(3).Focus()
                        Exit Sub
                    End If
                    PMCatalogo("V", "cc_tipo_banca", txtCampo(3), lblDescripcion(0), Nothing)
                    If txtCampo(3).Text = "" And lblDescripcion(3).Text = "" Then
                        txtCampo(3).Focus()
                    End If
                End If
            Case 4
                If Not VLPaso Then
                    If txtCampo(4).Text <> "" Then
                        If txtCampo(4).Text <> "3" And txtCampo(4).Text <> "4" Then
                            COBISMessageBox.Show(FMLoadResString(1142), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(4).Text = ""
                            lblDescripcion(7).Text = ""
                            lblDescripcion(11).Text = ""
                            lblDescripcion(9).Text = ""
                            txtCampo(4).Focus()
                            Exit Sub
                        End If
                        VGOperacion = "sp_promon"
                        VGTipo = "Q"
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4076")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, txtCampo(4).Text)
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_promon", True, FMLoadResString(1112)) Then
                            PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                            PMMapeaTextoGrid(FRegistros.grdRegistros)
                            PMChequea(sqlconn)
                            FRegistros.ShowPopup(Me)
                            If VGValores(1) <> "" Then
                                lblDescripcion(9).Text = VGValores(2)
                                lblDescripcion(7).Text = VGValores(3)
                                If lblDescripcion(9).Text = "0" Then
                                    lblDescripcion(11).Text = "PESOS"
                                Else
                                    lblDescripcion(11).Text = "DOLARES"
                                End If
                            Else
                                lblDescripcion(7).Text = ""
                                lblDescripcion(11).Text = ""
                                lblDescripcion(9).Text = ""
                                txtCampo(4).Text = ""
                                txtCampo(4).Focus()

                            End If
                            For i As Integer = 1 To 5
                                VGValores(i) = ""
                            Next i
                            FRegistros.Dispose() '18/05/2016 migracion
                        Else
                            PMChequea(sqlconn)
                            VLPaso = True
                            txtCampo(2).Text = ""
                            lblDescripcion(9).Text = ""
                            lblDescripcion(7).Text = ""
                            lblDescripcion(11).Text = ""
                            txtCampo(4).Focus()
                        End If
                    Else
                        txtCampo(2).Text = ""
                        lblDescripcion(9).Text = ""
                        lblDescripcion(7).Text = ""
                        lblDescripcion(11).Text = ""
                    End If
                    VGOperacion = ""
                    VGTipo = ""
                End If
            Case 5
                If Not VLPaso Then
                    If txtCampo(5).Text <> "" Then
                        VGForma = "FMantenLinea2"
                        FAyudaSubserv2.ShowPopup(Me)
                        If VGDetalle(1) <> "" Then
                            PMSubserv()
                        Else
                            lblDescripcion(8).Text = ""
                            lblDescripcion(1).Text = ""
                            lblDescripcion(2).Text = ""
                            'lblDescripcion(6).Text = ""
                            'lblDescripcion(3).Text = ""
                            'lblDescripcion(5).Text = ""
                            'lblDescripcion(4).Text = ""
                            txtCampo(5).Text = ""
                            'txtCampo(6).Text = ""
                            'txtCampo(7).Text = ""
                            'txtCampo(2).Text = ""
                            'txtCampo(1).Text = ""
                            txtCampo(5).Focus()
                            VLPaso = True
                        End If
                        FAyudaSubserv2.Dispose() '18/05/2016 migracion
                    End If
                End If

                If txtCampo(5).Text = "" And lblDescripcion(2).Text <> "" And lblDescripcion(8).Text <> "" And lblDescripcion(1).Text <> "" Then
                    '  TSBotones.Focus()
                    lblDescripcion(2).Text = ""
                    lblDescripcion(8).Text = ""
                    lblDescripcion(1).Text = ""
                    txtCampo(5).Focus()
                End If

            Case 6
                If Not VLPaso Then
                    If txtCampo(6).Text <> "" Then
                        If CDbl(txtCampo(6).Text) > 255 Then
                            COBISMessageBox.Show(FMLoadResString(1780), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(6).Text = ""
                            lblDescripcion(6).Text = ""
                            txtCampo(7).Text = ""
                            lblDescripcion(4).Text = ""
                            lblDescripcion(5).Text = ""
                            txtCampo(1).Text = ""
                            txtCampo(6).Focus()
                            Exit Sub
                        End If
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4038")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(6).Text)
                        PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, lblDescripcion(9).Text)
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "T")
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rango_pe", True, FMLoadResString(502081)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(6))
                            PMChequea(sqlconn)
                            txtCampo(7).Text = ""
                            lblDescripcion(4).Text = ""
                            lblDescripcion(5).Text = ""
                            txtCampo(1).Text = ""
                        Else
                            PMChequea(sqlconn)
                            txtCampo(6).Text = ""
                            lblDescripcion(6).Text = ""
                            txtCampo(7).Text = ""
                            lblDescripcion(4).Text = ""
                            lblDescripcion(5).Text = ""
                            txtCampo(1).Text = ""
                            txtCampo(6).Focus()
                            VLPaso = True
                        End If
                    Else
                        VLPaso = True
                        lblDescripcion(6).Text = ""
                        txtCampo(7).Text = ""
                        lblDescripcion(4).Text = ""
                        lblDescripcion(5).Text = ""
                        txtCampo(1).Text = ""
                        txtCampo(6).Focus()
                    End If
                End If
            Case 7
                If Not VLPaso Then
                    If txtCampo(7).Text <> "" Then
                        If txtCampo(6).Text = "" Then
                            COBISMessageBox.Show(FMLoadResString(1293), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(7).Text = ""
                            txtCampo(6).Focus()
                            Exit Sub
                        End If
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4038")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_grupo", 0, SQLINT2, txtCampo(7).Text)
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "G")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(6).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_rango_pe", True, FMLoadResString(502089)) Then
                            PMChequea(sqlconn)
                            lblDescripcion(4).Text = ""
                            lblDescripcion(5).Text = ""
                            txtCampo(1).Text = ""
                        Else
                            PMChequea(sqlconn)
                            lblDescripcion(4).Text = ""
                            lblDescripcion(5).Text = ""
                            txtCampo(1).Text = ""
                            txtCampo(7).Text = ""
                            txtCampo(7).Focus()
                            VLPaso = True
                        End If
                    Else
                        lblDescripcion(4).Text = ""
                        lblDescripcion(5).Text = ""
                        txtCampo(1).Text = ""
                        txtCampo(7).Focus()
                    End If
                End If
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_7.MouseDown, _txtCampo_6.MouseDown, _txtCampo_5.MouseDown, _txtCampo_4.MouseDown, _txtCampo_0.MouseDown, _txtCampo_3.MouseDown, _txtCampo_1.MouseDown, _txtCampo_2.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3, 4, 5, 6, 7
                My.Computer.Clipboard.Clear()
                'My.Computer.Clipboard.SetText("")
        End Select
    End Sub

    Public Sub PMCargarFechaIni()
        Dim VLFechaini As String
        Dim VLFormatoFecha As String = VGFormatoFecha
        mskFecha.Mask = FMMascaraFecha(VLFormatoFecha)
        mskFecha.DateType = PLFormatoFecha()
        mskFecha.Connection = VGMap
        VLFechaini = VGFechaProceso
        VGFecha = FMDateAdd(VLFechaini, "d", 1, VGFormatoFecha)
        mskFecha.Text = FMConvFecha(VGFecha, VLFormatoFecha, VLFormatoFecha)
    End Sub

    Public Sub PMCargarSucursales()

        PMLimpiaGrid(grdSucurs)
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4079")
        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", True, FMLoadResString(1913)) Then
            PMMapeaGrid(sqlconn, grdSucurs, False)
            PMMapeaTextoGrid(grdSucurs)
            PMAnchoColumnasGrid(grdSucurs)
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If

    End Sub


    Private Sub PLTSEstado()
        TSBIngresar.Enabled = _cmdBoton_0.Enabled
        TSBIngresar.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
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

    Private Sub grdSucurs_Enter(sender As Object, e As EventArgs)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1393))
    End Sub

    Private Sub grdSucurs_Leave(sender As Object, e As EventArgs)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub PMDesmarcarSelec(ByVal matriz() As String)
        VLSumSucursal = 0
        VLNumSecuencial = 0
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "4079")
        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_sucursal", True, FMLoadResString(1913)) Then
            PMMapeaGrid(sqlconn, grdSucurs, False)
            PMMapeaTextoGrid(grdSucurs)
            PMAnchoColumnasGrid(grdSucurs)
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If

        For i As Integer = 1 To grdSucurs.Rows - 1
            grdSucurs.Row = CShort(i)
            grdSucurs.Col = 1
            For x As Integer = 0 To Sucursal.Length - 1
                If Sucursal(x) = grdSucurs.CtlText Then
                    grdSucurs.Col = 0
                    If grdSucurs.Picture Is Nothing Or m Is picVisto(1).Image Then
                        grdSucurs.CtlText = Conversion.Str(grdSucurs.Row)
                        grdSucurs.Picture = picVisto(0).Image
                        m = picVisto(0).Image
                    End If
                    Exit For
                End If
            Next x
        Next i
    End Sub

End Class


