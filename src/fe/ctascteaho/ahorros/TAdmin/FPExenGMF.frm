VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#7.0#0"; "MhRealInput.ocx"
Begin VB.Form FPExenGMF 
   Caption         =   "Conceptos de Exención Gravamen Movimiento Financiero"
   ClientHeight    =   5850
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   9870
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5850
   ScaleWidth      =   9870
   Begin VB.TextBox txtcampo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   12
      Left            =   1770
      MaxLength       =   2
      TabIndex        =   35
      Top             =   2565
      Width           =   675
   End
   Begin VB.TextBox Txtdescripcionc 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   2460
      Locked          =   -1  'True
      MaxLength       =   64
      TabIndex        =   34
      Top             =   2565
      Width           =   6390
   End
   Begin VB.ComboBox CmbPers 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   1800
      Style           =   2  'Dropdown List
      TabIndex        =   3
      Tag             =   "4"
      Top             =   1350
      Width           =   2430
   End
   Begin Threed.SSFrame SSFrame5 
      Height          =   1230
      Left            =   120
      TabIndex        =   24
      Top             =   30
      Width           =   8730
      _Version        =   65536
      _ExtentX        =   15399
      _ExtentY        =   2170
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.ComboBox cmbTipo 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1680
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Tag             =   "2"
         Top             =   825
         Width           =   2445
      End
      Begin VB.TextBox txtnemo 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   7470
         MaxLength       =   5
         TabIndex        =   2
         Tag             =   "3"
         Top             =   840
         Width           =   1185
      End
      Begin VB.TextBox txtdescripcion 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1680
         MaxLength       =   65
         MultiLine       =   -1  'True
         TabIndex        =   0
         Tag             =   "1"
         Top             =   480
         Width           =   6975
      End
      Begin VB.Label lbletiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Producto :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   5
         Left            =   120
         TabIndex        =   30
         Top             =   900
         Width           =   900
      End
      Begin VB.Label lbletiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Nemonico :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   9
         Left            =   6420
         TabIndex        =   28
         Top             =   900
         Width           =   975
      End
      Begin VB.Label lbletiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Concepto:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   0
         Left            =   120
         TabIndex        =   27
         Top             =   180
         Width           =   885
      End
      Begin VB.Label lbletiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Descripcion:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   2
         Left            =   120
         TabIndex        =   26
         Top             =   525
         Width           =   1080
      End
      Begin VB.Label lblConcepto 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
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
         Height          =   240
         Left            =   1680
         TabIndex        =   25
         Top             =   225
         Width           =   1050
      End
   End
   Begin Threed.SSFrame txtCampotxtCampo 
      Height          =   585
      Left            =   6570
      TabIndex        =   23
      Tag             =   "9"
      Top             =   1920
      Width           =   2280
      _Version        =   65536
      _ExtentX        =   4022
      _ExtentY        =   1032
      _StockProps     =   14
      Caption         =   "Permite Otra Exenta"
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
      Begin Threed.SSOption optucta 
         Height          =   195
         Index           =   0
         Left            =   435
         TabIndex        =   8
         Tag             =   "11"
         Top             =   285
         Width           =   555
         _Version        =   65536
         _ExtentX        =   979
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Si"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSOption optucta 
         Height          =   195
         Index           =   1
         Left            =   1530
         TabIndex        =   21
         Tag             =   "12"
         Top             =   255
         Width           =   555
         _Version        =   65536
         _ExtentX        =   979
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "No"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Value           =   -1  'True
      End
   End
   Begin Threed.SSFrame SSFrame2 
      Height          =   555
      Left            =   6555
      TabIndex        =   22
      Tag             =   "5"
      Top             =   1335
      Width           =   2280
      _Version        =   65536
      _ExtentX        =   4022
      _ExtentY        =   979
      _StockProps     =   14
      Caption         =   "Titular"
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
      Begin Threed.SSOption opttitular 
         CausesValidation=   0   'False
         Height          =   195
         Index           =   0
         Left            =   420
         TabIndex        =   7
         Tag             =   "5"
         Top             =   285
         Width           =   495
         _Version        =   65536
         _ExtentX        =   873
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Si"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Value           =   -1  'True
      End
      Begin Threed.SSOption opttitular 
         CausesValidation=   0   'False
         Height          =   195
         Index           =   1
         Left            =   1515
         TabIndex        =   20
         Tag             =   "6"
         Top             =   270
         Width           =   555
         _Version        =   65536
         _ExtentX        =   979
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "No"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   600
      Left            =   75
      TabIndex        =   18
      Tag             =   "6"
      Top             =   1830
      Width           =   1710
      _Version        =   65536
      _ExtentX        =   3016
      _ExtentY        =   1058
      _StockProps     =   14
      Caption         =   "Tope"
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
      Begin Threed.SSOption opttope 
         CausesValidation=   0   'False
         Height          =   195
         Index           =   0
         Left            =   360
         TabIndex        =   4
         Tag             =   "7"
         Top             =   270
         Width           =   495
         _Version        =   65536
         _ExtentX        =   873
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Si"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSOption opttope 
         CausesValidation=   0   'False
         Height          =   315
         Index           =   1
         Left            =   1050
         TabIndex        =   19
         Tag             =   "8"
         Top             =   225
         Width           =   495
         _Version        =   65536
         _ExtentX        =   873
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "No"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Value           =   -1  'True
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8970
      TabIndex        =   10
      Tag             =   "4108"
      Top             =   870
      WhatsThisHelpID =   2001
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Si&guientes"
      ForeColor       =   0
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
      Picture         =   "FPExenGMF.frx":0000
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   2610
      Left            =   75
      TabIndex        =   16
      TabStop         =   0   'False
      Tag             =   "11"
      Top             =   3195
      Width           =   8790
      _Version        =   65536
      _ExtentX        =   15505
      _ExtentY        =   4604
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8970
      TabIndex        =   11
      Tag             =   "4102"
      Top             =   1650
      WhatsThisHelpID =   2030
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Crear"
      ForeColor       =   0
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
      Picture         =   "FPExenGMF.frx":001C
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   5
      Left            =   8970
      TabIndex        =   14
      Top             =   4275
      WhatsThisHelpID =   2003
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Limpiar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FPExenGMF.frx":0038
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   6
      Left            =   8970
      TabIndex        =   15
      Top             =   5055
      WhatsThisHelpID =   2008
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Salir"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FPExenGMF.frx":0054
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8970
      TabIndex        =   9
      Tag             =   "4108"
      Top             =   90
      WhatsThisHelpID =   2000
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Buscar"
      ForeColor       =   0
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
      Picture         =   "FPExenGMF.frx":0070
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8970
      TabIndex        =   13
      Tag             =   "4104"
      Top             =   3225
      Visible         =   0   'False
      WhatsThisHelpID =   2006
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Eliminar"
      ForeColor       =   0
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
      Picture         =   "FPExenGMF.frx":008C
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8970
      TabIndex        =   12
      Tag             =   "4103"
      Top             =   2430
      WhatsThisHelpID =   2031
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Actualizar"
      ForeColor       =   0
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
      Picture         =   "FPExenGMF.frx":00A8
   End
   Begin MhinrelLib.MhRealInput mskValor 
      Height          =   285
      Left            =   2865
      TabIndex        =   5
      Tag             =   "7"
      Top             =   2025
      Width           =   1605
      _Version        =   458753
      _ExtentX        =   2831
      _ExtentY        =   503
      _StockProps     =   205
      BackColor       =   12632256
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Enabled         =   0   'False
      FillColor       =   16777215
      MaxReal         =   3.4E+38
      MinReal         =   0
      SpinChangeReal  =   0
      AutoHScroll     =   -1  'True
      CaretColor      =   -2147483642
      CaretVisible    =   -1  'True
      DecimalPlaces   =   2
      Separator       =   -1  'True
   End
   Begin MhinrelLib.MhRealInput Msktasa 
      Height          =   285
      Left            =   5070
      TabIndex        =   6
      Tag             =   "8"
      Top             =   2040
      Width           =   915
      _Version        =   458753
      _ExtentX        =   1614
      _ExtentY        =   503
      _StockProps     =   205
      BackColor       =   12632256
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Enabled         =   -1  'True
      FillColor       =   16777215
      MaxReal         =   3.4E+38
      MinReal         =   0
      SpinChangeReal  =   0
      AutoHScroll     =   -1  'True
      CaretColor      =   -2147483642
      CaretVisible    =   -1  'True
      DecimalPlaces   =   3
      Separator       =   -1  'True
      TextRaw         =   "0.000"
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Otro Concepto :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   150
      TabIndex        =   33
      Top             =   2625
      Width           =   1365
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Tasa:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   4530
      TabIndex        =   32
      Top             =   2115
      Width           =   495
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Valor Tope:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   1830
      TabIndex        =   31
      Top             =   2115
      Width           =   1005
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo de Persona:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   120
      TabIndex        =   29
      Top             =   1425
      Width           =   1470
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Registros:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   13
      Left            =   90
      TabIndex        =   17
      Top             =   2970
      Width           =   870
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   75
      X2              =   8880
      Y1              =   2910
      Y2              =   2910
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8910
      X2              =   8910
      Y1              =   0
      Y2              =   9000
   End
End
Attribute VB_Name = "FPExenGMF"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*********************************************************
'   Archivo:        FPExenGMF.FRM
'   Producto:       terminal administrativa
'   Diseñado por:   Mauricio Zuluaga
'   Fecha de Documentación: 17/Abril/2007
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
' Forma: FBuscarGrupo
' Descripción: Esta forma permite el mantenimiento de conceptos de
'               exencion de gravamen del mov.Financiero (GMF)
' VARIABLES GLOBALES:
'           ServerName$         nombre del servidor
'           VGBusqueda()        arreglo global que guarda
'                               en forma temporal los campos
'                               del registro seleccionado
' MODULOS:
'           MHELPG.BAS = Rutinas para usar la ventana de ayuda
'*********************************************************
Option Explicit
Dim VTCol As Long
Dim VTRow As Long

Dim VLPaso As Integer
Dim VTRespuesta As Integer
Dim VLTope As String
Dim VLVrTope As Currency
Dim VLTasa As Double
Dim VLTitular As String
Dim VLUCta As String
Dim VLProd As String
Dim VLTipoP As String




Private Sub CmbPers_GotFocus()
   FPrincipal!pnlHelpLine.Caption = " Tipo de Persona"
End Sub

Private Sub cmbTipo_GotFocus()
   FPrincipal!pnlHelpLine.Caption = " Tipo de Producto"
End Sub

Private Sub Form_Load()
'*********************************************************
'Objetivo:  se establecen los parametros para acrgar la forma
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'17/Abril/2007  MZA         Emisión Inicial
'*********************************************************
     Me.Left = 15
     Me.Top = 15
     Me.Width = 9972
     Me.Height = 6324
    'CCB TIPO DE PRODUCTO
    cmbTipo.AddItem "CUENTA CORRIENTE", 0
    cmbTipo.AddItem "CUENTA DE AHORRO", 1
    cmbTipo.AddItem "AHORROS Y CORRIENTES", 2
    cmbTipo.ListIndex = 0
    'ccb tipo de persona
    CmbPers.AddItem "NATURAL", 0
    CmbPers.AddItem "JURIDICA", 1
    CmbPers.AddItem "NATURAL Y JURIDICA", 2
    CmbPers.ListIndex = 0
    PLLimpiar
    
    PMLoadResStrings Me
    PMLoadResIcons Me
End Sub

Private Sub cmdBoton_Click(Index As Integer)
'*********************************************************
'Objetivo:  Botones de control de la forma
'Input   :  Index% Indice del Boton
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'17/Abril/2007  MZA         Emisión Inicial
'*********************************************************
    Select Case Index%
    Case 0
        PLBuscar
    Case 1
        PLSgtes
    Case 2
        PLIngresar
    Case 3
        PLActualizar
    Case 4
        VTRespuesta% = MsgBox("Desea Eliminar la Transacción (S/N)", 4 + 16, "Transmision de Datos")
        If VTRespuesta = 6 Then
            PLEliminar
        End If
    Case 5
        PLLimpiar
    Case 6
        PLSalir
    End Select
End Sub
Private Sub PLBuscar()
'*********************************************************
'Objetivo:  rutina que consulta los primeros registros que existen
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'17/Abril/2007  MZA         Emisión Inicial
'*********************************************************
PMLimpiaG grdRegistros

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4108"
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "C"
PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
PMPasoValores sqlconn&, "@i_concepto", 0, SQLINT4&, "0"

 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_conc_ext_gmf", True, "Busqueda de Registros") Then
    PMMapeaGrid sqlconn&, grdRegistros, False
    PMChequea sqlconn&
    PLFormatear
    If grdRegistros.Tag = 20 Then
        cmdBoton(1).Enabled = True
    Else
        cmdBoton(1).Enabled = False
    End If
 Else
    PMChequea sqlconn&
 End If

End Sub
Private Sub PLSgtes()
'*********************************************************
'Objetivo:  rutina que consulta los sgtes registros que existen
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'17/Abril/2007  MZA         Emisión Inicial
'*********************************************************
PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4108"
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "C"
PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "1"

grdRegistros.Row = grdRegistros.Rows - 1
grdRegistros.Col = 1

