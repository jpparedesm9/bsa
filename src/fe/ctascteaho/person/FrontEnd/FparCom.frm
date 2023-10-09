VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{9AED8C43-3F39-11D1-8BB4-0000C039C248}#2.0#0"; "txtin.ocx"
Object = "{DECFDD03-1E4B-11D1-B65E-0000C039C248}#5.0#0"; "mskedit.ocx"
Begin VB.Form FParCom 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Parametrización Comisiones "
   ClientHeight    =   10710
   ClientLeft      =   30
   ClientTop       =   420
   ClientWidth     =   10785
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7.437
   ScaleMode       =   0  'User
   ScaleWidth      =   7.49
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame3 
      Caption         =   "Detalle Cobro Comisión"
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
      Height          =   1455
      Left            =   30
      TabIndex        =   41
      Top             =   2760
      Width           =   8295
      Begin MSGrid.Grid grdParamCobCom 
         Height          =   1095
         Left            =   120
         TabIndex        =   42
         Top             =   240
         Width           =   8085
         _Version        =   65536
         _ExtentX        =   14261
         _ExtentY        =   1931
         _StockProps     =   77
         BackColor       =   16777215
      End
   End
   Begin VB.Frame FraTransaccion 
      Caption         =   "Información Comisión por Transacción"
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
      ForeColor       =   &H000000FF&
      Height          =   1695
      Left            =   0
      TabIndex        =   38
      Top             =   4200
      Width           =   8295
      Begin MskeditLib.MaskInBox mskMonto 
         Height          =   300
         Left            =   3180
         TabIndex        =   11
         Top             =   1230
         Width           =   1080
         _Version        =   262144
         _ExtentX        =   1905
         _ExtentY        =   529
         _StockProps     =   253
         Text            =   "0"
         BorderStyle     =   1
         Decimals        =   0
         Separator       =   -1  'True
         MaskType        =   0
         HideSelection   =   0   'False
         MaxLength       =   0
         AutoTab         =   0   'False
         DateString      =   ""
         FormattedText   =   ""
         Mask            =   "###,##0"
         HelpLine        =   ""
         ClipText        =   "0"
         ClipMode        =   0
         StringIndex     =   0
         DateType        =   0
         DateSybase      =   "10/02/13"
         AutoDecimal     =   0   'False
         MinReal         =   -1.1e38
         MaxReal         =   3.4e38
         Units           =   0
         Errores         =   0
      End
      Begin TxtinLib.TextValid txtCampo 
         Height          =   285
         Index           =   0
         Left            =   1440
         TabIndex        =   8
         Top             =   600
         Width           =   720
         _Version        =   65536
         _ExtentX        =   1270
         _ExtentY        =   503
         _StockProps     =   253
         BorderStyle     =   1
         Range           =   ""
         MaxLength       =   4
         Character       =   2
         Type            =   2
         HelpLine        =   ""
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   0
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin VB.CommandButton cmdBoton 
         Caption         =   "Eli&minar"
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
         Index           =   8
         Left            =   6960
         Style           =   1  'Graphical
         TabIndex        =   14
         Tag             =   "4109"
         Top             =   915
         Width           =   1215
      End
      Begin TxtinLib.TextValid txtNumTrn 
         Height          =   285
         Left            =   1440
         TabIndex        =   10
         Top             =   1230
         Width           =   720
         _Version        =   65536
         _ExtentX        =   1270
         _ExtentY        =   503
         _StockProps     =   253
         BorderStyle     =   1
         Range           =   ""
         MaxLength       =   4
         Character       =   2
         Type            =   2
         HelpLine        =   ""
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   0
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin VB.CommandButton cmdBoton 
         Caption         =   "C&rear"
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
         Index           =   6
         Left            =   6960
         Style           =   1  'Graphical
         TabIndex        =   12
         Tag             =   "4109"
         Top             =   300
         Width           =   1215
      End
      Begin VB.CommandButton cmdBoton 
         Caption         =   "Ac&tualizar"
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
         Index           =   7
         Left            =   6960
         Style           =   1  'Graphical
         TabIndex        =   13
         Tag             =   "4109"
         Top             =   600
         Width           =   1215
      End
      Begin TxtinLib.TextValid txtCanal 
         Height          =   285
         Left            =   1440
         TabIndex        =   7
         Top             =   285
         Width           =   720
         _Version        =   65536
         _ExtentX        =   1270
         _ExtentY        =   503
         _StockProps     =   253
         BorderStyle     =   1
         Range           =   ""
         MaxLength       =   4
         Character       =   2
         Type            =   2
         HelpLine        =   ""
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   0
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin TxtinLib.TextValid txtCausal 
         Height          =   285
         Left            =   1440
         TabIndex        =   9
         Top             =   915
         Width           =   720
         _Version        =   65536
         _ExtentX        =   1270
         _ExtentY        =   503
         _StockProps     =   253
         BorderStyle     =   1
         Range           =   ""
         MaxLength       =   4
         Character       =   2
         Type            =   2
         HelpLine        =   ""
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   0
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin VB.Label lblDesEstado 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Left            =   5745
         TabIndex        =   55
         Top             =   1230
         Width           =   1110
      End
      Begin VB.Label lblEstado 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Left            =   5175
         TabIndex        =   54
         Top             =   1230
         Width           =   555
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Estado:"
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
         Index           =   16
         Left            =   4425
         TabIndex        =   53
         Top             =   1305
         Width           =   660
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Monto:"
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
         Index           =   15
         Left            =   2505
         TabIndex        =   52
         Top             =   1320
         Width           =   600
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Causal:"
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
         Left            =   120
         TabIndex        =   51
         Top             =   960
         Width           =   645
      End
      Begin VB.Label lblDesCausal 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Left            =   2175
         TabIndex        =   50
         Top             =   915
         Width           =   4680
      End
      Begin VB.Label lblDesCanal 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Left            =   2175
         TabIndex        =   49
         Top             =   285
         Width           =   4680
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Canal:"
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
         Index           =   11
         Left            =   120
         TabIndex        =   48
         Top             =   345
         Width           =   555
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Cantidad Trn.:"
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
         Index           =   10
         Left            =   120
         TabIndex        =   47
         Top             =   1320
         Width           =   1230
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   0
         Left            =   2175
         TabIndex        =   40
         Top             =   600
         Width           =   4680
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Transacción:"
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
         Left            =   120
         TabIndex        =   39
         Top             =   645
         Width           =   1125
      End
   End
   Begin VB.Frame Frame4 
      Caption         =   "Detalle Cobro Comisión por Transacción"
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
      Height          =   1575
      Left            =   30
      TabIndex        =   36
      Top             =   5880
      Width           =   8295
      Begin MSGrid.Grid grdParamTrans 
         Height          =   1215
         Left            =   120
         TabIndex        =   37
         Top             =   240
         Width           =   8085
         _Version        =   65536
         _ExtentX        =   14261
         _ExtentY        =   2143
         _StockProps     =   77
         BackColor       =   16777215
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Información Producto"
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
      Height          =   1245
      Left            =   30
      TabIndex        =   29
      Top             =   90
      Width           =   8295
      Begin TxtinLib.TextValid txtCampo 
         Height          =   285
         Index           =   2
         Left            =   1800
         TabIndex        =   2
         Top             =   540
         Width           =   1095
         _Version        =   65536
         _ExtentX        =   1931
         _ExtentY        =   503
         _StockProps     =   253
         BorderStyle     =   1
         Range           =   ""
         MaxLength       =   10
         Character       =   0
         Type            =   1
         HelpLine        =   ""
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   0
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin TxtinLib.TextValid txtCampo 
         Height          =   285
         Index           =   3
         Left            =   1800
         TabIndex        =   3
         Top             =   840
         Width           =   1095
         _Version        =   65536
         _ExtentX        =   1931
         _ExtentY        =   503
         _StockProps     =   253
         BorderStyle     =   1
         Range           =   ""
         MaxLength       =   2
         Character       =   0
         Type            =   3
         HelpLine        =   ""
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   0
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin TxtinLib.TextValid txtCampo 
         Height          =   285
         Index           =   1
         Left            =   1800
         TabIndex        =   1
         Top             =   240
         Width           =   1095
         _Version        =   65536
         _ExtentX        =   1931
         _ExtentY        =   503
         _StockProps     =   253
         BorderStyle     =   1
         Range           =   ""
         MaxLength       =   32000
         Character       =   0
         Type            =   1
         HelpLine        =   ""
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   0
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   1
         Left            =   2920
         TabIndex        =   46
         Top             =   240
         Width           =   5250
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   2
         Left            =   2920
         TabIndex        =   45
         Top             =   540
         Width           =   5250
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   3
         Left            =   2920
         TabIndex        =   44
         Top             =   840
         Width           =   5250
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Sucursal:"
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
         TabIndex        =   43
         Top             =   285
         Width           =   810
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Producto Final:"
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
         Left            =   120
         TabIndex        =   34
         Top             =   585
         Width           =   1305
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Categoría:"
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
         Left            =   120
         TabIndex        =   30
         Top             =   885
         Width           =   870
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Información Cobro"
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
      Height          =   1455
      Left            =   30
      TabIndex        =   0
      Top             =   1320
      Width           =   8295
      Begin VB.ComboBox cmbEstado 
         Height          =   315
         ItemData        =   "FparCom.frx":0000
         Left            =   1800
         List            =   "FparCom.frx":0002
         TabIndex        =   6
         Top             =   797
         Width           =   1095
      End
      Begin MSMask.MaskEdBox mskFecha 
         BeginProperty DataFormat 
            Type            =   1
            Format          =   "dd/MM/yyyy"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   9226
            SubFormatType   =   3
         EndProperty
         Height          =   285
         Left            =   1800
         TabIndex        =   5
         Top             =   496
         Width           =   1080
         _ExtentX        =   1905
         _ExtentY        =   503
         _Version        =   393216
         Appearance      =   0
         PromptChar      =   "_"
      End
      Begin TxtinLib.TextValid txtCampo 
         Height          =   285
         Index           =   4
         Left            =   1800
         TabIndex        =   4
         Top             =   195
         Width           =   1080
         _Version        =   65536
         _ExtentX        =   1905
         _ExtentY        =   503
         _StockProps     =   253
         BorderStyle     =   1
         Range           =   ""
         MaxLength       =   2
         Character       =   0
         Type            =   3
         HelpLine        =   ""
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   0
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin TxtinLib.TextValid txtTotTrans 
         Height          =   285
         Left            =   7200
         TabIndex        =   20
         Top             =   195
         Width           =   975
         _Version        =   65536
         _ExtentX        =   1720
         _ExtentY        =   503
         _StockProps     =   253
         BorderStyle     =   1
         Enabled         =   0   'False
         Range           =   ""
         MaxLength       =   2
         Character       =   0
         Type            =   1
         HelpLine        =   ""
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   0
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin TxtinLib.TextValid txtDebito 
         Height          =   285
         Left            =   7200
         TabIndex        =   22
         Top             =   505
         Width           =   975
         _Version        =   65536
         _ExtentX        =   1720
         _ExtentY        =   503
         _StockProps     =   253
         BorderStyle     =   1
         Enabled         =   0   'False
         Range           =   ""
         MaxLength       =   2
         Character       =   0
         Type            =   1
         HelpLine        =   ""
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   0
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin TxtinLib.TextValid txtCredito 
         Height          =   285
         Left            =   7200
         TabIndex        =   23
         Top             =   815
         Width           =   975
         _Version        =   65536
         _ExtentX        =   1720
         _ExtentY        =   503
         _StockProps     =   253
         BorderStyle     =   1
         Enabled         =   0   'False
         Range           =   ""
         MaxLength       =   2
         Character       =   0
         Type            =   1
         HelpLine        =   ""
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   0
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin TxtinLib.TextValid txtConsulta 
         Height          =   285
         Left            =   7200
         TabIndex        =   24
         Top             =   1115
         Width           =   975
         _Version        =   65536
         _ExtentX        =   1720
         _ExtentY        =   503
         _StockProps     =   253
         BorderStyle     =   1
         Enabled         =   0   'False
         Range           =   ""
         MaxLength       =   2
         Character       =   0
         Type            =   1
         HelpLine        =   ""
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
         BackStyle       =   0  'Transparent
         Caption         =   "Estado:"
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
         TabIndex        =   35
         Top             =   857
         Width           =   660
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Fecha de Vigencia:"
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
         Index           =   12
         Left            =   120
         TabIndex        =   33
         Top             =   541
         Width           =   1620
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Tipo Cobro:"
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
         TabIndex        =   32
         Top             =   240
         Width           =   990
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Total Transacción:"
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
         Left            =   5520
         TabIndex        =   31
         Top             =   240
         Width           =   1620
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Cantidad Consulta:"
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
         Index           =   8
         Left            =   5535
         TabIndex        =   28
         Top             =   1160
         Width           =   1620
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Cantidad Crédito:"
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
         Index           =   7
         Left            =   5535
         TabIndex        =   27
         Top             =   860
         Width           =   1485
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Cantidad Débito:"
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
         Left            =   5520
         TabIndex        =   26
         Top             =   550
         Width           =   1440
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   4
         Left            =   2920
         TabIndex        =   25
         Top             =   195
         Width           =   2520
      End
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Eliminar"
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
      Height          =   750
      Index           =   3
      Left            =   8400
      Picture         =   "FparCom.frx":0004
      Style           =   1  'Graphical
      TabIndex        =   18
      Tag             =   "4112"
      Top             =   2295
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Crear"
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
      Height          =   750
      Index           =   0
      Left            =   8400
      Picture         =   "FparCom.frx":036A
      Style           =   1  'Graphical
      TabIndex        =   16
      Tag             =   "4110"
      Top             =   765
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Actualizar"
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
      Height          =   750
      Index           =   4
      Left            =   8400
      Picture         =   "FparCom.frx":0674
      Style           =   1  'Graphical
      TabIndex        =   17
      Tag             =   "4111"
      Top             =   1530
      Width           =   870
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
      Picture         =   "FparCom.frx":097E
      Style           =   1  'Graphical
      TabIndex        =   19
      Top             =   3060
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Buscar"
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
      Height          =   750
      Index           =   5
      Left            =   8400
      Picture         =   "FparCom.frx":0CE4
      Style           =   1  'Graphical
      TabIndex        =   15
      Tag             =   "4109"
      Top             =   0
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
      Left            =   8400
      Picture         =   "FparCom.frx":0F46
      Style           =   1  'Graphical
      TabIndex        =   21
      Top             =   3825
      Width           =   870
   End
   Begin VB.OLE OLE1 
      Class           =   "Package"
      Height          =   1335
      Left            =   1800
      TabIndex        =   56
      Top             =   8160
      Width           =   2895
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00400000&
      BorderWidth     =   2
      X1              =   5.802
      X2              =   5.802
      Y1              =   0
      Y2              =   5.333
   End
End
Attribute VB_Name = "FParCom"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
'*************************************************************
' ARCHIVO:          FPARCOM.FRM
' NOMBRE LOGICO:    FPARCOM
' PRODUCTO:         CUENTAS AHORROS
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
' Esta forma permite el mantenimiento de cobros de comisiones
' por transacciones o consulta de cuentas
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR               RAZON
' 01-12-09       Carlos Muñoz       Emisión Inicial
'*************************************************************
Dim VLPaso As Integer
'! removed Dim VTMarca As Integer




Private Sub cmbEstado_GotFocus()
     FPrincipal.pnlHelpLine.Caption = " Estado "
End Sub

Private Sub cmbEstado_KeyPress(KeyAscii As Integer)
    KeyAscii = 0
End Sub

Private Sub cmdBoton_GotFocus(Index As Integer)
    Select Case Index%
        Case 0
            FPrincipal.pnlHelpLine.Caption = " Crear Parametrización Comisión"
        Case 1
            FPrincipal.pnlHelpLine.Caption = " Limpiar Campos Parametrización Comisión"
        Case 2
            FPrincipal.pnlHelpLine.Caption = " Salir de Pantalla"
        Case 3
            FPrincipal.pnlHelpLine.Caption = " Eliminar Parametrización Comisión"
        Case 4
            FPrincipal.pnlHelpLine.Caption = " Actualizar Parametrización Comisión"
        Case 5
            FPrincipal.pnlHelpLine.Caption = " Buscar Información Producto"
        Case 6
            FPrincipal.pnlHelpLine.Caption = " Crear Transacción"
        Case 7
            FPrincipal.pnlHelpLine.Caption = " Actualizar Transacción"
        Case 8
            FPrincipal.pnlHelpLine.Caption = " Eliminar Transacción"
    End Select
End Sub

Private Sub Form_Load()
Dim VLFormatoFecha$
    FParCom.Left = 0    '15
    FParCom.Top = 0    '15
    FParCom.Width = 9405   '9420
    FParCom.Height = 7900 '7515   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    PMBotonSeguridad FParCom, 5
    
    PMObjetoSeguridad cmdBoton(5)
    PMObjetoSeguridad cmdBoton(0)
    PMObjetoSeguridad cmdBoton(4)
    PMObjetoSeguridad cmdBoton(3)
    
    'cmdBoton_Click (5)
    cmdBoton(3).Enabled = False
    cmdBoton(4).Enabled = False
    
    VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
    mskFecha.Mask = FMMascaraFecha(VLFormatoFecha$)
   ' mskFecha.Text = Format$(VGFecha$, VLFormatoFecha$)
   cmbEstado.AddItem "V", 0
   cmbEstado.AddItem "C", 1
   cmbEstado.ListIndex = 0
   
  FPrincipal.pnlHelpLine.Caption = "FParCom - Version VSS 3"
    
End Sub

Private Sub mskFecha_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Fecha de la Vigencia [" & VGFormatoFecha & "]"
    mskFecha.SelStart = 0
    mskFecha.SelLength = Len(mskFecha.Text)

End Sub

Private Sub mskFecha_LostFocus()
Dim VTValido%
Dim VTValido1$
Dim VTValido2$
Dim VGFechaProceso$
    If mskFecha.ClipText <> "" Then
       VTValido% = FMVerFormato((mskFecha.FormattedText), VGFormatoFecha$)
       If Not VTValido% Then
          MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
          mskFecha.SetFocus
          Exit Sub
       End If
       VTValido1$ = Format$(mskFecha.Text, VGFormatoFecha$)
       VTValido2$ = Format$(VGFecha$, VGFormatoFecha$)
       If FMDateDiff("d", VTValido1$, VTValido2$, VGFormatoFecha) > 0 Then
          mskFecha.Text = Format$(VGFecha$, VGFormatoFecha$)
          MsgBox ("Fecha seleccionada es Menor a la Fecha del Sistema " + VGFechaProceso$)
          mskFecha.SetFocus
          Exit Sub
       End If
    End If
End Sub



Private Sub mskMonto_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Monto"
End Sub

Private Sub mskMonto_KeyPress(KeyAscii As Integer)
If (KeyAscii% < 48 And KeyAscii% <> 8 And KeyAscii% <> 9 And KeyAscii% <> 46) Or KeyAscii% > 57 Then
   KeyAscii% = 0
End If
End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 0, 1, 2, 3
        VLPaso% = False
    Case 4
        If txtCampo(4).Text = "T" Then
            txtTotTrans.Enabled = True
            txtDebito.Enabled = False
            txtCredito.Enabled = False
            txtConsulta.Enabled = False
            FraTransaccion.Enabled = False
        ElseIf txtCampo(4).Text = "C" Then
            txtTotTrans.Enabled = False
            txtDebito.Enabled = True
            txtCredito.Enabled = True
            txtConsulta.Enabled = True
            FraTransaccion.Enabled = False
        ElseIf txtCampo(4).Text = "M" Then
            txtTotTrans.Enabled = False
            txtDebito.Enabled = False
            txtCredito.Enabled = False
            txtConsulta.Enabled = False
            FraTransaccion.Enabled = False
        ElseIf txtCampo(4).Text = "W" Then
            txtTotTrans.Enabled = False
            txtDebito.Enabled = False
            txtCredito.Enabled = False
            txtConsulta.Enabled = False
            FraTransaccion.Enabled = True
        End If
        VLPaso% = False
        
            txtTotTrans.Text = ""
            txtDebito.Text = ""
            txtCredito.Text = ""
            txtConsulta.Text = ""
    End Select
    
  
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
VLPaso% = True
Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Transacción [F5] Ayuda"
    Case 1
        FPrincipal.pnlHelpLine.Caption = " Sucursal [F5] Ayuda"
    Case 2
        FPrincipal.pnlHelpLine.Caption = " Producto Final [F5] Ayuda"
    Case 3
        FPrincipal.pnlHelpLine.Caption = " Categoria [F5] Ayuda"
    Case 4
        FPrincipal.pnlHelpLine.Caption = " Tipo de Cobro [F5] Ayuda"
    Case 5
        FPrincipal.pnlHelpLine.Caption = " Cantidad Transacción [F5] Ayuda"
End Select

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
Dim VTFilas%
Dim VTProFinal$
Dim VLProducto$
    If KeyCode% = VGTeclaAyuda% Then
        VLPaso% = True
        Select Case Index%

    Case 0
        txtCausal.Text = "" 'Req 371
        lblDesCausal.Caption = ""
        PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "pe_transaccion"
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de Tipo de Cobro " & "[" & txtCampo(4).Text & "]") Then
            PMMapeaListaH sqlconn&, FCatalogo.lstCatalogo, False
            PMChequea sqlconn&
            FCatalogo.Show 1
            txtCampo(0).Text = VGACatalogo.Codigo$
            lblDescripcion(0).Caption = VGACatalogo.Descripcion$
            If txtCampo(0).Text <> "" Then
               txtCampo(0).SetFocus
            End If
         Else
             txtCampo(0).Text = ""
             lblDescripcion(0).Caption = ""
             txtCampo(0).SetFocus
         End If

    Case 1
        VGOperacion$ = "sp_hp_sucursal"
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4079"
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", False, "") Then
                Load FRegistros
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                 PMChequea sqlconn&
                FRegistros.Show 1
                ' PMChequea SqlConn&
                If VGValores(1) <> "" Then
                    txtCampo(1).Text = VGValores(1)
                    lblDescripcion(1).Caption = VGValores(2)
                    'PLLimpiar
                Else
                    txtCampo(1).Text = ""
                    lblDescripcion(1).Caption = ""
                    VGOperacion$ = ""
                    'PLLimpiar
                End If
                VLPaso% = True
            Else
                txtCampo(1).Text = ""
                lblDescripcion(1).Caption = ""
                VGOperacion$ = ""
            End If
    
    
    Case 2
        
        If txtCampo(1).Text = "" Then
                    MsgBox "La Sucursal es Mandatoria", 0 + 16, "Mensaje de Error"
                    txtCampo(1).SetFocus
                    Exit Sub
        End If
        
        VTFilas% = VGMaxRows%
        VTProFinal$ = "0"
        VGOperacion$ = "sp_prodfin3"
        Load FRegistros
        While VTFilas% = VGMaxRows%
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4011"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(1).Text
             PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, VTProFinal$

             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, "Ok... Consulta de Productos") Then
                If VTProFinal$ = "0" Then
                     PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                Else
                     PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
                End If
                
                 PMChequea sqlconn&
                   
                VTFilas% = Val(FRegistros.grdRegistros.Tag)

                FRegistros.grdRegistros.Col = 1
                FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                VTProFinal$ = FRegistros.grdRegistros.Text
            Else
                txtCampo(2).Text = ""
                lblDescripcion(2).Caption = ""
                VGOperacion$ = ""
            End If
        Wend

        FRegistros.grdRegistros.Row = 1
        FRegistros.Show 1
            
        If VGValores(1) <> "" Then
            txtCampo(2).Text = VGValores(1)
            lblDescripcion(2).Caption = VGValores(2)
            VLPaso% = True
        Else
            txtCampo(2).Text = ""
            lblDescripcion(2).Caption = ""
            VGOperacion$ = ""
            VLProducto$ = ""
        End If
    

  
    Case 3
    
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4101"
            PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "H"
            PMPasoValores sqlconn&, "@i_cons_profinal", 0, SQLCHAR, "N"
            PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(2).Text
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_categoria_profinal", True, " Ok... Consulta de Categorías") Then
                 PMMapeaListaH sqlconn&, FCatalogo.lstCatalogo, False
                 PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(3).Text = VGACatalogo.Codigo$
                lblDescripcion(3).Caption = VGACatalogo.Descripcion$
                If txtCampo(3).Text <> "" Then
                   txtCampo(3).SetFocus
                End If
             Else
                 txtCampo(3).Text = ""
                 lblDescripcion(3).Caption = ""
                 txtCampo(3).SetFocus
             End If
    Case 4
    
            PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "pe_tipo_cobro"
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
            PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de Tipo de Cobro " & "[" & txtCampo(4).Text & "]") Then
                 PMMapeaListaH sqlconn&, FCatalogo.lstCatalogo, False
                 PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(4).Text = VGACatalogo.Codigo$
                lblDescripcion(4).Caption = VGACatalogo.Descripcion$
                If txtCampo(4).Text <> "" Then
                   txtCampo(4).SetFocus
                End If
             Else
                 txtCampo(4).Text = ""
                 lblDescripcion(4).Caption = ""
                 txtCampo(4).SetFocus
             End If


    
    
    
    
End Select
End If
End Sub


Private Sub txtCampo_LostFocus(Index As Integer)
Dim VTR%
Dim VLProducto$
    Select Case Index%

    Case 0
       If Not VLPaso% Then
            txtCampo(0).Text = Trim$(txtCampo(0).Text)
            If txtCampo(0).Text <> "" Then
                PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR&, "pe_transaccion"
                PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V"
                PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR&, (txtCampo(0).Text)
                If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, "") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(0)
                     PMChequea sqlconn&
                Else
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Caption = ""
                End If
            End If
        Else
            txtCampo(0).Text = Trim$(txtCampo(0).Text)
        End If
        If txtCampo(0).Text = "" And lblDescripcion(0).Caption <> "" Then
            lblDescripcion(0).Caption = ""
        End If
    Case 1
        If VLPaso% = False Then
                
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4078"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(1).Text
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", True, " Consulta del Sucursal ") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(1)
                     PMChequea sqlconn&
                    'PLLimpiar
                Else
                    lblDescripcion(1).Caption = ""
                    txtCampo(1).Text = ""
                    txtCampo(1).SetFocus
                    VLPaso% = True
                    'PLLimpiar
                End If
            
        End If

    Case 2
    If VLPaso% = False Then
            
    
        If Trim$(txtCampo(2).Text) = "" Then
            
            Exit Sub
        End If
        
        If Trim$(txtCampo(1).Text) = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            'PLLimpiar
            txtCampo(1).SetFocus
            Exit Sub
        End If
        
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4077"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, txtCampo(2).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, " Consulta del producto ") Then
            ReDim VTArreglo(3) As String
             VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
             PMChequea sqlconn&
            lblDescripcion(2).Caption = VTArreglo(1)
            VLProducto$ = VTArreglo(3)

        Else
            'PLLimpiar
            txtCampo(2).Text = ""
            txtCampo(2).SetFocus
            VLPaso% = True
        End If
    End If
    
    Case 3
     If Not VLPaso% Then
        txtCampo(3).Text = Trim$(txtCampo(3).Text)
        If txtCampo(3).Text <> "" Then
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4101"
            PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "Q"
            PMPasoValores sqlconn&, "@i_cons_profinal", 0, SQLCHAR, "N"
            PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(2).Text
            PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(3).Text
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_categoria_profinal", True, " Ok... Consulta de Categorías") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(3)
                 PMChequea sqlconn&
            Else
                txtCampo(3).Text = ""
                lblDescripcion(3).Caption = ""
            End If
        End If
    Else
        txtCampo(3).Text = Trim$(txtCampo(3).Text)
    End If
    If txtCampo(3).Text = "" And lblDescripcion(3).Caption <> "" Then
        lblDescripcion(3).Caption = ""
    End If
    
    
    Case 4
     If Not VLPaso% Then
        txtCampo(4).Text = Trim$(txtCampo(4).Text)
        If txtCampo(4).Text <> "" Then
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR&, "pe_tipo_cobro"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V"
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR&, (txtCampo(4).Text)
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, "") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(4)
                 PMChequea sqlconn&
            Else
                txtCampo(4).Text = ""
                lblDescripcion(4).Caption = ""
            End If
        End If
    Else
        txtCampo(4).Text = Trim$(txtCampo(4).Text)
    End If
    If txtCampo(4).Text = "" And lblDescripcion(4).Caption <> "" Then
        lblDescripcion(4).Caption = ""
    End If
    
   

End Select
End Sub

Private Sub cmdBoton_Click(Index As Integer)
    Const MB_YESNO = 4
    Const MB_ICONQUESTION = 32
    Const MB_DEBUTTON1 = 0
    '! removed Const IDCANCEL = 2
    '! removed Const IDNO = 7
    '! removed Const MB_DEFBUTTON1 = 0
    Const IDYES = 6
'FIXIT: Declare 'DgDef' and 'Response' with an early-bound data type                       FixIT90210ae-R1672-R1B8ZE
    Dim DgDef As Integer
    Dim Response As String
    Dim VLSucursal As String
    Dim VLProdFinal As String
    Dim VLCategoria As String

    'DgDef = MB_YESNOCANCEL + MB_ICONQUESTION + MB_DEBUTTON1
    DgDef = MB_YESNO + MB_ICONQUESTION + MB_DEBUTTON1
    
