VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form FCosEsp 
   Appearance      =   0  'Flat
   Caption         =   "Definición Costos Especiales"
   ClientHeight    =   5325
   ClientLeft      =   165
   ClientTop       =   1245
   ClientWidth     =   9300
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
   Icon            =   "FCOSESP.frx":0000
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   1
      Left            =   1650
      MaxLength       =   40
      TabIndex        =   3
      Top             =   1035
      Width           =   6690
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   3
      Left            =   1665
      MaxLength       =   4
      TabIndex        =   1
      Top             =   270
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   4
      Left            =   1665
      MaxLength       =   1
      TabIndex        =   2
      Top             =   780
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   0
      Left            =   1650
      MaxLength       =   2
      TabIndex        =   5
      Top             =   1800
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   5
      Left            =   1650
      MaxLength       =   2
      TabIndex        =   4
      Top             =   1290
      Width           =   930
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Actualizar"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   4
      Left            =   8415
      Picture         =   "FCOSESP.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   11
      Tag             =   "4088"
      Top             =   3030
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Crear"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   0
      Left            =   8415
      Picture         =   "FCOSESP.frx":0614
      Style           =   1  'Graphical
      TabIndex        =   10
      Tag             =   "4087"
      Top             =   2265
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Salir"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   2
      Left            =   8415
      Picture         =   "FCOSESP.frx":091E
      Style           =   1  'Graphical
      TabIndex        =   13
      Top             =   4560
      Width           =   875
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Buscar"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   3
      Left            =   8415
      Picture         =   "FCOSESP.frx":0C84
      Style           =   1  'Graphical
      TabIndex        =   9
      Tag             =   "4086"
      Top             =   15
      Width           =   875
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Limpiar"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   1
      Left            =   8415
      Picture         =   "FCOSESP.frx":0EE6
      Style           =   1  'Graphical
      TabIndex        =   12
      Top             =   3795
      Width           =   875
   End
   Begin MSGrid.Grid grdProductos 
      Height          =   2040
      Left            =   0
      TabIndex        =   24
      Top             =   3225
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
      _ExtentY        =   3598
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
   Begin MSMask.MaskEdBox mskFecha 
      Height          =   240
      Left            =   1665
      TabIndex        =   0
      Top             =   15
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   423
      _Version        =   393216
      Appearance      =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskCosto 
      Height          =   240
      Index           =   2
      Left            =   1650
      TabIndex        =   8
      Top             =   2565
      Width           =   1680
      _ExtentX        =   2963
      _ExtentY        =   423
      _Version        =   393216
      Appearance      =   0
      MaxLength       =   12
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   "#,##0.00"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskCosto 
      Height          =   240
      Index           =   1
      Left            =   1650
      TabIndex        =   6
      Top             =   2055
      Width           =   1680
      _ExtentX        =   2963
      _ExtentY        =   423
      _Version        =   393216
      Appearance      =   0
      MaxLength       =   12
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   "#,##0.00"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskCosto 
      Height          =   240
      Index           =   0
      Left            =   1650
      TabIndex        =   7
      Top             =   2310
      Width           =   1680
      _ExtentX        =   2963
      _ExtentY        =   423
      _Version        =   393216
      Appearance      =   0
      MaxLength       =   12
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   "#,##0.00"
      PromptChar      =   "_"
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   1
      Left            =   2610
      TabIndex        =   37
      Top             =   270
      Width           =   5715
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   0
      Left            =   2610
      TabIndex        =   36
      Top             =   525
      Width           =   5715
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   2
      Left            =   2610
      TabIndex        =   35
      Top             =   780
      Width           =   5715
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   4
      Left            =   3810
      TabIndex        =   34
      Top             =   1815
      Width           =   1755
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   5
      Left            =   6375
      TabIndex        =   33
      Top             =   1815
      Width           =   1950
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   6
      Left            =   2595
      TabIndex        =   32
      Top             =   1290
      Width           =   5730
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   7
      Left            =   2595
      TabIndex        =   31
      Top             =   1545
      Width           =   5730
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   3
      Left            =   1650
      TabIndex        =   30
      Top             =   1545
      Width           =   930
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   8
      Left            =   1665
      TabIndex        =   29
      Top             =   525
      Width           =   930
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Fecha de Vigencia:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   13
      Left            =   105
      TabIndex        =   28
      Top             =   75
      Width           =   1440
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Moneda:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   4
      Left            =   90
      TabIndex        =   27
      Top             =   1620
      Width           =   675
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Rubro:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   0
      Left            =   90
      TabIndex        =   26
      Top             =   600
      Width           =   525
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo Rango:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   12
      Left            =   90
      TabIndex        =   25
      Top             =   1365
      Width           =   945
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Rango :"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   11
      Left            =   90
      TabIndex        =   23
      Top             =   1875
      Width           =   600
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Valor Base:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   10
      Left            =   90
      TabIndex        =   22
      Top             =   2385
      Width           =   900
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Hasta:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   9
      Left            =   5730
      TabIndex        =   21
      Top             =   1875
      Width           =   510
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Desde:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   8
      Left            =   3150
      TabIndex        =   20
      Top             =   1875
      Width           =   540
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Valor Máximo:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   7
      Left            =   90
      TabIndex        =   19
      Top             =   2640
      Width           =   1110
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Valor Mínimo:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   1
      Left            =   90
      TabIndex        =   18
      Top             =   2130
      Width           =   1095
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Valores de Costos Generales:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   6
      Left            =   90
      TabIndex        =   17
      Top             =   2985
      Width           =   2295
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   -105
      X2              =   8400
      Y1              =   2895
      Y2              =   2895
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo de Dato:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   3
      Left            =   90
      TabIndex        =   16
      Top             =   855
      Width           =   1050
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Servicio Disponible:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   5
      Left            =   90
      TabIndex        =   15
      Top             =   330
      Width           =   1545
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Descripción:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   2
      Left            =   90
      TabIndex        =   14
      Top             =   1110
      Width           =   975
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8385
      X2              =   8385
      Y1              =   0
      Y2              =   5310
   End
End
Attribute VB_Name = "FCosEsp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010

Dim VLPaso As Integer
'! removed Dim VLTrans As Integer

Dim VLMoneda As String
Dim VLFecha As String
Dim VLDato As String
Dim VLRango As String
Private Sub cmdBoton_Click(Index As Integer)
Dim i%
    Select Case Index%
    Case 0 'Crear
        'Crea un nuevo detalle de servicio
        If txtCampo(3).Text = "" Then
            MsgBox "El código de servicio es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        If txtCampo(4).Text = "" Then
            MsgBox "El tipo de dato es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(4).SetFocus
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            MsgBox "La descripción del rubro es mandatoria", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If

        If txtCampo(5).Text = "" Then
            MsgBox "El tipo de rango es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(5).SetFocus
            Exit Sub
        End If
        
        If txtCampo(0).Text = "" Then
            MsgBox "El grupo de rango es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(5).SetFocus
            Exit Sub
        End If

        If txtCampo(4).Text = "P" Then
            For i% = 0 To 2
                If Val(Format$(mskCosto(i%).Text)) > 100 Then
                    MsgBox "El valor debe ser Porcentaje", 0 + 16, "Mensaje de Error"
                    mskCosto(i%).Text = ""
                    mskCosto(i%).SetFocus
                    Exit Sub
                End If
            Next i%
        End If
        
        If mskCosto(1).Text = "" Then
            MsgBox "El valor mínimo es mandatorio", 0 + 16, "Mensaje de Error"
            mskCosto(1).SetFocus
            Exit Sub
        End If
        If mskCosto(2).Text = "" Then
            MsgBox "El valor máximo es mandatorio", 0 + 16, "Mensaje de Error"
            mskCosto(2).SetFocus
            Exit Sub
        End If
        If mskCosto(0).Text = "" Then
            MsgBox "El valor base es mandatorio", 0 + 16, "Mensaje de Error"
            mskCosto(0).SetFocus
            Exit Sub
        End If
        If mskCosto(1).Text <> "" Then
            If (Val(Format$(mskCosto(1).Text)) > Val(Format$(mskCosto(2).Text))) Then
                MsgBox "El valor máximo está incorrecto", 0 + 16, "Mensaje de Error"
                mskCosto(2).Text = ""
                mskCosto(2).SetFocus
                Exit Sub
            End If
        End If
        If mskCosto(2).Text <> "" Then
            If (Val(Format$(mskCosto(0).Text)) > Val(Format$(mskCosto(2).Text))) Then
                MsgBox "El valor base está incorrecto", 0 + 16, "Mensaje de Error"
                mskCosto(0).Text = ""
                mskCosto(0).SetFocus
                Exit Sub
            End If
         End If
        If mskCosto(1).Text <> "" Then
            If (Val(Format$(mskCosto(0).Text)) < Val(Format$(mskCosto(1)))) Then
                MsgBox "El valor base está incorrecto", 0 + 16, "Mensaje de Error"
                mskCosto(0).Text = ""
                mskCosto(0).SetFocus
                Exit Sub
            End If
        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4087"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(3).Text
         PMPasoValores sqlconn&, "@i_rubro", 0, SQLCHAR, lblDescripcion(8).Caption
         PMPasoValores sqlconn&, "@i_tipo_dato", 0, SQLCHAR, txtCampo(4).Text
         PMPasoValores sqlconn&, "@i_descripcion", 0, SQLVARCHAR, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_tipo_rango", 0, SQLINT1, txtCampo(5).Text
         PMPasoValores sqlconn&, "@i_grupo_rango", 0, SQLINT1, VLRango$
         PMPasoValores sqlconn&, "@i_rango", 0, SQLINT2, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_val_minimo", 0, SQLMONEY, mskCosto(1).Text
         PMPasoValores sqlconn&, "@i_val_base", 0, SQLMONEY, mskCosto(0).Text
         PMPasoValores sqlconn&, "@i_val_maximo", 0, SQLMONEY, mskCosto(2).Text
         PMPasoValores sqlconn&, "@i_fecha_vigencia", 0, SQLVARCHAR, FMConvFecha((mskFecha.Text), Get_Preferencia("FORMATO-FECHA"), "mm/dd/yyyy")
         
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_costos_especiales", True, "Ok...Creación de Subservicio") Then
             PMChequea sqlconn&
            cmdBoton(0).Enabled = False
        End If
        cmdBoton_Click (3)
    
    Case 1 'Limpiar
        If lblDescripcion(8).Caption <> "" Then
        
            txtCampo(0).Text = ""
            txtCampo(1).Text = ""
            lblDescripcion(8).Caption = ""
            txtCampo(4).Text = ""
            txtCampo(5).Text = ""
            lblDescripcion(0).Caption = ""
            lblDescripcion(2).Caption = ""
            For i% = 3 To 7
                lblDescripcion(i%).Caption = ""
            Next i%
            txtCampo(1).Enabled = True
            txtCampo(4).Enabled = True
            FPrincipal.pnlHelpLine.Caption = ""
            FPrincipal.pnlTransaccionLine.Caption = ""
            cmdBoton(4).Enabled = False
            txtCampo(3).SetFocus
            For i% = 0 To 2
                mskCosto(i%).Text = ""
                mskCosto(i%).Format = "#,##0.00"
                VLMoneda$ = ""
            Next i%
 
        Else
            txtCampo(1).Text = ""
            For i% = 3 To 4
                txtCampo(i%).Text = ""
            Next i%
    
            For i% = 0 To 2
                lblDescripcion(i%).Caption = ""
            Next i%
            txtCampo(4).Enabled = True
            FPrincipal.pnlHelpLine.Caption = ""
            FPrincipal.pnlTransaccionLine.Caption = ""
            PMLimpiaGrid grdProductos
            cmdBoton(4).Enabled = False
            txtCampo(3).SetFocus
        End If
        cmdBoton(0).Enabled = True
        VLPaso% = False
        
    Case 2 'Salir
        
        Unload FCosEsp

    Case 3  'Buscar
        If txtCampo(3).Text = "" Then
            MsgBox "El código de servicio es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4086"
        PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(3).Text
        PMPasoValores sqlconn&, "@i_rubro", 0, SQLCHAR, lblDescripcion(8).Caption
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_costos_especiales", True, "Ok... Consulta de Detalle de Servicios Especiales") Then
            PMMapeaGrid sqlconn&, grdProductos, False
            PMChequea sqlconn&
            grdProductos.Col = 1
            grdProductos.Row = grdProductos.Rows - 1
        End If
        grdProductos.Row = 1
        
        grdProductos.ColWidth(1) = 1300
        grdProductos.ColWidth(6) = 3500
        grdProductos.ColWidth(7) = 1500
        grdProductos.ColWidth(8) = 1500
        For i% = 12 To 15
            grdProductos.ColWidth(i%) = 1
        Next i%

    Case 4 'Actualizar
    
        If txtCampo(3).Text = "" Then
            MsgBox "El código de servicio es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        
        If txtCampo(4).Text = "" Then
            MsgBox "El tipo de dato es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(4).SetFocus
            Exit Sub
        End If
        
        If mskCosto(1).Text = "" Then
            MsgBox "El valor mínimo es mandatorio", 0 + 16, "Mensaje de Error"
            mskCosto(1).SetFocus
            Exit Sub
        End If
        If mskCosto(2).Text = "" Then
            MsgBox "El valor máximo es mandatorio", 0 + 16, "Mensaje de Error"
            mskCosto(2).SetFocus
            Exit Sub
        End If
        If mskCosto(0).Text = "" Then
            MsgBox "El valor base es mandatorio", 0 + 16, "Mensaje de Error"
            mskCosto(0).SetFocus
            Exit Sub
        End If
        
        If txtCampo(4).Text = "P" Then
            For i% = 0 To 2
                If Val(Format$(mskCosto(i%).Text)) > 100 Then
                    MsgBox "El valor debe ser Porcentaje", 0 + 16, "Mensaje de Error"
                    mskCosto(i%).Text = ""
                    mskCosto(i%).SetFocus
                    Exit Sub
                End If
            Next i%
        End If
        
        If mskCosto(1).Text <> "" Then
            If (Val(Format$(mskCosto(1).Text)) > Val(Format$(mskCosto(2).Text))) Then
                MsgBox "El valor máximo está incorrecto", 0 + 16, "Mensaje de Error"
                mskCosto(2).Text = ""
                mskCosto(2).SetFocus
                Exit Sub
            End If
        End If
        If mskCosto(2).Text <> "" Then
            If (Val(Format$(mskCosto(0).Text)) > Val(Format$(mskCosto(2).Text))) Then
                MsgBox "El valor base está incorrecto", 0 + 16, "Mensaje de Error"
                mskCosto(0).Text = ""
                mskCosto(0).SetFocus
                Exit Sub
            End If
         End If
        If mskCosto(1).Text <> "" Then
            If (Val(Format$(mskCosto(0).Text)) < Val(Format$(mskCosto(1)))) Then
                MsgBox "El valor base está incorrecto", 0 + 16, "Mensaje de Error"
                mskCosto(0).Text = ""
                mskCosto(0).SetFocus
                Exit Sub
            End If
        End If
             
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4088"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(3).Text
         PMPasoValores sqlconn&, "@i_rubro", 0, SQLCHAR, lblDescripcion(8).Caption
         PMPasoValores sqlconn&, "@i_tipo_dato", 0, SQLCHAR, txtCampo(4).Text
         PMPasoValores sqlconn&, "@i_descripcion", 0, SQLCHAR, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_tipo_rango", 0, SQLINT1, txtCampo(5).Text
         PMPasoValores sqlconn&, "@i_grupo_rango", 0, SQLINT1, VLRango$
         PMPasoValores sqlconn&, "@i_rango", 0, SQLINT2, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_val_minimo", 0, SQLMONEY, mskCosto(1).Text
         PMPasoValores sqlconn&, "@i_val_base", 0, SQLMONEY, mskCosto(0).Text
         PMPasoValores sqlconn&, "@i_val_maximo", 0, SQLMONEY, mskCosto(2).Text
         PMPasoValores sqlconn&, "@i_fecha_vigencia", 0, SQLVARCHAR, FMConvFecha((mskFecha.Text), Get_Preferencia("FORMATO-FECHA"), "mm/dd/yyyy")
         PMPasoValores sqlconn&, "@i_fecha_mod", 0, SQLVARCHAR, FMConvFecha((VGFecha$), Get_Preferencia("FORMATO-FECHA"), "mm/dd/yyyy")
         
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_costos_especiales", True, "Ok...Actualización de Subservicio") Then
             PMChequea sqlconn&
            cmdBoton(4).Enabled = False
        End If
        cmdBoton_Click (3)
         
         
End Select
End Sub

Private Sub Form_Load()
Dim VLFormatoFecha$
    FCosEsp.Left = 15
    FCosEsp.Top = 15
    FCosEsp.Width = 9420
    FCosEsp.Height = 5730
'   PMBotonSeguridad FCosEsp, 4
'   cmdBoton(0).Enabled = True
'   cmdBoton(4).Enabled = False
    
    mskCosto(0).Format = VGDecimales$
    mskCosto(0).Text = Format$(0, VGDecimales$)
    mskCosto(0).MaxLength = 14
     
    mskCosto(1).Format = VGDecimales$
    mskCosto(1).Text = Format$(0, VGDecimales$)
    mskCosto(1).MaxLength = 14
    
    mskCosto(2).Format = VGDecimales$
    mskCosto(2).Text = Format$(0, VGDecimales$)
    mskCosto(2).MaxLength = 14

    VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
    mskFecha.Mask = FMMascaraFecha(VLFormatoFecha$)
    VLFecha$ = FMConvFecha((VGFecha), "mm/dd/yyyy", Get_Preferencia("FORMATO-FECHA"))
    VLFecha$ = DateAdd("d", 1, VLFecha$)
    mskFecha.Text = VLFecha$
 
 PMObjetoSeguridad cmdBoton(0)
 PMObjetoSeguridad cmdBoton(3)
 PMObjetoSeguridad cmdBoton(4)
 
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdProductos_Click()

    grdProductos.Col = 0
    grdProductos.SelStartCol = 1
    grdProductos.SelEndCol = grdProductos.Cols - 1
    If grdProductos.Row = 0 Then
        grdProductos.SelStartRow = 1
        grdProductos.SelEndRow = 1
    Else
        grdProductos.SelStartRow = grdProductos.Row
        grdProductos.SelEndRow = grdProductos.Row
    End If
End Sub

Private Sub grdProductos_DblClick()
Dim VTRow%
VTRow% = grdProductos.Row
grdProductos.Row = 1
grdProductos.Col = 1
If (grdProductos.Text <> "") Then
    grdProductos.Row = VTRow%
    PMMarcarRegistro
    VLPaso% = False
    txtCampo_LostFocus (5)
    mskCosto(1).SetFocus
End If
End Sub

Private Sub grdProductos_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Haga Doble Click para Actualizar"
End Sub

Private Sub grdProductos_KeyUp(KeyCode As Integer, Shift As Integer)
    grdProductos.Col = 0
    grdProductos.SelStartCol = 1
    grdProductos.SelEndCol = grdProductos.Cols - 1
    If grdProductos.Row = 0 Then
        grdProductos.SelStartRow = 1
        grdProductos.SelEndRow = 1
    Else
        grdProductos.SelStartRow = grdProductos.Row
        grdProductos.SelEndRow = grdProductos.Row
    End If
    
End Sub
Private Sub PMMarcarRegistro()
    cmdBoton(0).Enabled = False
    cmdBoton(4).Enabled = True
    grdProductos.Col = 4
    lblDescripcion(8).Caption = grdProductos.Text
    grdProductos.Col = 12
    lblDescripcion(0).Caption = grdProductos.Text
    grdProductos.Col = 5
    If grdProductos.Text = "P" Then
        lblDescripcion(2).Caption = "PORCENTAJE"
    Else
        lblDescripcion(2).Caption = "MONTO"
    End If
    txtCampo(4).Text = grdProductos.Text
    grdProductos.Col = 6
    txtCampo(1).Text = grdProductos.Text
    grdProductos.Col = 13
    txtCampo(5).Text = grdProductos.Text
    grdProductos.Col = 14
    VLRango$ = grdProductos.Text
    grdProductos.Col = 15
    txtCampo(0).Text = grdProductos.Text
    grdProductos.Col = 9
    mskCosto(1).Text = grdProductos.Text
    grdProductos.Col = 10
    mskCosto(0).Text = grdProductos.Text
    grdProductos.Col = 11
    mskCosto(2).Text = grdProductos.Text
    grdProductos.Col = 7
    lblDescripcion(4).Caption = grdProductos.Text
    grdProductos.Col = 8
    lblDescripcion(5).Caption = grdProductos.Text
