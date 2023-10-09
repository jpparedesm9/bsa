VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form FPersoEspecial 
   Appearance      =   0  'Flat
   Caption         =   "Personalización de Costos Especiales"
   ClientHeight    =   5310
   ClientLeft      =   60
   ClientTop       =   1830
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
   Icon            =   "FPERESP.frx":0000
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5310
   ScaleWidth      =   9300
   Begin VB.ComboBox cmbPerso 
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
      Height          =   285
      ItemData        =   "FPERESP.frx":030A
      Left            =   5850
      List            =   "FPERESP.frx":030C
      Sorted          =   -1  'True
      Style           =   2  'Dropdown List
      TabIndex        =   3
      Top             =   540
      Width           =   2430
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
      Left            =   4620
      MaxLength       =   1
      TabIndex        =   10
      Top             =   1365
      Width           =   930
   End
   Begin VB.ComboBox cmbCosto 
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
      Height          =   285
      Left            =   1560
      Sorted          =   -1  'True
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   795
      Width           =   1920
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
      Left            =   1605
      MaxLength       =   4
      TabIndex        =   0
      Top             =   30
      Width           =   930
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      FillColor       =   &H00808080&
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   0
      Left            =   8640
      Picture         =   "FPERESP.frx":030E
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   24
      Top             =   1620
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   195
      Index           =   1
      Left            =   8865
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   23
      Top             =   1620
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Transmitir"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Index           =   0
      Left            =   8385
      Picture         =   "FPERESP.frx":03E8
      Style           =   1  'Graphical
      TabIndex        =   13
      Tag             =   "4090"
      Top             =   3015
      Width           =   870
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
      Left            =   8400
      Picture         =   "FPERESP.frx":074E
      Style           =   1  'Graphical
      TabIndex        =   12
      Tag             =   "4089"
      Top             =   60
      Width           =   875
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
      Index           =   2
      Left            =   1560
      MaxLength       =   8
      TabIndex        =   8
      Top             =   1110
      Width           =   1665
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
      Left            =   8400
      Picture         =   "FPERESP.frx":09B0
      Style           =   1  'Graphical
      TabIndex        =   15
      Top             =   4530
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
      Left            =   8400
      Picture         =   "FPERESP.frx":0D16
      Style           =   1  'Graphical
      TabIndex        =   14
      Top             =   3765
      Width           =   875
   End
   Begin MSGrid.Grid grdServicios 
      Height          =   1395
      Index           =   1
      Left            =   45
      TabIndex        =   20
      Top             =   3840
      Width           =   8265
      _Version        =   65536
      _ExtentX        =   14579
      _ExtentY        =   2461
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
   Begin MSGrid.Grid grdServicios 
      Height          =   1410
      Index           =   0
      Left            =   30
      TabIndex        =   11
      Top             =   2085
      Width           =   8265
      _Version        =   65536
      _ExtentX        =   14579
      _ExtentY        =   2487
      _StockProps     =   77
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
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   240
      Left            =   1560
      TabIndex        =   6
      Top             =   1110
      Width           =   1665
      _ExtentX        =   2937
      _ExtentY        =   423
      _Version        =   393216
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
   Begin MSMask.MaskEdBox mskFecha 
      Height          =   240
      Left            =   1575
      TabIndex        =   1
      Top             =   540
      Width           =   975
      _ExtentX        =   1720
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
      Left            =   1560
      MaxLength       =   7
      TabIndex        =   7
      Top             =   1110
      Width           =   1665
   End
   Begin MSMask.MaskEdBox mskCosto 
      Height          =   240
      Left            =   1560
      TabIndex        =   9
      Top             =   1365
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
   Begin VB.Frame FrmAplic 
      Height          =   360
      Left            =   5850
      TabIndex        =   35
      Top             =   735
      Width           =   2430
      Begin VB.OptionButton OptAplic 
         Alignment       =   1  'Right Justify
         Caption         =   "Oficina"
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   1
         Left            =   1365
         TabIndex        =   5
         Top             =   135
         Width           =   885
      End
      Begin VB.OptionButton OptAplic 
         Alignment       =   1  'Right Justify
         Caption         =   "Nacional"
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   0
         Left            =   60
         TabIndex        =   4
         Top             =   135
         Value           =   -1  'True
         Width           =   990
      End
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo Aplicación:"
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
      Left            =   4245
      TabIndex        =   34
      Top             =   900
      Width           =   1260
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
      Index           =   8
      Left            =   3480
      TabIndex        =   33
      Top             =   1455
      Width           =   1050
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
      Index           =   4
      Left            =   5565
      TabIndex        =   32
      Top             =   1365
      Width           =   2715
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
      Left            =   1605
      TabIndex        =   31
      Top             =   285
      Width           =   930
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo de Costo:"
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
      Left            =   30
      TabIndex        =   30
      Top             =   900
      Width           =   1155
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
      Index           =   7
      Left            =   45
      TabIndex        =   29
      Top             =   360
      Width           =   525
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
      Left            =   2550
      TabIndex        =   28
      Top             =   285
      Width           =   5730
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
      Index           =   6
      Left            =   45
      TabIndex        =   27
      Top             =   105
      Width           =   1545
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
      Left            =   2550
      TabIndex        =   26
      Top             =   30
      Width           =   5730
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Fecha Vigencia:"
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
      Left            =   45
      TabIndex        =   25
      Top             =   615
      Width           =   1215
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Valores de Costos Personalizados:"
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
      Left            =   45
      TabIndex        =   22
      Top             =   3585
      Width           =   2715
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Valores de Costos Generales Vigentes:"
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
      Left            =   45
      TabIndex        =   21
      Top             =   1815
      Width           =   3000
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   -75
      X2              =   8295
      Y1              =   1665
      Y2              =   1665
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Personalización por:"
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
      Left            =   4230
      TabIndex        =   16
      Top             =   615
      Width           =   1590
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Valor Fijo:"
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
      Left            =   45
      TabIndex        =   19
      Top             =   1440
      Width           =   810
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
      Left            =   3240
      TabIndex        =   17
      Top             =   1110
      Width           =   5040
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Nro. Cuenta:"
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
      Left            =   45
      TabIndex        =   18
      Top             =   1185
      Width           =   975
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8340
      X2              =   8340
      Y1              =   15
      Y2              =   5325
   End
