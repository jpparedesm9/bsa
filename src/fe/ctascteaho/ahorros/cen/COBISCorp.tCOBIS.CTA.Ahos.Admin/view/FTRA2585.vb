Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran2585Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLPaso As Integer = 0
    Dim VLCiudad As String = ""
    Dim VLCodigo As String = ""
    Dim i As Integer = 0

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_6.Click, _cmdBoton_5.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_4.Click, _cmdBoton_1.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                Me.Close()
            Case 1
                PLLimpiar()
            Case 2
                PLEliminar()
            Case 3
                PLCrear()
            Case 4
                PLActualizar()
            Case 5
                PLSiguientes()
            Case 6
                PLBuscar()
        End Select
    End Sub

    Private Sub FTran2585_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
    End Sub

    Public Sub PLInicializar()
        PMBotonSeguridad(Me, 4)
        cmdBoton(2).Enabled = False
        cmdBoton(4).Enabled = False
        cmdBoton(5).Enabled = False
        PLTSEstado()
    End Sub

    Private Sub FTran2585_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdRegistros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.Click
        grdRegistros.Col = 0
        grdRegistros.SelStartCol = 1
        grdRegistros.SelEndCol = grdRegistros.Cols - 1
        If grdRegistros.Row = 0 Then
            grdRegistros.SelStartRow = 1
            grdRegistros.SelEndRow = 1
        Else
            grdRegistros.SelStartRow = grdRegistros.Row
            grdRegistros.SelEndRow = grdRegistros.Row
        End If
    End Sub

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdRegistros.DblClick
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
        If grdRegistros.Rows <= 2 Then
            grdRegistros.Row = 1
            grdRegistros.Col = 1
            If grdRegistros.CtlText.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(500280), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        End If
        grdRegistros.Col = 1
        txtCampo(1).Text = StringsHelper.Format(grdRegistros.CtlText, "0000")
        grdRegistros.Col = 3
        txtCampo(2).Text = StringsHelper.Format(grdRegistros.CtlText, "0000")
        grdRegistros.Col = 4
        txtCampo(3).Text = StringsHelper.Format(grdRegistros.CtlText, "0000")
        grdRegistros.Col = 5
        txtCampo(4).Text = StringsHelper.Format(grdRegistros.CtlText, "0000")
        grdRegistros.Col = 7
        txtCampo(5).Text = StringsHelper.Format(grdRegistros.CtlText, "0000")
        grdRegistros.Col = 8
        txtCampo(6).Text = StringsHelper.Format(grdRegistros.CtlText, "0000")
        grdRegistros.Col = 9
        txtCampo(7).Text = grdRegistros.CtlText
        grdRegistros.Col = 10
        txtCampo(8).Text = grdRegistros.CtlText
        VLCiudad = txtCampo(0).Text
        txtCampo(1).Enabled = False
        txtCampo(2).Enabled = False
        txtCampo(3).Enabled = False
        txtCampo(4).Enabled = False
        txtCampo(5).Enabled = False
        txtCampo(6).Enabled = False
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = True
        cmdBoton(2).Enabled = True
        PLTSEstado()
    End Sub

    Private Sub PLActualizar()
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503246), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503247), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(1).Focus()
            Exit Sub
        ElseIf txtCampo(2).Text = "" Then
            txtCampo(2).Text = "0"
        ElseIf txtCampo(3).Text = "" Then
            txtCampo(2).Text = "0"
        ElseIf txtCampo(4).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503248), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(4).Focus()
            Exit Sub
        ElseIf txtCampo(5).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503249), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(5).Focus()
            Exit Sub
        ElseIf txtCampo(6).Text = "" Then
            FMLoadResString(502627)
            COBISMessageBox.Show(FMLoadResString(503250), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(6).Focus()
            Exit Sub
        End If
        If txtCampo(7).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500282), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(7).Focus()
            Exit Sub
        End If
        If txtCampo(8).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503251), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(8).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2586")
        PMPasoValores(sqlconn, "@i_localidad_a", 0, SQLINT4, VLCiudad)
        PMPasoValores(sqlconn, "@i_localidad", 0, SQLINT4, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_banco_p", 0, SQLINT2, txtCampo(1).Text)
        PMPasoValores(sqlconn, "@i_oficina_p", 0, SQLINT2, txtCampo(2).Text)
        PMPasoValores(sqlconn, "@i_ciudad_p", 0, SQLINT4, txtCampo(3).Text)
        PMPasoValores(sqlconn, "@i_banco_c", 0, SQLINT2, txtCampo(4).Text)
        PMPasoValores(sqlconn, "@i_oficina_c", 0, SQLINT2, txtCampo(5).Text)
        PMPasoValores(sqlconn, "@i_ciudad_c", 0, SQLINT4, txtCampo(6).Text)
        PMPasoValores(sqlconn, "@i_num_dias", 0, SQLINT1, txtCampo(7).Text)
        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
        PMPasoValores(sqlconn, "@i_causacont", 0, SQLVARCHAR, txtCampo(8).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_crea_rutayt", True, FMLoadResString(503252)) Then
            PMChequea(sqlconn)
            PLBuscar()
            PLLimpiar()
        Else
            PMChequea(sqlconn)
            PLLimpiar()
        End If
    End Sub

    Private Sub PLBuscar()
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503253), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2587")
        PMPasoValores(sqlconn, "@i_tran", 0, SQLCHAR, "C")
        PMPasoValores(sqlconn, "@i_localidad", 0, SQLINT4, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, "0")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_crea_rutayt", True, FMLoadResString(503254)) Then
            PMMapeaGrid(sqlconn, grdRegistros, False)
            PMMapeaTextoGrid(grdRegistros)
            PMAnchoColumnasGrid(grdRegistros)
            PMChequea(sqlconn)
            cmdBoton(5).Enabled = Conversion.Val(CStr(grdRegistros.Rows - 1)) >= 20
            If grdRegistros.Rows <= 2 Then
                grdRegistros.Col = 1
                grdRegistros.Row = 1
                If grdRegistros.CtlText = "" Then
                    PLLimpiar()
                    Exit Sub
                End If
            End If
            If cmdBoton(3).Enabled Then
                cmdBoton(3).Focus()
            End If
            If Not txtCampo(1).Enabled Then
                txtCampo(1).Enabled = True
            End If
            txtCampo(1).Focus()
        Else
            PMChequea(sqlconn)
            PLLimpiar()
        End If
        PLTSEstado()
    End Sub

    Private Sub PLCrear()
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503255), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503256), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(1).Focus()
            Exit Sub
        ElseIf txtCampo(2).Text = "" Then
            txtCampo(2).Text = "0"
        ElseIf txtCampo(3).Text = "" Then
            txtCampo(3).Text = "0"
        ElseIf txtCampo(4).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503257), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(4).Focus()
            Exit Sub
        ElseIf txtCampo(5).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503258), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(5).Focus()
            Exit Sub
        ElseIf txtCampo(6).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503259), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(6).Focus()
            Exit Sub
        End If
        If txtCampo(7).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500282), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(7).Focus()
            Exit Sub
        End If
        If txtCampo(8).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503251), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(8).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2585")
        PMPasoValores(sqlconn, "@i_localidad", 0, SQLINT4, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_banco_p", 0, SQLINT2, txtCampo(1).Text)
        PMPasoValores(sqlconn, "@i_oficina_p", 0, SQLINT2, txtCampo(2).Text)
        PMPasoValores(sqlconn, "@i_ciudad_p", 0, SQLINT4, txtCampo(3).Text)
        PMPasoValores(sqlconn, "@i_banco_c", 0, SQLINT2, txtCampo(4).Text)
        PMPasoValores(sqlconn, "@i_oficina_c", 0, SQLINT2, txtCampo(5).Text)
        PMPasoValores(sqlconn, "@i_ciudad_c", 0, SQLINT4, txtCampo(6).Text)
        PMPasoValores(sqlconn, "@i_num_dias", 0, SQLINT1, txtCampo(7).Text)
        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
        PMPasoValores(sqlconn, "@i_causacont", 0, SQLVARCHAR, txtCampo(8).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_crea_rutayt", True, FMLoadResString(503261)) Then
            PMChequea(sqlconn)
            PLBuscar()
            PLLimpiar()
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub PLEliminar()
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503262), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503263), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(1).Focus()
            Exit Sub
        ElseIf txtCampo(2).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503264), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(2).Focus()
            Exit Sub
        ElseIf txtCampo(3).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503265), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(3).Focus()
            Exit Sub
        ElseIf txtCampo(4).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503266), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(4).Focus()
            Exit Sub
        ElseIf txtCampo(5).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503264), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(5).Focus()
            Exit Sub
        ElseIf txtCampo(6).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503265), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(6).Focus()
            Exit Sub
        End If
        If txtCampo(7).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500282), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(7).Focus()
            Exit Sub
        End If
        If txtCampo(8).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(503251), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(8).Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2588")
        PMPasoValores(sqlconn, "@i_localidad", 0, SQLINT4, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_banco_p", 0, SQLINT2, txtCampo(1).Text)
        PMPasoValores(sqlconn, "@i_oficina_p", 0, SQLINT2, txtCampo(2).Text)
        PMPasoValores(sqlconn, "@i_ciudad_p", 0, SQLINT4, txtCampo(3).Text)
        PMPasoValores(sqlconn, "@i_banco_c", 0, SQLINT2, txtCampo(4).Text)
        PMPasoValores(sqlconn, "@i_oficina_c", 0, SQLINT2, txtCampo(5).Text)
        PMPasoValores(sqlconn, "@i_ciudad_c", 0, SQLINT4, txtCampo(6).Text)
        PMPasoValores(sqlconn, "@i_num_dias", 0, SQLINT1, txtCampo(7).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_crea_rutayt", True, FMLoadResString(503270)) Then
            PMChequea(sqlconn)
            PLBuscar()
            PLLimpiar()
        Else
            PMChequea(sqlconn)
            PLLimpiar()
        End If
    End Sub

    Private Sub PLLimpiar()
        txtCampo(1).Enabled = True
        txtCampo(2).Enabled = True
        txtCampo(3).Enabled = True
        txtCampo(4).Enabled = True
        txtCampo(5).Enabled = True
        txtCampo(6).Enabled = True
        txtCampo(7).Enabled = True
        txtCampo(8).Enabled = True
        txtCampo(1).Text = ""
        txtCampo(2).Text = ""
        txtCampo(3).Text = ""
        txtCampo(4).Text = ""
        txtCampo(5).Text = ""
        txtCampo(6).Text = ""
        txtCampo(7).Text = ""
        txtCampo(8).Text = ""
        cmdBoton(3).Enabled = True
        cmdBoton(2).Enabled = False
        cmdBoton(4).Enabled = False
        cmdBoton(5).Enabled = False
        PMLimpiaG(grdRegistros)
        lblDescripcion.Text = ""
        txtCampo(0).Text = ""
        txtCampo(0).Focus()
        PLTSEstado() 'JSA
    End Sub

    Private Sub PLSiguientes()
        grdRegistros.Row = grdRegistros.Rows - 1
        grdRegistros.Col = 10
        Dim VTBancoP As String = grdRegistros.CtlText
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2587")
        PMPasoValores(sqlconn, "@i_tran", 0, SQLCHAR, "C")
        PMPasoValores(sqlconn, "@i_localidad", 0, SQLINT4, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, VTBancoP)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_crea_rutayt", True, FMLoadResString(503271)) Then
            PMMapeaGrid(sqlconn, grdRegistros, True)
            PMMapeaTextoGrid(grdRegistros)
            PMAnchoColumnasGrid(grdRegistros)
            PMChequea(sqlconn)
            cmdBoton(5).Enabled = Conversion.Val(Convert.ToString(grdRegistros.Tag)) >= 20
            If grdRegistros.Rows <= 2 Then
                grdRegistros.Col = 1
                grdRegistros.Row = 1
                If grdRegistros.CtlText = "" Then
                    PLLimpiar()
                    Exit Sub
                End If
            End If
            If cmdBoton(3).Enabled Then
                cmdBoton(3).Focus()
            End If
        Else
            PMChequea(sqlconn)
            cmdBoton(5).Enabled = False
        End If
        PLTSEstado()
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_8.TextChanged, _txtCampo_7.TextChanged, _txtCampo_6.TextChanged, _txtCampo_5.TextChanged, _txtCampo_4.TextChanged, _txtCampo_3.TextChanged, _txtCampo_2.TextChanged, _txtCampo_1.TextChanged, _txtCampo_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                VLPaso = False
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_8.Enter, _txtCampo_7.Enter, _txtCampo_6.Enter, _txtCampo_5.Enter, _txtCampo_4.Enter, _txtCampo_3.Enter, _txtCampo_2.Enter, _txtCampo_1.Enter, _txtCampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = True
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503272))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503273))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503274))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503275))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500287))
            Case 5
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503276))
            Case 6
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500289))
            Case 7
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500290))
            Case 8
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(9998))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_8.KeyDown, _txtCampo_7.KeyDown, _txtCampo_6.KeyDown, _txtCampo_5.KeyDown, _txtCampo_4.KeyDown, _txtCampo_3.KeyDown, _txtCampo_2.KeyDown, _txtCampo_1.KeyDown, _txtCampo_0.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Keycode = VGTeclaAyuda Then
            VLPaso = True
            txtCampo(Index).Text = ""
            Select Case Index
                Case 0
                    VGOperacion = "sp_tr_crea_rutayt"
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2587")
                    PMPasoValores(sqlconn, "@i_tran", 0, SQLCHAR, "L")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_localidad", 0, SQLINT4, "0")
                    PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, "0")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_crea_rutayt", True, FMLoadResString(503254)) Then
                        PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                        PMMapeaTextoGrid(FRegistros.grdRegistros)
                        PMAnchoColumnasGrid(FRegistros.grdRegistros)
                        PMChequea(sqlconn)
                        FRegistros.ShowPopup(Me)
                        txtCampo(Index).Text = VGACatalogo.Codigo
                        lblDescripcion.Text = VGACatalogo.Descripcion
                        If VLCodigo <> "" And VLCodigo <> txtCampo(Index).Text Then
                            For i As Integer = 1 To 8
                                txtCampo(i).Text = ""
                            Next i
                            PMLimpiaG(grdRegistros)
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
                    If txtCampo(Index).Text <> "" Then
                        cmdBoton(6).Focus()
                        VLCodigo = txtCampo(Index).Text
                    Else
                        txtCampo(Index).Text = ""
                        lblDescripcion.Text = ""
                    End If
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_8.KeyPress, _txtCampo_7.KeyPress, _txtCampo_6.KeyPress, _txtCampo_5.KeyPress, _txtCampo_4.KeyPress, _txtCampo_3.KeyPress, _txtCampo_2.KeyPress, _txtCampo_1.KeyPress, _txtCampo_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3, 4, 5, 6, 7, 8
                KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        End Select
        Select Case Index
            Case 0
                If Strings.Len(txtCampo(Index).Text) = 7 And txtCampo(Index + 1).Enabled Then
                    txtCampo(Index + 1).Focus()
                End If
            Case 1, 2, 3
                If Strings.Len(txtCampo(Index).Text) = 3 And txtCampo(Index + 1).Enabled Then
                    txtCampo(Index + 1).Focus()
                End If
            Case 4, 5, 6
                If Strings.Len(txtCampo(Index).Text) = 3 And txtCampo(Index + 1).Enabled Then
                    txtCampo(Index + 1).Focus()
                End If
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_8.Leave, _txtCampo_7.Leave, _txtCampo_6.Leave, _txtCampo_5.Leave, _txtCampo_4.Leave, _txtCampo_3.Leave, _txtCampo_2.Leave, _txtCampo_1.Leave, _txtCampo_0.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If Not VLPaso And txtCampo(Index).Text <> "" Then
                    If VLCodigo <> "" And VLCodigo <> txtCampo(Index).Text Then
                        For i As Integer = 1 To 8
                            txtCampo(i).Text = ""
                        Next i
                        PMLimpiaG(grdRegistros)
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2587")
                    PMPasoValores(sqlconn, "@i_tran", 0, SQLCHAR, "L")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                    PMPasoValores(sqlconn, "@i_localidad", 0, SQLINT4, txtCampo(0).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_crea_rutayt", True, FMLoadResString(503278)) Then
                        PMMapeaObjeto(sqlconn, lblDescripcion)
                        PMChequea(sqlconn)
                        If txtCampo(Index).Text <> "" Then
                            cmdBoton(6).Focus()
                            VLCodigo = txtCampo(Index).Text
                        End If
                    Else
                        PMChequea(sqlconn)
                        txtCampo(Index).Text = ""
                        lblDescripcion.Text = ""
                        txtCampo(Index).Focus()
                        PLLimpiar()
                    End If
                End If
        End Select
    End Sub

    Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_8.MouseDown, _txtCampo_7.MouseDown, _txtCampo_6.MouseDown, _txtCampo_5.MouseDown, _txtCampo_4.MouseDown, _txtCampo_3.MouseDown, _txtCampo_2.MouseDown, _txtCampo_1.MouseDown, _txtCampo_0.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 2, 3, 4, 5, 6, 7, 8
                My.Computer.Clipboard.Clear()
        End Select
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Visible = _cmdBoton_6.Visible
        TSBBuscar.Enabled = _cmdBoton_6.Enabled
        TSBSiguientes.Visible = _cmdBoton_5.Visible
        TSBSiguientes.Enabled = _cmdBoton_5.Enabled
        TSBCrear.Visible = _cmdBoton_3.Visible
        TSBCrear.Enabled = _cmdBoton_3.Enabled
        TSBActualizar.Visible = _cmdBoton_4.Visible
        TSBActualizar.Enabled = _cmdBoton_4.Enabled
        TSBEliminar.Visible = _cmdBoton_2.Visible
        TSBEliminar.Enabled = _cmdBoton_2.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBSalir.Visible = _cmdBoton_0.Visible
        TSBSalir.Enabled = _cmdBoton_0.Enabled
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub

    Private Sub TSBSiguientes_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguientes.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509116)) 'JSA
    End Sub

    Private Sub grdRegistros_Leave(sender As Object, e As EventArgs) Handles grdRegistros.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("") 'JSA
    End Sub
End Class