End Sub

Private Sub mskCosto_GotFocus(Index As Integer)
    If VLDato$ = "M" Then
        If VLMoneda$ = "S" Then
            mskCosto(Index%).Format = "#,##0.00"
        ElseIf VLMoneda$ = "N" Then
            mskCosto(Index%).Format = "#,##0"
            
        End If
    Else
        mskCosto(Index%).Format = "##0.00"
    End If
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Costo  para el Servicio"
    Case 1
        FPrincipal.pnlHelpLine.Caption = " Valor Mínimo del Costo"
    Case 2
        FPrincipal.pnlHelpLine.Caption = " Valor Máximo del Costo"
    End Select
    mskCosto(Index%).SelStart = 0
    mskCosto(Index%).SelLength = Len(mskCosto(Index%).Text)

End Sub

Private Sub mskCosto_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0, 1, 2
    If VLDato$ = "P" Then
        If (Chr$(KeyAscii%)) <> "." And (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
                KeyAscii% = 0
        End If
        Exit Sub
    End If
    If VLMoneda$ = "S" Then
        If (Chr$(KeyAscii%)) <> "." And (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
                KeyAscii% = 0
        End If
    ElseIf VLMoneda$ = "N" Then
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
                KeyAscii% = 0
        End If
        
   End If
    End Select
End Sub

Private Sub mskCosto_LostFocus(Index As Integer)
    If mskCosto(Index%).Text <> "" Then
        If txtCampo(3).Text = "" Then
            MsgBox "El código del servicio es mandatorio", 0 + 16, "Mensaje de Error"
            mskCosto(0).Text = ""
            txtCampo(3).SetFocus
            Exit Sub
        End If
    End If
    Select Case Index%
    Case 0  'Costo Base
        
        If mskCosto(0).Text <> "" Then
            If Not IsNumeric(mskCosto(0).Text) Then
                mskCosto(0).Text = ""
                mskCosto(0).SetFocus
                Exit Sub
            End If
            
            If VLDato$ = "P" Then
                If Val(Format$(mskCosto(0).Text)) > 100 Then
                    MsgBox "El valor debe ser Porcentaje", 0 + 16, "Mensaje de Error"
                    mskCosto(0).Text = ""
                    mskCosto(0).SetFocus
                    Exit Sub
                End If
                
            End If
            'If mskCosto(2).Text <> "" Then
            '    If (Val(Format(mskCosto(0).Text)) > Val(Format(mskCosto(2).Text))) Then
            '        MsgBox "El costo está incorrecto", 0 + 16, "Mensaje de Error"
            '        mskCosto(0).Text = ""
            '        mskCosto(0).SetFocus
            '        Exit Sub
            '    End If
           ' End If
            'If mskCosto(1).Text <> "" Then
            '    If (Val(Format(mskCosto(0).Text)) < Val(Format(mskCosto(1)))) Then
            '        MsgBox "El costo está incorrecto", 0 + 16, "Mensaje de Error"
            '        mskCosto(0).Text = ""
            '        mskCosto(0).SetFocus
            '        Exit Sub
            '    End If
            'End If

        End If
    
    Case 1  'Valor mínimo
        
        If mskCosto(1).Text <> "" Then
            If Not IsNumeric(mskCosto(1).Text) Then
                mskCosto(1).Text = ""
                mskCosto(1).SetFocus
                Exit Sub
            End If
            
            If VLDato$ = "P" Then
                If Val(Format$(mskCosto(1).Text)) > 100 Then
                    MsgBox "El valor mínimo debe ser Porcentaje", 0 + 16, "Mensaje de Error"
                    mskCosto(1).Text = ""
                    mskCosto(1).SetFocus
                    Exit Sub
                End If
                
            End If
            'If mskCosto(2).Text <> "" Then
            '    If (Val(Format(mskCosto(1).Text)) > Val(Format(mskCosto(2).Text))) Then
            '        MsgBox "El valor mínimo está incorrecto", 0 + 16, "Mensaje de Error"
            '        mskCosto(1).Text = ""
            '        mskCosto(1).SetFocus
            '        Exit Sub
            '    End If
           ' End If
        End If
    
    Case 2 'Valor máximo
        
        If mskCosto(2).Text <> "" Then
            If Not IsNumeric(mskCosto(2).Text) Then
                mskCosto(2).Text = ""
                mskCosto(2).SetFocus
                Exit Sub
            End If
            
            If VLDato$ = "P" Then
                If Val(Format$(mskCosto(2).Text)) > 100 Then
                    MsgBox "El valor máximo debe ser Porcentaje", 0 + 16, "Mensaje de Error"
                    mskCosto(2).Text = ""
                    mskCosto(2).SetFocus
                    Exit Sub
                End If
                
            End If
            'If mskCosto(1).Text <> "" Then
            '    If (Val(Format(mskCosto(1).Text)) > Val(Format(mskCosto(2).Text))) Then
            '        MsgBox "El valor máximo está incorrecto", 0 + 16, "Mensaje de Error"
            '        mskCosto(2).Text = ""
            '        mskCosto(2).SetFocus
            '        Exit Sub
            '    End If
            'End If
        End If
    End Select
End Sub

Private Sub mskFecha_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Fecha de Vigencia"
    mskFecha.SelStart = 0
    mskFecha.SelLength = Len(mskFecha.Text)
End Sub

Private Sub mskFecha_LostFocus()
Dim VTValido%

 If mskFecha.ClipText <> "" Then
        VTValido% = FMVerFormato((mskFecha.FormattedText), VGFormatoFecha$)
        If Not VTValido% Then
            MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
            mskFecha.Mask = ""
            mskFecha.Text = ""
            mskFecha.Mask = FMMascaraFecha(VGFormatoFecha$)
            mskFecha.SetFocus
            
            Exit Sub
        End If
    End If
    If mskFecha.Text <> Format$(VLFecha$, VGFormatoFecha$) Then
        If FMDateDiff("d", Format$(VLFecha$, VGFormatoFecha$), (mskFecha.Text), VGFormatoFecha$) < 0 Then
            MsgBox "Fecha de Vigencia Incorrecta", 16, "Mensaje de Error"
            mskFecha.Mask = ""
            mskFecha.Text = ""
            mskFecha.Mask = FMMascaraFecha(VGFormatoFecha$)
            mskFecha.SetFocus
            Exit Sub
        End If
    End If

'    If mskFecha.ClipText <> "" Then
'        VTValido% = FMVerFormato((mskFecha.FormattedText), "mm/dd/yyyy")
'        If Not VTValido% Then
'            MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
'            mskFecha.Mask = ""
'            mskFecha.Text = ""
'            mskFecha.Mask = FMMascaraFecha("mm/dd/yyyy")
'            mskFecha.SetFocus
'
'            Exit Sub
'        End If
'    End If
'    If mskFecha.Text <> Format$(VLFecha$, "mm/dd/yyyy") Then
'        If FMDateDiff("d", Format$(VLFecha$, "mm/dd/yyyy"), (mskFecha.Text), "mm/dd/yyyy") < 0 Then
'            MsgBox "Fecha de Vigencia Incorrecta", 16, "Mensaje de Error"
'            mskFecha.Mask = ""
'            mskFecha.Text = ""
'            mskFecha.Mask = FMMascaraFecha("mm/dd/yyyy")
'            mskFecha.SetFocus
'            Exit Sub
'        End If
'    End If

End Sub


Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 0, 2, 3, 4, 5
        VLPaso% = False
    End Select

End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Rango [F5 Ayuda]"
    Case 2
       FPrincipal.pnlHelpLine.Caption = " Rubro del Servicio [F5 Ayuda]"
    Case 3
        FPrincipal.pnlHelpLine.Caption = " Código del Servicio [F5 Ayuda]"
    Case 4
        FPrincipal.pnlHelpLine.Caption = " Tipo de dato [F5 Ayuda]"
    Case 5
        FPrincipal.pnlHelpLine.Caption = " Tipo de rango [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
Dim VTFilas%
Dim VTGrupo$
Dim VTRango$
Dim VTR%
    If KeyCode% = VGTeclaAyuda% Then
        VLPaso% = True
        Select Case Index%
            
        Case 0 'Grupo rango
            VLPaso% = True
            If txtCampo(5).Text = "" Then
                MsgBox "El tipo de rango es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(5).SetFocus
                Exit Sub
            End If
            VLPaso% = True
            VGOperacion$ = "sp_help_rango_pe"
            VGTipo$ = "T"
            VTFilas% = VGMaxRows%
            VTGrupo$ = "0"
            VTRango$ = "0"
            While VTFilas% = VGMaxRows%
                 Load FRegistros
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4038"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "G"
                 PMPasoValores sqlconn&, "@i_grupo", 0, SQLINT2, VTGrupo$
                 PMPasoValores sqlconn&, "@i_rango", 0, SQLINT1, VTRango$
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT1, txtCampo(5).Text
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "Ok...Consulta de Rangos") Then
                    If VTGrupo$ = "0" Then
                         PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                    Else
                         PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
                    End If
                     PMChequea sqlconn&
                    VTFilas% = Val(FRegistros.grdRegistros.Tag)

                    FRegistros.grdRegistros.Col = 1
                    FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                    VTGrupo$ = FRegistros.grdRegistros.Text
                 'GBB27May98001 II:
                 'Veirifica que el número de columnas se mayor a dos para asignar los valores
                 If FRegistros.grdRegistros.Col > 2 Then
                    FRegistros.grdRegistros.Col = 2
                 End If
                 FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                 VTRango$ = FRegistros.grdRegistros.Text
                Else
                   VGOperacion$ = ""
                   VGTipo$ = ""
                End If
            Wend
            
            FRegistros.grdRegistros.Row = 1
            FRegistros.Show 1
            If VGValores(1) <> "" Then
                VLRango$ = VGValores(1)
                txtCampo(0) = VGValores(2)
                lblDescripcion(4) = VGValores(3)
                lblDescripcion(5) = VGValores(4)
                VLPaso% = True
            End If
            

        Case 3 'serv disponible
            VGForma$ = "FCosEsp"
            FAyudaSubserv2.Show 1
            'Unload FRubros
            If VGDetalle(1) <> "" Then
                PMSubserv
                VLPaso% = True
            End If
            
        Case 4
            
            PMCatalogo "A", "pe_tipo_dato", txtCampo(4), lblDescripcion(2)
            txtCampo(1).SetFocus
            VLPaso% = True
        
        Case 5 'tipo rango
            VLPaso% = True
            VGOperacion$ = "sp_costos_especiales"
            'GBB26May98008 II:
            ' Se debe haver un load a la forma antes de cargar los valores
            Load FRegistros
            'GBB26May98008 IF:
            Load FRegistros
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4086"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
            PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
            PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT1, "0"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_costos_especiales", False, "Ok...Consulta de Servicios") Then
                PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                PMChequea sqlconn&
                FRegistros.Show 1
                txtCampo(5).Text = VGACatalogo.Codigo$
                lblDescripcion(6).Caption = VGACatalogo.Descripcion$
                If txtCampo(5).Text <> "" Then
                    cmdBoton_Click (3)
                End If
            End If
            VLPaso% = True
        
            'Consulta del tipo de rango
            If txtCampo(5).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4038"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT1, txtCampo(5).Text
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "T"
                ReDim Valores(10) As String
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "Ok...Consulta de Servicios") Then
                     VTR% = FMMapeaArreglo(sqlconn&, Valores())
                     PMChequea sqlconn&
                
                    lblDescripcion(3).Caption = Valores(2) ' moneda
                    lblDescripcion(7).Caption = Valores(3) ' descripcion moneda
                    'Consulta si tiene o no decimales
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4044"
                     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
                     PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, lblDescripcion(3).Caption
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_promon", False, "") Then
                         PMMapeaVariable sqlconn&, VLMoneda$
                         PMChequea sqlconn&
                    End If
                Else
                    txtCampo(3).Text = ""
                    lblDescripcion(3).Caption = ""
                    lblDescripcion(7).Caption = ""
                    VLDato$ = ""

                End If
            End If
        
        End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 1, 2, 4
        If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 96) Or (KeyAscii > 123)) Then
            KeyAscii% = 0
        Else
            KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
        End If
    Case 0, 3, 5
    If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    End Select
    
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
   Dim VTR%
   Select Case Index%
   Case 0 'Grupo rango
        ' Si se ha ingresado algo y se va insertar
        If VLPaso% = False Then
            If txtCampo(0).Text = "" Then
                lblDescripcion(4).Caption = ""
                lblDescripcion(5).Caption = ""
                Exit Sub
            End If
            If txtCampo(5).Text = "" Then
                MsgBox "El tipo de rango es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(5).Text = ""
                txtCampo(5).SetFocus
                Exit Sub
            End If
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4047"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "V"
             PMPasoValores sqlconn&, "@i_tipo_rango", 0, SQLINT1, txtCampo(5).Text
             PMPasoValores sqlconn&, "@i_grupo_rango", 0, SQLINT2, VLRango$
             PMPasoValores sqlconn&, "@i_rango", 0, SQLINT1, txtCampo(0).Text
            ReDim Valores(5) As String
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_corango_pe", False, "Ok...Consulta de Rangos") Then
                 VTR% = FMMapeaArreglo(sqlconn&, Valores())
                 PMChequea sqlconn&
                lblDescripcion(4).Caption = Valores(1)
                lblDescripcion(5).Caption = Valores(2)
            Else
                lblDescripcion(4).Caption = ""
                lblDescripcion(5).Caption = ""
                txtCampo(0).Text = ""
                txtCampo(0).SetFocus
                VLPaso% = True
            End If

        End If
          
    Case 3 'servicio disponible
            If VLPaso% = False Then
                If txtCampo(3).Text <> "" Then
                   VGForma$ = "FCosEsp"
                   FAyudaSubserv2.Show 1
                   If VGDetalle(1) <> "" Then
                        PMSubserv
                   Else
                        If lblDescripcion(1).Caption = "" Then
                            txtCampo(3).Text = ""
                            txtCampo(3).SetFocus
                            VLPaso% = True
                        End If
                   End If
                Else
                   VLPaso% = True
                   lblDescripcion(1).Caption = ""
                   lblDescripcion(0).Caption = ""
                   lblDescripcion(8).Caption = ""
                End If
            End If
    
    Case 4  'Tipo de dato
        If VLPaso% = False Then
            If txtCampo(4).Text <> "" Then
                PMCatalogo "V", "pe_tipo_dato", txtCampo(4), lblDescripcion(2)
                txtCampo(1).SetFocus
            Else
                txtCampo(4).Text = ""
                lblDescripcion(2).Caption = ""
            End If

        End If
        
    Case 5 'tipo de rango
          If VLPaso% = False Then
            If txtCampo(5).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4086"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(5).Text
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_costos_especiales", False, "Ok...Consulta de Tipos de rubro") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(6)
                     PMChequea sqlconn&
                Else
                    txtCampo(5).Text = ""
                    lblDescripcion(6).Caption = ""
                    lblDescripcion(3).Caption = ""
                    lblDescripcion(7).Caption = ""
                End If

            Else
               VLPaso% = True
               lblDescripcion(6).Caption = ""
            End If
              
            'Consulta del tipo de rango
            If txtCampo(5).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4038"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT1, txtCampo(5).Text
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "T"
                ReDim Valores(10) As String
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "Ok...Consulta de Servicios") Then
                     VTR% = FMMapeaArreglo(sqlconn&, Valores())
                     PMChequea sqlconn&
                
                    lblDescripcion(3).Caption = Valores(2) ' moneda
                    lblDescripcion(7).Caption = Valores(3) ' descripcion moneda
                    'Consulta si tiene o no decimales
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4044"
                     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
                     PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, lblDescripcion(3).Caption
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_promon", False, "") Then
                         PMMapeaVariable sqlconn&, VLMoneda$
                         PMChequea sqlconn&
                    End If
                Else
                    txtCampo(3).Text = ""
                    lblDescripcion(0).Caption = ""
                    lblDescripcion(2).Caption = ""
                    VLDato$ = ""
                End If
            End If
              
        End If
        
    End Select

End Sub


Private Sub PMSubserv()
    If VGDetalle(0) = "S" Then
        If txtCampo(3).Text = "" Then
            lblDescripcion(1).Caption = VGDetalle(1) 'des serv dis
            lblDescripcion(0).Caption = VGDetalle(2) 'des rubro
            txtCampo(3).Text = VGDetalle(3) 'cod serv dis
            lblDescripcion(8).Caption = VGDetalle(4) 'cod rubro
            txtCampo(1).Text = VGDetalle(1)
        Else
            lblDescripcion(1).Caption = VGDetalle(1) 'des serv dis
            lblDescripcion(0).Caption = VGDetalle(2) 'des rubro
            lblDescripcion(8).Caption = VGDetalle(3) 'cod rubro
            txtCampo(1).Text = VGDetalle(1)
            
        End If
    End If
End Sub



