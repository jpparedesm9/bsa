Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Drawing
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports Artinsoft.VB6.Utils

Partial Public Class FCheqAprobRechazClass
    Inherits COBISFuncionalityView
    Public VLPopUpMenu As COBISCorp.Framework.UI.Components.PopUpMenu
    Dim m As System.Drawing.Bitmap
    Dim VLMascaraC As String = String.Empty
    Dim VTCausaDev As String = String.Empty
    Dim VGCodRolRegional As String = String.Empty
    Dim VGRolNacional As Boolean = False
    Dim VLSecuencial As String = String.Empty
    Dim VLDevuelto As String = String.Empty
    Dim VLUltimSec As String = String.Empty
    Dim VTCheques(9, 50) As String
    Dim VTBorrar As Boolean = False
    Dim vti As Integer = 0
    Dim vti2 As Integer = 0
    Dim i As Integer = 0
    Dim j As Integer = 0
    Dim VLPaso As Boolean = False
    Dim resp As Integer = 0
    Dim VGbanTipoChq As Boolean = True

#Region "Eventos Formulario"
    Private Sub FCheqAprobRechaz_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicio()
    End Sub
#End Region

#Region "Eventos Botones"
    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Click, _cmdBoton_0.Click, _cmdBoton_6.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Me.TSBotones.Focus()

        Select Case Index
            Case 0
                PLBuscarChq()
            Case 1
                PLDevuelveChq()
            Case 2
                PLLimpiar()
            Case 6
                Me.Close()
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(String.Empty)
        End Select
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub
    Private Sub TSBDevolver_Click(sender As Object, e As EventArgs) Handles TSBDevolver.Click
        If cmdEfectivizar.Enabled Then cmdBoton_Click(cmdEfectivizar, e)
    End Sub

    'Private Sub cmdEfectivizar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdEfectivizar.Click
    '    If cmdEfectivizar.Enabled Then cmdBoton_Click(cmdEfectivizar, eventArgs)
    'End Sub
#End Region

