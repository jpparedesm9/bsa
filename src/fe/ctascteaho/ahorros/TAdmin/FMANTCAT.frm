VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FMantCatalogo 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Creación y Actualización de Tablas de Referencias"
   ClientHeight    =   5310
   ClientLeft      =   300
   ClientTop       =   2310
   ClientWidth     =   9390
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00C0C0C0&
   HelpContextID   =   400
   Icon            =   "FMANTCAT.frx":0000
   LinkMode        =   1  'Source
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5310
   ScaleWidth      =   9390
   Begin Threed.SSPanel pnlBotones 
      Height          =   855
      Left            =   45
      TabIndex        =   13
      Top             =   4425
      Visible         =   0   'False
      Width           =   9255
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   15
      ForeColor       =   8421504
      BackColor       =   -2147483633
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   0
      FloodShowPct    =   0   'False
      Alignment       =   1
      Begin Threed.SSCommand cmdCancelar 
         Height          =   795
         Left            =   8340
         TabIndex        =   20
         Top             =   30
         Width           =   870
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   78
         Caption         =   "&Salir"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FMANTCAT.frx":030A
      End
      Begin Threed.SSCommand cmdLimpiar 
         Height          =   795
         Left            =   7455
         TabIndex        =   19
         Top             =   30
         Width           =   870
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   78
         Caption         =   "&Limpiar"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FMANTCAT.frx":0680
      End
      Begin Threed.SSCommand cmdTransmitir 
         Height          =   795
         Left            =   6600
         TabIndex        =   18
         Top             =   30
         Width           =   870
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   78
         Caption         =   "&Transmitir"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FMANTCAT.frx":09F6
      End
   End
   Begin Threed.SSFrame fraBusqueda 
      Height          =   5325
      Left            =   15
      TabIndex        =   11
      Top             =   15
      Width           =   9345
      _Version        =   65536
      _ExtentX        =   16484
      _ExtentY        =   9393
      _StockProps     =   14
      ForeColor       =   255
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.ComboBox cboTabla 
         Appearance      =   0  'Flat
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2775
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   105
         Width           =   3060
      End
      Begin Threed.SSCommand cmdSalir1 
         Height          =   795
         Left            =   8400
         TabIndex        =   4
         Top             =   4440
         Width           =   870
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   78
         Caption         =   "&Salir"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Picture         =   "FMANTCAT.frx":0D6C
      End
      Begin Threed.SSCommand cmdActualizar 
         Height          =   795
         Left            =   8400
         TabIndex        =   3
         Tag             =   "585"
         Top             =   3645
         Width           =   870
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   78
         Caption         =   "&Actualizar"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Enabled         =   0   'False
         Picture         =   "FMANTCAT.frx":10E2
      End
      Begin Threed.SSCommand cmdIngresar 
         Height          =   795
         Left            =   8400
         TabIndex        =   2
         Tag             =   "584"
         Top             =   2850
         Width           =   870
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   78
         Caption         =   "&Crear"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Enabled         =   0   'False
         Picture         =   "FMANTCAT.frx":13FC
      End
      Begin Threed.SSCommand cmdSiguiente 
         Height          =   795
         Left            =   8400
         TabIndex        =   6
         Tag             =   "1564;1222;1209;1389"
         Top             =   2055
         Width           =   870
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   78
         Caption         =   "Siguiente"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Enabled         =   0   'False
         Picture         =   "FMANTCAT.frx":1716
      End
      Begin Threed.SSCommand cmdBuscar 
         Height          =   795
         Left            =   8400
         TabIndex        =   5
         Tag             =   "1564;1222;1209;1389"
         Top             =   1275
         Width           =   870
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   78
         Caption         =   "&Buscar"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Enabled         =   0   'False
         Picture         =   "FMANTCAT.frx":1A8C
      End
      Begin MSGrid.Grid grdValores 
         Height          =   4710
         Left            =   120
         TabIndex        =   1
         Top             =   465
         Width           =   8235
         _Version        =   65536
         _ExtentX        =   14527
         _ExtentY        =   8308
         _StockProps     =   77
         ForeColor       =   0
         BackColor       =   16777215
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label il_tabla 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Tablas de Catálogo:"
         ForeColor       =   &H000000C0&
         Height          =   285
         Left            =   90
         TabIndex        =   14
         Top             =   150
         Width           =   2640
      End
   End
   Begin Threed.SSFrame fraCatalogo 
      Height          =   2655
      Left            =   0
      TabIndex        =   10
      Top             =   1080
      Visible         =   0   'False
      Width           =   9270
      _Version        =   65536
      _ExtentX        =   16352
      _ExtentY        =   4683
      _StockProps     =   14
      Caption         =   "Datos Generales"
      ForeColor       =   255
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.TextBox txtEstado 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   0
         Left            =   1650
         MaxLength       =   1
         TabIndex        =   9
         Top             =   1605
         Width           =   495
      End
      Begin VB.TextBox txtDescripcion 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Index           =   0
         Left            =   1650
         MaxLength       =   64
         TabIndex        =   8
         Top             =   1260
         Width           =   6870
      End
      Begin VB.TextBox TxtCodigo 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   0
         Left            =   1650
         MaxLength       =   10
         TabIndex        =   7
         Top             =   960
         Width           =   1905
      End
      Begin VB.Label lbldEstado 
         Appearance      =   0  'Flat
         BackColor       =   &H80000004&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   315
         Index           =   0
         Left            =   2160
         TabIndex        =   17
         Top             =   1605
         Width           =   3045
      End
      Begin VB.Label lblEstado 
         Appearance      =   0  'Flat
         BackColor       =   &H80000004&
         Caption         =   "Estado:"
         ForeColor       =   &H00800000&
         Height          =   285
         Index           =   0
         Left            =   495
         TabIndex        =   16
         Top             =   1620
         Width           =   1140
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000004&
         Caption         =   "Descripción:"
         ForeColor       =   &H00800000&
         Height          =   300
         Index           =   0
         Left            =   480
         TabIndex        =   12
         Top             =   1260
         Width           =   1140
      End
      Begin VB.Label lblCodigo 
         Appearance      =   0  'Flat
         BackColor       =   &H80000004&
         Caption         =   "Código:"
         ForeColor       =   &H00800000&
         Height          =   285
         Index           =   0
         Left            =   495
         TabIndex        =   15
         Top             =   960
         Width           =   1140
      End
   End
End
Attribute VB_Name = "FMantCatalogo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*********************************************************
'   Archivo:        FCATALG.FRM
'   Producto:       Master Information Subsystem
'   Diseñado por:   Myriam Dávila
'   Fecha de Documentación: 14/Ene/94
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
' Forma: FMantCatalogo
' Descripción:  Esta forma permite realizar el mantenimien-
'               to de los datos de las tablas de catálogo
'               que están relacionadas con el MIS
' VARIABLES GLOBALES:
'           ServerName$         nombre del servidor
' MODULOS:
'           MHELPG.BAS = Rutinas para usar la ventana de ayuda
'*********************************************************
Option Explicit
'CONSTANTES
Const INSERTAR% = 1      'Operación Actual
Const Actualizar% = 2
Const Caracter% = 9

'VARIABLES
Dim VLTabla As String        'Variable que indica la tabla de
                             'catalogo a ser manipulada
Dim VLOpCatalogo As Integer  'Variable para indicar la operación a
                             'realizarse.
Dim VLactual As String       'Variable para indicar el valor actual del
                             'combo box con la lista de tablas del catalogo
Dim VLCargar As Integer      'Indica que el proceso inicial de carga de tablas se realiza
Dim VLPaso As Integer        'Indica si el contenido de un campo a cambiado

'Utilizado en la subrutina cmdActualizar_Click () para almacenar los datos de un catalogo específico
Dim VLOficina As String      'indica la oficina default
Dim VLNumLin As Integer      'indica el numero veces que se presiona siguiente
Dim ubicacion As Integer
Dim VLRPC As String
Dim VTR As Integer
Dim i As Integer

Private Sub cboTabla_Click()
'*********************************************************
'Objetivo:  Selecciona una tabla de catálogo del combo
'           si la tabla cambia, automáticamente llama a
'           la rutina del botón buscar.
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    If Not VLCargar% Then
        If VLactual$ <> cboTabla.Text Then
            VLactual$ = cboTabla.Text
            cmdBuscar_Click
        End If
    End If
End Sub

Private Sub cboTabla_GotFocus()
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal!pnlTransaccionLine.Caption = ""
    FPrincipal!pnlHelpLine.Caption = " Escoja una tabla para mantenimiento"
End Sub

Private Sub cmdActualizar_Click()
'*********************************************************
'Objetivo:  Con los datos del registro de la línea del
'           grid escogido. Llena los campos del frame
'           apropiado y lo despliega para que se puedan
'           actualizar los datos del registro.
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'04/Abr/01  R.Avila RIA01       Agragar tipo cuenta patrimonio
'*********************************************************
Dim VTRow%
    VTRow% = grdValores.Row
    grdValores.Row = 1
    grdValores.Col = 1
    'chequea que el grid no esté vacío.
    If grdValores.Rows >= 2 And grdValores.Text <> "" Then
        grdValores.Row = VTRow%
        VLOpCatalogo% = Actualizar%
        grdValores.Col = 1
        TxtCodigo(0).Text = grdValores.Text
        grdValores.Col = 2
        txtdescripcion(0).Text = grdValores.Text
        grdValores.Col = 3
        txtEstado(0).Text = grdValores.Text
        txtEstado_lostfocus (0)
        grdValores.Row = 0
        grdValores.Col = 1
        fraCatalogo.Caption = grdValores.Text
        fraCatalogo.Visible = True
        TxtCodigo(0).Enabled = False
        txtEstado(0).Enabled = True
        fraBusqueda.Visible = False
        pnlBotones.Visible = True
        cmdLimpiar.Enabled = False
    End If
End Sub

Private Sub cmdActualizar_GotFocus()
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal!pnlTransaccionLine.Caption = ""
    FPrincipal!pnlHelpLine.Caption = " Actualizar los datos de un Registro"
End Sub

Private Sub cmdBuscar_Click()
'*********************************************************
'Objetivo:  De acuerdo a la tabla escogida en el combo box
'           llama al stored procedure que busca los regis-
'           tros existentes para dicha tabla.
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
ReDim VTArreglo(10) As String
'JAN FEB/01 Seguridad
    If cmdBuscar.Enabled = False Then
        MsgBox "Usted no está autorizado a ejecutar una Consulta", 48, "Control de Ingreso de Datos"
        Exit Sub
    End If
'JAN FEB/01
    VLNumLin = 0
    'obtiene el nombre de la tabla de la línea seleccionada en el combo box
    ubicacion% = InStr(1, cboTabla.Text, Chr$(Caracter%))
    VLTabla$ = Mid$(cboTabla.Text, ubicacion% + 1, Len(cboTabla.Text))
    VLRPC$ = "sp_catalogo"
    PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, VLTabla$
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "S"
    PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
    'codigo de transaccion
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1564"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_catalogo", True, "Búsqueda de Valores") Then
        VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
        PMMapeaGrid sqlconn&, grdValores, False
        PMChequea sqlconn&
       grdValores.Row = 0
       For i% = 1 To VTR%
           grdValores.Col = i%
           grdValores.Text = VTArreglo(i%)
       Next i%
       If grdValores.Rows >= VGMaximoRows% Then
           cmdSiguiente.Enabled = True
       Else
           cmdSiguiente.Enabled = False
       End If
       grdValores.Row = 1
    Else
       PMLimpiaG grdValores
    End If
End Sub

Private Sub cmdBuscar_GotFocus()
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal!pnlHelpLine.Caption = " Buscar Contenido de la Tabla"
End Sub

Private Sub cmdCancelar_Click()
'*********************************************************
'Objetivo:  Esta rutina oculta el frame con el registro
'           actual y el frame con los botones transmitir
'           limpiar y salir y pone visible el frame
'           con el combo box, el grid de registros y los
'           botones de mantenimiento (buscar, siguiente,
'           crear, actualizar y salir)
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    fraBusqueda.Visible = True
    fraCatalogo.Visible = False
    pnlBotones.Visible = False
    cmdTransmitir.Enabled = True
    cmdLimpiar_Click
    cmdBuscar_Click
End Sub

Private Sub cmdCancelar_GotFocus()
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal!pnlHelpLine.Caption = " Retornar a la Lista de Registros"
End Sub

Private Sub cmdIngresar_Click()
'*********************************************************
'Objetivo:  De acuerdo a la tabla escogida en el combo box
'           despliega el frame apropiado con los campos va-
'           cíos para ingresar los datos de un nuevo regis-
'           tro.
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    'obtiene el nombre de la tabla de la línea escogida del combo
    If cmdBuscar.Enabled = False Then Exit Sub
    VLOpCatalogo% = INSERTAR%
    ubicacion% = InStr(1, cboTabla.Text, Chr$(Caracter%))
    If ubicacion% > 0 Then
        VLTabla$ = Mid$(cboTabla.Text, ubicacion% + 1, Len(cboTabla.Text))
        If VLTabla$ = "cc_causa_nd_data" Or VLTabla$ = "cc_causa_nc_data" Or VLTabla$ = "ah_causa_nd_data" Or VLTabla$ = "ah_causa_nc_data" Or _
            VLTabla$ = "cc_causa_nc_caja" Or VLTabla$ = "cc_causa_nd_caja" Or VLTabla$ = "ah_causa_nc_caja" Or VLTabla$ = "ah_causa_nd_caja" Then
            MsgBox "Creación solo permitida por Opción de creación de Causales", 48, "Control de Datos"
            Exit Sub
        End If
        
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V"
        PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR&, "cl_estado_ser"
        PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR&, "V"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", False, "") Then
            PMMapeaObjeto sqlconn&, lbldEstado(0)
            txtEstado(0).Text = "V"
            PMChequea sqlconn&
        End If
        grdValores.Row = 0
        grdValores.Col = 2
        fraCatalogo.Caption = grdValores.Text
        fraCatalogo.Visible = True
        TxtCodigo(0).Enabled = True
        txtEstado(0).Enabled = False
        fraBusqueda.Visible = False
        pnlBotones.Visible = True
        cmdLimpiar.Enabled = True
    End If
End Sub

Private Sub cmdIngresar_GotFocus()
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal!pnlTransaccionLine.Caption = ""
    FPrincipal!pnlHelpLine.Caption = " Ingresar un Nuevo Registro a la Tabla"
End Sub

Private Sub cmdLimpiar_Click()
'*********************************************************
'Objetivo:  Limpia los campos del frame apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    TxtCodigo(0).Text = ""
    txtdescripcion(0).Text = ""
    cmdTransmitir.Enabled = True
    If fraCatalogo.Visible = True Then
        TxtCodigo(0).SetFocus
    End If
    cmdTransmitir.Enabled = True
    VLPaso% = True
End Sub

Private Sub cmdLimpiar_GotFocus()
    FPrincipal.pnlHelpLine.Caption = "Limpiar la Forma para el ingreso de nuevos datos"
End Sub

Private Sub cmdSalir1_Click()
'*********************************************************
'Objetivo:  Descarga la forma
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    Unload FMantCatalogo
End Sub

Private Sub cmdSalir1_GotFocus()
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal.pnlHelpLine.Caption = "Salir de la Forma"
End Sub

Private Sub cmdSiguiente_Click()
'*********************************************************
'Objetivo:  Busca los siguientes 20 registros de la tabla
'           actualmente escogida en el combo box
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
ReDim VTArreglo(10) As String
Dim VTTope As Long
    VTTope& = grdValores.Rows - 1
    VLRPC$ = "sp_catalogo"
    PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, VLTabla$
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "S"
    PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "1"
    grdValores.Row = grdValores.Rows - 1
    grdValores.Col = 1
    PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR&, (grdValores.Text)
    'codigo de transaccion
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1564"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_catalogo", True, "Búsqueda de Valores") Then
       PMMapeaGrid sqlconn&, grdValores, True
       VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
       grdValores.Row = 0
        PMChequea sqlconn&
       For i% = 1 To VTR%
           grdValores.Col = i%
           grdValores.Text = VTArreglo(i%)
       Next i%
    
       If Val(grdValores.Tag) >= VGMaximoRows% - 1 Then
           cmdSiguiente.Enabled = True
           If grdValores.Rows > VGMaximoRows% Then
               grdValores.TopRow = VTTope&
           End If
       Else
           If grdValores.Tag > 0 Then
               grdValores.TopRow = grdValores.Rows - grdValores.Tag - (VGMaximoRows% - grdValores.Tag)
           End If
           cmdSiguiente.Enabled = False
       End If
    End If
End Sub

Private Sub cmdSiguiente_GotFocus()
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal!pnlHelpLine.Caption = " Buscar Contenido de la Tabla"
End Sub

Private Sub cmdTransmitir_Click()
'*********************************************************
'Objetivo:  De acuerdo a la tabla actualmente escogida
'           y a la operacion acutal, invoca al stored procedure
'           apropiado con sus respectivos parámetros
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'04/Abr/01  R.Avila  RIA01      Agregar tipo de cuenta patrimonio
'*********************************************************
    Dim VLBdd As String
    Dim VLOpCatalgo As Integer
    VLRPC$ = "sp_catalogo"
    VLBdd$ = "cobis"
    If TxtCodigo(0).Text = "" Then
        MsgBox "El campo Código es Obligatorio", 48, "Control de Ingreso de Datos"
        TxtCodigo(0).SetFocus
        Exit Sub
    End If
    If txtdescripcion(0).Text = "" Then
        MsgBox "El campo Descripción es Obligatorio", 48, "Control de Ingreso de Datos"
        txtdescripcion(0).SetFocus
        Exit Sub
    End If

    If VLOpCatalgo% = Actualizar% Then
        If txtEstado(0).Text = "" Then
           MsgBox "El campo Estado es Obligatorio", 48, "Control de Ingreso de Datos"
           txtEstado(0).SetFocus
           Exit Sub
        End If
    End If

    PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, VLTabla$
    PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR&, (TxtCodigo(0).Text)
    PMPasoValores sqlconn&, "@i_descripcion", 0, SQLVARCHAR&, (txtdescripcion(0).Text)
    PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR&, (txtEstado(0).Text)
    Select Case VLOpCatalogo%
    Case INSERTAR%
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "584"
    Case Actualizar%
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "585"
    End Select
    Select Case VLOpCatalogo%
    Case INSERTAR%
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "I"
        cmdTransmitir.Enabled = False
    Case Actualizar%
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "U"
    End Select
    If FMTransmitirRPC(sqlconn&, ServerName$, VLBdd$, VLRPC$, True, "Mantenimiento Catálogo") Then
        PMChequea sqlconn&
        FPrincipal!pnlTransaccionLine.Caption = "Tran. Ok."
    Else
        cmdTransmitir.Enabled = True
    End If
End Sub

Private Sub cmdTransmitir_GotFocus()
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal!pnlHelpLine.Caption = "Transmisión de la Operación"
End Sub

Private Sub Form_Load()
'*********************************************************
'Objetivo:  Al cargar la forma, inicializa las variables
'           locales e invoca en lazo al stored procedure
'           que retorna de 20 en 20 las tablas de catálogo
'           correspondientes al MIS. Fija también las
'           coordenadas iniciales de la forma
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'22/Ene/94  M.Davila            Lazo de recuperación
'*********************************************************
Dim VTCaracteres As String       'caracteres que se añaden entre
                                 'la descripcion y el nombre de la tabla
'FIXIT: Replace 'String' function with 'String$' function                                  FixIT90210ae-R9757-R1B8ZE
Dim j As Integer
Dim VTItem As String
VTCaracteres = String$(50, " ")
VLCargar% = True
VLNumLin = 0
ReDim VTMatriz(0 To 2, 0 To 22) As String
    FMantCatalogo.Top = 15
    FMantCatalogo.Left = 15
    FMantCatalogo.Width = 9420
    FMantCatalogo.Height = 5730
    'JAN FEB/01 Seguridad
    PMObjetoSeguridad cmdBuscar
    PMObjetoSeguridad cmdSiguiente
    PMObjetoSeguridad cmdIngresar
    PMObjetoSeguridad cmdActualizar
    'JAN FEB/01
    VLOficina$ = VGOficina$
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "S"
     PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
     PMPasoValores sqlconn&, "@i_producto", 0, SQLCHAR&, VGProducto$
    'codigo de transaccion
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1578"
     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_catalogo_pro", True, "Catálogos -- Terminal Administrativa") Then
         VTR% = FMMapeaMatriz(sqlconn&, VTMatriz())
         PMChequea sqlconn&
        'llegaron datos?
        If VTR% > 0 Then
            'mapear a la lista
            cboTabla.Clear
            For j% = 1 To VTR%
                VTItem$ = Trim$(VTMatriz(0, j%)) + VTCaracteres$ + Chr$(9) + Trim$(VTMatriz(1, j%))
                cboTabla.AddItem VTItem$
            Next j%
            'lazo de recuperacion de 20 en 20
            Do While VTR% > 0
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "S"
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "1"
                 PMPasoValores sqlconn&, "@i_producto", 0, SQLCHAR&, VGProducto$
                 PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR&, VTMatriz(1, VTR%)
                'codigo de transaccion
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1578"
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_catalogo_pro", False, "") Then
                     VTR% = FMMapeaMatriz(sqlconn&, VTMatriz())
                     PMChequea sqlconn&
                    'llegaron datos?
                    If VTR% > 0 Then
                        'mapear a la lista
                        For j% = 1 To VTR%
                            VTItem$ = Trim$(VTMatriz(0, j%)) + VTCaracteres$ + Chr$(9) + Trim$(VTMatriz(1, j%))
                            cboTabla.AddItem VTItem$
                        Next j%
                    End If
                Else
                    VTR% = 0
                    ReDim VTMatriz(0, 0)
                End If
            Loop
        Else
            cboTabla.Clear
        End If
    Else
        cboTabla.Clear
    End If
    VLCargar% = False
End Sub

Private Sub Form_Unload(Cancel As Integer)
'*********************************************************
'Objetivo:  Limpia las líneas de Mensaje y Transaccion
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
    FPrincipal.mnuadmin8(2).Enabled = True
End Sub



Private Sub grdValores_Click()
'*********************************************************
'Objetivo:  Selecciona una línea del grid
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    PMLineaG grdValores
End Sub

Private Sub grdValores_DblClick()
'*********************************************************
'Objetivo:  Ejecutar cmdActualizar_click
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
If cmdActualizar.Enabled = True Then
    cmdActualizar_Click
Else
    MsgBox "Usted no está autorizado para ejecutar una Actualización", 48, "Control de Ingreso de Datos"
End If
End Sub

Private Sub txtCodigo_GotFocus(Index As Integer)
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  Index       identifica al campo código
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal!pnlTransaccionLine.Caption = ""
    Select Case Index
    Case 0
        FPrincipal!pnlHelpLine.Caption = "Código de " + fraCatalogo.Caption
    End Select
    TxtCodigo(Index).SelStart = 0
    TxtCodigo(Index).SelLength = Len(TxtCodigo(Index).Text)
End Sub

Private Sub txtCodigo_KeyPress(Index As Integer, KeyAscii As Integer)
'*********************************************************
'Objetivo:  controla que el texto sea alfanumerico
'Input   :  KeyAscii    codigo ascii de la tecla presionada
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'21/Ene/94  M.Davila            Emisión Inicial
'*********************************************************
    Select Case Index
    Case 0
        If VLTabla$ = "cl_cargo" Or VLTabla$ = "cl_actividad" Or VLTabla$ = "cl_profesion" Then 'solo ingrese numeros
            If (KeyAscii% <> 8) And (KeyAscii% < 48 Or KeyAscii% > 57) Then
                KeyAscii% = 0
            End If
        Else
            If (KeyAscii% = 32 Or KeyAscii% = 44) Then
                KeyAscii% = 0
            Else
                KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
            End If
        End If
    Case Else
        If (KeyAscii% <> 8) And (KeyAscii% < 48 Or KeyAscii% > 57) Then
            KeyAscii% = 0
        End If
    End Select
End Sub

Private Sub txtCodigo_LostFocus(Index As Integer)
'*********************************************************
'Objetivo:  Elimina los blancos a izquierda y derecha
'Input   :  Index       identifica al campo código
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    If VLTabla$ = "cl_cargo" Then
       If Val(TxtCodigo(Index)) > 255 Then
          MsgBox "El valor del Código no debe pasar de 255", 48, "Control de Ingreso de Datos"
          TxtCodigo(Index).SetFocus
          Exit Sub
       End If
    Else
        TxtCodigo(Index).Text = Trim$(UCase$((TxtCodigo(Index).Text)))
    End If
End Sub

Private Sub TxtCodigo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)

Clipboard.Clear

End Sub

Private Sub txtdescripcion_GotFocus(Index As Integer)
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal!pnlTransaccionLine.Caption = ""
    Select Case Index
    Case 0
        FPrincipal!pnlHelpLine.Caption = "Nombre descriptivo del dato en el Catálogo"
    Case 1
        FPrincipal!pnlHelpLine.Caption = "Nombre del País"
    Case 2
        FPrincipal!pnlHelpLine.Caption = "Nombre del Departamento"
    Case 3
        FPrincipal!pnlHelpLine.Caption = "Nombre de la Ciudad"
    Case 4
        FPrincipal!pnlHelpLine.Caption = "Nombre del Barrio"
    Case 5
        FPrincipal!pnlHelpLine.Caption = "Nombre de la Moneda"
    Case 6
        FPrincipal!pnlHelpLine.Caption = "Nombre de la Cuenta"
    End Select
    txtdescripcion(Index).SelStart = 0
    txtdescripcion(Index).SelLength = Len(txtdescripcion(Index).Text)
End Sub

Private Sub txtdescripcion_KeyPress(Index As Integer, KeyAscii As Integer)
'*********************************************************
'Objetivo:  controla que el texto sea alfanumerico
'Input   :  KeyAscii    codigo ascii de la tecla presionada
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'21/Ene/94  M.Davila            Emisión Inicial
'*********************************************************

 If VLTabla$ <> "cc_trn_causa_contb" Then
        If KeyAscii% = 209 Or KeyAscii% = 241 Then
           KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
        Else
            If (KeyAscii% <> 8) And (KeyAscii% <> 32) And _
            (KeyAscii% < 65 Or KeyAscii% > 90) And (KeyAscii% < 48 Or KeyAscii% > 57) And (KeyAscii% < 97 Or KeyAscii% > 122) Then
                KeyAscii% = 0
            Else
                KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
            End If
        End If
        
End If
End Sub

Private Sub txtDescripcion_LostFocus(Index As Integer)
'*********************************************************
'Objetivo:  Elimina los blancos a izquierda y derecha
'Input   :  Index       identifica al campo descripción
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************

If VLTabla$ <> "cc_trn_causa_contb" Then
    txtdescripcion(Index).Text = Trim$(UCase$((txtdescripcion(Index).Text)))
Else
     txtdescripcion(Index).Text = Trim$(((txtdescripcion(Index).Text)))
End If
End Sub

Private Sub txtDescripcion_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
Clipboard.Clear
End Sub

Private Sub txtEstado_Change(Index As Integer)
'*********************************************************
'Objetivo:  Indica que el contenido de cualquier campo
'           Estado ha cambiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    VLPaso% = False
End Sub

Private Sub txtEstado_GotFocus(Index As Integer)
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado e
'           inicializa la variable que chequea los cambios
'Input   :  Index       identifica al campo estado
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal!pnlTransaccionLine.Caption = ""
    VLPaso% = True
    FPrincipal!pnlHelpLine.Caption = "Estado del Dato en el Catálogo  [F5 Ayuda]"
    txtEstado(Index).SelStart = 0
    txtEstado(Index).SelLength = Len(txtEstado(Index).Text)
End Sub

Private Sub txtEstado_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
'*********************************************************
'Objetivo:  Llama a la forma de ayuda grid_valores la cual
'           muestra los códigos de Estadi
'Input   :  Index       identifica al campo estado a modificar
'           KeyCode     código de la tecla F5
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    Const F5 = 116
    If Keycode = F5% Then
        VLPaso% = True
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, "cl_estado_ser"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
        PMHelpG "cobis", "sp_hp_catalogo", 3, 1
         PMBuscarG 1, "@i_tabla", "cl_estado_ser", SQLVARCHAR&
         PMBuscarG 2, "@i_tipo", "A", SQLCHAR&
         PMBuscarG 3, "@i_modo", "0", SQLINT1&
         PMSigteG 1, "@i_codigo", 1, SQLVARCHAR&
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, "") Then
             PMMapeaGrid sqlconn&, grid_valores.gr_SQL, False
             PMChequea sqlconn&
            PMProcesG
            grid_valores.Show 1
            If Temporales(1) <> "" Then
                txtEstado(Index).Text = Temporales(1)
                lbldEstado(Index).Caption = Temporales(2)
                VLPaso% = True
                SendKeys "{TAB}"
            Else
                VLPaso% = False
                txtEstado_lostfocus Index%
            End If
        End If
    End If
End Sub

Private Sub txtEstado_KeyPress(Index As Integer, KeyAscii As Integer)
'*********************************************************
'Objetivo:  controla que el texto sea alfanumerico
'Input   :  KeyAscii    codigo ascii de la tecla presionada
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'21/Ene/94  M.Davila            Emisión Inicial
'*********************************************************
    KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
End Sub

Private Sub txtEstado_lostfocus(Index As Integer)
'*********************************************************
'Objetivo:  Cuando el contenido del campo ha sido modifi-
'           cado en forma manual se invoca al sp que trae
'           la descripción del código
'Input   :  Index       identifica el campo estado a
'                       modificar
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Nov/93  M.Davila            Emisión Inicial
'*********************************************************
    If Not VLPaso% Then
        txtEstado(Index).Text = Trim$(UCase$((txtEstado(Index).Text)))
        If txtEstado(Index).Text <> "" Then
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, "cl_estado_ser"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V"
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR&, (txtEstado(Index).Text)
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, "") Then
                 PMMapeaObjeto sqlconn&, lbldEstado(Index)
                 PMChequea sqlconn&
            Else
                txtEstado(Index).Text = ""
                lbldEstado(Index).Caption = ""
                txtEstado(Index).SetFocus
                 VLPaso% = True
            End If
        End If
    Else
        txtEstado(Index).Text = Trim$(txtEstado(Index).Text)
    End If
    If txtEstado(Index).Text = "" And lbldEstado(Index).Caption <> "" Then
        lbldEstado(Index).Caption = ""
    End If
End Sub


