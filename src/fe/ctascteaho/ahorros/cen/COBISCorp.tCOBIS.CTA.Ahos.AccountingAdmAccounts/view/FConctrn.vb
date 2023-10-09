Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Globalization
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary


Partial Public Class FConcTrnClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLParametro As String = ""
    Dim VLTabla As String = ""
    Dim VLser As String = ""
    Dim VLser1 As String = ""
    Dim VLcon As String = ""
    Dim Index As Integer = 0
    Dim causa As String = ""
    Dim VLTransac As Integer = 0
    Dim causa_sus As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_15.Click, _cmdBoton_1.Click, _cmdBoton_14.Click, _cmdBoton_17.Click, _cmdBoton_3.Click, _cmdBoton_16.Click, _cmdBoton_0.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                PLTrasmitir()
            Case 1
                PLEliminar()
            Case 3
                PLActualizar()
            Case 15
                PLBuscar()
            Case 16
                PLSiguientes()
            Case 17
                PLLimpiar(True)
            Case 14
                Me.Close()
        End Select
    End Sub

    Private Sub PLInicializar()
        VLTabla = "cc_campo_contable"
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VLTabla)
        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502627)) Then
            PMMapeaGrid(sqlconn, grdConta, False)
            PMChequea(sqlconn)
            grdConta.Col = 2
            For i As Integer = 0 To grdConta.Rows - 2
                grdConta.Row = i + 1
                CmbContab(0).Items.Insert(i, grdConta.CtlText)
                CmbContab(1).Items.Insert(i, grdConta.CtlText)
                CmbContab(2).Items.Insert(i, grdConta.CtlText)
            Next i
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub FConcTrn_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub FConcTrn_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub PLTrasmitir()
        If CmbContab(0).Text = "" And CmbContab(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503302), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            CmbContab(0).Focus()
            Exit Sub
        End If
        If CmbContab(2).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503303), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            CmbContab(2).Focus()
            Exit Sub
        End If
        If txtCampo(7).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503304), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(7).Focus()
            Exit Sub
        End If
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503305), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If txtTImpuesto.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503306), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtTImpuesto.Focus()
            Exit Sub
        End If
        If txtConcepto.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503307), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtConcepto.Focus()
            Exit Sub
        End If
        If CmbContab(0).Text <> "" And CmbContab(1).Text <> "" Then
            VLser = Strings.Mid(Me.CmbContab(0).Items(Me.CmbContab(0).SelectedIndex), 1, 3)
            VLser1 = Strings.Mid(Me.CmbContab(1).Items(Me.CmbContab(1).SelectedIndex), 1, 3)
            If VLser <> VLser1 Then
                COBISMessageBox.Show(FMLoadResString(503308), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                CmbContab(0).Focus()
                Exit Sub
            End If
            If CmbContab(0).Text = CmbContab(1).Text Then
                COBISMessageBox.Show(FMLoadResString(503309), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                CmbContab(0).Focus()
                Exit Sub
            End If
        End If
        If CmbContab(2).Text <> "" Then
            VLcon = Strings.Mid(CmbContab(2).Items(CmbContab(2).SelectedIndex), 1, 3)
            If VLser <> "" Then
                If VLcon <> VLser Then
                    COBISMessageBox.Show(FMLoadResString(503310), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    CmbContab(0).Focus()
                    Exit Sub
                End If
            End If
            If VLser1 <> "" Then
                If VLcon <> VLser1 Then
                    COBISMessageBox.Show(FMLoadResString(503313), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    CmbContab(0).Focus()
                    Exit Sub
                End If
            End If
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(4107))
        PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_causal", 0, SQLVARCHAR, txtCausal.Text)
        PMPasoValores(sqlconn, "@i_timpuesto", 0, SQLVARCHAR, txtTImpuesto.Text)
        PMPasoValores(sqlconn, "@i_concepto", 0, SQLVARCHAR, txtConcepto.Text)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "I")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, txtCampo(7).Text)
        PMPasoValores(sqlconn, "@i_base1", 0, SQLVARCHAR, CmbContab(0).Text)
        PMPasoValores(sqlconn, "@i_base2", 0, SQLVARCHAR, CmbContab(1).Text)
        PMPasoValores(sqlconn, "@i_contabiliza", 0, SQLVARCHAR, CmbContab(2).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_concepto_tran", True, FMLoadResString(503311)) Then
            PMChequea(sqlconn)
            PLLimpiar(False)
            PLBuscar()
        Else
            PMChequea(sqlconn)
            COBISMessageBox.Show(FMLoadResString(503312), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End If
    End Sub

    Private Sub PLActualizar()
        If txtCampo(7).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503304), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            cmdBoton(17).Focus()
            Exit Sub
        End If
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503305), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            cmdBoton(17).Focus()
            Exit Sub
        End If
        If txtTImpuesto.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503306), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            cmdBoton(17).Focus()
            Exit Sub
        End If
        If txtConcepto.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503307), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtConcepto.Focus()
            Exit Sub
        End If
        If CmbContab(2).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503303), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            CmbContab(2).Focus()
            Exit Sub
        End If
        If CmbContab(0).Text = "" And CmbContab(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503302), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            CmbContab(0).Focus()
            Exit Sub
        End If
        If CmbContab(0).Text <> "" And CmbContab(1).Text <> "" Then
            VLser = Strings.Mid(CmbContab(0).Items(CmbContab(0).SelectedIndex), 1, 3)
            VLser1 = Strings.Mid(CmbContab(1).Items(CmbContab(1).SelectedIndex), 1, 3)

            If VLser <> VLser1 Then
                COBISMessageBox.Show(FMLoadResString(503308), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                CmbContab(0).Focus()
                Exit Sub
            End If
            If CmbContab(0).Text = CmbContab(1).Text Then
                COBISMessageBox.Show(FMLoadResString(503309), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                CmbContab(0).Focus()
                Exit Sub
            End If
        End If
        If CmbContab(2).Text <> "" Then
            VLcon = Strings.Mid(CmbContab(2).Items(CmbContab(2).SelectedIndex), 1, 3)
            If VLser <> "" Then
                If VLcon <> VLser Then
                    COBISMessageBox.Show(FMLoadResString(503310), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    CmbContab(0).Focus()
                    Exit Sub
                End If
            End If
            If VLser1 <> "" Then
                If VLcon <> VLser1 Then
                    COBISMessageBox.Show(FMLoadResString(503313), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    CmbContab(0).Focus()
                    Exit Sub
                End If
            End If
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(4107))
        PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_causal", 0, SQLVARCHAR, txtCausal.Text)
        PMPasoValores(sqlconn, "@i_timpuesto", 0, SQLVARCHAR, txtTImpuesto.Text)
        PMPasoValores(sqlconn, "@i_concepto", 0, SQLVARCHAR, txtConcepto.Text)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "U")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, txtCampo(7).Text)
        PMPasoValores(sqlconn, "@i_base1", 0, SQLVARCHAR, CmbContab(0).Text)
        PMPasoValores(sqlconn, "@i_base2", 0, SQLVARCHAR, CmbContab(1).Text)
        PMPasoValores(sqlconn, "@i_contabiliza", 0, SQLVARCHAR, CmbContab(2).Text)
        PMPasoValores(sqlconn, "@i_conta_antes", 0, SQLVARCHAR, lblconta.Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_concepto_tran", True, FMLoadResString(503311)) Then
            PMChequea(sqlconn)
            PLLimpiar(False)
            PLBuscar()
            cmdBoton(3).Enabled = False
            cmdBoton(1).Enabled = False
            cmdBoton(0).Enabled = True
        Else
            PMChequea(sqlconn)
            COBISMessageBox.Show(FMLoadResString(503314), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End If
        PLTSEstado()
    End Sub

    Private Sub PLEliminar()
        If txtCampo(7).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503304), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            cmdBoton(17).Focus()
            Exit Sub
        End If
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503305), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            cmdBoton(17).Focus()
            Exit Sub
        End If
        If txtTImpuesto.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503306), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            cmdBoton(17).Focus()
            Exit Sub
        End If
        If txtConcepto.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503307), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtConcepto.Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(4107))
        PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_causal", 0, SQLVARCHAR, txtCausal.Text)
        PMPasoValores(sqlconn, "@i_timpuesto", 0, SQLVARCHAR, txtTImpuesto.Text)
        PMPasoValores(sqlconn, "@i_concepto", 0, SQLVARCHAR, txtConcepto.Text)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "D")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, txtCampo(7).Text)
        PMPasoValores(sqlconn, "@i_contabiliza", 0, SQLVARCHAR, CmbContab(2).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_concepto_tran", True, FMLoadResString(503315)) Then
            PMChequea(sqlconn)
            PLLimpiar(False)
            PLBuscar()
            cmdBoton(3).Enabled = False
            cmdBoton(1).Enabled = False
            cmdBoton(0).Enabled = True
        Else
            PMChequea(sqlconn)
            COBISMessageBox.Show(FMLoadResString(503316), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End If
        PLTSEstado()
    End Sub

    Private Sub PLBuscar()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, CStr(4107))
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_causal", 0, SQLVARCHAR, "0")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_concepto_tran", True, FMLoadResString(503317)) Then
            PMMapeaGrid(sqlconn, grdTran, False)
            PMChequea(sqlconn)
            cmdBoton(16).Enabled = Conversion.Val(Convert.ToString(grdTran.Tag)) = 20
        Else
            PMChequea(sqlconn)
            PLLimpiar(True)
        End If
        PLTSEstado()
    End Sub

    Private Sub PLLimpiar(ByRef VLBan As Boolean)
        txtCampo(0).Text = ""
        txtCampo(7).Text = ""
        lblDescripcion(3).Text = ""
        lblDescripcion(0).Text = ""
        txtTImpuesto.Text = ""
        lblTImpuesto.Text = ""
        txtConcepto.Text = ""
        txtCausal.Text = ""
        lblDescripcion(1).Text = ""
        txtCampo(0).Enabled = True
        txtCampo(7).Enabled = True
        txtCausal.Enabled = True
        txtTImpuesto.Enabled = True
        If VLBan Then
            PMLimpiaGrid(grdTran)
        End If
        cmdBoton(3).Enabled = False
        cmdBoton(1).Enabled = False
        cmdBoton(0).Enabled = True
        cmdBoton(16).Enabled = False
        CmbContab(0).SelectedIndex = -1
        CmbContab(1).SelectedIndex = -1
        CmbContab(2).SelectedIndex = -1
        txtCampo(7).Focus()
        PLTSEstado() 'JSA
    End Sub

    Private Sub PLSiguientes()
        grdTran.Row = grdTran.Rows - 1
        grdTran.Col = 1
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, CStr(4107))
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        grdTran.Row = grdTran.Rows - 1
        grdTran.Col = 1
        PMPasoValores(sqlconn, "@i_sec", 0, SQLINT2, grdTran.CtlText)
        grdTran.Col = 3
        PMPasoValores(sqlconn, "@i_causal", 0, SQLVARCHAR, grdTran.CtlText)
        grdTran.Col = 4
        PMPasoValores(sqlconn, "@i_tipoimp", 0, SQLVARCHAR, grdTran.CtlText)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_concepto_tran", True, FMLoadResString(503317)) Then
            PMMapeaGrid(sqlconn, grdTran, True)
            PMChequea(sqlconn)
            grdTran.ColAlignment(3) = 1
            cmdBoton(16).Enabled = Conversion.Val(Convert.ToString(grdTran.Tag)) = 20
        Else
            PMChequea(sqlconn)
            PLLimpiar(False)
        End If
        PLTSEstado()
    End Sub

    Private Sub grdTran_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdTran.Click
        grdTran.Col = 0
        grdTran.SelStartCol = 1
        grdTran.SelEndCol = grdTran.Cols - 1
        If grdTran.Row = 0 Then
            grdTran.SelStartRow = 1
            grdTran.SelEndRow = 1
        Else
            grdTran.SelStartRow = grdTran.Row
            grdTran.SelEndRow = grdTran.Row
        End If
        PMMarcaFilaCobisGrid(grdTran, grdTran.Row)
    End Sub

    Private Sub grdTran_ClickEvent(sender As Object, e As EventArgs) Handles grdTran.ClickEvent
        PMMarcaFilaCobisGrid(grdTran, grdTran.Row)
    End Sub

    Private Sub grdTran_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdTran.DblClick
        lblDescripcion(1).Text = ""
        lblconta.Text = ""
        If grdTran.CtlText <> "" Then
            CmbContab(0).SelectedIndex = -1
            CmbContab(1).SelectedIndex = -1
            CmbContab(2).SelectedIndex = -1
            grdTran.Col = 1
            txtCampo(0).Text = grdTran.CtlText
            grdTran.Col = 2
            lblDescripcion(0).Text = grdTran.CtlText
            grdTran.Col = 4
            txtTImpuesto.Text = grdTran.CtlText
            grdTran.Col = 5
            lblTImpuesto.Text = grdTran.CtlText
            grdTran.Col = 6
            txtConcepto.Text = grdTran.CtlText
            grdTran.Col = 7
            txtCampo(7).Text = grdTran.CtlText
            grdTran.Col = 8
            lblDescripcion(3).Text = grdTran.CtlText
            grdTran.Col = 3
            txtCausal.Text = grdTran.CtlText
            If txtCausal.Text <> "0" And txtCausal.Text.Trim() <> "" Then
                txtCausal_Leave(txtCausal, New EventArgs())
            End If
            grdTran.Col = 9
            If grdTran.CtlText.Trim() <> "" Then
                CmbContab(2).Text = grdTran.CtlText.Trim()
                lblconta.Text = CmbContab(2).Text
            End If
            grdTran.Col = 10
            If grdTran.CtlText.Trim() <> "" Then
                CmbContab(0).Text = grdTran.CtlText.Trim()
            End If
            grdTran.Col = 11
            If grdTran.CtlText.Trim() <> "" Then
                CmbContab(1).Text = grdTran.CtlText.Trim()
            End If
            cmdBoton(3).Enabled = True
            cmdBoton(1).Enabled = True
            cmdBoton(0).Enabled = False
            txtCampo(0).Enabled = False
            txtCampo(7).Enabled = False
            txtCausal.Enabled = False
            txtTImpuesto.Enabled = False
        End If
        PMMarcaFilaCobisGrid(grdTran, grdTran.Row)
        txtConcepto.Focus()
        PLTSEstado()
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.TextChanged, _txtCampo_7.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 7
                VLPaso = False
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Enter, _txtCampo_7.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502251))
            Case 7

                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502258))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_0.KeyDown, _txtCampo_7.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Keycode <> VGTeclaAyuda Then
            Exit Sub
        End If
        Select Case Index
            Case 7
                VLPaso = True
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "475")
                PMPasoValores(sqlconn, "@i_ope", 0, SQLCHAR, "A")
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_consulta_prod", True, FMLoadResString(2277)) Then
                    PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                    PMChequea(sqlconn)
                    FCatalogo.ShowPopup(Me)
                    txtCampo(7).Text = VGACatalogo.Codigo
                    lblDescripcion(3).Text = VGACatalogo.Descripcion
                    If txtCampo(7).Text.Trim() = "" Then
                        txtCampo(0).Text = ""
                        lblDescripcion(0).Text = ""
                        lblDescripcion(3).Text = ""
                        txtCampo(7).Focus()
                    End If
                    FCatalogo.Dispose()
                Else
                    PMChequea(sqlconn)
                End If
            Case 0
                If txtCampo(7).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502633), My.Application.Info.ProductName)
                    txtCampo(7).Focus()
                    Exit Sub
                End If
                VLPaso = True
                VGOperacion = "sp_pro_transaccion"
                VGProductoConta = txtCampo(7).Text
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "15020")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "9")
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, txtCampo(7).Text)
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "R")
                PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGMoneda)
                PMPasoValores(sqlconn, "@i_transaccion", 0, SQLINT4, "0")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_pro_transaccion", True, FMLoadResString(2277)) Then
                    PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                    PMChequea(sqlconn)
                    FCatalogo.ShowPopup(Me)
                    txtCampo(0).Text = VGACatalogo.Codigo
                    lblDescripcion(0).Text = VGACatalogo.Descripcion
                    If txtCampo(0).Text.Trim() = "" Then
                        txtCampo(0).Text = ""
                        lblDescripcion(0).Text = ""
                        txtCampo(0).Focus()
                    End If
                    FCatalogo.Dispose()
                Else
                    PMChequea(sqlconn)
                End If
        End Select
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_0.KeyPress, _txtCampo_7.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Leave, _txtCampo_7.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTTranVal As Integer = 0
        Select Case Index
            Case 0
                If txtCampo(0).Text.Trim() = "" Then
                    lblDescripcion(0).Text = ""
                    txtCausal.Text = ""
                    lblDescripcion(1).Text = ""
                    Exit Sub
                End If
                If txtCampo(7).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502237), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Text = ""
                    If txtCausal.Text.Trim() <> "" Then
                        txtCausal.Text = ""
                        lblDescripcion(1).Text = ""
                    End If
                    txtCampo(7).Focus()
                    Exit Sub
                End If
                VTTranVal = Conversion.Val(txtCampo(0).Text)
                Select Case txtCampo(7).Text.Trim()
                    Case "3"
                        If VTTranVal > 2999 Or (VTTranVal < 2500 And VTTranVal > 99) And VTTranVal <> 638 Then
                            COBISMessageBox.Show(FMLoadResString(502636), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(0).Text = ""
                            lblDescripcion(0).Text = ""
                            txtCausal.Text = ""
                            lblDescripcion(1).Text = ""
                            txtCampo(0).Focus()
                            Exit Sub
                        End If
                    Case "4"
                        If VTTranVal <= 200 Or VTTranVal >= 399 Then
                            COBISMessageBox.Show(FMLoadResString(502986), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(0).Text = ""
                            lblDescripcion(0).Text = ""
                            txtCampo(0).Focus()
                            Exit Sub
                        End If
                    Case "10"
                        If VTTranVal >= 500 Or VTTranVal < 400 Then
                            If (VTTranVal >= 700 Or VTTranVal < 600) And VTTranVal <> 638 Then
                                COBISMessageBox.Show(FMLoadResString(503319), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                txtCampo(0).Text = ""
                                lblDescripcion(0).Text = ""
                                txtCampo(0).Focus()
                                Exit Sub
                            End If
                        End If
                End Select
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "494")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                PMPasoValores(sqlconn, "@i_prod", 0, SQLINT1, txtCampo(7).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_trn_contabilizar", False, "") Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(0))
                    txtCausal.Text = ""
                    lblDescripcion(1).Text = ""
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Text = ""
                    txtCampo(0).Focus()
                End If
                PLParametro()
                VLTabla = ""
                If txtCampo(0).Text = VLParametro Then
                    txtCausal.Enabled = True
                End If
            Case 7
                If VLPaso Then
                    Exit Sub
                End If
                If txtCampo(7).Text.Trim() = "" Then
                    lblDescripcion(3).Text = ""
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Text = ""
                    txtCausal.Text = ""
                    lblDescripcion(1).Text = ""
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "475")
                PMPasoValores(sqlconn, "@i_ope", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, txtCampo(7).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_consulta_prod", True, FMLoadResString(503322) & " " & "[" & txtCampo(Index).Text & "]") Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(3))
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Text = ""
                    txtCausal.Text = ""
                    lblDescripcion(1).Text = ""
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtCampo(7).Text = ""
                    lblDescripcion(3).Text = ""
                    txtCampo(7).Focus()
                End If
                If txtCampo(7).Text = "3" Then
                End If
        End Select
    End Sub

    Private Sub txtCausal_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCausal.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub txtCausal_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCausal.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        txtCausal.MaxLength = 4
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503323))
        txtCausal.SelectionStart = 0
        txtCausal.SelectionLength = Strings.Len(txtCausal.Text)
    End Sub

    Private Sub txtCausal_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtCausal.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode <> VGTeclaAyuda Then
            Exit Sub
        End If
        If txtCausal.Text <> "" Then
            txtCausal.Text = ""
            lblDescripcion(1).Text = ""
        End If
        If txtCampo(0).Text = VLParametro Then
            VLTabla = "ah_cau_nc_gmf_ba"
        End If
        If CDbl(txtCampo(7).Text) = 3 And CDbl(txtCampo(0).Text) = 86 Then
            VLTabla = "cc_causa_oe"
        End If
        If CDbl(txtCampo(7).Text) = 3 And CDbl(txtCampo(0).Text) = 32 Then
            VLTabla = "cc_causa_oioe"
        End If
        If CDbl(txtCampo(7).Text) = 3 And CDbl(txtCampo(0).Text) = 50 Then
            VLTabla = "cc_causa_nd"
        End If
        If CDbl(txtCampo(7).Text) = 3 And CDbl(txtCampo(0).Text) = 48 Then
            VLTabla = "cc_causa_nc"
        End If
        If CDbl(txtCampo(7).Text) = 4 And CDbl(txtCampo(0).Text) = 264 Then
            VLTabla = "ah_causa_nd"
        End If
        If CDbl(txtCampo(7).Text) = 4 And CDbl(txtCampo(0).Text) = 253 Then
            VLTabla = "ah_causa_nc"
        End If
        If VLTabla = "" Then
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VLTabla)
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(503324) & " " & "[" & txtCampo(Index).Text & "]") Then
            VLPaso = True
            PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
            PMChequea(sqlconn)
            FCatalogo.ShowPopup(Me)
            txtCausal.Text = VGACatalogo.Codigo
            lblDescripcion(1).Text = VGACatalogo.Descripcion
            If txtCausal.Text.Trim() = "" Then
                lblDescripcion(1).Text = ""
                txtCausal.Focus()
            End If
            FCatalogo.Dispose()
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub txtCausal_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtCausal.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCausal_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCausal.Leave
        If VLPaso Then
            Exit Sub
        End If
        If txtCausal.Text.Trim() <> "" Then
            If txtCampo(7).Text = "" Then
                COBISMessageBox.Show(FMLoadResString(503325), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtCampo(0).Text = ""
                lblDescripcion(0).Text = ""
                txtCausal.Text = ""
                lblDescripcion(1).Text = ""
                txtCampo(7).Focus()
                Exit Sub
            End If
            If txtCampo(0).Text = "" Then
                COBISMessageBox.Show(FMLoadResString(503326), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtCausal.Text = ""
                lblDescripcion(1).Text = ""
                txtCampo(0).Focus()
                Exit Sub
            End If
        End If
        If txtCausal.Text.Trim() = "" Then
            lblDescripcion(1).Text = ""
            Exit Sub
        End If
        causa = txtCausal.Text
        If txtCampo(0).Text = VLParametro Then
            VLTabla = "ah_cau_nc_gmf_ba"
        End If
        If CDbl(txtCampo(7).Text) = 3 And CDbl(txtCampo(0).Text) = 86 Then
            VLTabla = "cc_causa_oe"
        End If
        If CDbl(txtCampo(7).Text) = 3 And CDbl(txtCampo(0).Text) = 32 Then
            VLTabla = "cc_causa_oioe"
        End If
        If CDbl(txtCampo(7).Text) = 3 And CDbl(txtCampo(0).Text) = 50 Then
            VLTabla = "cc_causa_nd"
        End If
        If CDbl(txtCampo(7).Text) = 3 And CDbl(txtCampo(0).Text) = 48 Then
            VLTabla = "cc_causa_nc"
        End If
        If CDbl(txtCampo(7).Text) = 4 And CDbl(txtCampo(0).Text) = 264 Then
            VLTabla = "ah_causa_nd"
        End If
        If CDbl(txtCampo(7).Text) = 4 And CDbl(txtCampo(0).Text) = 253 Then
            VLTabla = "ah_causa_nc"
        End If
        If VLTabla = "" Then
            COBISMessageBox.Show(FMLoadResString(502266), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        Dim dbNumericTemp As Double = 0
        If txtCampo(0).Text <> "" And Double.TryParse(txtCausal.Text, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp) Then
            VLTransac = CInt(txtCampo(0).Text)
        End If
        If VLTransac = 50 Or VLTransac = 264 Then
            Dim dbNumericTemp2 As Double = 0
            If txtCausal.Text <> "" And Double.TryParse(txtCausal.Text, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp2) Then
                causa_sus = CStr(CInt(txtCausal.Text))
                causa = txtCausal.Text
                VLTransac = CInt(txtCampo(0).Text)
                If StringsHelper.ToDoubleSafe(causa_sus) > 500 And (VLTransac = 50 Or VLTransac = 264) Then
                    causa_sus = CStr(CDbl(causa_sus) - 500)
                End If
                causa = causa_sus
            End If
        End If
        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VLTabla)
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
        PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, causa)
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502637) & " " & "[" & txtCampo(Index).Text & "]") Then
            PMMapeaObjeto(sqlconn, lblDescripcion(1))
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
            txtCausal.Text = ""
            lblDescripcion(1).Text = ""
            txtCausal.Enabled = True
            txtCausal.Focus()
        End If
    End Sub

    Private Sub txtConcepto_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtConcepto.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        txtConcepto.MaxLength = 4
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503327))
        txtConcepto.SelectionStart = 0
        txtTImpuesto.SelectionLength = Strings.Len(txtTImpuesto.Text)
    End Sub

    Private Sub txtConcepto_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtConcepto.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtTImpuesto_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtTImpuesto.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub txtTImpuesto_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtTImpuesto.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        txtTImpuesto.MaxLength = 1
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503328))
        txtTImpuesto.SelectionStart = 0
        txtTImpuesto.SelectionLength = Strings.Len(txtTImpuesto.Text)
    End Sub

    Private Sub txtTImpuesto_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtTImpuesto.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode = VGTeclaAyuda Then
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "cb_tipo_impuesto")
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, " " & FMLoadResString(503329) & " ") Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                VLPaso = True
                FCatalogo.ShowPopup(Me)
                txtTImpuesto.Text = VGACatalogo.Codigo
                lblTImpuesto.Text = VGACatalogo.Descripcion
                FCatalogo.Dispose()
            Else
                PMChequea(sqlconn)
            End If
        End If
    End Sub

    Private Sub PLParametro()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "F")
        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "TGMFBA")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(2628)) Then
            PMMapeaVariable(sqlconn, VLParametro)
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub txtTImpuesto_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtTImpuesto.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtTImpuesto_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtTImpuesto.Leave
        If VLPaso Then
            Exit Sub
        End If
        If txtTImpuesto.Text <> "" Then
            PMCatalogo("V", "cb_tipo_impuesto", txtTImpuesto, lblTImpuesto)
        Else
            lblTImpuesto.Text = ""
        End If
    End Sub

    Private Sub ToolStripButton6_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_17.Enabled Then cmdBoton_Click(_cmdBoton_17, e)
    End Sub

    Private Sub TSBBUSCAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_15.Enabled Then cmdBoton_Click(_cmdBoton_15, e)
    End Sub

    Private Sub TSBSIGUIENTE_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If _cmdBoton_16.Enabled Then cmdBoton_Click(_cmdBoton_16, e)
    End Sub

    Private Sub TSBTRANSMITIR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBACTUALIZAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBELIMINAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSALIR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_14.Enabled Then cmdBoton_Click(_cmdBoton_14, e)
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_15.Enabled
        TSBBuscar.Visible = _cmdBoton_15.Visible()
        TSBSiguiente.Enabled = _cmdBoton_16.Enabled
        TSBSiguiente.Visible = _cmdBoton_16.Visible()
        TSBActualizar.Enabled = _cmdBoton_3.Enabled
        TSBActualizar.Visible = _cmdBoton_3.Visible()
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible()
        TSBEliminar.Enabled = _cmdBoton_1.Enabled
        TSBEliminar.Visible = _cmdBoton_1.Visible()
        TSBLimpiar.Enabled = _cmdBoton_17.Enabled
        TSBLimpiar.Visible = _cmdBoton_17.Visible()
        TSBSalir.Enabled = _cmdBoton_14.Enabled
        TSBSalir.Visible = _cmdBoton_14.Visible()
    End Sub

    Private Sub grdTran_Enter(sender As Object, e As EventArgs) Handles grdTran.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502008))
    End Sub

    Private Sub grdTran_Leave(sender As Object, e As EventArgs) Handles grdTran.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub CmbContab_Enter(sender As Object, e As EventArgs) Handles _CmbContab_0.Enter, _CmbContab_1.Enter, _CmbContab_2.Enter
        Dim Index As Integer = Array.IndexOf(CmbContab, sender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(20023))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(20024))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(20022))
        End Select
    End Sub
End Class