PMPasoValores sqlconn&, "@i_concepto", 0, SQLINT4&, CInt(grdRegistros.Text)

 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_conc_ext_gmf", True, "Busqueda Sgtes. Registros") Then
    PMMapeaGrid sqlconn&, grdRegistros, True
    PMChequea sqlconn&
    PLFormatear
    If grdRegistros.Tag = 20 Then
        cmdBoton(1).Enabled = True
    Else
        cmdBoton(1).Enabled = False
    End If
Else
    PMChequea sqlconn&
End If

End Sub
Private Sub PLFormatear()
'*********************************************************
'Objetivo:  permite formatear el tamaño de las columnas del grid
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'17/Abril/2007  MZA         Emisión Inicial
'*********************************************************
    grdRegistros.ColWidth(1) = 800
    grdRegistros.ColWidth(2) = 5000
    grdRegistros.ColWidth(3) = 1000
    grdRegistros.ColWidth(4) = 800
    grdRegistros.ColWidth(5) = 1000
    grdRegistros.ColWidth(6) = 1000
    grdRegistros.ColWidth(7) = 1000
    grdRegistros.ColWidth(8) = 1000
    grdRegistros.ColWidth(9) = 1000
    grdRegistros.ColWidth(10) = 1000  'ccb nemonico
    grdRegistros.ColWidth(11) = 800  'ccb nemonico


End Sub
Private Sub PLIngresar()
'*********************************************************
'Objetivo:  rutina que adiciona registros a la tabla
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'17/Abril/2007  MZA         Emisión Inicial
'*********************************************************
If Not FMValidaEntradas() Then Exit Sub

 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4102"
 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
 PMPasoValores sqlconn&, "@i_descripc", 0, SQLVARCHAR, txtdescripcion.Text
 PMPasoValores sqlconn&, "@i_tope", 0, SQLCHAR, VLTope$
 If mskValor.Text = "" Then
    mskValor.Format = VGDecimales$
    mskValor.Text = Format$(0, VGDecimales$)
  End If
  PMPasoValores sqlconn&, "@i_vlr_tope", 0, SQLMONEY, (mskValor.Text)
 
 If Msktasa.Text = "" Then
    Msktasa.Format = VGDecimales$
    Msktasa.Text = Format$(0, VGDecimales$)
  End If
 PMPasoValores sqlconn&, "@i_tasa", 0, SQLFLT8, (Msktasa.Text)
 
 'ccb producto
 If cmbTipo.Text = "CUENTA CORRIENTE" Then
    PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "3"
 ElseIf cmbTipo.Text = "CUENTA DE AHORRO" Then
      PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
 Else
      PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "9"
 End If
'ccb tipo persona
 If CmbPers.Text = "NATURAL" Then
    PMPasoValores sqlconn&, "@i_tipo_per", 0, SQLCHAR, "P"
 ElseIf CmbPers.Text = "JURIDICA" Then
      PMPasoValores sqlconn&, "@i_tipo_per", 0, SQLCHAR, "C"
 Else
      PMPasoValores sqlconn&, "@i_tipo_per", 0, SQLCHAR, "Y"
 End If
 PMPasoValores sqlconn&, "@i_titular", 0, SQLCHAR, VLTitular$
 PMPasoValores sqlconn&, "@i_otra_exen", 0, SQLCHAR, VLUCta$
 PMPasoValores sqlconn&, "@i_desc_nemo", 0, SQLVARCHAR, txtnemo.Text
 PMPasoValores sqlconn&, "@i_otro_conc", 0, SQLINT2, txtcampo(12).Text
 
 
 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_conc_ext_gmf", True, "Ok... Creación de Conceptos") Then
    PMChequea sqlconn&
 Else
    PMChequea sqlconn&
End If
cmdBoton(2).Enabled = False      'Desactivar Boton crear
PLBuscar

