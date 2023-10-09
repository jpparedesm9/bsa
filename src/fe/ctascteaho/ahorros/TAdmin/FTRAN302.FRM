VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{9AED8C43-3F39-11D1-8BB4-0000C039C248}#2.0#0"; "txtin.ocx"
Begin VB.Form Ftran302 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Consulta de Operaciones Superiores a un monto en Cuentas de Ahorros"
   ClientHeight    =   5310
   ClientLeft      =   2850
   ClientTop       =   4665
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
   HelpContextID   =   1111
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5310
   ScaleWidth      =   9300
   Tag             =   "3067"
   Begin VB.TextBox txtcampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   1425
      MaxLength       =   4
      TabIndex        =   1
      Top             =   495
      WhatsThisHelpID =   5005
      Width           =   1065
   End
   Begin VB.TextBox txtcampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   1425
      MaxLength       =   4
      TabIndex        =   0
      Top             =   195
      Width           =   1065
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   5
      Left            =   8415
      TabIndex        =   11
      Tag             =   "6335"
      Top             =   1296
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
      Enabled         =   0   'False
   End
   Begin VB.TextBox txtcampo 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "#,##0.0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   9226
         SubFormatType   =   1
      EndProperty
      Height          =   285
      Index           =   0
      Left            =   1425
      MaxLength       =   15
      TabIndex        =   3
      Text            =   "0.00"
      Top             =   1095
      WhatsThisHelpID =   5005
      Width           =   2115
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8415
      TabIndex        =   6
      Top             =   3780
      WhatsThisHelpID =   2003
      Width           =   875
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
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8415
      TabIndex        =   4
      Top             =   2250
      WhatsThisHelpID =   2001
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Sig&tes."
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
      Enabled         =   0   'False
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8415
      TabIndex        =   5
      Top             =   3015
      WhatsThisHelpID =   2007
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Transmitir"
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
      Index           =   3
      Left            =   8415
      TabIndex        =   7
      Top             =   4545
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
   Begin MSGrid.Grid grdOperaciones 
      Height          =   3345
      Left            =   30
      TabIndex        =   9
      Top             =   1950
      Width           =   8310
      _Version        =   65536
      _ExtentX        =   14658
      _ExtentY        =   5900
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
   Begin TxtinLib.TextValid txtoficina 
      Height          =   285
      Left            =   1425
      TabIndex        =   2
      Top             =   795
      Width           =   1065
      _Version        =   65536
      _ExtentX        =   1879
      _ExtentY        =   503
      _StockProps     =   253
      BorderStyle     =   1
      Range           =   ""
      MaxLength       =   4
      Character       =   0
      Type            =   1
      HelpLine        =   ""
      Pendiente       =   ""
      Connection      =   0
      AsociatedLabelIndex=   0
      TableName       =   "cl_oficina"
      MinChar         =   0
      Error           =   0
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   7
      Left            =   2535
      TabIndex        =   17
      Top             =   495
      Width           =   5760
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   6
      Left            =   2535
      TabIndex        =   16
      Top             =   195
      Width           =   5760
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Territorial:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   120
      TabIndex        =   15
      Top             =   225
      Width           =   885
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Zona:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   120
      TabIndex        =   14
      Top             =   525
      Width           =   510
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Agencia:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   120
      TabIndex        =   13
      Top             =   825
      WhatsThisHelpID =   5005
      Width           =   840
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   2535
      TabIndex        =   12
      Top             =   795
      Width           =   5760
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Listado de las Operaciones:"
      ForeColor       =   &H00800000&
      Height          =   285
      Index           =   1
      Left            =   60
      TabIndex        =   10
      Top             =   1680
      WhatsThisHelpID =   5340
      Width           =   2625
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   -75
      X2              =   8350
      Y1              =   1620
      Y2              =   1620
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Monto:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   120
      TabIndex        =   8
      Top             =   1125
      WhatsThisHelpID =   5196
      Width           =   675
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8370
      X2              =   8370
      Y1              =   30
      Y2              =   5340
   End
End
Attribute VB_Name = "Ftran302"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FTRAN302.frm
' NOMBRE LOGICO:    Ftran302
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
' Permite la Consulta de Operaciones Superiores a un monto en
' Cuentas de Ahorros
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

