VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FGenerales 
   Appearance      =   0  'Flat
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Datos Generales"
   ClientHeight    =   2220
   ClientLeft      =   2310
   ClientTop       =   2700
   ClientWidth     =   5985
   ControlBox      =   0   'False
   FillColor       =   &H00FFFFFF&
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00FFFFFF&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2220
   ScaleWidth      =   5985
   Begin MSGrid.Grid grdRol 
      Height          =   1065
      Left            =   60
      TabIndex        =   8
      Top             =   1065
      Width           =   5850
      _Version        =   65536
      _ExtentX        =   10319
      _ExtentY        =   1879
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   795
      MaxLength       =   5
      TabIndex        =   1
      Top             =   675
      Width           =   765
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   795
      MaxLength       =   2
      TabIndex        =   0
      Top             =   375
      Width           =   550
   End
   Begin VB.CommandButton cmdSeleccion 
      Appearance      =   0  'Flat
      Caption         =   "&Cancelar"
      Height          =   375
      Index           =   0
      Left            =   4710
      TabIndex        =   3
      Top             =   675
      Width           =   1185
   End
   Begin VB.CommandButton cmdSeleccion 
      Appearance      =   0  'Flat
      Caption         =   "&OK"
      Default         =   -1  'True
      Height          =   375
      Index           =   1
      Left            =   4710
      TabIndex        =   2
      Top             =   285
      Width           =   1185
   End
   Begin VB.Label lblVersion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   795
      TabIndex        =   10
      Top             =   80
      Width           =   3625
   End
   Begin VB.Label lblCampo 
      Appearance      =   0  'Flat
      BackStyle       =   0  'Transparent
      Caption         =   "Versión:"
      ForeColor       =   &H00800000&
      Height          =   255
      Index           =   2
      Left            =   60
      TabIndex        =   9
      Top             =   90
      Width           =   720
   End
   Begin VB.Label lblCampo 
      Appearance      =   0  'Flat
      BackStyle       =   0  'Transparent
      Caption         =   "Oficina:"
      ForeColor       =   &H00800000&
      Height          =   255
      Index           =   1
      Left            =   60
      TabIndex        =   7
      Top             =   690
      Width           =   720
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   1560
      TabIndex        =   6
      Top             =   675
      Width           =   2865
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   1365
      TabIndex        =   5
      Top             =   375
      Width           =   3060
   End
   Begin VB.Label lblCampo 
      Appearance      =   0  'Flat
      BackStyle       =   0  'Transparent
      Caption         =   "Filial:"
      ForeColor       =   &H00800000&
      Height          =   255
      Index           =   0
      Left            =   60
      TabIndex        =   4
      Top             =   390
      Width           =   720
   End
End
Attribute VB_Name = "FGenerales"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
'*********************************************************
'   Archivo:                FGENERAL.FRM - FGenerales
'   Producto:               Terminal Administrativa
'   Fecha de Documentación: 6-Junio-1994
'*********************************************************
'                       IMPORTANTE
' Esta Aplicación es parte de los paquetes bancarios pro-
' piedad de MACOSA, representantes exclusivos para el Ecua-
' dor de la NCR CORPORATION.  Su uso no autorizado queda
' expresamente prohibido así como cualquier alteración o
' agregado hecho por alguno de sus usuarios sin el debido
' consentimiento por escrito de la Presidencia Ejecutiva
' de MACOSA o su representante
'*********************************************************
' DESCRIPCION:  Esta forma permite seleccionar la oficina,
'               la filial, la moneda y el rol con el
'               cual el usuario se registrara en el
'               sistema
'*********************************************************

' Variable para controlar las ayudas por F5 y LostFucus
Dim VLPaso As Integer

Private Sub cmdSeleccion_Click(Index As Integer)
'*********************************************************
'Objetivo:  Permite aceptar o cancelar el registro del
'           usuario al sistema. (Boton)
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'26/May/98  Geovanna Bonilla B. Migracion VB3 a VB5
'*********************************************************
'GBB26May98003 UI:Reemplazo de la funcion Getprivateprofilestring por la funcion Get_preferencia

'-------------------------------------------
' Control de tiempo para timeout de conexion
    Dim VLHookTiempo As Long
    Dim VLParametro(15, 2) As String
    Dim VLRolcito%
    Dim VLSection$
    Dim VLEntry$
    Dim VLLong%
    Dim VLFileName$
    Dim VLTerminalName$
    Dim VLDefault$
    Dim valor As Boolean
    Dim VTTamanio$
    Dim VTRolNum%
    Dim VTRol$
    Dim VLRol_Time_Out As String
    Dim VTMensaje$
    Dim VTReturn%
    Dim VTTemporal$
    Dim VTR1%
    Dim i%
    Dim VLPosicionFilial%
    Dim VTItem$
    Dim VTMail$
'! removed Dim VLRol_Timeout As Long

'-------------------------------------------

   
    ' Boton Aceptar los datos desplegados

    ' Boton Cancelar
    If Index% <> 1 Then
         SqlClose sqlconn&
         sqlconn& = 0
        Unload FGenerales
        SqlExit
        SqlWinExit
        Exit Sub
    End If

    ' Filial
    If txtCampo(0).Text = "" Then
        MsgBox "El código de la filial es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(0).SetFocus
        Exit Sub
    End If

    ' Oficina
    If txtCampo(1).Text = "" Then
        MsgBox "El código de la oficina es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(1).SetFocus
        Exit Sub
    End If
    
    ' Rol
    VLRolcito% = grdRol.Row
    If VLRolcito% <= 0 Then VLRolcito% = 1
    grdRol.Row = 1
    grdRol.Col = 1
    If grdRol.Text = "" Then
         SqlClose sqlconn&
         sqlconn& = 0
        MsgBox "No existen roles definidos para el usuario", 0, "Mensaje del Servidor"
        Unload FGenerales
        Exit Sub
    End If

    ' Terminal de conexion
    VLSection$ = "network"
    VLEntry$ = "ComputerName"
    VLLong% = 15
    VLFileName$ = "system.ini"
    VLTerminalName$ = Space$(15)
    VLDefault$ = "TermTADMIN"

    '**** OBTIENE NOMBRE MAQUINA CON MANEJO PARA TERMINAL SERVICES   --OUS
 'FIXIT: Replace 'String' function with 'String$' function                                  FixIT90210ae-R9757-R1B8ZE
    VTTamanio$ = String$(22, 32)
'FIXIT: Replace 'String' function with 'String$' function                                  FixIT90210ae-R9757-R1B8ZE
    VLTerminalName$ = String$(22, 32)
    
    'OBTIENE EL NOMBRE DE LA MAQUINA
    valor = NombreCliente(VTTamanio, VLTerminalName)
    
    If Val(VTTamanio) = 1 Then
         VLTerminalName = FMGetComputerName()
    Else
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
        If AscW(Mid$(VLTerminalName$, Val(VTTamanio), 1)) = 0 Then
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
           VLTerminalName = Mid$(VLTerminalName$, 1, Val(VTTamanio) - 1)
        End If
    End If
    'FIN MANEJO PARA TERMINAL SERVICES
    HostName$ = VLTerminalName
    ' Incialiacion de los parametros de conexion

    grdRol.Row = VLRolcito%
    VTRolNum% = Val(grdRol.Text)
    VTRol$ = Str$(VTRolNum%)
    VGRol$ = VTRol$
    grdRol.Col = 3
    VLRol_Time_Out = Val(grdRol.Text)
    '----------------------------------------------
    ' Control de tiempo para timeout de conexion
    VLHookTiempo = CLng(VLRol_Time_Out)
    '----------------------------------------------
     PMPasoValores sqlconn&, "@i_server", 0, SQLVARCHAR, ServerNameLocal$
     PMPasoValores sqlconn&, "@i_login", 0, SQLVARCHAR, VGLogin$
     PMPasoValores sqlconn&, "@i_terminal", 0, SQLVARCHAR, HostName$
     PMPasoValores sqlconn&, "@i_office", 0, SQLINT4, (txtCampo(1).Text)
     PMPasoValores sqlconn&, "@i_role", 0, SQLINT4, VGRol$
     PMPasoValores sqlconn&, "@i_campwd", 0, SQLINT1&, "1"
     PMPasoValores sqlconn&, "@o_campwd", 1, SQLINT1&, ""
     If FMTransmitirRPC(sqlconn&, "", "master", "sp_reclogin", True, "") Then
        PMMapeaVariable sqlconn&, VTMensaje$
        PMChequea sqlconn&
        MsgBox VTMensaje$
        VGFilial$ = txtCampo(0).Text   ' Nuevo
        VGOficina$ = txtCampo(1).Text  ' Nuevo
        VGRol$ = VTRol$                ' Nuevo
        VGCorreo% = True               ' Nuevo
        VTReturn% = FMRetStatus(sqlconn&)
        
        'Cambio password                ' Nuevo
        VTTemporal$ = FMRetParam(sqlconn&, 1)
        If VTTemporal$ = "1" Then
            Me.Visible = False

            PMCambioPassword sqlconn&, ServerName$, ServerNameLocal$, VGLogin$, VGFilial, VGOficina
            FPrincipal.Desconectar
            Exit Sub
        End If


        ' Registro del usuario exitoso

        If VTReturn% = 0 Then
        
            '-------------------------------------------
            ' Control de tiempo para timeout de conexion
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1579"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
            PMPasoValores sqlconn&, "@i_nemonico", 0, SQLVARCHAR, "TDT"
            PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR, "ADM"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_parametro", True, " Ok... Consulta de tipo de bloqueo de terminal") Then
                VTR1% = FMMapeaMatriz(sqlconn&, VLParametro())
                PMChequea sqlconn&
            End If
            
            If VLHookTiempo < 60 Then
                VLHookTiempo = 60
            End If
            If VTR1% = 0 Then   'Tipo de Desconexion no esta configurado: Desconectar frontend
                FPrincipal.VGTipoDesconexion = True
            Else
                If VLParametro(3, 1) = "D" Then 'Tipo de Desconexion: Desconectar Frontend
                    FPrincipal.VGTipoDesconexion = True
                Else                            'Tipo de Desconexion: Bloqueo de pantalla
                    FPrincipal.VGTipoDesconexion = False
                End If
            End If
            VLHookTiempo = VLHookTiempo * 1000
            Set FPrincipal.VGHook = New COBISTools.IdleTimeout
            FPrincipal.VGHook.Timeout = VLHookTiempo
            '-------------------------------------------

            ' Inicialiacion de seguridades a nivel de boton
            If FMSeguridad() = True Then
                PMMenuSeguridad FPrincipal.mnuServicios
                
                PMMenuSeguridad FPrincipal.mnuProductos
                PMMenuSeguridad FPrincipal.mnuTranServ(0)
                PMMenuSeguridad FPrincipal.mnuTranServ(1)
                PMMenuSeguridad FPrincipal.mnuTranServ(2)
                PMMenuSeguridad FPrincipal.mnuTranServ(5)
                PMMenuSeguridad FPrincipal.mnuTranServ(6)
                PMMenuSeguridad FPrincipal.mnuTranServ(7)
                
                PMMenuSeguridad FPrincipal.mnuTranProd(0)
                PMMenuSeguridad FPrincipal.mnuTranProd(1)
                PMMenuSeguridad FPrincipal.mnuTranProd(2)
                PMMenuSeguridad FPrincipal.mnuTranProd(3)
                PMMenuSeguridad FPrincipal.mnuTranProd(4)
                PMMenuSeguridad FPrincipal.mnuTranProd(5)
                
                PMMenuSeguridad FPrincipal.mnuCostos
                
                PMMenuSeguridad FPrincipal.mnuTranCos(1)
                PMMenuSeguridad FPrincipal.mnuTranCos(2)
                
                PMMenuSeguridad FPrincipal.mnuTranCos0(0)
                PMMenuSeguridad FPrincipal.mnuTranCos0(1)
                PMMenuSeguridad FPrincipal.mnuTranCos0(2)
                                            
                PMMenuSeguridad FPrincipal.mnuTranCos1(0)
                PMMenuSeguridad FPrincipal.mnuTranCos1(1)
                PMMenuSeguridad FPrincipal.mnuTranCos1(2)
                PMMenuSeguridad FPrincipal.mnuTranCos1(4)
                PMMenuSeguridad FPrincipal.mnuTranCos1(5)
                PMMenuSeguridad FPrincipal.mnuTranCos1(6)
                PMMenuSeguridad FPrincipal.mnuTranCos1(7)
                
                PMMenuSeguridad FPrincipal.mnuRango
                
                PMMenuSeguridad FPrincipal.mnuRangos(0)
                PMMenuSeguridad FPrincipal.mnuRangos(1)
    
                'CLE 23/Nov/05 Activación menus para Costos Especiales
                PMMenuSeguridad FPrincipal.mnuValoresEsp
                PMMenuSeguridad FPrincipal.mnucostoesp(0)
                PMMenuSeguridad FPrincipal.mnucostoesp(1)
                PMMenuSeguridad FPrincipal.mnucostoesp(2)
                
                'ADI REQ 217 Seguridad para menu Autorización Transacciones en Caja
                PMMenuSeguridad FPrincipal.mnuTranCaja
                PMMenuSeguridad FPrincipal.mnuProCont(6)

                'ADI REQ 252 Seguridad para menu Topes Retiro en Oficina
                PMMenuSeguridad FPrincipal.mnuTopesOfi(1)
                PMMenuSeguridad FPrincipal.mnuTopesOfi(2)
                                
                FPrincipal.mnuLogon.Enabled = False
                FPrincipal.mnuLogoff.Enabled = True
                FPrincipal.mnuCambioPass.Enabled = True
                'FPrincipal!mnuContenido.Enabled = True
                FPrincipal.mnuBloquear.Enabled = True

                ' Carga de parámetros iniciales para cuentas corrientes
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "78"
                 PMPasoValores sqlconn&, "@i_prod", 0, SQLVARCHAR, "CTE"
                 PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, "0"
                 If FMTransmitirRPC(sqlconn&, "", "cobis", "sp_cons_param_inicio", True, "") Then
                    ReDim VTArreglo(20) As String
                     VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
                     PMChequea sqlconn&
                    If VTR1% <> 0 Then
                        VGLongCtaCte% = Val(VTArreglo(1))
                        VGPesosCtaCte$ = VTArreglo(2)
                        VGModuloCtaCte% = Val(VTArreglo(3))
                        VGMascaraCtaCte$ = VTArreglo(4)
                        VGFecha$ = VTArreglo(9)
                    Else
                        MsgBox "Error en consulta de Parámetros iniciales", 0 + 16, "Mensaje del Servidor"
                         SqlClose sqlconn&
                        SqlWinExit
                        SqlExit
                         sqlconn& = 0
                        Exit Sub
                    End If
                Else
                     PMChequea sqlconn&
                    MsgBox "Error en consulta de Parámetros iniciales de Cuentas Corrientes", 0 + 16, "Mensaje del Servidor"
                    PMLogOff
                    Exit Sub
                End If
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "78"
                 PMPasoValores sqlconn&, "@i_prod", 0, SQLVARCHAR, "AHO"
                 If FMTransmitirRPC(sqlconn&, "", "cobis", "sp_cons_param_inicio", True, "") Then
                    ReDim VTArreglo(10) As String
                     VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
                     PMChequea sqlconn&
                    If VTR1% <> 0 Then
                        VGLongCtaAho% = Val(VTArreglo(1))
                        VGPesosCtaAho$ = VTArreglo(2)
                        VGModuloCtaAho% = Val(VTArreglo(3))
                        VGMascaraCtaAho$ = VTArreglo(4)
                    Else
                        MsgBox "Error en consulta de Parámetros iniciales" & Chr$(13) & VTMensaje$, 0 + 16, "Mensaje del Servidor"
                    End If
                Else
                     PMChequea sqlconn&
                     SqlClose sqlconn&
                    SqlWinExit
                    SqlExit
                     sqlconn& = 0
                    MsgBox "Error en consulta de Parámetros iniciales" & Chr$(13) & VTMensaje$, 0, "Mensaje del Servidor"
                    Unload FGenerales
                    Exit Sub
                End If

                VGFilial$ = txtCampo(0).Text
                VGOficina$ = txtCampo(1).Text
                VGMoneda$ = Get_Preferencia("MONEDA") 'txtCampo(2).Text
                ' If lblDescripcion(3).Caption = "N" Then
                '     VGDecimales$ = "#,##0"
                ' Else
                '     VGDecimales$ = "#,##0.00"
                ' End If
                    ReDim VTFilial(2, 150) As String
                     PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_filial"
                     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la filial " & "[" & txtCampo(Index%).Text & "]") Then
                         VTR1% = FMMapeaMatriz(sqlconn&, VTFilial())
                         PMChequea sqlconn&
    
                        ' Carga de las filiales al COMBO de Filiales
                        FPrincipal.lblEtiqueta.Visible = True
                        FPrincipal.cmbFilial.Visible = True
                        FPrincipal.cmbFilial.Enabled = True
                        For i% = 1 To VTR1%
                            If Trim$(VTFilial(0, i%)) = VGFilial$ Then
                                VLPosicionFilial% = i% - 1
                            End If
                            VTItem$ = VTFilial(0, i%) & "-" & VTFilial(1, i%)
                            FPrincipal.cmbFilial.AddItem VTItem$, i% - 1
                        Next i%
                        FPrincipal.cmbFilial.ListIndex = VLPosicionFilial%
                        VGFilial$ = VTFilial(0, (VLPosicionFilial% + 1))
                    Else
                        MsgBox "No existen Filiales", 0 + 16, "Mensaje del Servidor"
                        ' Cerrar la conexión pues sin filiales no se puede trabajar
                        PMLogOff
                        Exit Sub
                    End If
    
    
                VGCorreo% = True
                
                Set_Preferencia "FILIAL", (txtCampo(0).Text)
                Set_Forma_Preferencia "FILIAL", (txtCampo(0).Text) & " - " & (lblDescripcion(0).Caption)
                Set_Preferencia "OFICINA", (txtCampo(1).Text)
                Set_Forma_Preferencia "OFICINA", (txtCampo(1).Text) & " - " & (lblDescripcion(1).Caption)
                'Set_Preferencia "MONEDA", (txtCampo(2).Text)
                'Set_Forma_Preferencia "MONEDA", (txtCampo(2).Text) & " - " & (lblDescripcion(2).Caption)
                Set_Preferencia "ROL", VGRol$
                Set_Forma_Preferencia "ROL", VGRol$ & " - " & Mid$(grdRol.Text, InStr(1, grdRol.Text, Chr$(9)) + 1, Len(grdRol.Text))
                Set_Preferencia "TERMINAL", HostName$
                Set_Forma_Preferencia "TERMINAL", HostName$
                
                MsgBox VTMensaje$ & Chr$(13) & VTMail$, 0, "Mensaje del Servidor"
                'ServerName$ = ""
            
            Else
                 SqlClose sqlconn&
                 sqlconn& = 0
                MsgBox "No existen transacciones autorizadas", 48, "Mensaje del Servidor"
                Unload FGenerales
            End If
            Unload FGenerales
        Else
            Unload FGenerales
             SqlClose sqlconn&
             sqlconn& = 0
            SqlWinExit
            SqlExit
            MsgBox "El usuario " & VGLogin$ & Chr$(13) & "No se registró con el servidor", 0, "Mensaje del Servidor"
            Unload FGenerales
        End If
    Else
         SqlClose sqlconn&
        SqlWinExit
        SqlExit
         sqlconn& = 0
        MsgBox "El usuario " & VGLogin$ & Chr$(13) & "No se registró con el servidor", 0, "Mensaje del Servidor"
        Unload FGenerales
    End If

