VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{F9367463-CC18-11CE-A0B7-00AA00575482}#7.0#0"; "MhTab.ocx"
Begin VB.Form FTran2810 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenimiento Centros de Canje"
   ClientHeight    =   5610
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   8670
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5610
   ScaleWidth      =   8670
   Begin MhtabLib.MhTab MhTab1 
      Height          =   5505
      Left            =   15
      TabIndex        =   3
      Top             =   60
      Width           =   8460
      _Version        =   458752
      _ExtentX        =   14922
      _ExtentY        =   9710
      _StockProps     =   69
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
      Folders         =   2
      BevelSize       =   1
      TabOffset       =   12
      BorderStyle     =   1
      BevelStyle      =   1
      PictureVAlignment=   2
      TabBorderStyle  =   3
      VAlignment      =   2
      PageBevelSize0  =   1
      PageBevelStyle0 =   1
      PageBorderStyle0=   1
      TabBevelSize0   =   1
      TabBevelStyle0  =   1
      TabWidth0       =   2000
      TabAlignment0   =   3
      TabVAlignment0  =   3
      PageBevelSize1  =   1
      PageBevelStyle1 =   1
      PageBorderStyle1=   1
      TabBevelSize1   =   1
      TabBevelStyle1  =   1
      TabWidth1       =   2200
      TabAlignment1   =   3
      TabVAlignment1  =   3
      PagePicture0    =   "FTran2810.frx":0000
      PagePicture1    =   "FTran2810.frx":001C
      Xoffset         =   0
      Yoffset         =   315
      AssociateChildren=   -1  'True
      TabFontBold0    =   -1  'True
      TabFontTransparent0=   -1  'True
      TabFontSize0    =   8.25
      TabCaption0     =   "Centros de Canje"
      TabFontName0    =   "MS Sans Serif"
      TabFormat0      =   ""
      TabFontBold1    =   -1  'True
      TabFontTransparent1=   -1  'True
      TabFontSize1    =   8.25
      TabCaption1     =   "Oficina - Centro de Canje"
      TabFontName1    =   "MS Sans Serif"
      TabFormat1      =   ""
      BorderColor     =   -2147483642
      FillColor       =   -2147483633
      LightColor      =   -2147483628
      ShadowColor     =   -2147483632
      TextColor       =   -2147483630
      TransparentColor=   -2147483633
      TotalChildren   =   3
      cmName0         =   "Frame1"
      cmEnabled0      =   -1  'True
      cmFolder1       =   1
      cmName1         =   "Frame2"
      cmEnabled1      =   -1  'True
      cmFolder2       =   2
      cmName2         =   "Frame3"
      cmEnabled2      =   -1  'True
      Begin VB.Frame Frame1 
         Height          =   5115
         Index           =   0
         Left            =   15
         TabIndex        =   32
         Top             =   346
         Width           =   8205
         Begin VB.Frame Frame4 
            Caption         =   "Información General"
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
            Height          =   1455
            Index           =   0
            Left            =   120
            TabIndex        =   35
            Top             =   240
            Width           =   7020
            Begin VB.TextBox txtDesc 
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
               Left            =   1260
               TabIndex        =   2
               Top             =   960
               Width           =   5685
            End
            Begin VB.TextBox txtCampo 
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
               Index           =   0
               Left            =   1260
               MaxLength       =   6
               TabIndex        =   0
               Top             =   360
               Width           =   945
            End
            Begin VB.TextBox txtCampo 
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
               Index           =   1
               Left            =   1260
               MaxLength       =   5
               TabIndex        =   1
               Top             =   660
               Width           =   930
            End
            Begin VB.Label lblEtiqueta 
               Appearance      =   0  'Flat
               AutoSize        =   -1  'True
               BackColor       =   &H80000005&
               BackStyle       =   0  'Transparent
               Caption         =   "Descripción:"
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
               TabIndex        =   40
               Top             =   990
               Width           =   1080
            End
            Begin VB.Label lblDescripcion 
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
               ForeColor       =   &H00000000&
               Height          =   285
               Index           =   0
               Left            =   2220
               TabIndex        =   39
               Top             =   360
               Width           =   4710
            End
            Begin VB.Label lblEtiqueta 
               Appearance      =   0  'Flat
               AutoSize        =   -1  'True
               BackColor       =   &H80000005&
               BackStyle       =   0  'Transparent
               Caption         =   "Oficina:"
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
               Left            =   135
               TabIndex        =   38
               Top             =   375
               Width           =   675
            End
            Begin VB.Label lblDescripcion 
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
               ForeColor       =   &H00000000&
               Height          =   285
               Index           =   1
               Left            =   2205
               TabIndex        =   37
               Top             =   660
               Width           =   4740
            End
            Begin VB.Label lblEtiqueta 
               Appearance      =   0  'Flat
               AutoSize        =   -1  'True
               BackColor       =   &H80000005&
               BackStyle       =   0  'Transparent
               Caption         =   "Ciudad:"
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
               TabIndex        =   36
               Top             =   690
               Width           =   660
            End
         End
         Begin MSGrid.Grid grdRegistros 
            Height          =   2925
            Left            =   75
            TabIndex        =   33
            TabStop         =   0   'False
            Top             =   2040
            Width           =   7035
            _Version        =   65536
            _ExtentX        =   12409
            _ExtentY        =   5159
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
            Height          =   690
            Index           =   0
            Left            =   7230
            TabIndex        =   53
            Top             =   180
            WhatsThisHelpID =   2000
            Width           =   855
            _Version        =   65536
            _ExtentX        =   1508
            _ExtentY        =   1217
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
            Picture         =   "FTran2810.frx":0038
         End
         Begin Threed.SSCommand cmdBoton 
            Height          =   660
            Index           =   14
            Left            =   7230
            TabIndex        =   54
            Top             =   870
            WhatsThisHelpID =   2001
            Width           =   855
            _Version        =   65536
            _ExtentX        =   1508
            _ExtentY        =   1164
            _StockProps     =   78
            Caption         =   "*Siguien&te"
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
            Picture         =   "FTran2810.frx":0054
         End
         Begin Threed.SSCommand cmdBoton 
            Height          =   750
            Index           =   1
            Left            =   7215
            TabIndex        =   55
            Top             =   1530
            WhatsThisHelpID =   2030
            Width           =   855
            _Version        =   65536
            _ExtentX        =   1508
            _ExtentY        =   1323
            _StockProps     =   78
            Caption         =   "*&Ingresar"
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
            Picture         =   "FTran2810.frx":0070
         End
         Begin Threed.SSCommand cmdBoton 
            Height          =   720
            Index           =   2
            Left            =   7215
            TabIndex        =   56
            Top             =   2280
            WhatsThisHelpID =   2031
            Width           =   840
            _Version        =   65536
            _ExtentX        =   1482
            _ExtentY        =   1270
            _StockProps     =   78
            Caption         =   "*&Modificar"
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
            Picture         =   "FTran2810.frx":008C
         End
         Begin Threed.SSCommand cmdBoton 
            Height          =   705
            Index           =   3
            Left            =   7200
            TabIndex        =   57
            Top             =   3000
            WhatsThisHelpID =   2006
            Width           =   855
            _Version        =   65536
            _ExtentX        =   1508
            _ExtentY        =   1244
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
            Picture         =   "FTran2810.frx":00A8
         End
         Begin Threed.SSCommand cmdBoton 
            Height          =   690
            Index           =   4
            Left            =   7200
            TabIndex        =   58
            Top             =   3705
            WhatsThisHelpID =   2003
            Width           =   855
            _Version        =   65536
            _ExtentX        =   1508
            _ExtentY        =   1217
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
            Picture         =   "FTran2810.frx":00C4
         End
         Begin Threed.SSCommand cmdBoton 
            Height          =   690
            Index           =   5
            Left            =   7200
            TabIndex        =   59
            Top             =   4395
            WhatsThisHelpID =   2008
            Width           =   855
            _Version        =   65536
            _ExtentX        =   1508
            _ExtentY        =   1217
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
            Picture         =   "FTran2810.frx":00E0
         End
         Begin VB.Label lblSecuencial 
            Height          =   255
            Left            =   3720
            TabIndex        =   41
            Top             =   1800
            Visible         =   0   'False
            Width           =   375
         End
         Begin VB.Label lblEtiqueta 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H00C0C0C0&
            BackStyle       =   0  'Transparent
            Caption         =   "Centros de Canje Vigentes"
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
            Height          =   195
            Index           =   1
            Left            =   120
            TabIndex        =   34
            Top             =   1815
            Width           =   2265
         End
      End
      Begin VB.Frame Frame2 
         Height          =   5100
         Left            =   -74955
         TabIndex        =   24
         Top             =   361
         Width           =   8280
         Begin VB.Frame Frame4 
            Caption         =   "Información General"
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
            Height          =   1455
            Index           =   1
            Left            =   120
            TabIndex        =   42
            Top             =   240
            Width           =   7095
            Begin VB.TextBox txtCampo 
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
               Index           =   4
               Left            =   1260
               MaxLength       =   5
               TabIndex        =   51
               Top             =   960
               Width           =   780
            End
            Begin VB.TextBox txtCampo 
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
               Index           =   3
               Left            =   1260
               MaxLength       =   5
               TabIndex        =   44
               Top             =   660
               Width           =   780
            End
            Begin VB.TextBox txtCampo 
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
               Index           =   2
               Left            =   1260
               MaxLength       =   6
               TabIndex        =   43
               Top             =   360
               Width           =   780
            End
            Begin VB.Label lblDescripcion 
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
               ForeColor       =   &H00000000&
               Height          =   285
               Index           =   4
               Left            =   2070
               TabIndex        =   52
               Top             =   960
               Width           =   4875
            End
            Begin VB.Label lblEtiqueta 
               Appearance      =   0  'Flat
               AutoSize        =   -1  'True
               BackColor       =   &H80000005&
               BackStyle       =   0  'Transparent
               Caption         =   "Ciudad:"
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
               TabIndex        =   49
               Top             =   690
               Width           =   660
            End
            Begin VB.Label lblDescripcion 
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
               ForeColor       =   &H00000000&
               Height          =   285
               Index           =   3
               Left            =   2070
               TabIndex        =   48
               Top             =   660
               Width           =   4875
            End
            Begin VB.Label lblEtiqueta 
               Appearance      =   0  'Flat
               AutoSize        =   -1  'True
               BackColor       =   &H80000005&
               BackStyle       =   0  'Transparent
               Caption         =   "Oficina:"
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
               Left            =   135
               TabIndex        =   47
               Top             =   420
               Width           =   675
            End
            Begin VB.Label lblDescripcion 
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
               ForeColor       =   &H00000000&
               Height          =   285
               Index           =   2
               Left            =   2070
               TabIndex        =   46
               Top             =   360
               Width           =   4875
            End
            Begin VB.Label lblEtiqueta 
               Appearance      =   0  'Flat
               AutoSize        =   -1  'True
               BackColor       =   &H80000005&
               BackStyle       =   0  'Transparent
               Caption         =   "C. Canje:"
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
               TabIndex        =   45
               Top             =   960
               Width           =   795
            End
         End
         Begin Threed.SSCommand cmdBoton 
            Height          =   750
            Index           =   6
            Left            =   7365
            TabIndex        =   25
            Tag             =   "8005;8006"
            Top             =   480
            WhatsThisHelpID =   2000
            Width           =   855
            _Version        =   65536
            _ExtentX        =   1508
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
            Picture         =   "FTran2810.frx":00FC
         End
         Begin Threed.SSCommand cmdBoton 
            Height          =   750
            Index           =   10
            Left            =   7365
            TabIndex        =   29
            Top             =   3540
            WhatsThisHelpID =   2003
            Width           =   855
            _Version        =   65536
            _ExtentX        =   1508
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
            Picture         =   "FTran2810.frx":0118
         End
         Begin MSGrid.Grid grdOfiCanje 
            Height          =   2940
            Left            =   60
            TabIndex        =   31
            TabStop         =   0   'False
            Top             =   2085
            Width           =   7185
            _Version        =   65536
            _ExtentX        =   12674
            _ExtentY        =   5186
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
            Index           =   9
            Left            =   7365
            TabIndex        =   28
            Tag             =   "8005;8006"
            Top             =   2775
            WhatsThisHelpID =   2006
            Width           =   855
            _Version        =   65536
            _ExtentX        =   1508
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
            Picture         =   "FTran2810.frx":0134
         End
         Begin Threed.SSCommand cmdBoton 
            Height          =   750
            Index           =   11
            Left            =   7365
            TabIndex        =   30
            Top             =   4305
            WhatsThisHelpID =   2008
            Width           =   855
            _Version        =   65536
            _ExtentX        =   1508
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
            Picture         =   "FTran2810.frx":0150
         End
         Begin Threed.SSCommand cmdBoton 
            Height          =   750
            Index           =   7
            Left            =   7365
            TabIndex        =   26
            Tag             =   "8001"
            Top             =   1245
            WhatsThisHelpID =   2030
            Width           =   855
            _Version        =   65536
            _ExtentX        =   1508
            _ExtentY        =   1323
            _StockProps     =   78
            Caption         =   "*&Ingresar"
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
            Picture         =   "FTran2810.frx":016C
         End
         Begin Threed.SSCommand cmdBoton 
            Height          =   750
            Index           =   8
            Left            =   7365
            TabIndex        =   27
            Tag             =   "8002"
            Top             =   2010
            WhatsThisHelpID =   2031
            Width           =   855
            _Version        =   65536
            _ExtentX        =   1508
            _ExtentY        =   1323
            _StockProps     =   78
            Caption         =   "*&Modificar"
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
            Picture         =   "FTran2810.frx":0188
         End
         Begin VB.Label lblEtiqueta 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H00C0C0C0&
            BackStyle       =   0  'Transparent
            Caption         =   "Oficina - Centro de Canje"
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
            Height          =   195
            Index           =   7
            Left            =   120
            TabIndex        =   50
            Top             =   1875
            Width           =   2160
         End
         Begin VB.Line Line1 
            BorderColor     =   &H00800000&
            BorderWidth     =   2
            Index           =   0
            X1              =   7275
            X2              =   7260
            Y1              =   120
            Y2              =   5025
         End
      End
      Begin VB.Frame Frame3 
         Height          =   4830
         Left            =   -74940
         TabIndex        =   4
         Top             =   376
         Width           =   8280
         Begin VB.PictureBox picVisto 
            Appearance      =   0  'Flat
            BackColor       =   &H00C0C0C0&
            ForeColor       =   &H80000008&
            Height          =   195
            Index           =   5
            Left            =   330
            ScaleHeight     =   165
            ScaleWidth      =   165
            TabIndex        =   7
            Top             =   1260
            Visible         =   0   'False
            Width           =   195
         End
         Begin VB.PictureBox picVisto 
            Appearance      =   0  'Flat
            BackColor       =   &H00808080&
            FillColor       =   &H00808080&
            ForeColor       =   &H00808080&
            Height          =   195
            Index           =   4
            Left            =   150
            ScaleHeight     =   165
            ScaleWidth      =   165
            TabIndex        =   6
            Top             =   1260
            Visible         =   0   'False
            Width           =   195
         End
         Begin VB.TextBox txtCampo 
            Appearance      =   0  'Flat
            Height          =   285
            Index           =   5
            Left            =   2175
            MaxLength       =   3
            TabIndex        =   5
            Top             =   900
            Width           =   1020
         End
         Begin Threed.SSCheck SSCheck1 
            Height          =   210
            Index           =   0
            Left            =   4140
            TabIndex        =   8
            Top             =   1290
            Width           =   255
            _Version        =   65536
            _ExtentX        =   450
            _ExtentY        =   370
            _StockProps     =   78
            Caption         =   "SSCheck1"
            ForeColor       =   16777215
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
         Begin MSGrid.Grid grdPagos 
            Height          =   3015
            Left            =   45
            TabIndex        =   9
            TabStop         =   0   'False
            Top             =   1770
            Width           =   7260
            _Version        =   65536
            _ExtentX        =   12806
            _ExtentY        =   5318
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
            Height          =   795
            Index           =   12
            Left            =   7380
            TabIndex        =   10
            Tag             =   "8005;8006"
            Top             =   135
            Width           =   855
            _Version        =   65536
            _ExtentX        =   2646
            _ExtentY        =   1323
            _StockProps     =   78
            Caption         =   "&Buscar"
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
         End
         Begin Threed.SSCommand cmdBoton 
            Height          =   795
            Index           =   16
            Left            =   7380
            TabIndex        =   11
            Top             =   3210
            Width           =   855
            _Version        =   65536
            _ExtentX        =   2646
            _ExtentY        =   1323
            _StockProps     =   78
            Caption         =   "&Limpiar"
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
         End
         Begin Threed.SSCommand cmdBoton 
            Height          =   795
            Index           =   13
            Left            =   7365
            TabIndex        =   12
            Tag             =   "8001"
            Top             =   930
            Width           =   855
            _Version        =   65536
            _ExtentX        =   2646
            _ExtentY        =   1323
            _StockProps     =   78
            Caption         =   "&Ingresar"
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
         End
         Begin Threed.SSCommand cmdBoton 
            Height          =   795
            Index           =   15
            Left            =   7380
            TabIndex        =   13
            Tag             =   "8005;8006"
            Top             =   2430
            Width           =   855
            _Version        =   65536
            _ExtentX        =   2646
            _ExtentY        =   1323
            _StockProps     =   78
            Caption         =   "&Eliminar"
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
         End
         Begin VB.Label lblEtiqueta 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Se permite en horario extendido"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   21
            Left            =   4440
            TabIndex        =   23
            Top             =   1290
            Width           =   2715
         End
         Begin VB.Label lblDescripcion 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H00000000&
            Height          =   285
            Index           =   5
            Left            =   3225
            TabIndex        =   22
            Top             =   885
            Width           =   4050
         End
         Begin VB.Label lblEtiqueta 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Forma de Pago:"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   2
            Left            =   645
            TabIndex        =   21
            Top             =   960
            Width           =   1350
         End
         Begin VB.Label lblEtiqueta 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H00C0C0C0&
            BackStyle       =   0  'Transparent
            Caption         =   "Formas de Pago:"
            ForeColor       =   &H000000FF&
            Height          =   195
            Index           =   20
            Left            =   45
            TabIndex        =   20
            Top             =   1545
            Width           =   1440
         End
         Begin VB.Label lblDescripcion 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H00000000&
            Height          =   285
            Index           =   14
            Left            =   3225
            TabIndex        =   19
            Top             =   585
            Width           =   4050
         End
         Begin VB.Label lblEtiqueta 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Tipo de Impuesto:"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   19
            Left            =   435
            TabIndex        =   18
            Top             =   630
            Width           =   1545
         End
         Begin VB.Label lblDescripcion 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H00000000&
            Height          =   285
            Index           =   13
            Left            =   2190
            TabIndex        =   17
            Top             =   585
            Width           =   1005
         End
         Begin VB.Line Line1 
            BorderColor     =   &H00800000&
            BorderWidth     =   2
            Index           =   2
            X1              =   7350
            X2              =   7350
            Y1              =   120
            Y2              =   4800
         End
         Begin VB.Label lblDescripcion 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H00000000&
            Height          =   285
            Index           =   11
            Left            =   2190
            TabIndex        =   16
            Top             =   270
            Width           =   1005
         End
         Begin VB.Label lblEtiqueta 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Clase de Impuesto:"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   18
            Left            =   375
            TabIndex        =   15
            Top             =   315
            Width           =   1635
         End
         Begin VB.Label lblDescripcion 
            Appearance      =   0  'Flat
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            BorderStyle     =   1  'Fixed Single
            ForeColor       =   &H00000000&
            Height          =   285
            Index           =   12
            Left            =   3225
            TabIndex        =   14
            Top             =   270
            Width           =   4035
         End
      End
   End
End
Attribute VB_Name = "FTran2810"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Dim VLPaso As Boolean
Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index
        Case 0  'Buscar centro canje
            PLBuscar (0)
        Case 1  'Ingresar centro canje
            PLIngresar (0)
        Case 2  'Modificar centro canje
            PLActualizar (0)
        Case 3  'Eliminar centro canje
            PLEliminar (0)
        Case 4  'Limpiar centro canje
            PLLimpiar (0)
        Case 5  'Salir centro canje
            Unload Me
        Case 6  'Buscar oficina - centro canje
            PLBuscar (1)
        Case 7  'Ingresar oficina - centro canje
            PLIngresar (1)
        Case 8  'Modificar oficina - centro canje
            PLActualizar (1)
        Case 9  'Eliminar oficina - centro canje
            PLEliminar (1)
        Case 10 'Limpiar oficina - centro canje
            PLLimpiar (1)
        Case 11 'Salir oficina - centro canje
            Unload Me
        Case 14 'siguiente - centro canje
           PLSiguiente (0)
      
    End Select
End Sub

Private Sub Form_Load()
    PMLoadResStrings Me
    PMLoadResIcons Me
End Sub

Private Sub grdOfiCanje_Click()
    
    grdOfiCanje.Col = 0
    grdOfiCanje.SelStartCol = 1
    grdOfiCanje.SelEndCol = grdOfiCanje.Cols - 1
    If grdOfiCanje.Row = 0 Then
        grdOfiCanje.SelStartRow = 1
        grdOfiCanje.SelEndRow = 1
    Else
        grdOfiCanje.SelStartRow = grdOfiCanje.Row
        grdOfiCanje.SelEndRow = grdOfiCanje.Row
    End If
    
End Sub

Private Sub grdOfiCanje_DblClick()
    
    grdOfiCanje.Col = 1
    txtCampo(2).Text = grdOfiCanje.Text
    Call txtCampo_LostFocus(2)
    grdOfiCanje.Col = 3
    txtCampo(3).Text = grdOfiCanje.Text
    Call txtCampo_LostFocus(3)
    grdOfiCanje.Col = 2
    txtCampo(4).Text = grdOfiCanje.Text
    Call txtCampo_LostFocus(4)
    cmdBoton(7).Enabled = False
    cmdBoton(8).Enabled = True
    cmdBoton(9).Enabled = True
    txtCampo(2).Enabled = False
    
End Sub

Private Sub grdRegistros_Click()

    grdRegistros.Col = 0
    grdRegistros.SelStartCol = 1
    grdRegistros.SelEndCol = grdRegistros.Cols - 1
    If grdRegistros.Row = 0 Then
        grdRegistros.SelStartRow = 1
        grdRegistros.SelEndRow = 1
    Else
        grdRegistros.SelStartRow = grdRegistros.Row
        grdRegistros.SelEndRow = grdRegistros.Row
    End If

End Sub

Private Sub grdregistros_DblClick()

    grdRegistros.Col = 1
    lblSecuencial.Caption = grdRegistros.Text
    grdRegistros.Col = 2
    txtCampo(0).Text = grdRegistros.Text
    Call txtCampo_LostFocus(0)
    grdRegistros.Col = 3
    txtDesc.Text = grdRegistros.Text
    grdRegistros.Col = 4
    txtCampo(1).Text = grdRegistros.Text
    Call txtCampo_LostFocus(1)
    cmdBoton(1).Enabled = False
    cmdBoton(2).Enabled = True
    cmdBoton(3).Enabled = True
    txtCampo(0).SetFocus
    
End Sub

Private Sub txtCampo_Change(Index As Integer)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim$(txtCampo(Index).Text) = "" Then
        lblDescripcion(Index).Caption = ""
    End If
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0, 2
        FPrincipal!pnlHelpLine.Caption = " Oficina [F5 Ayuda]"
    Case 1, 3
        FPrincipal!pnlHelpLine.Caption = " Ciudad [F5 Ayuda]"
    Case 4
        FPrincipal!pnlHelpLine.Caption = " Centro de Canje [F5 Ayuda]"
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
    End Select
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    
    If Keycode% <> VGTeclaAyuda% Then
        Exit Sub
    End If

    Select Case Index%
        Case 0, 2 'Oficinas
            If Keycode% = VGTeclaAyuda% Then
                VGOperacion$ = "sp_oficina"
                VLPaso = True
                PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
                PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
                If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina ") Then
                    PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                    PMChequea sqlconn&
                    FCatalogo.Show 1
                    txtCampo(Index%).Text = VGACatalogo.Codigo$
                    lblDescripcion(Index%).Caption = VGACatalogo.Descripcion$
                    If txtCampo(Index%).Text <> "" Then
                        VLPaso = True
                        txtCampo(Index%).SetFocus
                    End If
                End If
            End If
        Case 1, 3 'Ciudades
            VGOperacion$ = "sp_centro_canje"
            Load FRegistros
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2810"
            PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "H"
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
            PMPasoValores sqlconn&, "@i_ciudad", 0, SQLINT4, "0"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_centro_canje", True, "Ok... Consulta de ciudad") Then
                PMMapeaGrid sqlconn&, FRegistros!grdRegistros, False
                PMChequea sqlconn&
                FRegistros!grdRegistros.ColWidth(1) = 1500
                FRegistros!grdRegistros.ColWidth(2) = 3300
                FRegistros.Show 1
                txtCampo(Index%).Text = VGACatalogo.Codigo$
                lblDescripcion(Index%).Caption = VGACatalogo.Descripcion$
            Else
                txtCampo(Index%).Text = ""
                lblDescripcion(Index%).Caption = ""
            End If
        Case 4 'Centros de canje
            VGOperacion$ = "sp_centro_canje1"
            Load FRegistros
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2810"
            PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "H1"
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
            PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, "0"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_centro_canje", True, "Ok... Consulta de ciudad") Then
                PMMapeaGrid sqlconn&, FRegistros!grdRegistros, False
                PMChequea sqlconn&
                FRegistros!grdRegistros.ColWidth(1) = 1500
                FRegistros!grdRegistros.ColWidth(2) = 3300
                FRegistros.Show 1
                txtCampo(Index%).Text = VGACatalogo.Codigo$
                lblDescripcion(Index%).Caption = VGACatalogo.Descripcion$
            Else
                txtCampo(Index%).Text = ""
                lblDescripcion(Index%).Caption = ""
            End If
  End Select
End Sub
Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0, 1, 2, 3, 4
        If (KeyAscii < 48 Or KeyAscii > 57) Then
           KeyAscii = 0
        End If
    End Select
End Sub
Private Sub txtCampo_LostFocus(Index As Integer)
    
    Select Case Index
        Case 0, 2 'Oficina
         
            If txtCampo(Index%).Text <> "" Then
                 PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCampo(Index%).Text)
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(Index%).Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(Index%)
                    PMChequea sqlconn&
                  Else
                     txtCampo(Index%).Text = ""
                     lblDescripcion(Index%).Caption = ""
                     txtCampo(Index%).SetFocus
                  End If
                Else
                   lblDescripcion(0).Caption = ""
            End If
            
        Case 1, 3 'Ciudad
            If txtCampo(Index%) <> "" Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2810"
                PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "H"
                PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                PMPasoValores sqlconn&, "@i_ciudad", 0, SQLINT4, (txtCampo(Index%).Text)
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_centro_canje", True, "Ok... Consulta ciudad") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(Index%)
                    PMChequea sqlconn&
                Else
                    txtCampo(Index%).Text = ""
                    lblDescripcion(Index%).Caption = ""
                End If
            Else
                lblDescripcion(Index%).Caption = ""
                txtCampo(Index%).Text = ""
            End If
        Case 4 'Centro de canje
            If txtCampo(4) <> "" Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2810"
                PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "H1"
                PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, (txtCampo(Index%).Text)
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_centro_canje", True, "Ok... Consulta Centro de Canje") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(Index%)
                    PMChequea sqlconn&
                Else
                    txtCampo(Index%).Text = ""
                    lblDescripcion(Index%).Caption = ""
                End If
            Else
                lblDescripcion(Index%).Caption = ""
                txtCampo(Index%).Text = ""
            End If
    End Select
    
End Sub

Private Sub txtDesc_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Descripción Centro de Canje [F5 Ayuda]"
End Sub

Private Sub txtDesc_KeyPress(KeyAscii As Integer)
    If (KeyAscii > 47 And KeyAscii < 58) Or _
       (KeyAscii > 64 And KeyAscii < 91) Or _
       (KeyAscii > 96 And KeyAscii < 123) Or (KeyAscii = 32 Or KeyAscii = 8) Then
           
       KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
    Else
       KeyAscii = 0
    End If
End Sub

Public Sub PLIngresar(parOpc As Integer)
    
    Select Case parOpc
        Case 0 'Ingresar centro de canje
            'Se validan campos mandatorios
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(txtCampo(0).Text) = "" Or Trim$(lblDescripcion(0).Caption) = "" Then
                MsgBox "El campo oficina es mandatorio.", vbCritical
                txtCampo(0).SetFocus
                Exit Sub
            End If
            
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(txtCampo(1).Text) = "" Or Trim$(lblDescripcion(1).Caption) = "" Then
                MsgBox "El campo ciudad es mandatorio.", vbCritical
                txtCampo(1).SetFocus
                Exit Sub
            End If
            
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(txtDesc.Text) = "" Then
                MsgBox "La descripción del centro de canje es mandatoria.", vbCritical
                txtDesc.SetFocus
                Exit Sub
            End If
            
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2810"
            PMPasoValores sqlconn&, "@i_opcion", 0, SQLVARCHAR, "I"
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT4, Trim$(txtCampo(0).Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            PMPasoValores sqlconn&, "@i_desc", 0, SQLVARCHAR, Trim$(txtDesc.Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            PMPasoValores sqlconn&, "@i_ciudad", 0, SQLINT4, Trim$(txtCampo(1).Text)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_centro_canje", True, " Ok... Ingreso Centro de Canje") Then
                PMChequea sqlconn&
                PLLimpiar (0)
                PLBuscar (0)
                MsgBox "Ha sido ingresado el centro de canje", vbInformation
            Else
                MsgBox "Error ingresando centro de canje", vbCritical
            End If
        Case 1 'Ingresarar oficina - centro canje
            'Se validan campos mandatorios
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(txtCampo(2).Text) = "" Or Trim$(lblDescripcion(2).Caption) = "" Then
                MsgBox "El campo oficina es mandatorio.", vbCritical
                txtCampo(2).SetFocus
                Exit Sub
            End If
            
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(txtCampo(3).Text) = "" Or Trim$(lblDescripcion(3).Caption) = "" Then
                MsgBox "El campo ciudad es mandatorio.", vbCritical
                txtCampo(3).SetFocus
                Exit Sub
            End If
            
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(txtCampo(4).Text) = "" Or Trim$(lblDescripcion(4).Caption) = "" Then
                MsgBox "El campo centro de canje es mandatorio.", vbCritical
                txtCampo(4).SetFocus
                Exit Sub
            End If
            
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2811"
            PMPasoValores sqlconn&, "@i_opcion", 0, SQLVARCHAR, "I"
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT4, Trim$(txtCampo(2).Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            PMPasoValores sqlconn&, "@i_centro", 0, SQLINT4, Trim$(txtCampo(4).Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            PMPasoValores sqlconn&, "@i_ciudad", 0, SQLINT4, Trim$(txtCampo(3).Text)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_ofi_canje", True, " Ok... Ingresar Información") Then
                PMChequea sqlconn&
                PLLimpiar (1)
                PLBuscar (1)
                MsgBox "Ha sido ingresada la información", vbInformation
            Else
                MsgBox "Error ingresando la información", vbCritical
            End If
    End Select
    
End Sub

Public Sub PLLimpiar(parOpc As Integer)

    Select Case parOpc
        Case 0 'Limpiar centros de canje
            txtCampo(0).Text = ""
            txtCampo(1).Text = ""
            txtDesc.Text = ""
            lblDescripcion(0).Caption = ""
            lblDescripcion(1).Caption = ""
            lblSecuencial.Caption = ""
            cmdBoton(1).Enabled = True
            cmdBoton(2).Enabled = False
            cmdBoton(3).Enabled = False
            PMLimpiaG grdRegistros
            txtCampo(0).SetFocus
        Case 1 'Limpiar oficina - centro canje
            txtCampo(2).Text = ""
            txtCampo(3).Text = ""
            txtCampo(4).Text = ""
            lblDescripcion(2).Caption = ""
            lblDescripcion(3).Caption = ""
            lblDescripcion(4).Caption = ""
            cmdBoton(6).Enabled = True
            cmdBoton(7).Enabled = True
            cmdBoton(8).Enabled = False
            cmdBoton(9).Enabled = False
            PMLimpiaG grdOfiCanje
            txtCampo(2).Enabled = True
            txtCampo(2).SetFocus
    End Select
End Sub

Public Sub PLBuscar(parOpc As Integer)
    Dim VTRegistros As Integer
    Dim VTFlag As Boolean
    Dim VTSecuencial As String
    
    Select Case parOpc
        Case 0
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2810"
            PMPasoValores sqlconn&, "@i_opcion", 0, SQLVARCHAR, "S"
            PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, "0"
            PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2, "0"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_centro_canje", True, " Ok... Consulta Centros de Canje") Then
                PMMapeaGrid sqlconn&, grdRegistros, False
                PMChequea sqlconn&
                
                If (grdRegistros.Rows - 1) >= 20 Then
                    cmdBoton(14).Enabled = True
                Else
                    cmdBoton(14).Enabled = False
                End If
            Else
                VTRegistros% = 0
            End If
           
        Case 1
        
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2811"
            PMPasoValores sqlconn&, "@i_opcion", 0, SQLVARCHAR, "S1"
            grdOfiCanje.Col = 1
            If grdOfiCanje.Rows > 1 And grdOfiCanje.Text <> "" Then
                grdOfiCanje.Row = grdOfiCanje.Rows - 1
                PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT4, grdOfiCanje.Text
            Else
                PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT4, 0
            End If
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_ofi_canje", True, " Ok... Consulta Oficina - Centros de Canje") Then
                PMMapeaGrid sqlconn&, grdOfiCanje, False
                PMChequea sqlconn&
                VTFlag = True
                VTRegistros% = Val(grdOfiCanje.Tag)
                grdOfiCanje.Row = grdOfiCanje.Rows - 1
                grdOfiCanje.Col = 1
                VTSecuencial$ = grdOfiCanje.Text
                While grdOfiCanje.Tag >= 20
                    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2811"
                    PMPasoValores sqlconn&, "@i_opcion", 0, SQLVARCHAR, "S1"
                    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT4, VTSecuencial$
                    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_ofi_canje", True, " Ok... Consulta Oficina - Centros de Canje") Then
                        PMMapeaGrid sqlconn&, grdOfiCanje, True
                        PMChequea sqlconn&
                        VTFlag = True
                        VTRegistros% = Val(grdOfiCanje.Tag)
                        grdOfiCanje.Row = grdOfiCanje.Rows - 1
                        grdOfiCanje.Col = 1
                        VTSecuencial$ = grdOfiCanje.Text
                    End If
                Wend
                cmdBoton(6).Enabled = False
            Else
                VTRegistros% = 0
            End If
    End Select
End Sub


Public Sub PLSiguiente(parOpc As Integer)
    Dim VTRegistros As Integer
      
        grdRegistros.Row = grdRegistros.Rows - 1
        grdRegistros.Col = 1
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2, "1"
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2810"
        PMPasoValores sqlconn&, "@i_opcion", 0, SQLVARCHAR, "S"
        PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, (grdRegistros.Text)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_centro_canje", True, " Ok... Consulta Centros de Canje") Then
                PMMapeaGrid sqlconn&, grdRegistros, True
                PMChequea sqlconn&
               
                If Val(grdRegistros.Tag) = 20 Then
                    cmdBoton(14).Enabled = True
                Else
                    cmdBoton(14).Enabled = False
                End If
                              
            Else
                VTRegistros% = 0
            End If
           
End Sub
Public Sub PLActualizar(parOpc As Integer)
    Dim i As Integer
    Select Case parOpc
        Case 0 'Actualizar centro de canje
            'Se validan campos mandatorios
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(txtCampo(0).Text) = "" Or Trim$(lblDescripcion(0).Caption) = "" Then
                MsgBox "El campo oficina es mandatorio.", vbCritical
                txtCampo(0).SetFocus
                Exit Sub
            End If
            
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(txtCampo(1).Text) = "" Or Trim$(lblDescripcion(1).Caption) = "" Then
                MsgBox "El campo ciudad es mandatorio.", vbCritical
                txtCampo(1).SetFocus
                Exit Sub
            End If
            
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(txtDesc.Text) = "" Then
                MsgBox "La descripción del centro de canje es mandatoria.", vbCritical
                txtDesc.SetFocus
                Exit Sub
            End If
            
            i% = MsgBox("Está seguro de modificar la información del centro de canje?", vbQuestion + vbYesNo)
            If i% = vbNo Then
                Exit Sub
            End If
            
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2810"
            PMPasoValores sqlconn&, "@i_opcion", 0, SQLVARCHAR, "U"
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT4, Trim$(txtCampo(0).Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            PMPasoValores sqlconn&, "@i_desc", 0, SQLVARCHAR, Trim$(txtDesc.Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            PMPasoValores sqlconn&, "@i_ciudad", 0, SQLINT4, Trim$(txtCampo(1).Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, Trim$(lblSecuencial.Caption)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_centro_canje", True, " Ok... Modificar Centro de Canje") Then
                PMChequea sqlconn&
                PLLimpiar (0)
                PLBuscar (0)
                MsgBox "Ha sido modificada la información del centro de canje", vbInformation
            Else
                MsgBox "Error modificando información del centro de canje", vbCritical
            End If
        Case 1 'Modificar oficina - centro canje
            'Se validan campos mandatorios
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(txtCampo(2).Text) = "" Or Trim$(lblDescripcion(2).Caption) = "" Then
                MsgBox "El campo oficina es mandatorio.", vbCritical
                txtCampo(2).SetFocus
                Exit Sub
            End If
            
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(txtCampo(3).Text) = "" Or Trim$(lblDescripcion(3).Caption) = "" Then
                MsgBox "El campo ciudad es mandatorio.", vbCritical
                txtCampo(3).SetFocus
                Exit Sub
            End If
            
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(txtCampo(4).Text) = "" Or Trim$(lblDescripcion(4).Caption) = "" Then
                MsgBox "El campo centro de canje es mandatorio.", vbCritical
                txtCampo(4).SetFocus
                Exit Sub
            End If
            
            i% = MsgBox("Está seguro de modificar la información?", vbQuestion + vbYesNo)
            If i% = vbNo Then
                Exit Sub
            End If
            
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2811"
            PMPasoValores sqlconn&, "@i_opcion", 0, SQLVARCHAR, "U"
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT4, Trim$(txtCampo(2).Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            PMPasoValores sqlconn&, "@i_centro", 0, SQLINT4, Trim$(txtCampo(4).Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            PMPasoValores sqlconn&, "@i_ciudad", 0, SQLINT4, Trim$(txtCampo(3).Text)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_ofi_canje", True, " Ok... Modificar Información") Then
                PMChequea sqlconn&
                PLLimpiar (1)
                PLBuscar (1)
                MsgBox "Ha sido modificada la información", vbInformation
            Else
                MsgBox "Error modificando información", vbCritical
            End If
    End Select
    
End Sub

Public Sub PLEliminar(parOpc As Integer)
    Dim i As Integer
    Select Case parOpc
        Case 0 'Eliminar centro de canje
        
            'Se validan campos mandatorios
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(txtCampo(0).Text) = "" Or Trim$(lblDescripcion(0).Caption) = "" Then
                MsgBox "El campo oficina es mandatorio.", vbCritical
                txtCampo(0).SetFocus
                Exit Sub
            End If
            
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(txtCampo(1).Text) = "" Or Trim$(lblDescripcion(1).Caption) = "" Then
                MsgBox "El campo ciudad es mandatorio.", vbCritical
                txtCampo(1).SetFocus
                Exit Sub
            End If
            
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(txtDesc.Text) = "" Then
                MsgBox "La descripción del centro de canje es mandatoria.", vbCritical
                txtDesc.SetFocus
                Exit Sub
            End If
            
            i% = MsgBox("Está seguro de eliminar la información del centro de canje?", vbQuestion + vbYesNo)
            If i% = vbNo Then
                Exit Sub
            End If
            
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2810"
            PMPasoValores sqlconn&, "@i_opcion", 0, SQLVARCHAR, "D"
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, Trim$(lblSecuencial.Caption)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_centro_canje", True, " Ok... Eliminar Centro de Canje") Then
                PMChequea sqlconn&
                PLLimpiar (0)
                PLBuscar (0)
                MsgBox "Ha sido eliminada la información del centro de canje", vbInformation
            Else
                MsgBox "Error eliminando información del centro de canje", vbCritical
            End If
        Case 1 'Eliminar oficina - centro canje
            'Se validan campos mandatorios
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(txtCampo(2).Text) = "" Or Trim$(lblDescripcion(2).Caption) = "" Then
                MsgBox "El campo oficina es mandatorio.", vbCritical
                txtCampo(2).SetFocus
                Exit Sub
            End If
            
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(txtCampo(3).Text) = "" Or Trim$(lblDescripcion(3).Caption) = "" Then
                MsgBox "El campo ciudad es mandatorio.", vbCritical
                txtCampo(3).SetFocus
                Exit Sub
            End If
            
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(txtCampo(4).Text) = "" Or Trim$(lblDescripcion(4).Caption) = "" Then
                MsgBox "El campo centro de canje es mandatorio.", vbCritical
                txtCampo(4).SetFocus
                Exit Sub
            End If
            
            i% = MsgBox("Está seguro de eliminar la información?", vbQuestion + vbYesNo)
            If i% = vbNo Then
                Exit Sub
            End If
            
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2811"
            PMPasoValores sqlconn&, "@i_opcion", 0, SQLVARCHAR, "D"
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT4, Trim$(txtCampo(2).Text)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_ofi_canje", True, " Ok... Eliminar Información") Then
                PMChequea sqlconn&
                PLLimpiar (1)
                PLBuscar (1)
                MsgBox "Ha sido eliminada la información", vbInformation
            Else
                MsgBox "Error eliminando información", vbCritical
            End If
    End Select
    
End Sub

