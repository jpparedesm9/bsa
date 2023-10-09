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
 Public  Partial  Class FPersoEspecialClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim FBuscarCliente = New COBISCorp.tCOBIS.BClientes.FBuscarClienteClass()
	Dim VLPaso As Integer = 0
	Dim VLMoneda As String = ""
    Dim VLTipo_dato As String = ""
	Dim VLTipo_rango As String = ""
	Dim VLGrupo As String = ""
	Dim VLRango As String = ""
	Dim VLMinimo As Double = 0
	Dim VLMaximo As Double = 0
	Dim VLBase As Double = 0
    Dim VLFecha As String = ""

    Private Sub cmb_Leave(sender As Object, e As EventArgs) Handles cmbCosto.Leave, cmbPerso.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

	Private Sub cmbCosto_SelectedIndexChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbCosto.SelectedIndexChanged
		Dim Index As Integer = 0
		For i As Integer = 1 To grdServicios(0).Rows - 1
			grdServicios(Index).Col = 0
			grdServicios(Index).Row = i
			grdServicios(Index).CtlText = Conversion.Str(grdServicios(Index).Row)
			grdServicios(Index).Picture = picVisto(1).Image
		Next i
		grdServicios(1).Rows = 2
		grdServicios(1).Cols = 2
		grdServicios(1).Row = 0
		grdServicios(1).Col = 1
		grdServicios(1).CtlText = ""
		grdServicios(1).Row = 1
		grdServicios(1).Col = 0
		grdServicios(1).CtlText = ""
		grdServicios(1).Row = 1
		grdServicios(1).Col = 1
		grdServicios(1).CtlText = ""
		grdServicios(1).ColWidth(1) = grdServicios(1).ColWidth(0)
		VLTipo_dato = ""
		Select Case cmbCosto.Text
			Case "VALOR FIJO"
				lblEtiqueta(3).Visible = True
				lblEtiqueta(3).Text = "Valor Fijo:"
				mskCosto.Text = ""
				mskCosto.Visible = True
				txtCampo(1).Text = ""
				txtCampo(2).Text = ""
				mskCuenta.Mask = ""
				mskCuenta.Text = ""
				mskCuenta_Enter(mskCuenta, New EventArgs())
				lblDescripcion(0).Text = ""
				mskCosto.Mask = ""
				mskCosto.Text = ""
				mskFecha.Text = VLFecha
				txtCampo(4).Text = ""
				lblDescripcion(4).Text = ""
				lblEtiqueta(8).Visible = True
				lblDescripcion(4).Visible = True
				txtCampo(4).Visible = True
			Case "VALOR VARIABLE"
				lblEtiqueta(3).Visible = True
				lblEtiqueta(3).Text = "Valor Variable:"
				mskCosto.Text = ""
				mskCosto.Visible = True
				txtCampo(1).Text = ""
				txtCampo(2).Text = ""
				mskCuenta.Mask = ""
				mskCuenta.Text = ""
				mskCuenta_Enter(mskCuenta, New EventArgs())
				lblDescripcion(0).Text = ""
				mskCosto.Mask = ""
				mskCosto.Text = ""
				mskFecha.Text = VLFecha
				txtCampo(4).Text = ""
				lblDescripcion(4).Text = ""
				lblEtiqueta(8).Visible = True
				lblDescripcion(4).Visible = True
				txtCampo(4).Visible = True
			Case "VALOR EXONERADO"
				lblEtiqueta(3).Visible = False
				txtCampo(4).Text = ""
				lblDescripcion(4).Text = ""
				lblEtiqueta(8).Visible = False
				lblDescripcion(4).Visible = False
				txtCampo(4).Visible = False
				mskCosto.Text = ""
				mskCosto.Visible = False
				txtCampo(1).Text = ""
				txtCampo(2).Text = ""
				mskCuenta.Mask = ""
				mskCuenta.Text = ""
				mskCuenta_Enter(mskCuenta, New EventArgs())
				lblDescripcion(0).Text = ""
				mskCosto.Mask = ""
				mskCosto.Text = ""
				mskFecha.Text = VLFecha
		End Select
	End Sub

    Private Sub cmbCosto_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbCosto.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1768))
    End Sub

	Private Sub cmbPerso_SelectedIndexChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbPerso.SelectedIndexChanged
		Dim Index As Integer = 0
		For i As Integer = 1 To grdServicios(0).Rows - 1
			grdServicios(Index).Col = 0
			grdServicios(Index).Row = i
			grdServicios(Index).CtlText = Conversion.Str(grdServicios(Index).Row)
			grdServicios(Index).Picture = picVisto(1).Image
		Next i
		grdServicios(1).Rows = 2
		grdServicios(1).Cols = 2
		grdServicios(1).Row = 0
		grdServicios(1).Col = 1
		grdServicios(1).CtlText = ""
		grdServicios(1).Row = 1
		grdServicios(1).Col = 0
		grdServicios(1).CtlText = ""
		grdServicios(1).Row = 1
		grdServicios(1).Col = 1
		grdServicios(1).CtlText = ""
		grdServicios(1).ColWidth(1) = grdServicios(1).ColWidth(0)
		VLTipo_dato = ""
		Select Case cmbPerso.Text
			Case "CTA CORRIENTE", "CTA AHORROS"
				lblEtiqueta(2).Text = "Nro. Cuenta:"
				mskCuenta.Visible = True
				txtCampo(1).Visible = False
				txtCampo(2).Visible = False
				txtCampo(1).Text = ""
				txtCampo(2).Text = ""
				mskCuenta.Mask = ""
				mskCuenta.Text = ""
				mskCuenta_Enter(mskCuenta, New EventArgs())
				lblDescripcion(0).Text = ""
				mskCosto.Mask = ""
				mskCosto.Text = ""
				mskFecha.Text = VLFecha
				FrmAplic.Visible = True
				lblEtiqueta(9).Visible = True
				OptAplic(0).Checked = True
				If mskCuenta.Visible Then mskCuenta.Focus()
			Case "CLIENTE"
				lblEtiqueta(2).Text = "Código Cliente:"
				mskCuenta.Visible = False
				mskCuenta.Mask = ""
				mskCuenta.Text = ""
				lblDescripcion(0).Text = ""
				txtCampo(1).Text = ""
				txtCampo(1).Visible = False
				txtCampo(2).Text = ""
				txtCampo(2).Visible = True
				mskCosto.Mask = ""
				mskCosto.Text = ""
				mskFecha.Text = VLFecha
				FrmAplic.Visible = True
				lblEtiqueta(9).Visible = True
				OptAplic(0).Checked = True
				If txtCampo(2).Visible Then txtCampo(2).Focus()
			Case "OFICINA"
				lblEtiqueta(2).Text = "Código Oficina:"
				mskCuenta.Visible = False
				mskCuenta.Mask = ""
				mskCuenta.Text = ""
				lblDescripcion(0).Text = ""
				txtCampo(1).Text = ""
				txtCampo(1).Visible = True
				txtCampo(2).Text = ""
				txtCampo(2).Visible = False
				mskCosto.Mask = ""
				mskCosto.Text = ""
				mskFecha.Text = VLFecha
				FrmAplic.Visible = False
				lblEtiqueta(9).Visible = False
				OptAplic(0).Checked = False
				txtCampo(1).Focus()
		End Select
	End Sub

	Private Sub cmbPerso_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbPerso.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1771))
	End Sub

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_3.Click, _cmdBoton_2.Click, _cmdBoton_1.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Dim VTMarca As Integer = 0
		Dim VTValor As Double = 0
        Dim VTTipoCosto As String = string.Empty
        Dim VTTipoPer As String = string.Empty
        Dim VTProdu As String = string.Empty
        Dim VTTipoAplic As String = string.Empty
        Dim VLFormatoFecha As String = string.Empty
		Select Case Index
			Case 0
				If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1288), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(0).Focus()
					Exit Sub
				End If
				If mskFecha.ClipText = "" Then
                    COBISMessageBox.Show(FMLoadResString(1431), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					mskFecha.Focus()
					Exit Sub
				End If
				If cmbCosto.Text = "VALOR VARIABLE" Then
					VTMarca = 0
					For i As Integer = 1 To grdServicios(0).Rows - 1
						grdServicios(0).Col = 0
						grdServicios(0).Row = i
						If grdServicios(0).CtlText = "X" Then
							VTMarca = 1
							Exit For
						End If
					Next i
					If VTMarca = 0 Then
                        COBISMessageBox.Show(FMLoadResString(1245), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
						grdServicios(0).Focus()
						Exit Sub
					End If
				End If
				If mskCuenta.ClipText = "" And (cmbPerso.Text = "CTA CORRIENTE" Or cmbPerso.Text = "CTA AHORROS") Then
                    COBISMessageBox.Show(FMLoadResString(1226), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					mskCuenta.Focus()
					Exit Sub
				End If
				If cmbCosto.Text = "VALOR VARIABLE" And mskCosto.ClipText = "" Then
                    COBISMessageBox.Show(FMLoadResString(1231), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					mskCosto.Focus()
					Exit Sub
				End If
				If cmbCosto.Text = "VALOR FIJO" Or cmbCosto.Text = "VALOR VARIABLE" Then
					If txtCampo(4).Text = "P" Then
						If Conversion.Val(mskCosto.Text.ToString()) < -100 Or Conversion.Val(mskCosto.Text.ToString()) > 100 Then
                            COBISMessageBox.Show(FMLoadResString(1298), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
							mskCosto.Text = ""
							mskCosto.Focus()
							Exit Sub
						End If
					End If
				End If
				If cmbCosto.Text = "VALOR VARIABLE" Then
					If txtCampo(4).Text = "P" Then
						VTValor = VLBase + Math.Round(VLBase * CDbl(mskCosto.Text) / 100, 2)
					Else
						VTValor = VLBase + CDbl(mskCosto.Text)
					End If
					If VTValor > VLMaximo Then
                        COBISMessageBox.Show(FMLoadResString(1310) & StringsHelper.Format(VLMaximo, "#,##0.00"), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
						mskCosto.Mask = ""
						mskCosto.Text = ""
						mskCosto.Focus()
						Exit Sub
					End If
					If VTValor < VLMinimo Then
                        COBISMessageBox.Show(FMLoadResString(1309) & StringsHelper.Format(VLMinimo, "#,##0.00"), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
						mskCosto.Mask = ""
						mskCosto.Text = ""
						mskCosto.Focus()
						Exit Sub
					End If
				End If
				If mskCosto.ClipText = "" And cmbCosto.Text = "VALOR FIJO" Then
                    COBISMessageBox.Show(FMLoadResString(1230), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					mskCosto.Focus()
					Exit Sub
				End If
				If cmbCosto.Text <> "VALOR EXONERADO" And txtCampo(4).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1227), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(4).Focus()
					Exit Sub
				End If
				If mskCuenta.ClipText = "" And (cmbPerso.Text = "CTA CORRIENTE" Or cmbPerso.Text = "CTA AHORROS") Then
                    COBISMessageBox.Show(FMLoadResString(1226), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					mskCuenta.Focus()
					Exit Sub
				End If
				If txtCampo(1).Text = "" And cmbPerso.Text = "OFICINA" Then
                    COBISMessageBox.Show(FMLoadResString(1222), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(1).Focus()
					Exit Sub
				End If
				If txtCampo(2).Text = "" And cmbPerso.Text = "CLIENTE" Then
                    COBISMessageBox.Show(FMLoadResString(1223), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(2).Focus()
					Exit Sub
				End If
				If cmbCosto.Text = "VALOR FIJO" Then
					VTTipoCosto = "F"
					VLMinimo = 0
					VLMaximo = 0
                    VLTipo_rango = ""
					VLGrupo = ""
					VLRango = ""
					VLMinimo = -99
				ElseIf cmbCosto.Text = "VALOR VARIABLE" Then 
					VTTipoCosto = "V"
				Else
					VTTipoCosto = "E"
                    VLTipo_rango = ""
					VLGrupo = ""
					VLRango = ""
					VLMinimo = -99
				End If
				If cmbPerso.Text = "CTA CORRIENTE" Or cmbPerso.Text = "CTA AHORROS" Then
					VTTipoPer = "C"
				ElseIf cmbPerso.Text = "OFICINA" Then 
					VTTipoPer = "O"
				Else
					VTTipoPer = "E"
				End If
				If cmbPerso.Text = "CTA CORRIENTE" Then
					VTProdu = "3"
				ElseIf cmbPerso.Text = "CTA AHORROS" Then 
					VTProdu = "4"
				Else
					VTProdu = ""
				End If
				If cmbPerso.Text <> "OFICINA" Then
					If OptAplic(0).Checked Then
						VTTipoAplic = "N"
					Else
						VTTipoAplic = "O"
					End If
				Else
					VTTipoAplic = ""
				End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4090")
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
				PMPasoValores(sqlconn, "@i_tipo_costo", 0, SQLCHAR, VTTipoCosto)
				PMPasoValores(sqlconn, "@i_tipo_per", 0, SQLCHAR, VTTipoPer)
				PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(0).Text)
				PMPasoValores(sqlconn, "@i_rubro", 0, SQLVARCHAR, lblDescripcion(3).Text)
				PMPasoValores(sqlconn, "@i_tipo_dato", 0, SQLCHAR, txtCampo(4).Text)
				PMPasoValores(sqlconn, "@i_tipo_rango", 0, SQLINT1, VLTipo_rango)
				PMPasoValores(sqlconn, "@i_grupo_rango", 0, SQLINT2, VLGrupo)
				PMPasoValores(sqlconn, "@i_rango", 0, SQLINT1, VLRango)
				PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, mskCuenta.ClipText)
				PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtCampo(1).Text)
				PMPasoValores(sqlconn, "@i_cliente", 0, SQLINT4, txtCampo(2).Text)
				PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, VTProdu)
				PMPasoValores(sqlconn, "@i_valor_per", 0, SQLMONEY, mskCosto.Text)
				PMPasoValores(sqlconn, "@i_val_minimo", 0, SQLMONEY, CStr(VLMinimo))
				PMPasoValores(sqlconn, "@i_val_maximo", 0, SQLMONEY, CStr(VLMaximo))
				PMPasoValores(sqlconn, "@i_tipo_aplic", 0, SQLCHAR, VTTipoAplic)
				PMPasoValores(sqlconn, "@i_fecha_vigencia", 0, SQLVARCHAR, FMConvFecha(mskFecha.Text, Get_Preferencia("FORMATO-FECHA"), "mm/dd/yyyy"))
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_costos_especiales_per", True, FMLoadResString(1612)) Then
                    PMChequea(sqlconn)
                    mskCosto.Text = ""
                    cmdBoton_Click(cmdBoton(3), New EventArgs())
                Else
                    PMChequea(sqlconn)
                    COBISMessageBox.Show(FMLoadResString(1322), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                End If
			Case 1
				cmbCosto.Items.Clear()
				cmbCosto.Items.Insert(0, "VALOR FIJO")
				cmbCosto.Items.Insert(1, "VALOR VARIABLE")
				cmbCosto.Items.Insert(2, "VALOR EXONERADO")
				cmbCosto.SelectedIndex = 0
				cmbPerso.Items.Clear()
				cmbPerso.Items.Insert(0, "CTA CORRIENTE")
				cmbPerso.Items.Insert(1, "CTA AHORROS")
				cmbPerso.Items.Insert(2, "CLIENTE")
				cmbPerso.Items.Insert(3, "OFICINA")
				cmbPerso.SelectedIndex = 0
				mskCuenta.Mask = ""
				mskCuenta.Text = ""
				mskCuenta_Enter(mskCuenta, New EventArgs())
				mskCosto.Mask = ""
				mskCosto.Text = ""
				mskFecha.Text = StringsHelper.Format(VLFecha, VLFormatoFecha)
				For i As Integer = 0 To 2
					txtCampo(i).Text = ""
				Next i
				For i As Integer = 0 To 3
					lblDescripcion(i).Text = ""
				Next i
				For i As Integer = 0 To 1
					grdServicios(i).Rows = 2
					grdServicios(i).Cols = 2
					grdServicios(i).Row = 0
					grdServicios(i).Col = 1
					grdServicios(i).CtlText = ""
					grdServicios(i).Row = 1
					grdServicios(i).Col = 0
					grdServicios(i).CtlText = ""
					grdServicios(i).Row = 1
					grdServicios(i).Col = 1
					grdServicios(i).CtlText = ""
					grdServicios(i).ColWidth(1) = grdServicios(i).ColWidth(0)
				Next i
				cmdBoton(0).Enabled = True
				txtCampo(0).Focus()
			Case 2
                Me.Close()
                'FBuscarCliente.Close() '19/05/2016 migracion
                FBuscarCliente.Dispose()
			Case 3
				grdServicios(1).Rows = 2
				grdServicios(1).Cols = 2
				grdServicios(1).Row = 0
				grdServicios(1).Col = 1
				grdServicios(1).CtlText = ""
				grdServicios(1).Row = 1
				grdServicios(1).Col = 0
				grdServicios(1).CtlText = ""
				grdServicios(1).Row = 1
				grdServicios(1).Col = 1
				grdServicios(1).CtlText = ""
				grdServicios(1).ColWidth(1) = grdServicios(1).ColWidth(0)
				If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1288), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(0).Focus()
					Exit Sub
				End If
				If mskFecha.ClipText = "" Then
                    COBISMessageBox.Show(FMLoadResString(1431), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					mskFecha.Focus()
					Exit Sub
				End If
				If mskCuenta.ClipText = "" And (cmbPerso.Text = "CTA CORRIENTE" Or cmbPerso.Text = "CTA AHORROS") Then
                    COBISMessageBox.Show(FMLoadResString(1226), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					mskCuenta.Focus()
					Exit Sub
				End If
				If txtCampo(1).Text = "" And cmbPerso.Text = "OFICINA" Then
                    COBISMessageBox.Show(FMLoadResString(1222), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(1).Focus()
					Exit Sub
				End If
				If txtCampo(2).Text = "" And cmbPerso.Text = "CLIENTE" Then
                    COBISMessageBox.Show(FMLoadResString(1223), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(2).Focus()
					Exit Sub
				End If
				If cmbCosto.Text = "VALOR VARIABLE" Then
					VTMarca = 0
					For i As Integer = 1 To grdServicios(0).Rows - 1
						grdServicios(0).Col = 0
						grdServicios(0).Row = i
						If grdServicios(0).CtlText = "X" Then
							VTMarca = 1
							Exit For
						End If
					Next i
					If mskCuenta.ClipText = "" And (cmbPerso.Text = "CTA CORRIENTE" Or cmbPerso.Text = "CTA AHORROS") Then
                        COBISMessageBox.Show(FMLoadResString(1226), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
						mskCuenta.Focus()
						Exit Sub
					End If
				End If
				If cmbCosto.Text = "VALOR FIJO" Then
					VTTipoCosto = "F"
					VLMinimo = 0
					VLMaximo = 0
                    VLTipo_rango = ""
					VLGrupo = ""
					VLRango = ""
					VLMinimo = -99
				ElseIf cmbCosto.Text = "VALOR VARIABLE" Then 
					VTTipoCosto = "V"
				Else
					VTTipoCosto = "E"
                    VLTipo_rango = ""
					VLGrupo = ""
					VLRango = ""
					VLMinimo = -99
				End If
				If cmbPerso.Text = "CTA CORRIENTE" Or cmbPerso.Text = "CTA AHORROS" Then
					VTTipoPer = "C"
				ElseIf cmbPerso.Text = "OFICINA" Then 
					VTTipoPer = "O"
				Else
					VTTipoPer = "E"
				End If
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4089")
				PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
				PMPasoValores(sqlconn, "@i_tipo_costo", 0, SQLCHAR, VTTipoCosto)
				PMPasoValores(sqlconn, "@i_tipo_per", 0, SQLCHAR, VTTipoPer)
				PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(0).Text)
				PMPasoValores(sqlconn, "@i_rubro", 0, SQLVARCHAR, lblDescripcion(3).Text)
				PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, mskCuenta.ClipText)
				PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, txtCampo(1).Text)
				PMPasoValores(sqlconn, "@i_cliente", 0, SQLINT4, txtCampo(2).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_costos_especiales_per", True, FMLoadResString(1549)) Then
                    PMMapeaGrid(sqlconn, grdServicios(1), False)
                    PMMapeaTextoGrid(grdServicios(1))
                    PMChequea(sqlconn)
                    grdServicios(1).ColWidth(1) = 1300
                    grdServicios(1).ColWidth(6) = 1800
                    grdServicios(1).ColWidth(4) = 1500
                    grdServicios(1).ColWidth(5) = 1500
                Else
                    PMChequea(sqlconn)
                End If
		End Select
          PLTSEstado()
	End Sub

	Private Sub FPersoEspecial_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
		cmbCosto.Items.Clear()
		cmbCosto.Items.Insert(0, "VALOR FIJO")
		cmbCosto.Items.Insert(1, "VALOR VARIABLE")
		cmbCosto.Items.Insert(2, "VALOR EXONERADO")
		cmbCosto.SelectedIndex = 0
		cmbPerso.Items.Clear()
		cmbPerso.Items.Insert(0, "CTA CORRIENTE")
		cmbPerso.Items.Insert(1, "CTA AHORROS")
		cmbPerso.Items.Insert(2, "CLIENTE")
		cmbPerso.Items.Insert(3, "OFICINA")
		cmbPerso.SelectedIndex = 0
		VLTipo_dato = ""
		Dim VLFormatoFecha As String = Get_Preferencia("FORMATO-FECHA")
		mskFecha.Mask = FMMascaraFecha(VLFormatoFecha)
		VLFecha = FMConvFecha(VGFecha, "mm/dd/yyyy", Get_Preferencia("FORMATO-FECHA"))
		VLFecha = DateTimeHelper.ToString(CDate(VLFecha).AddDays(1))
		mskFecha.Text = VLFecha
		PMObjetoSeguridad(cmdBoton(3))
        PMObjetoSeguridad(cmdBoton(0))
        PLTSEstado()
	End Sub

	Private Sub FPersoEspecial_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

	Private Sub PMMarcarRegistro(ByRef Index As Integer)
		Dim VTFila As Integer = 0
		If Index = 0 Then
			If cmbCosto.Text = "VALOR VARIABLE" Then
				grdServicios(Index).Col = 0
				If grdServicios(Index).CtlText <> "X" Then
					grdServicios(Index).CtlText = "X"
					grdServicios(Index).Picture = picVisto(0).Image
                    'grdServicios(Index).Col = 2
                    'VLRubro = grdServicios(Index).CtlText
					grdServicios(Index).Col = 3
					VLTipo_dato = grdServicios(Index).CtlText
					grdServicios(Index).Col = 10
					VLTipo_rango = grdServicios(Index).CtlText
					grdServicios(Index).Col = 11
					VLGrupo = grdServicios(Index).CtlText
					grdServicios(Index).Col = 12
					VLRango = grdServicios(Index).CtlText
					grdServicios(Index).Col = 6
					VLMinimo = CDbl(grdServicios(Index).CtlText)
					grdServicios(Index).Col = 7
					VLBase = CDbl(grdServicios(Index).CtlText)
					grdServicios(Index).Col = 8
					VLMaximo = CDbl(grdServicios(Index).CtlText)
					mskCosto.Focus()
				Else
					grdServicios(Index).CtlText = Conversion.Str(grdServicios(Index).Row)
					grdServicios(Index).Picture = picVisto(1).Image
                    VLTipo_dato = ""
					VLTipo_rango = ""
					VLGrupo = ""
					VLRango = ""
					VLMinimo = 0
					VLMaximo = 0
				End If
				grdServicios(Index).Col = 0
				VTFila = grdServicios(Index).Row
				For i As Integer = 1 To grdServicios(Index).Rows - 1
					If i <> VTFila Then
						grdServicios(Index).Row = i
						grdServicios(Index).CtlText = Conversion.Str(grdServicios(Index).Row)
						grdServicios(Index).Picture = picVisto(1).Image
					End If
				Next i
			End If
		End If
	End Sub
    Private Sub grdServicios_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _grdServicios_1.ClickEvent, _grdServicios_0.ClickEvent
        Dim Index As Integer = Array.IndexOf(grdServicios, eventSender)
        Select Case Index
            Case 0, 1
                grdServicios(Index).Col = 0
                grdServicios(Index).SelStartCol = 1
                grdServicios(Index).SelEndCol = grdServicios(Index).Cols - 1
                If grdServicios(Index).Row = 0 Then
                    grdServicios(Index).SelStartRow = 1
                    grdServicios(Index).SelEndRow = 1
                Else
                    grdServicios(Index).SelStartRow = grdServicios(Index).Row
                    grdServicios(Index).SelEndRow = grdServicios(Index).Row
                End If
        End Select
    End Sub

	Private Sub grdServicios_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles _grdServicios_1.DblClick, _grdServicios_0.DblClick
		Dim Index As Integer = Array.IndexOf(grdServicios, eventSender)
		Dim VTRow As Integer = grdServicios(Index).Row
		grdServicios(Index).Row = 1
		grdServicios(Index).Col = 1
		If grdServicios(Index).CtlText <> "" Then
			grdServicios(Index).Row = VTRow
			Select Case Index
				Case 0, 1
					If Conversion.Val(Convert.ToString(grdServicios(Index).Tag)) > 0 Then
						cmdBoton(0).Enabled = True
						PMMarcarRegistro(Index)
					End If
			End Select
               PLTSEstado()
		End If
	End Sub

	Private Sub grdServicios_KeyUpEvent(ByVal eventSender As Object, ByVal eventArgs As COBISCorp.Framework.UI.Components.GridEvents_KeyUpEvent) Handles _grdServicios_1.KeyUpEvent, _grdServicios_0.KeyUpEvent
		Dim Index As Integer = Array.IndexOf(grdServicios, eventSender)
		Select Case Index
			Case 0, 1
				grdServicios(Index).Col = 0
				grdServicios(Index).SelStartCol = 1
				grdServicios(Index).SelEndCol = grdServicios(Index).Cols - 1
				If grdServicios(Index).Row = 0 Then
					grdServicios(Index).SelStartRow = 1
					grdServicios(Index).SelEndRow = 1
				Else
					grdServicios(Index).SelStartRow = grdServicios(Index).Row
					grdServicios(Index).SelEndRow = grdServicios(Index).Row
				End If
		End Select
	End Sub

	Private Sub mskCosto_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCosto.Enter
		If VLTipo_dato = "M" Then
			If VLMoneda = "S" Then
				mskCosto.Text = "#,##0.00"
			ElseIf VLMoneda = "N" Then 
				mskCosto.Text = "#,##0"
			End If
		Else
			mskCosto.Text = "##0.00"
		End If
		If cmbCosto.Text = "VALOR FIJO" Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1801))
		End If
		If cmbCosto.Text = "VALOR VARIABLE" Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1818))
		End If
		mskCosto.SelectionStart = 0
		mskCosto.SelectionLength = Strings.Len(mskCosto.Text)
	End Sub

	Private Sub mskCosto_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskCosto.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		If cmbCosto.Text <> "VALOR FIJO" Then
			If (Strings.Chr(KeyAscii).ToString()) <> "." And KeyAscii <> 8 And Strings.Chr(KeyAscii).ToString().ToUpper() <> "-" And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
				KeyAscii = 0
			End If
		Else
			If (Strings.Chr(KeyAscii).ToString()) <> "." And KeyAscii <> 8 And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
				KeyAscii = 0
			End If
		End If
		If VLTipo_dato = "P" Then
			If (Strings.Chr(KeyAscii).ToString()) <> "." And KeyAscii <> 8 And Strings.Chr(KeyAscii).ToString().ToUpper() <> "-" And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
				KeyAscii = 0
			End If
			If KeyAscii = 0 Then
				eventArgs.Handled = True
			End If
			Exit Sub
		End If
		If VLMoneda = "S" Then
			If (Strings.Chr(KeyAscii).ToString()) <> "." And KeyAscii <> 8 And Strings.Chr(KeyAscii).ToString().ToUpper() <> "-" And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
				KeyAscii = 0
			End If
		ElseIf VLMoneda = "N" Then 
			If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
				KeyAscii = 0
			End If
		End If
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub mskCosto_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCosto.Leave
		If mskCosto.Text <> "" Then
			Dim dbNumericTemp As Double = 0
			If Not Double.TryParse(mskCosto.Text, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp) Then
				mskCosto.Text = ""
				mskCosto.Focus()
				Exit Sub
			End If
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
	End Sub

	Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
		If cmbPerso.Text <> "" Then
			If cmbPerso.Text = "CTA CORRIENTE" Then
				mskCuenta.Mask = VGMascaraCtaCte
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1527))
			Else
				mskCuenta.Mask = VGMascaraCtaAho
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1528))
			End If
		End If
		mskCuenta.SelectionStart = 0
		mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
	End Sub

	Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        Dim VTR1 As Integer = 0
        Dim VTArreglo() As String
		Try 
			If cmbPerso.Text <> "CTA CORRIENTE" And cmbPerso.Text <> "CTA AHORROS" Then
                COBISMessageBox.Show(FMLoadResString(1289), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
				cmbPerso.Focus()
				Exit Sub
			End If
			If mskCuenta.ClipText <> "" Then
				If cmbPerso.Text = "CTA CORRIENTE" Then
					If FMChequeaCtaCte(mskCuenta.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4074")
						PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
						PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, mskCuenta.ClipText)
						PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "3")
						PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_valor_contratado", True, FMLoadResString(1590)) Then
                            ReDim VTArreglo(10)
                            VTR1 = FMMapeaArreglo(sqlconn, VTArreglo)
                            PMChequea(sqlconn)
                            If VTR1 <> 0 Then
                                lblDescripcion(0).Text = VTArreglo(1)
                            Else
                                COBISMessageBox.Show(FMLoadResString(1232), FMLoadResString(1473), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            End If
                        Else
                            PMChequea(sqlconn)
                            mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                            mskCuenta.Focus()
                        End If
					Else
                        COBISMessageBox.Show(FMLoadResString(1278), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
						lblDescripcion(0).Text = ""
						mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
						mskCuenta.Focus()
						VLPaso = True
						Exit Sub
					End If
				Else
					If FMChequeaCtaAho(mskCuenta.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4074")
						PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
						PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, mskCuenta.ClipText)
						PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
						PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_valor_contratado", True, FMLoadResString(1590)) Then
                            ReDim VTArreglo(10)
                            VTR1 = FMMapeaArreglo(sqlconn, VTArreglo)
                            PMChequea(sqlconn)
                            If VTR1 <> 0 Then
                                lblDescripcion(0).Text = VTArreglo(1)
                            Else
                                COBISMessageBox.Show(FMLoadResString(1232), FMLoadResString(1473), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            End If
                        Else
                            PMChequea(sqlconn)
                            mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                            mskCuenta.Focus()
                        End If
					Else
                        COBISMessageBox.Show(FMLoadResString(1279), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
						lblDescripcion(0).Text = ""
						mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
						mskCuenta.Focus()
						VLPaso = True
						Exit Sub
					End If
				End If
			End If
		Catch exc As System.Exception
			NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
		End Try
	End Sub

	Private Sub mskFecha_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFecha.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1367))
		mskFecha.SelectionStart = 0
		mskFecha.SelectionLength = Strings.Len(mskFecha.Text)
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
				mskFecha.Focus()
				Exit Sub
			End If
		End If
		If mskFecha.Text < StringsHelper.Format(VLFecha, VGFormatoFecha) Then
			If FMDateDiff("d", StringsHelper.Format(VLFecha, VGFormatoFecha), mskFecha.Text, VGFormatoFecha) < 0 Then
                COBISMessageBox.Show(FMLoadResString(1368), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
				mskFecha.Mask = ""
				mskFecha.Text = ""
				mskFecha.Mask = FMMascaraFecha(VGFormatoFecha)
				mskFecha.Focus()
				Exit Sub
			End If
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
	End Sub

	Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_4.Enter, _txtCampo_0.Enter, _txtCampo_2.Enter, _txtCampo_1.Enter
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 0
				VLPaso = True
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1165))
			Case 1
				VLPaso = True
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1155))
			Case 2
				VLPaso = True
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1159))
			Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1690))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1778))
        End Select
		txtCampo(Index).SelectionStart = 0
		txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
	End Sub

	Private isInitializingComponent As Boolean = false

	Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_4.TextChanged, _txtCampo_0.TextChanged, _txtCampo_2.TextChanged, _txtCampo_1.TextChanged
		If isInitializingComponent Then
			Exit Sub
		End If
		VLPaso = False
	End Sub

	Private Sub PMSubserv()
		If VGDetalle(0) = "S" Then
			If txtCampo(0).Text = "" Then
				lblDescripcion(1).Text = VGDetalle(1)
				lblDescripcion(2).Text = VGDetalle(2)
				txtCampo(0).Text = VGDetalle(3)
				lblDescripcion(3).Text = VGDetalle(4)
			Else
				lblDescripcion(1).Text = VGDetalle(1)
				lblDescripcion(2).Text = VGDetalle(2)
				lblDescripcion(3).Text = VGDetalle(3)
			End If
		End If
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_4.KeyDown, _txtCampo_0.KeyDown, _txtCampo_2.KeyDown, _txtCampo_1.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If KeyCode = VGTeclaAyuda Then
            Select Case Index
                Case 0
                    VGForma = "FPersoEspecial"
                    FAyudaSubserv2.ShowPopup(Me)
                    If VGDetalle(1) <> "" Then
                        PMSubserv()
                        VLPaso = True
                    End If
                    PMBuscarServicio()
                    FAyudaSubserv2.Dispose() '18/05/2016 migracion
                Case 1
                    VGOperacion = "sp_oficina"
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(1109) & "[" & txtCampo(0).Text & "]") Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(1).Text = VGACatalogo.Codigo
                        lblDescripcion(0).Text = VGACatalogo.Descripcion
                        FCatalogo.Dispose() '18/05/2016 migracion
                    Else
                        PMChequea(sqlconn)
                    End If
                    VLPaso = True
                Case 2
                    FBuscarCliente.optCliente(0).Checked = True
                    FBuscarCliente.ShowPopup(Me)
                    FBuscarCliente.optCliente(1).Enabled = True
                    If VGBusqueda(1) <> "" Then
                        txtCampo(2).Text = VGBusqueda(1)
                        lblDescripcion(0).Text = VGBusqueda(2) & " " & VGBusqueda(3) & " " & VGBusqueda(4)
                    End If
                    FBuscarCliente.Dispose() '18/05/2016 migracion
                    VLPaso = True
                Case 3
                    PMCatalogo("A", "pe_rubro", txtCampo(2), lblDescripcion(2), FRegistros)
                    VLPaso = True
                Case 4
                    PMCatalogo("A", "pe_tipo_dato", txtCampo(4), lblDescripcion(4), FRegistros)
                    VLPaso = True
            End Select
        End If
    End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_4.KeyPress, _txtCampo_0.KeyPress, _txtCampo_2.KeyPress, _txtCampo_1.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		If Index <> 4 Then
			If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
				KeyAscii = 0
			End If
		Else
			If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 96) Or (KeyAscii > 123)) Then
				KeyAscii = 0
			Else
				KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
			End If
		End If
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_4.Leave, _txtCampo_0.Leave, _txtCampo_2.Leave, _txtCampo_1.Leave
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		If Not VLPaso Then
			Select Case Index
				Case 0
					If Not VLPaso Then
						If txtCampo(0).Text <> "" Then
							VGForma = "FPersoEspecial"
							FAyudaSubserv2.ShowPopup(Me)
							If VGDetalle(1) <> "" Then
								PMSubserv()
							Else
								If lblDescripcion(2).Text = "" Then
									txtCampo(0).Text = ""
									txtCampo(0).Focus()
									VLPaso = True
								End If
							End If
							FAyudaSubserv2.Dispose() '18/05/2016 migracion
						Else
							VLPaso = True
							lblDescripcion(1).Text = ""
							lblDescripcion(2).Text = ""
							lblDescripcion(3).Text = ""
						End If
					End If
					PMBuscarServicio()
				Case 1
					If txtCampo(1).Text <> "" Then
						PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
						PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
						PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txtCampo(1).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(1109) & "[" & txtCampo(0).Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(0))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            VLPaso = True
                            txtCampo(1).Text = ""
                            lblDescripcion(0).Text = ""
                            txtCampo(1).Focus()
                        End If
					Else
						lblDescripcion(0).Text = ""
					End If
				Case 2
					If txtCampo(2).Text <> "" Then
						Dim VTArreglo(7) As String
						PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1190")
						PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, txtCampo(2).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_qrente", False, FMLoadResString(1598)) Then
                            FMMapeaArreglo(sqlconn, VTArreglo)
                            PMChequea(sqlconn)
                            lblDescripcion(0).Text = VTArreglo(1)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(2).Text = ""
                            lblDescripcion(0).Text = ""
                        End If
					End If
				Case 4
					If Not VLPaso Then
						If txtCampo(4).Text <> "" Then
                            PMCatalogo("V", "pe_tipo_dato", txtCampo(4), lblDescripcion(4), Nothing)
						Else
							txtCampo(4).Text = ""
							lblDescripcion(4).Text = ""
						End If
					End If
            End Select
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
		End If
	End Sub

	Sub PMBuscarServicio()
		PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4086")
		PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, txtCampo(0).Text)
		PMPasoValores(sqlconn, "@i_rubro", 0, SQLCHAR, lblDescripcion(3).Text)
		PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_costos_especiales", True, FMLoadResString(1552)) Then
            PMMapeaGrid(sqlconn, grdServicios(0), False)
            PMMapeaTextoGrid(grdServicios(0))
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
		grdServicios(0).Row = 1
		grdServicios(0).ColWidth(1) = 1300
		grdServicios(0).ColWidth(6) = 1500
		grdServicios(0).ColWidth(4) = 1500
		grdServicios(0).ColWidth(5) = 1500
		For i As Integer = 10 To 12
			grdServicios(0).ColWidth(CShort(i)) = 1
		Next i
	End Sub


    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_3.Enabled
        TSBBuscar.Visible = _cmdBoton_3.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

    Private Sub optBoton_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _OptAplic_1.Enter, _OptAplic_0.Enter
        Dim Index As Integer = Array.IndexOf(OptAplic, eventSender)
        Select Case Index
            Case 0, 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1877))
        End Select
    End Sub

    Private Sub _OptAplic_0_Leave(sender As Object, e As EventArgs) Handles _OptAplic_1.Enter, _OptAplic_0.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
End Class