End Sub

Private Sub Form_Load()
'*********************************************************
'Objetivo:  Permite cargar la forma de generales
'           cargando los datos existentes en el archivo
'           de preferencias
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'10/Oct/01  E.Pulido            Carga Version
'*********************************************************
Dim VLEncuentra$
Dim VTRol$
Dim i%
lblVersion.Caption = CStr(App.Major) + "." + CStr(App.Minor) + "." + CStr(App.revision) + " - " + App.CompanyName

    'lblDescripcion(3).Caption = "N"
     PMPasoValores sqlconn&, "@login", 0, SQLVARCHAR, VGLogin$
     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "rp_rol", True, "") Then
         PMMapeaGrid sqlconn&, grdRol, False
         PMChequea sqlconn&
        grdRol.ColWidth(2) = 3900
        grdRol.ColWidth(3) = 550
        If grdRol.Tag = 0 Then
            MsgBox "Usuario No Válido, No tiene Roles Asignados", 48, "Parámetros de Conexión"
             SqlClose (sqlconn&)
             sqlconn& = 0
        Else
            txtCampo(0).Text = Get_Preferencia("FILIAL")
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_filial"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCampo(0).Text)
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, "") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(0)
                 PMChequea sqlconn&
            Else
                txtCampo(0).Text = ""
                lblDescripcion(0).Caption = ""
            End If
            txtCampo(1).Text = Get_Preferencia("OFICINA")
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCampo(1).Text)
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, "") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(1)
            Else
                txtCampo(1).Text = ""
                lblDescripcion(1).Caption = ""
            End If
             PMChequea sqlconn&
           ' txtCampo(2).Text = Get_Preferencia("MONEDA")
            ' PMPasoValores SqlConn&, "@i_tabla", 0, SQLCHAR, "cl_moneda"
            ' PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "V"
            ' PMPasoValores SqlConn&, "@i_codigo", 0, SQLCHAR, (txtCampo(2).Text)
            ' If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", False, "") Then
            '     PMMapeaObjeto SqlConn&, lblDescripcion(2)
            '     PMChequea SqlConn&
           ' Else
           '     txtCampo(2).Text = ""
           '     lblDescripcion(2).Caption = ""
           '     lblDescripcion(3).Caption = ""
           ' End If
           'II VMA 22-jun-2001
            VLEncuentra$ = "N"
            grdRol.Col = 1
            'FI VMA 22-jun-2001
            VTRol$ = Get_Preferencia("ROL")
            For i% = 0 To grdRol.Rows - 1
                grdRol.Row = i%
                If Val(grdRol.Text) = Val(VTRol$) Then
                    VLEncuentra$ = "S"
                    Exit For
                End If
            Next i%
            If VLEncuentra$ = "S" Then
                grdRol.Row = i%
                grdRol_Click
            Else
                grdRol.Row = 0
            End If
        End If
    End If
    ServerName$ = ""
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdRol_Click()
    If Val(grdRol.Tag) > 0 Then
        PMLineaG grdRol
    End If
End Sub

Private Sub txtCampo_Change(Index As Integer)
'*********************************************************
'Objetivo:  Permite activar la ayuda por LostFocus si se
'           cambia el campo respectivo
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'*********************************************************
    
    VLPaso% = False
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
'*********************************************************
'Objetivo:  Permite desplegar en la barra de ayuda el
'           significado del campo actual
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'*********************************************************
    
    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Código de la filial [F5 Ayuda]"
    Case 1
        FPrincipal.pnlHelpLine.Caption = " Código de la oficina [F5 Ayuda]"
    Case 2
        FPrincipal.pnlHelpLine.Caption = " Código de la moneda [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
'*********************************************************
'Objetivo:  Permite desplegar la lista de ayuda F5
'           del campo actual
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'*********************************************************
    If KeyCode% = VGTeclaAyuda% Then
        VLPaso% = True
        Select Case Index%
        Case 0
            VGOperacion$ = "sp_filial"
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_filial"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la filial " & "[" & txtCampo(Index%).Text & "]") Then
                 PMMapeaListaH sqlconn&, FCatalogo.lstCatalogo, False
                 PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(0).Text = VGACatalogo.Codigo$
                lblDescripcion(0).Caption = VGACatalogo.Descripcion$
            End If
        Case 1
            If txtCampo(0).Text <> "" Then
                VGOperacion$ = "sp_oficina"
                 PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(Index%).Text & "]") Then
                     PMMapeaListaH sqlconn&, FCatalogo.lstCatalogo, False
                     PMChequea sqlconn&
                    FCatalogo.Show 1
                    txtCampo(1).Text = VGACatalogo.Codigo$
                    lblDescripcion(1).Caption = VGACatalogo.Descripcion$
                End If
            Else
                MsgBox "El código de la filial es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(0).SetFocus
            End If
        'Case 2
        '    VGOperacion$ = "sp_moneda"
         '    PMPasoValores SqlConn&, "@i_tabla", 0, SQLCHAR, "cl_moneda"
         '    PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "A"
         '    If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de monedas") Then
         '        PMMapeaListaH SqlConn&, FCatalogo!lstCatalogo, False
         '        PMChequea SqlConn&
        '        FCatalogo.Show 1
        '        txtCampo(2).Text = VGACatalogo.Codigo$
        '        lblDescripcion(2).Caption = VGACatalogo.Descripcion$
        '    End If
        End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
'*********************************************************
'Objetivo:  Permite activar las teclas permitidas del campo
'           actual, ya sean estos digitos o letras
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'*********************************************************

    If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
'*********************************************************
'Objetivo:  Permite obtener la ayuda por LostFocus del
'           campo actual
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'*********************************************************
    If VLPaso% = False Then
        Select Case Index%
        Case 0
            If txtCampo(0).Text <> "" Then
                 PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_filial"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCampo(0).Text)
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la filial " & "[" & txtCampo(Index%).Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(0)
                     PMChequea sqlconn&
                Else
                    VLPaso% = True
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Caption = ""
                    txtCampo(0).SetFocus
                End If
            Else
                lblDescripcion(0).Caption = ""
            End If
        Case 1
            If txtCampo(0).Text <> "" Then
                If txtCampo(1).Text <> "" Then
                     PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
                     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                     PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCampo(1).Text)
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(Index%).Text & "]") Then
                         PMMapeaObjeto sqlconn&, lblDescripcion(1)
                         PMChequea sqlconn&
                    Else
                        VLPaso% = True
                        txtCampo(1).Text = ""
                        lblDescripcion(1).Caption = ""
                        txtCampo(1).SetFocus
                    End If
                Else
                    lblDescripcion(1).Caption = ""
                End If
            Else
                MsgBox "El código de la filial es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(0).SetFocus
            End If
      '  Case 2
      '      If txtCampo(Index%).Text <> "" Then
       '          PMPasoValores SqlConn&, "@i_tabla", 0, SQLCHAR, "cl_moneda"
       '          PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "V"
       '          PMPasoValores SqlConn&, "@i_codigo", 0, SQLCHAR, (txtCampo(2).Text)
       '          If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la moneda " & "[" & txtCampo(Index%).Text & "]") Then
       '              PMMapeaObjeto SqlConn&, lblDescripcion(2)
       '              PMChequea SqlConn&
      '          Else
     '               VLPaso% = True
     '               txtCampo(2).Text = ""
     '               lblDescripcion(2).Caption = ""
     '               lblDescripcion(3).Caption = ""
     '               txtCampo(2).SetFocus
     '           End If
     '       Else
      '          lblDescripcion(2).Caption = ""
      '          lblDescripcion(3).Caption = ""
      '      End If
        End Select
    End If
End Sub



