VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#7.0#0"; "MhRealInput.ocx"
Begin VB.Form FMantenLinea 
   Appearance      =   0  'Flat
   Caption         =   " Valores de Servicios Personalizables [Mantenimiento en Línea]"
   ClientHeight    =   5325
   ClientLeft      =   105
   ClientTop       =   1410
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
   Icon            =   "FMANLIN1.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   2220
      MaxLength       =   5
      TabIndex        =   0
      Top             =   15
      Width           =   930
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Ingresar"
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
      Index           =   4
      Left            =   8385
      Picture         =   "FMANLIN1.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   8
      Tag             =   "4117"
      Top             =   2325
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Transmitir"
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
      Index           =   0
      Left            =   8385
      Picture         =   "FMANLIN1.frx":0614
      Style           =   1  'Graphical
      TabIndex        =   9
      Tag             =   "4060"
      Top             =   3075
      Width           =   875
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Buscar"
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
      Left            =   8385
      Picture         =   "FMANLIN1.frx":097A
      Style           =   1  'Graphical
      TabIndex        =   7
      Tag             =   "4116"
      Top             =   15
      Width           =   875
   End
   Begin MSGrid.Grid grdServicios 
      Height          =   1980
      Left            =   15
      TabIndex        =   13
      Top             =   3315
      Width           =   8295
      _Version        =   65536
      _ExtentX        =   14632
      _ExtentY        =   3493
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
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   3
      Left            =   2220
      MaxLength       =   4
      TabIndex        =   1
      Top             =   315
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   2220
      MaxLength       =   2
      TabIndex        =   3
      Top             =   1815
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
      Left            =   8385
      Picture         =   "FMANLIN1.frx":0BDC
      Style           =   1  'Graphical
      TabIndex        =   11
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
      Left            =   8385
      Picture         =   "FMANLIN1.frx":0F42
      Style           =   1  'Graphical
      TabIndex        =   10
      Top             =   3825
      Width           =   875
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   2205
      MaxLength       =   2
      TabIndex        =   2
      Top             =   1515
      Width           =   930
   End
   Begin MhinrelLib.MhRealInput mskCosto 
      Height          =   285
      Index           =   1
      Left            =   2220
      TabIndex        =   4
      Top             =   2160
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
      Left            =   2220
      TabIndex        =   5
      Top             =   2460
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
      Left            =   2220
      TabIndex        =   6
      Top             =   2760
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
      Caption         =   "Código Sucursal:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   12
      Left            =   60
      TabIndex        =   36
      Top             =   15
      Width           =   1455
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   10
      Left            =   3165
      TabIndex        =   35
      Top             =   15
      Width           =   5160
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   9
      Left            =   2220
      TabIndex        =   34
      Top             =   1215
      Width           =   930
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   8
      Left            =   3165
      TabIndex        =   33
      Top             =   1215
      Width           =   5160
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Producto Final:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   10
      Left            =   60
      TabIndex        =   32
      Top             =   1215
      Width           =   1305
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Moneda:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   60
      TabIndex        =   31
      Top             =   915
      Width           =   750
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   7
      Left            =   3165
      TabIndex        =   30
      Top             =   915
      Width           =   5160
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   6
      Left            =   2220
      TabIndex        =   29
      Top             =   915
      Width           =   930
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
      TabIndex        =   28
      Top             =   2115
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
      TabIndex        =   25
      Top             =   2715
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
      Left            =   3165
      TabIndex        =   21
      Top             =   1815
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
      Left            =   5760
      TabIndex        =   22
      Top             =   1815
      Width           =   570
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   4
      Left            =   3780
      TabIndex        =   23
      Top             =   1815
      Width           =   1950
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   5
      Left            =   6375
      TabIndex        =   24
      Top             =   1815
      Width           =   1950
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
      TabIndex        =   26
      Top             =   2415
      Width           =   990
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de Valores Vigentes:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   11
      Left            =   60
      TabIndex        =   19
      Top             =   3090
      Width           =   2235
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   2220
      TabIndex        =   18
      Top             =   615
      Width           =   930
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo Rango:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   60
      TabIndex        =   20
      Top             =   615
      Width           =   1065
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   3165
      TabIndex        =   27
      Top             =   615
      Width           =   5160
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   3165
      TabIndex        =   17
      Top             =   315
      Width           =   5160
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   3165
      TabIndex        =   16
      Top             =   1515
      Width           =   5160
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
      TabIndex        =   15
      Top             =   1815
      Width           =   690
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8340
      Y1              =   3060
      Y2              =   3060
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Servicio Personalizable:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   60
      TabIndex        =   14
      Top             =   315
      Width           =   2055
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
      TabIndex        =   12
      Top             =   1515
      Width           =   915
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
Attribute VB_Name = "FMantenLinea"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
Dim VLPaso As Integer
'! removed Dim VLTrans As Integer

Dim VLDato As String
'! removed Dim VLFormatoFecha As String

Dim VLMoneda As String

Private Sub cmdBoton_Click(Index As Integer)
Dim VTMsg$
Dim i%
Dim VTFilas%
Dim VTServicio$
Dim VTCategoria$
Dim VTTipoRango$
Dim VTRango$
Dim VTFecha$
   Select Case Index%
    
    Case 0
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4060"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_costos", True, VTMsg$) Then
                PMChequea sqlconn&
               cmdBoton(0).Enabled = False
               cmdBoton(2).Enabled = True
               cmdBoton_Click (3)
            End If
        
        
    Case 1 'Limpiar
        
        
        If txtCampo(1).Text <> "" Then
            txtCampo(1).Text = ""
            txtCampo(1).Enabled = True
            For i% = 0 To 2
                mskCosto(i%).Text = ""
                mskCosto(i%).Text = "##0.00"
                VLMoneda$ = ""
            
            Next i%
            For i% = 4 To 5
                lblDescripcion(i%).Caption = ""
            Next i%
            txtCampo(1).SetFocus
            'cmdBoton(4).Enabled = True
            PMObjetoSeguridad cmdBoton(4)
        Else
            If txtCampo(2).Text <> "" Then
                txtCampo(2).Text = ""
                txtCampo(2).Enabled = True
                lblDescripcion(3).Caption = ""
                txtCampo(2).SetFocus
             Else
                If txtCampo(3).Text <> "" Then
                    txtCampo(3).Text = ""
                    txtCampo(3).Enabled = True
                    For i% = 0 To 2
                        lblDescripcion(i%).Caption = ""
                    Next i%
                    For i% = 6 To 9
                        lblDescripcion(i%).Caption = ""
                    Next i%
                    txtCampo(3).SetFocus
                Else
                    If txtCampo(0).Text <> "" Then
                        txtCampo(0).Text = ""
                        lblDescripcion(10).Caption = ""
                        PMLimpiaGrid grdServicios
                        txtCampo(0).Enabled = True
                        txtCampo(0).SetFocus
                    End If
                End If
             End If
        End If
        VLPaso% = True
        'cmdBoton(0).Enabled = True
        PMObjetoSeguridad cmdBoton(0)
        FPrincipal.pnlHelpLine.Caption = ""
        FPrincipal.pnlTransaccionLine.Caption = ""
        'cmdBoton_Click (3)

    Case 2 'Salir
        
        Unload FMantenLinea
    
    Case 3
        ' Trae los primeros 20 registros y luego añade los demás de 20 en 20
        If txtCampo(0).Text = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
    
         VTFilas% = VGMaxRows%
         VTServicio$ = "0"
         VTCategoria$ = "0"
         VTTipoRango$ = "0"
         VTRango$ = "0"
         
         While VTFilas% = VGMaxRows%
            
            
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4059"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"  '"CVV"
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text
             PMPasoValores sqlconn&, "@i_servicio", 0, SQLINT2, VTServicio$
             PMPasoValores sqlconn&, "@i_rango", 0, SQLINT2, VTRango$
             PMPasoValores sqlconn&, "@i_tipo_rango", 0, SQLINT2, VTTipoRango$
             PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, VTCategoria$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help2_costos", True, "Ok...Consulta de Costos - Servicios") Then
                If VTServicio$ = "0" Then
                     PMMapeaGrid sqlconn&, grdServicios, False
                Else
                     PMMapeaGrid sqlconn&, grdServicios, True
                End If

                 PMChequea sqlconn&

                grdServicios.Col = 1
                grdServicios.Row = grdServicios.Rows - 1
                VTServicio$ = grdServicios.Text
                grdServicios.Col = 3
                grdServicios.Row = grdServicios.Rows - 1
                VTTipoRango$ = grdServicios.Text
                grdServicios.Col = 7
                grdServicios.Row = grdServicios.Rows - 1
                VTCategoria$ = grdServicios.Text
                grdServicios.Col = 10
                grdServicios.Row = grdServicios.Rows - 1
                VTRango$ = grdServicios.Text

                If Val(grdServicios.Tag) > 0 Then
                    grdServicios.ColAlignment(11) = 1
                    grdServicios.ColAlignment(12) = 1
                    'grdServicios.ColAlignment(13) = 1
                End If
               
            End If
            VTFilas% = Val(grdServicios.Tag)
        Wend
        grdServicios.Col = 1
         
    Case 4
    
        If txtCampo(0).Text = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        
        If txtCampo(3).Text = "" Then
            MsgBox "El código del servicio es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
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

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4049"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
         PMPasoValores sqlconn&, "@i_servicio_per", 0, SQLINT2, txtCampo(3).Text
         PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_tipo_rango", 0, SQLINT2, lblDescripcion(2).Caption
         PMPasoValores sqlconn&, "@i_rango", 0, SQLINT1, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_medio", 0, SQLMONEY, mskCosto(0).Text
         PMPasoValores sqlconn&, "@i_minimo", 0, SQLMONEY, mskCosto(1).Text
         PMPasoValores sqlconn&, "@i_maximo", 0, SQLMONEY, mskCosto(2).Text
         VTFecha$ = FMConvFecha(VGFecha, VGFormatoFecha, "mm/dd/yyyy") 'Format$(VGFecha, "mm/dd/yyyy")
         PMPasoValores sqlconn&, "@i_fecha_vigencia", 0, SQLVARCHAR, VGFecha
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_reg_cambios_costos", True, "Ok...Creación de un Costo - Servicio") Then
            PMChequea sqlconn&
            cmdBoton(0).Enabled = True
            cmdBoton(2).Enabled = False
            cmdBoton(4).Enabled = False
            cmdBoton_Click (3)
        End If