End
Attribute VB_Name = "FPersoEspecial"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
Dim VLPaso As Integer
Dim VLMoneda As String

'variables para guardar en costos personalizados
Dim VLRubro As String
Dim VLTipo_dato As String
Dim VLTipo_rango As String
Dim VLGrupo As String
Dim VLRango As String
Dim VLMinimo As Double
Dim VLMaximo As Double
Dim VLBase As Double
Dim VLFecha As String

Private Sub cmbCosto_Click()
Dim i%
Dim Index%
    For i% = 1 To grdServicios(0).Rows - 1
        grdServicios(Index%).Col = 0
        grdServicios(Index%).Row = i%
        grdServicios(Index%).Text = Str$(grdServicios(Index%).Row)
        grdServicios(Index%).Picture = picVisto(1)
    Next i%
    grdServicios(1).Rows = 2
    grdServicios(1).Cols = 2
    grdServicios(1).Row = 0
    grdServicios(1).Col = 1
    grdServicios(1).Text = ""
    grdServicios(1).Row = 1
    grdServicios(1).Col = 0
    grdServicios(1).Text = ""
    grdServicios(1).Row = 1
    grdServicios(1).Col = 1
    grdServicios(1).Text = ""
    grdServicios(1).ColWidth(1) = grdServicios(1).ColWidth(0)
    VLTipo_dato$ = ""
    
Select Case cmbCosto.Text
        Case "VALOR FIJO"
            lblEtiqueta(3).Visible = True
            lblEtiqueta(3).Caption = "Valor Fijo:"
            mskCosto.Text = ""
            mskCosto.Visible = True
            txtCampo(1).Text = ""
            txtCampo(2).Text = ""
            mskCuenta.Mask = ""
            mskCuenta.Text = ""
            mskCuenta_GotFocus
            lblDescripcion(0).Caption = ""
            mskCosto.Mask = ""
            mskCosto.Text = ""
            mskFecha.Text = VLFecha$
            txtCampo(4).Text = ""
            lblDescripcion(4).Caption = ""
            lblEtiqueta(8).Visible = True
            lblDescripcion(4).Visible = True
            txtCampo(4).Visible = True
                        
        Case "VALOR VARIABLE"
            lblEtiqueta(3).Visible = True
            lblEtiqueta(3).Caption = "Valor Variable:"
            mskCosto.Text = ""
            mskCosto.Visible = True
            txtCampo(1).Text = ""
            txtCampo(2).Text = ""
            mskCuenta.Mask = ""
            mskCuenta.Text = ""
            mskCuenta_GotFocus
            lblDescripcion(0).Caption = ""
            mskCosto.Mask = ""
            mskCosto.Text = ""
            mskFecha.Text = VLFecha$
            txtCampo(4).Text = ""
            lblDescripcion(4).Caption = ""
            lblEtiqueta(8).Visible = True
            lblDescripcion(4).Visible = True
            txtCampo(4).Visible = True
            
        Case "VALOR EXONERADO"
            lblEtiqueta(3).Visible = False
            txtCampo(4).Text = ""
            lblDescripcion(4).Caption = ""
            lblEtiqueta(8).Visible = False
            lblDescripcion(4).Visible = False
            txtCampo(4).Visible = False
            mskCosto.Text = ""
            mskCosto.Visible = False
            txtCampo(1).Text = ""
            txtCampo(2).Text = ""
            mskCuenta.Mask = ""
            mskCuenta.Text = ""
            mskCuenta_GotFocus
            lblDescripcion(0).Caption = ""
            mskCosto.Mask = ""
            mskCosto.Text = ""
            mskFecha.Text = VLFecha$
            
End Select

End Sub

Private Sub cmbcosto_GotFocus()
 FPrincipal.pnlHelpLine.Caption = " Tipo de Costo Especial"
End Sub

Private Sub cmbPerso_Click()
Dim i%
Dim Index%
    For i% = 1 To grdServicios(0).Rows - 1
        grdServicios(Index%).Col = 0
        grdServicios(Index%).Row = i%
        grdServicios(Index%).Text = Str$(grdServicios(Index%).Row)
        grdServicios(Index%).Picture = picVisto(1)
    Next i%
    grdServicios(1).Rows = 2
    grdServicios(1).Cols = 2
    grdServicios(1).Row = 0
    grdServicios(1).Col = 1
    grdServicios(1).Text = ""
    grdServicios(1).Row = 1
    grdServicios(1).Col = 0
    grdServicios(1).Text = ""
    grdServicios(1).Row = 1
    grdServicios(1).Col = 1
    grdServicios(1).Text = ""
    grdServicios(1).ColWidth(1) = grdServicios(1).ColWidth(0)
    VLTipo_dato$ = ""
    
