VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#7.0#0"; "MhRealInput.ocx"
Begin VB.Form Ftran2797 
   Caption         =   "Consulta Registro de Operaciones en Efectivo "
   ClientHeight    =   6345
   ClientLeft      =   75
   ClientTop       =   525
   ClientWidth     =   9270
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   6345
   ScaleWidth      =   9270
   Tag             =   "2797"
   Begin VB.Frame Frame1 
      Height          =   4410
      Left            =   105
      TabIndex        =   25
      Top             =   -45
      Width           =   8190
      Begin MhinrelLib.MhRealInput MhRealValor 
         Height          =   288
         Index           =   1
         Left            =   4344
         TabIndex        =   4
         Top             =   800
         Width           =   1668
         _Version        =   458753
         _ExtentX        =   2942
         _ExtentY        =   508
         _StockProps     =   205
         ForeColor       =   16777215
         BackColor       =   16777215
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Appearance      =   1
         BorderStyle     =   0
         FillColor       =   16777215
         Text            =   "0.0000"
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         Separator       =   -1  'True
      End
      Begin MhinrelLib.MhRealInput MhRealValor 
         Height          =   288
         Index           =   0
         Left            =   1332
         TabIndex        =   3
         Top             =   800
         Width           =   1668
         _Version        =   458753
         _ExtentX        =   2942
         _ExtentY        =   508
         _StockProps     =   205
         ForeColor       =   16777215
         BackColor       =   16777215
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Appearance      =   1
         BorderStyle     =   0
         FillColor       =   16777215
         Text            =   "0.0000"
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         Separator       =   -1  'True
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Beneficiario"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   195
         Index           =   3
         Left            =   255
         TabIndex        =   12
         Top             =   2745
         Width           =   1635
      End
      Begin VB.CheckBox ChkFiltros 
         Caption         =   "[No] Filtros Especiales"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   210
         Left            =   4350
         TabIndex        =   5
         Top             =   1152
         Width           =   3000
      End
      Begin VB.ComboBox cmbTipo 
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
         Height          =   252
         Index           =   1
         ItemData        =   "ftra2797.frx":0000
         Left            =   5148
         List            =   "ftra2797.frx":0002
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   45
         Top             =   4248
         Visible         =   0   'False
         Width           =   2580
      End
      Begin VB.ComboBox cmbTipo 
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
         Index           =   2
         ItemData        =   "ftra2797.frx":0004
         Left            =   4185
         List            =   "ftra2797.frx":0006
         Sorted          =   -1  'True
         TabIndex        =   44
         Text            =   "cmbTipo"
         Top             =   4248
         Visible         =   0   'False
         Width           =   780
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Titular de la cuenta"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   195
         Index           =   2
         Left            =   240
         TabIndex        =   16
         Top             =   3420
         Width           =   2190
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Persona en nombre de quien se realiza la transacción"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   195
         Index           =   1
         Left            =   255
         TabIndex        =   9
         Top             =   2088
         Width           =   4965
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Persona que realizó la transacción"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   195
         Index           =   0
         Left            =   240
         TabIndex        =   6
         Top             =   1440
         Width           =   3360
      End
      Begin VB.Frame Frame2 
         Height          =   930
         Index           =   2
         Left            =   108
         TabIndex        =   38
         Top             =   3384
         Width           =   7992
         Begin VB.TextBox txtNomCta 
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
            Left            =   3255
            MaxLength       =   40
            TabIndex        =   48
            Top             =   600
            Width           =   4404
         End
         Begin VB.ComboBox cmbTipo 
            Appearance      =   0  'Flat
            Enabled         =   0   'False
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
            Index           =   0
            ItemData        =   "ftra2797.frx":0008
            Left            =   2244
            List            =   "ftra2797.frx":000A
            Sorted          =   -1  'True
            Style           =   2  'Dropdown List
            TabIndex        =   17
            Top             =   264
            Width           =   2445
         End
         Begin VB.TextBox Ide 
            Enabled         =   0   'False
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
            Left            =   2244
            Locked          =   -1  'True
            MaxLength       =   15
            TabIndex        =   19
            Top             =   600
            Width           =   1000
         End
         Begin MSMask.MaskEdBox mskCuenta 
            Height          =   288
            Left            =   5532
            TabIndex        =   18
            Top             =   264
            Width           =   2112
            _ExtentX        =   3731
            _ExtentY        =   503
            _Version        =   393216
            Enabled         =   0   'False
            MaxLength       =   24
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            PromptChar      =   "_"
         End
         Begin VB.Label lblEtiqueta 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "No. Cta"
            Enabled         =   0   'False
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
            Index           =   14
            Left            =   4785
            TabIndex        =   43
            Top             =   300
            Width           =   660
         End
         Begin VB.Label Label6 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Prod."
            Enabled         =   0   'False
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
            Left            =   1140
            TabIndex        =   42
            Top             =   300
            Width           =   465
         End
         Begin VB.Label Label7 
            Appearance      =   0  'Flat
            Caption         =   "Cliente"
            Enabled         =   0   'False
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
            Height          =   168
            Index           =   2
            Left            =   1140
            TabIndex        =   39
            Top             =   576
            Width           =   1032
         End
      End
      Begin VB.Frame Frame2 
         Height          =   612
         Index           =   1
         Left            =   108
         TabIndex        =   35
         Top             =   2076
         Width           =   7992
         Begin VB.ComboBox cmbide 
            Appearance      =   0  'Flat
            Enabled         =   0   'False
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
            Index           =   1
            Left            =   1560
            TabIndex        =   10
            TabStop         =   0   'False
            Top             =   240
            Width           =   855
         End
         Begin MSMask.MaskEdBox Maskpers_ced_nit 
            Height          =   285
            Index           =   1
            Left            =   3780
            TabIndex        =   11
            Top             =   255
            Width           =   1170
            _ExtentX        =   2064
            _ExtentY        =   503
            _Version        =   393216
            Enabled         =   0   'False
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            PromptChar      =   "_"
         End
         Begin VB.Label Label6 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            Caption         =   "Identificación"
            Enabled         =   0   'False
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
            Left            =   2550
            TabIndex        =   37
            Top             =   300
            Width           =   1170
         End
         Begin VB.Label Label7 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            Caption         =   "Tipo"
            Enabled         =   0   'False
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
            Left            =   1095
            TabIndex        =   36
            Top             =   315
            Width           =   390
         End
      End
      Begin VB.Frame Frame2 
         Height          =   612
         Index           =   0
         Left            =   108
         TabIndex        =   28
         Top             =   1404
         Width           =   7992
         Begin VB.ComboBox cmbide 
            Appearance      =   0  'Flat
            Enabled         =   0   'False
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
            Index           =   0
            Left            =   1548
            TabIndex        =   7
            TabStop         =   0   'False
            Top             =   240
            Width           =   852
         End
         Begin MSMask.MaskEdBox Maskpers_ced_nit 
            Height          =   285
            Index           =   0
            Left            =   3780
            TabIndex        =   8
            Top             =   240
            Width           =   1170
            _ExtentX        =   2064
            _ExtentY        =   503
            _Version        =   393216
            Enabled         =   0   'False
            MaxLength       =   14
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            PromptChar      =   "_"
         End
         Begin VB.Label Label7 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            Caption         =   "Tipo"
            Enabled         =   0   'False
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
            Left            =   1065
            TabIndex        =   34
            Top             =   315
            Width           =   390
         End
         Begin VB.Label Label6 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            Caption         =   "Identificación"
            Enabled         =   0   'False
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
            Left            =   2520
            TabIndex        =   33
            Top             =   285
            Width           =   1170
         End
      End
      Begin VB.TextBox txtOficRecep 
         BeginProperty DataFormat 
            Type            =   1
            Format          =   "0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   9226
            SubFormatType   =   1
         EndProperty
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
         Left            =   1332
         MaxLength       =   5
         TabIndex        =   0
         Top             =   168
         Width           =   615
      End
      Begin MSMask.MaskEdBox mskFechaIni 
         Height          =   288
         Left            =   1332
         TabIndex        =   1
         Top             =   480
         Width           =   1668
         _ExtentX        =   2937
         _ExtentY        =   503
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskFechaFin 
         Height          =   288
         Left            =   4344
         TabIndex        =   2
         Top             =   480
         Width           =   1668
         _ExtentX        =   2937
         _ExtentY        =   503
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         PromptChar      =   "_"
      End
      Begin MSGrid.Grid grdProductos 
         Height          =   252
         Left            =   3600
         TabIndex        =   41
         Top             =   3924
         Visible         =   0   'False
         Width           =   252
         _Version        =   65536
         _ExtentX        =   450
         _ExtentY        =   450
         _StockProps     =   77
         ForeColor       =   16777215
         BackColor       =   16777215
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
      Begin VB.Frame Frame2 
         Height          =   612
         Index           =   3
         Left            =   108
         TabIndex        =   46
         Top             =   2724
         Width           =   7992
         Begin VB.ComboBox cmbide 
            Appearance      =   0  'Flat
            Enabled         =   0   'False
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
            Index           =   3
            Left            =   1575
            TabIndex        =   13
            TabStop         =   0   'False
            Top             =   225
            Width           =   855
         End
         Begin MSMask.MaskEdBox Maskpers_ced_nit 
            Height          =   285
            Index           =   3
            Left            =   3765
            TabIndex        =   15
            Top             =   210
            Width           =   1170
            _ExtentX        =   2064
            _ExtentY        =   503
            _Version        =   393216
            Enabled         =   0   'False
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            PromptChar      =   "_"
         End
         Begin VB.Label Label7 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            Caption         =   "Tipo"
            Enabled         =   0   'False
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
            Left            =   1095
            TabIndex        =   47
            Top             =   240
            Width           =   390
         End
         Begin VB.Label Label6 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            Caption         =   "Identificación"
            Enabled         =   0   'False
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
            Left            =   2565
            TabIndex        =   14
            Top             =   255
            Width           =   1170
         End
      End
      Begin VB.Label lblOfiRecep 
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
         Height          =   288
         Left            =   1944
         TabIndex        =   40
         Top             =   168
         Width           =   6048
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Valor Final"
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
         Left            =   3150
         TabIndex        =   32
         Top             =   825
         Width           =   915
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Valor inicial"
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
         Left            =   135
         TabIndex        =   31
         Top             =   825
         Width           =   1005
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Fecha Final"
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
         Left            =   3150
         TabIndex        =   30
         Top             =   510
         Width           =   1005
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Fecha Inicial"
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
         Left            =   135
         TabIndex        =   29
         Top             =   510
         Width           =   1110
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Oficina"
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
         Left            =   135
         TabIndex        =   27
         Top             =   225
         Width           =   615
      End
   End
   Begin MSGrid.Grid grdChequeras 
      Height          =   1785
      Left            =   75
      TabIndex        =   26
      Top             =   4500
      Width           =   8220
      _Version        =   65536
      _ExtentX        =   14499
      _ExtentY        =   3154
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
      Index           =   3
      Left            =   8385
      TabIndex        =   24
      Top             =   5520
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
      Picture         =   "ftra2797.frx":000C
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8385
      TabIndex        =   23
      Top             =   4755
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
      Picture         =   "ftra2797.frx":0028
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8385
      TabIndex        =   20
      Top             =   30
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
      Picture         =   "ftra2797.frx":0044
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8385
      TabIndex        =   21
      Top             =   810
      WhatsThisHelpID =   2001
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Sig&tes."
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
      Picture         =   "ftra2797.frx":0060
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   765
      Index           =   4
      Left            =   8385
      TabIndex        =   22
      Top             =   1590
      WhatsThisHelpID =   2500
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1349
      _StockProps     =   78
      Caption         =   "*&Excel"
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
      Picture         =   "ftra2797.frx":007C
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   45
      X2              =   8315
      Y1              =   4410
      Y2              =   4410
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8340
      X2              =   8340
      Y1              =   0
      Y2              =   6410
   End
End
Attribute VB_Name = "Ftran2797"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
Dim VLPaso1 As Integer
Dim VLPaso As Integer
Dim VLTipoCuenta As String
Dim VLFormatoFecha As String
Dim VTProducto$
Dim VLProducto$
Dim VLoficial$
Dim VGCliente As Double
Dim pers1_ced_nit$
Dim VLTced As String
Dim VLPApe$
Dim VLSApe$
Dim VLNomb$

'FIXIT: Declare JTA'Index' with an early-bound data type                                      FixIT90210ae-R1672-R1B8ZE
Private Sub PLBuscar(Index As Integer)
        
        Dim VLregistros As Integer
        
        VLregistros = grdChequeras.Rows - 1
        
        'If VLregistros = grdchequeras.Rows - 1 Then
        '    cmdBoton(Index).Enabled = True
        '    cmdBoton(0).Enabled = False
        '    txtOficRecep.Enabled = True
        '    mskFechaIni.Enabled = True
        '    mskFechaFin.Enabled = True
        '    MhRealValor(0).Enabled = True
        '    MhRealValor(1).Enabled = True
        '    'Option1(0).Enabled = True
        '    'Option1(1).Enabled = True
        '    'Option1(2).Enabled = True
        '    ChkFiltros.Enabled = True
        '    ChkFiltros.Value = 0
        '    Exit Sub
        'End If
        
        PMChequea sqlconn&
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2796"
        If Index = 1 Then
            PMPasoValores sqlconn&, "@i_modo", 0, SQLINT4, "1"
        Else
            grdChequeras.Row = grdChequeras.Rows - 1
            grdChequeras.Col = 31
            PMPasoValores sqlconn&, "@i_modo", 0, SQLINT4, "0"
            PMPasoValores sqlconn&, "@i_consecutivo", 0, SQLINT4, grdChequeras.Text
            grdChequeras.Col = 0
            PMPasoValores sqlconn&, "@i_pivote", 0, SQLINT4, grdChequeras.Text
        End If
        PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT4, txtOficRecep.Text
        PMPasoValores sqlconn&, "@i_fecha_fin", 0, SQLDATETIME, FMConvFecha((mskFechaFin), VLFormatoFecha$, "mm/dd/yyyy")
        PMPasoValores sqlconn&, "@i_fecha_ini", 0, SQLDATETIME, FMConvFecha((mskFechaIni), VLFormatoFecha$, "mm/dd/yyyy")
        PMPasoValores sqlconn&, "@i_valor_inicial", 0, SQLMONEY, MhRealValor(0).Text
        PMPasoValores sqlconn&, "@i_valor_final", 0, SQLMONEY, MhRealValor(1).Text
        If Option1(0).Value Then
            PMPasoValores sqlconn&, "@i_accion", 0, SQLINT4, "0"
            PMPasoValores sqlconn&, "@i_tipo_doc_e", 0, SQLVARCHAR, cmbide(0).Text
            PMPasoValores sqlconn&, "@i_cedula_e", 0, SQLVARCHAR, Maskpers_ced_nit(0).ClipText
        ElseIf Option1(1).Value Then
            PMPasoValores sqlconn&, "@i_accion", 0, SQLINT4, "1"
            PMPasoValores sqlconn&, "@i_tipo_doc_t", 0, SQLVARCHAR, cmbide(1).Text
            PMPasoValores sqlconn&, "@i_cedula_t", 0, SQLVARCHAR, Maskpers_ced_nit(1).ClipText
        ElseIf Option1(2).Value Then
            PMPasoValores sqlconn&, "@i_accion", 0, SQLINT4, "2"
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, cmbTipo(1).Text
            PMPasoValores sqlconn&, "@i_iden", 0, SQLVARCHAR, Ide.Text
            PMPasoValores sqlconn&, "@i_numcta", 0, SQLVARCHAR, mskCuenta.ClipText
        ElseIf Option1(3).Value Then
            PMPasoValores sqlconn&, "@i_accion", 0, SQLINT4, "3"
            PMPasoValores sqlconn&, "@i_num_doc_benef", 0, SQLVARCHAR, Maskpers_ced_nit(3).ClipText
            PMPasoValores sqlconn&, "@i_tipo_doc_benef", 0, SQLVARCHAR, cmbide(3).Text
        End If
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_control_efectivo", True, " Ok... Datos Registrados") Then
            If Index = 0 Then
               PMMapeaGrid sqlconn&, grdChequeras, True
               
            Else
               PMMapeaGrid sqlconn&, grdChequeras, False
               cmdBoton(0).Enabled = True
            End If
            PMChequea sqlconn&
            If VLregistros = grdChequeras.Rows - 1 Then
                MsgBox "FIN CONSULTA. NO se retornaron mas datos"
                cmdBoton(1).Enabled = True
                cmdBoton(0).Enabled = False
                txtOficRecep.Enabled = True
                mskFechaIni.Enabled = True
                mskFechaFin.Enabled = True
                MhRealValor(0).Enabled = True
                MhRealValor(1).Enabled = True
                ChkFiltros.Enabled = True
                ChkFiltros.Value = 0
                Exit Sub
            End If
        End If