#Region "Procedimientos Generales"
    Private Sub PLInicio()
        Dim VTServername As String = String.Empty
        Dim VTArreglo(5) As String
        Dim VTMensajeError As String = 0
        Dim checkOn As Boolean = True
        PLTSEstado()

        mmskFecha.Mask = FMMascaraFecha(VGFormatoFecha)
        mmskFecha.Connection = VGMap
        mmskFecha.DateType = PLFormatoFecha()
        mskCuentaOperacion.Mask = VGMascaraCtaAho
        VLMascaraC = mmskFecha.Text
        mmskFecha.Text = VGFecha

        'JBA: DESACTIVA USO DE REGIONAL PLCargaRegionales()

        'Control de Usuario Rol nacional (Activa marcar todos)
        'PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "1579")
        'PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        'PMPasoValores(sqlconn, "@i_criterio", 0, SQLINT1, 1)
        'PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "4")
        'PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, "REM")
        'PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "REDCHQ")

        'If FMTransmitirRPC(sqlconn, VTServername, "cobis", "sp_parametro", True, FMLoadResString(508482)) Then
        '    FMMapeaArreglo(sqlconn, VTArreglo)
        '    PMChequea(sqlconn)
        '    VGCodRolRegional = VTArreglo(3)
        'Else
        '    PMChequea(sqlconn)
        'End If

        'If VGRol = VGCodRolRegional Then
        '    chkmarca.Enabled = True
        '    VGRolNacional = True
        'Else
        'Try
        'Me.Cursor = Cursors.WaitCursor
        'PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "150017")
        'PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        'PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT4, VGOficina)
        'PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "R")
        'If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cheq_aprob_rechaz", True, "") Then 'FMLoadResString(502905)) Then
        ' ReDim VTArreglo(1)
        ' FMMapeaArreglo(sqlconn, VTArreglo)
        ' PMChequea(sqlconn)
        '
        '
        '        grdRegionales.Row = 1
        '        grdRegionales.Col = 1
        '       If grdRegionales.CtlText.Trim() = String.Empty Then
        'COBISMessageBox.Show(FMLoadResString(99051), FMLoadResString(502214), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        'Exit Sub
        'End If

        'For i As Integer = 1 To grdRegionales.Rows - 1
        '    grdRegionales.Row = CShort(i)
        '    grdRegionales.Col = 1
        '    If VTArreglo(1).Equals(grdRegionales.CtlText.Trim()) Then
        '        grdRegionales.Col = 0
        '        grdRegionales.Picture = _picVisto_0.Image
        '        'grdRegionales.Enabled = False
        '        Exit For
        '    End If
        'Next i

        'Else
        'PMChequea(sqlconn)
        'PLLimpiar()
        'End If

        'Me.Cursor = Cursors.Default
        'Catch ex As Exception
        '    VTMensajeError = "CTA.Ctes.Chamber.PLBuscarChqs: " & Information.Err.Number & ", " & ex.Message & ", " & ex.Source
        '    COBISMessageBox.Show(VTMensajeError, Application.ProductName)
        'End Try
        'End If

        'Cargar Combos
        PLCargarCatalogo(cmbTipoProducto, "re_producto_chq")
        PLCargarCatalogo(cmbTipoChq, "cc_tipos_cheque")
        PLCargarCatalogo(cmbEstado, "re_echeque")


        cmbEstado.SelectedIndex = -1
        cmbTipoChq.SelectedIndex = -1
        cmbBcoChq.SelectedIndex = -1
        cmbTipoProducto.SelectedIndex = 0
        'grdRegionales.Row = 0
        'grdRegionales.Col = 1
        'grdRegionales.CtlText = FMLoadResString(600019)
        'grdRegionales.Col = 2
        'grdRegionales.CtlText = FMLoadResString(505011)
        'PMAnchoColumnasGrid(grdRegionales)
    End Sub
    Private Sub PLBuscarChq()

        Dim VTmodo As Short = 0
        Dim VTMensajeError As String

        Dim checkOn As Boolean = True
        VTBorrar = False
        Dim VLBucle As Short = 0
        Dim VLRegionales As Short = 0

        If Not (cmbTipoProducto.SelectedIndex <> -1 Or cmbEstado.SelectedIndex <> -1 Or mskCuentaOperacion.ClipText <> String.Empty Or mmskFecha.Text <> VLMascaraC Or txtCheque.Text <> String.Empty) Then
            COBISMessageBox.Show(FMLoadResString(502511), FMLoadResString(15000), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If mmskFecha.ClipText <> "" AndAlso Not IsDate(mmskFecha.Text) Then
            COBISMessageBox.Show(FMLoadResString(502545), FMLoadResString(500989), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation) 'Ingrese una fecha válida
            mmskFecha.Focus()
            Exit Sub
        End If

        'For i As Integer = 1 To grdRegionales.Rows - 1
        '    grdRegionales.Row = CShort(i)
        '    grdRegionales.Col = 0
        '    If Not grdRegionales.Picture Is Nothing Then
        '        Dim bmp1 As Bitmap = DirectCast(grdRegionales.Picture, Bitmap)
        '        Dim bmp2 As Bitmap = DirectCast(_picVisto_0.Image, Bitmap)

        '        Dim bln As Boolean = CompareBitmaps(bmp1, bmp2)
        '        If bln Then
        '            checkOn = False
        '            Exit For
        '        End If
        '    End If
        'Next i

        'If checkOn Then
        '    COBISMessageBox.Show(FMLoadResString(99051), FMLoadResString(15000), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        '    Exit Sub
        'End If

        PLLimpiaGrid(grdAprobRechazCqh)

        If chkmarca.Checked = True Then
            Do While VLBucle = False
                Try
                    Me.Cursor = Cursors.WaitCursor
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "150017")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                    PMPasoValores(sqlconn, "@i_cuenta_operacion", 0, SQLVARCHAR, CStr(mskCuentaOperacion.ClipText))
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, cmbTipoProducto.SelectedValue)
                    PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT2, VGFecha_SP)
                    PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, cmbEstado.SelectedValue)
                    PMPasoValores(sqlconn, "@i_dc_tipo", 0, SQLCHAR, cmbTipoChq.SelectedValue)
                    PMPasoValores(sqlconn, "@i_dc_co_banco", 0, SQLINT4, cmbBcoChq.SelectedValue)
                    PMPasoValores(sqlconn, "@i_fecha", 0, SQLDATETIME, FMConvFecha(mmskFecha.Text, VGFormatoFecha, CGFormatoBase))
                    If VTmodo Then
                        grdAprobRechazCqh.Col = 1
                        grdAprobRechazCqh.Row = grdAprobRechazCqh.Rows
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT4, 1)
                        PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, grdAprobRechazCqh.CtlText)
                    Else
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT4, 0)
                    End If

                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cheq_aprob_rechaz", True, FMLoadResString(502884)) Then
                        PMMapeaGrid(sqlconn, grdAprobRechazCqh, VTmodo)
                        PMAnchoColumnasGrid(grdAprobRechazCqh)
                        PMMapeaTextoGrid(grdAprobRechazCqh)
                        PMChequea(sqlconn)
                        VTmodo = True
                        If CDbl(grdAprobRechazCqh.Tag) >= VGMaxRows Then
                            VLBucle = False
                        Else
                            VLBucle = True
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If

                    Me.Cursor = Cursors.Default
                Catch ex As Exception
                    VTMensajeError = "CTA.Ctes.Chamber.PLBuscarChqs: " & Information.Err.Number & ", " & ex.Message & ", " & ex.Source
                    COBISMessageBox.Show(VTMensajeError, Application.ProductName)
                End Try
            Loop
        Else
            'For i As Integer = 1 To grdRegionales.Rows - 1
            '    grdRegionales.Row = CShort(i)
            '    grdRegionales.Col = 0
            '    If Not grdRegionales.Picture Is Nothing Then
            '        Dim bmp1 As Bitmap = DirectCast(grdRegionales.Picture, Bitmap)
            '        Dim bmp2 As Bitmap = DirectCast(_picVisto_0.Image, Bitmap)

            '        Dim bln As Boolean = CompareBitmaps(bmp1, bmp2)
            Dim bln As Boolean = True
            VLBucle = False

            If bln Then
                Do While VLBucle = False
                    Try
                        Me.Cursor = Cursors.WaitCursor
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "150017")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_cuenta_operacion", 0, SQLVARCHAR, CStr(mskCuentaOperacion.ClipText))
                        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, cmbTipoProducto.SelectedValue)
                        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT2, VGFecha_SP)
                        PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, cmbEstado.SelectedValue)
                        PMPasoValores(sqlconn, "@i_dc_tipo", 0, SQLCHAR, cmbTipoChq.SelectedValue)
                        PMPasoValores(sqlconn, "@i_dc_co_banco", 0, SQLINT4, cmbBcoChq.SelectedValue)
                        grdRegionales.Col = 1
                        'PMPasoValores(sqlconn, "@i_regional", 0, SQLVARCHAR, grdRegionales.CtlText)
                        PMPasoValores(sqlconn, "@i_fecha", 0, SQLDATETIME, FMConvFecha(mmskFecha.Text, VGFormatoFecha, CGFormatoBase))
                        If Not txtCheque.Text.Equals(String.Empty) Then
                            PMPasoValores(sqlconn, "@i_num_cheque", 0, SQLINT4, CInt(txtCheque.Text))
                        End If
                        If VTmodo Then
                            grdAprobRechazCqh.Col = 1
                            grdAprobRechazCqh.Row = grdAprobRechazCqh.Rows
                            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT4, 1)
                            PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, grdAprobRechazCqh.CtlText)
                        Else
                            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT4, 0)
                        End If

                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cheq_aprob_rechaz", True, FMLoadResString(502884)) Then
                            PMMapeaGrid(sqlconn, grdAprobRechazCqh, VLRegionales)
                            PMMapeaTextoGrid(grdAprobRechazCqh)
                            PMAnchoColumnasGrid(grdAprobRechazCqh)
                            PMChequea(sqlconn)
                            VTmodo = True
                            If CDbl(grdAprobRechazCqh.Tag) >= VGMaxRows Then
                                VLBucle = False
                            Else
                                VLBucle = True
                            End If
                        Else
                            PMChequea(sqlconn)
                        End If

                        Me.Cursor = Cursors.Default
                    Catch ex As Exception
                        VTMensajeError = "CTA.Ctes.Chamber.PLBuscarChqs: " & Information.Err.Number & ", " & ex.Message & ", " & ex.Source
                        COBISMessageBox.Show(VTMensajeError, Application.ProductName)
                    End Try
                    VLRegionales = True
                Loop
            End If
        End If
        VTmodo = False
        'Next i
        'End If


        grdAprobRechazCqh.Row = 1
        grdAprobRechazCqh.Col = 1
        If grdAprobRechazCqh.CtlText.Trim() = String.Empty Then
            COBISMessageBox.Show(FMLoadResString(500361), FMLoadResString(501878), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            PLLimpiar()
        Else
            grdAprobRechazCqh.set_ColIsVisible(1, False) 'ocultar columna SECUENCIAL
            txtCampo(0).Enabled = True
            cmdEfectivizar.Enabled = True
            cmdBoton(1).Enabled = True
            mskCuentaOperacion.Enabled = False
            'grdRegionales.Enabled = False
            chkmarca.Enabled = False
            cmbTipoChq.Enabled = False
            cmbBcoChq.Enabled = False
            cmdBoton(0).Enabled = False
            mmskFecha.Enabled = False
            cmbTipoProducto.Enabled = False
            cmbEstado.Enabled = False
            txtCheque.Enabled = False
        End If
        VTmodo = False
        PLTSEstado()
    End Sub

    Private Sub PLLimpiar()
        cmdBoton(0).Enabled = True
        cmbBcoChq.SelectedIndex = -1
        cmbBcoChq.Enabled = True
        mmskFecha.Mask = FMMascaraFecha(VGFormatoFecha)
        mmskFecha.DateType = PLFormatoFecha()
        mmskFecha.Text = VGFecha
        grdAprobRechazCqh.set_ColIsVisible(1, True)
        mskCuentaOperacion.Text = String.Empty
        txtCampo(0).Text = String.Empty
        txtCheque.Text = String.Empty
        lblDescripcion.Text = String.Empty
        cmbEstado.SelectedIndex = -1
        cmdBoton(0).Enabled = True
        cmbTipoChq.SelectedIndex = -1
        cmbTipoChq.Enabled = True
        cmdBoton(1).Enabled = False
        cmbEstado.Enabled = True
        'mmskFecha.Enabled = True
        txtCheque.Enabled = True
        cmbTipoProducto.Enabled = True
        mskCuentaOperacion.Enabled = True
        txtCampo(0).Enabled = False
        cmdEfectivizar.Enabled = False
        PLLimpiaGrid(grdAprobRechazCqh)
        cmbTipoProducto.Focus()
        cmbTipoProducto.SelectedIndex = 0
        PLTSEstado()
    End Sub

    Sub PLLimpiaGrid(ByRef grdGrid As COBISCorp.Framework.UI.Components.COBISGrid)
        grdGrid.Rows = 2
        grdGrid.Cols = 2
        For i As Integer = 0 To 1
            grdGrid.Col = CShort(i)
            For j As Integer = 0 To 1
                grdGrid.Row = CShort(j)
                grdGrid.CtlText = String.Empty
            Next j
        Next i
    End Sub

    Sub PLLimpiaGridCheques(ByRef grdGrid As COBISCorp.Framework.UI.Components.COBISSpread)
        grdGrid.MaxRows = 0
    End Sub

    Private Sub PLCargarCatalogo(ByRef parCombo As ComboBox, ByVal partabla As String)
        Dim VLCatalogo As New ArrayList()
        Dim VTValores(0, 0) As String
        Dim VTMensajeError As String
        Dim VTServername As String = String.Empty
        Dim VTR1 As Integer

        Try
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, partabla)
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")

            If FMTransmitirRPC(sqlconn, VTServername, "cobis", "sp_hp_catalogo", True, FMLoadResString(20061)) Then
                VTR1 = FMMapeaMatriz(sqlconn, VTValores)
                PMChequea(sqlconn)

                If VTR1 > 0 Then
                    For VT2 As Integer = 1 To VTR1
                        If partabla = "cc_tipos_cheque" And VTValores(0, VT2) = "2" Then
                        Else
                            VLCatalogo.Add(New Catalogo(VTValores(0, VT2), VTValores(1, VT2)))
                        End If
                    Next
                End If
            Else
                PMChequea(sqlconn)
            End If

            parCombo.ValueMember = "Codigo"
            parCombo.DisplayMember = "Descripcion"
            parCombo.DataSource = VLCatalogo
            'parCombo.SelectedIndex = -1

        Catch ex As System.Exception
            VTMensajeError = "FManConvenio.PLCargarCatalogo: " & Information.Err.Number & ", " & ex.Message & ", " & ex.Source
            COBISMessageBox.Show(VTMensajeError, Application.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End Try
    End Sub
    Private Sub PLEjecutaItemMenu(ByRef parIndice As Integer)
        If parIndice <> 0 Then
            Select Case VLPopUpMenu.ItemKey(parIndice)
                Case "mnumsgerror"

                Case "mnucorre"

            End Select
        End If
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

    Private Sub PLDevuelveChq()
        Dim checkOn As Boolean = True
        Dim VLCuentaCheques As Integer = 0
        Dim VLValorCheque As Double = 0
        Dim VLNumeroCheque As Integer = 0
        Dim VLOfiOrigen As Integer = -1
        Dim VLSSNChq As Integer
        Dim VLSecuencialChq As Integer

        Dim VLProducto As Integer = -1
        Dim VLEstado As String = String.Empty
        Dim VLCuentaBanco As String = String.Empty
        Dim VLFechaCheque As Date

        If txtCampo(0).Text = String.Empty Then
            COBISMessageBox.Show(FMLoadResString(500314), FMLoadResString(15000), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If

        For i As Integer = 1 To grdAprobRechazCqh.Rows - 1
            grdAprobRechazCqh.Row = CShort(i)
            grdAprobRechazCqh.Col = 0
            If Not grdAprobRechazCqh.Picture Is Nothing Then
                Dim bmp1 As Bitmap = DirectCast(grdAprobRechazCqh.Picture, Bitmap)
                Dim bmp2 As Bitmap = DirectCast(_picVisto_0.Image, Bitmap)
                Dim bln As Boolean = CompareBitmaps(bmp1, bmp2)
                If bln Then
                    checkOn = False
                    VLCuentaCheques += 1
                    grdAprobRechazCqh.Row = i
                    grdAprobRechazCqh.Col = 3
                    VLOfiOrigen = CInt(grdAprobRechazCqh.CtlText)
                    grdAprobRechazCqh.Col = 4
                    VLProducto = CInt(grdAprobRechazCqh.CtlText)
                    grdAprobRechazCqh.Col = 5
                    VLNumeroCheque = CInt(grdAprobRechazCqh.CtlText)
                    grdAprobRechazCqh.Col = 6
                    VLCuentaBanco = grdAprobRechazCqh.CtlText
                    grdAprobRechazCqh.Col = 7
                    VLEstado = grdAprobRechazCqh.CtlText
                    grdAprobRechazCqh.Col = 8
                    VLValorCheque = CDbl(grdAprobRechazCqh.CtlText)
                    grdAprobRechazCqh.Col = 9
                    VLFechaCheque = CDate(grdAprobRechazCqh.CtlText)
                    grdAprobRechazCqh.Col = 16
                    VLSSNChq = CInt(grdAprobRechazCqh.CtlText)
                    grdAprobRechazCqh.Col = 17
                    VLSecuencialChq = CInt(grdAprobRechazCqh.CtlText)

                    If VLCuentaCheques > 1 Then
                        Exit For
                    End If
                End If
            End If
        Next i

        If checkOn Then
            COBISMessageBox.Show(FMLoadResString(501640), FMLoadResString(15000), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If

        If VLCuentaCheques > 1 Then
            COBISMessageBox.Show(FMLoadResString(500729), FMLoadResString(15000), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            grdAprobRechazCqh.Col = 0
            For i As Integer = 1 To grdAprobRechazCqh.Rows - 1
                grdAprobRechazCqh.Row = CShort(i)
                grdAprobRechazCqh.CtlText = Conversion.Str(grdAprobRechazCqh.Row)
                grdAprobRechazCqh.Picture = _picVisto_1.Image
            Next i
            Exit Sub
        End If

        If Not VLEstado.ToString.Equals("I") Then
            COBISMessageBox.Show(FMLoadResString(600023), FMLoadResString(15000), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            grdAprobRechazCqh.Col = 0
            For i As Integer = 1 To grdAprobRechazCqh.Rows - 1
                grdAprobRechazCqh.Row = CShort(i)
                grdAprobRechazCqh.CtlText = Conversion.Str(grdAprobRechazCqh.Row)
                grdAprobRechazCqh.Picture = _picVisto_1.Image
            Next i
            Exit Sub
        End If

        resp = COBISMessageBox.Show(FMLoadResString(501641), FMLoadResString(500085), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question)


        If resp = System.Windows.Forms.DialogResult.Yes Then
            VLPaso = True
            Dim VTMensajeError As String = 0
            Try
                Me.Cursor = Cursors.WaitCursor
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "150017")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
                PMPasoValores(sqlconn, "@i_causa", 0, SQLVARCHAR, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_valor_cheque", 0, SQLMONEY, VLValorCheque)
                PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, VLCuentaBanco)
                PMPasoValores(sqlconn, "@i_num_cheque", 0, SQLINT4, VLNumeroCheque)
                PMPasoValores(sqlconn, "@i_ofiorigen", 0, SQLINT4, VLOfiOrigen)
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, VLProducto)
                PMPasoValores(sqlconn, "@i_fecha", 0, SQLDATETIME, FMConvFecha(VGFecha, VGFormatoFecha, CGFormatoBase))
                PMPasoValores(sqlconn, "@i_fecha_cheque", 0, SQLDATETIME, FMConvFecha(VLFechaCheque, VGFormatoFecha, CGFormatoBase))
                'PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT4, VGOficina)
                PMPasoValores(sqlconn, "@i_ssn", 0, SQLINT4, VLSSNChq)
                PMPasoValores(sqlconn, "@i_secuencial_chq", 0, SQLINT4, VLSecuencialChq)

                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cheq_aprob_rechaz", True, "") Then 'JBAFMLoadResString(502923)) Then
                    PMChequea(sqlconn)
                    COBISMessageBox.Show(FMLoadResString(99831), FMLoadResString(501878), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                Else
                    PMChequea(sqlconn)
                End If
                PLLimpiar()

                Me.Cursor = Cursors.Default
            Catch ex As Exception
                VTMensajeError = "CTA.Ctes.Chamber.PLBuscarChqs: " & Information.Err.Number & ", " & ex.Message & ", " & ex.Source
                COBISMessageBox.Show(VTMensajeError, Application.ProductName)
            End Try
        End If

    End Sub

    'Private Sub PMMarcarRegistro()
    '    grdRegionales.Col = 0
    '    If grdRegionales.Picture Is Nothing Or m Is _picVisto_1.Image Then
    '        grdRegionales.CtlText = Conversion.Str(grdRegionales.Row)
    '        grdRegionales.Picture = _picVisto_0.Image
    '        m = _picVisto_0.Image
    '    Else
    '        grdRegionales.CtlText = Conversion.Str(grdRegionales.Row)
    '        grdRegionales.Picture = _picVisto_1.Image
    '        m = _picVisto_1.Image
    '    End If
    '    grdRegionales.AutoResizeColumns()
    'End Sub

    Private Sub PMMarcarRegistroChq()
        grdAprobRechazCqh.Col = 0
        If grdAprobRechazCqh.Picture Is Nothing Or m Is _picVisto_1.Image Then
            grdAprobRechazCqh.CtlText = Conversion.Str(grdAprobRechazCqh.Row)
            grdAprobRechazCqh.Picture = _picVisto_0.Image
            m = _picVisto_0.Image
        Else
            grdAprobRechazCqh.CtlText = Conversion.Str(grdAprobRechazCqh.Row)
            grdAprobRechazCqh.Picture = _picVisto_1.Image
            m = _picVisto_1.Image
        End If
        grdAprobRechazCqh.AutoResizeColumns()
    End Sub

    'Private Sub PLCargaRegionales()
    '    Dim VTmodo As Short = 0
    '    Dim VTMensajeError As String
    '    Dim VTServername As String = String.Empty

    '    Try
    '        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
    '        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_regional")
    '        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")

    '        If FMTransmitirRPC(sqlconn, VTServername, "cobis", "sp_hp_catalogo", True, FMLoadResString(502905)) Then
    '            PMMapeaGrid(sqlconn, grdRegionales, VTmodo)
    '            PMMapeaTextoGrid(grdRegionales)
    '            PMAnchoColumnasGrid(grdRegionales)
    '            PMChequea(sqlconn)
    '            VTmodo = True
    '        Else
    '            PMChequea(sqlconn)
    '        End If

    '    Catch ex As System.Exception
    '        VTMensajeError = "FManConvenio.PLCargarCatalogo: " & Information.Err.Number & ", " & ex.Message & ", " & ex.Source
    '        COBISMessageBox.Show(VTMensajeError, Application.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
    '    End Try
    'End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible

        cmdEfectivizar.Enabled = cmdEfectivizar.Enabled
        cmdEfectivizar.Visible = cmdEfectivizar.Visible

        TSBDevolver.Enabled = cmdEfectivizar.Enabled
        TSBDevolver.Visible = cmdEfectivizar.Visible


        'If VGRolNacional Then
        '    grdRegionales.Enabled = grdRegionales.Enabled
        'End If

        mskCuentaOperacion.Enabled = mskCuentaOperacion.Enabled
        mmskFecha.Enabled = mmskFecha.Enabled
        cmbTipoProducto.Enabled = cmbTipoProducto.Enabled

        TSBLimpiar.Enabled = _cmdBoton_2.Enabled
        TSBLimpiar.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_6.Enabled
        TSBSalir.Visible = _cmdBoton_6.Visible
    End Sub
#End Region

#Region "Eventos Campos"
    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5030671))
                _txtCampo_0.SelectionStart = 0
                _txtCampo_0.SelectionLength = Strings.Len(_txtCampo_0.Text)
        End Select
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_0.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Shift As Integer = eventArgs.KeyData \ &H10000
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If KeyCode = VGTeclaAyuda Then
                    VLPaso = True
                    txtCampo(0).Text = String.Empty
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cc_devolucion_cheque")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, "") Then 'JBAFMLoadResString(502924)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(0).Text = VGACatalogo.Codigo
                        lblDescripcion.Text = VGACatalogo.Descripcion
                        If txtCampo(0).Text <> String.Empty Then
                            VLPaso = True
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
                End If
        End Select
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtCheque.KeyPress
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1
                Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
                KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
                If KeyAscii = 0 Then
                    eventArgs.Handled = True
                End If
                eventArgs.KeyChar = Convert.ToChar(KeyAscii)
        End Select
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If Not VLPaso And txtCampo(0).Text <> String.Empty Then
                    If txtCampo(0).Text <> String.Empty Then
                        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cc_devolucion_cheque")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtCampo(0).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, "") Then 'FMLoadResString(502925).Replace(VGCharReemplazo, Me._txtCampo_0.Text)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion)
                            PMChequea(sqlconn)
                        Else
                            txtCampo(0).Text = String.Empty
                            lblDescripcion.Text = String.Empty
                            If ActiveControl Is Nothing Then Return
                            txtCampo(0).Focus()
                        End If
                    Else
                        lblDescripcion.Text = String.Empty
                    End If
                    cmbEstado.Focus()
                Else
                    If txtCampo(0).Text = String.Empty Then
                        lblDescripcion.Text = String.Empty
                    End If
                End If

        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.TextChanged
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If Not Me.Created Then Exit Sub
                VLPaso = False
            Case 1
                If Not Me.Created Then Exit Sub
                VLPaso = False
        End Select
    End Sub

    Private Sub txtCheque_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtCheque.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCheque_Enter(sender As Object, e As EventArgs) Handles txtCheque.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501434))
    End Sub

    Private Sub txtCheque_Leave(sender As Object, e As EventArgs) Handles txtCheque.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
