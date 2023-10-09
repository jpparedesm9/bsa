VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran602 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Novedades de Remesa"
   ClientHeight    =   5310
   ClientLeft      =   555
   ClientTop       =   1860
   ClientWidth     =   9240
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
   HelpContextID   =   1032
   Icon            =   "FTRAN602.frx":0000
   LinkMode        =   1  'Source
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5307.009
   ScaleMode       =   0  'User
   ScaleWidth      =   536.516
   Tag             =   "3889"
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      FillColor       =   &H00808080&
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   0
      Left            =   7740
      Picture         =   "FTRAN602.frx":030A
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   6
      Top             =   1770
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   195
      Index           =   1
      Left            =   7965
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   7
      Top             =   1770
      Visible         =   0   'False
      Width           =   195
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   6
      Left            =   8370
      TabIndex        =   4
      Top             =   3765
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
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRAN602.frx":03E4
   End
   Begin VB.TextBox txtCarta 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   1671
      MaxLength       =   9
      TabIndex        =   0
      Top             =   30
      Width           =   1605
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   3495
      Left            =   0
      TabIndex        =   8
      Top             =   1680
      Width           =   8250
      _Version        =   65536
      _ExtentX        =   14552
      _ExtentY        =   6165
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8370
      TabIndex        =   5
      Top             =   4530
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
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRAN602.frx":0400
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8370
      TabIndex        =   3
      Top             =   3000
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
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRAN602.frx":041C
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8385
      TabIndex        =   2
      Top             =   780
      WhatsThisHelpID =   2506
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Des. Chq"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRAN602.frx":0438
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8370
      TabIndex        =   1
      Top             =   15
      WhatsThisHelpID =   2505
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Bloq. Chq"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRAN602.frx":0454
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8370
      TabIndex        =   30
      Top             =   2220
      WhatsThisHelpID =   2507
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Acuse"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   484.258
      Y1              =   1430.194
      Y2              =   1430.194
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   484.258
      X2              =   484.258
      Y1              =   -14.992
      Y2              =   5307.009
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   17
      Left            =   5025
      TabIndex        =   44
      Top             =   1110
      Width           =   3135
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Causa:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   16
      Left            =   3945
      TabIndex        =   43
      Top             =   1170
      Width           =   600
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   16
      Left            =   5025
      TabIndex        =   42
      Top             =   840
      Width           =   3135
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   15
      Left            =   1671
      TabIndex        =   41
      Top             =   1110
      Width           =   2205
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Estado:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   15
      Left            =   3945
      TabIndex        =   40
      Top             =   870
      WhatsThisHelpID =   5415
      Width           =   735
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Valor:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   14
      Left            =   105
      TabIndex        =   39
      Top             =   1170
      WhatsThisHelpID =   5439
      Width           =   585
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   14
      Left            =   1671
      TabIndex        =   38
      Top             =   840
      Width           =   2205
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Cheque:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   13
      Left            =   105
      TabIndex        =   37
      Top             =   870
      WhatsThisHelpID =   5404
      Width           =   795
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   12
      Left            =   1671
      TabIndex        =   36
      Top             =   570
      Width           =   2205
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Producto:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   12
      Left            =   3945
      TabIndex        =   35
      Top             =   570
      WhatsThisHelpID =   5434
      Width           =   915
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   13
      Left            =   5024
      TabIndex        =   34
      Top             =   570
      Width           =   2205
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Cta Depositada:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   11
      Left            =   105
      TabIndex        =   33
      Top             =   585
      WhatsThisHelpID =   5414
      Width           =   1455
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   10
      Left            =   1671
      TabIndex        =   32
      Top             =   300
      Width           =   2210
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Cta Girada:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   10
      Left            =   120
      TabIndex        =   31
      Top             =   330
      WhatsThisHelpID =   5421
      Width           =   1050
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   8419.991
      X2              =   8419.991
      Y1              =   0
      Y2              =   5310.007
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Lista de cheques:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   90
      TabIndex        =   26
      Top             =   1455
      WhatsThisHelpID =   5429
      Width           =   1605
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   11
      Left            =   5775
      TabIndex        =   29
      Top             =   840
      Width           =   2430
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha emisión carta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   3945
      TabIndex        =   28
      Top             =   870
      WhatsThisHelpID =   5427
      Width           =   1860
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de carta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   120
      TabIndex        =   27
      Top             =   60
      WhatsThisHelpID =   5430
      Width           =   1215
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   9
      Left            =   5790
      TabIndex        =   25
      Top             =   20
      Width           =   2430
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   8
      Left            =   1665
      TabIndex        =   24
      Top             =   1110
      Width           =   855
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   7
      Left            =   5775
      TabIndex        =   23
      Top             =   1110
      Width           =   2430
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   6
      Left            =   1665
      TabIndex        =   22
      Top             =   840
      Width           =   855
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   5
      Left            =   3285
      TabIndex        =   21
      Top             =   570
      Width           =   4920
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   4
      Left            =   1665
      TabIndex        =   20
      Top             =   570
      Width           =   1605
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   3
      Left            =   3300
      TabIndex        =   19
      Top             =   1365
      Visible         =   0   'False
      Width           =   4920
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   2
      Left            =   1680
      TabIndex        =   18
      Top             =   1365
      Visible         =   0   'False
      Width           =   1605
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   1
      Left            =   3284
      TabIndex        =   17
      Top             =   300
      Width           =   4920
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   0
      Left            =   1671
      TabIndex        =   16
      Top             =   299
      Width           =   1605
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Valor de la carta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   3960
      TabIndex        =   15
      Top             =   60
      WhatsThisHelpID =   5437
      Width           =   1560
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "No. de cheques:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   105
      TabIndex        =   14
      Top             =   1140
      WhatsThisHelpID =   5431
      Width           =   1425
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha efectiva:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   3975
      TabIndex        =   13
      Top             =   1155
      WhatsThisHelpID =   5426
      Width           =   1425
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Días retención:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   105
      TabIndex        =   12
      Top             =   870
      WhatsThisHelpID =   5424
      Width           =   1410
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Emisor:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   105
      TabIndex        =   11
      Top             =   600
      Width           =   630
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Propietario:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   120
      TabIndex        =   10
      Top             =   1395
      Visible         =   0   'False
      Width           =   990
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Corresponsal:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   120
      TabIndex        =   9
      Top             =   330
      Width           =   1170
   End
End
Attribute VB_Name = "FTran602"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
Dim VLPaso As Integer
Dim VLFila As Integer
Dim VLVez As Integer
Dim VLSalir As Boolean
Dim VLStatus As String
Dim VLRef As String
Dim VLDatosCheque() As String

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
    Case 0  'Bloqueo de cheques de una carta
        PLBloqueoCheques
        PLBuscar
    Case 1  'Acuse de cheques
        PLAcuseCheques
        PLBuscar
    Case 2  'Desbloquear Cheque
        PLDesbloquearCheque
        PLBuscar
    Case 3  'Postergar la fecha de la carta
        PLBuscar
    Case 4
        Unload FTran602
    Case 6   'Limpiar
       PLLimpiar
    End Select
End Sub

Private Function FLMarcados(modo As Integer) As Integer
    Dim VTVistos As Integer
    Dim VTPendientes As Integer
    Dim i As Integer
    VTVistos = 0
    VTPendientes = 0
    For i = 1 To grdRegistros.Rows - 1
        grdRegistros.Col = 0
        grdRegistros.Row = i
        If grdRegistros.Picture = picVisto(0) Then
           VTVistos = VTVistos + 1
        End If
        If modo = 1 Then  'Cheques Pendientes
           grdRegistros.Col = 6
           If grdRegistros.Text = "PENDIENTE" Then
              VTPendientes = VTPendientes + 1
           End If
        End If
    Next i

    Select Case modo
        Case 0   ' Chequea Vistos
            If VTVistos% > 0 Then
                FLMarcados = 1
            Else
                FLMarcados = 0
            End If
        Case 1   ' Chequea Pendientes
            If VTPendientes% = grdRegistros.Rows - 1 Then
                FLMarcados = 1
            Else
                FLMarcados = 0
            End If
    End Select
