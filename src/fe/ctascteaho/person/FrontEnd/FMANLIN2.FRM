VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#7.0#0"; "MhRealInput.ocx"
Begin VB.Form FMantenLinea2 
   Appearance      =   0  'Flat
   Caption         =   "  Valores de Servicios Personalizables [Mantenimiento Masivo]"
   ClientHeight    =   5325
   ClientLeft      =   210
   ClientTop       =   1560
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
   Icon            =   "FMANLIN2.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      FillColor       =   &H00808080&
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   0
      Left            =   7900
      Picture         =   "FMANLIN2.frx":030A
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   46
      Top             =   15
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   195
      Index           =   1
      Left            =   8130
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   45
      Top             =   15
      Visible         =   0   'False
      Width           =   195
   End
   Begin MSGrid.Grid grdSucurs 
      Height          =   1060
      Left            =   1800
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   1515
      Width           =   6525
      _Version        =   65536
      _ExtentX        =   11510
      _ExtentY        =   1870
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
   End
   Begin MSMask.MaskEdBox mskFecha 
      Height          =   270
      Left            =   1800
      TabIndex        =   0
      Top             =   30
      Width           =   1215
      _ExtentX        =   2143
      _ExtentY        =   476
      _Version        =   393216
      Appearance      =   0
      PromptChar      =   "_"
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   7
      Left            =   1800
      MaxLength       =   2
      TabIndex        =   7
      Top             =   3495
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   6
      Left            =   1800
      MaxLength       =   3
      TabIndex        =   6
      Top             =   3195
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   5
      Left            =   1800
      MaxLength       =   4
      TabIndex        =   5
      Top             =   2600
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   4
      Left            =   1800
      MaxLength       =   2
      TabIndex        =   3
      Top             =   915
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   1800
      MaxLength       =   2
      TabIndex        =   1
      Top             =   315
      Width           =   930
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Ingresar"
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
      Index           =   0
      Left            =   8400
      Picture         =   "FMANLIN2.frx":03E4
      Style           =   1  'Graphical
      TabIndex        =   13
      Tag             =   "4082"
      Top             =   3075
      Width           =   870
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   3
      Left            =   1800
      MaxLength       =   3
      TabIndex        =   2
      Top             =   615
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   1800
      MaxLength       =   2
      TabIndex        =   9
      Top             =   4095
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
      Picture         =   "FMANLIN2.frx":06EE
      Style           =   1  'Graphical
      TabIndex        =   15
      Top             =   4575
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
      Picture         =   "FMANLIN2.frx":0A54
      Style           =   1  'Graphical
      TabIndex        =   14
      Top             =   3825
      Width           =   875
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   1800
      MaxLength       =   2
      TabIndex        =   8
      Top             =   3800
      Width           =   930
   End
   Begin MhinrelLib.MhRealInput mskCosto 
      Height          =   285
      Index           =   1
      Left            =   1800
      TabIndex        =   10
      Top             =   4410
      Width           =   2265
      _Version        =   458753
      _ExtentX        =   3995
      _ExtentY        =   503
      _StockProps     =   205
      ForeColor       =   -2147483630
      Enabled         =   -1  'True
      FillColor       =   16777215
      MaxReal         =   3.4E+38
      MinReal         =   0
      SpinChangeReal  =   0
      AutoHScroll     =   -1  'True
      CaretColor      =   -2147483642
      CaretVisible    =   -1  'True
      DecimalPlaces   =   2
      Separator       =   -1  'True
   End
   Begin MhinrelLib.MhRealInput mskCosto 
      Height          =   285
      Index           =   0
      Left            =   1800
      TabIndex        =   11
      Top             =   4710
      Width           =   2265
      _Version        =   458753
      _ExtentX        =   3995
      _ExtentY        =   503
      _StockProps     =   205
      ForeColor       =   -2147483630
      Enabled         =   -1  'True
      FillColor       =   16777215
      MaxReal         =   3.4E+38
      MinReal         =   0
      SpinChangeReal  =   0
      AutoHScroll     =   -1  'True
      CaretColor      =   -2147483642
      CaretVisible    =   -1  'True
      DecimalPlaces   =   2
      Separator       =   -1  'True
   End
   Begin MhinrelLib.MhRealInput mskCosto 
      Height          =   285
      Index           =   2
      Left            =   1800
      TabIndex        =   12
      Top             =   5010
      Width           =   2265
      _Version        =   458753
      _ExtentX        =   3995
      _ExtentY        =   503
      _StockProps     =   205
      ForeColor       =   -2147483630
      Enabled         =   -1  'True
      FillColor       =   16777215
      MaxReal         =   3.4E+38
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
      Caption         =   "Moneda:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   16
      Left            =   60
      TabIndex        =   44
      Top             =   1215
      Width           =   750
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Fecha de vigencia:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   15
      Left            =   60
      TabIndex        =   43
      Top             =   15
      Width           =   1650
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   11
      Left            =   2745
      TabIndex        =   42
      Top             =   1215
      Width           =   5580
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   9
      Left            =   1800
      TabIndex        =   41
      Top             =   1215
      Width           =   930
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Grupo rango:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   14
      Left            =   60
      TabIndex        =   35
      Top             =   3495
      Width           =   1125
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo rango:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   13
      Left            =   60
      TabIndex        =   40
      Top             =   3195
      Width           =   990
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   6
      Left            =   2745
      TabIndex        =   39
      Top             =   3195
      Width           =   5580
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Sucursales:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   11
      Left            =   60
      TabIndex        =   38
      Top             =   1515
      Width           =   1005
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Prod. Bancario:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   12
      Left            =   60
      TabIndex        =   37
      Top             =   315
      Width           =   1335
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   10
      Left            =   2745
      TabIndex        =   36
      Top             =   315
      Width           =   5580
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   8
      Left            =   2745
      TabIndex        =   34
      Top             =   2595
      Width           =   5580
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Servicio disponible:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   10
      Left            =   60
      TabIndex        =   33
      Top             =   2595
      Width           =   1680
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Producto Cobis:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   60
      TabIndex        =   32
      Top             =   915
      Width           =   1365
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   7
      Left            =   2745
      TabIndex        =   31
      Top             =   915
      Width           =   5580
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Valor Mínimo:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   60
      TabIndex        =   30
      Top             =   4395
      Width           =   1185
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Valor Máximo:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   60
      TabIndex        =   27
      Top             =   4995
      Width           =   1200
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Desde:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   2805
      TabIndex        =   23
      Top             =   4095
      Width           =   615
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Hasta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   5610
      TabIndex        =   24
      Top             =   4095
      Width           =   570
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   4
      Left            =   3420
      TabIndex        =   25
      Top             =   4095
      Width           =   2085
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   5
      Left            =   6195
      TabIndex        =   26
      Top             =   4095
      Width           =   2130
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Valor Base:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   60
      TabIndex        =   28
      Top             =   4695
      Width           =   990
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   1800
      TabIndex        =   21
      Top             =   2895
      Width           =   930
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Rubro:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   60
      TabIndex        =   22
      Top             =   2895
      Width           =   585
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   2745
      TabIndex        =   29
      Top             =   2895
      Width           =   5580
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   2745
      TabIndex        =   20
      Top             =   615
      Width           =   5580
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   2745
      TabIndex        =   19
      Top             =   3795
      Width           =   5580
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Rango :"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   60
      TabIndex        =   18
      Top             =   4095
      Width           =   690
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Mercado:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   60
      TabIndex        =   17
      Top             =   615
      Width           =   810
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Categoría:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   60
      TabIndex        =   16
      Top             =   3795
      Width           =   915
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8370
      X2              =   8370
      Y1              =   -100
      Y2              =   5500
   End