Select Case Index%
    Case 0, 6 'Crear una comisión
            
        If txtCampo(1).Text = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If
        
        If txtCampo(2).Text = "" Then
                MsgBox "El código del producto es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(2).SetFocus
                Exit Sub
        End If

        If txtCampo(3).Text = "" Then
            MsgBox "El código de la categoría es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        
        If txtCampo(4).Text = "" Then
                MsgBox "El código del tipo de cobro es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(4).SetFocus
                Exit Sub
        End If
        
        If mskFecha.ClipText = "" Then
                MsgBox "La fecha de vigencia es mandatoria", 0 + 16, "Mensaje de Error"
                mskFecha.SetFocus
                Exit Sub
        End If
        
        If txtCampo(4).Text = "W" Then
           If txtCampo(0).Text = "" Then
              MsgBox "El codigo de transacción es mandatoria", 0 + 16, "Mensaje de Error"
              mskFecha.SetFocus
              Exit Sub
           End If
        End If
        
        If txtCampo(4).Text = "W" Then
           If txtNumTrn.Text = "" Then
              MsgBox "La cantidad de transacción es mandatoria", 0 + 16, "Mensaje de Error"
              mskFecha.SetFocus
              Exit Sub
           End If
        End If
       
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4110"
        PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "I"
        PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(2).Text
        PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(3).Text
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, txtCampo(4).Text
        PMPasoValores sqlconn&, "@i_numtot", 0, SQLINT2, txtTotTrans.Text
        PMPasoValores sqlconn&, "@i_numcre", 0, SQLINT2, txtCredito.Text
        PMPasoValores sqlconn&, "@i_numdeb", 0, SQLINT2, txtDebito.Text
        PMPasoValores sqlconn&, "@i_numco", 0, SQLINT2, txtConsulta.Text 'Format((mskFecha.FormattedText), VGFormatoFecha$)
        PMPasoValores sqlconn&, "@i_fechavig", 0, SQLDATETIME, FMConvFecha((mskFecha.FormattedText), VGFormatoFecha$, "mm/dd/yy")
        PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, cmbEstado.Text
        PMPasoValores sqlconn&, "@i_transaccion", 0, SQLINT2, txtCampo(0).Text
        PMPasoValores sqlconn&, "@i_numtrn", 0, SQLINT2, txtNumTrn.Text
        PMPasoValores sqlconn&, "@i_causa", 0, SQLCHAR, txtCausal.Text
        PMPasoValores sqlconn&, "@i_canal", 0, SQLCHAR, txtCanal.Text
        PMPasoValores sqlconn&, "@i_monto", 0, SQLMONEY, mskMonto.ClipText
        If Index = 6 Then
           PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "T"
        End If
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cobcom_profinal", True, "Ok...Creación de Cobros") Then
           
           PMChequea sqlconn&
           'cmdBoton(0).Enabled = False
           
           cmdBoton_Click (5)
        End If
                        
    Case 1 'Limpiar
        txtCampo(1).Enabled = True
        txtCampo(1).Text = ""
        txtCampo(4).Text = ""
        txtCampo(4).Enabled = True
        PLLimpiar
        txtCampo(1).SetFocus
        'lblDescripcion(5).Caption = ""

    Case 2 'Salir
         Unload Me

    Case 3
          'Eliminar
        If txtCampo(2).Text = "" Then
            MsgBox "El código del producto final es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If

        If txtCampo(3).Text = "" Then
            MsgBox "El código de la categoría es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        
        cmdBoton(4).Enabled = False
        Response = MsgBox("Desea Eliminar la Comisión No. " + (txtCampo(1).Text) + "?", DgDef, "Mensaje de Seguridad")
        If Response = IDYES Then
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4112"
            PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "D"
            PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(2).Text
            PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(3).Text
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, txtCampo(4).Text
            PMPasoValores sqlconn&, "@i_transaccion", 0, SQLINT2, txtCampo(0).Text
            PMPasoValores sqlconn&, "@i_causa", 0, SQLCHAR, txtCausal.Text
            PMPasoValores sqlconn&, "@i_canal", 0, SQLCHAR, txtCanal.Text
            PMPasoValores sqlconn&, "@i_monto", 0, SQLMONEY, mskMonto.ClipText
            If Index = 8 Then
               PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "T"
            End If
            
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cobcom_profinal", True, " Ok... Eliminación de Comisión por Cobro") Then
                 PMChequea sqlconn&
                cmdBoton(3).Enabled = False
                PLLimpiar
                'cmdBoton_Click (5)
            End If
        Else
            Exit Sub
        End If
        
    Case 8 'Elimina transaccion
        If txtCampo(0).Text = "" Then
            MsgBox "Debe seleccionar la transaccion a eliminar", 0 + 16, "Mensaje de Error"
            grdParamTrans.SetFocus
            Exit Sub
        End If
        
        Response = MsgBox("Desea Eliminar la Transaccion " + (txtCampo(0).Text) + "-" + lblDescripcion(0).Caption + "?", DgDef, "Mensaje de Seguridad")
        If Response = IDYES Then
            VLSucursal = txtCampo(1).Text
            VLProdFinal = txtCampo(2).Text
            VLCategoria = txtCampo(3).Text
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4112"
            PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "D"
            PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(2).Text
            PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(3).Text
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, txtCampo(4).Text
            PMPasoValores sqlconn&, "@i_transaccion", 0, SQLINT2, txtCampo(0).Text
            PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "T"
            PMPasoValores sqlconn&, "@i_causa", 0, SQLCHAR, txtCausal.Text
            PMPasoValores sqlconn&, "@i_canal", 0, SQLCHAR, txtCanal.Text
            PMPasoValores sqlconn&, "@i_monto", 0, SQLMONEY, mskMonto.ClipText
            
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cobcom_profinal", True, " Ok... Eliminación de Comisión por Cobro") Then
               PMChequea sqlconn&
               cmdBoton(3).Enabled = False
               PLLimpiar
               txtCampo(1).Text = VLSucursal
               Call txtCampo_LostFocus(1)
               txtCampo(2).Text = VLProdFinal
               Call txtCampo_LostFocus(2)
               txtCampo(3).Text = VLCategoria
               Call txtCampo_LostFocus(3)
               Call cmdBoton_Click(5)
            End If
        Else
            Exit Sub
        End If



    Case 4, 7 'Actualizar
        
        If txtCampo(2).Text = "" Then
            MsgBox "El código del producto final es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If

        If txtCampo(3).Text = "" Then
            MsgBox "El código de la categoría es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        If txtCampo(4).Text = "" Then
            MsgBox "El código del tipo de cobro es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(4).SetFocus
            Exit Sub
        End If
               
        cmdBoton(3).Enabled = False
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4111"
        PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "U"
        PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(2).Text
        PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(3).Text
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, txtCampo(4).Text
        PMPasoValores sqlconn&, "@i_numtot", 0, SQLINT2, txtTotTrans.Text
        PMPasoValores sqlconn&, "@i_numcre", 0, SQLINT2, txtCredito.Text
        PMPasoValores sqlconn&, "@i_numdeb", 0, SQLINT2, txtDebito.Text
        PMPasoValores sqlconn&, "@i_numco", 0, SQLINT2, txtConsulta.Text
        PMPasoValores sqlconn&, "@i_fechavig", 0, SQLDATETIME, FMConvFecha((mskFecha.FormattedText), VGFormatoFecha$, CGFormatoBase$)
        PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP$
        PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, cmbEstado.Text
        PMPasoValores sqlconn&, "@i_transaccion", 0, SQLINT2, txtCampo(0).Text
        PMPasoValores sqlconn&, "@i_numtrn", 0, SQLINT2, txtNumTrn.Text
        PMPasoValores sqlconn&, "@i_causa", 0, SQLCHAR, txtCausal.Text
        PMPasoValores sqlconn&, "@i_canal", 0, SQLCHAR, txtCanal.Text
        PMPasoValores sqlconn&, "@i_monto", 0, SQLMONEY, mskMonto.Text 'IB Modificacion monto correcto 16/01/2014
        If Index = 7 Then
           PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "T"
        End If
        
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cobcom_profinal", True, "Ok...Modificación de Cobros") Then
           PMChequea sqlconn&
           cmdBoton(4).Enabled = False
           cmdBoton_Click (5)
        End If
    Case 5 'Buscar

        If txtCampo(1).Text = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If
        
        If Trim$(txtCampo(2).Text) = "" Then
            MsgBox "El código del producto final es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
         
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4109"
         PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "S"
         PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, 103 'VGFecha_SP
         PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(3).Text

         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cobcom_profinal", True, " Ok... Consulta de Comisión por Cobro") Then
             PMMapeaGrid sqlconn&, grdParamCobCom, False
             PMMapeaGrid sqlconn&, grdParamTrans, False
             PMChequea sqlconn&
             txtCampo(0).Text = ""
             lblDescripcion(0).Caption = ""
             txtNumTrn.Text = ""
             'Req. 371 - CAV
             txtCanal.Text = ""
             lblDesCanal.Caption = ""
             txtCausal.Text = ""
             lblDesCausal.Caption = ""
             'mskMonto.Mask = ""
             mskMonto.Text = ""
             'mskMonto.Mask = "###,###.00"
             lblDesCanal.Caption = ""
             lblDesCausal.Caption = ""
             lblDesEstado.Caption = ""
             lblEstado.Caption = ""
           ' grdParamCobCom.ColWidth(1) = 1000
           ' grdParamCobCom.ColWidth(2) = 5750
           ' grdParamCobCom.ColWidth(3) = 1000

            
         End If
               
         
    End Select
End Sub

