VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FConsulMas 
   Appearance      =   0  'Flat
   Caption         =   " Consulta de Costos en Linea"
   ClientHeight    =   5325
   ClientLeft      =   105
   ClientTop       =   1410
   ClientWidth     =   9300
   BeginProperty Font 
      Name            =   "Small Fonts"
      Size            =   6.75
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   Icon            =   "FCONMAS.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.CommandButton cmdBoton 
      Caption         =   "Sig&tes."
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
      Height          =   740
      Index           =   3
      Left            =   8400
      Picture         =   "FCONMAS.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   7
      Tag             =   "4083"
      Top             =   795
      Width           =   875
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   2985
      Left            =   15
      TabIndex        =   28
      Top             =   2310
      Width           =   8310
      _Version        =   65536
      _ExtentX        =   14659
      _ExtentY        =   5266
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
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
      Left            =   8400
      Picture         =   "FCONMAS.frx":053C
      Style           =   1  'Graphical
      TabIndex        =   6
      Tag             =   "4083"
      Top             =   30
      Width           =   875
   End
   Begin VB.TextBox txtCampo 
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
      Index           =   1
      Left            =   2160
      MaxLength       =   5
      TabIndex        =   4
      Top             =   1320
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
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
      Index           =   5
      Left            =   2160
      MaxLength       =   4
      TabIndex        =   5
      Top             =   1575
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
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
      Index           =   4
      Left            =   2160
      MaxLength       =   3
      TabIndex        =   2
      Top             =   555
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
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
      Index           =   0
      Left            =   2160
      MaxLength       =   2
      TabIndex        =   0
      Top             =   45
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
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
      Index           =   3
      Left            =   2160
      MaxLength       =   2
      TabIndex        =   1
      Top             =   300
      Width           =   930
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
      Height          =   740
      Index           =   2
      Left            =   8400
      Picture         =   "FCONMAS.frx":079E
      Style           =   1  'Graphical
      TabIndex        =   9
      Top             =   4545
      Width           =   875
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
      Height          =   740
      Index           =   1
      Left            =   8400
      Picture         =   "FCONMAS.frx":0B04
      Style           =   1  'Graphical
      TabIndex        =   8
      Top             =   3800
      Width           =   875
   End
   Begin VB.TextBox txtCampo 
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
      Left            =   2160
      MaxLength       =   2
      TabIndex        =   3
      Top             =   1050
      Width           =   930
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   8340
      X2              =   0
      Y1              =   2100
      Y2              =   2100
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de Valores del Servicio:"
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
      Height          =   165
      Index           =   1
      Left            =   45
      TabIndex        =   29
      Top             =   2115
      Width           =   2235
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   4
      Left            =   3105
      TabIndex        =   16
      Top             =   1320
      Width           =   5220
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Moneda:"
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
      Height          =   165
      Index           =   16
      Left            =   45
      TabIndex        =   17
      Top             =   810
      Width           =   675
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   11
      Left            =   3105
      TabIndex        =   18
      Top             =   810
      Width           =   5220
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   9
      Left            =   2160
      TabIndex        =   19
      Top             =   810
      Width           =   930
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Sucursal:"
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
      Height          =   165
      Index           =   11
      Left            =   45
      TabIndex        =   20
      Top             =   1320
      Width           =   720
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Prod. Bancario:"
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
      Height          =   165
      Index           =   12
      Left            =   45
      TabIndex        =   21
      Top             =   45
      Width           =   1215
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   10
      Left            =   3105
      TabIndex        =   23
      Top             =   45
      Width           =   5220
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   8
      Left            =   3105
      TabIndex        =   27
      Top             =   1575
      Width           =   5220
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Servicio disponible:"
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
      Height          =   165
      Index           =   10
      Left            =   45
      TabIndex        =   26
      Top             =   1590
      Width           =   1515
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Producto Cobis:"
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
      Height          =   165
      Index           =   8
      Left            =   45
      TabIndex        =   25
      Top             =   555
      Width           =   1275
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   7
      Left            =   3105
      TabIndex        =   24
      Top             =   555
      Width           =   5220
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   2
      Left            =   2160
      TabIndex        =   14
      Top             =   1830
      Width           =   930
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Rubro:"
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
      Height          =   165
      Index           =   9
      Left            =   45
      TabIndex        =   15
      Top             =   1830
      Width           =   525
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   1
      Left            =   3105
      TabIndex        =   22
      Top             =   1830
      Width           =   5220
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   0
      Left            =   3105
      TabIndex        =   13
      Top             =   300
      Width           =   5220
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   3
      Left            =   3105
      TabIndex        =   12
      Top             =   1065
      Width           =   5220
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Mercado:"
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
      Height          =   165
      Index           =   5
      Left            =   45
      TabIndex        =   11
      Top             =   300
      Width           =   735
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Categoría:"
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
      Height          =   165
      Index           =   0
      Left            =   45
      TabIndex        =   10
      Top             =   1065
      Width           =   825
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8355
      X2              =   8355
      Y1              =   15
      Y2              =   5475
   End