End
Attribute VB_Name = "FMantenLinea2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
Dim VLPaso As Integer
Dim VLTrans As Integer
Dim VLDato As String
Dim VLFormatoFecha As String
'! removed Dim VLMoneda As String


Private Sub cmdBoton_Click(Index As Integer)
Dim VLNumSuc%
Dim i%
Dim VLMaxSuc%
Dim VLContLoop%
Dim VLSucBak%
Dim VLPSuc$
Dim VLSucEnv%
Dim VLParam$
    Select Case Index%
    Case 0
     'Ingresar
     
     
        If mskFecha.ClipText = "" Then
            MsgBox "La fecha de vigencia es mandatoria", 0 + 16, "Mensaje de Error"
            mskFecha.SetFocus
            Exit Sub
        End If
        
        
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
            MsgBox "El código del producto Cobis es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(4).SetFocus
            Exit Sub
        End If
        
        If txtCampo(5).Text = "" Then
            MsgBox "El código del Servicio es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(5).SetFocus
            Exit Sub
        End If

        If txtCampo(2).Text = "" Then
            MsgBox "La categoría es mandatoria", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            MsgBox "El rango es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If
        If mskCosto(1).Text = "" Then
            MsgBox "El valor mínimo es mandatorio", 0 + 16, "Mensaje de Error"
            mskCosto(1).SetFocus
            Exit Sub
        End If
        If mskCosto(2).Text = "" Then
            MsgBox "El valor máximo es mandatorio", 0 + 16, "Mensaje de Error"
            mskCosto(2).SetFocus
            Exit Sub
        End If
        If mskCosto(0).Text = "" Then
            MsgBox "El valor base es mandatorio", 0 + 16, "Mensaje de Error"
            mskCosto(0).SetFocus
            Exit Sub
        End If
        If mskCosto(1).Text <> "" Then
            If (Val(Format$(mskCosto(1).Text)) > Val(Format$(mskCosto(2).Text))) Then
                MsgBox "El valor máximo está incorrecto", 0 + 16, "Mensaje de Error"
                mskCosto(2).Text = ""
                mskCosto(2).SetFocus
                Exit Sub
            End If
        End If
        If mskCosto(2).Text <> "" Then
            If (Val(Format$(mskCosto(0).Text)) > Val(Format$(mskCosto(2).Text))) Then
                MsgBox "El valor base está incorrecto", 0 + 16, "Mensaje de Error"
                mskCosto(0).Text = ""
                mskCosto(0).SetFocus
                Exit Sub
            End If
         End If
        If mskCosto(1).Text <> "" Then
            If (Val(Format$(mskCosto(0).Text)) < Val(Format$(mskCosto(1)))) Then
                MsgBox "El valor base está incorrecto", 0 + 16, "Mensaje de Error"
                mskCosto(0).Text = ""
                mskCosto(0).SetFocus
                Exit Sub
            End If
        End If

        ReDim Sucursal(1000) As String
        
        VLNumSuc% = 0
        For i% = 1 To grdSucurs.Rows - 1
            grdSucurs.Row = i%
            grdSucurs.Col = 0
            If grdSucurs.Picture = picVisto(0) Then
                grdSucurs.Col = 1
                VLNumSuc% = VLNumSuc% + 1
                Sucursal(VLNumSuc%) = grdSucurs.Text
            End If
        Next i%
        
        If VLNumSuc% = 0 Then
            MsgBox "Debe seleccionar al menos una sucursal", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
    
        VLMaxSuc% = 40
        VLContLoop% = 0
        Do
            VLSucBak% = (VLContLoop% + 1) * VLMaxSuc%
            If VLSucBak% > VLNumSuc% Then VLSucBak% = VLNumSuc%
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4082"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
             PMPasoValores sqlconn&, "@i_prod_cobis", 0, SQLINT1, txtCampo(4).Text
             PMPasoValores sqlconn&, "@i_prod_banc", 0, SQLINT2, txtCampo(0).Text
             PMPasoValores sqlconn&, "@i_sector", 0, SQLVARCHAR, txtCampo(3).Text
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, lblDescripcion(9).Caption
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
            VLPSuc$ = "@i_suc"
            VLSucEnv% = 0
            For i% = VLContLoop% * VLMaxSuc% + 1 To VLSucBak%
                VLParam$ = VLPSuc$ & CVar(i%)
                VLSucEnv% = VLSucEnv% + 1
                 PMPasoValores sqlconn&, VLParam$, 0, SQLINT2, Sucursal(i%)
            Next i%
             PMPasoValores sqlconn&, "@i_num_suc", 0, SQLINT2, CVar(VLSucEnv%)
             PMPasoValores sqlconn&, "@i_serv_dis", 0, SQLINT2, txtCampo(5).Text
             PMPasoValores sqlconn&, "@i_rubro", 0, SQLVARCHAR, lblDescripcion(2).Caption
             PMPasoValores sqlconn&, "@i_tipo_rango", 0, SQLINT1, txtCampo(6).Text
             PMPasoValores sqlconn&, "@i_grupo_rango", 0, SQLINT2, txtCampo(7).Text
             PMPasoValores sqlconn&, "@i_categoria", 0, SQLVARCHAR, txtCampo(2).Text
             PMPasoValores sqlconn&, "@i_rango", 0, SQLINT1, txtCampo(1).Text
             PMPasoValores sqlconn&, "@i_val_med", 0, SQLMONEY, mskCosto(0).Text
             PMPasoValores sqlconn&, "@i_val_min", 0, SQLMONEY, mskCosto(1).Text
             PMPasoValores sqlconn&, "@i_val_max", 0, SQLMONEY, mskCosto(2).Text
             PMPasoValores sqlconn&, "@i_fecha_vigen", 0, SQLVARCHAR, FMConvFecha((mskFecha.Text), Get_Preferencia("FORMATO-FECHA"), "mm/dd/yyyy")
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_costos_total", True, "Ok...Creación de un Costo - Servicio") Then
                 PMChequea sqlconn&
                cmdBoton(0).Enabled = False
            Else
                 PMChequea sqlconn&
                Exit Sub
            End If
            VLContLoop% = VLContLoop% + 1
            If VLSucBak% = VLNumSuc% Then VLSucBak% = 0
        Loop While VLSucBak% = VLMaxSuc%

    Case 1 'Limpiar
        If txtCampo(1).Text <> "" Then
            txtCampo(1).Text = ""
            txtCampo(1).Enabled = True
            For i% = 0 To 2
                mskCosto(i%).Text = "0"
            Next i%
            For i% = 4 To 5
                lblDescripcion(i%).Caption = ""
            Next i%
            txtCampo(1).SetFocus
        Else
            If txtCampo(2).Text <> "" Then
                txtCampo(2).Text = ""
                txtCampo(2).Enabled = True
                lblDescripcion(3).Caption = ""
                txtCampo(2).SetFocus
             Else
                If txtCampo(6).Text <> "" Then
                    txtCampo(6).Text = ""
                    txtCampo(6).Enabled = True
                    txtCampo(7).Text = ""
                    txtCampo(7).Enabled = True
                    lblDescripcion(6).Caption = ""
                    txtCampo(6).SetFocus
                Else
                    If txtCampo(5).Text <> "" Then
                        txtCampo(5).Text = ""
                        lblDescripcion(8).Caption = ""
                        lblDescripcion(2).Caption = ""
                        lblDescripcion(1).Caption = ""
                        txtCampo(5).Enabled = True
                        txtCampo(5).SetFocus
                    Else
                        If txtCampo(4).Text <> "" Then
                            txtCampo(4).Text = ""
                            txtCampo(4).Enabled = True

                            For i% = 7 To 11 Step 2
                                lblDescripcion(i%).Caption = ""
                            Next i%
                            txtCampo(4).SetFocus
                        Else
                            If txtCampo(3).Text <> "" Then
                                txtCampo(3).Text = ""
                                txtCampo(3).Enabled = True
                                lblDescripcion(0).Caption = ""
                                'For I% = 0 To 15
                                '    chkSucursal(I%).Value = False
                                'Next I%
                                txtCampo(3).SetFocus
                            Else
                                If txtCampo(0).Text <> "" Then
                                    txtCampo(0).Text = ""
                                    txtCampo(0).Enabled = True
                                    lblDescripcion(10).Caption = ""
                                    txtCampo(0).SetFocus
                                End If
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
        
        Unload FMantenLinea2
    
    End Select
End Sub

Private Sub Form_Load()
    FMantenLinea2.Left = 15
    FMantenLinea2.Top = 15
    FMantenLinea2.Width = 9420
    FMantenLinea2.Height = 5730
    'PMBotonSeguridad FMantenLinea2, 2
    'cmdBoton(0).Enabled = True
    
    VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
    mskFecha.Mask = FMMascaraFecha(VLFormatoFecha$)
    VGFecha$ = FMDateAdd(VGFecha, "d", 1, "mm/dd/yyyy")
    mskFecha.Text = FMConvFecha(VGFecha$, "mm/dd/yyyy", VLFormatoFecha$)
    
'    VLFecha$ = DateAdd("d", 1, VGFecha)
'    mskFecha.Mask = FMMascaraFecha(VGFormatoFecha$)
'    mskFecha.Text = Format$(VLFecha$, VGFormatoFecha$)
    VLTrans% = True
'mskCosto(0).Format = VGDecimales$
'mskCosto(0).Text = Format$(0, VGDecimales$)
'mskCosto(0).MaxLength = 14
'mskCosto(1).Format = VGDecimales$
'mskCosto(1).Text = Format$(0, VGDecimales$)
'mskCosto(1).MaxLength = 14
'mskCosto(2).Format = VGDecimales$
'mskCosto(2).Text = Format$(0, VGDecimales$)
'mskCosto(2).MaxLength = 14
    
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4079"
     PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", False, "") Then
         PMMapeaGrid sqlconn&, grdSucurs, False
         PMChequea sqlconn&
    End If
    
 PMObjetoSeguridad cmdBoton(0)
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdSucurs_Click()
    grdSucurs.Col = 0
    grdSucurs.SelStartCol = 1
    grdSucurs.SelEndCol = grdSucurs.Cols - 1
    If grdSucurs.Row = 0 Then
        grdSucurs.SelStartRow = 1
        grdSucurs.SelEndRow = 1
    Else
        grdSucurs.SelStartRow = grdSucurs.Row
        grdSucurs.SelEndRow = grdSucurs.Row
    End If
End Sub

Private Sub grdSucurs_DblClick()
    ' Verificar que existan registros
    If grdSucurs.Rows <= 2 Then
        grdSucurs.Row = 1
        grdSucurs.Col = 1
        If Trim$(grdSucurs.Text) = "" Then
            MsgBox "No existen Sucursales", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
    End If
    PMMarcarRegistro
End Sub

Private Sub mskCosto_GotFocus(Index As Integer)
  '  If VLDato$ = "M" Then
  '      If VLMoneda$ = "S" Then
  '          mskCosto(Index%).Format = "#,##0.00"
  '      ElseIf VLMoneda$ = "N" Then
  '          mskCosto(Index%).Format = "#,##0"
  '
  '      End If
  '  Else
  '      mskCosto(Index%).Format = "#,##0.00"
  '  End If
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Costo  para el Servicio"
    Case 1
        FPrincipal.pnlHelpLine.Caption = " Valor Mínimo del Costo"
    Case 2
        FPrincipal.pnlHelpLine.Caption = " Valor Máximo del Costo"
    End Select
    mskCosto(Index%).SelStart = 0
    mskCosto(Index%).SelLength = Len(mskCosto(Index%).Text)

End Sub

Private Sub mskCosto_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    If KeyCode% = 46 Then 'Suprimir
      mskCosto(Index%).Text = ""
    End If
