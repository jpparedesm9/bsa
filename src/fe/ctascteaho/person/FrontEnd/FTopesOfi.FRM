VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#7.0#0"; "MhRealInput.ocx"
Object = "{9AED8C43-3F39-11D1-8BB4-0000C039C248}#2.0#0"; "txtin.ocx"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Begin VB.Form FTopesOfi 
   Appearance      =   0  'Flat
   Caption         =   "Topes de Retiro por Canal"
   ClientHeight    =   8160
   ClientLeft      =   885
   ClientTop       =   1350
   ClientWidth     =   9330
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H8000000D&
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   8160
   ScaleWidth      =   9330
   Begin TabDlg.SSTab MhTListaLimites 
      Height          =   4695
      Left            =   120
      TabIndex        =   1
      Top             =   480
      Width           =   8400
      _ExtentX        =   14817
      _ExtentY        =   8281
      _Version        =   393216
      Tab             =   2
      TabsPerRow      =   5
      TabHeight       =   520
      TabCaption(0)   =   "Límites de Oficina"
      Tab(0).ControlEnabled=   0   'False
      Tab(0).Control(0)=   "lblEtiqueta(0)"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "Frame2(0)"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "Frame3(1)"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "TextValid"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).ControlCount=   4
      TabCaption(1)   =   "Límites Origen-Especie"
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "Frame2(1)"
      Tab(1).Control(0).Enabled=   0   'False
      Tab(1).ControlCount=   1
      TabCaption(2)   =   "Causales Origen- Especie"
      Tab(2).ControlEnabled=   -1  'True
      Tab(2).Control(0)=   "grdVariables2(0)"
      Tab(2).Control(0).Enabled=   0   'False
      Tab(2).Control(1)=   "Frame1"
      Tab(2).Control(1).Enabled=   0   'False
      Tab(2).Control(2)=   "FrmOE"
      Tab(2).Control(2).Enabled=   0   'False
      Tab(2).ControlCount=   3
      Begin VB.Frame FrmOE 
         Enabled         =   0   'False
         Height          =   975
         Left            =   240
         TabIndex        =   48
         Top             =   615
         Width           =   7575
         Begin VB.Label LblEspecie22 
            Appearance      =   0  'Flat
            BorderStyle     =   1  'Fixed Single
            Enabled         =   0   'False
            ForeColor       =   &H80000008&
            Height          =   285
            Left            =   960
            TabIndex        =   54
            Top             =   540
            Width           =   975
         End
         Begin VB.Label LblOrigen22 
            Appearance      =   0  'Flat
            BorderStyle     =   1  'Fixed Single
            Enabled         =   0   'False
            ForeColor       =   &H80000008&
            Height          =   285
            Left            =   960
            TabIndex        =   53
            Top             =   240
            Width           =   975
         End
         Begin VB.Label LblEspecie2 
            Appearance      =   0  'Flat
            BorderStyle     =   1  'Fixed Single
            Enabled         =   0   'False
            ForeColor       =   &H80000008&
            Height          =   285
            Left            =   1950
            TabIndex        =   52
            Top             =   540
            Width           =   5415
         End
         Begin VB.Label lblEtiqueta 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Especie:"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   10
            Left            =   120
            TabIndex        =   51
            Top             =   560
            Width           =   750
         End
         Begin VB.Label LblOrigen2 
            Appearance      =   0  'Flat
            BorderStyle     =   1  'Fixed Single
            Enabled         =   0   'False
            ForeColor       =   &H80000008&
            Height          =   285
            Left            =   1950
            TabIndex        =   50
            Top             =   240
            Width           =   5415
         End
         Begin VB.Label lblEtiqueta 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Origen:"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   9
            Left            =   120
            TabIndex        =   49
            Top             =   240
            Width           =   630
         End
      End
      Begin VB.TextBox TextValid 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   -71640
         TabIndex        =   13
         Top             =   255
         Width           =   1215
      End
      Begin VB.Frame Frame1 
         Caption         =   "Causales asociadas a Origen - Especie"
         ForeColor       =   &H000000FF&
         Height          =   4095
         Left            =   120
         TabIndex        =   35
         Top             =   15
         Width           =   8055
         Begin VB.CommandButton BtnBuscarCau 
            Caption         =   "Buscar"
            Height          =   375
            Left            =   6960
            TabIndex        =   47
            Top             =   2400
            Width           =   1005
         End
         Begin VB.CommandButton BtnEliminarCau 
            Caption         =   "Eliminar"
            Height          =   375
            Left            =   6960
            TabIndex        =   46
            Tag             =   "736"
            Top             =   3180
            Width           =   1005
         End
         Begin VB.CommandButton BtnAgregarCau 
            Caption         =   "Agregar"
            Height          =   375
            Left            =   6960
            TabIndex        =   43
            Tag             =   "736"
            Top             =   2760
            Width           =   1005
         End
         Begin MSGrid.Grid grdCausales 
            Height          =   2235
            Left            =   120
            TabIndex        =   42
            Top             =   1800
            Width           =   6735
            _Version        =   65536
            _ExtentX        =   11880
            _ExtentY        =   3942
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
         Begin TxtinLib.TextValid TextCausal 
            Height          =   285
            Left            =   1080
            TabIndex        =   40
            Top             =   240
            Width           =   975
            _Version        =   65536
            _ExtentX        =   1711
            _ExtentY        =   503
            _StockProps     =   253
            BorderStyle     =   1
            Range           =   ""
            MaxLength       =   0
            Character       =   0
            Type            =   0
            HelpLine        =   ""
            Pendiente       =   ""
            Connection      =   0
            AsociatedLabelIndex=   0
            TableName       =   "ah_causa_nd"
            MinChar         =   0
            Error           =   0
         End
         Begin VB.Label lblEtiqueta 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Causal:"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   8
            Left            =   120
            TabIndex        =   44
            Top             =   240
            Width           =   645
         End
         Begin VB.Label lblCausal 
            Appearance      =   0  'Flat
            BorderStyle     =   1  'Fixed Single
            Enabled         =   0   'False
            ForeColor       =   &H80000008&
            Height          =   285
            Left            =   2065
            TabIndex        =   41
            Top             =   240
            Width           =   5415
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Límites por Origen-Especie"
         ForeColor       =   &H000000FF&
         Height          =   4245
         Index           =   1
         Left            =   -74880
         TabIndex        =   15
         Top             =   15
         Width           =   8055
         Begin VB.Frame FrmLImD 
            Caption         =   "Límites Diarios"
            ForeColor       =   &H000000FF&
            Height          =   975
            Left            =   0
            TabIndex        =   55
            Top             =   840
            Width           =   7815
            Begin MhinrelLib.MhRealInput mskNumTx 
               BeginProperty DataFormat 
                  Type            =   1
                  Format          =   "999"
                  HaveTrueFalseNull=   0
                  FirstDayOfWeek  =   0
                  FirstWeekOfYear =   0
                  LCID            =   9226
                  SubFormatType   =   0
               EndProperty
               Height          =   285
               Left            =   2520
               TabIndex        =   56
               Top             =   240
               Width           =   1305
               _Version        =   458753
               _ExtentX        =   2302
               _ExtentY        =   503
               _StockProps     =   205
               ForeColor       =   -2147483630
               Enabled         =   -1  'True
               FillColor       =   16777215
               MaxReal         =   999
               MinReal         =   0
               SpinChangeReal  =   0
               AutoHScroll     =   -1  'True
               CaretColor      =   -2147483642
               CaretVisible    =   -1  'True
               DecimalPlaces   =   0
               Separator       =   -1  'True
               TextRaw         =   "0"
            End
            Begin MhinrelLib.MhRealInput mskMontoRetiro 
               Height          =   285
               Left            =   2520
               TabIndex        =   57
               Top             =   600
               Width           =   2385
               _Version        =   458753
               _ExtentX        =   4207
               _ExtentY        =   503
               _StockProps     =   205
               ForeColor       =   -2147483630
               Enabled         =   -1  'True
               FillColor       =   16777215
               MaxReal         =   20
               MinReal         =   0
               SpinChangeReal  =   0
               AutoHScroll     =   -1  'True
               CaretColor      =   -2147483642
               CaretVisible    =   -1  'True
               DecimalPlaces   =   2
               Separator       =   -1  'True
            End
            Begin VB.Label lblEtiqueta 
               Appearance      =   0  'Flat
               AutoSize        =   -1  'True
               BackStyle       =   0  'Transparent
               Caption         =   "Número de Transacciones:"
               ForeColor       =   &H00800000&
               Height          =   195
               Index           =   5
               Left            =   120
               TabIndex        =   59
               Top             =   240
               Width           =   2295
            End
            Begin VB.Label lblEtiqueta 
               Appearance      =   0  'Flat
               AutoSize        =   -1  'True
               BackStyle       =   0  'Transparent
               Caption         =   "Monto en Retiros:"
               ForeColor       =   &H00800000&
               Height          =   195
               Index           =   6
               Left            =   120
               TabIndex        =   58
               Top             =   630
               Width           =   1530
            End
         End
         Begin VB.CommandButton BtnEliminarLim 
            Caption         =   "Eliminar"
            Height          =   375
            Left            =   6960
            TabIndex        =   39
            Tag             =   "735"
            Top             =   3180
            Width           =   1005
         End
         Begin VB.CommandButton BtnBuscarLim 
            Caption         =   "Buscar"
            Height          =   375
            Left            =   6960
            TabIndex        =   38
            Top             =   2400
            Width           =   1005
         End
         Begin TxtinLib.TextValid TextOrigen 
            Height          =   285
            Left            =   1080
            TabIndex        =   31
            Top             =   240
            Width           =   970
            _Version        =   65536
            _ExtentX        =   1711
            _ExtentY        =   503
            _StockProps     =   253
            BorderStyle     =   1
            Range           =   ""
            MaxLength       =   10
            Character       =   0
            Type            =   0
            HelpLine        =   ""
            Pendiente       =   ""
            Connection      =   0
            AsociatedLabelIndex=   0
            TableName       =   "pe_lt_origen"
            MinChar         =   0
            Error           =   0
         End
         Begin VB.CommandButton BtnAgregarLim 
            Caption         =   "Agregar"
            Height          =   375
            Left            =   6960
            TabIndex        =   37
            Tag             =   "735"
            Top             =   2760
            Width           =   1005
         End
         Begin MSGrid.Grid grdLimites 
            Height          =   2235
            Left            =   0
            TabIndex        =   36
            Top             =   1800
            Width           =   6855
            _Version        =   65536
            _ExtentX        =   12091
            _ExtentY        =   3942
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
         Begin TxtinLib.TextValid TextEspecie 
            Height          =   285
            Left            =   1080
            TabIndex        =   33
            Top             =   540
            Width           =   970
            _Version        =   65536
            _ExtentX        =   1711
            _ExtentY        =   503
            _StockProps     =   253
            BorderStyle     =   1
            Range           =   ""
            MaxLength       =   10
            Character       =   0
            Type            =   0
            HelpLine        =   ""
            Pendiente       =   ""
            Connection      =   0
            AsociatedLabelIndex=   0
            TableName       =   "pe_lt_especie"
            MinChar         =   0
            Error           =   0
         End
         Begin VB.Label lblEspecie 
            Appearance      =   0  'Flat
            BorderStyle     =   1  'Fixed Single
            Enabled         =   0   'False
            ForeColor       =   &H80000008&
            Height          =   285
            Left            =   2065
            TabIndex        =   34
            Top             =   540
            Width           =   5715
         End
         Begin VB.Label lblOrigen 
            Appearance      =   0  'Flat
            BorderStyle     =   1  'Fixed Single
            Enabled         =   0   'False
            ForeColor       =   &H80000008&
            Height          =   285
            Left            =   2065
            TabIndex        =   32
            Top             =   240
            Width           =   5715
         End
         Begin VB.Label lblEtiqueta 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Especie:"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   4
            Left            =   120
            TabIndex        =   20
            Top             =   560
            Width           =   750
         End
         Begin VB.Label lblEtiqueta 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Origen:"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   3
            Left            =   120
            TabIndex        =   18
            Top             =   240
            Width           =   630
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Límites en otras Oficinas"
         ForeColor       =   &H000000FF&
         Height          =   1725
         Index           =   1
         Left            =   -74880
         TabIndex        =   5
         Top             =   2415
         Width           =   8055
         Begin VB.CheckBox Check4 
            Caption         =   "Chq. Gerencia"
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   120
            TabIndex        =   23
            Top             =   900
            Width           =   1935
         End
         Begin VB.CheckBox Check3 
            Caption         =   "Efectivo"
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   120
            TabIndex        =   21
            Top             =   600
            Width           =   1575
         End
         Begin MhinrelLib.MhRealInput mskMonto 
            Height          =   285
            Index           =   3
            Left            =   3240
            TabIndex        =   22
            Top             =   600
            Width           =   2385
            _Version        =   458753
            _ExtentX        =   4207
            _ExtentY        =   503
            _StockProps     =   205
            ForeColor       =   -2147483630
            Enabled         =   0   'False
            FillColor       =   16777215
            MaxReal         =   0
            MinReal         =   0
            SpinChangeReal  =   0
            AutoHScroll     =   -1  'True
            CaretColor      =   -2147483642
            CaretVisible    =   -1  'True
            DecimalPlaces   =   2
            Separator       =   -1  'True
         End
         Begin MhinrelLib.MhRealInput mskMonto 
            Height          =   285
            Index           =   4
            Left            =   3240
            TabIndex        =   24
            Top             =   900
            Width           =   2385
            _Version        =   458753
            _ExtentX        =   4207
            _ExtentY        =   503
            _StockProps     =   205
            ForeColor       =   -2147483630
            Enabled         =   0   'False
            FillColor       =   16777215
            MaxReal         =   0
            MinReal         =   0
            SpinChangeReal  =   0
            AutoHScroll     =   -1  'True
            CaretColor      =   -2147483642
            CaretVisible    =   -1  'True
            DecimalPlaces   =   2
            Separator       =   -1  'True
         End
         Begin VB.Label lblDescripcionOo 
            Appearance      =   0  'Flat
            Caption         =   "Valor Ref :"
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
            Height          =   345
            Index           =   2
            Left            =   2280
            TabIndex        =   7
            Top             =   910
            WhatsThisHelpID =   5455
            Width           =   1455
            WordWrap        =   -1  'True
         End
         Begin VB.Label lblDescripcionOo 
            Appearance      =   0  'Flat
            Caption         =   "Valor Ref :"
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
            Height          =   345
            Index           =   1
            Left            =   2280
            TabIndex        =   6
            Top             =   600
            WhatsThisHelpID =   5455
            Width           =   1455
            WordWrap        =   -1  'True
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Límites en la Oficina Radicadora"
         ForeColor       =   &H000000FF&
         Height          =   1605
         Index           =   0
         Left            =   -74880
         TabIndex        =   2
         Top             =   735
         Width           =   8055
         Begin VB.CheckBox Check1 
            Caption         =   "Efectivo"
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   120
            TabIndex        =   14
            Top             =   600
            Width           =   1575
         End
         Begin VB.CheckBox Check2 
            Caption         =   "Chq. Gerencia"
            ForeColor       =   &H00800000&
            Height          =   255
            Left            =   120
            TabIndex        =   17
            Top             =   900
            Width           =   1935
         End
         Begin MhinrelLib.MhRealInput mskMonto 
            Height          =   285
            Index           =   1
            Left            =   3240
            TabIndex        =   16
            Top             =   600
            Width           =   2385
            _Version        =   458753
            _ExtentX        =   4207
            _ExtentY        =   503
            _StockProps     =   205
            ForeColor       =   -2147483630
            Enabled         =   0   'False
            FillColor       =   16777215
            MaxReal         =   0
            MinReal         =   0
            SpinChangeReal  =   0
            AutoHScroll     =   -1  'True
            CaretColor      =   -2147483642
            CaretVisible    =   -1  'True
            DecimalPlaces   =   2
            Separator       =   -1  'True
         End
         Begin MhinrelLib.MhRealInput mskMonto 
            Height          =   285
            Index           =   2
            Left            =   3240
            TabIndex        =   19
            Top             =   900
            Width           =   2385
            _Version        =   458753
            _ExtentX        =   4207
            _ExtentY        =   503
            _StockProps     =   205
            ForeColor       =   -2147483630
            Enabled         =   0   'False
            FillColor       =   16777215
            MaxReal         =   0
            MinReal         =   0
            SpinChangeReal  =   0
            AutoHScroll     =   -1  'True
            CaretColor      =   -2147483642
            CaretVisible    =   -1  'True
            DecimalPlaces   =   2
            Separator       =   -1  'True
         End
         Begin VB.Label lblDescripcion 
            Appearance      =   0  'Flat
            Caption         =   "Valor Ref :"
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
            Height          =   345
            Index           =   1
            Left            =   2280
            TabIndex        =   4
            Top             =   600
            WhatsThisHelpID =   5455
            Width           =   1455
            WordWrap        =   -1  'True
         End
         Begin VB.Label lblDescripcion 
            Appearance      =   0  'Flat
            Caption         =   "Valor Ref :"
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
            Height          =   345
            Index           =   2
            Left            =   2280
            TabIndex        =   3
            Top             =   910
            WhatsThisHelpID =   5455
            Width           =   1455
            WordWrap        =   -1  'True
         End
      End
      Begin MSGrid.Grid grdVariables2 
         Height          =   2865
         Index           =   0
         Left            =   960
         TabIndex        =   27
         Top             =   6135
         Width           =   7935
         _Version        =   65536
         _ExtentX        =   13996
         _ExtentY        =   5054
         _StockProps     =   77
         ForeColor       =   0
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
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Cantidad de Transacciones:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   0
         Left            =   -74760
         TabIndex        =   12
         Top             =   255
         Width           =   2400
      End
   End
   Begin VB.ComboBox cmbTipo 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   5400
      Style           =   2  'Dropdown List
      TabIndex        =   11
      Top             =   120
      Width           =   2925
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
      Index           =   0
      Left            =   8430
      Picture         =   "FTopesOfi.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   0
      Tag             =   "4129"
      Top             =   45
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
      Index           =   1
      Left            =   8400
      Picture         =   "FTopesOfi.frx":0262
      Style           =   1  'Graphical
      TabIndex        =   25
      Tag             =   "4128"
      Top             =   1440
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
      Index           =   5
      Left            =   8430
      Picture         =   "FTopesOfi.frx":056C
      Style           =   1  'Graphical
      TabIndex        =   26
      Tag             =   "4128"
      Top             =   2220
      Width           =   870
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
      Height          =   735
      Index           =   2
      Left            =   8430
      Picture         =   "FTopesOfi.frx":0876
      Style           =   1  'Graphical
      TabIndex        =   28
      Tag             =   "4128"
      Top             =   2970
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
      Index           =   4
      Left            =   8430
      Picture         =   "FTopesOfi.frx":0BDC
      Style           =   1  'Graphical
      TabIndex        =   30
      Top             =   4455
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
      Index           =   3
      Left            =   8430
      Picture         =   "FTopesOfi.frx":0F42
      Style           =   1  'Graphical
      TabIndex        =   29
      Top             =   3705
      Width           =   870
   End
   Begin MSGrid.Grid grdVariables 
      Height          =   555
      Left            =   4680
      TabIndex        =   45
      Top             =   4440
      Width           =   3375
      _Version        =   65536
      _ExtentX        =   5953
      _ExtentY        =   979
      _StockProps     =   77
      ForeColor       =   0
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
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8400
      X2              =   8400
      Y1              =   0
      Y2              =   5400
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Producto: "
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   4080
      TabIndex        =   10
      Top             =   120
      Width           =   900
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   960
      TabIndex        =   9
      Top             =   120
      Width           =   915
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Código:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   240
      TabIndex        =   8
      Top             =   120
      Width           =   660
   End
End
Attribute VB_Name = "FTopesOfi"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010

'*************************************************************
' ARCHIVO:          FTopesOfi.FRM
' NOMBRE LOGICO:    FTopesOfi
' PRODUCTO:         Personalización
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
' Realiza el mantenimiento de las Categorías por Producto Final
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR               RAZON
' 13-Jun-2011   Saira Molano    Emisión Inicial
' 27-May-2014   Luisa Bernal    REQ 413-COntrol Limites TX
'*************************************************************
Dim VLPaso As Integer

Dim MhTListaLimitesCurrentTab As Integer
Private Sub Form_Load()

'! removed Dim VLOrigen As String

'! removed Dim VLEspecie As String

'! removed Dim VLDescOrigen As String

'! removed Dim VLDescEspecie As String
Dim VLGrid%
  
   
    FTopesOfi.Left = 15
    FTopesOfi.Top = 15
    FTopesOfi.Width = 9420
    FTopesOfi.Height = 5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    PMBotonSeguridad FTopesOfi, 5   ' Chequeo de Seguridades a nivel de Botón
    cmbTipo.AddItem "CUENTA DE AHORRO", 0
    cmbTipo.AddItem "CUENTA CORRIENTE", 1
    cmbTipo.ListIndex = 0
    VLGrid% = 0
   
    Set TextOrigen.AsociatedLabel = lblOrigen  'REQ 412
    TextOrigen.Connection = VGMap
    Set TextEspecie.AsociatedLabel = lblEspecie   'REQ 412
    TextEspecie.Connection = VGMap
    Set TextCausal.AsociatedLabel = lblCausal    'REQ 412
    TextCausal.Connection = VGMap
        
   MhTListaLimitesCurrentTab = 2
   MhTListaLimites.Tab = 2
   MhTListaLimites.TabEnabled(MhTListaLimitesCurrentTab) = False
   MhTListaLimitesCurrentTab = 0
   MhTListaLimites.Tab = 0
   
End Sub

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
    Case 0
         PLBuscar
     Case 1
         PLTransmitir
     Case 2
         PLEliminar
     Case 3
        PLLimpiar
     Case 4
        Unload FTopesOfi
     Case 5
        PLActualizar
     End Select
End Sub
Private Sub Check1_Click()
If Check1.Value = False Then
    mskMonto(1).Text = "0"
    mskMonto(1).Enabled = False

Else
    mskMonto(1).Enabled = True
End If
End Sub

Private Sub Check2_Click()
If Check2.Value = False Then
    mskMonto(2).Text = "0"
    mskMonto(2).Enabled = False
Else
    mskMonto(2).Enabled = True
End If
End Sub
Private Sub Check3_Click()
If Check3.Value = False Then
    mskMonto(3).Text = "0"
    mskMonto(3).Enabled = False
Else
    mskMonto(3).Enabled = True
End If
End Sub
Private Sub Check4_Click() ' REQ 412
If Check4.Value = False Then
    mskMonto(4).Text = "0"
    mskMonto(4).Enabled = False
Else
    mskMonto(4).Enabled = True
End If
End Sub
Private Sub Form_Activate()

  
    MhTListaLimites.Tab = 0
    MhTListaLimitesCurrentTab = 0
    mskMonto(1).Enabled = False  'REQ 412
    mskMonto(2).Enabled = False  'REQ 412
    mskMonto(3).Enabled = False  'REQ 412
    mskMonto(4).Enabled = False  'REQ 412
    cmdBoton(5).Enabled = False  'REQ 412
    cmdBoton(2).Enabled = False  'REQ 412
    
    
   'validación para habilitar pestaña de causales
   
   If MhTListaLimites.Tab = 1 Then
  
      If grdLimites.Text = "" Or grdLimites.Row = 0 Then
         MhTListaLimitesCurrentTab = 2
         MhTListaLimites.Tab = 2
         MhTListaLimites.TabEnabled(MhTListaLimitesCurrentTab) = False
         
         MhTListaLimitesCurrentTab = 1
         MhTListaLimites.Tab = 1
       
      End If
   End If
   
   If MhTListaLimites.Tab = 0 Then
      cmdBoton(0).Enabled = True
           'REQ 412
       mskMonto(1).Enabled = False
       mskMonto(2).Enabled = False
       mskMonto(3).Enabled = False
       mskMonto(4).Enabled = False
       
       MhTListaLimitesCurrentTab = 0
       MhTListaLimites.Tab = 0
         
   Else
      cmdBoton(0).Enabled = False
   End If
    
End Sub

Private Sub PLLimpiar()
'*************************************************************
' PROPOSITO: Limpia todos los valores de los objetos y del
'            grid de la forma.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 13-Jun-2011    Saira Molano    Emisión Inicial
'*************************************************************
MhTListaLimitesCurrentTab = 0
PMLimpiaGrid grdVariables
TextValid.Text = ""

cmbTipo.ListIndex = 0
mskMonto(1).Text = "0.00"
mskMonto(2).Text = "0.00"
mskMonto(3).Text = "0.00"
mskMonto(4).Text = "0.00"
  
Check1.Value = "0"
Check2.Value = "0"
Check3.Value = "0" 'REQ 412
Check4.Value = "0"  'REQ 412
lblDescripcion(0).Caption = ""
cmbTipo.Enabled = True
cmdBoton(2).Enabled = False
cmdBoton(5).Enabled = False
cmdBoton(1).Enabled = True


MhTListaLimitesCurrentTab = 1
MhTListaLimites.TabEnabled(MhTListaLimitesCurrentTab) = True
PMLimpiaGrid grdLimites ' REQ 412
mskNumTx.Text = "0"
mskMontoRetiro = "0.00"


'Se limpian campos de pestaña de limites REQ 412

TextOrigen.Text = ""    'REQ 412
lblOrigen.Caption = ""  'REQ 412
TextEspecie.Text = ""   'REQ 412
lblEspecie.Caption = "" 'REQ 412
TextCausal.Text = ""    'REQ 412
lblCausal.Caption = ""  'REQ 412
mskNumTx.Text = ""   'REQ 412
mskMontoRetiro.Text = "" 'REQ 412

'Se deshabilita pestaña de causales REQ 412
MhTListaLimites.Tab = 2
MhTListaLimitesCurrentTab = 2
PMLimpiaGrid grdCausales
MhTListaLimites.TabEnabled(MhTListaLimitesCurrentTab) = False

MhTListaLimites.Tab = 1
MhTListaLimitesCurrentTab = 1
MhTListaLimites.TabEnabled(MhTListaLimitesCurrentTab) = True

MhTListaLimites.Tab = 0
MhTListaLimitesCurrentTab = 0
MhTListaLimites.TabEnabled(MhTListaLimitesCurrentTab) = True

TextValid.SetFocus

End Sub

'REQ 412
Private Sub grdLimites_DblClick()
   Dim VLOrigen As String
   Dim VLEspecie  As String
   Dim VLDescOrigen As String
   Dim VLDescEspecie As String
    grdLimites.Col = 1
    If grdLimites.Text = "" Then
       MsgBox "No está seleccionando un registro"
       TextOrigen.SetFocus
       Exit Sub
    End If
    
       TextOrigen.Text = grdLimites.Text
    grdLimites.Col = 2
       lblOrigen.Caption = grdLimites.Text
    grdLimites.Col = 3
       TextEspecie.Text = grdLimites.Text
    grdLimites.Col = 4
       lblEspecie.Caption = grdLimites.Text
    grdLimites.Col = 5
       mskNumTx.Text = grdLimites.Text
    grdLimites.Col = 6
       mskMontoRetiro.Text = grdLimites.Text
   
   
   MhTListaLimitesCurrentTab = 1
   MhTListaLimites.TabEnabled(MhTListaLimitesCurrentTab) = True
   VLOrigen = TextOrigen
   VLEspecie = TextEspecie
   VLDescOrigen = lblOrigen
   VLDescEspecie = lblEspecie
   MhTListaLimitesCurrentTab = 2
   MhTListaLimites.Tab = 2
   MhTListaLimites.TabEnabled(MhTListaLimitesCurrentTab) = True
   Frame1.Enabled = True
   TextCausal.Enabled = True
   TextCausal.SetFocus
         
   LblOrigen22.Caption = VLOrigen
   LblEspecie22.Caption = VLEspecie
   LblOrigen2.Caption = VLDescOrigen
   LblEspecie2.Caption = VLDescEspecie
   BtnBuscarCau_Click
   
End Sub
Private Sub PLBuscar()
PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 4129
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
If cmbTipo.ListIndex = 0 Then
   PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "4"
ElseIf cmbTipo.ListIndex = 1 Then
   PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "3"
End If
PMPasoValores sqlconn&, "@i_cantidad", 0, SQLINT1, TextValid
If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_topes_oficina", True, " Ok... Consulta de Topes de Oficina") Then
   PMMapeaGrid sqlconn&, grdVariables, False
   PMChequea sqlconn&
   grdVariables.Col = 1
   lblDescripcion(0).Caption = grdVariables.Text
   cmdBoton(2).Enabled = True
   cmdBoton(5).Enabled = True
   grdVariables.Col = 3
   TextValid.Text = grdVariables.Text
   
   'REQ 412
   cmdBoton(1).Enabled = False
      
   grdVariables.Col = 6
   If grdVariables.Text > 0 Then
      mskMonto(1).Text = grdVariables.Text
      Check1.Value = 1
    Else
       mskMonto(1).Enabled = False
   End If
   
   grdVariables.Col = 7
   If grdVariables.Text > 0 Then
      mskMonto(2).Text = grdVariables.Text
      Check2.Value = 1
   Else
       mskMonto(2).Enabled = False
   End If
   
    grdVariables.Col = 12
   If grdVariables.Text > 0 Then
      mskMonto(3).Text = grdVariables.Text
      Check3.Value = 1
   Else
      mskMonto(3).Enabled = False
   End If
   
    grdVariables.Col = 13
   If grdVariables.Text > 0 Then
      mskMonto(4).Text = grdVariables.Text
      Check4.Value = 1
   Else
      mskMonto(4).Enabled = False
   End If
   cmdBoton(5).Enabled = True  'REQ 412
   cmdBoton(2).Enabled = True  'REQ 412

End If
MhTListaLimites.Tab = 0
MhTListaLimitesCurrentTab = 0
TextValid.SetFocus

'validación para habilitar pestaña de causales

MhTListaLimitesCurrentTab = 1
MhTListaLimites.Tab = 1
If grdLimites.Text = "" Then
   MhTListaLimites.Tab = 2
   MhTListaLimitesCurrentTab = 2
   MhTListaLimites.TabEnabled(MhTListaLimitesCurrentTab) = False
End If

MhTListaLimitesCurrentTab = 1
MhTListaLimites.Tab = 1

   TextOrigen.Text = ""
   lblOrigen.Caption = ""
   TextEspecie.Text = ""
   lblEspecie.Caption = ""

MhTListaLimitesCurrentTab = 0
MhTListaLimites.Tab = 0
   
End Sub


Private Sub PLTransmitir()
 MhTListaLimites.Tab = 0  'Req 412

If TextValid.Text = "" Then
   MsgBox "El campo cantidad es mandatorio", 0 + 16, "Mensaje de Error"
   TextValid.SetFocus
   Exit Sub
End If
If Check1.Value = 1 And Int(mskMonto(1).Text) = "0" Then
   MsgBox "El Valor en efectivo es mandatorio", 0 + 16, "Mensaje de Error"
   TextValid.SetFocus
   Exit Sub
End If
If Int(mskMonto(1).Text) > "0.00" And Check1.Value = 0 Then
   Check1.Value = 1
End If
If Check2.Value = 1 And Int(mskMonto(2).Text) = "0.00" Then
   MsgBox "El Valor en Cheque de Gerencia es mandatorio", 0 + 16, "Mensaje de Error"
   TextValid.SetFocus
   Exit Sub
End If
If Int(mskMonto(2).Text) > "0.00" And Check2.Value = 0 Then
   Check2.Value = 1
End If
If Int(mskMonto(1).Text) = "0.00" And Check1.Value = 0 And Int(mskMonto(2).Text) = "0.00" And Check2.Value = 0 Then
   MsgBox "Por Favor Ingresar Tope para Efectivo Y/O Cheque", 0 + 16, "Mensaje de Error"
   TextValid.SetFocus
   Exit Sub
End If

'req 412
If Check3.Value = 1 And Int(mskMonto(3).Text) = "0" Then
   MsgBox "El Valor en efectivo es mandatorio", 0 + 16, "Mensaje de Error"
   TextValid.SetFocus
   Exit Sub
End If
If Int(mskMonto(3).Text) > "0.00" And Check3.Value = 0 Then
   Check3.Value = 1
End If
If Check4.Value = 1 And Int(mskMonto(4).Text) = "0.00" Then
   MsgBox "El Valor en Cheque de Gerencia es mandatorio", 0 + 16, "Mensaje de Error"
   TextValid.SetFocus
   Exit Sub
End If
If Int(mskMonto(4).Text) > "0.00" And Check4.Value = 0 Then
   Check4.Value = 1
End If
If Int(mskMonto(3).Text) = "0.00" And Check3.Value = 0 And Int(mskMonto(4).Text) = "0.00" And Check4.Value = 0 Then
   MsgBox "Por Favor Ingresar Tope para Efectivo Y/O Cheque para otras Oficinas", 0 + 16, "Mensaje de Error"
   TextValid.SetFocus
   Exit Sub
End If

'fin req 412

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 4128
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
If cmbTipo.ListIndex = 0 Then
   PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "4"
ElseIf cmbTipo.ListIndex = 1 Then
   PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "3"
End If
PMPasoValores sqlconn&, "@i_cantidad", 0, SQLINT1, TextValid
If Check1.Value = 1 Then
    PMPasoValores sqlconn&, "@i_efectivo", 0, SQLCHAR, "S"
    PMPasoValores sqlconn&, "@i_valor_efe", 0, SQLMONEY, mskMonto(1).Text
End If
If Check2.Value = 1 Then
    PMPasoValores sqlconn&, "@i_chq_ger", 0, SQLCHAR, "S"
    PMPasoValores sqlconn&, "@i_valor_chq", 0, SQLMONEY, mskMonto(2).Text
End If
If Check3.Value = 1 Then
    PMPasoValores sqlconn&, "@i_efectivo_otra", 0, SQLCHAR, "S"
    PMPasoValores sqlconn&, "@i_valor_efe_otra", 0, SQLMONEY, mskMonto(3).Text
End If
If Check4.Value = 1 Then
    PMPasoValores sqlconn&, "@i_chq_ger_otra", 0, SQLCHAR, "S"
    PMPasoValores sqlconn&, "@i_valor_chq_otra", 0, SQLMONEY, mskMonto(4).Text
End If
 
If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_topes_oficina", True, " Ok... Creación de Topes de Oficina") Then
   PMMapeaGrid sqlconn&, grdVariables, False
   PMChequea sqlconn&
   grdVariables.Col = 1
   lblDescripcion(0).Caption = grdVariables.Text
   cmdBoton(1).Enabled = False
   cmdBoton(2).Enabled = True
   cmdBoton(5).Enabled = True
   MsgBox "Registro creado correctamente"

End If

End Sub

'REQ 412
Private Sub grdCausales_DblClick()
    If grdCausales.Text = "" Then
       MsgBox "No está seleccionando un registro"
       TextCausal.SetFocus
       Exit Sub
    End If
    
   grdCausales.Col = 1
   TextCausal.Text = grdCausales.Text
   grdCausales.Col = 2
   lblCausal.Caption = grdCausales.Text
   
End Sub


'REQ 412
Private Sub MhTListaLimites_TabChangedHelper(NewFolder As Integer, OldFolder As Integer)
Dim VLOrigen As String
Dim VLEspecie As String
Dim VLDescOrigen As String
Dim VLDescEspecie As String

If NewFolder = 0 Then
  MhTListaLimites.Tab = 0
   MhTListaLimitesCurrentTab = 0

  MhTListaLimites.Enabled = True
  cmdBoton(0).Enabled = True
  Check1_Click
  Check2_Click
  Check3_Click
  Check4_Click
  cmdBoton(1).Enabled = True
  cmdBoton(2).Enabled = True
  cmdBoton(3).Enabled = True
  cmdBoton(5).Enabled = True
  
  
Else
  cmdBoton(0).Enabled = False
  cmdBoton(1).Enabled = False
  cmdBoton(2).Enabled = False
  cmdBoton(5).Enabled = False

  If NewFolder = 1 Then
     MhTListaLimites.Tab = 1
     MhTListaLimitesCurrentTab = 1
     MhTListaLimites.Enabled = True
     MhTListaLimites.TabEnabled(MhTListaLimitesCurrentTab) = True
    
     VLOrigen = TextOrigen
     VLEspecie = TextEspecie
     VLDescOrigen = lblOrigen
     VLDescEspecie = lblEspecie
   Else
  
   
   MhTListaLimitesCurrentTab = 1
   
   VLOrigen = TextOrigen
   VLEspecie = TextEspecie
   
   VLDescOrigen = lblOrigen.Caption
   VLDescEspecie = lblEspecie.Caption
   
 
   MhTListaLimites.Tab = 2
   MhTListaLimitesCurrentTab = 2
   MhTListaLimites.TabEnabled(MhTListaLimitesCurrentTab) = True
      
   TextCausal.Enabled = True
      
   TextCausal.Text = ""
   LblOrigen2.Caption = ""
   LblOrigen22.Caption = ""
   LblEspecie2.Caption = ""
   LblEspecie22.Caption = ""
   LblOrigen22.Caption = VLOrigen
   LblEspecie22.Caption = VLEspecie
   LblOrigen2.Caption = VLDescOrigen
   LblEspecie2.Caption = VLDescEspecie
     
   BtnBuscarCau_Click
   End If
End If

End Sub
Private Sub mskMonto_GotFocus(Index As Integer)
    Select Case Index%
    Case 1
        FPrincipal.pnlHelpLine.Caption = " Valor Tope Efectivo"
    Case 2
        FPrincipal.pnlHelpLine.Caption = " Valor Tope Cheque Gerencia"
    'REQ 412
    Case 3
        FPrincipal.pnlHelpLine.Caption = " Valor Tope Efectivo otras Oficinas"
    Case 4
        FPrincipal.pnlHelpLine.Caption = " Valor Tope Cheque Gerencia otras Oficinas"
    End Select
    'fin  REQ 412
    mskMonto(Index%).SelStart = 0
    mskMonto(Index%).SelLength = Len(mskMonto(Index%).Text)
End Sub

Private Sub mskMonto_KeyPress(Index As Integer, KeyAscii As Integer)
 Select Case Index%
 Case 1, 2, 3, 4
     If (KeyAscii < 48 Or KeyAscii > 57) And (KeyAscii <> 8) And (KeyAscii <> 46) Then
         KeyAscii = 0
     End If
     KeyAscii = FMValidarNumero((mskMonto(Index).Text), 16, KeyAscii, "105")
 End Select
End Sub
Function FMValidarNumero(parValor As String, parLongitud As Integer, parcaracter As Integer, parNemonico As String) As Integer

  Dim VTDecimal As Integer
  Dim VTSeparadorDecimal As String
  Dim CGTeclaMenos%
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
Private Sub PLActualizar()

MhTListaLimites.Tab = 0  ' Req 412
If TextValid.Text = "" Then
   MsgBox "El campo cantidad es mandatorio", 0 + 16, "Mensaje de Error"
End If
If Check1.Value = 1 And Int(mskMonto(1).Text) = "0.00" Then
   MsgBox "El Valor en efectivo es mandatorio", 0 + 16, "Mensaje de Error"
   mskMonto(1).SetFocus
   Exit Sub
End If
If Check2.Value = 1 And Int(mskMonto(2).Text) = "0.00" Then
   MsgBox "El Valor en Cheque de Gerencia es mandatorio", 0 + 16, "Mensaje de Error"
   mskMonto(2).SetFocus
   Exit Sub
End If

'REQ 412
If Check3.Value = 1 And Int(mskMonto(3).Text) = "0.00" Then
   MsgBox "El Valor en efectivo es mandatorio", 0 + 16, "Mensaje de Error"
   mskMonto(3).SetFocus
   Exit Sub
End If
If Check4.Value = 1 And Int(mskMonto(4).Text) = "0.00" Then
   MsgBox "El Valor en Cheque de Gerencia es mandatorio", 0 + 16, "Mensaje de Error"
   mskMonto(4).SetFocus
   Exit Sub
End If
If Int(mskMonto(1).Text) > "0.00" And Check1.Value = 0 Then
   Check1.Value = 1
   Exit Sub
End If
If Int(mskMonto(2).Text) > "0.00" And Check2.Value = 0 Then
   Check2.Value = 1
   Exit Sub
End If
'REQ 412
If Int(mskMonto(3).Text) > "0.00" And Check3.Value = 0 Then
   Check3.Value = 1
   Exit Sub
End If
If Int(mskMonto(4).Text) > "0.00" And Check4.Value = 0 Then
   Check4.Value = 1
   Exit Sub
End If

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 4128
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
If cmbTipo.ListIndex = 0 Then
   PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "4"
ElseIf cmbTipo.ListIndex = 1 Then
   PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "3"
End If
PMPasoValores sqlconn&, "@i_cantidad", 0, SQLINT1, TextValid
If Check1.Value = 1 Then
    PMPasoValores sqlconn&, "@i_efectivo", 0, SQLCHAR, "S"
    PMPasoValores sqlconn&, "@i_valor_efe", 0, SQLMONEY, mskMonto(1).Text