End Sub
Private Sub PLActualizar()
'*********************************************************
'Objetivo:  rutina que Actualiza registros de la tabla
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'17/Abril/2007  MZA         Emisión Inicial
'*********************************************************
If Not FMValidaEntradas() Then Exit Sub

 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4103"
 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
 PMPasoValores sqlconn&, "@i_concepto", 0, SQLINT4, lblConcepto.Caption
 PMPasoValores sqlconn&, "@i_descripc", 0, SQLVARCHAR, txtdescripcion.Text
 If mskValor.Text = "" Then
    mskValor.Format = VGDecimales$
    mskValor.Text = Format$(0, VGDecimales$)
  End If
  PMPasoValores sqlconn&, "@i_vlr_tope", 0, SQLMONEY, (mskValor.Text)
 PMPasoValores sqlconn&, "@i_tope", 0, SQLCHAR, VLTope$
 'PMPasoValores sqlconn&, "@i_vlr_tope", 0, SQLMONEY, VLVrTope
 If Msktasa.Text = "" Then
    Msktasa.Format = VGDecimales$
    Msktasa.Text = Format$(0, VGDecimales$)
  End If
  PMPasoValores sqlconn&, "@i_tasa", 0, SQLFLT8, (Msktasa.Text)
  If cmbTipo.Text = "CUENTA CORRIENTE" Then
    PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "3"
  ElseIf cmbTipo.Text = "CUENTA DE AHORRO" Then
      PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
  Else
      PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "9"
 End If
 If CmbPers.Text = "NATURAL" Then
    PMPasoValores sqlconn&, "@i_tipo_per", 0, SQLCHAR, "P"
 ElseIf CmbPers.Text = "JURIDICA" Then
      PMPasoValores sqlconn&, "@i_tipo_per", 0, SQLCHAR, "C"
 Else
      PMPasoValores sqlconn&, "@i_tipo_per", 0, SQLCHAR, "Y"
 End If
 PMPasoValores sqlconn&, "@i_titular", 0, SQLCHAR, VLTitular$
 PMPasoValores sqlconn&, "@i_otra_exen", 0, SQLCHAR, VLUCta$
 PMPasoValores sqlconn&, "@i_desc_nemo", 0, SQLVARCHAR, txtnemo.Text
 PMPasoValores sqlconn&, "@i_otro_conc", 0, SQLINT2, txtcampo(12).Text
 
 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_conc_ext_gmf", True, "Ok... Eliminación transacción") Then
    PMChequea sqlconn&
 Else
    PMChequea sqlconn&
End If

PLBuscar

End Sub
Private Sub PLEliminar()
'*********************************************************
'Objetivo:  rutina que Elimina registros de la tabla
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'07/Feb/2007  MZA         Emisión Inicial
'*********************************************************
If Not FMValidaEntradas() Then Exit Sub

 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4104"
 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
 PMPasoValores sqlconn&, "@i_concepto", 0, SQLINT4, lblConcepto.Caption
 
 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_conc_ext_gmf", True, "Ok... Eliminación transacción") Then
    PMChequea sqlconn&
 Else
    PMChequea sqlconn&
End If

cmdBoton(4).Enabled = False      'Desactivar Boton Eliminar

'eliminar datos del doble clic en la pantalla
lblConcepto.Caption = ""
txtdescripcion.Text = ""
Txtdescripcionc.Text = ""
mskValor.Text = "0"
Msktasa.Text = "0"
txtnemo.Text = ""
txtcampo(12).Text = ""
cmbTipo.ListIndex = 0
CmbPers.ListIndex = 0
opttope(1).Value = True
opttitular(0).Value = True
optucta(1).Value = True
PLBuscar 'refresca grilla
End Sub
Function FMValidarNumero(parValor As String, parLongitud As Integer, parcaracter As Integer, parNemonico As String) As Integer

  Dim VTDecimal As Integer
  Dim VTSeparadorDecimal As String
  Const CGTeclaMenos% = 109

  VTSeparadorDecimal$ = "."

  VTDecimal% = 2
  If parcaracter% = CGTeclaMenos% Then
    'CHM 08-nov-99
    FMValidarNumero% = 0
    Exit Function
  End If

  If (VTDecimal% > 0) Then
      If (InStr(1, parValor, VTSeparadorDecimal$)) >= (parLongitud + (VTDecimal) + 1) Then
        FMValidarNumero% = 0
      Else
        FMValidarNumero% = parcaracter%
      End If
  Else
    If Len(parValor) >= parLongitud Then
      FMValidarNumero% = 0
    Else
      FMValidarNumero% = parcaracter%
    End If
  End If

End Function
'FIXIT: Declare 'FMValidaEntradas' with an early-bound data type                           FixIT90210ae-R1672-R1B8ZE
Function FMValidaEntradas() As Boolean
'*********************************************************
'Objetivo:  Funcion que valida y muestra los mensajes de error de
'           la forma cuando hacen falta datos
'
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                MODIFICACIONES
'FECHA              AUTOR              RAZON
'17/Abril/2007        MAZ            Emisión Inicial
'*********************************************************
    Dim Index As Integer
    FMValidaEntradas = False
   
    VLVrTope = mskValor.Text
    VLTasa = Msktasa.Text

   
    If Index% > 2 Then
        If lblConcepto.Caption = "" Then
            MsgBox "El campo Concepto es Obligatorio", 48, "Control de Ingreso de Datos"
            Exit Function
        End If
    End If
    
    If txtdescripcion.Text = "" Then
         MsgBox "El campo Descripción es Obligatorio", 48, "Control de Ingreso de Datos"
         txtdescripcion.SetFocus
         Exit Function
    End If
    
    If txtnemo.Text = "" Then
         MsgBox "El Campo Nemonico del Concepto es Obligatorio", 48, "Control concepto de Datos"
         txtnemo.SetFocus
         Exit Function
    End If
    
    
    If VLVrTope < 0 Then
         MsgBox "El campo Valor Tope debe ser mayor o igual a cero", 48, "Control de Ingreso de Datos"
         mskValor.SetFocus
         Exit Function
    End If

    If VLTasa < 0 Then
         MsgBox "El campo Valor Tasa debe ser mayor o igual a cero", 48, "Control de Ingreso de Datos"
         Msktasa.SetFocus
         Exit Function
    End If
    
    If VLTasa > 100 Then
         MsgBox "El campo Valor Tasa debe estar entre 0 y 100", 48, "Control de Ingreso de Datos"
         Msktasa.SetFocus
         Exit Function
    End If
    
    If opttope(0).Value = True Then
       VLTope$ = "S"
    Else
       VLTope$ = "N"
    End If
    
    If optucta(0).Value = True Then
       VLUCta$ = "S"
    Else
       VLUCta$ = "N"
    End If
   
    
'    If VLTope$ = "S" Then
'        If VLVrTope = 0 Then
'         MsgBox "El tope esta marcado como si, el valor del tope debe ser mayor a cero", 48, "Control de Ingreso de Datos"
'         mskValor.SetFocus
'         Exit Function
'        End If
'    End If
    
    
'    If optucta(0).Value = True And txtcampo(12).Text = "" Then
'         MsgBox "Permite otra exenta,debe ingresar el Otro concepto", 48, "Control otro concepto"
'         txtcampo(12).SetFocus
'         Exit Function
'    End If
    '--Valida si requiere titular
    If opttitular(0).Value = True Then
       VLTitular$ = "S"
    Else
       VLTitular$ = "N"
    End If
    
    '--Valida si es unica cta.
    
    FMValidaEntradas = True
    Exit Function
    
End Function
Private Sub PLLimpiar()
'*********************************************************
'Objetivo:  rutina que limpia la informacion de la pantalla
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'17/Abril/2007  MZA         Emisión Inicial
'*********************************************************
Dim i As Integer
lblConcepto.Caption = ""
txtdescripcion.Text = ""
VLTope$ = ""
VLVrTope = 0
mskValor.Text = "0"
VLTasa = 0
Msktasa.Text = "0"
VLTitular$ = ""
VLUCta$ = ""
VLProd$ = ""
VLTipoP$ = ""
txtnemo.Text = "" 'ccb
cmbTipo.ListIndex = 0
CmbPers.ListIndex = 0
'opttope(1).Value = True
opttope(0).Value = False
opttope(1).Value = True
opttitular(0).Value = True
opttitular(1).Value = False
optucta(1).Value = True
txtcampo(12).Text = ""
Txtdescripcionc.Text = ""
txtcampo(12).Enabled = False
PMLimpiaG grdRegistros
cmdBoton(1).Enabled = False      'Desactiva  Boton sgtes
cmdBoton(2).Enabled = True       'Activa     Boton crear
cmdBoton(3).Enabled = False      'Desactivar Boton Actualizar
cmdBoton(4).Enabled = False      'Desactivar Boton Eliminar
For i% = 0 To 4
    PMObjetoSeguridad cmdBoton(i%)
Next i%
End Sub
Private Sub grdRegistros_Click()
'*********************************************************
'Objetivo:  captura los datos cunado se da click
'
'
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                MODIFICACIONES
'*********************************************************
'FECHA                  AUTOR              RAZON
'11/Noviembre/2005      MAZ            Emisión Inicial
'*********************************************************
    VTCol = grdRegistros.Col
    VTRow = grdRegistros.Row
    
    If VTRow > 0 And grdRegistros.Text <> "" Then
        cmdBoton(2).Enabled = False     'desactivar el ingreso
        PMObjetoSeguridad cmdBoton(3)   'Activar Boton Actualizar
        PMObjetoSeguridad cmdBoton(4)   'Activar Boton Eliminar