End Select
End Sub

Private Sub Form_Load()
    FMantenLinea.Left = 15
    FMantenLinea.Top = 15
    FMantenLinea.Width = 9420
    FMantenLinea.Height = 5900
    'PMBotonSeguridad FMantenLinea, 3
    'cmdBoton(0).Enabled = False
'mskCosto(0).Format = VGDecimales$
'mskCosto(0).Text = Format$(0, VGDecimales$)
'mskCosto(0).MaxLength = 14
'mskCosto(1).Format = VGDecimales$
'mskCosto(1).Text = Format$(0, VGDecimales$)
'mskCosto(1).MaxLength = 14
'mskCosto(2).Format = VGDecimales$
'mskCosto(2).Text = Format$(0, VGDecimales$)
'mskCosto(2).MaxLength = 14
    
 PMObjetoSeguridad cmdBoton(0)
 PMObjetoSeguridad cmdBoton(4)
 PMObjetoSeguridad cmdBoton(3)
     
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdServicios_Click()
    grdServicios.Col = 0
    grdServicios.SelStartCol = 1
    grdServicios.SelEndCol = grdServicios.Cols - 1
    If grdServicios.Row = 0 Then
        grdServicios.SelStartRow = 1
        grdServicios.SelEndRow = 1
    Else
        grdServicios.SelStartRow = grdServicios.Row
        grdServicios.SelEndRow = grdServicios.Row
    End If

End Sub

Private Sub grdServicios_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Haga doble click para Seleccionar"
End Sub

Private Sub grdServicios_KeyUp(KeyCode As Integer, Shift As Integer)
    grdServicios.Col = 0
    grdServicios.SelStartCol = 1
    grdServicios.SelEndCol = grdServicios.Cols - 1
    If grdServicios.Row = 0 Then
        grdServicios.SelStartRow = 1
        grdServicios.SelEndRow = 1
    Else
        grdServicios.SelStartRow = grdServicios.Row
        grdServicios.SelEndRow = grdServicios.Row
    End If