End Function

Private Sub Form_Activate()
    VGHelpRem$ = "N"
End Sub

Private Sub Form_Load()
    Dim i As Integer
    FTran602.Left = 15
    FTran602.Top = 15
    FTran602.Width = 9420
    FTran602.Height = 5820
    txtCarta.Height = 255
    PMLoadResStrings Me
    PMLoadResIcons Me
    cmdBoton(0).Enabled = False 'Conf. Chq
    cmdBoton(2).Enabled = False 'Conf. Cart
    For i = 10 To 17
      lblDescripcion(i).Visible = False
    Next i
     lblDescripcion(11).Visible = True
    For i = 10 To 16
    lbletiqueta(i).Visible = False
    Next i
    VGTipoOper = ""
End Sub

Private Sub Form_Unload(Cancel As Integer)
    
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""

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
   If grdRegistros.Cols <= 2 Then
        MsgBox "No Hay Datos en la lista de Cheques", 48, "Mensaje del Servidor"
        Exit Sub
    End If
   VLFila% = 0
   PLMarcarRegistro

End Sub

Private Sub PLDesbloquearCheque()
Dim i As Integer
Dim VTSec As String
Dim VTValor As String
Dim VTReferencia As String
If (FLMarcados(0)) Then
    For i = 1 To grdRegistros.Rows - 1
        grdRegistros.Col = 0
        grdRegistros.Row = i
        If grdRegistros.Picture = picVisto(0) Then
            grdRegistros.Col = 5
            VTValor = grdRegistros.Text
            grdRegistros.Col = 4
            VTReferencia = grdRegistros.Text
            grdRegistros.Col = 7
            VTSec = grdRegistros.Text
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "604"
         PMPasoValores sqlconn&, "@i_propie", 0, SQLVARCHAR, (lblDescripcion(2).Caption)
         PMPasoValores sqlconn&, "@i_corres", 0, SQLVARCHAR, (lblDescripcion(0).Caption)
         PMPasoValores sqlconn&, "@i_secuen", 0, SQLINT4, txtCarta.Text
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
         PMPasoValores sqlconn&, "@i_chq", 0, SQLINT4, VTReferencia$
         PMPasoValores sqlconn&, "@i_chq_sec", 0, SQLINT4, VTSec$
         PMPasoValores sqlconn&, "@i_val", 0, SQLMONEY, VTValor$
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
         PMPasoValores sqlconn&, "@i_bloq", 0, SQLVARCHAR, "D"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_novedad_remesas", True, " Ok... Confirmación de Cheque desbloqueado") Then
                PMChequea sqlconn&
            End If
         End If
    Next i%
End If
End Sub

Private Sub PLBloqueoCheques()
Dim VTCausaDev As String
Dim VTDescripcion As String
Dim i As Integer
Dim VTValor As String
Dim VTReferencia As String
Dim VTSec As String
If (FLMarcados(0)) Then
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
    PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, "re_bloqueo_remesa"
    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de parámetros") Then
        PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
        PMChequea sqlconn&
        FCatalogo.Show 1
        VTCausaDev = VGACatalogo.Codigo
        VTDescripcion = VGACatalogo.Descripcion
    End If
    If VTCausaDev$ = "" Then
        MsgBox "Causa de Devolución es mandatoria", 0 + 16, "Mensaje de Error"
    Exit Sub
    End If
    For i = 1 To grdRegistros.Rows - 1
        grdRegistros.Col = 0
        grdRegistros.Row = i
        If grdRegistros.Picture = picVisto(0) Then
            grdRegistros.Col = 5
            VTValor = grdRegistros.Text
            grdRegistros.Col = 4
            VTReferencia = grdRegistros.Text
            grdRegistros.Col = 7
            VTSec = grdRegistros.Text
            
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "605"
                 PMPasoValores sqlconn&, "@i_propie", 0, SQLVARCHAR, (lblDescripcion(2).Caption)
                 PMPasoValores sqlconn&, "@i_emisor", 0, SQLVARCHAR, (lblDescripcion(4).Caption)
                 PMPasoValores sqlconn&, "@i_corres", 0, SQLVARCHAR, (lblDescripcion(0).Caption)
                 PMPasoValores sqlconn&, "@i_secuen", 0, SQLINT4, txtCarta.Text
                 PMPasoValores sqlconn&, "@i_chq", 0, SQLINT4, VTReferencia$
                 PMPasoValores sqlconn&, "@i_chq_sec", 0, SQLINT4, VTSec$
                 PMPasoValores sqlconn&, "@i_val", 0, SQLMONEY, VTValor$
                 PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                 PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
                 PMPasoValores sqlconn&, "@i_caubloq", 0, SQLVARCHAR, VTCausaDev$
                 PMPasoValores sqlconn&, "@i_bloq", 0, SQLVARCHAR, "B"
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_novedad_remesas", True, " Ok... Confirmación de cheques Bloqueado") Then
                    PMChequea sqlconn&
                    PLObtenerDatos
                    Exit For
                 End If
        End If
       Next i%
End If
End Sub

Private Sub PLAcuseCheques()
    FAcuseChq.Show 1
End Sub

Private Sub PLHabilitaBotones()

    If grdRegistros.Rows <= 2 Then
       grdRegistros.Row = 1
       grdRegistros.Col = 1
       If grdRegistros.Text = "" Then
          Exit Sub
       End If
    End If
       
       cmdBoton(0).Enabled = True  'Conf. Chq
       cmdBoton(1).Enabled = True  'Devolver
       cmdBoton(2).Enabled = True  'Conf. Cart
       cmdBoton(3).Enabled = True  'Postergar
       cmdBoton(0).SetFocus

   
End Sub

Private Sub PLLimpiar()
    Dim i As Integer
    txtCarta.Enabled = True
    txtCarta.Text = ""
    For i = 0 To 9
        If i < 2 Or i > 3 Then
            lblDescripcion(i).Visible = True
        End If
    Next i
    lblDescripcion(11).Visible = True
    For i% = 0 To 6
        If i% <> 1 Then
            lbletiqueta(i%).Visible = True
        End If
    Next i%
    lbletiqueta(8).Visible = True
    lbletiqueta(9).Visible = True
       
    For i% = 10 To 17
        lblDescripcion(i%).Visible = False
    Next i%
        lblDescripcion(11).Visible = True
    For i% = 10 To 16
        lbletiqueta(i%).Visible = False
    Next i%
    For i% = 0 To 17
           lblDescripcion(i%).Caption = ""
    Next i%
    PMLimpiaGrid grdRegistros
    txtCarta.SetFocus

    If grdRegistros.Rows <= 2 Then
          grdRegistros.Row = 1
          grdRegistros.Col = 1
          If grdRegistros.Text = "" Then
             grdRegistros.Col = 0
             grdRegistros.Picture = picVisto(1)
          End If
    End If
    cmdBoton(0).Enabled = False 'Conf. Chq
    cmdBoton(2).Enabled = False 'Conf. Cart

End Sub

Private Sub PLMarcarRegistro()
 Dim i As Integer
 For i = 0 To 9
      lblDescripcion(i).Visible = False
 Next i
  lblDescripcion(11).Visible = False
  
For i% = 0 To 6
    lbletiqueta(i%).Visible = False
Next i%
    lbletiqueta(8).Visible = False
    lbletiqueta(9).Visible = False
    
    VLFila% = grdRegistros.Row
    grdRegistros.Col = 0
    For i% = 0 To grdRegistros.Rows - 1
       grdRegistros.Row = i%
       If grdRegistros.Picture = picVisto(0) Then
          grdRegistros.Text = Str$(grdRegistros.Row)
          grdRegistros.Picture = picVisto(1)
       End If
    Next i%
    grdRegistros.Col = 0
    grdRegistros.Row = VLFila%
    grdRegistros.Picture = picVisto(0)
    For i% = 10 To 17
      lblDescripcion(i%).Visible = True
    Next i%
     lblDescripcion(11).Visible = False
    For i% = 10 To 16
    lbletiqueta(i%).Visible = True
    Next i%
       
    grdRegistros.Col = 1
    lblDescripcion(10).Caption = grdRegistros.Text
    grdRegistros.Col = 2
    lblDescripcion(12).Caption = grdRegistros.Text
    grdRegistros.Col = 3
    lblDescripcion(13).Caption = grdRegistros.Text
    grdRegistros.Col = 4
    lblDescripcion(14).Caption = grdRegistros.Text
    grdRegistros.Col = 5
    lblDescripcion(15).Caption = grdRegistros.Text
    grdRegistros.Col = 6
    lblDescripcion(16).Caption = grdRegistros.Text
    grdRegistros.Col = 9
    lblDescripcion(17).Caption = grdRegistros.Text
    


End Sub

Private Sub PLObtenerDatos()
        Dim VTR1 As Integer
        Dim VTValor As String
        VLVez = 1
        VLSalir = False
        VLStatus = " "
        VLRef = "0"
        While Not VLSalir
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "407"
            PMPasoValores sqlconn&, "@i_secuen", 0, SQLINT4, txtCarta.Text
            PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
            PMPasoValores sqlconn&, "@i_consulta", 0, SQLVARCHAR, "N"
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
            PMPasoValores sqlconn&, "@i_status", 0, SQLVARCHAR, VLStatus$
            PMPasoValores sqlconn&, "@i_ref", 0, SQLINT4, VLRef$
            PMPasoValores sqlconn&, "@i_vez", 0, SQLINT1, Str$(VLVez%)
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "N"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_rem_consulcar", True, " OK... Consulta general de la carta remesa") Then
                If VLVez = 1 Then
                    ReDim VTArreglo(20) As String
                     VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
                     PMMapeaGrid sqlconn&, grdRegistros, False
                Else
                     PMMapeaGrid sqlconn&, grdRegistros, True
                End If
                PMChequea sqlconn&
                grdRegistros.Col = 8
                VTValor = grdRegistros.Text
                If VTValor$ = "N" Then
                   MsgBox "Número de Carta No ha sido Acusada ", 64, "Mensaje de Error"
                   cmdBoton(0).Enabled = False
                   cmdBoton(1).Enabled = False
                   cmdBoton(2).Enabled = False
                   cmdBoton(3).Enabled = False
                   Exit Sub
                End If
                
                VLVez% = VLVez% + 1
                If grdRegistros.Tag < 40 Then VLSalir = True
                    grdRegistros.ColAlignment(5) = 1
                    lblDescripcion(0).Caption = VTArreglo(1)
                    lblDescripcion(1).Caption = VTArreglo(2)
                    lblDescripcion(2).Caption = VTArreglo(3)
                    lblDescripcion(3).Caption = VTArreglo(4)
                    lblDescripcion(4).Caption = VTArreglo(5)
                    lblDescripcion(5).Caption = VTArreglo(6)
                    lblDescripcion(6).Caption = VTArreglo(7)
                    lblDescripcion(7).Caption = VTArreglo(8)
                    lblDescripcion(8).Caption = VTArreglo(9)
                    lblDescripcion(9).Caption = VTArreglo(10)
                    lblDescripcion(11).Caption = VTArreglo(12)
                    txtCarta.Enabled = False
                    grdRegistros.Row = grdRegistros.Rows - 1
                    grdRegistros.Col = 6
                    VLStatus$ = grdRegistros.Text
                    grdRegistros.Col = 7
                    VLRef$ = grdRegistros.Text
                Else
                    PLLimpiar
                    Exit Sub
                End If
        Wend
        PLHabilitaBotones
        PLProducto
End Sub

Private Sub PLBuscar()
        VGTipoOper = "N"
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "447"
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "N"
        PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
        PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4, "0"
        PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VGMoneda$
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, VGTipoOper
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_rem_ayuda", True, " Ok... Consulta de Número de Carta Remesa") Then
           PMMapeaGrid sqlconn&, FRegistros!grdRegistros, False
           PMChequea sqlconn&
          If txtCarta.Text <> "" Then
             PLObtenerDatos
          End If
       End If
End Sub

Private Sub PLProducto()
Dim i As Integer
   If grdRegistros.Rows <= 2 Then
      grdRegistros.Col = 1
      grdRegistros.Row = 1
      If grdRegistros.Text = "" Then
         Exit Sub
      End If
   End If
        
   For i = 1 To grdRegistros.Rows - 1
      grdRegistros.Col = 3
      grdRegistros.Row = i
      Select Case grdRegistros.Text
         Case "3"
            grdRegistros.Text = "CTE"
         Case "4"
            grdRegistros.Text = "AHO"
      End Select
   Next i
   

   
End Sub

Private Sub grdRegistros_GotFocus()
VLPaso% = False
End Sub

Private Sub grdRegistros_KeyDown(Keycode As Integer, Shift As Integer)
 Dim VTAccion As String
 Dim VTCausaDev As String
 Dim VTDescripcion As String
 If Keycode% = VGTeclaAyuda% Then
        VTAccion = ""
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
            PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, "re_bloqueo_remesa"
            PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de parámetros") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                VTCausaDev = VGACatalogo.Codigo
                VTDescripcion = VGACatalogo.Descripcion
                
            End If
        End If
   
End Sub

Private Sub txtCarta_Change()
    VLPaso% = False
End Sub

Private Sub txtCarta_GotFocus()
    VLPaso% = True
    FPrincipal!pnlHelpLine.Caption = " Número de Carta [F5 Ayuda]"
    txtCarta.SelStart = 0
    txtCarta.SelLength = Len(txtCarta.Text)
End Sub

Private Sub txtCarta_KeyDown(Keycode As Integer, Shift As Integer)
    If Keycode = VGTeclaAyuda% Then
       VLPaso% = True
       VGOperacion$ = "sp_rem_ayuda"
       VGTipoOper = "N"
       txtCarta.Text = ""
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "447"
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "N"
        PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
        PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4, "0"
        PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VGMoneda$
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, VGTipoOper
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_rem_ayuda", True, " Ok... Consulta de Número de Carta Remesa") Then
           Load FRegistros
           PMMapeaGrid sqlconn&, FRegistros!grdRegistros, False
           PMChequea sqlconn&
          FRegistros.Show 1
          If Val(FRegistros!grdRegistros.Tag) = VGMaxRows% Then
             FRegistros!cmdSiguientes.Enabled = True
            Else
               FRegistros!cmdSiguientes.Enabled = False
          End If
          txtCarta.Text = VGACatalogo.Codigo$
          If txtCarta.Text <> "" Then
             PLObtenerDatos
          End If
       End If
    End If
End Sub

Private Sub txtCarta_KeyPress(KeyAscii As Integer)

   KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)

End Sub

Private Sub txtCarta_LostFocus()
    If VLPaso% = False And txtCarta.Text <> "" Then
       FPrincipal!pnlHelpLine.Caption = ""
       FPrincipal!pnlTransaccionLine.Caption = ""
       PLObtenerDatos
    End If
End Sub

Private Sub txtCarta_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Clipboard.Clear
    Clipboard.SetText ""
End Sub