End Sub


Private Sub ChkFiltros_Click()
If ChkFiltros.Value = vbOK Then
    ChkFiltros.Caption = "[Si] Filtros Especiales"
    PLHabilitarFiltros (True)
Else
    ChkFiltros.Caption = "[No] Filtros Especiales"
    PLHabilitarFiltros (False)
End If
End Sub


Private Sub ChkFiltros_GotFocus()
         FPrincipal!pnlHelpLine.Caption = " Activar Filtro de Consulta"
End Sub

Private Sub cmbide_Click(Index As Integer)
    Select Case cmbide(Index).Text
            Case "CC"
                Maskpers_ced_nit(Index).Mask = "##-###-###"
                Maskpers_ced_nit(Index).MaxLength = 8
            Case "TI"
                Maskpers_ced_nit(Index).Mask = "######-#####"
                Maskpers_ced_nit(Index).MaxLength = 11
            Case "CE"
                Maskpers_ced_nit(Index).Mask = "###-###"
                Maskpers_ced_nit(Index).MaxLength = 6
            Case "NI"
                Maskpers_ced_nit(Index).Mask = "###-###-###-#"
                Maskpers_ced_nit(Index).MaxLength = 10
            Case "PA"
                Maskpers_ced_nit(Index).Format = ""
                
                Maskpers_ced_nit(Index).Mask = ""
                Maskpers_ced_nit(Index).Text = ""
                Maskpers_ced_nit(Index).MaxLength = 14
            Case Else
                Maskpers_ced_nit(Index).Format = ""
                Maskpers_ced_nit(Index).Mask = ""
                Maskpers_ced_nit(Index).Text = ""
                Maskpers_ced_nit(Index).MaxLength = 14
    End Select
    Maskpers_ced_nit(Index).SetFocus
End Sub

Private Sub cmbide_GotFocus(Index As Integer)
    FPrincipal!pnlHelpLine.Caption = " Tipo de Identificación"
    VLTipoCuenta$ = cmbide(Index).Text
End Sub

Private Sub cmbide_KeyPress(Index As Integer, KeyAscii As Integer)
    Dim sendKey As String
    Select Case Index%
        Case 0
            If KeyAscii% = Asc("+") Then
                sendKey = "{TAB}"
                KeyAscii% = 0
                Exit Sub
            End If
            If KeyAscii% = Asc("-") Then
                sendKey = "+{TAB}"
                KeyAscii% = 0
                Exit Sub
            End If
        Case 1
            If KeyAscii% = Asc("+") Then
                sendKey = "{TAB}"
                KeyAscii% = 0
                Exit Sub
            End If
            If KeyAscii% = Asc("-") Then
                sendKey = "+{TAB}"
                KeyAscii% = 0
                Exit Sub
            End If
    End Select

End Sub

Private Sub cmbTipo_Click(Index As Integer)
    Select Case Index%
        Case 0
            mskCuenta.Mask = ""
            mskCuenta.Text = ""
            txtNomCta.Text = ""
            VGCliente = 0
            Ide.Text = ""
            If cmbTipo(0) <> "CUENTA CORRIENTE" And cmbTipo(0) <> "CUENTA DE AHORROS" Then
               txtNomCta.Locked = False
               Ide.Locked = False
            Else
               If cmbTipo(0).Text = "CUENTA CORRIENTE" Then
                  mskCuenta.Mask = VGMascaraCtaCte$
               ElseIf cmbTipo(0).Text = "CUENTA DE AHORROS" Then
                      mskCuenta.Mask = VGMascaraCtaAho$
               End If
               txtNomCta.Locked = True
               Ide.Locked = True
            End If
            VLPaso% = True

            If cmbTipo(0) = "CUENTA CORRIENTE" Or cmbTipo(0) = "CUENTA DE AHORROS" Or cmbTipo(0) = "CLIP" Then
                lblEtiqueta(14).Caption = " No. Cta."
            Else
                lblEtiqueta(14).Caption = " No. Ope."
            End If
            cmbTipo(1).ListIndex = cmbTipo(0).ListIndex
            VTProducto$ = cmbTipo(1).Text
            cmbTipo(2).ListIndex = cmbTipo(0).ListIndex
            VLProducto$ = cmbTipo(2).Text
    End Select

End Sub


Private Sub cmbTipo_GotFocus(Index As Integer)
    FPrincipal!pnlHelpLine.Caption = " Tipo Producto"
End Sub

Private Sub cmbTipo_KeyPress(Index As Integer, KeyAscii As Integer)
    Dim sendKey As String
    Select Case Index%
        Case 0
            If KeyAscii% = Asc("+") Then
                sendKey = "{TAB}"
                KeyAscii% = 0
                Exit Sub
            End If
            If KeyAscii% = Asc("-") Then
                sendKey = "+{TAB}"
                KeyAscii% = 0
                Exit Sub
            End If
        Case 1
            If KeyAscii% = Asc("+") Then
                sendKey = "{TAB}"
                KeyAscii% = 0
                Exit Sub
            End If
            If KeyAscii% = Asc("-") Then
                sendKey = "+{TAB}"
                KeyAscii% = 0
                Exit Sub
            End If
    End Select
End Sub


Private Sub cmdBoton_Click(Index As Integer)

Select Case Index

Case 0
    If PLValida_Campos Then
        PLBuscar Index
    End If
Case 1
    If PLValida_Campos Then
        PLBuscar Index
        grdChequeras.SetFocus
    End If
    'If grdChequeras.Rows >= 9 Then
    '    cmdBoton(Index).Enabled = False
    '    cmdBoton(0).Enabled = True

    '    txtOficRecep.Enabled = False
    '    mskFechaIni.Enabled = False
    '    mskFechaFin.Enabled = False
    '    MhRealValor(0).Enabled = False
    '    MhRealValor(1).Enabled = False
    '    Option1(0).Enabled = False
    '    Option1(1).Enabled = False
    '    Option1(2).Enabled = False
    '    ChkFiltros.Enabled = False
    'End If
Case 2
    PLLimpiar
Case 3
    PLSalir
Case 4
    PLExcel
End Select

End Sub

Private Sub Form_Load()
    Dim VFecha1 As String
    Dim VTR1 As Integer
    
    Ftran2797.Left = 15
    Ftran2797.Top = 15
    Ftran2797.Width = 9390
    Ftran2797.Height = 6850
    Dim VTModo As Integer
    Dim VLModo As Integer
    VTModo = False '20 Primeros
    VLModo = 0
    VLProducto = 0
    Do While 1 = 1
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "15029"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, VLModo
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1&, VLProducto
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "R"
        PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP$
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_producto", True, " Ok... Consulta de Productos") Then
           PMMapeaGrid sqlconn&, grdProductos, VTModo%
           PMChequea sqlconn&
           If Val(grdProductos.Tag) >= VGMaximoRows - 1 Then
              grdProductos.Col = 1
              grdProductos.Row = grdProductos.Rows - 1
              VLProducto = grdProductos.Text
              VTModo% = True '20 Siguientes
              VLModo = 1
           Else
              Exit Do
           End If
        Else
           Exit Do
        End If
    Loop
    
    grdProductos.Row = 0
    Dim i As Integer
    Dim j As Integer
    Dim VLAbrv As String
    j = 0
    If Val(grdProductos.Tag) > 0 Then
    For i = 1 To grdProductos.Rows - 1
       grdProductos.Row = i
       grdProductos.Col = 4
       VLAbrv = grdProductos.Text
       If VLAbrv = "CTE" Or VLAbrv = "AHO" Or VLAbrv = "CCA" Or VLAbrv = "CEX" Or _
          VLAbrv = "TES" Or VLAbrv = "ATX" Or VLAbrv = "PFI" Or VLAbrv = "GAR" Or _
          VLAbrv = "CRE" Or VLAbrv = "SBA" Or VLAbrv = "SAC" Or VLAbrv = "BON" Or _
          VLAbrv = "ACH" Then
          grdProductos.Col = 3
          cmbTipo(0).AddItem grdProductos.Text, j
          grdProductos.Col = 1
          cmbTipo(1).AddItem grdProductos.Text, j
          grdProductos.Col = 4
          cmbTipo(2).AddItem grdProductos.Text, j
          j = j + 1
       End If
    Next i
    Else
    Exit Sub
    End If
    
    cmbide(0).AddItem "CC", 0
    cmbide(0).AddItem "TI", 1
    cmbide(0).AddItem "CE", 2
    cmbide(0).AddItem "NI", 3
    cmbide(0).AddItem "PA", 4
    cmbide(0).AddItem "N", 5
    cmbide(0).AddItem "S", 6
    cmbide(1).AddItem "CC", 0
    cmbide(1).AddItem "TI", 1
    cmbide(1).AddItem "CE", 2
    cmbide(1).AddItem "NI", 3
    cmbide(1).AddItem "PA", 4
    cmbide(1).AddItem "N", 5
    cmbide(1).AddItem "S", 6
    cmbide(3).AddItem "CC", 0
    cmbide(3).AddItem "TI", 1
    cmbide(3).AddItem "CE", 2
    cmbide(3).AddItem "NI", 3
    cmbide(3).AddItem "PA", 4
    cmbide(3).AddItem "N", 5
    cmbide(3).AddItem "S", 6
    VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
    mskFechaIni.Mask = FMMascaraFecha(VLFormatoFecha$) 'MVA'
    mskFechaIni.Text = VGFecha$
    mskFechaFin.Mask = FMMascaraFecha(VLFormatoFecha$) 'MVA'
    mskFechaFin.Text = VGFecha$
    VFecha1$ = FMConvFecha((mskFechaIni.Text), VLFormatoFecha$, VLFormatoFecha$) 'MVA'
    VFecha1$ = FMConvFecha((mskFechaFin.Text), VLFormatoFecha$, VLFormatoFecha$) 'MVA'
    
    mskCuenta.Mask = VGMascaraCtaCte$
    mskFechaIni.MaxLength = 14
    mskFechaFin.MaxLength = 14
    cmbTipo(0).ListIndex = 0
    
    
    txtOficRecep.Text = VGOficina$
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, 1572
    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT4, (txtOficRecep.Text)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_oficina", True, " Consulta de la oficina " & "[" & txtOficRecep.Text & "]") Then
        ReDim VLDatosOficina(20) As String
        VTR1% = FMMapeaArreglo(sqlconn&, VLDatosOficina())
        lblOfiRecep.Caption = VLDatosOficina(5)
        PMChequea sqlconn&
    End If
    
    VLPaso1% = True
    PLHabilitarFiltros (False)
    
    PMLoadResStrings Me
    PMLoadResIcons Me
    
    
End Sub


Private Sub Ide_Change()
    VLPaso% = False
End Sub

Private Sub Ide_GotFocus()
   If Ide.Locked = False Then
    If VGCliente <> 0 Then Ide.Text = VGCliente
    FPrincipal!pnlHelpLine.Caption = " Código del cliente [F5 Ayuda]"
    Label7(2).Caption = "Código Cliente:"
    Ide.SelStart = 0
    Ide.SelLength = Len(Ide.Text)
   End If
End Sub


Private Sub Ide_KeyDown(Keycode As Integer, Shift As Integer)
    Dim txtDir As String
    Dim Ideuno As String
    If Keycode = VGTeclaAyuda% Then
        Ide.Text = ""
        txtDir = ""
        VGCliente = 0
        VLPaso% = True
        FBuscarCliente.Show 1
        If VGBusqueda(1) <> "" Then
            VGCliente = CDbl(VGBusqueda(1))
            If VGBusqueda(0) = "P" Then
              Ideuno = VGBusqueda(5)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
              VLPApe$ = Trim(VGBusqueda(2))
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
              VLSApe$ = Trim(VGBusqueda(3))
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
              VLNomb$ = Trim(VGBusqueda(4))
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
              VLTced$ = Trim(VGBusqueda(6))
            Else
              Ideuno = VGBusqueda(3)
            End If
            If Len(Ideuno) = 8 Then
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                Ide = Mid(Ideuno, 1, 2) + "-" + Mid(Ideuno, 3, 3) + "-" + Mid(Ideuno, 6, 3)
            ElseIf Len(Ideuno) = 11 Then
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                Ide = Mid(Ideuno, 1, 6) + "-" + Mid(Ideuno, 7, 5)
            ElseIf Len(Ideuno) = 6 Then
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                Ide = Mid(Ideuno, 1, 3) + "-" + Mid(Ideuno, 4, 3)
            ElseIf Len(Ideuno) = 10 Then
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                Ide = Mid(Ideuno, 1, 3) + "-" + Mid(Ideuno, 4, 3) + "-" + Mid(Ideuno, 7, 3) + "-" + Mid(Ideuno, 10, 1)
                Else
                  Ide = Ideuno 'Mid(Ideuno, 1, 3) + "-" + Mid(Ideuno, 4, 3) + "-" + Mid(Ideuno, 7, 3) + "-" + Mid(Ideuno, 10, 3)
                  VLTced$ = "NA"
                  pers1_ced_nit$ = "NA"
            End If
            VLPaso% = True
            If Ide.Text <> VGBusqueda(3) Then
                PLLimpiaObjOption (1)
                PLLimpiaObjOption (2)
            End If
            Label7(2).Caption = "Numero Identificación:"
            Ide.Text = Ideuno 'VGBusqueda(3)
        Else
            Ide.Text = ""
            Label7(2).Caption = "Cód Cliente:"
            VLPaso% = True
        End If
    End If
End Sub


Private Sub Ide_KeyPress(KeyAscii As Integer)
   If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
      KeyAscii% = 0
   End If
End Sub