Dim VLPaso As Integer
Dim VLUltLinea As Long
Dim VLSec As String
Dim VLAlt As String

Private Sub cmdBoton_Click(Index As Integer)

    Select Case Index%
    Case 1 'Siguientes
        PLSiguientes
    Case 2 'Transmitir
        PLTransmitir
    Case 3 'Salir
        Unload Ftran302
    Case 4 'Limpiar
        PLLimpiar
    Case 5 'Imprimir
        PLImprimir
    End Select
End Sub

Private Sub Form_Load()
    Ftran302.Left = 0   '15
    Ftran302.Top = 0   '15
    Ftran302.Width = 9450   '9420
    Ftran302.Height = 5900   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    'cmdBoton(2).Enabled = False
    txtOficina.Connection = VGMap
    Set txtOficina.AsociatedLabel = lblEtiqueta(3)
    
    txtCampo(0).Text = Format$(txtCampo(0).Text, "#,##0.00")
    
End Sub

Private Sub grdOperaciones_Click()
    Dim VTCol As Integer
    Dim VTFil As Integer
    Dim VTTipoDato As String
    VTCol = grdOperaciones.Col
    VTFil = grdOperaciones.Row
    grdOperaciones.Col = 0
    grdOperaciones.SelStartCol = 1
    grdOperaciones.SelEndCol = grdOperaciones.Cols - 1
    If grdOperaciones.Row = 0 Then
        grdOperaciones.SelStartRow = 1
        grdOperaciones.SelEndRow = 1
    Else
        grdOperaciones.SelStartRow = grdOperaciones.Row
        grdOperaciones.SelEndRow = grdOperaciones.Row

        If VTFil <= grdOperaciones.TopRow Then
            Select Case VTCol
                Case 1 'Cuenta
                    VTTipoDato$ = "N"
                Case 2 'Nombre
                    VTTipoDato$ = "A"
                Case 3 'Desc. PB
                    VTTipoDato$ = "A"
                Case 4 'Tran
                    VTTipoDato$ = "N"
                Case 5 'Causa
                    VTTipoDato$ = "A"
                Case 6 'Signo
                    VTTipoDato$ = "A"
                Case 7 'Monto
                    VTTipoDato$ = "M"
                Case 8 'Oficina
                    VTTipoDato$ = "A"
                Case 9 'Usuario
                    VTTipoDato$ = "A"
                Case 10 'Hora
                    VTTipoDato$ = "D"
                Case 11 'Sec
                    VTTipoDato$ = "N"
                Case 12 'Sec Alt
                    VTTipoDato$ = "N"
            End Select

            PMOrdenaGrid grdOperaciones, VTTipoDato$, VTCol, "A"
            grdOperaciones.Col = VTCol
            grdOperaciones.Row = VTFil
        End If
    End If

End Sub

Private Sub grdOperaciones_DblClick()
    Dim VTCol As Integer
    Dim VTFil As Integer
    Dim VTTipoDato As String
    
    VTCol = grdOperaciones.Col
    VTFil = grdOperaciones.Row
    
    If VTFil <= grdOperaciones.TopRow Then
        Select Case VTCol
            Case 1 'Cuenta
                VTTipoDato$ = "A"
            Case 2 'Nombre
                VTTipoDato$ = "A"
            Case 3 'Desc. PB
                VTTipoDato$ = "A"
            Case 4 'Tran
                VTTipoDato$ = "N"
            Case 5 'Causa
                VTTipoDato$ = "A"
            Case 6 'Signo
                VTTipoDato$ = "A"
            Case 7 'Monto
                VTTipoDato$ = "M"
            Case 8 'Oficina
                VTTipoDato$ = "A"
            Case 9 'Usuario
                VTTipoDato$ = "A"
            Case 10 'Hora
                VTTipoDato$ = "D"
            Case 11 'Sec
                VTTipoDato$ = "N"
            Case 12 'Sec Alt
                VTTipoDato$ = "N"
        End Select
    
        PMOrdenaGrid grdOperaciones, VTTipoDato$, VTCol, "D"
    End If

End Sub

Private Sub PLEliminarDup()
'*************************************************************
' PROPOSITO: Elimina valores duplicados
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

Dim VTLinea As Long
Dim VTSec As String
Dim VTAlt As String
Dim i As Integer
VTLinea = VLUltLinea

Do
    If grdOperaciones.Rows - 1 >= VLUltLinea + 1 Then
        grdOperaciones.Row = VLUltLinea + 1
    Else
        Exit Do
    End If


    grdOperaciones.Col = 11
    VTSec = grdOperaciones.Text

    grdOperaciones.Col = 12
    VTAlt = grdOperaciones.Text
    
    If VLSec = VTSec And VLAlt >= VTAlt Then
        grdOperaciones.RemoveItem VLUltLinea + 1
    Else
        VLUltLinea = VLUltLinea + 1
    End If
    
Loop Until VLSec <> VTSec

grdOperaciones.Col = 0
grdOperaciones.Row = VTLinea
For i = grdOperaciones.Row To grdOperaciones.Rows - 1
    grdOperaciones.Row = i
    grdOperaciones.Text = grdOperaciones.Row
Next i

End Sub

Private Sub PLImprimir()
'*************************************************************
' PROPOSITO: Permite imprimir los datos consultados en el grid
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    Dim VTResp As Integer
    Dim cont As Integer
    Dim VTInicio As Integer
    Dim VTFin As Integer
    Dim j As Integer
    Dim Linea As String
    VTResp = MsgBox("¿Desea imprimir sólo la página actual?", 3, "Mensaje del Sistema")

    If VTResp = 2 Then 'Cancelar
        Exit Sub
    End If

        Screen.MousePointer = 11
        Printer.Orientation = 1 'vbPRORLandscape
        
    
        'Printer.FontName = "Courier"
''        Printer.FontBold = True
''        Printer.CurrentX = 0
''        Printer.CurrentY = 0
''        Printer.FontSize = 12
''        Printer.Print ""
''        Printer.Print "                                                               Fecha: " & VGFecha$
''        Printer.Print "                                                               Página: " & Printer.Page
''
''
''        Printer.FontBold = True
''        Printer.CurrentX = 0
''        Printer.CurrentY = 0
''        Printer.FontSize = 36
''        Printer.Print VGBanco$
''        Printer.FontSize = 10
''        Printer.Print ""
''        Printer.Print ""
''        Printer.FontSize = 16
''        Printer.Print "OPERACIONES SUPERIORES A "; txtcampo.Text; " EN CUENTAS DE AHORRO"
        FMCabeceraReporte VGBanco$, Date, "OPERACIONES SUPERIORES A " + txtCampo(0).Text + " EN CUENTAS DE AHORRO", _
                          Time(), Me.Caption, VGFecha$, Printer.Page
        Printer.FontBold = True
        Printer.Print "MONEDA: "; VGMoneda$
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.FontSize = 6.5
                Printer.Print "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
                Printer.Print "No. CUENTA       NOMBRE                           DESC. PB              TRAN   CAUSA SIG            MONTO           AGENCIA            USUARIO         HORA        SEC     ALT"
                Printer.Print "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
        Printer.FontBold = False
        cont% = 1
        
        If VTResp = 6 Then 'SI, imprimir solo la pagina actual
            VTInicio = grdOperaciones.TopRow
            If grdOperaciones.TopRow + 25 > grdOperaciones.Rows - 1 Then
                VTFin = grdOperaciones.Rows - 1
            Else
                VTFin = grdOperaciones.TopRow + 25
            End If
        End If
        If VTResp = 7 Then 'NO, imprimir todo el reporte
            VTInicio = 1
            VTFin = grdOperaciones.Rows - 1
        End If
        
        For j% = VTInicio To VTFin
            grdOperaciones.Row = j%

            grdOperaciones.Col = 1  'Cuenta
            Linea$ = grdOperaciones.Text
            Linea$ = Linea$ + Space$(15 - Len(grdOperaciones.Text))
            grdOperaciones.Col = 2  'Nombre
'FIXIT: Replace 'Left' function with 'Left$' function                                      FixIT90210ae-R9757-R1B8ZE
            grdOperaciones.Text = Left$(grdOperaciones.Text, 35)
            Linea$ = Linea$ + grdOperaciones.Text
            Linea$ = Linea$ + Space$(35 - Len(grdOperaciones.Text))
            grdOperaciones.Col = 3  'Desc. PB
'FIXIT: Replace 'Left' function with 'Left$' function                                      FixIT90210ae-R9757-R1B8ZE
            grdOperaciones.Text = Left$(grdOperaciones.Text, 19)
            Linea$ = Linea$ + grdOperaciones.Text
            Linea$ = Linea$ + Space$(20 - Len(grdOperaciones.Text))
            grdOperaciones.Col = 4  'Tran   (El valor esta alineado a la derecha)
            Linea$ = Linea$ + Space$(6 - Len(grdOperaciones.Text)) + grdOperaciones.Text + " "
            grdOperaciones.Col = 5  'Causa   (El valor esta alineado a la derecha)
            Linea$ = Linea$ + Space$(6 - Len(grdOperaciones.Text)) + grdOperaciones.Text + " "
            grdOperaciones.Col = 6  'Signo
            Linea$ = Linea$ + " " + grdOperaciones.Text + " "
            'linea$ = linea$ + Space$(4 - Len(grdOperaciones.Text))
            grdOperaciones.Col = 7  'Monto   (El valor esta alineado a la derecha)
            Linea$ = Linea$ + Space$(21 - Len(grdOperaciones.Text)) + grdOperaciones.Text + " "
            grdOperaciones.Col = 8  'Oficina
'FIXIT: Replace 'Left' function with 'Left$' function                                      FixIT90210ae-R9757-R1B8ZE
            grdOperaciones.Text = Left$(grdOperaciones.Text, 25)
            Linea$ = Linea$ + grdOperaciones.Text
            Linea$ = Linea$ + Space$(26 - Len(grdOperaciones.Text))
            grdOperaciones.Col = 9  'Usuario
'FIXIT: Replace 'Left' function with 'Left$' function                                      FixIT90210ae-R9757-R1B8ZE
            grdOperaciones.Text = Left$(grdOperaciones, 15)
            Linea$ = Linea$ + grdOperaciones.Text
            Linea$ = Linea$ + Space$(16 - Len(grdOperaciones.Text))
            grdOperaciones.Col = 10  'Hora
            Linea$ = Linea$ + grdOperaciones.Text
            Linea$ = Linea$ + Space$(6 - Len(grdOperaciones.Text))
            grdOperaciones.Col = 11  'Sec   (El valor esta alineado a la derecha)
            Linea$ = Linea$ + Space$(10 - Len(grdOperaciones.Text)) + grdOperaciones.Text + " "
            grdOperaciones.Col = 12  'Sec Alt   (El valor esta alineado a la derecha)
            Linea$ = Linea$ + Space$(4 - Len(grdOperaciones.Text)) + grdOperaciones.Text + " "

            Printer.Print Linea$
            cont% = cont% + 1

            If cont% = 50 Then
                Printer.NewPage
                cont% = 1
                