Private Sub PLLimpiar()
'*************************************************************
' PROPOSITO: Limpia el contenido de los objetos de la forma,
'            y habilita o deshabilita ciertos botones.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 27-Ene-94      A.Rodríguez     Emisión Inicial
'*************************************************************
Dim VLFormatoFecha$
Dim i%
    txtCampo(1).Enabled = True
    txtCampo(2).Enabled = True
    txtCampo(3).Enabled = True
    txtCampo(4).Text = ""
    txtCampo(1).Text = ""
    txtCampo(2).Text = ""
    txtCampo(3).Text = ""
    txtCampo(4).Text = ""
    'Se limpian campos texto asociados a transacciones
    txtCampo(0).Text = ""
    lblDescripcion(0).Caption = ""
    txtNumTrn.Text = ""
    txtTotTrans.Text = ""
    txtCredito.Text = ""
    txtDebito.Text = ""
    txtConsulta.Text = ""
    mskFecha.Mask = ""
    mskFecha.Text = ""
    mskMonto.Mask = ""
    mskMonto.Text = ""
    txtCanal.Text = ""
    txtCausal.Text = ""
    lblDesCanal.Caption = ""
    lblDesCausal.Caption = ""
    lblDesEstado.Caption = ""
    lblEstado.Caption = ""
    VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
    mskFecha.Mask = FMMascaraFecha(VLFormatoFecha$)
    mskMonto.Text = ""
    'mskFecha.Text = Format$("", VLFormatoFecha$)
    
    For i% = 1 To 4
        lblDescripcion(i%).Caption = ""
    Next i%
        
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
        
    'cmdBoton(0).Enabled = True
    'cmdBoton(4).Enabled = False
    'cmdBoton(3).Enabled = False
    
    PMObjetoSeguridad cmdBoton(0)
    PMObjetoSeguridad cmdBoton(4)
    PMObjetoSeguridad cmdBoton(3)
    
    'cmdBoton_Click (5)
    grdParamCobCom.Rows = 2
    grdParamCobCom.Cols = 2
    'grdParamCobCom.ColWidth(1) = 600
    grdParamCobCom.Row = 0
    grdParamCobCom.Col = 1
    grdParamCobCom.Text = ""
    grdParamCobCom.Row = 1
    grdParamCobCom.Col = 0
    grdParamCobCom.Text = ""
    grdParamCobCom.Col = 1
    grdParamCobCom.Text = ""
    
    grdParamTrans.Rows = 2
    grdParamTrans.Cols = 2
    'grdParamCobCom.ColWidth(1) = 600
    grdParamTrans.Row = 0
    grdParamTrans.Col = 1
    grdParamTrans.Text = ""
    grdParamTrans.Row = 1
    grdParamTrans.Col = 0
    grdParamTrans.Text = ""
    grdParamTrans.Col = 1
    grdParamTrans.Text = ""

    cmbEstado.ListIndex = 0
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdParamCobCom_Click()
    grdParamCobCom.Col = 0
    grdParamCobCom.SelStartCol = 1
    grdParamCobCom.SelEndCol = grdParamCobCom.Cols - 1
    If grdParamCobCom.Row = 0 Then
        grdParamCobCom.SelStartRow = 1
        grdParamCobCom.SelEndRow = 1
    Else
        grdParamCobCom.SelStartRow = grdParamCobCom.Row
        grdParamCobCom.SelEndRow = grdParamCobCom.Row
    End If
End Sub

Private Sub grdParamCobCom_DblClick()
Dim VTRow%
    VTRow% = grdParamCobCom.Row
    grdParamCobCom.Row = 1
    grdParamCobCom.Col = 1
    If grdParamCobCom.Text <> "" Then
        grdParamCobCom.Row = VTRow%
        PMMarcarRegistro
    End If
End Sub

Private Sub grdParamCobCom_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Haga Doble Click para Seleccionar"
End Sub

Private Sub grdParamCobCom_KeyUp(KeyCode As Integer, Shift As Integer)
    grdParamCobCom.Col = 0
    grdParamCobCom.SelStartCol = 1
    grdParamCobCom.SelEndCol = grdParamCobCom.Cols - 1
    If grdParamCobCom.Row = 0 Then
        grdParamCobCom.SelStartRow = 1
        grdParamCobCom.SelEndRow = 1
    Else
        grdParamCobCom.SelStartRow = grdParamCobCom.Row
        grdParamCobCom.SelEndRow = grdParamCobCom.Row
    End If
    
End Sub

Private Sub grdParamTrans_Click()
    grdParamTrans.Col = 0
    grdParamTrans.SelStartCol = 1
    grdParamTrans.SelEndCol = grdParamTrans.Cols - 1
    If grdParamTrans.Row = 0 Then
        grdParamTrans.SelStartRow = 1
        grdParamTrans.SelEndRow = 1
    Else
        grdParamTrans.SelStartRow = grdParamTrans.Row
        grdParamTrans.SelEndRow = grdParamTrans.Row
    End If
End Sub

Private Sub grdParamTrans_DblClick()
Dim VTRow%
    VTRow% = grdParamTrans.Row
    grdParamTrans.Col = 1
    If grdParamTrans.Text <> "" Then
       grdParamTrans.Row = VTRow%
       PMMarcarRegistroTx
    End If
End Sub

Private Sub grdParamTrans_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Haga Doble Click para Seleccionar"
End Sub

Private Sub grdParamTrans_KeyUp(KeyCode As Integer, Shift As Integer)
    grdParamTrans.Col = 0
    grdParamTrans.SelStartCol = 1
    grdParamTrans.SelEndCol = grdParamTrans.Cols - 1
    If grdParamTrans.Row = 0 Then
        grdParamTrans.SelStartRow = 1
        grdParamTrans.SelEndRow = 1
    Else
        grdParamTrans.SelStartRow = grdParamTrans.Row
        grdParamTrans.SelEndRow = grdParamTrans.Row
    End If
    
End Sub

Private Sub PMMarcarRegistro()
'*************************************************************
' PROPOSITO: Toma los valores ubicados en cierta fila del grid
'            y los ubica en ciertos objetos de la forma.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 27-Ene-94      A.Rodríguez     Emisión Inicial
'*************************************************************
    'cmdBoton(4).Enabled = True
    'cmdBoton(3).Enabled = True
Dim VLFormatoFecha$
    PMObjetoSeguridad cmdBoton(4)
    PMObjetoSeguridad cmdBoton(3)
    cmdBoton(0).Enabled = False
    
    'grdParamCobCom.Col = 1
    'txtCampo(2).Text = grdParamCobCom.Text
    
    grdParamCobCom.Col = 2
    txtCampo(3).Text = grdParamCobCom.Text
    txtCampo_LostFocus (3)
    
    
    grdParamCobCom.Col = 3
    txtCampo(4).Text = grdParamCobCom.Text
    txtCampo_LostFocus (4)
    
    
    grdParamCobCom.Col = 4
    txtTotTrans.Text = grdParamCobCom.Text
    
    grdParamCobCom.Col = 5
    txtCredito.Text = grdParamCobCom.Text
    
    grdParamCobCom.Col = 6
    txtDebito.Text = grdParamCobCom.Text

    grdParamCobCom.Col = 7
    txtConsulta.Text = grdParamCobCom.Text
    
    grdParamCobCom.Col = 8
    mskFecha.Mask = FMMascaraFecha(VLFormatoFecha$)
    mskFecha.Text = Format$(grdParamCobCom.Text, VGFormatoFecha)
    
    grdParamCobCom.Col = 9
    If grdParamCobCom.Text = "V" Then
     cmbEstado.ListIndex = 0
    Else
     cmbEstado.ListIndex = 1
    End If
    
End Sub

Sub PMMarcarRegistroTx()
    grdParamTrans.Col = 1
    txtCampo(0).Text = grdParamTrans.Text
    txtCampo_LostFocus (0)
    grdParamTrans.Col = 2
    txtNumTrn.Text = grdParamTrans.Text
    'Canal
    grdParamTrans.Col = 4
    txtCanal.Text = grdParamTrans.Text
    txtCanal_LostFocus
    If txtCanal.Text = "" Then
        lblDesCanal.Caption = ""
    End If
    'Causal
    grdParamTrans.Col = 6
    txtCausal.Text = grdParamTrans.Text
    txtCausal_LostFocus
    If txtCausal.Text = "" Then
        lblDesCausal.Caption = ""
    End If
    'Monto
    grdParamTrans.Col = 8
    'mskMonto.Mask = ""
    'mskMonto.Text = ""
    If grdParamTrans.Text = "" Then
       grdParamTrans.Text = 0
    End If
    mskMonto.Mask = grdParamTrans.Text
    'mskMonto.Mask = "###,###,###.00"
    
    'Estado
    grdParamTrans.Col = 9
    lblEstado.Caption = grdParamTrans.Text
    'Descripcion Estado
    grdParamTrans.Col = 10
    lblDesEstado.Caption = grdParamTrans.Text
End Sub

Private Sub txtCanal_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Canales [F5] Ayuda"
End Sub
Private Sub txtCanal_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode% = VGTeclaAyuda% Then
        PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "re_canales"
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de Tipo de Cobro " & "[" & txtCampo(4).Text & "]") Then
           PMMapeaListaH sqlconn&, FCatalogo.lstCatalogo, False
           PMChequea sqlconn&
           FCatalogo.Show 1
           txtCanal.Text = VGACatalogo.Codigo$
           lblDesCanal.Caption = VGACatalogo.Descripcion$
           If txtCanal.Text <> "" Then
              txtCanal.SetFocus
           End If
        Else
            txtCanal.Text = ""
            lblDesCanal.Caption = ""
            txtCanal.SetFocus
        End If
    End If
End Sub

Private Sub txtCanal_KeyPress(KeyAscii As Integer)
    If (KeyAscii% < 48 And KeyAscii% <> 8 And KeyAscii% <> 9) Or KeyAscii% > 57 Then
       KeyAscii% = 0
    End If
End Sub

Private Sub txtCanal_LostFocus()
    txtCanal.Text = Trim$(txtCanal.Text)
    If txtCanal.Text <> "" Then
        PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR&, "re_canales"
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V"
        PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR&, (txtCanal.Text)
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, "") Then
            PMMapeaObjeto sqlconn&, lblDesCanal
            PMChequea sqlconn&
        Else
           txtCanal.Text = ""
           lblDesCanal.Caption = ""
        End If
    End If
End Sub

Private Sub txtCausal_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Causales [F5] Ayuda"
End Sub

Private Sub txtCausal_KeyDown(KeyCode As Integer, Shift As Integer)
Dim VLTabla$
    If KeyCode% = VGTeclaAyuda% Then
        If txtCampo(0).Text <> "" Then
            If txtCampo(0).Text = 264 Or txtCampo(0).Text = 253 Then
                If txtCampo(0).Text = 264 Then
                    VLTabla$ = "ah_causa_nd"
                End If
                If txtCampo(0).Text = 253 Then
                    VLTabla$ = "ah_causa_nc"
                End If
                PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VLTabla$
                PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
                PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
                If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de Tipo de Cobro " & "[" & txtCampo(4).Text & "]") Then
                   PMMapeaListaH sqlconn&, FCatalogo.lstCatalogo, False
                   PMChequea sqlconn&
                   FCatalogo.Show 1
                   txtCausal.Text = VGACatalogo.Codigo$
                   lblDesCausal.Caption = VGACatalogo.Descripcion$
                   If txtCausal.Text <> "" Then
                      txtCausal.SetFocus
                   End If
                Else
                    txtCausal.Text = ""
                    lblDesCausal.Caption = ""
                    txtCausal.SetFocus
                End If
            End If
        End If
    End If
End Sub

Private Sub txtCausal_LostFocus()
Dim VLTabla$
    If txtCausal.Text <> "" Then
        If txtCampo(0).Text = "" Then
            MsgBox "La Transaccion es Mandatoria", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            txtCausal.Text = ""
            Exit Sub
        End If
        If txtCampo(0).Text = 264 Or txtCampo(0).Text = 253 Then
            If txtCampo(0).Text = 264 Then
                VLTabla$ = "ah_causa_nd"
            End If
            If txtCampo(0).Text = 253 Then
                VLTabla$ = "ah_causa_nc"
            End If
            PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VLTabla$
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V"
            PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR&, (txtCausal.Text)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de Tipo de Cobro " & "[" & txtCampo(4).Text & "]") Then
                PMMapeaObjeto sqlconn&, lblDesCausal
                PMChequea sqlconn&
            Else
                txtCausal.Text = ""
                lblDesCausal.Caption = ""
                txtCausal.SetFocus
            End If
        Else
            txtCausal.Text = ""
            lblDesCausal.Caption = ""
            txtNumTrn.SetFocus
        End If
    Else
        lblDesCausal.Caption = ""
    End If
End Sub

Private Sub txtConsulta_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Cantidad Consulta"
End Sub

Private Sub txtCredito_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Cantidad Crédito"
End Sub

Private Sub txtDebito_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Cantidad Débito"
End Sub


Private Sub txtNumTrn_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Cantidad Transacciones"
End Sub

Private Sub txtNumTrn_KeyPress(KeyAscii As Integer)
    If (KeyAscii% < 48 And KeyAscii% <> 8 And KeyAscii% <> 9) Or KeyAscii% > 57 Then
       KeyAscii% = 0
    End If
End Sub

Private Sub txtTotTrans_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Total Transacción"
End Sub