'        cmdBoton(3).Enabled = True      'Activar Boton Actualizar
'        cmdBoton(4).Enabled = True      'Activar Boton Eliminar
        
        PMLineaG grdRegistros           'Resalta la linea
        
        grdRegistros.Row = VTRow
        
        grdRegistros.Col = 1
        lblConcepto.Caption = grdRegistros.Text
        
        grdRegistros.Col = 2
        txtdescripcion.Text = grdRegistros.Text
        
        grdRegistros.Col = 3
        VLTope$ = grdRegistros.Text
        opttope(0).Value = IIf(grdRegistros.Text = "S", True, False)
        opttope(1).Value = IIf(grdRegistros.Text = "N", True, False)
        
        grdRegistros.Col = 4
        VLVrTope = CCur(grdRegistros.Text)
        mskValor = VLVrTope
        
        grdRegistros.Col = 5
        VLTasa = CDbl(grdRegistros.Text)
        Msktasa = VLTasa
        
        grdRegistros.Col = 6  'PRODUCTO
        VLProd$ = grdRegistros.Text
        Select Case VLProd$
           Case "3" 'ccb corrientes
           cmbTipo.ListIndex = 0
           Case "4" 'ahorros
           cmbTipo.ListIndex = 1
           Case "9" 'ambas
           cmbTipo.ListIndex = 2
        End Select
        
        grdRegistros.Col = 7  'TIPO PERSONA
        VLTipoP$ = grdRegistros.Text
         Select Case VLTipoP$
           Case "N"  'ccb natural
           CmbPers.ListIndex = 0
           Case "C" 'ccb compañia
           CmbPers.ListIndex = 1
           Case "Y" 'ccb ambas
           CmbPers.ListIndex = 2
        End Select
        
        grdRegistros.Col = 8
        VLTitular$ = grdRegistros.Text
        opttitular(0).Value = IIf(grdRegistros.Text = "S", True, False)
        opttitular(1).Value = IIf(grdRegistros.Text = "N", True, False)
        
        grdRegistros.Col = 9
        VLUCta$ = grdRegistros.Text
        optucta(0).Value = IIf(grdRegistros.Text = "S", True, False)
        optucta(1).Value = IIf(grdRegistros.Text = "N", True, False)
        
        grdRegistros.Col = 10 'ccb nemonico
        txtnemo.Text = grdRegistros.Text
        
        grdRegistros.Col = 11 'ccb codigo otro concepto
        txtcampo(12).Text = grdRegistros.Text
        Call txtCampo_LostFocus(12)
    End If
    
End Sub
Private Sub PLSalir()
'*********************************************************
'Objetivo:  Establece las instrucciones necesarias para salir de la forma
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'07/Feb/2007  MZA         Emisión Inicial
'*********************************************************
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
    Unload Me

End Sub
'FIXIT: Declare 'FMVAlidaTipoDato' with an early-bound data type                           FixIT90210ae-R1672-R1B8ZE
Function FMVAlidaTipoDato(TipoDato As String, valor As Integer) As Integer
'*********************************************************
'Objetivo:  funcion que valida cualquier tipo de dato
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'07/Feb/2007  MZA         Emisión Inicial
'*********************************************************
    FMVAlidaTipoDato = valor%
    Select Case TipoDato$
    Case "N"
        If (valor% <> 8) And ((valor% < 48) Or (valor% > 57)) Then
            FMVAlidaTipoDato = 0
        End If
    Case "A"
        If (valor% <> 8) And ((valor% < 65) Or (valor% > 90)) And ((valor% < 97) Or (valor% > 122)) Then
            FMVAlidaTipoDato = 0
        Else
            FMVAlidaTipoDato = Asc(UCase$(Chr$(valor%)))
        End If
    Case "S"
        If (valor% = 32) Then
            FMVAlidaTipoDato = 0
        Else
            FMVAlidaTipoDato = Asc(UCase$(Chr$(valor%)))
        End If
    Case "B"
        FMVAlidaTipoDato = Asc(UCase$(Chr$(valor%)))
    Case "M"
        If (valor% <> 8) And (valor% <> 46) And ((valor% < 48) Or (valor% > 57)) Then
            FMVAlidaTipoDato = 0
        End If
    End Select
End Function
Private Sub mskTasa_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Valor Tasa"
    Msktasa.SelStart = 0
    Msktasa.SelLength = Len(mskValor.Text)
End Sub
Private Sub Msktasa_KeyPress(KeyAscii As Integer)
    If VGDecimales$ = "#,##0" Then
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    Else
        If (KeyAscii% <> 8) And (KeyAscii% <> 46) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    End If
    KeyAscii = FMValidarNumero((Msktasa.Text), 3, KeyAscii, "105")

End Sub

Private Sub mskValor_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Valor del Tope"
    mskValor.SelStart = 0
    mskValor.SelLength = Len(mskValor.Text)
End Sub

Private Sub mskValor_KeyPress(KeyAscii As Integer)
    If VGDecimales$ = "#,##0" Then
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    Else
        If (KeyAscii% <> 8) And (KeyAscii% <> 46) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    End If
    KeyAscii = FMValidarNumero((mskValor.Text), 13, KeyAscii, "105")
End Sub









Private Sub opttitular_GotFocus(Index As Integer)
    FPrincipal!pnlHelpLine.Caption = " Titular"
End Sub

Private Sub opttope_Click(Index As Integer, Value As Integer)
Select Case Index%
 Case 0
       mskValor.Enabled = True
 Case 1
      mskValor.Text = ""
      mskValor.Enabled = False
End Select
End Sub

Private Sub opttope_GotFocus(Index As Integer)
  FPrincipal!pnlHelpLine.Caption = " Manejo de Tope"
End Sub

Private Sub optucta_Click(Index As Integer, Value As Integer)
  If optucta(1).Value = True Then 'N
     txtcampo(12).Enabled = False
     txtcampo(12).Text = ""
     Txtdescripcionc.Text = ""
  Else
     txtcampo(12).Enabled = True
  End If
End Sub

Private Sub optucta_GotFocus(Index As Integer)
    FPrincipal!pnlHelpLine.Caption = " Otra Exenta"
End Sub

Private Sub txtCampo_Change(Index As Integer)
Select Case Index%
Case 12
    VLPaso% = False
End Select
End Sub
Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
 If Keycode = VGTeclaAyuda% Then
   Select Case Index%
    Case 12    'Req. 453, 711  -- ccb
           VGOperacion$ = ""
           PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "F"
           PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4105" '"2927"
           PMPasoValores sqlconn&, "@i_cuenta", 0, SQLINT2, "0"
           If cmbTipo.Text = "CUENTA CORRIENTE" Then
               PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "3"
            ElseIf cmbTipo.Text = "CUENTA DE AHORRO" Then
               PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
            Else
               PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "9"
            End If
           VGOperacion$ = "sp_exencion"
           'If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_calcula_gmf", True, " Ok... Consulta de agencias") Then
           If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_calcula_gmf", True, " Ok... Consulta de agencias") Then
              PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, True 'False
              PMChequea sqlconn&
              VLPaso% = True
              FCatalogo.Show 1
              txtcampo(12).Text = VGACatalogo.Codigo$
              Txtdescripcionc.Text = VGACatalogo.Descripcion$
           End If
    End Select
  End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
Select Case Index%
    Case 12
        KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
Dim VTR1 As Integer
Dim VLTipoPer As String
Dim VLUnicTit As String
Dim VLOtraEx As String
Select Case Index%
    Case 12    'Req. 453, 711  --CRT
      If VLPaso% = False Then
        If txtcampo(12).Text <> "" Then
           PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "B"
           PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4105" '"2927"
           PMPasoValores sqlconn&, "@i_cuenta", 0, SQLINT2, txtcampo(12).Text
           If cmbTipo.Text = "CUENTA CORRIENTE" Then
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "3"
            ElseIf cmbTipo.Text = "CUENTA DE AHORRO" Then
               PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
            Else
               PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "9"
            End If
           'If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_calcula_gmf", True, " Ok... Consulta de agencias") Then
           If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_calcula_gmf", True, " Ok... Consulta de agencias") Then
              ReDim VTArreglo(5) As String
              VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
              PMChequea sqlconn&
              Txtdescripcionc = VTArreglo(1)
              VLTipoPer = VTArreglo(2)
              VLUnicTit = VTArreglo(3)
              VLOtraEx = VTArreglo(4)
           Else
              Txtdescripcionc.Text = ""
              txtcampo(12).Text = ""
           End If
        Else
              Txtdescripcionc.Text = ""
        End If
      End If
  End Select
End Sub

Private Sub txtdescripcion_GotFocus()
     FPrincipal!pnlHelpLine.Caption = " Descripción"
End Sub

Private Sub txtdescripcion_KeyPress(KeyAscii As Integer)
'alfabetico y numerico sin caractares especiales
    If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 96) Or (KeyAscii > 123)) Then
        KeyAscii% = 0
    Else
        KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
    End If
End Sub

Private Sub txtnemo_GotFocus()
  FPrincipal!pnlHelpLine.Caption = "Nemonico del Tipo de Concepto "
End Sub

Private Sub txtnemo_KeyPress(KeyAscii As Integer)
  KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
End Sub