End If
If Check2.Value = 1 Then
    PMPasoValores sqlconn&, "@i_chq_ger", 0, SQLCHAR, "S"
    PMPasoValores sqlconn&, "@i_valor_chq", 0, SQLMONEY, mskMonto(2).Text
End If
If Int(mskMonto(1).Text) = "0.00" And Check1.Value = 0 And Int(mskMonto(2).Text) = "0.00" And Check2.Value = 0 Then
   MsgBox "Por Favor Ingresar Tope para Efectivo Y/O Cheque", 0 + 16, "Mensaje de Error"
   Check1.SetFocus
   'mskMonto(1).SetFocus
   Exit Sub
End If
'REQ 412
If Check3.Value = 1 Then
    PMPasoValores sqlconn&, "@i_efectivo_otra", 0, SQLCHAR, "S"
    PMPasoValores sqlconn&, "@i_valor_efe_otra", 0, SQLMONEY, mskMonto(3).Text
End If
If Check2.Value = 1 Then
    PMPasoValores sqlconn&, "@i_chq_ger_otra", 0, SQLCHAR, "S"
    PMPasoValores sqlconn&, "@i_valor_chq_otra", 0, SQLMONEY, mskMonto(4).Text
End If
If Int(mskMonto(3).Text) = "0.00" And Check1.Value = 0 And Int(mskMonto(4).Text) = "0.00" And Check4.Value = 0 Then
   MsgBox "Por Favor Ingresar Tope para Efectivo Y/O Cheque", 0 + 16, "Mensaje de Error"
   mskMonto(3).SetFocus
   Exit Sub
End If

'FIN REQ 412
    
If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_topes_oficina", True, " Ok... Creación de Topes de Oficina") Then
   PMMapeaGrid sqlconn&, grdVariables, False
   PMChequea sqlconn&
   grdVariables.Col = 1
   lblDescripcion(0).Caption = grdVariables.Text
   cmdBoton(2).Enabled = True
   cmdBoton(5).Enabled = True
    MsgBox "Registro actualizado correctamente"
End If
End Sub
Private Sub PLEliminar()
'*************************************************************
' PROPOSITO: Permite eliminar registro tope por oficina
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 15-Jun-2011    S.Molano        Emisión Inicial
'*************************************************************
Dim VLRespuesta%
MhTListaLimites.Tab = 0  ' Req 412
If grdVariables.Row > 0 Then
   VLRespuesta% = MsgBox("Esta Seguro de Eliminar el Registro " + " ?", 1 + 32 + 256, "Eliminar Registros")
   If VLRespuesta% = 2 Then
      Exit Sub
   End If
End If
PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 4128
If cmbTipo.ListIndex = 0 Then
   PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "4"
ElseIf cmbTipo.ListIndex = 1 Then
   PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "3"
End If
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_topes_oficina", True, " Ok... Eliminación Topes por Oficina") Then
   PMChequea sqlconn&
   PLLimpiar
   MsgBox "Eliminar el registro correctamente"
   TextValid.SetFocus
End If
End Sub

Private Sub BtnBuscarLim_Click()  'REQ 412
  
   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 4129
   PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "SO"
   PMPasoValores sqlconn&, "@i_lr_origen", 0, SQLINT2, TextOrigen.Text
   PMPasoValores sqlconn&, "@i_lr_especie", 0, SQLINT1, TextEspecie.Text
  
   If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_topes_oficina", True, " Ok... Consulta de Topes de Oficina") Then
      PMMapeaGrid sqlconn&, grdLimites, False
      PMChequea sqlconn&
      grdLimites.Col = 1
   End If
   
   If grdLimites.Text = "" Then
      MsgBox "No existen registros", 0 + 16, "Mensaje de Error"
   Exit Sub
      
   End If
   
End Sub
Private Sub BtnAgregarLim_Click()
   If TextOrigen = "" Then
      MsgBox "El campo origen es mandatorio", 0 + 16, "Mensaje de Error"
      Exit Sub
   End If
   If TextEspecie = "" Then
      MsgBox "El campo especie es mandatorio", 0 + 16, "Mensaje de Error"
      Exit Sub
   End If
   If mskNumTx = "" Then
      MsgBox "El campo número de transacciones es mandatorio", 0 + 16, "Mensaje de Error"
      Exit Sub
   End If
   If mskMontoRetiro = "" Then
      MsgBox "El campo monto en retiros es mandatorio", 0 + 16, "Mensaje de Error"
      Exit Sub
   End If
   
   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 4156
   PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "IO"
   PMPasoValores sqlconn&, "@i_lr_origen", 0, SQLINT2, TextOrigen.Text
   PMPasoValores sqlconn&, "@i_lr_especie", 0, SQLINT2, TextEspecie.Text
   PMPasoValores sqlconn&, "@i_lr_nro_transacciones", 0, SQLINT2, mskNumTx.Text
   PMPasoValores sqlconn&, "@i_lr_monto_transacciones", 0, SQLMONEY, mskMontoRetiro.Text
 
   If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_topes_oficina", True, " Ok... Creación de Topes de Oficina") Then
      PMMapeaGrid sqlconn&, grdLimites, False
      PMChequea sqlconn&
      grdLimites.Col = 1
 
      cmdBoton(1).Enabled = False
      cmdBoton(2).Enabled = True
      cmdBoton(5).Enabled = True
      MsgBox "El registro se agregó exitosamente", vbOKOnly, "MENSAJE"
       
   End If
   
  
   BtnBuscarLim_Click
   
End Sub
Private Sub BtnEliminarLim_Click()
   Dim VLRespuesta%
   
   If grdLimites.Text = "" Or grdLimites.Row = 0 Then
      MsgBox "No existen registros a eliminar"
      Exit Sub
   End If
   
   If grdLimites.Row > 0 Then
      VLRespuesta% = MsgBox("Esta Seguro de Eliminar el Registro " + " ?", 1 + 32 + 256, "Eliminar Registros")
      If VLRespuesta% = 2 Then
         Exit Sub
      End If
   End If
      
      
   MhTListaLimitesCurrentTab = 2
   BtnBuscarCau_Click
   grdCausales.Col = 1
   If grdCausales.Row = 0 Then
      
      MhTListaLimitesCurrentTab = 1
      PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 4156
      PMPasoValores sqlconn&, "@i_lr_origen", 0, SQLINT2, TextOrigen.Text
      PMPasoValores sqlconn&, "@i_lr_especie", 0, SQLINT1, TextEspecie.Text
      PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "DO"
   
      If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_topes_oficina", True, " Ok... Eliminación Topes por Oficina") Then
         PMChequea sqlconn&
      
         MhTListaLimitesCurrentTab = 1
         PMLimpiaGrid grdLimites
         mskNumTx.Text = "0"
         mskMontoRetiro = "0.00"
   
         MsgBox "El registro se eliminó exitosamente", vbOKOnly, "MENSAJE"
         PLLimpiar
      End If
      BtnBuscarLim_Click
      MhTListaLimitesCurrentTab = 1
      MhTListaLimites.Tab = 1
   Else
      
      MsgBox "Debe eliminar primero los causales relacionados", 0 + 16, "Mensaje de Error"
      MhTListaLimitesCurrentTab = 2
  
   End If
  BtnBuscarLim_Click
  
End Sub
Private Sub BtnBuscarCau_Click()
     
   MhTListaLimitesCurrentTab = 2
   MhTListaLimites.Tab = 2
   MhTListaLimites.TabEnabled(MhTListaLimitesCurrentTab) = True
    
   
   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 4129
   PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "SE"
   
       
   PMPasoValores sqlconn&, "@i_cr_origen", 0, SQLINT2, LblOrigen22.Caption
   PMPasoValores sqlconn&, "@i_cr_especie", 0, SQLINT1, LblEspecie22.Caption

      
   If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_topes_oficina", True, " Ok... Consulta de Topes de Oficina") Then
      PMMapeaGrid sqlconn&, grdCausales, False
      PMChequea sqlconn&
      grdCausales.Col = 1
   End If
   
   
End Sub

Private Sub BtnAgregarCau_Click()
   If TextCausal = "" Then
      MsgBox "El campo causal es mandatorio", 0 + 16, "Mensaje de Error"
      Exit Sub
   End If
   
   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 4157
   PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "IE"

   MhTListaLimitesCurrentTab = 1
      
   PMPasoValores sqlconn&, "@i_cr_origen", 0, SQLINT2, TextOrigen.Text
   PMPasoValores sqlconn&, "@i_cr_especie", 0, SQLINT1, TextEspecie.Text
  
   MhTListaLimitesCurrentTab = 2
   PMPasoValores sqlconn&, "@i_cr_causal", 0, SQLINT1, TextCausal.Text
   
   If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_topes_oficina", True, " Ok... Creación de Topes de Oficina") Then
      PMMapeaGrid sqlconn&, grdCausales, False
      PMChequea sqlconn&
      grdCausales.Col = 1
 
      cmdBoton(1).Enabled = False
      cmdBoton(2).Enabled = True
      cmdBoton(5).Enabled = True
      MsgBox "El registro se agregó exitosamente", vbOKOnly, "MENSAJE"
   End If
   BtnBuscarCau_Click
End Sub
Private Sub BtnEliminarCau_Click()
   Dim VLRespuesta%
   If grdCausales.Text = "" Or grdCausales.Row = 0 Then
      MsgBox "No existen registros a eliminar"
      Exit Sub
   End If

   If grdCausales.Row > 0 Then
      VLRespuesta% = MsgBox("Esta Seguro de Eliminar el Registro " + " ?", 1 + 32 + 256, "Eliminar Registros")
      If VLRespuesta% = 2 Then
         Exit Sub
      End If
   
   End If
   
   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 4157
   PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "DE"
   MhTListaLimitesCurrentTab = 1
      
   PMPasoValores sqlconn&, "@i_cr_origen", 0, SQLINT2, TextOrigen.Text
   PMPasoValores sqlconn&, "@i_cr_especie", 0, SQLINT1, TextEspecie.Text
  
   MhTListaLimitesCurrentTab = 2
  
   PMPasoValores sqlconn&, "@i_cr_causal", 0, SQLINT1, TextCausal.Text
   If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_topes_oficina", True, " Ok... Eliminación Topes por Oficina") Then
      PMChequea sqlconn&
  
      MsgBox "El registro se eliminó exitosamente", vbOKOnly, "MENSAJE"
      
   End If
   BtnBuscarCau_Click
End Sub

Private Sub mskNumTx_KeyPress(KeyAscii As Integer)
    If CDbl(mskNumTx.Text) >= 999# Then
        KeyAscii = 0
    End If
End Sub
Private Sub mskNumTx_LostFocus()
    If Val(mskNumTx.Text) < 0 Or Val(mskNumTx.Text) > 999# Then
       mskNumTx.Text = "0"
    End If
End Sub
Private Sub mskMontoRetiro_KeyPress(KeyAscii As Integer)
    If CDbl(mskMontoRetiro.Text) >= 9999999999# Then
        KeyAscii = 0
    End If
End Sub
Private Sub mskMontoRetiro_LostFocus()
    If Val(mskMontoRetiro.Text) < 0 Or Val(mskMontoRetiro.Text) > 9999999999# Then
       mskMontoRetiro.Text = "0.00"
    End If
End Sub
Private Sub TextOrigen_Change()
    VLPaso% = False
       'Se deshabilita pestaña de causales REQ 412
     MhTListaLimites.Tab = 2
     MhTListaLimitesCurrentTab = 2
     PMLimpiaGrid grdCausales
     MhTListaLimites.TabEnabled(MhTListaLimitesCurrentTab) = False

    MhTListaLimites.Tab = 1
    MhTListaLimitesCurrentTab = 1
    MhTListaLimites.TabEnabled(MhTListaLimitesCurrentTab) = True
  End Sub
Private Sub TextEspecie_Change()
    VLPaso% = False
      
   MhTListaLimitesCurrentTab = 2
   MhTListaLimites.Tab = 2
   PMLimpiaGrid grdCausales
   MhTListaLimites.TabEnabled(MhTListaLimitesCurrentTab) = False

   MhTListaLimites.Tab = 1
   MhTListaLimitesCurrentTab = 1
   MhTListaLimites.TabEnabled(MhTListaLimitesCurrentTab) = True
End Sub

Private Sub TextCausal_GotFocus()

    VLPaso% = True
    FPrincipal.pnlTransaccionLine.Caption = ""
    FPrincipal.pnlHelpLine.Caption = " Causal asociado al origen - especie [F5] Ayuda"
End Sub

Private Sub TextOrigen_GotFocus()

    VLPaso% = True
    FPrincipal.pnlTransaccionLine.Caption = ""
    FPrincipal.pnlHelpLine.Caption = " Origen de la Transacción [F5] Ayuda"
End Sub

Private Sub TextEspecie_GotFocus()

    VLPaso% = True
    FPrincipal.pnlTransaccionLine.Caption = ""
    FPrincipal.pnlHelpLine.Caption = " Especie de la Transacción [F5] Ayuda"
End Sub

Private Sub TextValid_Change()
    'REQ 412
    VLPaso% = True
    FPrincipal.pnlTransaccionLine.Caption = ""
    FPrincipal.pnlHelpLine.Caption = " Número máximo de transacciones [F5] Ayuda"
    
    If TextValid <> "" Then
        mskMonto(1).Enabled = False
        mskMonto(2).Enabled = False
        mskMonto(3).Enabled = False
        mskMonto(4).Enabled = False
     End If
    
End Sub

Private Sub MhTListaLimites_Click(PreviousTab As Integer)
 
Dim NewFolder As Integer
Dim OldFolder As Integer
NewFolder = MhTListaLimites.Tab
OldFolder = PreviousTab
MhTListaLimites_TabChangedHelper NewFolder, OldFolder
End Sub

