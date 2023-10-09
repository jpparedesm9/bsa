Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Drawing
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.tCOBIS.PER.SharedLibrary
Imports COBISCorp.tCOBIS.PER.Products
Imports COBISCorp.tCOBIS.PER.Cost
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports System.IO
Imports COBISCorp.eCOBIS.COBISExplorer.CompositeUI.ExtendedView


Public Class FTra2946Class
    Inherits COBISFuncionalityView

    Public VTDatos(2, 100) As String
    Dim blocerrar As Boolean = False
    Dim VLPaso As Boolean = True
    Public VLAbierta As String = "N"

    Private Sub FTra2946Class_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
    End Sub

    Private Sub TSBBuscar_Click(sender As System.Object, e As System.EventArgs) Handles TSBBuscar.Click

        If cmbProductoBancario.SelectedIndex > -1 Then
            VLAbierta = "S"
        Else
            VLAbierta = "N"
        End If


        PLBuscar(FMLoadResString(500480))
    End Sub


    Private Sub PLBuscar(parMensajeBarra As String)

        Dim VLProductoCobis As String = ""
        Dim VlSig As Integer
        Dim VlModo As Integer

        If cmbTipo.Text = "" Or cmbTipo.SelectedIndex = -1 Then
            COBISMessageBox.Show(FMLoadResString(500206), FMLoadResString(500045), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            cmbTipo.Focus()
            Exit Sub
        End If

        TSBTransmitir.Enabled = True

        VlSig = 20
        VlModo = 0

        If cmbTipo.SelectedIndex = 0 Then
            VLProductoCobis = "4"
        Else
            VLProductoCobis = "3"
        End If

        If grdContratos.MaxRows > 0 Then
            grdContratos.DeleteRows(1, grdContratos.MaxRows)
        End If

        While VlSig = 20
            PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "2946")
            PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "S")
            PMPasoValores(SqlConn, "@i_producto", 0, SQLINT1, VLProductoCobis)
            PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, VlModo)

            If cmbProductoBancario.SelectedIndex > -1 And VLAbierta = "S" Then
                PMPasoValores(SqlConn, "@i_prod_banc", 0, SQLINT2, VTDatos(0, cmbProductoBancario.SelectedIndex + 1))
            End If

            If txtEstado.Text <> "" Then
                PMPasoValores(SqlConn, "@i_estado", 0, SQLCHAR, txtEstado.Text)
            End If


            If VlModo = 1 Then
                grdContratos.Row = grdContratos.MaxRows
                grdContratos.Col = 12

                If Not (cmbProductoBancario.SelectedIndex > -1 And VLAbierta = "S") Then
                    PMPasoValores(SqlConn, "@i_prod_banc", 0, SQLINT2, grdContratos.Text)
                End If
                grdContratos.Col = 9
                PMPasoValores(SqlConn, "@i_plantilla", 0, SQLVARCHAR, grdContratos.Text)
            End If

            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_contrato_producto", True, parMensajeBarra) Then
                PMMapeaGrid(sqlconn, grdContratos, VlModo)
                PMChequea(sqlconn)
                'grdContratos.ColWidth(6) = 60
                VlSig = grdContratos.Tag
                VlModo = 1
                'TSBActualizar.Enabled = True
            End If
        End While
    End Sub

    Private Sub FTra2946Class_QueryContinueDrag(sender As Object, e As QueryContinueDragEventArgs) Handles Me.QueryContinueDrag

    End Sub


    Private Sub FTra2946Class_ShowView(sender As System.Object, e As System.EventArgs) Handles MyBase.ShowView
        Me.Left = 0
        Me.Top = 26
        cmbTipo.Items.Insert(0, FMLoadResString(500344))
        ' cmbTipo.Items.Insert(1, FMLoadResString(500343))
        cmbTipo.SelectedIndex = 0

        'Dim ckbxcell As New FarPoint.Win.Spread.CellType.CheckBoxCellType()
        'ckbxcell.ThreeState = True
        'ckbxcell.TextTrue = "Checked"
        'ckbxcell.TextFalse = "Unchecked"
        'ckbxcell.TextIndeterminate = "Not Sure"
        'grdContratos.ActiveSheet.Cells(0, 0).CellType = ckbxcell

        txtTitularidad.Enabled = False
        lblTitularidad.Enabled = False
        TSBActualizar.Enabled = False
        TSBEliminar.Enabled = False

    End Sub


    Private Sub PLCargaCboProdBcario()

        Dim VTR1 As Integer = 0
        Dim VLProductoCobis As String = ""

        cmbProductoBancario.Items.Clear()

        If cmbTipo.SelectedIndex = 0 Then
            VLProductoCobis = "4"
        Else
            VLProductoCobis = "3"
        End If

        PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "2946")
        PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "X")
        PMPasoValores(SqlConn, "@i_producto", 0, SQLINT1, VLProductoCobis)
        PMPasoValores(SqlConn, "@i_prod_banc", 0, SQLINT2, "0")
        PMPasoValores(SqlConn, "@i_estado", 0, SQLCHAR, txtEstado.Text)
        PMPasoValores(SqlConn, "@i_plantilla", 0, SQLVARCHAR, txtPlantilla.Text)
        PMPasoValores(SqlConn, "@i_descripcion", 0, SQLVARCHAR, lblDescripcion.Text)


        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_contrato_producto", True, "") Then
            VTR1 = FMMapeaMatriz(sqlconn, VTDatos)
            PMChequea(sqlconn)

            If VTR1 <> 0 Then
                For i As Integer = 1 To VTR1
                    cmbProductoBancario.Items.Insert(i - 1, VTDatos(1, i).ToString)
                Next (i)
                cmbProductoBancario.SelectedIndex = -1
            End If

        End If

    End Sub

    Private Sub cmbTipo_TextChanged(sender As System.Object, e As System.EventArgs)
        PLCargaCboProdBcario()
    End Sub

    Private Sub TSBTransmitir_Click(sender As System.Object, e As System.EventArgs) Handles TSBTransmitir.Click
        PLTransmitir("I", FMLoadResString(500478))
    End Sub

    Private Sub TSBActualizar_Click(sender As System.Object, e As System.EventArgs) Handles TSBActualizar.Click
        PLTransmitir("U", FMLoadResString(500477))

    End Sub


    Private Sub PLTransmitir(VLOperacion As String, parMensajeBarra As String)

        Dim VLProductoCobis As String
        Dim VLEsEspecial As String = ""
        Dim nomArch = VGPathResouces + LTrim(RTrim(txtPlantilla.Text))

        TSButton.Focus()
        VLPaso = True


        If cmbProductoBancario.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500234), FMLoadResString(500045), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            cmbProductoBancario.Focus()
            Exit Sub
        End If


        If txtEstado.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500469), FMLoadResString(500045), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtEstado.Focus()
            Exit Sub
        End If
        PMCatalogo("V", "cl_est_plantillas_contratos", txtEstado, lblDescripcionEstado, Nothing)

        If lblDescripcionEstado.Text = "" Then
            Exit Sub
        End If

        If cmbTipo.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500206), FMLoadResString(500045), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            cmbTipo.Focus()
            Exit Sub
        End If

        If txtTipoPersona.Text = "P" Then
            If txtTitularidad.Text = "" Then
                COBISMessageBox.Show(FMLoadResString(500533), FMLoadResString(500045), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtTitularidad.Focus()
                Exit Sub
            End If
        End If

        If txtTipoPersona.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(9033), FMLoadResString(500045), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtTipoPersona.Focus()
            Exit Sub
        End If
        PMCatalogo("V", "cc_tipo_banca", txtTipoPersona, lblDescTipoPersona, Nothing)


        If txtTipoPersona.Text = "P" Then
            If txtTitularidad.Text = "" Then
                COBISMessageBox.Show(FMLoadResString(500533), FMLoadResString(500045), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtTitularidad.Focus()
                Exit Sub
            End If
            PMCatalogo("V", "re_titularidad", txtTitularidad, lblDescTitularidad, Nothing)

            If chkEspecial.Checked = True Then
                VLEsEspecial = "SI"
            Else
                VLEsEspecial = "NO"
            End If

        End If

        If txtTipoPersona.Text = "C" Then
            If chkEspecial.Checked = True Then
                VLEsEspecial = "SI"
            Else
                VLEsEspecial = "NO"
                txtTitularidad.Text = ""
                lblDescTitularidad.Text = ""
            End If
        End If


        If txtPlantilla.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500470), FMLoadResString(500045), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)

            txtPlantilla.Focus()
            Exit Sub
        End If
        PMCatalogo("V", "re_plantillas", txtPlantilla, lblDescripcion, Nothing)

        If lblDescripcion.Text = "" Then
            lblDescripcion.Text = ""
            Exit Sub
        End If

        If File.Exists(nomArch) Then

        Else
            ' COBISMessageBox.Show(FMLoadResString(500471), FMLoadResString(500045), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            COBISMessageBox.Show(FMLoadResString(9113), FMLoadResString(500045), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtPlantilla.Text = ""
            lblDescripcion.Text = ""
            txtPlantilla.Focus()
            Exit Sub
        End If

        If cmbTipo.SelectedIndex = 0 Then
            VLProductoCobis = "4"
        Else
            VLProductoCobis = "3"
        End If

        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2946")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, VLOperacion)
        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VLProductoCobis)
        PMPasoValores(sqlconn, "@i_prod_banc", 0, SQLINT2, VTDatos(0, cmbProductoBancario.SelectedIndex + 1))
        PMPasoValores(sqlconn, "@i_tipo_persona", 0, SQLCHAR, txtTipoPersona.Text)
        PMPasoValores(sqlconn, "@i_titularidad", 0, SQLCHAR, txtTitularidad.Text)
        PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, txtEstado.Text)
        PMPasoValores(sqlconn, "@i_plantilla", 0, SQLVARCHAR, txtPlantilla.Text)
        PMPasoValores(sqlconn, "@i_descripcion", 0, SQLVARCHAR, lblDescripcion.Text)
        If VLEsEspecial <> "" Then
            PMPasoValores(sqlconn, "@i_es_especial", 0, SQLVARCHAR, VLEsEspecial)
        End If

        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_contrato_producto", True, parMensajeBarra) Then
            PMChequea(sqlconn) 'TCA Inci_19944
            PLBuscar(parMensajeBarra)
            PLLimpiar("1")
            If VLOperacion = "U" Then
                cmbTipo.Enabled = True
                cmbProductoBancario.Enabled = True
                grdContratos.ActiveSheet.Columns(0).Locked = False
            End If
        Else
            PMChequea(sqlconn)
        End If
        PLBuscar(FMLoadResString(500480))
    End Sub
    'Private Sub txtCampo_PLA_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_PLA.KeyDown
    Private Sub txtEstado_KeyDown(sender As System.Object, e As System.Windows.Forms.KeyEventArgs) Handles txtEstado.KeyDown
        PLPopupCatalogo("cl_est_plantillas_contratos", txtEstado, lblDescripcionEstado, e)
    End Sub

    Private Sub txtPlantilla_KeyDown(sender As System.Object, e As System.Windows.Forms.KeyEventArgs) Handles txtPlantilla.KeyDown
        Dim a As System.Windows.Forms.KeyEventArgs
        a = e
        Dim Keycode As Integer = a.KeyCode
        '   Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Keycode = VGTeclaAyuda Then
            VLPaso = True
            PLPopupCatalogo("re_plantillas", txtPlantilla, lblDescripcion, e)
        End If
    End Sub

    Private Sub PLPopupCatalogo(parTabla As String, parTxtCod As Object, parLblDescripcion As Object, e As System.Windows.Forms.KeyEventArgs)

        If e.KeyCode = VGTeclaAyuda Then
            Try
                Temporales(1) = ""
                Temporales(2) = ""
            Catch
            End Try

            VGPaso = True
            PMPasoValores(SqlConn, "@i_tabla", 0, SQLVARCHAR, parTabla)
            PMPasoValores(SqlConn, "@i_tipo", 0, SQLCHAR, "A")
            PMPasoValores(SqlConn, "@i_modo", 0, SQLINT1, "0")
            PMHelpG("cobis", "sp_hp_catalogo", 3, 1)
            PMBuscarG(1, "@i_tabla", parTabla, SQLVARCHAR)
            PMBuscarG(2, "@i_tipo", "A", SQLCHAR)
            PMBuscarG(3, "@i_modo", "0", SQLINT1)
            PMSigteG(1, "@i_codigo", 1, SQLVARCHAR)
            If FMTransmitirRPC(SqlConn, ServerName, "cobis", "sp_hp_catalogo", True, "") Then
                Dim tempLoadForm As FRegistrosClass = FRegistros
                PMMapeaGrid(sqlconn, tempLoadForm.grdRegistros, False)
                tempLoadForm.grdRegistros.AutoResizeColumns()
                If tempLoadForm.grdRegistros.Tag <= 15 Then
                  tempLoadForm.cmdSiguientes.Enabled = False
                End If
                PMChequea(sqlconn)
                tempLoadForm.ShowPopup(Me)
                Try
                    parTxtCod.Text = VGACatalogo.Codigo
                    parLblDescripcion.Text = VGACatalogo.Descripcion
                Catch
                End Try
            End If
        End If

    End Sub


    Private Sub TSBSalir_Click(sender As System.Object, e As System.EventArgs) Handles TSBSalir.Click
        blocerrar = True
        Me.Close()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub


    Private Sub TSBLimpiar_Click(sender As System.Object, e As System.EventArgs) Handles TSBLimpiar.Click
        PLLimpiar("2")
    End Sub

    Function FLEliminar() As Boolean
        Dim VLRetorno As Boolean = False
      
        With grdContratos
            .Col = 1

            If .MaxRows > 0 Then

                For i As Integer = 1 To .MaxRows '- 1
                    .Row = i

                    .Col = 1

                    If .Value = CStr(1) Then
                        VLRetorno = True
                        Return VLRetorno
                    End If
                Next
            End If

        End With

    End Function


    Private Sub TSBEliminar_Click(sender As System.Object, e As System.EventArgs) Handles TSBEliminar.Click
        Const MB_YESNO As Integer = 4
        Const MB_ICONQUESTION As Integer = 32
        Const MB_DEBUTTON1 As Integer = 0
        Const IDYES As Integer = 6
        Dim Response As String = ""
        Dim DgDef As COBISMsgBox.COBISButtons = MB_YESNO + MB_ICONQUESTION + MB_DEBUTTON1


        If grdContratos.MaxRows > 0 And FLEliminar() Then

            grdContratos.Enabled = False


            With grdContratos
                .Col = 1

                If .MaxRows > 0 Then

                    For i As Integer = 1 To .MaxRows '- 1
                        .Row = i

                        .Col = 1

                        If .Value = CStr(1) Then
                            Response = CStr("¿" & COBISMsgBox.MsgBox(FMLoadResString(502109) & CStr(i) & "?", DgDef, FMLoadResString(1867)))
                            If StringsHelper.ToDoubleSafe(Response.Substring(1, 1)) = IDYES Then

                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2946")

                                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")

                                .Col = 11
                                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, .Text)
                                .Col = 12
                                PMPasoValores(sqlconn, "@i_prod_banc", 0, SQLINT2, .Text)

                                .Col = 4
                                PMPasoValores(sqlconn, "@i_tipo_persona", 0, SQLCHAR, .Text)

                                .Col = 5
                                PMPasoValores(sqlconn, "@i_titularidad", 0, SQLCHAR, .Text)

                                .Col = 8
                                PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, .Text)
                                .Col = 9
                                PMPasoValores(sqlconn, "@i_plantilla", 0, SQLVARCHAR, .Text)
                                .Col = 10
                                PMPasoValores(sqlconn, "@i_descripcion", 0, SQLVARCHAR, .Text)

                                .Col = 13
                                If Not String.IsNullOrEmpty(.Text) Then
                                    PMPasoValores(sqlconn, "@i_es_especial", 0, SQLVARCHAR, .Text)
                                End If

                                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_contrato_producto", True, FMLoadResString(500479)) Then
                                    PMChequea(sqlconn)
                                End If
                            Else
                                Exit Sub
                            End If
                        End If
                    Next

                    VLPaso = True
                    cmbProductoBancario.SelectedIndex = -1
                    PLLimpiar("1")
                    PLBuscar(FMLoadResString(500479))
                    chkEspecial.Checked = True
                    TSBEliminar.Enabled = False
                End If

            End With

            grdContratos.Enabled = True

            'PLLimpiar("1")
        Else
            COBISMessageBox.Show(FMLoadResString(500481), FMLoadResString(500045), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End If

    End Sub

    Private Sub PLLimpiar(parModo As String)

        TSBActualizar.Enabled = False

        lblEspecial.Enabled = False
        chkEspecial.Enabled = False
        chkEspecial.Checked = True

        If parModo = "0" Then
            txtTipoPersona.Text = ""
            lblDescTipoPersona.Text = ""
            txtTitularidad.Text = ""
            lblDescTitularidad.Text = ""
            lblTitularidad.Enabled = False
            txtTitularidad.Enabled = False

            txtEstado.Text = ""
            lblDescripcionEstado.Text = ""
            txtPlantilla.Text = ""
            lblDescripcion.Text = ""
            cmbTipo.SelectedIndex = 0
            cmbProductoBancario.SelectedIndex = -1
            cmbTipo.Focus()

            'TSBActualizar.Enabled = False

            Exit Sub
        End If

        If parModo = "1" Then


            txtEstado.Text = ""
            lblDescripcionEstado.Text = ""
            txtPlantilla.Text = ""
            lblDescripcion.Text = ""

            txtPlantilla.Enabled = True
            VLPaso = True
            If VLAbierta = "N" Then
                cmbProductoBancario.Focus()
            Else
                txtEstado.Focus()
            End If


            TSBTransmitir.Enabled = True
            TSBBuscar.Enabled = True

            txtTipoPersona.Text = ""
            lblDescTipoPersona.Text = ""

            txtTitularidad.Text = ""
            lblDescTitularidad.Text = ""
            lblTitularidad.Enabled = False
            txtTitularidad.Enabled = False

            Exit Sub
        End If

        If parModo = "2" Then
            VLPaso = True
            txtTipoPersona.Text = ""
            lblDescTipoPersona.Text = ""

            txtTitularidad.Text = ""
            lblDescTitularidad.Text = ""
            txtTitularidad.Enabled = False
            lblTitularidad.Enabled = False

            txtEstado.Text = ""
            lblDescripcionEstado.Text = ""
            txtPlantilla.Enabled = True
            txtPlantilla.Text = ""
            lblDescripcion.Text = ""
            cmbTipo.Enabled = True
            cmbProductoBancario.Enabled = True
            TSBEliminar.Enabled = False
            TSBBuscar.Enabled = True
            cmbTipo.SelectedIndex = 0
            cmbProductoBancario.SelectedIndex = -1

            TSBActualizar.Enabled = False
            TSBTransmitir.Enabled = True
            grdContratos.MaxRows = 0
            grdContratos.ActiveSheet.Columns(0).Locked = False
            'If grdContratos.MaxRows > 0 Then
            '    grdContratos.DeleteRows(1, grdContratos.MaxRows)
            'End If
            VLPaso = True
            cmbTipo.Focus()
            Exit Sub

        End If

    End Sub


    Private Sub txtPlantilla_Leave(sender As System.Object, e As System.EventArgs) Handles txtPlantilla.Leave
        If Not VLPaso Then
            If txtPlantilla.Text <> "" Then

                PMCatalogo("V", "re_plantillas", txtPlantilla, lblDescripcion, Nothing)

                If lblDescripcion.Text = "" Then
                    txtPlantilla.Focus()
                End If
            Else
                lblDescripcion.Text = ""
            End If
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
    End Sub


    Private Sub PLValidaNumero(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles txtEstado.KeyPress

        If Char.IsDigit(e.KeyChar) AndAlso Not Char.IsControl(e.KeyChar) Then
            e.Handled = True
        End If

    End Sub


    Private Sub txtEstado_Enter(sender As System.Object, e As System.EventArgs) Handles txtEstado.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500476))
        VLPaso = True
    End Sub


    Private Sub PLPredeterminaProductoXNombre(parCodProdBcrio As String)
        Dim i As Integer = 0
        cmbProductoBancario.SelectedIndex = -1
        For i = 0 To cmbProductoBancario.Items.Count - 1
            If cmbProductoBancario.Items(i).ToString() = parCodProdBcrio Then
                cmbProductoBancario.SelectedIndex = i
            End If
        Next i
    End Sub


    Private Sub PMMarcarRegistro()

        PMMarcaFilaGrid(grdContratos, grdContratos.Row)

        grdContratos.Col = 11

        If grdContratos.Text = "4" Then
            cmbTipo.SelectedIndex = 0
        Else
            cmbTipo.SelectedIndex = 1
        End If

        grdContratos.Col = 8

        'PLPredeterminaProducto(Convert.ToInt16(grdContratos.Text))
        grdContratos.Col = 3
        PLPredeterminaProductoXNombre((grdContratos.Text))

        'Tipo de Persona
        Dim VTPersonaNat As Boolean = False
        grdContratos.Col = 4
        txtTipoPersona.Text = grdContratos.Text
        If grdContratos.Text = "P" Then 'Persona natural
            VTPersonaNat = True
            lblTitularidad.Enabled = True
            lblDescTitularidad.Enabled = True
            txtTitularidad.Enabled = True
        Else 'Persona Jurídica
            lblEspecial.Enabled = False
            chkEspecial.Enabled = False
            chkEspecial.Checked = False

            lblTitularidad.Enabled = False
            txtTitularidad.Enabled = False
            lblDescTitularidad.Text = ""
        End If
        grdContratos.Col = 6
        lblDescTipoPersona.Text = grdContratos.Text


        'Titularidad (Solidaria, Indistinta, Conjunta)
        grdContratos.Col = 5
        txtTitularidad.Text = grdContratos.Text
        grdContratos.Col = 7
        lblDescTitularidad.Text = grdContratos.Text

        grdContratos.Col = 8
        txtEstado.Text = grdContratos.Text
        PMCatalogo("V", "cl_est_plantillas_contratos", txtEstado, lblDescripcionEstado, Nothing)

        grdContratos.Col = 9
        txtPlantilla.Text = grdContratos.Text
        txtPlantilla.Enabled = True
        grdContratos.Col = 10
        lblDescripcion.Text = grdContratos.Text

        grdContratos.Col = 13
        If VTPersonaNat Then
            lblEspecial.Enabled = True
            chkEspecial.Enabled = True
            If grdContratos.Text = "SI" Then
                chkEspecial.Checked = True
            ElseIf grdContratos.Text = "NO" Then
                chkEspecial.Checked = False
                'Else
                '    lblEspecial.Enabled = False
                '    chkEspecial.Enabled = False
                '    chkEspecial.Checked = False
            End If
        End If


    End Sub

   
    Private Sub grdContratos_DblClick(sender As Object, e As Framework.UI.Components._DSpreadEvents_DblClickEvent) Handles grdContratos.DblClick
        If grdContratos.Text <> "" Then
            grdContratos.Row = grdContratos.ActiveRow
            TSBActualizar.Enabled = True
            PMMarcarRegistro()
            cmbTipo.Enabled = False
            cmbProductoBancario.Enabled = False
            txtPlantilla.Enabled = False
            TSBTransmitir.Enabled = False
            TSBEliminar.Enabled = False
            TSBBuscar.Enabled = False

            'Dim col As FarPoint.Win.Spread.Column
            'col = grdContratos.ActiveSheet.Columns(1)
            'col.Locked = True
            grdContratos.Col = 1
            For i As Integer = 1 To grdContratos.MaxRows Step 1
                grdContratos.Row = CShort(i)
                grdContratos.Value = False
            Next i

            grdContratos.ActiveSheet.Columns(0).Locked = True

        End If
    End Sub

    Private Sub txtEstado_Leave(sender As System.Object, e As System.EventArgs) Handles txtEstado.Leave
        If Not VLPaso Then
            If txtEstado.Text <> "" Then

                PMCatalogo("V", "cl_est_plantillas_contratos", txtEstado, lblDescripcionEstado, Nothing)

                If lblDescripcionEstado.Text = "" Then
                    txtEstado.Focus()
                End If
            Else
                lblDescripcionEstado.Text = ""
            End If
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
    End Sub


    Private Sub cmbTipo_SelectedIndexChanged(sender As System.Object, e As System.EventArgs) Handles cmbTipo.SelectedIndexChanged
        PLCargaCboProdBcario()
    End Sub

    Private Sub txtPlantilla_Enter(sender As System.Object, e As System.EventArgs) Handles txtPlantilla.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500475))
        VLPaso = True
    End Sub

    Private Sub txtEstado_TextChanged(sender As System.Object, e As System.EventArgs) Handles txtEstado.TextChanged
        VLPaso = False
        If txtEstado.Text = "" Then
            lblDescripcionEstado.Text = ""
        End If
    End Sub

    Private Sub txtPlantilla_TextChanged(sender As System.Object, e As System.EventArgs) Handles txtPlantilla.TextChanged
        VLPaso = False

        If txtPlantilla.Text = "" Then
            lblDescripcion.Text = ""
        End If


    End Sub

    Private Sub cmbProductoBancario_SelectedIndexChanged(sender As System.Object, e As System.EventArgs) Handles cmbProductoBancario.SelectedIndexChanged
        '        TSBActualizar.Enabled = False
    End Sub

    Private Sub cmbProductoBancario_TextChanged(sender As Object, e As System.EventArgs) Handles cmbProductoBancario.TextChanged
        'If cmbProductoBancario.Text <> "" Then
        'TSBActualizar.Enabled = True
        'End If
    End Sub

    Private Sub cmbTipo_Enter(sender As Object, e As EventArgs) Handles cmbTipo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500498))
    End Sub

    Private Sub cmbTipo_Leave(sender As Object, e As EventArgs) Handles cmbTipo.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
    End Sub

    Private Sub cmbProductoBancario_Enter(sender As Object, e As EventArgs) Handles cmbProductoBancario.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(9052))
    End Sub

    Private Sub cmbProductoBancario_Leave(sender As Object, e As EventArgs) Handles cmbProductoBancario.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
    End Sub

    Private Sub grdContratos_Enter(sender As Object, e As EventArgs) Handles grdContratos.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(9053))
    End Sub

    Private Sub grdContratos_Leave(sender As Object, e As EventArgs) Handles grdContratos.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub TSButton_Enter(sender As Object, e As EventArgs) Handles TSButton.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub grdContratos_LeaveCell(sender As Object, e As Framework.UI.Components._DSpreadEvents_LeaveCellEvent) Handles grdContratos.LeaveCell
        If e.NewRow > -1 Then
            PMMarcaFilaGrid(grdContratos, e.NewRow)
        End If
    End Sub



    Private Sub txtTipoPersona_KeyPress(sender As Object, e As KeyPressEventArgs) Handles txtTipoPersona.KeyPress
        If Char.IsDigit(e.KeyChar) AndAlso Not Char.IsControl(e.KeyChar) Then
            e.Handled = True
        End If
    End Sub

    Private Sub txtTitularidad_TextChanged(sender As Object, e As EventArgs) Handles txtTitularidad.TextChanged
        VLPaso = False
        If txtTitularidad.Text = "" Then
            lblDescTitularidad.Text = ""
        End If
    End Sub

    Private Sub txtTipoPersona_TextChanged(sender As Object, e As EventArgs) Handles txtTipoPersona.TextChanged
        VLPaso = False
        If txtTipoPersona.Text = "" Then
            lblDescTipoPersona.Text = ""
        End If
    End Sub


    Private Sub txtTipoPersona_Enter(sender As Object, e As EventArgs) Handles txtTipoPersona.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500532))
        VLPaso = True
    End Sub

    Private Sub txtTipoPersona_KeyDown(sender As Object, e As KeyEventArgs) Handles txtTipoPersona.KeyDown
        Dim KeyCode As Integer = e.KeyCode
        If KeyCode = VGTeclaAyuda Then
            txtTipoPersona.Text = ""
            PMCatalogo("A", "cc_tipo_banca", txtTipoPersona, lblDescTipoPersona, FRegistros)
            If txtTipoPersona.Text <> "" Then
                VLPaso = True

                If txtTipoPersona.Text = "C" Then
                    lblTitularidad.Enabled = False
                    txtTitularidad.Enabled = False
                    txtTitularidad.Text = ""
                    lblDescTitularidad.Text = ""
                    lblEspecial.Enabled = False
                    chkEspecial.Enabled = False
                    chkEspecial.Checked = False
                ElseIf txtTipoPersona.Text = "P" Then
                    lblTitularidad.Enabled = True
                    txtTitularidad.Enabled = True
                    txtTitularidad.Focus()
                    lblEspecial.Enabled = True
                    chkEspecial.Enabled = True
                End If

            End If
        End If
    End Sub

    Private Sub txtTipoPersona_Leave(sender As Object, e As EventArgs) Handles txtTipoPersona.Leave

        If Not VLPaso Then
            If txtTipoPersona.Text = "" Then
                lblTitularidad.Enabled = False
                txtTitularidad.Enabled = False
                lblDescTipoPersona.Text = ""
                lblEspecial.Enabled = False
                chkEspecial.Enabled = False

                If txtPlantilla.Enabled = True Then
                    txtPlantilla.Focus()
                Else
                    grdContratos.Focus()
                End If

                Exit Sub
            End If
            PMCatalogo("V", "cc_tipo_banca", txtTipoPersona, lblDescTipoPersona, Nothing)

            If lblDescTipoPersona.Text = "" Then
                txtTipoPersona.Focus()
            End If

            If txtTipoPersona.Text = "C" Then
                lblTitularidad.Enabled = False
                txtTitularidad.Enabled = False
                txtTitularidad.Text = ""
                lblDescTitularidad.Text = ""
                lblEspecial.Enabled = False
                chkEspecial.Enabled = False
                chkEspecial.Checked = False
                chkEspecial.Visible = False
                txtPlantilla.Focus()
            ElseIf txtTipoPersona.Text = "P" Then
                lblTitularidad.Enabled = True
                txtTitularidad.Enabled = True
                txtTitularidad.Focus()
                lblEspecial.Enabled = True
                chkEspecial.Enabled = True
                chkEspecial.Visible = False
                chkEspecial.Focus()
            End If

        End If

    End Sub

    Private Sub txtTitularidad_KeyPress(sender As Object, e As KeyPressEventArgs) Handles txtTitularidad.KeyPress
        If Char.IsDigit(e.KeyChar) AndAlso Not Char.IsControl(e.KeyChar) Then
            e.Handled = True
        End If
    End Sub

    Private Sub txtTitularidad_Leave(sender As Object, e As EventArgs) Handles txtTitularidad.Leave
        If Not VLPaso Then
            If txtTitularidad.Text = "" Then
                lblDescTitularidad.Text = ""
                Exit Sub
            End If
            ' PMCatalogo("V", "cc_titularidad", txtTitularidad, lblDescTitularidad, Nothing)
            PMCatalogo("V", "re_titularidad", txtTitularidad, lblDescTitularidad, Nothing)
            If lblDescTitularidad.Text = "" Then
                txtTitularidad.Focus()
            End If

        End If
    End Sub

    Private Sub txtTitularidad_Enter(sender As Object, e As EventArgs) Handles txtTitularidad.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500531))
        VLPaso = True
    End Sub

    Private Sub txtTitularidad_KeyDown(sender As Object, e As KeyEventArgs) Handles txtTitularidad.KeyDown
        Dim KeyCode As Integer = e.KeyCode
        If KeyCode = VGTeclaAyuda Then
            txtTitularidad.Text = ""
            PMCatalogo("A", "re_titularidad", txtTitularidad, lblDescTitularidad, FRegistros)
            If txtTitularidad.Text <> "" Then
                VLPaso = True
            End If
        End If
    End Sub

    Private Sub grdContratos_MouseMoveEvent(sender As Object, e As Framework.UI.Components._DSpreadEvents_MouseMoveEvent) Handles grdContratos.MouseMoveEvent
        If grdContratos.MaxRows > 0 Then

            Dim someRowChecked As Boolean = False
            Dim valor As Boolean
            grdContratos.Col = 1
            For i As Integer = 1 To grdContratos.MaxRows Step 1
                grdContratos.Row = CShort(i)
                'valor = grdContratos.ActiveSheet.Cells(i, 0).Value
                If grdContratos.Value = True Then
                    someRowChecked = True
                End If

            Next i

            If (someRowChecked) Then
                TSBTransmitir.Enabled = False
                TSBBuscar.Enabled = False
                TSBActualizar.Enabled = False
                TSBEliminar.Enabled = True
            Else
                TSBTransmitir.Enabled = True
                TSBBuscar.Enabled = True
                TSBEliminar.Enabled = False

                If TSBActualizar.Enabled = True Then
                    TSBTransmitir.Enabled = False
                    TSBBuscar.Enabled = False
                End If
            End If


        End If
    End Sub

    Private Sub chkEspecial_Enter(sender As Object, e As EventArgs) Handles chkEspecial.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500534))
    End Sub


    Private Sub grdContratos_MouseClick(sender As Object, e As MouseEventArgs) Handles grdContratos.MouseClick
        If grdContratos.MaxRows > 0 Then

            Dim someRowChecked As Boolean = False
            ' Dim valor As Boolean
            grdContratos.Col = 1
            For i As Integer = 1 To grdContratos.MaxRows Step 1
                grdContratos.Row = CShort(i)
                ' valor = grdContratos.ActiveSheet.Cells(i, 0).Value
                If grdContratos.Value = True Then
                    someRowChecked = True
                End If

            Next i

            If (someRowChecked) Then
                TSBTransmitir.Enabled = False
                TSBBuscar.Enabled = False
                TSBActualizar.Enabled = False
                TSBEliminar.Enabled = True
            Else
                TSBTransmitir.Enabled = True
                TSBBuscar.Enabled = True
                TSBEliminar.Enabled = False

                If TSBActualizar.Enabled = True Then
                    TSBTransmitir.Enabled = False
                    TSBBuscar.Enabled = False
                End If
            End If


        End If
    End Sub

    Private Sub txtPlantilla_KeyPress(sender As Object, e As KeyPressEventArgs) Handles txtPlantilla.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(e.KeyChar)

        If Char.IsDigit(e.KeyChar) Then
            KeyAscii = 0
            e.Handled = True
        Else
            If Char.IsLetter(e.KeyChar) Then
                KeyAscii = 0
                e.Handled = True
            Else
                If Char.IsControl(e.KeyChar) Then
                    If KeyAscii = VGTeclaAyuda Then
                        VLPaso = True
                    Else
                        KeyAscii = 0
                        e.Handled = True
                    End If
                End If
            End If
        End If
        e.KeyChar = Convert.ToChar(KeyAscii)
    End Sub
End Class