Select Case cmbPerso.Text
        Case "CTA CORRIENTE", "CTA AHORROS"
            lblEtiqueta(2).Caption = "Nro. Cuenta:"
            mskCuenta.Visible = True
            txtCampo(1).Visible = False
            txtCampo(2).Visible = False
            txtCampo(1).Text = ""
            txtCampo(2).Text = ""
            mskCuenta.Mask = ""
            mskCuenta.Text = ""
            mskCuenta_GotFocus
            lblDescripcion(0).Caption = ""
            mskCosto.Mask = ""
            mskCosto.Text = ""
            mskFecha.Text = VLFecha$
            FrmAplic.Visible = True
            lblEtiqueta(9).Visible = True
            OptAplic(0).Value = True
            If mskCuenta.Visible = True Then mskCuenta.SetFocus
        
        Case "CLIENTE"
            lblEtiqueta(2).Caption = "Código Cliente:"
            mskCuenta.Visible = False
            mskCuenta.Mask = ""
            mskCuenta.Text = ""
            lblDescripcion(0).Caption = ""
            txtCampo(1).Text = ""
            txtCampo(1).Visible = False
            txtCampo(2).Text = ""
            txtCampo(2).Visible = True
            mskCosto.Mask = ""
            mskCosto.Text = ""
            mskFecha.Text = VLFecha$
            FrmAplic.Visible = True
            lblEtiqueta(9).Visible = True
            OptAplic(0).Value = True
            If txtCampo(2).Visible = True Then txtCampo(2).SetFocus
    
        Case "OFICINA"
            lblEtiqueta(2).Caption = "Código Oficina:"
            mskCuenta.Visible = False
            mskCuenta.Mask = ""
            mskCuenta.Text = ""
            lblDescripcion(0).Caption = ""
            txtCampo(1).Text = ""
            txtCampo(1).Visible = True
            txtCampo(2).Text = ""
            txtCampo(2).Visible = False
            mskCosto.Mask = ""
            mskCosto.Text = ""
            mskFecha.Text = VLFecha$
            FrmAplic.Visible = False
            lblEtiqueta(9).Visible = False
            OptAplic(0).Value = False
            txtCampo(1).SetFocus
            
End Select
End Sub

Private Sub cmbperso_GotFocus()
 FPrincipal.pnlHelpLine.Caption = " Tipo de Personalización Especial"
End Sub

Private Sub cmdBoton_Click(Index As Integer)
Dim VTMarca%
Dim i%
Dim VTValor#
Dim VTTipoCosto$
Dim VTTipoPer$
Dim VTProdu$
Dim VTTipoAplic$
Dim VLFormatoFecha$
   Select Case Index%
    Case 0 'Transmitir
        'Validación de Mandatoriedades
        If txtCampo(0).Text = "" Then
            MsgBox "El servicio disponible es obligatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        
        If mskFecha.ClipText = "" Then
            MsgBox "La fecha de vigencia es obligatoria", 0 + 16, "Mensaje de Error"
            mskFecha.SetFocus
            Exit Sub
        End If
        
        If cmbCosto.Text = "VALOR VARIABLE" Then
            VTMarca% = 0
            For i% = 1 To grdServicios(0).Rows - 1
                grdServicios(0).Col = 0
                grdServicios(0).Row = i%
                If grdServicios(0).Text = "X" Then
                    VTMarca% = 1
                    Exit For
                End If
            Next i%
            
            If VTMarca% = 0 Then
                MsgBox "El costo general a personalizar es obligatorio", 0 + 16, "Mensaje de Error"
                grdServicios(0).SetFocus
                Exit Sub
            End If
        End If
        
        If mskCuenta.ClipText = "" And (cmbPerso.Text = "CTA CORRIENTE" Or cmbPerso.Text = "CTA AHORROS") Then
            MsgBox "El Nùmero de cuenta es obligatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If
        
        If cmbCosto.Text = "VALOR VARIABLE" And mskCosto.ClipText = "" Then
            MsgBox "El Valor Variable es obligatorio", 0 + 16, "Mensaje de Error"
            mskCosto.SetFocus
            Exit Sub
        End If
                    
        
        If cmbCosto.Text = "VALOR FIJO" Or cmbCosto.Text = "VALOR VARIABLE" Then
            If txtCampo(4).Text = "P" Then
                If Val(Format$(mskCosto.Text)) < -100 Or Val(Format$(mskCosto.Text)) > 100 Then
                    MsgBox "El valor debe ser Porcentaje", 0 + 16, "Mensaje de Error"
                    mskCosto.Text = ""
                    mskCosto.SetFocus
                    Exit Sub
                End If
            End If
        End If

        'validacion de limites
        If cmbCosto.Text = "VALOR VARIABLE" Then
            If txtCampo(4).Text = "P" Then
                VTValor# = VLBase + Round(VLBase * CDbl(mskCosto.Text) / 100, 2)
            Else
                VTValor# = VLBase + CDbl(mskCosto.Text)
            End If
                        
            If VTValor# > VLMaximo Then
                MsgBox "El valor variable no puede ser superior al valor máximo: " + Format$(VLMaximo, "#,##0.00"), 0 + 16, "Mensaje de Error"
                mskCosto.Mask = ""
                mskCosto.Text = ""
                mskCosto.SetFocus
                Exit Sub
            End If
            
            If VTValor# < VLMinimo Then
                MsgBox "El valor variable no puede ser inferior al valor mínimo: " + Format$(VLMinimo, "#,##0.00"), 0 + 16, "Mensaje de Error"
                mskCosto.Mask = ""
                mskCosto.Text = ""
                mskCosto.SetFocus
                Exit Sub
            End If
        End If
        
        If mskCosto.ClipText = "" And cmbCosto.Text = "VALOR FIJO" Then
            MsgBox "El Valor Fijo es obligatorio", 0 + 16, "Mensaje de Error"
            mskCosto.SetFocus
            Exit Sub
        End If
                       
        If cmbCosto.Text <> "VALOR EXONERADO" And txtCampo(4).Text = "" Then
            MsgBox "El Tipo de dato es obligatorio", 0 + 16, "Mensaje de Error"
            txtCampo(4).SetFocus
            Exit Sub
        End If
                       
        If mskCuenta.ClipText = "" And (cmbPerso.Text = "CTA CORRIENTE" Or cmbPerso.Text = "CTA AHORROS") Then
            MsgBox "El Nùmero de cuenta es obligatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If
            
        If txtCampo(1).Text = "" And cmbPerso.Text = "OFICINA" Then
            MsgBox "El Código de la oficina es obligatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If
            
        If txtCampo(2).Text = "" And cmbPerso.Text = "CLIENTE" Then
            MsgBox "El Código del cliente es obligatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
       
        If cmbCosto.Text = "VALOR FIJO" Then
            VTTipoCosto$ = "F"
            VLMinimo = 0
            VLMaximo = 0
            VLRubro$ = ""
            VLTipo_rango$ = ""
            VLGrupo$ = ""
            VLRango$ = ""
            VLMinimo = -99
        ElseIf cmbCosto.Text = "VALOR VARIABLE" Then
            VTTipoCosto$ = "V"
        Else
            VTTipoCosto$ = "E"
            VLRubro$ = ""
            VLTipo_rango$ = ""
            VLGrupo$ = ""
            VLRango$ = ""
            VLMinimo = -99
        End If
        
        If cmbPerso.Text = "CTA CORRIENTE" Or cmbPerso.Text = "CTA AHORROS" Then
            VTTipoPer$ = "C"
        ElseIf cmbPerso.Text = "OFICINA" Then
            VTTipoPer$ = "O"
        Else
            VTTipoPer$ = "E"
        End If
        
        If cmbPerso.Text = "CTA CORRIENTE" Then
            VTProdu$ = "3"
        ElseIf cmbPerso.Text = "CTA AHORROS" Then
            VTProdu$ = "4"
        Else
            VTProdu$ = ""
        End If
         
        If cmbPerso <> "OFICINA" Then
            If OptAplic(0).Value = True Then
                VTTipoAplic$ = "N"
            Else
                VTTipoAplic$ = "O"
            End If
        Else
            VTTipoAplic$ = ""
        End If
        
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4090"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
        PMPasoValores sqlconn&, "@i_tipo_costo", 0, SQLCHAR, VTTipoCosto$
        PMPasoValores sqlconn&, "@i_tipo_per", 0, SQLCHAR, VTTipoPer$
        PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(0).Text
        PMPasoValores sqlconn&, "@i_rubro", 0, SQLVARCHAR, lblDescripcion(3).Caption
        PMPasoValores sqlconn&, "@i_tipo_dato", 0, SQLCHAR, txtCampo(4).Text
        PMPasoValores sqlconn&, "@i_tipo_rango", 0, SQLINT1, VLTipo_rango$
        PMPasoValores sqlconn&, "@i_grupo_rango", 0, SQLINT2, VLGrupo$
        PMPasoValores sqlconn&, "@i_rango", 0, SQLINT1, VLRango$
        PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, mskCuenta.ClipText
        PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, txtCampo(1).Text
        PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, txtCampo(2).Text
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VTProdu$
        PMPasoValores sqlconn&, "@i_valor_per", 0, SQLMONEY, mskCosto.Text
        PMPasoValores sqlconn&, "@i_val_minimo", 0, SQLMONEY, VLMinimo
        PMPasoValores sqlconn&, "@i_val_maximo", 0, SQLMONEY, VLMaximo
        PMPasoValores sqlconn&, "@i_tipo_aplic", 0, SQLCHAR, VTTipoAplic$
        PMPasoValores sqlconn&, "@i_fecha_vigencia", 0, SQLVARCHAR, FMConvFecha((mskFecha.Text), Get_Preferencia("FORMATO-FECHA"), "mm/dd/yyyy")
                           
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_costos_especiales_per", True, " Ok...Personalización de Costos Especiales") Then
            'cmdBoton(0).Enabled = False
            PMChequea sqlconn&
            mskCosto.Text = ""
            cmdBoton_Click (3)
        Else
            MsgBox "Error al ingresar el Costo Especial Personalizado", 0 + 16, "Mensaje de Error"
        End If
        'cmdBoton_Click (3)
         'Después Consultar y quitar el visto
         
    Case 1 'Limpiar
        cmbCosto.Clear
        cmbCosto.AddItem "VALOR FIJO", 0
        cmbCosto.AddItem "VALOR VARIABLE", 1
        cmbCosto.AddItem "VALOR EXONERADO", 2
        cmbCosto.ListIndex = 0
        cmbPerso.Clear
        cmbPerso.AddItem "CTA CORRIENTE", 0
        cmbPerso.AddItem "CTA AHORROS", 1
        cmbPerso.AddItem "CLIENTE", 2
        cmbPerso.AddItem "OFICINA", 3
        cmbPerso.ListIndex = 0
    
        mskCuenta.Mask = ""
        mskCuenta.Text = ""
        mskCuenta_GotFocus
        mskCosto.Mask = ""
        mskCosto.Text = ""
        mskFecha.Text = Format$(VLFecha$, VLFormatoFecha$)
        For i% = 0 To 2
            txtCampo(i%).Text = ""
        Next i%
        For i% = 0 To 3
            lblDescripcion(i%).Caption = ""
        Next i%
        For i% = 0 To 1
            grdServicios(i%).Rows = 2
            grdServicios(i%).Cols = 2
            grdServicios(i%).Row = 0
            grdServicios(i%).Col = 1
            grdServicios(i%).Text = ""
            grdServicios(i%).Row = 1
            grdServicios(i%).Col = 0
            grdServicios(i%).Text = ""
            grdServicios(i%).Row = 1
            grdServicios(i%).Col = 1
            grdServicios(i%).Text = ""
            grdServicios(i%).ColWidth(1) = grdServicios(i%).ColWidth(0)
        Next i%
        
        cmdBoton(0).Enabled = True
        txtCampo(0).SetFocus

    Case 2 'Salir
        
        Unload FPersoEspecial
        Unload FBuscarCliente
        'Unload FBuscarLabor
        
    Case 3 'Buscar costos especiales personalizados
        
        grdServicios(1).Rows = 2
        grdServicios(1).Cols = 2
        grdServicios(1).Row = 0
        grdServicios(1).Col = 1
        grdServicios(1).Text = ""
        grdServicios(1).Row = 1
        grdServicios(1).Col = 0
        grdServicios(1).Text = ""
        grdServicios(1).Row = 1
        grdServicios(1).Col = 1
        grdServicios(1).Text = ""
        grdServicios(1).ColWidth(1) = grdServicios(1).ColWidth(0)

        If txtCampo(0).Text = "" Then
            MsgBox "El servicio disponible es obligatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
                
        If mskFecha.ClipText = "" Then
            MsgBox "La fecha de vigencia es obligatoria", 0 + 16, "Mensaje de Error"
            mskFecha.SetFocus
            Exit Sub
        End If
        
        If mskCuenta.ClipText = "" And (cmbPerso.Text = "CTA CORRIENTE" Or cmbPerso.Text = "CTA AHORROS") Then
            MsgBox "El Número de cuenta es obligatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If
            
        If txtCampo(1).Text = "" And cmbPerso.Text = "OFICINA" Then
            MsgBox "El Código de la oficina es obligatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If
            
        If txtCampo(2).Text = "" And cmbPerso.Text = "CLIENTE" Then
            MsgBox "El Código del cliente es obligatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
            
        If cmbCosto.Text = "VALOR VARIABLE" Then
            VTMarca% = 0
            For i% = 1 To grdServicios(0).Rows - 1
                grdServicios(0).Col = 0
                grdServicios(0).Row = i%
                If grdServicios(0).Text = "X" Then
                    VTMarca% = 1
                    Exit For
                End If
            Next i%
            
            'If VTMarca% = 0 Then
            '    MsgBox "Es obligatorio marcar un costo general", 0 + 16, "Mensaje de Error"
            '    grdServicios(0).SetFocus
            '    Exit Sub
            'End If
            
            If mskCuenta.ClipText = "" And (cmbPerso.Text = "CTA CORRIENTE" Or cmbPerso.Text = "CTA AHORROS") Then
                MsgBox "El Nùmero de cuenta es obligatorio", 0 + 16, "Mensaje de Error"
                mskCuenta.SetFocus
                Exit Sub
            End If
        End If
                    
        If cmbCosto.Text = "VALOR FIJO" Then
            VTTipoCosto$ = "F"
            'VLTipo_dato$ = "M"
            VLMinimo = 0
            VLMaximo = 0
            VLRubro$ = ""
            VLTipo_rango$ = ""
            VLGrupo$ = ""
            VLRango$ = ""
            VLMinimo = -99
        ElseIf cmbCosto.Text = "VALOR VARIABLE" Then
            VTTipoCosto$ = "V"
        Else
            VTTipoCosto$ = "E"
            'VLTipo_dato$ = ""
            VLRubro$ = ""
            VLTipo_rango$ = ""
            VLGrupo$ = ""
            VLRango$ = ""
            VLMinimo = -99
        End If
        
        If cmbPerso.Text = "CTA CORRIENTE" Or cmbPerso.Text = "CTA AHORROS" Then
            VTTipoPer$ = "C"
        ElseIf cmbPerso.Text = "OFICINA" Then
            VTTipoPer$ = "O"
        Else
            VTTipoPer$ = "E"
        End If
        
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4089"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
         PMPasoValores sqlconn&, "@i_tipo_costo", 0, SQLCHAR, VTTipoCosto$
         PMPasoValores sqlconn&, "@i_tipo_per", 0, SQLCHAR, VTTipoPer$
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_rubro", 0, SQLVARCHAR, lblDescripcion(3).Caption
         'PMPasoValores sqlconn&, "@i_tipo_dato", 0, SQLVARCHAR, VLTipo_dato$
         PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, mskCuenta.ClipText
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, txtCampo(2).Text
        
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_costos_especiales_per", True, "Ok... Consulta de Costos Especiales Personalizados") Then
             PMMapeaGrid sqlconn&, grdServicios(1), False
             PMChequea sqlconn&
             grdServicios(1).ColWidth(1) = 1300
             grdServicios(1).ColWidth(6) = 1800
             grdServicios(1).ColWidth(4) = 1500
             grdServicios(1).ColWidth(5) = 1500
         End If
                 
        