#End Region

#Region "Eventos Opciones"
    'Private Sub chkmarca_CheckStateChanged(sender As Object, e As EventArgs) Handles chkmarca.CheckStateChanged
    '    If grdRegionales.Rows <= 2 Then
    '        grdRegionales.Row = 1
    '        grdRegionales.Col = 1
    '        If grdRegionales.CtlText.Trim() = String.Empty Then
    '            COBISMessageBox.Show(FMLoadResString(99051), FMLoadResString(15000), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
    '            Exit Sub
    '        End If
    '    End If
    '    If chkmarca.Checked = True Then
    '        chkmarca.Text = FMLoadResString(990511)
    '        grdRegionales.Col = 0
    '        For i As Integer = 1 To grdRegionales.Rows - 1
    '            grdRegionales.Row = CShort(i)
    '            grdRegionales.CtlText = Conversion.Str(grdRegionales.Row)
    '            grdRegionales.Picture = _picVisto_0.Image
    '            m = _picVisto_0.Image
    '        Next i
    '        'grdRegionales.Enabled = False
    '    End If
    '    If chkmarca.Checked = False Then
    '        chkmarca.Text = FMLoadResString(990511)
    '        grdRegionales.Col = 0
    '        For i As Integer = 1 To grdRegionales.Rows - 1
    '            grdRegionales.Row = CShort(i)
    '            grdRegionales.CtlText = Conversion.Str(grdRegionales.Row)
    '            grdRegionales.Picture = _picVisto_1.Image
    '            m = _picVisto_1.Image
    '        Next i
    '        'grdRegionales.Enabled = True
    '    End If
    'End Sub

    Private Sub chkmarca_Enter(sender As Object, e As EventArgs) Handles chkmarca.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(990511))
    End Sub

    Private Sub chkmarca_Leave(sender As Object, e As EventArgs) Handles chkmarca.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
#End Region

#Region "Eventos Grid"
    Private Sub grdAprobRechazCqh_DblClick(sender As Object, e As EventArgs) Handles grdAprobRechazCqh.DblClick
        If grdAprobRechazCqh.Rows <= 2 Then
            grdAprobRechazCqh.Row = 1
            grdAprobRechazCqh.Col = 1
            If grdAprobRechazCqh.CtlText.Trim() = String.Empty Then
                COBISMessageBox.Show(FMLoadResString(99051), FMLoadResString(502214), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        End If
        PMMarcarRegistroChq()
    End Sub

    Private Sub grdAprobRechazCqh_ClickEvent(sender As Object, e As EventArgs) Handles grdAprobRechazCqh.ClickEvent
        grdAprobRechazCqh.Col = 1
        grdAprobRechazCqh.SelStartCol = 2
        grdAprobRechazCqh.SelEndCol = CShort(grdAprobRechazCqh.Cols - 1)
        grdAprobRechazCqh.ColorSelectedCells = System.Drawing.Color.FromArgb(190, 235, 240)
        If grdAprobRechazCqh.Row = 0 Then
            grdAprobRechazCqh.SelStartRow = 1
            grdAprobRechazCqh.SelEndRow = 1
        Else
            grdAprobRechazCqh.SelStartRow = grdAprobRechazCqh.Row
            grdAprobRechazCqh.SelEndRow = grdAprobRechazCqh.Row
        End If
        'Me.grdAprobRechazCqh.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.grdAprobRechazCqh.Refresh()
        'PMLineaG(Me.grdAprobRechazCqh)
    End Sub

    'Private Sub grdRegionales_DblClick(sender As Object, e As EventArgs) Handles grdRegionales.DblClick
    '    If Not VGRolNacional Then
    '        Exit Sub
    '    End If
    '    If grdRegionales.Rows <= 2 Then
    '        grdRegionales.Row = 1
    '        grdRegionales.Col = 1
    '        If grdRegionales.CtlText.Trim() = String.Empty Then
    '            COBISMessageBox.Show(FMLoadResString(99051), FMLoadResString(502214), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
    '            Exit Sub
    '        End If
    '    End If
    '    PMMarcarRegistro()
    'End Sub

    Private Sub grdAprobRechazCqh_Leave(sender As Object, e As EventArgs) Handles grdAprobRechazCqh.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub grdAprobRechazCqh_Enter(sender As Object, e As EventArgs) Handles grdAprobRechazCqh.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5029011))
    End Sub

    'Private Sub grdRegionales_Enter(sender As Object, e As EventArgs) Handles grdRegionales.Enter
    '    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5029021))
    'End Sub

    'Private Sub grdRegionales_Leave(sender As Object, e As EventArgs) Handles grdRegionales.Leave
    '    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    'End Sub
#End Region

#Region "Eventos Combos"
    Private Sub cmbTipoChq_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cmbTipoChq.SelectedIndexChanged
        Dim VLCatalogo As New ArrayList()
        Dim VTValores(0, 0) As String
        Dim VTServername As String = String.Empty
        Dim VTR1 As Integer
        Dim VLBucle As Short = 0
        Dim VTmodo As Short = 0
        Dim VTMensajeError As String
        VLSecuencial = 0
        If VGbanTipoChq Then
            Do While VLBucle = False
                Try
                    cmbBcoChq.Enabled = True
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "18")
                    PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_tran", 0, SQLCHAR, "O")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT4, VGFilial)
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT4, 1)
                    PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, VLSecuencial)

                    If FMTransmitirRPC(sqlconn, VTServername, "cob_cuentas", "sp_banco", True, FMLoadResString(508482)) Then
                        VTR1 = FMMapeaMatriz(sqlconn, VTValores)

                        If VTR1 > 0 Then
                            For VT2 As Integer = 1 To VTR1
                                VLCatalogo.Add(New Catalogo(VTValores(0, VT2), VTValores(1, VT2)))
                            Next

                            If VTR1 < VGMaxRows Then
                                VLBucle = True
                            Else
                                VLSecuencial = VTValores(0, (VTValores.Length - 1) / 2)
                            End If
                        End If
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                    End If

                Catch ex As Exception
                    VTMensajeError = "CTA.Ctes.Chamber.PLBuscarChqs: " & Information.Err.Number & ", " & ex.Message & ", " & ex.Source
                    COBISMessageBox.Show(VTMensajeError, Application.ProductName)
                End Try
            Loop
            cmbBcoChq.ValueMember = "Codigo"
            cmbBcoChq.DisplayMember = "Descripcion"
            cmbBcoChq.DataSource = VLCatalogo
            VGbanTipoChq = False
        Else
            cmbBcoChq.SelectedIndex = -1
            cmbBcoChq.Enabled = True
        End If
    End Sub

    Private Sub cmbTipoProducto_Enter(sender As Object, e As EventArgs) Handles cmbTipoProducto.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5286))
    End Sub

    Private Sub cmbTipoProducto_Leave(sender As Object, e As EventArgs) Handles cmbTipoProducto.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub cmdEfectivizar_Enter(sender As Object, e As EventArgs) Handles cmdEfectivizar.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5029191))
    End Sub

    Private Sub cmdEfectivizar_Leave(sender As Object, e As EventArgs) Handles cmdEfectivizar.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub cmbEstado_Enter(sender As Object, e As EventArgs) Handles cmbEstado.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(51041))
    End Sub

    Private Sub cmbEstado_Leave(sender As Object, e As EventArgs) Handles cmbEstado.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub cmbTipoChq_Leave(sender As Object, e As EventArgs) Handles cmbTipoChq.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub cmbTipoChq_Enter(sender As Object, e As EventArgs) Handles cmbTipoChq.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5016041))
    End Sub

    Private Sub cmbBcoChq_Enter(sender As Object, e As EventArgs) Handles cmbBcoChq.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5029201))
    End Sub

    Private Sub cmbBcoChq_Leave(sender As Object, e As EventArgs) Handles cmbBcoChq.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
#End Region

#Region "Eventos Campos Cuenta"
    Private Sub mskCuentaOperacion_Enter(sender As Object, e As EventArgs) Handles mskCuentaOperacion.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5029211))
    End Sub

    Private Sub mskCuentaOperacion_Leave(sender As Object, e As EventArgs) Handles mskCuentaOperacion.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Try
            If mskCuentaOperacion.ClipText <> "" Then
                If FMChequeaCtaAho(mskCuentaOperacion.ClipText) Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuentaOperacion.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_cerrada", 0, SQLCHAR, "C")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(502622) & mskCuentaOperacion.Text & "]") Then
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        mskCuentaOperacion.Clear()
                        mskCuentaOperacion.Focus()
                        Exit Sub
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuentaOperacion.Focus()
                    Exit Sub
                End If
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
        End Try
    End Sub
#End Region

#Region "Eventos Campos Fecha"
    Private Sub mmskFecha_Enter(sender As Object, e As EventArgs) Handles mmskFecha.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5029221))
    End Sub

    Private Sub mmskFecha_Leave(sender As Object, e As EventArgs) Handles mmskFecha.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
#End Region


End Class