End
Attribute VB_Name = "FConsulMas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
Dim VLPaso As Integer
Dim VLTrans As Integer
'! removed Dim VLDato As String

'! removed Dim VLFormatoFecha As String

'! removed Dim VLMoneda As String


Private Sub cmdBoton_Click(Index As Integer)
   Dim VTFilas%
   Dim VTRango$
   Dim VTCategoria$

   Select Case Index%
    Case 0
     'Buscar
        If txtCampo(0).Text = "" Then
            MsgBox "El producto bancario es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        
        If txtCampo(3).Text = "" Then
            MsgBox "El código del mercado es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        
        If txtCampo(4).Text = "" Then
            MsgBox "El código de la moneda es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(4).SetFocus
            Exit Sub
        End If

        If txtCampo(2).Text = "" Then
            MsgBox "La categoría es mandatoria", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            MsgBox "La Sucursal es Mandatoria", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If

     VTFilas% = VGMaxRows%
     VTRango$ = "0"
     VTCategoria$ = "0"
     While VTFilas% = VGMaxRows%


         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4083"
         'PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR, "I"
         PMPasoValores sqlconn&, "@i_pro_cobis", 0, SQLINT1, txtCampo(4).Text
         PMPasoValores sqlconn&, "@i_pro_banc", 0, SQLINT2, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_sector", 0, SQLVARCHAR, txtCampo(3).Text
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, lblDescripcion(9).Caption
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_categoria", 0, SQLVARCHAR, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_suc", 0, SQLINT2, txtCampo(1).Text
        If txtCampo(5).Text <> "" Then
             PMPasoValores sqlconn&, "@i_ser_disp", 0, SQLINT2, txtCampo(5).Text
        End If

        If lblDescripcion(2).Caption <> "" Then
             PMPasoValores sqlconn&, "@i_rubro", 0, SQLVARCHAR, lblDescripcion(2).Caption
        End If
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_con_costot_linea", True, "Ok...Consulta de Costos - Servicios") Then
                If VTRango$ = "0" Then
                     PMMapeaGrid sqlconn&, grdRegistros, False
                Else
                     PMMapeaGrid sqlconn&, grdRegistros, True
                End If
    
                 PMChequea sqlconn&
                If Val(grdRegistros.Tag) > 0 Then
                    grdRegistros.ColAlignment(3) = 1
                    grdRegistros.ColAlignment(4) = 1
                    grdRegistros.ColAlignment(5) = 1
                    grdRegistros.ColAlignment(6) = 1
                    grdRegistros.ColAlignment(7) = 1
                    grdRegistros.ColAlignment(8) = 2


                End If
    
                'grdRegistros.Col = 2
                'grdRegistros.Row = grdRegistros.Rows - 1
                'VTRango$ = grdRegistros.Text
    
            End If
            VTFilas% = Val(grdRegistros.Tag)
       Wend
            grdRegistros.Col = 1
       If Val(grdRegistros.Tag) = VGMaxRows% + 5 Then
                cmdBoton(3).Enabled = True
       End If

       

    Case 1 'Limpiar
        
        
        If txtCampo(5).Text <> "" Then
            txtCampo(5).Text = ""
            txtCampo(5).Enabled = True
            lblDescripcion(8).Caption = ""
            lblDescripcion(2).Caption = ""
            lblDescripcion(1).Caption = ""
            txtCampo(5).SetFocus
        Else
            If txtCampo(1).Text <> "" Then
                txtCampo(1).Text = ""
                txtCampo(1).Enabled = True
                lblDescripcion(4).Caption = ""
                txtCampo(1).SetFocus
             Else
                If txtCampo(2).Text <> "" Then
                    txtCampo(2).Text = ""
                    txtCampo(2).Enabled = True
                    lblDescripcion(3).Caption = ""
                    txtCampo(2).SetFocus
                Else
                    If txtCampo(4).Text <> "" Then
                        txtCampo(4).Text = ""
                        lblDescripcion(7).Caption = ""
                        lblDescripcion(9).Caption = ""
                        lblDescripcion(11).Caption = ""
                        txtCampo(4).Enabled = True
                        txtCampo(4).SetFocus
                    Else
                        If txtCampo(3).Text <> "" Then
                            txtCampo(3).Text = ""
                            txtCampo(3).Enabled = True
                            lblDescripcion(0).Caption = ""
                            txtCampo(3).SetFocus
                        Else
                            If txtCampo(0).Text <> "" Then
                                txtCampo(0).Text = ""
                                txtCampo(0).Enabled = True
                                lblDescripcion(10).Caption = ""
                            End If
                        End If
                            
                    End If
                End If
             End If
        End If
        VLPaso% = True
        
        cmdBoton(0).Enabled = True
        FPrincipal.pnlHelpLine.Caption = ""
        FPrincipal.pnlTransaccionLine.Caption = ""
        'cmdBoton_Click (3)
        

    Case 2 'Salir
        Unload FConsulMas

    Case 3  'Siguientes

        grdRegistros.Row = grdRegistros.Rows - 1
        grdRegistros.Col = 12
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4083"
         'PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR, "I"
         PMPasoValores sqlconn&, "@i_pro_cobis", 0, SQLINT1, txtCampo(4).Text
         PMPasoValores sqlconn&, "@i_pro_banc", 0, SQLINT2, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_sector", 0, SQLVARCHAR, txtCampo(3).Text
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, lblDescripcion(9).Caption
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_categoria", 0, SQLVARCHAR, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_suc", 0, SQLINT2, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, (grdRegistros.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_con_costot_linea", True, "Ok... Consulta de Servicios Personalizables") Then
             PMMapeaGrid sqlconn&, grdRegistros, True
             PMChequea sqlconn&
            ' If Val(grdRegistros.Tag) > 0 Then
            '    grdRegistros.ColWidth(2) = 1
            '    grdRegistros.ColWidth(4) = 1
            '    grdRegistros.ColWidth(6) = 1
            '    grdRegistros.ColWidth(8) = 1
            '    grdRegistros.ColWidth(10) = 1
            '    grdRegistros.ColWidth(9) = 1
            '
            ' End If
            
            If Val(grdRegistros.Tag) = VGMaxRows% + 5 Then
                cmdBoton(3).Enabled = True
            Else
                cmdBoton(3).Enabled = False
            End If
            grdRegistros.Row = 1
        End If

    
End Select
End Sub

Private Sub Form_Load()
Dim i%
    FConsulMas.Left = 15
    FConsulMas.Top = 15
    FConsulMas.Width = 9420
    FConsulMas.Height = 5730
    'PMBotonSeguridad FConsulMas, 2
    'cmdBoton(0).Enabled = True
    'cmdBoton(3).Enabled = False
'    VLFecha$ = DateAdd("d", 1, VGFecha)
'    mskFecha.Mask = FMMascaraFecha("mm/dd/yyyy")
'    mskFecha.Text = Format$(VLFecha$, "mm/dd/yyyy")
    VLTrans% = True
    For i% = 0 To 5
        txtCampo(i%).Height = 240
    Next
 PMObjetoSeguridad cmdBoton(0)
 PMObjetoSeguridad cmdBoton(3)
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub PMSubserv()
    If VGDetalle(0) = "S" Then
        If txtCampo(5).Text = "" Then

            lblDescripcion(8).Caption = VGDetalle(1) 'des serv dis
            lblDescripcion(1).Caption = VGDetalle(2) 'des rubro
            txtCampo(5).Text = VGDetalle(3) 'cod serv dis
            lblDescripcion(2).Caption = VGDetalle(4) 'cod rubro
            
        Else
            
            lblDescripcion(8).Caption = VGDetalle(1) 'des serv dis
            lblDescripcion(1).Caption = VGDetalle(2) 'des rubro
            lblDescripcion(2).Caption = VGDetalle(3) 'cod rubro

        End If
    End If
End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 0, 1, 2, 3, 4, 5
        VLPaso% = False
    End Select

End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Producto Bancario [F5 Ayuda]"
    Case 1
        FPrincipal.pnlHelpLine.Caption = " Código de Sucursal [F5 Ayuda]"
    Case 2
       FPrincipal.pnlHelpLine.Caption = " Categoria [F5 Ayuda]"
    Case 3
        FPrincipal.pnlHelpLine.Caption = " Mercado [F5 Ayuda]"
    Case 4
        FPrincipal.pnlHelpLine.Caption = " Producto Cobis [F5 Ayuda]"
    Case 5
        FPrincipal.pnlHelpLine.Caption = " Codigo de Servicio Dis. [F5 Ayuda]"

    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
Dim i%
    If KeyCode% = VGTeclaAyuda% Then
        VLPaso% = True
        Select Case Index%
    Case 0
          VGOperacion$ = "sp_prod_bancario"
            ' GBB26May98008 II:
            ' Se debe haver un load a la forma antes de cargar los valores
            Load FRegistros
            'GBB26May98008 IF:
        
           PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4002"
           PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
           PMPasoValores sqlconn&, "@i_modo", 0, SQLINT4, "0"
           If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prod_bancario", False, "") Then
                PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                PMChequea sqlconn&
               FRegistros.Show 1
               txtCampo(0).Text = VGACatalogo.Codigo$
               lblDescripcion(10).Caption = VGACatalogo.Descripcion$
               VLPaso% = True
                    
          Else
               VGOperacion$ = ""
          End If

        Case 1

            VGOperacion$ = "sp_hp_sucursal"
            ' GBB26May98008 II:
            ' Se debe haver un load a la forma antes de cargar los valores
            Load FRegistros
            'GBB26May98008 IF:
        
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4079"
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", False, "") Then
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                 PMChequea sqlconn&
                FRegistros.Show 1
                ' PMChequea SqlConn&
                If VGValores(1) <> "" Then
                    txtCampo(1).Text = VGValores(1)
                    lblDescripcion(4).Caption = VGValores(2)
                Else
                    txtCampo(1).Text = ""
                    lblDescripcion(4).Caption = ""
                    VGOperacion$ = ""
                End If
                
                VLPaso% = True
            Else
                txtCampo(1).Text = ""
                lblDescripcion(4).Caption = ""
                VGOperacion$ = ""
            End If
                
        Case 2
            ' Consulta de las categorias
            'If txtCampo(3).Text = "" Then
            '    MsgBox "El código del servicio es mandatorio", 0 + 16, "Mensaje de Error"
            '    txtCampo(3).SetFocus
            '    Exit Sub
            'End If
            PMCatalogo "A", "pe_categoria", txtCampo(2), lblDescripcion(3)
            VLPaso% = True
        Case 3
            ' Consulta sectores
            'IU ERP 02/13/2001 PE00001
            'PMCatalogo "A", "cc_sector", txtCampo(3), lblDescripcion(0)
            PMCatalogo "A", "cc_tipo_banca", txtCampo(3), lblDescripcion(0)
            'FU ERP 02/13/2001 PE00001
            VLPaso% = True


        Case 4
            
            VGOperacion$ = "sp_promon"
            VGTipo$ = "H"
            ' GBB26May98008 II:
            ' Se debe haver un load a la forma antes de cargar los valores
            Load FRegistros
            'GBB26May98008 IF:
        
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4075"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "0"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_promon", True, " Consulta del producto ") Then
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                 PMChequea sqlconn&
                FRegistros.Show 1
                If VGValores(1) <> "" Then

                    txtCampo(4).Text = VGValores(1)
                    lblDescripcion(9).Caption = VGValores(2)
                    lblDescripcion(7).Caption = VGValores(3)
                    'lblDescripcion(11).Caption = VGValores(4)
                    If lblDescripcion(9).Caption = "0" Then
                        lblDescripcion(11).Caption = "PESOS"
                        Else
                           lblDescripcion(11).Caption = "DOLARES"
                    End If

               '     txtCampo(0).SetFocus
                    For i% = 1 To 10
                        VGValores(i%) = ""
                    Next i%
                End If
            Else
            VGOperacion$ = ""
            VGTipo$ = ""
            End If
         
         VLPaso% = True
        Case 5
            VGForma$ = "FConsulMas"
            FAyudaSubserv2.Show 1
            If VGDetalle(1) <> "" Then
                PMSubserv
                VLPaso% = True
            End If
        End Select
        
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 2, 3
        KeyAscii% = FMValidaTipoDato("A", KeyAscii%)
        KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
    Case 0, 1, 4, 5, 6, 7
    If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
Dim i%
    Select Case Index%
    Case 0
        If VLPaso% = False Then
            If txtCampo(0).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4003"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(0).Text
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prod_bancario", False, "") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(10)
                     PMChequea sqlconn&
                Else
                   txtCampo(0).Text = ""
                   lblDescripcion(10).Caption = ""
                   txtCampo(0).SetFocus
                   VLPaso% = True
                End If
            Else
                lblDescripcion(10).Caption = ""
            End If
         End If
    Case 1
        If VLPaso% = False Then
            If txtCampo(1).Text <> "" Then
            
            
              If txtCampo(1).Text > 32000 Then
                    MsgBox "El código de sucursal fuera de rango", 0 + 16, "Mensaje de Error"
                    txtCampo(1).Text = ""
                    txtCampo(1).SetFocus
                    Exit Sub
               End If
               
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4078"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(1).Text
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", True, " Consulta del producto ") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(4)
                     PMChequea sqlconn&
                    
                Else
                    lblDescripcion(4).Caption = ""
                    txtCampo(1).Text = ""
                    txtCampo(1).SetFocus
                   ' VLPaso% = True
                End If
            Else
                lblDescripcion(4).Caption = ""
            End If
        End If
    Case 2
        If VLPaso% = False Then
            If txtCampo(3).Text = "" Then
                MsgBox "El código del servicio es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(3).Text = ""
                txtCampo(3).SetFocus
                Exit Sub
            End If
            If txtCampo(2).Text = "" Then
                lblDescripcion(3).Caption = ""
                Exit Sub
             End If
            PMCatalogo "V", "pe_categoria", txtCampo(2), lblDescripcion(3)
        End If


    Case 3
        If VLPaso% = False Then
            If txtCampo(3).Text = "" Then
                lblDescripcion(0).Caption = ""
                txtCampo(3).SetFocus
                Exit Sub
            End If
            'IU ERP 02/13/2001 PE00001
            'PMCatalogo "V", "cc_sector", txtCampo(3), lblDescripcion(0)
            PMCatalogo "V", "cc_tipo_banca", txtCampo(3), lblDescripcion(0)
            'FU ERP 02/13/2001 PE00001
        End If

    Case 4
      If VLPaso% = False Then
            
    
        If txtCampo(4).Text <> "" Then
            'Tiene que ser una cuenta de ahorros o una cuenta corriente
            If txtCampo(4).Text <> "3" And txtCampo(4).Text <> "4" Then
                MsgBox "Código Incorrecto", 0 + 16, "Mensaje de Error"
                txtCampo(4).Text = ""
                txtCampo(4).SetFocus
                Exit Sub
            End If
            VGOperacion$ = "sp_promon"
            VGTipo$ = "Q"
            ' GBB26May98008 II:
            ' Se debe haver un load a la forma antes de cargar los valores
            Load FRegistros
            'GBB26May98008 IF:
        
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4076"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, txtCampo(4).Text
             PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
             'PMPasoValores SqlConn&, "@i_moneda", 0, SQLINT1, "0"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_promon", True, " Consulta del producto ") Then
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                 PMChequea sqlconn&
                FRegistros.Show 1
                If VGValores(1) <> "" Then
                    lblDescripcion(9).Caption = VGValores(2) 'moneda
                    lblDescripcion(7).Caption = VGValores(3) ' descripcion
                    'lblDescripcion(1).Caption = VGValores(4)' tipo producto
                    If lblDescripcion(9).Caption = "0" Then
                        lblDescripcion(11).Caption = "PESOS"
                        Else
                          lblDescripcion(11).Caption = "DOLARES"
                    End If
                Else
                    If lblDescripcion(7).Caption = "" Then
                        txtCampo(4).Text = ""
                        txtCampo(4).SetFocus
                    End If
                End If
                For i% = 1 To 5
                    VGValores(i%) = ""
                Next i%
            
            Else
                    VLPaso% = True
                    txtCampo(2).Text = ""
                    lblDescripcion(9).Caption = ""
                    lblDescripcion(7).Caption = ""
                    lblDescripcion(11).Caption = ""
                    txtCampo(4).SetFocus
            End If
         Else
            lblDescripcion(9).Caption = ""
            lblDescripcion(7).Caption = ""
            lblDescripcion(11).Caption = ""
            

         End If
        VGOperacion$ = ""
        VGTipo$ = ""
      End If

    Case 5
        If VLPaso% = False Then
            If txtCampo(5).Text <> "" Then
               'VLPaso% = True
               VGForma$ = "FConsulMas"
               FAyudaSubserv2.Show 1
               If VGDetalle(1) <> "" Then
                    PMSubserv
               Else
                    If lblDescripcion(8).Caption = "" Then
                        txtCampo(5).Text = ""
                        txtCampo(5).SetFocus
                        VLPaso% = True
                    End If
               End If
            End If
        End If

    Case 6
      If VLPaso% = False Then
        If txtCampo(6).Text <> "" Then
            
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4038"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(6).Text
             PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, lblDescripcion(9).Caption
             PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "T"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "Ok...Consulta de Servicios") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(6)
                 PMChequea sqlconn&
            Else
                txtCampo(6).Text = ""
                lblDescripcion(6).Caption = ""
                txtCampo(6).SetFocus
                VLPaso% = True
            End If
        Else
           VLPaso% = True
           lblDescripcion(5).Caption = ""
        End If
      End If

    Case 7
        If VLPaso% = False Then
            If txtCampo(6).Text = "" Then
                MsgBox "El tipo de rango es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(6).SetFocus
                Exit Sub
            End If
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4038"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
             PMPasoValores sqlconn&, "@i_grupo", 0, SQLINT2, txtCampo(7).Text
             PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "G"
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(6).Text
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "Ok...Consulta de Servicios") Then
                 PMChequea sqlconn&
            Else
                txtCampo(7).Text = ""
                txtCampo(7).SetFocus
                VLPaso% = True
            End If
       End If

    End Select
    End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0, 1, 2, 3, 4, 5
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub


