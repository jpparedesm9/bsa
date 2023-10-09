VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FImagenes 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Firmas y Sellos de la Cuenta"
   ClientHeight    =   5610
   ClientLeft      =   1200
   ClientTop       =   1500
   ClientWidth     =   9300
   ClipControls    =   0   'False
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
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5610
   ScaleWidth      =   9300
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   7455
      TabIndex        =   2
      Top             =   4545
      Visible         =   0   'False
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Refrescar"
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
   End
   Begin MSGrid.Grid grdImagen 
      Height          =   4470
      Left            =   0
      TabIndex        =   0
      Top             =   15
      Width           =   9270
      _Version        =   65536
      _ExtentX        =   16352
      _ExtentY        =   7885
      _StockProps     =   77
      ForeColor       =   0
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8400
      TabIndex        =   1
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
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Label Label1 
      BackColor       =   &H00C0C0C0&
      Height          =   255
      Left            =   2130
      TabIndex        =   9
      Top             =   5190
      Width           =   3015
   End
   Begin VB.Label Lbltitularidad 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Titularidad:"
      Height          =   255
      Left            =   60
      TabIndex        =   8
      Top             =   5190
      Width           =   1455
   End
   Begin VB.Label lblnomente 
      BackColor       =   &H00C0C0C0&
      Height          =   255
      Left            =   3000
      TabIndex        =   7
      Top             =   4890
      Width           =   4215
   End
   Begin VB.Label lblCodente 
      BackColor       =   &H00C0C0C0&
      Height          =   255
      Left            =   2130
      TabIndex        =   6
      Top             =   4890
      Width           =   975
   End
   Begin VB.Label lbltotalfirmas 
      BackColor       =   &H00C0C0C0&
      Height          =   255
      Left            =   2130
      TabIndex        =   5
      Top             =   4590
      Width           =   4095
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Cliente :"
      Height          =   195
      Left            =   60
      TabIndex        =   4
      Top             =   4890
      Width           =   720
   End
   Begin VB.Label Label6 
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Total Firmas a  Revisar:"
      Height          =   195
      Left            =   60
      TabIndex        =   3
      Top             =   4590
      Width           =   2040
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   0
      X2              =   9285
      Y1              =   4515
      Y2              =   4515
   End
End
Attribute VB_Name = "FImagenes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
Dim VLTitularidad As String
Dim VLNomCta As String
Dim VLCedRuc As String
Dim VLClaseCta As String
Dim VLImagen As String
Dim VLSeguir As String


'Dim VLTitularidad As String
                 


'*************************************************************
' ARCHIVO:          Ffsimg.frm
' NOMBRE LOGICO:    FImagenes
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
' Permite ver las firmas y sellos de las cuentas
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
    Case 0
        Unload FImagenes
    Case 1
        PLRefresca
    End Select
End Sub

Private Sub cmdBoton_GotFocus(Index As Integer)
Select Case Index
Case 0
    FPrincipal!pnlHelpLine.Caption = " Salir"
Case 1
    FPrincipal!pnlHelpLine.Caption = " Actualizar Consulta de Firmas y Sellos de la Cuenta"
End Select
End Sub

Private Sub Form_Load()
    PLRefresca
    PMLoadResStrings Me
    PMLoadResIcons Me
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdImagen_DblClick()
Dim VTFirma As String
Dim Codigo As String
Dim Descrip As String



If grdImagen.Text <> "" Then
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
    VTFirma = Mid$(grdImagen.Text, 1, InStr(1, grdImagen.Text, "-") - 1)
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "3020"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "E"
    PMPasoValores sqlconn&, "@i_imagen", 0, SQLINT4, VTFirma$
    If FMTransmitirRPC(sqlconn&, ServerName$, "firmas", "sp_consulta_condiciones", True, " Ok ... Consulta de firmas y/o sellos") Then
        PMMapeaVariable sqlconn&, Codigo
        PMMapeaVariable sqlconn&, Descrip
        PMChequea sqlconn&
        lblCodente.Caption = Codigo$
        lblnomente.Caption = Descrip$
    Else
      PMChequea sqlconn&
      Exit Sub
    End If
Else
        lblCodente.Caption = ""
        lblnomente.Caption = ""
End If 'imagen vacio
End Sub

Private Sub grdImagen_GotFocus()
FPrincipal!pnlHelpLine.Caption = " Firmas y Sellos de la Cuenta"
End Sub

Private Sub PLRefresca()
Dim VTNoPaso As Integer
Dim VTFila As Integer
Dim VTcolumna As Integer
Dim VTFlag As Integer
Dim VTIMAGEN As String
Dim VTpos As Integer
Dim VTR1 As Integer



    grdImagen.Rows = 2
    grdImagen.Cols = 3
    
    If VGADatosI(2) = "AHO" Then
         PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, VGADatosI(1)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
         PMPasoValores sqlconn&, "@i_cerrada", 0, SQLCHAR, "C"
         PMPasoValores sqlconn&, "@o_titularidad", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta ") Then
            PMMapeaVariable sqlconn&, VLTitularidad
            PMChequea sqlconn&
            VGTitularidad = FMRetParam(sqlconn&, 1)
            Label1.Caption = VGTitularidad

        End If
    Else
        If VGADatosI(2) = "CTE" Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, VGADatosI(1)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Cuenta ") Then
                 PMMapeaVariable sqlconn&, VLNomCta
                 PMMapeaVariable sqlconn&, VLCedRuc$
                 PMMapeaVariable sqlconn&, VLClaseCta$
                 PMMapeaVariable sqlconn&, VLTitularidad$
                 PMChequea sqlconn&
             End If
             
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "re_titularidad"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, VLTitularidad$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina ") Then
                PMMapeaObjeto sqlconn&, Label1
                PMChequea sqlconn&
             End If
        End If
    End If
    

    
    
    For i% = 0 To grdImagen.Cols - 1
        grdImagen.col = i%
        grdImagen.ColWidth(i%) = 1
        For j% = 0 To grdImagen.Rows - 1
            grdImagen.Row = j%
            grdImagen.Text = ""
            grdImagen.Picture = LoadPicture("")
            grdImagen.RowHeight(j%) = 1
        Next j%
    Next i%
    VTNoPaso = True
    Dim VTTipo As Boolean
    VTTipo = True
       
    VTFila = 1
    VTcolumna = 0
    VTFlag% = True
    VTIMAGEN = "0"
    Do While VTFlag%
         VTpos = InStr(VTIMAGEN$, "-")
         If VTpos% <> 0 Then
'FIXIT: Replace 'RTrim' function with 'RTrim$' function                                    FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
           VLImagen = RTrim(Mid(VTIMAGEN$, 1, VTpos% - 1))
         Else
'FIXIT: Replace 'RTrim' function with 'RTrim$' function                                    FixIT90210ae-R9757-R1B8ZE
           VLImagen$ = RTrim(VTIMAGEN$)
         End If
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "3016"
         PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, VGADatosI(1)
         PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR, VGADatosI(2)
             PMPasoValores sqlconn&, "@i_imagen", 0, SQLINT4, VLImagen$ 'VTImagen$
          PMPasoValores sqlconn&, "@i_interface", 0, SQLVARCHAR, "S" 'CVA Jun-9-06 Visualizar firmas autorizadas
         PMPasoValores sqlconn&, "@o_mas", 1, SQLINT2, "0"
         If FMTransmitirRPC(sqlconn&, ServerName$, "firmas", "sp_query_candidata", True, " Ok ... Consulta de firmas y/o sellos") Then
            If VTIMAGEN$ = "0" Then
                ReDim VGGrafo(100, 5) As String
            End If
             VTR1 = FMMapeaGrafo(sqlconn&, VGGrafo(), VTTipo)
             PMMapeaVariable sqlconn&, VLSeguir
             PMChequea sqlconn&
            If VLSeguir$ <> "0" Then
             'If FMRetParam(SqlConn&, 1) <> "0" Then
                VTFlag% = True
                VTIMAGEN$ = VGGrafo(Val(VGGrafo(0, 0)), 0)
                VTTipo = False
            Else
                VTFlag% = False
            End If
        Else
            MsgBox "No existen firmas y/o sellos capturados...", 0 + 16, "Mensaje del Sistema"
            VTFlag% = False
            VTNoPaso% = False
        End If
    Loop
    lbltotalfirmas.Caption = 0
    If VTNoPaso% Then
        If Val(VGGrafo(0, 0)) >= 1 Then
            For i% = 1 To Val(VGGrafo(0, 0))
                VTcolumna% = VTcolumna% + 1
                grdImagen.SelStartRow = VTFila%
                grdImagen.SelStartCol = VTcolumna%
                grdImagen.SelEndRow = VTFila%
                grdImagen.SelEndCol = VTcolumna%
                BitMap grdImagen, VGGrafo(i%, 1), VTcolumna%, VTFila%
                grdImagen.col = VTcolumna%
                grdImagen.Row = VTFila%
                grdImagen.Text = VGGrafo(i%, 0)
            'CVargas Agrandar el RowHeight
                grdImagen.RowHeight(VTFila%) = 2200 '1900
                grdImagen.ColWidth(VTcolumna%) = 6000 '5500
                grdImagen.ColAlignment(VTcolumna%) = 0
                If (VTcolumna% = 2) And (i% < Val(VGGrafo(0, 0))) Then
                    VTcolumna% = 0
                    VTFila% = VTFila% + 1
                    grdImagen.AddItem "" & Chr$(9) & "" & Chr$(9)
                End If
            Next i%
            lbltotalfirmas.Caption = i% - 1
        End If
    End If
End Sub