End Select
End Sub

Private Sub Form_Load()
Dim VLFormatoFecha$
    FPersoEspecial.Left = 15
    FPersoEspecial.Top = 15
    FPersoEspecial.Width = 9420
    FPersoEspecial.Height = 5730
    'PMBotonSeguridad FPersoEspecial, 3
    cmbCosto.Clear
    cmbCosto.AddItem "VALOR FIJO", 0
    cmbCosto.AddItem "VALOR VARIABLE", 1
    cmbCosto.AddItem "VALOR EXONERADO", 2
    cmbCosto.ListIndex = 0
    cmbPerso.Clear
    cmbPerso.AddItem "CTA CORRIENTE", 0
    cmbPerso.AddItem "CTA AHORROS", 1
    cmbPerso.AddItem "CLIENTE", 2
    cmbPerso.AddItem "OFICINA", 3
    cmbPerso.ListIndex = 0
    
    VLTipo_dato$ = ""
    VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
    mskFecha.Mask = FMMascaraFecha(VLFormatoFecha$)
    VLFecha$ = FMConvFecha((VGFecha), "mm/dd/yyyy", Get_Preferencia("FORMATO-FECHA"))
    VLFecha$ = DateAdd("d", 1, VLFecha$)
    mskFecha.Text = VLFecha$
    
 PMObjetoSeguridad cmdBoton(3)
 PMObjetoSeguridad cmdBoton(0)
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub


Private Sub PMMarcarRegistro(Index As Integer)
Dim VTFila%
Dim i%
If Index% = 0 Then
    If cmbCosto.Text = "VALOR VARIABLE" Then
        grdServicios(Index%).Col = 0
        If grdServicios(Index%).Text <> "X" Then
            grdServicios(Index%).Text = "X"
            grdServicios(Index%).Picture = picVisto(0)
            grdServicios(Index%).Col = 2
            VLRubro$ = grdServicios(Index%).Text
            grdServicios(Index%).Col = 3
            VLTipo_dato$ = grdServicios(Index%).Text
            grdServicios(Index%).Col = 10
            VLTipo_rango$ = grdServicios(Index%).Text
            grdServicios(Index%).Col = 11
            VLGrupo$ = grdServicios(Index%).Text
            grdServicios(Index%).Col = 12
            VLRango$ = grdServicios(Index%).Text
            grdServicios(Index%).Col = 6
            VLMinimo = grdServicios(Index%).Text
            grdServicios(Index%).Col = 7
            VLBase = grdServicios(Index%).Text
            grdServicios(Index%).Col = 8
            VLMaximo = grdServicios(Index%).Text
            mskCosto.SetFocus
        Else
            grdServicios(Index%).Text = Str$(grdServicios(Index%).Row)
            grdServicios(Index%).Picture = picVisto(1)
            VLRubro$ = ""
            VLTipo_dato$ = ""
            VLTipo_rango$ = ""
            VLGrupo$ = ""
            VLRango$ = ""
            VLMinimo = 0
            VLMaximo = 0
        End If
        
        grdServicios(Index%).Col = 0
        VTFila% = grdServicios(Index%).Row
        
        For i% = 1 To grdServicios(Index%).Rows - 1
            If i% <> VTFila% Then
                grdServicios(Index%).Row = i%
                grdServicios(Index%).Text = Str$(grdServicios(Index%).Row)
                grdServicios(Index%).Picture = picVisto(1)
            End If
        Next i%
    End If
End If

End Sub

Private Sub grdServicios_DblClick(Index As Integer)
Dim VTRow%
    VTRow% = grdServicios(Index%).Row
    grdServicios(Index%).Row = 1
    grdServicios(Index%).Col = 1
    If grdServicios(Index%).Text <> "" Then
            grdServicios(Index%).Row = VTRow%
            Select Case Index%
            Case 0, 1
                If Val(grdServicios(Index%).Tag) > 0 Then
                  cmdBoton(0).Enabled = True
                  PMMarcarRegistro Index%
                  
                End If
            End Select
    End If

End Sub

Private Sub grdServicios_KeyUp(Index As Integer, KeyCode As Integer, Shift As Integer)
    Select Case Index%
    Case 0, 1
        grdServicios(Index%).Col = 0
        grdServicios(Index%).SelStartCol = 1
        grdServicios(Index%).SelEndCol = grdServicios(Index%).Cols - 1
        If grdServicios(Index%).Row = 0 Then
            grdServicios(Index%).SelStartRow = 1
            grdServicios(Index%).SelEndRow = 1
        Else
            grdServicios(Index%).SelStartRow = grdServicios(Index%).Row
            grdServicios(Index%).SelEndRow = grdServicios(Index%).Row
        End If
    End Select
End Sub

Private Sub mskCosto_GotFocus()
    If VLTipo_dato$ = "M" Then
        If VLMoneda$ = "S" Then
            mskCosto.Format = "#,##0.00"
        ElseIf VLMoneda$ = "N" Then
            mskCosto.Format = "#,##0"
            
        End If
    Else
        mskCosto.Format = "##0.00"
    End If

    If cmbCosto.Text = "VALOR FIJO" Then
        FPrincipal.pnlHelpLine.Caption = " Valor Fijo"
    End If
    If cmbCosto.Text = "VALOR VARIABLE" Then
        FPrincipal.pnlHelpLine.Caption = " Valor Variable"
    End If
    
    mskCosto.SelStart = 0
    mskCosto.SelLength = Len(mskCosto.Text)

End Sub

Private Sub mskCosto_KeyPress(KeyAscii As Integer)
    If cmbCosto.Text <> "VALOR FIJO" Then
        If (Chr$(KeyAscii%)) <> "." And KeyAscii% <> 8 And UCase$(Chr$(KeyAscii%)) <> "-" And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
                KeyAscii% = 0
        End If
    Else
        If (Chr$(KeyAscii%)) <> "." And KeyAscii% <> 8 And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
                KeyAscii% = 0
        End If
    End If
    
    If VLTipo_dato$ = "P" Then
        If (Chr$(KeyAscii%)) <> "." And KeyAscii% <> 8 And UCase$(Chr$(KeyAscii%)) <> "-" And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
                KeyAscii% = 0
        End If
        Exit Sub
    End If
    If VLMoneda$ = "S" Then
        If (Chr$(KeyAscii%)) <> "." And KeyAscii% <> 8 And UCase$(Chr$(KeyAscii%)) <> "-" And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
                KeyAscii% = 0
        End If
    ElseIf VLMoneda$ = "N" Then
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
                KeyAscii% = 0
        End If
    End If

End Sub

Private Sub mskCosto_LostFocus()
        If mskCosto.Text <> "" Then
            If Not IsNumeric(mskCosto.Text) Then
                mskCosto.Text = ""
                mskCosto.SetFocus
                Exit Sub
            End If
        End If

End Sub

Private Sub mskCuenta_GotFocus()
    If cmbPerso.Text <> "" Then

        If cmbPerso.Text = "CTA CORRIENTE" Then
            mskCuenta.Mask = VGMascaraCtaCte$
            FPrincipal.pnlHelpLine.Caption = " Número de la Cuenta Corriente"
        Else
            mskCuenta.Mask = VGMascaraCtaAho$
            FPrincipal.pnlHelpLine.Caption = " Número de la Cuenta de Ahorros"
        End If
    End If
    
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)

End Sub

Private Sub mskCuenta_LostFocus()
Dim VLTipo%
Dim VTR1%
    On Error Resume Next
    If cmbPerso.Text <> "CTA CORRIENTE" And cmbPerso.Text <> "CTA AHORROS" Then
        MsgBox "El tipo de Cuenta es mandatorio", 0 + 16, "Mensaje de Error"
        cmbPerso.SetFocus
        Exit Sub
    End If
    If mskCuenta.ClipText <> "" Then
        If cmbPerso.Text = "CTA CORRIENTE" Then
            If FMChequeaCtaCte((mskCuenta.ClipText)) Then
                VLTipo% = True
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4074"
                     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
                     PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                     PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "3"
                     PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_valor_contratado", True, "") Then
                        ReDim VTArreglo(10) As String
                         VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
                         PMChequea sqlconn&
                        If VTR1% <> 0 Then
                            lblDescripcion(0).Caption = VTArreglo(1)
                        Else
                            MsgBox "Error en consulta de Cuenta", 0 + 16, "Mensaje del Servidor"
                        End If
                    Else
                        mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                        mskCuenta.SetFocus
                    End If
                
            Else
                MsgBox "El dígito verificador de la cuenta corriente está incorrecto", 0 + 16, "Mensaje de Error"
                lblDescripcion(0).Caption = ""
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                mskCuenta.SetFocus
                VLPaso% = True
                Exit Sub
            End If
            
        Else
            'OJO
            If FMChequeaCtaAho((mskCuenta.ClipText)) Then
                VLTipo% = False
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4074"
                     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
                     PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                     PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
                     PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_valor_contratado", True, "") Then
                        ReDim VTArreglo(10) As String
                         VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
                         PMChequea sqlconn&
                        If VTR1% <> 0 Then
                            lblDescripcion(0).Caption = VTArreglo(1)
                        Else
                            MsgBox "Error en consulta de Cuenta", 0 + 16, "Mensaje del Servidor"
                        End If
                    Else
                        mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                        mskCuenta.SetFocus
                    End If
            Else
                MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
                lblDescripcion(0).Caption = ""
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                mskCuenta.SetFocus
                VLPaso% = True
                Exit Sub
            End If
        End If
End If

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
    If mskFecha.Text < Format$(VLFecha$, VGFormatoFecha$) Then
        If FMDateDiff("d", Format$(VLFecha$, VGFormatoFecha$), (mskFecha.Text), VGFormatoFecha$) < 0 Then
            MsgBox "Fecha de Vigencia Incorrecta", 16, "Mensaje de Error"
            mskFecha.Mask = ""
            mskFecha.Text = ""
            mskFecha.Mask = FMMascaraFecha(VGFormatoFecha$)
            mskFecha.SetFocus
            Exit Sub
        End If
    End If


End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        VLPaso% = True
        FPrincipal.pnlHelpLine.Caption = " Código del Servicio Disponible [F5 Ayuda]"
    Case 1
        VLPaso% = True
        FPrincipal.pnlHelpLine.Caption = " Código de la Oficina [F5 Ayuda]"
    Case 2
        VLPaso% = True
        FPrincipal.pnlHelpLine.Caption = " Código del Cliente [F5 Ayuda]"
    Case 3
        FPrincipal.pnlHelpLine.Caption = " Rubro del Servicio [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub
Private Sub txtCampo_Change(Index As Integer)
'    If Index% = 1 Or Index% = 2 Then
        VLPaso% = False
'    End If
End Sub
Private Sub PMSubserv()
    If VGDetalle(0) = "S" Then
        If txtCampo(0).Text = "" Then

            lblDescripcion(1).Caption = VGDetalle(1) 'des serv dis
            lblDescripcion(2).Caption = VGDetalle(2) 'des rubro
            txtCampo(0).Text = VGDetalle(3) 'cod serv dis
            lblDescripcion(3).Caption = VGDetalle(4) 'cod rubro
            
        Else
            lblDescripcion(1).Caption = VGDetalle(1) 'des serv dis
            lblDescripcion(2).Caption = VGDetalle(2) 'des rubro
            lblDescripcion(3).Caption = VGDetalle(3) 'cod rubro

        End If
    End If
End Sub
Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    If KeyCode = VGTeclaAyuda% Then
      Select Case Index%
        Case 0 'Serv disponible
            VGForma$ = "FPersoEspecial"
            FAyudaSubserv2.Show 1
            'Unload FRubros
            If VGDetalle(1) <> "" Then
                PMSubserv
                VLPaso% = True
            End If
            PMBuscarServicio 'busca los costos generales
            
       Case 1 'Oficina
            VGOperacion$ = "sp_oficina"
            PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(0).Text & "]") Then
                PMMapeaListaH sqlconn&, FCatalogo.lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(1).Text = VGACatalogo.Codigo$
                lblDescripcion(0).Caption = VGACatalogo.Descripcion$
            End If
            VLPaso% = True
        
        Case 2 'clientes
            FBuscarCliente.optCliente(0).Value = True
            FBuscarCliente.Show 1
            FBuscarCliente.optCliente(1).Enabled = True
            If VGBusqueda(1) <> "" Then
                txtCampo(2).Text = VGBusqueda(1)
                lblDescripcion(0).Caption = VGBusqueda(2) & " " & VGBusqueda(3) & " " & VGBusqueda(4)
            End If
            VLPaso% = True

        Case 3 'rubro
            PMCatalogo "A", "pe_rubro", txtCampo(2), lblDescripcion(2)
            'txtCampo(4).SetFocus
            VLPaso% = True
            
        Case 4
            PMCatalogo "A", "pe_tipo_dato", txtCampo(4), lblDescripcion(4)
            VLPaso% = True
            
      End Select

    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
If Index% <> 4 Then
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
Else
        If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 96) Or (KeyAscii > 123)) Then
            KeyAscii% = 0
        Else
            KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
        End If
End If
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
Dim VTR%
    If VLPaso% = False Then
      Select Case Index%
        Case 0 'ser disponible
                If VLPaso% = False Then
                    If txtCampo(0).Text <> "" Then
                       VGForma$ = "FPersoEspecial"
                       FAyudaSubserv2.Show 1
                       If VGDetalle(1) <> "" Then
                            PMSubserv
                       Else
                            If lblDescripcion(2).Caption = "" Then
                                txtCampo(0).Text = ""
                                txtCampo(0).SetFocus
                                VLPaso% = True
                            End If
                       End If
                    Else
                       VLPaso% = True
                       lblDescripcion(1).Caption = ""
                       lblDescripcion(2).Caption = ""
                       lblDescripcion(3).Caption = ""
                    End If
                End If
                PMBuscarServicio 'busca los costos generales
                
        Case 1 'oficina
            If txtCampo(1).Text <> "" Then
                PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
                PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCampo(1).Text)
                If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(0).Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(0)
                    PMChequea sqlconn&
                Else
                    VLPaso% = True
                    txtCampo(1).Text = ""
                    lblDescripcion(0).Caption = ""
                    txtCampo(1).SetFocus
                    'PMLimpiaGrid grdServicios
                End If
            Else
                'txtCampo(1).SetFocus
                lblDescripcion(0).Caption = ""
            End If
            
        Case 2 'cliente
                If txtCampo(2).Text <> "" Then
                    ReDim VTArreglo(7) As String
                    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1190"
                    PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4, (txtCampo(2).Text)
                    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_qrente", False, "Ok...Consulta de cliente") Then
                         VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
                         PMChequea sqlconn&
                         lblDescripcion(0).Caption = VTArreglo(1)
                    Else
                        txtCampo(2).Text = ""
                        lblDescripcion(0).Caption = ""
                    End If
                End If
           
        Case 4  'Tipo de dato
                If VLPaso% = False Then
                    If txtCampo(4).Text <> "" Then
                        PMCatalogo "V", "pe_tipo_dato", txtCampo(4), lblDescripcion(4)
                    Else
                        txtCampo(4).Text = ""
                        lblDescripcion(4).Caption = ""
                    End If
                End If

      End Select
    End If
End Sub

Sub PMBuscarServicio()
   Dim i%
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4086"
        PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(0).Text
        PMPasoValores sqlconn&, "@i_rubro", 0, SQLCHAR, lblDescripcion(3).Caption
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "C"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_costos_especiales", True, "Ok... Consulta de Detalle de Servicios Especiales") Then
            PMMapeaGrid sqlconn&, grdServicios(0), False
            PMChequea sqlconn&
        End If
        grdServicios(0).Row = 1
        grdServicios(0).ColWidth(1) = 1300
        grdServicios(0).ColWidth(6) = 1500
        grdServicios(0).ColWidth(4) = 1500
        grdServicios(0).ColWidth(5) = 1500
        For i% = 10 To 12
            grdServicios(0).ColWidth(i%) = 1
        Next i%
End Sub