Private Sub Ide_LostFocus()
    Dim txtDir As String
    Dim VTR1 As Integer
    Dim txtGerente As String
    Dim LenIdeuno As String
    Dim Ideuno As String
    
    If VLPaso% = False And Ide.Locked = False Then
       txtDir = ""
       VGCliente = 0
       If Ide.Text <> "" Then
          PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
          PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, (Ide.Text)
          PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2543"
          If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_desc_cliente_cc", True, " Ok... Consulta del cliente " & "[" & Ide.Text & "]") Then
             ReDim VTValores(10) As String
             VTR1% = FMMapeaArreglo(sqlconn&, VTValores())
             PMChequea sqlconn&
             VGCliente = CDbl(Ide.Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
             VLoficial$ = Trim(VTValores(4))
             txtGerente = VLoficial$
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
             VLTced$ = Trim(VTValores(5))
             If VLTced$ = "CC" Then
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
                VLNomb$ = Trim(VTValores(6))
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
                VLPApe$ = Trim(VTValores(7))
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
                VLSApe$ = Trim(VTValores(8))
             Else
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
                VLNomb$ = Trim(VTValores(2))
                VLPApe$ = ""
                VLSApe$ = ""
             End If
             
             Select Case VLTced$
             Case "CC"
                LenIdeuno = 8
             Case "TI"
                LenIdeuno = 11
             Case "CE"
                LenIdeuno = 6
             Case "NI"
                LenIdeuno = 10
             Case "PA"
                LenIdeuno = 14
             Case Else
                LenIdeuno = 14
             End Select
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'String' function with 'String$' function                                  FixIT90210ae-R9757-R1B8ZE
             Ideuno$ = String(Abs(LenIdeuno - Len(Trim(VTValores(1)))), " ") + Trim(VTValores(1))
                                               
             If LenIdeuno = 8 Then
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                Ide = Mid(Ideuno$, 1, 2) + "-" + Mid(Ideuno$, 3, 3) + "-" + Mid(Ideuno$, 6, 3)
             ElseIf LenIdeuno = 11 Then
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                Ide = Mid(Ideuno$, 1, 6) + "-" + Mid(Ideuno$, 7, 5)
             ElseIf LenIdeuno = 6 Then
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                Ide = Mid(Ideuno$, 1, 3) + "-" + Mid(Ideuno$, 4, 3)
             ElseIf LenIdeuno = 10 Then
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                Ide = Mid(Ideuno$, 1, 3) + "-" + Mid(Ideuno$, 4, 3) + "-" + Mid(Ideuno$, 7, 3) + "-" + Mid(Ideuno$, 10, 1)
             ElseIf LenIdeuno = 14 Then
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                Ide = Mid(Ideuno$, 1, 14)
                Else
                  Ide = Ideuno$ 'Mid(Ideuno$, 1, 3) + "-" + Mid(Ideuno$, 4, 3) + "-" + Mid(Ideuno$, 7, 3) + "-" + Mid(Ideuno$, 10, 3)
                  VLTced$ = "NA"
                  pers1_ced_nit$ = "NA"
             End If
             Ide = Trim$(Ide)
             Label7(2).Caption = "Numero Identificación:"
          Else
             Ide.Text = ""
             Ide.SetFocus
             Label7(2).Caption = "Código Cliente:"
          End If
          VLPaso% = True
       End If
    End If
End Sub

Private Sub Maskpers_ced_nit_GotFocus(Index As Integer)
    FPrincipal!pnlHelpLine.Caption = " Identificación"
End Sub

Private Sub MhRealValor_GotFocus(Index As Integer)
   Select Case Index
        Case 0
             FPrincipal!pnlHelpLine.Caption = " Saldo Inicial"
        Case 1
            FPrincipal!pnlHelpLine.Caption = " Saldo Final"
   End Select
End Sub

Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub


Private Sub mskCuenta_LostFocus()
    Dim leedir As Integer
    Dim VLExcSipla As String
    
    leedir = 0
    On Error Resume Next
    If cmbTipo(0) <> "CUENTA CORRIENTE" And cmbTipo(0) <> "CUENTA DE AHORROS" Then
       txtNomCta.Locked = False
       Ide.Locked = False
    Else
       txtNomCta.Locked = True
       Ide.Locked = True
       If mskCuenta.ClipText <> "" Then
          If cmbTipo(0) = "CUENTA CORRIENTE" Then
             VLProducto$ = "CTE"
             If FMChequeaCtaCte((mskCuenta.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "16"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                'DGO PMPasoValores SqlConn&, "@i_cta", 0, SQLVARCHAR, VGCtaNueva  'Se envía el número de cuenta nuevo. MZS 09/09/97
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                PMPasoValores sqlconn&, "@i_cerrada", 0, SQLCHAR, "C"
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                    PMMapeaObjeto sqlconn&, txtNomCta
                    PMChequea sqlconn&
                    leedir = 1
                Else
                    mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                    txtNomCta.Text = ""
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta corriente está incorrecto", 0 + 16, "Mensaje de Error"
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                txtNomCta.Text = ""
                Exit Sub
            End If
      Else
        If cmbTipo(0) = "CUENTA DE AHORROS" Then
          VLProducto$ = "AHO"
          If FMChequeaCtaAho((mskCuenta.ClipText)) Then
              PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
              PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
              'DGO PMPasoValores SqlConn&, "@i_cta", 0, SQLVARCHAR, VGCtaNueva  'Se envía el número de cuenta nuevo. MZS 09/09/97
              PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
              If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                  PMMapeaObjeto sqlconn&, txtNomCta
                  PMChequea sqlconn&
                  leedir = 1
              Else
                mskCuenta.Mask = ""
                mskCuenta.Text = ""
                mskCuenta.Mask = VGMascaraCtaCte$
              End If
          Else
              MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
              cmdBoton_Click (1)
              mskCuenta.SetFocus
                  txtNomCta.Text = ""
              Exit Sub
          End If
        End If
      End If
    End If
      'Validación de Cliente exceptuado de Sipla'
      VLExcSipla$ = "N"
      PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "2733"
      PMPasoValores sqlconn&, "@i_producto", 0, SQLCHAR, VLProducto$
      PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
      PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
      PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
      If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_query_excep_sipla", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
         PMMapeaVariable sqlconn&, VLExcSipla$
         PMChequea sqlconn&
      End If
      If VLExcSipla$ = "S" Then
        MsgBox "Cliente EXCEPTUADO de llenar Formulario de Mayor Cuantia"
        PLLimpiar
        Exit Sub
      End If
            
        If leedir = 1 Then
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2669"
            PMPasoValores sqlconn&, "@i_tipo_con", 0, SQLINT1, 1
            PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VTProducto$
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_control_efectivo", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                PMMapeaObjeto sqlconn&, Ide
                PMChequea sqlconn&
                leedir = 0
            End If
        Else
            PLLimpiaObjOption (1)
            PLLimpiaObjOption (2)
        End If
    End If
End Sub

Private Sub mskFechaFin_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Fecha Final [dd/mm/yyyy]"
End Sub

Private Sub mskFechaFin_LostFocus()
  Dim VTValido As Integer
  If mskFechaFin.ClipText <> "" Then
        VTValido% = FMVerFormato((mskFechaFin.FormattedText), VLFormatoFecha$)
        If Not VTValido% Then
            MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
             mskFechaFin.SetFocus
            Exit Sub
        End If
  End If
End Sub

Private Sub mskFechaIni_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Fecha Inicial [dd/mm/yyyy]"
End Sub

Private Sub mskFechaIni_LostFocus()
  Dim VTValido As Integer
  If mskFechaIni.ClipText <> "" Then
        VTValido% = FMVerFormato((mskFechaIni.FormattedText), VLFormatoFecha$)
        If Not VTValido% Then
            MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
             mskFechaIni.SetFocus
            Exit Sub
        End If
  End If

End Sub


Private Sub Option1_Click(Index As Integer)
PLLimpiaObjOption (Index)
End Sub


Private Sub Option1_GotFocus(Index As Integer)
    Select Case Index
        Case 0
             FPrincipal!pnlHelpLine.Caption = " Persona que realizó la transacción"
        Case 1
             FPrincipal!pnlHelpLine.Caption = " Persona en nombre de quien se realiza la transacción"
        Case 2
             FPrincipal!pnlHelpLine.Caption = " Titular de la cuenta"
        Case 3
             FPrincipal!pnlHelpLine.Caption = " Beneficiario"
    End Select
End Sub

Private Sub txtOficRecep_Change()
'*********************************************************
'Objetivo:  Indica que el campo ha cambiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'25/Abr/05  Y.Martinez  emisión Inicial
'*********************************************************
    VLPaso% = False
End Sub


Private Sub txtOficRecep_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Código de la Oficina Solicitante [F5 Ayuda]"
    txtOficRecep.SelStart = 0
    txtOficRecep.SelLength = Len(txtOficRecep.Text)
End Sub


Private Sub txtOficRecep_KeyDown(Keycode As Integer, Shift As Integer)
    If Keycode% = VGTeclaAyuda% Then
       VLPaso% = True
       VGOperacion$ = "sp_oficina"
       PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
       PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
       If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtOficRecep.Text & "]") Then
          PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
          PMChequea sqlconn&
          FCatalogo.Show 1
          txtOficRecep.Text = VGACatalogo.Codigo$
          lblOfiRecep.Caption = VGACatalogo.Descripcion$
       End If
       If Trim$(txtOficRecep.Text) = "" Then
          txtOficRecep.SetFocus
       End If
       VLPaso% = True
    End If
End Sub


Private Sub txtOficRecep_KeyPress(KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
End Sub


Private Sub txtOficRecep_LostFocus()
If txtOficRecep.Text <> "" Then
If CLng(txtOficRecep) > 32760 Then
     MsgBox "Valor excede el máximo permitido", 0 + 16, "Mensaje de Error"
     txtOficRecep.Text = ""
     txtOficRecep.SetFocus
 End If
   PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
   PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
   PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtOficRecep.Text)
   If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtOficRecep.Text & "]") Then
      PMMapeaObjeto sqlconn&, lblOfiRecep
      PMChequea sqlconn&
      
   Else
      VLPaso% = True
      txtOficRecep.Text = ""
      lblOfiRecep.Caption = ""
      If txtOficRecep.Enabled = True Then
         txtOficRecep.SetFocus
      End If
      lblOfiRecep.Caption = ""
   End If
Else
   lblOfiRecep.Caption = ""
End If
End Sub

Public Sub PLSalir()
Unload Me
End Sub

Function PLValida_Campos() As Boolean
PLValida_Campos = False
If txtOficRecep = "" Then
    MsgBox "Es Obligatorio Ingrezar Una Oficina", vbInformation, "Cons.Tran.Efec. Contrlo Datos"
    txtOficRecep.SetFocus
    Exit Function
End If
If mskFechaIni.ClipText = "" Then
    MsgBox "Es Obligatorio Ingrezar Una Fecha Inicial", vbInformation, "Cons.Tran.Efec. Contrlo Datos"
    mskFechaIni.SetFocus
    Exit Function
End If
If mskFechaFin.ClipText = "" Then
    MsgBox "Es Obligatorio Ingrezar Una Fecha Final", vbInformation, "Cons.Tran.Efec. Contrlo Datos"
    mskFechaFin.SetFocus
    Exit Function
End If

If Val(MhRealValor(1)) <= 0 Then
    MsgBox "Es Obligatorio Ingrezar Un Valor Final", vbInformation, "Cons.Tran.Efec. Contrlo Datos"
    MhRealValor(1).SetFocus
    Exit Function
End If

If Option1(0).Value Then
    If cmbide(0).Text = "" Then
        MsgBox "Es Obligatorio Ingrezar el tipo de identificacion para la opcion: " + Chr(13) + "Persona que realizó la transacción ", vbInformation, "Cons.Tran.Efec. Contrlo Datos"
        cmbide(0).SetFocus
        Exit Function
    End If
    If Maskpers_ced_nit(0).ClipText = "" Then
        MsgBox "Es Obligatorio Ingrezar el numero de identificacion para la opcion: " + Chr(13) + "Persona en nombre de quien se realiza la transaccón", vbInformation, "Cons.Tran.Efec. Contrlo Datos"
        Maskpers_ced_nit(0).SetFocus
        Exit Function
    End If
ElseIf Option1(1).Value Then
    If cmbide(1).Text = "" Then
        MsgBox "Es Obligatorio Ingrezar el tipo de identificacion para la opcion: " + Chr(13) + "Persona que realizó la transacción ", vbInformation, "Cons.Tran.Efec. Contrlo Datos"
        cmbide(1).SetFocus
        Exit Function
    End If
    If Maskpers_ced_nit(1).ClipText = "" Then
        MsgBox "Es Obligatorio Ingrezar el numero de identificacion para la opcion: " + Chr(13) + "Persona en nombre de quien se realiza la transaccón", vbInformation, "Cons.Tran.Efec. Contrlo Datos"
        Maskpers_ced_nit(1).SetFocus
        Exit Function
    End If
ElseIf Option1(2).Value Then
    If Ide.Text = "" Then
        MsgBox "Es Obligatorio Ingrezar el numero de identificacion para la opcion: " + Chr(13) + "Titular de la Cuenta", vbInformation, "Cons.Tran.Efec. Contrlo Datos"
        Ide.SetFocus
        Exit Function
    End If
ElseIf Option1(3).Value Then
    If cmbide(3).Text = "" Then
        MsgBox "Es Obligatorio Ingrezar el tipo de identificacion para la opcion: " + Chr(13) + "Beneficiario ", vbInformation, "Cons.Tran.Efec. Contrlo Datos"
        cmbide(3).SetFocus
        Exit Function
    End If
    If Maskpers_ced_nit(3).ClipText = "" Then
        MsgBox "Es Obligatorio Ingrezar el numero de identificacion para la opcion: " + Chr(13) + "Beneficiario ", vbInformation, "Cons.Tran.Efec. Contrlo Datos"
        Maskpers_ced_nit(3).SetFocus
        Exit Function
    End If
End If

PLValida_Campos = True
End Function

'FIXIT: Declare JTA'Index' with an early-bound data type                                      FixIT90210ae-R1672-R1B8ZE
Public Sub PLLimpiaObjOption(Index As Integer)
Dim i As Integer
For i = 0 To 3
    If i <> Index Then
        Select Case i
        Case 0
            cmbide(i).Text = ""
            Maskpers_ced_nit(i).Mask = ""
            Maskpers_ced_nit(i).Text = ""
            Frame2(i).Enabled = False
            Label6(i).Enabled = False
            Label7(i).Enabled = False
        Case 1
            cmbide(i).Text = ""
            Maskpers_ced_nit(i).Mask = ""
            Maskpers_ced_nit(i).Text = ""
            cmbide(i).Enabled = False
            Maskpers_ced_nit(i).Enabled = False
            Frame2(i).Enabled = False
            Label6(i).Enabled = False
            Label7(i).Enabled = False
        Case 2
            txtNomCta.Text = ""
            mskCuenta.Mask = ""
            mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
            mskCuenta.Enabled = False
            Ide.Text = ""
            Ide.Enabled = False
            cmbTipo(0).Enabled = False
            Frame2(i).Enabled = False
            Label6(i).Enabled = False
            Label7(i).Enabled = False
            lblEtiqueta(14).Enabled = False
        Case 3
            cmbide(i).Text = ""
            Maskpers_ced_nit(i).Mask = ""
            Maskpers_ced_nit(i).Text = ""
            cmbide(i).Enabled = False
            Maskpers_ced_nit(i).Enabled = False
            Frame2(i).Enabled = False
            Label6(i).Enabled = False
            Label7(i).Enabled = False
        End Select
    Else
        Select Case i
        Case 0
            Frame2(i).Enabled = True
            cmbide(i).Enabled = True
            Maskpers_ced_nit(i).Enabled = True
            Label6(i).Enabled = True
            Label7(i).Enabled = True
        Case 1
            Frame2(i).Enabled = True
            cmbide(i).Enabled = True
            Maskpers_ced_nit(i).Enabled = True
            Label6(i).Enabled = True
            Label7(i).Enabled = True
        Case 2
            Frame2(i).Enabled = True
            Ide.Enabled = True
            Label6(i).Enabled = True
            Label7(i).Enabled = True
            lblEtiqueta(14).Enabled = True
            cmbTipo(0).Enabled = True
            mskCuenta.Enabled = True
            mskCuenta.Mask = VGMascaraCtaCte$
        Case 3
            
            Frame2(i).Enabled = True
            cmbide(i).Enabled = True
            Maskpers_ced_nit(i).Enabled = True
            Label6(i).Enabled = True
            Label7(i).Enabled = True
        End Select
    End If
Next i
End Sub

Public Sub PLLimpiar()
    Dim VFecha1 As String
    txtOficRecep = ""
    mskFechaIni.Mask = FMMascaraFecha(VLFormatoFecha$) 'MVA'
    mskFechaIni.Text = VGFecha$
    mskFechaFin.Mask = FMMascaraFecha(VLFormatoFecha$) 'MVA'
    mskFechaFin.Text = VGFecha$
    VFecha1$ = FMConvFecha((mskFechaIni.Text), VLFormatoFecha$, VLFormatoFecha$) 'MVA'
    VFecha1$ = FMConvFecha((mskFechaFin.Text), VLFormatoFecha$, VLFormatoFecha$) 'MVA'
    mskFechaIni.MaxLength = 14
    mskFechaFin.MaxLength = 14
    MhRealValor(0) = 0
    MhRealValor(1) = 0
    cmdBoton(1).Enabled = True
    cmdBoton(0).Enabled = False
    txtOficRecep.Enabled = True
    mskFechaIni.Enabled = True
    mskFechaFin.Enabled = True
    MhRealValor(0).Enabled = True
    MhRealValor(1).Enabled = True
    PLHabilitarFiltros (False)
    ChkFiltros.Enabled = True
    ChkFiltros.Value = 0
    lblOfiRecep = ""
    
     PMLimpiaGrid grdChequeras
End Sub

'FIXIT: Declare JTA 'valor' with an early-bound data type                                      FixIT90210ae-R1672-R1B8ZE
Public Sub PLHabilitarFiltros(valor As Boolean)
    
cmbide(0).Text = ""
Maskpers_ced_nit(0).Mask = ""
Maskpers_ced_nit(0).Text = ""

cmbide(1).Text = ""
Maskpers_ced_nit(1).Mask = ""
Maskpers_ced_nit(1).Text = ""

txtNomCta.Text = ""
Ide.Text = ""
mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
mskCuenta.Enabled = False
    
cmbide(3).Text = ""
Maskpers_ced_nit(3).Mask = ""
Maskpers_ced_nit(3).Text = ""

If valor Then
    Option1(0).Value = True
    PLLimpiaObjOption (0)
    
    Option1(0).Enabled = True
    Option1(0).Value = False
    Option1(1).Enabled = True
    Option1(1).Value = False
    Option1(2).Enabled = True
    Option1(2).Value = False
    Option1(3).Enabled = True
    Option1(3).Value = False
Else
    Option1(0).Value = True
    PLLimpiaObjOption (0)
    Option1(0).Value = False
    Option1(0).Enabled = False
    Option1(1).Value = False
    Option1(1).Enabled = False
    Option1(2).Value = False
    Option1(2).Enabled = False
    Option1(3).Value = False
    Option1(3).Enabled = False
End If
            
cmbide(0).Enabled = False
Maskpers_ced_nit(0).Enabled = False
Label6(0).Enabled = False
Label7(0).Enabled = False
            
End Sub

Private Sub PLExcel()
    Dim Nombre_hoja As String
    If txtOficRecep.Text = "" Then
        MsgBox " Debe Existir una Oficina Receptora"
        txtOficRecep.SetFocus
        Exit Sub
    End If
     
    Nombre_hoja$ = "Operaciones en Efectivo_" + txtOficRecep.Text
     
    If Me.grdChequeras.Cols > 2 Then
        GeneraDatosGrid_Excel Me.grdChequeras, Nombre_hoja$
    Else
        MsgBox "No hay datos en la Grilla", vbCritical, "ERROR"
    End If
End Sub

Sub GeneraDatosGrid_Excel(grilla As Grid, svTitulo As String)
On Local Error GoTo ErrGeneraDatos_Excel
Dim XlsApl As Excel.Application
Dim xlsLibro As Excel.Workbook
Dim xlhoja As Excel.Worksheet
Dim Fil As Integer, Col As Integer
Dim nlTimer As Long

nlTimer = Timer

Set XlsApl = New Excel.Application
XlsApl.Visible = True
XlsApl.Caption = svTitulo

With XlsApl
    .Workbooks.Add
    Set xlsLibro = .ActiveWorkbook
    Set xlhoja = xlsLibro.Worksheets.Add
    xlhoja.Name = svTitulo
    
    With xlsLibro.Worksheets(svTitulo)
        .Activate
        For Fil = 0 To grilla.Rows - 1
            grilla.Row = Fil
            For Col = 1 To grilla.Cols - 1
                grilla.Col = Col
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
                .Cells(Fil + 1, Col) = UCase(grilla.Text)
            Next
            If Fil = 0 Then
                .Rows("1:1").Select
                With XlsApl.Selection.Interior
                    .ColorIndex = 37
                    .Pattern = xlSolid
                End With
                XlsApl.Selection.Font.Bold = True
                XlsApl.Selection.Borders(xlInsideVertical).LineStyle = xlNone
                XlsApl.Cells.Select
                XlsApl.Range("E1").Activate
                XlsApl.Cells.EntireColumn.AutoFit
            End If
        Next
   End With
End With

XlsApl.Selection.Borders(xlInsideVertical).LineStyle = xlNone
XlsApl.Cells.Select
XlsApl.Range("E1").Activate
XlsApl.Cells.EntireColumn.AutoFit


Exit Sub
ErrGeneraDatos_Excel:
    MsgBox Err.Number & " - " & Err.Description, vbInformation
    Resume Next
End Sub