End Sub

Private Sub mskCosto_GotFocus(Index As Integer)
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

Private Sub mskCosto_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0, 1, 2
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

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 0, 1, 2, 3
        VLPaso% = False
    End Select

End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Código de Sucursal [F5 Ayuda]"
    Case 1
        FPrincipal.pnlHelpLine.Caption = " Rango [F5 Ayuda]"
    Case 2
       FPrincipal.pnlHelpLine.Caption = " Categoría [F5 Ayuda]"
    Case 3
        FPrincipal.pnlHelpLine.Caption = " Código del Servicio [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
Dim VTR%
    If KeyCode% = VGTeclaAyuda% Then
        VLPaso% = True
        Select Case Index%
    Case 0
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
                    txtCampo(0).Text = VGValores(1)
                    lblDescripcion(10).Caption = VGValores(2)
                Else
                    txtCampo(0).Text = ""
                    lblDescripcion(10).Caption = ""
                    VGOperacion$ = ""
                End If
                
                VLPaso% = True
            Else
                txtCampo(0).Text = ""
                lblDescripcion(10).Caption = ""
                VGOperacion$ = ""
            End If

        Case 1

            ' Realiza consulta del rango de acuerdo al tipo de rango para ese
            ' servicio
            If txtCampo(3).Text = "" Then
                MsgBox "El código del servicio es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(3).SetFocus
                Exit Sub
            End If

            VGOperacion$ = "sp_corango_pe"
            ' GBB26May98008 II:
            ' Se debe haver un load a la forma antes de cargar los valores
            Load FRegistros
            'GBB26May98008 IF:
        
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4048"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
             PMPasoValores sqlconn&, "@i_servicio_per", 0, SQLINT2, txtCampo(3).Text
             PMPasoValores sqlconn&, "@i_rango", 0, SQLINT1, "0"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_corango_pe", False, "Ok...Consulta de Rangos") Then
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
            
            'Consulta de los servicios personalizables
            'Se obtiene el código, la descripción, tipo de rango y el tipo de dato

            If txtCampo(0).Text <> "" Then
                VGOperacion$ = "sp_help_rubros"
                ' GBB26May98008 II:
                ' Se debe haver un load a la forma antes de cargar los valores
                Load FRegistros
                'GBB26May98008 IF:
        
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4046"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT1, "0"
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text
                VGSucursalSig% = txtCampo(0).Text
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rubros", False, "Ok...Consulta de Servicios") Then
                     PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                     PMChequea sqlconn&
                    FRegistros.Show 1
                    
                    VGOperacion$ = ""
                    If VGValores(1) = "" Then
                        Exit Sub
                    End If
                    txtCampo(3).Text = VGValores(1)
                    lblDescripcion(0).Caption = VGValores(2)
                    lblDescripcion(2).Caption = VGValores(3)
                    lblDescripcion(9).Caption = VGValores(4)
                    lblDescripcion(8).Caption = VGValores(5)
                    VLDato$ = VGValores(6)
                    'Consulta del tipo de rango
                    If lblDescripcion(2).Caption <> "" Then
                         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4038"
                         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                         PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT1, lblDescripcion(2).Caption
                         PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "T"
                        ReDim Valores(10) As String
                         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "Ok...Consulta de Servicios") Then
                             VTR% = FMMapeaArreglo(sqlconn&, Valores())
                             PMChequea sqlconn&
                        
                            lblDescripcion(1).Caption = Valores(1) 'Descripcion de tipo rango
                            lblDescripcion(6).Caption = Valores(2) ' moneda
                            lblDescripcion(7).Caption = Valores(3) ' descripcion moneda
                            'Consulta si tiene o no decimales
                             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4044"
                             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
                             PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, lblDescripcion(6).Caption
                             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_promon", False, "") Then
                                 PMMapeaVariable sqlconn&, VLMoneda$
                                 PMChequea sqlconn&
                            End If
                        Else
                            txtCampo(3).Text = ""
                            lblDescripcion(0).Caption = ""
                            lblDescripcion(2).Caption = ""
                            VLDato$ = ""
    
                        End If
                    End If
                Else
                VGOperacion$ = ""
                End If
    
                VLPaso% = True
            Else
                MsgBox "Debe ingresar la sucursal"
                txtCampo(0).SetFocus
            End If
        
        End Select
        
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 2
        KeyAscii% = FMValidaTipoDato("A", KeyAscii%)
        KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
    Case 0, 1, 3
    If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
Dim VTR%
    Select Case Index%
    Case 0
        If VLPaso% = False Then
            If txtCampo(0).Text <> "" Then
            
            
                If txtCampo(0).Text > 32000 Then
                    MsgBox "El código de sucursal fuera de rango", 0 + 16, "Mensaje de Error"
                    txtCampo(0).Text = ""
                    txtCampo(0).SetFocus
                    Exit Sub
                 End If
                 
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4078"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(0).Text
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", True, " Consulta del producto ") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(10)
                     PMChequea sqlconn&
                    
                Else
                    lblDescripcion(10).Caption = ""
                    txtCampo(0).Text = ""
                    VLPaso% = True
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
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4047"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
             PMPasoValores sqlconn&, "@i_servicio_per", 0, SQLINT2, txtCampo(3).Text
             PMPasoValores sqlconn&, "@i_rango", 0, SQLINT1, txtCampo(1).Text
            ReDim Valores(5) As String
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_corango_pe", False, "Ok...Consulta de Rangos") Then
                 VTR% = FMMapeaArreglo(sqlconn&, Valores())
                 PMChequea sqlconn&
                lblDescripcion(4).Caption = Valores(1)
                lblDescripcion(5).Caption = Valores(2)
            Else
                lblDescripcion(4).Caption = ""
                lblDescripcion(5).Caption = ""
                lblDescripcion(6).Caption = ""
                txtCampo(1).Text = ""
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
                Exit Sub
             End If
            PMCatalogo "V", "pe_categoria", txtCampo(2), lblDescripcion(3)
        End If


    Case 3
        If VLPaso% = False Then
            If txtCampo(3).Text = "" Then
                lblDescripcion(0).Caption = ""
                lblDescripcion(1).Caption = ""
                lblDescripcion(2).Caption = ""
                lblDescripcion(6).Caption = ""
                lblDescripcion(7).Caption = ""
                lblDescripcion(8).Caption = ""
                lblDescripcion(9).Caption = ""
                Exit Sub
            End If
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4046"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, txtCampo(3).Text
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text
            ReDim Valores(7) As String
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rubros", False, "") Then
                 VTR% = FMMapeaArreglo(sqlconn&, Valores())
                 PMChequea sqlconn&
                lblDescripcion(0).Caption = Valores(1)
                lblDescripcion(2).Caption = Valores(2)
                lblDescripcion(9).Caption = Valores(3)
                lblDescripcion(8).Caption = Valores(4)
                VLDato$ = Valores(5)
                'Consulta de tipo rango

                If lblDescripcion(2).Caption <> "" Then
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4038"
                     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                     PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT1, lblDescripcion(2).Caption
                     PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "T"
                    ReDim Valores(10) As String
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "Ok...Consulta de Servicios") Then
                         VTR% = FMMapeaArreglo(sqlconn&, Valores())
                         PMChequea sqlconn&
                        
                        lblDescripcion(1).Caption = Valores(1) 'Descripcion de tipo rango
                        lblDescripcion(6).Caption = Valores(2) ' moneda
                        lblDescripcion(7).Caption = Valores(3) ' descripcion moneda
                        'Consulta si tiene o no decimales
                         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4044"
                         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
                         PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, lblDescripcion(6).Caption
                         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_promon", False, "") Then
                             PMMapeaVariable sqlconn&, VLMoneda$
                             PMChequea sqlconn&
                        End If
                   
                    Else
                        txtCampo(3).Text = ""
                        lblDescripcion(0).Caption = ""
                        lblDescripcion(2).Caption = ""
                        VLDato$ = ""

                    End If
                End If
            Else
                txtCampo(3).Text = ""
                lblDescripcion(0).Caption = ""
                lblDescripcion(1).Caption = ""
                lblDescripcion(2).Caption = ""
                lblDescripcion(6).Caption = ""
                lblDescripcion(7).Caption = ""

            End If
        End If
    End Select
    End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0, 1, 2, 3
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub


