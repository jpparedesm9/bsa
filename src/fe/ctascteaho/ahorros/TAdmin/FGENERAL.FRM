VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FGenerales 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Datos Generales"
   ClientHeight    =   2055
   ClientLeft      =   2850
   ClientTop       =   2445
   ClientWidth     =   5655
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
   Icon            =   "FGENERAL.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2055
   ScaleWidth      =   5655
   Begin MSGrid.Grid grdRol 
      Height          =   1065
      Left            =   0
      TabIndex        =   8
      Top             =   960
      Width           =   5610
      _Version        =   65536
      _ExtentX        =   9896
      _ExtentY        =   1879
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   7.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   1
      Left            =   825
      MaxLength       =   4
      TabIndex        =   1
      Top             =   600
      Width           =   675
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   0
      Left            =   825
      MaxLength       =   2
      TabIndex        =   0
      Top             =   300
      Width           =   675
   End
   Begin VB.CommandButton cmdSeleccion 
      Appearance      =   0  'Flat
      Caption         =   "*&Cancelar"
      Height          =   325
      Index           =   0
      Left            =   4440
      TabIndex        =   3
      Top             =   470
      WhatsThisHelpID =   2012
      Width           =   1185
   End
   Begin VB.CommandButton cmdSeleccion 
      Appearance      =   0  'Flat
      Caption         =   "*&OK"
      Default         =   -1  'True
      Height          =   325
      Index           =   1
      Left            =   4440
      TabIndex        =   2
      Top             =   125
      WhatsThisHelpID =   2041
      Width           =   1185
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   2
      Left            =   825
      TabIndex        =   10
      Top             =   0
      Width           =   3580
   End
   Begin VB.Label lblCampo 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Version:"
      ForeColor       =   &H00800000&
      Height          =   255
      Index           =   2
      Left            =   30
      TabIndex        =   9
      Top             =   0
      Width           =   720
   End
   Begin VB.Label lblCampo 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Oficina:"
      ForeColor       =   &H00800000&
      Height          =   255
      Index           =   1
      Left            =   30
      TabIndex        =   7
      Top             =   570
      WhatsThisHelpID =   5005
      Width           =   720
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   1
      Left            =   1515
      TabIndex        =   6
      Top             =   600
      Width           =   2895
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   0
      Left            =   1515
      TabIndex        =   5
      Top             =   300
      Width           =   2895
   End
   Begin VB.Label lblCampo 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Filial:"
      ForeColor       =   &H00800000&
      Height          =   255
      Index           =   0
      Left            =   30
      TabIndex        =   4
      Top             =   330
      Width           =   720
   End
End
Attribute VB_Name = "FGenerales"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FGENERAL.FRM
' NOMBRE LOGICO:    FGenerales
' PRODUCTO:         Terminal Administrativa
'*************************************************************
'                       IMPORTANTE
' Esta aplicacion es parte de los paquetes bancarios propiedad
' de MACOSA S.A.
' Su uso no  autorizado queda  expresamente prohibido asi como
' cualquier  alteracion o  agregado  hecho por  alguno  de sus
' usuarios sin el debido consentimiento por escrito de MACOSA.
' Este programa esta protegido por la ley de derechos de autor
' y por las  convenciones  internacionales de  propiedad inte-
' lectual.  Su uso no  autorizado dara  derecho a  MACOSA para
' obtener ordenes  de secuestro o  retencion y para  perseguir
' penalmente a los autores de cualquier infraccion.
'*************************************************************
'                         PROPOSITO
' Esta forma permite seleccionar la oficina, la filial,
' la moneda y el rol con el cual el usuario se registrara en
' el sistema.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 06-Jun-94      J. Uría         Emisión Inicial
' 10-Ene-02      C. Milán        Personalización AgroMercantil
'*************************************************************

' Variable para controlar las ayudas por F5 y LostFucus
Dim VLPaso As Integer
Dim VLRol_Time_Out As Long

Private Sub PLDatosContabilidad()
     Dim VTNiveles(30) As String
     
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6030"
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "N"
     PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGFilial
     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_conta", "sp_empresa", True, "Ok busqueda de datos de empresa") Then
         PMMapeaVariable sqlconn&, VTNombre$
         Y% = FMMapeaArreglo(sqlconn&, VTNiveles())
         PMMapeaVariable sqlconn&, VGMascaraConta$
         PMMapeaVariable sqlconn&, VTMoneda$
         PMChequea sqlconn&
    End If
