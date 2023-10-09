Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Text
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Imports COBISCorp.tCOBIS.CTA.Ahos.Query
Imports COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses
Imports System.IO

Partial Public Class FTran201Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim FDatoCliente As COBISCorp.tCOBIS.BClientes.BuscarClientes
    Dim FBuscarCliente As COBISCorp.tCOBIS.BClientes.FBuscarClienteClass
    Dim VLCuentaAct As String = ""
    Dim VLNumero As Integer = 0
    Dim VLTitular As Integer = 0
    Dim VLPaso As Integer = 0
    Dim VLImprimio As Integer = 0
    Dim VLEnte As Integer = 0
    Dim VLCedula1 As String = ""
    Dim VLCotitular As String = ""
    Dim VLCodTitular As Integer = 0
    Dim VLTipoEnteTitular As String = ""
    Dim VLyaingreso As Integer = 0
    Dim VLCuenta0 As String = ""
    Dim VLTutor As Boolean = False
    Dim VTMatrizprop(,) As String
    Dim VLContadorprop As Integer = 0
    Dim VLTipoDireccion(2, 2) As String
    Dim VLProdProgresivo As String = ""
    Dim Roles(,) As String
    Dim VLNumDoc As String = ""
    Dim VLTitularidad As String = ""
    Dim VLTipoTran As String = ""
    Dim VLProdBancBloq As String = ""
    Dim VTCliente As String = ""
    Dim VLMensajeBlq As String = ""
    Public VLSolicitud As String = ""
    Dim VLHabilitaClientesEsp As String = "S"

    Private Sub PLReporteApertura()
        Dim archivo As String = ""
        Dim archivo_logo As String = ""
        Dim VTR5 As Integer = 0
        Dim reporte As String = ""
        Dim VTFechaAux As DateTime
        Try
            Dim BaseDatos As DAO.Database
            Dim VTTelefonoCli(,) As String
            Dim Tabla1, tabla2, tabla4, tabla5 As DAO.Recordset
            Dim VTArray() As String

            archivo = VGPath & "\APERTURA.MDB"
            archivo_logo = VGPath & "logo.mdb"
            BaseDatos = DAO_DBEngine_definst.OpenDatabase(archivo)
            Tabla1 = BaseDatos.OpenRecordset("cuenta")
            tabla2 = BaseDatos.OpenRecordset("propietarios")
            tabla4 = BaseDatos.OpenRecordset("referencias")
            tabla5 = BaseDatos.OpenRecordset("datosadic")
            BaseDatos.Execute("delete from cuenta")
            BaseDatos.Execute("delete from propietarios")
            BaseDatos.Execute("delete from referencias")
            BaseDatos.Execute("delete from datosadic")
            Tabla1.AddNew()
            Tabla1.Fields("oficina").Value = VGOficina
            Tabla1.Fields("fecha").Value = DateTime.Today.ToString("MM-dd-yyyy")
            Tabla1.Fields("deposito").Value = StringsHelper.Format(Mskvalor.Text, "#,##0.00")
            Tabla1.Fields("numero").Value = StringsHelper.Format(lblDescripcion(0).Text, VGMascaraCtaCte)
            'Tabla1.Fields("moneda").Value = Strings.Left(FPrincipal.cmbMoneda.Text, 30)
            Tabla1.Fields("nombre").Value = Strings.Left(txtCampo(2).Text, 64)
            Tabla1.Fields("producto").Value = Strings.Left(lblDescripcion(11).Text, 30)
            Tabla1.Fields("origen").Value = Strings.Left(lblDescripcion(12).Text, 30)
            Tabla1.Fields("oficial").Value = Strings.Left(lblDescripcion(7).Text, 30)
            Tabla1.Fields("promedio").Value = Strings.Left(lblDescripcion(8).Text, 30)
            Tabla1.Fields("categoria").Value = Strings.Left(lblDescripcion(10).Text, 30)
            Tabla1.Fields("ciclo").Value = Strings.Left(lblDescripcion(9).Text, 30)
            Tabla1.Fields("fecha_corte").Value = Strings.Left(lblDescripcion(1).Text, 30)
            If cmbenvioec.Text = "S" Then
                If VLTipoDireccion(0, 0) = "D" Then
                    Tabla1.Fields("direccion").Value = Strings.Left(lblDescripcion(15).Text, 30)
                Else
                    Tabla1.Fields("agencia_ec").Value = Strings.Left(lblDescripcion(6).Text, 30)
                End If
            End If
            Tabla1.Fields("tipo").Value = "Ahorro"
            Tabla1.Fields("firma").Value = Strings.Left(lblDescripcion(20).Text, 30)
            If VGCodPais = "PA" Then Tabla1.Fields("patente").Value = txtCampo(12).Text
            If VGCodPais = "PA" Then Tabla1.Fields("fideicomiso").Value = txtCampo(15).Text
            ReDim VTMatrizprop(grdPropietarios.Cols - 1, 0)
            VLContadorprop = -1
            ReDim Roles(50, 1)
            PLProcesarPropietarios("T", 1)
            PLProcesarPropietarios("C", 1)
            PLProcesarPropietarios("F", 1)
            PLProcesarPropietarios("OTROS", 0)
            For i As Integer = 1 To grdPropietarios.Rows - 1
                For j As Integer = 1 To grdPropietarios.Cols - 1
                    grdPropietarios.Row = i
                    grdPropietarios.Col = j
                    grdPropietarios.CtlText = VTMatrizprop(j - 1, i - 1)
                Next j
            Next i
            grdPropietarios.Row = 1
            grdPropietarios.Col = 1
            Dim VTclientepro As String = ""
            VTclientepro = grdPropietarios.CtlText
            Tabla1.Fields("solicitu").Value = VTclientepro
            Tabla1.Fields("secuencial").Value = 1
            If VLTipoDireccion(0, 0) = "C" And txtCampo(3).Text <> "" Then
                VTArray = lblDescripcion(6).Text.Trim().Split("|"c)
                If VTArray.GetLowerBound(0) >= 0 Then
                    For i As Integer = VTArray.GetLowerBound(0) To VTArray.GetUpperBound(0)
                        Select Case i
                            Case 0
                                Tabla1.Fields("di_codpostal").Value = VTArray(0).Trim()
                            Case 1
                                Tabla1.Fields("di_ciudad").Value = VTArray(2).Trim()
                            Case 2
                                Tabla1.Fields("di_zona").Value = VTArray(1).Trim()
                            Case 3
                                Tabla1.Fields("di_pais").Value = VTArray(3).Trim()
                        End Select
                    Next i
                End If
            End If
            Dim VLSecuencial As Integer = 0
            VLSecuencial = 1
            Dim VTTitular As String = String.Empty
            Dim VLCondicion As String = String.Empty
            Dim VTR1 As Integer = 0
            Dim VTR3 As Integer = 0
            Dim VTR4 As Integer = 0

            Dim tiempoemp As Integer = 0
            Dim VTSec As Integer = 0
            Dim Index As Integer = 0
            Dim VTTelef As String = String.Empty
            Dim VTCelular As String = String.Empty
            Dim VTFax As String = String.Empty
            Dim VTTelex As String = String.Empty
            Dim VTR2 As Integer = 0
            For k As Integer = 1 To grdPropietarios.Rows - 1
                grdPropietarios.Col = 1
                grdPropietarios.Row = k
                VLCodTitular = CInt(grdPropietarios.CtlText)
                grdPropietarios.Col = 5
                VTTitular = grdPropietarios.CtlText
                grdPropietarios.Col = 6
                VLCondicion = grdPropietarios.CtlText
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "R")
                PMPasoValores(sqlconn, "@i_cliente", 0, SQLINT4, CStr(VLCodTitular))
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2543")
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_desc_cliente_cc", True, " Ok... Consulta del cliente " & "[" & txtCampo(0).Text & "]") Then
                    Dim VTDatosCli(40) As String
                    VTR1 = FMMapeaArreglo(sqlconn, VTDatosCli)
                    Dim VTRefCom(10, 100) As String
                    VTR3 = FMMapeaMatriz(sqlconn, VTRefCom)
                    Dim VTRefBan(4) As String
                    FMMapeaArreglo(sqlconn, VTRefBan)
                    Dim VTRefPerso(10, 100) As String
                    VTR5 = FMMapeaMatriz(sqlconn, VTRefPerso)
                    PMChequea(sqlconn)
                    tabla2.AddNew()
                    tabla2.Fields("cliente").Value = VLCodTitular
                    tabla2.Fields("secuencial").Value = VLSecuencial
                    tabla2.Fields("numero").Value = lblDescripcion(0).Text
                    tabla2.Fields("firma").Value = Strings.Left(lblDescripcion(20).Text, 30)
                    tabla2.Fields("condicion").Value = VLCondicion
                    tabla2.Fields("titular").Value = VTTitular
                    VLSecuencial += 1
                    If VTDatosCli(7) = "P" Then
                        tabla2.Fields("cedula").Value = Strings.Left(VTDatosCli(1), 30)
                        tabla2.Fields("nombre").Value = VTDatosCli(37).Trim()
                        If VTDatosCli(2) = "" Then
                            tabla2.Fields("primer_nombre").Value = " "
                        Else
                            tabla2.Fields("primer_nombre").Value = Strings.Left(VTDatosCli(2), 30)
                        End If
                        If VTDatosCli(3) = "" Then
                            tabla2.Fields("segundo_nombre").Value = " "
                        Else
                            tabla2.Fields("segundo_nombre").Value = Strings.Left(VTDatosCli(3), 30)
                        End If
                        If VTDatosCli(4) = "" Then
                            tabla2.Fields("primer_apellido").Value = " "
                        Else
                            tabla2.Fields("primer_apellido").Value = Strings.Left(VTDatosCli(4), 30)
                        End If
                        If VTDatosCli(5) = "" Then
                            tabla2.Fields("segundo_apellido").Value = " "
                        Else
                            tabla2.Fields("segundo_apellido").Value = Strings.Left(VTDatosCli(5), 30)
                        End If
                        tabla2.Fields("apellido_casada").Value = Strings.Left(VTDatosCli(6), 30)
                        tabla2.Fields("tipo_cliente").Value = Strings.Left(VTDatosCli(7), 30)
                        tabla2.Fields("pais").Value = Strings.Left(VTDatosCli(9), 30)
                        tabla2.Fields("sexo").Value = Strings.Left(VTDatosCli(10), 30)
                        tabla2.Fields("estado_civil").Value = Strings.Left(VTDatosCli(11), 30)
                        tabla2.Fields("nit").Value = Strings.Left(VTDatosCli(12), 30)
                        If VTDatosCli(13) <> "" Then
                            tabla2.Fields("fecha_nacimiento").Value = Strings.Left(VTDatosCli(13), 30)
                        End If
                        tabla2.Fields("num_hijos").Value = Conversion.Val(VTDatosCli(14))
                        tabla2.Fields("num_cargas").Value = Conversion.Val(VTDatosCli(15))
                        tabla2.Fields("desc_ciudad_nac").Value = Strings.Left(VTDatosCli(16), 30)
                        tabla2.Fields("desc_lugar_doc").Value = Strings.Left(VTDatosCli(17), 30)
                        tabla2.Fields("desc_dep_doc").Value = Strings.Left(VTDatosCli(18), 30)
                        tabla2.Fields("desc_profesion").Value = Strings.Left(VTDatosCli(19), 30)
                        tabla2.Fields("emp_cargo").Value = VTDatosCli(20)
                        tabla2.Fields("empresa").Value = Strings.Left(VTDatosCli(21), 64)
                        tabla2.Fields("razon_social").Value = Strings.Left(VTDatosCli(22), 30)
                        tabla2.Fields("emp_telefono").Value = Strings.Left(VTDatosCli(23), 30)
                        tabla2.Fields("desc_dep_nac").Value = VTDatosCli(24)
                        tabla2.Fields("desc_pais_nac").Value = VTDatosCli(25)
                        If VTDatosCli(26) <> "" And VTDatosCli(27) <> "" Then
                            tabla2.Fields("emp_tiempo").Value = DateAndTime.DateDiff("yyyy", CDate(VTDatosCli(26)), CDate(VTDatosCli(27)), FirstDayOfWeek.Sunday, FirstWeekOfYear.Jan1)
                        ElseIf VTDatosCli(26) <> "" And VTDatosCli(27) = "" Then
                            tabla2.Fields("emp_tiempo").Value = DateAndTime.DateDiff("yyyy", CDate(VTDatosCli(26)), DateTime.Now, FirstDayOfWeek.Sunday, FirstWeekOfYear.Jan1)
                        End If
                        Dim TempDate As Date = DateTime.Now
                        tabla2.Fields("rl_fecha_ing").Value = IIf(DateTime.TryParse(VTDatosCli(26), TempDate), TempDate.ToString("dd/MM/yyyy"), VTDatosCli(26))
                        tabla2.Fields("nacionalidad").Value = VTDatosCli(28)
                        tabla2.Fields("tipo_vivienda").Value = VTDatosCli(29)
                        tabla2.Fields("tipo_ced").Value = VTDatosCli(30)
                        tabla2.Fields("emp_ingresos").Value = VTDatosCli(31)
                        tabla2.Fields("emp_act_economica").Value = VTDatosCli(32)
                        tabla2.Fields("emp_desc_actividad").Value = Strings.Mid(VTDatosCli(33), 1, 50)
                        tabla2.Fields("emp_direccion").Value = VTDatosCli(34)
                        tabla2.Fields("email").Value = VTDatosCli(35)
                        tabla2.Fields("digito").Value = VTDatosCli(36)
                        reporte = VGPath & "\APCTACTE1.RPT"
                    Else
                        tabla2.Fields("pais").Value = Strings.Left(VTDatosCli(5), 30)
                        tabla2.Fields("razon_social").Value = VTDatosCli(3)
                        tabla2.Fields("nombre").Value = VTDatosCli(1)
                        tabla2.Fields("emp_act_economica").Value = VTDatosCli(2)
                        tabla2.Fields("rep_legal").Value = VTDatosCli(4)
                        tabla2.Fields("rl_telefono").Value = VTDatosCli(8)
                        tabla2.Fields("rl_fax").Value = VTDatosCli(9)
                        tabla2.Fields("rl_email").Value = VTDatosCli(11)
                        tabla2.Fields("emp_cargo").Value = VTDatosCli(10)
                        tabla2.Fields("rl_fecha_ing").Value = VTDatosCli(12)
                        tabla2.Fields("cedula").Value = VTDatosCli(21)
                        tabla2.Fields("tipo_ced").Value = VTDatosCli(22)
                        tabla2.Fields("digito").Value = VTDatosCli(23)
                        tabla2.Fields("num_patenteC").Value = VTDatosCli(14)
                        tabla2.Fields("num_RegM").Value = VTDatosCli(15)
                        tabla2.Fields("num_folioRegM").Value = VTDatosCli(16)
                        tabla2.Fields("num_libroRegM").Value = VTDatosCli(17)
                        If VTDatosCli(18) <> "" Then
                            tiempoemp = VTDatosCli(18).Length
                            If tiempoemp > 2 Then
                                VTDatosCli(18) = Strings.Mid(VTDatosCli(18), 1, 2)
                                tabla2.Fields("emp_tiempo").Value = VTDatosCli(18)
                            End If
                        End If
                        tabla2.Fields("fecha_constitucion").Value = VTDatosCli(19)
                        tabla2.Fields("objeto_social").Value = VTDatosCli(20)
                        tabla2.Fields("nit").Value = VTDatosCli(21)
                        reporte = VGPath & "\APCTACTE1.RPT"
                    End If
                    tabla2.Fields("refcom1").Value = Strings.Left(VTRefCom(0, 1), 64)
                    tabla2.Fields("di_refcom1").Value = Strings.Left(VTRefCom(1, 1), 64)
                    tabla2.Fields("tel_refcom1").Value = Strings.Left(VTRefCom(2, 1), 16)
                    tabla2.Fields("refcom2").Value = Strings.Left(VTRefCom(0, 2), 64)
                    tabla2.Fields("di_refcom2").Value = Strings.Left(VTRefCom(1, 2), 64)
                    tabla2.Fields("tel_refcom2").Value = Strings.Left(VTRefCom(2, 2), 16)
                    tabla2.Fields("refcom3").Value = Strings.Left(VTRefCom(0, 3), 64)
                    tabla2.Fields("di_refcom3").Value = Strings.Left(VTRefCom(1, 3), 64)
                    tabla2.Fields("tel_refcom3").Value = Strings.Left(VTRefCom(2, 3), 16)
                    tabla2.Fields("refban1").Value = Strings.Left(VTRefBan(1), 64)
                    tabla2.Fields("refban2").Value = Strings.Left(VTRefBan(2), 64)
                    tabla2.Fields("refban3").Value = Strings.Left(VTRefBan(3), 64)
                    VTSec = 1
                    For n As Integer = 1 To VTR3
                        If Strings.Left(VTRefCom(0, n), 50) <> "" Then
                            tabla4.AddNew()
                            tabla4.Fields("numero").Value = lblDescripcion(0).Text
                            tabla4.Fields("entidad").Value = Strings.Left(VTRefCom(0, n), 50)
                            tabla4.Fields("anios").Value = VTRefCom(1, n)
                            tabla4.Fields("contacto").Value = Strings.Left(VTRefCom(2, n), 50)
                            tabla4.Fields("tipo_cta").Value = Strings.Left(VTRefCom(3, n), 30)
                            tabla4.Fields("telefono").Value = Strings.Left(VTRefCom(4, n), 38)
                            tabla4.Fields("secuencial").Value = VTSec
                            tabla4.Fields("sec_beneficiario").Value = tabla2.Fields("secuencial").Value
                            VTSec += 1
                            tabla4.Fields("filial").Value = Conversion.Val(VGLOGO)
                            tabla4.Update()
                        End If
                    Next n
                    For n As Integer = 1 To VTR5
                        tabla4.AddNew()
                        tabla4.Fields("numero").Value = lblDescripcion(0).Text
                        tabla4.Fields("entidad").Value = Strings.Left(VTRefPerso(0, n), 50)
                        tabla4.Fields("anios").Value = VTRefPerso(1, n)
                        tabla4.Fields("contacto").Value = Strings.Left(VTRefPerso(2, n), 50)
                        tabla4.Fields("tipo_cta").Value = Strings.Left(VTRefPerso(3, n), 30)
                        tabla4.Fields("telefono").Value = Strings.Left(VTRefPerso(4, n), 38)
                        tabla4.Fields("secuencial").Value = VTSec
                        tabla4.Fields("sec_beneficiario").Value = tabla2.Fields("secuencial").Value
                        VTSec += 1
                        tabla4.Fields("filial").Value = Conversion.Val(VGLOGO)
                        tabla4.Update()
                    Next n
                    If VTR3 = 0 And VTR5 = 0 Then
                        tabla4.AddNew()
                        tabla4.Fields("numero").Value = lblDescripcion(0).Text
                        tabla4.Fields("sec_beneficiario").Value = tabla2.Fields("secuencial").Value
                        tabla4.Fields("secuencial").Value = VTSec
                        tabla4.Update()
                    End If
                Else
                    Tabla1.Close()
                    tabla2.Close()
                    tabla4.Close()
                    BaseDatos.Close()
                    PMChequea(sqlconn)
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, CStr(VLCodTitular))
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1227")
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_direccion_cons", True, FMLoadResString(2600) & " [" & txtCampo(Index).Text & "]") Then
                    Dim VTDireccionCli(25, 10) As String
                    VTR1 = FMMapeaMatriz(sqlconn, VTDireccionCli)
                    PMChequea(sqlconn)
                    For i As Integer = 1 To VTR1
                        If VTDireccionCli(11, i) = "S" Then
                            tabla2.Fields("direccion_ente").Value = Strings.Left((VTDireccionCli(15, i).Trim() & " " & VTDireccionCli(16, i).Trim() & " " & VTDireccionCli(17, i).Trim() & " " & VTDireccionCli(18, i).Trim()).Trim(), 255)
                            tabla2.Fields("di_ciudad").Value = Strings.Left(VTDireccionCli(5, i), 30)
                            tabla2.Fields("di_provincia").Value = Strings.Left(VTDireccionCli(3, i), 30)
                            tabla2.Fields("di_codpostal").Value = Strings.Left(VTDireccionCli(8, i), 30)
                            VTTelef = ""
                            VTCelular = ""
                            VTFax = ""
                            VTTelex = ""
                            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                            PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, CStr(VLCodTitular))
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1345")
                            PMPasoValores(sqlconn, "@i_direccion", 0, SQLINT4, VTDireccionCli(0, i))
                            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_direccion_cons", True, FMLoadResString(2600) & " [" & txtCampo(Index).Text & "]") Then
                                ReDim VTTelefonoCli(4, 10)
                                VTR2 = FMMapeaMatriz(sqlconn, VTTelefonoCli)
                                PMChequea(sqlconn)
                                For j As Integer = 1 To VTR2
                                    If VTTelefonoCli(2, j) = "RE" Then
                                        VTTelef = VTTelefonoCli(1, j)
                                    End If
                                    If VTTelefonoCli(2, j) = "CE" Then
                                        VTCelular = VTTelefonoCli(1, j)
                                    End If
                                    If VTTelefonoCli(2, j) = "FA" Then
                                        VTFax = VTTelefonoCli(1, j)
                                    End If
                                    If VTTelefonoCli(2, j) = "OT" Then
                                        VTTelex = VTTelefonoCli(1, j)
                                    End If
                                Next j
                            Else
                                PMChequea(sqlconn)
                            End If
                            tabla2.Fields("telefono").Value = VTTelef
                            tabla2.Fields("num_fax").Value = VTFax
                            tabla2.Fields("celular").Value = VTCelular
                            tabla2.Fields("telex").Value = VTTelex
                        End If
                        VTTelef = ""
                        VTFax = ""
                        If VLTipoDireccion(0, 0) = "C" And Conversion.Val(VTDireccionCli(0, i)) = Conversion.Val(txtCampo(3).Text) And txtCampo(3).Text <> "" Then
                            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                            PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, CStr(VLCodTitular))
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1345")
                            PMPasoValores(sqlconn, "@i_direccion", 0, SQLINT4, txtCampo(3).Text)
                            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_direccion_cons", True, FMLoadResString(2600) & " [" & txtCampo(3).Text & "]") Then
                                ReDim VTTelefonoCli(4, 10)
                                VTR2 = FMMapeaMatriz(sqlconn, VTTelefonoCli)
                                PMChequea(sqlconn)
                                For j As Integer = 1 To VTR2
                                    If VTTelefonoCli(2, j) = "RE" Then
                                        VTTelef = VTTelefonoCli(1, j)
                                    Else
                                        VTFax = VTTelefonoCli(1, j)
                                    End If
                                Next j
                            Else
                                PMChequea(sqlconn)
                            End If
                            Tabla1.Fields("di_telefono").Value = Strings.Left(VTTelef, 16)
                            Tabla1.Fields("di_fax").Value = Strings.Left(VTFax, 16)
                        End If
                        If VTDireccionCli(9, i) = "E-MAIL" Then
                            tabla2.Fields("email").Value = VTDireccionCli(1, i)
                        End If
                    Next i
                Else
                    PMChequea(sqlconn)
                End If
                tabla2.Fields("filial").Value = Conversion.Val(VGLOGO)
                tabla2.Update()
            Next k
            REM If VGCodPais = "PA" Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "348")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, VLCuenta0)
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, CInt(VGMoneda))
            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
            Dim VTArreglo(30) As String
            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_datos_adic_aho", True, FMLoadResString(2601) & " [" & lblDescripcion(0).Text & "]") Then
                VTR1 = FMMapeaArreglo(sqlconn, VTArreglo)
                PMChequea(sqlconn)
                If VTR1 > 0 Then
                    tabla5.AddNew()
                    tabla5.Fields("numero").Value = lblDescripcion(0).Text
                    tabla5.Fields("dep_inicial").Value = VTArreglo(2)
                    tabla5.Fields("forma_dep_inicial").Value = VTArreglo(3)
                    tabla5.Fields("proposito_cuenta").Value = VTArreglo(4)
                    tabla5.Fields("origen_fondos").Value = VTArreglo(5)
                    tabla5.Fields("prod_cobis1").Value = VTArreglo(6)
                    tabla5.Fields("prod_cobis2").Value = VTArreglo(7)
                    tabla5.Fields("monto_ext").Value = VTArreglo(8)
                    tabla5.Fields("trx_ext").Value = Conversion.Val(VTArreglo(9))
                    tabla5.Fields("frecuencia_ext").Value = VTArreglo(10)
                    tabla5.Fields("monto_efec").Value = VTArreglo(11)
                    tabla5.Fields("trx_efec").Value = Conversion.Val(VTArreglo(12))
                    tabla5.Fields("frecuencia_efec").Value = VTArreglo(13)
                    tabla5.Fields("monto_refec").Value = VTArreglo(14)
                    tabla5.Fields("trx_refec").Value = Conversion.Val(VTArreglo(15))
                    tabla5.Fields("frecuencia_refec").Value = VTArreglo(16)
                    tabla5.Fields("monto_giro").Value = VTArreglo(17)
                    tabla5.Fields("trx_giro").Value = Conversion.Val(VTArreglo(18))
                    tabla5.Fields("frecuencia_giro").Value = VTArreglo(19)
                    tabla5.Fields("monto_gerencia").Value = VTArreglo(20)
                    tabla5.Fields("trx_gerencia").Value = Conversion.Val(VTArreglo(21))
                    tabla5.Fields("frecuencia_gerencia").Value = VTArreglo(22)
                    tabla5.Fields("monto_transfer").Value = VTArreglo(23)
                    tabla5.Fields("trx_transfer").Value = Conversion.Val(VTArreglo(24))
                    tabla5.Fields("frecuencia_transfer").Value = VTArreglo(25)
                    tabla5.Fields("monto_recib").Value = VTArreglo(26)
                    tabla5.Fields("trx_recib").Value = Conversion.Val(VTArreglo(27))
                    tabla5.Fields("frecuencia_recib").Value = VTArreglo(28)
                    tabla5.Fields("filial").Value = Conversion.Val(VGLOGO)
                    tabla5.Fields("aporte_social").Value = VTArreglo(29)

                    Dim VTEntero As Long
                    Dim VTFraccion As Decimal
                    Dim VTValor As Decimal
                    Dim VTPartedecimal As Integer
                    Dim VTValorEnLetras As String

                    VTValorEnLetras = ""
                    If IsNumeric(VTArreglo(29)) Then
                        VTValor = CDbl(VTArreglo(29))
                        VTEntero = Fix(VTValor)
                        VTFraccion = VTValor - VTEntero
                        VTPartedecimal = VTFraccion * 100
                        VTValorEnLetras = UCase(Num2Text(VTEntero)) & " CON " & IIf(VTPartedecimal < 10, "0", "") & CStr(VTPartedecimal) & "/100"
                    End If
                    tabla5.Fields("valorletra").Value = VTValorEnLetras

                    tabla5.Update()
                End If
            Else
                PMChequea(sqlconn)
            End If
            REM End If
            Tabla1.Fields("filial").Value = Conversion.Val(VGLOGO)

            REM ===================
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "538")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
            PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, VLCuenta0)
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, CInt(VGMoneda))
            Dim VTArreglo2(130) As String
            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_cons_datos_cuenta", True, FMLoadResString(2601) & " [" & lblDescripcion(0).Text & "]") Then
                VTR1 = FMMapeaArreglo(sqlconn, VTArreglo2)
                PMChequea(sqlconn)
                If VTR1 > 0 Then
                    Tabla1.Fields("ah_cuenta").Value = VTArreglo2(1)
                    Tabla1.Fields("ah_cta_banco").Value = VTArreglo2(2)
                    Tabla1.Fields("ah_estado").Value = VTArreglo2(3)
                    Tabla1.Fields("ah_control").Value = VTArreglo2(4)
                    Tabla1.Fields("ah_filial").Value = VTArreglo2(5)
                    Tabla1.Fields("ah_producto").Value = VTArreglo2(7)
                    Tabla1.Fields("ah_tipo").Value = VTArreglo2(8)
                    Tabla1.Fields("ah_moneda").Value = VTArreglo2(9)
                    VTFechaAux = DateSerial(CInt(Mid(VTArreglo2(10), 7, 4)), CInt(Mid(VTArreglo2(10), 1, 2)), CInt(Mid(VTArreglo2(10), 4, 2)))
                    Tabla1.Fields("ah_fecha_aper").Value = VTFechaAux
                    Tabla1.Fields("ah_oficial").Value = VTArreglo2(11)
                    Tabla1.Fields("ah_cliente").Value = VTArreglo2(12)
                    Tabla1.Fields("ah_ced_ruc").Value = VTArreglo2(13)
                    Tabla1.Fields("ah_nombre").Value = VTArreglo2(14)
                    Tabla1.Fields("ah_categoria").Value = VTArreglo2(15)
                    Tabla1.Fields("ah_tipo_promedio").Value = VTArreglo2(16)
                    Tabla1.Fields("ah_capitalizacion").Value = VTArreglo2(17)
                    Tabla1.Fields("ah_ciclo").Value = VTArreglo2(18)
                    Tabla1.Fields("ah_suspensos").Value = VTArreglo2(19)
                    Tabla1.Fields("ah_bloqueos").Value = VTArreglo2(20)
                    Tabla1.Fields("ah_condiciones").Value = VTArreglo2(21)
                    Tabla1.Fields("ah_monto_bloq").Value = VTArreglo2(22)
                    Tabla1.Fields("ah_num_blqmonto").Value = VTArreglo2(23)
                    Tabla1.Fields("ah_cred_24").Value = VTArreglo2(24)
                    Tabla1.Fields("ah_cred_rem").Value = VTArreglo2(25)
                    Tabla1.Fields("ah_tipo_def").Value = VTArreglo2(26)
                    Tabla1.Fields("ah_default").Value = VTArreglo2(27)
                    Tabla1.Fields("ah_rol_ente").Value = VTArreglo2(28)
                    Tabla1.Fields("ah_disponible").Value = VTArreglo2(29)
                    Tabla1.Fields("ah_12h").Value = VTArreglo2(30)
                    Tabla1.Fields("ah_12h_dif").Value = VTArreglo2(31)

                    Tabla1.Fields("ah_24h").Value = VTArreglo2(32)
                    Tabla1.Fields("ah_48h").Value = VTArreglo2(33)
                    Tabla1.Fields("ah_remesas").Value = VTArreglo2(34)
                    Tabla1.Fields("ah_rem_hoy").Value = VTArreglo2(35)
                    Tabla1.Fields("ah_interes").Value = VTArreglo2(36)
                    Tabla1.Fields("ah_interes_ganado").Value = VTArreglo2(37)
                    Tabla1.Fields("ah_saldo_libreta").Value = VTArreglo2(38)
                    Tabla1.Fields("ah_saldo_interes").Value = VTArreglo2(39)
                    Tabla1.Fields("ah_saldo_anterior").Value = VTArreglo2(40)
                    Tabla1.Fields("ah_saldo_ult_corte").Value = VTArreglo2(41)
                    Tabla1.Fields("ah_saldo_ayer").Value = VTArreglo2(42)
                    Tabla1.Fields("ah_creditos").Value = VTArreglo2(43)
                    Tabla1.Fields("ah_debitos").Value = VTArreglo2(44)
                    Tabla1.Fields("ah_creditos_hoy").Value = VTArreglo2(45)
                    Tabla1.Fields("ah_debitos_hoy").Value = VTArreglo2(46)
                    VTFechaAux = DateSerial(CInt(Mid(VTArreglo2(47), 7, 4)), CInt(Mid(VTArreglo2(47), 1, 2)), CInt(Mid(VTArreglo2(47), 4, 2)))
                    Tabla1.Fields("ah_fecha_ult_mov").Value = VTFechaAux
                    VTFechaAux = DateSerial(CInt(Mid(VTArreglo2(48), 7, 4)), CInt(Mid(VTArreglo2(48), 1, 2)), CInt(Mid(VTArreglo2(48), 4, 2)))
                    Tabla1.Fields("ah_fecha_ult_mov_int").Value = VTFechaAux
                    VTFechaAux = DateSerial(CInt(Mid(VTArreglo2(49), 7, 4)), CInt(Mid(VTArreglo2(49), 1, 2)), CInt(Mid(VTArreglo2(49), 4, 2)))
                    Tabla1.Fields("ah_fecha_ult_upd").Value = VTFechaAux
                    VTFechaAux = DateSerial(CInt(Mid(VTArreglo2(50), 7, 4)), CInt(Mid(VTArreglo2(50), 1, 2)), CInt(Mid(VTArreglo2(50), 4, 2)))
                    Tabla1.Fields("ah_fecha_prx_corte").Value = VTFechaAux
                    VTFechaAux = DateSerial(CInt(Mid(VTArreglo2(51), 7, 4)), CInt(Mid(VTArreglo2(51), 1, 2)), CInt(Mid(VTArreglo2(51), 4, 2)))
                    Tabla1.Fields("ah_fecha_ult_corte").Value = VTFechaAux
                    VTFechaAux = DateSerial(CInt(Mid(VTArreglo2(52), 7, 4)), CInt(Mid(VTArreglo2(52), 1, 2)), CInt(Mid(VTArreglo2(52), 4, 2)))
                    Tabla1.Fields("ah_fecha_ult_capi").Value = VTFechaAux
                    VTFechaAux = DateSerial(CInt(Mid(VTArreglo2(53), 7, 4)), CInt(Mid(VTArreglo2(53), 1, 2)), CInt(Mid(VTArreglo2(53), 4, 2)))
                    Tabla1.Fields("ah_fecha_prx_capita").Value = VTFechaAux
                    Tabla1.Fields("ah_linea").Value = VTArreglo2(54)
                    Tabla1.Fields("ah_ult_linea").Value = VTArreglo2(55)
                    Tabla1.Fields("ah_cliente_ec").Value = VTArreglo2(56)
                    Tabla1.Fields("ah_direccion_ec").Value = VTArreglo2(57)
                    Tabla1.Fields("ah_descripcion_ec").Value = VTArreglo2(58)
                    Tabla1.Fields("ah_tipo_dir").Value = VTArreglo2(59)
                    Tabla1.Fields("ah_agen_ec").Value = VTArreglo2(60)
                    Tabla1.Fields("ah_parroquia").Value = VTArreglo2(61)

                    Tabla1.Fields("ah_zona").Value = VTArreglo2(62)
                    Tabla1.Fields("ah_prom_disponible").Value = VTArreglo2(63)
                    Tabla1.Fields("ah_promedio1").Value = VTArreglo2(64)
                    Tabla1.Fields("ah_promedio2").Value = VTArreglo2(65)
                    Tabla1.Fields("ah_promedio3").Value = VTArreglo2(66)
                    Tabla1.Fields("ah_promedio4").Value = VTArreglo2(67)
                    Tabla1.Fields("ah_promedio5").Value = VTArreglo2(68)
                    Tabla1.Fields("ah_promedio6").Value = VTArreglo2(69)
                    Tabla1.Fields("ah_personalizada").Value = VTArreglo2(70)
                    Tabla1.Fields("ah_contador_trx").Value = VTArreglo2(71)
                    Tabla1.Fields("ah_cta_funcionario").Value = VTArreglo2(72)
                    Tabla1.Fields("ah_tipocta").Value = VTArreglo2(73)
                    Tabla1.Fields("ah_prod_banc").Value = VTArreglo2(74)
                    Tabla1.Fields("ah_origen").Value = VTArreglo2(75)
                    Tabla1.Fields("ah_numlib").Value = VTArreglo2(76)
                    Tabla1.Fields("ah_contador_firma").Value = VTArreglo2(78)
                    Tabla1.Fields("ah_telefono").Value = VTArreglo2(79)
                    Tabla1.Fields("ah_int_hoy").Value = VTArreglo2(80)
                    Tabla1.Fields("ah_tasa_hoy").Value = VTArreglo2(81)
                    Tabla1.Fields("ah_min_dispmes").Value = VTArreglo2(82)
                    VTFechaAux = DateSerial(CInt(Mid(VTArreglo2(83), 7, 4)), CInt(Mid(VTArreglo2(83), 1, 2)), CInt(Mid(VTArreglo2(83), 4, 2)))
                    Tabla1.Fields("ah_fecha_ult_ret").Value = VTFechaAux
                    Tabla1.Fields("ah_cliente1").Value = VTArreglo2(84)
                    Tabla1.Fields("ah_nombre1").Value = VTArreglo2(85)
                    Tabla1.Fields("ah_cedruc1").Value = VTArreglo2(86)
                    Tabla1.Fields("ah_sector").Value = VTArreglo2(87)
                    Tabla1.Fields("ah_monto_imp").Value = VTArreglo2(88)
                    Tabla1.Fields("ah_monto_consumos").Value = VTArreglo2(89)
                    Tabla1.Fields("ah_ctitularidad").Value = VTArreglo2(90)
                    Tabla1.Fields("ah_promotor").Value = VTArreglo2(91)
                    Tabla1.Fields("ah_int_mes").Value = VTArreglo2(92)

                    Tabla1.Fields("ah_tipocta_super").Value = VTArreglo2(93)
                    Tabla1.Fields("ah_direccion_dv").Value = VTArreglo2(94)
                    Tabla1.Fields("ah_descripcion_dv").Value = VTArreglo2(85)
                    Tabla1.Fields("ah_tipodir_dv").Value = VTArreglo2(96)
                    Tabla1.Fields("ah_parroquia_dv").Value = VTArreglo2(97)
                    Tabla1.Fields("ah_zona_dv").Value = VTArreglo2(98)
                    Tabla1.Fields("ah_agen_dv").Value = VTArreglo2(99)
                    Tabla1.Fields("ah_cliente_dv").Value = VTArreglo2(100)
                    Tabla1.Fields("ah_traslado").Value = VTArreglo2(101)
                    Tabla1.Fields("ah_aplica_tasacorp").Value = VTArreglo2(102)
                    Tabla1.Fields("ah_monto_emb").Value = VTArreglo2(103)
                    Tabla1.Fields("ah_monto_ult_capi").Value = VTArreglo2(104)
                    Tabla1.Fields("ah_saldo_mantval").Value = VTArreglo2(105)
                    Tabla1.Fields("ah_cuota").Value = VTArreglo2(106)
                    Tabla1.Fields("ah_creditos2").Value = VTArreglo2(107)
                    Tabla1.Fields("ah_creditos3").Value = VTArreglo2(108)
                    Tabla1.Fields("ah_creditos4").Value = VTArreglo2(109)
                    Tabla1.Fields("ah_creditos5").Value = VTArreglo2(110)
                    Tabla1.Fields("ah_creditos6").Value = VTArreglo2(111)
                    Tabla1.Fields("ah_debitos2").Value = VTArreglo2(112)
                    Tabla1.Fields("ah_debitos3").Value = VTArreglo2(113)
                    Tabla1.Fields("ah_debitos4").Value = VTArreglo2(114)
                    Tabla1.Fields("ah_debitos5").Value = VTArreglo2(115)
                    Tabla1.Fields("ah_debitos6").Value = VTArreglo2(116)
                    Tabla1.Fields("ah_tasa_ayer").Value = VTArreglo2(117)
                    Tabla1.Fields("ah_estado_cuenta").Value = VTArreglo2(118)
                    Tabla1.Fields("ah_permite_sldcero").Value = VTArreglo2(119)
                    Tabla1.Fields("ah_rem_ayer").Value = VTArreglo2(120)
                    Tabla1.Fields("ah_numsol").Value = VTArreglo2(121)
                    If VTArreglo2(124) <> "" Then Tabla1.Fields("ah_nxmil").Value = VTArreglo2(124)

                    If VTArreglo2(125) <> "" Then Tabla1.Fields("ah_clase_clte").Value = VTArreglo2(125)
                    If VTArreglo2(126) <> "" Then Tabla1.Fields("ah_deb_mes_ant").Value = Val(VTArreglo2(126))
                    If VTArreglo2(127) <> "" Then Tabla1.Fields("ah_cred_mes_ant").Value = Val(VTArreglo2(127))
                    If VTArreglo2(128) <> "" Then Tabla1.Fields("ah_num_deb_mes").Value = Val(VTArreglo2(128))
                    If VTArreglo2(129) <> "" Then Tabla1.Fields("ah_num_cred_mes").Value = Val(VTArreglo2(129))
                    If VTArreglo2(130) <> "" Then Tabla1.Fields("ah_num_con_mes").Value = Val(VTArreglo2(130))
                    If VTArreglo2(131) <> "" Then Tabla1.Fields("ah_num_deb_mes_ant").Value = Val(VTArreglo2(131))
                    If VTArreglo2(132) <> "" Then Tabla1.Fields("ah_num_cred_mes_ant").Value = Val(VTArreglo2(132))
                    If VTArreglo2(133) <> "" Then Tabla1.Fields("ah_num_con_mes_ant").Value = Val(VTArreglo2(133))
                    If VTArreglo2(134) <> "" Then
                        VTFechaAux = DateSerial(CInt(Mid(VTArreglo2(134), 7, 4)), CInt(Mid(VTArreglo2(134), 1, 2)), CInt(Mid(VTArreglo2(134), 4, 2)))
                        Tabla1.Fields("ah_fecha_ult_proceso").Value = VTFechaAux
                    End If
                    If VTArreglo2(135) <> "" Then Tabla1.Fields("cod_ciudad_oficina").Value = Val(VTArreglo2(135))
                    If VTArreglo2(136) <> "" Then Tabla1.Fields("ciudad_oficina").Value = VTArreglo2(136)
                End If
            Else
                PMChequea(sqlconn)
            End If

            'Consultar y guardar datos del banco
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "640")
            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_ah_datos_bco", True, FMLoadResString(2601) & " [" & lblDescripcion(0).Text & "]") Then
                VTR1 = FMMapeaArreglo(sqlconn, VTArreglo2)
                PMChequea(sqlconn)
                If VTR1 > 0 Then
                    Tabla1.Fields("nombre_corto_bco").Value = VTArreglo2(1)
                    Tabla1.Fields("nombre_banco").Value = VTArreglo2(2)
                    Tabla1.Fields("direccion_banco").Value = VTArreglo2(3)
                    Tabla1.Fields("tfno1_banco").Value = VTArreglo2(4)
                    Tabla1.Fields("tfno2_banco").Value = VTArreglo2(5)
                    Tabla1.Fields("mail1_banco").Value = VTArreglo2(6)
                    Tabla1.Fields("mail2_banco").Value = VTArreglo2(7)
                End If
            Else
                PMChequea(sqlconn)
            End If

            REM ===================

            Tabla1.Update()
            Tabla1.Close()
            tabla2.Close()
            tabla4.Close()
            tabla5.Close()
            BaseDatos.Close()
            Dim respuesta As DialogResult
            respuesta = COBISMessageBox.Show(FMLoadResString(501194), FMLoadResString(500092), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question)
            If respuesta = System.Windows.Forms.DialogResult.No Then
                Exit Sub
            End If

        Catch
            COBISMessageBox.Show(FMLoadResString(501195) & Conversion.ErrorToString(), FMLoadResString(500092))
            Exit Sub
        End Try

        'FIN Apertura sin Asociación de Contratos'

        Dim VTConvFec As String = "dd Mes aaaa"

        Dim VTContratos(10) As String
        Dim VTMatriz(10, 20) As String


        Try

            Dim VTTipoPersona As String = ""
            Dim VTEspecial As String = ""
            If txtCampo(19).Text = "1" Then
                VTTipoPersona = "P"
            ElseIf txtCampo(19).Text = "2" Then
                VTTipoPersona = "C"
            End If


            If String.IsNullOrEmpty(VTTipoPersona) Then
                grdPropietarios.Row = 1
                grdPropietarios.Col = 3
                VTTipoPersona = grdPropietarios.CtlText
            End If

            archivo = VGPath & "APERTURA.MDB"

            VLHabilitaClientesEsp = "S"

            If VTTipoPersona = "C" Then
                VLHabilitaClientesEsp = "N"
            End If


            If VLHabilitaClientesEsp = "S" Then
                VTEspecial = "SI"
            ElseIf VLHabilitaClientesEsp = "N" Then
                VTEspecial = "NO"
            End If


            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2946")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "P")
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
            PMPasoValores(sqlconn, "@i_prod_banc", 0, SQLINT2, txtCampo(8).Text)
            PMPasoValores(sqlconn, "@i_tipo_persona", 0, SQLCHAR, VTTipoPersona)
            PMPasoValores(sqlconn, "@i_titularidad", 0, SQLCHAR, txtCampo(18).Text)
            PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
            If Not String.IsNullOrEmpty(VTEspecial) Then
                PMPasoValores(sqlconn, "@i_es_especial", 0, SQLCHAR, VTEspecial)
            End If


            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_contrato_producto", False, "") Then
                VTR5 = FMMapeaMatriz(sqlconn, VTMatriz)
                PMChequea(sqlconn)

                If VTR5 = 0 Then
                    COBISMessageBox.Show(FMLoadResString(5263), FMLoadResString(500018))
                End If


                For i As Integer = 1 To VTR5
                    'en un arreglo los contratos a imprimir para este producto
                    VTContratos(i) = VGPath & VTMatriz(3, i)
                    If Not File.Exists(VTContratos(i)) Then
                        COBISMessageBox.Show(VTMatriz(3, i) & " - " & FMLoadResString(5262), FMLoadResString(500018))
                    Else
                        reporte = VTContratos(i)
                        rptReporte.Reset()
                        rptReporte.DiscardSavedData = True
                        rptReporte.Refresh()
                        rptReporte.ReportFileName = reporte
                        rptReporte.CopiesToPrinter = 1
                        rptReporte.DataFiles(0) = archivo
                        rptReporte.DataFiles(1) = archivo
                        rptReporte.DataFiles(2) = archivo
                        rptReporte.DataFiles(3) = archivo
                        rptReporte.DataFiles(4) = archivo_logo
                        rptReporte.Destination = COBISCorp.Framework.UI.Components.DestinationConstants.crptToWindow

                        rptReporte.Formulas(0) = "usuario=""" & VGLogin & " - " & VGFecha & " """
                        rptReporte.Formulas(1) = "fecha=""" & VGFecha & """"
                        rptReporte.Action = 1

                    End If
                Next i
            Else
                PMChequea(sqlconn)
            End If


            'rptReporte.ReportFileName = reporte
            'rptReporte.CopiesToPrinter = 1
            'rptReporte.DataFiles(0) = archivo
            'rptReporte.DataFiles(1) = archivo
            'rptReporte.DataFiles(2) = archivo
            'rptReporte.DataFiles(3) = archivo
            'rptReporte.DataFiles(4) = archivo_logo


            'rptReporte.Destination = COBISCorp.Framework.UI.Components.DestinationConstants.crptToWindow
            'rptReporte.Formulas(0) = "usuario=""" & VGLogin & " - " & VGFecha & " """
            'rptReporte.Formulas(1) = "fecha=""" & VGFecha & """"
            'rptReporte.Action = 1

        Catch ex As Exception
            COBISMessageBox.Show(FMLoadResString(501195) & Conversion.ErrorToString(), FMLoadResString(500092))
            Exit Sub
        End Try
        PLTSEstado()
    End Sub
    Public Function Num2Text(ByVal value As Double) As String
        Select Case value
            Case 0 : Num2Text = "CERO"
            Case 1 : Num2Text = "UN"
            Case 2 : Num2Text = "DOS"
            Case 3 : Num2Text = "TRES"
            Case 4 : Num2Text = "CUATRO"
            Case 5 : Num2Text = "CINCO"
            Case 6 : Num2Text = "SEIS"
            Case 7 : Num2Text = "SIETE"
            Case 8 : Num2Text = "OCHO"
            Case 9 : Num2Text = "NUEVE"
            Case 10 : Num2Text = "DIEZ"
            Case 11 : Num2Text = "ONCE"
            Case 12 : Num2Text = "DOCE"
            Case 13 : Num2Text = "TRECE"
            Case 14 : Num2Text = "CATORCE"
            Case 15 : Num2Text = "QUINCE"
            Case Is < 20 : Num2Text = "DIECI" & Num2Text(value - 10)
            Case 20 : Num2Text = "VEINTE"
            Case Is < 30 : Num2Text = "VEINTI" & Num2Text(value - 20)
            Case 30 : Num2Text = "TREINTA"
            Case 40 : Num2Text = "CUARENTA"
            Case 50 : Num2Text = "CINCUENTA"
            Case 60 : Num2Text = "SESENTA"
            Case 70 : Num2Text = "SETENTA"
            Case 80 : Num2Text = "OCHENTA"
            Case 90 : Num2Text = "NOVENTA"
            Case Is < 100 : Num2Text = Num2Text(Int(value \ 10) * 10) & " Y " & Num2Text(value Mod 10)
            Case 100 : Num2Text = "CIEN"
            Case Is < 200 : Num2Text = "CIENTO " & Num2Text(value - 100)
            Case 200, 300, 400, 600, 800 : Num2Text = Num2Text(Int(value \ 100)) & "CIENTOS"
            Case 500 : Num2Text = "QUINIENTOS"
            Case 700 : Num2Text = "SETECIENTOS"
            Case 900 : Num2Text = "NOVECIENTOS"
            Case Is < 1000 : Num2Text = Num2Text(Int(value \ 100) * 100) & " " & Num2Text(value Mod 100)
            Case 1000 : Num2Text = "MIL"
            Case Is < 2000 : Num2Text = "MIL " & Num2Text(value Mod 1000)
            Case Is < 1000000 : Num2Text = Num2Text(Int(value \ 1000)) & " MIL"
                If value Mod 1000 Then Num2Text = Num2Text & " " & Num2Text(value Mod 1000)
            Case 1000000 : Num2Text = "UN MILLON"
            Case Is < 2000000 : Num2Text = "UN MILLON " & Num2Text(value Mod 1000000)
            Case Is < 1000000000000.0# : Num2Text = Num2Text(Int(value / 1000000)) & " MILLONES "
                If (value - Int(value / 1000000) * 1000000) Then Num2Text = Num2Text & " " & Num2Text(value - Int(value / 1000000) * 1000000)
            Case 1000000000000.0# : Num2Text = "UN BILLON"
            Case Is < 2000000000000.0# : Num2Text = "UN BILLON " & Num2Text(value - Int(value / 1000000000000.0#) * 1000000000000.0#)
            Case Else : Num2Text = Num2Text(Int(value / 1000000000000.0#)) & " BILLONES"
                If (value - Int(value / 1000000000000.0#) * 1000000000000.0#) Then Num2Text = Num2Text & " " & Num2Text(value - Int(value / 1000000000000.0#) * 1000000000000.0#)
        End Select

    End Function
    Private Sub PLProcesarPropietarios(ByVal ParTipoPropietario As String, ByVal ParPrincipal As Integer)
        Dim bandera As Integer = 0
        Dim XT As Integer = 0
        If ParPrincipal = 1 Then
            XT += 1
            Roles(XT, 1) = ParTipoPropietario
        End If
        For i As Integer = 1 To grdPropietarios.Rows - 1
            grdPropietarios.Col = 5
            grdPropietarios.Row = i
            bandera = 0
            For YT As Integer = 1 To XT
                If grdPropietarios.CtlText = Roles(YT, 1) Then
                    bandera = 1
                End If
            Next YT
            If grdPropietarios.CtlText = ParTipoPropietario Or (ParTipoPropietario = "OTROS" And bandera = 1) Then
                VLContadorprop += 1
                ReDim Preserve VTMatrizprop(grdPropietarios.Cols - 1, VLContadorprop)
                For j As Integer = 1 To grdPropietarios.Cols - 1
                    grdPropietarios.Col = j
                    grdPropietarios.Row = i
                    VTMatrizprop(j - 1, VLContadorprop) = grdPropietarios.CtlText
                Next j
            End If
        Next i
        PLTSEstado()
    End Sub

    Private Sub cmbenvioec_SelectedIndexChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbenvioec.SelectedIndexChanged
        optdir(0).Enabled = Not (cmbenvioec.Text = "N")
        If cmbenvioec.Text = "N" Then
            optdir(1).Checked = True
        Else
            optdir(0).Checked = True
        End If
        PLTSEstado()
    End Sub

    Private Sub cmbenvioec_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbenvioec.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501927))
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_3.Click, _cmdBoton_2.Click, _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_6.Click, _cmdBoton_9.Click, _cmdBoton_5.Click, _cmdBoton_7.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VLProdbanc As String = ""
        Dim VTR As Integer = 0
        Dim VLTipoDoc As String = ""
        Select Case Index
            Case 0 'ANADIR
                PLAniadir()
                txtCampo(0).Focus()
                VLEnte = True
            Case 1 'ELIMINAR
                PLEliminar()
            Case 2 'TRANSMITIR
                PLTransmitir()
                If _lblDescripcion_0.Text <> "" Then
                    _cmdBoton_2.Enabled = False
                    PLTSEstado()
                End If
            Case 3
                If VGCodPais = "PA" Then
                    If VGPerfilCta <> "S" And VGPerfilCta <> "" Then
                        COBISMessageBox.Show(FMLoadResString(501185), FMLoadResString(500092), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        Exit Sub
                    End If
                End If
                PLLimpiar()
            Case 4
                If VGCodPais = "PA" Then
                    If VGPerfilCta <> "S" And VGPerfilCta <> "" Then
                        COBISMessageBox.Show(FMLoadResString(501186), FMLoadResString(500092), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        Exit Sub
                    End If
                End If
                PLSalir()
            Case 5
                'VLSolicitud = txtCampo(14).Text
                PLBuscar()
            Case 9
                If VGCodPais = "PA" Then
                    If VGPerfilCta <> "S" And VGPerfilCta <> "" Then
                        COBISMessageBox.Show(FMLoadResString(501187), FMLoadResString(500092), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        Exit Sub
                    End If
                End If
                PLReporteApertura()
            Case 6
                VGProducto = "AHO"
                Fdatadi.Show(Me)
                Fdatadi.mskCuenta.Mask = VGMascaraCtaAho
                Fdatadi.mskCuenta.Text = lblDescripcion(0).Text
            Case 7
                VGCuenta = VLCuenta0
                VLProdbanc = txtCampo(8).Text
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "747")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "V")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, VLProdbanc)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_relacion_cta_canal", True, FMLoadResString(2249)) Then
                    PMMapeaVariable(sqlconn, VLProdBancBloq)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    VLProdBancBloq = ""
                End If
                If VLProdBancBloq <> "" Then
                    COBISMessageBox.Show(FMLoadResString(2603), FMLoadResString(500068), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, VGCuenta)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, "") Then
                    Dim VTArreglo(20) As String
                    FMMapeaArreglo(sqlconn, VTArreglo)
                    VLTitularidad = VTArreglo(4)
                    PMChequea(sqlconn)
                    If VLTitularidad = "CONJUNTA" Then
                        COBISMessageBox.Show(FMLoadResString(2605), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        Exit Sub
                    Else
                        VTR = grdPropietarios.Rows - 1
                        For i As Integer = 1 To VTR
                            grdPropietarios.Col = 2
                            grdPropietarios.Row = i
                            VLNumDoc = grdPropietarios.CtlText
                            grdPropietarios.Col = 3
                            VLTipoDoc = grdPropietarios.CtlText
                            If VLTipoDoc = "C" Then
                                COBISMessageBox.Show(FMLoadResString(2606), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                Exit Sub
                            End If
                            VLTipoTran = "1610"
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1020")
                            PMPasoValores(sqlconn, "@i_frontend", 0, SQLCHAR, "S")
                            PMPasoValores(sqlconn, "@i_cedruc", 0, SQLVARCHAR, VLNumDoc)
                            PMPasoValores(sqlconn, "@o_tipoced", 0, SQLVARCHAR, VGTipoDoc)
                            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_datos_cliente", True, "") Then
                                PMMapeaVariable(sqlconn, VGTipoDoc)
                                PMChequea(sqlconn)
                            Else
                                PMChequea(sqlconn)
                            End If
                            FMRegistraHuellaAValidar(VGTipoDoc, VLNumDoc, VLTitularidad, VGCuenta, VLTipoTran)
                        Next i
                        If VGOcucol <> "S" Then
                            If VGValidaHuella Then
                                VLTipoTran = "1610"
                                FMVerificaHuella(VGCuenta, VLTipoTran)
                                If VGRegistraHuellaAValidar Then
                                    FRelCtaCanal.Show(Me)
                                Else
                                    Exit Sub
                                End If
                            End If
                        End If
                        
                    End If
                Else
                    PMChequea(sqlconn)
                End If
        End Select
        PLTSEstado()
    End Sub

    Private Sub FTran201_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLLimpiar()
    End Sub

    Public Sub PLInicializar()
        mskCuenta.Text = VGMascaraCtaAho
        If VGAperCifrada Then
            Me.Tag = CStr(3031)
        Else
            Me.Tag = CStr(3030)
        End If
        VGOrigen = "0"
        VGCancelar = "N"
        grdPropietarios.set_ColIsVisible(0, False)
        grdPropietarios.ColWidth(1) = 800
        grdPropietarios.ColWidth(2) = 1300
        grdPropietarios.ColWidth(3) = 300
        grdPropietarios.ColWidth(4) = 3915
        grdPropietarios.ColWidth(5) = 375
        grdPropietarios.ColWidth(6) = 1230
        grdPropietarios.Row = 0
        grdPropietarios.Col = 1
        grdPropietarios.CtlText = FMLoadResString(9919) '"CODIGO"
        grdPropietarios.Col = 2
        grdPropietarios.CtlText = FMLoadResString(9938) '"IDENTIFICACION"
        grdPropietarios.Col = 3
        grdPropietarios.CtlText = "TP."
        grdPropietarios.Col = 4
        grdPropietarios.CtlText = FMLoadResString(9940) '"NOMBRE"
        grdPropietarios.Col = 5
        grdPropietarios.CtlText = FMLoadResString(9101) '"TIT."
        grdPropietarios.Col = 6
        grdPropietarios.CtlText = FMLoadResString(9942) '"DESCRIPCION"
        PMAnchoColumnasGrid(grdPropietarios)
        PMCatalogo("D", "cl_rol", txtCampo(1), lblDescripcion(5))
        txtCampo(6).Enabled = True
        VLNumero = 0
        VLTitular = 0
        Mskvalor.Text = VGDecimales
        Mskvalor.Text = StringsHelper.Format(0, VGDecimales)
        Mskvalor.MaxLength = 14
        VLImprimio = True
        VLEnte = True
        VLCedula1 = ""
        VLCotitular = "0"
        VLyaingreso = 0
        cmbenvioec.Items.Clear()
        cmbenvioec.Items.Add("S")
        cmbenvioec.Items.Add("N")
        cmbenvioec.SelectedIndex = 1
        VGPerfilCta = ""
        For n As Integer = 0 To VLTipoDireccion.GetUpperBound(0) - 1
            For C As Integer = 0 To VLTipoDireccion.GetUpperBound(1) - 1
                VLTipoDireccion(n, C) = ""
            Next C
        Next n
        'optdir(1).Checked = True
        'optdir_CheckedChanged(optdir(1), New EventArgs())
        txtCampo(21).Text = ""
        lblDescripcion(22).Text = ""
        If VGCodPais = "PA" Then
            lblEtiqueta(15).Visible = True
            txtCampo(12).Visible = True
            lblEtiqueta(20).Visible = True
            txtCampo(15).Visible = True
            cmdBoton(6).Visible = True
        End If
        CargaParametros("1579", "Q", "3", "AHO", "OCUCOL", 3)
        If VGOcucol = "S" Then
            Label5.Visible = False
            Lblalianza.Visible = False
            lbldesalianza.Visible = False
            cmdBoton(7).Visible = False
        End If
        PLParametro()
        PLLimpiar()
        PLTSEstado()
        txtCampo(2).MaxLength = 255
    End Sub

    Private Sub FTran201_Closing(ByVal eventSender As Object, ByVal eventArgs As FormClosingEventArgs) Handles MyBase.Closing
        Dim Cancel As Integer = IIf(eventArgs.Cancel, 1, 0)
        Dim Msg As String = ""
        If Not VLImprimio Then
            Msg = FMLoadResString(502444)
            If COBISMsgBox.MsgBox(Msg, 36, Me.Text) = System.Windows.Forms.DialogResult.No Then Cancel = True
        End If
        eventArgs.Cancel = Cancel <> 0
    End Sub

    Private Sub FTran201_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        VGPerfilCta = ""
    End Sub

    Private Sub grdPropietarios_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdPropietarios.Click
        grdPropietarios.Col = 0
        grdPropietarios.SelStartCol = 1
        grdPropietarios.SelEndCol = grdPropietarios.Cols - 1
        If grdPropietarios.Row = 0 Then
            grdPropietarios.SelStartRow = 1
            grdPropietarios.SelEndRow = 1
        Else
            grdPropietarios.SelStartRow = grdPropietarios.Row
            grdPropietarios.SelEndRow = grdPropietarios.Row
        End If
        If Not optdir(1).Checked Then
            If VLTipoDireccion(0, 0) = "D" Then
                txtCampo(3).Text = ""
                lblDescripcion(6).Text = ""
            End If
        Else
            If VLTipoDireccion(1, 0) = "D" Then
                txtCampo(13).Text = ""
                lblDescripcion(15).Text = ""
            End If
        End If
        PLTSEstado()
    End Sub

    Private Sub grdPropietarios_ClickEvent(sender As Object, e As EventArgs) Handles grdPropietarios.ClickEvent
        PMMarcaFilaCobisGrid(grdPropietarios, grdPropietarios.Row)
    End Sub

    Private Sub grdPropietarios_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdPropietarios.DblClick
        PMMarcaFilaCobisGrid(grdPropietarios, grdPropietarios.Row)
        If VLEnte Then
            grdPropietarios.Col = 2
            For i As Integer = 1 To (grdPropietarios.Rows - 1)
                grdPropietarios.Row = i
                If (grdPropietarios.CtlText) = "C" Then
                    grdPropietarios.Col = 4
                    If grdPropietarios.CtlText.Trim() = "T" Then
                        Exit For
                    End If
                End If
            Next i
            VLEnte = False
            _cmdBoton_1.Enabled = True
            PLTSEstado()
        End If
        PLTSEstado()
    End Sub

    Private Sub grdPropietarios_GotFocus(sender As Object, e As EventArgs) Handles grdPropietarios.GotFocus
        _cmdBoton_1.Enabled = False
        PLTSEstado()
    End Sub

    Private Sub grdPropietarios_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdPropietarios.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2223))
        If VGHabilita = "S" Then
            _cmdBoton_7.Enabled = False
        Else
            _cmdBoton_7.Enabled = True
        End If
        PLTSEstado()
    End Sub

    Private Sub Mskvalor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles Mskvalor.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5001954))
        Mskvalor.SelectionStart = 0
        Mskvalor.SelectionLength = Strings.Len(Mskvalor.Text)
    End Sub

    Private Sub Mskvalor_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles Mskvalor.KeyPress
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
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
        PLTSEstado()
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub optdir_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optdir_1.CheckedChanged, _optdir_0.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Index As Integer = Array.IndexOf(optdir, eventSender)
            If Index = 0 Then
                txtCampo(3).Visible = True
                txtCampo(13).Visible = Not txtCampo(3).Visible
                lblDescripcion(6).Visible = True
                lblDescripcion(15).Visible = Not lblDescripcion(6).Visible
                lblEtiqueta(12).Visible = True
                lblEtiqueta(19).Visible = Not lblEtiqueta(12).Visible
                txtCampo(21).Text = VLTipoDireccion(Index, 0)
                lblDescripcion(22).Text = VLTipoDireccion(Index, 1)
            Else
                txtCampo(13).Visible = True
                txtCampo(3).Visible = Not txtCampo(13).Visible
                lblDescripcion(15).Visible = True
                lblDescripcion(6).Visible = Not lblDescripcion(15).Visible
                lblEtiqueta(19).Visible = True
                lblEtiqueta(12).Visible = Not lblEtiqueta(19).Visible
                txtCampo(21).Text = VLTipoDireccion(Index, 0)
                lblDescripcion(22).Text = VLTipoDireccion(Index, 1)
            End If
        End If
        PLTSEstado()
    End Sub

    Private Sub optdir_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optdir_1.Enter, _optdir_0.Enter
        Dim Index As Integer = Array.IndexOf(optdir, eventSender)
        optdir(Index).Checked = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501157))
    End Sub

    Private Sub PLAniadir()
        Dim VTValores(15) As String
        Dim VTArreglo(10) As String
        Dim VTCadena As String = ""
        Dim VTR1 As Integer = 0
        Dim vti As Integer = 1
        Dim VTSeguir As Integer = 1
        If grdPropietarios.Rows - 1 >= 20 Then
            COBISMessageBox.Show(FMLoadResString(501191), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            Exit Sub
        End If
        If txtCampo(0).Text <> "" Then
            If lblDescripcion(3).Text = "C" And lblDescripcion(2).Text = "" Then
                lblDescripcion(2).Text = FMLoadResString(502404)
            End If
            If lblDescripcion(2).Text <> "" Then
                If lblDescripcion(4).Text <> "" Then
                    If lblDescripcion(3).Text <> "" Then
                        If txtCampo(1).Text <> "" Then
                            If txtCampo(1).Text <> "T" And VLyaingreso = 0 Then
                                COBISMessageBox.Show(FMLoadResString(501133), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                                Exit Sub
                            End If
                            If txtCampo(1).Text = "U" Then
                                COBISMessageBox.Show(FMLoadResString(2527), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                                txtCampo(1).Focus()
                                Exit Sub
                            End If
                            VLTutor = False
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "350")
                            PMPasoValores(sqlconn, "@i_retorna", 0, SQLINT1, "1")
                            VTCadena = ""
                            VTCadena = VTCadena & (txtCampo(0).Text) & "@"
                            VTCadena = VTCadena & (txtCampo(1).Text) & "@"
                            VTCadena = VTCadena & (lblDescripcion(4).Text) & "@"
                            PMPasoValores(sqlconn, "@i_param" & vti, 0, SQLCHAR, VTCadena)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_valida_menor", True, FMLoadResString(2528)) Then
                                VTR1 = FMMapeaArreglo(sqlconn, VTValores)
                                PMChequea(sqlconn)
                                If VTR1 > 0 Then
                                    VLTutor = True
                                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "cl_rol")
                                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, "U")
                                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", False, "") Then
                                        VTR1 = FMMapeaArreglo(sqlconn, VTArreglo)
                                        PMChequea(sqlconn)
                                    Else
                                        PMChequea(sqlconn)
                                    End If
                                End If
                            Else
                                PMChequea(sqlconn)
                                txtCampo(0).Text = ""
                                txtCampo(0).Focus()
                                lblDescripcion(2).Text = ""
                                lblDescripcion(3).Text = ""
                                lblDescripcion(4).Text = ""
                                txtCampo(1).Text = ""
                                lblDescripcion(5).Text = ""
                                Exit Sub
                            End If
                            If VLNumero > 0 Then
                                VTSeguir = PLChequeoIngreso()
                            End If
                            If VTSeguir = 1 Then
                                If (txtCampo(1).Text = "T") And (Convert.ToString(grdPropietarios.Tag) <> "T") Then
                                    VLTitular = VLNumero + 1
                                    grdPropietarios.Tag = "T"
                                    If VLNumero = 0 Then
                                        grdPropietarios.Row = 1
                                        grdPropietarios.Col = 1
                                        grdPropietarios.CtlText = txtCampo(0).Text
                                        grdPropietarios.Col = 2
                                        grdPropietarios.CtlText = lblDescripcion(2).Text
                                        grdPropietarios.Col = 3
                                        grdPropietarios.CtlText = lblDescripcion(3).Text
                                        grdPropietarios.Col = 4
                                        grdPropietarios.CtlText = lblDescripcion(4).Text
                                        grdPropietarios.Col = 5
                                        grdPropietarios.CtlText = txtCampo(1).Text
                                        If txtCampo(1).Text = "T" Then
                                            VLCodTitular = CInt(Conversion.Val(txtCampo(0).Text))
                                            VLTipoEnteTitular = lblDescripcion(3).Text
                                        End If
                                        grdPropietarios.Col = 6
                                        grdPropietarios.CtlText = lblDescripcion(5).Text
                                    Else
                                        grdPropietarios.AddItem("" & Strings.Chr(9).ToString() & txtCampo(0).Text & Strings.Chr(9).ToString() & lblDescripcion(2).Text & Strings.Chr(9).ToString() & lblDescripcion(3).Text & Strings.Chr(9).ToString() & lblDescripcion(4).Text & Strings.Chr(9).ToString() & txtCampo(1).Text & Strings.Chr(9).ToString() & lblDescripcion(5).Text, VLNumero + 1)
                                    End If
                                    If VTR1 > 0 Then
                                        grdPropietarios.AddItem("" & Strings.Chr(9).ToString() & VTValores(1) & Strings.Chr(9).ToString() & VTValores(2) & Strings.Chr(9).ToString() & VTValores(3) & Strings.Chr(9).ToString() & VTValores(4) & Strings.Chr(9).ToString() & "U" & Strings.Chr(9).ToString() & VTArreglo(1), VLNumero + 2)
                                        VLNumero += 1
                                        txtCampo(0).Focus()
                                    End If
                                    grdPropietarios.Col = 5
                                    If txtCampo(1).Text.Trim() = "T" Then
                                        VLyaingreso = 1
                                        txtCampo(2).Text = lblDescripcion(4).Text
                                        txtCampo(2).Enabled = False
                                    End If
                                    VLNumero += 1
                                    txtCampo(0).Text = ""
                                    txtCampo(1).Text = ""
                                    lblDescripcion(2).Text = ""
                                    lblDescripcion(3).Text = ""
                                    lblDescripcion(4).Text = ""
                                    lblDescripcion(5).Text = ""
                                    mskCuenta.Mask = VGMascaraCtaAho
                                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                                ElseIf (txtCampo(1).Text <> "T") Then
                                    If VLNumero = 0 Then
                                        grdPropietarios.Row = 1
                                        grdPropietarios.Col = 1
                                        grdPropietarios.CtlText = txtCampo(0).Text
                                        grdPropietarios.Col = 2
                                        grdPropietarios.CtlText = lblDescripcion(2).Text
                                        grdPropietarios.Col = 3
                                        grdPropietarios.CtlText = lblDescripcion(3).Text
                                        grdPropietarios.Col = 4
                                        grdPropietarios.CtlText = lblDescripcion(4).Text
                                        grdPropietarios.Col = 5
                                        grdPropietarios.CtlText = txtCampo(1).Text
                                        grdPropietarios.Col = 6
                                        grdPropietarios.CtlText = lblDescripcion(5).Text
                                    Else
                                        If VLTipoEnteTitular = "C" Then
                                            If txtCampo(1).Text = "C" Then
                                                COBISMessageBox.Show(FMLoadResString(501134), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                                VLNumero -= 1
                                            Else
                                                If txtCampo(1).Text = "F" And lblDescripcion(3).Text = "C" Then
                                                    COBISMessageBox.Show(FMLoadResString(501928), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                                    VLNumero -= 1
                                                Else
                                                    grdPropietarios.AddItem("" & Strings.Chr(9).ToString() & txtCampo(0).Text & Strings.Chr(9).ToString() & lblDescripcion(2).Text & Strings.Chr(9).ToString() & lblDescripcion(3).Text & Strings.Chr(9).ToString() & lblDescripcion(4).Text & Strings.Chr(9).ToString() & txtCampo(1).Text & Strings.Chr(9).ToString() & lblDescripcion(5).Text, VLNumero + 1)
                                                End If
                                            End If
                                        Else
                                            If lblDescripcion(3).Text = "C" Then
                                                COBISMessageBox.Show(FMLoadResString(501928), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                                VLNumero -= 1
                                            Else
                                                grdPropietarios.AddItem("" & Strings.Chr(9).ToString() & txtCampo(0).Text & Strings.Chr(9).ToString() & lblDescripcion(2).Text & Strings.Chr(9).ToString() & lblDescripcion(3).Text & Strings.Chr(9).ToString() & lblDescripcion(4).Text & Strings.Chr(9).ToString() & txtCampo(1).Text & Strings.Chr(9).ToString() & lblDescripcion(5).Text, VLNumero + 1)
                                            End If
                                        End If
                                    End If
                                    VLNumero += 1
                                    txtCampo(0).Text = ""
                                    txtCampo(1).Text = ""
                                    lblDescripcion(2).Text = ""
                                    lblDescripcion(3).Text = ""
                                    lblDescripcion(4).Text = ""
                                    lblDescripcion(5).Text = ""
                                Else
                                    COBISMessageBox.Show(FMLoadResString(501929), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                End If
                                PMAnchoColumnasGrid(grdPropietarios)
                            Else
                                COBISMessageBox.Show(FMLoadResString(501930), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                txtCampo(0).Text = ""
                                txtCampo(1).Text = ""
                                lblDescripcion(2).Text = ""
                                lblDescripcion(3).Text = ""
                                lblDescripcion(4).Text = ""
                                lblDescripcion(5).Text = ""
                                txtCampo(0).Focus()
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501137), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(1).Focus()
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(501138), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(0).Focus()
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(501139), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                End If
            Else
                COBISMessageBox.Show(FMLoadResString(501140), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtCampo(0).Focus()
            End If
        Else
            COBISMessageBox.Show(FMLoadResString(501141), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
        End If
        If txtCampo(1).Text = "T" Then
            If VLEnte Then
                grdPropietarios.Col = 3
                For i As Integer = 1 To (grdPropietarios.Rows - 1)
                    grdPropietarios.Row = i
                    If (grdPropietarios.CtlText) = "C" Then
                        grdPropietarios.Col = 5
                        If grdPropietarios.CtlText.Trim() = "T" Then
                            Exit For
                        End If
                    End If
                Next i
                VLEnte = False
            End If
        End If
        cmdBoton(2).Enabled = True
        Comprobar_cliente()
        PLTSEstado()
    End Sub

    Private Function PLChequeoIngreso() As Integer
        Dim VTRegistrado As Integer = 0
        For i As Integer = 1 To grdPropietarios.Rows - 1
            grdPropietarios.Col = 1
            grdPropietarios.Row = i
            If grdPropietarios.CtlText.Trim() = txtCampo(0).Text.Trim() Then
                VTRegistrado = 0
                Exit For
            Else
                VTRegistrado = 1
            End If
        Next i
        PLTSEstado()
        Return VTRegistrado
    End Function

    Private Sub PLEliminar()
        Dim VTPosTmp As Integer = 0
        Dim VTFlag As Boolean = False
        grdPropietarios.Col = 5
        If grdPropietarios.CtlText = "U" Then
            COBISMessageBox.Show(FMLoadResString(2529), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            Exit Sub
        End If
        If grdPropietarios.CtlText = "T" Then
            VLTitular = 0
            grdPropietarios.Tag = ""
            txtCampo(2).Text = ""
            txtCampo(8).Text = ""
            lblDescripcion(11).Text = ""
            txtCampo(7).Text = ""
            lblDescripcion(10).Text = ""
            VLyaingreso = 0
            VTFlag = True
            mskCuenta.Mask = VGMascaraCtaAho
            mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
        End If
        grdPropietarios.Col = 1
        Dim VTCliCasi As String = grdPropietarios.CtlText
        If VTCliCasi = Convert.ToString(txtCampo(3).Tag) Then
            txtCampo(3).Text = ""
            lblDescripcion(6).Text = ""
            txtCampo(3).Tag = ""
        End If
        If VTCliCasi = Convert.ToString(txtCampo(13).Tag) Then
            txtCampo(13).Text = ""
            lblDescripcion(15).Text = ""
            txtCampo(13).Tag = ""
        End If
        If grdPropietarios.Rows = 2 Then
            VLNumero = 0
            grdPropietarios.Row = 1
            For i As Integer = 0 To 6
                grdPropietarios.Col = i
                grdPropietarios.CtlText = ""
            Next i
        Else
            VLNumero -= 1
            grdPropietarios.RemoveItem(CShort(grdPropietarios.Row))
            grdPropietarios.SelStartRow = grdPropietarios.Row
            grdPropietarios.SelEndRow = grdPropietarios.Row
            If VTFlag Then
                If grdPropietarios.Rows = 2 Then
                    VLNumero = 0
                    grdPropietarios.Row = 1
                    grdPropietarios.Col = 5
                    If grdPropietarios.CtlText = "U" Then
                        For i As Integer = 0 To 6
                            grdPropietarios.Col = i
                            grdPropietarios.CtlText = ""
                        Next i
                    End If
                Else
                    grdPropietarios.Row = 1
                    grdPropietarios.Col = 5
                    For i As Integer = 1 To (grdPropietarios.Rows - 1)
                        grdPropietarios.Row = i
                        If grdPropietarios.CtlText = "U" Then
                            VTPosTmp = i
                            Exit For
                        End If
                    Next i
                    If VTPosTmp > 0 Then
                        VLNumero -= 1
                        grdPropietarios.SelStartRow = VTPosTmp
                        grdPropietarios.SelEndRow = VTPosTmp
                        grdPropietarios.RemoveItem(CShort(VTPosTmp))
                    End If
                End If
            End If
            txtCampo(0).Focus()
        End If
        txtCampo(19).Text = ""
        lblDescripcion(14).Text = ""
        _cmdBoton_1.Enabled = False
        PLTSEstado()
    End Sub

    Private Sub PLLimpiar()
        For i As Integer = 0 To 4
            txtCampo(i).Text = ""
        Next i
        txtCampo(6).Text = ""
        txtCampo(5).Text = ""
        txtCampo(7).Text = ""
        txtCampo(8).Text = ""
        txtCampo(9).Text = ""
        txtCampo(10).Text = ""
        If VGCodPais = "PA" Then txtCampo(12).Text = ""
        txtCampo(12).Text = ""
        txtCampo(13).Text = ""
        txtCampo(14).Text = ""
        txtCampo(15).Text = ""
        If VGCodPais = "PA" Then txtCampo(15).Text = ""
        txtCampo(18).Text = ""
        lblDescripcion(20).Text = ""
        Mskvalor.Text = "0"
        txtCampo(3).Tag = ""
        lblDescripcion(15).Text = ""
        For i As Integer = 0 To 15
            lblDescripcion(i).Text = ""
        Next i
        grdPropietarios.Rows = 2
        grdPropietarios.Row = 1
        For i As Integer = 0 To 6
            grdPropietarios.Col = i
            grdPropietarios.CtlText = ""
        Next i
        grdPropietarios.Tag = ""
        VLNumero = 0
        VLTitular = 0
        VLCodTitular = 0
        PMCatalogo("D", "ah_tpromedio", txtCampo(5), lblDescripcion(8))
        cmdBoton(0).Enabled = False 'TSBAnadir
        cmdBoton(1).Enabled = False  'TSBEliminar
        cmdBoton(2).Enabled = False  'TSBTransmitir
        cmdBoton(3).Enabled = True 'TSBLimpiar
        cmdBoton(4).Enabled = True 'TSBSalir
        cmdBoton(5).Enabled = True  'TSBBuscar       
        cmdBoton(6).Enabled = False 'TSBPerfil
        cmdBoton(7).Enabled = False 'TSBCanales
        cmdBoton(9).Enabled = False 'TSBContrato
        'cmdBoton(9).Visible = False 'TSBContrato
        PLTSEstado()

        If VGCodPais = "PA" Then cmdBoton(6).Enabled = False
        txtCampo(0).Enabled = True
        txtCampo(1).Enabled = True
        txtCampo(14).Enabled = True
        txtCampo(8).Enabled = True
        chkFuncionario.Checked = False
        txtCampo(19).Text = ""
        lblDescripcion(14).Text = ""
        txtCampo(3).Text = ""
        txtCampo(0).Focus()
        VLEnte = True
        VLyaingreso = 0
        cmbenvioec.SelectedIndex = 1
        VGPerfilCta = ""
        'optdir(1).Checked = True
        txtCampo(21).Text = ""
        lblDescripcion(22).Text = ""
        For n As Integer = 0 To VLTipoDireccion.GetUpperBound(0) - 1
            For C As Integer = 0 To VLTipoDireccion.GetUpperBound(1) - 1
                VLTipoDireccion(n, C) = ""
            Next C
        Next n
        txtCampo(0).Enabled = True
        txtCampo(1).Enabled = True
        Lblalianza.Text = ""
        lbldesalianza.Text = ""
        PLTSEstado()
        VLPaso = False
        mskCuenta.Mask = VGMascaraCtaAho
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
        mskCuenta.Enabled = False
        txtCampo(14).Focus()
    End Sub

    Private Sub PLSalir()
        Me.Close()
    End Sub

    Private Sub PLTransmitir()
        Dim VTOficina As String = String.Empty
        Dim VTTrn As String = String.Empty
        Dim VTPatente As String = ""
        Dim VTFuncionario As Integer = 0
        Dim VLProdbanc As String = ""
        Dim VLRespuesta As DialogResult
        Dim VTR As Integer = 0
        Dim VLTipoDoc As String = ""
        Dim VLFirmante As Integer = 0
        For i As Integer = 1 To grdPropietarios.Rows - 1
            grdPropietarios.Col = 5
            grdPropietarios.Row = i
            If (grdPropietarios.CtlText = "F") Or (grdPropietarios.CtlText = "U") Then
                VLFirmante += 1
                VLTutor = True
            End If
        Next i
        If VLTitular <= 0 Then
            COBISMessageBox.Show(FMLoadResString(501931), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If txtCampo(18).Text = "I" Then
            If VLTutor Then
                If grdPropietarios.Rows > 3 Then
                    COBISMessageBox.Show(FMLoadResString(2607), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(18).Focus()
                    Exit Sub
                End If
            Else
                If grdPropietarios.Rows > 2 Then
                    COBISMessageBox.Show(FMLoadResString(2607), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(18).Focus()
                    Exit Sub
                End If
            End If
        Else
            If VLTutor Then
                If (grdPropietarios.Rows - VLFirmante) <= 2 Then
                    COBISMessageBox.Show(FMLoadResString(2608), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(18).Focus()
                    Exit Sub
                End If
            Else
                If grdPropietarios.Rows <= 2 Then
                    COBISMessageBox.Show(FMLoadResString(2608), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(18).Focus()
                    Exit Sub
                End If
            End If
        End If
        If txtCampo(2).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501932), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(2).Focus()
            Exit Sub
        End If
        If txtCampo(8).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501933), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(8).Focus()
            Exit Sub
        End If
        If mskCuenta.Enabled = True And mskCuenta.ClipText = "" Then
            ' si eligio Producto de Aporte Social Adicional se activa campo Cta Relacionada
            'ERROR: Debe registrar Cuenta Relacionada para provisión de Intereses
            COBISMessageBox.Show(FMLoadResString(99834), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskCuenta.Focus()
            Exit Sub
        End If
        If mskCuenta.Enabled = True And mskCuenta.ClipText <> "" Then
            If FMChequeaCtaAho(mskCuenta.ClipText) Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                PMPasoValores(sqlconn, "@i_relacionada", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_consulta", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_codcliente", 0, SQLVARCHAR, VLCodTitular)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(502622) & " [" & mskCuenta.Text & "]") Then
                    PMChequea(sqlconn)
                Else
                    mskCuenta.Mask = VGMascaraCtaAho
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                    mskCuenta.Focus()
                    PMChequea(sqlconn)
                    Exit Sub
                End If
            Else
                COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskCuenta.Mask = VGMascaraCtaAho
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                mskCuenta.Focus()
                Exit Sub
            End If
        End If
        If txtCampo(9).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501933), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(9).Focus()
            Exit Sub
        End If
        If VGCodPais = "PA" Then
            If txtCampo(12).Text.Trim() <> "" Then
                VTPatente = txtCampo(12).Text
            End If
        Else
            VTPatente = " "
        End If
        If txtCampo(13).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501203), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If txtCampo(18).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501200), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(18).Visible And txtCampo(18).Enabled Then txtCampo(18).Focus()
            Exit Sub
        End If
        If VLNumero = 1 And txtCampo(18).Text <> "I" Then
            COBISMessageBox.Show(FMLoadResString(501267), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(18).Visible And txtCampo(18).Enabled Then txtCampo(18).Focus()
            Exit Sub
        End If
        If txtCampo(3).Text = "" Then
            txtCampo(3).Text = txtCampo(13).Text
            txtCampo(3).Tag = Convert.ToString(txtCampo(13).Tag)
            lblDescripcion(6).Text = lblDescripcion(15).Text
        End If
        If lblDescripcion(6).Text = "" And cmbenvioec.Text = "S" Then
            COBISMessageBox.Show(FMLoadResString(501934), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(21).Focus()
            Exit Sub
        End If
        If lblDescripcion(15).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501935), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(21).Focus()
            Exit Sub
        End If
        If txtCampo(4).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501199), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(4).Focus()
            Exit Sub
        End If
        If txtCampo(5).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501204), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If txtCampo(6).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501205), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If txtCampo(10).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501212), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(10).Focus()
            Exit Sub
        End If
        If txtCampo(7).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501207), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(7).Focus()
            Exit Sub
        End If
        If txtCampo(19).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501214), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(19).Visible And txtCampo(19).Enabled Then txtCampo(19).Focus()
            Exit Sub
        End If
        If Not FLVerificarTitularidad() Then
            Exit Sub
        End If
        If Not FLVerificarMenor() Then
            Exit Sub
        End If
        If Not FLVerificarExtranjero() Then
            Exit Sub
        End If
        PLArmadoNomCta()
        If VGAperCifrada Then
            VTTrn = "320"
        Else
            VTTrn = "201"
        End If
        grdPropietarios.Row = VLTitular
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, VTTrn)
        grdPropietarios.Col = 1
        PMPasoValores(sqlconn, "@i_cli", 0, SQLINT4, grdPropietarios.CtlText)
        PMPasoValores(sqlconn, "@i_cli1", 0, SQLINT4, VLCotitular)
        grdPropietarios.Col = 2
        PMPasoValores(sqlconn, "@i_cedruc", 0, SQLVARCHAR, grdPropietarios.CtlText)
        PMPasoValores(sqlconn, "@i_nombre", 0, SQLVARCHAR, txtCampo(2).Text)
        PMPasoValores(sqlconn, "@i_nombre1", 0, SQLVARCHAR, " ")
        If VLCedula1 <> "" Then
            VLCedula1 = " "
            PMPasoValores(sqlconn, "@i_cedruc1", 0, SQLVARCHAR, VLCedula1)
        Else
            VLCedula1 = " "
            PMPasoValores(sqlconn, "@i_cedruc1", 0, SQLVARCHAR, VLCedula1)
        End If
        If cmbenvioec.Text = "N" Then
            PMPasoValores(sqlconn, "@i_agencia", 0, SQLINT2, "0")
            PMPasoValores(sqlconn, "@i_direc", 0, SQLINT1, "0")
            PMPasoValores(sqlconn, "@i_cli_ec", 0, SQLINT4, "0")
            PMPasoValores(sqlconn, "@i_tipodir", 0, SQLCHAR, "N")
        ElseIf VLTipoDireccion(0, 0) = "D" Then
            PMPasoValores(sqlconn, "@i_direc", 0, SQLINT1, txtCampo(3).Text)
            PMPasoValores(sqlconn, "@i_cli_ec", 0, SQLINT4, Convert.ToString(txtCampo(3).Tag))
            PMPasoValores(sqlconn, "@i_tipodir", 0, SQLCHAR, "D")
        ElseIf VLTipoDireccion(0, 0) = "C" Then
            PMPasoValores(sqlconn, "@i_direc", 0, SQLINT1, txtCampo(3).Text)
            PMPasoValores(sqlconn, "@i_cli_ec", 0, SQLINT4, Convert.ToString(txtCampo(3).Tag))
            PMPasoValores(sqlconn, "@i_tipodir", 0, SQLCHAR, "C")
        ElseIf VLTipoDireccion(0, 0) = "S" Then
            PMPasoValores(sqlconn, "@i_casillero", 0, SQLVARCHAR, txtCampo(3).Text)
            PMPasoValores(sqlconn, "@i_tipodir", 0, SQLCHAR, "S")
        ElseIf VLTipoDireccion(0, 0) = "R" Then
            If txtCampo(3).Text.Trim() = "" Then
                VTOficina = VGOficina
            Else
                VTOficina = txtCampo(3).Text.Trim()
            End If
            PMPasoValores(sqlconn, "@i_agencia", 0, SQLINT2, VTOficina)
            PMPasoValores(sqlconn, "@i_tipodir", 0, SQLCHAR, "R")
        End If
        If VLTipoDireccion(1, 0) = "D" Then
            PMPasoValores(sqlconn, "@i_direc_dv", 0, SQLINT1, txtCampo(13).Text)
            PMPasoValores(sqlconn, "@i_cli_dv", 0, SQLINT4, Convert.ToString(txtCampo(13).Tag))
            PMPasoValores(sqlconn, "@i_tipodir_dv", 0, SQLCHAR, "D")
        ElseIf VLTipoDireccion(1, 0) = "C" Then
            PMPasoValores(sqlconn, "@i_direc_dv", 0, SQLINT1, txtCampo(13).Text)
            PMPasoValores(sqlconn, "@i_cli_dv", 0, SQLINT4, Convert.ToString(txtCampo(13).Tag))
            PMPasoValores(sqlconn, "@i_tipodir_dv", 0, SQLCHAR, "C")
        ElseIf VLTipoDireccion(1, 0) = "S" Then
            PMPasoValores(sqlconn, "@i_casillero_dv", 0, SQLVARCHAR, txtCampo(13).Text)
            PMPasoValores(sqlconn, "@i_tipodir_dv", 0, SQLCHAR, "S")
        ElseIf VLTipoDireccion(1, 0) = "R" Then
            If txtCampo(13).Text.Trim() = "" Then
                VTOficina = VGOficina
            Else
                VTOficina = txtCampo(13).Text.Trim()
            End If
            PMPasoValores(sqlconn, "@i_agencia_dv", 0, SQLINT2, VTOficina)
            PMPasoValores(sqlconn, "@i_tipodir_dv", 0, SQLCHAR, "R")
        End If
        PMPasoValores(sqlconn, "@i_ofl", 0, SQLINT2, txtCampo(4).Text)
        PMPasoValores(sqlconn, "@i_tprom", 0, SQLCHAR, txtCampo(5).Text)
        PMPasoValores(sqlconn, "@i_categ", 0, SQLCHAR, txtCampo(7).Text)
        PMPasoValores(sqlconn, "@i_tint", 0, SQLCHAR, txtCampo(7).Text)
        PMPasoValores(sqlconn, "@i_ciclo", 0, SQLCHAR, txtCampo(6).Text)
        PMPasoValores(sqlconn, "@i_capit", 0, SQLCHAR, txtCampo(10).Text)
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
        PMPasoValores(sqlconn, "@i_tdef", 0, SQLCHAR, "D")
        PMPasoValores(sqlconn, "@i_def", 0, SQLINT4, "0")
        PMPasoValores(sqlconn, "@i_rolente", 0, SQLCHAR, "1")
        PMPasoValores(sqlconn, "@i_rolcli", 0, SQLCHAR, "T")
        PMPasoValores(sqlconn, "@i_prodbanc", 0, SQLINT2, txtCampo(8).Text)
        'PMPasoValores(sqlconn, "@i_tipo_cta", 0, SQLINT2, txtCampo(8).Text)
        PMPasoValores(sqlconn, "@i_origen", 0, SQLVARCHAR, txtCampo(9).Text)
        PMPasoValores(sqlconn, "@i_numlib", 0, SQLINT4, "0")
        PMPasoValores(sqlconn, "@i_tipocta_super", 0, SQLCHAR, txtCampo(19).Text)
        If txtCampo(14).Text <> "" Then
            PMPasoValores(sqlconn, "@i_numsol", 0, SQLINT4, txtCampo(14).Text)
        Else
            grdPropietarios.Row = VLTitular
            grdPropietarios.Col = 1
            PMPasoValores(sqlconn, "@i_numsol", 0, SQLINT4, grdPropietarios.CtlText)
        End If
        If Mskvalor.Text = "" Then
            Mskvalor.Text = VGDecimales
            Mskvalor.Text = StringsHelper.Format(0, VGDecimales)
        End If
        PMPasoValores(sqlconn, "@i_valor", 0, SQLMONEY, Mskvalor.Text)
        PMPasoValores(sqlconn, "@o_funcio", 1, SQLINT1, "0")
        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
        If VGCodPais = "PA" Then
            If txtCampo(15).Text.Trim() <> "" Then
                PMPasoValores(sqlconn, "@i_fideicomiso", 0, SQLCHAR, txtCampo(15).Text)
            End If
        End If
        If VGContractual = "S" Then
            If VGPlazo = "" Or VGDeposito = "" Then
                COBISMessageBox.Show(FMLoadResString(2610), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtCampo(7).Focus()
            Else
                PMPasoValores(sqlconn, "@i_contractual", 0, SQLCHAR, VGContractual)
                PMPasoValores(sqlconn, "@i_plazo", 0, SQLINT2, VGPlazo)
                PMPasoValores(sqlconn, "@i_deposito", 0, SQLMONEY, VGDeposito)
                PMPasoValores(sqlconn, "@i_puntos", 0, SQLFLT8, StringsHelper.Format(VGPuntos, "0##.000000"))
                PMPasoValores(sqlconn, "@i_profinal", 0, SQLINT2, VGProdFinal)
                PMPasoValores(sqlconn, "@i_monto_final", 0, SQLMONEY, VGMontoFinal)
                PMPasoValores(sqlconn, "@i_periodicidad", 0, SQLCHAR, VGPeriodicidad)
                PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, VGEstado)
            End If
        End If
        PMPasoValores(sqlconn, "@i_estado_cuenta", 0, SQLCHAR, cmbenvioec.Text)
        PMPasoValores(sqlconn, "@i_titularidad", 0, SQLCHAR, txtCampo(18).Text)
        PMPasoValores(sqlconn, "@i_patente", 0, SQLVARCHAR, VTPatente)
        PMPasoValores(sqlconn, "@i_tipo_cta", 0, SQLINT2, txtCampo(8).Text)
        If mskCuenta.Enabled = True And mskCuenta.ClipText <> "" Then
            PMPasoValores(sqlconn, "@i_cta_banco_rel", 0, SQLVARCHAR, mskCuenta.ClipText)
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_apertura_ah", True, FMLoadResString(2611)) Then
            VGPerfilCta = "N"
            VGCancelar = "N"
            VGOrigen = "0"
            Dim VTArreglo(20) As String
            FMMapeaArreglo(sqlconn, VTArreglo)
            PMChequea(sqlconn)
            VTFuncionario = Conversion.Val(FMRetParam(sqlconn, 1))
            If VTFuncionario = 1 Then
                chkFuncionario.Checked = True
            End If
            For j As Integer = 1 To grdPropietarios.Rows - 1
                If j <> VLTitular Then
                    grdPropietarios.Row = j
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, VTTrn)
                    grdPropietarios.Col = 1
                    PMPasoValores(sqlconn, "@i_cli", 0, SQLINT4, grdPropietarios.CtlText)
                    grdPropietarios.Col = 2
                    PMPasoValores(sqlconn, "@i_cedruc", 0, SQLVARCHAR, grdPropietarios.CtlText)
                    grdPropietarios.Col = 5
                    PMPasoValores(sqlconn, "@i_rolcli", 0, SQLCHAR, grdPropietarios.CtlText)
                    PMPasoValores(sqlconn, "@i_dprod", 0, SQLINT4, VTArreglo(3))
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_cli1", 0, SQLINT4, "0")
                    PMPasoValores(sqlconn, "@i_estado_cuenta", 0, SQLCHAR, cmbenvioec.Text)
                    PMPasoValores(sqlconn, "@i_tipocta_super", 0, SQLCHAR, txtCampo(19).Text)
                    PMPasoValores(sqlconn, "@i_patente", 0, SQLVARCHAR, VTPatente)
                    PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, VTArreglo(1))
                    PMPasoValores(sqlconn, "@i_prodbanc", 0, SQLINT2, txtCampo(8).Text)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_apertura_ah", True, FMLoadResString(2532)) Then
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                    End If
                End If
                grdPropietarios.Col = 5
                If grdPropietarios.CtlText = "T" Then
                    grdPropietarios.Col = 3
                End If
            Next j
            lblDescripcion(0).Text = FMMascara(VTArreglo(1), VGMascaraCtaAho)
            VLCuenta0 = VTArreglo(1)
            lblDescripcion(1).Text = FMConvFecha(VTArreglo(2), CGFormatoBase, VGFormatoFecha)
            cmdBoton(0).Enabled = False
            cmdBoton(1).Enabled = False
            cmdBoton(2).Enabled = True
            PLTSEstado()
            If cmdBoton(9).Visible Then cmdBoton(9).Enabled = True
            If VGCodPais = "PA" Then cmdBoton(6).Enabled = True
            txtCampo(0).Enabled = False
            txtCampo(1).Enabled = False
            VLImprimio = False
            If txtCampo(8).Text = VLProdProgresivo Then
                COBISMessageBox.Show(FMLoadResString(2612), FMLoadResString(15001), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            End If
            VLProdbanc = txtCampo(8).Text
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "747")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "V")
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, VLProdbanc)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_relacion_cta_canal", True, FMLoadResString(2249)) Then
                PMMapeaVariable(sqlconn, VLProdBancBloq)
                PMChequea(sqlconn)
            Else
                PMChequea(sqlconn)
                VLProdBancBloq = ""
            End If

            If VGOcucol <> "S" Then
                If VLProdBancBloq <> "" Then
                    COBISMessageBox.Show(FMLoadResString(2613), FMLoadResString(15001), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                    Exit Sub
                End If
            End If
            
            If (CDbl(txtCampo(19).Text)) <> 1 Then
                Exit Sub
            ElseIf (txtCampo(18).Text) = "M" Then
                Exit Sub
            Else
                If VGOcucol <> "S" Then
                    VLRespuesta = COBISMessageBox.Show(FMLoadResString(2614), FMLoadResString(2615), COBISMessageBox.COBISButtons.YesNo)
                    If VLRespuesta = System.Windows.Forms.DialogResult.No Then
                        cmdBoton(2).Enabled = False
                        cmdBoton(7).Enabled = True
                        PLTSEstado()
                        Exit Sub
                    End If
                End If
                VGCuenta = VTArreglo(1)
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, VGCuenta)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, "") Then
                    ReDim VTArreglo(20)
                    FMMapeaArreglo(sqlconn, VTArreglo)
                    VLTitularidad = VTArreglo(4)
                    PMChequea(sqlconn)
                    If VLTitularidad = "CONJUNTA" Then
                        COBISMessageBox.Show(FMLoadResString(2605), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        Exit Sub
                    Else
                        VTR = grdPropietarios.Rows - 1
                        For i As Integer = 1 To VTR
                            grdPropietarios.Row = i
                            grdPropietarios.Col = 2
                            VLNumDoc = grdPropietarios.CtlText
                            VLTipoTran = "1610"
                            VGTipoDoc = ""
                            grdPropietarios.Col = 3
                            VLTipoDoc = grdPropietarios.CtlText
                            If VLTipoDoc = "C" Then
                                COBISMessageBox.Show(FMLoadResString(2606), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                                Exit Sub
                            End If
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1020")
                            PMPasoValores(sqlconn, "@i_frontend", 0, SQLCHAR, "S")
                            PMPasoValores(sqlconn, "@i_cedruc", 0, SQLVARCHAR, VLNumDoc)
                            PMPasoValores(sqlconn, "@o_tipoced", 1, SQLVARCHAR, "0")
                            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_datos_cliente", True, "") Then
                                PMMapeaVariable(sqlconn, VGTipoDoc)
                                PMChequea(sqlconn)
                            Else
                                PMChequea(sqlconn)
                            End If
                            FMRegistraHuellaAValidar(VGTipoDoc, VLNumDoc, VLTitularidad, VGCuenta, VLTipoTran)
                        Next i
                        If VGOcucol <> "S" Then
                            If VGValidaHuella Then
                                VLTipoTran = "1610"
                                FMVerificaHuella(VGCuenta, VLTipoTran)
                                If VGRegistraHuellaAValidar Then
                                    FRelCtaCanal.Show(Me)
                                    cmdBoton(2).Enabled = True
                                Else
                                    Exit Sub
                                End If
                            End If
                        End If
                        
                    End If
                Else
                    PMChequea(sqlconn)
                End If
            End If
            cmdBoton(2).Enabled = False
        Else
            PMChequea(sqlconn)
            lblDescripcion(0).Text = ""
            lblDescripcion(1).Text = ""
        End If
    End Sub

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_21.TextChanged, _txtCampo_15.TextChanged, _txtCampo_14.TextChanged, _txtCampo_18.TextChanged, _txtCampo_19.TextChanged, _txtCampo_12.TextChanged, _txtCampo_11.TextChanged, _txtCampo_9.TextChanged, _txtCampo_8.TextChanged, _txtCampo_10.TextChanged, _txtCampo_5.TextChanged, _txtCampo_4.TextChanged, _txtCampo_2.TextChanged, _txtCampo_1.TextChanged, _txtCampo_0.TextChanged, _txtCampo_6.TextChanged, _txtCampo_7.TextChanged, _txtCampo_13.TextChanged, _txtCampo_3.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 18, 19, 20, 12, 21
                VLPaso = False
            Case 14
                VLPaso = False
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_21.Enter, _txtCampo_15.Enter, _txtCampo_14.Enter, _txtCampo_18.Enter, _txtCampo_19.Enter, _txtCampo_12.Enter, _txtCampo_11.Enter, _txtCampo_9.Enter, _txtCampo_8.Enter, _txtCampo_10.Enter, _txtCampo_5.Enter, _txtCampo_4.Enter, _txtCampo_2.Enter, _txtCampo_1.Enter, _txtCampo_0.Enter, _txtCampo_6.Enter, _txtCampo_7.Enter, _txtCampo_13.Enter, _txtCampo_3.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500415))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501145))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501936))
            Case 3
                If VLTipoDireccion(0, 0) = "D" Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501218))
                ElseIf VLTipoDireccion(0, 0) = "C" Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501219))
                ElseIf VLTipoDireccion(0, 0) = "R" Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501220))
                ElseIf VLTipoDireccion(0, 0) = "S" Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501221))
                End If
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501222))
            Case 5
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501223))
            Case 6
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501224))
            Case 7
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501225))
            Case 8
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501226))
            Case 9
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501938))
            Case 10
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501939))
            Case 11
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501940))
            Case 12
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501233))
            Case 13
                If VLTipoDireccion(1, 0) = "D" Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501230))
                    txtCampo(13).MaxLength = 2
                ElseIf VLTipoDireccion(1, 0) = "C" Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501219))
                    txtCampo(13).MaxLength = 2
                ElseIf VLTipoDireccion(1, 0) = "R" Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501220))
                    txtCampo(13).MaxLength = 4
                ElseIf VLTipoDireccion(1, 0) = "S" Then
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501221))
                End If
            Case 14 'num_solicitud
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501094))
            Case 15 ' Fideicomiso
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5233))
            Case 18
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501234))
            Case 19
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501236))
            Case 21
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500802))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_21.KeyDown, _txtCampo_15.KeyDown, _txtCampo_14.KeyDown, _txtCampo_18.KeyDown, _txtCampo_19.KeyDown, _txtCampo_12.KeyDown, _txtCampo_11.KeyDown, _txtCampo_9.KeyDown, _txtCampo_8.KeyDown, _txtCampo_10.KeyDown, _txtCampo_5.KeyDown, _txtCampo_4.KeyDown, _txtCampo_2.KeyDown, _txtCampo_1.KeyDown, _txtCampo_0.KeyDown, _txtCampo_6.KeyDown, _txtCampo_7.KeyDown, _txtCampo_13.KeyDown, _txtCampo_3.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTCliente As String = String.Empty
        Dim VTTipoper As String = String.Empty
        Dim n As Integer = 0
        If KeyCode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 0 'Cliente
                    txtCampo(0).Text = ""
                    VLPaso = True
                    'DLL CLIENTES KAMILO
                    FBuscarCliente = New COBISCorp.tCOBIS.BClientes.FBuscarClienteClass()
                    FDatoCliente = New COBISCorp.tCOBIS.BClientes.BuscarClientes()
                    FBuscarCliente.optCliente(1).Enabled = True
                    FBuscarCliente.optCliente(0).Checked = True
                    FBuscarCliente.ShowPopup(Me)
                    FBuscarCliente.optCliente(1).Enabled = True
                    VGBusqueda = FDatoCliente.PMRetornaCliente()

                    If Not (VGBusqueda(1) Is Nothing) Then
                        If VGBusqueda(1) <> "" Then
                            txtCampo(0).Text = VGBusqueda(1)
                            lblDescripcion(3).Text = VGBusqueda(0)
                            If VGBusqueda(0) = "P" Then
                                lblDescripcion(2).Text = VGBusqueda(5)
                                VTCliente = VGBusqueda(2) & " " & VGBusqueda(3) & " " & VGBusqueda(4)
                                lblDescripcion(4).Text = VTCliente
                                VGTipoDoc = VGBusqueda(6)
                            Else
                                lblDescripcion(2).Text = VGBusqueda(3)
                                lblDescripcion(4).Text = VGBusqueda(2)
                                VGTipoDoc = VGBusqueda(4)
                            End If
                        End If
                    End If
                    Comprobar_cliente()
                Case 1 ' ROL
                    VLPaso = True
                    PMCatalogo("A", "cl_rol", _txtCampo_1, _lblDescripcion_5)
                    Comprobar_cliente()
                Case 3 'Cod. Dirección
                    If VLTipoDireccion(0, 0) = "" And cmbenvioec.Text = "S" Then
                        COBISMessageBox.Show(FMLoadResString(501942), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        VLPaso = True
                        txtCampo(3).Text = ""
                        txtCampo(21).Focus()
                        Exit Sub
                    End If
                    If VLTipoDireccion(0, 0) = "D" Then
                        If VLNumero <> 0 Then
                            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                            grdPropietarios.Col = 1
                            PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, grdPropietarios.CtlText)
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1227")
                            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_direccion_cons", True, FMLoadResString(2279)) Then
                                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                                PMChequea(sqlconn)
                                FCatalogo.ShowPopup(Me)
                                txtCampo(3).Text = VGACatalogo.Codigo
                                lblDescripcion(6).Text = VGACatalogo.Descripcion
                                grdPropietarios.Col = 1
                                txtCampo(3).Tag = grdPropietarios.CtlText
                                If txtCampo(3).Text <> "" Then
                                    VLPaso = True
                                End If
                            Else
                                PMChequea(sqlconn)
                                txtCampo(3).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(0).Focus()
                        End If
                    ElseIf VLTipoDireccion(0, 0) = "C" Then
                        If VLNumero <> 0 Then
                            grdPropietarios.Col = 5
                            If grdPropietarios.CtlText = "F" Then
                                COBISMessageBox.Show(FMLoadResString(501239), FMLoadResString(501240), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                                txtCampo(3).Text = ""
                                lblDescripcion(6).Text = ""
                                txtCampo(3).Tag = ""
                                Exit Sub
                            End If
                            PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
                            grdPropietarios.Col = 1
                            PMPasoValores(sqlconn, "@i_cli", 0, SQLINT4, grdPropietarios.CtlText)
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "92")
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_casilla", True, FMLoadResString(2617)) Then
                                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, True)
                                PMChequea(sqlconn)
                                VLPaso = True
                                FCatalogo.ShowPopup(Me)
                                txtCampo(3).Text = VGACatalogo.Codigo
                                lblDescripcion(6).Text = VGACatalogo.Descripcion
                                grdPropietarios.Col = 1
                                txtCampo(3).Tag = grdPropietarios.CtlText
                            Else
                                PMChequea(sqlconn)
                                txtCampo(3).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(0).Focus()
                        End If
                    ElseIf VLTipoDireccion(0, 0) = "R" Then
                        If VLNumero <> 0 Then
                            VGOperacion = "sp_agencia"
                            PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "O")
                            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "34")
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_agencia", True, FMLoadResString(2618)) Then
                                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                                PMChequea(sqlconn)
                                VLPaso = True
                                FCatalogo.ShowPopup(Me)
                                txtCampo(3).Text = VGACatalogo.Codigo
                                lblDescripcion(6).Text = VGACatalogo.Descripcion
                                grdPropietarios.Col = 1
                                txtCampo(3).Tag = grdPropietarios.CtlText
                            Else
                                PMChequea(sqlconn)
                                txtCampo(3).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(0).Focus()
                        End If
                    End If
                Case 4 ' Oficial de Cuenta
                    txtCampo(4).Text = ""
                    FHelpOficial.ShowPopup(Me)
                    If VGBusqueda(0) <> "*" Then
                        txtCampo(4).Text = VGBusqueda(0)
                        lblDescripcion(7).Text = VGBusqueda(1)
                        If txtCampo(4).Text <> "" Then
                            VLPaso = True
                        End If
                    Else
                        txtCampo(4).Text = ""
                        lblDescripcion(7).Text = ""
                    End If
                Case 5 ' Tipo de Promedio
                    PMCatalogo("A", "ah_tpromedio", txtCampo(5), lblDescripcion(8))
                    If txtCampo(5).Text <> "" Then
                        VLPaso = True
                    End If
                Case 6 ' Ciclo
                    txtCampo(6).Text = ""
                    PMCatalogo("A", "cc_ciclo", txtCampo(6), lblDescripcion(9))
                    If txtCampo(6).Text <> "" Then
                        VLPaso = True
                    End If
                Case 7 ' Categoria
                    If txtCampo(8).Text.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(501933), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(7).Text = ""
                        lblDescripcion(10).Text = ""
                        VLPaso = True
                        If txtCampo(19).Visible And txtCampo(19).Enabled Then txtCampo(19).Focus()
                        Exit Sub
                    End If
                    If VLTitular <= 0 Then
                        COBISMessageBox.Show(FMLoadResString(502006), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(7).Text = ""
                        lblDescripcion(10).Text = ""
                        txtCampo(0).Focus()
                        Exit Sub
                    Else
                        grdPropietarios.Row = VLTitular
                        grdPropietarios.Col = 3
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4101")
                    PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_cons_profinal", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_pro_bancario", 0, SQLINT2, txtCampo(8).Text)
                    PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.CtlText)
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_categoria_profinal", True, FMLoadResString(2534)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(7).Text = VGACatalogo.Codigo
                        lblDescripcion(10).Text = VGACatalogo.Descripcion
                        If txtCampo(7).Text.Trim() <> "" Then
                            VLPaso = True
                            If txtCampo(19).Visible And txtCampo(19).Enabled Then txtCampo(19).Focus()
                        End If
                        VGPlazo = ""
                        VGDeposito = ""
                        PLBuscar_marca()
                        If VGCancelar = "S" Then
                            txtCampo(7).Text = ""
                            lblDescripcion(10).Text = ""
                            txtCampo(7).Focus()
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
                Case 8 ' Prod. BAncario
                    If VLTitular <= 0 Then
                        COBISMessageBox.Show(FMLoadResString(501096), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(8).Text = ""
                        lblDescripcion(11).Text = ""
                        If txtCampo(8).Enabled Then txtCampo(8).Focus()
                        Exit Sub
                    Else
                        grdPropietarios.Row = VLTitular
                        grdPropietarios.Col = 3
                    End If
                    txtCampo(8).Text = ""
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "424")
                    PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "4")
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                    PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.CtlText)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_productoban", True, FMLoadResString(2533)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(8).Text = VGACatalogo.Codigo
                        lblDescripcion(11).Text = VGACatalogo.Descripcion
                    Else
                        PMChequea(sqlconn)
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4093")
                    PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_cons_profinal", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_pro_bancario", 0, SQLINT2, txtCampo(8).Text)
                    PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, VLTipoEnteTitular)
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "4")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, VGMoneda)
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_capitalizacion_profinal", True, FMLoadResString(2619)) Then
                        PMMapeaObjetoAB(sqlconn, txtCampo(10), lblDescripcion(13))
                        PMChequea(sqlconn)
                        txtCampo(10).Enabled = False
                    Else
                        PMChequea(sqlconn)
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4097")
                    PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_cons_profinal", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_pro_bancario", 0, SQLINT2, txtCampo(8).Text)
                    PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, VLTipoEnteTitular)
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "4")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, VGMoneda)
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_ciclo_profinal", True, FMLoadResString(2620)) Then
                        PMMapeaObjetoAB(sqlconn, txtCampo(6), lblDescripcion(9))
                        PMChequea(sqlconn)
                        txtCampo(6).Enabled = False
                    Else
                        PMChequea(sqlconn)
                    End If

                    'Si Producto Bancario es Aporte Social Adicional Activa el campo Cta RElacionada
                    If txtCampo(8).Text <> "" Then
                        Dim VLPAR As Integer
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "PCAASA")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLVARCHAR, "F")
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(2344)) Then
                            PMMapeaVariable(sqlconn, VLPAR)
                            If Val(txtCampo(8).Text) = VLPAR Then
                                mskCuenta.Enabled = True
                            Else
                                mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                                mskCuenta.Enabled = False
                            End If
                            PMChequea(sqlconn)
                        Else
                            mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                            mskCuenta.Enabled = False
                            PMChequea(sqlconn)
                        End If
                    End If

                Case 9 ' Origen de Cuenta
                    txtCampo(9).Text = ""
                    PMCatalogo("A", "ah_tipocta", txtCampo(9), lblDescripcion(12))
                    If txtCampo(9).Text <> "" Then
                        VLPaso = True
                    End If
                Case 10 ' Tipo Capitalización
                    PMCatalogo("A", "pe_capitalizacion", txtCampo(10), lblDescripcion(13))
                    If txtCampo(10).Text <> "" Then
                        VLPaso = True
                        txtCampo(7).Focus()
                    End If
                Case 13 ' Codigo Dirección
                    If VLTipoDireccion(1, 0) = "" Then
                        COBISMessageBox.Show(FMLoadResString(501244), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        VLPaso = True
                        txtCampo(13).Text = ""
                        txtCampo(21).Focus()
                        Exit Sub
                    End If
                    If VLTipoDireccion(1, 0) = "D" Then
                        If VLNumero <> 0 Then
                            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                            grdPropietarios.Col = 1
                            PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, grdPropietarios.CtlText)
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1227")
                            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_direccion_cons", True, FMLoadResString(2279)) Then
                                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                                PMChequea(sqlconn)
                                FCatalogo.ShowPopup(Me)
                                txtCampo(13).Text = VGACatalogo.Codigo
                                lblDescripcion(15).Text = VGACatalogo.Descripcion
                                grdPropietarios.Col = 1
                                txtCampo(13).Tag = grdPropietarios.CtlText
                                If txtCampo(13).Text <> "" Then
                                    VLPaso = True
                                End If
                            Else
                                PMChequea(sqlconn)
                                txtCampo(13).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(0).Focus()
                        End If
                    ElseIf VLTipoDireccion(1, 0) = "C" Then
                        If VLNumero <> 0 Then
                            grdPropietarios.Col = 5
                            If grdPropietarios.CtlText = "F" Then
                                COBISMessageBox.Show(FMLoadResString(501239), FMLoadResString(501240), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                                txtCampo(13).Text = ""
                                lblDescripcion(15).Text = ""
                                txtCampo(13).Tag = ""
                                Exit Sub
                            End If
                            PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
                            grdPropietarios.Col = 1
                            PMPasoValores(sqlconn, "@i_cli", 0, SQLINT4, grdPropietarios.CtlText)
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "92")
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_casilla", True, FMLoadResString(2617)) Then
                                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, True)
                                PMChequea(sqlconn)
                                VLPaso = True
                                FCatalogo.ShowPopup(Me)
                                txtCampo(13).Text = VGACatalogo.Codigo
                                lblDescripcion(15).Text = VGACatalogo.Descripcion
                                grdPropietarios.Col = 1
                                txtCampo(13).Tag = grdPropietarios.CtlText
                            Else
                                PMChequea(sqlconn)
                                txtCampo(13).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(0).Focus()
                        End If
                    ElseIf VLTipoDireccion(1, 0) = "R" Then
                        If VLNumero <> 0 Then
                            VGOperacion = "sp_agencia"
                            PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "O")
                            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "34")
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_agencia", True, FMLoadResString(2618)) Then
                                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                                PMChequea(sqlconn)
                                VLPaso = True
                                FCatalogo.ShowPopup(Me)
                                txtCampo(13).Text = VGACatalogo.Codigo
                                lblDescripcion(15).Text = VGACatalogo.Descripcion
                                grdPropietarios.Col = 1
                                txtCampo(13).Tag = grdPropietarios.CtlText
                            Else
                                PMChequea(sqlconn)
                                txtCampo(13).Tag = ""
                                txtCampo(13).Text = VGACatalogo.Codigo
                                lblDescripcion(15).Text = VGACatalogo.Descripcion
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(0).Focus()
                        End If
                    End If
                Case 18 ' Titularidad
                    PMCatalogo("A", "re_titularidad", txtCampo(18), lblDescripcion(20))
                    VLPaso = True
                Case 19 ' Cl. Cliente
                    If grdPropietarios.Rows <= 2 Then
                        grdPropietarios.Col = 1
                        grdPropietarios.Row = 1
                        If grdPropietarios.CtlText = "" Then
                            COBISMessageBox.Show(FMLoadResString(501242), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(0).Focus()
                            VLPaso = True
                            Exit Sub
                        End If
                    End If
                    grdPropietarios.Row = 1
                    grdPropietarios.Col = 3
                    VTTipoper = grdPropietarios.CtlText
                    grdPropietarios.Col = 1
                    PMCatalogo("A", "ah_cla_cliente", txtCampo(19), lblDescripcion(14))
                    VLPaso = True
                    If txtCampo(19).Text <> "" Then
                        If txtCampo(12).Visible And txtCampo(12).Enabled Then txtCampo(12).Focus()
                        If txtCampo(19).Text <> "1" And VTTipoper = "P" Then
                            COBISMessageBox.Show(FMLoadResString(501243), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(19).Text = ""
                            lblDescripcion(14).Text = ""
                            txtCampo(19).Focus()
                            Exit Sub
                        End If
                        If txtCampo(19).Text = "1" And VTTipoper = "C" Then
                            COBISMessageBox.Show(FMLoadResString(501243), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(19).Text = ""
                            lblDescripcion(14).Text = ""
                            txtCampo(19).Focus()
                            Exit Sub
                        End If
                    End If
                Case 21 ' Dirección
                    VLPaso = True
                    PMCatalogo("A", "cl_direccion_ec", txtCampo(21), lblDescripcion(22))
                    If txtCampo(21).Text <> "" Then
                        PLlblEtiqueta(txtCampo(21).Text)
                        n = IIf(optdir(0).Checked, 0, 1)
                        VLTipoDireccion(n, 0) = txtCampo(21).Text
                        VLTipoDireccion(n, 1) = lblDescripcion(22).Text
                    End If
            End Select
            VLPaso = True
        End If
        PLTSEstado()
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_21.KeyPress, _txtCampo_15.KeyPress, _txtCampo_14.KeyPress, _txtCampo_18.KeyPress, _txtCampo_19.KeyPress, _txtCampo_12.KeyPress, _txtCampo_11.KeyPress, _txtCampo_9.KeyPress, _txtCampo_8.KeyPress, _txtCampo_10.KeyPress, _txtCampo_5.KeyPress, _txtCampo_4.KeyPress, _txtCampo_2.KeyPress, _txtCampo_1.KeyPress, _txtCampo_0.KeyPress, _txtCampo_6.KeyPress, _txtCampo_7.KeyPress, _txtCampo_13.KeyPress, _txtCampo_3.KeyPress
        Dim keyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 3, 6, 4, 8, 9, 11, 13, 19
                keyAscii = FMVAlidaTipoDato("N", keyAscii)
            Case 1, 5, 10, 18, 21
                keyAscii = FMVAlidaTipoDato("A", keyAscii)
            Case 2
                keyAscii = FMVAlidaTipoDato("B", keyAscii)
            Case 12, 21
                keyAscii = Strings.AscW(Strings.Chr(keyAscii).ToString().ToUpper())
            Case 14
                If (keyAscii <> 8) And ((keyAscii < 48) Or (keyAscii > 57)) Then
                    keyAscii = 0
                End If
            Case 7, 15
                keyAscii = FMVAlidaTipoDato("U", keyAscii)
        End Select
        If keyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(keyAscii)
    End Sub

    Sub Comprobar_cliente()
        If txtCampo(0).Text <> "" And txtCampo(1).Text <> "" Then
            cmdBoton(0).Enabled = True ' TSBAnadir
        Else
            cmdBoton(0).Enabled = False ' TSBAnadir
        End If
        PLTSEstado()
    End Sub

    Public Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_21.Leave, _txtCampo_15.Leave, _txtCampo_14.Leave, _txtCampo_18.Leave, _txtCampo_19.Leave, _txtCampo_12.Leave, _txtCampo_11.Leave, _txtCampo_9.Leave, _txtCampo_8.Leave, _txtCampo_10.Leave, _txtCampo_5.Leave, _txtCampo_4.Leave, _txtCampo_2.Leave, _txtCampo_1.Leave, _txtCampo_0.Leave, _txtCampo_6.Leave, _txtCampo_7.Leave, _txtCampo_13.Leave, _txtCampo_3.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VLAlianza As String = ""
        Dim VLDesAlianza As String = ""
        Dim VTSubtipo As String = String.Empty
        Dim VLBloqueado As String = ""
        Dim VLMalaref As String = ""
        Dim VLLista As String = ""
        Dim VTTipoper As String = ""
        Dim n As Integer = 0
        Select Case Index
            Case 0 ' Cliente
                If Not VLPaso Then
                    If txtCampo(0).Text <> "" Then
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_cliente", 0, SQLINT4, txtCampo(0).Text)
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1181")
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_desc_cliente", True, FMLoadResString(2239) & " [" & txtCampo(0).Text & "]") Then
                            Dim VTValores(15) As String
                            FMMapeaArreglo(sqlconn, VTValores)
                            PMMapeaVariable(sqlconn, VLAlianza)
                            PMMapeaVariable(sqlconn, VLDesAlianza)
                            PMChequea(sqlconn)
                            VTSubtipo = VTValores(3)
                            lblDescripcion(3).Text = VTSubtipo
                            If VTSubtipo = "P" Then
                                lblDescripcion(2).Text = VTValores(1)
                                VTCliente = VTValores(2)
                                lblDescripcion(4).Text = VTCliente
                            Else
                                lblDescripcion(2).Text = VTValores(1)
                                lblDescripcion(4).Text = VTValores(2)
                            End If
                            Lblalianza.Text = VLAlianza
                            lbldesalianza.Text = VLDesAlianza
                            If txtCampo(1).Text = "" Then
                                txtCampo(1).Focus()
                            Else
                                cmdBoton(0).Focus()
                            End If
                        Else
                            PMChequea(sqlconn)
                            txtCampo(0).Text = ""
                            lblDescripcion(2).Text = ""
                            lblDescripcion(4).Text = ""
                            lblDescripcion(3).Text = ""
                            Lblalianza.Text = ""
                            lbldesalianza.Text = ""
                            txtCampo(0).Focus()
                        End If
                    Else
                        lblDescripcion(2).Text = ""
                        lblDescripcion(4).Text = ""
                        lblDescripcion(3).Text = ""
                    End If
                End If

                If txtCampo(0).Text <> "" Then
                    VLMensajeBlq = ""
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "175")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "B")
                    PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, txtCampo(0).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_ente_bloqueado", True, FMLoadResString(2240)) Then
                        PMMapeaVariable(sqlconn, VLBloqueado)
                        PMMapeaVariable(sqlconn, VLMalaref)
                        PMMapeaVariable(sqlconn, VLLista)
                        PMMapeaVariable(sqlconn, VLMensajeBlq)
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        lblDescripcion(2).Text = ""
                        lblDescripcion(3).Text = ""
                        lblDescripcion(4).Text = ""
                        txtCampo(0).Text = ""
                        txtCampo(0).Focus()
                        Exit Sub
                    End If
                    If VLBloqueado = "S" And VLMalaref = "N" Then
                        COBISMessageBox.Show(FMLoadResString(2241), FMLoadResString(2242), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                        lblDescripcion(2).Text = ""
                        lblDescripcion(3).Text = ""
                        lblDescripcion(4).Text = ""
                        txtCampo(0).Text = ""
                        txtCampo(0).Focus()
                        txtCampo(0).Text = ""
                        txtCampo(0).Focus()
                        Exit Sub
                    End If
                    If VLMalaref = "S" And VLMensajeBlq <> "" Then
                        COBISMessageBox.Show(VLMensajeBlq, FMLoadResString(2243), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                        lblDescripcion(2).Text = ""
                        lblDescripcion(3).Text = ""
                        lblDescripcion(4).Text = ""
                        txtCampo(0).Text = ""
                        txtCampo(0).Focus()
                        Exit Sub
                    End If
                    If VLMalaref = "N" And VLMensajeBlq <> "" Then
                        COBISMessageBox.Show(VLMensajeBlq, FMLoadResString(2243), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                    End If
                End If
                Comprobar_cliente()
            Case 1 ' Rol
                If Not VLPaso Then
                    If txtCampo(1).Text <> "" Then
                        PMCatalogo("V", "cl_rol", txtCampo(1), lblDescripcion(5))
                        VLPaso = True
                    Else
                        lblDescripcion(5).Text = ""
                    End If
                End If
                Comprobar_cliente()
            Case 3
                If Not VLPaso Then
                    If VLTipoDireccion(0, 0) = "" And cmbenvioec.Text = "S" Then
                        COBISMessageBox.Show(FMLoadResString(501942), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        VLPaso = True
                        txtCampo(3).Text = ""
                        txtCampo(21).Focus()
                        Exit Sub
                    End If
                    If VLTipoDireccion(0, 0) = "D" Then
                        If VLNumero <> 0 Then
                            If txtCampo(3).Text <> "" Then
                                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                                grdPropietarios.Col = 1
                                PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, grdPropietarios.CtlText)
                                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                                PMPasoValores(sqlconn, "@i_direccion", 0, SQLINT2, txtCampo(3).Text)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1229")
                                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_direccion_cons", True, FMLoadResString(2600) & " [" & txtCampo(Index).Text & "]") Then
                                    PMMapeaObjeto(sqlconn, lblDescripcion(6))
                                    PMChequea(sqlconn)
                                    grdPropietarios.Col = 1
                                    txtCampo(3).Tag = grdPropietarios.CtlText
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(3).Text = ""
                                    lblDescripcion(6).Text = ""
                                    txtCampo(3).Tag = ""
                                    txtCampo(3).Focus()
                                End If
                            Else
                                lblDescripcion(6).Text = ""
                                txtCampo(3).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(3).Tag = ""
                            txtCampo(0).Focus()
                        End If
                    ElseIf VLTipoDireccion(1, 0) = "C" Then
                        If VLNumero <> 0 Then
                            If txtCampo(3).Text <> "" Then
                                grdPropietarios.Col = 5
                                If grdPropietarios.CtlText = "F" Then
                                    COBISMessageBox.Show(FMLoadResString(501239), FMLoadResString(501240), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                                    txtCampo(3).Text = ""
                                    lblDescripcion(6).Text = ""
                                    txtCampo(3).Tag = ""
                                    Exit Sub
                                End If
                                PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "V")
                                grdPropietarios.Col = 1
                                PMPasoValores(sqlconn, "@i_cli", 0, SQLINT4, grdPropietarios.CtlText)
                                PMPasoValores(sqlconn, "@i_casi", 0, SQLINT2, txtCampo(3).Text)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "92")
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_casilla", True, FMLoadResString(2617) & " [" & txtCampo(Index).Text & "]") Then
                                    PMMapeaObjeto(sqlconn, lblDescripcion(6))
                                    PMChequea(sqlconn)
                                    grdPropietarios.Col = 1
                                    txtCampo(3).Tag = grdPropietarios.CtlText
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(3).Text = ""
                                    lblDescripcion(6).Text = ""
                                    txtCampo(3).Tag = ""
                                    txtCampo(3).Focus()
                                End If
                            Else
                                lblDescripcion(6).Text = ""
                                txtCampo(3).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(3).Tag = ""
                            txtCampo(0).Focus()
                        End If
                    ElseIf VLTipoDireccion(0, 0) = "R" Then
                        If VLNumero <> 0 Then
                            If txtCampo(3).Text <> "" Then
                                PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "H")
                                PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, txtCampo(3).Text)
                                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "34")
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_agencia", True, FMLoadResString(2618)) Then
                                    PMMapeaObjeto(sqlconn, lblDescripcion(6))
                                    PMChequea(sqlconn)
                                    grdPropietarios.Col = 1
                                    txtCampo(3).Tag = grdPropietarios.CtlText
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(3).Text = ""
                                    lblDescripcion(6).Text = ""
                                    txtCampo(3).Tag = ""
                                    txtCampo(3).Focus()
                                End If
                            Else
                                lblDescripcion(6).Text = ""
                                txtCampo(3).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(3).Tag = ""
                            txtCampo(0).Focus()
                        End If
                    End If
                End If
                VLPaso = True
            Case 4
                If Not VLPaso Then
                    If txtCampo(4).Text <> "" Then
                        If CDbl(txtCampo(4).Text) >= 32000 Then
                            COBISMessageBox.Show(FMLoadResString(2621), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(4).Focus()
                            Exit Sub
                        End If
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "15153")
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_oficial", 0, SQLINT2, txtCampo(4).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_tr_cons_oficiales", True, FMLoadResString(2622)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(7))
                            PMChequea(sqlconn)
                            VLPaso = True
                        Else
                            PMChequea(sqlconn)
                            txtCampo(4).Text = ""
                            lblDescripcion(7).Text = ""
                            txtCampo(4).Focus()
                        End If
                    Else
                        lblDescripcion(7).Text = ""
                    End If
                End If
            Case 5
                If Not VLPaso Then
                    If txtCampo(5).Text <> "" Then
                        PMCatalogo("V", "ah_tpromedio", txtCampo(5), lblDescripcion(8))
                        VLPaso = True
                    Else
                        lblDescripcion(8).Text = ""
                    End If
                End If
            Case 6
                If Not VLPaso Then
                    If txtCampo(6).Text <> "" Then
                        PMCatalogo("V", "cc_ciclo", txtCampo(6), lblDescripcion(9))
                        VLPaso = True
                    Else
                        lblDescripcion(9).Text = ""
                    End If
                End If
            Case 7
                If Not VLPaso Then
                    If txtCampo(7).Text.Trim() <> "" Then
                        If txtCampo(8).Text.Trim() = "" Then
                            COBISMessageBox.Show(FMLoadResString(501933), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(7).Text = ""
                            lblDescripcion(10).Text = ""
                            If txtCampo(8).Enabled Then txtCampo(8).Focus()
                            Exit Sub
                        End If
                        If VLTitular <= 0 Then
                            COBISMessageBox.Show(FMLoadResString(501931), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(7).Text = ""
                            lblDescripcion(10).Text = ""
                            txtCampo(0).Focus()
                            Exit Sub
                        Else
                            grdPropietarios.Row = VLTitular
                            grdPropietarios.Col = 3
                        End If
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4101")
                        PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_cons_profinal", 0, SQLCHAR, "S")
                        PMPasoValores(sqlconn, "@i_pro_bancario", 0, SQLINT2, txtCampo(8).Text)
                        PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.CtlText)
                        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGMoneda)
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                        PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(7).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_categoria_profinal", True, FMLoadResString(2534)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(10))
                            PMChequea(sqlconn)
                            VLPaso = True
                            VGPlazo = ""
                            VGDeposito = ""
                            PLBuscar_marca()
                            If VGCancelar = "S" Then
                                VGCancelar = "N"
                                txtCampo(7).Text = ""
                                lblDescripcion(10).Text = ""
                            End If
                        Else
                            PMChequea(sqlconn)
                            txtCampo(7).Text = ""
                            lblDescripcion(10).Text = ""
                        End If
                    Else
                        lblDescripcion(10).Text = ""
                    End If
                End If
            Case 8
                If Not VLPaso Then
                    If txtCampo(8).Text <> "" Then
                        If VLTitular <= 0 Then
                            COBISMessageBox.Show(FMLoadResString(501096), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(8).Text = ""
                            lblDescripcion(8).Text = ""
                            If txtCampo(8).Enabled Then txtCampo(8).Focus()
                            Exit Sub
                        Else
                            grdPropietarios.Row = VLTitular
                            grdPropietarios.Col = 3
                        End If
                        txtCampo(7).Text = ""
                        lblDescripcion(10).Text = ""
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "424")
                        PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_prodfin", 0, SQLINT2, txtCampo(8).Text)
                        PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "4")
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                        PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.CtlText)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_productoban", True, FMLoadResString(2466)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(11))
                            PMChequea(sqlconn)
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4093")
                            PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "H")
                            PMPasoValores(sqlconn, "@i_cons_profinal", 0, SQLCHAR, "S")
                            PMPasoValores(sqlconn, "@i_pro_bancario", 0, SQLINT2, txtCampo(8).Text)
                            PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, VLTipoEnteTitular)
                            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "4")
                            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                            PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, VGMoneda)
                            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_capitalizacion_profinal", True, FMLoadResString(2619)) Then
                                PMMapeaObjetoAB(sqlconn, txtCampo(10), lblDescripcion(13))
                                PMChequea(sqlconn)
                                txtCampo(10).Enabled = False
                            Else
                                PMChequea(sqlconn)
                            End If
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4097")
                            PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "H")
                            PMPasoValores(sqlconn, "@i_cons_profinal", 0, SQLCHAR, "S")
                            PMPasoValores(sqlconn, "@i_pro_bancario", 0, SQLINT2, txtCampo(8).Text)
                            PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, VLTipoEnteTitular)
                            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "4")
                            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                            PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT2, VGMoneda)
                            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_ciclo_profinal", True, FMLoadResString(2620)) Then
                                PMMapeaObjetoAB(sqlconn, txtCampo(6), lblDescripcion(9))
                                PMChequea(sqlconn)
                                txtCampo(6).Enabled = False
                            Else
                                PMChequea(sqlconn)
                            End If
                            VLPaso = True
                        Else
                            PMChequea(sqlconn)
                            txtCampo(8).Text = ""
                            lblDescripcion(11).Text = ""
                            txtCampo(6).Text = ""
                            lblDescripcion(9).Text = ""
                            txtCampo(10).Text = ""
                            lblDescripcion(13).Text = ""
                            If txtCampo(8).Enabled Then txtCampo(8).Focus()
                        End If
                    Else
                        lblDescripcion(11).Text = ""
                        txtCampo(7).Text = ""
                        lblDescripcion(10).Text = ""
                        txtCampo(6).Text = ""
                        lblDescripcion(9).Text = ""
                        txtCampo(10).Text = ""
                        lblDescripcion(13).Text = ""
                    End If
                    'Si Producto Bancario es Aporte Social Adicional Activa el campo Cta RElacionada
                    Dim VLPAR As Integer
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                    PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "PCAASA")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLVARCHAR, "F")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(99835)) Then
                        PMMapeaVariable(sqlconn, VLPAR)
                        If Val(txtCampo(8).Text) = VLPAR Then
                            mskCuenta.Enabled = True
                        Else
                            mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                            mskCuenta.Enabled = False
                        End If
                        PMChequea(sqlconn)
                    Else
                        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                        mskCuenta.Enabled = False
                        PMChequea(sqlconn)
                    End If
                End If
            Case 9
                If Not VLPaso Then
                    If txtCampo(9).Text <> "" Then
                        PMCatalogo("V", "ah_tipocta", txtCampo(9), lblDescripcion(12))
                    Else
                        lblDescripcion(12).Text = ""
                    End If
                End If
            Case 10
                If Not VLPaso Then
                    If txtCampo(10).Text <> "" Then
                        PMCatalogo("V", "pe_capitalizacion", txtCampo(10), lblDescripcion(13))
                        VLPaso = True
                    Else
                        lblDescripcion(13).Text = ""
                    End If
                End If
            Case 13
                If Not VLPaso Then
                    If VLTipoDireccion(1, 0) = "" Then
                        COBISMessageBox.Show(FMLoadResString(501244), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        VLPaso = True
                        txtCampo(13).Text = ""
                        txtCampo(21).Select()
                        Exit Sub
                    End If
                    If VLTipoDireccion(1, 0) = "D" Then
                        If VLNumero <> 0 Then
                            If txtCampo(13).Text <> "" Then
                                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                                grdPropietarios.Col = 1
                                PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, grdPropietarios.CtlText)
                                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                                PMPasoValores(sqlconn, "@i_direccion", 0, SQLINT2, txtCampo(13).Text)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1229")
                                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_direccion_cons", True, FMLoadResString(2600) & " [" & txtCampo(Index).Text & "]") Then
                                    PMMapeaObjeto(sqlconn, lblDescripcion(15))
                                    PMChequea(sqlconn)
                                    grdPropietarios.Col = 1
                                    txtCampo(13).Tag = grdPropietarios.CtlText
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(13).Text = ""
                                    lblDescripcion(15).Text = ""
                                    txtCampo(13).Tag = ""
                                    txtCampo(13).Focus()
                                End If
                            Else
                                lblDescripcion(15).Text = ""
                                txtCampo(13).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(13).Tag = ""
                            txtCampo(13).Text = ""
                            lblDescripcion(15).Text = ""
                            txtCampo(0).Focus()
                        End If
                    ElseIf VLTipoDireccion(1, 0) = "C" Then
                        If VLNumero <> 0 Then
                            If txtCampo(13).Text <> "" Then
                                grdPropietarios.Col = 5
                                If grdPropietarios.CtlText = "F" Then
                                    COBISMessageBox.Show(FMLoadResString(501239), FMLoadResString(501240), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                                    txtCampo(13).Text = ""
                                    lblDescripcion(15).Text = ""
                                    txtCampo(13).Tag = ""
                                    Exit Sub
                                End If
                                PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "V")
                                grdPropietarios.Col = 1
                                PMPasoValores(sqlconn, "@i_cli", 0, SQLINT4, grdPropietarios.CtlText)
                                PMPasoValores(sqlconn, "@i_casi", 0, SQLINT2, txtCampo(13).Text)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "92")
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_casilla", True, FMLoadResString(2617) & " [" & txtCampo(Index).Text & "]") Then
                                    PMMapeaObjeto(sqlconn, lblDescripcion(15))
                                    PMChequea(sqlconn)
                                    grdPropietarios.Col = 1
                                    txtCampo(13).Tag = grdPropietarios.CtlText
                                Else
                                    PMChequea(sqlconn)
                                    txtCampo(13).Text = ""
                                    lblDescripcion(15).Text = ""
                                    txtCampo(13).Tag = ""
                                    txtCampo(13).Focus()
                                End If
                            Else
                                lblDescripcion(15).Text = ""
                                txtCampo(13).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(13).Tag = ""
                            txtCampo(0).Focus()
                        End If
                    ElseIf VLTipoDireccion(1, 0) = "R" Then
                        If VLNumero <> 0 Then
                            If txtCampo(13).Text <> "" Then
                                PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "H")
                                PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, txtCampo(13).Text)
                                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "34")
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_agencia", True, FMLoadResString(2618)) Then
                                    PMMapeaObjeto(sqlconn, lblDescripcion(15))
                                    PMChequea(sqlconn)
                                    grdPropietarios.Col = 1
                                    txtCampo(13).Tag = grdPropietarios.CtlText
                                Else
                                    txtCampo(13).Text = ""
                                    lblDescripcion(15).Text = ""
                                    txtCampo(13).Tag = ""
                                    txtCampo(13).Focus()
                                    PMChequea(sqlconn)
                                End If
                            Else
                                lblDescripcion(15).Text = ""
                                txtCampo(13).Tag = ""
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(501238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(13).Tag = ""
                            txtCampo(0).Focus()
                        End If
                    End If
                End If
                VLPaso = True
            Case 14
                If txtCampo(14).Text <> "" Then
                    If VLPaso = False Then
                        VLPaso = True
                        PLBuscar()
                        grdPropietarios.Row = 1
                        grdPropietarios.Col = 1
                        If grdPropietarios.CtlText <> "" Then
                            VLCodTitular = CInt(grdPropietarios.CtlText)
                            plAlianza()
                        End If

                    End If
                End If
            Case 18
                If Not VLPaso Then
                    If txtCampo(18).Text <> "" Then
                        PMCatalogo("V", "re_titularidad", txtCampo(18), lblDescripcion(20))
                    Else
                        lblDescripcion(20).Text = ""
                    End If
                End If
            Case 19
                If Not VLPaso Then
                    If grdPropietarios.Rows <= 2 Then
                        grdPropietarios.Col = 1
                        grdPropietarios.Row = 1
                        If grdPropietarios.CtlText = "" Then
                            COBISMessageBox.Show(FMLoadResString(501242), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(19).Text = ""
                            txtCampo(0).Focus()
                            Exit Sub
                        End If
                    End If
                    grdPropietarios.Row = 1
                    grdPropietarios.Col = 3
                    VTTipoper = grdPropietarios.CtlText
                    grdPropietarios.Col = 1
                End If
                If Not VLPaso Then
                    If txtCampo(19).Text <> "" Then
                        PMCatalogo("V", "ah_cla_cliente", txtCampo(19), lblDescripcion(14))
                        If txtCampo(19).Text <> "1" And VTTipoper = "P" Then
                            COBISMessageBox.Show(FMLoadResString(501243), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(19).Text = ""
                            lblDescripcion(14).Text = ""
                            txtCampo(19).Focus()
                            Exit Sub
                        End If
                        If txtCampo(19).Text = "1" And VTTipoper = "C" Then
                            COBISMessageBox.Show(FMLoadResString(501243), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(19).Text = ""
                            lblDescripcion(14).Text = ""
                            txtCampo(19).Focus()
                            Exit Sub
                        End If
                        VLPaso = True
                    Else
                        lblDescripcion(14).Text = ""
                    End If
                End If
            Case 21 ' Dirección
                If Not VLPaso Then
                    If txtCampo(21).Text <> "" Then
                        PMCatalogo("V", "cl_direccion_ec", txtCampo(21), lblDescripcion(22))
                        n = IIf(optdir(0).Checked, 0, 1)
                        VLTipoDireccion(n, 0) = txtCampo(21).Text
                        VLTipoDireccion(n, 1) = lblDescripcion(22).Text
                        PLlblEtiqueta(txtCampo(21).Text)
                    End If
                End If
        End Select
        PLTSEstado()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Function FLVerificarTitularidad() As Boolean
        Dim result As Boolean = False
        Dim VTCadena As String = ""
        Dim vti As Integer = 0
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "344")
        PMPasoValores(sqlconn, "@i_prod_banc", 0, SQLINT2, txtCampo(8).Text)
        For j As Integer = 1 To grdPropietarios.Rows - 1
            grdPropietarios.Row = j
            grdPropietarios.Col = 5
            VTCadena = ""
            If grdPropietarios.CtlText = "T" Or grdPropietarios.CtlText = "C" Then
                vti += 1
                grdPropietarios.Col = 1
                VTCadena = VTCadena & (grdPropietarios.CtlText) & "@"
                grdPropietarios.Col = 4
                VTCadena = VTCadena & (grdPropietarios.CtlText) & "@"
                PMPasoValores(sqlconn, "@i_param" & vti, 0, SQLCHAR, VTCadena)
            End If
        Next j
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_valida_titularidad", True, FMLoadResString(2528)) Then
            PMChequea(sqlconn)
            vti = FMRetStatus(sqlconn)
            If vti <> 0 Then
                Return result
            End If
            Return True
        Else
            PMChequea(sqlconn)
            Return result
        End If
        PLTSEstado()
        Return result
    End Function

    Private Function FLVerificarMenor() As Boolean
        Dim result As Boolean = False
        Dim VTCadena As String = ""
        Dim vti As Integer = 0
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "350")
        'II JSA CUENTAS MENOR DE EDAD
        If txtCampo(8).Text <> "" Then 'JSA
            PMPasoValores(sqlconn, "@i_prod_banc", 0, SQLCHAR, txtCampo(8).Text)
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
        End If
        'FI JSA CUENTAS MENOR DE EDAD
        For j As Integer = 1 To grdPropietarios.Rows - 1
            grdPropietarios.Row = j
            grdPropietarios.Col = 5
            VTCadena = ""
            vti += 1
            grdPropietarios.Col = 1
            VTCadena = VTCadena & (grdPropietarios.CtlText) & "@"
            grdPropietarios.Col = 5
            VTCadena = VTCadena & (grdPropietarios.CtlText) & "@"
            grdPropietarios.Col = 4
            VTCadena = VTCadena & (grdPropietarios.CtlText) & "@"
            PMPasoValores(sqlconn, "@i_param" & vti, 0, SQLCHAR, VTCadena)
        Next j
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_valida_menor", True, FMLoadResString(2528)) Then
            'II JSA CUENTAS MENOR DE EDAD
            PMMapeaVariable(sqlconn, VTCadena)
            If VTCadena <> "" Then
                COBISMessageBox.Show(VTCadena, FMLoadResString(500092), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            End If
            'FI JSA CUENTAS MENOR DE EDAD
            PMChequea(sqlconn)
            vti = FMRetStatus(sqlconn)
            If vti <> 0 Then
                Return result
            End If
            Return True
        Else
            PMChequea(sqlconn)
            Return result
        End If
        PLTSEstado()
        Return result
    End Function

    Public Sub PLBuscar()
        Dim VTR As Integer = 0
        Dim VLCed As String = ""

        If txtCampo(14).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501082), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(10).Enabled Then txtCampo(10).Focus()
            Exit Sub
        End If

        VLSolicitud = Val(txtCampo(14).Text)
        PLLimpiar()

        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "355")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_numsol", 0, SQLINT4, VLSolicitud)
        PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, VGOficina)
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "SI")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_solicitud_apertura", True, FMLoadResString(2464)) Then
            Dim VTArreglo(20) As String
            FMMapeaArreglo(sqlconn, VTArreglo)
            PMChequea(sqlconn)
            If VTArreglo(9) = "AP" Then
                cmdBoton(5).Enabled = False
                cmdBoton(2).Enabled = True
                txtCampo(14).Enabled = False
                txtCampo(14).Text = VLSolicitud
            Else
                If VTArreglo(9) = "PR" Then
                    COBISMessageBox.Show(FMLoadResString(501088), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Else
                    COBISMessageBox.Show(FMLoadResString(501193), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                End If
                VLPaso = False
                txtCampo(14).Text = ""
                If txtCampo(14).Visible And txtCampo(14).Enabled Then txtCampo(14).Focus()
                Exit Sub
            End If
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "356")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S1")
            PMPasoValores(sqlconn, "@i_numsol", 0, SQLINT4, VLSolicitud)
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_solicitud_apertura", True, FMLoadResString(2464)) Then
                Dim Valores(8, 40) As String
                VTR = FMMapeaMatriz(sqlconn, Valores)
                For i As Integer = 1 To VTR
                    If Valores(1, i) <> "" Then
                        VLCed = Valores(1, i)
                    Else
                        VLCed = Valores(2, i)
                    End If
                    grdPropietarios.AddItem(Conversion.Str(i) & ChrW(9) & Valores(0, i) & ChrW(9) & VLCed & ChrW(9) & Valores(3, i) & ChrW(9) & Valores(4, i) & ChrW(9) & Valores(5, i) & ChrW(9) & Valores(6, i))
                Next i
                Dim ValEnte(16) As String
                FMMapeaArreglo(sqlconn, ValEnte)
                PMChequea(sqlconn)
                If VGCodPais = "CO" Then
                    txtCampo(0).Enabled = False
                    txtCampo(1).Enabled = False
                End If
            Else
                PMChequea(sqlconn)
            End If
            If grdPropietarios.Rows > 2 Then
                grdPropietarios.RemoveItem(1)
            End If
            'PLAjustaGrid(grdPropietarios, Me)
            PMAnchoColumnasGrid(grdPropietarios)
            grdPropietarios.Row = 0
            grdPropietarios.Col = 1
            grdPropietarios.CtlText = FMLoadResString(9919) '"CODIGO"
            grdPropietarios.Col = 2
            grdPropietarios.CtlText = FMLoadResString(9938) '"IDENTIFICACION"
            grdPropietarios.Col = 3
            grdPropietarios.CtlText = "TP."
            grdPropietarios.Col = 4
            grdPropietarios.CtlText = FMLoadResString(9940) '"NOMBRE"
            grdPropietarios.Col = 5
            grdPropietarios.CtlText = FMLoadResString(9101) '"TIT."
            grdPropietarios.Col = 6
            grdPropietarios.CtlText = FMLoadResString(9942) '"DESCRIPCION"
            VLTitular = 1
            grdPropietarios.Tag = "T"
            For j As Integer = 1 To grdPropietarios.Rows - 1
                grdPropietarios.Row = j
                grdPropietarios.Col = 5
                If grdPropietarios.CtlText.Trim() = "T" Then
                    grdPropietarios.Col = 4
                    txtCampo(2).Text = grdPropietarios.CtlText
                    grdPropietarios.Col = 1
                    VLCodTitular = CInt(grdPropietarios.CtlText)
                    VLTitular = j
                    grdPropietarios.Col = 3
                    VLTipoEnteTitular = grdPropietarios.CtlText
                    VLyaingreso = 1
                End If
                VLNumero += 1
            Next j
            grdPropietarios.Row = 1
            grdPropietarios.Refresh()
            grdPropietarios.Col = 0
            grdPropietarios.SelStartRow = grdPropietarios.Row
            grdPropietarios.SelEndRow = grdPropietarios.Row
            txtCampo(8).Text = VTArreglo(5)
            txtCampo(8).Enabled = False
            txtCampo_Leave(txtCampo(8), New EventArgs())
            txtCampo(7).Text = VTArreglo(10)
            txtCampo_Leave(txtCampo(7), New EventArgs())
            cmdBoton(0).Enabled = False
            cmdBoton(1).Enabled = False
        Else
            lblDescripcion(0).Text = ""
            lblDescripcion(1).Text = ""
            txtCampo(14).Text = ""
            If txtCampo(14).Visible And txtCampo(14).Enabled Then txtCampo(14).Focus()
            PMChequea(sqlconn)
        End If
        If VLEnte Then
            grdPropietarios.Col = 3
            For i As Integer = 1 To (grdPropietarios.Rows - 1)
                grdPropietarios.Row = i
                If (grdPropietarios.CtlText) = "C" Then
                    grdPropietarios.Col = 5
                    If grdPropietarios.CtlText.Trim() = "T" Then
                        Exit For
                    End If
                End If
            Next i
            VLEnte = False
        End If
        PMAnchoColumnasGrid(grdPropietarios)
        PLTSEstado()
    End Sub

    Private Sub plAlianza()
        Dim VLAlianza As String = ""
        Dim VLDesAlianza As String = ""
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_cliente", 0, SQLINT4, CStr(VLCodTitular))
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1181")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_desc_cliente", True, 2536 & " [" & txtCampo(0).Text & "]") Then
            Dim VTValores(15) As String
            FMMapeaArreglo(sqlconn, VTValores)
            PMMapeaVariable(sqlconn, VLAlianza)
            PMMapeaVariable(sqlconn, VLDesAlianza)
            PMChequea(sqlconn)
            Lblalianza.Text = VLAlianza
            lbldesalianza.Text = VLDesAlianza
        Else
            PMChequea(sqlconn)
            Lblalianza.Text = ""
            lbldesalianza.Text = ""
        End If
        PLTSEstado()
    End Sub

    Private Function FLVerificarExtranjero() As Boolean
        Dim result As Boolean = False
        Dim VTCadena As String = ""
        Dim vti As Integer = 0
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "350")
        PMPasoValores(sqlconn, "@i_opcion", 0, SQLINT2, "1")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "4")
        PMPasoValores(sqlconn, "@i_numsol", 0, SQLINT4, txtCampo(14).Text)
        For j As Integer = 1 To grdPropietarios.Rows - 1
            grdPropietarios.Row = j
            grdPropietarios.Col = 4
            VTCadena = ""
            vti += 1
            grdPropietarios.Col = 1
            VTCadena = VTCadena & (grdPropietarios.CtlText) & "@"
            grdPropietarios.Col = 5
            VTCadena = VTCadena & (grdPropietarios.CtlText) & "@"
            grdPropietarios.Col = 4
            VTCadena = VTCadena & (grdPropietarios.CtlText) & "@"
            PMPasoValores(sqlconn, "@i_param" & vti, 0, SQLCHAR, VTCadena)
        Next j
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_valida_menor", True, FMLoadResString(2469)) Then
            PMChequea(sqlconn)
            vti = FMRetStatus(sqlconn)
            If vti <> 0 Then
                Return result
            End If
            Return True
        Else
            PMChequea(sqlconn)
            Return result
        End If
        PLTSEstado()
        Return result
    End Function

    Private Sub PLArmadoNomCta()
        Dim VTTemp1 As String = ""
        Try
            Dim VTString As String = ""
            Dim VTNombreCta As New StringBuilder
            Dim VTcontador As Integer = 0
            VTTemp1 = txtCampo(2).Text
            VTNombreCta = New StringBuilder("")
            VTString = ""
            If txtCampo(18).Text.ToUpper() <> "M" And txtCampo(18).Text.ToUpper() <> "S" Then
                txtCampo(2).Text = VTTemp1
                Exit Sub
            End If
            ReDim VTMatrizprop(grdPropietarios.Cols - 1, 0)
            VLContadorprop = -1
            ReDim Roles(50, 1)
            PLProcesarPropietarios("T", 1)
            PLProcesarPropietarios("C", 1)
            PLProcesarPropietarios("F", 1)
            PLProcesarPropietarios("OTROS", 0)
            Select Case txtCampo(18).Text.ToUpper()
                Case "M"
                    VTString = " (Y) "
                Case "S"
                    VTString = " (O) "
            End Select
            VTcontador = 0
            For j As Integer = 0 To VTMatrizprop.GetUpperBound(1)
                For i As Integer = 0 To VTMatrizprop.GetUpperBound(0) - 1
                    If i = 2 Then
                        If VTMatrizprop(i, j).ToUpper() = "P" Then
                            If VTMatrizprop(4, j).ToUpper() = "T" Or VTMatrizprop(4, j).ToUpper() = "C" Then
                                If (VTMatrizprop.GetUpperBound(1)) > 0 Then
                                    VTcontador += 1
                                    If VTcontador = 1 Then
                                        VTNombreCta = New StringBuilder(VTMatrizprop(3, j).ToUpper())
                                    Else
                                        VTNombreCta.Append(VTString & VTMatrizprop(3, j).ToUpper())
                                    End If
                                End If
                            End If
                        Else
                            txtCampo(2).Text = VTTemp1
                            Exit Sub
                        End If
                    End If
                Next i
            Next j
            If VTcontador >= 2 Then
                txtCampo(2).Text = VTNombreCta.ToString()
            End If
        Catch
            txtCampo(2).Text = VTTemp1
            Exit Sub
        End Try
        PLTSEstado()
    End Sub

    Private Sub PLlblEtiqueta(ByRef Etiqueta As String)
        If optdir(0).Checked Then
            lblDescripcion(6).Visible = True
            txtCampo(3).Text = ""
            lblDescripcion(6).Text = ""
            Select Case Etiqueta
                Case "D"
                    lblEtiqueta(12).Text = FMLoadResString(501172) '"Código de dirección:"
                Case "C"
                    lblEtiqueta(12).Text = FMLoadResString(502405) '"Código de casilla:"
                Case "R"
                    lblEtiqueta(12).Text = FMLoadResString(502406) '"Código de sucursal:"
                Case "S"
                    lblEtiqueta(12).Text = FMLoadResString(502407) '"No. de casillero:"
            End Select
        ElseIf optdir(1).Checked Then
            lblDescripcion(15).Visible = True
            txtCampo(13).Text = ""
            lblDescripcion(15).Text = ""
            Select Case Etiqueta
                Case "D"
                    lblEtiqueta(19).Text = FMLoadResString(501256) '"Código de dirección:"
                Case "C"
                    lblEtiqueta(19).Text = FMLoadResString(502405) '"Código de casilla:"
                Case "R"
                    lblEtiqueta(19).Text = FMLoadResString(502406) '"Código de sucursal:"
                Case "S"
                    lblEtiqueta(19).Text = FMLoadResString(502407) '"No. de casillero:"
            End Select
        End If
    End Sub

    Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_21.MouseDown, _txtCampo_15.MouseDown, _txtCampo_14.MouseDown, _txtCampo_18.MouseDown, _txtCampo_19.MouseDown, _txtCampo_12.MouseDown, _txtCampo_11.MouseDown, _txtCampo_9.MouseDown, _txtCampo_8.MouseDown, _txtCampo_10.MouseDown, _txtCampo_5.MouseDown, _txtCampo_4.MouseDown, _txtCampo_2.MouseDown, _txtCampo_1.MouseDown, _txtCampo_0.MouseDown, _txtCampo_6.MouseDown, _txtCampo_7.MouseDown, _txtCampo_13.MouseDown, _txtCampo_3.MouseDown
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 4, 5, 6, 7, 8, 9, 10, 13, 18, 19, 14, 21
                My.Computer.Clipboard.Clear()
                ' My.Computer.Clipboard.SetText("")
        End Select
    End Sub

    Private Sub PLBuscar_marca()
        Dim VLParametro(15, 2) As String
        Dim VTCambiaCategoria As String = ""
        Dim VTParamContracual As String = ""
        Dim VLProdfinal As String = ""
        Dim VLParametriza As String = ""
        Dim VLMarca As String = ""
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "PAHCT")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, "AHO")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(2244)) Then
            FMMapeaMatriz(sqlconn, VLParametro)
            PMChequea(sqlconn)
            VTParamContracual = VLParametro(6, 1)
        Else
            PMChequea(sqlconn)
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "PAHPR")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, "AHO")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(2624)) Then
            FMMapeaMatriz(sqlconn, VLParametro)
            PMChequea(sqlconn)
            If VLParametro(6, 1) = txtCampo(8).Text Then
                VGProgresivo = "S"
            Else
                VGProgresivo = "N"
            End If
        Else
            PMChequea(sqlconn)
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "CAMCAT")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, "AHO")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(2244)) Then
            FMMapeaMatriz(sqlconn, VLParametro)
            PMChequea(sqlconn)
            If VLParametro(3, 1) = txtCampo(7).Text Then
                VTCambiaCategoria = "S"
            Else
                VTCambiaCategoria = "N"
            End If
        Else
            PMChequea(sqlconn)
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(734))
        PMPasoValores(sqlconn, "@i_categoria", 0, SQLVARCHAR, txtCampo(7).Text)
        PMPasoValores(sqlconn, "@i_prodban", 0, SQLVARCHAR, txtCampo(8).Text)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
        PMPasoValores(sqlconn, "@i_tipoente", 0, SQLCHAR, VLTipoEnteTitular)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mto_aho_contractual", True, FMLoadResString(2245)) Then
            PMMapeaVariable(sqlconn, VGContractual)
            PMMapeaVariable(sqlconn, VLProdfinal)
            PMMapeaVariable(sqlconn, VLParametriza)
            PMMapeaVariable(sqlconn, VLMarca)
            If VGContractual = "S" Or VGProgresivo = "S" Then
                If StringsHelper.ToDoubleSafe(VLParametriza) <> 0 Or (VTCambiaCategoria = "S" And txtCampo(8).Text = VTParamContracual) Then
                    VGcategoria = txtCampo(7).Text
                    VGprofinal = VLProdfinal
                    VGOrigen = "0"
                    VGNombreCuenta = txtCampo(2).Text
                    FTRAN434.ShowPopup(Me)
                Else
                    COBISMessageBox.Show(FMLoadResString(2626) & " " & VLProdfinal & " " & FMLoadResString(2627) & " " & txtCampo(7).Text & " ", FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(7).Text = ""
                    lblDescripcion(10).Text = ""
                    txtCampo(7).Focus()
                End If
            Else
                VGCancelar = "N"
            End If
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub PLParametro()
        Dim Matrizl(20, 20) As String
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "PAP")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, "AHO")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(2628)) Then
            FMMapeaMatriz(sqlconn, Matrizl)
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
        VLProdProgresivo = Matrizl(4, 1)
    End Sub

    Private Sub PLTSEstado()
        TSBAnadir.Visible = _cmdBoton_0.Visible
        TSBAnadir.Enabled = _cmdBoton_0.Enabled
        TSBEliminar.Visible = _cmdBoton_1.Visible
        TSBEliminar.Enabled = _cmdBoton_1.Enabled
        TSBPerfil.Visible = _cmdBoton_6.Visible
        TSBPerfil.Enabled = _cmdBoton_6.Enabled
        TSBBuscar.Visible = _cmdBoton_5.Visible
        TSBBuscar.Enabled = _cmdBoton_5.Enabled
        TSBCanales.Visible = _cmdBoton_7.Visible
        TSBCanales.Enabled = _cmdBoton_7.Enabled
        TSBContrato.Visible = _cmdBoton_9.Visible
        TSBContrato.Enabled = _cmdBoton_9.Enabled
        TSBTransmitir.Visible = _cmdBoton_2.Visible
        TSBTransmitir.Enabled = _cmdBoton_2.Enabled
        TSBLimpiar.Visible = _cmdBoton_3.Visible
        TSBLimpiar.Enabled = _cmdBoton_3.Enabled
        TSBSalir.Visible = _cmdBoton_4.Visible
        TSBSalir.Enabled = _cmdBoton_4.Enabled
    End Sub

    Private Sub TSBAnadir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBAnadir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBPerfil_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBPerfil.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBCanales_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCanales.Click
        If _cmdBoton_7.Enabled Then cmdBoton_Click(_cmdBoton_7, e)
    End Sub

    Private Sub TSBContrato_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBContrato.Click
        If _cmdBoton_9.Enabled Then cmdBoton_Click(_cmdBoton_9, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub grdPropietarios_Leave(sender As Object, e As EventArgs) Handles grdPropietarios.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub chkFuncionario_Enter(sender As Object, e As EventArgs) Handles chkFuncionario.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501275))
    End Sub

    Private Sub mskCuenta_Enter(sender As Object, e As EventArgs) Handles mskCuenta.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(99833))
    End Sub

    Private Sub mskCuenta_KeyDown(sender As Object, e As KeyEventArgs) Handles mskCuenta.KeyDown
        Dim KeyCode As Integer = e.KeyData
        If KeyCode = VGTeclaAyuda Then
            If VLCodTitular = 0 Then
                COBISMessageBox.Show(FMLoadResString(501931), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskCuenta.Mask = VGMascaraCtaAho
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                txtCampo(0).Focus()
            Else
                VLPaso = True
                PMCatalogo("CTA", VLCodTitular, mskCuenta, Nothing)
            End If
        End If
    End Sub

    Private Sub mskCuenta_Leave(sender As Object, e As EventArgs) Handles mskCuenta.Leave
        If Not VLPaso Then
            If mskCuenta.ClipText <> "" Then
                If FMChequeaCtaAho(mskCuenta.ClipText) Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_relacionada", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_consulta", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_codcliente", 0, SQLVARCHAR, VLCodTitular)                    
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(502622) & " [" & mskCuenta.Text & "]") Then
                        'PMMapeaObjeto(sqlconn, lblDescripcion(0))
                        PMChequea(sqlconn)
                    Else
                        mskCuenta.Mask = VGMascaraCtaAho
                        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                        mskCuenta.Focus()
                        PMChequea(sqlconn)
                        Exit Sub
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Mask = VGMascaraCtaAho
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                    mskCuenta.Focus()
                    Exit Sub
                End If
            End If
        End If
        VLPaso = True
    End Sub

    Private Sub mskCuenta_TextChanged(sender As Object, e As EventArgs) Handles mskCuenta.TextChanged
        VLPaso = False
    End Sub

End Class