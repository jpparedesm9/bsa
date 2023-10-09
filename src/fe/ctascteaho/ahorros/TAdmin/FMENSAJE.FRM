VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{F856EC8B-F03C-4515-BDC6-64CBD617566A}#6.0#0"; "fpSpr60.ocx"
Begin VB.Form FMensaje 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Mensajes de la Transmisión de Cheques"
   ClientHeight    =   2955
   ClientLeft      =   330
   ClientTop       =   2250
   ClientWidth     =   8865
   ControlBox      =   0   'False
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
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2955
   ScaleWidth      =   8865
   Begin FPSpreadADO.fpSpread grdMensaje 
      Height          =   2895
      Left            =   30
      TabIndex        =   0
      Top             =   30
      Width           =   7875
      _Version        =   393216
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   64
      AutoClipboard   =   0   'False
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MaxCols         =   1
      MaxRows         =   1
      SpreadDesigner  =   "FMENSAJE.frx":0000
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   7980
      TabIndex        =   2
      Top             =   2175
      WhatsThisHelpID =   2008
      Width           =   875
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
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   7980
      TabIndex        =   1
      Tag             =   "6335"
      Top             =   1410
      WhatsThisHelpID =   2009
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Imprimir"
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
      Index           =   0
      X1              =   7950
      X2              =   7950
      Y1              =   0
      Y2              =   2940
   End
End
Attribute VB_Name = "FMensaje"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FMENSAJE.frm
' NOMBRE LOGICO:    FMensaje
' PRODUCTO:         Terminal Administrativa
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
' Pantalla para los mensajes de transmision de cheques
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Option Explicit
Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index
        Case 0 'Imprimir
            PLImprimir
        Case 1 'Salir
            Unload FMensaje
    End Select
End Sub

Private Sub Form_Load()
    PMLoadResStrings Me
    PMLoadResIcons Me
    PLTitulosGrid
    FPrincipal!pnlTransaccionLine.Caption = "FMENSAJE - V 2"
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub PLImprimir()
'*************************************************************
' PROPOSITO: Impresión de los cheques con novedades en la
'            transmisión
' INPUT    : ninguna
' OUTPUT   : ninguna
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    Dim i As Integer
    Dim Linea As String
    Screen.MousePointer = 11
''    Printer.FontBold = True
''    Printer.CurrentX = 0
''    Printer.CurrentY = 0
''    fontant% = Printer.FontSize
''    Printer.FontSize = 20
''    Printer.Print ""
''    Printer.Print VGBanco$
''    Printer.FontSize = 10
''    Printer.Print ""
''    Printer.FontSize = 15
''    Printer.Print "Novedades en la transmisión de cheques"
''    Printer.Print ""
''    Printer.FontSize = fontant%
    FMCabeceraReporte VGBanco$, Date, "Novedades en la transmisión de cheques", _
                    Time(), Me.Caption, VGFecha$, Printer.Page

    Printer.Print String$(66, "-")
    Printer.Print "   Cuenta     Cheque        Valor                Mensaje"
    Printer.Print String$(66, "-")
    Printer.Print ""
    For i% = 1 To grdMensaje.MaxRows
        grdMensaje.Row = i%
        grdMensaje.Col = 1
        Linea$ = " " + grdMensaje.Text + " "
        grdMensaje.Col = 2
        Linea$ = Linea$ + Space$(10 - Len(grdMensaje.Text)) + grdMensaje.Text
        grdMensaje.Col = 3
        Linea$ = Linea$ + Space$(17 - Len(grdMensaje.Text)) + grdMensaje.Text
        grdMensaje.Col = 4
        Linea$ = Linea$ + " " + grdMensaje.Text
        Printer.Print Linea$
    Next i%
    Printer.Print ""
    Printer.Print ""
    Printer.Print ""
    If VGCodPais$ <> "CO" Then
        Printer.Print "---  U L T I M A   L I N E A  ---"
    End If
    Printer.EndDoc
    Screen.MousePointer = 0
End Sub

Private Sub PLTitulosGrid()
'*************************************************************
' PROPOSITO: Formato de los titulos en el grid
' INPUT    : ninguna
' OUTPUT   : ninguna
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    grdMensaje.MaxCols = 4
    grdMensaje.Row = 0
    grdMensaje.Col = 1
    grdMensaje.Text = "Cuenta"
    grdMensaje.ColWidth(1) = 12
    grdMensaje.Col = 2
    grdMensaje.Text = "Cheque"
    grdMensaje.ColWidth(2) = 10
    grdMensaje.Col = 3
    grdMensaje.Text = "Valor"
    grdMensaje.ColWidth(3) = 15
    grdMensaje.Col = 4
    grdMensaje.Text = "Mensaje"
    grdMensaje.ColWidth(4) = 30
    grdMensaje.Row = -1
    grdMensaje.Col = -1
    grdMensaje.Lock = True
End Sub