End Sub
Private Sub cmdSeleccion_Click(Index As Integer)
'*********************************************************
'PROPOSITO: Permite aceptar o cancelar el registro del
'           usuario al sistema. (Boton)
'INPUT   :  ninguno
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'12/Sep/01  T.Suárez            Incorporación NCS
'*********************************************************

'-------------------------------------------
' Control de tiempo para timeout de conexion
Dim VLHookTiempo As Long
Dim VLParametro(15, 2) As String
'-------------------------------------------

    ' Validacion de mandatoriedades de conexion

    ' Boton Cancelar
    If Index% <> 1 Then
       SqlClose sqlconn&
       sqlconn& = 0
       Unload FGenerales
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
       MsgBox "El código de la agencia es mandatorio", 0 + 16, "Mensaje de Error"
       txtCampo(1).SetFocus
       Exit Sub
    End If

    VTFilaTemp% = grdRol.Row

    ' Rol
    grdRol.Row = 1
    grdRol.Col = 1
    If grdRol.Text = "" Then
       SqlClose sqlconn&
       sqlconn& = 0
       MsgBox "No existen roles definidos para el usuario", 0, "Mensaje del Servidor"
       Unload FGenerales
       Exit Sub
    End If
    
    ' Inicialiacion de los parametros de conexion
    If VTFilaTemp% = 0 Then
       VTFilaTemp% = 1
    End If
    
    grdRol.Row = VTFilaTemp%
    VTRolNum% = Val(grdRol.Text)
    VTRol$ = Str$(VTRolNum%)
    VGRol$ = VTRol$
    grdRol.Col = 2
    VLRol_Time_Out = Val(grdRol.Text)
        
    '----------------------------------------------
    ' Control de tiempo para timeout de conexion
    VLHookTiempo = CLng(VLRol_Time_Out&)
    '----------------------------------------------
        
    VLSection$ = "network"
    VLEntry$ = "ComputerName"
    VLDefault$ = "TERMX"
    VLLong% = 15
    VLFileName$ = "system.ini"
     
     '**** OBTIENE NOMBRE MAQUINA CON MANEJO PARA TERMINAL SERVICES   --OUS
     Dim valor As Boolean
'FIXIT: Replace 'String' function with 'String$' function                                  FixIT90210ae-R9757-R1B8ZE
     VTTamanio$ = String(22, 32)
'FIXIT: Replace 'String' function with 'String$' function                                  FixIT90210ae-R9757-R1B8ZE
     VLTerminalName$ = String(22, 32)
    
     'OBTIENE EL NOMBRE DE LA MAQUINA
     valor = NombreCliente(VTTamanio, VLTerminalName)
    
     If Val(VTTamanio) = 1 Then
          VLTerminalName = FMGetComputerName()
     Else
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
         If Asc(Mid(VLTerminalName$, Val(VTTamanio), 1)) = 0 Then
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
            VLTerminalName = Mid(VLTerminalName$, 1, Val(VTTamanio) - 1)
         End If
     End If
    'FIN MANEJO PARA TERMINAL SERVICES
    
    VLValor$ = VLTerminalName
    HostName$ = VLValor$
      
    PMPasoValores sqlconn&, "@i_server", 0, SQLVARCHAR, ServerNameLocal$
    PMPasoValores sqlconn&, "@i_login", 0, SQLVARCHAR, VGLogin$
    PMPasoValores sqlconn&, "@i_password", 0, SQLVARCHAR, Password$
    PMPasoValores sqlconn&, "@i_terminal", 0, SQLVARCHAR, HostName$
    PMPasoValores sqlconn&, "@i_office", 0, SQLINT4, (txtCampo(1).Text)
    PMPasoValores sqlconn&, "@i_role", 0, SQLINT4, VGRol$
    'I.CVA Oct-09-06 Agregar parámetro Filial
    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT2&, (txtCampo(0).Text)
    'F.CVA Oct-09-06 Agregar parámetro Filial
    PMPasoValores sqlconn&, "@i_campwd", 0, SQLINT1&, "1"
    PMPasoValores sqlconn&, "@o_campwd", 1, SQLINT1&, ""
    If FMTransmitirRPC(sqlconn&, "", "master", "sp_reclogin", False, "") Then
       PMMapeaVariable sqlconn&, VTMensaje$
       PMChequea sqlconn&
       VTreturn% = FMRetStatus(sqlconn&)
       
       VGFilial$ = txtCampo(0).Text
       VGOficina$ = txtCampo(1).Text
       
       VTTemporal$ = FMRetParam(sqlconn&, 1)
       If VTTemporal$ = "1" Then
            Me.Visible = False
            PMCambioPassword sqlconn&, ServerName$, ServerNameLocal$, VGLogin$, VGFilial, VGOficina
            Me.Visible = True
            FPrincipal.PMDesconectar    'OUS 11/09/2009
            Exit Sub
        End If
        
       ' Registro del usuario exitoso
       If VTreturn% = 0 Then
               
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
            VLHookTiempo = 900 '60
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
             FPrincipal!pnlTransaccionLine.Caption = " Capturando transacciones..."
             FPrincipal!mnuLogon.Enabled = False
             FPrincipal!mnuLogoff.Enabled = True
             FPrincipal!mnuPassword.Enabled = True
             
             'MVE Credipyme Julio 2009
             'Validar si el producto corrientes esta o no instalado
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "78"
             PMPasoValores sqlconn&, "@i_prod", 0, SQLVARCHAR, "XXX"
             PMPasoValores sqlconn&, "@i_instalado", 0, SQLCHAR, "S"
             If FMTransmitirRPC(sqlconn&, "", "cobis", "sp_cons_param_inicio", False, "") Then
                ReDim VTArreglo(1) As String
                VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
                PMChequea sqlconn&
             Else
                PMLogOff
                Unload Me
                Exit Sub
             End If
             
             
             If VTArreglo(1) = "N" Then
                FPrincipal!mnuCamara(0).Visible = False
                FPrincipal.mnuAdmin3(9).Visible = False
                FPrincipal!mnuadmin6(29).Visible = False
                FPrincipal!mnuadmin4(8).Visible = False
                FPrincipal!mnuAdmin5(9).Visible = False
                FPrincipal!mnuadmin6(10).Visible = False
                FPrincipal!mnuadmin6(20).Visible = False
                FPrincipal!mnuadmin6(23).Visible = False
                FPrincipal!mnuadmin6(24).Visible = False
                FPrincipal!mnuadmin6(25).Visible = False
                FPrincipal!mnuadmin6(26).Visible = False
                FPrincipal!mnuadmin6(30).Visible = False
                FPrincipal!mnuadmin6(33).Visible = False
                FPrincipal!mnuAdmin0(0).Visible = False
                FPrincipal!mnuAdmin0(1).Visible = False
                FPrincipal!mnuAdmin0(2).Visible = False

                
                'CVargas Abr-13-07
                FPrincipal!mnuVolEfectivo.Visible = False
               
             Else
                FPrincipal!mnuadmin4(8).Visible = True
                FPrincipal!mnuAdmin5(9).Visible = True
                FPrincipal!mnuadmin6(10).Visible = True
                FPrincipal!mnuadmin6(33).Visible = True
                
                
                For i% = 0 To 4
                    PMMenuSeguridad FPrincipal!mnuTotales(i%)
                Next i%
                
                
                'CVargas Abr-13-07
                PMMenuSeguridad FPrincipal!mnuVolEfectivo
                
             End If 'MVE Sep012009
             
             FPrincipal!mnuAhorros.Enabled = True
             FPrincipal!mnuReCamara.Enabled = True
             FPrincipal!mnuContenido.Enabled = True
             FPrincipal!mnuBloquear.Enabled = True
             FPrincipal!mnuadmin.Enabled = True
             
             
             
            
            PMMenuSeguridad FPrincipal!mnuTranctaaho(7)
            PMMenuSeguridad FPrincipal!mnuTranctaaho(15)
            PMMenuSeguridad FPrincipal!mnuTranAho1(0)
            PMMenuSeguridad FPrincipal!mnuTranAho1(1)
            PMMenuSeguridad FPrincipal!mnuTranAho1(2)
            PMMenuSeguridad FPrincipal!mnuTranAho1(3)
            PMMenuSeguridad FPrincipal!mnuTranAho1(4)
            PMMenuSeguridad FPrincipal!mnuTranAho1(5)
            PMMenuSeguridad FPrincipal!mnuTranAho1(6)   ' REQ 306 ACTIVACION CTAS SIN DEPOSITO INICIAL
            PMMenuSeguridad FPrincipal!mnuTranAho2(0)
            PMMenuSeguridad FPrincipal!mnuTranAho2(1)
            PMMenuSeguridad FPrincipal!mnuTranAho3(0)
            PMMenuSeguridad FPrincipal!mnuTranAho3(1)
            PMMenuSeguridad FPrincipal!mnuTranAho6(0)
            PMMenuSeguridad FPrincipal!mnuTranAho6(1)
            PMMenuSeguridad FPrincipal!mnuTranAho6(2)
            PMMenuSeguridad FPrincipal!mnuTranAho6(3)
            PMMenuSeguridad FPrincipal!mnuTranAho7(1)
            PMMenuSeguridad FPrincipal!mnuTranAho7(2)
            PMMenuSeguridad FPrincipal!mnuTranAho7(3)
            PMMenuSeguridad FPrincipal!mnuTranAho7(5)
            PMMenuSeguridad FPrincipal!mnuTranAho7(6)
            PMMenuSeguridad FPrincipal!mnuTranAho7(7)
            PMMenuSeguridad FPrincipal!mnuTranAho7(8)
            PMMenuSeguridad FPrincipal!mnuTranAho7(9)
            PMMenuSeguridad FPrincipal!mnuTranAho7(10)
            PMMenuSeguridad FPrincipal!mnuTranAho7(14)
            PMMenuSeguridad FPrincipal!mnuTranAho7(15)
            PMMenuSeguridad FPrincipal!mnuTranAho7(18)
            PMMenuSeguridad FPrincipal!mnuTranAho7(22)
            PMMenuSeguridad FPrincipal!mnuTranAho7(23)  ' Mnu Consulta de Ctas con Caracteristicas Especiales
            PMMenuSeguridad FPrincipal!mnuTranAho7(24)
            PMMenuSeguridad FPrincipal!mnuTranAho8(1)
            PMMenuSeguridad FPrincipal!mnuTranAho8(2)
            For i% = 0 To 9
                If i% <> 3 Then PMMenuSeguridad FPrincipal!mnuTranRemesas(i%)
            Next i%
         
            PMMenuSeguridad FPrincipal!mnuHoldRes
            'FPrincipal!mnuCamara2(5).Enabled = True
            
            PMMenuSeguridad FPrincipal!mnuAdmin0(0)
            PMMenuSeguridad FPrincipal!mnuAdmin0(1)
            PMMenuSeguridad FPrincipal!mnuAdmin0(2)
            PMMenuSeguridad FPrincipal!mnuAdmin0(3)
            
            PMMenuSeguridad FPrincipal!mnuAdmin3(7)
            
            'LBM040305
            PMMenuSeguridad FPrincipal.mnuAdmin3(8)
            
            PMMenuSeguridad FPrincipal!mnuadmin4(8)
            PMMenuSeguridad FPrincipal!mnuAdmin5(9)
            PMMenuSeguridad FPrincipal!mnuadmin6(10)
            PMMenuSeguridad FPrincipal!mnuadmin6(11)
            'SSO 13-03-2004 BDF; Inclusion de controles para seguridades
            'PMMenuSeguridad FPrincipal!mnuadmin7(31)   'Mantenimiento de Relaciones Comparativo Auxiliar
            ' AVI 4-May-2005    G.Bank
            'PMMenuSeguridad FPrincipal!mnugmf
            PMMenuSeguridad FPrincipal!mnuTransferencias(1)    ' AVI 22/Jul/2005
            For i% = 0 To 4
                If i% <> 3 Then 'JSA 20160509 MIGRACION COBIS CLOUD
                    PMMenuSeguridad FPrincipal!mnuAdmin7(i%)
                End If
            Next i%
            PMMenuSeguridad FPrincipal!mnuadmin8(2)
            PMMenuSeguridad FPrincipal!mnuadmin8(4)
            PMMenuSeguridad FPrincipal!mnuadmin8(5)
            PMMenuSeguridad FPrincipal!mnuadmin8(6)
            PMMenuSeguridad FPrincipal!mnuAutRetOfi 'Autorizacion Retiros en Oficina
            PMMenuSeguridad FPrincipal!mnuMantDTN   'REQ 322 Cuentas Inactivas
            PMMenuSeguridad FPrincipal!mnuConsTransf 'REQ 353 Alianzas Comerciales
            PMMenuSeguridad FPrincipal!mnuRelCtaCanal   'REQ 363 Relacion CTA Canal
            PMMenuSeguridad FPrincipal!mnuCB        'REQ 381 - Red Propia
            PMMenuSeguridad FPrincipal!mnuMttoCB(0) 'REQ 381 - Red Propia
            PMMenuSeguridad FPrincipal!mnuMttoCB(1) 'REQ 381 - Red Propia
            PMMenuSeguridad FPrincipal!mnuMttoCB(2) 'REQ 381 - Red Propia
            PMMenuSeguridad FPrincipal!mnuMttoCB(3) 'REQ 381 - Red Propia
            PMMenuSeguridad FPrincipal!mnuMttoCB(4) 'REQ 420 - Red Posicionada Consultas e Informes
            PMMenuSeguridad FPrincipal!mnuMttoCB(5) 'REQ 420 - Red Posicionada Consultas e Informes
            PMMenuSeguridad FPrincipal!mnuMttoCB(6) 'REQ 420 - Red Posicionada Consultas e Informes
            PMMenuSeguridad FPrincipal!mnuMttoCB(7) 'REQ 381 - Red Propia
            PMMenuSeguridad FPrincipal!mnuMttoCB(8) 'REQ 381 - Red Propia
            PMMenuSeguridad FPrincipal!mnuMtoEquiv  'REQ 517 - Mto Equivalencias Homologación
            
            'esta parte la aumento VMO el dia 28 de Julio de 1998
            VGNombreFilial$ = lblDescripcion(0).Caption
            VGNombreOficina$ = lblDescripcion(1).Caption
            ' Default de Moneda
            PMGetDefault VGOficina$, "cl_moneda", VLMon$, VLDes$
            ' Cosulta de las monedas de trabajo del banco
            ReDim VTMoneda(2, 150) As String
            PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_moneda"
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la filial " & "[" & txtCampo(Index%).Text & "]") Then
               VTR1% = FMMapeaMatriz(sqlconn&, VTMoneda())
               PMChequea sqlconn&
               If VTR1% = 0 Then
                  MsgBox "No existen Monedas", 0 + 16, "Mensaje del Servidor"
                  ' Cerrar la conexión pues si monedas no se puede trabajar
                  PMLogOff
                  Unload Me
                  Exit Sub
               End If
               ' Carga de las monedas al COMBO de Monedas
               FPrincipal!cmbMoneda.Clear
               FPrincipal!lbletiqueta.Visible = True
               FPrincipal!cmbMoneda.Visible = True
               'FPrincipal!cmbMoneda.Enabled = True
               PMObjetoSeguridad FPrincipal!cmbMoneda 'Pcoello seguridad sobre el combo
               j% = -1
               For i% = 1 To VTR1%
                   VTItem$ = VTMoneda(0, i%) & "-" & VTMoneda(1, i%)
                   FPrincipal!cmbMoneda.AddItem VTItem$, i% - 1
                   If VTMoneda(0, i%) = VLMon$ Then j% = i% - 1
               Next i%
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
               If Trim(VLMon$) <> "" And j% <> -1 Then
                  FPrincipal!cmbMoneda.ListIndex = j%
                  VGMoneda$ = VLMon$
               Else
                  FPrincipal!cmbMoneda.ListIndex = 0
                  VGMoneda$ = VTMoneda(0, 1)
               End If
            Else
               MsgBox "No existen Monedas", 0 + 16, "Mensaje del Servidor"
               ' Cerrar la conexión pues si monedas no se puede trabajar
               PMLogOff
               Unload Me
               Exit Sub
            End If
            
            ' Carga de parámetros iniciales para cuentas corrientes
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "78"
             PMPasoValores sqlconn&, "@i_prod", 0, SQLVARCHAR, "CTE"
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
            
             If FMTransmitirRPC(sqlconn&, "", "cobis", "sp_cons_param_inicio", False, "") Then
                ReDim VTArreglo(11) As String
                VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
                PMChequea sqlconn&
                If VTR1% <> 0 Then
                   VGLongCtaCte% = Val(VTArreglo(1))
                   VGPesosCtaCte$ = VTArreglo(2)
                   VGModuloCtaCte% = Val(VTArreglo(3))
                   VGMascaraCtaCte$ = VTArreglo(4)
                   If VTArreglo(5) = "N" Then
                      VGDecimales$ = "#,##0"
                   Else
                      VGDecimales$ = "#,##0.00"
                   End If
                   VGNivelMaximo$ = VTArreglo(6)
                   VGNumGCtaCte% = Val(VTArreglo(7))
                   VGCtaGerencia$ = VTArreglo(8)
                   VGFecha$ = VTArreglo(9)
                   VGCodBanco$ = VTArreglo(10)
                   '  Pone VGfecha en formato de preferencias
                   VGFecha$ = FMConvFecha((VTArreglo(9)), CGFormatoBase, VGFormatoFecha$)
                   FPrincipal.pnlHora.Caption = Format(VGFecha, VGFormatoFecha$) + Format$(Now, " hh:mm")
                   VTMonto = VTArreglo(11)
                   If IsNumeric(VTMonto) Then
                      VGMontoVerCheque@ = CCur(VTMonto)
                   End If
                Else
                   MsgBox "Error en consulta de Parámetros iniciales de Depósitos Monetarios", 0 + 16, "Mensaje del Servidor"
                   PMLogOff
                   Unload Me
                   Exit Sub
                End If
             Else
                MsgBox "Error en consulta de Parámetros iniciales de Depósitos Monetarios", 0 + 16, "Mensaje del Servidor"
                PMLogOff
                Unload Me
                Exit Sub
             End If

             ' Carga de parámetros iniciales para cuentas de ahorros
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "78"
             PMPasoValores sqlconn&, "@i_prod", 0, SQLVARCHAR, "AHO"
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             If FMTransmitirRPC(sqlconn&, "", "cobis", "sp_cons_param_inicio", False, "") Then
                ReDim VTArreglo(10) As String
                'ReDim VGPrefijo_cta(3, 300) As String  'lgra (3,100)
                VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
                VTR2% = FMMapeaMatriz(sqlconn&, VTMoneda())
                'VGMaxPrefijos = FMMapeaMatriz(sqlconn&, VGPrefijo_cta())
                PMMapeaVariable sqlconn&, VGCteAbanks$
                PMMapeaVariable sqlconn&, VGCodPais$
                PMMapeaVariable sqlconn&, VGManejaNdNc$
                PMMapeaVariable sqlconn&, VGLineaPend$
                PMChequea sqlconn&
                
                If VTR1% <> 0 Then
                   VGLongCtaAho% = Val(VTArreglo(1))
                   VGPesosCtaAho$ = VTArreglo(2)
                   VGModuloCtaAho% = Val(VTArreglo(3))
                   VGMascaraCtaAho$ = VTArreglo(4)
                   VGNumGCtaAho% = Val(VTArreglo(7))
                Else
                   MsgBox "Error en consulta de Parámetros iniciales de Cuentas de Ahorros", 0 + 16, "Mensaje del Servidor"
                   PMLogOff
                   Unload Me
                   Exit Sub
                End If
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "78"
                PMPasoValores sqlconn&, "@i_prod", 0, SQLVARCHAR, "AHO"
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                PMPasoValores sqlconn&, "@i_consulta", 0, SQLVARCHAR, "S"
                If FMTransmitirRPC(sqlconn&, "", "cobis", "sp_cons_param_inicio", False, "") Then
                   ReDim VGPrefijo_cta(3, 2000) As String  'lgra (3,2000)
                   VGMaxPrefijos = FMMapeaMatriz(sqlconn&, VGPrefijo_cta())
                   PMChequea sqlconn&
                Else
                    MsgBox "Error en consulta de Parámetros iniciales de Cuentas de Ahorros", 0 + 16, "Mensaje del Servidor"
                    PMLogOff
                    Unload Me
                    Exit Sub
                End If
                
                PLDatosContabilidad
             Else
                MsgBox "Error en consulta de Parámetros iniciales de Cuentas de Ahorros", 0 + 16, "Mensaje del Servidor"
                PMLogOff
                Unload Me
                Exit Sub
             End If
             
            If VGCodPais$ = "CO" Then
               'Opciones GMF - Colombia
               FPrincipal!mnugmf.Visible = True
               FPrincipal!mnuctasexegmf.Visible = True
               FPrincipal!mnuupdgmf.Visible = True
               PMMenuSeguridad FPrincipal!mnuctasexegmf
               PMMenuSeguridad FPrincipal!mnuupdgmf
               FPrincipal!mnuLinea20.Visible = False
               FPrincipal!mnuTranctaaho(11).Visible = False
               FPrincipal!mnuTranAho7(19).Visible = False
               
            Else
               FPrincipal!mnugmf.Visible = False
               For i% = 0 To 6
                   If i% <= 2 Then 'JSA 20160509 MIGRACION COBIS CLOUD
                      FPrincipal!mnuAdmin7(i%).Visible = False
                   End If
                   If i% > 3 Then 'JSA 20160509 MIGRACION COBIS CLOUD
                      FPrincipal!mnuadmin8(i%).Visible = False
                   End If
               Next i%
            End If

             Set_Preferencia "FILIAL", (txtCampo(0).Text)
             Set_Forma_Preferencia "FILIAL", (txtCampo(0).Text) & " - " & (lblDescripcion(0).Caption)
             Set_Preferencia "OFICINA", (txtCampo(1).Text)
             Set_Forma_Preferencia "OFICINA", (txtCampo(1).Text) & " - " & (lblDescripcion(1).Caption)
             Set_Preferencia "ROL", VGRol$
             Set_Forma_Preferencia "ROL", VGRol$ & " - " & Mid$(grdRol.Text, InStr(1, grdRol.Text, Chr$(9)) + 1, Len(grdRol.Text))
             Set_Preferencia "TERMINAL", HostName$
             Set_Forma_Preferencia "TERMINAL", HostName$
             'Set_Forma_Preferencia "ROL", VGRol$ & " - " & Mid$(lstRol.Text, InStr(1, lstRol.Text, Chr$(9)) + 1, Len(lstRol.Text))
          Else
             SqlClose sqlconn&
             sqlconn& = 0
             MsgBox "No existen transacciones autorizadas", 48, "Mensaje del Servidor"
             Unload FGenerales
          End If
          MsgBox VTMensaje$ & Chr$(13) & VTMail$, 0, "Mensaje del Servidor"
          Unload FGenerales
       Else
          MsgBox VTMensaje$ & Chr$(13) & VTMail$, 0, "Mensaje del Servidor"
          Unload FGenerales
          SqlClose sqlconn&
          sqlconn& = 0
          MsgBox "El usuario " & VGLogin$ & Chr$(13) & "No se registró con el servidor", 0, "Mensaje del Servidor"
          Unload FGenerales
       End If
    Else
       SqlClose sqlconn&
       sqlconn& = 0
       MsgBox "El usuario " & VGLogin$ & Chr$(13) & "No se registró con el servidor", 0, "Mensaje del Servidor"
