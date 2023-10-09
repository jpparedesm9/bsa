VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran218 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Levantamiento de Bloqueo de Valores la Cuenta de Ahorros"
   ClientHeight    =   5310
   ClientLeft      =   120
   ClientTop       =   1800
   ClientWidth     =   9510
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
   HelpContextID   =   1077
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5310
   ScaleWidth      =   9510
   Tag             =   "3842"
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      FillColor       =   &H00808080&
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   0
      Left            =   7920
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   13
      Top             =   2235
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   195
      Index           =   1
      Left            =   8145
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   12
      Top             =   2235
      Visible         =   0   'False
      Width           =   195
   End
   Begin MSGrid.Grid grdListaValores 
      Height          =   2835
      Left            =   30
      TabIndex        =   6
      Top             =   2460
      Width           =   8484
      _Version        =   65536
      _ExtentX        =   14965
      _ExtentY        =   5001
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
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   1950
      TabIndex        =   0
      Top             =   45
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8600
      TabIndex        =   2
      Top             =   945
      WhatsThisHelpID =   2026
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Propiet."
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
   Begin MSGrid.Grid grdPropietarios 
      Height          =   1212
      Left            =   30
      TabIndex        =   1
      Top             =   948
      Width           =   8484
      _Version        =   65536
      _ExtentX        =   14965
      _ExtentY        =   2138
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
      Index           =   0
      Left            =   8600
      TabIndex        =   3
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
      Index           =   1
      Left            =   8600
      TabIndex        =   4
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
      Index           =   2
      Left            =   8600
      TabIndex        =   5
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
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Lista de valores bloqueados:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   45
      TabIndex        =   7
      Top             =   2220
      WhatsThisHelpID =   5137
      Width           =   2535
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Propietarios:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   45
      TabIndex        =   11
      Top             =   705
      WhatsThisHelpID =   5055
      Width           =   1155
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Nombre de la cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   15
      TabIndex        =   10
      Top             =   375
      WhatsThisHelpID =   5265
      Width           =   1920
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8550
      Y1              =   2190
      Y2              =   2190
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de cuenta ahorros:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   15
      TabIndex        =   9
      Top             =   45
      WhatsThisHelpID =   5254
      Width           =   2055
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8550
      Y1              =   660
      Y2              =   660
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8550
      X2              =   8550
      Y1              =   0
      Y2              =   5310
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   0
      Left            =   1950
      TabIndex        =   8
      Top             =   345
      UseMnemonic     =   0   'False
      Width           =   6550
   End
End
Attribute VB_Name = "FTran218"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FTran218.frm
' NOMBRE LOGICO:    FTran218
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
' Permite realizar el levantamiento de bloqueo de valores a una
' cuenta de ahorros.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************


Private Sub Form_Load()
    FTran218.Left = 0
    FTran218.Top = 0
    FTran218.Width = 9600
    FTran218.Height = 5900
    PMLoadResStrings Me
    PMLoadResIcons Me
    mskCuenta.Mask = VGMascaraCtaAho$
    
    picVisto(0).Picture = LoadResPicture(31001, 0)
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub cmdBoton_Click(Index As Integer)
    Dim i As Integer
    
    Select Case Index%
    Case 0
        'Transmitir
        ' Validacion de mandatoriedades
        ' Numero de la cuenta de ahorros
        If Trim$(mskCuenta.ClipText) = "" Then
            MsgBox "El código de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If

        For i% = 1 To grdListaValores.Rows - 1
            grdListaValores.Row = i%
            grdListaValores.Col = 0
            If grdListaValores.Picture = picVisto(0) Then
                FCausaLev.lblProducto = "AHO"
                FCausaLev.Show 1
                If VGNControl$ <> "*" Then
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "218"
                     PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                     PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                     PMPasoValores sqlconn&, "@i_accion", 0, SQLCHAR, "L"
                    grdListaValores.Col = 4
                     PMPasoValores sqlconn&, "@i_valor", 0, SQLMONEY, (grdListaValores.Text)
                     PMPasoValores sqlconn&, "@i_causa", 0, SQLCHAR, VGNControl$
                     PMPasoValores sqlconn&, "@i_aut", 0, SQLVARCHAR, VGLogin$
                    grdListaValores.Col = 12
                     PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, (grdListaValores.Text)
                     PMPasoValores sqlconn&, "@i_solicit", 0, SQLVARCHAR, VGNSolicit$
                     
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_bloq_val_ah", True, "Ok... Levantamiento de retención de valores") Then
                         PMChequea sqlconn&
                         MsgBox "El bloqueo de valor de la cuenta de ahorros fue levantado satisfactoriamente", 0 + vbInformation, "Informacion"
                         PLImprimir 'ARiggs 09-14-06
                    End If
                End If
            End If
        Next i%

        PLBuscar
    Case 1

        'Limpiar

        mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
        PMLimpiaGrid grdPropietarios
        PMLimpiaGrid grdListaValores
        lblDescripcion(0).Caption = ""
        cmdBoton(3).Enabled = False
        mskCuenta.SetFocus
    Case 2

        'Salir

        Unload FTran218
    Case 3
    
        'Consultar

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "298"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_clientes_ah", True, " Ok... Consulta de propietarios") Then
             PMMapeaGrid sqlconn&, grdPropietarios, False
             PMChequea sqlconn&
        Else
            PMLimpiaGrid grdPropietarios
        End If
    End Select
End Sub


Private Sub grdListaValores_Click()
    grdListaValores.Col = 0
    grdListaValores.SelStartCol = 1
    grdListaValores.SelEndCol = grdListaValores.Cols - 1
    If grdListaValores.Row = 0 Then
        grdListaValores.SelStartRow = 1
        grdListaValores.SelEndRow = 1
    Else
        grdListaValores.SelStartRow = grdListaValores.Row
        grdListaValores.SelEndRow = grdListaValores.Row
    End If
End Sub

Private Sub grdListaValores_DblClick()
    ' Verificar que existan chequeras para entregar
    If grdListaValores.Rows <= 2 Then
        grdListaValores.Row = 1
        grdListaValores.Col = 1
        If Trim$(grdListaValores.Text) = "" Then
            MsgBox "No existen valores bloqueados", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
    End If

    PMMarcarRegistro
End Sub

Private Sub grdListaValores_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Lista de propietarios de la cuenta de ahorros"
End Sub

Private Sub grdPropietarios_Click()
    grdPropietarios.Col = 0
    grdPropietarios.SelStartCol = 1
    grdPropietarios.SelEndCol = grdPropietarios.Cols - 1
    If grdPropietarios.Row = 0 Then
        grdPropietarios.SelStartRow = 1
        grdPropietarios.SelEndRow = 1
    Else
        grdPropietarios.SelStartRow = grdPropietarios.Row
        grdPropietarios.SelEndRow = grdPropietarios.Row
    End If
End Sub

Private Sub grdPropietarios_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Lista de propietarios de la cuenta de ahorros"
End Sub

Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta de Ahorros"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaAho((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "206"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             PMPasoValores sqlconn&, "@i_val_inac", 0, SQLVARCHAR, "N" 'PCOELLO NO SE DEBE VALIDAR INACTIVIDAD
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(0)
                 PMChequea sqlconn&
                cmdBoton(3).Enabled = True
                PMLimpiaGrid grdPropietarios
                PLBuscar
            Else
                cmdBoton_Click (1)
                Exit Sub
            End If
        Else
            MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
            cmdBoton_Click (1)
            Exit Sub
        End If
    End If
End Sub

Private Sub PLBuscar()
'*************************************************************
' PROPOSITO: Llena el grid de Valores Bloqueados con los datos
'            retornados por el stored procedure de consulta de
'            valores bloqueados de la cuenta.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    Dim VTModo As String
    Dim VTRows As Integer
    Dim VTSec As String
    Dim VTBorrar As Boolean
    Dim VTFechaHa As String
    Dim i As Integer
    
    ' Determinar los bloqueos posibles de levantar
    VTModo$ = "0"
    VTRows% = VGMaxRows%
    VTSec$ = "0"
    VTBorrar = False

    While VTRows% = VGMaxRows%

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "216"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, VTModo$
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "B"
         PMPasoValores sqlconn&, "@i_fdesde", 0, SQLDATETIME, "01/01/1960"
         VTFechaHa$ = FMConvFecha(VGFecha, VGFormatoFecha$, CGFormatoBase$)
         PMPasoValores sqlconn&, "@i_fhasta", 0, SQLDATETIME, VTFechaHa$
         PMPasoValores sqlconn&, "@i_ope", 0, SQLVARCHAR, "NO"
         PMPasoValores sqlconn&, "@i_sec", 0, SQLINT2, VTSec$
         PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_cons_bloq_ah", True, " Ok... Consulta de la retención de valores") Then
             PMMapeaGrid sqlconn&, grdListaValores, VTBorrar
             PMChequea sqlconn&

            If VTModo$ = "0" Then
                grdListaValores.ColAlignment(1) = 2
                grdListaValores.ColAlignment(3) = 1
                grdListaValores.ColAlignment(4) = 1
                grdListaValores.ColAlignment(5) = 1
            End If

            VTModo$ = "1"
            VTRows% = Val(grdListaValores.Tag)
            VTBorrar = True
            grdListaValores.Col = 12
            grdListaValores.Row = grdListaValores.Rows - 1
            VTSec$ = grdListaValores.Text

        Else
            PMLimpiaGrid grdListaValores
            VTRows% = 0
        End If

    Wend
    
    grdListaValores.Col = 0
    For i% = 1 To grdListaValores.Rows - 1
        grdListaValores.Row = i%
        grdListaValores.Picture = picVisto(1)
    Next i%

End Sub

Private Sub PMMarcarRegistro()
'*************************************************************
' PROPOSITO: Seleccionar y quitar la seleccion de una fila del
'            grid de valores bloqueados.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    grdListaValores.Col = 0
    If grdListaValores.Picture <> picVisto(0) Then
        grdListaValores.Picture = picVisto(0)
    Else
        grdListaValores.Picture = picVisto(1)
    End If
End Sub
Private Sub PLImprimir()
'*************************************************************
' PROPOSITO: Permite imprimir los datos consultados en el grid
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA           AUTOR           RAZON
' 06-Agos-06      A. Riggs        Emisión Inicial
'*************************************************************
    Dim i As Integer
    Dim Fecha As String
    Dim Hora As String
    
    grdListaValores.Col = 0
    If MsgBox("Desea imprimir los datos del Levantamiento del Bloqueo por Valores No. " + grdListaValores.Text, vbYesNo, "Mensaje del Sistema") = vbYes Then
       For i% = 1 To grdListaValores.Rows - 1
          grdListaValores.Row = i%
          grdListaValores.Col = 0
          If grdListaValores.Picture = picVisto(0) Then
             Screen.MousePointer = 11
             FMCabeceraReporte VGBanco$, Date, "LEVANTAMIENTO DE BLOQUEO POR VALORES EN CUENTAS AHORROS", _
                          Time(), Me.Caption, VGFecha$, 1 'Printer.Page
             Printer.FontSize = 8
             Printer.FontBold = True
             Printer.FontName = "Courier New"
             Printer.FontBold = True
             Printer.FontSize = 10
             Printer.Print Tab(5); "Número de Cuenta         :"; Tab(33); mskCuenta.Text
             Printer.Print ""
             Printer.Print Tab(5); "Nombre de la cuenta      :"; Tab(33); lblDescripcion(0).Caption
             
             grdListaValores.Col = 1
             Fecha = Format(grdListaValores.Text$, VGFormatoFecha$)
             
             Hora = grdListaValores.Text
             Printer.Print ""
             Printer.Print Tab(5); "Fecha Bloqueo            :"; Tab(33); Format(grdListaValores.Text$, VGFormatoFecha$)
             
             Printer.Print ""
             grdListaValores.Col = 2
             Printer.Print Tab(5); "Hora Bloqueo             :"; Tab(33); grdListaValores.Text
             
             Printer.Print ""
             grdListaValores.Col = 11
             Printer.Print Tab(5); "Sucursal Bloquea         :"; Tab(33); grdListaValores.Text
                       
             Printer.Print ""
             grdListaValores.Col = 8
             Printer.Print Tab(5); "Usuario Bloquea          :"; Tab(33); grdListaValores.Text
                    
             Printer.Print ""
             Printer.Print Tab(5); "Fecha Levantamiento      :"; Tab(33); (Format(VGFecha$, VGFormatoFecha$))
             
             Printer.Print ""
             Printer.Print Tab(5); "Hora Levantamiento       :"; Tab(33); Time()
                                      
             Printer.Print ""
             grdListaValores.Col = 4
             Printer.Print Tab(5); "Valor del Levantamiento  :"; Tab(33); grdListaValores.Text

             Printer.Print ""
             grdListaValores.Col = 7
             Printer.Print Tab(5); "Fecha Vencimiento        :"; Tab(33); Format(grdListaValores.Text$, VGFormatoFecha$)
            
             Printer.Print ""
             Printer.Print Tab(5); "Sucursal Liberacion      :"; Tab(33); VGOficina
             
             Printer.Print ""
             Printer.Print Tab(5); "Usuario                  :"; Tab(33); VGLogin$
            
             Printer.Print ""
             grdListaValores.Col = 9
             Printer.Print Tab(5); "Solicitante por          :"; Tab(33); VGNSolicit$
            
             Printer.Print ""
             grdListaValores.Col = 10
             Printer.Print Tab(5); "Causa                    :"; Tab(33); VGNCausa$
                                            
             Printer.Print Tab(3); String$(120, "_")
             Printer.Print ""
             Printer.Print ""
             Printer.Print ""
             Printer.Print ""
             Printer.Print Tab(4); VGLogin
             Printer.Print "  _________________                      _________________"
             Printer.Print "  PROCESADO POR                          AUTORIZADO POR "
             Printer.Print ""
             Printer.Print ""
             Printer.Print ""
             Printer.Print ""
               
            If VGCodPais$ <> "CO" Then
                Printer.Print "---  U L T I M A   L I N E A  ---"
            End If
             Printer.EndDoc
             Screen.MousePointer = 0
         End If
      Next i%
   End If
End Sub


