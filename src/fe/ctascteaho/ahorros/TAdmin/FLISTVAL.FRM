VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form ListaValores 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Listado de Registros Seleccionados"
   ClientHeight    =   2460
   ClientLeft      =   3855
   ClientTop       =   1425
   ClientWidth     =   5235
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
   ForeColor       =   &H00C0C0C0&
   LinkMode        =   1  'Source
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2460
   ScaleWidth      =   5235
   Begin VB.ListBox ListaSQL 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   1980
      Left            =   15
      TabIndex        =   2
      Top             =   15
      Width           =   5205
   End
   Begin Threed.SSCommand bb_escoger 
      Height          =   375
      Left            =   3405
      TabIndex        =   1
      Top             =   2070
      WhatsThisHelpID =   2042
      Width           =   900
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Escoger"
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
      BevelWidth      =   3
   End
   Begin Threed.SSCommand bb_cancelar 
      Height          =   375
      Left            =   4320
      TabIndex        =   0
      Top             =   2070
      WhatsThisHelpID =   2012
      Width           =   900
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Cancelar"
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
      BevelWidth      =   3
   End
End
Attribute VB_Name = "ListaValores"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FLISTVAL.frm
' NOMBRE LOGICO:    ListaValores
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
' Permite indicar el Listado de Registros Seleccionados
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Option Explicit
'Constantes
Const Caracter = 9
'Variables locales
Dim ubicacion As Integer
Dim i As Integer
Dim j As Integer
Dim M As Integer

Private Sub bb_cancelar_Click()
    ReDim Temporales(10)
    ListaValores.Hide
End Sub

Private Sub bb_escoger_Click()
    ListaSQL_DblClick
End Sub

Private Sub Form_Load()
PMLoadResStrings Me
    PMLoadResIcons Me
End Sub

Private Sub ListaSQL_DblClick()
        i% = 1
        j% = 1
        M% = 0
        ubicacion% = 1
        Do While ubicacion% <> 0
            ubicacion% = InStr(j%, ListaSQL.Text, Chr$(Caracter%))
            If ubicacion% <> 0 Then
                M% = M% + 1
            End If
            j% = ubicacion% + 1
        Loop
        ReDim Temporales(M% + 1)
        ubicacion% = 1
        j% = 1
        Do While ubicacion% <> 0
            ubicacion% = InStr(j%, ListaSQL.Text, Chr$(Caracter%))
            If ubicacion% <> 0 Then
                Temporales(i%) = Mid$(ListaSQL.Text, j%, ubicacion% - j%)
            Else
                Temporales(i%) = Mid$(ListaSQL.Text, j%, Len(ListaSQL.Text) - j% + 1)
            End If
            j% = ubicacion% + 1
            i% = i% + 1
        Loop
    ListaValores.Hide
End Sub

Private Sub ListaSQL_KeyPress(KeyAscii As Integer)
    Const KEY_ESCAPE = 27
    If KeyAscii = 13 Then
            i% = 1
            j% = 1
            M% = 0
            ubicacion% = 1
            Do While ubicacion% <> 0
                ubicacion% = InStr(j%, ListaSQL.Text, Chr$(Caracter%))
                If ubicacion% <> 0 Then
                    M% = M% + 1
                End If
                j% = ubicacion% + 1
            Loop
            ReDim Temporales(M% + 1)
            ubicacion% = 1
            j% = 1
            Do While ubicacion% <> 0
                ubicacion% = InStr(j%, ListaSQL.Text, Chr$(Caracter%))
                If ubicacion% <> 0 Then
                    Temporales(i%) = Mid$(ListaSQL.Text, j%, ubicacion% - j%)
                Else
                    Temporales(i%) = Mid$(ListaSQL.Text, j%, Len(ListaSQL.Text) - j% + 1)
                End If
                j% = ubicacion% + 1
                i% = i% + 1
            Loop
        ListaValores.Hide
    End If
    If KeyAscii = KEY_ESCAPE Then
        ReDim Temporales(10)
        ListaValores.Hide
    End If
End Sub