'       SqlExit
'       SqlWinExit
       Unload FGenerales
    End If
End Sub


Private Sub Form_Activate()
'If SqlConn& = 0 Then
' Unload FGenerales
'End If
End Sub

Private Sub Form_Load()
'*********************************************************
'PROPOSITO: Permite cargar la forma de generales
'           cargando los datos existentes en el archivo
'           de preferencias
'INPUT   :  ninguno
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'*********************************************************

Dim VTRol As String
Dim VLEncuentra As String


    PMLoadResStrings Me
    PMLoadResIcons Me

    If Get_Preferencia("DEBUG") = "S" Then
       PMDebug sqlconn&, True
    Else
       PMDebug sqlconn&, False
    End If
    
    PMPasoValores sqlconn&, "@login", 0, SQLVARCHAR, VGLogin$
    FPrincipal.pnlTransaccionLine.Caption = "" 'FCO Migracion
     
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "rp_rol", False, "") Then
       'PMMapeaListaH SqlConn&, lstRol, False
       PMMapeaGrid sqlconn&, grdRol, False
       PMChequea sqlconn&
       grdRol.ColWidth(2) = 3900
       grdRol.ColWidth(3) = 550
       If grdRol.Tag = 0 Then
          MsgBox "Usuario No Válido, No tiene Roles Asignados", 48, "Parámetros de Conexión"
          SqlClose (sqlconn&)
          sqlconn& = 0
       Else
          'Seteo de Filial
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
           
          If grdRol.Cols > 3 Then
             grdRol.Cols = 3
          End If

          'Seteo de Oficina
          txtCampo(1).Text = Get_Preferencia("OFICINA")
          
          PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, "cl_oficina"
          PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
          PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCampo(1).Text)
          FPrincipal.pnlTransaccionLine.Caption = "" 'FCO Migracion
          If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", False, "") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(1)
             PMChequea sqlconn&
          Else
             txtCampo(1).Text = ""
             lblDescripcion(1).Caption = ""
          End If
            
          If grdRol.Cols > 3 Then
             grdRol.Cols = 3
          End If
           
          VTRol$ = Get_Preferencia("ROL")
            
          'For I% = 0 To lstRol.ListCount - 1
            
          VLEncuentra$ = "N"  'FCO Migracion se inserta esta linea
            
          For i% = 1 To grdRol.Rows - 1
              'lstRol.ListIndex = I%
              grdRol.Row = i%
              grdRol.Col = 1
              'If VTRol$ = Mid$(lstRol.Text, 1, InStr(1, lstRol.Text, Chr$(9)) - 1) Then
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
    lblDescripcion(2).Caption = CStr(App.Major) + "." + CStr(App.Minor) + "." + CStr(App.revision) + " - " + App.CompanyName
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdRol_Click()
    If Val(grdRol.Tag) > 0 Then
            PMLineaG grdRol
    End If
End Sub

Private Sub txtCampo_Change(Index As Integer)
'*********************************************************
'PROPOSITO: Permite activar la ayuda por LostFocus si se
'           cambia el campo respectivo
'INPUT   :  ninguno
'OUTPUT  :  ninguno
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
'PROPOSITO: Permite desplegar en la barra de ayuda el
'           significado del campo actual
'INPUT   :  ninguno
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'*********************************************************
    
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Código de la filial [F5 Ayuda]"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Código de la agencia [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
'*********************************************************
'PROPOSITO: Permite desplegar la lista de ayuda F5
'           del campo actual
'INPUT   :  ninguno
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'*********************************************************
    If Keycode% = VGTeclaAyuda% Then
        VLPaso% = True
        Select Case Index%
        Case 0
            VGOperacion$ = "sp_filial"
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_filial"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la filial " & "[" & txtCampo(Index%).Text & "]") Then
                 Load grid_valores
                 PMMapeaGrid sqlconn&, grid_valores!gr_SQL, False
                 PMChequea sqlconn&
                PMProcesG
                grid_valores.bb_buscar.Enabled = True 'False
                grid_valores.bb_siguiente.Enabled = False
                
                 'Actualización para NCS por T. Suárez
                 PMHelpG "cobis", "sp_hp_catalogo", 4, 0
                 PMBuscarG 1, "@i_tabla", "cl_filial", SQLCHAR&
                 PMBuscarG 2, "@i_tipo", "A", SQLCHAR&
                 PMBuscarG 3, "@i_modo", "0", SQLINT1&
                 PMBuscarG 4, "@i_codigo", "0", SQLCHAR&
                 'Fin Actualización para NCS por T. Suárez
                
                
                grid_valores.Show 1
                If Temporales(1) <> "" Then
                    txtCampo(0).Text = Temporales(1)
                    lblDescripcion(0).Caption = Temporales(2)
                    txtCampo(1).Text = ""
                    lblDescripcion(1).Caption = ""
                Else
                    If txtCampo(0) = "" Then
                        lblDescripcion(0).Caption = ""
                    Else
                        VGPaso% = False
                        txtCampo_LostFocus Index%
                    End If
                End If
                grid_valores.bb_buscar.Enabled = True
            End If
        Case 1
            If txtCampo(0).Text <> "" Then
                VGOperacion$ = "sp_oficina"
                 PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
                 
                 'Actualización para NCS por T. Suárez
                 PMHelpG "cobis", "sp_hp_catalogo", 4, 0
                 PMBuscarG 1, "@i_tabla", "cl_oficina", SQLCHAR&
                 PMBuscarG 2, "@i_tipo", "A", SQLCHAR&
                 PMBuscarG 3, "@i_modo", "0", SQLINT1&
                 PMBuscarG 4, "@i_codigo", "0", SQLCHAR&
                 'Fin Actualización para NCS por T. Suárez
                  
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la agencia " & "[" & txtCampo(Index%).Text & "]") Then
                     Load grid_valores
                     PMMapeaGrid sqlconn&, grid_valores!gr_SQL, False
                     PMChequea sqlconn&
                    PMProcesG
                    grid_valores.bb_buscar.Enabled = True 'False
                    grid_valores.bb_siguiente.Enabled = False
                    grid_valores.Show 1
                    If Temporales(1) <> "" Then
                        txtCampo(1).Text = Temporales(1)
                        lblDescripcion(1).Caption = Temporales(2)
                    Else
                        If txtCampo(1).Text = "" Then
                            lblDescripcion(1).Caption = ""
                        Else
                            VGPaso% = False
                            txtCampo_LostFocus Index%
    
                        End If
                    End If
                    grid_valores.bb_buscar.Enabled = True
                End If
            Else
                MsgBox "El código de la filial es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(0).SetFocus
            End If
        End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
'*********************************************************
'PROPOSITO: Permite activar las teclas permitidas del campo
'           actual, ya sean estos digitos o letras
'INPUT   :  ninguno
'OUTPUT  :  ninguno
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
'PROPOSITO: Permite obtener la ayuda por LostFocus del
'           campo actual
'INPUT   :  ninguno
'OUTPUT  :  ninguno
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
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la agencia " & "[" & txtCampo(Index%).Text & "]") Then
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
        End Select
    End If
End Sub