''                Printer.FontBold = True
''                Printer.CurrentX = 0
''                Printer.CurrentY = 0
''                Printer.FontSize = 12
''                Printer.Print ""
''                Printer.Print "                                                               Fecha: " & VGFecha$
''                Printer.Print "                                                               Página: " & Printer.Page
''
''                Printer.FontBold = True
''                Printer.CurrentX = 0
''                Printer.CurrentY = 0
''                Printer.FontSize = 36
''                Printer.Print VGBanco$
''                Printer.FontSize = 10
''                Printer.Print ""
''                Printer.Print ""
''                Printer.FontSize = 16
''                Printer.Print "OPERACIONES SUPERIORES A "; txtCampo.Text; " EN CUENTAS DE AHORRO"
                FMCabeceraReporte VGBanco$, Date, "OPERACIONES SUPERIORES A " + txtCampo(0).Text + " EN CUENTAS DE AHORRO", _
                                Time(), Me.Caption, VGFecha$, Printer.Page
                Printer.FontBold = True
                Printer.Print "MONEDA: "; VGMoneda$
                Printer.Print ""
                Printer.Print ""
                Printer.Print ""
                Printer.FontSize = 6.5
                Printer.Print "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
                Printer.Print "No. CUENTA       NOMBRE                           DESC. PB              TRAN   CAUSA SIG            MONTO           AGENCIA            USUARIO         HORA        SEC     ALT"
                Printer.Print "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
               Printer.FontBold = False

            End If
        Next j%
        'Printer.FontSize = 12
        Printer.Print "--------------------------------------------------------------------------------------------------------------------------------------------------------"
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print Tab(4); VGLogin
        Printer.Print "_________________                                                 _________________"
        Printer.Print "  PROCESADO POR                                                     VERIFICADO POR "
        Printer.Print ""
        If VGCodPais$ <> "CO" Then
            Printer.Print "---  U L T I M A   L I N E A  ---"
        End If
        Printer.EndDoc
        Screen.MousePointer = 0
    'End If
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
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    PMLimpiaGrid grdOperaciones
    grdOperaciones.ColWidth(1) = 650
    cmdBoton(1).Enabled = False
    cmdBoton(5).Enabled = False
    txtOficina.Text = ""
    lblEtiqueta(3).Caption = ""
    lblEtiqueta(6).Caption = ""
    lblEtiqueta(7).Caption = ""
    'INI CMU REQ023 05/03/2010
    txtCampo(1).Text = ""
    txtCampo(2).Text = ""
    txtCampo(0).Enabled = True
    'txtcampo(0).Text = ""
    txtCampo(0).Text = Format("0.00", "#,###0.00")
    'txtcampo(0).SetFocus
    
    'FIN CMU REQ023 05/03/2010
End Sub

Private Sub PLSiguientes()
'*************************************************************
' PROPOSITO: Llena el grid con los siguientes 20 registros
'            retornados por el stored procedure
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
       
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "302"
             PMPasoValores sqlconn&, "@i_monto", 0, SQLMONEY, txtCampo(0).Text
             PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
             VLUltLinea = grdOperaciones.Rows - 1
             PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, VLSec
             PMPasoValores sqlconn&, "@i_cod_alterno", 0, SQLINT4, VLAlt
             PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VGMoneda
             If txtOficina.Text <> "" Then
                PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, txtOficina.Text
             End If
             
             ' INI CMU REQ023 BPT 04/03/2010
             If txtCampo(1).Text <> "" Then
                PMPasoValores sqlconn&, "@i_territorial", 0, SQLINT4, txtCampo(1).Text
             End If
             
             If txtCampo(2).Text <> "" Then
                PMPasoValores sqlconn&, "@i_zona", 0, SQLINT4, txtCampo(2).Text
             End If
             ' FIN CMU REQ023 BPT 04/03/2010
             
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_ahop_superiores_a", True, " Ok... Consulta de chequeras en la imprenta") Then
                 PMMapeaGrid sqlconn&, grdOperaciones, True
                 PMChequea sqlconn&
                grdOperaciones.ColAlignment(1) = 2  'Cuenta
                grdOperaciones.ColWidth(1) = 900
                grdOperaciones.ColAlignment(2) = 0  'Nombre
                grdOperaciones.ColWidth(2) = 3000
                grdOperaciones.ColAlignment(3) = 0  'Desc. PB
                grdOperaciones.ColWidth(3) = 1200
                grdOperaciones.ColAlignment(4) = 1  'Tran.
                grdOperaciones.ColWidth(4) = 500
                grdOperaciones.ColAlignment(5) = 2  'Causa
                grdOperaciones.ColWidth(5) = 500
                grdOperaciones.ColAlignment(6) = 2  'Signo
                grdOperaciones.ColWidth(6) = 500
                grdOperaciones.ColAlignment(7) = 1  'Monto
                grdOperaciones.ColWidth(7) = 1150
                grdOperaciones.ColAlignment(8) = 0  'Oficina
                grdOperaciones.ColWidth(8) = 2000
                grdOperaciones.ColAlignment(9) = 2  'Usuario
                grdOperaciones.ColWidth(9) = 700
                grdOperaciones.ColAlignment(10) = 2 'Hora
                grdOperaciones.ColWidth(10) = 500
                grdOperaciones.ColAlignment(11) = 1 'Secuencial
                grdOperaciones.ColWidth(11) = 800
                grdOperaciones.ColAlignment(12) = 1 'Secuencial Alterno
                grdOperaciones.ColWidth(12) = 600
                
                PLEliminarDup
                If grdOperaciones.Tag = 21 Then
                    cmdBoton(1).Enabled = True
                Else
                    cmdBoton(1).Enabled = False
                End If
                
                grdOperaciones.Row = grdOperaciones.Rows - 1
                grdOperaciones.Col = 11
                VLSec = grdOperaciones.Text
                
                grdOperaciones.Col = 12
                VLAlt = grdOperaciones.Text
           End If
End Sub

Private Sub PLTransmitir()
'*************************************************************
' PROPOSITO: Permite hacer la consulta de operaciones superiores
'            a un monto
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

        If txtCampo(1).Text = "" And txtCampo(2).Text = "" And txtOficina.Text = "" Then
           MsgBox "Debe seleccionar Territorial y/o Zona y/o Sucursal", 0 + 16, "Mensaje de Error"
           txtCampo(1).SetFocus
           Exit Sub
        End If
        
         If txtCampo(0).Text = "" Then
           MsgBox "El monto es un dato mandatorio", 0 + 16, "Mensaje de Error"
           txtCampo(0).SetFocus
           Exit Sub
        End If
                          
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "302"
             PMPasoValores sqlconn&, "@i_monto", 0, SQLMONEY, txtCampo(0).Text
             PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
             PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VGMoneda
             If txtOficina.Text <> "" Then
                PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, txtOficina.Text
             End If
             
             ' INI CMU REQ023 BPT 04/03/2010
             If txtCampo(1).Text <> "" Then
                PMPasoValores sqlconn&, "@i_territorial", 0, SQLINT4, txtCampo(1).Text
             End If
             
             If txtCampo(2).Text <> "" Then
                PMPasoValores sqlconn&, "@i_zona", 0, SQLINT4, txtCampo(2).Text
             End If
             ' FIN CMU REQ023 BPT 04/03/2010
             
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_ahop_superiores_a", True, " Ok... Consulta de Operaciones Superiores a un monto") Then
                 PMMapeaGrid sqlconn&, grdOperaciones, False
                 PMChequea sqlconn&
                grdOperaciones.ColAlignment(1) = 2  'Cuenta
                grdOperaciones.ColWidth(1) = 900
                grdOperaciones.ColAlignment(2) = 0  'Nombre
                grdOperaciones.ColWidth(2) = 3000
                grdOperaciones.ColAlignment(3) = 0  'Desc. PB
                grdOperaciones.ColWidth(3) = 1200
                grdOperaciones.ColAlignment(4) = 1  'Tran.
                grdOperaciones.ColWidth(4) = 500
                grdOperaciones.ColAlignment(5) = 2  'Causa
                grdOperaciones.ColWidth(5) = 500
                grdOperaciones.ColAlignment(6) = 2  'Signo
                grdOperaciones.ColWidth(6) = 500
                grdOperaciones.ColAlignment(7) = 1  'Monto
                grdOperaciones.ColWidth(7) = 1150
                grdOperaciones.ColAlignment(8) = 0  'Oficina
                grdOperaciones.ColWidth(8) = 2000
                grdOperaciones.ColAlignment(9) = 2  'Usuario
                grdOperaciones.ColWidth(9) = 700
                grdOperaciones.ColAlignment(10) = 2 'Hora
                grdOperaciones.ColWidth(10) = 500
                grdOperaciones.ColAlignment(11) = 1 'Secuencial
                grdOperaciones.ColWidth(11) = 800
                grdOperaciones.ColAlignment(12) = 1 'Secuencial Alterno
                grdOperaciones.ColWidth(12) = 600

                If grdOperaciones.Tag = 20 Then
                    cmdBoton(1).Enabled = True

                Else
                    cmdBoton(1).Enabled = False
                End If
            
                If Val(grdOperaciones.Tag) >= 1 Then
                    cmdBoton(5).Enabled = True
                End If

                txtCampo(0).Enabled = False
                grdOperaciones.Row = grdOperaciones.Rows - 1
                grdOperaciones.Col = 11
                VLSec = grdOperaciones.Text
                
                grdOperaciones.Col = 12
                VLAlt = grdOperaciones.Text
            End If
End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 0, 1, 2
        VLPaso% = False
    End Select
End Sub
Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Monto de Base"
        txtCampo(0).SelStart = 0
        txtCampo(0).SelLength = Len(txtCampo(0).Text)
        txtCampo(0).Text = Format(txtCampo(0).Text, "#,###0.00")
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Código Territorial"
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Codigo Zona"
    End Select
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
End Sub

'Private Sub txtCampo_KeyPress(KeyAscii As Integer)
' 'KeyAscii% = FMValidaTipoDato("N", KeyAscii%)
'    If (KeyAscii% <> 46) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) And (KeyAscii% <> 8) Then
'        KeyAscii% = 0
'    End If
'End Sub


Private Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index%
    Case 0
    
        If txtCampo(0).Text <> "" Then
            txtCampo(0).Text = Format(txtCampo(0).Text, "#,###0.00")
        Else
            txtCampo(0).Text = Format("0.00", "#,###0.00")
        End If
        
        cmdBoton(2).Enabled = True
        
    Case 1 'territorial
    If VLPaso% = False Then
            If txtCampo(1).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1574"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "VS"
                 PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "R"
                ' PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, txtCampo(1).Text
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_oficina", True, "Ok... Consulta de TERRITORIAL") Then
                     PMMapeaObjeto sqlconn&, lblEtiqueta(6)
                     PMChequea sqlconn&
                Else
                    VLPaso% = True
                    txtCampo(1).Text = ""
                    lblEtiqueta(6).Caption = ""
                    If txtCampo(1).Enabled = True Then
                        txtCampo(1).SetFocus
                    End If
                End If
            Else
                lblEtiqueta(6).Caption = ""
            End If
     End If
     Case 2 'zona
    If VLPaso% = False Then
            If txtCampo(2).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1574"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "VS"
                 PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "Z"
                ' PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, txtCampo(2).Text
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_oficina", True, "Ok... Consulta de ZONA") Then
                     PMMapeaObjeto sqlconn&, lblEtiqueta(7)
                     PMChequea sqlconn&
                Else
                    VLPaso% = True
                    txtCampo(2).Text = ""
                    lblEtiqueta(7).Caption = ""
                    If txtCampo(2).Enabled = True Then
                        txtCampo(2).SetFocus
                    End If
                End If
            Else
                lblEtiqueta(7).Caption = ""
            End If
     End If

    End Select
   
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    If Keycode = VGTeclaAyuda% Then
        Select Case Index%
       
        Case 1 'territorial
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1574"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "S"
         PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "C"
       
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_oficina", True, "Ok... Consulta de Territorial") Then
             PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, True
             PMChequea sqlconn&
             FCatalogo.Show 1
             txtCampo(1).Text = VGACatalogo.Codigo$
             lblEtiqueta(6).Caption = VGACatalogo.Descripcion$
         Else
                txtCampo(1).Text = ""
                lblEtiqueta(6).Caption = ""
                txtCampo(1).SetFocus
           
         End If
        Case 2 'zona
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1574"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "S"
         PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "O"
       
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_oficina", True, "Ok... Consulta de zona") Then
             PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, True
             PMChequea sqlconn&
             FCatalogo.Show 1
             txtCampo(2).Text = VGACatalogo.Codigo$
             lblEtiqueta(7).Caption = VGACatalogo.Descripcion$
         Else
                txtCampo(2).Text = ""
                lblEtiqueta(7).Caption = ""
                txtCampo(2).SetFocus
           
         End If

        End Select
    End If

End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0
            Clipboard.Clear
            Clipboard.SetText Format$("0.00", "#,##0.00")
        Case 1, 2
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub

Private Sub txtoficina_GotFocus()
   FPrincipal!pnlHelpLine.Caption = " Oficina"
End Sub

Private Sub txtOficina_LostFocus()
    If txtOficina <> "" Then
        If txtOficina.Text >= 32000 Then
            MsgBox "La Sucursal no puede ser mayor a 32000", 0 + 16, "Mensaje de Error"
            txtOficina.SetFocus
            Exit Sub
        End If
    End If
End Sub

Private Sub txtoficina_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Clipboard.Clear
    Clipboard.SetText ""
End Sub

