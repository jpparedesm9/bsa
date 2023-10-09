VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{9AED8C43-3F39-11D1-8BB4-0000C039C248}#2.0#0"; "txtin.ocx"
Begin VB.Form FMantenimiento 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Mantenimiento de Equivalencias"
   ClientHeight    =   4965
   ClientLeft      =   150
   ClientTop       =   1725
   ClientWidth     =   9315
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   HelpContextID   =   3895
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4965
   ScaleWidth      =   9315
   Tag             =   "4163"
   Begin MSGrid.Grid grdValores 
      Height          =   2250
      Left            =   0
      TabIndex        =   8
      Top             =   1320
      Width           =   8205
      _Version        =   65536
      _ExtentX        =   14473
      _ExtentY        =   3969
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSFrame fraBusqueda 
      Height          =   1305
      Left            =   60
      TabIndex        =   15
      Top             =   3600
      Width           =   8220
      _Version        =   65536
      _ExtentX        =   14499
      _ExtentY        =   2302
      _StockProps     =   14
      Caption         =   "Equivalencias"
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
      Begin TxtinLib.TextValid txtCampo 
         Height          =   285
         Index           =   7
         Left            =   6340
         TabIndex        =   7
         Top             =   840
         Width           =   1800
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   253
         BorderStyle     =   1
         Range           =   ""
         MaxLength       =   10
         Character       =   0
         Type            =   4
         HelpLine        =   "Valor Final"
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   0
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin TxtinLib.TextValid txtCampo 
         Height          =   285
         Index           =   6
         Left            =   1560
         TabIndex        =   6
         Top             =   840
         Width           =   1800
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   253
         BorderStyle     =   1
         Range           =   ""
         MaxLength       =   10
         Character       =   0
         Type            =   4
         HelpLine        =   "Valor Inicial"
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   23861
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin TxtinLib.TextValid txtCampo 
         Height          =   285
         Index           =   5
         Left            =   1560
         TabIndex        =   5
         Top             =   540
         Width           =   6585
         _Version        =   65536
         _ExtentX        =   11615
         _ExtentY        =   503
         _StockProps     =   253
         BorderStyle     =   1
         Range           =   ""
         MaxLength       =   100
         Character       =   0
         Type            =   4
         HelpLine        =   "Descripción Cobis"
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   0
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin TxtinLib.TextValid txtCampo 
         Height          =   285
         Index           =   4
         Left            =   1560
         TabIndex        =   4
         Top             =   240
         WhatsThisHelpID =   5483
         Width           =   1800
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   253
         BorderStyle     =   1
         Range           =   ""
         MaxLength       =   10
         Character       =   0
         Type            =   4
         HelpLine        =   "Valor Interfaz Externa"
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   0
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000004&
         Caption         =   "*Valor Inicial:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   5
         Left            =   210
         TabIndex        =   19
         Top             =   900
         WhatsThisHelpID =   5485
         Width           =   1155
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000004&
         Caption         =   "*Valor Final:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   6
         Left            =   5100
         TabIndex        =   18
         Top             =   900
         WhatsThisHelpID =   5486
         Width           =   1050
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000004&
         Caption         =   "*Descripción:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   4
         Left            =   210
         TabIndex        =   17
         Top             =   600
         WhatsThisHelpID =   5484
         Width           =   1155
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000004&
         Caption         =   "*Valor Interfaz:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   3
         Left            =   210
         TabIndex        =   16
         Top             =   300
         WhatsThisHelpID =   5483
         Width           =   1290
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   3
      Left            =   8400
      TabIndex        =   12
      Tag             =   "4165"
      Top             =   2490
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1402
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
      Picture         =   "FMANTEQU.frx":0000
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   5
      Left            =   8400
      TabIndex        =   14
      Top             =   4110
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1402
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
      Picture         =   "FMANTEQU.frx":0376
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   4
      Left            =   8400
      TabIndex        =   13
      Top             =   3300
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1402
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
      Picture         =   "FMANTEQU.frx":06EC
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   0
      Left            =   8400
      TabIndex        =   9
      Tag             =   "4164"
      Top             =   60
      Width           =   900
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
      Picture         =   "FMANTEQU.frx":0A62
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   1
      Left            =   8400
      TabIndex        =   10
      Tag             =   "4166"
      Top             =   870
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1402
      _StockProps     =   78
      Caption         =   "&Modificar"
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
      Picture         =   "FMANTEQU.frx":0CD4
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   2
      Left            =   8400
      TabIndex        =   11
      Tag             =   "4167"
      Top             =   1680
      Width           =   900
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Eliminar"
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
      Picture         =   "FMANTEQU.frx":0FEE
   End
   Begin TxtinLib.TextValid txtCampo 
      Height          =   285
      Index           =   3
      Left            =   2040
      TabIndex        =   3
      Tag             =   "19270"
      Top             =   960
      Width           =   1605
      _Version        =   65536
      _ExtentX        =   2831
      _ExtentY        =   503
      _StockProps     =   253
      BorderStyle     =   1
      Range           =   ""
      MaxLength       =   10
      Character       =   0
      Type            =   4
      HelpLine        =   "Código de la Tabla de Correspondencias [F5] Ayuda"
      Pendiente       =   ""
      Connection      =   0
      AsociatedLabelIndex=   24397
      TableName       =   "cr_sib"
      MinChar         =   0
      Error           =   0
   End
   Begin TxtinLib.TextValid txtCampo 
      Height          =   285
      Index           =   2
      Left            =   2040
      TabIndex        =   2
      Tag             =   "19270"
      Top             =   660
      Width           =   1605
      _Version        =   65536
      _ExtentX        =   2831
      _ExtentY        =   503
      _StockProps     =   253
      BorderStyle     =   1
      Range           =   ""
      MaxLength       =   10
      Character       =   0
      Type            =   4
      HelpLine        =   "Código de la Tabla de Equivalencias [F5] Ayuda"
      Pendiente       =   ""
      Connection      =   0
      AsociatedLabelIndex=   24397
      TableName       =   "re_equivalencias"
      MinChar         =   0
      Error           =   0
   End
   Begin TxtinLib.TextValid txtCampo 
      Height          =   285
      Index           =   0
      Left            =   2040
      TabIndex        =   0
      Tag             =   "19270"
      Top             =   60
      Width           =   1605
      _Version        =   65536
      _ExtentX        =   2831
      _ExtentY        =   503
      _StockProps     =   253
      BorderStyle     =   1
      Range           =   ""
      MaxLength       =   3
      Character       =   0
      Type            =   1
      HelpLine        =   "Código de Producto Cobis [F5] Ayuda"
      Pendiente       =   ""
      Connection      =   0
      AsociatedLabelIndex=   24397
      TableName       =   "cl_producto"
      MinChar         =   0
      Error           =   0
   End
   Begin TxtinLib.TextValid txtCampo 
      Height          =   285
      Index           =   1
      Left            =   2040
      TabIndex        =   1
      Tag             =   "19270"
      Top             =   360
      Width           =   1605
      _Version        =   65536
      _ExtentX        =   2831
      _ExtentY        =   503
      _StockProps     =   253
      BorderStyle     =   1
      Range           =   ""
      MaxLength       =   3
      Character       =   0
      Type            =   1
      HelpLine        =   "Código de Producto Cobis Equivalente [F5] Ayuda"
      Pendiente       =   ""
      Connection      =   0
      AsociatedLabelIndex=   24397
      TableName       =   "cl_producto"
      MinChar         =   0
      Error           =   0
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   3660
      TabIndex        =   26
      Top             =   660
      Width           =   4605
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "*Tabla:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   120
      TabIndex        =   25
      Top             =   690
      WhatsThisHelpID =   5481
      Width           =   630
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "*Producto Cobis:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   120
      TabIndex        =   24
      Top             =   90
      WhatsThisHelpID =   5479
      Width           =   1440
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "*Producto Equivalente:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   120
      TabIndex        =   23
      Top             =   390
      WhatsThisHelpID =   5480
      Width           =   1980
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   3660
      TabIndex        =   22
      Top             =   60
      Width           =   4605
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   3660
      TabIndex        =   21
      Top             =   360
      Width           =   4605
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "*Valor Cobis:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   10
      Left            =   120
      TabIndex        =   20
      Top             =   990
      WhatsThisHelpID =   5482
      Width           =   1110
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00800000&
      Index           =   0
      X1              =   8325
      X2              =   8325
      Y1              =   -120
      Y2              =   4920
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   0
      Y1              =   0
      Y2              =   5220
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   0
      X2              =   0
      Y1              =   0
      Y2              =   5220
   End
End
Attribute VB_Name = "FMantenimiento"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*********************************************************
'   Archivo:        FMANTEQU.FRM
'   Producto:       CLIENTES
'   Diseñado por:   LUISA BERNAL
'   Fecha de Documentación: 13/Jul/2015
'*********************************************************
'                       IMPORTANTE
' Esta Aplicación es parte de los paquetes bancarios pro-
' piedad de MACOSA, representantes exclusivos para el Ecua-
' dor de la AT&T.  Su uso no autorizado queda
' expresamente prohibido así como cualquier alteración o
' agregado hecho por alguno de sus usuarios sin el debido
' consentimiento por escrito de la Presidencia Ejecutiva
' de MACOSA o su representante
'*********************************************************
' Forma:    FCatalogo
' Descripción:  Esta forma nos permite hacer mantenimiento
'               de las tablas usadas para los reportes de
'               la SIB
'*********************************************************
Option Explicit
'Indica si el contenido de un campo a cambiado
'Constantes
'Const IDYES = 6                 ' Yes button pressed
'Const IDNO = 7                  ' No button pressed
Dim VLOperacion As String        'Insert/Update sobre el elemento
Dim VGFila As Integer


Private Sub cmdBoton_Click(Index As Integer)
'*********************************************************
'Objetivo:  Rutinas de los Botones:
' -buscar-modificar-eliminar-transmitir-limpiar-salir
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
Select Case Index
Case 0
'Buscar
    PLBuscaValor
Case 1
'Modificar
    PLModificar
    
Case 2
'Eliminar
    PLEliminar
Case 3
'Transmitir
    PLTransmitir
Case 4
'Limpiar
    PLLimpiar
Case 5
'Salir
    'Erase VGBotones     'SBU: 15/jun/2000
    Unload FMantenimiento
End Select

End Sub

Private Sub cmdBoton_GotFocus(Index As Integer)
'*********************************************************
'Objetivo:  Línea de Auida
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
    Select Case Index
    Case 0
'    Buscar
         FPrincipal.pnlHelpLine.Caption = " Buscar los Elementos de la Tabla"
    Case 1
 '   Modificar
        FPrincipal.pnlHelpLine.Caption = " Escoge un Elemento para ser Modificado"
    Case 2
  '  ELIMINAR
        FPrincipal.pnlHelpLine.Caption = " Elimina el Elemento Señalado"
    Case 3
   ' Transmitir
        FPrincipal.pnlHelpLine.Caption = " Transmitir la Inserción/Actualización de un Elemento"
    Case 4
   ' LImpiar
        FPrincipal.pnlHelpLine.Caption = " Limpiar la pantalla"
    Case 5
    'Salir
        FPrincipal.pnlHelpLine.Caption = " Salir de la Pantalla Actual"
    End Select
End Sub

Private Sub Form_Activate()
    txtCampo(0).SetFocus
    If (txtCampo(0).Text <> "" And txtCampo(1).Text <> "" And txtCampo(7).Text <> "" And txtCampo(6).Text <> "") Then
       cmdBoton(1).Enabled = True
       cmdBoton(2).Enabled = True
    End If
    If (txtCampo(0).Text = "" And txtCampo(1).Text = "" And txtCampo(7).Text = "" And txtCampo(6).Text = "") Then
       cmdBoton(1).Enabled = False
       cmdBoton(2).Enabled = False
    End If
End Sub

Private Sub Form_Load()
   If (txtCampo(0).Text <> "" And txtCampo(1).Text <> "" And txtCampo(7).Text <> "" And txtCampo(6).Text <> "") Then
      cmdBoton(1).Enabled = True
      cmdBoton(2).Enabled = True
   End If
 If (txtCampo(0).Text = "" And txtCampo(1).Text = "" And txtCampo(7).Text = "" And txtCampo(6).Text = "") Then
       cmdBoton(1).Enabled = False
       cmdBoton(2).Enabled = False
 End If
 txtCampo(0).Connection = VGMap
 Set txtCampo(0).AsociatedLabel = lblDescripcion(0)
 
 txtCampo(1).Connection = VGMap
 Set txtCampo(1).AsociatedLabel = lblDescripcion(1)
 
  txtCampo(2).Connection = VGMap
 Set txtCampo(2).AsociatedLabel = lblDescripcion(2)
 
    VLOperacion$ = "I"

    PMLoadResStrings Me
    PMLoadResIcons Me

    FMantenimiento.Top = 15
    FMantenimiento.Left = 15
    FMantenimiento.Width = 9420
    FMantenimiento.Height = 5475
    
    PMObjetoSeguridad cmdBoton(0)
    PMObjetoSeguridad cmdBoton(1)
    PMObjetoSeguridad cmdBoton(2)
    PMObjetoSeguridad cmdBoton(3)
    
    ReDim VGBotones(3)
    Set VGBotones(1) = cmdBoton(0)
    Set VGBotones(2) = cmdBoton(2)
    Set VGBotones(3) = cmdBoton(3)

End Sub

Private Sub Form_Unload(Cancel As Integer)
'*********************************************************
'Objetivo:  Limpia las líneas de mensajes
'*********************************************************
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdValores_Click()
'*********************************************************
'Objetivo:  Señala la línea del grid
'*********************************************************
    PMLineaG grdValores
End Sub

Private Sub grdValores_DblClick()
'*********************************************************
'Objetivo:  Escoje el registro actualmente señalado en
'           el grid para modificación
'*********************************************************
    PLEditar
    
   grdValores.Row = 1
   grdValores.Col = 1
   If grdValores.Text <> "" Then
      grdValores.Row = VGFila%
   
         cmdBoton(1).Enabled = True
         cmdBoton(2).Enabled = True
   End If
End Sub

Private Sub grdValores_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Lista de Elementos de la Tabla"
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub PLBuscaValor()
'*********************************************************
'Objetivo:  Busca los registros existentes de la tabla
'           escogida por el usuario
'           Buscar trae los 20 primeros
'Input   :  Index   identifica al botón
'*********************************************************
    Dim inicio As Integer
    PMLimpiaG grdValores
   If txtCampo(0).Text = "" And txtCampo(1).Text = "" And txtCampo(2).Text = "" And txtCampo(3).Text = "" Then
      MsgBox "Debe existir al menos un criterio de Búsqueda", 48, "Control Ingreso de Datos"
      Exit Sub
   End If

    inicio% = True
    Do While (grdValores.Tag >= VGMaximoRows% - 1) Or inicio%
    
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4164"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "S"
         PMPasoValores sqlconn&, "@i_modulo", 0, SQLINT4&, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_mod_int", 0, SQLINT4&, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_val_cfijo", 0, SQLVARCHAR&, txtCampo(3).Text
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, lblDescripcion(2).Caption
         PMPasoValores sqlconn&, "@i_val_interfaz", 0, SQLVARCHAR&, txtCampo(4).Text
       If inicio% = False Then
            grdValores.Row = grdValores.Rows - 1
            grdValores.Col = 1
             PMPasoValores sqlconn&, "@i_siguiente", 0, SQLVARCHAR&, grdValores.Text
        End If
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2&, Str$(inicio% + 1)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_mant_equiv", False, "Ok... Consulta de Equivalencias") Then
            PMMapeaGrid sqlconn&, grdValores, Not (inicio%)
            PMChequea sqlconn&
        Else
           grdValores.Tag = 0
        End If
        inicio% = False
    Loop
End Sub

Private Sub PLEditar()
'*********************************************************
'Objetivo: Edita la información de un registro
'          desde el grid
'*********************************************************
 If (txtCampo(0).Text <> "" And txtCampo(1).Text <> "" And txtCampo(7).Text <> "" And txtCampo(6).Text <> "") Then
       cmdBoton(1).Enabled = True
       cmdBoton(2).Enabled = True
 End If
'verificar si el grid tiene datos
VGFila% = grdValores.Row
grdValores.Row = 1
grdValores.Col = 1
If grdValores.Text <> "" Then
   grdValores.Row = VGFila%
   
   grdValores.Col = 2
   txtCampo(0).Text = grdValores.Text  'producto
   grdValores.Col = 3
   lblDescripcion(0).Caption = grdValores.Text  'producto
   grdValores.Col = 4
   txtCampo(1).Text = grdValores.Text  'producto equivalente
   grdValores.Col = 5
   lblDescripcion(1).Caption = grdValores.Text  'producto
   grdValores.Col = 6
   txtCampo(2).Text = grdValores.Text  'codigo tabla
   grdValores.Col = 7
   lblDescripcion(2).Caption = grdValores.Text
   grdValores.Col = 8
   txtCampo(3).Text = grdValores.Text  'valor fijo cobis
   grdValores.Col = 9
   txtCampo(6).Text = grdValores.Text  'valor_inicial
   grdValores.Col = 10
   txtCampo(7).Text = grdValores.Text  'valor_fin
   grdValores.Col = 11
   txtCampo(4).Text = grdValores.Text  'Interfaz
   grdValores.Col = 12
   txtCampo(5).Text = grdValores.Text  'Descripciòn
   'adecuacion del frame y los botones
   fraBusqueda.Enabled = True
   fraBusqueda.Caption = "Equivalencias [Modificación]"
   cmdBoton(3).Enabled = False
   txtCampo(0).Enabled = False
   txtCampo(1).Enabled = False
   txtCampo(2).Enabled = False
   txtCampo(3).Enabled = False
End If
End Sub
Private Sub PLModificar()
   VLOperacion$ = "U"
   PLTransmitir
End Sub
Private Sub PLEliminar()
'*********************************************************
'Objetivo:  Elimina el código actual
'*********************************************************
Dim VLCodigo As String
Dim VLValorCobis As String
Dim Msg As String
Dim VTResp As Integer
VGFila% = grdValores.Row
'validar que el grid tenga datos'
grdValores.Row = VGFila%
grdValores.Col = 1
VLCodigo = grdValores.Text
If grdValores.Text <> "" Then
    grdValores.Row = VGFila%
    grdValores.Col = 12
    VLValorCobis = grdValores.Text
    Msg$ = "Está seguro de eliminar el registro ?" + Chr(13)
    grdValores.Col = 1
    Msg$ = Msg$ + "Codigo COBIS: " + VLCodigo + " - " + VLValorCobis
    VTResp = MsgBox(Msg$, vbYesNo, "Control Ingreso de Datos")
    If VTResp = vbYes Then
        grdValores.Col = 2
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4167"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "D"
        PMPasoValores sqlconn&, "@i_modulo", 0, SQLINT4&, txtCampo(0).Text
        PMPasoValores sqlconn&, "@i_mod_int", 0, SQLINT4&, txtCampo(1).Text
        PMPasoValores sqlconn&, "@i_val_cfijo", 0, SQLVARCHAR&, txtCampo(3).Text
        PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, lblDescripcion(2).Caption
        PMPasoValores sqlconn&, "@i_descripcion", 0, SQLVARCHAR&, txtCampo(5).Text
        PMPasoValores sqlconn&, "@i_val_num_ini", 0, SQLVARCHAR&, txtCampo(6).Text
        PMPasoValores sqlconn&, "@i_val_num_fin", 0, SQLVARCHAR&, txtCampo(7).Text
        PMPasoValores sqlconn&, "@i_val_interfaz", 0, SQLVARCHAR&, txtCampo(4).Text
        
        grdValores.Col = 1
        PMPasoValores sqlconn&, "@i_siguiente", 0, SQLVARCHAR&, grdValores.Text
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_mant_equiv", False, "Ok... Equivalencia Eliminada") Then
           PMChequea sqlconn&
           If FMRetStatus(sqlconn&) = 2 Then
               MsgBox "No se puede eliminar el registro", 0
           Else
               MsgBox "Se ha eliminado registro exitosamente", 48, "Control Ingreso de Datos"
           End If
           PLLimpiar
        End If
    Else
        Exit Sub
    End If
End If
End Sub
Private Sub PLLimpiar()
'*********************************************************
'Objetivo:  Limpia los objetos de la forma
'Input   :  Index   identifica al botón
'*********************************************************
Dim i As Integer
For i% = 0 To 7
    txtCampo(i%).Text = ""
Next i%
cmdBoton(3).Enabled = True

fraBusqueda.Caption = "Equivalencias[Creación]"
VLOperacion$ = "I"
txtCampo(0).Enabled = True
txtCampo(1).Enabled = True
txtCampo(6).Enabled = True
txtCampo(7).Enabled = True
fraBusqueda.Enabled = True

lblDescripcion(0).Caption = ""
lblDescripcion(1).Caption = ""
lblDescripcion(2).Caption = ""

PMLimpiaG grdValores

 cmdBoton(1).Enabled = False
 cmdBoton(2).Enabled = False
 cmdBoton(3).Enabled = True

txtCampo(0).Enabled = True
txtCampo(1).Enabled = True
txtCampo(2).Enabled = True
txtCampo(3).Enabled = True

txtCampo(0).SetFocus


End Sub
Private Sub PLTransmitir()
'*********************************************************
'Objetivo: Ingresa o modifica un codigo de correspondencia
'          en las tablas para los reportes de la SIB.
'*********************************************************
Dim msgingreso As String
Dim msgtrn As String
If txtCampo(2).Text = "" Then
    MsgBox "El Campo Tabla es Obligatorio", 48, "Control Ingreso de Datos"
    Exit Sub
End If
If txtCampo(3).Text = "" Then
    MsgBox "El Campo Valor Cobis es Obligatorio", 48, "Control Ingreso de Datos"
    Exit Sub
End If
If txtCampo(4).Text = "" Then
      MsgBox "El Campo Interfaz es Obligatorio", 48, "Control Ingreso de Datos"
   Exit Sub
End If
If Trim(txtCampo(5).Text) = "" Then
      MsgBox "El Campo Descripción es Obligatorio", 48, "Control Ingreso de Datos"
   Exit Sub
End If
If Trim(txtCampo(0).Text) = "" Then
      MsgBox "El Campo Producto es Obligatorio", 48, "Control Ingreso de Datos"
   Exit Sub
End If

If Trim(txtCampo(1).Text) = "" Then
      MsgBox "El Campo Producto Equivalente es Obligatorio", 48, "Control Ingreso de Datos"
   Exit Sub
End If


Select Case VLOperacion$
Case "I"
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4165"
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "I"
     msgingreso$ = "Registro ingresado exitosamente"
     msgtrn$ = "Ok... Equivalencia Ingresada"
Case "U"
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4166"
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "U"
     msgingreso$ = "Se ha actualizado registro exitosamente"
     msgtrn$ = "Ok... Equivalencia Modificada"
End Select
 
     PMPasoValores sqlconn&, "@i_modulo", 0, SQLINT4&, txtCampo(0).Text
     PMPasoValores sqlconn&, "@i_mod_int", 0, SQLINT4&, txtCampo(1).Text
     PMPasoValores sqlconn&, "@i_val_cfijo", 0, SQLVARCHAR&, txtCampo(3).Text
     'PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, txtCampo(0).Text
     PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, lblDescripcion(2).Caption
     
     PMPasoValores sqlconn&, "@i_descripcion", 0, SQLVARCHAR&, txtCampo(5).Text
     PMPasoValores sqlconn&, "@i_val_num_ini", 0, SQLVARCHAR&, txtCampo(6).Text
     PMPasoValores sqlconn&, "@i_val_num_fin", 0, SQLVARCHAR&, txtCampo(7).Text
     PMPasoValores sqlconn&, "@i_val_interfaz", 0, SQLVARCHAR&, txtCampo(4).Text

    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_mant_equiv", False, msgtrn$) Then
        MsgBox msgingreso$, 48, "Control Ingreso de Datos"
        PLLimpiar
        PMMapeaGrid sqlconn&, grdValores, False
        PMChequea sqlconn&
    End If
End Sub

Private Sub txtCampo_Change(Index As Integer)
'*********************************************************
'Objetivo:  Limpia la forma para el ingreso de nuevos datos
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'If Index = 0 Then
'    PMLimpiaG grdValores
'    PLLimpiar
'End If
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index
    Case 0
        FPrincipal!pnlHelpLine.Caption = "Código de Producto Cobis [F5] Ayuda"
    Case 1
        FPrincipal!pnlHelpLine.Caption = "Código de Producto Cobis Equivalente[F5] Ayuda"
    Case 2
        FPrincipal!pnlHelpLine.Caption = "Código de la Tabla de Equivalencias [F5] Ayuda"
    Case 3
        FPrincipal!pnlHelpLine.Caption = "Valor Cobis"
    Case 4
        FPrincipal!pnlHelpLine.Caption = "Valor Interfaz Externa"
    Case 5
        FPrincipal!pnlHelpLine.Caption = "Descripción Cobis"
    Case 6
        FPrincipal!pnlHelpLine.Caption = "Valor Inicial"
    Case 7
        FPrincipal!pnlHelpLine.Caption = "Valor Final"
    
        
    End Select
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