End Sub

Private Sub mskCosto_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0, 1, 2
'    If VLDato$ = "P" Then
'        If (Chr$(KeyAscii%)) <> "." And (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
'                KeyAscii% = 0
'        End If
'        Exit Sub
'    End If
'    If VLMoneda$ = "S" Then
'        If (Chr$(KeyAscii%)) <> "." And (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
'                KeyAscii% = 0
'        End If
'    ElseIf VLMoneda$ = "N" Then
'        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
'                KeyAscii% = 0
'        End If
'
'   End If
        If (KeyAscii < 48 Or KeyAscii > 57) And (KeyAscii <> 8) And (KeyAscii <> 46) Then
            KeyAscii = 0
        End If
        KeyAscii = FMValidarNumero((mskCosto(Index).Text), 16, KeyAscii, "105")
    End Select
End Sub

Private Sub mskCosto_LostFocus(Index As Integer)
    If mskCosto(Index%).Text <> "" Then
        If txtCampo(3).Text = "" Then
            MsgBox "El código del servicio es mandatorio", 0 + 16, "Mensaje de Error"
            mskCosto(0).Text = ""
            txtCampo(3).SetFocus
            Exit Sub
        End If
    End If
    Select Case Index%
    Case 0  'Costo Base
        
        If mskCosto(0).Text <> "" Then
            If Not IsNumeric(mskCosto(0).Text) Then
                mskCosto(0).Text = ""
                mskCosto(0).SetFocus
                Exit Sub
            End If
            
            If VLDato$ = "P" Then
                If Val(Format$(mskCosto(0).Text)) > 100 Then
                    MsgBox "El valor debe ser Porcentaje", 0 + 16, "Mensaje de Error"
                    mskCosto(0).Text = ""
                    mskCosto(0).SetFocus
                    Exit Sub
                End If
                
            End If
            'If mskCosto(2).Text <> "" Then
            '    If (Val(Format(mskCosto(0).Text)) > Val(Format(mskCosto(2).Text))) Then
            '        MsgBox "El costo está incorrecto", 0 + 16, "Mensaje de Error"
            '        mskCosto(0).Text = ""
            '        mskCosto(0).SetFocus
            '        Exit Sub
            '    End If
           ' End If
            'If mskCosto(1).Text <> "" Then
            '    If (Val(Format(mskCosto(0).Text)) < Val(Format(mskCosto(1)))) Then
            '        MsgBox "El costo está incorrecto", 0 + 16, "Mensaje de Error"
            '        mskCosto(0).Text = ""
            '        mskCosto(0).SetFocus
            '        Exit Sub
            '    End If
            'End If

        End If
    
    Case 1  'Valor mínimo
        
        If mskCosto(1).Text <> "" Then
            If Not IsNumeric(mskCosto(1).Text) Then
                mskCosto(1).Text = ""
                mskCosto(1).SetFocus
                Exit Sub
            End If
            
            If VLDato$ = "P" Then
                If Val(Format$(mskCosto(1).Text)) > 100 Then
                    MsgBox "El valor mínimo debe ser Porcentaje", 0 + 16, "Mensaje de Error"
                    mskCosto(1).Text = ""
                    mskCosto(1).SetFocus
                    Exit Sub
                End If
                
            End If
            'If mskCosto(2).Text <> "" Then
            '    If (Val(Format(mskCosto(1).Text)) > Val(Format(mskCosto(2).Text))) Then
            '        MsgBox "El valor mínimo está incorrecto", 0 + 16, "Mensaje de Error"
            '        mskCosto(1).Text = ""
            '        mskCosto(1).SetFocus
            '        Exit Sub
            '    End If
           ' End If
        End If
    
    Case 2 'Valor máximo
        
        If mskCosto(2).Text <> "" Then
            If Not IsNumeric(mskCosto(2).Text) Then
                mskCosto(2).Text = ""
                mskCosto(2).SetFocus
                Exit Sub
            End If
            
            If VLDato$ = "P" Then
                If Val(Format$(mskCosto(2).Text)) > 100 Then
                    MsgBox "El valor máximo debe ser Porcentaje", 0 + 16, "Mensaje de Error"
                    mskCosto(2).Text = ""
                    mskCosto(2).SetFocus
                    Exit Sub
                End If
                
            End If
            'If mskCosto(1).Text <> "" Then
            '    If (Val(Format(mskCosto(1).Text)) > Val(Format(mskCosto(2).Text))) Then
            '        MsgBox "El valor máximo está incorrecto", 0 + 16, "Mensaje de Error"
            '        mskCosto(2).Text = ""
            '        mskCosto(2).SetFocus
            '        Exit Sub
            '    End If
            'End If
        End If
    End Select
End Sub

Private Sub mskCosto_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0, 1, 2
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub

Private Sub mskFecha_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Fecha de Vigencia " + "[" + VGFormatoFecha$ + "]"
End Sub

Private Sub mskFecha_LostFocus()
Dim VTValido%
Dim VLFecha$
    If mskFecha.ClipText <> "" Then
        VTValido% = FMVerFormato((mskFecha.FormattedText), VGFormatoFecha$)
        If Not VTValido% Then
            MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
            mskFecha.Mask = ""
            mskFecha.Text = ""
            mskFecha.Mask = FMMascaraFecha(VGFormatoFecha$)
            mskFecha.SetFocus
            
            Exit Sub
        End If
    End If
    If mskFecha.Text <> Format$(VLFecha$, VGFormatoFecha$) Then
        If FMDateDiff("d", Format$(VLFecha$, VGFormatoFecha$), (mskFecha.Text), VGFormatoFecha$) < 0 Then
            MsgBox "Fecha de Vigencia Incorrecta", 16, "Mensaje de Error"
            mskFecha.Mask = ""
            mskFecha.Text = ""
            mskFecha.Mask = FMMascaraFecha(VGFormatoFecha$)
            mskFecha.SetFocus
            Exit Sub
        End If
    End If

End Sub

Private Sub PMMarcarRegistro()
    grdSucurs.Col = 0
    If grdSucurs.Picture = picVisto(1) Then
        grdSucurs.Text = Str$(grdSucurs.Row)
        grdSucurs.Picture = picVisto(0)
    Else
        grdSucurs.Text = Str$(grdSucurs.Row)
        grdSucurs.Picture = picVisto(1)
    End If
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

'! Private Sub mskValor_AutoTerminate(Index As Integer)
'!
'! End Sub
'!
Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 0, 1, 2, 3, 4, 5, 6, 7
        VLPaso% = False
    End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Producto Bancario [F5 Ayuda]"
    Case 1
        FPrincipal.pnlHelpLine.Caption = " Rango [F5 Ayuda]"
    Case 2
       FPrincipal.pnlHelpLine.Caption = " Categoría [F5 Ayuda]"
    Case 3
        FPrincipal.pnlHelpLine.Caption = " Código del Mercado [F5 Ayuda]"
    Case 4
        FPrincipal.pnlHelpLine.Caption = " Producto COBIS [F5 Ayuda]"
    Case 5
        FPrincipal.pnlHelpLine.Caption = " Servicio disponible [F5 Ayuda]"
    Case 6
        FPrincipal.pnlHelpLine.Caption = " Tipo de rango [F5 Ayuda]"
    Case 7
        FPrincipal.pnlHelpLine.Caption = " Grupo de rango [F5 Ayuda]"

    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
Dim i%
Dim VTFilas%
Dim VTCodigo$
Dim VTMoneda$
Dim VTGrupo$
Dim VTRango$
    If KeyCode% = VGTeclaAyuda% Then
        VLPaso% = True

        Select Case Index%
        Case 0
            VGOperacion$ = "sp_prod_bancario"
            Load FRegistros
        
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
            ' Realiza consulta del rango de acuerdo al tipo de rango para ese
            ' servicio
            If txtCampo(6).Text = "" Then
                MsgBox "El tipo de rango es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(6).SetFocus
                Exit Sub
            End If
            
            If txtCampo(7).Text = "" Then
                MsgBox "El grupo de rango es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(7).SetFocus
                Exit Sub
            End If
    
            VGOperacion$ = "sp_corango_ma"
            Load FRegistros
        
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4080"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
             PMPasoValores sqlconn&, "@i_tipo_rango", 0, SQLINT1, txtCampo(6).Text
             PMPasoValores sqlconn&, "@i_grupo_rango", 0, SQLINT2, txtCampo(7).Text
             PMPasoValores sqlconn&, "@i_rango", 0, SQLINT1, "0"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_corango_ma", False, "Ok...Consulta de Rangos") Then
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                 PMChequea sqlconn&
                FRegistros.Show 1
                If VGValores(1) <> "" Then
                    txtCampo(1).Text = VGValores(1)
                    lblDescripcion(4).Caption = VGValores(2)
                    lblDescripcion(5).Caption = VGValores(3)
                End If
            Else
                VGOperacion$ = ""
            End If
            
            VLPaso% = True
                
        Case 2
            ' Consulta de las categorias
            If txtCampo(3).Text = "" Then
                MsgBox "El código del servicio es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(3).SetFocus
                Exit Sub
            End If
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
            Load FRegistros
        
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
            VGForma$ = "FMantenLinea2"
            FAyudaSubserv2.Show 1
            'Unload FRubros
            If VGDetalle(1) <> "" Then
                PMSubserv
                VLPaso% = True
            End If
        Case 6
    '            If txtCampo(2).Text = "" Then
    '                MsgBox "El código del producto final es mandatorio", 0 + 16, "Mensaje de Error"
    '                txtCampo(2).SetFocus
    '                Exit Sub
    '            End If
            
            VLPaso% = True
            VGOperacion$ = "sp_help_rango_pe"
            VGTipo$ = "T"
            VTFilas% = VGMaxRows%
            VTCodigo$ = "0"
            VTMoneda$ = lblDescripcion(9).Caption
            Load FRegistros
            While VTFilas% = VGMaxRows%
                    
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4038"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "T"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, VTCodigo$
                 PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VTMoneda$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "Ok...Consulta de Rangos") Then
                    If VTCodigo$ = "0" Then
                         PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                    Else
                         PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
                    End If
                     PMChequea sqlconn&
                    VTFilas% = Val(FRegistros.grdRegistros.Tag)
                        
                        FRegistros.grdRegistros.Col = 1
                        FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                        VTCodigo$ = FRegistros.grdRegistros.Text
                        
                        FRegistros.grdRegistros.Col = 3
                        FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                        VTMoneda$ = FRegistros.grdRegistros.Text
                Else
                    VGOperacion$ = ""
                    VGTipo$ = ""
                End If
    
            Wend
            FRegistros.grdRegistros.Row = 1
            FRegistros.Show 1
            If VGValores(1) <> "" Then
                txtCampo(6).Text = VGValores(1)
                lblDescripcion(6).Caption = VGValores(2)
                VLPaso% = True
            End If
    
        Case 7
            If txtCampo(6).Text = "" Then
                MsgBox "El tipo de rango es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(6).SetFocus
                Exit Sub
            End If
            VGOperacion$ = "sp_help_rango_pe"
            VGTipo$ = "G"
            VTFilas% = VGMaxRows%
            VTGrupo$ = "0"
            VTRango$ = "0"
            Load FRegistros
            While VTFilas% = VGMaxRows%
                    
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4038"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "G"
                 PMPasoValores sqlconn&, "@i_grupo", 0, SQLINT2, VTGrupo$
                 PMPasoValores sqlconn&, "@i_rango", 0, SQLINT2, VTRango$
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(6).Text
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "Ok...Consulta de Rangos") Then
                    If VTGrupo$ = "0" Then
                         PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                    Else
                         PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
                    End If
                     PMChequea sqlconn&
                    VTFilas% = Val(FRegistros.grdRegistros.Tag)
    
                    If VTFilas% > 0 Then
                        FRegistros.grdRegistros.Col = 1
                        FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                        VTGrupo$ = FRegistros.grdRegistros.Text
                        
                        FRegistros.grdRegistros.Col = 2
                        FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                        VTRango$ = FRegistros.grdRegistros.Text
                    End If
                Else
                    VGOperacion$ = ""
                    VGTipo$ = ""
    
                End If
    
            Wend
            FRegistros.grdRegistros.Row = 1
            
                FRegistros.Show 1
                If VGACatalogo.Codigo$ <> "" Then
                    txtCampo(7).Text = VGACatalogo.Codigo$
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
Dim VTR%
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
                End If
            Else
                lblDescripcion(10).Caption = ""
            End If
         End If
    Case 1
        ' Si se ha ingresado algo y se va insertar
        If VLPaso% = False Then
            If txtCampo(1).Text = "" Then
                Exit Sub
            End If
            If lblDescripcion(2).Caption = "" Then
                MsgBox "El código del servicio es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(1).Text = ""
                txtCampo(1).SetFocus
                Exit Sub
            End If
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4081"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
             PMPasoValores sqlconn&, "@i_grupo_rango", 0, SQLINT2, txtCampo(7).Text
             PMPasoValores sqlconn&, "@i_tipo_rango", 0, SQLINT1, txtCampo(6).Text
             PMPasoValores sqlconn&, "@i_rango", 0, SQLINT1, txtCampo(1).Text
            ReDim Valores(5) As String
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_corango_ma", False, "Ok...Consulta de Rangos") Then
                 VTR% = FMMapeaArreglo(sqlconn&, Valores())
                 PMChequea sqlconn&
                lblDescripcion(4).Caption = Valores(1)
                lblDescripcion(5).Caption = Valores(2)
            Else
                lblDescripcion(4).Caption = ""
                lblDescripcion(5).Caption = ""
                lblDescripcion(6).Caption = ""
                txtCampo(1).Text = ""
                txtCampo(1).SetFocus
            End If

        End If
    Case 2
        If VLPaso% = False Then
            If txtCampo(3).Text = "" Then
                MsgBox "El código del servicio es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(2).Text = ""
                txtCampo(2).SetFocus
                Exit Sub
            End If
            If txtCampo(2).Text = "" Then
                lblDescripcion(3).Caption = ""
                txtCampo(2).SetFocus
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
               VGForma$ = "FMantenLinea2"
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
        
               If txtCampo(6).Text > 255 Then
                    MsgBox "Tipo de rango  fuera de limite", 0 + 16, "Mensaje de Error"
                    txtCampo(6).Text = ""
                    txtCampo(6).SetFocus
                    Exit Sub
                 End If
        
            
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
        Case 0, 1, 2, 3, 4, 5, 6, 7
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub


